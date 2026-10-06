<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ResourceLoading.aspx.vb" Inherits="PbNIT.PM_ResourceLoading" %>

<!DOCTYPE html>

<html>

     <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
   <%-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%= MyBase.GetResourceString("C_ResourceAllocated") %></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
    
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">

    <!--daterange-picker-->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/daterangepicker.min.css">--%>

    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3">

</head>

<style type="text/css">
h5.pgtitle {
    margin: 6px 0 0;
    font-weight: 700;
    color: #4263c1;
    font-size: 16px;
}
.sitename ~ span{margin-top:0!important;display:inline-block}
.ui-datepicker-calendar tbody tr:hover,.ui-datepicker-calendar tbody tr:hover td a{background:#eee!important}
.ui-datepicker-calendar tbody tr:hover td.ui-datepicker-today a.ui-state-highlight{background:#007fff!important}
#Tabdetailpagewrap.toggled #Tabdetailpage-content .table-responsive{overflow:auto}
#Tabdetailpagewrap.toggled #Tabdetailpage-content .alocatedresourcereqtbl td .custom_chckbox{pointer-events:none}
.btnlistinline{margin-top:0px}
.resource_allocation{margin-top:4px}
body{background:#fff}
table tr th,table tr td{padding:4px 8px}

.content h5 {font-size: 14px;font-weight: 600;}
.resourceutilization_pie_chart {width: 50%;}
    </style>


<body class="hold-transition fixed" id="Main_ResourceBody">

    <!-- Content Wrapper. Contains page content -->
    <div class="resource_allocation">

        <div class="graybg container-fluid pt-1 pb-1">
            <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_ResourceUtilization") %></h5>
            <div class="float-end btnlistinline">
               <button class="btn borderbtn nobtnstyle-xs canclebtn mt-0"><%= MyBase.GetResourceString("C_Back") %></button>
            </div>
            <div class="clearfix"></div>
        </div>
        <!-- Main content -->
        <section class="content">

            <p class="container-fluid pt-1 pb-1 text-end clearfix">
                <strong><span class="float-start" id="ResourceLoadingYear"></span></strong>
                <span class="float-end"><strong><span data-bs-toggle="tooltip" data-bs-placement="top" title="" id="ResourceName" data-original-title="Selected Project"></span></strong></span>
            </p>
            <div class="resource_utilization_panel">


                <div class="row">
                    <div class="col-sm-8">
                        <div class="resourceutilization_pie_chart">
                            <canvas id="resourceutilization_pie_chart" height="100"></canvas>
                        </div>

                    </div>
                    <div class="col-sm-4">
                        <div class="table-responsive">
                            <table class="table table-stripped table-bordered utlizationtbl" id="tblResourceWork">
                            </table>
                        </div>
                        <small><strong><%= MyBase.GetResourceString("C_Note") %></strong> <em><%= MyBase.GetResourceString("C_InstallCapacityNote") %></em></small>
                    </div>
                </div>
                <hr />

                <h5><%= MyBase.GetResourceString("C_MonthlyLoading") %></h5>
                <div class="table-responsive">
                    <table class="table table-stripped table-bordered">
                        <thead id="tblmonthlyLoadingThead">
                            <tr>
                            </tr>
                        </thead>
                        <tbody id="tblmonthlyLoadingTbody">
                        </tbody>

                    </table>
                </div>

                <h5><%= MyBase.GetResourceString("C_ProjectLoading") %></h5>
                <div class="table-responsive">
                    <table class="table table-stripped table-bordered">
                        <thead id="tblProjectLoadingThead">
                            <tr>
                            </tr>
                        </thead>
                        <tbody id="tblProjectLoadingTbody">
                        </tbody>

                    </table>
                </div>


            </div>



        </section>


    </div>
    <!-- /.content-wrapper -->


    <!-- ./wrapper -->

    <!-- REQUIRED JS SCRIPTS -->
   
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
    <%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
    <!-- jqueryUI js -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>   
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <!-- chartjs -->
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>

    <!--daterangepicker-->
    <%--<script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/dist/js/jquery.daterangepicker.min.js"></script>--%>

    <!--Added for loader-->
    <!-- custome js -->
    <%--<script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js"></script>--%>

    <script type="text/javascript">

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'

        //Comment By Imran 25-06-2021
        //var ProjectEmployeeRoleID = '<%=ProjectEmployeeRoleID%>';
        //End Comment

        var ProjectEmployeeRoleID = "";
        var ProjectID = '<%=ProjectID%>';
        var ProjectName = '<%=ProjectName%>';
        var EmployeeID = '<%=EmployeeID%>';
        var intRoleLevel = '<%= Session("intRoleLevel") %>';
        var intUserID = '<%= Session("intUserID") %>';
        var Link = '<%=BackLink%>';
        var Parameters="";
       
        //weeekly and daily tab
        $("document").ready(function ()
        {    
            // Added By Imran 28-06-2021 Pass Parameter baklinks for back to Pm_Resource Page
            Parameters = getParameters();
            Link = unescape(Parameters["BackLink"]);
            // alert(Link);
            // End By Imran 28-06-2021

            //pie chart
            var intCount = '12';
            var intRUCount = '12';
            var intIndex;
            var StartMonth;
            var globalCurrentYear = "";
            var currentYear = (new Date).getFullYear();
            //Added By Dipali V On 2nd Jan 2020 For Month & Year Logic
            var Month = (new Date().getMonth());
            var Month = Month + 1;
            if (Month >= 1 && Month <= 3) {
                globalCurrentYear = (currentYear - 1);

            } else {
                globalCurrentYear = currentYear
            }           
            currentYear = globalCurrentYear;
            // End of Added By Dipali V On 2nd Jan 2020 For Month & Year Logic

            if (Link == 'AR') {
                $(".btnlistinline").hide();
            }
            else {
                $(".btnlistinline").show();
            }
            var ResourceLoadingYear = "Resource Loading For year " + currentYear + " to " + (currentYear + 1);
            $("#ResourceLoadingYear").html(ResourceLoadingYear);

          
            if (ProjectEmployeeRoleID == 0 || ProjectEmployeeRoleID == null || ProjectEmployeeRoleID == '' || ProjectEmployeeRoleID == undefined) {
                var ResourceParameter = {
                    ProjectID: encodeURI(ProjectID),
                    EmployeeID: encodeURI(EmployeeID)
                }
                var param = JSON.stringify(ResourceParameter);
                var strResult = AJAXCallWithResult("/api/PM_ResourceLoading/GetProjectEmployeeRoleID", param, false);
                ProjectEmployeeRoleID = strResult;
            }

            //Added by imran for back url redirection button 28-06-2021
            if (Link == '' || Link == 'undefined') {
                  $.ajax({
                    url: strUrl + '/api/PM_Resources/GetResourceUIAllocation',
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    },
                       success: function (data)
                       {
                           for (var i = 0; i < data.length; i++)
                           {
                               var d = data[i];
                               if (d.ShowResourceAllocation == true) {
                                   Link = 'NewUI';
                               }
                               else {
                                   Link = '';
                               }
                            }
                        },
                       error: function (err)
                       {
                        console.log(err);
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
            });
            }          
            //End Comment by imran 28-06-2021
          
            StartLoader("#Main_ResourceBody");          
            GetEmployeeInfo();           
            GetResourcePieChart();
            GetStartMonth();
            GetMonthlyLoading();
            GetResourceLoading();
            StopAjaxLoader("#Main_ResourceBody");

            //function GetEmployeeInfo() {
            //    var param = JSON.stringify(ProjectEmployeeRoleID);
            //    var strResult = AJAXCallWithResult("/api/PM_ResourceLoading/GetEmployeeInfo", param, false);
            //    var ResourceData = "Resource : " + strResult[0].UserName + " - " + strResult[0].EmployeeName + "[" + strResult[0].RoleDescription + "]";
            //    $("#ResourceName").html(ResourceData);
            //}

            function GetEmployeeInfo()
            {
                //Added by imran on 05-09-2022
                if (ProjectEmployeeRoleID == null || ProjectEmployeeRoleID == "") {
                    ProjectEmployeeRoleID = 0;
                }
                //End of comment by imran on 05-09-2022

                ResourceParameters = {
                    ProjectEmployeeRoleID: ProjectEmployeeRoleID,
                    EmployeeID: EmployeeID
                }
                if (ProjectEmployeeRoleID == 0 || ProjectEmployeeRoleID == null || ProjectEmployeeRoleID == undefined || ProjectEmployeeRoleID == '') {
                    var param = JSON.stringify(ResourceParameters);
                    var strResult = AJAXCallWithResult("/api/PM_ResourceLoading/GetEmployeeData", param, false);
                    var ResourceData = "Resource : " + strResult[0].UserName + " - " + strResult[0].EmployeeName + " [ " + strResult[0].RoleDescription + " ] ";
                    $("#ResourceName").html(ResourceData);                
                }
                else {
                    var param = JSON.stringify(ResourceParameters);
                    // alert(param);
                    var strResult = AJAXCallWithResult("/api/PM_ResourceLoading/GetEmployeeInfo", param, false);
                   
                    var ResourceData = "Resource : " + strResult[0].UserName + " - " + strResult[0].EmployeeName + " [ " + strResult[0].RoleDescription + " ] ";
                    $("#ResourceName").html(ResourceData);
                   }
            }

            function GetResourcePieChart() {
                var TypeArray = [];
                var HoursArray = [];
                var HoursHHMMArray = [];//added By Dipali V On 28th April 2020 For data should display in HH:MM Formate
                var ResourceParameter = {
                    CurrentYear: encodeURI(currentYear),
                    EmployeeID: encodeURI(EmployeeID),
                    IsPieChart: encodeURI(1)
                }

                var param = JSON.stringify(ResourceParameter);
                var strResult = AJAXCallWithResult("/api/PM_ResourceLoading/GetResourceData", param, false);

                strHTML = '';
                $('#tblResourceWork').append('');
                var TotalCapacity = GetTotalCapacityOfResource();
                for (var i = 0; i < TotalCapacity.length; i++) {
                    strHTML = ('<tbody><tr><th>Install Capacity</th><td>' + TotalCapacity[i].TotalCapacity + ' Hrs</td></tr></tbody>');
                    //  debugger;
                    if (strResult != undefined && strResult != null) { //Added By Usha Pandit On 07.07.2020 For javascript error
                        for (var j = 0; j < strResult.length; j++) {
                            var d = strResult[j];
                            var Type = d.Type;
                            var Hours = d.Hours;
                            var HMHours = d.HMHours;
                            TypeArray.push(Type);
                            HoursArray.push(Hours);
                            HoursHHMMArray.push(HMHours);
                            //Added By dipali V On 28th April 2020 For Data should display in HH:MM Fomate
                            //strHTML += ('<tr><th>' + Type + '</th><td>' + Hours + ' Hrs</td></tr>');
                            strHTML += ('<tbody><tr><th>' + Type + '</th><td>' + HMHours + ' Hrs</td></tr></tbody>');
                            //End of Commented By dipali V On 28th April 2020 For Data should display in HH:MM Fomate
                        }
                    }
                    $('#tblResourceWork').append(strHTML);
                }
                //Commented By dipali V On 28th April 2020 For Data should display in HH:MM Fomate
                //var Resourcedata = {
                //    labels:
                //        TypeArray,
                //    datasets: [{
                //        labels:
                //            [TypeArray],
                //        data: HoursArray,
                //        //fill: false,
                //        backgroundColor: [
                //            "#d8a24e",
                //            "#afd037",
                //            "#f4cd0e",
                //            "#e01a29",
                //            "#0d95d3",
                //            "#cccccc",
                //        ],
                //        borderColor: [
                //            "#FFFFFF"
                //        ],
                //        borderWidth: [1, 1, 1]
                //    }]
                //};

                //$('#canvasId').empty();
                //$('#canvasId').html(' <canvas id="SISreportchart" width="200" height="80"></canvas>'); // then load chart.
                //End of Commented By dipali V On 28th April 2020 For Data should display in HH:MM Fomate
                var ctx = $("#resourceutilization_pie_chart");
                //Chart.defaults.global.defaultFontFamily = "roboto";
                //Chart.defaults.global.defaultFontSize = 12;
                Chart.defaults.font.size = 12;
                //Chart.defaults.font.family = "roboto";
                //added by Dipali V On 28th April 2020 For Data should be display in HH:MM Format
                var myPie = new Chart(ctx, {
                    type: 'pie',
                    data: {
                        labels: TypeArray,
                        datasets: [{
                            backgroundColor: [
                                "#d8a24e",
                                "#afd037",
                                "#f4cd0e",
                                "#e01a29",
                                "#0d95d3",
                                "#cccccc",
                            ],
                            data: HoursArray,
                            tooltipdataset: HoursHHMMArray
                        }],
                    },
                    options: {
                        title: {
                            display: true,
                            fontStyle: 'bold',
                            fontSize: 12
                        },
                        legend: {
                            position: 'right',
                        },
                        tooltips: {
                            callbacks: {
                                // this callback is used to create the tooltip label
                                label: function (tooltipItem, data) {
                                    // get the data label and data value to display
                                    // convert the data value to local string so it uses a comma seperated number
                                    var dataLabel = data.labels[tooltipItem.index];
                                    var value = ': ' + data.datasets[tooltipItem.datasetIndex].tooltipdataset[tooltipItem.index].toLocaleString();

                                    // make this isn't a multi-line label (e.g. [["label 1 - line 1, "line 2, ], [etc...]])
                                    if (Chart.helpers.isArray(dataLabel)) {
                                        // show value on first line of multiline label
                                        // need to clone because we are changing the value
                                        dataLabel = dataLabel.slice();
                                        dataLabel[0] += value;
                                    } else {
                                        dataLabel += value;
                                    }

                                    // return the text to display on the tooltip
                                    return dataLabel;
                                }
                            }
                        }
                    }
                });
            }
             //End of added by Dipali V On 28th April 2020 For Data should be display in HH:MM Format

            function GetTotalCapacityOfResource() {
                var ResourceParameter = {
                    CurrentYear: encodeURI(currentYear),
                    EmployeeID: encodeURI(EmployeeID)
                }
                var param = JSON.stringify(ResourceParameter);
                var strResult = AJAXCallWithResult("/api/PM_ResourceLoading/GetTotalCapacityOfResource", param, false);
                return strResult;
            }

            function GetStartMonth() {
                var ResourceParameter = {
                    ProjectID: encodeURI(ProjectID)
                }
                var param = JSON.stringify(ResourceParameter);
                StartMonth = AJAXCallWithResult("/api/PM_ResourceLoading/GetStartMonth", param, false);
                //return strResult;               
                var strHTML = '';
                strHTML += '<th width="22%" class="text-start">&nbsp;</th>'
                intIndex = StartMonth;
                while (intCount > 0) {
                    strHTML += '<th>' + GetMonthName(intIndex) + '</th>';
                    intIndex = intIndex + 1;
                    if (intIndex == 13) {
                        intIndex = 1;
                    }
                    intCount = intCount - 1;
                }

                $("#tblmonthlyLoadingThead tr").append(strHTML);
                $("#tblProjectLoadingThead tr").append(strHTML);
            }

            function GetResourceLoading() {
                var intCnt = 0;
                var strResult = GetResourceData();
                var strHTML = "";
                var m_strOpenProjectName = strResult[0].ProjectName;
                for (var i = 0; i < strResult.length; i++) {

                    if (intCnt < strResult.length) {
                        var ProjectID = strResult[intCnt].ProjectID;
                        if (ProjectID > 0) {
                            var ObjResource = strResult[intCnt];
                            intCnt = intCnt + 1;
                            strHTML += "<tr><td>" + ObjResource.ProjectName + "</td>";
                            intCount = 12
                            intIndex = StartMonth;

                            while (intCount > 0) {
                                var MonthName = GetMonthName(intIndex);
                                MonthName = MonthName + "Count";
                                if (MonthName != "") {
                                    var Count = ObjResource[MonthName];
                                    if (Count != '' && Count != undefined && Count != null && Count != "NULL") {
                                        Count = Count.toFixed(2);
                                    }
                                    else {
                                        //Added & Commented By Dipali V On 2nd Jan 2020
                                        // Count = Count;
                                        if (Count == 0 || Count == null) {
                                            Count = "0.00";
                                        }
                                        else {
                                            Count = Count;
                                        }
                                    }
                                     //End of Added & Commented By Dipali V On 2nd Jan 2020
                                    //if (Count == 0) {
                                    //    Count = "0.00";
                                    //}
                                    //else {
                                    //    Count = Count + ".00";
                                    //}
                                    //var Countlength = Count.length;
                                    //if (Countlength > 4) {
                                    //    Count = Count.slice(0, -3);
                                    //}
                                    //var Value = Count.split(".").pop();
                                    //if (Value.length == 1) {
                                    //    Count = Count + "0";
                                    //}
                                    //if (Count.indexOf('.') < 1) {
                                    //    Count = Count + ".00";
                                    //}
                                    strHTML += "<td>" + Count + "</td>"
                                }
                                intIndex = intIndex + 1;
                                if (intIndex == 13) {
                                    intIndex = 1;
                                }
                                intCount = intCount - 1
                            }
                            strHTML += "</tr>";
                        }
                        intCnt = intCnt + 1;
                    }
                }
                strHTML += "<tr><td>" + m_strOpenProjectName + "</td>";
                intCount = 12
                intIndex = StartMonth;
                var ObjOpenProject = strResult[0];
                while (intCount > 0) {
                    var MonthName = GetMonthName(intIndex);
                    MonthName = MonthName + "Count";
                    if (MonthName != "") {
                        var Count = ObjOpenProject[MonthName];
                        if (Count != '' && Count != undefined && Count != null && Count != "NULL") {
                            Count = Count.toFixed(2);
                        }
                        else {
                             //Added & Commented By Dipali V On 2nd Jan 2020
                            //Count = Count;
                           // debugger;
                            if (Count == 0 || Count == null) {
                                Count = "0.00";
                            }
                            else {
                                Count = Count;
                            }
                        }
                         //End of Added & Commented By Dipali V On 2nd Jan 2020
                        //if (Count == 0) {
                        //    Count = "0.00";
                        //}
                        //else {
                        //    Count = Count + ".00";
                        //}
                        //var Countlength = Count.length;
                        //if (Countlength > 4) {
                        //    Count = Count.slice(0, -3);
                        //}
                        //var Value = Count.split(".").pop();
                        //if (Value.length == 1) {
                        //    Count = Count + "0";
                        //}
                        //if (Count.indexOf('.') < 1) {
                        //                Count = Count + ".00";
                        // }
                        strHTML += "<td>" + Count + "</td>"
                    }
                    intIndex = intIndex + 1;
                    if (intIndex == 13) {
                        intIndex = 1;
                    }
                    intCount = intCount - 1
                }
                strHTML += "</tr>";

                $("#tblProjectLoadingTbody").append(strHTML);
            }

            function GetMonthlyLoading() {
                var intCnt = 0;
                var strHTML = "";
                var strResult = GetResourceData();
                var ObjResource = strResult[1];
                intCnt = intCnt + 1;
                strHTML += "<tr><td>Hours</td>";
                intCount = 12
                intIndex = StartMonth;

                while (intCount > 0) {
                    var MonthName = GetMonthName(intIndex);
                    MonthName = MonthName + "Count";
                    if (MonthName != "") {
                        var Count = ObjResource[MonthName];
                        if (Count != '' && Count != undefined && Count != null && Count != "NULL") {
                            Count = Count.toFixed(2);
                        }
                        else {
                            //Added & Commented By Dipali V On 2nd Jan 2020
                            //Count = Count;
                             if (Count == 0 || Count == null) {
                                Count = "0.00";
                            }
                            else {
                               Count =  Count.toFixed(2);
                            }
                             //End of Added & Commented By Dipali V On 2nd Jan 2020
                        }
                        //if (Count == 0) {
                        //    Count = "0.00";
                        //}
                        //else {
                        //    Count = Count + ".00";
                        //}
                        //var Countlength = Count.length;
                        //if (Countlength > 4) {
                        //    Count = Count.slice(0, -3);
                        //}
                        //var Value = Count.split(".").pop();
                        //if (Value.length == 1) {
                        //    Count = Count + "0";
                        //}
                        //if (Count.indexOf('.') < 1) {
                        //    Count = Count + ".00";
                        // }
                        strHTML += "<td>" + Count + "</td>"
                    }
                    intIndex = intIndex + 1;
                    if (intIndex == 13) {
                        intIndex = 1;
                    }
                    intCount = intCount - 1
                }
                strHTML += "</tr>";

                intRUCount = 12;
                strHTML += "<tr><td>Resource Utilization % </td>";
                while (intRUCount > 0) {
                    var MonthName = GetMonthName(intIndex);
                    MonthName = "RU" + MonthName;
                    if (MonthName != "") {
                        var Count = ObjResource[MonthName];
                        if (Count != '' && Count != undefined && Count != null && Count != "NULL") {
                            Count = Count.toFixed(2);
                        }
                        else {
                             //Added & Commented By Dipali V On 2nd Jan 2020
                            if (Count == 0 || Count == null) {
                                Count = "0.00";
                            }
                            else {
                                Count =  Count.toFixed(2);
                                // Count = Count + ".00";
                            }
                             //End of Added & Commented By Dipali V On 2nd Jan 2020
                        }
                        //if (Count == 0) {
                        //    Count = "0.00";
                        //}
                        //else {
                        //    Count = Count + ".00";
                        //}
                        //var Countlength = Count.length;
                        //if (Countlength > 4) {
                        //    Count = Count.slice(0, -3);
                        //}
                        //var Value = Count.split(".").pop();
                        //if (Value.length == 1) {
                        //    Count = Count + "0";
                        //}
                        //if (Count.indexOf('.') < 1) {
                        //       Count = Count + ".00";
                        // }
                        strHTML += "<td>" + Count + "</td>"
                    }
                    intIndex = intIndex + 1;
                    if (intIndex == 13) {
                        intIndex = 1;
                    }
                    intRUCount = intRUCount - 1
                }
                strHTML += "</tr>";
                $("#tblmonthlyLoadingTbody").append(strHTML);
            }

            function GetResourceData() {
                var ResourceParameter = {
                    CurrentYear: encodeURI(currentYear),
                    EmployeeID: encodeURI(EmployeeID),
                    intUserID: encodeURI(intUserID),
                    intRoleLevel: encodeURI(intRoleLevel)
                }
                var param = JSON.stringify(ResourceParameter);
                var strResult = AJAXCallWithResult("/api/PM_ResourceLoading/GetResourceLoading", param, false);
                return strResult;
            }

            function GetMonthName(MonthIndex) {
                switch (MonthIndex) {
                    case 1:
                        return "Jan";
                        break;
                    case 2:
                        return "Feb";
                        break;
                    case 3:
                        return "Mar";
                        break;
                    case 4:
                        return "Apr";
                        break;
                    case 5:
                        return "May";
                        break;
                    case 6:
                        return "June";
                        break;
                    case 7:
                        return "July";
                        break;
                    case 8:
                        return "Aug";
                        break;
                    case 9:
                        return "Sep";
                        break;
                    case 10:
                        return "Oct";
                        break;
                    case 11:
                        return "Nov";
                        break;
                    case 12:
                        return "Dec";
                        break;
                }
            }

            var ajaxResult;
            function AJAXCallWithResult(url, param, async) {
                //StartLoader("#bodyIssueDetails");
                $.ajax({
                    url: encodeURI(strUrl + url),
                    type: "POST",
                    data: param,
                    async: async,
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (param) {
                            xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                        }
                    },
                    success: function (data) {
                        //StopAjaxLoader("#bodyIssueDetails");
                        ajaxResult = data;
                    },
                    error: function (err) {
                        ajaxResult = undefined;
                        //StopAjaxLoader("#bodyIssueDetails");
                        console.log(err);
                    }
                });
                return ajaxResult;
            }
        });

         //Resquest QueryString Parameter
        function getParameters() {

            var params = {},
                pairs = document.URL.split('?')
                    .pop()
                    .split('&');
            for (var i = 0, p; i < pairs.length; i++) {
                p = pairs[i].split('=');
                params[p[0]] = p[1];
            }
            return params;
        }

        //click on back button
        $(".btnlistinline").click(function ()
        {
            if (Link == 'AR') {
                var url = "PM_RequestedResources.aspx?PKToken=<%=m_PKToken_FromResourcesRequestList%>&ProjectID=" + ProjectID + "&ProjectName=" + ProjectName;
                window.location.href = url;
            }
            //Added By  Imran 28-06-2021 For Redirection as per UI (Old / New)
            else if (Link=='PM') {
                window.location.href = "PM_Resources.aspx?ProjectID=" + ProjectID + "&ProjectName=" + ProjectName + "";
            }
            else if (Link == 'NewUI')
            {
                window.location.href = "PM_Resource_Selection.aspx?ProjectID=" + ProjectID + "&ProjectName=" + ProjectName + "";
            } 
            //End By Imran 28-06-2021
        });

    </script>
</body>
</html>