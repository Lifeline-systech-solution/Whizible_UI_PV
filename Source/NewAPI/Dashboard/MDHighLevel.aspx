<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MDHighLevel.aspx.vb" Inherits="PbNIT.MDHighLevel" %>

<!DOCTYPE html>
<html>
         <%CommonFunctions.General.PlotPageHeadTag("Resource")%>
        <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
<head>
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
       <link href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" rel="stylesheet" />
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.css?v=2">
        <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">--%>
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css?v=2">
    <!-- animate css -->
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">



</head>
        <style type="text/css">
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        a.clearalllink {
            font-weight: bold;
            margin: 7px 0px 0 8px;
            display: none;
        }

        .filter.pull-right {
            margin: 2px 0 0 8px;
        }

        table tr th {
            vertical-align: middle !important;
        }

            table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before {
                margin-right: 0;
            }

        .notebox {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
        }

        .dropdown-submenu .dropdown-submenu > a:after {
            border-color: transparent transparent transparent #fff;
            border-style: solid;
            border-width: 5px 0 5px 5px;
            content: " ";
            display: block;
            float: right;
            height: 0;
            margin-right: 10px;
            margin-top: 5px;
            width: 0;
        }

        .dropdown-submenu > .dropdown-submenu:hover a:after {
            border-color: transparent transparent transparent #464a4c;
        }

        /*Detailpanel*/
        .Resourcedetailpanel {
            margin: 40px 15px 0;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .pgdetailinner {
            padding: 10px;
        }

        .Resourcedetailpanel .tab-pane {
            padding: 20px 0;
        }

        tr.rowhiglight {
            background: #c3dbff;
        }

        .DisableContent {
            pointer-events: none;
            opacity: 0.5;
        }

            .DisableContent:hover {
                cursor: no-drop;
            }

        .dataTables_scrollBody.DisableContent {
            height: auto !important
        }

        ul.nav.nav-tabs.detailsubtabs {
            background: #f5f5f5;
            margin: -11px -11px;
            padding: 10px 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px 4px 0 0;
        }

        .nav.detailsubtabs > li > a:hover, .nav.nav.detailsubtabs > li > a:active, .nav.nav.detailsubtabs > li > a:focus {
            background: #fff;
            color: #1359ac;
        }

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .dblock {
            display: block;
        }

        /*New css start here*/
        .circleIndicator {
        }

        .ciYellow {
            color: #f4cd0f;
        }

        .ciGreen {
            color: #81cf09;
        }

        .ciRed {
            color: #eb1c24;
        }

        #healthshetprojectList tr th:first-child, #healthshetprojectList tr td:first-child {
            text-align: left;
        }

        #healthshetprojectList tr th, #healthshetprojectList tr th {
            text-align: center;
        }

        .informationtbl tr th {
            text-align: right;
            font-weight: 500;
        }

        .informationtbl th, .informationtbl td {
            padding: 2px 4px;
        }

            .informationtbl td.colan {
                padding: 0px;
            }

        .borderbox {
            padding: 15px 10px 10px;
            border: 1px solid #ddd;
            min-height: 91px;
            margin: 0 0 10px;
            border-radius: 4px;
            background: #f5f5f5;
        }
        /*chartbox css start here*/
        .chartbox {
            position: relative;
            border-radius: 4px;
            background: #fff;
            margin-bottom: 20px
        }

            .chartbox .box-body {
                border: 1px solid #d2d6de;
                box-shadow: 0 1px 1px rgba(0,0,0,0.1);
                padding: 15px
            }

            .chartbox .box-header {
                background: #4263c1;
                color: #fff;
                padding: 10px
            }

                .chartbox .box-header h3 {
                    margin: 0;
                    color: #fff;
                    font-size: 16px
                }

        .bluehighlight {
            background: #0d95d3
        }

        .bluelight {
            background: #87c9eb
        }
        /*chartbox css end here*/


        /*New css end here*/
/*Sub Tab Pages*/

