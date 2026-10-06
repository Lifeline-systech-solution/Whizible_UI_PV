<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HRM_Management_Dashboard.aspx.vb" Inherits="Whizible.HRM_Management_Dashboard" %>

<!DOCTYPE html>
<html>



<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Dashboard</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css?v=1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom_dashboardb.css">
     <%-- Added and commented out by Vyankat B to apply the correct custom_dashboard.css --%>
    <%--  <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom_dashboardb.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom_dashboard.css?date=8/13/2025 2:19:07 PM">  
    <%-- End of change by Vyankat B for applying the correct custom_dashboard.css --%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
    
    <style type="text/css">
        /*Commented By Dipali V on 1th April 2026*/
       /* select.form-select {
            -webkit-appearance: menulist;
        }*/
       /*End of Commented By Dipali V on 1th April 2026*/
        .open_text{
            font-size:18px ;
        }
        .CR_text {
             font-size:18px ;
        }
        .inner_all_openstatus {
            font-size: 25px;
            /* Modified By Madhuri.K On 26-03-2026 */
        }
        .inner_all_blue_status {
            font-size: 25px;
            /* Modified By Madhuri.K On 26-03-2026 */
        }
        .inner_all_topPro_status {
            font-size: 25px;
            /* Modified By Madhuri.K On 26-03-2026 */
        }
        .topPro_text {
             font-size:18px ;
        }

        .MainDiv {
    overflow: auto;
    height: 80vh;
}
        .canvas-con {
    display: flex;
    align-items: center;
    justify-content: end;
    position: relative;
}
        .medium_center_text {
    position: relative;
    left: 59px;
    margin-top: 35px;
}

        .carousel-inner:hover {
            overflow-y: auto;
        }
        .small_text{
            font-size:11.5px; /* Modified By Madhuri.K On 26-03-2026 */
        }
        .blu__small_text {
            font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
            color: #2B55CE;
        }
        .legends-div .SCAT_legends {
            display: flex;
            padding: 4px;
        }
            .legends-div .SCAT_legends .l-name {
                margin-left: 4px;
            }
        .legends-div .voi1_box {
            width: 20px;
            height: 17px;
            background-color: #0cb567;
        }
        .legends-div .gray-box {
            width: 20px;
            height: 17px;
            background-color: #4be53dc7;
        }
        .legends-div .light_red_box {
            width: 20px;
            height: 17px;
            background-color: #fbc89ed9;
        }
        .legends-div .orge-box {
            width: 20px;
            height: 17px;
            background-color: #ec7103d9;
        }
        .legends-div .red-box {
            width: 20px;
            height: 17px;
            background-color: #d10c0cd9;
        }
        .SCAT_graphSection {
            position: relative;
            height: 30vh;
            width: 100%;
        }
        .cardkblu_view {
            border-radius: 10px !important;
            border: 1px solid #d2d7db;
        }
        .resourceutilization_pie_chart canvas {
            max-width: 35%;
            height: auto !important;
        }
        .pageTitle {
            color: #273a90;
        }
        .flex_display {
            margin-top: 29px
        }
        .scorer-1-tick {
            position: absolute;
            top: 65px;
            left: 57%;
            width: 178%;
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

        .Score_1InnerDiv5 {
            position: absolute;
            /* left: 2%; */
            top: 100%;
            width: 20%;
            height: 0%;
            border-radius: 50%;
            background-color: #000000;
            z-index: 2;
        }

        @keyframes ticker-mover-1 {
            0% {
                transform-origin: right center;
                transform: rotate(0deg);
            }

            33% {
                transform-origin: right center;
                transform: rotate(10deg);
            }

            66% {
                transform-origin: right center;
                transform: rotate(10deg);
            }

            100% {
                transform-origin: right center;
                transform: rotate(10deg);
            }
        }
        .d-inline {
            padding: 4px;
            border-bottom: 1px solid #ddd;
        }

        .carousel .carousel-indicators button {
            width: 10px;
            height: 10px;
            border-radius: 100%;
            background-color: #ddd;
        }

        .btn_carousel {
            width: 11px !important;
            height: 10px !important;
            border-radius: 100%;
            background-color: #000000 !important;
        }

        .carousel_height {
            height: 350px;
        }

        .carousel-inner {
            position: static;
            width: 100%;
            overflow: hidden;
        }

        .carousel-indicators {
            position: absolute;
            right: 0;
            bottom: -34px;
        }

        .greenn_like_thum {
        color: #0cb567;
        }

       .yelloww_like_thum {
        color: #4be53dc7;
       }

       .red_like_thum {
        color: #D83030;
        }

        .orange_like_thum {
        color: #edc5a5;
        }

        .blue_like_thum {
        color: #EF8629;
        }

        .like_thum {
        color: grey; /* Default color */
        }
         /*Added By Dipali V On 19th FEB 2025 For ICON Color Changes */
        .clearedStage1,.OnlineStage,.clearedStage_orange,.blueStage1 {
        background-color: lightgray!important;
        
        }
         /*End of Added By Dipali V On 19th FEB 2025 For ICON Color Changes */
    </style>
</head>

<body class="hold-transition bgwhite sidebar-mini fixed">

   <%If m_blnViewAccess = True Then%>
 
    <!-- Content Wrapper. Contains page content -->
    <div class="bgwhite resource_allocation">
        <div class="container-fluid pt-1 pb-1 mb-1 test-end graybg">
            <h5 class="pgtitle float-start">HRM [Management] Dashboard</h5>
            <div class="clearfix"></div>
        </div>

            <div class="resource_utilization_panel px-3">
                <div class="row mb-1 ps-2">
                    <div class="col-sm-6 ps-1 py-2">
                        <div class="pageTitle font-weight-500 pt-2"><span class="helpstatus">Helpdesk Today</span><span class="help_date_time"> [ 28-May-24 06:13 PM] </span><span class="help_department"> [HRM]</span></div>
                    </div>
                    <div class="col-sm-6 text-end py-1 col-10 col-lg-6 ">
                        <div class="row">
                            <div class="col-4 col-sm-6 text-end">
                                <label for="CntryCodeEdtInput" class=" mt-2"><%=MyBase.GetResourceString("C_Departments_Of_HRM")%></label>
                            </div>
                            <div class="col-8 col-sm-6 text-start">
                                <select class="form-select" id="ddl_departmentSelectID" onchange="fillDashboardOnDepartment(this.options[this.selectedIndex].value)">
                                    <option>Select Department</option>
                                    <option>Support</option>
                                    <option>Testing</option>
                                    <option>Sales</option>
                                    <option>Design</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="">
                    <div class="CardsAcc_flex">
                        <div class="row">
                            <div class="col-12 col-sm-6 col-lg-2 pe-0 ps-0">
                                <div class="col-12 col-sm-12 col-lg-12 pe-0 ps-0">
                                    <div class="card cardkblu_view ontime_data mb-3">
                                        <div class="card-body pt-0">
                                            <div class="justify-content-between">
                                                <div class="row d-flex">
                                                    <div class="col-sm-12 py-2 ">
                                                        <div class="text-center top_pink_text"><%=MyBase.GetResourceString("C_LT_Open")%></div>  
                                                    </div>
                                                    <div class="col-sm-12 text-center">
                                                        <div class="IniCode">
                                                            <span class="inner_all_top_pink_status" id="spn_LTOpenID"></span>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <!--<div class="card-img text-end">
                    <a href="javascript:;"><i class="fas fa-exclamation Card_View_whiz clearedStage1"></i></a>
                </div>-->
                                        <div class="card-img text-end">
                                            <span data-bs-toggle="tooltip" title="More Details">
                                                <a href="javascript:;" data-bs-toggle="offcanvas"
                                                   data-bs-target="#moredetails_OffcvsScreenLo"><i class="fas fa-exclamation Card_View_whiz clearedStage1" onclick="resetLoTicketsDetails()"></i></a>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-12 col-sm-12 col-lg-12 mt-3 pt-2 pe-0 ps-0">
                                    <div class="card cardkblu_view  ontime_data ">
                                        <div class="card-header">
                                            <div class=""><%= MyBase.GetResourceString("C_OTickets") %></div>
                                        </div>
                                       <%-- percentage from here--%>

                                       <%-- <div class="card-body pt-0">
                                            <div class="justify-content-between">
                                                <div class="row d-flex">
                                                    <div class="col-12 col-sm-12 text-start">
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-6 col-sm-7 col-lg-7 text-start pe-0 ps-0">
                                                                <div class="canvas-con">
                                                                    <p class="medium_center_text" id="p_openTicketsHighID"></p>
                                                                    <div class="canvas-con-inner" id="div_openHighTicketPercentage">
                                                                        <canvas id="HighOpenTickets" style="width:85px; height:96px; padding:0px"></canvas>
                                                                    </div>
                                                                    <div id="my-legend-con" class="legend-con"></div>
                                                                </div>
                                                            </div>
                                                            <div class="col-6 col-sm-5 col-lg-5 text-start flex_display pe-0 ps-2">
                                                                <span class="span_text"><%= MyBase.GetResourceString("C_High") %></span>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="col-12 col-sm-12 text-start">
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-6 col-sm-7 col-lg-7 text-start pe-0 ps-0">
                                                                <div class="canvas-con">
                                                                    <p class="medium_center_text" id="p_openTicketsMediumID"></p>
                                                                    <div class="canvas-con-inner" id="div_openMediumTicketPercentage">
                                                                        <canvas id="MediumOpenTickets" style="width:85px; height:96px;"></canvas>
                                                                    </div>
                                                                    <div id="my-legend-con" class="legend-con"></div>
                                                                </div>
                                                            </div>
                                                            <div class="col-6 col-sm-5 col-lg-5 text-start flex_display pe-0 ps-1">
                                                                <span class="span_pinktext"><%= MyBase.GetResourceString("C_Med") %></span>
                                                            </div>

                                                        </div>
                                                    </div>
                                                    <div class="col-12 col-sm-12 text-start">
                                                        <div class="row mt-2 mb-2">
                                                            <div class="col-6 col-sm-7 col-lg-7 text-start pe-0 ps-0">
                                                                <div class="canvas-con">
                                                                    <p class="medium_center_text" id="p_openTicketsLowID"></p>
                                                                    <div class="canvas-con-inner" id="div_openLowTicketPercentage">
                                                                        <canvas id="LowOpenTickets" style="width:85px; height:96px;"></canvas>
                                                                    </div>
                                                                    <div id="my-legend-con" class="legend-con"></div>
                                                                </div>
                                                            </div>
                                                            <div class="col-6 col-sm-5 col-lg-5 text-start flex_display pe-0 ps-1">
                                                                <span class="span_bluetext"><%= MyBase.GetResourceString("C_Low") %></span>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>--%>

                                        <div class="card-body pt-0" style="min-height: 350px;">
                                            <div class="justify-content-between">
                                                 <div class="row d-flex">
                                                     <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">

                                                        <div class="carousel-inner" id="carousel-inner">
                                                            <!-- Dynamic carousel items will be appended here -->
                                                        </div>

                                                        <div class="carousel-indicators" id="carousel-indicators">
                                                            <!-- Dynamic pagination buttons will be appended here -->
                                                        </div>

                                                      </div>
                                                 </div>
                                            </div>
                                        </div>

                                      <%-- percentage to here--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 col-sm-6 col-lg-4 d-flex pe-0 ps-0">
                                <div class="CardsAcc_flex">
                                    <div class="row">
                                        <div class="col-12 col-sm-12">
                                            <div class="CardsAcc_flex">
                                                <div class="row">
                                                    <div class="col-12 col-sm-12 d-flex">
                                                        <div class="card cardkblu_view  ontime_data CardsAcc_flex">
                                                            <div class="card-body pt-0">
                                                                <div class="justify-content-between">
                                                                    <div class="row">
                                                                        <div class="col-sm-12 text-center">
                                                                            <div class="IniCode">
                                                                                <span class="inner_allstatus" id="spn_unassignedTicketsID"></span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-sm-12 py-1">
                                                                            <div class="text-center"><%= MyBase.GetResourceString("C_UAT") %></div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="card-img text-end">
                                                                <span data-bs-toggle="tooltip" title="More Details">
                                                                    <a href="javascript:;" data-bs-toggle="offcanvas"
                                                                       data-bs-target="#moredetails_OffcvsScreen"><i class="fas fa-exclamation Card_View_whiz clearedStage1"  onclick="resetUnassignedTicketsDetails()"></i></a>
                                                                </span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-12 col-sm-12 mt-3 mb-1 d-flex">
                                                        <div class="CardsAcc_flex">
                                                            <div class="row">
                                                                <div class="col-sm-5 d-flex">
                                                                    <div class="card cardkblu_view ontime_data card_border CardsAcc_flex">
                                                                        <div class="card-header card_header_border">
                                                                            <div class=""><%= MyBase.GetResourceString("C_CQueue") %></div>
                                                                        </div>
                                                                        <div class="">
                                                                            <div class="card cardkblu_view ontime_data mt-3">
                                                                                <div class="card-body pt-0">
                                                                                    <div class="justify-content-between">
                                                                                        <div class="row d-flex">
                                                                                            <div class="col-sm-12 text-center">
                                                                                                <div class="IniCode py-1">
                                                                                                    <span class="inner_all_openstatus" id="spn_open_CQID"></span>
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="col-sm-12 py-0">
                                                                                                <div class="text-center open_text"><%= MyBase.GetResourceString("C_Opn") %></div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="card-img text-end">
                                                                                    <span data-bs-toggle="tooltip" title="More Details">
                                                                                        <a href="javascript:;" data-bs-toggle="offcanvas"
                                                                                           data-bs-target="#moredetails_OffcvsScreenOpen"><i class="fas fa-exclamation Card_View_whiz clearedStage1" onclick="resetOpenTicketsDetails()"></i></a>
                                                                                    </span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="card cardkblu_view ontime_data mt-3">
                                                                                <div class="card-body pt-0">
                                                                                    <div class="justify-content-between">
                                                                                        <div class="row d-flex">
                                                                                            <div class="col-sm-12 text-center">
                                                                                                <div class="IniCode py-1">
                                                                                                    <span class="inner_all_blue_status" id="spn_CR_CQID"></span>
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="col-sm-12 py-0">
                                                                                                <div class="text-center CR_text"><%= MyBase.GetResourceString("C_CR") %></div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="card-img text-end">
                                                                                    <span data-bs-toggle="tooltip" title="More Details">
                                                                                        <a href="javascript:;" data-bs-toggle="offcanvas"
                                                                                           data-bs-target="#moredetails_OffcvsScreenCR"><i class="fas fa-exclamation Card_View_whiz blueStage1" onclick="resetCRTicketsDetails()"></i></a>
                                                                                    </span>
                                                                                </div>
                                                                            </div>
                                                                            <div class="card cardkblu_view ontime_data mt-3">
                                                                                <div class="card-body pt-0">
                                                                                    <div class="justify-content-between">
                                                                                        <div class="row d-flex">
                                                                                            <div class="col-sm-12 text-center">
                                                                                                <div class="IniCode py-1">
                                                                                                    <span class="inner_all_topPro_status" id="spn_TopPriority_CQID"></span>
                                                                                                </div>
                                                                                            </div>
                                                                                            <div class="col-sm-12 py-0">
                                                                                                <div class="text-center topPro_text"><%= MyBase.GetResourceString("C_TP") %> </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="card-img text-end">
                                                                                    <span data-bs-toggle="tooltip" title="More Details">
                                                                                        <a href="javascript:;" data-bs-toggle="offcanvas"
                                                                                           data-bs-target="#moredetails_OffcvsScreenTop"><i class="fas fa-exclamation Card_View_whiz clearedStage_orange" onclick="resetTopTicketsDetails()"></i></a>
                                                                                    </span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-sm-7">
                                                                    <div class="card cardkblu_view  ontime_data card_border">
                                                                        <div class="card-header card_header_border">
                                                                            <div class=""><%= MyBase.GetResourceString("C_TA") %></div>
                                                                        </div>
                                                                        <div class="row mt-2">
                                                                            <div class="col-sm-6 pe-0 ps-0">
                                                                                <div class="card cardkblu_view ontime_data mt-1 mb-1 mx-1">
                                                                                    <div class="card-body pt-0">
                                                                                        <div class="justify-content-between">
                                                                                            <div class="row d-flex">
                                                                                                <div class="col-sm-12 text-center">
                                                                                                    <div class="IniCode">
                                                                                                        <span class="inner_onlinestatus" id="spn_onlineEmployeeID"></span>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="col-sm-12 py-0">
                                                                                                    <div class="text-center online_text">Online</div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>

                                                                                    <div class="card-img text-end">
                                                                                        <span data-bs-toggle="tooltip" title="More Details">
                                                                                            <a href="javascript:;" data-bs-toggle="offcanvas"
                                                                                               data-bs-target="#Leave_OffcvsScreen"><i class="fas fa-exclamation Card_View_whiz OnlineStage" onclick="EmployeeOnLineDetailsInitially()" ></i></a>
                                                                                        </span>
                                                                                    </div>
                                                                                </div>

                                                                            </div>
                                                                            <div class="col-sm-6 pe-0 ps-0">
                                                                                <div class="card cardkblu_view ontime_data mt-1 mb-1 mx-1">
                                                                                    <div class="card-body pt-0">
                                                                                        <div class="justify-content-between">
                                                                                            <div class="row d-flex">
                                                                                                <div class="col-sm-12 text-center">
                                                                                                    <div class="IniCode">
                                                                                                        <span class="inner_leave_status" id="spn_onLeaveEmployeeID"></span>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="col-sm-12 py-0">
                                                                                                    <div class="text-center leave_text">Leave</div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div class="card-img text-end">
                                                                                        <span data-bs-toggle="tooltip" title="More Details">
                                                                                            <a href="javascript:;" data-bs-toggle="offcanvas"
                                                                                               data-bs-target="#Leave_OffcvsScreen2"><i class="fas fa-exclamation Card_View_whiz clearedStage_orange" onclick="EmployeeOnLeaveeDetailsInitially()"></i></a>
                                                                                        </span>
                                                                                    </div>
                                                                                </div>

                                                                            </div>
                                                                        </div>


                                                                    </div>
                                                                    <div class="card cardkblu_view  ontime_data mt-2">
                                                                        <div class="card-header">
                                                                            <div class=""><%= MyBase.GetResourceString("C_CustomerTO") %></div>
                                                                        </div>
                                                                        <div class="card-body  mt-0" id="ticketContainer">
                                                                           
                                                                        </div>
                                                                        <div class="card-img text-end">
                                                                            <span data-bs-toggle="tooltip" title="More Details">
                                                                                <a href="javascript:;" data-bs-toggle="offcanvas"
                                                                                   data-bs-target="#moredetails_OffcvsScreenCustomerOpen"><i class="fas fa-exclamation Card_View_whiz clearedStage_orange" onclick="resetCustomerOpenTicketsDetails()"></i></a>
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
                            <div class="col-12 col-sm-12 col-lg-6 d-flex pe-0 ps-0">
                                <div class="CardsAcc_flex">
                                    <div class="row">
                                        <div class="col-12 col-sm-8">
                                            <div class="row CardsAcc_flex">
                                                <div class="col-sm-12 d-flex">
                                                    <div class="card CardsAcc_flex cardkblu_view  ontime_data">
                                                        <div class="card-header ">
                                                            <div class="card_top_heading"><%= MyBase.GetResourceString("C_TicketsThisWeek") %></div>
                                                        </div>
                                                        <div class="card-body d-flex align-items-center">
                                                            <div class="CardsAcc_flex" id="">
                                                                <div class="legends-div justify-content-center" id="legends-div">
                                                                    <div class="row g-0">
                                                                        <div class="col-sm-4 col-4 pe-0 ps-0">
                                                                            <div class="legends legend2">
                                                                                <div class="voi-box"></div>
                                                                                <div class="l-name">Create</div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-sm-4 col-6 pe-0 ps-0">
                                                                            <div class="legends legend3">
                                                                                <div class="legend-box "></div>
                                                                                <div class="l-name">Closed</div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-sm-4 col-6 pe-0 ps-0 ">
                                                                            <div class="legends legend5">
                                                                                <div class=" orange-box"></div>
                                                                                <div class="l-name">SLA will Breaches</div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="project_graphSection d-flex align-items-center" id="div_canvasWrapper2ID">
                                                                    <canvas id="Cost_LineChart" class=""></canvas>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 col-sm-4 ps-0">
                                            <div class="row CardsAcc_flex">
                                                <div class="col-12 col-sm-12 d-flex">
                                                    <div class="card cardkblu_view  ontime_data ">
                                                        <div class="card-header">
                                                            <div class="d-flex justify-content-between">
                                                                <div class=""><%= MyBase.GetResourceString("C_CSATScore") %></div>
                                                                <div class="" ><strong id="str_csatPercentageID"></strong></div>
                                                            </div>
                                                        </div>
                                                        <div class="card-body pt-0 d-flex align-items-center">
                                                            <div class="CardsAcc_flex">
                                                                <div class="row d-flex">
                                                                    <div class="col-sm-12 text-center">
                                                                        <div class="IniCode" id="div_canvasWrapper7ID">
                                                                            <canvas id="SCAT_month_Graph" style="width:112px; height:100px;"></canvas>
                                                                        </div>
                                                                    </div>
                                                                    <div class="blu__small_text text-center" id="div_custSurveyedID"> Customer Surveyed:  </div>
                                                                    <div class="legends-div d-flex justify-content-center" id="">
                                                                        <div class="row g-0">
                                                                            <div class="col-sm-12 col-12">
                                                                                <div class="SCAT_legends legend2">
                                                                                    <div class="voi1_box"></div>
                                                                                    <div class="l-name small_text">
                                                                                        <strong id="str_verySatisfiedPercentageID"> </strong> <span class="" id="spn_vsID">Very Satisfied1</span>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-sm-12 col-12">
                                                                                <div class="SCAT_legends legend3">
                                                                                    <div class="gray-box"></div>
                                                                                    <div class="l-name small_text">
                                                                                        <strong id="str_satisfiedPercentageID"> </strong> <span class="" id="spn_sId">Satisfied1</span>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-sm-12 col-12">
                                                                                <div class="SCAT_legends legend5">
                                                                                    <div class="light_red_box"></div>
                                                                                    <div class="l-name small_text">
                                                                                        <strong id="str_neutralPercentageID"> </strong> <span class="" id="spn_nID">Neutral1</span>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-sm-12 col-12">
                                                                                <div class="SCAT_legends legend5">
                                                                                    <div class="orge-box"></div>
                                                                                    <div class="l-name small_text">
                                                                                        <strong id="str_dissatisfiedPercentageID"> </strong> <span class="" id="spn_dID">Dissatisfied1</span>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-sm-12 col-12">
                                                                                <div class="SCAT_legends legend5">
                                                                                    <div class="red-box"></div>
                                                                                    <div class="l-name small_text">
                                                                                        <strong id="str_veryDissatisfiedPercentageID"> </strong> <span class="" id="spn_vdID">Very dissatisfied1</span>
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
                                                <div class="col-12 col-sm-12 mt-2 d-flex">
                                                    <div class="card cardkblu_view  ontime_data CardsAcc_flex">
                                                        <div class="card-header">
                                                            <div class=""><%= MyBase.GetResourceString("C_TopPerformer") %></div>
                                                        </div>
                                                        <div class="card-body mt-0" id="div_topPerformerID">

                                                           
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

                    <div class="CardsAcc_flex">
                        <div class="row">
                            <div class="col-12 col-sm-12 col-lg-6 d-flex">
                                <div class="card cardkblu_view ontime_data mt-2 CardsAcc_flex">
                                    <div class="card-header ">
                                        <div class="card_top_heading"><%= MyBase.GetResourceString("C_SLABreaches") %></div>
                                    </div>
                                    <div class="card-body d-flex align-items-center">
                                        <div class="CardsAcc_flex" id="">
                                            <div class="legends-div " id="legends-div">
                                                <div class="row g-0">
                                                    <div class="col-sm-4 col-4">
                                                        <div class="legends legend2">
                                                            <div class="inter-box"></div>
                                                            <div class="l-name">Response SLA</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4 col-6">
                                                        <div class="legends legend3">
                                                            <div class="exter-box"></div>
                                                            <div class="l-name">Resolution SLA</div>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4 col-6">
                                                        <div class="legends legend3">
                                                            <div class="Closer-box"></div>
                                                            <div class="l-name">Closure</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="Tickets_graphSection" id="div_canvasWrapper3ID">
                                                <canvas id="SGraph"></canvas>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <div class="col-12 col-sm-12 col-lg-6 d-flex ">
                                <div class="card cardkblu_view  ontime_data mt-2 CardsAcc_flex">
                                    <div class="card-header">
                                        <div class=""><%= MyBase.GetResourceString("C_TRA") %></div>
                                    </div>
                                    <div class="card-body pt-2">
                                        <div id="carousel_Recently_breached" class="carousel slide" data-bs-ride="false">
                                            <div class="carousel-inner">
                                                <div class="carousel-item carousel_height active">
                                                    <div class=" table-responsive mt-0" id="div_tRASectionID">
                                                        <table id="" class=" table bgwhite table-bordered table-border-none table-fixed-header projectdetailtbl mb-1" style="width:100%">
                                                            <thead class="stickyTblHeader">
                                                                <tr>
                                                                    <th id="ticket_id" class="col-sm-1">ID</th>
                                                                    <th id="ticket_sub" class="col-sm-5">Subject</th>
                                                                    <th id="ticket_sub" class="col-sm-3"><div class="d-flex justify-content-start"><i class="fas fa-user user_outlook"></i> Assignee</div></th>
                                                                    <th id="ticket_sub" class="col-sm-3">Created at </th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr id="ticket_1">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">
                                                                            <!--<i class="fas fa-user "></i>-->
                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_red">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr id="ticket_2">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">

                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_red">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr id="ticket_3">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">

                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_red">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr id="ticket_4">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">

                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_red">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr id="ticket_5">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">

                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_orange">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                </tr>

                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>

                                                <div class="carousel-item carousel_height" id="div_secondSet">
                                                    <div class=" table-responsive mt-0">
                                                        <table id="" class=" table bgwhite table-bordered table-border-none table-fixed-header projectdetailtbl mb-1" style="width:100%">
                                                            <thead class="stickyTblHeader">
                                                                <tr>
                                                                    <th id="ticket_id" class="col-sm-1">ID</th>
                                                                    <th id="ticket_sub" class="col-sm-5">Subject</th>
                                                                    <th id="ticket_sub" class="col-sm-3"><div class="d-flex justify-content-start"><i class="fas fa-user user_outlook"></i> Assignee</div></th>
                                                                    <th id="ticket_sub" class="col-sm-3">Created at </th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr id="ticket_6">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">
                                                                            <!--<i class="fas fa-user "></i>-->
                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_green">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr id="ticket_7">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">

                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_green">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr id="ticket_8">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">

                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_red">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr id="ticket_9">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">

                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_orange">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr id="ticket_10">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">

                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_orange">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                </tr>

                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>


                                                <div class="carousel-item carousel_height" id="div_thirdSet">
                                                    <div class=" table-responsive mt-0">
                                                        <table id="" class=" table bgwhite table-bordered table-border-none table-fixed-header projectdetailtbl mb-1" style="width:100%">
                                                            <thead class="stickyTblHeader">
                                                                <tr>
                                                                    <th id="ticket_id" class="col-sm-1">ID</th>
                                                                    <th id="ticket_sub" class="col-sm-5">Subject</th>
                                                                    <th id="ticket_sub" class="col-sm-3"><div class="d-flex justify-content-start"><i class="fas fa-user user_outlook"></i> Assignee</div></th>
                                                                    <th id="ticket_sub" class="col-sm-3">Created at </th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <tr id="ticket_11">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">
                                                                            <!--<i class="fas fa-user "></i>-->
                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_green">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr id="ticket_12">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">

                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_green">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr id="ticket_13">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">

                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_red">
                                                                           
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr id="ticket_14">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">

                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_orange">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr id="ticket_15">
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <div class="d-flex justify-content-start">

                                                                            <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt="">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <div class="text_orange">
                                                                            
                                                                        </div>
                                                                    </td>
                                                                </tr>

                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>

                                             
                                                <div class="carousel-indicators mb-4">
                                                    <button type="button" data-bs-target="#carousel_Recently_breached" data-bs-slide-to="0" class="active btn_carousel" aria-current="true" aria-label="Slide 1"></button>
                                                   <button type="button" data-bs-target="#carousel_Recently_breached" data-bs-slide-to="1" class="btn_carousel" aria-label="Slide 2"></button>
                                                    <button type="button" data-bs-target="#carousel_Recently_breached" data-bs-slide-to="2" class="btn_carousel" aria-label="Slide 3"></button>
                                                </div> 
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="CardsAcc_flex mb-3">
                    <div class="row">
                        <div class="col-12 col-sm-12 col-lg-6 d-flex">
                            <div class="card cardkblu_view ontime_data mt-2 CardsAcc_flex">
                                <div class="card-header ">
                                    <div class="card_top_heading"><%= MyBase.GetResourceString("C_TVT") %></div>
                                </div>
                                <div class="card-body d-flex align-items-center">
                                    <div class="CardsAcc_flex" id="">
                                        <div class="Tickets_graphSection" id="div_canvasWrapperID">
                                           <canvas id="Tickets_VolumeChart">
                                            </canvas> 
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="col-12 col-sm-12 col-lg-6 d-flex">
                            <div class="card cardkblu_view ontime_data mt-2 CardsAcc_flex">
                                <div class="card-header ">
                                    <div class="card_top_heading"><%= MyBase.GetResourceString("C_CustFeedback") %></div>
                                </div>
                                <div class="card-body">
                                    <div class="card-body">
                                        <div id="carousel_Customer" class="carousel slide" data-bs-ride="false">

                                            <div class="carousel-inner">
                                                <div class="carousel-item carousel_height active">
                                                    <div class="mt-4">
                                                        
                                                        <div class="mt-4">
                                                        <div class="d-flex justify-content-between d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                   <%-- <i class="fas fa-thumbs-up like_thum me-2"></i>--%>
                                                                    <span class="small_Txt" id="feedbackComment1"></span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time1"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">
                                                                <div class="Custromer_name">
                                                                    <span class="span_text" id="customerName1"></span>
                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1" id="stars1">
                                                                       
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="d-flex justify-content-between d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                  <%--  <i class="fas fa-thumbs-up yellow_like_thum me-2"></i>--%>
                                                                    <span class="small_Txt" id="feedbackComment2"> </span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time2"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">

                                                                <div class="Custromer_name">
                                                                    <span class="span_text" id="customerName2"></span>
                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1" id="stars2">
                                                                       
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="d-flex justify-content-between d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                   <%-- <i class="fas fa-thumbs-up green_like_thum me-2"></i>--%>
                                                                    <span class="small_Txt" id="feedbackComment3"> </span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time3"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">

                                                                <div class="Custromer_name">
                                                                    <span class="span_text" id="customerName3"></span>
                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1" id="stars3">
                                                                        
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="d-flex justify-content-between d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                  <%--  <i class="fas fa-thumbs-up like_thum me-2"></i>--%>
                                                                    <span class="small_Txt" id="feedbackComment4"> </span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time4"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">

                                                                <div class="Custromer_name" id="customerName4">
                                                                    <span class="span_text"></span>

                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1" id="stars4">
                                                                     
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="d-flex justify-content-between  d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                 <%--   <i class="fas fa-thumbs-up like_thum me-2"></i>--%>
                                                                    <span class="small_Txt" id="feedbackComment5"> </span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time5"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">

                                                                <div class="Custromer_name">
                                                                    <span class="span_text" id="customerName5"></span>
                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1" id="stars5">
                                                                       
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>


                                                    </div>


                                                    </div>
                                                </div>


                                                <div class="carousel-item carousel_height">
                                                    <div class="mt-4">
                                                        <div class="d-flex justify-content-between d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                  <%--  <i class="fas fa-thumbs-up like_thum me-2"></i>--%>
                                                                    <span class="small_Txt" id="feedbackComment6"></span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time6"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">
                                                                <div class="Custromer_name">
                                                                    <span class="span_text" id="customerName6"></span>
                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1"  id="stars6">
                                                                       
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="d-flex justify-content-between d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                 <%--   <i class="fas fa-thumbs-up yellow_like_thum me-2"></i>--%>
                                                                    <span class="small_Txt" id="feedbackComment7"></span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time7"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">

                                                                <div class="Custromer_name">
                                                                    <span class="span_text" id="customerName7"></span>
                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1"  id="stars7">
                                                                       
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="d-flex justify-content-between d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                   <%-- <i class="fas fa-thumbs-up green_like_thum me-2"></i>--%>
                                                                    <span class="small_Txt" id="feedbackComment8"></span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time8"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">

                                                                <div class="Custromer_name">
                                                                    <span class="span_text" id="customerName8"></span>
                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1"  id="stars8">
                                                                      
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="d-flex justify-content-between d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                   <%-- <i class="fas fa-thumbs-up like_thum me-2"></i>--%>
                                                                    <span class="small_Txt" id="feedbackComment9"></span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time9"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">

                                                                <div class="Custromer_name">
                                                                    <span class="span_text" id="customerName9"></span>

                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1"  id="stars9">
                                                                        
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="d-flex justify-content-between  d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                   <%-- <i class="fas fa-thumbs-up like_thum me-2"></i>--%>
                                                                    <span class="small_Txt" id="feedbackComment10"></span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time10"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">

                                                                <div class="Custromer_name">
                                                                    <span class="span_text" id="customerName10"></span>
                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1"  id="stars10">
                                                                      
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>


                                                    </div>
                                                </div>

                                                   <! --  jump --> 

                                                 <div class="carousel-item carousel_height">
                                                    <div class="mt-4">
                                                        <div class="d-flex justify-content-between d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                 <%--   <i class="fas fa-thumbs-up like_thum me-2"></i>--%>
                                                                    <span class="small_Txt" id="feedbackComment11"></span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time11"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">
                                                                <div class="Custromer_name">
                                                                    <span class="span_text" id="customerName11"></span>
                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1" id="stars11">
                                                                        
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="d-flex justify-content-between d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                  <%--  <i class="fas fa-thumbs-up yellow_like_thum me-2"></i>--%>
                                                                    <span class="small_Txt"  id="feedbackComment12"> </span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time12"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">

                                                                <div class="Custromer_name">
                                                                    <span class="span_text" id="customerName12"></span>
                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1" id="stars12">
                                                                      
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="d-flex justify-content-between d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                   <%-- <i class="fas fa-thumbs-up green_like_thum me-2"></i>--%>
                                                                    <span class="small_Txt" id="feedbackComment13"> </span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time13"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">

                                                                <div class="Custromer_name">
                                                                    <span class="span_text" id="customerName13"></span>
                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1" id="stars13">
                                                                      
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="d-flex justify-content-between d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                  <%--  <i class="fas fa-thumbs-up like_thum me-2"></i>--%>
                                                                    <span class="small_Txt" id="feedbackComment14"> </span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time14"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">

                                                                <div class="Custromer_name">
                                                                    <span class="span_text" id="customerName14"></span>

                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1" id="stars14">
                                                                        
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="d-flex justify-content-between  d-inline">
                                                            <div class="text-start">
                                                                <div class="">
                                                                 <%--   <i class="fas fa-thumbs-up like_thum me-2"></i>--%>
                                                                    <span class="small_Txt" id="feedbackComment15"> </span>
                                                                </div>
                                                                <div class="ml-4">
                                                                    <span class="small_blu_text" id="time15"></span>
                                                                </div>

                                                            </div>
                                                            <div class="text-end">

                                                                <div class="Custromer_name">
                                                                    <span class="span_text" id="customerName15"></span>
                                                                </div>
                                                                <div class="ml-4 d-flex">
                                                                    <div class="gap-1" id="stars15">
                                                                        
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>


                                                    </div>
                                                </div>




                                                <div class="carousel-indicators mt-4">
                                                    <button type="button" id="carousel_slide1" data-bs-target="#carousel_Customer" data-bs-slide-to="0" class="active btn_carousel" aria-current="true" aria-label="Slide 1"></button>
                                                    <button type="button" id="carousel_slide2" data-bs-target="#carousel_Customer" data-bs-slide-to="1" class="btn_carousel" aria-label="Slide 2"></button>
                                                    <button type="button" id="carousel_slide3" data-bs-target="#carousel_Customer" data-bs-slide-to="2" class="btn_carousel" aria-label="Slide 3"></button>
                                                </div>
                                            </div>

                                            <!--<button class="carousel-control-prev" type="button" data-bs-target="#carousel_Customer" data-bs-slide="prev">
                                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                            <span class="visually-hidden">Previous</span>
                                        </button>
                                        <button class="carousel-control-next" type="button" data-bs-target="#carousel_Customer" data-bs-slide="next">
                                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                            <span class="visually-hidden">Next</span>
                                        </button>-->
                                        </div>


                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>

                </div>
            </div>

    </div>


        <!-- More Details for Tickets  Offcanvas Section starts UnAssigned Tickets -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1"
             id="moredetails_OffcvsScreen" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-body" id="div_offcanvasidxID">
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
                <div id="Ticketes_Tab" class="CountryInfo">
                    <div class="row mb-2">
                        <div class="col-sm-6 col-lg-4">
                            <div class="row form-group mb-2 mx-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Department</label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                <%CommonFunctions.HTMLControls.DrawComboBox("ddl_DeptFilter_Unassigned_ID", "usp_Whizible2_sel_DepartmentOfHRMPersonWithSelectDepartmentOnId " & Session("intUserID"),,, "onchange='GetUnassignedTicketsDetails();' class='form-select'",,,) %>
                                </div>
                              </div>
                            </div>
                        <div class="col-sm-6 col-lg-4">
                            <div class="row form-group mb-2">
                                <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                                    <label>Customer </label>
                                </div>
                                <div class="col-sm-7 col-lg-7 col-8">
                                   <select class="form-select" id="ddl_CustFilter_Unassigned_ID" onchange="GetUnassignedTicketsDetails(this.options[this.selectedIndex].value)" >
                                    <option>Select Customer</option>
                                    <option>Support</option>
                                    <option>Testing</option>
                                    <option>Sales</option>
                                    <option>Design</option>
                                </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="MainDiv">
                        <table id="tbl_TicketsDetails_Unassigned" class="table bgwhite table-bordered  table-fixed-header projectdetailtbl mb-1" style="width:100%">
                            <thead class="stickyTblHeader">
                                <tr>
                                    <th class="col-sm-1">ID</th>
                                    <th class="col-sm-2">Subject</th>
                                    <th class="col-sm-1">Request Type</th>
                                    <th class="col-sm-1">Priority</th>
                                    <th class="col-sm-1">Requestor</th>
                                    <th class="col-sm-1">Requestor Name</th>
                                    <th class="col-sm-1">Requested On</th>
                                    <th class="col-sm-1">Last Updated</th>
                                    <th class="col-sm-1">Exp. Date of Resol..</th>
                                    <th class="col-sm-1">Status</th>
                                    <th class="col-sm-1">Assigned To</th>    
                                </tr>
                            </thead>
                            <tbody id ="offcanvasDynamicAppendData_Unassigned">
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
                </div></div>
        <!-- More Details for Tickets  Offcanvas Section ends -->


        <!-- More Details for Tickets  Offcanvas Section starts Open Tickets -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="moredetails_OffcvsScreenOpen" aria-labelledby="offcanvasWithBothOptionsLabel2">
        <div class="offcanvas-body" id="div_offcanvasidxIDOpen">
        <div class="container-fluid py-2 graybg mb-2 ">
            <div class="row align-items-center">
                <div class="col-10 col-sm-10 ">
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
        <div id="Ticketes_Tab2" class="CountryInfo">
            <div class="row mb-2">
                <div class="col-sm-6 col-lg-4">
                    <div class="row form-group mb-2 mx-2">
                        <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                            <label>Department</label>
                        </div>
                        <div class="col-sm-7 col-lg-7 col-8">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_DeptFilter_Open_ID", "usp_Whizible2_sel_DepartmentOfHRMPersonWithSelectDepartmentOnId " & Session("intUserID"),,, "onchange='GetOpenTicketsDetails();' class='form-select'",,,) %>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-4">
                    <div class="row form-group mb-2">
                        <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                            <label>Customer</label>
                        </div>
                        <div class="col-sm-7 col-lg-7 col-8">
                            <select class="form-select" id="ddl_CustFilter_Open_ID" onchange="GetOpenTicketsDetails(this.options[this.selectedIndex].value)">
                                <option>Select Customer</option>
                                <option>Support</option>
                                <option>Testing</option>
                                <option>Sales</option>
                                <option>Design</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="MainDiv">
                <table id="tbl_TicketsDetails_Open" class="table bgwhite table-bordered table-fixed-header projectdetailtbl mb-1" style="width:100%">
                    <thead class="stickyTblHeader">
                        <tr>
                            <th class="col-sm-1">ID</th>
                            <th class="col-sm-2">Subject</th>
                            <th class="col-sm-1">Request Type</th>
                            <th class="col-sm-1">Priority</th>
                            <th class="col-sm-1">Requestor</th>
                            <th class="col-sm-1">Requestor Name</th>
                            <th class="col-sm-1">Requested On</th>
                            <th class="col-sm-1">Last Updated</th>
                            <th class="col-sm-1">Exp. Date of Resol..</th>
                            <th class="col-sm-1">Status</th>
                            <th class="col-sm-1">Assigned To</th>
                        </tr>
                    </thead>
                    <tbody id="offcanvasDynamicAppendData_Open"></tbody>
                </table>
            </div>
        </div>
        </div>
        </div>
        <!-- More Details for Open Tickets Offcanvas Section ends -->
        

         <!-- More Details for Tickets  Offcanvas Section starts Customer Open Tickets -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="moredetails_OffcvsScreenCustomerOpen" aria-labelledby="offcanvasWithBothOptionsLabel2">
        <div class="offcanvas-body" id="div_offcanvasidxIDOpen">
        <div class="container-fluid py-2 graybg mb-2 ">
            <div class="row align-items-center">
                <div class="col-10 col-sm-10 ">
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
            <div id="Ticketes_Tab2" class="CountryInfo">
                <div class="row mb-2">
                     <div class="col-sm-6 col-lg-4">
                   <div class="row form-group mb-2 mx-2">
                 <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                     <label>Department</label>
                 </div>
                 <div class="col-sm-7 col-lg-7 col-8">
                     <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_DeptFilter_CustomerOpen_ID", "usp_Whizible2_sel_DepartmentOfHRMPersonWithSelectDepartmentOnId " & Session("intUserID"),,, "onchange='GetCustomerOpenTicketsDetails();' class='form-select'",,,) %>
                 </div>
                  </div>
                 </div>
                 <div class="col-sm-6 col-lg-4">
                   <div class="row form-group mb-2">
                 <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                     <label>Customer</label>
                 </div>
                 <div class="col-sm-7 col-lg-7 col-8">
                     <select class="form-select" id="ddl_CustFilter_CustomerOpen_ID" onchange="GetCustomerOpenTicketsDetails(this.options[this.selectedIndex].value)">
                         <option>Select Customer</option>
                         <option>Support</option>
                         <option>Testing</option>
                         <option>Sales</option>
                         <option>Design</option>
                     </select>
                 </div>
                     </div>
                 </div>
             </div>
                <div class="MainDiv">
                <table id="tbl_TicketsDetails_CustomerOpen" class="table bgwhite table-bordered table-fixed-header projectdetailtbl mb-1" style="width:100%">
                    <thead class="stickyTblHeader">
                         <tr>
                     <th class="col-sm-1">ID</th>
                     <th class="col-sm-2">Subject</th>
                     <th class="col-sm-1">Request Type</th>
                     <th class="col-sm-1">Priority</th>
                     <th class="col-sm-1">Requestor</th>
                     <th class="col-sm-1">Requestor Name</th>
                     <th class="col-sm-1">Requested On</th>
                     <th class="col-sm-1">Last Updated</th>
                     <th class="col-sm-1">Exp. Date of Resol..</th>
                     <th class="col-sm-1">Status</th>
                     <th class="col-sm-1">Assigned To</th>
                     </tr>
                 </thead>
                    <tbody id="offcanvasDynamicAppendData_CustomerOpen"></tbody>
                    </table>
                </div>
                </div>
                    </div>
                </div>
 <!-- More Details for Open Tickets Offcanvas Section ends -->

    
        <!-- More Details for Tickets  Offcanvas Section starts CR Tickets -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="moredetails_OffcvsScreenCR" aria-labelledby="offcanvasWithBothOptionsLabel3">
        <div class="offcanvas-body" id="div_offcanvasidxIDCR">
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
        <div id="Ticketes_Tab3" class="CountryInfo">
            <div class="row mb-2">
                <div class="col-sm-6 col-lg-4">
                    <div class="row form-group mb-2 mx-2">
                        <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                            <label>Department</label>
                        </div>
                        <div class="col-sm-7 col-lg-7 col-8">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_DeptFilter_CR_ID", "usp_Whizible2_sel_DepartmentOfHRMPersonWithSelectDepartmentOnId " & Session("intUserID"),,, "onchange='GetCRTicketsDetails();' class='form-select'",,,) %>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-4">
                    <div class="row form-group mb-2">
                        <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                            <label>Customer</label>
                        </div>
                        <div class="col-sm-7 col-lg-7 col-8">
                            <select class="form-select" id="ddl_CustFilter_CR_ID" onchange="GetCRTicketsDetails(this.options[this.selectedIndex].value)">
                                <option>Select Customer</option>
                                <option>Support</option>
                                <option>Testing</option>
                                <option>Sales</option>
                                <option>Design</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="MainDiv">
                <table id="tbl_TicketsDetails_CR" class="table bgwhite table-bordered table-fixed-header projectdetailtbl mb-1" style="width:100%">
                    <thead class="stickyTblHeader">
                        <tr>
                            <th class="col-sm-1">ID</th>
                            <th class="col-sm-2">Subject</th>
                            <th class="col-sm-1">Request Type</th>
                            <th class="col-sm-1">Priority</th>
                            <th class="col-sm-1">Requestor</th>
                            <th class="col-sm-1">Requestor Name</th>
                            <th class="col-sm-1">Requested On</th>
                            <th class="col-sm-1">Last Updated</th>
                            <th class="col-sm-1">Exp. Date of Resol..</th>
                            <th class="col-sm-1">Status</th>
                            <th class="col-sm-1">Assigned To</th>
                        </tr>
                    </thead>
                    <tbody id="offcanvasDynamicAppendData_CR"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
        <!-- More Details for CR Tickets Offcanvas Section ends -->


       <!-- More Details for Top Tickets  Offcanvas Section starts Top Tickets -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="moredetails_OffcvsScreenTop" aria-labelledby="offcanvasWithBothOptionsLabel4">
        <div class="offcanvas-body" id="div_offcanvasidxIDTop">
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
        <div id="Ticketes_Tab3" class="CountryInfo">
            <div class="row mb-2">
                <div class="col-sm-6 col-lg-4">
                    <div class="row form-group mb-2 mx-2">
                        <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                            <label>Department</label>
                        </div>
                        <div class="col-sm-7 col-lg-7 col-8">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_DeptFilter_Top_ID", "usp_Whizible2_sel_DepartmentOfHRMPersonWithSelectDepartmentOnId " & Session("intUserID"),,, "onchange='GetTopTicketsDetails();' class='form-select'",,,) %>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-4">
                    <div class="row form-group mb-2">
                        <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                            <label>Customer</label>
                        </div>
                        <div class="col-sm-7 col-lg-7 col-8">
                            <select class="form-select" id="ddl_CustFilter_Top_ID" onchange="GetTopTicketsDetails(this.options[this.selectedIndex].value)">
                                <option>Select Customer</option>
                                <option>Support</option>
                                <option>Testing</option>
                                <option>Sales</option>
                                <option>Design</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="MainDiv">
                <table id="tbl_TicketsDetails_Top" class="table bgwhite table-bordered table-fixed-header projectdetailtbl mb-1" style="width:100%">
                    <thead class="stickyTblHeader">
                        <tr>
                            <th class="col-sm-1">ID</th>
                            <th class="col-sm-2">Subject</th>
                            <th class="col-sm-1">Request Type</th>
                            <th class="col-sm-1">Priority</th>
                            <th class="col-sm-1">Requestor</th>
                            <th class="col-sm-1">Requestor Name</th>
                            <th class="col-sm-1">Requested On</th>
                            <th class="col-sm-1">Last Updated</th>
                            <th class="col-sm-1">Exp. Date of Resol..</th>
                            <th class="col-sm-1">Status</th>
                            <th class="col-sm-1">Assigned To</th>
                        </tr>
                    </thead>
                    <tbody id="offcanvasDynamicAppendData_Top"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
        <!-- More Details for Top Tickets Offcanvas Section ends -->


        <!-- More Details for Latest Open Tickets  Offcanvas Section starts Tickets -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="moredetails_OffcvsScreenLo" aria-labelledby="offcanvasWithBothOptionsLabel5">
        <div class="offcanvas-body" id="div_offcanvasidxIDLo">
        <div class="container-fluid py-2 graybg mb-2">
            <div class="row align-items-center" style="width:100%">
                <div class="col-12 col-sm-10">
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
        <div id="Ticketes_Tab4" class="CountryInfo">
            <div class="row mb-2">
                <div class="col-sm-6 col-lg-4">
                    <div class="row form-group mb-2 mx-2">
                        <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                            <label>Department</label>
                        </div>
                        <div class="col-sm-7 col-lg-7 col-8">
                            <%=CommonFunctions.HTMLControls.DrawComboBox("ddl_DeptFilter_Lo_ID", "usp_Whizible2_sel_DepartmentOfHRMPersonWithSelectDepartmentOnId " & Session("intUserID"),,, "onchange='GetLoTicketsDetails();' class='form-select'",,,) %>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-lg-4">
                    <div class="row form-group mb-2">
                        <div class="col-sm-5 col-lg-3 col-4 pe-0 d-flex align-items-center justify-content-end">
                            <label>Customer</label>
                        </div>
                        <div class="col-sm-7 col-lg-7 col-8">
                            <select class="form-select" id="ddl_CustFilter_Lo_ID" onchange="GetLoTicketsDetails(this.options[this.selectedIndex].value)">
                                <option>Select Customer</option>
                                <option>Support</option>
                                <option>Testing</option>
                                <option>Sales</option>
                                <option>Design</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="MainDiv">
                <table id="tbl_TicketsDetails_Lo" class="table bgwhite table-bordered table-fixed-header projectdetailtbl mb-1" style="width:100%">
                    <thead class="stickyTblHeader">
                        <tr>
                            <th class="col-sm-1">ID</th>
                            <th class="col-sm-1">Subject</th>
                            <th class="col-sm-1">Request Type</th>
                            <th class="col-sm-1">Priority</th>
                            <th class="col-sm-1">Requestor</th>
                            <th class="col-sm-1">Requestor Name</th>
                            <th class="col-sm-1">Requested On</th>
                            <th class="col-sm-1">Last Updated</th>
                            <th class="col-sm-1">Exp. Date of Resol..</th>
                            <th class="col-sm-1">Status</th>
                            <th class="col-sm-1">Assigned To</th>
                        </tr>
                    </thead>
                    <tbody id="offcanvasDynamicAppendData_Lo"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>
        <!-- More Details for Latest Open Tickets Offcanvas Section ends -->



        <!-- More Details for Employee Online Offcanvas Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="Leave_OffcvsScreen" aria-labelledby="Leave_OffcvsScreen">
    <div class="offcanvas-body" id="div_offcanvasLeaveBodyID">
        <div class="container-fluid py-2 graybg mb-2">
            <div class="row align-items-center">
                <div class="col-10 col-sm-10">
                    <div class="d-flex align-items-center font-weight-600">
                       <span id="leaveDetailsSpan1">Leave Details</span>
                    </div>
                </div>
                <div class="col-2 col-sm-2 text-end">
                    <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                        <i class="fas fa-times"></i>
                    </a>
                </div>
            </div>
        </div>
        <div id="LeaveTab" class="LeaveInfo">
            <div class="row py-2">
                <div class="col-sm-8">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="row form-group">
                                <div class="col-sm-4 pe-0 d-flex justify-content-end">
                                    <label class="">Employee Name</label>
                                </div>
                                <div class="col-sm-8">
                                    <select class="form-select" id="ddl_EmpFilter_Online_ID" onchange="EmployeeOnLineDetails(this.value)">
                                        <option>Select Employee Name</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">&nbsp;</div>
                    </div>
                </div>
                <div class="col-sm-4"></div>
            </div>
            <div class="MainDiv">
                <table id="tbl_leaveDetails" class="table bgwhite table-bordered table-fixed-header projectdetailtbl mb-1" style="width:100%">
                    <thead class="stickyTblHeader">
                        <tr>
                            <th class="col-sm-2">Employee Name</th>
                            <th class="col-sm-2">Email ID</th>
                            <th class="col-sm-2">Phone</th>
                            <th class="col-sm-2">From Date</th>
                            <th class="col-sm-2">To Date</th>
                            <th class="col-sm-2">Status</th>
                            <th class="col-sm-2">No of Leaves</th>
                            <th class="col-sm-2">Balance Leave</th>
                        </tr>
                    </thead>
                    <tbody id="offcanvasDynamicAppendData_LeaveEmployee">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
        <!-- More Details for Employee Online Offcanvas Section ends -->


        
     <!-- More Details for Employee Online Offcanvas Section starts -->
        <div class="offcanvas offcanvas-end offcanvas-85" data-bs-scroll="false" tabindex="-1" id="Leave_OffcvsScreen2" aria-labelledby="Leave_OffcvsScreen2">
    <div class="offcanvas-body" id="div_offcanvasLeaveBodyID2">
        <div class="container-fluid py-2 graybg mb-2">
            <div class="row align-items-center">
                <div class="col-10 col-sm-10">
                    <div class="d-flex align-items-center font-weight-600">
                        <span id="leaveDetailsSpan2">Leave Details</span>
                    </div>
                </div>
                <div class="col-2 col-sm-2 text-end">
                    <a href="javascript:;" class="close offClose" data-bs-dismiss="offcanvas" data-bs-toggle="tooltip" title="Close">
                        <i class="fas fa-times"></i>
                    </a>
                </div>
            </div>
        </div>
        <div id="LeaveTab" class="LeaveInfo">
            <div class="row py-2">
                <div class="col-sm-8">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="row form-group">
                                <div class="col-sm-4 pe-0 d-flex justify-content-end">
                                    <label class="">Employee Name</label>
                                </div>
                                <div class="col-sm-8">
                                    <select class="form-select" id="ddl_EmpFilter_Leave_ID" onchange="EmployeeOnLeaveDetails(this.value)">
                                        <option>Select Employee Name</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">&nbsp;</div>
                    </div>
                </div>
                <div class="col-sm-4"></div>
            </div>
            <div class="MainDiv">
                <table id="tbl_leaveDetails2" class="table bgwhite table-bordered table-fixed-header projectdetailtbl mb-1" style="width:100%">
                    <thead class="stickyTblHeader">
                        <tr>
                            <th class="col-sm-2">Employee Name</th>
                            <th class="col-sm-2">Email ID</th>
                            <th class="col-sm-2">Phone</th>
                            <th class="col-sm-2">From Date</th>
                            <th class="col-sm-2">To Date</th>
                            <th class="col-sm-2">Status</th>
                            <th class="col-sm-2">No of Leaves</th>
                            <th class="col-sm-2">Balance Leave</th>
                        </tr>
                    </thead>
                    <tbody id="offcanvasDynamicAppendData_LeaveEmployee2">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
        <!-- More Details for Employee Online Offcanvas Section ends -->
     <%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;">You are not authorized to view this page.</p>
        </div>
    </div>
    <%End If %>



    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->

    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <!--<script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>-->
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
    <script type="text/javascript">

        //function resizeSection() {
        //    alert('caled');
        //    var tblheight = $(window).height();
        //    $('.dataTables_wrapper .dataTables_scroll').css({ 'height': tblheight - 250 });
        //}

        //$(window).on("load resize scroll", function (e) {
        //    resizeSection(this);
        //});


   
        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip();
        });

        $(document).on("click", function () {
            $(".tooltip").remove();
        });

        // Cost Line chart start
        $(function () {

            //get the line chart canvas
            var ctx = $("#Cost_LineChart");

            //line chart data
            var data = {
                labels: ["", "", "", "", ""],
                datasets: [{
                    label: "Create",
                    data: [0, 0, 0, 0, 0],
                    backgroundColor: "#0ad97a",
                    borderColor: "#0ad97a",
                    borderWidth: 1.5,
                    fill: false,
                    lineTension: 0,
                    radius: 3
                },
                {
                    label: "Closed",
                    data: [0, 0, 0, 0, 0],
                    backgroundColor: "#2B55CE",
                    borderColor: "#2B55CE",
                    borderWidth: 1.5,
                    fill: false,
                    lineTension: 0,
                    radius: 3
                },
                {
                    label: "SLA will Breaches",
                    data: [0, 0, 0, 0, 0],
                    backgroundColor: "#ec7103d9",
                    borderColor: "#ec7103d9",
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
                onClick: function (event, element) {
                    if (element.length > 0) {
                        openNav();
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
            function openNav() {
                var offcanvasElement = document.getElementById('moredetails_OffcvsScreen');
                var offcanvas = new bootstrap.Offcanvas(offcanvasElement);
                offcanvas.show();
            }
            //create Chart class object
            var chart = new Chart(ctx, {
                type: "line",
                data: data,
                options: options
            });
        });
        // Cost Line chart end

        // CSAT Score Of This Month start here
        const ctx1 = document.getElementById('SCAT_month_Graph');
        new Chart(ctx1, {
            "chart": {
                "showBorder": "1",
            },
            type: 'doughnut',
            data: {
                labels: ['Very satisfied', 'Satisfied', 'Neutral', 'Dissatisfied', 'Very dissatisfied'],
                datasets: [{
                    label: false,
                    data: [42.8, 14.2, 14.2, 14.2, 14.2],
                    borderWidth: 1,
                    barThickness: 30,
                    backgroundColor: ['#0cb567', '#c4c4c5', '#fbc89ed9', '#ec7103d9','#d10c0cd9'],
                }],

            },
            options: {
                maintainAspectRatio: false,
                responsive: true,
                //rotation: -90,
                //circumference: 180,

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
       /* CSAT Score Of This Month end here*/

        // Tickets Volume chart start

        const ctx2 = document.getElementById('Tickets_VolumeChart');
        new Chart(ctx2,
            {
            "chart": {
                "showBorder": "2",
            },
            type: 'line',
            data: {
                //labels: ['Computive Revenue', 'Budget Revenue'],
                //datasets: [{
                //    label: false,
                //    data: [20, 30, 50],
                //    borderWidth: 1,
                //    barThickness: 30,
                //    backgroundColor: ['rgba(235, 28, 36, 1)', 'yellow', 'green'],
                //}],

                labels: ['', '', '', '', '', '',],
                datasets: [{
                    label: 'My First Dataset',
                    data: [0, 0, 0, 0, 0, 0],
                    fill: false,
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }],
            },
            options: {
                maintainAspectRatio: false,
                responsive: true,
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
                            size: 15,
                            weight: 600
                        }
                    },
                    legend: {
                        display: false,
                        position: 'bottom',
        
                        labels: {
                            color: '#414042',
                            boxWidth: 50,
                            boxHeight: 50,
                        }
                    },
        
                }
            }
        });
        // Tickets Volume chart end


        var ctx = document.getElementById('SGraph').getContext('2d');

        var SGraph = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['', '', '', '', '', ''],
                datasets: [{
                    label: "Response SLA",
                    data: [0, 0, 0, 0, 0, 0],
                    backgroundColor: '#0ad97a'
                },{
                    label: 'Resolution SLA',
                    data: [0, 0, 0, 0, 0, 0],
                    backgroundColor: '#2B55CE'
                    },{
                    label: 'Closure',
                    data: [0, 0, 0, 0, 0, 0],
                    backgroundColor: '#ec7103d9'
                }],
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        display: false
                    }
                },
                scales: {
                    x: {
                        stacked: true // Stack bars horizontally
                    },
                    y: {
                        stacked: true // Stack bars vertically
                    }
                }
            },
            //options
         

        });






        // High level open tickets script start here
