<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmReleaseMonitoring.aspx.vb" Inherits="Whizible.frmReleaseMonitoring" %> 

<!DOCTYPE html>
<html>
             <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("Project Dashboard")%>
<head id="Head1" runat="server">
  <%--  <title></title>
    <meta name='GENERATOR' content='Microsoft Visual Studio.NET 7.0' />
    <meta name='CODE_LANGUAGE' content='Visual Basic 7.0' />
    <meta name='vs_defaultClientScript' content='JavaScript' />
    <meta http-equiv="Cache-Control" content="no-cache" />
    <meta http-equiv="Pragma" content="no-cache/" />

    <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link href="../../Whizible2.0-new/dist/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="../../Whizible2.0-new/fontawesome/css/all.css" rel="stylesheet" />--%>
    <link href="../../Whizible2.0-new/dist/css/sb-admin.css" rel="stylesheet" />
   <%-- <link href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <link href="css/ReleasePlanning.css?v=1.6" rel="stylesheet" />
    <link href="css/Release_Monitoring.css?v=2.2" rel="stylesheet" />   
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/updated_versions.css" />

    <script src="../General/CommonFunctions.js"></script>
  <%--  <script src="../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
    <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>  
    <script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
    <script src="js/autosize.js"></script>
    <script src="js/CommonJS.js?v=1"></script>
   <%-- <script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
    <script src="../../Whizible2.0-new/dist/js/timepicker.min.js"></script>
<%--    <script src="../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>    
<%--    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>    
    <script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
 

</head>
        <style>
        /*Added By Yasmin on 11-3-19*/
        .searchbox {
            background: #fff !important;
            width: 208px !important;
            margin-right: 8px !important;
            display: inline-flex !important;
            margin-top: 0px;
        }

        #ulFilters {
            margin-left: -130px !important;
            margin-top: 18px !important;
            min-width: 160px !important;
           /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
            font-size: 11.5px !important;
        }

        .fa-filter {
            margin-top: 4px !important;
        }

        #BurnDown {
            margin-top: 20px;
        }

        .dropdown-menu {
            min-width: 110px !important;
        }

            .dropdown-menu li {
                margin-top: 0px !important;
            }

        #DivAttachmentList #DataTables_Table_10 {
            width: 98.9% !important;
        }

        #txtSearchRelease {
            box-shadow: none !important;
            width: 100% !important;
            border: none !important;
            border-bottom: none !important;
            text-align: left;
            height: 32px;
            font-weight: 100;
            margin-left: 0px !important;
        }

        .FilterUs, .FilterUS {
            float: right;
            width: 250px !important;
            margin-top: 10px;
            margin-right: 30px;
            margin-bottom: 0px;
        }

            .FilterUs .form-control, .FilterUS .form-control {
                border: none !important;
            }

            .FilterUs .input-group, .FilterUS .input-group {
                border-bottom: 1px solid #ddd;
                margin-right: 65px;
            }
        /*Added by Usha Pandit on 06 june 2018 for hiding scroll bar for history  grid*/
        #DivHistorykList, #divhistoryList {
            -ms-scrollbar-arrow-color: white !important;
            -ms-scrollbar-base-color: white !important;
            -ms-scrollbar-shadow-color: white !important;
        }

        /*Commented By Yasmin on 11-3-19*/
        #Sprints {
            height: 500px !important;
            /*width: 102% !important;*/
        }
        /*Commented By Yasmin on 11-3-19*/

        #div1.clsBox {
            height: 500px !important;
            /*width: 102% !important;*/
        }

        #Teams.clsBox {
            height: 500px !important;
            /*width: 102% !important;*/
        }

        #Tasks.clsBox {
            height: 500px !important;
            /*width: 102% !important;*/
        }

        #div6.clsBox {
            height: 500px !important;
            /*width: 102% !important;*/
        }

        #div2.clsBox {
            height: 500px !important;
            /*width: 102% !important;*/
        }

        #div9.clsBox {
            height: 500px !important;
            margin-bottom: 50px;
            /*width: 102% !important;*/
        }

        #ImpedimentsLogs.clsBox {
            height: 500px !important;
            /*width: 102% !important;*/
        }

        #Risks.clsBox {
            height: 500px !important;
            /*width: 102% !important;*/
        }

        #History.clsBox {
            height: 500px !important;
            width: 102% !important;
        }

        #div3.clsBox {
            height: 500px !important;
            /*width: 102% !important;*/
        }

        #divAttachments.clsBox {
            height: 500px !important;
            /*width: 102% !important;*/
        }
        /*End of Added by Usha Pandit on 06 june 2018 for hiding scroll bar for history  grid*/
        textarea {
            resize: both !important;
        }

        #divReleases table {
            border-spacing: 0 1em !important;
            border-collapse: separate !important;
        }

        .align-right {
            text-align: right;
        }

        #txtSearchRelease:focus {
            outline: none;
        }

        #divBtn {
            margin-top: -1%;
        }

        .releasetitle {
            color: #292828;
            font-weight: 500;
            font-size: 16px !important;
            margin-left: 30px;
            margin-top: 10px;
        }
        /*.fa-search {
            float: right !important;
            position: absolute !important;
            right: 158px !important;
        }*/
        .badge {
            display: inline-block !important;
            min-width: 10px !important;
            padding: 3px 7px !important;
            /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
            font-size: 11.5px !important;
            font-weight: 700 !important;
            line-height: 1 !important;
            color: #fff !important;
            text-align: center !important;
            white-space: nowrap !important;
            vertical-align: middle !important;
            background-color: #777;
            border-radius: 10px !important;
            margin-top: -26px !important;
        }

        .dropdown-menu > li > a:hover, .filter-dropdown li:hover, .dropdown-menu > li > a:focus {
            color: #fff !important;
            text-decoration: none !important;
            background-color: #e1e3e9!important; /*modified by pradip on 6-10-2020*/
            color: #fff;
            cursor: pointer;
        }

        .open > .dropdown-menu {
            display: block;
            margin-top: 6px !important;
        }

        .filter-dropdown {
            clear: both !important;
            font-weight: 400 !important;
            line-height: 1.42857143 !important;
            color: #333 !important;
            white-space: nowrap !important;
        }

        .table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
            padding: 6px !important;
            /* line-height: 1.42857143; */
            vertical-align: top;
            border-top: 1px solid #ddd;
        }

        @media (min-width: 992px) {
            .col-md-offset-7 {
                margin-left: 63% !important;
            }

            .team_cards {
                width: 46% !important;
            }

            .scrollspy-example.col-sm-9 {
                width: 70% !important;
                /*overflow:hidden !important; Added by Usha Pandit on 06 june 2018 for hiding scroll bar*/
            }
        }

        input[type="search"]:focus {
            outline: 0;
        }

        .badge {
            display: inline-block !important;
            min-width: 10px !important;
            padding: 3px 7px !important;
            /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
            font-size: 11.5px !important;
            font-weight: 700 !important;
            line-height: 1 !important;
            color: #fff !important;
            text-align: center !important;
            white-space: nowrap !important;
            vertical-align: middle !important;
            background-color: #777 !important;
            border-radius: 10px !important;
            margin-top: -26px !important;
        }

        .danger {
            background: red !important;
        }

        .complete {
            background: green !important;
        }

        .warning {
            background: orange !important;
        }

        .paginate_button .page-item previous {
            display: none !important;
        }

        .paginate_button .page-item next {
            display: none !important;
        }


        .clsDiscussion1 {
            font-size: 14px !important;
            padding-bottom: 4%;
            COLOR: #000 !important;
            border-bottom: 2px solid rgb(60, 141, 188) !important;
        }

            .clsDiscussion1 h2 {
                font-size: 14px !important;
                margin-left: -14px;
            }

        #divUserstories h5, #divTasks h5, #divIssues h5, #divReview h2, #divImpedimentsLogs h2, #divRisks h2, #divHistory h2 {
            font-size: 14px !important;
            margin-left: -3%;
            line-height: 2;
        }

        .clsDiscussion {
            /* background-color: #ddd; */
            height: 25px;
            /* margin-top: 0%; */
            /* padding-top: 1%; */
            line-height: 2;
            font-size: 14px !important;
            padding-bottom: 4%;
        }

        .SprintSeach {
            float: right;
            margin-right: 116px !important;
            margin-top: -38px;
            color: #4b4b4b !important;
        }

        .datepicker.dropdown-menu {
            display: grid;
            min-width: 262px !important;
        }

        .ui-datepicker {
            z-index: 99999 !important;
        }

        .datepicker-dropdown {
            margin-right: 53% !important;
        }

        .datepicker table {
            margin-bottom: 0px !important;
            border: none !important;
        }

            .datepicker table tr td, .datepicker table tr th {
                border: none !important;
            }

        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th {
            white-space: normal !important;
        }

        @media (min-width: 992px) {
            .col-md-offset-7 {
                margin-left: 63% !important;
            }

            .team_cards {
                width: 46% !important;
            }

            .scrollspy-example.col-sm-9 {
                width: 70% !important;
            }

            /*.SprintSeach {
                float: right;
                position: absolute;
                margin-right: 36px !important;
                margin-top: 11.5px;
                color: #4b4b4b !important;
                right: 103px;
            }*/
        }

        @media (max-width:1100px) {
            .details_tab {
                width: 98%;
            }
        }

        @media (max-width:991px) {
            .clsDiscussion {
                padding-bottom: 5% !important;
            }

            .table > thead > tr > th, .table > tbody > tr > th, .table > tfoot > tr > th, .table > thead > tr > td, .table > tbody > tr > td, .table > tfoot > tr > td {
                font-size: 11px !important;
            }

            .SprintSeach {
                float: right;
                margin-right: 72px;
                margin-top: -38px;
                color: #4b4b4b !important;
            }

            .dataTables_sizing, tr td p span, tr td p {
                font-size: 11px !important;
            }
        }
        /*Added by Usha Pandit on 08 June 2018 for hiding scrollbar*/
        #DivCurrentSprintUS table tr td:nth-child(1) {
            width: 10% !important;
        }

        #DivCurrentSprintUS table tr td:nth-child(2) {
            width: 30% !important;
        }

        #DivCurrentSprintUS table tr td:nth-child(3) {
            width: 10% !important;
        }

        #DivCurrentSprintUS table tr td:nth-child(4) {
            width: 10% !important;
        }

        #DivCurrentSprintUS table tr td:nth-child(5) {
            width: 35% !important;
        }


        /*End of Added by Usha Pandit on 08 June 2018 for hiding scrollbar*/
        /*Added By Ankush T on 08/06/2018 for sprint name to be wrap*/
        #DivNoTMappedSprintlist table tr td:nth-child(1) {
            width: 10% !important;
        }

        #DivNoTMappedSprintlist table tr td:nth-child(2) {
            width: 30% !important;
        }

        #DivNoTMappedSprintlist table tr td:nth-child(3) {
            width: 15% !important;
        }

        #DivNoTMappedSprintlist table tr td:nth-child(4) {
            width: 10% !important;
        }

        /*End By Ankush T on 08/06/2018 for sprint name to be wrap*/


        /*Added By Ankush T on 08/06/2018 for task name to be wrap*/
        #DivTaskList table tr td:nth-child(1) {
            width: 10% !important;
        }

        #DivTaskList table tr td:nth-child(2) {
            width: 30% !important;
        }

        #DivTaskList table tr td:nth-child(3) {
            width: 15% !important;
        }

        #DivTaskList table tr td:nth-child(4) {
            width: 15% !important;
        }

        #DivTaskList table tr td:nth-child(5) {
            width: 30% !important;
        }
        /*End By Ankush T on 08/06/2018 for task name to be wrap*/

        /*Added By Ankush T on 08/06/2018 for task name to be wrap*/
        #divIssuesList table tr td:nth-child(1) {
            width: 10% !important;
        }

        #divIssuesList table tr td:nth-child(2) {
            width: 10% !important;
        }

        #divIssuesList table tr td:nth-child(3) {
            width: 10% !important;
        }

        #divIssuesList table tr td:nth-child(4) {
            width: 10% !important;
        }

        #divIssuesList table tr td:nth-child(5) {
            width: 25% !important;
        }

        #divIssuesList table tr td:nth-child(6) {
            width: 30% !important;
        }
        /*End By Ankush T on 08/06/2018 for task name to be wrap*/

        /*Added By Ankush T on 08/06/2018 for sprint name to be wrap*/
        #DivReviewList table tr td:nth-child(1) {
            width: 10% !important;
        }

        #DivReviewList table tr td:nth-child(2) {
            width: 30% !important;
        }

        #DivReviewList table tr td:nth-child(3) {
            width: 10% !important;
        }

        #DivReviewList table tr td:nth-child(4) {
            width: 10% !important;
        }

        #DivReviewList table tr td:nth-child(5) {
            width: 20% !important;
        }

        #DivReviewList table tr td:nth-child(6) {
            width: 20% !important;
        }
        /*Added by usha Pandit on 13 June 2018 for Scroll Issue */
        .clsGraphDivWidth {
            width: 107%;
        }

        /*End of Added by usha Pandit on 13 June 2018 for Scroll Issue */
        /*End By Ankush T on 08/06/2018 for sprint name to be wrap*/

        /*Added By Ankush T on 08/06/2018 for sprint name to be wrap*/
        /*#DivImpedimentsLogsList table tr td:nth-child(1) {
            width: 10% !important;
        }

        #DivImpedimentsLogsList table tr td:nth-child(2) {
            width: 35% !important;
        }

        #DivImpedimentsLogsList table tr td:nth-child(3) {
            width: 10% !important;
        }

        #DivImpedimentsLogsList table tr td:nth-child(4) {
            width: 30% !important;
        }
        #DivImpedimentsLogsList table tr td:nth-child(5) {
            width: 20% !important;
        }
         #DivImpedimentsLogsList table tr td:nth-child(6) {
            width: 20% !important;
        }*/
        /*End By Ankush T on 08/06/2018 for sprint name to be wrap*/



        #divRemarks .clsRemark {
            margin-top:36px!important;
        }
        /*Added by Pradip p. on 18 Jun 2021 For Datepicker on hover color change*/
        a.ui-state-default:hover { color: #000 !important;}
        /*End of Added by Pradip p. on 18 Jun 2021 For Datepicker on hover color change*/

        label {margin-bottom: -4px!important;}
        #ReleaseDetailsall{display:flex;margin-top:65px}
        /* <!-- Modified By Madhuri.K On 02-04-2026 -->  */
        .details_tab .col-md-12, .details_tab .col-md-6{display:flex;margin-bottom:11.5px}
        .ClsHeaderGraph, .HeaderLine{font-size:14px}
        .clsunmappedAllcounts{position:relative}
        #HeaderLine{margin-top:20px}
        .label-primary {background-color: #428bca;}
         .progress {height: 20px;}
         #divAttachmentList{margin-top:20px}
         .demo-droppable p{font-size:14px}
         #txtDescription{border-bottom:1px solid #ddd}
         /*Added by Ashwini M on 28-3-2023*/
         .caret {display: inline-block;width: 0;height: 0;margin-left: 2px;vertical-align: middle;border-top: 4px solid;border-right: 4px solid transparent;border-left: 4px solid transparent;}
         .modal-header{display:block}
         .form-control{border-bottom:1px solid #ccc}
         textarea.form-control {height: auto;}
         .far.fa-calendar-check{margin-top: -25px!important;}
         .nav-pills > li > a.active, .nav-pills > li > a:focus{background:#428bca;color:#fff}
         #BurnDown, #Velocity{margin-bottom:170px}
         #DivNoTMappedSprintlist {height: 35px !important;color: #867c7c !important;font-weight: 100 !important;text-align: center;margin-top: 0%;}
         /*End of added by Ashwini M on 28-3-2023*/

         .fas, .far{cursor: pointer;}
         .dataTables_paginate{margin-bottom:25px}
         #ContainAllDivs .paginate_button.current, .release_table .paginate_button.current {
    background-color: #0288D1 !important;
    color: #fff !important;
}

#ContainAllDivs .paginate_button, .release_table .paginate_button {
    text-decoration: none;
    border: none !important;
    border-radius: 20px;
    color: #0288D1 !important;
    padding: 6px 10px;
}
#ContainAllDivs .paginate_button:hover, .release_table .paginate_button:hover {
    color: #fff !important;
    text-decoration: none;
    background-color: #0288D1 !important;
    border: none !important;
    border-radius: 20px;
    padding: 5px 10px;
}
#ContainAllDivs .paginate_button.previous, .release_table .paginate_button.previous, #ContainAllDivs .paginate_button.next, .release_table .paginate_button.next{display:none}
#DivHistorykList{padding-right: 25px;}
#ReleaseDetails #divReleases table thead.clsTRColumnHeader {
    display: none;
}
/*Added by pradip on 12-4-2023*/
div#div2 {padding: 0;}
.label-warning {background-color: #f0ad4e;}/*Added by pradip on 13-4-2023*/

    label.headerPage{
        font-weight: 400;
    }
    #myModal_dash INPUT.clsTextBox {
        FONT-SIZE: 10pt;
        opacity: 0.7;
        margin-top: 0;
    }
    .control-label {
        font-weight: 400;
    }
    #myScrollspy ul li a{
        font-size: 14px;
    }
    h2{
        font-weight: 400;
    }
    body{
        background-color: #FFF;
    }
    table thead tr th.DivCurrentSprintUS,
    table thead tr th.DivHistorykList,
    table thead tr th.DivAttachmentList  {
        background: #fff !important;
        font-size: 14px !important;
        font-weight: 400 !important;
    }
    .clsGridTable .clsTRColumnHeader th{
        background: #fff !important;
        font-size: 14px !important;
        font-weight: 600 !important;
    }
    .clsGridTable .clsTRColumnHeader th {
        border: 1px solid #dddddd !important;
    }
    #DivAttachmentList .dataTables_sizing{
        color: #000 !important;
        /* text-align: left !important; */
    }

    /* #DataTables_Table_3 table thead tr th { */
    /* #DataTables_Table_3 table thead tr th {
        background: #fff;
        font-weight: 700 !important;
        color: #8b8b8b !important;
    } */
    #DivImpedimentsLogsList .dataTables_sizing {
        color: #000 !important;
        font-size: 14px !important;
        font-weight: 700;
    }
    .dataTables_scroll {
        margin-left: 0 !important;
    }
    #DivImpedimentsLogsList .table > tbody > tr > td:nth-child(6) {
        text-align: center !important;
    }
    </style>
