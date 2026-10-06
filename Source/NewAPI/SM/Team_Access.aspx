<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Team_Access.aspx.vb" Inherits="Whizible.Team_Access" %>

<!DOCTYPE html>

<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%= MyBase.GetResourceString("C_TeamAccess") %></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/custom.css">
    <link href="../../../Whizible2.0-new/Plugins/alertify/css/alertify.min.css" rel="stylesheet" /> 

     <style type="text/css">
        #EmployeeTbl > thead{
            position:sticky;
            top:0;
            z-index:999;
        }
        .btnred {
            background: #fb3b3b;
            color: #fff;
        }
        .btnred:hover {
            background: #fb3b3b;
            color: #fff;
        }
        .tbody_billing_info > tr > td > .form-control {
            padding: 0px;
            width: 80px;
            margin: 0px;
        }

        .tdCurrent[colspan="6"] {
            border-right: 1px solid #ddd !important;
            background-color: #e7edf0 !important;
        }


        .hide-col {
            width: 0 !important;
            height: 0 !important;
            display: block !important;
            overflow: hidden !important;
            margin: 0 !important;
            padding: 0 !important;
            border: #808080 !important
        }

        td.hidecol, th.hidecol {
            display: table-cell;
            font-size: 0;
            /*            width: 20px !important;*/
            min-width: auto !important;
            border: #808080 !important;
            border-bottom: 1px solid #ddd !important;
            text-align: center !important;
            padding: 5px !important
        }

        .billing_info_task_Grid td.hidecol .fa-minus, .billing_info_task_Grid th.hidecol .fa-minus {
            display: none
        }

        .billing_info_task_Grid td.hidecol .fa-plus, .billing_info_task_Grid th.hidecol .fa-plus {
            display: block;
            font-size: 14px;
            color: #1359a6
        }


        .hidecol .custom_chckbox {
            display: none
        }


        .billing_info_task_Grid td.hidecol .fa-plus, .billing_info_task_Grid th.hidecol .fa-plus {
            display: block;
            font-size: 14px;
            color: #1359a6;
        }

        .billing_info_task_Grid td .fa-minus, .billing_info_task_Grid th .fa-minus {
            display: block
        }

        .billing_info_task_Grid td .fa-plus, .billing_info_task_Grid th .fa-plus {
            display: none
        }

        .billing_info_task_Grid td.hidecol .fa-minus, .billing_info_task_Grid th.hidecol .fa-minus {
            display: none
        }

        .billing_info_task_Grid td.hidecol .fa-plus, .billing_info_task_Grid th.hidecol .fa-plus {
            display: block;
            font-size: 14px;
            color: #1359a6
        }

        .hide-column {
            background: none;
            border: #808080;
            outline: none
        }

            .hide-column:hover, .hide-column:focus {
                background: none;
                border: none;
                outline: none
            }

        h5.pgtitle {
            margin: 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }
        .content {
            min-height: 0px;
        }

        .added_IR {
            background-color: #faf8b6;
        }
        .StageboxDiv {
            width: 20px;
            height: 20px;
            border: 1px solid #999;
            border-radius: 3px;
        }
        .stickytable thead {
            position: sticky;
            top: 0;
            z-index: 100;
        }
        .text_size {
            font-size: 12px !important;
        }
        .hypertext {
            text-decoration: underline;
        }
        .clsNote {
            color: red;
            /* float: right; */
            margin-left: 14px;
            /* margin-top: -14px; */
            font-size: 11px;
        }
/*        .fa-times {
            color: red;
        }*/
            .dblock {
            display: block;
        }

        .mb-1 {
            margin-bottom: 10px;
        }

