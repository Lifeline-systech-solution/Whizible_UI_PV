<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmProjectDashboard.aspx.vb" Inherits="PbNIT.frmProjectDashboard" %>

<!DOCTYPE html>

<html>
         <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("Project Dashboard")%>
<head runat="server">
<%--    <title>Project Dashboard</title>--%>
                <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->

<%--    <link rel="stylesheet" type="text/css" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
    <link rel="stylesheet" type="text/css" href="assets/css/style.css" />
<%--    <link rel="stylesheet" href="../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/font.css" />--%>
    <link href="css/ProjectDashboard.css?v=1.12" rel="stylesheet" />   
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/updated_versions.css" />

    <script src="assets/js/progressbar.js"></script>
<%--    <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> --%>
    <script src="../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
<%--    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>

   
</head>
     <style>
        .days_left{width: 155px;}
        .panel.panel-default{display:flex}
        #dashboard-stat-tab{width:300px}
        a#status_tab{margin-top:-8px}
        .col-md-4{width:29%}
        .Pageheader{position:relative;top:24px}
/*BS5 Chnages*/
/* .main{ height:auto!important;} */
.main .HeaderFreeze p {margin-bottom: 0px;}
#myChart{ max-height:180px;}
.main .HeaderFreeze .panel.panel-default{margin-bottom: 0px;}
.activity-row{ padding-top:5px;}
#divMain_dash{ overflow:auto !important;}
/*End BS 5 chnages*/

        /* Added By Gauri On 03rd Sep 2024 For Alignment Issue */
        .main{
            height: unset !important;
            overflow: hidden;
        }
        body{
            background-color: #FFF;
            overflow-y: auto;
        }
        /* End of Added By Gauri On 03rd Sep 2024 For Alignment Issue */

    </style>