.Divsubpages{background:#fff;border-bottom:2px solid #4263c1; margin-bottom:0px; white-space:nowrap; width:97%; float:left; overflow:auto; /*padding:0px 24px;*/ padding:0px 5px;}
ul.subpageslist{margin:0;padding:0}
.subpageslist li{/*width:200px;*/ display:inline-block;vertical-align:middle;text-align:center;margin:0 -3px 0 0;border-right:1px solid #ddd; position:relative;}
.subpageslist li:last-child{ margin-right:10px;}
.subpageslist li.active a,.subpageslist li:hover a{background:#4263c1;color:#fff}
.subpageslist li a{color:#464a4c;padding:10px 15px 6px;display:block;cursor:pointer}
span.subpgicon{display:block}
span.subpgtitletext{font-size:12px;margin-top:8px;display:block;}
span.subpgicon img{/*filter:opacity(0.5);*/max-width:24px}
.subpageslist>li.active a img,.subpageslist>li:hover a img{filter:invert(1)}
.subpageslist>li.active li a img,.subpageslist>li:hover li a img{filter:unset;}
.subpageslist li.active a span.subpgtitletext,.subpageslist li:hover a span.subpgtitletext{opacity:1}
.subpageslist li:last-child{border-right:none}

.InnerpgFrame{ border:none;}
.triangle_down {
  width: 0;
  height: 0;
  border-left: 8px solid transparent;
  border-right: 8px solid transparent;
  border-top: 8px solid #4263c1;
  font-size: 0;
  line-height: 0;
  position:absolute; left:0; right:0; margin:0 auto; display:none;
}
/*.subpageslist li.active .triangle_down{ display:block}*/

.InnerpgFrame{ border:none;}
        #btn-nav-previous {
            text-align: center;
            color: white;
            cursor: pointer;
            font-size: 24px;
            position: fixed;
            left: 0px;
            top: 0;
            padding: 9px 0px;
            background: rgb(233 233 233 / 80%);
            fill: #FFF;
            width: 24px;
            height: 65px;
            text-indent: -4px;
        }
 #btn-nav-previous:hover{background: rgb(233 233 233 / 100%);}
        #btn-nav-next {
            text-align: center;
            color: white;
            cursor: pointer;
            font-size: 24px;
            position: fixed;
            right: 0px; top:0;
            padding: 9px 0px;
            background: rgb(233 233 233 / 80%);
            fill: #FFF;
            width: 24px;
            height: 65px;
        }
#btn-nav-next:hover{background: rgb(233 233 233 / 100%);}
#btn-nav-previous svg, #btn-nav-next svg{filter: brightness(0.5);}



/*Sub Tab Pages css end*/
.last-item{margin-right: 50px;}
nav#menu-container {height: 67px;overflow: hidden;margin-bottom: 10px;}
.more div i{ color:#000; opacity:0.5;}
.more div:hover i{opacity:1;}
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed">
    <div class="bgwhite">
        <div class="Divsubpages">
            <ul class="subpageslist">
                <li class="active">
                    <a href="'../../../../PTS/PM_SQERT.aspx?Mode=SQERTDetails&txtReportingDate=&optReportingPeriod=0&cboCategoryID=&cboBUID=&cboOUID=&cboProgramID=&cboProjectID=&FromWhere=DB';" class="subpageslistbox" target="someFrame">
                        <span class="subpgicon"><img src="../../../Whizible2.0-new/dist/img/project-health.png" alt="Project Health" /></span>
                        <span class="subpgtitletext">Project health</span>
                    </a>
                    <div id="" class="triangle_down"></div>
                </li>
                <li>
                    <a href="'../../../../PRJPROFIT/ProjectProfitByBGOU.aspx?Action=Menu&FromWhere=MR&MasterTagId=3944'" class="subpageslistbox" target="someFrame">
                        <span class="subpgicon"><img src="../../../Whizible2.0-new/dist/img/project-health-icon.png" alt="Project Health" /></span>
                        <span class="subpgtitletext">Project Profitability</span>
                    </a>
                    <div id="" class="triangle_down"></div>
                </li>
                <li>
                    <a href="'../../../../PRJPROFIT/ProjectProfitablityByCustomer.aspx?Action=Menu&FromWhere=MR&MasterTagId=3947'" class="subpageslistbox" target="someFrame">
                        <span class="subpgicon"><img src="../../../Whizible2.0-new/dist/img/people.png" alt="Project Health" /></span>
                        <span  class="subpgtitletext">Profitability By Customer </span>
                    </a>
                    <div id="" class="triangle_down"></div>
                </li>
                <li>
                    <a href="'../../../../REPORTANDMETRICS/RM_ResourceUtilizationReport.aspx?Mode=Generate&PROJECTREPORT=0&BUID=&OUID=&DUID=&ResourceID=&DateRangeID=10&FromWhere=DB'" class="subpageslistbox" target="someFrame">
                        <span class="subpgicon"><img src="../../../Whizible2.0-new/dist/img/resource-utilization-icon.png" alt="Project Health" /></span>
                        <span class="subpgtitletext">Resource Utilization</span>
                    </a>
                    <div id="" class="triangle_down"></div>
                </li>
                <li>
                    <a href="HR_ResourceCalendarViewPlannedHrs.aspx" class="subpageslistbox" target="someFrame">
                        <span class="subpgicon"><img src="../../../Whizible2.0-new/dist/img/calendar.png" alt="Project Health" /></span>
                        <span class="subpgtitletext">Resource Calendar View</span>
                    </a>
                    <div id="" class="triangle_down"></div>
                </li>
                <li>
                    <a href="'../../../../RFI/RFI_InvoiceDB.aspx?DashboardID=0&FromWhere=MDB'" class="subpageslistbox" target="someFrame">
                        <span class="subpgicon"><img src="../../../Whizible2.0-new/dist/img/billing.png" alt="Project Health" /></span>
                        <span class="subpgtitletext">Project Billing</span>
                    </a>
                    <div id="" class="triangle_down"></div>
                </li>
                <%--<li class="more">
                    <div id="btn-nav-previous">
                        <i class="fas fa-angle-left"></i>
                    </div>
                    <div id="btn-nav-next">
                        <i class="fas fa-angle-right"></i>
                    </div>
                </li>--%>
            </ul>
        </div>

        <!--<iframe name="someFrame" width="100%" height="100%"></iframe>-->
        <iframe name="someFrame" class="InnerpgFrame" width="100%" height="100%"></iframe>
        
    </div>

        <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 2.1.4 -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jQuery-2.1.4.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
    <!-- jqueryUI js -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
    <!-- Bootstrap 3.3.5 -->
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
    <!-- Bootstrap 3.3.5 -->
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <!-- Bootstrap 3.3.5 -->
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables.min.js"></script>

    <!--chart js-->
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/chartjs-plugin-datalabels.js"></script>

    <script>

        //$("[data-toggle='tooltip'], [data-toggle='collapse'], [data-toggle='dropdown']").tooltip();

        function editPHSDetail() {
            //$(".dataTables_scrollBody").css("height", "auto!important");
            $(".Resourcedetailpanel").show();
            $('html,body').animate({
                scrollTop: $(".Resourcedetailpanel").offset().top - 20
            }, 'slow');
            //used for disable grid
            $("#healthshetprojectList_wrapper .dataTables_scrollBody, .profiencyTbllist, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").addClass("DisableContent").parent().css("cursor", "no-drop");
        }
        $(".BGdetalilink").click(function () {
            $(this).closest('tr').addClass('rowhiglight');
        });


        $('.canceldetailpanel').click(function () {
            $('table tr').removeClass('rowhiglight');
            $(".Resourcedetailpanel").hide();
            $("#healthshetprojectList_wrapper .dataTables_scrollBody, .profiencyTbllist, .backbtn, .addbtn, .paginate_button, .deletebtn, .filter").removeClass("DisableContent").parent().css("cursor", "auto");

        });



        //datatable
        $('#healthshetprojectList').dataTable({
            "scrollY": true,
            "scrollX": true,
            "pageLength": 10,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true,

        });

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);
        $('#healthshetprojectList').DataTable().columns.adjust().draw();

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        function resizeSection() {
            var tblheight = $(window).height();
            $('#healthshetprojectList_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 450, "overflow-y": "auto" });
            var Frmheight = $(window).height();
            $('.InnerpgFrame').css({ 'height': tblheight - 84, "overflow-y": "auto" });

            var tblheight = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });

        }
        $(document).ready(function () {
            //Added & Commented By Dipali V On 16th March 2023 For Tagret Project Health Tab On Page Load
            //$('.InnerpgFrame').attr('src', 'project-health.html');
            $('.InnerpgFrame').attr('src', '../../PTS/PM_SQERT.aspx?Mode=SQERTDetails&txtReportingDate=&optReportingPeriod=0&cboCategoryID=&cboBUID=&cboOUID=&cboProgramID=&cboProjectID=&FromWhere=DB');
            //End of Added & Commented By Dipali V On 16th March 2023 For Tagret Project Health Tab On Page Load
            $(".subpageslist").on('click', 'li', function () {
             
                // remove classname 'active' from all li who already has classname 'active'
                $(".subpageslist li").removeClass("active");
                // adding classname 'active' to current click li 
                $(this).addClass("active");
            });


            //$('#btn-nav-previous').click(function () {

            //    event.preventDefault();
            //    $('.Divsubpages').animate({
            //        scrollLeft: "-=300px"
            //    }, "");
            //});

            //$('#btn-nav-next').click(function () {

            //    event.preventDefault();
            //    $('.Divsubpages').animate({
            //        scrollLeft: "+=300px"
            //    }, "");
            //});


        });

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });

       
        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

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

        //$(function () {

        //    var url = window.location.pathname,
        //        urlRegExp = new RegExp(url.replace(/\/$/, '') + "$"); // create regexp to match current url pathname and remove trailing slash if present as it could collide with the link in navigation in case trailing slash wasn't present there
        //    // now grab every link from the navigation
        //    $('.subpageslist li').each(function () {
        //        // and test its normalized href against the url pathname regexp
        //        if (urlRegExp.test(this.href.replace(/\/$/, ''))) {
        //            $(this).addClass('active');
        //        }
        //    });

        //});

       

        //Graph script start Frome Here

        //Total Task vs Completion Status
        var ctx1 = document.getElementById("CompletionstatusGraph");
        var myChart = new Chart(ctx1, {
            type: 'doughnut',
            data: {
                labels: ["10%", "20%", "30%", "40%", "50%"],
                datasets: [{
                    label: '# 1',
                    data: [8, 7, 10, 15, 12],
                    backgroundColor: [
                        'rgba(235, 28, 36, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        '#afd037',
                        '#4bc0c0',

                    ],
                    borderColor: [
                        '#fff',
                        '#fff',
                        '#fff',
                        '#fff',
                        '#fff',

                    ],
                    borderWidth: 0
                }]
            },
            options: {
                cutoutPercentage: 60,
                responsive: false,
                segmentShowStroke: true,
                legend: {
                    display: true,
                    position: 'right',
                    labels: {
                        fontColor: "#000080",
                    }
                },

            }
        });
        //End Graph

        //Delay in days graph start
        var ctx = document.getElementById("DelayinDayschart").getContext("2d");

        var data = {
            labels: ["1Day", "3Day", "5Day", "7Day", "9Day"],
            datasets: [{
                label: "Delay Count",
                text: "label",
                backgroundColor: "#fbb03b",
                data: [2, 3, 6, 0, 1]
            }]
        };

        var tooltipsLabel = ['1Day', '3Day', '5Day', '7Day', '9Day']
        var myBarChart = new Chart(ctx, {
            type: 'bar',
            data: data,
            options: {
                title: {
                    display: true,
                    responsive: true,
                    //text: ''
                },
                barValueSpacing: 20,
                scales: {
                    xAxes: [{
                        maxBarThickness: 50,
                        barPercentage: 0.6,
                    }],
                    yAxes: [{
                        maxBarThickness: 20,
                        ticks: {
                            max: 10,
                            min: 0
                        }
                    }]
                },
                responsive: true,


                plugins: {
                    datalabels: {
                        align: 'end',
                        anchor: 'end',
                        //backgroundColor: function (context) {
                        //    return context.dataset.backgroundColor;
                        //},
                        borderRadius: 4,
                        color: 'white',
                        formatter: function (value) {
                            return value + " % ";
                        }
                    }
                }
            }
        });

        //delay in days graph end

        //Monthly Resource Cost graph start
        var ctx = document.getElementById("MonthlyResourceCostChart").getContext("2d");

        var data = {
            labels: ["Feb19", "Nov20", "Dec21"],
            datasets: [{
                label: "Resource Cost",
                text: "label",
                backgroundColor: "#fbb03b",
                data: [1100, 2100, 250]
            }]
        };

        var tooltipsLabel = ['Dhaka', 'Rajshahi', 'NewYork', 'London']
        var myBarChart = new Chart(ctx, {
            type: 'bar',
            data: data,
            options: {
                title: {
                    display: true,
                    responsive: true,
                    //text: ''
                },
                barValueSpacing: 20,
                scales: {
                    xAxes: [{
                        maxBarThickness: 50,
                        barPercentage: 0.6,
                    }],
                    yAxes: [{
                        maxBarThickness: 20,
                        ticks: {
                            max: 500,
                            min: 0
                        }
                    }]
                },
                responsive: true,


                plugins: {
                    datalabels: {
                        align: 'end',
                        anchor: 'end',
                        //backgroundColor: function (context) {
                        //    return context.dataset.backgroundColor;
                        //},
                        borderRadius: 4,
                        color: 'white',
                        formatter: function (value) {
                            return value + " % ";
                        }
                    }
                }

            }
        });

                //Monthly Resource Cost graph end

                //Graph script end here



    </script>

</body>

</html>