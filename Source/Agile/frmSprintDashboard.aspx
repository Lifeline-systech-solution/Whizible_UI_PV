<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmSprintDashboard.aspx.vb" Inherits="PbNIT.frmSprintDashboard" %>

<!DOCTYPE html>

<html>
        <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("")%>
<head runat="server">
<%--    <title></title>
    <meta name='GENERATOR' content='Microsoft Visual Studio.NET 7.0' />
    <meta name='CODE_LANGUAGE' content='Visual Basic 7.0' />
    <meta name='vs_defaultClientScript' content='JavaScript' />
    <meta http-equiv="Cache-Control" content="no-cache" />
    <meta http-equiv="Pragma" content="no-cache/" />
   
    <link href="../../Whizible2.0-new/fontawesome/css/all.css" rel="stylesheet" />--%>
    <link href="css/Sprintdashboard.css?v=1.10" rel="stylesheet" /> 
    <%--<link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/updated_versions.css" />

<%--    <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="js/jquery.nicescroll.js"></script>
    <script src="../General/CommonFunctions.js"></script>

   
</head>
     <style>
        @media only screen and (min-width: 992px) {
            .col-md-5 {
                width: 47.666667%!important;
            }
            .col-sm-5 {
                width: 47.666667%!important;
            }
            .col-md-offset-1 {
                margin-left: 2.24%!important;
            }
            .col-sm-offset-1 {
                margin-left: 2.24%!important;
            }
        }
        @media only screen and (min-width: 768px) {
            .col-sm-offset-1 {
                margin-left: 2.24%!important;
            }
             .col-sm-5 {
                width: 47.666667%!important;
            }
        }
        #issueindetaild{
            height:400px !important;
        }
        /*Added By Usha Pandit On 17.07.2020 for tooltip alignment*/
        .tooltip {
            position: fixed;
        }
        /*End Of Added By Usha Pandit On 17.07.2020 for tooltip alignment*/
          
        .fixed-top{
            display:inherit;
            margin-top: 7px;
        }
        @media only screen and (min-width: 992px) and (max-width: 1240px) {
    input:not([type=button]) {
        margin-top: -14px;
}
         #emplistUL {
             height: 130px;
         }

        .form-control {
    display: block;
    width: 100%;
    height: 36px;
    margin-bottom: 10px;
    padding: 6px 12px;
    font-size: 11.5px;
    line-height: 1.42857143;
    color: #555;
    background-color: #fff!important;
    background-image: none;
    border-top: 0px!important;
    border-right: 0px!important;
    border-left: 0px!important;
    border-bottom: 1px solid #ccc!important;
    border-radius: 0px!important;
}

.dropdown-menu {
    position: absolute;
    top: 100%;
    right: 0;
    z-index: 1000;
    display: none;
    float: left;
    min-width: 160px;
    padding: 5px 6px;
    margin: 2px 0 0;
    font-size: 11.5px;
    text-align: left;
    list-style: none;
    background-color: #fff;
    -webkit-background-clip: padding-box;
    background-clip: padding-box;
    -webkit-box-shadow: 0 6px 12px rgb(0 0 0 / 18%);
    box-shadow: 0 6px 12px rgb(0 0 0 / 18%);
}
        .stage{display:flex}
        #divmain_sprint{margin-top:50px}
        .second-row{display:flex}
        .fullscreeicon{margin-top:-40px;position:relative}
        .modal-header{display:block}
        .modal-title{text-align:center}
        .sprint_card_detail{display:flex}
#divmain_sprint .container-fluid{ height:auto!important;}
/*#divmain_sprint .container-fluid {
    height: auto;
    overflow: auto !important;
}*/
body {
    background-color: #FFF;
    overflow-y: auto;
}
    </style>