<body style="overflow-x: hidden;">

    <form id="frmReleaseMonitoring" runat="server">
        <div id="container2">
            <%WritePage("load")%>
        </div>
        <div class="modal fade" id="myModal_dash" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document" style="max-width: 98%!important">
                <div class="modal-content" id="dashcontent">
                    <div class="modal-header" id="dashheader">
                        <div class="col-sm-4">
                            <h5 class="modal-title" style="color: maroon;" id="H1"></h5>
                        </div>

                        <div class="col-sm-1">
                            <button type="button" class="close" title="close" onclick="RefreshAllPage()" data-bs-dismiss="modal" aria-label="Close" style="margin-top: -6%!important; margin-right: -3%!important">
                                <%--data-bs-dismiss="modal" aria-label="Close"--%>
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </div>
                    <div class="modal-body" id="DashBody">
                    </div>
                    <div class="modal-footer">
                        <%-- <button type="button" class="btn btn-primary" onclick="SaveSprint()" id="Button5" title="Save">Save</button>--%>
                    </div>

                </div>
            </div>
        </div>
    </form>

    <div class="modal fade" id="divUS" data-keyboard="false" data-backdrop="static" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content" id="USmodalcontent">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="headerUS">Create User Story</h4>
                </div>
                <%-- <div class="modal-header" id="SectionHeader">
                       
                        <div class="col-md-6 col-sm-12 col-sm-12">
                            <i data-bs-toggle='tooltip' title='Save' onclick='SaveNew_UserStory()' class='fa fa-save' style="margin-top: 4px; float: left; margin-left: 38%;"></i>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" title="close modal " style="margin-top: 4px!important">
                                &times;
                            </button>
                        </div>

                    </div>--%>
                <div class="modal-body" id="divUSbodys">
                    '<%--//divProductBacklog_Body--%>
                </div>
                <div class="col-md-12 align-right" style="margin-bottom: 20px">
                    <button type="button" class="btn btn-primary" onclick="SaveNew_UserStory()" id="Button2" title='Save' data-bs-toggle='tooltip'>Save</button>
                </div>

            </div>
        </div>
    </div>
    <div class="modal fade" id="CreateSprint" data-keyboard="false" data-backdrop="static" tabindex="-1" role="dialog">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="HeaderCreate"></h4>
                </div>

                <div class="modal-body" id="SprintBody">
                </div>
                <div class="col-md-12 align-right">
                    <%-- <button type="button" class="btn btn-primary" onclick="SaveSprint()" id="Button5" title="Save">Save</button>--%>
                </div>

            </div>
        </div>
    </div>

    <div id="myModalconfirm" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"><i class="fa fa-check-circle" style="color: green; margin-right: 5px;"></i>Confirmation</h4>
                </div>
                <div class="modal-body">
                    <p id="ConfirmMessage"></p>
                </div>
                <div class="modal-footer">
                    <button id="divOk" type="button" class="btn btn-primary">ok</button>
                    <button id="divClose" type="button" class="btn btn-default">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<script>
    $(document).ready(function () {
        //alert($("#FilterListCount").val());
        //Added By Dipali V On 24th March 2023 For Datatable Issue
        if ($("#FilterListCount").val() > 0) {
            datatables_New('divReleases', 'txtSearchRelease', '')
        }
       //End of Added By Dipali V On 24th March 2023 For Datatable Issue
       
        $('[data-bs-toggle="tooltip"]').tooltip();
        $(".edit_release").tooltip();
        $(".delete_release").tooltip();
        $(".fa-ellipsis-v").tooltip();
        $("#btncreate").tooltip();
        $(".fa-filter").tooltip();


       

    });
   

    function datatables(divID, txtBoxID, height, CountList) {
        if (CountList > 0) {//Added By Dipali V On 24th March 2023 For Datatable Issue
            $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' > table tr').removeClass("clsTROdd odd");
            $('#' + divID + ' > table tr').removeClass("clsTREvenRow even");
            $('#' + divID + ' table').addClass("table table-striped nowrap");
            var table = $('#' + divID + ' > table').DataTable({
                responsive: true,
                sorting: true,
                scrollX: true,
                tooltip: true,
                "pageLength": 5,
                "bAutoWidth": false,
                scrollY: '290px',
                "drawCallback": function (settings) { //Added by Usha Pandit on 08 June 2018 for hiding vertical scrollbar

                    $("#" + divID).find(".col-sm-12").css("cssText", "overflow: hidden;width: 100%;");
                    $("#" + divID).find(".dataTables_scroll").css("cssText", "overflow: auto;width: 100%;");

                }
            }).on('page.dt', function () {     //Added by Usha Pandit on 08 June 2018 for hiding vertical scrollbar

                $("#" + divID).find(".col-sm-12").css("cssText", "overflow: hidden;width: 100%;");
                $("#" + divID).find(".dataTables_scroll").css("cssText", "overflow: auto;width: 100%;");

            });

            if (txtBoxID != "") {
                $('#' + txtBoxID).on('keyup change', function () {
                    table.search($(this).val()).draw();
                })
            }
        }//End of Added By Dipali V On 24th March 2023 For Datatable Issue
    }


    function datatables_New(divID, txtBoxID, height) {
       
            $('#' + divID + ' > table').removeClass("clsGridTable");
            $('#' + divID + ' > table tr').removeClass("clsTROdd odd");
            $('#' + divID + ' > table tr').removeClass("clsTREvenRow even");
            $('#' + divID + ' table').addClass("table table-striped nowrap");
            var table = $('#' + divID + ' > table').DataTable({
                responsive: true,
                sorting: true,
                scrollX: true,
                tooltip: true,
                "pageLength": 5,
                scrollY: '290px',
                "drawCallback": function (settings) { //Added by Usha Pandit on 08 June 2018 for hiding vertical scrollbar

                    $("#" + divID).find(".col-sm-12").css("cssText", "overflow: hidden;width: 100%;");
                    $("#" + divID).find(".dataTables_scroll").css("cssText", "overflow: auto;width: 100%;");

                }
            }).on('page.dt', function () {     //Added by Usha Pandit on 08 June 2018 for hiding vertical scrollbar

                $("#" + divID).find(".col-sm-12").css("cssText", "overflow: hidden;width: 100%;");
                $("#" + divID).find(".dataTables_scroll").css("cssText", "overflow: auto;width: 100%;");

            });

            if (txtBoxID != "") {
                $('#' + txtBoxID).on('keyup change', function () {
                    table.search($(this).val()).draw();
                })
            }
       
    }

    //function show() {
    //    $("#ulFilters").css("display", "block");
    //}
    var strGlobaFilterField = "";
    function ShowFilter(flag) {
        strGlobaFilterField = flag;
        
        var strUserResult = ajaxCall("frmReleaseMonitoring.aspx/FilterPlotGrid", "POST", "application/json", "json", JSON.stringify({ Flag: flag }));
        if (strUserResult.d != null || strUserResult.d != undefined) {
            //$("#divReleases").html("")
            if (flag != "AfterLoad")
            {
                $("#divReleases").html("");
                $("#divReleases").html(strUserResult.d);
            }
            $('[data-bs-toggle="tooltip"]').tooltip();
            $("#RightArrow").css("display", "none");
            //$("#ulFilters").css("display", "none");
           // debugger;
            //Added By Dipali V On 24th March 2023 For Datatable Issue
            if ($("#Filter" + flag).val() > 0) {
                datatables_New('divReleases', 'txtSearchRelease', '')
            }
             //End of Added By Dipali V On 24th March 2023 For Datatable Issue
        }
    }
    var arrFile = [];
    function ajaxCall(url, type, contentType, dataType, data) {
        var ajaxResult;
        $.ajax({
            url: url,
            type: type,
            contentType: contentType,
            dataType: dataType,
            data: data,
            async: false,
            success: function (result) {
                ajaxResult = result;
            },
            error: function (xhr) {
                console.log(xhr);
            }
        })

        return ajaxResult;
    }