<body>
    <form id="form1" runat="server">
        <div id="divMain_dash">
            <% ProductDashBoard()%>
        </div>
    </form>
    <script type="text/javascript">
        // Returns an array of maxLength (or less) page numbers
        // where a 0 in the returned array denotes a gap in the series.
        // Parameters:
        //   totalPages:     total number of pages
        //   page:           current page
        //   maxLength:      maximum size of returned array
        function getPageList(totalPages, page, maxLength) {
            if (maxLength < 5) throw "maxLength must be at least 5";

            //function range(start, end) {
            //    return Array.from(Array(end - start + 1), (_, i) => i + start); 
            //}
            function range(start, end) {
                if (Array.from != undefined) {
                    {

                        Array.from = (function () {
                            var toStr = Object.prototype.toString;
                            var isCallable = function (fn) {
                                return typeof fn === 'function' || toStr.call(fn) === '[object Function]';
                            };
                            var toInteger = function (value) {
                                var number = Number(value);
                                if (isNaN(number)) { return 0; }
                                if (number === 0 || !isFinite(number)) { return number; }
                                return (number > 0 ? 1 : -1) * Math.floor(Math.abs(number));
                            };
                            var maxSafeInteger = Math.pow(2, 53) - 1;
                            var toLength = function (value) {
                                var len = toInteger(value);
                                return Math.min(Math.max(len, 0), maxSafeInteger);
                            };

                            // The length property of the from method is 1.
                            return function from(arrayLike/*, mapFn, thisArg */) {
                                // 1. Let C be the this value.
                                var C = this;

                                // 2. Let items be ToObject(arrayLike).
                                var items = Object(arrayLike);

                                // 3. ReturnIfAbrupt(items).
                                if (arrayLike == null) {
                                    throw new TypeError("Array.from requires an array-like object - not null or undefined");
                                }

                                // 4. If mapfn is undefined, then let mapping be false.
                                var mapFn = arguments.length > 1 ? arguments[1] : void undefined;
                                var T;
                                if (typeof mapFn !== 'undefined') {
                                    // 5. else
                                    // 5. a If IsCallable(mapfn) is false, throw a TypeError exception.
                                    if (!isCallable(mapFn)) {
                                        throw new TypeError('Array.from: when provided, the second argument must be a function');
                                    }

                                    // 5. b. If thisArg was supplied, let T be thisArg; else let T be undefined.
                                    if (arguments.length > 2) {
                                        T = arguments[2];
                                    }
                                }

                                // 10. Let lenValue be Get(items, "length").
                                // 11. Let len be ToLength(lenValue).
                                var len = toLength(items.length);

                                // 13. If IsConstructor(C) is true, then
                                // 13. a. Let A be the result of calling the [[Construct]] internal method of C with an argument list containing the single item len.
                                // 14. a. Else, Let A be ArrayCreate(len).
                                var A = isCallable(C) ? Object(new C(len)) : new Array(len);

                                // 16. Let k be 0.
                                var k = 0;
                                // 17. Repeat, while k < len… (also steps a - h)
                                var kValue;
                                while (k < len) {
                                    kValue = items[k];
                                    if (mapFn) {
                                        A[k] = typeof T === 'undefined' ? mapFn(kValue, k) : mapFn.call(T, kValue, k);
                                    } else {
                                        A[k] = kValue;
                                    }
                                    k += 1;
                                }
                                // 18. Let putStatus be Put(A, "length", len, true).
                                A.length = len;
                                // 20. Return A.
                                return A;
                            };
                        }());
                    }
                    if (Array.from != undefined) {
                        return Array.from(Array(end - start + 1), function (_, i) {
                            return i + start;
                        });
                    }
                }
                var sideWidth = maxLength < 9 ? 1 : 2;
                var leftWidth = (maxLength - sideWidth * 2 - 3) >> 1;
                var rightWidth = (maxLength - sideWidth * 2 - 2) >> 1;
                if (totalPages <= maxLength) {
                    // no breaks in list
                    return range(1, totalPages);
                }
                if (page <= maxLength - sideWidth - 1 - rightWidth) {
                    // no break on left of page
                    return range(1, maxLength - sideWidth - 1)
                        .concat([0])
                        .concat(range(totalPages - sideWidth + 1, totalPages));
                }
                if (page >= totalPages - sideWidth - 1 - rightWidth) {
                    // no break on right of page
                    return range(1, sideWidth)
                        .concat([0])
                        .concat(range(totalPages - sideWidth - 1 - rightWidth - leftWidth, totalPages));
                }
                // Breaks on both sides
                return range(1, sideWidth)
                    .concat([0])
                    .concat(range(page - leftWidth, page + rightWidth))
                    .concat([0])
                    .concat(range(totalPages - sideWidth + 1, totalPages));
            }

            $(function () {
                // Number of items and limits the number of items per page
                var numberOfItems = $("#jar #Risk_").length;
                var limitPerPage = 7;
                // Total pages rounded upwards
                var totalPages = Math.ceil(numberOfItems / limitPerPage);
                // Number of buttons at the top, not counting prev/next,
                // but including the dotted buttons.
                // Must be at least 5:
                var paginationSize = 7;
                var currentPage;

                function showPage(whichPage) {
                    if (whichPage < 1 || whichPage > totalPages) return false;
                    currentPage = whichPage;
                    $("#jar #Risk_").hide()
                        .slice((currentPage - 1) * limitPerPage,
                            currentPage * limitPerPage).show();
                    // Replace the navigation items (not prev/next):            
                    $("#pagination_active li").slice(1, -1).remove();

                    //if (!getPageList(totalPages, currentPage, paginationSize).forEach) {
                    // getPageList(totalPages, currentPage, paginationSize).forEach = function(fn, scope) {
                    //     for(var i = 0, len = this.length; i < len; ++i) {
                    //         fn.call(scope, this[i], i, this);

                    //         $("<li>").addClass("page-item")
                    //         .addClass(item ? "current-page" : "disabled")
                    //         .toggleClass("active", this[i] === currentPage).append(
                    //    $("<a>").addClass("page-link").attr({
                    //        href: "#Risk_"}).text(this[i] || "...")
                    //).insertBefore("#next-page");
                    //     }
                    // }
                    //}

                    //    getPageList(totalPages, currentPage, paginationSize).forEach( item => {

                    //        $("<li>").addClass("page-item")
                    //                 .addClass(item ? "current-page" : "disabled")
                    //                 .toggleClass("active", item === currentPage).append(
                    //            $("<a>").addClass("page-link").attr({
                    //                href: "#Risk_"}).text(item || "...")
                    //        ).insertBefore("#next-page");
                    //});

                    getPageList(totalPages, currentPage, paginationSize).forEach(function (item) {
                        return $("<li>").addClass("page-item")
                            .addClass(item ? "current-page" : "disabled")
                            .toggleClass("active", item === currentPage).append(
                                $("<a>").addClass("page-link").attr({
                                    href: "#Risk_"
                                }).text(item || "...")
                            ).insertBefore("#next-page");

                    });

                    // Disable prev/next when at first/last page:
                    $("#previous-page").toggleClass("disabled", currentPage === 1);
                    $("#next-page").toggleClass("disabled", currentPage === totalPages);
                    return true;
                }

                // Include the prev/next buttons:
                $("#pagination_active").append(
                    $("<li>").addClass("page-item").attr({ id: "previous-page" }).append(
                        $("<a>").addClass("page-link").attr({
                            href: "#Risk_"
                        }).text("Prev")
                    ),
                    $("<li>").addClass("page-item").attr({ id: "next-page" }).append(
                        $("<a>").addClass("page-link").attr({
                            href: "#Risk_"
                        }).text("Next")
                    )
                );
                // Show the page links
                $("#jar").show();
                showPage(1);

                // Use event delegation, as these items are recreated later    
                $(document).on("click", "#pagination_active li.current-page:not(.active)", function (e) {
                    e.preventDefault();
                    return showPage(+$(this).text());
                });
                $(document).on("click", "#pagination_active", function (e) {
                    e.preventDefault();
                    //return showPageNew(+$(this).text());
                });
                $("#next-page").on("click", function () {
                    return showPage(currentPage + 1);
                });

                $("#previous-page").on("click", function () {
                    return showPage(currentPage - 1);
                });
            });
        }
    </script>
    <script>
        var chart;
        var WhichTab;
        //var RemainingDays = document.getElementById("hdnRemainingDays").value;
        //var TotalDays = document.getElementById("hdnTotalDays").value;
        //var bar = new ProgressBar.SemiCircle(container_p, {
        //    strokeWidth: 10,
        //    color: '#42c8f4',
        //    trailColor: '#eee',
        //    trailWidth: 10,
        //    easing: 'easeInOut',
        //    duration: 1400,
        //    svgStyle: null,
        //    text: {
        //        value: '',
        //        alignToBottom: false
        //    },

        //    // Set default step function for all animate calls
        //    step: function (state, bar) {
        //        bar.path.setAttribute('stroke', state.color);
        //        var value = Math.round(bar.value() * 100);
        //        if (value === 0) {
        //            bar.setText('');
        //        } else {
        //            bar.setText(RemainingDays);
        //        }

        //        bar.text.style.color = state.color;
        //        return bar.text.style.color;
        //    }
        //});
        //bar.text.style.fontFamily = '"Raleway", Helvetica, sans-serif';
        //bar.text.style.fontSize = '2rem';


        //var remaindays = RemainingDays / 100;
        //if (remaindays > 1)
        //    remaindays = 1;
        //bar.animate(remaindays);

        $(document).ready(function () {

            GetLineStackBar();

            //var url = "frmProjectDashboard.aspx/GetDefaultDropDownValues";
            //data = JSON.stringify({ Type: 'Sprint' });
            //var result = AJAXCallWithResult(url, data, false);
            //GetLineBurnUP(result.d, 'Iteration');
            Filterflag('', 'Sprint');
            $('#sprintTab').addClass('selected');
            GetLinedonut();
            //$("#DivcboUS").css("display", "none")
            //$("#DivcboSprint").css("display", "none")
            //$("#DivcboRelease").css("display", "none")
            //SemiDonutgraph();
        });



        function GetLineBurnUP(EntityID, Entity) {
           // alert(Entity);
            // debugger;
            var ctx1 = document.getElementById("container").getContext("2d");
            // var ctx1 = $("#container");
            // var ctx1 = $("#line-chartcanvas1");
            var strResult, data;
            data = JSON.stringify({ EntityID: EntityID, Entity: Entity });
            strResult = AJAXCallWithResult("frmProjectDashboard.aspx/GetGraphDetails", data, false);
            // alert(strResult.d);
            var strInRate1 = [];
            var strOutRate1 = [];
            var strOutStanding1 = [];
            var arrBackColor1 = [];
            var strLabels1 = [];
            var Available = [];
            var dates = [];
            var noData = 0;
            if (strResult.d != "") {
                // debugger;
                $.each(JSON.parse(strResult.d), function (id, object) {
                    strLabels1.push(object["Duration"]);
                    strInRate1.push(object["Planned"]);
                    strOutRate1.push(object["Remained"]);
                    Available.push(object["Available"]);
                    dates.push(object["EntryDate"]);
                    if (object["EntryDate"] == null)
                        noData = 1;
                    // arrBackColor1.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
                });

            }

            // debugger;
            var lineChartData1 = {
                labels: strLabels1,
                datasets: [{
                    type: "line",
                    label: "Planned",
                    borderColor: "#42c8f4",
                    backgroundColor: "#42c8f4",
                    fill: false,
                    data: strInRate1,

                }, {
                    type: "line",
                    label: "Remaining",
                    borderColor: "#4cae4c",
                    backgroundColor: "#4cae4c",
                    fill: false,
                    data: strOutRate1,
                    //yAxisID: "y-axis-2"
                },

                {
                    label: "Available",
                    borderColor: "#FFCA28",
                    backgroundColor: "#FFCA28",
                    fill: false,
                    data: Available,

                    //yAxisID: "y-axis-2"
                },

                ]
            };
            //options
            var options = {
                responsive: true,
                title: {
                    display: true,
                    //Commented And Added By Usha Pandit On 02.07.2019 for Burn Down Chart graph alignment issue 
                    //position: "top",
                    position: "bottom",
                    //End Of Added By Usha Pandit On 02.07.2019 for Burn Down Chart graph alignment issue 
                    //text: "Burn Down Chart",
                    fontSize: 12,
                    fontColor: "#111"
                },
                tooltips: {
                    callbacks: {
                        //title: function (tooltipItem, data) { return 'Day ' + data.labels[tooltipItem[0].index] + ' : ' + dates[tooltipItem[0].index]; }

                        title: function (tooltipItem, data) {
                            return 'Day ' + data.labels[tooltipItem[0].index] + ' : ' + dates[tooltipItem[0].index];

                        }
                        //Added By Usha Pandit On 25.08.2020 For getting tooltip for Efforts in HH:MM format
                        , label: function (tooltipItems, data) {
                            if (data.datasets[tooltipItems.datasetIndex].label == "Remaining") {
                                var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                                HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                                return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                            }
                            if (data.datasets[tooltipItems.datasetIndex].label == "Available") {
                                    var HMAvailableEfforts = tooltipItems.yLabel.toFixed(2);
                                    HMAvailableEfforts = HMAvailableEfforts.toString().replace(".", ":");
                                    return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMAvailableEfforts;
                            }
                            if (data.datasets[tooltipItems.datasetIndex].label == "Planned") {
                                var HMPlannedEfforts = tooltipItems.yLabel.toFixed(2);
                                HMPlannedEfforts = HMPlannedEfforts.toString().replace(".", ":");
                                return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMPlannedEfforts;
                            }
                        }
                        //End Of Added By Usha Pandit On 25.08.2020 For getting tooltip for Efforts in HH:MM format
                    }
                },
                legend: {
                    display: true,
                    position: "bottom",
                    responsive: true,
                    labels: {
                        fontColor: "#333",
                        fontSize: 12,
                        //boxWidth:10,
                    }
                },
                scales: {
                    xAxes: [{
                        ticks: {
                            autoSkip: false,
                        },
                        scaleLabel: {
                            display: true,
                            labelString: 'Days Remaining'
                        }
                    }],
                    yAxes: [{
                        scaleLabel: {
                            display: true,
                            labelString: 'Work Hrs'
                        }
                    }]
                },
            };

            if (chart) {
                chart.destroy();
            }

            chart = new Chart(ctx1, {
                type: "bar",
                data: lineChartData1,
                options: options
            });

            //if(noData == 1)
            //    NoData(ctx1);
            Chart.plugins.register({
                afterDraw: function (chart) {
                    var isPlot = 0;
                    for (var i = 0; i < chart.config.data.datasets["0"].data.length; i++) {
                        if (chart.config.data.datasets["0"].data[i] > 0) {
                            isPlot = 1;
                        }

                    }

                    if (chart.data.labels.length === 0 || isPlot == 0) {
                        // No data is present
                        var ctx = chart.chart.ctx;
                        var width = chart.chart.width;
                        var height = chart.chart.height
                        chart.clear();

                        ctx.save();
                        ctx.textAlign = 'center';
                        ctx.textBaseline = 'middle';
                        ctx.font = "16px normal 'Helvetica Nueue'";
                        //ctx.fillStyle = "black";
                        if (chart.chart.ctx.canvas.id == "container") {
                            if (WhichTab = "User" && document.getElementById("cboUS").value == "") {
                                ctx.fillText('User stories are not mapped to Sprint.', width / 2, height / 2);
                            }
                            else if (WhichTab = "Sprint" && document.getElementById("cboSprint").value == "") {
                                ctx.fillText('Sprints are not mapped to Release.', width / 2, height / 2);
                            }
                            else if (WhichTab = "Release" && document.getElementById("cboRelease").value == "") {
                                ctx.fillText('Releases are not present on project.', width / 2, height / 2);
                            }
                            else {
                                ctx.fillText('No data to display', width / 2, height / 2);
                            }
                        }
                        else {
                            ctx.fillText('No data to display', width / 2, height / 2);
                        }
                        ctx.restore();

                    }
                }
            });

        }

        function GetLineStackBar() {
            var numberWithCommas = function (x) {
                return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            };



            var strResult, data;
            data = JSON.stringify({});
            console.log(data)
            strResult = AJAXCallWithResult("frmProjectDashboard.aspx/GetStackData", data, false);
            // alert(strResult.d);
            var dates = [];
            var dataPack3 = [];
            var dataPack1 = [];
            var dataPack2 = [];
            if (strResult.d != "") {

                $.each(JSON.parse(strResult.d), function (id, object) {
                    dates.push(object["TransactionDate"]);
                    dataPack1.push(object["NewlyAdded"]);
                    dataPack2.push(object["RemovedFromSprint"]);
                    dataPack3.push(object["MappedToSprint"]);
                    // arrBackColor.push("#" + ((1 << 24) * Math.random() | 0).toString(16));
                });

            }

            // Chart.defaults.global.elements.rectangle.backgroundColor = '#FF0000';
            //debugger
            var bar_ctx = document.getElementById('chartContainer');
            var bar_chart = new Chart(bar_ctx, {
                type: 'bar',
                data: {
                    labels: dates, // responsible for how many bars are gonna show on the chart
                    // create 12 datasets, since we have 12 items
                    // data[0] = labels[0] (data for first bar - 'Standing costs') | data[1] = labels[1] (data for second bar - 'Running costs')
                    // put 0, if there is no data for the particular bar
                    datasets: [{
                        label: 'Newly Added',
                        data: dataPack1,
                        backgroundColor: '#f4429b'
                    }, {
                        label: 'Moved To Sprint',
                        data: dataPack3,
                        backgroundColor: '#FFCA28'
                    }, {
                        label: 'Moved From Sprint',
                        data: dataPack2,
                        backgroundColor: '#8BC34A'
                    }, ]
                },
                options: {
                    responsive: false,
                    legend: {
                        position: 'bottom' // place legend on the right side of chart
                    },

                    scales: {
                        xAxes: [{
                            barPercentage: 0.2,
                            ticks: {
                                autoSkip: false,
                                maxRotation: 90,
                                minRotation: 90
                            },
                            stacked: true // this should be set to make the bars stacked
                        }],
                        yAxes: [{
                            stacked: true // this also..
                        }]
                    }
                }
            }
            );

        }

        function GetLinedonut() {
            var strResult, data;
            data = JSON.stringify({});
            console.log(data)
            strResult = AJAXCallWithResult("frmProjectDashboard.aspx/GetOverallDetails", data, false);
            // alert(strResult.d);
            var strStatus = [];
            var StatusCount = [];
            var arrBackColor = [];

            var objProjectGraph = strResult;
            var ticks = [];
            var dataset = [];
            var columnData = String(objProjectGraph.d).split("|")

            objColor = String(columnData[0]).split(",")

            var objColumnName = String(columnData[1]).split(",")

            for (var i = 0; i < objColor.length - 1; i++) {
                objProjectGraph = String(objColor[i]).split("_")
                strStatus.push(objColumnName[i]);
                StatusCount.push(objProjectGraph[1]);
                arrBackColor.push(objProjectGraph[0]);
            }

            var ctx = document.getElementById("myChart").getContext("2d");

            var config = {
                type: "doughnut",
                data: {
                    labels: strStatus,
                    datasets: [{
                        label: "",
                        data: StatusCount,
                        fill: false,
                        backgroundColor: arrBackColor,
                    }, ]
                },
                options: {
                    legend: {
                        display: true,
                        position: "right",
                        labels: {
                            fontColor: "#333",
                            fontSize: 10
                        }
                    },
                    responsive: true,
                }
            };


            var myChart;
            if (myChart) {
                myChart.destroy();
            }
            var temp = jQuery.extend(true, {}, config);
            temp.type = 'doughnut';
            myChart = new Chart(ctx, temp);
          
        }

        //function SemiDonutgraph() {

        //    var ctx = document.getElementById("SemiDonut");
        //    var RemainingDays = document.getElementById("hdnRemainingDays").value;

        //    var myChart = new Chart(ctx, {
        //        type: 'doughnut',
        //        data: {
        //            labels: ["Remaining Days"],
        //            datasets: [{
        //                label: 'Remaining Days',
        //                data: [RemainingDays],
        //                backgroundColor: [
        //                    'rgba(255, 99, 132, 0.2)',


        //                ],
        //                borderColor: [
        //                    'rgba(255,99,132,1)',


        //                ],
        //                borderWidth: 1
        //            }]
        //        },
        //        options: {
        //            rotation: 1 * Math.PI,
        //            circumference: 1 * Math.PI
        //        }
        //    });



        //}


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
                    //   StopAjaxLoader("body");
                    $(".loadingoverlay", parent.document).css("display", "none");
                    console.log(xhr.responseText);
                    window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

            return AjaxResult;
        }

       var globalFlag = "";
        function Filterflag(object, Flag) {
            WhichTab = Flag;
            globalFlag = Flag;
            if (Flag == "User") {
                $("#DivcboSprint").css("display", "block")
                $("#DivcboUS").css("display", "block")

                $("#DivcboRelease").css("display", "none")
                try {
                    var url = "frmProjectDashboard.aspx/GetDropDownValues"
                    data = JSON.stringify({ Type: 'UserStory', Entity: 'Iteration', UserStoryID: 0, IterationID: 0, ReleaseID: 0 });
                    var result = AJAXCallWithResult(url, data, false);
                    BindDropDown(result, 'Sprint');
                }
                catch (ex) {
                    console.log(ex.message);
                }
            }

            else if (Flag == "Sprint") {
                $("#DivcboUS").css("display", "none")
                $("#DivcboRelease").css("display", "block")
                $("#DivcboSprint").css("display", "block")

                try {
                    var url = "frmProjectDashboard.aspx/GetDropDownValues"
                    data = JSON.stringify({ Type: 'Iteration', Entity: 'Release', UserStoryID: 0, IterationID: 0, ReleaseID: 0 });
                    var result = AJAXCallWithResult(url, data, false);
                    BindDropDown(result, 'Release');
                }
                catch (ex) {
                    console.log(ex.message);
                }
            }

            else if (Flag == "Release") {
                $("#DivcboUS").css("display", "none")
                $("#DivcboSprint").css("display", "none")
                $("#DivcboRelease").css("display", "block");

                try {
                    var url = "frmProjectDashboard.aspx/GetDropDownValues"
                    data = JSON.stringify({ Type: 'Release', Entity: 'Release', UserStoryID: 0, IterationID: 0, ReleaseID: 0 });
                    var result = AJAXCallWithResult(url, data, false);
                    BindDropDown(result, 'Release');
                }
                catch (ex) {
                    console.log(ex.message);
                }

            }


        }
        function CboSprintonChange(selectedSprint) {
            try {
                var url = "frmProjectDashboard.aspx/GetDropDownValues"
                if (selectedSprint == undefined)
                    selectedSprint = 0;

                data = JSON.stringify({ Type: 'UserStory', Entity: 'UserStory', UserStoryID: 0, IterationID: selectedSprint, ReleaseID: 0 });
                var result = AJAXCallWithResult(url, data, false);
                if (globalFlag == 'User')
                    BindDropDown(result, 'US');
                else if (globalFlag == 'Sprint')
                    GetLineBurnUP(selectedSprint, 'Iteration');
            }
            catch (ex) {
                console.log(ex.message);
            }
        }
        function CboReleaseonChange(selectedRelease) {
         
            try {
                var url = "frmProjectDashboard.aspx/GetDropDownValues"
                if (selectedRelease == undefined)
                    selectedRelease = 0;

                data = JSON.stringify({ Type: 'Iteration', Entity: 'Iteration', UserStoryID: 0, IterationID: 0, ReleaseID: selectedRelease });
                var result = AJAXCallWithResult(url, data, false);
                //debugger;
               // alert(globalFlag);
                if (globalFlag == 'Sprint') {
                 
                    BindDropDown(result, 'Sprint');
                }
                else if (globalFlag == 'Release')
                    GetLineBurnUP(selectedRelease, 'Release');
            }
            catch (ex) {
                console.log(ex.message);
            }
        }
        function ChangeUserStory(SelectedUS) {
            //debugger;
            GetLineBurnUP(SelectedUS, 'UserStory');
        }
        function BindDropDown(result, DropDown) {
            var strcbo = DropDown;
           
            var objCbo = document.getElementById("cbo" + strcbo);
            var i = 0;
            var dropid = 0;
            var value = "";
            objCbo.innerHTML = "";
            $.each(JSON.parse(result.d), function (id, obj) {
                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.value = obj.FieldID;
                objOption.text = obj.FieldName;
                if (dropid == 0) {
                    dropid = obj.FieldID;
                    value = obj.FieldName;
                }
            });
            var url = "frmProjectDashboard.aspx/GetDefaultDropDownValues";
            data = JSON.stringify({ Type: DropDown });
            var result = AJAXCallWithResult(url, data, false);

            if (DropDown == "Sprint") {
                if (WhichTab == 'Sprint')
                    GetLineBurnUP(dropid, 'Iteration');
                else if (WhichTab == 'User') {
                    if (result.d == "")
                        CboSprintonChange(dropid);
                    else {
                        objCbo.value = result.d;
                        CboSprintonChange(result.d);
                    }
                }
            }
            else if (DropDown == "Release") {
                if (WhichTab == 'Release') {
                    if (result.d == "")
                        GetLineBurnUP(dropid, 'Release');
                    else {
                        objCbo.value = result.d;
                        GetLineBurnUP(result.d, 'Release');
                    }
                }
                else if (WhichTab == 'Sprint') {
                    if (result.d == "")
                        CboReleaseonChange(dropid);
                    else {
                        objCbo.value = result.d;
                        CboReleaseonChange(result.d);
                    }
                }
            }
            else if (DropDown == "US") {
                ChangeUserStory(dropid);
            }
        }


        var $li = $('.tab_s').click(function () {
            //$("#status_tab").css("text-decoration-color", "red");
            $li.removeClass('selected');

            $(this).addClass('selected');


        });

        function getPageListNew(totalPages, page, maxLength) {
            if (maxLength < 5) throw "maxLength must be at least 5";

            //function range(start, end) {
            //    return Array.from(Array(end - start + 1), (_, i) => i + start); 
            //}
            function range(start, end) {
                if (Array.from != undefined) {
                    {   //Added by Usha Pandit on 12 june 2018 for javascript error Object doesn't support property or method 'from'
                        return Array.from(Array(end - start + 1), function (_, i) {
                            return i + start;
                        });
                    }
                }
                var sideWidth = maxLength < 9 ? 1 : 2;
                var leftWidth = (maxLength - sideWidth * 2 - 3) >> 1;
                var rightWidth = (maxLength - sideWidth * 2 - 2) >> 1;
                if (totalPages <= maxLength) {
                    // no breaks in list
                    return range(1, totalPages);
                }
                if (page <= maxLength - sideWidth - 1 - rightWidth) {
                    // no break on left of page
                    return range(1, maxLength - sideWidth - 1)
                        .concat([0])
                        .concat(range(totalPages - sideWidth + 1, totalPages));
                }
                if (page >= totalPages - sideWidth - 1 - rightWidth) {
                    // no break on right of page
                    return range(1, sideWidth)
                        .concat([0])
                        .concat(range(totalPages - sideWidth - 1 - rightWidth - leftWidth, totalPages));
                }
                // Breaks on both sides
                return range(1, sideWidth)
                    .concat([0])
                    .concat(range(page - leftWidth, page + rightWidth))
                    .concat([0])
                    .concat(range(totalPages - sideWidth + 1, totalPages));
            }

            $(function () {
                // Number of items and limits the number of items per page
                var numberOfItems = $("#jar_imped #Impediment_").length;
                var limitPerPage = 7;
                // Total pages rounded upwards
                var totalPages = Math.ceil(numberOfItems / limitPerPage);
                // Number of buttons at the top, not counting prev/next,
                // but including the dotted buttons.
                // Must be at least 5:
                var paginationSize = 7;
                var currentPage;

                function showPageNew(whichPage) {
                    if (whichPage < 1 || whichPage > totalPages) return false;
                    currentPage = whichPage;
                    $("#jar_imped #Impediment_").hide()
                        .slice((currentPage - 1) * limitPerPage,
                            currentPage * limitPerPage).show();
                    // Replace the navigation items (not prev/next):            
                    $("#pagination_imped li").slice(1, -1).remove();
                    //    getPageListNew(totalPages, currentPage, paginationSize).forEach( item => {
                    //        $("<li>").addClass("page-item_new")
                    //                 .addClass(item ? "current-page_new" : "disabled")
                    //                 .toggleClass("active", item === currentPage).append(
                    //            $("<a>").addClass("page-link_new").attr({
                    //                href: "#Impediment_"}).text(item || "...")
                    //        ).insertBefore("#next-page_new");
                    //});

                    getPageListNew(totalPages, currentPage, paginationSize).forEach(function (item) {
                        return $("<li>").addClass("page-item_new")
                            .addClass(item ? "current-page_new" : "disabled")
                            .toggleClass("active", item === currentPage).append(
                                $("<a>").addClass("page-link_new").attr({
                                    href: "#Impediment_"
                                }).text(item || "...")
                            ).insertBefore("#next-page_new1");

                    });

                    // Disable prev/next when at first/last page:
                    $("#previous-page_new").toggleClass("disabled", currentPage === 1);
                    $("#next-page_new").toggleClass("disabled", currentPage === totalPages);
                    return true;
                }





                // Include the prev/next buttons:
                $("#pagination_imped").append(
                    $("<li>").addClass("page-item_new").attr({ id: "previous-page_new" }).append(
                        $("<a>").addClass("page-link_new").attr({
                            href: "#Impediment_"
                        }).text("Prev")
                    ),
                    $("<li>").addClass("page-item_new").attr({ id: "next-page_new" }).append(
                        $("<a>").addClass("page-link_new").attr({
                            href: "#Impediment_"
                        }).text("Next")
                    )
                );
                // Show the page links
                $("#jar_imped").show();
                showPageNew(1);


                // Use event delegation, as these items are recreated later    
                $(document).on("click", "#pagination_imped li.current-page_new:not(.active)", function (e) {
                    e.preventDefault();
                    return showPageNew(+$(this).text());
                });
                $(document).on("click", "#pagination_imped", function (e) {
                    e.preventDefault();
                    //return showPageNew(+$(this).text());
                });
                $("#next-page_new").on("click", function () {
                    return showPageNew(currentPage + 1);
                });

                $("#previous-page_new").on("click", function () {
                    return showPageNew(currentPage - 1);
                });
            });


            $(document).ready(function () {
                $('[data-bs-toggle="tooltip"]').tooltip();
            });
            function showallviews() {

                if ($("#SpnAllUsers").text() == "View All Users") {
                    $("#SpnAllUsers").html("");
                    $("#SpnAllUsers").html("View less Users");
                }
                else {
                    $("#SpnAllUsers").html("");
                    $("#SpnAllUsers").html("View All Users");
                }
            }
            $(document).ready(function () {
                $("#icnShow").click(function () {
                    //alert("abc");

                    //$("#sidebar").animate({ width: '#icnShow' ,     align: 'center',position:'relative'});
                    //$("#sidebar").animate({
                    //    //left: '100px'
                    //    overflow:'auto'
                    //});
                    //$("#map").toggleClass('#sidebar');
                    //if($("#sidebar").hasClass('shortcutnew')

                    //if ($("#SpnAllUsers1").html() == "<i class='fa fa-arrow-right' id='icnShow'></i>") {
                    //    $("#SpnAllUsers1").html("");
                    //    $("#SpnAllUsers1").html("<i class='fa fa-arrow-left' ></i>");

                    //}
                    //else {
                    //    $("#SpnAllUsers1").html("");
                    //    $("#SpnAllUsers1").html("<i class='fa fa-arrow-left' id='icnShow' ></i>");
                    //}
                    if ($("#icnShow").hasClass('fa-arrow-right')) {
                        $("#icnShow").removeClass('fa-arrow-right');
                        $("#icnShow").addClass('fa-arrow-left');
                    }
                    else {
                        $("#icnShow").addClass('fa-arrow-right');
                        $("#icnShow").removeClass('fa-arrow-left');
                    }
                    //$("#sidebar").toggleClass('shortcutnew');

                    $('a[id="sidebar"]').toggleClass('shortcutnew');
                });

            });
        }
        function Excel_OnClick(format) {
            var strPageName = 'frmProjectDashboard.aspx';
            format = format.toUpperCase();
            var strResult, data;
            var IterationID;

            data = JSON.stringify({ ReportFormat: format });
            strResult = AJAXCallWithResult(strPageName + '/ExportToExcel', data, false);

            if (strResult.d != "") {
            }

            var objStatus, objHRM;
            window.open("../CRW/CRW_ReportOutput.aspx?filename=" + strResult.d, "_report", "");
        }
        ////$("#icnShow").hover(function ()
        ////{
        ////    $(this).css("visibility", "visible");
        ////});
    </script>
</body>
</html>