<body>
    <form id="frmSprintDashboard" runat="server">
        <div id="divmain_sprint">
            <%WritePage(m_strIterationID)%>
        </div>
    </form>
    
    <!--Modal popup for canvas fullscreen for Category -->
    <div class="modal fade myModalCategory" role="dialog">
        <div class="modal-dialog modal-lg" style=" transform: translate(0px,10px)!important;">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Category</h4>
                </div>
                <div class="modal-body">
                    <canvas id="categorypopup"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!--Modal popup for canvas fullscreen for PlotRiskGraph -->
    <div class="modal fade myModalRisk" role="dialog">
        <div class="modal-dialog modal-lg" style=" transform: translate(0px,10px)!important;">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Impediments/Issues/Risks</h4>
                </div>
                <div class="modal-body">
                    <canvas id="Riskpopup"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!--Modal popup for canvas fullscreen for PlotBurnDownChart -->
    <div class="modal fade myModalBurnDown" role="dialog">
        <div class="modal-dialog modal-lg" style=" transform: translate(0px,10px)!important;">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">BurnDown Chart</h4>
                </div>
                <div class="modal-body">
                    <canvas id="BurnDownPopup"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!--Modal popup for canvas fullscreen for PlotUSTrand -->
    <div class="modal fade myModalUSTrend" role="dialog">
        <div class="modal-dialog modal-lg" style=" transform: translate(0px,10px)!important;">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Top 5 Resources</h4>
                </div>
                <div class="modal-body">
                    <canvas id="USTrendpopup"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!--Modal popup for canvas fullscreen for PlotTaskBoard -->
    <div class="modal fade myModalTaskBoard" role="dialog">
        <div class="modal-dialog modal-lg" style=" transform: translate(0px,10px)!important;">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Task Board</h4>
                </div>
                <div class="modal-body">
                    <canvas id="TaskBoardpopup" width='800'  height='520'></canvas>
                </div>
            </div>
        </div>
    </div>

    <!--Modal popup for canvas fullscreen for PlotIssueGraph -->
    <div class="modal fade myModalIssue" role="dialog">
        <div class="modal-dialog modal-lg" style=" transform: translate(0px,10px)!important;">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Issue In Detailed</h4>
                </div>
                <div class="modal-body">
                    <canvas id="Issuepopup"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!--Modal popup for canvas fullscreen for PlotVelocityGraph -->
    <div class="modal fade myModalVelocity" role="dialog">
        <div class="modal-dialog modal-lg" style=" transform: translate(0px,10px)!important;">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Velocity / Effort</h4>
                </div>
                <div class="modal-body">
                    <canvas id="Velocitypopup"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!--Modal popup for canvas fullscreen for PlotFocusFactorGraph -->
    <div class="modal fade myModalFocusFactor" role="dialog">
        <div class="modal-dialog modal-lg" style=" transform: translate(0px,10px)!important;">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Focus Factor</h4>
                </div>
                <div class="modal-body">
                    <canvas id="FocusFactorpopup"></canvas>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<script>
    var strPageName = 'frmSprintDashboard.aspx';
    var objForm = GetFormReference("frmSprintDashboard");
    $(document).ready(function () {        
        $('[data-bs-toggle="tooltip"]').tooltip();        
        
        $(".Activity").niceScroll({
            scrollspeed: 40
            //A smaller value increases the scroll speed. A larger value makes the scroll speed slower.
        });
        myFunction();
        PlotCategoryGraph('category');
        PlotRiskGraph('issues');
        PlotBurnDownChart('burndown');
        PlotUSTrand('resources');
        PlotTaskBoard('vertical');
        PlotIssueGraph('issueindetaild');
        PlotVelocityGraph('Velocity');
        PlotFocusFactorGraph('FocusFactor')        
    });
    $("#myModalCategory").click(function () {
        PlotCategoryGraph('categorypopup');
    });
    $("#myModalRisk").click(function () {
        PlotRiskGraph('Riskpopup');
    });
    $("#myModalBurnDown").click(function () {
        PlotBurnDownChart('BurnDownPopup');
    });
    $("#myModalUSTrend").click(function () {
        PlotUSTrand('USTrendpopup');
    });
    $("#myModalTaskBoard").click(function () {
        PlotTaskBoard('TaskBoardpopup');
    });
    $("#myModalIssue").click(function () {
        PlotIssueGraph('Issuepopup');
    });
    $("#myModalVelocity").click(function () {
        PlotVelocityGraph('Velocitypopup');
    });
    $("#myModalFocusFactor").click(function () {
        PlotFocusFactorGraph('FocusFactorpopup');
    });

    $('#dropdown-content').on('click', function (e) {
        e.stopPropagation();
    });
    $(document).ready(function () {
        $("#showcountsection").show();
        $("#showpointsection").hide();
       
        $("#point").click(function () {
            $("#count").css("cssText", "text-decoration: none !important;");            //Added by Usha Pandit on 06 Jun 2018 for highlighting Story Point 
            $("#point").css("cssText", "text-decoration: underline !important;");            //Added by Usha Pandit on 07 Jun 2018 for highlighting Story Point 

            $("#showcountsection").hide();
            $("#showpointsection").show();
        });
        $("#count").click(function () {
            $("#count").css("cssText", "text-decoration: underline !important;");      //Added by Usha Pandit on 06 Jun 2018 for highlighting User Story count 
            $("#point").css("cssText", "text-decoration: none !important;");      //Added by Usha Pandit on 06 Jun 2018 for highlighting User Story count 

            $("#showcountsection").show();
            $("#showpointsection").hide();
        });

        $(".fullscreen_icon").tooltip();
        $(".btn-info").tooltip();
    });
    function PlotCategoryGraph(Graph) {
        //Category graph
        var strResult, data;
        var IterationID;

        IterationID = "<%= m_strIterationID%>";
        data = JSON.stringify({ IterationID: IterationID });
        strResult = AJAXCallWithResult(strPageName + '/GetCategoryGraphData', data, false);

        var strCategory = [];
        var CategoryCount = [];
        var arrBackColor = [];
        var r = 0;
        var g = 0;
        var b = 0;
        if (strResult.d != "") {
            $.each(JSON.parse(strResult.d), function (id, object) {
                strCategory.push(object["Category"]);
                CategoryCount.push(object["TotalUS"]);
                arrBackColor.push("hsl(" + r + ", 100%, 70%)");
                r += 30;
            });
        }
        
        new Chart(Graph, {
            type: 'bar',
            data: {
                labels: strCategory,
                datasets: [
                    {
                        label: "",
                        data: CategoryCount,
                        fill: false,
                        backgroundColor: arrBackColor,
                    }
                ]
            },
            options: {
                legend: {
                    display: false,
                    position: 'right',
                },
                title: {
                    display: false,
                    text: 'Category'
                },
                scales: {
                    xAxes: [{
                        barPercentage: 0.2,
                        ticks: {
                            autoSkip: false,
                            maxRotation: 90,
                            minRotation: 90
                        },
                    }],
                    yAxes: [{
                        ticks: {
                            beginAtZero: true   // minimum value will be 0.
                        }
                    }]
                }
            }
        });

       // NoData()
    }
    function PlotRiskGraph(Graph) {
        //Risk graph
        var strResult, data;
        var IterationID;

        IterationID = "<%= m_strIterationID%>";
        data = JSON.stringify({ IterationID: IterationID });
        strResult = AJAXCallWithResult(strPageName + '/GetRiskGraphData', data, false);

        var strEntity = [];
        var EntityCount = [];
        if (strResult.d != "") {
            $.each(JSON.parse(strResult.d), function (id, object) {
                strEntity.push(object["Entity"]);
                EntityCount.push(object["EntityCount"]);
                
            });
        }
        arrBackColor = ["#FFA726", "#F44336", "#29B6F6"];
        new Chart(Graph, {
            type: 'bar',
            data: {
                labels: strEntity,
                datasets: [
                    {
                        label: "",
                        data: EntityCount,
                        fill: false,
                        backgroundColor: arrBackColor,
                    }
                ]
            },
            options: {
                legend: {
                    display: false,
                    position: 'right',
                },
                title: {
                    display: false,
                    text: 'Impediments/Issues/Risks'
                },
                scales: {
                    xAxes: [{
                        barPercentage: 0.2
                    }],
                    yAxes: [
                            {
                                ticks: {
                                    beginAtZero: true   // minimum value will be 0.
                                }
                            }
                    ]
                }
            }
        });
    }
    var burnChart;
    function PlotBurnDownChart(Graph) {
        //Burndown chart
        var ctx1 = Graph;
        var strResult, data;
        var IterationID;

        IterationID = "<%= m_strIterationID%>";
        data = JSON.stringify({ IterationID: IterationID });
        strResult = AJAXCallWithResult(strPageName + '/GetBurnDownChart', data, false);

        var strLabels = [];
        var strPlan = [];
        var strRemain = [];
        var RemainingTask = [];
        var CompletedTask = [];
        var dates = [];
        if (strResult.d != "") {
            $.each(JSON.parse(strResult.d), function (id, object) {
                strLabels.push("Day " + object["Duration"]);
                strPlan.push(object["Planned"]);
                strRemain.push(object["Remained"]);
                RemainingTask.push(object["RemainingTask"]);
                CompletedTask.push(object["CompletedTask"]);
                dates.push(object["EntryDate"]);
            });
        }
        
        var config1 = {
            type: 'bar',
            data: {
                labels: strLabels,
                datasets: [{
                    type: 'line',
                    label: 'Ideal burndown',
                    borderColor: '#33691E',
                    borderWidth: 2,
                    fill: false,
                    data: strPlan,
                    yAxisID: "y-axis-1",
                }, {
                    type: 'line',
                    label: 'Remaining Effort',
                    borderColor: '#01579B',
                    borderWidth: 2,
                    fill: false,
                    data: strRemain,
                    yAxisID: "y-axis-1",
                }, {
                    type: 'line',
                    label: 'Remaining Tasks',
                    borderColor: '#4FC3F7',
                    borderWidth: 2,
                    fill: false,
                    data: RemainingTask,
                    yAxisID: "y-axis-2",
                }, {

                    type: 'bar',
                    label: 'Completed Tasks',
                    backgroundColor: '#FFA726',
                    data: CompletedTask,
                    borderWidth: 2,
                    yAxisID: "y-axis-2",
                }]
            },
            options: {
                title: {
                    display: false,
                    text: 'BurnDown Chart'
                },
                //Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
        tooltips: {
            callbacks: {               
                
                label: function (tooltipItems, data) {
                    //alert(data.datasets[tooltipItems.datasetIndex].label);
                    if (data.datasets[tooltipItems.datasetIndex].label == "Ideal burndown") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                    if (data.datasets[tooltipItems.datasetIndex].label == "Remaining Effort") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                }
                
            }
        },
        //End Of Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
            
                legend: {
                    position: 'bottom' // place legend on the right side of chart
                },
                //Commented By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
                //tooltips: {
                //    callbacks: {
                //        title: function (tooltipItem, data) { return '' + data.labels[tooltipItem[0].index] + ' : ' + dates[tooltipItem[0].index]; }
                //    }
                //},
                //End Of Commented By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
                responsive: true,
                scales: {
                    yAxes: [{
                        type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                        display: true,
                        position: "left",
                        id: "y-axis-1",
                        scaleLabel: {
                            display: true,
                            labelString: 'Effort(hours)'
                        },
                        ticks: {
                            beginAtZero: true   // minimum value will be 0.
                        }
                    }, {
                        type: "linear", // only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
                        display: true,
                        position: "right",
                        id: "y-axis-2",
                        scaleLabel: {
                            display: true,
                            labelString: 'Task(Count)'
                        },
                        ticks: {
                            beginAtZero: true   // minimum value will be 0.
                        }
                    }],
                    xAxes: [{
                        ticks: {
                            autoSkip: false,
                            maxRotation: 90,
                            minRotation: 90
                        }
                    }]
                }
            }
        };

        // Remove the old chart and all its event handles
        //if (burnChart) {
        //    burnChart.destroy();
        //}

        // Chart.js modifies the object you pass in. Pass a copy of the object so we can use the original object later
        var temp = jQuery.extend(true, {}, config1);
        temp.type = 'bar';
        burnChart = new Chart(ctx1, temp);
    }
    function PlotUSTrand(Graph) {
        var strResult, data;
        var IterationID;

        IterationID = "<%= m_strIterationID%>";
        data = JSON.stringify({ IterationID: IterationID });
        strResult = AJAXCallWithResult(strPageName + '/GetUSTrend', data, false);

        var EmployeeName = [];
        var ToDo = [];
        var InProgress = [];
        var Completed = [];
        if (strResult.d != "") {
            $.each(JSON.parse(strResult.d), function (id, object) {
                EmployeeName.push(object["EmployeeName"]);
                ToDo.push(object["ToDoList"]);
                InProgress.push(object["InProgress"]);
                Completed.push(object["Completed"]);
            });

        }

        //var ctx = document.getElementById('resources');

        var myChart = new Chart(Graph, {
            //type: 'horizontalBar',
            type: 'bar',
            data: {
                labels: EmployeeName,
                datasets: [
                  {
                      label: 'ToDo List',
                      data: ToDo,
                      backgroundColor: '#26c6da',
                  },
                  {
                      label: 'In Progress',
                      data: InProgress,
                      backgroundColor: '#FFCA28',
                  },
                  {
                      label: 'Completed',
                      data: Completed,
                      backgroundColor: '#8BC34A',
                  }
                ]
            },
            options: {
                legend: {
                    position: 'bottom' // place legend on the right side of chart
                },
                scales: {
                    xAxes: [{
                        barPercentage: 0.2,
                        stacked: true,
                        scaleLabel: {
                            display: true,
                            labelString: 'US Trend'
                        }
                    }],
                    yAxes: [
                            {
                                stacked: true,
                                ticks: {
                                    beginAtZero: true   // minimum value will be 0.
                                }
                            }
                    ]
                }
            }
        });
    }
    function PlotTaskBoard(Graph) {
        //Task Board
        var strResult, data;
        var IterationID;

        IterationID = "<%= m_strIterationID%>";
        data = JSON.stringify({ IterationID: IterationID });
        strResult = AJAXCallWithResult(strPageName + '/GetPlotTaskBoard', data, false);

        var UserStory = [];
        var Open = [];
        var Delayed = [];
        var Completed = [];
        
        if (strResult.d != "") {
            $.each(JSON.parse(strResult.d), function (id, object) {
                UserStory.push("US ID - " + object["UserStoryID"]);
                Open.push(object["OpenTask"]);
                Delayed.push(object["DelayedTask"]);
                Completed.push(object["CompletedTask"]);
            });

        }
       
        var chart = new Chart(Graph, {
            type: 'bar',
            data: {
                labels: UserStory, // responsible for how many bars are gonna show on the chart
                // create 12 datasets, since we have 12 items
                // data[0] = labels[0] (data for first bar - 'Standing costs') | data[1] = labels[1] (data for second bar - 'Running costs')
                // put 0, if there is no data for the particular bar
                datasets: [{
                    label: 'Open',
                    data: Open,
                    backgroundColor: '#4FC3F7'
                },{
                    label: 'Delayed',
                    data: Delayed,
                    backgroundColor: '#F44336'
                },  {
                    label: 'Completed',
                    data: Completed,
                    backgroundColor: '#8BC34A'
                }
                ]
            },
            options: {
                responsive: true,
                title: {
                    display: false,
                    text: 'Tasks Board'
                },
                legend: {
                    position: 'right' // place legend on the right side of chart
                },
                scales: {
                    xAxes: [{
                        barPercentage: 0.2,
                        stacked: true // this should be set to make the bars stacked
                    }],
                    yAxes: [{
                        stacked: true, // this also..
                        scaleLabel: {
                            display: true,
                            labelString: 'Count'
                        },
                        ticks: {
                            beginAtZero: true   // minimum value will be 0.
                        }
                    }]
                }
            }
        });
    }
    function PlotIssueGraph(Graph) {
        //Issue In Detailed
        var strResult, data;
        var IterationID;

        IterationID = "<%= m_strIterationID%>";
        data = JSON.stringify({ IterationID: IterationID });
        strResult = AJAXCallWithResult(strPageName + '/GetPlotIssueGraph', data, false);

        //var Axis = [];
        //var XAxis = [], Values = [], XAxisLabel = [], YAxisLabel = [];
        //Axis = String(strResult.d).split("^^")
        //XAxis = String(Axis[0]).split("??")
        //Values = String(Axis[1]).split("??")
        
        ////XAxisLabel = String(XAxis[0]).split("|")
        //var UserStory = [];
        //var rows = String(XAxis[0]).split(",")
            
        //for (var j = 0; j < rows.length - 1; j++) {
        //    UserStory.push(rows[j])
        //}
        
        //var Employee = [];
        //var EmployeeCount = [];
        
        //var rows = String(Values[0]).split(",")
        //var cols = String(Values[1]).split(",")
        //for (var j = 0; j < rows.length - 1; j++) {
        //    EmployeeCount.push(rows[j])
        //}
        //for (var j = 0; j < cols.length - 1; j++) {
        //    Employee.push(cols[j])
        //}
        //var datasetValue = [];
        //for (var j = 0; j < rows.length - 1; j++) {
        //    datasetValue[j] = {
        //        label: cols,
        //        data: rows,
        //        backgroundColor: '#2196F3'
        //    }
        //}
        //var DataArray = [];
        //for (i = 0; i <= Employee.length - 1; i++) {
        //    DataArray = EmployeeCount[i];
        //    datasetValue[i] =
        //        {
        //            label: Employee[i],
        //            data: EmployeeCount,
        //            backgroundColor: '#2196F3'
        //        }
        //}
        
        //console.log(datasetValue)
        var strUS = [];
        var IssueCount = [];
        var arrBackColor = [];
        var r = 0;
        var g = 0;
        var b = 0;
        if (strResult.d != "") {
            $.each(JSON.parse(strResult.d), function (id, object) {
                strUS.push("US ID - " + object["UserStoryID"]);
                IssueCount.push(object["IssueCount"]);
                arrBackColor.push("hsl(" + r + ", 100%, 70%)");
                r += 30;
            });
        }

        new Chart(Graph, {
            type: 'bar',
            data: {
                labels: strUS,
                datasets: [
                    {
                        label: "",
                        data: IssueCount,
                        fill: false,
                        backgroundColor: arrBackColor,
                    }
                ]
            },
            options: {
                responsive: true,
                legend: {
                    display: false,
                    position: 'right',
                },
                title: {
                    display: false,
                    text: 'Issue In Detailed'
                },
                scales: {
                    xAxes: [{
                        barPercentage: 0.2,
                        scaleLabel: {
                            display: true,
                            labelString: 'UserStory'
                        },
                        ticks: {
                            autoSkip: false,
                            maxRotation: 90,
                            minRotation: 90
                        }
                    }],
                    yAxes: [
                            {
                                scaleLabel: {
                                    display: true,
                                    labelString: 'Issue Count'
                                },
                                ticks: {
                                    beginAtZero: true   // minimum value will be 0.
                                }
                            }
                    ]
                }
            }
        });
    }
    function PlotVelocityGraph(Graph) {
        //Velocity graph
        var strResult, data;
        var IterationID;

        IterationID = "<%= m_strIterationID%>";
        data = JSON.stringify({ IterationID: IterationID });
        strResult = AJAXCallWithResult(strPageName + '/GetVelocityGraph', data, false);

        var strEntity = [];
        var Velcity = [];
        var Actual = [];
        if (strResult.d != "") {
            $.each(JSON.parse(strResult.d), function (id, object) {
                strEntity.push(object["IterationName"]);
                Velcity.push(object["Velocity"]);
                Actual.push(object["Actual"]);

            });
        }
        arrBackColor = ["#FFA726", "#F44336"];
        new Chart(Graph, {
            type: 'bar',
            data: {
                labels: strEntity,
                datasets: [
                    {
                        label: "",
                        data: Velcity,
                        fill: false,
                        backgroundColor: "#FFA726",
                    },
                    {
                        label: "",
                        data: Actual,
                        fill: false,
                        backgroundColor: "#F44336",
                    }
                ]
            },
            options: {
                legend: {
                    display: false,
                    position: 'right',
                },
                title: {
                    display: false,
                    text: 'Velocity/Actual'
                },
                //Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
        tooltips: {
            callbacks: {               
                
                label: function (tooltipItems, data) {
                    //alert(data.datasets[tooltipItems.datasetIndex].label);
                    if (data.datasets[tooltipItems.datasetIndex].label == "") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return HMRemainingEfforts;
                    }                   
                }
                
            }
        },
        //End Of Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
            scales: {
                    xAxes: [{
                        barPercentage: 0.2
                    }],
                    yAxes: [{
                        ticks: {
                            beginAtZero: true   // minimum value will be 0.
                        }
                    }]
                }
            }
        });
    }
    function PlotFocusFactorGraph(Graph) {
        //Velocity graph
        var strResult, data;
        var IterationID;

        IterationID = "<%= m_strIterationID%>";
        data = JSON.stringify({ IterationID: IterationID });
        strResult = AJAXCallWithResult(strPageName + '/GetFocusFactorGraph', data, false);

        var strEntity = [];
        var CompletedStoryPoint = [];
        var TotalEffort = [];
        if (strResult.d != "") {
            $.each(JSON.parse(strResult.d), function (id, object) {
                strEntity.push(object["Entity"]);
                CompletedStoryPoint.push(object["CompletedStoryPoint"]);
                TotalEffort.push(object["TotalEffort"]);

            });
        }
        arrBackColor = ["#FFA726", "#F44336"];
        new Chart(Graph, {
            type: 'bar',
            data: {
                labels: strEntity,
                datasets: [
                    {
                        label: "Compeleted Story Point",
                        data: CompletedStoryPoint,
                        fill: false,
                        backgroundColor: "#FFA726",
                    },
                    {
                        label: "Total Effort",
                        data: TotalEffort,
                        fill: false,
                        backgroundColor: "#F44336",
                    }
                ]
            },
            options: {
                legend: {
                    display: false,
                    position: 'right',
                },
                title: {
                    display: false,
                    text: 'Completed Story Point/Total Effort'
                },
                 //Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
        tooltips: {
            callbacks: {               
                
                label: function (tooltipItems, data) {
                    //alert(data.datasets[tooltipItems.datasetIndex].label);
                    if (data.datasets[tooltipItems.datasetIndex].label == "Total Effort") {
                        var HMRemainingEfforts = tooltipItems.yLabel.toFixed(2);
                        HMRemainingEfforts = HMRemainingEfforts.toString().replace(".", ":");
                        return data.datasets[tooltipItems.datasetIndex].label + ': ' + HMRemainingEfforts;
                    }
                }
                
            }
        },
        //End Of Added By Usha Pandit On 18.01.2021 For getting tooltip for Efforts in HH:MM format
            scales: {
                    xAxes: [{
                        barPercentage: 0.2
                    }],
                    yAxes: [{
                        ticks: {
                            beginAtZero: true   // minimum value will be 0.
                        }
                    }]
                }
            }
        });
    }
    function NoData() {
        Chart.plugins.register({
            afterDraw: function (chart) {
                var isPlot = 0;
                
                for (var i = 0; i < chart.config.data.datasets["0"].data.length; i++) {
                    if (chart.config.data.datasets["0"].data[i] > 0) {
                        isPlot = 1;
                    }
                }

                if (isPlot == 0 && (chart.chart.ctx.canvas.id == "vertical" || chart.chart.ctx.canvas.id == "TaskBoardpopup" || chart.chart.ctx.canvas.id == "resources" || chart.chart.ctx.canvas.id == "USTrendpopup" || chart.chart.ctx.canvas.id == "FocusFactor" || chart.chart.ctx.canvas.id == "FocusFactorpopup")) {
                    if (chart.config.data.datasets["1"] != null) {
                        for (var i = 0; i < chart.config.data.datasets["1"].data.length; i++) {
                            if (chart.config.data.datasets["1"].data[i] > 0) {
                                isPlot = 1;
                            }
                        }
                    }
                }
                if (isPlot == 0 && (chart.chart.ctx.canvas.id == "vertical" || chart.chart.ctx.canvas.id == "TaskBoardpopup" || chart.chart.ctx.canvas.id == "resources" || chart.chart.ctx.canvas.id == "USTrendpopup" || chart.chart.ctx.canvas.id == "FocusFactor" || chart.chart.ctx.canvas.id == "FocusFactorpopup")) {
                    if (chart.config.data.datasets["2"] != null) {
                        for (var i = 0; i < chart.config.data.datasets["2"].data.length; i++) {
                            if (chart.config.data.datasets["2"].data[i] > 0) {
                                isPlot = 1;
                            }
                        }
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
                    ctx.fillStyle = "black";
                    ctx.fillText('No data to display', width / 2, height / 2);
                    ctx.restore();
                }
            }
        });
    }
    function AssignToListClick(object) {
        $("#txtSprint").val(object.name);
        $("#hdntxtSprint").val(object.id);
        $("#emplistUL").css("display", "none");

        objForm.action = strPageName + "?IterationID=" + object.id;
        objForm.submit();
    }
    function myFunction() {
        var input, filter, ul, li, a, i;
        $("#emplistUL").css("display", "block");
        input = document.getElementById("txtSprint");
        filter = input.value.toUpperCase();
        ul = document.getElementById("emplistUL");
        li = document.getElementsByClassName("clsAssignedListItem");
        for (i = 0; i < li.length; i++) {
            a = li[i].innerText;
            if (a.toUpperCase().indexOf(filter) > -1) {
                li[i].style.display = "";
            } else {
                li[i].style.display = "none";

            }
        }
    }
    function Excel_OnClick(format) {
        format = format.toUpperCase();
        var strResult, data;
        var IterationID;

        IterationID = "<%= m_strIterationID%>";
        data = JSON.stringify({ ReportFormat: format, IterationID: IterationID });
        strResult = AJAXCallWithResult(strPageName + '/ExportToExcel', data, false);

        if (strResult.d != "") {
        }

        var objStatus, objHRM;
        window.open("../CRW/CRW_ReportOutput.aspx?filename=" + strResult.d, "_report", "");
    }
    function ShowPreviousNext(val, num) {
        if (val == 1) {
            if (document.getElementById("hdnCurrentPage").value < num) {

                $(".employeeList" + document.getElementById("hdnCurrentPage").value).css("display", "none")
                document.getElementById("hdnCurrentPage").value = parseInt(document.getElementById("hdnCurrentPage").value) + 1;
                $(".employeeList" + document.getElementById("hdnCurrentPage").value).css("display", "")
                $("#employeeListPrev").css("display", "");
                if (document.getElementById("hdnCurrentPage").value == num) {
                    $("#employeeListNext").css("display", "none");
                }
            }
            else {
                $("#employeeListNext").css("display", "none");
            }
        }
        else {
            if (document.getElementById("hdnCurrentPage").value > 1) {
                $(".employeeList" + document.getElementById("hdnCurrentPage").value).css("display", "none")
                document.getElementById("hdnCurrentPage").value = parseInt(document.getElementById("hdnCurrentPage").value) - 1;
                $("#employeeListNext").css("display", "");
                if (document.getElementById("hdnCurrentPage").value == 1) {
                    $("#employeeListPrev").css("display", "none");
                }
                $(".employeeList" + document.getElementById("hdnCurrentPage").value).css("display", "")
            }
            else {
                $("#employeeListPrev").css("display", "none");
            }
        }
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
                //   StopAjaxLoader("body");
                $(".loadingoverlay", parent.document).css("display", "none");
                console.log(xhr.responseText);
                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
            }
        });

        return AjaxResult;
    }
</script>
