<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Main_MD-Highlevel.aspx.vb" Inherits="Whizible.Main_MD_Highlevel" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <!-- Bootstrap 5.3.2 -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css">
    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/Required_Custom.css">

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

.Divsubpages{background:#fff;border-bottom:2px solid #4263c1; margin-bottom:0px; white-space:nowrap; width:97%; float:left; overflow:auto; padding:0px 24px;}
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
    
html, body {
    height: 100%;
    margin: 0;
    overflow: hidden;
    background: #ffffff;
}
form#form1 {
    display: flex;
    flex-direction: column;
    height: 100%;
    margin: 0;
    min-height: 0;
}
.md-shell {
    display: flex;
    flex-direction: column;
    flex: 1 1 auto;
    height: 100%;
    min-height: 0;
    background: #ffffff;
}
.management-dashboard-header {
    align-items: center;
    background: #fff;
    border-bottom: 1px solid #eef2f7;
    box-shadow: rgba(0, 0, 0, 0.06) 0 5px 5px -3px, rgba(0, 0, 0, 0.043) 0 8px 10px 1px, rgba(0, 0, 0, 0.035) 0 3px 14px 2px;
    display: flex;
    justify-content: space-between;
    padding: 1rem 1.25rem;
    flex-shrink: 0;
}
.management-dashboard-title {
    align-items: center;
    color: #1e40af;
    display: flex;
    font-size: 18px;
    font-weight: 600;
    gap: 0.75rem;
    margin: 0 0 0.25rem;
}
.management-dashboard-title i { color: #1e40af; font-size: 1.5rem; }
.management-dashboard-subtitle { color: #6b7280; font-size: 0.72rem; margin: 0; }
.management-dashboard-tabs-wrapper {
    background: #fff;
    border-bottom: 1px solid #e0e0e0;
    margin: 0;
    padding: 0 15px;
    flex-shrink: 0;
}
.management-dashboard-tabs {
    border-bottom: 0;
    display: flex;
    flex-wrap: wrap;
    gap: 5px;
    margin-bottom: 0;
    overflow: hidden;
    white-space: normal;
}
.management-dashboard-tabs::-webkit-scrollbar {
    display: none;
    width: 0;
    height: 0;
}
.management-dashboard-tabs .nav-link {
    align-items: center;
    background: transparent;
    border: 0;
    border-bottom: 2px solid transparent;
    color: #666;
    display: flex;
    font-weight: 400;
    gap: 0.4rem;
    padding: 8px 10px;
}
.management-dashboard-tabs .nav-link:hover { background: #f8fbff; color: #1359a6; }
.management-dashboard-tabs .nav-link.active { background: #f0f7ff; border-bottom-color: #1359a6; color: #1359a6; }
.Divsubpages { display: none !important; }
.InnerpgFrame {
    flex: 1 1 auto;
    width: 100%;
    height: 100%;
    border: 0;
    min-height: 0;
    background: #ffffff;
    display: block;
}
    
        /* MyProfile-style bootstrap-select */
        .fixed-width-combo {
            width: 250px !important;
        }
        .fixed-width-combo + .dropdown-toggle,
        .bootstrap-select.fixed-width-combo {
            width: 250px !important;
            max-width: 100%;
        }
        .bootstrap-select .dropdown-menu {
            z-index: 2000;
        }
        .bootstrap-select .dropdown-menu.show {
            display: block;
        }
        .form-inline .bootstrap-select {
            margin-right: 8px;
        }

    </style>

</head>
<body>
    <form id="form1" runat="server">
       <div class="md-shell">
        <div class="management-dashboard-header">
            <div>
                <h2 class="management-dashboard-title">
                    <i class="fas fa-tachometer-alt"></i>
                    Management Dashboard (High Level)
                </h2>
                <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
                <p class="management-dashboard-subtitle" id="mdHighlevelSubtitle">High-level view of project health, profitability, resource utilization, calendar, and billing metrics -<strong>Details till <%= DateTime.Now.ToString("dd-MM-yyyy") %>.</strong></p>
            </div>
        </div>
        <div class="management-dashboard-tabs-wrapper">
            <ul class="nav nav-tabs management-dashboard-tabs" id="mdHighlevelTabs">
                <li class="nav-item">
                    <a class="nav-link active" href="Project_health_sheet.aspx" target="someFrame">
                        <i class="fas fa-heartbeat"></i> Project Health
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Project_Profitability.aspx" target="someFrame">
                        <i class="fas fa-chart-line"></i> Project Profitability
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="project-profitabilitybycustomer.aspx" target="someFrame">
                        <i class="fas fa-users"></i> Profitability By Customer
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Resource_Utilization.aspx" target="someFrame">
                        <i class="fas fa-user-clock"></i> Resource Utilization
                    </a>
                </li>
                <!-- <li class="nav-item">
                    <a class="nav-link" href="resource-calendarview.html" target="someFrame">
                        <i class="fas fa-calendar-alt"></i> Resource Calendar View
                    </a>
                </li> -->
                <li class="nav-item">
                    <a class="nav-link" href="Management-dashboard-billing.aspx" target="someFrame">
                        <i class="fas fa-file-invoice-dollar"></i> Project Billing
                    </a>
                </li>
            </ul>
        </div>
        <iframe name="someFrame" class="InnerpgFrame" title="Management Dashboard page"></iframe>
    </div>


    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery 3.7.1 -->
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <!-- Bootstrap 5.3.2 -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <!-- bootstrap-select (after Bootstrap) -->
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <!-- Bootstrap 5.3.2 -->
<!-- Bootstrap 5.3.2 -->
<!-- Bootstrap 5.3.2 -->
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>

    <!--chart js-->
    <script src="../../../Whizible2.0-new/plugins/chartjs/chart.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/chartjs-plugin-datalabels.js"></script>

    <script>
        //  <!-- /* Added By Madhuri.K on 24-08-2026 */ -->
        (function () {
            var d = new Date();
            var dd = ('0' + d.getDate()).slice(-2);
            var mm = ('0' + (d.getMonth() + 1)).slice(-2);
            var el = document.getElementById('mdHighlevelSubtitle');
            if (el) {
                el.textContent = 'High-level view of project health, profitability, resource utilization, calendar, and billing metrics - Details till ' + dd + '-' + mm + '-' + d.getFullYear() + '.';
            }
        })();

        //$("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

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

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        function resizeSection() {
            var used = ($('.management-dashboard-header').outerHeight(true) || 0)
                + ($('.management-dashboard-tabs-wrapper').outerHeight(true) || 0);
            var frameHeight = Math.max($(window).height() - used, 200);
            $('.InnerpgFrame').css({ height: frameHeight + 'px', minHeight: 0 });
        }

                function initDashboardSelectPicker() {
            if (!$.fn.selectpicker) return;
            $('select').each(function () {
                var $select = $(this);
                if ($select.data('selectpicker')) {
                    try { $select.selectpicker('refresh'); } catch (e) { }
                    return;
                }
                $select.addClass('selectpicker form-control fixed-width-combo');
                $select.attr('data-live-search', 'true');
                $select.selectpicker({
                    liveSearch: true,
                    container: 'body',
                    dropupAuto: true,
                    width: '100%'
                });
            });
        }

        $(document).ready(function () {
            initDashboardSelectPicker();

            var $tabs = $('#mdHighlevelTabs .nav-link');
            var defaultPage = 'Project_health_sheet.aspx';
            var requested = (window.location.search.match(/[?&]page=([^&]+)/) || [])[1];
            if (requested) {
                try { requested = decodeURIComponent(requested); } catch (e) { requested = ''; }
            }
            var $match = requested ? $tabs.filter(function () {
                return ($(this).attr('href') || '').toLowerCase() === requested.toLowerCase();
            }).first() : $();
            var startPage = $match.length ? $match.attr('href') : defaultPage;
            $tabs.removeClass('active');
            $tabs.filter('[href="' + startPage + '"]').addClass('active');
            $('.InnerpgFrame').attr('src', startPage);
            resizeSection();

            $tabs.on('click', function () {
                $tabs.removeClass('active');
                $(this).addClass('active');
            });
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

    </form>
</body>
</html>
