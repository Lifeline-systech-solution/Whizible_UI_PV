<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_ResourceAllocationView.aspx.vb" Inherits="PbNIT.RM_ResourceAllocationView" %>

<!DOCTYPE html>
<html>
      <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head>
  <%--  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2?v=2">
    <!-- Bootstrap 3.3.5 -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">--%>
    
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css?v=2">    
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
 <%--       <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

   

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

        .filter.float-end {
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

        .inline-blck.dtrnge {
            display: inline-block;
            float: left;
            padding: 0px 15px;
        }

        a.refreshdata {
            color: #464a4c;
            margin-top: 5px;
            display: inline-block;
        }

        .weekly_calender .input-group-box {max-width: 230px;}

        .input-group-box span {
            margin-top: 7px;
            display: inline-block;
        }

        .Totalrow td {
            font-weight: bold !important;
        }

        .bglightgray td {
            background: #f5f5f5;
        }

        .refreshview {
            margin-top: 7px;
            display: inline-block;
            color: #464a4c;
            margin-right: 5px;
        }

        .viewtblcontainer {
            display: none;
        }

        td.avrgtd {
            background: #e7edf0;
            font-weight: bold;
        }
.mr-0{ margin-right:0!important;}
.dropdown-toggle::after{ display:none;}
        #txtEmployeeName {
            border:none;
        }
        .weekly_calender .input-group-box {
            margin: -7px 5px;
        }
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bodyRAV">

    <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-1 text-end graybg">
            <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_RAV") %></h5>
         
            <a href="javascript:;" class="refreshdata float-end"><i class="fas fa-redo-alt" data-bs-toggle="tooltip" data-bs-placement="bottom" data-container="body" title="Refresh" onclick="RefreshPage()"></i></a>
        <div class="dropdown filedownload float-end" style="margin-top:5px;">
                                    <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Click here to download" class="fas fa-download"></i></button>
                                    <ul class="dropdown-menu">
                                        <li><a href="#" onclick="Export_Click('PDF')"><img src="../../../Whizible2.0-new/dist/img/pdf.svg" style="width:18px">Pdf</a></li>
                                        <li><a href="#"  onclick="Export_Click('Xlsx')"><img src="../../../Whizible2.0-new/dist/img/xls.svg"  style="width:18px">Xlsx</a></li>
                                        <li><a href="#" onclick="Export_Click('Xml')"><img src="../../../Whizible2.0-new/dist/img/xml.svg"  style="width:18px">Xml</a></li>
                                        <%--Commented & Added By Dipali V On 27th March 2023 For Change Doc to Text--%>
                                        <%--<li><a href="#"  onclick="Export_Click('Doc')" ><img src="../../../Whizible2.0-new/dist/img/doc.svg" style="width:18px">Doc</a></li>--%>
                                        <li><a href="#"  onclick="Export_Click('Doc')" ><img src="../../../Whizible2.0-new/dist/img/doc.svg" style="width:18px">Text</a></li>
                                        <%--End of Commented & Added By Dipali V On 27th March 2023 For Change Doc to Text--%>
                                    </ul>

                                </div>
            
            <div class="clearfix"></div>
        </div>


        <div class="content pt-0">
            <div class="row pt-1 pb-1">
                <div class="col-sm-4 form-inline">
                    <div class="row">
                        <label class="col-sm-2" for="email">View : </label>
                          <% CommonFunctions.HTMLControls.DrawComboBox("Resviewselect", "usp_SEL_FinancialType", 210,, "onchange=Chngviewfunction(event) class='form-select'",,, ) %> 
                      
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="weekly_calender" id="">
                        <button data-bs-toggle="tooltip" data-bs-placement="top" id="prev" title="Previous Week" style="display:none"><i class="fas fa-caret-left"></i></button>
                        <div class="input-group-box">
                            <span class=""><strong><%= MyBase.GetResourceString("C_From") %>: <span id="lblFrom"></span></strong></span>
                            <span class=""><strong><%= MyBase.GetResourceString("C_To") %>: <span id="lblTo"></span></strong></span>
                        </div>
                        <input type="hidden" id="DistinctDays" />
                        <button id="next" data-bs-toggle="tooltip" data-bs-placement="top" title="Next Week" style="display:none"><i class="fas fa-caret-right"></i></button>
                        <!-- /.input group -->
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="form-group form-inline text-end">
                        <label for="email" class="mr-0"><%= MyBase.GetResourceString("C_EmployeeName") %>: </label>
                        <%--<input type="text" class="form-control" />--%>
                          <% CommonFunctions.HTMLControls.DrawTextBox("txtEmployeeName", "txtEmployeeName", "form-control", 185,,,,, ,,,, " autocomplete='Off' maxlength='100' ",,, True,,,,) %>
                              
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>

            <div id="allocationviewbyD" class="day viewtblcontainer" style="display:block;">
                <table id="resrsAllocationViewTblD" class="table table-stripped table-bordered" style="width:100%;">
                    <thead id="theadD">
                       
                    </thead>
                    <tbody id="tbodyD">
                   
                </table>
            </div>
            <div id="allocationviewbyW" class="week viewtblcontainer">
                <table id="resrsAllocationViewTblW" class="table table-stripped table-bordered" style="width:100%;">
                    <thead id="theadW">
                        
                    </thead>
                    <tbody id="tbodyW">
                       
                    </tbody>
                </table>
            </div>
            <div id="allocationviewbyM" class="month viewtblcontainer">
                <table id="resrsAllocationViewTblM" class="table table-stripped table-bordered profiencyTbllist" style="width:100%;">
                    <thead id="theadM">
                      
                    </thead>
                    <tbody id="tbodyM">
                      
                    </tbody>
                </table>
            </div>
            <div id="allocationviewbyQ" class="quarter viewtblcontainer">
                <table id="resrsAllocationViewTblQ" class="table table-stripped table-bordered" style="width:100%;">
                    <thead  id="theadQ">
                        
                    </thead>
                    <tbody id="tbodyQ">
                        
                    </tbody>
                </table>
            </div>

           
            <div class="clearfix"></div>
        </div>

        <div class="clearfix"></div>
    </div>

    <!-- REQUIRED JS SCRIPTS -->
    
  <%--  <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>    
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>    
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>

 <%--       <script src="../../General/CommonValidations.js?v=2"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js?v=1"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

    <script>
        //$("input").change(function () {
        //    alert("The text has been changed.");
        //});
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']"))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });
    

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-resource").ToString%>'

        var RequestID, EmployeeName, FromDate, EmployeeID
        var LoginEmployeeID = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var LoginID = '<%= Session("intLoginID") %>';
        var LoginType = '<%= Session("LoginType") %>';
        $(document).ready(function () {
           // debugger;
            params = getParams();
            RequestID = unescape(params["RequestID"]);
            EmployeeName = unescape(params["EmployeeName"]);
            FromDate = unescape(params["Fromdate"]);
            EmployeeID = unescape(params["EmployeeID"]);

            GetFromDateToDate();

        });

        function getParams() {
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

        var selectedFDate = "";
        var SelectedTDate = "";
        function GetFromDateToDate() {
            var View = $("#Resviewselect").val();
            var HDDetails = {
                FromDate: FromDate,
                View: View,
                Period: "0",
            }
            var param = JSON.stringify(HDDetails);
            var strResult = AJAXCallWithResult("/api/RMResourceAllocationView/GetFromDateToDate", param, false);
            if (strResult.length != 0) {
                for (var i = 0; i < strResult.length; i++) {
                    $("#lblFrom").text(strResult[i].FromDate);
                    $("#lblTo").text(strResult[i].ToDate);
                    $("#DistinctDays").val(strResult[i].DistinctDays);
                    selectedFDate = strResult[i].FromDate
                    SelectedTDate = strResult[i].ToDate
                }
               // debugger;
                $("#txtEmployeeName").val(EmployeeName);
                GetDetailsDayView(selectedFDate, SelectedTDate);
            }
        }


        function RefreshPage() {
            GetDetailsDayView(selectedFDate, SelectedTDate);
        }

        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {
            StartLoader("#bodyRAV");
            $.ajax({
                url: encodeURI(strUrl + url),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_resource"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    ajaxResult = undefined;
                    console.log(err.responseText)
                    // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#bodyRAV");
            return ajaxResult;
        }


        function Chngviewfunction(e) {
            //$(".cutoffdiv").css('display', 'inline-block')
            $("select option:selected").each(function () {

                if ($(this).attr("value") == "D") {
                    $(".viewtblcontainer").hide();
                    $(".day").show();
                    $(".JStableOuter").hide();
                    $(".JStableOuter.RRdaytbl").show();
                }
                if ($(this).attr("value") == "W") {

                    $(".viewtblcontainer").hide();
                    $(".week").show();
                    $(".JStableOuter").hide();
                    $(".JStableOuter.RRweektbl").show();
                }
                if ($(this).attr("value") == "M") {
                    $(".viewtblcontainer").hide();
                    $(".month").show();
                    $(".JStableOuter").hide();
                    $(".JStableOuter.RRmonthtbl").show();

                }
                if ($(this).attr("value") == "Q") {
                    $(".viewtblcontainer").hide();
                    $(".quarter").show();
                    $(".JStableOuter").hide();
                    $(".JStableOuter.RRquartertbl").show();


                }
               
                GetFromDateToDate();
              
            });

        }
        function removeDuplicates(arr) {
            return arr.filter((item,
                index) => arr.indexOf(item) === index);
        }

       

        var IsNodata = 0;
        function GetDetailsDayView(FromDate, ToDate) {
           // debugger;
            var View = $("#Resviewselect").val();
            var strHtml = "", strhtmlThead = "";
            var ArrTitle = [];
            var ArrRowsPrecentage = [];
            var ArrProjectName = [];
            var ArrProjectSdate = [];
            var ArrProjectEDate = [];
            var ArrTotal = [];
            var DistinctDays = $("#DistinctDays").val();
          
            $("#thead" + View).html("");
            $("#tbody" + View).html("");
            var gProjectName = "";
            var HDDetails = {
                FromDate: FromDate,
                ToDate: ToDate,
                View: View,
                LoginEmployeeID: LoginEmployeeID,
                UserName: UserName,
                LoginID: LoginID,
                LoginType: LoginType,
                EmployeeID: EmployeeID,
            }
            var param = JSON.stringify(HDDetails);
            var strResult = AJAXCallWithResult("/api/RMResourceAllocationView/GetDetailsView", param, false);
            //$('#resrsAllocationViewTbl' + View).dataTable().fnDestroy();
            
                                     
            if (strResult.length != 0) {
                for (var i = 0; i < strResult.length; i++) {
                    // alert();
                    // debugger;
                    IsNodata = 1;
                    var ProjectName = strResult[i]["ProjectName"];
                    var ResourcePercentage = strResult[i]["ResourcePercentage"];
                    var ExpectedStartDate = strResult[i]["ExpectedStartDate"];
                    var ExpectedEndDate = strResult[i]["ExpectedEndDate"];
                    var Title = strResult[i]["Title"];
                    ArrTitle.push(Title);
                    ArrTitle = removeDuplicates(ArrTitle);

                    // ArrRowsPrecentage = removeDuplicates(ArrRowsPrecentage)
                    ArrProjectName.push(ProjectName);
                    ArrProjectName = removeDuplicates(ArrProjectName)
                    if (gProjectName == '') {
                        ArrProjectSdate.push(ExpectedStartDate);
                        ArrProjectEDate.push(ExpectedEndDate);
                        ArrRowsPrecentage.push(ResourcePercentage)
                        ArrTotal.push(ResourcePercentage)
                    }
                    else if (gProjectName == ProjectName) {
                        ArrProjectEDate.push(ExpectedEndDate);
                        ArrProjectSdate.push(ExpectedStartDate);
                        ArrRowsPrecentage.push(ResourcePercentage)
                        ArrTotal.push(ResourcePercentage)
                    }
                    else if (gProjectName != ProjectName) {
                        ArrProjectEDate.push(ExpectedEndDate);
                        ArrProjectSdate.push(ExpectedStartDate);
                        ArrRowsPrecentage.push(ResourcePercentage)
                        ArrTotal.push(ResourcePercentage)

                    }
                    gProjectName = ProjectName;
                }

                console.log(ArrTotal);
               // debugger;
                //------------------Thead---------
                strhtmlThead += "<tr>";
                strhtmlThead += "<th>Project Name </th>";
                strhtmlThead += "<th>Start Date </th>";
                strhtmlThead += "<th>End Date </th>";
                for (var i = 0; i < ArrTitle.length; i++) {
                    strhtmlThead += "<th>" + ArrTitle[i] + "</th>";
                }
                strhtmlThead += "<th>Average</th>";
                strhtmlThead += "</tr>";
                //------------------End of Thead---------
                $("#thead" + View).html("");
                $("#thead" + View).html(strhtmlThead);
                //if ($('#resrsAllocationViewTblD') != undefined) {
                //    $('#resrsAllocationViewTblD').dataTable().fnDestroy();
                //}
                $('#resrsAllocationViewTbl' + View).dataTable().fnDestroy();
                //--------------------- Tbody--------------------------
                var TotalAvg = 0;
                for (var i = 0; i < ArrProjectName.length; i++) {
                    var Avg = 0, sum = 0;
                    strHtml += "<tr>"
                    strHtml += "<td> " + ArrProjectName[i] + " </td>"
                    strHtml += "<td> " + ArrProjectSdate[i] + " </td>"
                    strHtml += "<td> " + ArrProjectEDate[i] + " </td>"
                    for (var k = 0; k < ArrTitle.length; k++) {
                        strHtml += "<td> " + ArrRowsPrecentage[k] + " </td>"
                        sum += ArrRowsPrecentage[k];

                    }
                    Avg = sum / parseInt(DistinctDays);
                    TotalAvg += Avg
                    if (Avg == null) {
                        
                    } else {
                        Avg = Avg.toFixed(2);
                    }
                    strHtml += "<td class='avrgtd'>" + Avg + "</td>"
                    strHtml += "</tr>"
                }

                //---------------------End of  Tbody--------------------------
                //------------------Total & Avg---------
                strHtml += "<tr><td><b>Total</b></td><td></td><td></td>";
                for (var i = 0; i < parseInt(DistinctDays); i++) {
                   // strHtml += "<td><b>" + eval(ArrTotal.join('+')) + "</b></td>";
                    strHtml += "<td><b>" + ArrTotal[i] + "</b></td>";
                }

                if (TotalAvg == null) {

                } else {
                    TotalAvg = TotalAvg.toFixed(2);
                }
                strHtml += "<td class='avrgtd'>" + TotalAvg + "</td>";
                strHtml += "</tr>";
                //------------------End of Total---------


                $("#tbody" + View).html("");
                $("#tbody" + View).html(strHtml);
                $('#resrsAllocationViewTbl' + View).dataTable({
                    // $('#resrsAllocationViewTblD').dataTable({
                    "scrollY": true,
                    "scrollX": true,
                    "pageLength": 10,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": true,
                    "retrieve": true,
                    "responsive": true,
                    "statesave": true,
                });
                $(".collapse").on('show.bs.collapse', function (e) {
                    $(".table").resize();
                });
                $(".collapse").on('hidden.bs.collapse', function (e) {
                    $(".table").resize();
                });

                $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                    $(".table").resize();
                });
            } else {
                IsNodata = 0;
                $("#tbody" + View).html("<tr><td style='text-align:center'>There are no items to show in this view.</td></tr>");
            }
        }

     
        function resizeSection() {
            var tblheight = $(window).height();
            $('#profiencyListTbl_wrapper .dataTables_scrollBody').css({ 'height': tblheight - 280, "overflow-y": "auto" });

        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });


        
        function Export_Click(ReportFormat) {
            //debugger;
            if (IsNodata == 1) {
                var View = $("#Resviewselect").val();
                var HDDetails = {
                    FromDate: selectedFDate,
                    ToDate: SelectedTDate,
                    View: View,
                    LoginEmployeeID: LoginEmployeeID,
                    UserName: UserName,
                    LoginID: LoginID,
                    LoginType: LoginType,
                    EmployeeID: EmployeeID,
                    ReportFormat: ReportFormat
                }
                var param = JSON.stringify(HDDetails);
                console.log(HDDetails);
                var strResult = AJAXCallWithResult("/api/RMResourceAllocationView/ExportToReport", param, false);
                if (strResult != "") {
                    if (strResult != "0") {
                        window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + strResult, "_report", "");
                    }
                }
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("There is no data present.");
            }

        }



    </script>

</body>

</html>
