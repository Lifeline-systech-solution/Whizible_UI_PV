<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_UnlockUser.aspx.vb" Inherits="PbNIT.CRM_UnlockUser" %>

<!DOCTYPE html>

<html>

<%CommonFunctions.General.PlotPageHeadTag("")%>
<head runat="server">
    <%--<title></title>--%>
    <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Unlock User")%>--%>
   
    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/editor.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/reqdetail.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/setting.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />--%>


    <script src="../../../Whizible2.0-new/dist/js/timepicker.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/New_CommonFunctions.js"></script>
    <%--<script src="../../General/CommonFunctions.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/editor.js"></script>
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/timepicker.min.js"></script>
    <%--<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
<script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>

    <style>
          

        table.dataTable thead .sorting::before,
        table.dataTable thead .sorting::after,
        table.dataTable thead .sorting_asc::before,
        table.dataTable thead .sorting_asc::after,
        table.dataTable thead .sorting_desc::before,
        table.dataTable thead .sorting_desc::after,
        table.dataTable thead .sorting_asc_disabled::before,
        table.dataTable thead .sorting_asc_disabled::after,
        table.dataTable thead .sorting_desc_disabled::before,
        table.dataTable thead .sorting_desc_disabled::after {
            position: absolute;
            bottom: 0.9em;
            display: none !IMPORTANT;
            opacity: 0.3;
        }
        .dataTables_wrapper .row:nth-child(1) {
            display: none;
        }
        @media screen and (min-width: 200px) {
            #idSearchHistory {
                position: absolute;                
                margin-top: 3%;
                margin-left: 10px;
            }
        }
       
         @media screen and (min-width: 1000px) {
            #idSearchHistory {
                position: absolute;
                margin-top: 14px;
                /*margin-top: 3%;*/
                margin-left: 10px;
            }
        }

        .table {
            border-bottom: 2px solid #e3e2e2;
        }
        #divUnlockUser  th:nth-child(3) {
            text-align: center;
        }
        #divUnlockUser td {
            border: none !important;
            font-family: Verdana !important;
            font-size: 12px !important;
        }
        table.dataTable thead > tr > th.sorting_asc, table.dataTable thead > tr > th.sorting_desc, table.dataTable thead > tr > th.sorting, table.dataTable thead > tr > td.sorting_asc, table.dataTable thead > tr > td.sorting_desc, table.dataTable thead > tr > td.sorting {
            padding-right: 1%;
        }
        #txtSearchHistory {
            outline:none;
        }
        .dataTables_info {
            font-size: 13px;
        }
        

        .alertify-notifier {
            font-family: "Open Sans",sans-serif!important;
            font-size: 12px !important;
        }

         /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
        .form-control:-ms-input-placeholder { /* IE 10+ */
          color: #bbb!important;
        }
          /*Added By Yasmin on 25th july 2018*/
        .dataTables_paginate {
        float:right;
        }
        .ui-tooltip {
	        padding: 4px!important;
	        position: absolute;
	        z-index: 9999;
	        max-width: 300px;
            background: #000 !important;
            color: #fff !important;
	        -webkit-box-shadow: 0!important;
	        box-shadow: 0 !important;
            border:none!important;
            font-size:11.5px!important;
        }
       .ui-tooltip-content::after, .ui-tooltip-content::before {
                top: 100%;
                border: solid transparent;
                content: " ";
                height: 0;
                width: 0;
                position: absolute;
        }

        .bottom .ui-tooltip-content::after {
            border-color: rgba(118, 118, 118, 0);
            border-top-color: #000;
            border-width: 6px;
            left: 50%;
            margin-left: -6px;
        }

        .bottom .ui-tooltip-content::before {
            border-color: rgba(118, 118, 118, 0);
            border-top-color: #000;
            border-width: 6px;
            left: 50%;
            margin-left: -6px;
        }

        .top .ui-tooltip-content::after {
            top: -6px;
            left: 50%;
            border-bottom-color: #000;
    
            border-width: 0 6px 6px;
            margin-left: -6px;
        }

        .top .ui-tooltip-content::before {
             border-color: rgba(118, 118, 118, 0);
             border-bottom-color: #000;
             top: -6px;
             left: 50%;
             border-width: 0 6px 6px;
             margin-left: -6px;
         }
    </style>
    <script>
       
      
        var DivSerach;
        var DivId;
        DivId = "divUnlockUser";
        DivSerach = "txtSearchHistory";

        $(document).click(function () {
            //alert(window.parent.parent.parent.location);
            $("#profileDropdwn", window.parent.parent.parent.document).parent().removeClass("open");
            $("#ulUserThemes", window.parent.parent.parent.document).parent().removeClass("open");

        })
        $(document).ready(function () {
            datatables(DivId, DivSerach);
          
        });
       
        function SelectMultipleUsers() {
            //debugger;

            var table = $('#divUnlockUser table').DataTable();
            var rows = table.rows({ 'search': 'applied' }).nodes();

            var group = "input:checkbox[id='chkLockUserSelect']";
            // the checked state of the group/box on the other hand will change
            // and the current value is retrieved using .prop() method

            if ($("#chkUserSelectAll").is(":checked"))
                //$(group).filter(function () {
                //    return !this.disabled;
                //}).prop("checked", true);
                $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true);
            else
                //$(group).filter(function () {
                //    return !this.disabled;
                //}).prop("checked", false);
                $('input[type="checkbox"]', rows).prop('checked', false);

            $("[title]").click(function () {
                $('.ui-tooltip').fadeOut('fast', function () {
                    $('.ui-tooltip').remove();
                });
            });
        }
        function datatables(divID, txtBoxID) {
            $('#' + divID + ' table').removeClass("clsGridTable");
            $('#' + divID + ' table').addClass("table table-bordered table-stripped");
            var table = $('#' + divID + ' table').DataTable({
                responsive: true,
                pageLength: 10,
                //scrollY: '130px',

                pagingType: "simple_numbers",

            });


            if (txtBoxID != "") {
                $('#' + txtBoxID).on('keyup change', function () {
                    table.search($(this).val()).draw();
                })
            }
        }
        function  unlockUser()
        {
            var strLockedUserIds;
            strLockedUserIds = $('input[id=chkLockUserSelect]:checked').map(function () {
                return this.value;
            }).get().join(',');
           
            if (strLockedUserIds.length <= 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please select at least one user to unlock', 'error');
                return;
            }           
           
            var url = "CRM_UnlockUser.aspx/UnlockUser"

            data = JSON.stringify({ LoginID: strLockedUserIds });
            CustomAJAXCall(url, data, BindTRUpdateGrid);

        }
        function BindTRUpdateGrid(result) {
            if (strResult.d != "") {
                if (result.d == "Success") {
                    
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Selected User(s) Unlocked successfully', 'success');
                }
                else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(result.d, 'error');
                }
            }
            //if (result.d == "Success") {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('Selected User(s) Unlocked successfully', 'success');
            //}
            //else {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify(result.d, 'error');
            //}
            RefreshGrid();
        }
        function RefreshGrid() {
            //debugger;
            var strResult, data;

            data = JSON.stringify({ GridParam: "divUnlockUser" });

            strResult = AJAXCallWithResult("CRM_UnlockUser.aspx/GetGridData", data, false);
          
            if (strResult.d != '') {
             
               
                $("#" + DivId).html(strResult.d);

                $("#" + DivId).addClass("table");
              
            }
            var TypeDiv; var accordion;
            //TypeDiv = document.getElementById('divRequestTypes');
            //accordion = document.getElementById('accordion');
            var intDivGridHeight
            //   if (TypeDiv != null && accordion != null) {
            //if (WhichBrowser() == "IE") {
            //    intDivGridHeight = (window.innerHeight / 2);

            //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {

            //        intDivGridListHeight = parseInt(window.innerHeight) - 320;
            //    }
            //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

            //        intDivGridListHeight = parseInt(window.innerHeight) - 320;
            //    }
            //    else {

            //        intDivGridListHeight = parseInt(window.innerHeight) - parseInt($('#' + DivId).offset().top) - 250;
            //    }

            //    $('.panel-body').css('height', intDivGridListHeight + "px");
            //    //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);
            //    $('#divRequestTypes').css('height', intDivGridListHeight - 130 + "px");
            //}
            //else {
            //    intDivGridHeight = (window.innerHeight / 2);

            //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
            //        intDivGridListHeight = parseInt(window.innerHeight) - 385;
            //    }
            //    else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
            //        intDivGridListHeight = parseInt(window.innerHeight) - 385;
            //    }
            //    else {
            //        intDivGridListHeight = (window.innerHeight / 3) - 5;
            //    }

            //    $('#accordion').css('height', intDivGridListHeight - 20 + "px");
            //    //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);
            //    $('#divRequestTypes').css('height', intDivGridListHeight - 130 + "px");
            //}

            datatables(DivId, DivSerach);           

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
                    //Stop();
                },
                error: function (xhr, status, error) {
                    //Stop();
                    //StopAjaxLoader("body");
                    $(".loadingoverlay", parent.document).css("display", "none");
                    console.log(xhr.responseText);
                    //window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

            return AjaxResult;
        }
        function CustomAJAXCall(url, data, method) {
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: "json",
                contentType: "application/json",
                timeout: 180000,
                async: false,
                success: function (result) {
                    method(result);
                },
                error: function (xhr, status, error) {
                    console.log(xhr.responseText);
                    window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                }
            });

        }

        /*Added By Yasmin on 25th july 2018*/

        $(function () {
            $(document).tooltip({
                position: {
                    my: "center bottom-20",
                    at: "center top",
                    using: function (position, feedback) {
                        $(this).css(position);
                        $(this)
                            .addClass(feedback.vertical);
                    }
                }
            });

        });

        $("[title]").click(function () {
            $('.ui-tooltip').fadeOut('fast', function () {
                $('.ui-tooltip').remove();
            });
        });
    </script>
</head>

<body>
    <form id="form1" runat="server">
        <div>
            <% PlotHTML()%>
        </div>
    </form>
</body>
</html>