//        const ctx3 = document.getElementById('HighOpenTickets');
//        new Chart(ctx3, {
//            "chart": {
//                "showBorder": "2",
//            },
//            type: 'doughnut',
//            data: {
//                labels: ['High',''],
//                datasets: [{
//                    label: false,
//                    data: [70, 30],
//                    borderWidth: 2,
//                    barThickness: 10,
//                    backgroundColor: ['#1748d5','#ddd'],
//                }],

//            },
//            options: {
//                maintainAspectRatio: false,
//                responsive: true,
//                reverse: true,
//                cutout: '80%',
///*                radius: '50%',*/
//                plugins: {
//                    title: {
//                        display: true,
//                        text: '',
//                        color: '#414042',
//                        align: 'start',
//                        padding: {
//                            /*        bottom: 20*/
//                        },
//                        font: {
//                            // size: 18,
//                            // weight: 600
//                            size: 13,
//                            weight: 600

//                        }
//                    },
//                    legend: {
//                        display: false,
//                        position: 'bottom',
//                        reverse: true ,

//                        labels: {
//                            color: '#414042',
//                            boxWidth: 20,
//                            boxHeight: 20,
//                        }
//                    }
//                }
//            }
//        });
        // High level open tickets script End here  
        // Medium level open tickets script start here
        //const ctx4 = document.getElementById('MediumOpenTickets');
        //new Chart(ctx4, {
        //    "chart": {
        //        "showBorder": "2",
        //    },
        //    type: 'doughnut',
        //    data: {
        //        labels: ['High',''],
        //        datasets: [{
        //            label: false,
        //            data: [20, 80],
        //            borderWidth: 2,
        //            barThickness: 10,
        //            backgroundColor: ['#ec23ed','#ddd'],
        //        }],

        //    },
        //    options: {
        //        maintainAspectRatio: false,
        //        responsive: true,
        //        reverse: true,
        //        cutout: '80%',
        //        /*                radius: '50%',*/
        //        plugins: {
                   
        //            title: {
        //                display: true,
        //                text: '',
        //                color: '#414042',
        //                align: 'start',
        //                padding: {
        //                    /*        bottom: 20*/
        //                },
        //                font: {
        //                    // size: 18,
        //                    // weight: 600
        //                    size: 13,
        //                    weight: 600

        //                }
        //            },
        //            doughnutlabel: {
        //                labels: [
        //                    {
        //                        text: '550',
        //                        font: {
        //                            size: 90,
        //                            weight: 'bold',
        //                        },
        //                    },
        //                    {
        //                        text: 'total',
        //                    },
        //                ],
        //            },
        //            legend: {
        //                display: false,
        //                position: 'bottom',
        //                reverse: true ,

        //                labels: {
        //                    color: '#414042',
        //                    boxWidth: 20,
        //                    boxHeight: 20,
        //                }
        //            }
        //        }
        //    }
        //});
        // Medium level open tickets script End here
          // Low level open tickets script start here