/*        .dataTables_scrollBody {
            margin-bottom: 10px;
        }*/
        /*New Style*/
        .topfltr label {
            width: 120px;
            vertical-align: middle;
            text-align: right;
            margin-top: 5px;
        }

        .form-inline.topfltr.borderbox {
            border: 1px solid #eee;
            padding: 10px;
            background: #f5f5f5;
        }

        .topfltr .form-group {
            margin-right: 15px
        }

        .topfltr .form-group {
            margin-bottom: 10px;
            vertical-align: top;
        }

            .topfltr .form-group select.form-control, .topfltr .form-group select.form-control {
                width: 200px
            }

        .rowheading {
            background: #e7edf0
        }

            .rowheading td {
                font-weight: 700
            }

        tfoot tr {
            background: #e7edf0
        }

            tfoot tr td {
                font-weight: 700
            }

        .nostylebtn {
            background: none;
            border: none
        }

        /*.dataTables_paginate a.paginate_button.disabled {
            cursor: no-drop
        }*/

        .dataTables_paginate a.paginate_button {
            border: 1px solid #e9e9e9;
            min-width: 40px;
            display: inline-block;
            text-align: center;
            height: 32px;
            padding: 8px;
            line-height: 14px;
            color: #1359a6;
            margin-left: -1px;
            cursor: pointer
        }

            .dataTables_paginate a.paginate_button.current {
                background: #1359a6;
                color: #fff;
                cursor: pointer
            }

        .ui-datepicker {
            z-index: 9999 !important
        }

        .pr0 {
            padding-right: 0
        }

        table tr th, table tr td {
            text-align: center !important
        }

            table tr th:last-child, table tr td:last-child {
                text-align: center
            }

        .modalDTtabl {
            width: 100% !important
        }

        div.dataTables_scrollHead table.table-bordered {
            margin-top: 0px !important;
        }

        .mb-0 {
            margin-bottom: 0px !important;
        }

        .table thead tr th {
            padding: 8px;
        }

        tr.clsrowheader {
            background: #e7edf0;
        }

            tr.clsrowheader td, tr.rowtotal td {
                font-weight: 500;
            }

        tr.rowtotal {
            background: #f5f5f5;
        }

        tr.clsrowtotalmain {
            background: #cccccc;
        }

            tr.clsrowtotalmain td {
                font-weight: bold;
            }

        .stastusbtn {
            display: block;
            cursor: auto;
        }

        .actionTD a {
            margin: 0px 5px;
        }
        .offcanvas {
            width: 90% !important;
        }
        .notebox {
            padding: 8px;
            font-size: 11px;
            margin-bottom: 6px;
        }
        td{
            vertical-align:middle;
        }
        label {
            font-weight: 500;
        }
        #project_timeperiod {
            font-size: 15px;
            font-weight: 500 !important;
        }
        .bottom-note {
            position: absolute;
            bottom: 0;
            margin-bottom: 10px;
        }
        .dropdown-menu > li:hover {
            background-color: #e1e3e9;
            color: #333;
            width: 100% !important;
        }

        .main-menu li:hover > a,
        nav.main-menu li.active > a,
        .dropdown-menu > li > a:hover,
        .dropdown-menu > li > a:focus,
        .dropdown-menu > .active > a,
        .dropdown-menu > .active > a:hover,
        .dropdown-menu > .active > a:focus,
        .no-touch .dashboard-page nav.dashboard-menu ul li:hover a,
        .dashboard-page nav.dashboard-menu ul li.active a {
            color: #656363;
            background: none;
        }

         .alertify-notifier {
             z-index: 99999 !important;
         }

         table.dataTable thead > tr > th.sorting_asc:before, table.dataTable thead > tr > th.sorting_desc:after, table.dataTable thead > tr > td.sorting_asc:before, table.dataTable thead > tr > td.sorting_desc:after {
             opacity: 0 !important;
         }

         table.dataTable thead > tr > th.sorting::after, table.dataTable thead > tr > th.sorting_asc::after, table.dataTable thead > tr > th.sorting_desc::after, table.dataTable thead > tr > th.sorting_asc_disabled::after, table.dataTable thead > tr > th.sorting_desc_disabled::after, table.dataTable thead > tr > td.sorting::after, table.dataTable thead > tr > td.sorting_asc::after, table.dataTable thead > tr > td.sorting_desc::after, table.dataTable thead > tr > td.sorting_asc_disabled::after, table.dataTable thead > tr > td.sorting_desc_disabled::after {
             opacity: 0 !important;
         }

        .custom_chckbox input[type="checkbox"]:disabled + label:before {       
            cursor: no-drop;
        }

    </style>

</head>