</script>
<!--Script for popup -->
<script>

   $(function () {
        /*Commented By yasmin on 5-3-19*/
        //$('#SprintStartdate').datepicker();
        //$('#SprintEnddate').datepicker();
        //$('#RstartDate').datepicker();
        //$('#txtEndDate').datepicker();

        $('[data-toggle="tooltip"]').tooltip();

        $('#SprintStartdate,#SprintEnddate,#RstartDate,#txtEndDate').datepicker(
          {
              changeMonth: true,
              changeYear: true,
              //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
             //yearRange: '2000:2020'
               yearRange: 'c-100:c+100'
             //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
          }
        );

    });
    var intDivGridListHeight, dragUserStoryD = '', ReleaseID = '';
    var strResultForStatus = "";

    $(document).ready(function () {
        $('.fa').tooltip();
        $('span').tooltip();
        $('[data-bs-toggle="tooltip"]').tooltip();
        //$('p').tooltip();
        $('lblname').tooltip();
        $('.clsTROdd ').tooltip();
        $('.even').tooltip();
        // $('body').tooltip({ selector: '[data-bs-toggle="tooltip"]' });
        $('[data-bs-toggle="tooltip"]').tooltip()
        $(".clsrightdiv").sortable({
            connectWith: ".clsrightdiv ",
            scroll: true,
            cursor: "move",
            opacity: 0.7,
        });
        $('#hdnselectedReleaseID').val("");


       
        /*Commented By yasmin on 5-3-19*/
        //$('#RstartDate').datepicker();
        //$('#txtEndDate').datepicker();
        $('#RstartDate,#txtEndDate').datepicker(
       {
           changeMonth: true,
           changeYear: true,
           //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
           //yearRange: '2000:2020'
             yearRange: 'c-100:c+100'
           //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
       }
     );

        var $li = $('#tab_link a').click(function () {
            $li.removeClass('selected');
            $(this).addClass('selected');


            //var divId = $(this).attr("href").toString();
            //alert(divId);
            //divId = divId.replace("tab", "");
            //$("div").removeClass("activecls");
            //$("#" + divId).addClass("activecls");
        });



    });

    //For Refresh
    function refresh() {
        $('[data-bs-toggle="tooltip"]').tooltip()



        var $li = $('#tab_link a').click(function () {
            $li.removeClass('selected');
            $(this).addClass('selected');
        });

    }

    //select One checkbox at time
    function SelectOne(obj) {
        $('input.clscheckbox').on('change', function () {
            $('input.clscheckbox').not(this).prop('checked', false);
        });
        $(this).is(":checked");
        if ($(this).is(":checked")) {
            $('#DivRleaselist input[name=SelectReleaseList]:checked').each(function () {
                $('#hdnselectedReleaseID').val(strSeletedRelease + ',');

            });

        }
        else {
            $(this).prop('checked', false);
            $('#hdnselectedReleaseID').val("")

        }
        //alert($('#hdnselectedReleaseID').val());

    }






    //For Showwing All Release List


    function ApplyFilter(Flag) {
        var strSeletedUS = "", strSeletedSprint = "", strSeletedRelease = "";
        //  debugger;
        var flag = 0;
        if (Flag == "UserStory") {
            flag = 1;
            strSeletedUS = $('input[name=SelectUSList]:checked').map(function () {
                return this.value;
            }).get().join(',');

            if (strSeletedUS.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select at least one User Story', 'error');
                return;
            }
        }
        else if (Flag == "Sprint") {
            // alert("Sprints");
            flag = 1;
            strSeletedUS = $('input[name=SelectSprintList]:checked').map(function () {
                return this.value;
            }).get().join(',');

            if (strSeletedUS.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select at least one Sprint', 'error');
                return;
            }
        }
        else {
            //  alert("Release");
            flag = 1;
            strSeletedUS = $('input[name=SelectReleaseList]:checked').map(function () {
                return this.value;
            }).get().join(',');

            if (strSeletedUS.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select at least one Release', 'error');
                return;
            }
        }

        if (flag == 1) {
            // debugger;
            var strResult, data;
            var ReleaseID = document.getElementById('hdnReleaseID').value;
            data = JSON.stringify({ ReleaseID: "", strSeletedUS: strSeletedUS, FilterFlag: Flag });//UserStory
            strResult = AJAXCallWithResult("frmReleasePlanning.aspx/SelectUserStory", data, false);

            if (strResult.d != '') {


                //$("#MainDiv").html("");
                //$("#MainDiv").html(strResult.d);
                // $("#FilterUS").modal('hide');

                // $("#Idheader").html("Release")
                // $("#DivRleaselist").modal('show');

                if (Flag == "Sprint") {
                    $("#FilterSprint").modal('hide');
                    $("#MainDiv").html("");
                    $("#MainDiv").html(strResult.d);
                }
                else if (Flag == "UserStory") {
                    $("#FilterUS").modal('hide');
                    $("#MainDiv").html("");
                    $("#MainDiv").html(strResult.d);
                }
                else {
                    $("#FilterRelese").modal('hide');
                    $("#MainDiv").html("");
                    $("#MainDiv").html(strResult.d);
                }

                refresh();
                $('[data-bs-toggle="tooltip"]').tooltip();
                // $('.radio-inline').tooltip()
            }
        }

    }

    //For Remark Validation
    function CheckTextLength(obj, lbl, span) {
        var MaxLength = obj.getAttribute("ShowLength");

        if (parseInt(String(obj.value).length) >= MaxLength) {
            $("#" + span).css("display", "block")
            // $("#" + span).text("you can enter only " + MaxLength + " characters.");
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("you can enter only " + MaxLength + " characters.", 'error');
        }
        else {
            $("#" + span).text("");
        }
        $("#" + span).css("display", "block")
        document.getElementById(lbl).innerHTML = '-' + (MaxLength - parseInt(String(obj.value).length));
    }


    //For Open Modal
    var SprintID = 0;
    var ReleaseID = 0;
    function ShowModal(type, categoryID, obj) {

        //For Hightlight Selected Option
        $('.dropdown-item').removeClass('active');
        $(obj).addClass('active');
        //End of Hightlight Selected Option
        var categoryID = "";

        var strUserResult = ajaxCall("frmReleasePlanning.aspx/AddUserStoryModal", "POST", "application/json", "json", JSON.stringify({ CategoryID: categoryID, type: type }));


        if (type == "Release") {
            $("#DashBody").html('');  /*Added by Usha Pandit on 31 May 2018 to fix javascript error issue */
            $("#SprintBody").html(strUserResult.d);
            /*Added by kashish For Texarea Enhancement*/
            //AutoResizeTextArea();
            RemoveTextArea();
            $("#CreateSprint").modal('show');

            $("#HeaderCreate").html('Create Release')
           /*Commented By yasmin on 5-3-19*/
            //$('#RstartDate').datepicker();
            //$('#txtEndDate').datepicker();
            $('#RstartDate,#txtEndDate').datepicker(
                  {
                      changeMonth: true,
                      changeYear: true,
                      //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                      //yearRange: '2000:2020'
                      yearRange: 'c-100:c+100'
                      //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                  }
            );
             $('#RstartDate,#txtEndDate').prop('readonly', true);
            $("#RstartDate,#txtEndDate").change(function () {
                GetDuration("Release");
            });

        }


    }

    var arrFile = [];
    function ajaxCall(url, type, contentType, dataType, data) {
        var ajaxResult;
        $.ajax({
            url: url,
            type: type,
            contentType: contentType,
            dataType: dataType,
            data: data,
            async: false,
            success: function (result) {
                ajaxResult = result;
            },
            error: function (xhr) {
                console.log(xhr);
            }
        })

        return ajaxResult;
    }


    function ClearSpan(txt, span) {

        if ($('#' + txt).val() == "") {
        }
        else {
            $('#' + txt).css('border-color', '#d8dade');
            $('#' + txt).css('border-width', '1px');
            $('#' + span).text("");
        }
    }

    function ShowLength(limitField, limitCount, limitNum, Flag) {

        var length;
        if (limitField.value.length > limitNum) {
            limitField.value = limitField.value.substring(0, limitNum);
        } else {
            limitCount.innerHTML = (limitNum - limitField.value.length);
        }

        if (limitCount.innerHTML == 0) {
            if (Flag == 'Sprint') {
                document.getElementById("countdownSprint").style.color = 'red' //when Char 0 length  then Color red
                // $('#spanBusinessValue').html("You Can Enter Only 100 Character");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You Can Enter Only 1000 Character', 'error');
            }
            else if (Flag == 'Release') {
                document.getElementById("countdownRelease").style.color = 'red' //when Char 0 length  then Color red
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You Can Enter Only 1000 Character', 'error');
            }

        }
        else {
            if (Flag == 'Sprint') {
                document.getElementById("countdownSprint").style.color = 'black'
                // $('#spanBusinessValue').text("");
            }
            else if (Flag == 'Release') {
                document.getElementById("countdownRelease").style.color = 'black'
                // $('#spanAcceptanceCriteria').text("");
            }

        }
        if (limitField.clientHeight < limitField.scrollHeight) {
            limitField.style.height = limitField.scrollHeight + "px";
            if (limitField.clientHeight < limitField.scrollHeight) {
                limitField.style.height =
                    (limitField.scrollHeight * 2 - limitField.clientHeight) + "px";
            }
        }
    }




    (function (window) {
        function triggerCallback(e, callback) {
            if (!callback || typeof callback !== 'function') {
                return;
            }
            var files;
            if (e.dataTransfer) {
                files = e.dataTransfer.files;
            } else if (e.target) {
                files = e.target.files;
            }
            callback.call(null, files);
        }
        function makeDroppable(ele, callback) {
            var input = document.createElement('input');
            input.setAttribute('type', 'file');
            //input.setAttribute('multiple', true);
            input.style.display = 'none';
            input.addEventListener('change', function (e) {
                triggerCallback(e, callback);
            });
            ele.appendChild(input);

            ele.addEventListener('dragover', function (e) {
                e.preventDefault();
                e.stopPropagation();
                ele.classList.add('dragover');
            });

            ele.addEventListener('dragleave', function (e) {
                e.preventDefault();
                e.stopPropagation();
                ele.classList.remove('dragover');
            });

            ele.addEventListener('drop', function (e) {
                e.preventDefault();
                e.stopPropagation();
                ele.classList.remove('dragover');
                triggerCallback(e, callback);
            });

            ele.addEventListener('click', function () {
                input.value = null;
                input.click();
            });
            ele.addEventListener('dragenter', function (event) {
                if (event.preventDefault)
                    event.preventDefault();

            });
        }
        window.makeDroppable = makeDroppable;
    })(this);




    //For Validation Numeric
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
    //For Validation Blank
    function ValidateBlankField(obj, spanObj, Msg) {
        var checkValue = 0;
        if ($("#" + obj.id).val() == "") {
            $("#" + obj.id).css('border-color', 'red');
            $("#" + obj.id).css('border-width', '1px');
            $("#" + spanObj.id).text(Msg);
            if (checkValue != 1) {
                $("#" + obj.id).focus()
            }
            checkValue = 1;
        }
        return checkValue;
    }



    //Save Sprint Release

    var SprintID = 0;
    var ReleaseID = 0;
    function SaveSprintRelease(Flag) {
        // debugger;
        if (validationRelease() == 0) {
            //  debugger;
            var ReleaseName = $("#ReleaseName").val();
            var RstartDate = $("#RstartDate").val();
            var txtDescription = $("#txtDescription").val();
            var txtEndDate = $("#txtEndDate").val();
            var txtRelCalendar = $("#txtRelCalendar").val();
            // var txtBusiness = $("#txtBusiness").val();
            var txtRelEfforts = $("#txtRBusinessDuration").val();
            var ProjectID = document.getElementById('hdnProjectID').value;


            if (ReleaseName == "") {
                ReleaseName = "";
            }
            else {
                ReleaseName = ReleaseName;
            }

            if (txtDescription == "") {
                txtDescription = "";
            }
            else {
                txtDescription = txtDescription;
            }


            if (txtRelEfforts == "") {
                txtRelEfforts = "";
            }
            else {
                txtRelEfforts = txtRelEfforts;
            }

            var ReleaseID = $("#hdnReleaseIDnew").val();
            if (ReleaseID != undefined) {
                ReleaseID = ReleaseID;
            } else {
                ReleaseID = "0";
            }

            //Added By Aniruddh Gujar on 23-Apr-2018 Purpose::Whizible Agile Development
            var strStatus;
            if (document.getElementById("btnStatus") != null)
                strStatus = document.getElementById("btnStatus").innerHTML;
            else
                strStatus = ""

            if (strStatus == 'Released') {
                var result = AJAXCallWithResult("frmReleaseMonitoring.aspx/CheckAllIssues", JSON.stringify({ strReleaseID: ReleaseID }), false);
                if (result.d != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(result.d, 'error', 15);
                    return false;
                }
            }
            //End of Added By Aniruddh Gujar on 23-Apr-2018 Purpose::Whizible Agile Development

            SprintID = "0";
            var strUserResult = ajaxCall("frmReleasePlanning.aspx/SaveSprintRelease", "POST", "application/json", "json", JSON.stringify({ Flag: Flag, SprintID: ReleaseID, ProjectID: ProjectID, Sprintname: ReleaseName, ReleaseID: ReleaseID, txtDescriptionSprint: txtDescription, SprintStartdate: RstartDate, SprintEnddate: txtEndDate, txtCalendar: txtRelCalendar, txtEfforts: txtRelEfforts, txtBusiness: "", strStatus: strStatus }));
            //alert(strUserResult.d);
            if (strUserResult.d != "") {

                var NewSprintID = strUserResult.d;
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Release saved Successfully', 'success');
                $("#CreateSprint").modal('hide');
                //AfterRelaseSprintSave(Flag, NewSprintID)
                RefreshAllPage();
                //Added By Dipali V On 24th March 2023 For Datatable Issue
                if ($("#FilterListCount").val() > 0) {
                    datatables_New('divReleases', 'txtSearchRelease', '')
                }
                //datatables('divReleases', 'txtSearchRelease', '')
                 //End of Added By Dipali V On 24th March 2023 For Datatable Issue
                
                $('[data-bs-toggle="tooltip"]').tooltip();
                $(".edit_release").tooltip();
                $(".delete_release").tooltip();
                $(".fa-ellipsis-v").tooltip();
                $("#btncreate").tooltip();

                refresh();

            }


        }
    }

    function validationRelease() {
        
        var checkvalue = 0;
        var Flag = 0;
        var checkvalue = 0;
        var strmsg = "";
        var errorMsg = "<ul>"
        dtStartDate = document.getElementById("RstartDate");
        dtEndDate = document.getElementById("txtEndDate");
        var ProjectID = document.getElementById('hdnProjectID').value;
        //alert(GlobalProjectID);
        //Added By Aniruddh Gujar on 23-Apr-2018 Purpose::Whizible Agile Development
        var strStatus;
        if (document.getElementById("btnStatus") != null)
            strStatus = document.getElementById("btnStatus").innerHTML;
        else
            strStatus = ""
        if (strStatus == 'Released') {
            return checkvalue;
        }
        //End of Added By Aniruddh Gujar on 23-Apr-2018 Purpose::Whizible Agile Development
        var ReleaseID = $("#hdnReleaseIDnew").val();
        if (ReleaseID != undefined) {
            ReleaseID = ReleaseID;
        } else {
            ReleaseID = "0";
        }
        if ($('#txtReleaseName').val() != null) {
            if (checkSpecialCharacter($('#txtReleaseName').val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Release Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtReleaseName").focus();
                Flag = 1;
                checkvalue = 1;
                return;
            }
        }

        if ($("#ReleaseName").val() == "") {
            strmsg = '- Release Name should not be left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }
        //Added By Riddhesh Patil on 11-NOV-2022 
        if ($('#ReleaseName').val() != "") {
            if (checkSpecialCharacter($('#ReleaseName').val()) == true) {

                alertify.error('Release Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#ReleaseName").focus();
                checkvalue = 1;
            }


            //End of Added By Riddhesh Patil
       // if ($("#ReleaseName").val() != "") {
	    //Uncommented by Usha Pandit On 02.09.2020 For checking special characters in release name
         //   if (checkSpecialCharacter($('#ReleaseName').val()) == true) {
            //    // alertify.set('notifier', 'position', 'top-right');
         //       strmsg = '- Release Name cannot contain any of these /\\:*?<>|,"+- Characters';
          //      errorMsg += "<li>" + strmsg + "</li></br>";
            //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
          //      checkvalue = 1;

          //  }
            //End Of Uncommented by Usha Pandit On 02.09.2020 For checking special characters in release name

            $.ajax({
                url: "frmReleaseMonitoring.aspx/CheckIterationName",
                data: JSON.stringify({ strIterationName: $("#ReleaseName").val(), strProjectID: GlobalProjectID, flag: "Release", EntityID: ReleaseID }),
                dataType: "json",
                type: "POST",
                contentType: "application/json",
                async: false,
                success: function (result) {
                    if (result.d != 0) {
                        strmsg = result.d;
                        errorMsg += "<li>" + strmsg + "</li></br>";
                        Flag = 1;
                        /// checkvalue = 1;
                        if (checkvalue != 1) {
                            $("#ReleaseName").focus();
                        }
                        checkvalue = 1;
                    }
                }
            })
        }
        if ($("#txtDescription").val() != "") {
            //Uncommented by Usha Pandit On 02.09.2020 For checking special characters in release name
            if (checkSpecialCharacter($('#txtDescription').val()) == true) {
                //    // alertify.set('notifier', 'position', 'top-right');
                strmsg = 'Description cannot contain any of these' + WebConfigSpecialCharacters + 'Characters';
                errorMsg += "<li>" + strmsg + "</li></br>";
                //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                checkvalue = 1;

            }
        }

        if ($("#RstartDate").val() == "") {
            strmsg = '- Release Start Date should not be left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }

        if ($("#txtEndDate").val() == "") {
            strmsg = '- Release End date should not be left blank';
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;
        }

        if (CompairDates(dtStartDate, dtEndDate) == 1) {
            strmsg = '- Release End date should be greater than Release start date';//End date should be greater than start date
            errorMsg += "<li>" + strmsg + "</li></br>";
            Flag = 1;
            checkvalue = 1;

        }


        if (checkvalue == 0) {
            var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value });
            var result = AJAXCallWithResult("frmReleasePlanning.aspx/ValidateProjectDates", data, false);
            result = result.d;
            if (result != '') {
                var arrResult = result.split('##');
                // alert(arrResult[0]);
                if (arrResult[0] == '1') {
                    //dtStartDate.style.borderColor = 'red';
                    //dtStartDate.style.borderWidth = '1px';
                    //spandtStartDate.innerHTML = arrResult[1];

                    //checkvalue = 1;
                    strmsg = '-' + arrResult[1];
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }
                if (arrResult[0] == '2') {

                    //dtEndDate.style.borderColor = 'red';
                    //dtEndDate.style.borderWidth = '1px';
                    //spandtEndDate.innerHTML = arrResult[1];

                    //checkvalue = 1;
                    strmsg = '-' + arrResult[1];
                    errorMsg += "<li>" + strmsg + "</li></br>";
                    Flag = 1;
                    checkvalue = 1;
                }
            }

        }




        if (RestrictNonNumeric(document.getElementById('txtRelCalendar')) == true) {
            // alertify.set('notifier', 'position', 'top-right');
            strmsg = ' - Please Enter only positive numeric value for Calendar Day"s" !!!';
            errorMsg += "<li>" + strmsg + "</li></br>";
            //alertify.notify('', 'error');
            checkvalue = 1;

        }

        //if ($("#txtRelEfforts").val() == "") {
        //    strmsg = '- Efforts should not be left blank';
        //    errorMsg += "<li>" + strmsg + "</li></br>";
        //    Flag = 1;
        //    checkvalue = 1;
        //}

        if ($("#txtRBusinessDuration").val() != "") {
            if (RestrictNonNumeric(document.getElementById('txtRBusinessDuration')) == true) {
                // alertify.set('notifier', 'position', 'top-right');
                strmsg = ' - Please Enter only positive numeric value for Business Duration !!!';
                errorMsg += "<li>" + strmsg + "</li></br>";
                //alertify.notify('', 'error');
                checkvalue = 1;

            }
            //else if (checkSpecialCharacter($('#txtRelEfforts').val()) == true) {
            //    // alertify.set('notifier', 'position', 'top-right');
            //    strmsg = '- Efforts cannot contain any of these /\\:*?<>|,"+- Characters';
            //    errorMsg += "<li>" + strmsg + "</li>";
            //    //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
            //    checkvalue = 1;

            //}
        }

        //if (RestrictNonNumeric(document.getElementById('txtBusiness')) == true) {
        //    // alertify.set('notifier', 'position', 'top-right');
        //    strmsg = ' - Please Enter only positive numeric value for Business Day"s" !!!';
        //    errorMsg += "<li>" + strmsg + "</li>";
        //    //alertify.notify('', 'error');
        //    checkvalue = 1;

        //}

        if (ReleaseID == "0") {
            var objCurrentReleaseStartDate = dtStartDate.value;
            var objCurrentReleaseEnddateDate = dtEndDate.value;
            if (checkvalue == 0) {
                if (dtStartDate != null && dtEndDate != null) {
                    var data = JSON.stringify({ ProjectID: ProjectID, StartDate: dtStartDate.value, EndDate: dtEndDate.value, Flag: "Release" });
                    var result1 = AJAXCallWithResult("frmReleaseMonitoring.aspx/ValidateIterationDate", data, false);
                    if (result1.d != '') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(result1.d, 'error', 15);
                        checkValu = 1;
                        return;

                    }
                }
            }
        }


        if (strmsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }
        return checkvalue;




    }
    function setFrameLoader() {

        $("HTML").append("<div id='preloader'></div>");
        $("HTML").append("<div id='fillDiv'></div>");
    }

    function RemoveFrameLoader() {
        jQuery("#preloader").remove();
        jQuery("#fillDiv").remove();
        jQuery("#preloader").fadeOut("slow");
        jQuery("#fillDiv").fadeOut("slow");
        jQuery("#preloader").remove();
        jQuery("#fillDiv").remove();
    }

    var newChartTab;
    //function AfterRelaseSprintSave(Flag,UniqueID) {
    //    var strResult = ajaxCall("frmReleasePlanning.aspx/Modal_popupdashboard", "POST", "application/json", "json", JSON.stringify({ UniqueID: UniqueID, Flag: Flag }));
    //    // setFrameLoader();
    //    var arrResult = strResult.d.split('||');
    //    // alert(arrResult);
    //    //  alert(UniqueID);
    //    //  alert(arrResult[0]);
    //    $("#DashBody").html("");
    //    $("#addsprint").html("Update");
    //    // $("#add_Release").html("");
    //    $("#addRelease").html("Update");
    //    datatables('DivNoTMappedSprintlist', 'txtSearchSprint11', '')

    //    //debugger;
    //    //var Arrdata = arrResult[1].split('##');
    //    //alert(Arrdata[0]);
    //    //alert(Arrdata[1]);
    //    //alert(Arrdata[2]);
    //    //alert(Arrdata[3]);
    //    //alert(Arrdata[4]);
    //    //alert(Arrdata[5]);
    //    //alert(Arrdata[6]);

    //    //if (Flag == "Sprint")
    //    //{
    //    //  //  $('#Sprintname').val(Arrdata[1]);
    //    //    document.getElementById('Sprintname').value = Arrdata[0];
    //    //    document.getElementById('txtDescriptionSprint').value = Arrdata[1];
    //    //    document.getElementById('SprintStartdate').value = Arrdata[2];
    //    //    document.getElementById('SprintEnddate').value = Arrdata[3];
    //    //    document.getElementById('txtCalendar').value = Arrdata[4];
    //    //    document.getElementById('txtEfforts').value = Arrdata[5];
    //    //    document.getElementById('txtBusiness').value = Arrdata[6];
    //    //    //$('#txtDescriptionSprint').val(Arrdata[1]);
    //    //    //$('#SprintStartdate').val(Arrdata[2]);
    //    //    //$('#SprintEnddate').val(Arrdata[3]);
    //    //    //$('#txtCalendar').val(Arrdata[4]);
    //    //    //$('#txtEfforts').val(Arrdata[5]);
    //    //    //$('#txtBusiness').val(Arrdata[6]);

    //    //    // CustomerContact = Arrdata[9];
    //    //}
    //    //  RemoveFrameLoader();
    //    $("#DashBody").html(arrResult[0]);
    //    $("#myModal_dash").modal('show');
    //    $("#dashheader").css('display', 'none');
    //    //      $("#txtDiscussion").Editor();
    //    $('#sprint_details').css("height", ((window.innerHeight / 2) + 50 + 'px'));

    //    //if (Flag != "Sprint") {
    //    //    $('#div_details').css("height", ((window.innerHeight / 2) - 35 + 'px'));
    //    //}
    //    //else {

    //    // alert((window.innerHeight / 2)+ 200)
    //    //}
    //    $('#tab_link li').click(function () {
    //        $('#tab_link li a').css("text-decoration", "none");
    //        $('#tab_link li a').css("color", "");
    //        $("a", this).css("text-decoration", "underline");
    //        $("a", this).css("color", "#60ffa7");
    //        // $("#dashcontent").css("top", "-10px");
    //        //  $("a", this).css("color", "#60ffa7");
    //        // debugger;
    //        //$("a", this).attr("href").addClass("SelectedDIV")




    //    })
    //    $(".clsBox").hover(function () {
    //        $('#tab_link li a').css("text-decoration", "none");
    //        $('#tab_link li a').css("color", "");
    //        $("[href=#" + $(this).attr("id") + "]").css("text-decoration", "underline");
    //        $("[href=#" + $(this).attr("id") + "]").css("color", "#60ffa7");
    //        //$("[href=#" + $(this).attr("id") + "]").addClass("Selected")
    //        // alert( $(this).attr("id"));
    //    });

    //    if (Flag != undefined) {
    //        setTimeout(function () {
    //            $("[href=#" + Flag + "]").click();
    //            var scrollPos = $("#" + Flag + "").offset().top;


    //            //if (Flag != "Sprint") {
    //            //    $("#div_details").scrollTop(scrollPos - 250);
    //            //   // $('#div_details').css("height", ((window.innerHeight / 2) - 35 + 'px'));
    //            //}
    //            //else {
    //            $("#sprint_details").scrollTop(scrollPos - 200);

    //            // }
    //        }, 500)
    //    }


    //    var $li = $('#tab_link a').click(function () {
    //        //$li.removeClass('selected');
    //        //$(this).addClass('selected');
    //        var divId = $(this).attr("href").toString();

    //        divId = divId.replace("#", "");
    //        $("div").removeClass("activecls");
    //        //  alert(divId);
    //        $("#" + divId).addClass("activecls");
    //    });

    //    newChartTab = $('#myScrollspy ul li').click(function () {
    //        newChartTab.removeClass('active');
    //        $(this).addClass('active');

    //    });

    //    $(".tabcontentChart").hover(function () {

    //        $('#myScrollspy ul li a').css("background-color", "white");
    //        $('#myScrollspy ul li a').css("color", "black");
    //        // $("[href=#" + $(this).attr("id") + "]").removeClass('active');
    //        // $(this).addClass('active');
    //        $("[href=#" + $(this).attr("id") + "]").css("background-color", "#337ab7");
    //        $("[href=#" + $(this).attr("id") + "]").css("color", "white");
    //        // alert( $(this).attr("id"));
    //        //newChartTab.removeClass('active');
    //        // $(this).addClass('active');
    //    });

    //    makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
    //        var output = document.querySelector('.demo-droppable');
    //        output.innerHTML = '';
    //        for (var i = 0; i < files.length; i++) {
    //            arrFile[0] = files[i];
    //            output.innerHTML += '<p>' + files[i].name + '</p>';
    //        }
    //    });
    //    //if (document.getElementById("leftTree").style != null)
    //    //{
    //    //    document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 200) + 'px';

    //    //}

    //    var $li = $('#tab_link a').click(function ()
    //    {
    //        $li.removeClass('selected');
    //        $(this).addClass('selected');
    //        //if ($('#tab_link a').hasClass('selected')) {
    //        //    $(this).removeClass('selected');

    //        //}
    //        //else {
    //        //    $(this).addClass('selected');

    //        //}

    //    });
    //    $('[data-bs-toggle="tooltip"]').tooltip(); 
    //    //   $('.radio-inline').tooltip()
    //    $("#editReleaseName").tooltip(); 
    //    $("#ReleaseSprintPer").tooltip(); 
    //    $("#ReleaseSprintNext").tooltip(); 
    //    $("#tab_content").tooltip(); 
    //    $(".ClsCaptiontooltip").tooltip(); 
    //    $(".card-text ").tooltip(); 

    //    // document.getElementById("defaultOpen").click();
    //    // debugger
    //    GetLineBurnUP(UniqueID,'Release', 'divGraph' + UniqueID, "","BurnDown");
    //    GetLineBurnDown(UniqueID,'Release', 'divGraph' + UniqueID, "","BurnUp");

    //    GetLineBurnUPEffortS(UniqueID,'Release', 'divGraph' + UniqueID, "","BurnDown");
    //    GetLineBurnDownStoryPoints(UniqueID,'Release', 'divGraph' + UniqueID, "","BurnUp");


    //    GetLineVelocityEffortBar(UniqueID,'Release', 'divGraph' + UniqueID, "","BurnDown");
    //    GetLineVelocityStoryBar(UniqueID,'Release', 'divGraph' + UniqueID, "","BurnUp");

    //    GetFlowEfforts(UniqueID,'Release', 'divGraph' + UniqueID, "","BurnDown");
    //    GetCompleteCancelSprintSprint(UniqueID,'Cancel')
    //    GetCompleteCancelSprintSprint(UniqueID,'Complete')
    //    //GetFlowStoryPoints(UniqueID,'Release', 'divGraph' + UniqueID, "","BurnUp");


    //    datatables('DivCurrentSprintUS', 'txtSearchCurrntSprintUS', '')
    //    datatables('DivSubTabIssuesList', 'txtSearchIssues', '')
    //    datatables('DivImpedimentsLogsList', 'txtSearchImpediments', '')
    //    datatables('DivRisksList', 'txtSearchRisks', '')
    //    datatables('DivReviewList', 'txtSearchReviews', '')
    //    datatables('DivTaskList', 'txtSearchTask', '')
    //    datatables('DivHistorykList', 'txtSearchhistory', '')
    //}


    function GetCompleteCancelSprintSprint(ReleaseID, GraphFlag) {
        var strResult = ajaxCall("frmReleasePlanning.aspx/GetCompleteCancelGraphDetails", "POST", "application/json", "json",
            JSON.stringify({ ReleaseID: ReleaseID, GraphFlag: GraphFlag }));//188
        if (strResult.d != "") {

            if (GraphFlag != "Complete") {

                $("#CanSprintGrid" + ReleaseID).html("");
                $("#CanSprintGrid" + ReleaseID).html(strResult.d);
                var ListCount = $("#Filter" + GraphFlag).val()
                //datatables('DivCancelSprint', '', '',)
                //Added By Dipali V On 24th March 2023 For Datatable Issue
                    datatables('DivCancelSprint', '', '', ListCount);
                
                //End of Added By Dipali V On 24th March 2023 For Datatable Issue


            }
            else {
                $("#ComSprintGrid" + ReleaseID).html("");
                $("#ComSprintGrid" + ReleaseID).html(strResult.d);
                var ListCount = $("#Filter" + GraphFlag).val()
                datatables('DivCompleteSprint', '', '', ListCount)


            }
            $('[data-bs-toggle="tooltip"]').tooltip();
            // $('.radio-inline').tooltip()
        }
    }
    //Added By Riddhesh Patil on 22/12/2022
    var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
		//End of Added By Riddhesh Patil on 22/12/2022

    function checkSpecialCharacter(value) {
        var regularExpression = WebConfigSpecialCharacters;
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
    function CompairDates(obj1, Obj2) {
        var date1 = new Date(obj1.value);
        var date2 = new Date(Obj2.value);
        if (date1 > date2) {
            return 1;
        }
        else if (date1 < date2) {
            return -1;
        }
        else {
            return 0;
        }
    }

    //$("#tab_Discussions").onclickclick(function(){

    //    alert();
    //    $("#SprintRelease").html('');
    //    $("#SprintRelease").html('Post');
    //});



    function ShowMoreLess(discussionID, obj) {
        //  debugger;

        if (document.getElementById(discussionID).style.display == "none") {
            document.getElementById(discussionID).style.display = "block";
            obj.innerHTML = "Less"
        }
        else {
            document.getElementById(discussionID).style.display = "none";
            obj.innerHTML = "More"
        }
    }




    var strUser
    function Delete_Attachment(AttachmentID, UserStoryID, Flag) {
       // debugger;
        //alert(AttachmentID);
        var strUserResult = ajaxCall("frmReleaseMonitoring.aspx/DeleteAttachment", "POST", "application/json",
            "json", JSON.stringify({ strAttachmentID: AttachmentID, strUserStoryID: UserStoryID, strEntity: Flag }));
        strUser = strUserResult.d.split("||")


        document.getElementById("Attachmentus").innerHTML = "";
        // document.getElementById("attachmentdata").innerHTML = "";
        document.getElementById("Attachmentus").innerHTML = strUser[2];
        // document.getElementById("attachmentdata").innerHTML = strUserResult[1];
        //Added By Dipali V On 24th March 2023 For datatable issues
        var ListCount = $("#Filter" + Flag).val()
        datatables('DivAttachmentList', 'txtDivAttachmentList', '', ListCount)
         //End of Added By Dipali V On 24th March 2023 For datatable issues
        makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
            var output = document.querySelector('.demo-droppable');
            output.innerHTML = '';
            for (var i = 0; i < files.length; i++) {
                arrFile[0] = files[i];
                output.innerHTML += '<p>' + files[i].name + '</p>';
            }
        });
        //Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red
        if (strUser[1] == 0) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strUser[0], 'error', 15);
        }
        else {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strUser[0], 'success', 15);
        }
        //End of Commented and Added by Ankush T on 04-April-2019 for Alertify should be in red
        //Added By Dipali V On 24th March 2023 For datatable issues
        var ListCount = $("#Filter" + Flag).val()
        //datatables('DivAttachmentList', 'txtDivAttachmentList', '')
        datatables('DivAttachmentList', 'txtDivAttachmentList', '', ListCount)
        //End of Added By Dipali V On 24th March 2023 For datatable issues
        $('[data-bs-toggle="tooltip"]').tooltip();
    }
    function ShowData(type) {
        if (type == 'List') {
            $("#divSubstoryList").css("display", "")
            $("#divSubstoryForm").css("display", "none")
        }
        else if (type == "Form") {
            $("#divSubstoryList").css("display", "none")
            $("#divSubstoryForm").css("display", "")
        }
    }



    function ShowSprintData(type) {
        if (type == 'List') {
            $("#divSprintList").css("display", "")
            $("#divSprintForm").css("display", "none")
            $("#divRemarks").css("display", "none");
        }
        else if (type == "Form") {
            //Added By Dipali V On 24th March 2023 For datatable issues
            var ListCount = $("#FilterNoTMapped").val()
            datatables('DivNoTMappedSprintlist', 'txtSearchSprint11', '', ListCount)
            //datatables('DivNoTMappedSprintlist', 'txtSearchSprint11', '')
             //End of Added By Dipali V On 24th March 2023 For datatable issues
            $("#divSprintList").css("display", "none")
            $("#divSprintForm").css("display", "")
            $("#divRemarks").css("display", "none");
        }
    }




    function editReleaseName(ReleaseName) {
        //alert();
        // debugger;
        $("#txtReleaseName").prop('disabled', false);
        $("#txtReleaseName").css("border-bottom", "#ddd");
        //  $("#txtReleaseName").val("");
        $("#txtReleaseName").focus();

    }


    function ChangeReleaseName(ReleaseID) {
       // debugger;
        var Flag = "";
        if ($('#txtReleaseName').val() != null) {
            if (checkSpecialCharacter($('#txtReleaseName').val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Release Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtReleaseName").focus();
                return false;
            }
        }
        var result = AJAXCallWithResult("frmReleaseMonitoring.aspx/ChangeReleaseName", JSON.stringify({ ReleaseID: ReleaseID, ReleaseName: $("#txtReleaseName").val() }), false);
        if (result.d != "") {
            EditRelease(ReleaseID, GlobalProjectID)
           //alert(result.d);
            $('#tab_link li').click(function () {
                $('#tab_link li a').css("text-decoration", "none");
                $('#tab_link li a').css("color", "");
                $("a", this).css("text-decoration", "underline");
                $("a", this).css("color", "#60ffa7");


            })
            $(".clsBox").hover(function () {
                $('#tab_link li a').css("text-decoration", "none");
                $('#tab_link li a').css("color", "");
                $("[href=#" + $(this).attr("id") + "]").css("text-decoration", "underline");
                $("[href=#" + $(this).attr("id") + "]").css("color", "#60ffa7");
                //$("[href=#" + $(this).attr("id") + "]").addClass("Selected")
            });


        }
    }
    var Mode = 'Edit';
    function GetDuration(MODE) {
        //debugger;
        var objStart;
        var objEnd;
        Mode = MODE;

        if (MODE == "Release") {
            objStart = document.getElementById("RstartDate");
            objEnd = document.getElementById("txtEndDate");
        }
        else {
            objStart = document.getElementById("SprintStartdate");
            objEnd = document.getElementById("SprintEnddate");
        }
        var dtstart = new Date(objStart.value);
        var dtend = new Date(objEnd.value);
        if (isNaN(dtstart.getTime()) && isNaN(dtend.getTime())) {
        }
        else {
            if (objStart.value != "" && objEnd.value != "") {
                var url = "frmReleasePlanning.aspx/GetDuration"
                var data = JSON.stringify({ strStartDate: objStart.value, strEndDate: objEnd.value })
                AJAXCall(url, data, bindDuration);
            }
        }
    }


    function AJAXCall(url, data, method) {
        $.ajax({
            type: "POST",
            url: url,
            data: data,
            dataType: "json",
            contentType: "application/json",
            //timeout:180000,
            success: function (result) {
                method(result);
                $(".loadingoverlay", parent.document).css("display", "none");
                // Stop();
            },
            error: function (xhr, status, error) {
                // Stop();
                StopAjaxLoader("body");
                $(".loadingoverlay", parent.document).css("display", "none");
                console.log(xhr.responseText);
                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
            }
        });

    }

    function bindDuration(result) {
        //debugger;
        var strArray = String(result.d).split("|");
        if (Mode == "New") {
            document.getElementById("txtDuration").value = strArray[0];
            document.getElementById("txtDurationBusiness").value = strArray[1];
        }
        else if (Mode == "Release") {
            document.getElementById("txtRelCalendar").value = "";
            document.getElementById("txtRBusinessDuration").value = "";
            document.getElementById("txtRelCalendar").value = strArray[0];
            document.getElementById("txtRBusinessDuration").value = strArray[1];
        }
        else {
            document.getElementById("txtCalendar").value = strArray[0];
            document.getElementById("txtBusiness").value = strArray[1];
        }
    }






    var GlobalstrIterationID = ""
    function UnmappedSprint(strIterationID, ReleaseID, txtID) {
        $("#" + txtID).val("");
        $("#divRemarks").css("display", "block");
        $("#divSprintList").css("display", "none");
        GlobalstrIterationID = strIterationID

    }


    function TerminateSprint1(ReleaseID, txtID, Flag) {


        var txtRemark = document.getElementById(txtID);
        var spanRemark = document.getElementById("spanRemark" + GlobalstrIterationID);
        if (txtRemark.value != "") {
            var strResult = AJAXCallWithResult("frmReleaseMonitoring.aspx/CheckSprintIsMappedOrNot", JSON.stringify({ strIterationID: GlobalstrIterationID, strReleaseID: ReleaseID }), false);
            if (strResult.d == "2") {
                // obj.disabled=true;

                var result = AJAXCallWithResult("frmReleaseMonitoring.aspx/TerminateSprint", JSON.stringify({ strIterationID: GlobalstrIterationID, strRemark: txtRemark.value, ReleaseID: ReleaseID, Flag: Flag }), false);
                if (result.d != "") {
                    var ResultLefdiv = result.d.split("||")
                    document.getElementById("divSprintList").innerHTML = ResultLefdiv[1];
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Sprint unmapped successfully', 'success', 25);

                    ShowSprintData('List');
                    $("#divRemarks").css("display", "none");
                    txtRemark.value = "";


                }

            }
            else if (strResult.d == "1") {
                // ShowPopup("Release is released.You can not terminate Sprint.");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Release is released.You can not terminate Sprint.', 'error');
                ShowSprintData('List');
            }
            else if (strResult.d == "3") {
                //ShowPopup("You can not terminate Sprint.");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('You can not terminate Sprint', 'error');
                ShowSprintData('List');

            }
            else {
                //   ShowConfirmForCancel(strResult.d,iterationID,userStoryID,txtRemark.value);
            }
        }
        else {

            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please Enter Remark', 'error');
            //$("#" + "txtRemark" + GlobalstrIterationID).css('border-color', 'red');
            //$("#" + "txtRemark" + GlobalstrIterationID).css('border-width', '1px');
            //$("#" + "spanRemark" + GlobalstrIterationID).text("Please Enter Remark");
            return false;
        }
    }



    function Showmore(ReleaseID, Flag) {
        $('[data-bs-toggle="tooltip"]').tooltip();
        AfterRelaseSprintSave(Flag, ReleaseID);

    }
    var AjaxResult;
    function AJAXCallWithResult(url, data, async) {
        $.ajax({
            type: "POST",
            url: url,
            data: data,
            dataType: "json",
            contentType: "application/json",
            //timeout: 180000,
            async: async,
            success: function (result) {
                AjaxResult = result;
                $(".loadingoverlay", parent.document).css("display", "none");
                // Stop();
            },
            error: function (xhr, status, error) {
                //  Stop();
                //  StopAjaxLoader("body");
                $(".loadingoverlay", parent.document).css("display", "none");
                console.log(xhr.responseText);
                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
            }
        });

        return AjaxResult;
    }


    function StartIteration(IterationID) {
        // debugger;
        // alert(IterationID);
        $('#idStartIteration').css('color', '#00a65a');
        var strResult = AJAXCallWithResult("frmReleaseMonitoring.aspx/CheckIterationMappedToUserStory", JSON.stringify({ intIterationID: IterationID }), false)
        if (strResult.d == "") {
            var data = JSON.stringify({ IterationID: IterationID, ProjectID: <%=Session("intProjectID")%> });
            var result = AJAXCallWithResult("frmReleaseMonitoring.aspx/StartIteration", data, false)
            strResultForStatus = result.d;
            //debugger;
            //alert(strResultForStatus);
            var arr = [];
            if (String(strResultForStatus).indexOf("$$$") == -1) {
                arr[0] = strResultForStatus;
            }
            else {
                arr = String(strResultForStatus).split("$$$");
            }


            if (strResultForStatus != "" && arr[1] == "1") {
                //ShowConfirm1(arr[0]);

                //alert(arr[0]);
            }
            else if (strResultForStatus != "" && arr[1] != "1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(arr[0], 'error', 20);
                // $(ui.sender).sortable('cancel');
                return;

            }
            else {

                //alert('Iteration_onClick');
                Iteration_onClick(intIterationID, strIterationName);
            }


        }
        else {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(strResult.d, 'error', 20);
            //ShowPopup(strResult.d);
        }
    }









    //For BurnDown Graph
    function GetLineBurnDown(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

        //debugger
        var ctx = $("#BurnDown" + UniqueID);
        var strResult, data;
        data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetGraphDetails", data, false);

        var strInRate1 = [];
        var strOutRate1 = [];
        var strOutStanding1 = [];
        var arrBackColor1 = [];
        var strLabels1 = [];
        if (strResult.d != "") {
            // debugger;
            $.each(JSON.parse(strResult.d), function (id, object) {
                strLabels1.push(object["EntryDate"]);
                strInRate1.push(object["Planned"]);
                strOutRate1.push(object["Remained"]);
                // strOutStanding1.push(object["OutStanding"]);

                // arrBackColor1.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
            });

        }

        var lineChartData1 = {
            labels: strLabels1,
            datasets: [{
                label: "Planned",
                borderColor: "orange",
                backgroundColor: "orange",
                fill: false,
                data: strInRate1,
                //yAxisID: "y-axis-1",
            }, {
                label: "Remaining",
                borderColor: "#4cae4c",
                backgroundColor: "#4cae4c",
                fill: false,
                data: strOutRate1,
                //yAxisID: "y-axis-2"
            },

            ]
        };
        //options
        var options = {
            responsive: true,
            title: {
                display: true,
                position: "top",
                text: "Burn Down Chart(Efforts)",
                fontSize: 13,
                fontColor: "#111"
            },
             //Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
        tooltips: {
            callbacks: {               
                
                label: function (tooltipItems, data) {
                    //alert(data.datasets[tooltipItems.datasetIndex].label);
                    if (data.datasets[tooltipItems.datasetIndex].label == "Remaining") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                    if (data.datasets[tooltipItems.datasetIndex].label == "Planned") {
                        var HMPlannedEfforts = tooltipItems.yLabel.toFixed(2);
                        HMPlannedEfforts = HMPlannedEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMPlannedEfforts;
                    }
                }
                
            }
        },
        //End Of Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
            legend: {
                display: true,
                position: "bottom",
                labels: {
                    fontColor: "#333",
                    // <!-- Modified By Madhuri.K On 02-04-2026 --> 
                    fontSize: 11.5
                }
            },


        };


        var chart = new Chart(ctx, {
            type: "line",
            data: lineChartData1,
            options: options
        });

    }
    function GetLineBurnUP(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

        // debugger;

        var ctx1 = $("#BurnUp" + UniqueID);
        // var ctx1 = $("#line-chartcanvas1");
        var strResult, data;
        data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetGraphDetailsStoryPoint", data, false);

        var strInRate1 = [];
        var strOutRate1 = [];
        var strOutStanding1 = [];
        var arrBackColor1 = [];
        var strLabels1 = [];
        if (strResult.d != "") {
            // debugger;
            $.each(JSON.parse(strResult.d), function (id, object) {
                strLabels1.push(object["EntryDate"]);
                strInRate1.push(object["Planned"]);
                strOutRate1.push(object["Remained"]);
            });

        }

        var lineChartData1 = {
            labels: strLabels1,
            datasets: [{
                label: "Planned",
                borderColor: "orange",
                backgroundColor: "orange",
                fill: false,
                data: strInRate1,
                //yAxisID: "y-axis-1",
            }, {
                label: "Remaining",
                borderColor: "#4cae4c",
                backgroundColor: "#4cae4c",
                fill: false,
                data: strOutRate1,
                //yAxisID: "y-axis-2"
            },

            ]
        };
        //options
        var options = {
            responsive: true,
            title: {
                display: true,
                position: "top",
                text: "Burn Down Chart(Story Points)",
                fontSize: 13,
                fontColor: "#111"
            },
            legend: {
                display: true,
                position: "bottom",
                labels: {
                    fontColor: "#333",
                    // <!-- Modified By Madhuri.K On 02-04-2026 --> 
                    fontSize: 11.5
                }
            },
        };




        var chart = new Chart(ctx1, {
            type: "line",
            data: lineChartData1,
            options: options
        });



    }
    //End of BurnDown Graph


    //For Burnup Graph
    function GetLineBurnUPEffortS(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {


        var BurnupGraphEfforts = $("#BurnupGraphEfforts" + UniqueID);
        var strResult, data;
        data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetGetBurnUpChartGraphDetails", data, false);

        var strInRate1 = [];
        var strOutRate1 = [];
        var strOutStanding1 = [];
        var arrBackColor1 = [];
        var strLabels1 = [];
        if (strResult.d != "") {
            // debugger;
            $.each(JSON.parse(strResult.d), function (id, object) {
                strLabels1.push(object["EntryDate"]);
                strInRate1.push(object["Planned"]);
                strOutRate1.push(object["Remained"]);
                // strOutStanding1.push(object["OutStanding"]);

                // arrBackColor1.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
            });

        }

        var lineChartData1 = {
            labels: strLabels1,
            datasets: [{
                label: "Planned",
                borderColor: "#55acee",
                backgroundColor: "#55acee",
                fill: false,
                data: strInRate1,
                //yAxisID: "y-axis-1",
            }, {
                label: "Remaining",
                borderColor: "#4c66a4",
                backgroundColor: "#4c66a4",
                fill: false,
                data: strOutRate1,
                //yAxisID: "y-axis-2"
            },

            ]
        };
        //options
        var options = {
            responsive: true,
            title: {
                display: true,
                position: "top",
                text: "Burn Up Chart(Efforts)",
                fontSize: 13,
                fontColor: "#111"
            },
        //Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
        tooltips: {
            callbacks: {               
                
                label: function (tooltipItems, data) {
                    //alert(data.datasets[tooltipItems.datasetIndex].label);
                    if (data.datasets[tooltipItems.datasetIndex].label == "Remaining") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                    if (data.datasets[tooltipItems.datasetIndex].label == "Planned") {
                        var HMPlannedEfforts = tooltipItems.yLabel.toFixed(2);
                        HMPlannedEfforts = HMPlannedEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMPlannedEfforts;
                    }
                }
                
            }
        },
        //End Of Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
            legend: {
                display: true,
                position: "bottom",
                labels: {
                    fontColor: "#333",
                    // <!-- Modified By Madhuri.K On 02-04-2026 --> 
                    fontSize: 11.5
                }
            },
            scales: {
                xAxes: [{
                    ticks: {
                        // autoSkip: false,
                        // maxRotation: 90,
                        // minRotation: 90
                    }
                }],
                yAxes: [{
                    // type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                    display: true,
                    //position: "left",
                    //id: "y-axis-1",
                    ticks: {
                        min: 0
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Efforts'
                    }
                    //}, {
                    //    //type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                    //    display: true,
                    //  //  position: "right",
                    //  //  id: "y-axis-2",
                    //    scaleLabel: {
                    //        display: true,
                    //        // labelString: 'cumulative % (0-100%)'
                    //    }
                }],
            }
        };

        var chart = new Chart(BurnupGraphEfforts, {
            type: "line",
            data: lineChartData1,
            options: options
        });

    }
    function GetLineBurnDownStoryPoints(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {



        var BurnupGraphStoryPoints = $("#BurnupGraphStoryPoints" + UniqueID);
        // var ctx1 = $("#line-chartcanvas1");
        var strResult, data;
        data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetBurnUpStoryPoint", data, false);

        var strInRate1 = [];
        var strOutRate1 = [];
        var strOutStanding1 = [];
        var arrBackColor1 = [];
        var strLabels1 = [];
        if (strResult.d != "") {
            // debugger;
            $.each(JSON.parse(strResult.d), function (id, object) {
                strLabels1.push(object["EntryDate"]);
                strInRate1.push(object["Planned"]);
                strOutRate1.push(object["Remained"]);
                // strOutStanding1.push(object["OutStanding"]);

                // arrBackColor1.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
            });

        }

        var lineChartData1 = {
            labels: strLabels1,
            datasets: [{
                label: "Planned",
                borderColor: "#55acee",
                backgroundColor: "#55acee",
                fill: false,
                data: strInRate1,
                //yAxisID: "y-axis-1",
            }, {
                label: "Remaining",
                borderColor: "#4c66a4",
                backgroundColor: "#4c66a4",
                fill: false,
                data: strOutRate1,
                //yAxisID: "y-axis-2"
            },

            ]
        };
        //options
        var options = {
            responsive: true,
            title: {
                display: true,
                position: "top",
                text: "Burn Up Chart(Story Points)",
                fontSize: 13,
                fontColor: "#111"
            },
            legend: {
                display: true,
                position: "bottom",
                labels: {
                    fontColor: "#333",
                //    <!-- Modified By Madhuri.K On 02-04-2026 --> 
                    fontSize: 11.5
                }
            },
            scales: {
                xAxes: [{
                    ticks: {
                        // autoSkip: false,
                        // maxRotation: 90,
                        // minRotation: 90
                    }
                }],
                yAxes: [{
                    // type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                    display: true,
                    //position: "left",
                    //id: "y-axis-1",
                    ticks: {
                        min: 0
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Story Points'
                    }
                    //}, {
                    //    //type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                    //    display: true,
                    //  //  position: "right",
                    //  //  id: "y-axis-2",
                    //    scaleLabel: {
                    //        display: true,
                    //        // labelString: 'cumulative % (0-100%)'
                    //    }
                }],
            }
        };




        var chart = new Chart(BurnupGraphStoryPoints, {
            type: "line",
            data: lineChartData1,
            options: options
        });



    }
    //End of Burnup Graph

    //For Velocity Bar Graph
    var preChartVelocity;
    function GetLineVelocityEffortBar(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

        var VelocityEffortBar = document.getElementById("VelocityEffortBar" + UniqueID).getContext("2d");

        var strResult, data;

        data = JSON.stringify({ strGraphFilter: "Effort", UniqueID: UniqueID });

        console.log(data)
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetVelocityData", data, false);
        var strEntityCount = [];
        var PercentCount = [];
        var arrBackColor = [];
        var strLabels = [];
        var r = 0;
        var g = 0;
        var b = 0;
        if (strResult.d != "") {

            $.each(JSON.parse(strResult.d), function (id, object) {
                strLabels.push(object["IterationName"]);
                strEntityCount.push(object["Velocity"]);
                PercentCount.push(object["Efforts"]);
                arrBackColor.push("hsl(" + r + ", 100%, 70%)");
                r += 30;
            });

        }
        //  alert(strEntityCount)
        //   alert(PercentCount)
        var config1 = {
            type: 'bar',
            data: {
                labels: strLabels,
                datasets: [{
                    type: 'bar',
                    label: 'Commited',
                    backgroundColor: 'orange',
                    borderWidth: 1,
                    //fill: false,
                    data: strEntityCount,
                    // yAxisID: "y-axis-2",
                }, {

                    type: 'bar',
                    label: 'Completed',
                    // data: PercentCount,
                    backgroundColor: 'green',
                    borderWidth: 1,
                    data: PercentCount,
                    //  borderColor: 'white',
                    // borderWidth: 2,
                    // yAxisID: "y-axis-1",
                }]
            },

        };


        var options = {
            responsive: true,
            title: {
                display: true,
                position: "top",
                text: "Velocity Bar Graph(Effort)",
                fontSize: 13,
                fontColor: "#111"
            },
            //Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
        tooltips: {
            callbacks: {               
                
                label: function (tooltipItems, data) {
                    //alert(data.datasets[tooltipItems.datasetIndex].label);
                    if (data.datasets[tooltipItems.datasetIndex].label == "Commited") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                    if (data.datasets[tooltipItems.datasetIndex].label == "Completed") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                }
                
            }
        },
        //End Of Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
            
                
            legend: {
                display: true,
                position: "bottom",
                labels: {
                    fontColor: "#333",
                //    <!-- Modified By Madhuri.K On 02-04-2026 --> 
                    fontSize: 11.5
                }
            },
            //scales: {
            //    yAxes: [{
            //        ticks: {
            //            min: 0
            //        }
            //    }]
            //},
            //scaleLabel: {
            //    display: true,
            //    labelString: 'Story Points'
            //}
            scales: {
                xAxes: [{
                    ticks: {
                        // autoSkip: false,
                        // maxRotation: 90,
                        // minRotation: 90
                    }
                }],
                yAxes: [{
                    // type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                    display: true,
                    //position: "left",
                    //id: "y-axis-1",
                    ticks: {
                        min: 0
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Efforts'
                    }
                    //}, {
                    //    //type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                    //    display: true,
                    //  //  position: "right",
                    //  //  id: "y-axis-2",
                    //    scaleLabel: {
                    //        display: true,
                    //        // labelString: 'cumulative % (0-100%)'
                    //    }
                }],
            }
        };

        // Remove the old chart and all its event handles
        if (preChartVelocity) {
            preChartVelocity.destroy();
        }

        // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
        var temp = jQuery.extend(true, {}, config1);
        temp.type = 'bar';
        temp.options = options;
        preChartVelocity = new Chart(VelocityEffortBar, temp);
    };
    var preChartVelocityStoryBar;
    function GetLineVelocityStoryBar(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {

        var VelocitySToryPoints = document.getElementById("VelocitySToryPoints" + UniqueID).getContext("2d");

        var strResult, data;

        data = JSON.stringify({ strGraphFilter: "Storypoint", UniqueID: UniqueID });

        console.log(data)
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetVelocityData", data, false);
        var strEntityCount = [];
        var PercentCount = [];
        var arrBackColor = [];
        var strLabels = [];
        var r = 0;
        var g = 0;
        var b = 0;
        if (strResult.d != "") {

            $.each(JSON.parse(strResult.d), function (id, object) {
                strLabels.push(object["IterationName"]);
                strEntityCount.push(object["Velocity"]);
                PercentCount.push(object["Efforts"]);
                arrBackColor.push("hsl(" + r + ", 100%, 70%)");
                r += 30;
            });

        }

        var config1 = {
            type: 'bar',
            data: {
                labels: strLabels,
                datasets: [{
                    type: 'bar',
                    label: 'Commited',
                    backgroundColor: 'orange',
                    borderWidth: 1,
                    //fill: false,
                    data: strEntityCount,
                    // yAxisID: "y-axis-2",
                }, {

                    type: 'bar',
                    label: 'Completed',
                    // data: PercentCount,
                    backgroundColor: 'green',
                    borderWidth: 1,
                    data: PercentCount,
                    //  borderColor: 'white',
                    // borderWidth: 2,
                    // yAxisID: "y-axis-1",
                }]
            },

        };


        var options = {
            responsive: true,
            title: {
                display: true,
                position: "top",
                text: "Velocity Bar Graph(Story Points)",
                fontSize: 13,
                fontColor: "#111"
            },
            legend: {
                display: true,
                position: "bottom",
                labels: {
                    fontColor: "#333",
                    // <!-- Modified By Madhuri.K On 02-04-2026 --> 
                    fontSize: 11.5
                }
            },
            //scales: {
            //    yAxes: [{
            //        ticks: {
            //            min: 0
            //        }
            //    }]
            //},
            //scaleLabel: {
            //    display: true,
            //    labelString: 'Story Points'
            //}
            scales: {
                xAxes: [{
                    ticks: {
                        // autoSkip: false,
                        // maxRotation: 90,
                        // minRotation: 90
                    }
                }],
                yAxes: [{
                    // type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                    display: true,
                    //position: "left",
                    //id: "y-axis-1",
                    ticks: {
                        min: 0
                    },
                    scaleLabel: {
                        display: true,
                        labelString: 'Story Points'
                    }
                    //}, {
                    //    //type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                    //    display: true,
                    //  //  position: "right",
                    //  //  id: "y-axis-2",
                    //    scaleLabel: {
                    //        display: true,
                    //        // labelString: 'cumulative % (0-100%)'
                    //    }
                }],
            }
        };

        // Remove the old chart and all its event handles
        if (preChartVelocityStoryBar) {
            preChartVelocityStoryBar.destroy();
        }

        // // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
        var temp = jQuery.extend(true, {}, config1);
        temp.type = 'bar';
        temp.options = options;
        preChartVelocityStoryBar = new Chart(VelocitySToryPoints, temp);




    };
    //End  of  Velocity Bar Graph


    //For Flow Efforts Graph
    function GetFlowEfforts(UniqueID, Flag, GrapID, SelectedID, WhichGraph) {


        var FlowGraphEfforts = $("#FlowGraphEfforts" + UniqueID);
        var strResult, data;
        data = JSON.stringify({ UniqueID: UniqueID, Flag: Flag, SelectedID: "Null" });
        strResult = AJAXCallWithResult("frmReleasePlanning.aspx/GetFlowGraph", data, false);

        var strToDO = [];
        var strInProgress = [];
        var strCompleted = [];
        var arrBackColor1 = [];
        var strLabels1 = [];
        if (strResult.d != "") {
            // debugger;
            $.each(JSON.parse(strResult.d), function (id, object) {
                strLabels1.push(object["EntryDate"]);
                strToDO.push(object["ToDo"]);
                strInProgress.push(object["InProgress"]);
                strCompleted.push(object["Completed"]);
            });

        }

        var lineChartData1 = {
            labels: strLabels1,
            datasets: [{
                label: "To-Do List",
                borderColor: "orange",
                backgroundColor: "orange",
                fill: false,
                data: strToDO,
            }, {
                label: "In Progress",
                borderColor: "#5bc0de",
                backgroundColor: "#5bc0de",
                fill: false,
                data: strInProgress,
            },
            {
                label: "Completed",
                borderColor: "green",
                backgroundColor: "green",
                fill: false,
                data: strCompleted,
            }
            ]
        };
        //options
        var options = {
            responsive: true,
            title: {
                display: true,
                position: "top",
                text: "Flow Chart(Flow)",
                fontSize: 13,
                fontColor: "#111"
            },

            legend: {
                display: true,
                position: "bottom",
                labels: {
                    fontColor: "#333",
                    // <!-- Modified By Madhuri.K On 02-04-2026 --> 
                    fontSize: 11.5
                }
            }
        };

        var chart = new Chart(FlowGraphEfforts, {
            type: "line",
            data: lineChartData1,
            options: options
        });

    }

    var data, strResult;

    //function RefreshAllPage()
    //{  

    //    //alert($('#hdnReleaseIDUS').val())
    //    //if($('#hdnReleaseID').val()!=undefined)
    //    //{
    //    //    var ReleaseID = document.getElementById('hdnReleaseID').value;
    //    //}
    //    //if (ReleaseID == "") 
    //    //{
    //    //    ReleaseID = document.getElementById('hdnReleaseIDUS').value;
    //    //}
    //    ////data = JSON.stringify({ ReleaseID: ReleaseID });
    //    ////strResult = AJAXCallWithResult("frmReleasePlanning.aspx/RefreshPage", data, false);
    //    ////if(strResult.d!="")
    //    ////{
    //    ////alert(strResult.d);
    //    ////$("#MainDiv").html("");

    //    //$("#MainDiv").html(strResult.d);

    //    RefreshAllPage();

    //    //}

    //}



    function RefreshAllPage() {


        data = JSON.stringify({ Flag: "AfterLoad" });
        strResult = AJAXCallWithResult("frmReleaseMonitoring.aspx/FilterPlotGrid", data, false);
        if (strResult.d != "") {
            $('[data-bs-toggle="tooltip"]').tooltip();
            $(".edit_release").tooltip();
            $(".delete_release").tooltip();
            $(".fa-ellipsis-v").tooltip();
            $("#btncreate").tooltip();
            $('#myModal_dash').modal('hide');
            refresh();
            $("#PlotDetails").html("");
            $("#PlotDetails").html(strResult.d);
            //Added By Dipali V On 24th March 2023 For Datatable Issue
            if ($("#FilterListCount").val() > 0) {

                datatables('Divlist', 'txtSearchPendingP', '');
            }
            //datatables('divReleases', 'txtSearchRelease', '')
            //End of Added By Dipali V On 24th March 2023 For Datatable Issue
           


        }

    }






    //Edit Release
    var newChartTab;
    var GlobalProjectID = "";
    function EditRelease(ReleaseID, ProjectID) {
        GlobalProjectID = ProjectID
        // alert(GlobalProjectID);
        var strResult = ajaxCall("frmReleaseMonitoring.aspx/Modal_popupdashboard","POST", "application/json", "json", JSON.stringify({ ReleaseID: ReleaseID }));
        var arrResult = strResult.d.split('||');


        $("#DashBody").html("");
        $("#addsprint").html("Update");
        // $("#add_Release").html("");
        $("#addRelease").html("Update");
        //Added By Dipali V On 24th March 2023 For datatable issues
        var ListCount = $("#FilterNoTMapped").val()
        datatables('DivNoTMappedSprintlist', 'txtSearchSprint11', '', ListCount)
        //datatables('DivNoTMappedSprintlist', 'txtSearchSprint11', '')
        //End of Added By Dipali V On 24th March 2023 For datatable issues

        $("#DashBody").html(arrResult[0]);
        //AutoResizeTextArea();
        getRows();

        $("#myModal_dash").modal('show');
        /*Added by kashish For Texarea Enhancement*/

        $("#dashheader").css('display', 'none');
        $('#sprint_details').css("height", ((window.innerHeight / 2) + 50 + 'px'));
        $('#RstartDate,#txtEndDate').datepicker(
            {
                changeMonth: true,
                changeYear: true,
                //Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
                //yearRange: '2000:2020'
                yearRange: 'c-100:c+100'
                //End of Commented And Added By Reshma Chavan on 22 Jan 2021 For Year Range Change
            });
        //Added By Dipali V On 25th Jun 2020 Issue ID 25256

       
             $('#RstartDate,#txtEndDate').prop('readonly', true);
            $("#RstartDate,#txtEndDate").change(function () {
                GetDuration("Release");
            });

        //End of Added By Dipali V On 25th Jun 2020 Issue ID 25256


        $('#tab_link li').click(function () {
            $('#tab_link li a').css("text-decoration", "none");
            $('#tab_link li a').css("color", "");
            $("a", this).css("text-decoration", "underline");
            $("a", this).css("color", "#60ffa7");
            // $("#dashcontent").css("top", "-10px");



        });
        $(".clsBox").hover(function () {
            $('#tab_link li a').css("text-decoration", "none");
            $('#tab_link li a').css("color", "");
            $("[href=#" + $(this).attr("id") + "]").css("text-decoration", "underline");
            $("[href=#" + $(this).attr("id") + "]").css("color", "#60ffa7");
            //$("[href=#" + $(this).attr("id") + "]").addClass("Selected")
            // alert( $(this).attr("id"));
        });

        //if (Flag != undefined) {
        //    setTimeout(function () {
        //        $("[href=#" + Flag + "]").click();
        //        var scrollPos = $("#" + Flag + "").offset().top;

        //        $("#sprint_details").scrollTop(scrollPos - 200);


        //    }, 500)
        //}


        var $li = $('#tab_link a').click(function () {

            var divId = $(this).attr("href").toString();

            divId = divId.replace("#", "");
            $("div").removeClass("activecls");
            //  alert(divId);
            $("#" + divId).addClass("activecls");
        });

        newChartTab = $('#myScrollspy ul li').click(function () {
            newChartTab.removeClass('active');
            $(this).addClass('active');

        });

        $(".tabcontentChart").hover(function () {
            //Commented and Added by Usha PAndit on 13 June 2018 for burn up down button highlight issue
            //$('#myScrollspy ul li a').css("background-color", "white");
            //$('#myScrollspy ul li a').css("color", "black");

            //$("[href=#" + $(this).attr("id") + "]").css("background-color", "#337ab7");
            //$("[href=#" + $(this).attr("id") + "]").css("color", "white");


            $('#myScrollspy ul li').removeClass('active');
            $("[href=#" + $(this).attr("id") + "]").parent().addClass('active');


            $('#myScrollspy ul li a').css("cssText", "background-color:white!important;");
            $('#myScrollspy ul li a').css("cssText", "color:black!important;");


            $('#myScrollspy ul li.active a').css("cssText", "background-color:#337ab7!important;");
            $('#myScrollspy ul li.active a').css("cssText", "color:white!important;");
            //End of Added by Usha PAndit on 13 June 2018 for burn up down button highlight issue
        });
        
        $('#myScrollspy .nav-pills > li > a').on('click', function () {
            var $this = $(this);            
            $('#myScrollspy .nav-pills > li > a').removeClass('active');
            $this.addClass('active');
        }); //Added by pradip on 12-4-2023

        makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
            var output = document.querySelector('.demo-droppable');
            output.innerHTML = '';
            for (var i = 0; i < files.length; i++) {
                arrFile[0] = files[i];
                output.innerHTML += '<p>' + files[i].name + '</p>';
            }
        });


        var $li = $('#tab_link a').click(function () {
            $li.removeClass('selected');
            $(this).addClass('selected');

        });
        $('[data-bs-toggle="tooltip"]').tooltip();
        //   $('.radio-inline').tooltip()
        $("#editReleaseName").tooltip();
        $("#ReleaseSprintPer").tooltip();
        $("#ReleaseSprintNext").tooltip();
        $("#tab_content").tooltip();
        $(".ClsCaptiontooltip").tooltip();
        $(".card-text ").tooltip();

        // document.getElementById("defaultOpen").click();
        // debugger
        GetLineBurnUP(ReleaseID, 'Release', 'divGraph' + ReleaseID, "", "BurnDown");
        GetLineBurnDown(ReleaseID, 'Release', 'divGraph' + ReleaseID, "", "BurnUp");

        GetLineBurnUPEffortS(ReleaseID, 'Release', 'divGraph' + ReleaseID, "", "BurnDown");
        GetLineBurnDownStoryPoints(ReleaseID, 'Release', 'divGraph' + ReleaseID, "", "BurnUp");


        GetLineVelocityEffortBar(ReleaseID, 'Release', 'divGraph' + ReleaseID, "", "BurnDown");
        GetLineVelocityStoryBar(ReleaseID, 'Release', 'divGraph' + ReleaseID, "", "BurnUp");

        GetFlowEfforts(ReleaseID, 'Release', 'divGraph' + ReleaseID, "", "BurnDown");
        GetCompleteCancelSprintSprint(ReleaseID, 'Cancel')
        GetCompleteCancelSprintSprint(ReleaseID, 'Complete')
        //GetFlowStoryPoints(UniqueID,'Release', 'divGraph' + UniqueID, "","BurnUp");


        //Added By Dipali V On 24th March 2023 For datatable issues
    
        var ListCount = $("#FilterCurrentSprintUS").val()
        //datatables('DivCurrentSprintUS', 'txtSearchCurrntSprintUS', '');
        datatables('DivCurrentSprintUS', 'txtSearchCurrntSprintUS', '', ListCount);
         //End of Added By Dipali V On 24th March 2023 For datatable issues
        $("#DivCurrentSprintUS").find(".col-sm-12").css("cssText", "overflow: hidden;width: 100%;"); //Added by Usha Pandit on 08 June 2018 for hiding scrollbar
        $("#DivCurrentSprintUS").find(".dataTables_scroll").css("cssText", "overflow: auto;width: 100%;"); //Added by Usha Pandit on 08 June 2018 for hiding scrollbar
        //Added By Dipali V On 24th March 2023 For datatable issues
        var ListCount = $("#FilterIssuesList").val()
        //datatables('DivSubTabIssuesList', 'txtSearchIssues', '')
        datatables('DivSubTabIssuesList', 'txtSearchIssues', '', ListCount)
        var ListCount = $("#FilterImpedimentsLogsList").val()
        datatables('DivImpedimentsLogsList', 'txtSearchImpediments', '', ListCount)
        var ListCount = $("#FilterRisksList").val()
        datatables('DivRisksList', 'txtSearchRisks', '', ListCount)
        var ListCount = $("#FilterReviewList").val()
        datatables('DivReviewList', 'txtSearchReviews', '', ListCount)
        var ListCount = $("#FilterTaskList").val()
        datatables('DivTaskList', 'txtSearchTask', '', ListCount)
        var ListCount = $("#FilterHistorykList").val()
        datatables('DivHistorykList', 'txtSearchhistory', '', ListCount)
        var ListCount = $("#FilterAttachmentList").val()
        datatables('DivAttachmentList', 'txtDivAttachmentList', '', ListCount)
       //End of Added By Dipali V On 24th March 2023 For datatable issues

        $("#DivImpedimentsLogsList").find(".col-sm-12").css("cssText", "overflow: hidden;width: 100%;"); //Added by Usha Pandit on 08 June 2018 for hiding scrollbar
        $("#DivImpedimentsLogsList").find(".dataTables_scroll").css("cssText", "overflow: auto;width: 100%;"); //Added by Usha Pandit on 08 June 2018 for hiding scrollbar

        $(".fa-ellipsis-v").tooltip();
        $("#btncreate").tooltip();
        //$('input.clscheckbox').on('change', function () 
        //{
        //    $('input.clscheckbox').not(this).prop('checked', false);
        //});

        $('input[name=SelectUnmappedSprintList]').on('change', function () {
            $('input.clscheckbox').not(this).prop('checked', false);
        });

        HighLightChart();
        /*Added by usha Pandit on 13 June 2018 for Scroll Issue */
        if (isIE() == "FF" || isIE() == "IE") {
            //$("#")
            $("#graph").addClass("clsGraphDivWidth");
        }
        else {
            $("#graph").removeClass("clsGraphDivWidth");
        }
        /*End of Added by usha Pandit on 13 June 2018 for Scroll Issue */

        

    }

    function HighLightChart() {

        $('#myScrollspy ul li').click(function () {


            //$('#myScrollspy ul li a').removeClass("activecharttab");
            //$(this).addClass("activecharttab");

            //$('#myScrollspy ul li a').css("background-color", "white");
            //$('#myScrollspy ul li a').css("color", "black");
            //$("[href=#" + $(this).attr("id") + "]").css("background-color", "#337ab7");
            //$("[href=#" + $(this).attr("id") + "]").css("color", "white");

            $('#myScrollspy ul li a').css("cssText", "background-color:white!important;");
            $('#myScrollspy ul li a').css("cssText", "color:black!important;");


            $('#myScrollspy ul li.active a').css("cssText", "background-color:#337ab7!important;");
            $('#myScrollspy ul li.active a').css("cssText", "color:white!important;");

            //$(this).css("cssText", "background-color:#337ab7!important;");
            //$(this).css("cssText", "color:white!important;");
            //$("[href=#" + $(this).attr("id") + "]").css("cssText", "background-color:#337ab7!important;");
            //$("[href=#" + $(this).attr("id") + "]").css("cssText", "color:white!important;");



        });

        $('#myScrollspy ul li a').click(function () {


            //$('#myScrollspy ul li a').removeClass("activecharttab");
            //$(this).addClass("activecharttab");

            //$('#myScrollspy ul li a').css("background-color", "white");
            //$('#myScrollspy ul li a').css("color", "black");
            //$("[href=#" + $(this).attr("id") + "]").css("background-color", "#337ab7");
            //$("[href=#" + $(this).attr("id") + "]").css("color", "white");

            $('#myScrollspy ul li a').css("cssText", "background-color:white!important;");
            $('#myScrollspy ul li a').css("cssText", "color:black!important;");


            $('#myScrollspy ul li.active a').css("cssText", "background-color:#337ab7!important;");
            $('#myScrollspy ul li.active a').css("cssText", "color:white!important;");


            //$(this).css("cssText", "background-color:#337ab7!important;");
            //$(this).css("cssText", "color:white!important;");
            //$("[href=#" + $(this).attr("id") + "]").css("cssText", "background-color:#337ab7!important;");
            //$("[href=#" + $(this).attr("id") + "]").css("cssText", "color:white!important;");



        });
    }

    var strFlag = "";
    function Save_SubTab_Data(UserStoryID, SubTabFlag) {
        if (SubTabFlag == "MappedSprint") {
            // debugger;
            var SelectUnmappedSprintList = "";

            SelectUnmappedSprintList = $('input[name=SelectUnmappedSprintList]:checked').map(function () {
                return this.value;
            }).get().join(',');

            if (SelectUnmappedSprintList.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select at least one Sprint', 'error');
                return;
            }

            var ProjectID = document.getElementById('hdnProjectID').value;
            // debugger;
            var data;

            if (UserStoryID != "") {
                $.ajax({
                    url: "frmReleaseMonitoring.aspx/CheckReleaseDates",
                    data: JSON.stringify({ strIterationID: SelectUnmappedSprintList, strReleaseID: UserStoryID, strProjectID: ProjectID }),
                    type: "POST",
                    contentType: "application/json;charset-utf=8",
                    dataType: "json",
                    success: function (result) {
                        var strTextReleaseStartDate;
                        var strTextReleaseEndDate;
                        var strTextisValid;
                        var strText;
                        var arrStr;
                        //alert(result.d);
                        strText = String(result.d);
                        arrStr = strText.split(",");
                        strTextisValid = arrStr[0];
                        strTextReleaseStartDate = arrStr[1];
                        strTextReleaseEndDate = arrStr[2];
                        //     alert(arrStr[4]);

                        if (arrStr[4] == 1) {
                            //ShowPopup("ITERATIONMAPPING");
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('ITERATIONMAPPING.', 'error');
                            //$(ui.sender).sortable("cancel");
                            // $(ui.sender).sortable("cancel");
                            return;
                        }

                        if (arrStr[5] == "Sprint Cancelled") {
                            //ShowPopup("Selected sprint is cancelled, you can not map cancelled sprint to release.");
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('Selected sprint is cancelled, you can not map cancelled sprint to release.', 'error');
                            //  $(ui.sender).sortable("cancel");
                            return;
                        }

                        if (arrStr[6] == "1") {
                            // ShowPopup("Release is already started, you can not map sprint to release.");
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('Release is already started, you can not map sprint to release.', 'error');
                            // $(ui.sender).sortable("cancel");
                            return;
                        }

                        else if (strTextisValid == 0) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('Start Date and End Date should be between Release Dates i.e.' + strTextReleaseStartDate + " and " + strTextReleaseEndDate, 'error');
                            // ShowPopup("Start Date and End Date should be between Release Dates i.e. " + strTextReleaseStartDate + " and " + strTextReleaseEndDate);
                            //  $(ui.sender).sortable("cancel");
                            return;
                        }

                        var data = JSON.stringify({ SelectedSprint: SelectUnmappedSprintList, ReleaseID: UserStoryID });
                        var result = ajaxCall("frmReleaseMonitoring.aspx/SaveUnmappedSprinttoRelease", "POST", "application/json", "json", data);
                        var Resultsplit = result.d.split("||");


                        // alert(Resultsplit[0]);
                        // alert(Resultsplit[1]);
                        if (Resultsplit[0] != 0) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('Sprint added successfully', 'success', 25);
                            document.getElementById("divSprintList").innerHTML = Resultsplit[1];
                        }
                        ShowSprintData('List');
                    }
                });
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Before map sprint ,you should  first create release', 'error');
                // $(ui.sender).sortable("cancel");
                return;
            }









            // document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 150) + 'px'

        }
    }

    function AddNewDiscussion(UniqueID, Flag, obj, txtID) {

        var DiscussionID = 0; strnewDiscussionID = 0;
        if ($("#txtDiscussions").val() != "") {
            var strUserResult = ajaxCall("frmReleaseMonitoring.aspx/SaveDiscussion", "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag }));
            document.getElementById("divDiscussionListSprintRelease").innerHTML = strUserResult.d;
            $("#spanpost").html('');
            /*Added by kashish For Texarea Enhancement*/
            AutoResizeTextArea();
            $("#spanpost").html('Post');
            $("#txtDiscussions").val('');
             $("#txtDiscussions").prop("placeholder", "Post New Discussion");
            $("#collapse_" + strnewDiscussionID).addClass('in');


            //  $("#FreeTextBox_editor").html('');
            DiscussionID = 0;
            $('[data-bs-toggle="tooltip"]').tooltip();
            $("#SprintReleaseAddDiscussion").attr('disabled');
            $("#txtDiscussions").val("");
        }
        else {
            $("#txtDiscussions").focus();
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please Add Discussion', 'error', 25);
        }

    }

     //Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478
    $("#DiscussionTextArea").keypress(function () {             
            if ($("#DiscussionTextArea").val().length >= 2000) {
               alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Enter Discussion less than 2000 characters.', 'error', 5);
                $("#DiscussionTextArea").focus();
            }
        });
        //End of Added by Chetan M on 21th Aug 2020 for All E Tech Issue ID = 25478

    var DiscussionID = 0;
    var strnewDiscussionID = "";
    function insertSprintReleaseDiscussion(UniqueID, Flag, obj, txtID) {
        if ($("#" + txtID).val() != "") {
           
 //Added by Chetan M on 31st Jully 2020 for Issue ID =25478
             //Commented by Chetan M on 21st Aug 2020 for Issue ID =25478
            //if ($("#" + txtID).val().length >= 2000) {
            //    $("#" + txtID).focus();
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('Please Enter Discussion less than 2000 characters, you have entered ' + $("#" + txtID).val().length + ' characters.', 'error', 5);
            //    return;
            //}
            //else {
            //End of Commented by Chetan M on 21st Aug 2020 for Issue ID =25478
            //End of Added by Chetan M on 31st Jully 2020 for Issue ID =25478
            //Added By Riddhesh Patil on 11-NOV-2022 
            if ($('#txtDiscussions').val() != "") {
                if (checkSpecialCharacter($('#txtDiscussions').val()) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Discussions should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtDiscussions").focus();
                    return false;
                }
            }

            //End of Added By Riddhesh Patil









 var strUserResult = ajaxCall("frmReleaseMonitoring.aspx/SaveDiscussion",
                "POST", "application/json", "json", JSON.stringify({ strUserStoryID: UniqueID, DiscussionComment: $("#" + txtID).val(), DiscussionID: DiscussionID, Flag: Flag }));
            // alert(strUserResult.d);
            if (Flag != "UserStory") {
                // var strDiscussionID =  $("#hdnstrDiscussionID").val();

                // strnewDiscussionID =strDiscussionID - 1;
                //  alert(strnewDiscussionID);
                document.getElementById("divDiscussionListSprintRelease").innerHTML = strUserResult.d;
                /*Added by kashish For Texarea Enhancement*/
                //AutoResizeTextArea();

                $("#spanpost").html('');
                $("#spanpost").html('Post');
                // $("#SprintRelease").css("display","block");
                $("#txtDiscussion").val('');
                // debugger;
                $("#collapse_" + strnewDiscussionID).addClass('in');
                $("#collapse_" + strnewDiscussionID).focus();
            }
            else {
                document.getElementById("divDiscussionList").innerHTML = strUserResult.d;
                $("#btnSend").html('');
                $("#btnSend").html('Post');
                $("#txtDiscussions").val('');
                $("#collapse_" + strnewDiscussionID).addClass('in');
            }

                //  $("#FreeTextBox_editor").html('');
                DiscussionID = 0;
                $('[data-bs-toggle="tooltip"]').tooltip();
                //Added by Chetan M on 31st Jully 2020 for Issue ID =25478
             //Commented by Chetan M on 21st Aug 2020 for Issue ID =25478
            //}
             //End of Commented by Chetan M on 21st Aug 2020 for Issue ID =25478
            //End of Added by Chetan M on 31st Jully 2020 for Issue ID =25478

        }
        else {
            $("#" + txtID).focus();
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please Enter Discussion', 'error', 25);
            return;
        }
    }

    function reply_onclick(userstoryID, discussionID, Flag) {
        //if ($("#DiscussionTextArea").val() != "") {
        /*Added by kashish For Texarea Enhancement*/
        AutoResizeTextArea();
        strnewDiscussionID = discussionID;
        $("#txtDiscussions").focus();
        $("#spanpost").html('Reply');
         $("#txtDiscussions").prop("placeholder", "Reply New Discussion");
        DiscussionID = discussionID;
        //$("#SprintReleaseAddDiscussion").css('display','block');
        $("#SprintReleaseAddDiscussion").removeAttr('disabled');

    }


    var isValidTypeExeCheckFlag = false;
    var ValidateFileExtension = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
    async function UploadData(userStoryID) {

        //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not


        if (arrFile[0] != "") {
            var objtxtFileName = arrFile[0].name;
            var objFile = objtxtFileName;
            var fileName = objtxtFileName;
            var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();


            isValidTypeExeCheck = false;
            //var fileName = arrFile[0];
            //    var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

            //  var objFileName = arrFile[0] ;
            isValidTypeExeCheck = false;
            //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
            const ValidExtsExe = ValidateFileExtension.split(",");
            isValidTypeExeCheck = ValidExtsExe.includes(extension);

            if (isValidTypeExeCheck) {
                const file = arrFile[0];
                //const error = await validateDocFileForExe(file);
                //console.log(error);
                //await checkFileForExe(file);
                await validateDocFileForExe(file)
                    .then(() => {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("File is valid and ready to upload.");
                        isValidTypeExeCheckFlag = true
                    })
                    .catch(error => {
                        console.log(error);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                        $(".demo-droppable p").text("Drag files here or click to upload");
                        arrFile = [];
                        isValidTypeExeCheck = false;
                        isValidTypeExeCheckFlag = false;
                        $(objtxtFileName).val("");
                        /*$(objFileName).attr("placeholder", "Upload File");*/
                        //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                        return;
                    });



                if (!isValidTypeExeCheck) {
                    return;
                }
            }

            //$(objtxtFileName).val("");

            //Ended by Parth Godshelwar
        }





            //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
        // debugger;
        if (arrFile[0] != undefined) {
            var formdata = new FormData();
            formdata.append('file', arrFile[0]);
            formdata.append('Mode', 'Upload');
            formdata.append('UserStoryID', userStoryID);
            $.ajax({
                type: 'post',
                url: 'frmReleaseMonitoring.aspx',
                data: formdata,
                success: function (status) {
                    //  debugger;
                    // alert(status);
                    if (status == "Invalid") {
                        // alert("Invalid content type!");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Invalid content type!", 'error', 25);
                    }
                    else {
                        document.getElementById("divAttachmentList").innerHTML = status;
                        //Added By Dipali V On 24th March 2023 For Datatable Issue
                        var listcount = $("#FilterAttachmentList").val();
                        datatables('DivAttachmentList', 'txtDivAttachmentList', '', listcount)
                        //End of Added By Dipali V On 24th March 2023 For Datatable Issue
                        $('[data-bs-toggle="tooltip"]').tooltip();

                        makeDroppable(window.document.querySelector('.demo-droppable'), function (files) {
                            var output = document.querySelector('.demo-droppable');
                            output.innerHTML = '';
                            for (var i = 0; i < files.length; i++) {
                                arrFile[0] = files[i];
                                output.innerHTML += '<p>' + files[i].name + '</p>';
                            }
                        });

                        // $('.radio-inline').tooltip()
                    }
                    arrFile = [];
                },
                processData: false,
                contentType: false,
                error: function (error) {
                    //alertify.set('notifier', 'position', 'top-right');
                    // alertify.notify("oops something went wrong!", 'error', 25);
                    // alert("oops something went wrong!");
                    alertify.notify("Invalid content type!", 'error', 25);
                    // alert(error.status);
                    // alert(error.responseText);
                }
            });
        }

        else {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("Please select file to  Upload", 'error', 25);


        }


        //  document.getElementById("leftTree").style.height = ((window.innerHeight / 2) + 140) + 'px';
        //if (arrFile[0] == undefined) {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify("Please Upload file!", 'error', 25);
        //}
    }

    var SelectedReleasID = "";
    function delete_release(ReleaseID) {
        SelectedReleasID = ReleaseID;
        // alert(ReleaseID);
        var strUserResult = ajaxCall("frmReleaseMonitoring.aspx/DeleteEntryValidation",
            "POST", "application/json", "json",
            JSON.stringify({ ReleaseID: ReleaseID }));
        var Result = strUserResult.d.split("||")
        if (Result[0] != "") {
            // alert(Result[0]);
            if (Result[0] == "0") {

                $("#ReleaseDetails").html("");
                $("#ReleaseDetails").html(Result[1]);
                //Added By Dipali V On 24th March 2023 For Datatable Issue
                var listcount = $("#FilterListCount").val();
                datatables('divReleases', 'txtSearchRelease', '', listcount)
                 //End of Added By Dipali V On 24th March 2023 For Datatable Issue
                $('[data-bs-toggle="tooltip"]').tooltip();
                $(".edit_release").tooltip();
                $(".delete_release").tooltip();
                $(".fa-ellipsis-v").tooltip();
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Release Deleted Successfully', 'success');
                //alertify.set('notifier', 'position', 'top-right');
                //alertify.notify('Release Deleted Successfully', 'Success', 25);
            }

        }
    }



    function ShowConfirm(strMessage) {
        //  alert(strMessage);
        $('#ConfirmMessage').html(strMessage);
        $("#myModalconfirm").modal({
            backdrop: 'static'
        });
        ConfirmYesNo();
    }
    function ConfirmYesNo() {
        var dfd = jQuery.Deferred();
        var $confirm = $('#myModalconfirm');
        $confirm.modal({
            backdrop: 'static'
        });
        //$('#myModalLabel').html(title);
        //$('#myModalText').html(msg);
        var flag = false;
        $('#divOk').off('click').click(function () {
            var strUserResult = ajaxCall("frmReleaseMonitoring.aspx/DeleteEntryValidation",
                "POST", "application/json", "json",
                JSON.stringify({ ReleaseID: SelectedReleasID }));
            var Result = strUserResult.d.split("||")
            if (Result[0] != "") {

                $("#ReleaseDetails").html("");
                $("#ReleaseDetails").html(Result[1]);
                //Added By Dipali V On 24th March 2023 For Datatable Issue
                var listcount = $("#FilterListCount").val();
                datatables('divReleases', 'txtSearchRelease', '', listcount)
                //End of Added By Dipali V On 24th March 2023 For Datatable Issue
                $('[data-bs-toggle="tooltip"]').tooltip();
                $(".edit_release").tooltip();
                $(".delete_release").tooltip();
                $(".fa-ellipsis-v").tooltip();
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Release Deleted Successfully', 'Success', 25);

            }

            //return 1;
        });
        $('#divClose').off('click').click(function () {
            $("#myModalconfirm").modal('hide');
            return 0;
        });
        return dfd.promise();
    }
    function OpenDropDown(divID) {

    }
    function Status_onChange(Entity) {
        document.getElementById('btnStatus').innerHTML = "";
        document.getElementById('btnStatus').innerHTML = Entity;
    }
    function Export_onclick(EntityID, format) {
        var objform;
        format = format.toUpperCase();
        var strExportResult = ajaxCall("frmReleaseMonitoring.aspx/ExportToExcel", "POST", "application/json", "json", JSON.stringify({ ReportFormat: format, EntityID: EntityID }));

        if (strExportResult.d != "") {
            //alert(strExportResult.d);
        }
        window.open("../CRW/CRW_ReportOutput.aspx?filename=" + strExportResult.d, "_report", "");
    }
    /*Added by kashish For Texarea Enhancement*/
    function AutoResizeTextArea() {
        jQuery.each(jQuery('textarea[data-autoresize]'), function () {
            //var offset = this.offsetHeight - this.clientHeight;

            var resizeTextarea = function (el) {
                //jQuery(el).css('height', 'auto').css('height', el.scrollHeight + offset);
            };
            jQuery(this).on('keyup input', function () {
                if ($(this).attr("id") == "txtDescription") {
                    Maxlength(this, "countdownRelease", 1000);
                }
                //if ($(this).attr("id") == "txtFeatureName") {
                //    Maxlength(this, "countdownFN", 200);
                //}

                resizeTextarea(this);
            }).removeAttr('data-autoresize');


        });
    }
    function AutoGrowTextArea(textField) {
        if (textField.clientHeight < textField.scrollHeight) {
            textField.style.height = textField.scrollHeight + "px";
            if (textField.clientHeight < textField.scrollHeight) {
                textField.style.height =
                    (textField.scrollHeight * 2 - textField.clientHeight) + "px";
            }
        }
    }
    function RemoveTextArea() {
        $('textarea').keydown(function (e) {
            var $this = $(this),
                rows = parseInt($this.attr('rows')),
                lines;

            // on enter
            //if (e.which === 13)
            //    $this.attr('rows', rows + 1);

            // on backspace -- THIS IS THE PROBLEM
            if (e.which === 8 && rows !== 2) {
                lines = $(this).val().split('\n')
                console.log(lines);
                if (!lines[lines.length - 1]) {
                    $this.attr('rows', rows - 1);
                }
            }
        });
    }
    function getRows() {
        //alert(document.getElementById('txtFeatureName').value.split("\n").length);

        if ($("#txtDescription").val() != undefined) {
            var str = document.getElementById("txtDescription").value;
            str = str.replace(/(?!$|\n)([^\n]{120}(?!\n))/g, '$1\n');
            document.getElementById("txtDescription").value = str;
            var lineheight = document.getElementById("txtDescription").value.split("\n").length;
            var height = document.getElementById("txtDescription").rows = lineheight;

            $("#txtDescription").attr("style", "height: auto !important");
        }

        if ($("#txtRemark").val() != undefined) {
            var str = document.getElementById("txtRemark").value;
            str = str.replace(/(?!$|\n)([^\n]{120}(?!\n))/g, '$1\n');
            document.getElementById("txtRemark").value = str;
            var lineheight = document.getElementById("txtRemark").value.split("\n").length;
            var height = document.getElementById("txtRemark").rows = lineheight;
            $("#txtRemark").attr("style", "height: auto !important");
        }

        //var lineheight = document.getElementById('txtDescription').value.split("\n").length;
        //var height = document.getElementById("txtDescription").rows = lineheight;
        //$("#txtDescription").attr("style", "height: auto !important");

    }


    function RefreshTab(SelectedTab, Flag, UniqueID, DivID) {
        data = JSON.stringify({ SelectedTab: SelectedTab, Flag: Flag, UniqueID: UniqueID });
        strResult = AJAXCallWithResult("frmReleaseMonitoring.aspx/ReFreshTab", data, false);
        // alert(strResult.d);
        if (strResult.d != "") {
            $("#" + DivID).html("");
            $("#" + DivID).html(strResult.d);
            //datatables('DivSubTabIssuesList', 'txtSearchIssues', '')
            //datatables('DivImpedimentsLogsList', 'txtSearchImpediments', '')
            //datatables('DivRisksList', 'txtSearchRisks', '')
            //datatables('DivReviewList', 'txtSearchReviews', '')
            //datatables('DivTaskList', 'txtSearchTask', '')
            //datatables('DivHistorykList', 'txtSearchhistory', '')
            //datatables('DivAttachmentList', 'txtDivAttachmentList', '')


            //Added By Dipali V On 24th March 2023 For datatable issues
            var ListCount = $("#FilterIssuesList").val()
            //datatables('DivSubTabIssuesList', 'txtSearchIssues', '')
            datatables('DivSubTabIssuesList', 'txtSearchIssues', '', ListCount)
            var ListCount = $("#FilterImpedimentsLogsList").val()
            datatables('DivImpedimentsLogsList', 'txtSearchImpediments', '', ListCount)
            var ListCount = $("#FilterRisksList").val()
            datatables('DivRisksList', 'txtSearchRisks', '', ListCount)
            var ListCount = $("#FilterReviewList").val()
            datatables('DivReviewList', 'txtSearchReviews', '', ListCount)
            var ListCount = $("#FilterTaskList").val()
            datatables('DivTaskList', 'txtSearchTask', '', ListCount)
            var ListCount = $("#FilterHistorykList").val()
            datatables('DivHistorykList', 'txtSearchhistory', '', ListCount)
            var ListCount = $("#FilterAttachmentList").val()
            datatables('DivAttachmentList', 'txtDivAttachmentList', '', ListCount)
       //End of Added By Dipali V On 24th March 2023 For datatable issues


        }
    }

    //Added by Ashwini M on 3-4-2023
    window.onclick = function (event) {
        if (!event.target.matches('.dropdown-toggle')) {

            var sharedowns = document.getElementsByClassName("dropdown-menu");
            var i;
            for (i = 0; i < sharedowns.length; i++) {
                var openSharedown = sharedowns[i];
                if (openSharedown.classList.contains('show')) {
                    openSharedown.classList.remove('show');
                }
            }
        }
    }
    //End of Added by Ashwini M on 3-4-2023
</script>