//        const ctx5 = document.getElementById('LowOpenTickets');
//        new Chart(ctx5, {
//            "chart": {
//                "showBorder": "2",
//            },
//            type: 'doughnut',
//            data: {
//                labels: ['High',''],
//                datasets: [{
//                    label: false,
//                    data: [10, 90],
//                    borderWidth: 2,
//                    barThickness: 10,
//                    backgroundColor: ['#8da2f1','#ddd'],
//                }],

//            },
//            options: {
//                maintainAspectRatio: false,
//                responsive: true,
//                reverse: true,
//                cutout: '80%',
///*                radius: '50%',*/
//                plugins: {
//                    title: {
//                        display: true,
//                        text: '',
//                        color: '#414042',
//                        align: 'start',
//                        padding: {
//                            /*        bottom: 20*/
//                        },
//                        font: {
//                            // size: 18,
//                            // weight: 600
//                            size: 13,
//                            weight: 600

//                        }
//                    },
//                    legend: {
//                        display: false,
//                        position: 'bottom',
//                        reverse: true ,

//                        labels: {
//                            color: '#414042',
//                            boxWidth: 20,
//                            boxHeight: 20,
//                        }
//                    }
//                }
//            }
//        });
        // Low level open tickets script End here

        //datatable
        $('#tbl_tickets_reqlist').dataTable({
             "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 10,
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
        $('#tbl_tickets_reqlist').wrap('<div class="dataTables_scroll" />');


        $('#tbl_TicketsDetails').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 10,
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
        $('#tbl_TicketsDetails').wrap('<div class="dataTables_scroll" />');

        $('#tbl_leaveDetails').dataTable({
            // "scrollY": true,
            // "scrollX": true,
            "paging": true,
            "pageLength": 10,
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
        $('#tbl_leaveDetails').wrap('<div class="dataTables_scroll" />');

        function resizeSection() {
            var tblheight = $(window).height();
            $('#tbl_tickets_reqlist_wrapper .dataTables_scroll').css({ 'height': tblheight - 310});
            $('#tbl_TicketsDetails_wrapper .dataTables_scroll').css({ 'height': tblheight - 250, "overflow-y": "auto" });
            $('#tbl_leaveDetails_wrapper .dataTables_scroll').css({ 'height': tblheight - 250, "overflow-y": "auto" });
        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

  




        // IMPLEMENTATION FOR HRM-DAASHBOARD STARTS HERE

        function AJAXCallWithResult(url, param, async) {
            var ajaxResult = null;

            $.ajax({
                url: encodeURI(strUrl + url), // Ensure strUrl is defined
                type: "POST",
                data: JSON.stringify(param), // Ensure data is correctly serialized as JSON
                //data: param, // Ensure data is correctly serialized as JSON
                async: async,
                dataType: "json",
                contentType: "application/json;charset=utf-8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'Bearer ' + sessionStorage.getItem("access_token-Helpdesk"));

                    //xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_invoice"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }

                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    ajaxResult = undefined;
                    console.error("AJAX Error: ", err); // Improved error logging
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + encodeURIComponent(err.responseText);
                }
            });

            return ajaxResult;
        }


        // GLOBAL VARIABLES THAT WE WILL BE USING THROUGOUT 
        var AllHRMDepartment;
        var AllRequests;
        var department;
        var deptName;
        var deptID;
        var AllRequestsOfHRMDepartments;
        var AllOpenRequests;
        var uniqueDepartments;
        var selectedDeptId;
        var uniqueOnlineEmployee;
        var uniqueOfflineEmployee;
        var uniqueCustomers;
        var uniqueCustomers2;
        var today;
        var LatestTicketOpen;
        var UnassignedTickets;
        var OpenAllTickets;
        var ClosedAllTickets;
        var OpenHighTickets;
        var OpenMediumTickets;
        var OpenLowTickets;

        var openHighTicketPercentage;
        var openMediumTicketPercentage;
        var openLowTicketPercentage;

        var CRTickets;
        var AllOpenTicketsCustomerWise;
        var currentWeekDates;
        var TicketsCountOnDates = [];
        var CreatedTicketsCountOnDates = [];
        var ClosedTicketsCountOnDates = [];
        var AllIdOfDepartment = [];
        var VaioursCountOnDate = [];
        var AcknowledgementCount ;
        var ClosureCount ;
        var ResolutionCount ;
        var ResponseCount;
        var ResponseCountOfWeek = [];
        var ResolutionCountOfWeek = [];
        var ClosureCountOfWeek = [];

        // VARIABLE FOR CSAT PARAMETERS
        var totalRows;
        var verySatisfiedPercent;
        var satisfiedPercent;
        var neutralPercent;
        var dissatisfiedPercent;
        var veryDissatisfiedPercent;
        var CSAT;
        var FeedbackCountArray = []; // required to append CSAT section graph
        var allFBackData = [];
        var allFBackDataOfCurrentMonth = [];

        var selectedDPT;
        var ThresholdValue;
        var singletktSLA = [];
        var slawillbreachCountOnSingleDate = [];
        var TRAData = [];
        var fbpara;
        var FeedBackParameter = [];
        var EmployeeOnline = [];
        var empOnlineCounts;
        var EmployeeOnLeave = [];
        var closedTicketsOfThisWeek = [];
        var AssignToAndCountTemp = [];
        var FinalTopPerformerData = {};

        var hrmDbCounts = [];
        var createdTicketsResult = [];
        var closedTicketsResult = [];
        var stringOfHRMdepartmentIDs;
        var firstCustomerIDForCTO = null;
        var allPriorities = [];
        


        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Helpdesk").ToString()%>';

        var LoginType = '<%= Session("LoginType") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserId = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';


        $(document).ready(function () {
            documentReadyExecution();
        });




        //FUNCTION WHICH IS TO BE CALLED ON DOCUMENT DOT READY
        function documentReadyExecution() {
            var Parameters = {
                LoginType: LoginType,
                RoleId: RoleID,
                UserId: UserId,
                UserName: UserName
            }
            var param = Parameters;
            var Parameters2 = {
                UserId: UserId
            }

            AllHRMDepartment = [];
            AllHRMDepartment = AJAXCallWithResult("api/HRM_Management_Dashboard/GetDepartmentsForHRM", Parameters2, false);

            createDepartmentIDString(AllHRMDepartment);

            uniqueCustomers = getCustomersByHRMDepartmentIDs(stringOfHRMdepartmentIDs);
            // console.log('uuq Ccs: ' + JSON.stringify(uniqueCustomers)); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.

            uniqueDepartments = getUniqueDepartments(AllHRMDepartment);

            appendDepartmentsAndCustomer(AllHRMDepartment, uniqueCustomers);

            ThresholdValue = getThreshold();

            updateDateTime();
            document.querySelector('.help_department').textContent = `[${AllHRMDepartment[1].Department}]`;

            fillDashboardOnDepartment(AllHRMDepartment[1].DepartmentID);
        }
        //END OF Above Function


        //FUNCTION TO MAKE STRING OF HRMDEPARTMENTIDS
        function createDepartmentIDString(data) {
            stringOfHRMdepartmentIDs = '';
            if (!Array.isArray(data) || data.length === 0) {
                console.error("Invalid data:", data);
                return '';
            }
            stringOfHRMdepartmentIDs = data.map(item => item.DepartmentID).join(',');
            return stringOfHRMdepartmentIDs;
        }
        //END


        //FUNCTION TO FIND OUT CUSTOMERS OF ALL HRM DEPARTMENT

        function getCustomersByHRMDepartmentIDs(departmentIDString) {
            let parameters = {
                SIDs: departmentIDString
            };
            let result = AJAXCallWithResult("api/HRM_Management_Dashboard/GetCustomersByHRMDepartmentIDs", parameters, false);
            if (result && Array.isArray(result)) {

                let uniqueCustomers = [];
                let customerIDs = new Set();

                result.forEach(function (customer) {
                    if (!customerIDs.has(customer.CustomerID)) {
                        uniqueCustomers.push(customer);
                        customerIDs.add(customer.CustomerID);
                    }
                });

                return uniqueCustomers;
            } else {
                console.error("Failed to get customers data or invalid result format.");
                return [];
            }
        }

        //END


        //FUNCTION FOR EVALUATING THE TOP TIMING FOR THE DASHBOARD
        function updateDateTime() {
            var now = new Date();

            // Format the date and time as [ DD-MMM-YY hh:mm AM/PM ]
            var date = now.toLocaleDateString('en-GB', { day: '2-digit', month: 'short', year: '2-digit' }).replace(/ /g, '-');
            var time = now.toLocaleTimeString('en-GB', { hour: '2-digit', minute: '2-digit', hour12: true });
            // Combine date and time
            var dateTimeString = `[ ${date} ${time.toUpperCase()} ]`;
            // Update the content of the span element
            document.querySelector('.help_date_time').textContent = dateTimeString;
        }
        //END

        setInterval(updateDateTime, 1000);




        //FUNCTION TO GET UNIQUE DEPARTMENTS
        function getUniqueDepartments(data) {
            var departments = data.map(function (department) {
                return department.Department;
            });
            return departments;
        }


        //FUNCTION FOR FETCHING UNIQUE EMPLOYEE NAME
        function getUniqueEmployeeNames(data) {
            if (!Array.isArray(data)) {
                console.error("Data is not an array:", data);
                return [];
            }

            var employeeNames = [];
            data.forEach(function (employee) {
                employee.forEach(function (detail) { // since EmployeeOnline is a nested array
                    if (!employeeNames.includes(detail.EmployeeName)) {
                        employeeNames.push(detail.EmployeeName);
                    }
                });
            });
            return employeeNames;
        }

        //FUNCTION TO APPEND EMPLOYEE DROPDOWN
        function AppendEmployeeDropdown() {
            var $seld = $('#ddl_EmpFilter_Online_ID, #ddl_EmpFilter_Leave_ID');

            if ($seld.length) {
                $seld.empty();
                $seld.append('<option>Select Employee</option>');
                uniqueOnlineEmployee.forEach(function (employee) {
                    $seld.append($('<option>', {
                        value: employee,
                        text: employee
                    }));
                });
            } else {
                console.error("Employee dropdown not found.");
            }
        }

        function AppendEmployeeOnLeaveDropdown() {
            var $seld = $('#ddl_EmpFilter_Leave_ID');

            if ($seld.length) {
                $seld.empty();
                $seld.append('<option>Select Employee</option>');
                uniqueOfflineEmployee.forEach(function (employee) {
                    $seld.append($('<option>', {
                        value: employee,
                        text: employee
                    }));
                });
            } else {
                console.error("Employee dropdown not found.");
            }
        }



        //FUNCTION TO APPEND UNIQUE DEPARTMENT TO THE DROPDOWN
        function appendDepartmentsAndCustomer(departments, customers) {
            var $seld = $('#ddl_departmentSelectID');
            if ($seld.length) {
                $seld.empty();
                // $seld.append('<option>Select Department</option>');
                AllHRMDepartment.slice(1).forEach(function (department) {
                    $seld.append($('<option>', {
                        value: department.DepartmentID,
                        text: department.Department,
                        selected: department.DepartmentID === AllHRMDepartment[1].DepartmentID
                    }));
                });
            } else {
                console.error("Department dropdown not found.");
            } 


            // for offcanvas
            var $select2 = $('#ddl_departmentSelectOffcanvasID');
            $select2.empty();
            $select2.append('<option>Select Department</option>');
            departments.forEach(function (department) {
                $select2.append($('<option>', {
                    value: department,
                    text: department
                }));
            });

            //for offcanvas
            var $select3 = $('#ddl_customerSelectOffcanvasID');
            $select3.empty();
            customers.forEach(function (customer) {
                $select3.append($('<option>', {
                    value: customer.CustomerID, 
                    text: customer.CustomerName
                }));
            });

            //old offcanvas
            var $select4 = $('#ddl_CustFilter_Unassigned_ID, #ddl_CustFilter_Open_ID, #ddl_CustFilter_Lo_ID, #ddl_CustFilter_Top_ID, #ddl_CustFilter_CR_ID, #ddl_CustFilter_CustomerOpen_ID');
            $select4.empty();
            customers.forEach(function (customer) {
                $select4.append($('<option>', {
                    value: customer.CustomerID,
                    text: customer.CustomerName
                }));
            });

        }



        //FUNCTION TO APPEND DATA IN DASHBOARD ON THE BASIS OF DEPARTMENT
        function fillDashboardOnDepartment(department) {
            deptID = department;
            deptName = getDepartmentName(department);

            var Parameter3 = {
                Id: department
            };
            AllRequests = AJAXCallWithResult("api/HRM_Management_Dashboard/GetTicketsForAllDepartmentsOfHRM", Parameter3, false);

            EmployeeOnline = [];
            document.querySelector('.help_department').textContent = `[${deptName}]`;

            selectedDPT = department;
            today = getTodaysDate();
            feedbackPara();
            $('#spn_vsID').text(FeedBackParameter[0]);
            $('#spn_sId').text(FeedBackParameter[1]);
            $('#spn_nID').text(FeedBackParameter[2]);
            $('#spn_dID').text(FeedBackParameter[3]);
            $('#spn_vdID').text(FeedBackParameter[4]);


            var Parameterstwo = {
                Id: department
            }

            OpenAllTickets = OpenTicketsSystemStatus(Parameterstwo); // needed for percentage calculation OF HIGH LOW MEDIUM and customer wise open ticket data 

            OpenHighTickets = openTicketsHigh(OpenAllTickets, deptName);

            OpenMediumTickets = openTicketsMedium(OpenAllTickets, deptName);

            OpenLowTickets = openTicketsLow(OpenAllTickets, deptName);

            openHighTicketPercentage = ((OpenHighTickets.length / OpenAllTickets.length) * 100).toFixed(1);
            openMediumTicketPercentage = ((OpenMediumTickets.length / OpenAllTickets.length) * 100).toFixed(1);
            openLowTicketPercentage = ((OpenLowTickets.length / OpenAllTickets.length) * 100).toFixed(1);

            //AppendOpenTicketsPercentage(openHighTicketPercentage, openMediumTicketPercentage, openLowTicketPercentage);

            //appendTicketsPercentage(openHighTicketPercentage, openMediumTicketPercentage, openLowTicketPercentage);

            AllOpenTicketsCustomerWise = processTickets(OpenAllTickets, uniqueCustomers);
            appendTickets(AllOpenTicketsCustomerWise);

            currentWeekDates = getCurrentWeekDates();

            CreatedTicketThisWeekData(department, currentWeekDates[0], currentWeekDates[5]);
            ClosedTicketThisWeekData(department, currentWeekDates[0], currentWeekDates[5]);

            CreatedTicketThisWeek(createdTicketsResult);
            ClosedTicketThisWeek(closedTicketsResult);

            TicketVolumeThisWeek(createdTicketsResult);
            AppendTicketVolumneGraph();

            AllIdOfDepartment = getAllQueryIDsByDepartment(department);

            ResponseCountOfWeek = [];
            ResolutionCountOfWeek = [];
            ClosureCountOfWeek = [];

            slawillbreachCountOnSingleDate = [];
            executeSLABreachesUntilToday(currentWeekDates, AllIdOfDepartment);

            AppendSLABreachesThisWeek();

            allFBackData = toFetchFeedbacks(department);

            allFBackDataOfCurrentMonth = toFetchFeedbacksOfCurrentMonth(department);
            toFetchCountsOnFeedBackOfCurrentMonthOfDepartment(allFBackDataOfCurrentMonth);
            appendCSATSectionData();

            AppendTicketThisWeek();

            AllTicketsOfDepartmentRequiringAttention(AllRequests, deptName);

            appendTicketsRequiringAttention(TRAData);

            emponline(department, today);

            uniqueOnlineEmployee = [];
            uniqueOnlineEmployee = getUniqueEmployeeNames(EmployeeOnline);

            empOnlineCount(department, today);

            emponLeave(department, today);

            removeOnLeaveEmployeesFromOnline();


            uniqueOfflineEmployee = [];
            uniqueOfflineEmployee = getUniqueEmployeeNames(EmployeeOnLeave);

            var Parameters = {
                Id: deptID,
                FromDate: currentWeekDates[0],
                ToDate: currentWeekDates[currentWeekDates.length - 1]
            }

            let closedTktOfWeekForSelectedDepartment = AJAXCallWithResult("api/HRM_Management_Dashboard/GetClosedTicketsByDepartmentidForWeek", Parameters, false);

            FindTopPerformerAndItsCount(closedTktOfWeekForSelectedDepartment);

            FinalTopPerformerData = combineTimeTakenAndCount(AssignToAndCountTemp);

            AppendTopPerformer(FinalTopPerformerData);

            hrmDbCounts = getHRMDBCountsForMultipleSection(department, currentWeekDates[0], currentWeekDates[5]);

            updateHtmlSections(hrmDbCounts);

            AppendEmployeeDropdown();
            AppendEmployeeOnLeaveDropdown();

            // appendLeaveDetailsWithDate();

            OpenTicketsPriorityWise(OpenAllTickets);
            // alert(JSON.stringify(allPriorities));

        }
        //END OF ABOVE FUNCTION



        //FUNCTION FOR FINDING OUT PRIORITY PARAMETER AND DATA FILTERING
       // var percentageForAllPriorities = []; // It should store data like : [{'High',30.50,69.50}]

        function OpenTicketsPriorityWise(data) {
            let result = AJAXCallWithResult("api/HRM_Management_Dashboard/GetConfiguredPrioritiesForTicket", null, false);
            let allPriorities = [];
            percentageForAllPriorities = [];

            if (result && Array.isArray(result)) {
                for (let r of result) {
                    allPriorities.push(r);
                }
            } else {
                console.error("Error: The result is not defined or is not an array.");
            }

            for (let i = 0; i < allPriorities.length; i++) {
                let filteredData = data.filter(function (row) {
                    return row.Priority === allPriorities[i].Priority;
                });

                let percentageForPOpenTickets = (filteredData.length / data.length) * 100;

                if (isNaN(percentageForPOpenTickets)) { percentageForPOpenTickets = 0.0; }
                
                let rempercentageForPOpenTickets = 100 - percentageForPOpenTickets;

                percentageForAllPriorities.push([
                    allPriorities[i].Priority,
                    percentageForPOpenTickets.toFixed(2),
                    rempercentageForPOpenTickets.toFixed(2)
                ]);
            }

            // console.log('percentageForAllPriorities:', JSON.stringify(percentageForAllPriorities)); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.

            generateCarousel(percentageForAllPriorities); // Generate the carousel and graphs with the processed data
        }

        function generateCarousel(data) {
            let carouselInner = document.getElementById('carousel-inner');
            let carouselIndicators = document.getElementById('carousel-indicators');

            carouselInner.innerHTML = '';
            carouselIndicators.innerHTML = '';

            let numPages = Math.ceil(data.length / 3);

            for (let i = 0; i < numPages; i++) {
                // Create a carousel item
                let carouselItem = document.createElement('div');
                carouselItem.className = 'carousel-item' + (i === 0 ? ' active' : '');

                let rowDiv = document.createElement('div');
                rowDiv.className = 'row d-flex';

                // Create graphs for each page
                for (let j = 0; j < 3; j++) {
                    let paramIndex = i * 3 + j;
                    if (paramIndex < data.length) {
                        let colDiv = document.createElement('div');
                        colDiv.className = 'col-12 col-sm-12 text-start p-0 m-0';

                        let graphDiv = document.createElement('div');
                        graphDiv.className = 'canvas-con';

                        let percentageParagraph = document.createElement('p');
                        percentageParagraph.className = 'medium_center_text';
                        percentageParagraph.id = 'percentageOpenTickets' + paramIndex;
                        percentageParagraph.textContent = data[paramIndex][1] + '%';

                        let canvasInnerDiv = document.createElement('div');
                        canvasInnerDiv.className = 'canvas-con-inner';

                        let canvas = document.createElement('canvas');
                        canvas.id = 'graphCanvas' + paramIndex;
                        canvas.style.width = '85px';
                        canvas.style.height = '96px';
                        canvas.style.maxWidth = '85px'; // Ensuring the size is consistent
                        canvas.style.maxHeight = '96px'; // Ensuring the size is consistent
                        canvas.style.minWidth = '85px'; // Ensuring the size is consistent
                        canvas.style.minHeight = '96px'; // Ensuring the size is consistent

                        canvasInnerDiv.appendChild(canvas);

                        graphDiv.appendChild(percentageParagraph);
                        graphDiv.appendChild(canvasInnerDiv);

                        let graphRowDiv = document.createElement('div');
                        graphRowDiv.className = 'row mt-2 mb-2';

                        let canvasColDiv = document.createElement('div');
                        canvasColDiv.className = 'col-6 col-sm-7 col-lg-7 text-start pe-0 ps-0';
                        canvasColDiv.appendChild(graphDiv);

                        let labelColDiv = document.createElement('div');
                        labelColDiv.className = 'col-6 col-sm-5 col-lg-5 text-start flex_display pe-0 ps-2';
                        let span = document.createElement('span');
                        span.textContent = data[paramIndex][0];
                        span.className = 'pe-3 span_text';
                        span.style.fontSize = '14px';
                        labelColDiv.appendChild(span);

                        graphRowDiv.appendChild(canvasColDiv);
                        graphRowDiv.appendChild(labelColDiv);
                        colDiv.appendChild(graphRowDiv);
                        rowDiv.appendChild(colDiv);
                    }
                }

                carouselItem.appendChild(rowDiv);
                carouselInner.appendChild(carouselItem);

                // Create a carousel indicator
                let indicator = document.createElement('button');
                indicator.type = 'button';
                indicator.setAttribute('data-bs-target', '#carouselExample');
                indicator.setAttribute('data-bs-slide-to', i);
                indicator.className = i === 0 ? 'active' : '';
                carouselIndicators.appendChild(indicator);
            }

            // Ensure graphs are generated after DOM update
            setTimeout(() => {
                for (let i = 0; i < data.length; i++) {
                    generateGraph('graphCanvas' + i, data[i]);
                }
            }, 0);
        }

        function generateGraph(canvasId, param) {
            const ctx = document.getElementById(canvasId).getContext('2d');
            new Chart(ctx, {
                type: 'doughnut',
                data: {
                   /* labels: [param[0], ''],*/
                    datasets: [{
                        data: [parseFloat(param[1]), parseFloat(param[2])],
                        backgroundColor: ['#ec23ed', '#ddd'],
                        borderWidth: 2,
                        barThickness: 10
                    }]
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
                                /* bottom: 20 */
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
                                boxHeight: 20
                            }
                        }
                    }
                }
            });
        }






        //END OF ABOVE FUNCTION


        //FUNCTION TO FETCH DASHBOARD INITIAL COUNTS
        function getHRMDBCountsForMultipleSection(departmentId, fromDate, toDate) {
            let parameters = {
                Id: departmentId,
                FromDate: fromDate,
                ToDate: toDate
            };
            let result = AJAXCallWithResult("api/HRM_Management_Dashboard/GetHRMDBCounts", parameters, false);
            return result;
        }

        //FUNCTION TO APPEND DASHBOARD VALUES FOR MULTIPLE SECTIONS
        function updateHtmlSections(data) {
            if (!Array.isArray(data) || data.length === 0) {
                console.error("Invalid data:", data);
                return;
            }
            let counts = data[0];

            $('#spn_unassignedTicketsID').text(counts.UTCount);
            $('#spn_LTOpenID').text(counts.LOTCount);
            $('#spn_open_CQID').text(counts.OTCount);
            $('#spn_CR_CQID').text(counts.CRTCounts);
            $('#spn_TopPriority_CQID').text(counts.TPTCount);
        }

        function CreatedTicketThisWeekData(departmentID, fromDate, toDate) {
            let parameters = {
                Id: departmentID,
                FromDate: fromDate,
                ToDate: toDate
            };
            createdTicketsResult = AJAXCallWithResult("api/HRM_Management_Dashboard/GetTicketsCreatedOnCurrentWeekForDepartment", parameters, false);
        }

        function ClosedTicketThisWeekData(departmentId, fromDate, toDate) {
            let parameters = {
                Id: departmentId,
                FromDate: fromDate,
                ToDate: toDate
            };
            closedTicketsResult = AJAXCallWithResult("api/HRM_Management_Dashboard/GetTicketsClosedOnCurrentWeekForDepartment", parameters, false);
        }



        //FUNCTION TO APPEND CLOSED TICKETS THIS WEEK
        function ClosedTicketThisWeek(data) {
            if (!Array.isArray(data) || data.length === 0) {
                console.error("Invalid data:", data);
                return;
            }
            ClosedTicketsCountOnDates = [];
            ClosedTicketsCountOnDates.push(data[0].day1);
            ClosedTicketsCountOnDates.push(data[0].day2);
            ClosedTicketsCountOnDates.push(data[0].day3);
            ClosedTicketsCountOnDates.push(data[0].day4);
            ClosedTicketsCountOnDates.push(data[0].day5);
            ClosedTicketsCountOnDates.push(data[0].day6);
        }
        //END



        //FUNCTION TO APPEND CLOSED TICKETS THIS WEEK
        function CreatedTicketThisWeek(data) {
            if (!Array.isArray(data) || data.length === 0) {
                console.error("Invalid data:", data);
                return;
            }
            CreatedTicketsCountOnDates = [];
            CreatedTicketsCountOnDates.push(data[0].day1);
            CreatedTicketsCountOnDates.push(data[0].day2);
            CreatedTicketsCountOnDates.push(data[0].day3);
            CreatedTicketsCountOnDates.push(data[0].day4);
            CreatedTicketsCountOnDates.push(data[0].day5);
            CreatedTicketsCountOnDates.push(data[0].day6);
        }
        //END

        //FUNCTION TO GET ALL ID OF SELECTED DEPARTMENT
        function getAllQueryIDsByDepartment(department) {

            let parameters = {
                Id: department
            };
            let result = AJAXCallWithResult("api/HRM_Management_Dashboard/GetALLQueryIDsByDepartment", parameters, false);
            AllIdOfDepartment = [];
            if (result && Array.isArray(result)) {
                result.forEach(function (row) {
                    AllIdOfDepartment.push(row.QueryID);
                });
            } else {
                console.error("Failed to get QueryIDs data or invalid result format.");
            }
            return AllIdOfDepartment;
        }

        //FUNCTION TO FETCH DEPARTMENT NAME FROM DEPARTMENT ID
        function getDepartmentName(departmentID) {
            // Convert departmentID to a number to ensure proper comparison
            departmentID = Number(departmentID);
            let department = AllHRMDepartment.find(dept => dept.DepartmentID === departmentID);
            return department ? department.Department : 'Department not found';
        }


        //END



        //FUNCTION TO FIND COUNTS WITH EMPLOYEE NAME
        function FindTopPerformerAndItsCount(data) {
            AssignToAndCountTemp = []
            data.forEach(dt => {
                var Parameters = {
                    Id: dt.QueryID
                };
                let SLAData = AJAXCallWithResult("api/HRM_Management_Dashboard/GetSLADataOfTicket", Parameters, false);
                let valid = 0;
                let timeTaken = 0;
                SLAData.forEach(row => {
                    if (row.MetApplicable === 'Met') {
                        valid += 1;
                    }
                });
                // if (valid != 4) {
                if (valid != SLAData.length) {
                    return; // to skip to the next iteration for this row
                } else {
                    if (dt.AssignTo != null) {
                        SLAData.forEach(row => {
                            timeTaken += parseFloat(row.ActualDuration);
                        });
                        AssignToAndCountTemp.push({ AssignTo: dt.AssignTo, TimeTaken: timeTaken });
                    }
                }
            });
        }

        function combineTimeTakenAndCount(data) {
            let combinedData = {};
            data.forEach(item => {
                if (combinedData[item.AssignTo]) {
                    combinedData[item.AssignTo].TimeTaken += item.TimeTaken;
                    combinedData[item.AssignTo].Count += 1;
                } else {
                    combinedData[item.AssignTo] = {
                        TimeTaken: item.TimeTaken,
                        Count: 1
                    };
                }
            });

            let result = [];
            for (let key in combinedData) {
                if (combinedData.hasOwnProperty(key)) {
                    result.push({
                        AssignTo: key,
                        TimeTaken: combinedData[key].TimeTaken,
                        Count: combinedData[key].Count
                    });
                }
            }

            result.sort((a, b) => {
                if (b.Count === a.Count) {
                    return a.TimeTaken - b.TimeTaken;
                }
                return b.Count - a.Count; // Sort by Count descending
            });

            return result;
        }

        function AppendTopPerformer(data) {
            let insideHTML = ``;
            data.forEach(row => {
                insideHTML +=
                    `<div class="d-flex justify-content-between d-inline">
                <div class="">${row.AssignTo}</div>
                <div class="">${row.Count}</div>
            </div>`;
            });
            $('#div_topPerformerID').empty();
            $('#div_topPerformerID').html(insideHTML);
        }
        //END OF ABOVE FUNCTIONALITY



        //FUNCTION TO FIND EMPLOYEES WHO ARE ONLINE (NOT ON LEAVE) AND WHOM HAVE APPLIED FOR THE FUTURE LEAVE
        function emponline(dept, date) {
            EmployeeOnline = [];
            var Parameters = {
                Id: dept,
                OnDate: date
            };
            let onlineEmp = AJAXCallWithResult("api/HRM_Management_Dashboard/GetEmployeesDetailWhoNotOnLeaveToday", Parameters, false);
            if (onlineEmp != null && onlineEmp.length > 0) {
                EmployeeOnline.push(onlineEmp);
            }
        }
        //END


        //FUNCTION TO FIND ONLINE EMPLOYEES COUNT
         function empOnlineCount(dept, date) {
            empOnlineCounts = 0;
            var Parameters = {
                Id: dept,
                OnDate: date
            };
            let onlineEmpCount = AJAXCallWithResult("api/HRM_Management_Dashboard/GetEmployeesOnlineCount", Parameters, false);
            empOnlineCounts = onlineEmpCount.length;
            $('#spn_onlineEmployeeID').text(onlineEmpCount.length);
        }
        //END





        // function to find employees who are on leave
        function emponLeave(dept, date) {
            EmployeeOnLeave = [];
            let EmployeeOnLeaveForCount = [];
            var Parameters = {
                Id: dept,
                OnDate: date
            };
            let onleaveEmp = AJAXCallWithResult("api/HRM_Management_Dashboard/GetEmployeesDetailWhoOnLeaveToday", Parameters, false);
            if (onleaveEmp != null && onleaveEmp.length > 0) {
                EmployeeOnLeave.push(onleaveEmp); // Keep this as it was earlier
                EmployeeOnLeaveForCount = EmployeeOnLeaveForCount.concat(onleaveEmp);
            }
            $('#spn_onLeaveEmployeeID').text(EmployeeOnLeaveForCount.length);
        }

        // END OF ABOVE FUNCTION




        // Function to remove employees from EmployeeOnline if they exist in EmployeeOnLeave
        function removeOnLeaveEmployeesFromOnline() {
            if (!EmployeeOnline || EmployeeOnline.length === 0) {
                console.error('EmployeeOnline is not defined or empty.');
                return;
            }
            if (!EmployeeOnLeave || EmployeeOnLeave.length === 0) {
                console.error('EmployeeOnLeave is not defined or empty.');
                return;
            }
            // Flatten the nested arrays
            let flatEmployeeOnline = EmployeeOnline.flat();
            let flatEmployeeOnLeave = EmployeeOnLeave.flat();
            // Filter out employees who are on leave from EmployeeOnline
            flatEmployeeOnline = flatEmployeeOnline.filter(onlineEmp => {
                return !flatEmployeeOnLeave.some(onLeaveEmp => onLeaveEmp.EmployeeID === onlineEmp.EmployeeID);
            });
            // Update EmployeeOnline with the filtered data
            EmployeeOnline = [flatEmployeeOnline];
        }


        //FUNCTION TO EXECUTE OTHER FUNCTION TO FIND OUT SLA BREACHED UPTILL TODAY
        function executeSLABreachesUntilToday(currentWeekDates, AllIdOfDepartment) {
            let today = new Date();
            let formattedTodayDate = formatDateToSQL(today);
            for (let i = 0; i < currentWeekDates.length; i++) {
                let formattedDate = formatDateToSQL(currentWeekDates[i]);
                if (formattedDate <= formattedTodayDate) {
                    AllSLABreachesOnDateForDepartmentOnDate(selectedDPT, formattedDate);
                    SLAWillBreachCountForDepartmentOnDate(selectedDPT, formattedDate);
                }
                else {
                    break;
                }
            }
        }


        //FUNCTION TO CALCULATE SLA WILL BREACH COUNT FOR A SPECIFIC DATE
        function SLAWillBreachCount(ids, date) {
            // console.log("Starting SLAWillBreachCount with date: " + date); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
            // Format the input date to match the format of SubmittedDate
            let formattedDate = date.split(' ')[0];
            // console.log("Formatted date for comparison: " + formattedDate); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
            let actualbreachCount = 0; // Initialize breach count for a single execution
            ids.forEach(id => {
                // console.log("Processing ID: " + id); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                var Parameters = { Id: id };
                var param = Parameters;
                var singleTktSLAData = AJAXCallWithResult("api/HRM_Management_Dashboard/GetSLADataOfTicket", param, false);
                // console.log("Received SLA data for ID " + id + ": ", singleTktSLAData); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                let slabreach = 0;
                singleTktSLAData.forEach(row => {
                    let threshold = ThresholdValue[0].Threshold;
                    // console.log("Threshold value: " + threshold); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    // console.log("Processing row: ", row); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    const conditionsMet = row.MetApplicable === "Not Occured";
                    const remainingHrsMinNotNull = row.RemainingHrsMin != null;
                    const remainingHrsMinConverted = remainingHrsMinNotNull ? convertHrsMinToMinutes(row.RemainingHrsMin) < threshold : false;
                    const submittedDateMatches = row.SubmittedDate.startsWith(formattedDate);
                    const noNegativeTime = remainingHrsMinNotNull ? !row.RemainingHrsMin.includes('-') : false;
                    // console.log("Conditions - MetApplicable: ", conditionsMet); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    // console.log("Conditions - RemainingHrsMin Not Null: ", remainingHrsMinNotNull); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    // console.log("Conditions - RemainingHrsMin Converted: ", remainingHrsMinConverted); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    // console.log("Conditions - Submitted Date Matches: ", submittedDateMatches); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    // console.log("Conditions - No Negative Time: ", noNegativeTime); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    // console.log("Comparing row.SubmittedDate: ", row.SubmittedDate); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    // console.log("Comparing with formatted date: ", formattedDate); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    if (conditionsMet && remainingHrsMinNotNull && remainingHrsMinConverted && submittedDateMatches && noNegativeTime) {
                        // console.log("Row passes criteria, RemainingHrsMin: " + row.RemainingHrsMin); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                        // console.log("Converted time: " + convertHrsMinToMinutes(row.RemainingHrsMin)); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                        slabreach += 1;
                        if (row.SLACategory === "Closure" && (row.MetApplicable === "Met" || row.MetApplicable === "Not Met")) {
                            // console.log("Resetting slabreach for Closure"); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                            slabreach = 0;
                        }
                    } else {
                        // console.log("Row does not pass criteria, skipping"); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    }
                });
                // console.log("Slabreach count for ID " + id + ": " + slabreach); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                // if (slabreach > 1) {
                if (slabreach >= 1) {
                    actualbreachCount += 1;
                }
            });
            // Insert the summed value for a specific date
            slawillbreachCountOnSingleDate.push(actualbreachCount);
            // console.log("Final slawillbreachCountOnSingleDate for the date: ", actualbreachCount); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
        }

        function convertHrsMinToMinutes(hrsMin) {
            // console.log("Converting hrsMin: " + hrsMin); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
            if (!hrsMin) {
                console.error("hrsMin is null or invalid: " + hrsMin);
                return 0;
            }
            let [hours, minutes] = hrsMin.split('Hr ').map(val => parseInt(val.replace('Min', '')));
            // console.log("Parsed hours: " + hours + ", minutes: " + minutes); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
            return (hours * 60) + minutes;
        }
        //END





        //FUNCTION TO CALCULATE SLA WILL BREACH COUNT FOR A SPECIFIC DATE IT IS FASTER
        function SLAWillBreachCountForDepartmentOnDate(departmentId, formattedDate) {
            // console.log("Starting SLAWillBreachCountForAllTickets with date: " + formattedDate); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
            let actualbreachCount = 0; // Initialize breach count for a single execution
            var Parameters = {
                Id: departmentId,
                OnDate: formattedDate // Ensure the key matches the expected parameter name in the backend
            };
            // Fetch all ticket SLA data
            var allTktSLAData;
            try {
                allTktSLAData = AJAXCallWithResult("api/HRM_Management_Dashboard/GetSLADataOfAllTicketForDepartmentOnDate", Parameters, false);
                // console.log("Received all ticket SLA data: ", allTktSLAData); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
            } catch (error) {
                console.error("Error fetching SLA data: ", error);
                return;
            }
            // Group the data by QueryID
            let groupedData = allTktSLAData.reduce((acc, row) => {
                if (!acc[row.QueryID]) {
                    acc[row.QueryID] = [];
                }
                acc[row.QueryID].push(row);
                return acc;
            }, {});
            // Iterate through each group of rows
            Object.keys(groupedData).forEach(queryID => {
                let rows = groupedData[queryID];
                let slabreach = 0;
                rows.forEach(row => {
                    let threshold = ThresholdValue[0].Threshold;
                    // console.log("Threshold value: " + threshold); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    // console.log("Processing row: ", row); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    //const conditionsMet = row.MetApplicable === "Not Occured"; 
                    const remainingHrsMinNotNull = row.RemainingHrsMin != null;
                    const remainingHrsMinConverted = remainingHrsMinNotNull ? convertHrsMinToMinutes(row.RemainingHrsMin) < threshold : false;
                    // Parsing the date to match the format
                    const rowSubmittedDate = new Date(row.SubmittedDate).toISOString().split('T')[0];
                    const formattedDateParsed = new Date(formattedDate).toISOString().split('T')[0];
                    const submittedDateMatches = rowSubmittedDate === formattedDateParsed;
                    const noNegativeTime = remainingHrsMinNotNull ? !row.RemainingHrsMin.includes('-') : false;
                    // console.log("Conditions - MetApplicable: ", conditionsMet); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    // console.log("Conditions - RemainingHrsMin Not Null: ", remainingHrsMinNotNull); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    // console.log("Conditions - RemainingHrsMin Converted: ", remainingHrsMinConverted); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    // console.log("Conditions - Submitted Date Matches: ", submittedDateMatches); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    // console.log("Conditions - No Negative Time: ", noNegativeTime); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    // console.log("Comparing row.SubmittedDate: ", row.SubmittedDate); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    // console.log("Comparing with formatted date: ", formattedDate); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    //if (conditionsMet && remainingHrsMinNotNull && remainingHrsMinConverted && submittedDateMatches && noNegativeTime) {
                    if (remainingHrsMinNotNull && remainingHrsMinConverted && submittedDateMatches && noNegativeTime) {
                        // console.log("Row passes criteria, RemainingHrsMin: " + row.RemainingHrsMin); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                        // console.log("Converted time: " + convertHrsMinToMinutes(row.RemainingHrsMin)); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                        slabreach += 1;
                        if (row.SLACategory === "Closure" && (row.MetApplicable === "Met" || row.MetApplicable === "Not Met")) {
                            // console.log("Resetting slabreach for Closure"); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                            slabreach = 0;
                        }
                    } else {
                        // console.log("Row does not pass criteria, skipping"); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                    }
                });
                // console.log("Slabreach count for QueryID " + queryID + ": " + slabreach); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                if (slabreach > 1) {
                    actualbreachCount += 1;
                }
            });
            // Insert the summed value for a specific date
            slawillbreachCountOnSingleDate.push(actualbreachCount);
            // console.log("Final slawillbreachCountOnSingleDate for the date: ", actualbreachCount); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
        }
        //END





        //FUNCTION TO FIND SLABREACHED OR NOT
        function IsSLABreached(id) {
            let isBreached = 0;
            var Parameters = { Id: id };
            var singleTktSLAData = AJAXCallWithResult("api/HRM_Management_Dashboard/GetSLADataOfTicket", Parameters, false);
            singleTktSLAData.forEach(row => {
                if (row.MetApplicable !== "Not Met") {
                    isBreached += 1;
                }
            });
            return isBreached > 0 ? 1 : 0;
        }




        //FUNCTION TO FIND ID OF TICKETS FOR TICKET REQUIRING ATTENTION SECTION
        function AllTicketsOfDepartmentRequiringAttention(data, department) {
            TRAData = [];
            //console.log('dataa: ' + JSON.stringify(data)); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
            filteredData = data.filter(function (row) {
                // console.log('TRADataRow: ', row); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
               // return row.Department === department && row.Priority === 'Critical - High' && row.Status != "Closed";
                return row.UniqueID !== null;
            });
            filteredData.sort((a, b) => new Date(b.SubmittedDate) - new Date(a.SubmittedDate));
            filteredData.forEach(row => {
                // let status = IsSLABreached(row.QueryID);
                // console.log('QueryID: ', row.QueryID, 'Status: ', status); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                //  if (status === 1) {
                TRAData.push(row);
                //      console.log('TRAPushed'); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
                //   }
            });
            //console.log('TRD:' + JSON.stringify(TRAData)); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
        }
        //END


        // Helper function to determine the time class based on the time difference
        function getTimeClass(submittedDate) {
            var now = new Date();
            var date = new Date(submittedDate);
            var diff = (now - date) / 1000 / 60; // difference in minutes
            if (diff <= 60) {
                return "text_green";
            } else if (diff <= 24 * 60) {
                return "text_orange";
            } else {
                return "text_red";
            }
        }

        // Helper function to calculate time ago
        function timeAgo(date) {
            var now = new Date();
            var seconds = Math.floor((now - date) / 1000);
            var interval = seconds / 3600;
            if (interval < 1) {
                return Math.floor(seconds / 60) + " min ago";
            } else if (interval < 24) {
                return Math.floor(interval) + " hours ago";
            } else {
                return Math.floor(interval / 24) + " days ago";
            }
        }




        //FUNCTION TO ATTEND TICKETS REQUIRING ATTENTION
        function appendTicketsRequiringAttention(data) {
            // Ensure data is an array to handle null or undefined scenarios
            data = Array.isArray(data) ? data : [];

            // Get references to the pagination buttons and carousel items within carousel_Recently_breached
            var buttonSlide1 = document.querySelector('#carousel_Recently_breached button[data-bs-slide-to="0"]');
            var buttonSlide2 = document.querySelector('#carousel_Recently_breached button[data-bs-slide-to="1"]');
            var buttonSlide3 = document.querySelector('#carousel_Recently_breached button[data-bs-slide-to="2"]');
            var firstCarouselItem = document.querySelector('#carousel_Recently_breached .carousel-item:nth-child(1)');
            var secondCarouselItem = document.querySelector('#carousel_Recently_breached .carousel-item:nth-child(2)');
            var thirdCarouselItem = document.querySelector('#carousel_Recently_breached .carousel-item:nth-child(3)');

            // Reset active state to the first button
            buttonSlide1.classList.add('active');
            buttonSlide1.setAttribute('aria-current', 'true');
            buttonSlide2.classList.remove('active');
            buttonSlide2.removeAttribute('aria-current');
            buttonSlide3.classList.remove('active');
            buttonSlide3.removeAttribute('aria-current');

            // Ensure the first carousel item is active
            firstCarouselItem.classList.add('active');
            secondCarouselItem.classList.remove('active');
            thirdCarouselItem.classList.remove('active');

            // Hide or show pagination buttons and carousel items based on data length
            if (data.length <= 5) {
                buttonSlide2.style.display = 'none';
                buttonSlide3.style.display = 'none';
            } else if (data.length > 5 && data.length <= 10) {
                buttonSlide2.style.display = 'block';
                buttonSlide3.style.display = 'none';
            } else {
                buttonSlide2.style.display = 'block';
                buttonSlide3.style.display = 'block';
            }

            // Loop through the first 15 rows or the length of the data array, whichever is smaller
            for (var i = 0; i < 15; i++) {
                var row = document.getElementById('ticket_' + (i + 1));
                if (row) {
                    if (i < data.length) {
                        var item = data[i];
                        row.cells[0].textContent = item.QueryID || '';
                        row.cells[1].textContent = item.Subject || '';
                        row.cells[2].innerHTML = `<div class="d-flex justify-content-start">
                              <img src="../../../Whizible2.0-new/dist/img/profImg1.jpg" class="CardView_icon" alt=""> ${item.AssignToName || ''}
                            </div>`;
                        row.cells[3].innerHTML = `<div class="${getTimeClass(item.SubmittedDate)}">${timeAgo(new Date(item.SubmittedDate))}</div>`;
                    } else {
                        // Clear the row if there are no more data items
                        row.cells[0].textContent = '';
                        row.cells[1].textContent = '';
                        row.cells[2].innerHTML = '';
                        row.cells[3].innerHTML = '';
                    }
                }
            }
        }
        //END




        //FUNCTION TO FETCH TODAYS DATE IN PROPER fORMAT
        function getTodaysDate() {
            
            var today = new Date();
            var year = today.getFullYear();
            var month = String(today.getMonth() + 1).padStart(2, '0');
            var day = String(today.getDate()).padStart(2, '0');
            return `${year}-${month}-${day}`;
        }



        //FUNCTION TO FETCH TODAYS DATE IN PROPER fORMAT WITH EXTRA ZEROES
        function formatDateToSQL(dateString) {
            var date = new Date(dateString);
            var year = date.getFullYear();
            var month = ('0' + (date.getMonth() + 1)).slice(-2);
            var day = ('0' + date.getDate()).slice(-2);
            return `${year}-${month}-${day} 00:00:00.000`;
        }



        //FUNCTION TO FETCH DATE IN PROPER FORMAT FOR LEAVE SECTION
        function appendLeaveDetailsWithDate() {
            var today = new Date();
            var day = String(today.getDate()).padStart(2, '0');
            var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            var month = monthNames[today.getMonth()];
            var year = today.getFullYear();
            var formattedDate = `${day} ${month} ${year}`;

            var leaveDetailsSpan1 = document.getElementById('leaveDetailsSpan1');
            leaveDetailsSpan1.textContent = `Leave Details: ${formattedDate}`;

            var leaveDetailsSpan2 = document.getElementById('leaveDetailsSpan2');
            leaveDetailsSpan2.textContent = `Leave Details: ${formattedDate}`;
        }



        //FUNCTION TO FILTER LATEST TICKET OPEN DEPARTMENT WISE
        function filterDataByDepartmentAndStatus(data, department, currentweekdates) {
            var firstDate = new Date(currentweekdates[0]);
            var lastDate = new Date(currentweekdates[currentweekdates.length - 1]);
            var filteredData = data.filter(function (row) {
            var submittedDate = new Date(row.SubmittedDate);
                // Ensure the time parts of the dates are removed for accurate comparison
                firstDate.setHours(0, 0, 0, 0);
                lastDate.setHours(0, 0, 0, 0);
                submittedDate.setHours(0, 0, 0, 0);

            var isDepartmentMatch = row.Department === department;
            var isWithinDateRange = (
                    submittedDate.getTime() === firstDate.getTime() ||
                    submittedDate.getTime() === lastDate.getTime() ||
                    (submittedDate >= firstDate && submittedDate <= lastDate)
                );
                return isDepartmentMatch && isWithinDateRange;
            });
            return filteredData;
        }
        //END



        //FUNCTION FOR OPEN TICKETS WITH HIGH PRIORITY
        function openTicketsHigh(data, department) {
            var filteredData = data.filter(function (row) {
                return row.Priority === 'High';
            });
            return filteredData;
        }
        //END


        //FUNCTION FOR OPEN TICKETS WITH MEDIUM PRIORITY
        function openTicketsMedium(data, department) {
            var filteredData = data.filter(function (row) {
                return row.Priority === 'Medium';
            });
            return filteredData;
        }
        //END


        //FUNCTION FOR OPEN TICKETS WITH MEDIUM PRIORITY
        function openTicketsLow(data, department) {
            var filteredData = data.filter(function (row) {
                return row.Priority === 'Low';
            });
            return filteredData;
        }
        //END



        //FUNCTION FOR ALL OPEN TICKETS OF SPECIFIC DEPARTMENT
        function allOpenTickets(data, department) {
            var filteredData = data.filter(function (row) {
                return row.Department === department && row.Status === "Submitted";
            });
            return filteredData;
        }
        //END



        //FUNCTION FOR ALL OPEN TICKETS ON SYSTEM STATUS BASIS FOR A SPECIFIC DEPARTMENT UPDATED
        function OpenTicketsSystemStatus(param) {
            let filtereddata;
            filtereddata = AJAXCallWithResult("api/HRM_Management_Dashboard/GetAllOpenTicketsForDepartment", param, false);
            return filtereddata;
        }
        //END



        //FUNCTION FOR ALL CLOSED TICKETS ON SYSTEM STATUS BASIS FOR A SPECIFIC DEPARTMENT UPDATED
        function CloseTicketsSystemStatus(param) {
            let filtereddata;
            filtereddata = AJAXCallWithResult("api/HRM_Management_Dashboard/GetAllCloseTicketsForDepartment", param, false);
            return filtereddata;

        }
        //END


        function appendTicketsPercentage(HighTPer, MediumTPer, LowTPer) {
            HighTPer = isNaN(HighTPer) ? '0.0' : HighTPer;
            MediumTPer = isNaN(MediumTPer) ? '0.0' : MediumTPer;
            LowTPer = isNaN(LowTPer) ? '0.0' : LowTPer;
            $('#p_openTicketsHighID').text(HighTPer + '%');
            $('#p_openTicketsMediumID').text(MediumTPer + '%');
            $('#p_openTicketsLowID').text(LowTPer + '%');
        }
        //END


        //FUNCTION FOR CR TICKETS DEPARTMENT WISE
        function allCRTicketsForDepartment(data, department) {
            var filteredData = data.filter(function (row) {
                return row.Department === department && row.SubRequestType === "Change Request";
            });
            return filteredData;
        }
        //END



        //FUNCTION TO APPEND CURRENT QUEUE SECTION
        function updateCurrentQueue(open, cr, topPriority) {
            $('#spn_open_CQID').text(open);
            $('#spn_CR_CQID').text(cr);
            $('#spn_TopPriority_CQID').text(topPriority);
        }
        //END




        //FUNCTION TO FETCH UNIQUE CUSTOMER AND THEIR RESPECTIVE OPEN TICKET COUNTS DEPARTMENT WISE
        function getOpenTicketsByCustomer(data, department) {
            var filteredData = data.filter(function (row) {
                return row.Status === 'Submitted' && row.Department === department;
            });
            var result = {};
            filteredData.forEach(function (row) {
                if (result[row.CustomerName]) {
                    result[row.CustomerName].NoOfOpenTickets += 1;
                } else {
                    result[row.CustomerName] = { CustomerName: row.CustomerName, NoOfOpenTickets: 1 };
                }
            });
            return Object.values(result);
        }
        //END



        //FUNCTION TO FETCH NUMBER OF OPEN TICKETS DEPARTMENT WISE
        //function processTickets(data, uniqueCustomers) {
        //    console.log('datax:' + JSON.stringify(data)); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.

        //    // Create a Set of unique CustomerIDs
        //    var customerIDSet = new Set(uniqueCustomers.map(customer => customer.CustomerID));

        //    var customerTicketCount = {};

        //    data.forEach(function (ticket) {
        //        if (customerIDSet.has(ticket.CustomerID)) {
        //            if (customerTicketCount[ticket.CustomerName]) {
        //                customerTicketCount[ticket.CustomerName]++;
        //            } else {
        //                customerTicketCount[ticket.CustomerName] = 1;
        //            }
        //        }
        //    });

        //    var result = Object.keys(customerTicketCount).map(function (customerName) {
        //        return {
        //            CustomerName: customerName,
        //            NoOfOpenTickets: customerTicketCount[customerName]
        //        };
        //    });

        //    return result;
        //}
        function processTickets(data, uniqueCustomers) {
            // console.log('datax:' + JSON.stringify(data)); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
            firstCustomerIDForCTO = null;

            // Create a Set of unique CustomerIDs
            var customerIDSet = new Set(uniqueCustomers.map(customer => customer.CustomerID));

            var customerTicketCount = {};

            data.forEach(function (ticket) {
                if (customerIDSet.has(ticket.CustomerID)) {
                    if (customerTicketCount[ticket.CustomerName]) {
                        customerTicketCount[ticket.CustomerName]++;
                    } else {
                        customerTicketCount[ticket.CustomerName] = 1;
                        // Store the first CustomerID
                        if (firstCustomerIDForCTO === null) {
                            firstCustomerIDForCTO = ticket.CustomerID;
                        }
                    }
                }
            });

            var result = Object.keys(customerTicketCount).map(function (customerName) {
                return {
                    CustomerName: customerName,
                    NoOfOpenTickets: customerTicketCount[customerName]
                };
            });
            // console.log('xyz:'+ firstCustomerIDForCTO); //Commented by Ajit L on 09/01/2025 for Point West VAPT issues.
            return result;
        }



        //END




        //FUNCTION TO GET THRESHOL VALUE
        function getThreshold() {
            return AJAXCallWithResult("api/HRM_Management_Dashboard/GetThresholdValue", null, false);
        }
        //END



        //FUNCTION TO APPEND CUSTOMER AND THEIR OPEN TICKET COUNTS
        function appendTickets(data) {
            var container = document.getElementById('ticketContainer');
            container.innerHTML = '';
            // Limit the loop to the first 5 items or the length of the data array, whichever is smaller
            for (var i = 0; i < Math.min(data.length, 5); i++) {
                var item = data[i];
                var ticketHtml = ` <div class="d-flex justify-content-between d-inline">
                               <div class="">${item.CustomerName}</div>
                               <div class="">${item.NoOfOpenTickets}</div> 
                           </div> `;
                container.insertAdjacentHTML('beforeend', ticketHtml);
            }
        }

        //END




        //FUNCTION TO FIND OUT DAYS AND THEIR DATE FOR CURRENT WEEK
        function getCurrentWeekDates() {
            var currentDate = new Date();
            var firstDayOfWeek = new Date(currentDate.setDate(currentDate.getDate() - currentDate.getDay() + 1)); // Monday
            var dates = [];
            for (var i = 0; i < 6; i++) {
                var date = new Date(firstDayOfWeek);
                date.setDate(firstDayOfWeek.getDate() + i);

                var year = date.getFullYear();
                var month = String(date.getMonth() + 1).padStart(2, '0');
                var day = String(date.getDate()).padStart(2, '0');
                dates.push(`${year}-${month}-${day}`);
            }
            return dates;
        }
        //END


        function TicketVolumeThisWeek(data) {
            if (!Array.isArray(data) || data.length === 0) {
                console.error("Invalid data:", data);
                return;
            }
            TicketsCountOnDates = [];
            TicketsCountOnDates.push(data[0].day1);
            TicketsCountOnDates.push(data[0].day2);
            TicketsCountOnDates.push(data[0].day3);
            TicketsCountOnDates.push(data[0].day4);
            TicketsCountOnDates.push(data[0].day5);
            TicketsCountOnDates.push(data[0].day6);
        }


        //END




        //FUNCTION TO SETUP TICKET VOLUME GRAPH
        function AppendTicketVolumneGraph() {
            $("#div_canvasWrapperID").empty();
            $("#div_canvasWrapperID").html("").html('<canvas id="storeSends"></canvas>');
            const ctx3 = document.getElementById('storeSends');
            new Chart(ctx3,
                {
                    "chart": {
                        "showBorder": "2",
                    },
                    type: 'line',
                    data: {

                        labels: currentWeekDates,
                        datasets: [{
                            label: 'Tickets Raised',
                            data: TicketsCountOnDates,
                            fill: false,
                            borderColor: 'rgb(75, 192, 192)',
                            tension: 0.1
                        }],
                    },
                    options: {
                        maintainAspectRatio: false,
                        responsive: true,
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
                                    size: 15,
                                    weight: 600
                                }
                            },
                            legend: {
                                display: false,
                                position: 'bottom',

                                labels: {
                                    color: '#414042',
                                    boxWidth: 50,
                                    boxHeight: 50,
                                }
                            },

                        }
                    }
                });
        }
        //END



        //FUNCTION TO APPEND TICKET THIS WEEK DATA
        function AppendTicketThisWeek() { 
            $("#div_canvasWrapper2ID").empty();
            $("#div_canvasWrapper2ID").html("").html('<canvas id="storeSends2"></canvas>');
            const ctx4 = document.getElementById('storeSends2');
            var data = {
                labels: currentWeekDates,
                datasets: [{
                    label: "Create",
                    data: CreatedTicketsCountOnDates,
                    backgroundColor: "#0ad97a",
                    borderColor: "#0ad97a",
                    borderWidth: 1.5,
                    fill: false,
                    lineTension: 0,
                    radius: 3
                },
                {
                    label: "Closed",
                    data: ClosedTicketsCountOnDates,
                    backgroundColor: "#2B55CE",
                    borderColor: "#2B55CE",
                    borderWidth: 1.5,
                    fill: false,
                    lineTension: 0,
                    radius: 3
                },
                {
                    label: "SLA will Breaches",
                    data: slawillbreachCountOnSingleDate,
                    backgroundColor: "#ec7103d9",
                    borderColor: "#ec7103d9",
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
                //onClick: function (event, element) {
                //    if (element.length > 0) {
                //        openNav();
                //    }
                //},
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
            function openNav() {
                var offcanvasElement = document.getElementById('moredetails_OffcvsScreen');
                var offcanvas = new bootstrap.Offcanvas(offcanvasElement);
                offcanvas.show();
            }
            //create Chart class object
            var chart = new Chart(ctx4, {
                type: "line",
                data: data,
                options: options
            });
        }
        //END



        //FUNCTION TO APPEND SLA BREACHES THIS WEEK
        function AppendSLABreachesThisWeek() {
            $("#div_canvasWrapper3ID").empty();
            $("#div_canvasWrapper3ID").html("").html('<canvas id="storeSends3"></canvas>');
            var ctx5 = document.getElementById('storeSends3').getContext('2d');
            var SGraph = new Chart(ctx5, {
                type: 'bar',
                data: {
                    labels: currentWeekDates,
                    datasets: [{
                        label: "Response SLA",
                        data: ResponseCountOfWeek,
                        backgroundColor: '#0ad97a'
                    }, {
                        label: 'Resolution SLA',
                        data: ResolutionCountOfWeek,
                        backgroundColor: '#2B55CE'
                    }, {
                        label: 'Closure',
                        data: ClosureCountOfWeek,
                        backgroundColor: '#ec7103d9'
                    }],
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: false
                        }
                    },
                    scales: {
                        x: {
                            stacked: true // Stack bars horizontally
                        },
                        y: {
                            stacked: true // Stack bars vertically
                        }
                    }
                },
                //options


            });

        }
        //END


        //FUNCTION TO FIND OUT ALL SLA BREACHES FOR A SPECIFIC DATE AND DEPARTMENT 
        // * this logic is causing page to render slow.



        // FUNCTION TO FIND OUT SLA BREACHES COUNT ON THE BASIS OF DEPARTMENT ID AND DATE
        function AllSLABreachesOnDateForDepartmentOnDate(departmentId, date) {
            AcknowledgementCount = 0;
            ClosureCount = 0;
            ResolutionCount = 0;
            ResponseCount = 0;
            let Parameters = {
                Id: departmentId, // Id acting as department id here
                OnDate: date
            };
            let data = AJAXCallWithResult("api/HRM_Management_Dashboard/GetSLABreachesCountForDepartmentOnDate", Parameters, false);
            data.forEach(function (dt) {
                if (dt.SLACategory === "Acknowledgement") {
                    AcknowledgementCount += dt.Count;
                }
                if (dt.SLACategory === "Closure") {
                    ClosureCount += dt.Count;
                }
                if (dt.SLACategory === "Resolution") {
                    ResolutionCount += dt.Count;
                }
                if (dt.SLACategory === "Response") {
                    ResponseCount += dt.Count;
                }
            });
            ResponseCountOfWeek.push(ResponseCount);
            ResolutionCountOfWeek.push(ResolutionCount);
            ClosureCountOfWeek.push(ClosureCount);
        }
        //END




        //FUNCTION TO FETCH FEEDBACK PARAMETER SUCH AS EXCELLENT, POOR, GOOD ETC
        function feedbackPara() {
            FeedBackParameter = [];
            let fbpara = AJAXCallWithResult("api/HRM_Management_Dashboard/GetFeedbackParameters", null, false);
            if (fbpara) {
                let fp = fbpara.map(item => item.ParameterName);
                FeedBackParameter.push(...fp);
            }
            return FeedBackParameter;
        }
        //END




        //FUNCTION TO FORMAT DATE IN THIS FORMAT '2024-11'
        function formatToYearMonth(date) {
            let year = date.getFullYear();
            let month = ('0' + (date.getMonth() + 1)).slice(-2);
            return `${year}-${month}`;
        }
        //END





        //FUNCTION TO APPEND HIGH TICKET PERCENTAGE GRAPH
        function AppendOpenTicketsPercentage(HighPercentage, MediumPercentage, LowPercentage) {
            let remPercentageForHigh = 100.0 - HighPercentage;
            let remPercentageForMedium = 100.0 - MediumPercentage;
            let remPercentageForLow = 100.0 - LowPercentage;
            // For High Section
            $("#div_openHighTicketPercentage").empty();
            $("#div_openHighTicketPercentage").html('<canvas id="HighOpenTicketsAppend" style="width:85px; height:96px; padding:0px"></canvas>');
            const ctxHigh = document.getElementById('HighOpenTicketsAppend');
            new Chart(ctxHigh, {
                type: 'doughnut',
                data: {
                    labels: ['High', ''],
                    datasets: [{
                        label: false,
                        data: [HighPercentage, remPercentageForHigh],
                        borderWidth: 2,
                        barThickness: 10,
                        backgroundColor: ['#1748d5', '#ddd'],
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
                            padding: {},
                            font: {
                                size: 13,
                                weight: 600,
                            },
                        },
                        legend: {
                            display: false,
                            position: 'bottom',
                            reverse: true,
                            labels: {
                                color: '#414042',
                                boxWidth: 20,
                                boxHeight: 20,
                            },
                        },
                    },
                },
            });

            // For Medium Section
            $("#div_openMediumTicketPercentage").empty();
            $("#div_openMediumTicketPercentage").html('<canvas id="MediumOpenTicketsAppend" style="width:85px; height:96px; padding:0px"></canvas>');

            const ctxMedium = document.getElementById('MediumOpenTicketsAppend');

            new Chart(ctxMedium, {
                type: 'doughnut',
                data: {
                    labels: ['Medium', ''],
                    datasets: [{
                        label: false,
                        data: [MediumPercentage, remPercentageForMedium],
                        borderWidth: 2,
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

            // For Low Section
            $("#div_openLowTicketPercentage").empty();
            $("#div_openLowTicketPercentage").html('<canvas id="LowOpenTicketsAppend" style="width:85px; height:96px; padding:0px"></canvas>');

            const ctxLow = document.getElementById('LowOpenTicketsAppend');

            new Chart(ctxLow, {
                type: 'doughnut',
                data: {
                    labels: ['Low', ''],
                    datasets: [{
                        label: false,
                        data: [LowPercentage, remPercentageForLow],
                        borderWidth: 2,
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

        //END


        //FUNCTION TO FETCH COUNTS RELATED TO CSAT OF CURRENT MONTH OF A SPECIFIC DEPARTMENT
        function toFetchCountsOnFeedBackOfCurrentMonthOfDepartment(datafb) {
            let feedbackCounts = {};
            let totalCount = datafb.length;

            datafb.forEach(row => {
                if (!feedbackCounts[row.Rating]) {
                    feedbackCounts[row.Rating] = 1;
                } else {
                    feedbackCounts[row.Rating]++;
                }
            });

            verySatisfiedPercent = (feedbackCounts[5] || 0) / totalCount * 100;
            satisfiedPercent = (feedbackCounts[4] || 0) / totalCount * 100;
            neutralPercent = (feedbackCounts[3] || 0) / totalCount * 100;
            dissatisfiedPercent = (feedbackCounts[2] || 0) / totalCount * 100;
            veryDissatisfiedPercent = (feedbackCounts[1] || 0) / totalCount * 100;
            CSAT = ((feedbackCounts[5] + feedbackCounts[4]) / totalCount) * 100;
            totalRows = totalCount;
        }


        //END



        //UPDATED FUNCTION TO APPEND CSAT SECTION
        function appendCSATSectionData() {
            FeedbackCountArray = [];
            if (isNaN(verySatisfiedPercent)) {
                verySatisfiedPercent = 0;
                $('#str_verySatisfiedPercentageID').text(verySatisfiedPercent.toFixed(1) + '%');
            } else {
                $('#str_verySatisfiedPercentageID').text(verySatisfiedPercent.toFixed(1) + '%');
            }

            if (isNaN(satisfiedPercent)) {
                satisfiedPercent = 0;
                $('#str_satisfiedPercentageID').text(satisfiedPercent.toFixed(1) + '%');
            } else {
                $('#str_satisfiedPercentageID').text(satisfiedPercent.toFixed(1) + '%');
            }

            if (isNaN(neutralPercent)) {
                neutralPercent = 0;
                $('#str_neutralPercentageID').text(neutralPercent.toFixed(1) + '%');
            } else {
                $('#str_neutralPercentageID').text(neutralPercent.toFixed(1) + '%');
            }

            if (isNaN(dissatisfiedPercent)) {
                dissatisfiedPercent = 0;
                $('#str_dissatisfiedPercentageID').text(dissatisfiedPercent.toFixed(1) + '%');
            } else {
                $('#str_dissatisfiedPercentageID').text(dissatisfiedPercent.toFixed(1) + '%');
            }

            if (isNaN(veryDissatisfiedPercent)) {
                veryDissatisfiedPercent = 0;
                $('#str_veryDissatisfiedPercentageID').text(veryDissatisfiedPercent.toFixed(1) + '%');
            } else {
                $('#str_veryDissatisfiedPercentageID').text(veryDissatisfiedPercent.toFixed(1) + '%');
            }

            if (isNaN(CSAT)) {
                CSAT = 0;
                $('#str_csatPercentageID').text(CSAT.toFixed(1) + '%');
            } else {
                $('#str_csatPercentageID').text(CSAT.toFixed(1) + '%');
            }
            $('#div_custSurveyedID').text('Customer Surveyed : ' + totalRows);

            FeedbackCountArray.push(verySatisfiedPercent);
            FeedbackCountArray.push(satisfiedPercent);
            FeedbackCountArray.push(neutralPercent);
            FeedbackCountArray.push(dissatisfiedPercent);
            FeedbackCountArray.push(veryDissatisfiedPercent);

            // for updating graph of CSAT score
            $("#div_canvasWrapper7ID").empty();
            $("#div_canvasWrapper7ID").html("").html('<canvas id="storeSends7" style="width:112px; height:100px;"></canvas>');

            const ctx7 = document.getElementById('storeSends7');

            new Chart(ctx7, {
                "chart": {
                    "showBorder": "1",
                },
                type: 'doughnut',
                data: {
                    labels: FeedBackParameter,
                    datasets: [{
                        label: false,
                        data: FeedbackCountArray,
                        borderWidth: 1,
                        barThickness: 30,
                        backgroundColor: ['#0cb567', '#4be53dc7', '#fbc89ed9', '#ec7103d9', '#d10c0cd9'],
                    }],

                },
                options: {
                    maintainAspectRatio: false,
                    responsive: true,
                    //rotation: -90,
                    //circumference: 180,

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
        //END


        //FUNCTION TO FETCH FEEDBACK DATA OF CURRENT MONTH FOR CSAT
        function toFetchFeedbacksOfCurrentMonth(id) {
            var Parameters = {
                Id: id,
                OnDate: today
            };
            let data = AJAXCallWithResult("api/HRM_Management_Dashboard/GetFeedBacksFoCSAT", Parameters, false);
            return data;
        }
        //END



        //FUNCTION TO FETCH DATA RELATED TO FEEDBACK

        //function toFetchFeedbacks(id) {
        //    var Parameters = {
        //        Id: id
        //    };
        //    let data = AJAXCallWithResult("api/HRM_Management_Dashboard/GetFeedBacks", Parameters, false);

        //    // Get references to the pagination buttons
        //    var buttonSlide1 = document.getElementById('carousel_slide1');
        //    var buttonSlide2 = document.getElementById('carousel_slide2');
        //    var buttonSlide3 = document.getElementById('carousel_slide3');
        //    var firstCarouselItem = document.querySelector('#carousel_Customer .carousel-item:nth-child(1)');
        //    var secondCarouselItem = document.querySelector('#carousel_Customer .carousel-item:nth-child(2)');
        //    var thirdCarouselItem = document.querySelector('#carousel_Customer .carousel-item:nth-child(3)');

        //    // Reset active state to the first button
        //    buttonSlide1.classList.add('active');
        //    buttonSlide1.setAttribute('aria-current', 'true');
        //    buttonSlide2.classList.remove('active');
        //    buttonSlide2.removeAttribute('aria-current');
        //    buttonSlide3.classList.remove('active');
        //    buttonSlide3.removeAttribute('aria-current');

        //    // Ensure the first carousel item is active
        //    firstCarouselItem.classList.add('active');
        //    secondCarouselItem.classList.remove('active');
        //    thirdCarouselItem.classList.remove('active');

        //    // Hide or show pagination buttons based on data length
        //    if (data.length <= 5) {
        //        buttonSlide2.style.display = 'none';
        //        buttonSlide3.style.display = 'none';
        //    } else if (data.length > 5 && data.length <= 10) {
        //        buttonSlide2.style.display = 'block';
        //        buttonSlide3.style.display = 'none';
        //    } else {
        //        buttonSlide2.style.display = 'block';
        //        buttonSlide3.style.display = 'block';
        //    }

        //    for (var i = 0; i < 15; i++) {
        //        var feedbackComment = $('#feedbackComment' + (i + 1));
        //        var customerName = $('#customerName' + (i + 1));
        //        var stars = $('#stars' + (i + 1));
        //        var time = $('#time' + (i + 1));

        //        if (i < data.length) {
        //            var item = data[i];
        //            feedbackComment.text(item.FeedbackComments);
        //            customerName.text(item.CustomerName);

        //            // Create and update the thumb icon based on the rating
        //            let thumbIcon = $('<i class="fas fa-thumbs-up me-2"></i>');
        //            if (item.Rating === 5) {
        //                thumbIcon.addClass('greenn_like_thum');
        //            } else if (item.Rating === 4) {
        //                thumbIcon.addClass('yelloww_like_thum');
        //            } else if (item.Rating === 3) {
        //                thumbIcon.addClass('orange_like_thum');
        //            } else if (item.Rating === 2) {
        //                thumbIcon.addClass('blue_like_thum');
        //            } else if (item.Rating === 1) {
        //                thumbIcon.addClass('red_like_thum');
        //            } else {
        //                thumbIcon.addClass('like_thum'); // Default color for other cases
        //            }

        //            // Remove any existing thumb icon and append the new one
        //            feedbackComment.prev('i').remove();
        //            feedbackComment.before(thumbIcon);

        //            // Update the stars
        //            let htmlstar = starhtml(item.Rating);
        //            stars.empty();
        //            stars.append(htmlstar);

        //            // Update the time
        //            let timeDiff = timeDifference(item.ClosedDate);
        //            time.empty();
        //            time.append(timeDiff);
        //        } else {
        //            feedbackComment.text('');
        //            customerName.text('');
        //            stars.empty();
        //            time.empty();
        //        }
        //    }
        //    return data;
        //}


        function toFetchFeedbacks(id) {
            var Parameters = {
                Id: id
            };
            let data = AJAXCallWithResult("api/HRM_Management_Dashboard/GetFeedBacks", Parameters, false);

            // Get references to the pagination buttons
            var buttonSlide1 = document.getElementById('carousel_slide1');
            var buttonSlide2 = document.getElementById('carousel_slide2');
            var buttonSlide3 = document.getElementById('carousel_slide3');
            var firstCarouselItem = document.querySelector('#carousel_Customer .carousel-item:nth-child(1)');
            var secondCarouselItem = document.querySelector('#carousel_Customer .carousel-item:nth-child(2)');
            var thirdCarouselItem = document.querySelector('#carousel_Customer .carousel-item:nth-child(3)');

            // Reset active state to the first button
            buttonSlide1.classList.add('active');
            buttonSlide1.setAttribute('aria-current', 'true');
            buttonSlide2.classList.remove('active');
            buttonSlide2.removeAttribute('aria-current');
            buttonSlide3.classList.remove('active');
            buttonSlide3.removeAttribute('aria-current');

            // Ensure the first carousel item is active 
            firstCarouselItem.classList.add('active');
            secondCarouselItem.classList.remove('active');
            thirdCarouselItem.classList.remove('active');

            // Hide or show pagination buttons based on data length
            if (data.length <= 5) {
                buttonSlide2.style.display = 'none';
                buttonSlide3.style.display = 'none';
            } else if (data.length > 5 && data.length <= 10) {
                buttonSlide2.style.display = 'block';
                buttonSlide3.style.display = 'none';
            } else {
                buttonSlide2.style.display = 'block';
                buttonSlide3.style.display = 'block';
            }

            for (var i = 0; i < 15; i++) {
                var feedbackComment = $('#feedbackComment' + (i + 1));
                var customerName = $('#customerName' + (i + 1));
                var stars = $('#stars' + (i + 1));
                var time = $('#time' + (i + 1));

                // Remove any existing thumb icon
                feedbackComment.prev('i').remove();

                if (i < data.length) {
                    var item = data[i];
                    feedbackComment.text(item.FeedbackComments);
                    customerName.text(item.CustomerName);

                    // Create and update the thumb icon based on the rating
                    let thumbIcon = $('<i class="fas fa-thumbs-up me-2"></i>');
                    if (item.Rating === 5) {
                        thumbIcon.addClass('greenn_like_thum');
                    } else if (item.Rating === 4) {
                        thumbIcon.addClass('yelloww_like_thum');
                    } else if (item.Rating === 3) {
                        thumbIcon.addClass('orange_like_thum');
                    } else if (item.Rating === 2) {
                        thumbIcon.addClass('blue_like_thum');
                    } else if (item.Rating === 1) {
                        thumbIcon.addClass('red_like_thum');
                    } else {
                        thumbIcon.addClass('like_thum'); // Default color for other cases
                    }

                    // Append the new thumb icon
                    feedbackComment.before(thumbIcon);

                    // Update the stars
                    let htmlstar = starhtml(item.Rating);
                    stars.empty();
                    stars.append(htmlstar);

                    // Update the time
                    let timeDiff = timeDifference(item.ClosedDate);
                    time.empty();
                    time.append(timeDiff);
                } else {
                    feedbackComment.text('');
                    customerName.text('');
                    stars.empty();
                    time.empty();
                }
            }
            return data;
        }

        //END




        //FUNCTION TO FIND OUT FEEDBACK SUBMITTED TIME IN (WHILE AGO FASHION)
        function timeDifference(previous) {
            let now = new Date();

            const msPerMinute = 60 * 1000;
            const msPerHour = msPerMinute * 60;
            const msPerDay = msPerHour * 24;
            const msPerMonth = msPerDay * 30;
            const msPerYear = msPerDay * 365;

            if (typeof previous === "string") {
                previous = new Date(previous);
            }

            let elapsed = now - previous;

            if (elapsed < msPerMinute) {
                return Math.round(elapsed / 1000) + ' seconds ago';
            } else if (elapsed < msPerHour) {
                return Math.round(elapsed / msPerMinute) + ' minutes ago';
            } else if (elapsed < msPerDay) {
                return Math.round(elapsed / msPerHour) + ' hours ago';
            } else if (elapsed < msPerMonth) {
                return Math.round(elapsed / msPerDay) + ' days ago';
            } else if (elapsed < msPerYear) {
                return Math.round(elapsed / msPerMonth) + ' months ago';
            } else {
                return Math.round(elapsed / msPerYear) + ' years ago';
            }
        }
        //END




        //FUNCTION FOR STAR HTML APPENDATION
        function starhtml(id) {
            if (id == 5) {
                return `
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>`;
            } else if (id == 4) {
                return `
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>
            <span class="rating_Fstar"><i class="far fa-star"></i></span>`;
            } else if (id == 3) {
                return `
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>
            <span class="rating_Fstar"><i class="far fa-star"></i></span>
            <span class="rating_Fstar"><i class="far fa-star"></i></span>`;
            } else if (id == 2) {
                return `
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>
            <span class="rating_Fstar"><i class="far fa-star"></i></span>
            <span class="rating_Fstar"><i class="far fa-star"></i></span>
            <span class="rating_Fstar"><i class="far fa-star"></i></span>`;
            } else {
                return `
            <span class="rating_Fstar"><i class="fas fa-star"></i></span>
            <span class="rating_Fstar"><i class="far fa-star"></i></span>
            <span class="rating_Fstar"><i class="far fa-star"></i></span>
            <span class="rating_Fstar"><i class="far fa-star"></i></span>
            <span class="rating_Fstar"><i class="far fa-star"></i></span>`;
            }
        }
        //END



        //OFFCANVAS DIFFERENT APPROACH USING DATATABLE FOR UNASSIGNED TICKETS
        function GetUnassignedTicketsDetails() {


            $("#tbl_TicketsDetails_Unassigned").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_Unassigned").empty();

            let DId = $('#ddl_DeptFilter_Unassigned_ID').val();
            let CId = $('#ddl_CustFilter_Unassigned_ID').val();
            var Parameters = {
                Id: DId,
                CustomerName: CId
            }

            var strResult = AJAXCallWithResult("api/HRM_Management_Dashboard/GetUnassignedTicketsByDepartmentForOffcanvas", Parameters, false);

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
                        ${strResult[i].CustomerName}
                    </td>
                    <td>
                        ${formatDate(strResult[i].SubmittedDate)}
                    </td>
                    <td>${strResult[i].LastUpdatedDate ? formatDate(strResult[i].LastUpdatedDate) : ''}</td>
                    <td>${strResult[i].ExpectedResolvedDate ? formatDate(strResult[i].ExpectedResolvedDate) : ''}</td>
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
                           ${strResult[i].AssignToName || ''}
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
                });

            }
            else {
                return;
            }
        }

        function GetUnassignedTicketsDetailsInitially() {

            $('#ddl_DeptFilter_Unassigned_ID').val(deptID);


            $("#tbl_TicketsDetails_Unassigned").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_Unassigned").empty();

            let DId = deptID || -1;
            let CId = $('#ddl_CustFilter_Unassigned_ID').val();
            var Parameters = {
                Id: DId,
                CustomerName: CId
            }

            var strResult = AJAXCallWithResult("api/HRM_Management_Dashboard/GetUnassignedTicketsByDepartmentForOffcanvas", Parameters, false);

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
                        ${strResult[i].CustomerName}
                    </td>
                    <td>
                        ${formatDate(strResult[i].SubmittedDate)}
                    </td>
                    <td>${strResult[i].LastUpdatedDate ? formatDate(strResult[i].LastUpdatedDate) : ''}</td>
                    <td>${strResult[i].ExpectedResolvedDate ? formatDate(strResult[i].ExpectedResolvedDate) : ''}</td>
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
                           ${strResult[i].AssignToName || ''}
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
                });

            }
            else {
                return;
            }
        }

        function resetUnassignedTicketsDetails() {


            $('#ddl_DeptFilter_Unassigned_ID').prop('selectedIndex', 0);
            $('#ddl_CustFilter_Unassigned_ID').prop('selectedIndex', 0);

            GetUnassignedTicketsDetailsInitially();
        }

        function formatDate(strDate) {

            var date = new Date(strDate);

            var day = date.getDate();
            var month = date.toLocaleString('en-us', { month: 'short' });
            var year = date.getFullYear();

            return `${day} ${month} ${year}`;
        }
        //ENF OF DATATABLE APPROACH FOR UNASSIGNED TICKETS



       //OFFCANVAS DIFFERENT APPROACH USING DATATABLE FOR OPEN TICKETS AND CUSTOMER TICKETS OPEN

        function GetOpenTicketsDetails() {
            $("#tbl_TicketsDetails_Open").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_Open").empty();

            let DId = $('#ddl_DeptFilter_Open_ID').val();
            let CId = $('#ddl_CustFilter_Open_ID').val();
            var Parameters = {
                Id: DId,
                CustomerName: CId
            };

            var strResult = AJAXCallWithResult("api/HRM_Management_Dashboard/GetOpenTicketsByDepartmentForOffcanvas", Parameters, false);

            if (strResult != undefined) {
                var newrow = "";

                for (var i = 0; i < strResult.length; i++) {
                    newrow += `<tr>
                <td>${strResult[i].QueryID}</td>
                <td>${strResult[i].Subject}</td>
                <td>${strResult[i].RequestType}</td>
                <td>${strResult[i].Priority}</td>
                <td>${strResult[i].CustomerID}</td>
                <td>${strResult[i].CustomerName}</td>
                <td>${formatDate(strResult[i].SubmittedDate)}</td>
                 <td>${strResult[i].LastUpdatedDate ? formatDate(strResult[i].LastUpdatedDate) : ''}</td>
                 <td>${strResult[i].ExpectedResolvedDate ? formatDate(strResult[i].ExpectedResolvedDate) : ''}</td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">
                        <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                        <a href="javascript:;">
                            <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                        </a>
                    </div>
                </td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">${strResult[i].AssignToName || ''}</div>
                </td>
            </tr>`;
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
                    "info": false
                });
            } else {
                return;
            }
        }


        function GetOpenTicketsDetailsInitially() {

            $('#ddl_DeptFilter_Open_ID').val(deptID);

            $("#tbl_TicketsDetails_Open").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_Open").empty();

            let DId = deptID || -1;
            let CId = $('#ddl_CustFilter_Open_ID').val();
            var Parameters = {
                Id: DId,
                CustomerName: CId
            };

            var strResult = AJAXCallWithResult("api/HRM_Management_Dashboard/GetOpenTicketsByDepartmentForOffcanvas", Parameters, false);

            if (strResult != undefined) {
                var newrow = "";

                for (var i = 0; i < strResult.length; i++) {
                    newrow += `<tr>
                <td>${strResult[i].QueryID}</td>
                <td>${strResult[i].Subject}</td>
                <td>${strResult[i].RequestType}</td>
                <td>${strResult[i].Priority}</td>
                <td>${strResult[i].CustomerID}</td>
                <td>${strResult[i].CustomerName}</td>
                <td>${formatDate(strResult[i].SubmittedDate)}</td>
                <td>${strResult[i].LastUpdatedDate ? formatDate(strResult[i].LastUpdatedDate) : ''}</td>
                <td>${strResult[i].ExpectedResolvedDate ? formatDate(strResult[i].ExpectedResolvedDate) : ''}</td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">
                        <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                        <a href="javascript:;">
                            <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                        </a>
                    </div>
                </td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">${strResult[i].AssignToName || ''}</div>
                </td>
            </tr>`;
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
                    "info": false
                });
            } else {
                return;
            }
        }


        function resetOpenTicketsDetails() {
            $('#ddl_DeptFilter_Open_ID').prop('selectedIndex', 0);
            $('#ddl_CustFilter_Open_ID').prop('selectedIndex', 0);
            GetOpenTicketsDetailsInitially();
        }


        function resetCustomerOpenTicketsDetails() {
            $('#ddl_DeptFilter_CustomerOpen_ID').prop('selectedIndex', 0);
            $('#ddl_CustFilter_CustomerOpen_ID').prop('selectedIndex', 0);
            GetCustomerOpenTicketsInitially();
        }

        function GetCustomerOpenTicketsInitially() {

            $('#ddl_DeptFilter_CustomerOpen_ID').val(deptID);
            $('#ddl_CustFilter_CustomerOpen_ID').val(firstCustomerIDForCTO);

            $("#tbl_TicketsDetails_CustomerOpen").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_CustomerOpen").empty();

            let DId = deptID || -1;
            let CId = firstCustomerIDForCTO;
            var Parameters = {
                Id: DId,
                CustomerName: CId
            };

            var strResult = AJAXCallWithResult("api/HRM_Management_Dashboard/GetOpenTicketsByDepartmentForOffcanvas", Parameters, false);
            
            if (strResult != undefined) {
                var newrow = "";

                for (var i = 0; i < strResult.length; i++) {
                    newrow += `<tr>
             <td>${strResult[i].QueryID}</td>
             <td>${strResult[i].Subject}</td>
             <td>${strResult[i].RequestType}</td>
             <td>${strResult[i].Priority}</td>
             <td>${strResult[i].CustomerID}</td>
             <td>${strResult[i].CustomerName}</td>
             <td>${formatDate(strResult[i].SubmittedDate)}</td>
             <td>${strResult[i].LastUpdatedDate ? formatDate(strResult[i].LastUpdatedDate) : ''}</td>
             <td>${strResult[i].ExpectedResolvedDate ? formatDate(strResult[i].ExpectedResolvedDate) : ''}</td>

             <td>
                 <div class="statusDiv d-flex justify-content-start">
                     <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                     <a href="javascript:;">
                         <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                     </a>
                 </div>
             </td>
             <td>
                 <div class="statusDiv d-flex justify-content-start">${strResult[i].AssignToName || ''}</div>
             </td>
         </tr>`;
                }
                $("#offcanvasDynamicAppendData_CustomerOpen").append(newrow);
                $('#tbl_TicketsDetails_CustomerOpen').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "bAutoWidth": false,
                    "info": false
                });
            } else {
                return;
            }
        }

        function GetCustomerOpenTicketsDetails() {
            $("#tbl_TicketsDetails_CustomerOpen").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_CustomerOpen").empty();

            let DId = $('#ddl_DeptFilter_CustomerOpen_ID').val();
            let CId = $('#ddl_CustFilter_CustomerOpen_ID').val();

            let DidsString = '';
            if (DId == 0) {
                let allIds = [];
                $('#ddl_DeptFilter_CustomerOpen_ID option').each(function () {
                    allIds.push($(this).val());
                });
                DidsString = allIds.join(',');
            } else {
                DidsString = DId;
            }

            let CidsString = '';
            if (CId == 'Select Customer') {
                let allIds = [];
                for (let i = 1; i < uniqueCustomers.length; i++) {
                    allIds.push(uniqueCustomers[i].CustomerID);
                }
                CidsString = allIds.join(',');
            } else {
                CidsString = CId;
            }

            var Parameters = {
                DepartmentName: DidsString,
                CustomerName: CidsString 
            };
            var strResult = AJAXCallWithResult("api/HRM_Management_Dashboard/FilterCustomeOpenTicket", Parameters, false);


            if (strResult != undefined) {
                var newrow = "";

                for (var i = 0; i < strResult.length; i++) {
                    newrow += `<tr>
         <td>${strResult[i].QueryID}</td>
         <td>${strResult[i].Subject}</td>
         <td>${strResult[i].RequestType}</td>
         <td>${strResult[i].Priority}</td>
         <td>${strResult[i].CustomerID}</td>
         <td>${strResult[i].CustomerName}</td>
         <td>${formatDate(strResult[i].SubmittedDate)}</td>
          <td>${strResult[i].LastUpdatedDate ? formatDate(strResult[i].LastUpdatedDate) : ''}</td>
          <td>${strResult[i].ExpectedResolvedDate ? formatDate(strResult[i].ExpectedResolvedDate) : ''}</td>
         <td>
             <div class="statusDiv d-flex justify-content-start">
                 <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                 <a href="javascript:;">
                     <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                 </a>
             </div>
         </td>
         <td>
             <div class="statusDiv d-flex justify-content-start">${strResult[i].AssignToName || ''}</div>
         </td>
     </tr>`;
                }
                $("#offcanvasDynamicAppendData_CustomerOpen").append(newrow);
                $('#tbl_TicketsDetails_CustomerOpen').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "bAutoWidth": false,
                    "info": false
                });
            } else {
                return;
            }
        }

       //ENF OF DATATABLE APPROACH FOR OPEN TICKETS



        //OFFCANVAS DIFFERENT APPROACH USING DATATABLE FOR CR TICKETS
         function GetCRTicketsDetails() {
            $("#tbl_TicketsDetails_CR").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_CR").empty();

            let DId = $('#ddl_DeptFilter_CR_ID').val();
            let CId = $('#ddl_CustFilter_CR_ID').val();
            var Parameters = {
                Id: DId,
                CustomerName: CId
            };

            var strResult = AJAXCallWithResult("api/HRM_Management_Dashboard/GetCRTicketsByDepartmentForOffcanvas", Parameters, false);
            if (strResult != undefined) {
                var newrow = "";

                for (var i = 0; i < strResult.length; i++) {
                    newrow += `<tr>
                <td>${strResult[i].QueryID}</td>
                <td>${strResult[i].Subject}</td>
                <td>${strResult[i].RequestType}</td>
                <td>${strResult[i].Priority}</td>
                <td>${strResult[i].CustomerID}</td>
                <td>${strResult[i].CustomerName}</td>
                <td>${formatDate(strResult[i].SubmittedDate)}</td>
                <td>${strResult[i].LastUpdatedDate ? formatDate(strResult[i].LastUpdatedDate) : ''}</td>
                <td>${strResult[i].ExpectedResolvedDate ? formatDate(strResult[i].ExpectedResolvedDate) : ''}</td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">
                        <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                        <a href="javascript:;">
                            <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                        </a>
                    </div>
                </td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">${strResult[i].AssignToName || ''}</div>
                </td>
            </tr>`;
                }
                $("#offcanvasDynamicAppendData_CR").append(newrow);
                $('#tbl_TicketsDetails_CR').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "bAutoWidth": false,
                    "info": false
                });
            } else {
                return;
            }
        }


        function GetCRTicketsDetailsInitially() {
            $('#ddl_DeptFilter_CR_ID').val(deptID);
            $("#tbl_TicketsDetails_CR").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_CR").empty();

            let DId = deptID || -1;
            let CId = $('#ddl_CustFilter_CR_ID').val();
            var Parameters = {
                Id: DId,
                CustomerName: CId
            };

            var strResult = AJAXCallWithResult("api/HRM_Management_Dashboard/GetCRTicketsByDepartmentForOffcanvas", Parameters, false);

            if (strResult != undefined) {
                var newrow = "";

                for (var i = 0; i < strResult.length; i++) {
                    newrow += `<tr>
                <td>${strResult[i].QueryID}</td>
                <td>${strResult[i].Subject}</td>
                <td>${strResult[i].RequestType}</td>
                <td>${strResult[i].Priority}</td>
                <td>${strResult[i].CustomerID}</td>
                <td>${strResult[i].CustomerName}</td>
                <td>${formatDate(strResult[i].SubmittedDate)}</td>
                <td>${strResult[i].LastUpdatedDate ? formatDate(strResult[i].LastUpdatedDate) : ''}</td>
                <td>${strResult[i].ExpectedResolvedDate ? formatDate(strResult[i].ExpectedResolvedDate) : ''}</td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">
                        <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                        <a href="javascript:;">
                            <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                        </a>
                    </div>
                </td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">${strResult[i].AssignToName || ''}</div>
                </td>
            </tr>`;
                }
                $("#offcanvasDynamicAppendData_CR").append(newrow);
                $('#tbl_TicketsDetails_CR').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "bAutoWidth": false,
                    "info": false
                });
            } else {
                return;
            }
        }


        function resetCRTicketsDetails() {
            $('#ddl_DeptFilter_CR_ID').prop('selectedIndex', 0);
            $('#ddl_CustFilter_CR_ID').prop('selectedIndex', 0);
            GetCRTicketsDetailsInitially();
        }

       //END OF DATATABLE APPROACH FOR OPEN TICKETS



        //OFFCANVAS DIFFERENT APPROACH USING DATATABLE FOR Top TICKETS
        function GetTopTicketsDetails() {
            $("#tbl_TicketsDetails_Top").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_Top").empty();

            let DId = $('#ddl_DeptFilter_Top_ID').val();
            let CId = $('#ddl_CustFilter_Top_ID').val();
            var Parameters = {
                Id: DId,
                CustomerName: CId
            };

            var strResult = AJAXCallWithResult("api/HRM_Management_Dashboard/GetTopPriorityTicketsByDepartmentForOffcanvas", Parameters, false);

            if (strResult != undefined) {
                var newrow = "";

                for (var i = 0; i < strResult.length; i++) {
                    newrow += `<tr>
                <td>${strResult[i].QueryID}</td>
                <td>${strResult[i].Subject}</td>
                <td>${strResult[i].RequestType}</td>
                <td>${strResult[i].Priority}</td>
                <td>${strResult[i].CustomerID}</td>
                <td>${strResult[i].CustomerName}</td>
                <td>${formatDate(strResult[i].SubmittedDate)}</td>
                <td>${strResult[i].LastUpdatedDate ? formatDate(strResult[i].LastUpdatedDate) : ''}</td>
                <td>${strResult[i].ExpectedResolvedDate ? formatDate(strResult[i].ExpectedResolvedDate) : ''}</td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">
                        <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                        <a href="javascript:;">
                            <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                        </a>
                    </div>
                </td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">${strResult[i].AssignToName || ''}</div>
                </td>
            </tr>`;
                }
                $("#offcanvasDynamicAppendData_Top").append(newrow);
                $('#tbl_TicketsDetails_Top').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "bAutoWidth": false,
                    "info": false
                });
            } else {
                return;
            }
        }

        function GetTopTicketsDetailsInitially() {
            $('#ddl_DeptFilter_Top_ID').val(deptID);
            $("#tbl_TicketsDetails_Top").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_Top").empty();

            let DId = deptID || -1;
            let CId = $('#ddl_CustFilter_Top_ID').val();
            var Parameters = {
                Id: DId,
                CustomerName: CId
            };

            var strResult = AJAXCallWithResult("api/HRM_Management_Dashboard/GetTopPriorityTicketsByDepartmentForOffcanvas", Parameters, false);

            if (strResult != undefined) {
                var newrow = "";

                for (var i = 0; i < strResult.length; i++) {
                    newrow += `<tr>
                <td>${strResult[i].QueryID}</td>
                <td>${strResult[i].Subject}</td>
                <td>${strResult[i].RequestType}</td>
                <td>${strResult[i].Priority}</td>
                <td>${strResult[i].CustomerID}</td>
                <td>${strResult[i].CustomerName}</td>
                <td>${formatDate(strResult[i].SubmittedDate)}</td>
                <td>${strResult[i].LastUpdatedDate ? formatDate(strResult[i].LastUpdatedDate) : ''}</td>
                <td>${strResult[i].ExpectedResolvedDate ? formatDate(strResult[i].ExpectedResolvedDate) : ''}</td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">
                        <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                        <a href="javascript:;">
                            <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                        </a>
                    </div>
                </td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">${strResult[i].AssignToName || ''}</div>
                </td>
            </tr>`;
                }
                $("#offcanvasDynamicAppendData_Top").append(newrow);
                $('#tbl_TicketsDetails_Top').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "bAutoWidth": false,
                    "info": false
                });
            } else {
                return;
            }
        }

        function resetTopTicketsDetails() {
            $('#ddl_DeptFilter_Top_ID').prop('selectedIndex', 0);
            $('#ddl_CustFilter_Top_ID').prop('selectedIndex', 0);
            GetTopTicketsDetailsInitially();
        }
        //END OF DATATABLE APPROACH FOR OPEN TICKETS



        //OFFCANVAS DIFFERENT APPROACH USING DATATABLE FOR Top TICKETS
        function GetLoTicketsDetails() {
            $("#tbl_TicketsDetails_Lo").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_Lo").empty();

            let DId = $('#ddl_DeptFilter_Lo_ID').val();
            let CId = $('#ddl_CustFilter_Lo_ID').val();

            var Parameters = {
                Id: DId,
                CustomerName: CId,
                FromDate: currentWeekDates[0],
                ToDate: currentWeekDates[currentWeekDates.length - 1]
            };

            let strResult = AJAXCallWithResult("api/HRM_Management_Dashboard/GetLatestOpenTicketsByDepartmentForOffcanvas", Parameters, false);

            if (strResult != undefined) {
                var newrow = "";

                for (var i = 0; i < strResult.length; i++) {
                    newrow += `<tr>
                <td>${strResult[i].QueryID}</td>
                <td>${strResult[i].Subject}</td>
                <td>${strResult[i].RequestType}</td>
                <td>${strResult[i].Priority}</td>
                <td>${strResult[i].CustomerID}</td>
                <td>${strResult[i].CustomerName}</td>
                <td>${formatDate(strResult[i].SubmittedDate)}</td>
                <td>${strResult[i].LastUpdatedDate ? formatDate(strResult[i].LastUpdatedDate) : ''}</td>
                <td>${strResult[i].ExpectedResolvedDate ? formatDate(strResult[i].ExpectedResolvedDate) : ''}</td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">
                        <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                        <a href="javascript:;">
                            <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                        </a>
                    </div>
                </td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">${strResult[i].AssignToName || ''}</div>
                </td>
            </tr>`;
                }
                $("#offcanvasDynamicAppendData_Lo").append(newrow);
                $('#tbl_TicketsDetails_Lo').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "bAutoWidth": false,
                    "info": false
                });
            } else {
                return;
            }
        }

        function GetLoTicketsDetailsInitially() {
            $('#ddl_DeptFilter_Lo_ID').val(deptID);
            $("#tbl_TicketsDetails_Lo").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_Lo").empty();

            let DId = deptID || -1;
            let CId = $('#ddl_CustFilter_Lo_ID').val();

            var Parameters = {
                Id: DId,
                CustomerName: CId,
                FromDate: currentWeekDates[0],
                ToDate: currentWeekDates[currentWeekDates.length - 1]
            };

            let strResult = AJAXCallWithResult("api/HRM_Management_Dashboard/GetLatestOpenTicketsByDepartmentForOffcanvas", Parameters, false);

            if (strResult != undefined) {
                var newrow = "";

                for (var i = 0; i < strResult.length; i++) {
                    newrow += `<tr>
                <td>${strResult[i].QueryID}</td>
                <td>${strResult[i].Subject}</td>
                <td>${strResult[i].RequestType}</td>
                <td>${strResult[i].Priority}</td>
                <td>${strResult[i].CustomerID}</td>
                <td>${strResult[i].CustomerName}</td>
                <td>${formatDate(strResult[i].SubmittedDate)}</td>
                <td>${strResult[i].LastUpdatedDate ? formatDate(strResult[i].LastUpdatedDate) : ''}</td>
                <td>${strResult[i].ExpectedResolvedDate ? formatDate(strResult[i].ExpectedResolvedDate) : ''}</td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">
                        <span class="statusBox statusRejected mx-2 mt-1">&nbsp;</span>
                        <a href="javascript:;">
                            <label class="crsrLink" data-bs-toggle="tooltip" data-bs-original-title="Open">${strResult[i].Status}</label>
                        </a>
                    </div>
                </td>
                <td>
                    <div class="statusDiv d-flex justify-content-start">${strResult[i].AssignToName || ''}</div>
                </td>
            </tr>`;
                }
                $("#offcanvasDynamicAppendData_Lo").append(newrow);
                $('#tbl_TicketsDetails_Lo').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": false,
                    "retrieve": true,
                    "bAutoWidth": false,
                    "info": false
                });
            } else {
                return;
            }
        }

        function resetLoTicketsDetails() {
            $('#ddl_DeptFilter_Lo_ID').prop('selectedIndex', 0);
            $('#ddl_CustFilter_Lo_ID').prop('selectedIndex', 0);
            GetLoTicketsDetailsInitially();
        }
        //END OF DATATABLE APPROACH FOR OPEN TICKETS




        
        //OFFCANVAS DIFFERENT APPROACH USING DATATABLE FOR Employee ONLINE

        function EmployeeOnLineDetailsInitially() {
            $("#tbl_leaveDetails").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_LeaveEmployee").empty();
            $('#ddl_EmpFilter_Online_ID').val('Select Employee');

            let strResult = EmployeeOnline[0]; // Assuming EmployeeOnline is an array with one element containing the data array

            if (strResult !== undefined && strResult.length > 0) {
                var newrow = "";

                for (var i = 0; i < strResult.length; i++) {
                    newrow += `<tr>
                <td>${strResult[i].EmployeeName}</td>
                <td>${strResult[i].EmailID}</td>
                <td>${strResult[i].Telephone || ''}</td>
                <td>${strResult[i].FromDate ? formatDate(strResult[i].FromDate) : ''}</td>
                <td>${strResult[i].ToDate ? formatDate(strResult[i].ToDate) : ''}</td>
                <td>${strResult[i].LeaveStatus}</td>
                <td>${strResult[i].NoOfLeaves || ''}</td>
                <td>${strResult[i].LeaveBalance || ''}</td>
            </tr>`;
                }

                $("#offcanvasDynamicAppendData_LeaveEmployee").append(newrow);
               
            } 
            $('#tbl_leaveDetails').dataTable({
                "paging": true,
                "pageLength": 10,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": true,
                "retrieve": true,
                "bAutoWidth": false,
                "info": false
            });
        }

        function EmployeeOnLineDetails(selectedEmployeeName) {
            $("#tbl_leaveDetails").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_LeaveEmployee").empty();

            let strResult = EmployeeOnline[0]; // Assuming EmployeeOnline is an array with one element containing the data array

            if (strResult !== undefined && strResult.length > 0) {
                var filteredResult = selectedEmployeeName === 'Select Employee' ? strResult : strResult.filter(function (employee) {
                    return employee.EmployeeName === selectedEmployeeName;
                });

                var newrow = "";

                for (var i = 0; i < filteredResult.length; i++) {
                    newrow += `<tr>
                <td>${filteredResult[i].EmployeeName}</td>
                <td>${filteredResult[i].EmailID}</td>
                <td>${filteredResult[i].Telephone || ''}</td>
                <td>${filteredResult[i].FromDate ? formatDate(filteredResult[i].FromDate) : ''}</td>
                <td>${filteredResult[i].ToDate ? formatDate(filteredResult[i].ToDate) : ''}</td>
                <td>${filteredResult[i].LeaveStatus}</td>
                <td>${filteredResult[i].NoOfLeaves || ''}</td>
                <td>${filteredResult[i].LeaveBalance || ''}</td>
            </tr>`;
                }

                $("#offcanvasDynamicAppendData_LeaveEmployee").append(newrow); 
            }
            $('#tbl_leaveDetails').dataTable({
                "paging": true,
                "pageLength": 10,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bAutoWidth": false,
                "info": false
            });
        }

        //END OF DATATABLE APPROACH FOR EMPLOYEE ONLINE


        //OFFCANVAS DIFFERENT APPROACH FOR EMPLOYEE ON LEAVE

        function EmployeeOnLeaveeDetailsInitially() {
            $("#tbl_leaveDetails2").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_LeaveEmployee2").empty();
            $('#ddl_EmpFilter_Leave_ID').val('Select Employee');

            let strResult = EmployeeOnLeave[0]; // Assuming EmployeeOnline is an array with one element containing the data array

            if (strResult !== undefined && strResult.length > 0) {
                var newrow = "";

                for (var i = 0; i < strResult.length; i++) {
                    newrow += `<tr>
                <td>${strResult[i].EmployeeName}</td>
                <td>${strResult[i].EmailID}</td>
                <td>${strResult[i].Telephone || ''}</td>
                <td>${strResult[i].FromDate ? formatDate(strResult[i].FromDate) : ''}</td>
                <td>${strResult[i].ToDate ? formatDate(strResult[i].ToDate) : ''}</td>
                <td>${strResult[i].LeaveStatus}</td>
                <td>${strResult[i].NoOfLeaves || ''}</td>
                <td>${strResult[i].LeaveBalance || ''}</td>
            </tr>`;
                }

                $("#offcanvasDynamicAppendData_LeaveEmployee2").append(newrow);
               
            }
            $('#tbl_leaveDetails2').dataTable({
                "paging": true,
                "pageLength": 10,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": true,
                "retrieve": true,
                "bAutoWidth": false,
                "info": false
            });
        }

        function EmployeeOnLeaveDetails(selectedEmployeeName) {
            $("#tbl_leaveDetails2").dataTable().fnDestroy();
            $("#offcanvasDynamicAppendData_LeaveEmployee2").empty();

            let strResult = EmployeeOnLeave[0]; // Assuming EmployeeOnline is an array with one element containing the data array
            if (strResult !== undefined && strResult.length > 0) {
                var filteredResult = selectedEmployeeName === 'Select Employee' ? strResult : strResult.filter(function (employee) {
                    return employee.EmployeeName === selectedEmployeeName;
                });

                var newrow = "";

                for (var i = 0; i < filteredResult.length; i++) {
                    newrow += `<tr>
                <td>${filteredResult[i].EmployeeName}</td>
                <td>${filteredResult[i].EmailID}</td>
                <td>${filteredResult[i].Telephone || ''}</td>
                <td>${filteredResult[i].FromDate ? formatDate(filteredResult[i].FromDate) : ''}</td>
                <td>${filteredResult[i].ToDate ? formatDate(filteredResult[i].ToDate) : ''}</td>
                <td>${filteredResult[i].LeaveStatus}</td>
                <td>${filteredResult[i].NoOfLeaves || ''}</td>
                <td>${filteredResult[i].LeaveBalance || ''}</td>
            </tr>`;
                }

                $("#offcanvasDynamicAppendData_LeaveEmployee2").append(newrow);
            }
            $('#tbl_leaveDetails2').dataTable({
                "paging": true,
                "pageLength": 10,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": true,
                "retrieve": true,
                "bAutoWidth": false,
                "info": false
            });
        }
        //END OF DATATABLE APPROACH FOR EMPLOYEE ON LEAVE 

    </script>
</body>  
</html>