<body class="hold-transition bgwhite sidebar-mini fixed">
   <%If m_blnViewAccess = True Then%>
    <div class="bgwhite">
      <div class="container-fluid  pt-2 pb-0 text-end graybg clearfix">
            <div class="row">
                <div class="col-sm-6">
                    <h5 class="pgtitle float-start pt-2 pb-2"><%= MyBase.GetResourceString("C_TeamAccess") %></h5>
                </div>
            </div>
        </div>

        <div class="content pt-0">
            <!-- Filters -->
            <div class="filtersSection" id="filterSec">
                <div class="py-2 mb-1 col-sm-12 text-end toplinks topFilters">
                    <div class="form-group mb-0">
                        <div class="row align-items-center">

                            <!-- Search Employee -->
                            <div class="col-sm-3 d-flex align-items-center">
                                <div class="input-group">
                                    <input id="serchEmployee" type="text" placeholder="Search Employee Name..."
                                        onkeyup="SearchEmployee()" class="form-control input-sm">
                                    <div class="input-group-btn">
                                        <button class="btn btn-default srchBtn" type="submit">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>

                          
                            <div class="col-sm-4 d-flex align-items-center">
                                <label for="RoleFilter" class="col-sm-4 text-end mb-0 pe-0"><%= MyBase.GetResourceString("C_Role") %></label>
                                <div class="col-sm-8">
                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_Whizible2_Sel_Role_TeamAccess ",,, "onchange='GetEmployeeList();' class='selectpicker' data-live-search='true'",,,) %>
                                </div>
                            </div>

                           
                            <div class="col-sm-4 d-flex align-items-center">
                                <label for="OUFilter" class="col-sm-4 text-end mb-0 pe-0"><%= MyBase.GetResourceString("C_OU") %></label>
                                <div class="col-sm-8">
                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_Whizible2_Sel_OU_for_TeamAccess ",,, "onchange='GetEmployeeList();' class='selectpicker' data-live-search='true'",,,) %>
                                </div>
                            </div>

                     <%If m_blnAddAccess = True Then%>
                            <div class="col-sm-1 d-flex justify-content-end align-items-center">
                                <button class="btn btnyellow" data-bs-toggle="tooltip" data-bs-placement="top" title="Save" id="SaveEmp" onclick="SaveEmployeeDetails()"><%= MyBase.GetResourceString("C_Save") %></button>
                            </div>
                       <%End If %>

                </div>
                    </div>
                </div>
            </div>

            <!-- Employee List View starts here -->
             <table id="EmployeeTbl" class="table table-bordered timesheet-tbl mx-2 " style="width:99%;">           
                <thead class="stickyTblHeader">
                    <tr>
                         <th class="text-start"><%= MyBase.GetResourceString("C_EmpID") %></th>
                         <th class="text-start"><%= MyBase.GetResourceString("C_EmpName") %></th>
                         <th class="text-start"><%= MyBase.GetResourceString("C_EmpCode") %></th>
                         <th class="text-start"><%= MyBase.GetResourceString("C_EmpEmailID") %></th>
                         <th>
                            <div>
                                <label for="PT_Gridcheck"><%= MyBase.GetResourceString("C_Select") %></label>
                            </div>
                         </th>
                    </tr>
                </thead>
                <tbody id="tbodyEmployeeTbl">

                </tbody>
            </table>
            <!-- Employee List View ends here -->
        </div>

    </div>
    <%Else %>
    <div id="ViewAccess" class="tab-pane" style="height: 448px">
        <div style="text-align: center">
            <p style="margin-top: 136px; font-weight: 700;"><%=MyBase.GetResourceString("C_NoAccess") %> </p>
        </div>
    </div>
    <%End If %>
    <div class="clearfix"></div>

     <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
    <!-- jqueryUI js -->

    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
        <script src="../../General/CommonValidations.js"></script> 

    <script>

        $(function () {
            $('[data-bs-toggle="tooltip"]').tooltip()
        })
        $(document).on("click", function () {
            $(".tooltip").remove();
        });
        function refreshPage() {
            window.location.reload();
        }

        // tbody height
        function resizeSection() {
            var listviewTreeHeight = $(window).height();
            $('.init_grid_panel').css({
                'height': listviewTreeHeight - 280,
                "overflow-y": "auto",
                "overflow-x": "auto"
            });

        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });
        //end script

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust();
        });

        //Added by Ajit L on 09/12/2024
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Configuration").ToString%>';
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var SessionLoginType = '<%=  Session("LoginType") %>';
        var UserName = '<%= Session("strUserName") %>';

        var ViewAccess = '<%=m_blnViewAccess%>';
        var EditAccess = '<%=m_blnEditAccess%>';
        var DeleteAccess = '<%=m_blnDeleteAccess%>';
        var AddAccess = '<%=m_blnAddAccess%>';
        alertify.set('notifier', 'position', 'top-right');
        //AjaxCall Function start here 
        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {
            $.ajax({
                url: encodeURI(strUrl) + url,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Configuration"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }
            //AjaxCall Function end here


        var checkedRecords = [];
        $(document).ready(function () {
      
            GetEmployeeList();
        });

        function GetEmployeeList() {
            var RoleID = $("#cboRole").val();
            var OUID = $("#cboOU").val();

            var Parameter = {
                RoleID: RoleID,
                OUID: OUID
            }
  
            var param = JSON.stringify(Parameter);
            var Result = AJAXCallWithResult("/api/TeamsAccess/GetEmployeeList", param, false);
            EmployeeList = Result;
            var strHTML = "";
            $('#EmployeeTbl').dataTable().fnDestroy();
            $("#tbodyEmployeeTbl").html("");
            if (Result != null && Result != undefined && Result != "") {
                for (var i = 0; i < Result.length; i++) {
                    var IsDisabled = "";
                    var IsChecked = "";
                    var SavedEmpID = Result[i].SavedEmpID
                    if (SavedEmpID != 0) {
                        IsDisabled = "Disabled";
                        IsChecked = "checked";
                    }
                    else {
                        IsDisabled = "";
                    }

                    strHTML += `<tr>
                        <td class="text-start">${Result[i].EmployeeId}</td>
                        <td class="text-start">${Result[i].EmployeeName}</td>
                        <td class="text-start">${Result[i].EmployeeCode}</td>
                        <td class="text-start">${Result[i].EmailID}</td>
                        <td>
                            <input type="hidden" name="hdn_PTEmployeeId" id="hdn_PTEmployeeId" value="${Result[i].EmployeeId}">                     
                            <div class="custom_chckbox">
                                <input id="chk_${i}" onclick="checkUncheck(this)" class="chcktbl" type="checkbox"${IsChecked} ${IsDisabled}>
                                <label for="chk_${i}"></label>
                            </div>
                        </td>
                    </tr>`;

                }
                $("#tbodyEmployeeTbl").html(strHTML);

                $('#EmployeeTbl').dataTable({
                    "paging": true,
                    "pageLength": 10,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": true,
                    "bFilter": false,
                });
                $(".table").resize();
            }
        }

        var EmployeeList = '';
        function SearchEmployee() {
            var SearchText = $("#serchEmployee").val();
            var FilterTitle = EmployeeList.filter(function (x) { return x.EmployeeName.toLowerCase().indexOf(SearchText.toLowerCase()) !== -1 });
            ReloadTableSearchEmployee(FilterTitle);
        }

        function ReloadTableSearchEmployee(Result) {

            $('#EmployeeTbl').dataTable().fnDestroy();
            var strHTML = "";
            $("#tbodyEmployeeTbl").html('');

            if (Result != null && Result != undefined && Result != 0) {
                for (var i = 0; i < Result.length; i++) {
                    var IsDisabled = "";
                    var SavedEmpID = Result[i].SavedEmpID
                    if (SavedEmpID != 0) {
                        IsDisabled = "Disabled"
                    }
                    else {
                        IsDisabled = "";
                    }
                    strHTML += `<tr>
                        <td class="text-start">${Result[i].EmployeeId}</td>
                        <td class="text-start">${Result[i].EmployeeName}</td>
                        <td class="text-start">${Result[i].EmployeeCode}</td>
                        <td class="text-start">${Result[i].EmailID}</td>
                        <td>
                            <input type="hidden" name="hdn_PTEmployeeId" id="hdn_PTEmployeeId" value="${Result[i].EmployeeId}">                     
                            <div class="custom_chckbox">
                                <input id="chk_${i}" onclick="checkUncheck(this)" class="chcktbl" type="checkbox" ${IsDisabled}>
                                <label for="chk_${i}"></label>
                            </div>
                        </td>
                    </tr>`;

                }
            }
            $("#tbodyEmployeeTbl").html(strHTML);

            $('#EmployeeTbl').dataTable({
                "paging": true,
                "pageLength": 10,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": true,
                "bFilter": false,
            });
            $(".table").resize();
        }

        var SelectedEmpID = [];
        function checkUncheck(currentObject) {
            var table = $('#EmployeeTbl').DataTable(); 
            var enabledCheckboxes = table.rows().nodes().to$().find('input.chcktbl:not(:disabled)');
            var checkedCheckboxes = enabledCheckboxes.filter(":checked");

            $(".chckHead").prop("checked", checkedCheckboxes.length === enabledCheckboxes.length);

            // Update SelectedEmpID array
            SelectedEmpID = []; 

            table.rows().every(function () {
                var row = $(this.node());
                var checkbox = row.find('input.chcktbl:not(:disabled)');
                var empID = parseInt(row.find('input[name="hdn_PTEmployeeId"]').val(), 10); 

                if (checkbox.is(':checked') && !SelectedEmpID.includes(empID)) {
                    SelectedEmpID.push(empID);
                }
            });
        }


        function SaveEmployeeDetails() {

            if (!SelectedEmpID || SelectedEmpID.length === 0) {
                alertify.error("<%= MyBase.GetResourceString("A_SelectEmp") %>"); 
                return;
            }
            var Parameters = {
                UserId: SessionEmployeeId,
                LoginType: 'E',
                EmployeeIDs: SelectedEmpID.toString() 
            };
            var param = JSON.stringify(Parameters); 

            var Result = AJAXCallWithResult("/api/TeamsAccess/SaveEmployeeDetails", param, false);

            if (Result == "Saved") {
                alertify.success("<%= MyBase.GetResourceString("A_Saved") %>");
                SelectedEmpID = [];
                GetEmployeeList();
            }
        }


    </script>

</body>

</html>
