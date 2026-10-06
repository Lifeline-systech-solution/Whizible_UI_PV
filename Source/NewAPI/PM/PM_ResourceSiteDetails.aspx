<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ResourceSiteDetails.aspx.vb" Inherits="PbNIT.PM_ResourceSiteDetails" %>

<!DOCTYPE html>
<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>

    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
    

    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.2">
    <link href="../../../Whizible2.0-new/dist/css/BS5_migration.css" rel="stylesheet" />
    <!-- media_queries -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">--%>

    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">

    <%--alertify Css--%>
    <%-- <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=0.1">--%>

</head>

    <style>
        .input-group-btn button.btn.btncalendar {
            height: 35px;
        }
          /*Added by Riddhesh Patil content 27th March 2023*/
        th.sorting_disabled::after, th.sorting_disabled::before{
            display:none!important;
        }
         /*End of Added by Riddhesh Patil content 27th March 2023*/

        .ui-datepicker {
            z-index: 9999 !important;
        }

        .custom_chckbox input[type=checkbox][disabled] + label:before {
            CURSOR: NOT-ALLOWED;
        }

        body {
            background: #fff;
        }

        .alertify-notifier {
            z-index: 9999;
        }

        #siteTransfer .note-wrap-txt {
            width: 100% !important;
            margin: 0px auto 15px;
        }

        /*New css added by pradip on 13-12-2019*/
        .accordian-body .dataTables_info {
            float: left;
        }

        .accordian-body .dtscroll {
            min-height: 65vh;
        }

            .accordian-body .dtscroll table tr td:last-child .custom_chckbox label::before {
                margin-right: 0;
            }

        .resource-emp-tbl tbody td.dataTables_empty {
            text-align: center;
        }

        .dataTables_scrollBody .emp-bill-tbl .dataTables_sizing::after {display:none;}
        .disabledbutton {
            cursor: not-allowed;
            /*opacity: 0.5;*/
        }
            .disabledbutton a, .disabledbutton td {
                pointer-events: none;
            }

            .disabledbutton .custom_chckbox {
                pointer-events: none;
                cursor:none;
            }



        .dataTables_scrollBody thead tr[role="row"]{
          visibility: collapse !important;
        }

        #siteTransfer, #ui-datepicker-div {
            cursor: auto;
        }
        
.accordian-body, #siteTransfer { cursor: auto;}
/*#ui-datepicker-div{ top:auto!important; bottom:0;}*/

td.hiddenRow.subCustomField .accordian-body{ padding:10px 0px;}
.note-wrap-txt h5{ font-size:14px;}
    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="MainResourceSiteDetails">
    

    <% If m_blnRSDViewAccess = True Then %>
    <div class="tab-pane pstbl_custom pt-0 in active" id="resourceSiteDetails">
        <%-- <div class="page-main-head">
            <h4><%= MyBase.GetResourceString("C_ResourceSite") %></h4>
        </div>--%>


        <div class="col-sm-12 pt-1 pb-1 mb-10 graybg" id="Divtop">
            <div class="row">
                <div class="col-sm-3">

                    <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceProjects", "Select ''",,, "class='form-select'",,, ) %>
                </div>
                <div class="col-sm-9">

                    <div class="" id="SelectResourceSite">
                        <div class="row">
                            <div class="col-sm-5 row">
                                <label class="control-label col-sm-1" style="padding-top: 8px;"> <%= MyBase.GetResourceString("C_Site") %></label>
                                <div class="col-sm-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceSite", "Select ''",,, "class='form-select'",,, ) %>
                                </div>

                            </div>
                            <% If m_blnRSDEditAccess = True Then %>
                            <div class="float-end col">
                                <div class="right-side-save">
                                    <button id="siteTrans1" class="btn borderbtn" onclick="ResourceSiteTrasfer(true)"><%= MyBase.GetResourceString("C_SiteTransfer") %></button>
                                </div>
                            </div>
                            <% End If %>
                            <div class="clearfix"></div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <div class="clearfix"></div>


        <div class="clearfix"></div>
        <div class="resource-detail-panel mt-1" id="AllresourceSiteDetails">
            <%-- <div class="page-main-head">
                <h4><%= MyBase.GetResourceString("C_ResourceSiteDetails") %></h4>
            </div>--%>
            <div class="scrollable-area">
                <table class="table table-bordered resource-emp-tbl" id="ResourceSiteTbl">
                    <thead>
                        <tr>
                            <th><%= MyBase.GetResourceString("C_EmployeeName") %></th>
                            <th><%= MyBase.GetResourceString("C_Role") %></th>
                            <th><%= MyBase.GetResourceString("C_Site") %></th>
                            <th><%= MyBase.GetResourceString("C_TransferDate") %></th>
                            <th><%= MyBase.GetResourceString("C_SiteTransfer") %></th>
                        </tr>
                    </thead>
                    <tbody id="ResourceSiteTblBody">
                    </tbody>
                </table>
            </div>
        </div>

        <!--Page modal start here-->

        <!--Site Transfer modal start here -->
        <div class="modal custmodal fade" id="siteTransfer" aria-hidden="true" data-keyboard="false" data-bs-backdrop="static">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="H5ResourceSite"></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-3">
                            <div class="note-wrap note-wrap-txt mt-0 pt-10">
                                <span id="CheckWhichModal"></span>
                                <h5 id="h5siteTransfer"></h5>
                            </div>
                            <div class="row">
                                <span id="SpanEmployeeSiteID"></span>
                                <span id="SpanEmployeeID"></span>
                                <div class="col-sm-4">
                                    <label class="required" id="LabelSite"></label>
                                    <div class="custom-dropdown ">
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboSiteEmpSite", "Select ''",,, "class='form-select'",,, ) %>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <label class="required"><%= MyBase.GetResourceString("C_Role") %></label>
                                    <div class="custom-dropdown ">
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboSiteEmpRole", "Select ''",,, "class='form-select'",,, ) %>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <%--<label class="required" id="LabelDate"><%= MyBase.GetResourceString("C_EffectiveDate") %></label>--%>
                                    <label class="required" id="LabelDate"></label>

                                    <div class="input-group datefielddiv">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtSiteEffDate", "txtSiteEffDate", "form-control",,,,,,,,,, "onkeypress='return Date_OnKeyPress(event)' autocomplete='off' onPaste='return false'",,, True,,,, True) %>

                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="">

                            <a href="javascript:;" data-bs-dismiss="modal" class="btn borderbtn "><%= MyBase.GetResourceString("C_Close") %></a>

                            <a href="javascript:;" class="btn btnyellow fl-right" onclick="SaveResourceonclick();" id="SavesiteTransfer"><%= MyBase.GetResourceString("C_Save") %></a>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Site Transfer modal end here -->

        <!--confrimation modal start here -->
        <div class="modal custmodal fade" id="confirmationmodal" aria-hidden="true" data-bs-dismiss="modal" data-keyboard="false" data-bs-backdrop="static">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="HResourceSite"><%= MyBase.GetResourceString("C_ConfirmationAlert") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p><%= MyBase.GetResourceString("C_ConfirmationAlertNote") %></p>
                        <br />
                        <br />
                        <p id="AlertMsg"></p>
                        <br />
                        <div class="text-center">
                            <a href="javascript:;" data-dismiss="modal" class="btn btnyellow"><%= MyBase.GetResourceString("C_OK") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- confrimation modal -->

        <!--Added new confrimation modal by Vishal Mane on 08/12/2025 to transfer site on same date -->
        <div class="modal custmodal fade" id="confirmationmodal_New" aria-hidden="true" data-bs-dismiss="modal" data-keyboard="false" data-backdrop="static">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="HResourceSite"><%= MyBase.GetResourceString("C_ConfirmationAlert") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p><%= MyBase.GetResourceString("C_ConfirmationAlertNote") %></p>
                        <br />
                        <br />
                        <p id="AlertMsg_New"></p>
                        <br />
                        <div class="text-center">
                             <a href="javascript:;" class="btn btnyellow" onclick="AllowToTransferResource(1)">Yes</a>
                            <a href="javascript:;" data-dismiss="modal" class="btn btnyellow" onclick="AllowToTransferResource(0)">No</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End of Added new confrimation modal by Vishal Mane on 08/12/2025 to transfer site on same date -->
        <!--Effective date modal start here-->
      <%--  Added & Commented By Dipali V On 10th Sep 2025 For Pointwest upgrade--%>
        <%--<div class="modal custmodal fade" id="effDateModal" aria-hidden="true" data-bs-dismiss="modal" data-keyboard="false" data-backdrop="static">--%>
        <div class="modal custmodal fade" id="effDateModal" aria-hidden="true" data-dismiss="modal" data-keyboard="false" data-backdrop="static">
           <%--End of Added & Commented By Dipali V On 10th Sep 2025 For Pointwest upgrade--%>
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_EmployeeBillingRateHistory") %></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row form-group">
                            <div class="col-sm-4">
                                <label class="required"><%= MyBase.GetResourceString("C_ProjectSite") %></label>
                                <div class="custom-dropdown">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("CboProSite", "Select ''",,, "class='form-select'",,, ) %>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <label class="required"><%= MyBase.GetResourceString("C_Role") %></label>
                                <div class="custom-dropdown">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboProRole", "Select ''",,, "class='form-select'",,, ) %>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <label class="required"><%= MyBase.GetResourceString("C_EffectiveFromDate") %></label>
                                <div class="input-group datefielddiv">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("TxtProEffDate", "TxtProEffDate", "form-control",,,,,,,,,, "onkeypress='return Date_OnKeyPress(event)' onPaste='return false'""autocomplete='off'",,, True,,,, True) %>

                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-sm-4">
                                <label class="required"><%= MyBase.GetResourceString("C_ToDate") %></label>
                                <div class="input-group datefielddiv">
                                    <% CommonFunctions.HTMLControls.DrawTextBox("TxtProToDate", "TxtProToDate", "form-control",,,,,,,,,, "onkeypress='return Date_OnKeyPress(event)'""autocomplete='off' onPaste='return false'",,, True,,,, True) %>

                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <label class="required"><%= MyBase.GetResourceString("C_NormalRate") %></label>
                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtProNormalRate", "txtProNormalRate", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>--%>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtProNormalRate", "txtProNormalRate", "form-control",, 9,,,,,,,, "placeholder='Enter Normal Rate (Maxlength 9 digit)' autocomplete='Off' maxlength='9'",,, True,,,, True) %>
                            </div>
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_ExtraRate") %></label>
                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtProExtraRate", "txtProExtraRate", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>--%>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtProExtraRate", "txtProExtraRate", "form-control",, 9,,,,,,,, "placeholder='Enter Extra Rate (Maxlength 9 digit)' autocomplete='Off' maxlength='9'",,, True,,,, True) %>
                            </div>
                        </div>
                        <div class="row form-group">
                            <div class="col-sm-4">
                                <label><%= MyBase.GetResourceString("C_HolidayRate") %></label>
                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtProHolidayRate", "txtProHolidayRate", "form-control",,,,,,,,,, "autocomplete='off'",,, True,,,, True) %>--%>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtProHolidayRate", "txtProHolidayRate", "form-control",, 9,,,,,,,, "placeholder='Enter Holiday Rate (Maxlength 9 digit)' autocomplete='Off' maxlength='9'",,, True,,,, True) %>
                            </div>
                        </div>
                        <div class="mt-3">
                            <a href="javascript:;" data-dismiss="modal" class="btn borderbtn "><%= MyBase.GetResourceString("C_Close") %></a>
                            <a href="javascript:;" class="btn btnyellow fl-right" onclick="UpdateBillingRateHistory();" id="saveEffDateModal"><%= MyBase.GetResourceString("C_Save") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Effective date modal emp7nd here-->


        <!--Delete confrimation modal start here -->
          <%--Added & Commented By Dipali V On 10th Sep 2025 For Pointwest upgrade--%>
        <%--<div class="modal custmodal fade" id="Deleteconfirmationmodal" aria-hidden="true" data-bs-dismiss="modal" data-keyboard="false" data-backdrop="static">--%>
        <div class="modal custmodal fade" id="Deleteconfirmationmodal" aria-hidden="true" data-dismiss="modal" data-keyboard="false" data-backdrop="static">
             <%--End of Added & Commented By Dipali V On 10th Sep 2025 For Pointwest upgrade--%>
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title"><%= MyBase.GetResourceString("C_ConfirmationDelete") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="text-center">
                            <span id="CheckModal"></span>
                            <p><%= MyBase.GetResourceString("C_DeleteNote") %></p>
                        </div>
                        <br />
                        <div class="">
                            <a href="javascript:;" data-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_No") %></a>
                            <a href="javascript:;" data-dismiss="modal" class="btn btnyellow fl-right" onclick="DeleteData();"><%= MyBase.GetResourceString("C_Yes") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Delete confrimation modal -->

        <!--Page modal end here-->
        <%CommonFunctions.HTMLControls.DrawTextBox("txtHiddenEmployeeID", "txtHiddenEmployeeID",, IsHidden:=True, EnableHTMLEncode:=True) %>
        <%CommonFunctions.HTMLControls.DrawTextBox("txtHiddenBillingPercentage", "txtHiddenBillingPercentage",, IsHidden:=True, EnableHTMLEncode:=True) %>
        <%CommonFunctions.HTMLControls.DrawTextBox("txtHiddenTransferDate", "txtHiddenTransferDate",, IsHidden:=True, EnableHTMLEncode:=True) %>
        <%CommonFunctions.HTMLControls.DrawTextBox("TxtProjectEndDate", "TxtProjectEndDate",, IsHidden:=True, EnableHTMLEncode:=True) %>
    </div>



    <div class="clearfix"></div>
    <% Else %>
    <div id="NotAuthorized">
        <br />
        <br />
        <center><h4>You are not authorized to view this record. </h4></center>
    </div>
    <% End If %>


    <!-- REQUIRED JS SCRIPTS -->
  
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
    <!-- jqueryUI js -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
   
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>

    
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>

    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js"></script>--%>
	<%-- Added by Chetan M on 20th Jully 2020 for IssueID 25620 --%>
    <%--<script src="../../General/CommonFunctions.js"></script>--%>
    <%-- End of Added by Chetan M on 20th Jully 2020 for IssueID 25620 --%>
    <!-- alertify -->
    <%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js"></script>--%>


    <script>


        // passing a fixedOffset param will cause the table header to stick to the bottom of this element
        //$("table").stickyTableHeaders({ scrollableArea: $(".scrollable-area")[0], "fixedOffset": 0 });

        // $("table").stickyTableHeaders();








        //$('.editor1').wysihtml5();
        //change date format
        var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
            "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
        var uDatepicker = $.datepicker._updateDatepicker;
        $.datepicker._updateDatepicker = function () {
            var ret = uDatepicker.apply(this, arguments);
            var $sel = this.dpDiv.find('select');
            $sel.find('option').each(function (i) {
                $(this).text(months[i]);
            });
            return ret;
        };

        //datepicker
        $(function () {
            $('#txtTransferDate, #txtSiteEffDate, #TxtProjectEndDate').datepicker({
                autoclose: true,
                changeMonth: true,
				changeYear: true, //added by pradip on 09-04-2020
                dateFormat: 'dd M yy'

            });

        });

        $("#workflowSLTAll, #billHistroyTblAll").click(function () {
            $(".projAppro-chck, .bill-history-chck").prop('checked', $(this).prop('checked'));
        });

        $(".projAppro-chck, .bill-history-chck").change(function () {
            if (!$(this).prop("checked")) {
                $("#workflowSLTAll, #billHistroyTblAll").prop("checked", false);
            }
        });
        $("#roleSltAll").click(function () {
            $(".role-chck").prop('checked', $(this).prop('checked'));
        });

        $(".role-chck").change(function () {
            if (!$(this).prop("checked")) {
                $("#roleSltAll").prop("checked", false);
            }
        });

        function closeaccordian(id) {

            $("#accordionEmp" + id).removeClass("show");
            $("#ResourceSiteTblBody>tr").css("pointer-events", "auto");
            $("#ResourceSiteTblBody>tr .accordian-body tr").css("pointer-events", "auto");
              $("#ResourceSiteTblBody>tr .accordian-body tr").css("cursor", "auto");
            //$("#ExeTempSelBody .btn").css("pointer-events", "auto");
            $("#siteTrans1").css("pointer-events", "auto");
            $("#ResourceSiteTblBody>tr").css("pointer-events", "auto");
            $("#Divtop").css("pointer-events", "auto");
            $("#Divtop").css("cursor", "pointer");

            $("body:not(.hiddenRow)").css("cursor", "auto");
            $("body:not(.accordian-body)").css("cursor", "auto");
            GetResourceSiteList();

        }

        window.onload = function () {
            setTimeout(function () {
                scrollTo(0, 0);
            }, 100); //100ms for example
        }

        $("#resourceSiteDetails > div.resource-detail-panel > table > tbody input").change(function () {
            var chk_box_checked_cnt = $('#resourceSiteDetails > div.resource-detail-panel > table > tbody input[type="checkbox"]:checked').length;
            if (chk_box_checked_cnt > 0) {
                $('#siteTrans1').removeClass('site-disabled');
            } else if (chk_box_checked_cnt == 0) {
                $('#siteTrans1').addClass('site-disabled');
            } else if (chk_box_checked_cnt > 2) {
                $('#siteTrans1').addClass('site-disabled');
            }
        });



    </script>
    <script>
        var ajaxResult = "";
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        alertify.set('notifier', 'position', 'top-right');
        var ProjectID = '<%= ProjectID %>';
        var GlobalEmployeeName = "";
        var GlobalSiteID = "";
        var GlobalEmployeeBillingInfoID = "";
        var SiteName = '';
        var GlobalEmployeeID = "";
        var ArrEmployeeSiteChk = [];
        var ArrBillingRateChk = [];
        var arrDocCatIds = [];
        var ArrEmployeeName = [];
        var SelectedBillingRateChk = "";
        var SelectedEmployeeSiteChk = "";
        var SessionProjectID = '<%= ProjectID %>';
        var UserID = '<%= Session("intUserID") %>';
        var LoginType = '<%= Session("LoginType") %>';
        var SelectedEmployees = "";

        $(document).ready(function () {
            $("html,body").animate({ scrollTop: 0 }, 100); //100ms for example

            FillProjectCombox();

            if (ProjectID != 0 || SessionProjectID != 0) {
                $("#cboResourceSite").prop("disabled", false);
                $("#siteTrans1").prop("disabled", false);
                var param = JSON.stringify(encodeURI(ProjectID));
                var IsOver = AJAXCallWithResult("/api/PM_ResourceSiteDetails/ProjectIsOver", param, false);
              //  debugger;
                if (IsOver == 1) {
                    $("#siteTrans1").addClass("disabledbutton");
                    $("#siteTrans2").addClass("disabledbutton");
                    $("#AllresourceSiteDetails").addClass("disabledbutton");
                    $("#cboResourceSite").prop("disabled", true);
                    $("#siteTrans1").prop("disabled", true);
                }
                else
                {
                    $("#AllresourceSiteDetails").removeClass("disabledbutton");
                    $("#cboResourceSite").prop("disabled", false);
                    $("#siteTrans1").removeClass("disabledbutton");
                    $("#siteTrans2").removeClass("disabledbutton");
                    $("#siteTrans1").prop("disabled", false);
                    $("#cboResourceSite").val('');
                   
                   
                    $("#ResourceSiteTblBody>tr").css("pointer-events", "auto");
                    $("#ResourceSiteTblBody>tr").css("cursor", "pointer");
                    $("#siteTrans1").css("pointer-events", "auto");
                }

                 FillSiteCombo();
                 GetResourceSiteList();
                 GetEmpRole();
                 GetEmpSite();
              
            }
            else {
                StartLoader("#MainResourceSiteDetails");
                GetResourceSiteList();
                 FillSiteCombo();
                 GetResourceSiteList();
                 GetEmpRole();
                 GetEmpSite();
                $("#cboResourceSite").prop("disabled", true);
                $("#siteTrans1").prop("disabled", true);
                StopAjaxLoader("#MainResourceSiteDetails");
            }



            $("#cboResourceProjects").change(function () {
                $("#cboResourceSite").val('');
                ProjectID = $(this).find(':selected').val();
                ProjectName = $('#cboResourceProjects option:selected').text();
                if (ProjectID == 0) {
                    StartLoader("#MainResourceSiteDetails");
                    $("#NoProjectDivID").show();
                    GetResourceSiteList();
                    $("#cboResourceSite").prop("disabled", true);
                    $("#siteTrans1").prop("disabled", true);

                    StopAjaxLoader("#MainResourceSiteDetails");
                }
                else {
                     var param = JSON.stringify(encodeURI(ProjectID));
                     var IsOver = AJAXCallWithResult("/api/PM_ResourceSiteDetails/ProjectIsOver", param, false);

                    if (IsOver == 1) {
                        $("#siteTrans1").addClass("disabledbutton");
                        $("#siteTrans2").addClass("disabledbutton");
                        $("#AllresourceSiteDetails").addClass("disabledbutton");
                        $("#cboResourceSite").prop("disabled", true);
                        $("#siteTrans1").prop("disabled", true);
                    }
                    else {
                        $("#AllresourceSiteDetails").removeClass("disabledbutton");
                        $("#cboResourceSite").prop("disabled", false);
                        $("#siteTrans1").removeClass("disabledbutton");
                        $("#siteTrans2").removeClass("disabledbutton");
                        $("#siteTrans1").prop("disabled", false);
                        $("#cboResourceSite").val('');


                        $("#ResourceSiteTblBody>tr").css("pointer-events", "auto");
                        $("#ResourceSiteTblBody>tr").css("cursor", "pointer");
                        $("#siteTrans1").css("pointer-events", "auto");
                    }

                     generatetoken();
                    FillSiteCombo();
                    GetResourceSiteList();
                    GetEmpRole();
                    GetEmpSite();
                }


            });


            $("#cboResourceSite").change(function () {
                GetResourceSiteList();
                $("#ResourceSiteTblBody>tr").css("pointer-events", "auto");
                $("#siteTrans1").css("pointer-events", "auto");
            });


            //script added for disable checkbox on click - added by pradip
            //    $('.inp-select input[class="chckHead"]').click(function () {
            //        
            //        var $this = $(this);
            //        if ($this.is(".chckHead")) {
            //            if ($this.is(":checked")) {
            //                $(".chckHead").not($this).prop({ disabled: true, checked: false });
            //                $()

            //            } else {
            //                $(".chckHead").prop("disabled", false);
            //            }
            //        }
            //    });
        });

        //Project Drop Down Binding
        function FillProjectCombox() {
            var sessionproj = 0;
            sessionproj = SessionProjectID;
            if (SessionProjectID == "") {
                sessionproj = 0;
            }

            var ResourceSiteDetailParameter = {
                UserID: encodeURI(UserID),
                ProjectID: encodeURI(sessionproj),
                LoginType: encodeURI(LoginType)
            }
            var param = JSON.stringify(ResourceSiteDetailParameter);
            var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/GetProjectID", param, false);

            var objCbo1 = document.getElementById("cboResourceProjects");
            $("#cboResourceProjects option").remove();

            if (strResult.length != 0) {
                for (var i = 0; i < strResult.length; i++) {

                    var ObjAccessProj = strResult[i];

                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);

                    if (SessionProjectID == ObjAccessProj.ProjectID) {
                        objOption.text = ObjAccessProj.ProjectName;
                        objOption.value = ObjAccessProj.ProjectID;
                    }
                    else {
                        objOption.text = ObjAccessProj.ProjectName;
                        objOption.value = ObjAccessProj.ProjectID;
                    }
                    if (ObjAccessProj.ProjectID == "0") {
                        objOption.text = "Select Project";
                    }
                }
            }

            if (SessionProjectID != null && SessionProjectID != undefined && SessionProjectID != "") {
                jQuery("select#cboResourceProjects option[value=" + SessionProjectID + " ]").attr("selected", "selected");
                ProjectID = SessionProjectID;

            }
        }


        // For Filled Site Combo Box
        function FillSiteCombo() {
            $("#SelectResourceSite > div > div > div > div > select#cboResourceSite").empty();

            ResourceSiteDetailParameter = {
                ProjectID: encodeURI(ProjectID)
            }
            var param = JSON.stringify(ResourceSiteDetailParameter);
            var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/FillSiteCombo", param, false);

            var objCbo = document.getElementById("cboResourceSite");

            $("#cboResourceSite option").remove();

            var objOption = document.createElement("OPTION");

            for (var i = 0; i < strResult.length; i++) {
                var Objresult = strResult[i];
                var objOption = document.createElement("OPTION");

                objCbo.options.add(objOption);

                objOption.text = Objresult.Name;
                objOption.value = Objresult.ID == 0 ? '' : Objresult.ID;

            }
        }


        //Plotting Site Grid View
        function GetResourceSiteList() {
            ArrEmployeeSiteChk = [];
            ArrBillingRateChk = [];
            arrDocCatIds = [];
            ArrEmployeeName = [];
            $("#ResourceSiteTblBody").empty();
            SiteName = $("#cboResourceSite").find(':selected').val();
            //Comment And Added By Riddhesh Patil on 21st March
            //if (SiteName == '' || SiteName == undefined) {
            if (SiteName == '' || SiteName == undefined || SiteName == null) {
                //End ofComment And Added By Riddhesh Patil on 21st March
                SiteName = "";
            }
            ResourceSiteDetailParameter = {
                ProjectID: encodeURI(ProjectID),
                SiteName: encodeURI(SiteName)
            }
            var param = JSON.stringify(ResourceSiteDetailParameter);
            var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/GetResourceSiteList", param, false);
            if (strResult.length == 0) {

                strHTML += '<tr>'
                strHTML += '<td colspan="5" class="text-center">There are no items to show in this view.</td>'
                strHTML += '</tr>'
                $("#ResourceSiteTblBody").append(strHTML);

            }
            else {
                var strHTML = "";
                for (var i = 0; i < strResult.length; i++) {
                    var EmployeeID = strResult[i]["EmployeeID"];
                    var EmployeeName = strResult[i]["EmployeeName"];
                    var RoleDescription = strResult[i]["RoleDescription"];
                    var SiteID = strResult[i]["SiteID"];
                    var SiteName = strResult[i]["SiteName"];
                    var StartDate = strResult[i]["StartDate"];
                    var BillingPercentage = strResult[i]["BillingPercentage"];

                    var inputEmployeeName = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtEmpName" + "EmployeeNameIndex", "txtEmpName" + "EmployeeNameIndex", "form-control", ,,,, , ,, returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    inputEmployeeName = inputEmployeeName.replace(/EmployeeNameIndex/g, EmployeeID);

                    var inputTransferDate = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtTransferDate" + "TransferDateIndex", "txtTransferDate" + "TransferDateIndex", "form-control", ,,,, , ,, returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    inputTransferDate = inputTransferDate.replace(/TransferDateIndex/g, EmployeeID);

                    var inputRole = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtRole" + "RoleIndex", "txtRole" + "RoleIndex", "form-control", ,,,, , ,, returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    inputRole = inputRole.replace(/RoleIndex/g, EmployeeID);

                    var InputSite = '<%=CommonFunctions.HTMLControls.DrawComboBox("CboSite" + "SiteIndex", "select ''", , , "class=""form-select """, True, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    InputSite = InputSite.replace(/SiteIndex/g, EmployeeID);

                    $("#txtHiddenBillingPercentage").val(BillingPercentage);

                    strHTML += '<tr>'
                 <% If m_blnRSDEditAccess = True Then %>
                    strHTML += '<td><a href="javascript:;" class="empname" data-bs-toggle="collapse" data-bs-target="#accordionEmp' + i + '" id="Emp' + EmployeeID + '" onclick="EditSiteDetail(' + '&quot;' + escape(EmployeeName) + '&quot;,' + EmployeeID + ',' + SiteID + ')">' + EmployeeName + '</a></td>'
                <% Else %>
                    strHTML += '<td>' + EmployeeName + '</td>'
                <% End If %>
                    strHTML += '<td>' + RoleDescription + '</td>'
                    strHTML += '<td>' + SiteName + '</td>'
                    strHTML += '<td>' + StartDate + '</td>'
                    strHTML += '<td class="inp-select">'
                    strHTML += '<div class="custom_chckbox">'
                    strHTML += '<input type="checkbox" id="' + EmployeeID + '" class="chckHead" onclick="chkbxclickevent(' + EmployeeID + ',&quot;' + escape(EmployeeName) + '&quot;' + ')">'
                    strHTML += '<label for="' + EmployeeID + '"></label>'
                    strHTML += '</div>'
                    strHTML += '</td>'
                    strHTML += '</tr>'
                    strHTML += '<tr>'
                    strHTML += ' <td colspan="5" class="hiddenRow subCustomField text-start">'
                    strHTML += '<div class="accordian-body collapse" id="accordionEmp' + i + '" aria-expanded="true" style="">'
                    strHTML += '<div class="pt-1 pb-1 bgwhite pad-10">'
                    strHTML += ' <div class="right-side-save">'
                 <% If m_blnRSDEditAccess = True %>
                    strHTML += '<a href="javascript:;" id="siteTrans2" class="btn borderbtn mr-5" onclick="ResourceSiteTrasfer(false)">Site Transfer</a>'
                <% End If %>
                    strHTML += ' <a onclick="closeaccordian(' + i + ')" href="javascript:;" data-bs-toggle="collapse" class="btn borderbtn closeAcco">Close</a>'
                    strHTML += ' </div>'
                    strHTML += ' <div class="mar-10 panel-border">'
                    strHTML += '  <div class="page-main-head">'
                    strHTML += ' <h4>Employee Current Site Details</h4>'
                    strHTML += ' </div>'
                    strHTML += ' <div class="row form-group pad-10">'
                    strHTML += ' <div class="col-sm-3">'
                    strHTML += ' <label class="required">Employee Name</label>'
                    strHTML += inputEmployeeName
                    strHTML += '</div>'
                    strHTML += '  <div class="col-sm-3">'
                    strHTML += '<label>Site</label>'
                    strHTML += ' <div class="custom-dropdown" >'
                    strHTML += InputSite
                    strHTML += ' </div>'
                    strHTML += '  </div>'
                    strHTML += ' <div class="col-sm-3">'
                    strHTML += '<label class="required">Transfer Date</label>'
                    strHTML += '<div class="input-group datefielddiv">'
                    strHTML += inputTransferDate
                    strHTML += ' <span class="input-group-btn">'
                    strHTML += '<button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>'
                    strHTML += ' </span>'
                    strHTML += '</div>'
                    strHTML += '</div>'
                    strHTML += '<div class="col-sm-3">'
                    strHTML += ' <label>Role</label>'
                    strHTML += inputRole
                    strHTML += ' </div>'
                    strHTML += '</div>'
                    strHTML += '<div class="page-main-head">'
                    strHTML += ' <h4>Employee Billing Rate History</h4>'
                    strHTML += ' </div>'
                <% If m_blnRSDDeleteAccess = True Then %>
                    strHTML += '<div class="right-side-save">'
                    strHTML += ' <a href="javascript:;" class="btn borderbtn" onclick=Deleteconfirmationmodal(true);>Delete</a>'
                    strHTML += ' </div>'
                <% End If %>
                    strHTML += ' <div class="mar-10">'
                    strHTML += '<table class="table table-bordered emp-bill-tbl" id="EmpBillingRatetbl' + EmployeeID + '" style="width:100%">'
                    strHTML += '<thead>'
                    strHTML += ' <tr>'
                    strHTML += '<th>Site</th>'
                    strHTML += '<th>Role</th>'
                    strHTML += '<th>Effective From Date</th>'
                    strHTML += ' <th>To Date</th>'
                    strHTML += ' <th>Normal Rate</th>'
                    strHTML += '<th>Extra Rate</th>'
                    strHTML += ' <th>Holiday Rate</th>'
                    strHTML += '<th class="nosort">'
                    strHTML += ' </th>'
                    strHTML += '</tr>'
                    strHTML += '</thead>'
                    strHTML += '<tbody id="EmpBillingRatetblBody' + EmployeeID + '">'
                    strHTML += ' </tbody>'
                    strHTML += '</table>'
                    strHTML += ' </div>'
                    strHTML += ' <div class="page-main-head">'
                    strHTML += ' <h4>Employee Site History</h4>'
                    strHTML += ' </div>'
                 <% If m_blnRSDDeleteAccess = True %>
                    strHTML += ' <div class="right-side-save">'
                    strHTML += ' <a href="javascript:;" class="btn borderbtn" onclick=Deleteconfirmationmodal(false);>Delete</a>'
                    strHTML += ' </div>'
                 <% End If %>
                    strHTML += ' <div class="mar-10">'
                    strHTML += ' <table class="table table-bordered emp-bill-tbl" id="EmpSiteHistoryTbl' + EmployeeID + '" style="width:100%">'
                    strHTML += ' <thead>'
                    strHTML += ' <tr>'
                    strHTML += ' <th>Name</th>'
                    strHTML += ' <th>Role</th>'
                    strHTML += ' <th>Transfer Date</th>'
                    strHTML += '<th class="nosort"> </th>'
                    strHTML += '</tr>'
                    strHTML += '</thead>'
                    strHTML += '<tbody id="EmpSiteHistoryTblBody' + EmployeeID + '">'
                    strHTML += '</tbody>'
                    strHTML += '</table>'
                    strHTML += ' <div class="clearfix"></div>'
                    strHTML += ' </div>'
                    strHTML += '</div>'
                    strHTML += '</div>'
                    strHTML += '</div>'
                    strHTML += '</td>'
                    strHTML += '</tr>'

                }
                $("#ResourceSiteTblBody").html("");
                $("#ResourceSiteTblBody").html(strHTML);
            }
        }

        // Edit Employee Current Site Details
        function EditSiteDetail(EmployeeName, EmployeeID, SiteID) {
            
            //debugger;
            ArrEmployeeSiteChk = [];
            ArrBillingRateChk = [];

            GlobalEmployeeID = EmployeeID;
            GlobalSiteID = SiteID
            GlobalEmployeeName = unescape(EmployeeName);
            //Comment And Added By Riddhesh Patil on 21st March
            //var SiteName = "null";
            var SiteName = "";
            //End of Comment And Added By Riddhesh Patil on 21st March
            $("#txtHiddenEmployeeID").val(EmployeeID);
            //StartLoader("#MainResourceSiteDetails");
            ResourceSiteDetailParameter = {
                ProjectID: encodeURI(ProjectID),
                SiteName: encodeURI(SiteName),
                EmployeeID: encodeURI(EmployeeID)
            }
            var param = JSON.stringify(ResourceSiteDetailParameter);
            var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/GetResourceSiteList", param, false);
            for (var i = 0; i < strResult.length; i++) {
               
                var EmployeeName = strResult[i]["EmployeeName"];
                var site = strResult[i]["Name"];
                var StartDate = strResult[i]["StartDate"];
                var Role = strResult[i]["RoleID"];
                var RoleDescription = strResult[i]["RoleDescription"];
                var SiteID = strResult[i]["SiteID"];

                EditGetEmpSite(EmployeeID);
                $("#txtEmpName" + EmployeeID).val(EmployeeName);
                $("#CboSite" + EmployeeID).val(SiteID);
                $("#txtTransferDate" + EmployeeID).val(StartDate);
                $("#txtRole" + EmployeeID).val(RoleDescription);
                $("#txtEmpName" + EmployeeID).prop("disabled", true);
                $("#CboSite" + EmployeeID).prop("disabled", true);
                $("#txtTransferDate" + EmployeeID).prop("disabled", true);
                $("#txtRole" + EmployeeID).prop("disabled", true);

            }
            $("#txtHiddenEmployeeID").val(EmployeeID);
            BillingRateHistoryList(EmployeeID);
            SiteHistoryList(EmployeeID);
            $("tr").on('shown.bs.collapse', function () {

                var panel = $(this).find('.in');

                $('html, body').animate({
                    scrollTop: panel.offset().top
                }, 500);

            });


            StopAjaxLoader("#MainResourceSiteDetails");


            $(".accordian-body").each(function () {
                if ($(this).css("visibility") == "visible") {
                    // handle non visible state
                    $("#ResourceSiteTblBody>tr").css("pointer-events", "none");
                    $("#siteTrans1").css("pointer-events", "none");
                    $("#ResourceSiteTblBody>tr .accordian-body tr").css("pointer-events", "auto");
                    $("#ResourceSiteTblBody>tr .accordian-body").css("pointer-events", "auto");
                    $("#ResourceSiteTblBody>tr .accordian-body .btn").css("pointer-events", "auto");
                    $("#Divtop").css("pointer-events", "none");
                    $("#Divtop").css("cursor", "not-allowed");//Commented and Added by Chetan M on 20th Jully 2020 for IssueID 25620
                    //$("body:not(.hiddenRow)").css("cursor", "not-allowed");
                    var BrowserName = isIE();
                    if (BrowserName != "IE") {
                    $("body:not(.hiddenRow)").css("cursor", "not-allowed");
                    }
                    //End of Commented and Added by Chetan M on 20th Jully 2020 for IssueID 25620

                   
                    
                    
                } else {
                    // handle visible state
                    $("#ResourceSiteTblBody>tr").css("pointer-events", "auto");
                    $("#ResourceSiteTblBody>tr .accordian-body tr").css("pointer-events", "auto");
                    $("#siteTrans1.btn").css("pointer-events", "auto");
                    $("#Divtop").css("pointer-events", "auto");
                    $("#Divtop").css("cursor", "pointer");

                    $("body:not(.hiddenRow)").css("cursor", "auto");
                    $("body:not(.accordian-body)").css("cursor", "auto");
                    
                }
            });

            
        }

        //Edit Employee Billing Rate History
        function EditBillingRateHistoryList(EmployeeID, EmployeeBillingInfoID) {
            GlobalEmployeeBillingInfoID = EmployeeBillingInfoID;
            GlobalEmployeeID = EmployeeID;
            GetProRole(EmployeeBillingInfoID);

            ResourceSiteDetailParameter = {
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(EmployeeID),
                EmployeeBillingInfoID: encodeURI(EmployeeBillingInfoID)
            }
            var param = JSON.stringify(ResourceSiteDetailParameter);
            var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/GetEmployeeBillingRateHistory", param, false);
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                var Site = strResult[i]["Name"];
                var RoleDescription = strResult[i]["RoleDescription"];
                var StartDate = strResult[i]["StartDate"];
                var EndDate = strResult[i]["EndDate"];
                var NormalRate = strResult[i]["NormalRate"];
                var ExtraRate = strResult[i]["ExtraRate"];
                var HolidayRate = strResult[i]["HolidayRate"];
                var BitData = strResult[i]["BitData"];
                var SiteID = strResult[i]["SiteID"]

               // NormalRate = NormalRate.toFixed(2);
                   if (NormalRate == '0.00' || NormalRate == null) {
                    //NormalRate = '00.00';
                    NormalRate = '0';
                }
                else {
                     //NormalRate = NormalRate.toFixed(2);
                     NormalRate = NormalRate;
                }

                if (ExtraRate == '' || ExtraRate == null) {
                    //ExtraRate = '00.00';
                    ExtraRate = '0';
                }
                else if (ExtraRate != '' || ExtraRate != null) {
                    //ExtraRate = ExtraRate.toFixed(2);
                    ExtraRate = ExtraRate;
                } else {
                    ExtraRate = ExtraRate;
                }
                if (HolidayRate == '' || HolidayRate == null) {
                    //HolidayRate = '00.00';
                    HolidayRate = '0';
                }
                else if (HolidayRate != '' || HolidayRate != null) {
                    //HolidayRate = HolidayRate.toFixed(2);
                    HolidayRate = HolidayRate;
                } else {
                    HolidayRate = HolidayRate;
                }
                if (EndDate == '' || EndDate == null) {
                    //BY DIPALI V ON 18TH DEC 2019
                    EndDate = '-';
                }

                if (StartDate == '' || StartDate == null) {
                     //BY DIPALI V ON 18TH DEC 2019
                    StartDate = '-';
                }

                $("#CboProSite").val(SiteID);
                $("#TxtProEffDate").val(StartDate);
                $("#txtProNormalRate").val(NormalRate);
                $("#txtProExtraRate").val(ExtraRate);
                $("#txtProHolidayRate").val(HolidayRate);
                $("#TxtProToDate").val(EndDate);

                $("#CboProSite").prop("disabled", true);
                $("#TxtProEffDate").prop("disabled", true);
                $("#TxtProToDate").prop("disabled", true);
                $("#cboProRole").prop("disabled", true);

            }
        }

        //Validate BillingRateHistory
        function ValidateBillingRateHistory() {
            $("#saveEffDateModal").removeAttr("data-bs-dismiss", "modal");
            var NormalRate = $("#txtProNormalRate").val();
            var ExtraRate = $("#txtProExtraRate").val();
            var HolidayRate = $("#txtProHolidayRate").val();
            var ObjNormalRate = document.getElementById("txtProNormalRate");
            var ObjExtraRate = document.getElementById("txtProExtraRate");
            var ObjHolidayRate = document.getElementById("txtProHolidayRate");
            var IsdigitNormalRate = isNumeric(ObjNormalRate.value);
            var IsdigitExtraRate = isNumeric(ObjExtraRate.value);
            var IsdigitHolidayRate = isNumeric(ObjHolidayRate.value);

            if (isBlank(NormalRate)) {
                alertify.error("<%= MyBase.GetResourceString("A_NormalRate") %>")
                $("#txtProNormalRate").focus();
                return false;
            }

            else if (isNumeric(ObjNormalRate)) {
                alertify.error("<%= MyBase.GetResourceString("A_PositiNormalRate") %>");
                $('#txtProNormalRate').focus();
                return false;

            }
            else if (IsdigitNormalRate == false) {
                alertify.error("<%= MyBase.GetResourceString("A_PositiNormalRate") %>");
                $('#txtProNormalRate').focus();
                return false;

            }
            else if (disallowNegativeNumeric(ObjNormalRate)) {
                alertify.error("Please enter only positive numeric value for 'Normal Rate'");
                $('#txtProNormalRate').focus();
                return false;
            }
            if (ExtraRate != '') {

                if (isNumeric(ObjExtraRate)) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveExtraRate") %>");
                    $('#txtProExtraRate').focus();
                    return false;
                }
                else if (IsdigitExtraRate == false) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveExtraRate") %>");
                    $('#txtProExtraRate').focus();
                    return false;
                }
                else if (disallowNegativeNumeric(ObjExtraRate)) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveExtraRate") %>");
                    $('#txtProExtraRate').focus();
                    return false;
                }
            }
            if (HolidayRate != '') {

                if (isNumeric(ObjHolidayRate)) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveHolidayRate") %>");
                    $('#txtProHolidayRate').focus();
                    return false;
                }
                else if (IsdigitHolidayRate == false) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveHolidayRate") %>");
                    $('#txtProHolidayRate').focus();
                    return false;
                }
                else if (disallowNegativeNumeric(ObjHolidayRate)) {
                    alertify.error("<%= MyBase.GetResourceString("A_PositiveHolidayRate") %>");
                    $('#txtProHolidayRate').focus();
                    return false;
                }
            }

            return true;


        }


        //Binding Billing Rate History Table List
        function BillingRateHistoryList(EmployeeID) {
            ArrEmployeeSiteChk = [];
            ArrBillingRateChk = [];
            $("#EmpBillingRatetblBody" + EmployeeID).empty();
            $("#EmpBillingRatetbl" + EmployeeID).dataTable().fnDestroy();
            ResourceSiteDetailParameter = {
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(EmployeeID)
            }
            var param = JSON.stringify(ResourceSiteDetailParameter);
            var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/GetEmployeeBillingRateHistory", param, false);
            var strHTML = "";

            //if (strResult.length == 0) {

            //    strHTML += '<tr>'
            //    strHTML += '<td colspan="8" class="text-center">No data available in table</td>'
            //    strHTML += '</tr>'
            //    $("#EmpBillingRatetblBody" + EmployeeID).append(strHTML);               
            //}
            //else {
            for (var i = 0; i < strResult.length; i++) {
                var Site = strResult[i]["Name"];
                var RoleDescription = strResult[i]["RoleDescription"];
                var StartDate = strResult[i]["StartDate"];
                var EndDate = strResult[i]["EndDate"];
                var NormalRate = strResult[i]["NormalRate"];
                var ExtraRate = strResult[i]["ExtraRate"];
                var HolidayRate = strResult[i]["HolidayRate"];
                var BitData = strResult[i]["BitData"];
                var EmployeeBillingInfoID = strResult[i]["EmployeeBillingInfoID"];
                var FirstRecord = strResult[i]["FirstRecord"];
                // NormalRate = NormalRate.toFixed(2);

                if (NormalRate == '0.00' || NormalRate == null) {
                    NormalRate = '00.00';
                }
                else {
                     NormalRate = NormalRate.toFixed(2);
                }

                if (ExtraRate == '' || ExtraRate == null) {
                    ExtraRate = '00.00';
                }
                else if (ExtraRate != '' || ExtraRate != null) {
                    ExtraRate = ExtraRate.toFixed(2);
                } else {
                    ExtraRate = ExtraRate;
                }
                if (HolidayRate == '' || HolidayRate == null) {
                    HolidayRate =  '00.00';
                }
                else if (HolidayRate != '' || HolidayRate != null) {
                    HolidayRate = HolidayRate.toFixed(2);
                } else {
                    HolidayRate = HolidayRate;
                }
                if (EndDate == '' || EndDate == null) {
                    EndDate = '';
                }

                strHTML += '<tr>'
                strHTML += '<td>' + Site + '</td>'
                strHTML += '<td>' + RoleDescription + '</td>'
                <% If m_blnRSDEditAccess = True %>
                strHTML += '<td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#effDateModal" onclick="EditBillingRateHistoryList(' + EmployeeID + ',' + EmployeeBillingInfoID + ')">' + StartDate + '</a></td>'
                <% Else %>
                strHTML += '<td>' + StartDate + '</td>'
                <% End If %>
                strHTML += '<td>' + EndDate + '</td>'
                strHTML += '<td>' + NormalRate + '</td>'
                strHTML += '<td>' + ExtraRate + '</td>'
                strHTML += '<td>' + HolidayRate + '</td>'

                if (BitData == 1) {
                    strHTML += '<td class="inp-select">'
                    strHTML += '<div class="custom_chckbox">'
                    strHTML += '<input type="checkbox" id="' + EmployeeBillingInfoID + '" class="chckHead bill-history-chck" disabled>'
                    strHTML += '<label for="' + EmployeeBillingInfoID + '"></label>'
                    strHTML += '</div>'
                    strHTML += '</td>'

                }
                else if (FirstRecord == EmployeeBillingInfoID) {

                    strHTML += '<td class="inp-select">'
                    strHTML += '<div class="custom_chckbox">'
                    strHTML += '<input type="checkbox" id="' + EmployeeBillingInfoID + '" class="chckHead bill-history-chck" disabled>'
                    strHTML += '<label for="' + EmployeeBillingInfoID + '"></label>'
                    strHTML += '</div>'
                    strHTML += '</td>'
                }
                else {
                    strHTML += '<td class="inp-select">'
                    strHTML += '<div class="custom_chckbox">'
                    strHTML += '<input type="checkbox" id="' + EmployeeBillingInfoID + '" class="chckHead bill-history-chck" onclick="BillingRatechkbxclickevent(this.id)">'
                    strHTML += '<label for="' + EmployeeBillingInfoID + '"></label>'
                    strHTML += '</div>'
                    strHTML += '</td>'
                }

                strHTML += '</tr>'

            }
            $("#EmpBillingRatetblBody" + EmployeeID).html("")
            $("#EmpBillingRatetblBody" + EmployeeID).html(strHTML);
            Pagination("#EmpBillingRatetbl" + EmployeeID);

            if (strHTML == "") {
                $("#EmpBillingRatetbl" + EmployeeID + " tbody tr td").prop("colspan", 8).css("text-align", "center");

            }

        }


        //}

        //To set the pagination for the table
        function Pagination(PageID) {

            $(PageID).dataTable().fnDestroy();
            var stdTable1 = $(PageID).DataTable({
                "pageLength": 5,
                //"scrollY": "52vh",
                //"scrollX": true,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "searching": false,
                "retrieve": true,
                "scrollCollapse": false,
                "dom": "<'row'<'col-sm-12 dtscroll'tr>>" + "<'row'<'col-sm-4'i><'col-sm-1'f><'col-sm-7 searchStyle'p>>",
                "drawCallback": function (settings) {
                    $(".dataTables_scrollHeadInner").css({ "width": "100%" });
                    $(".table ").css({ "width": "100%" });
                },

            });

            //$($.fn.dataTable.tables(true)).css('width', '100%'); $($.fn.dataTable.tables(true)).DataTable().columns.adjust().draw();

            $('.accordian-body').on('shown.bs.collapse', function () {
                $($.fn.dataTable.tables(true)).DataTable()
                    .columns.adjust();
            });
            $('.accordian-body').on('hidden.bs.collapse', function () {
                $($.fn.dataTable.tables(true)).DataTable()
                    .columns.adjust();
            });

            $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
                $($.fn.dataTable.tables(true)).DataTable()
                    .columns.adjust();
            });


        }
        // Saving BillingRateHistory

        function UpdateBillingRateHistory() {

            if (ValidateBillingRateHistory() == true) {

                var NormalRate = $("#txtProNormalRate").val();
                var ExtraRate = $("#txtProExtraRate").val();
                var HolidayRate = $("#txtProHolidayRate").val();
                if (HolidayRate == '' || HolidayRate == null || HolidayRate == undefined) {
                    HolidayRate = '0.0'
                }
                if (ExtraRate == '' || ExtraRate == null || ExtraRate == undefined) {
                    ExtraRate = '0.0'
                }
                if (NormalRate == '' || NormalRate == null || NormalRate == undefined) {
                    NormalRate = '0.0'
                }

                var EmployeeID = $("#txtHiddenEmployeeID").val();
                var FromDate = $("#TxtProEffDate").val();
                var SiteID = $("#CboProSite").val();
                var RoleID = $("#cboProRole").val();
                ResourceSiteDetailParameter = {
                    ProjectID: encodeURI(ProjectID),
                    EmployeeBillingInfoID: encodeURI(GlobalEmployeeBillingInfoID),
                    NormalRate: encodeURI(NormalRate),
                    ExtraRate: encodeURI(ExtraRate),
                    HolidayRate: encodeURI(HolidayRate),
                    EmployeeID: encodeURI(GlobalEmployeeID),
                    StartDate: encodeURI(FromDate),
                    RoleID: encodeURI(RoleID),
                    EmployeeSiteID: encodeURI(SiteID),
                    UserID : encodeURI(UserID)

                }
                var param = JSON.stringify(ResourceSiteDetailParameter);
                var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/UpdateBillingRateHistory", param, false);

                $("#saveEffDateModal").attr("data-bs-dismiss", "modal");
                alertify.success(strResult);
                EditSiteDetail(GlobalEmployeeName, EmployeeID, GlobalSiteID);

            }
        }

        //Binding Billing Rate History Table List
        function SiteHistoryList(EmployeeID) {
            ArrEmployeeSiteChk = [];
            ArrBillingRateChk = [];
            $('input:checkbox').removeAttr('checked');
            $("#EmpSiteHistoryTblBody" + EmployeeID).empty();
            $("#EmpSiteHistoryTbl" + EmployeeID).dataTable().fnDestroy();
            ResourceSiteDetailParameter = {
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(EmployeeID)
            }
            var param = JSON.stringify(ResourceSiteDetailParameter);
            var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/GetEmployeeSiteHistory", param, false);
            var strHTML = "";
            //if (strResult.length == 0) {
            //    strHTML += '<tr>'
            //    strHTML += '<td colspan="4" class="text-center">No data available in table</td>'
            //    strHTML += '</tr>'
            //    $("#EmpSiteHistoryTblBody" + EmployeeID).append(strHTML);
            //}
            //else {
            for (var i = 0; i < strResult.length; i++) {
                var Site = strResult[i]["Name"];
                var RoleDescription = strResult[i]["RoleDescription"];
                var StartDate = strResult[i]["StartDate"];
                var IsDeleteDisabled = strResult[i]["IsDeleteDisabled"];
                var EmployeeSiteID = strResult[i]["EmployeeSiteID"];
                var EmployeeID = strResult[i]["EmployeeID"];
                var FirstSiteID = strResult[i]["FirstSiteID"];
                var ResultStartDate = strResult[i]["ResultStartDate"];

                strHTML += '<tr>'
                 <% If m_blnRSDEditAccess = True Then %>
                strHTML += ' <td><a href="javascript:" data-bs-toggle="modal" data-bs-target="#siteTransfer" onclick="EditSiteHistory(' + EmployeeID + ',' + EmployeeSiteID + ',&quot;' + escape(StartDate) + '&quot;' + ')">' + Site + '</td>'
                <% Else %>
                strHTML += '<td>' + Site + '</td>'
                <% END IF %>
                strHTML += '<td>' + RoleDescription + '</td>'
                strHTML += '<td>' + StartDate + '</td>'

                if (IsDeleteDisabled == 1 || FirstSiteID == EmployeeSiteID || ResultStartDate == 1) {
                    strHTML += '<td class="inp-select">'
                    strHTML += '<div class="custom_chckbox">'
                    strHTML += '<input type="checkbox" id="' + EmployeeSiteID + '" class="chckHead emp-history-chck" disabled>'
                    strHTML += '<label for="' + EmployeeSiteID + '"></label>'
                    strHTML += '</div>'
                    strHTML += '</td>'
                }

                else {
                    strHTML += '<td class="inp-select">'
                    strHTML += '<div class="custom_chckbox">'
                    strHTML += '<input type="checkbox" id="' + EmployeeSiteID + '" class="chckHead emp-history-chck" onclick=EmployeeSitechkbxclickevent(this.id)>'
                    strHTML += '<label for="' + EmployeeSiteID + '"></label>'
                    strHTML += '</div>'
                    strHTML += '</td>'
                }

                strHTML += '</tr>'

            }


            $("#EmpSiteHistoryTblBody" + EmployeeID).html("")
            $("#EmpSiteHistoryTblBody" + EmployeeID).html(strHTML);
            Pagination("#EmpSiteHistoryTbl" + EmployeeID);

            if (strHTML == "") {
                $("#EmpBillingRatetbl" + EmployeeID + " tbody tr td").prop("colspan", 4).css("text-align", "center");

            }
        }

        //}

        //Edit Employee Site History
        function EditSiteHistory(EmployeeID, EmployeeSiteID, StartDate) {
            var StartDate = unescape(StartDate);
            $("#txtHiddenTransferDate").val(StartDate);
            $("#LabelSite").text('Name');
            $("#LabelDate").text('Transfer Date');
            $("#txtHiddenEmployeeID").val('');
            ResourceSiteDetailParameter = {
                ProjectID: encodeURI(ProjectID),
                EmployeeID: encodeURI(EmployeeID),
                EmployeeSiteID: encodeURI(EmployeeSiteID)
            }
            var param = JSON.stringify(ResourceSiteDetailParameter);
            var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/GetEmployeeSiteHistory", param, false);
            for (var i = 0; i < strResult.length; i++) {
                var Site = strResult[i]["Name"];
                var RoleID = strResult[i]["RoleID"];
                var StartDate = strResult[i]["StartDate"];
                var EmployeeSiteID = strResult[i]["EmployeeSiteID"];
                var EmployeeID = strResult[i]["EmployeeID"];
                var SiteID = strResult[i]["SiteID"];

                $("#cboSiteEmpSite").val(SiteID);
                $("#cboSiteEmpRole").val(RoleID);
                $("#txtSiteEffDate").val(StartDate);
                $("#SpanEmployeeSiteID").val(EmployeeSiteID);
                $("#txtHiddenEmployeeID").val(EmployeeID);
                $("#cboSiteEmpSite").prop("disabled", true);

                var SetRoleID = $("#cboSiteEmpRole").val();
                if (SetRoleID == '' || SetRoleID == null) {
                    $("#cboSiteEmpRole").val('');
                }
            }


            $("#H5ResourceSite").text("Employee Site History");
            $("#h5siteTransfer").text("Employee Site History");


        }

        // For Filled Site Combo Box
        function GetEmpRole() {

            ResourceSiteDetailParameter = {
                ProjectID: encodeURI(ProjectID)
            }
            var param = JSON.stringify(ResourceSiteDetailParameter);
            var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/GetEmpRole", param, false);

            var objCbo1 = document.getElementById("cboSiteEmpRole");
            var objCbo = document.getElementById("cboProRole");

            $("#cboSiteEmpRole option").remove();
            $("#cboProRole option").remove();

            for (var i = 0; i < strResult.length; i++) {
                var Objresult = strResult[i];
                var objOption = document.createElement("OPTION");
                var objOption1 = document.createElement("OPTION");
                objCbo1.options.add(objOption1);
                objCbo.options.add(objOption);

                objOption.text = Objresult.RoleDescription;
                objOption.value = Objresult.RoleID == 0 ? '' : Objresult.RoleID;

                objOption1.text = Objresult.RoleDescription;
                objOption1.value = Objresult.RoleID == 0 ? '' : Objresult.RoleID;


            }
        }

        //Fill Employee Site Dropdown
        function GetEmpSite() {
            ResourceSiteDetailParameter = {
                ProjectID: encodeURI(ProjectID)
            }
            var param = JSON.stringify(ResourceSiteDetailParameter);
            var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/GetEmpSite", param, false);

            var objCbo = document.getElementById("CboProSite");
            var objCbo1 = document.getElementById("cboSiteEmpSite");

            $("#CboProSite option").remove();
            $("#cboSiteEmpSite option").remove();

            var objOption = document.createElement("OPTION");
            var objOption1 = document.createElement("OPTION");

            for (var i = 0; i < strResult.length; i++) {
                var Objresult = strResult[i];
                var objOption = document.createElement("OPTION");
                var objOption1 = document.createElement("OPTION");

                objCbo.options.add(objOption);
                objCbo1.options.add(objOption1);

                objOption.text = Objresult.Name;
                objOption.value = Objresult.ProjectSiteID == 0 ? '' : Objresult.ProjectSiteID;

                objOption1.text = Objresult.Name;
                objOption1.value = Objresult.ProjectSiteID == 0 ? '' : Objresult.ProjectSiteID;


            }
        }

        // Fill Role Dropdown List
        function GetProRole(EmployeeBillingInfoID) {

            ResourceSiteDetailParameter = {
                ProjectID: encodeURI(ProjectID),
                EmployeeBillingInfoID: encodeURI(EmployeeBillingInfoID)
            }
            var param = JSON.stringify(ResourceSiteDetailParameter);
            var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/GetProRole", param, false);

            var objCbo = document.getElementById("cboProRole");

            $("#cboProRole option").remove();


            var objOption = document.createElement("OPTION");

            for (var i = 0; i < strResult.length; i++) {
                var Objresult = strResult[i];
                var objOption = document.createElement("OPTION");

                objCbo.options.add(objOption);

                objOption.text = Objresult.RoleDescription;
                objOption.value = Objresult.RoleID;

            }

        }
        //Save Site Transfer
        function SaveResourceonclick() {
            var Flag = $("#CheckWhichModal").val();
            var SiteTransfer = $("#h5siteTransfer").text();;
            if (SiteTransfer != 'Employee Site History') {
                if (ValidateSiteTransfer() == 0) {

                    var BillingPercentage = $("#txtHiddenBillingPercentage").val();
                    var intTransferSiteID = $("#cboSiteEmpSite").val();
                    var Role = $("#cboSiteEmpRole").val();
                    var EffectiveDate = $("#txtSiteEffDate").val();
                    var EmployeeID = $("#txtHiddenEmployeeID").val();
                    if (BillingPercentage == null || BillingPercentage == '' || BillingPercentage == undefined) {
                        BillingPercentage = 0;
                    }
                    ResourceSiteDetailParameter = {
                        BillingPercentage: encodeURI(BillingPercentage),
                        intTransferSiteID: encodeURI(intTransferSiteID),
                        StartDate: encodeURI(EffectiveDate),
                        RoleID: encodeURI(Role),
                        ProjectID: encodeURI(ProjectID),
                        strEmployeeID: encodeURI(EmployeeID),

                    }
                    var param = JSON.stringify(ResourceSiteDetailParameter);
                    var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/ResourceSiteTransfer", param, false);
                       //added by Dipali V On 19th Dec 2019 For close modal 
                    $("#SavesiteTransfer").attr("data-bs-dismiss", "modal");
                       //added by Dipali V On 19th Dec 2019 For close modal 
                     // $("#SavesiteTransfer").modal('hide');
                    $("#txtHiddenEmployeeID").val('');
                    alertify.success("Selected Resources Transferred successfully");
                    if (Flag == true) {
                      
                        GetResourceSiteList();
                        $("#Divtop").css("pointer-events", "auto");
                        $("#Divtop").css("cursor", "pointer");
                        //FillSiteCombo();
                        //added by Dipali V On 19th Dec 2019 For Refresh Site Dropdown Issues
                        $("#cboResourceProjects").change();
                           //End of added by Dipali V On 19th Dec 2019 For Refresh Site Dropdown Issues
                        $("#ResourceSiteTblBody>tr").css("pointer-events", "auto");

                        $("#siteTrans1").css("pointer-events", "auto");
                     
                    }
                    else {
                       
                        //GetResourceSiteList();
                        EditSiteDetail(GlobalEmployeeName, EmployeeID, GlobalSiteID);
                        //added by Dipali V On 19th Dec 2019 For Refresh Site Dropdown Issues
                        //$("#cboResourceProjects").change();
                         //End of added by Dipali V On 19th Dec 2019 For Refresh Site Dropdown Issues
                        $("#Emp" + EmployeeID).trigger("click");
                    }
                }
            }
            else {
                UpdateEmpSiteHistory();
            }


        }
        //Save Site Transfer
        function SaveResourceonclickold() {
            var Flag = $("#CheckWhichModal").val();
            var SiteTransfer = $("#h5siteTransfer").text();;
            if (SiteTransfer != 'Employee Site History') {
                if (ValidateSiteTransfer() == 0) {

                    var BillingPercentage = $("#txtHiddenBillingPercentage").val();
                    var intTransferSiteID = $("#cboSiteEmpSite").val();
                    var Role = $("#cboSiteEmpRole").val();
                    var EffectiveDate = $("#txtSiteEffDate").val();
                    var EmployeeID = $("#txtHiddenEmployeeID").val();
                    if (BillingPercentage == null || BillingPercentage == '' || BillingPercentage == undefined) {
                        BillingPercentage = 0;
                    }
                    ResourceSiteDetailParameter = {
                        BillingPercentage: encodeURI(BillingPercentage),
                        intTransferSiteID: encodeURI(intTransferSiteID),
                        StartDate: encodeURI(EffectiveDate),
                        RoleID: encodeURI(Role),
                        ProjectID: encodeURI(ProjectID),
                        strEmployeeID: encodeURI(EmployeeID),

                    }
                    var param = JSON.stringify(ResourceSiteDetailParameter);
                    var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/ResourceSiteTransfer", param, false);
                       //added by Dipali V On 19th Dec 2019 For close modal 
                    $("#SavesiteTransfer").attr("data-bs-dismiss", "modal");
                       //added by Dipali V On 19th Dec 2019 For close modal 
                     // $("#SavesiteTransfer").modal('hide');
                    $("#txtHiddenEmployeeID").val('');
                    alertify.success("<%= MyBase.GetResourceString("A_ResourcesTransfered") %>");
                    if (Flag == true) {
                        GetResourceSiteList();
                        //FillSiteCombo();
                        //added by Dipali V On 19th Dec 2019 For Refresh Site Dropdown Issues
                        $("#cboResourceProjects").change();
                           //End of added by Dipali V On 19th Dec 2019 For Refresh Site Dropdown Issues
                        $("#ResourceSiteTblBody>tr").css("pointer-events", "auto");

                        $("#siteTrans1").css("pointer-events", "auto");
                     
                    }
                    else {
                        EditSiteDetail(GlobalEmployeeName, EmployeeID, GlobalSiteID);
                        //GetResourceSiteList();
                           //added by Dipali V On 19th Dec 2019 For Refresh Site Dropdown Issues
                        $("#cboResourceProjects").change();
                           //End of added by Dipali V On 19th Dec 2019 For Refresh Site Dropdown Issues
                        $("#Emp" + EmployeeID).trigger("click");
                    }
                }
            }
            else {
                UpdateEmpSiteHistory();
            }


        }

        //Update Employee SIte History
        function UpdateEmpSiteHistory() {

            $("#SavesiteTransfer").removeAttr("data-bs-dismiss", "modal");
            var CheckVal = false;
            var HiddenTransferDate = $("#txtHiddenTransferDate").val();
            var Site = $("#cboSiteEmpSite").val();
            var Role = $("#cboSiteEmpRole").val();
            var EffectiveDate = $("#txtSiteEffDate").val();
            var EmployeeID = $("#txtHiddenEmployeeID").val();
            var TransferDate = $("#txtTransferDate" + EmployeeID).val();
            if (isBlank(Site)) {
                alertify.error("<%= MyBase.GetResourceString("A_Site") %>");
                $('#cboSiteEmpSite').focus();
                CheckVal = false;
            } else if (isBlank(Role)) {
                alertify.error("<%= MyBase.GetResourceString("A_Role") %>");
                $('#cboSiteEmpRole').focus();
                CheckVal = false;
            }

            else if (isBlank(EffectiveDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_EffectiveDate") %>");
                $('#txtSiteEffDate').focus();
                CheckVal = false;
            }
            else {
                if (HiddenTransferDate == EffectiveDate) {
                    ResourceSiteDetailParameter = {
                        EmployeeSiteID: encodeURI(Site),
                        RoleID: encodeURI(Role),
                        StartDate: encodeURI(EffectiveDate),
                        ProjectID: encodeURI(ProjectID),
                        EmployeeID: encodeURI(EmployeeID)

                    }
                    var param = JSON.stringify(ResourceSiteDetailParameter);
                    var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/CheckDuplicateBillingInfo", param, false);
                    if (strResult == 1) {
                        alertify.error("<%= MyBase.GetResourceString("A_SiteAndRole") %>");
                        CheckVal = false;
                    }
                    else {
                        CheckVal = true;
                    }
                }
                else if (TransferDate == EffectiveDate) {

                    alertify.error("<%= MyBase.GetResourceString("A_TransferDate") %>");
                    $('#txtSiteEffDate').focus();
                    CheckVal = false;
                }
                else {
                    CheckVal = true;
                }

            }

            if (CheckVal == true) {

                var EmployeeSiteID = $("#SpanEmployeeSiteID").val();
                var RoleID = $("#cboSiteEmpRole").val();
                var StartDate = $("#txtSiteEffDate").val();
                ResourceSiteDetailParameter = {
                    EmployeeSiteID: encodeURI(EmployeeSiteID),
                    RoleID: encodeURI(RoleID),
                    StartDate: encodeURI(StartDate),
                }
                var param = JSON.stringify(ResourceSiteDetailParameter);
                var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/UpdateEmpSiteHistory", param, false);

                $("#SavesiteTransfer").attr("data-bs-dismiss", "modal");
                alertify.success(strResult);
                EditSiteDetail(GlobalEmployeeName, EmployeeID, GlobalSiteID);

            }
            else {
                $("#SavesiteTransfer").removeAttr("data-bs-dismiss", "modal");
            }
        }

        //Validate Site Transfer
        function ValidateSiteTransfer() {
            var checkval = 0;
            var Site = $("#cboSiteEmpSite").val();
            var Role = $("#cboSiteEmpRole").val();
            var EffectiveDate = $("#txtSiteEffDate").val();
            var EmployeeID = $("#txtHiddenEmployeeID").val();
              //added by Dipali V On 19th Dec 2019 For close modal 
            $("#SavesiteTransfer").removeAttr("data-bs-dismiss", "modal");
              //End of  added by Dipali V On 19th Dec 2019 For close modal 
            var param = JSON.stringify(encodeURI(ProjectID));
            var ProjectEndDate = AJAXCallWithResult("/api/PM_ResourceSiteDetails/GetProjectEndDate", param, false);
            //Commented and added by Chetan M on 11th April 2020 for IssueID = 23193
            //ProjectEndDate = ProjectEndDate.replace(/-/g, " ");
            if (ProjectEndDate != null) {
                ProjectEndDate = ProjectEndDate.replace(/-/g, " ");
            }
            //End of Commented and added by Chetan M on 11th April 2020 for IssueID = 23193

            if (isBlank(Site)) {
                alertify.error("<%= MyBase.GetResourceString("A_Site") %>");
                $('#cboSiteEmpSite').focus();
              
                checkval = 1;

            } else if (isBlank(Role)) {
                alertify.error("<%= MyBase.GetResourceString("A_Role") %>");
                $('#cboSiteEmpRole').focus();
          
                checkval = 1;
            }
            else if (isBlank(EffectiveDate)) {
                alertify.error("<%= MyBase.GetResourceString("A_EffectiveDate") %>");
                $('#txtSiteEffDate').focus();
             
                checkval = 1;
            }
            else if (Date.parse(EffectiveDate) > Date.parse(ProjectEndDate)) {
               
                alertify.error("Effective Date should not be greater than Project End Date '" + ProjectEndDate + "'");

               // $("#siteTransfer").modal('show');
               // $('#txtSiteEffDate').focus();
                //$('#ui-datepicker-div').css({ 'top': 'auto!important', 'bottom': '0' });
                 checkval = 1;
            }
            else
            {
                ResourceSiteDetailParameter = {
                    ProjectID: encodeURI(ProjectID),
                    strEmployeeID: encodeURI(EmployeeID),
                    StartDate: encodeURI(EffectiveDate),
                }
                var param = JSON.stringify(ResourceSiteDetailParameter);
                var Result = AJAXCallWithResult("/api/PM_ResourceSiteDetails/GetUnsuccessFullTransfer", param, false);
                var EmployeeName = "";
                var EmpReason = "";

                var strResult = Result.UnsuccessFullTransfer;
                for (var i = 0; i < strResult.length; i++) {
                    ReasonID = strResult[i]["ReasonID"];
                    EmployeeName = strResult[i]["EmployeeName"];
                    EmpReason = strResult[i]["EmpReason"];
                }
                var strResult1 = Result.checkForUnsusseccfulTransfer;
                $("#AlertMsg").text(EmployeeName + '-' + EmpReason);
                //Commented and Added by Vishal Mane on 08/12/2025 to transfer site on same date
                //if (strResult1 == 1) {
                //    $("#confirmationmodal").modal('show');
                //      checkval = 1;
                //}
                //else {
                //     checkval = 0;
                //}
                if (strResult1 == 1) {
                    $("#confirmationmodal_New").modal('show');
                    $("#AlertMsg_New").text(EmployeeName + '-' + EmpReason);
                    checkval = 1;
                }
                else if (strResult1 == 2) {
                    $("#AlertMsg").text(EmployeeName + '-' + EmpReason);
                    $("#confirmationmodal").modal('show');
                    checkval = 1;
                }
                else {
                    checkval = 0;
                }
                //End of Commented and Added by Vishal Mane on 08/12/2025 to transfer site on same date
            }

            return checkval;
        }
        //Added by Vishal Mane on 08/12/2025 to transfer site on same date
        function AllowToTransferResource(flag) {
            if (flag == 1) {
                var Flag = $("#CheckWhichModal").val();
                var BillingPercentage = $("#txtHiddenBillingPercentage").val();
                var intTransferSiteID = $("#cboSiteEmpSite").val();
                var Role = $("#cboSiteEmpRole").val();
                var EffectiveDate = $("#txtSiteEffDate").val();
                var EmployeeID = $("#txtHiddenEmployeeID").val();
                if (BillingPercentage == null || BillingPercentage == '' || BillingPercentage == undefined) {
                    BillingPercentage = 0;
                }
                ResourceSiteDetailParameter = {
                    BillingPercentage: encodeURI(BillingPercentage),
                    intTransferSiteID: encodeURI(intTransferSiteID),
                    StartDate: encodeURI(EffectiveDate),
                    RoleID: encodeURI(Role),
                    ProjectID: encodeURI(ProjectID),
                    strEmployeeID: encodeURI(EmployeeID),
                }
                var param = JSON.stringify(ResourceSiteDetailParameter);
                var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/ResourceSiteTransfer", param, false);
                $("#SavesiteTransfer").attr("data-bs-dismiss", "modal");
                $("#txtHiddenEmployeeID").val('');
                alertify.success("Selected Resources Transferred successfully");
                if (Flag == true) {
                    GetResourceSiteList();
                    EditSiteDetail(GlobalEmployeeName, EmployeeID, GlobalSiteID);
                    $("#Emp" + EmployeeID).trigger("click");
                    $("#Divtop").css("pointer-events", "auto");
                    $("#Divtop").css("cursor", "pointer");
                    $("#cboResourceProjects").change();
                    $("#ResourceSiteTblBody>tr").css("pointer-events", "auto");
                    $("#confirmationmodal_New").modal('hide');
                    $("#siteTrans1").css("pointer-events", "auto");
                    $("#siteTransfer").modal('hide');
                }
                else {
                    // DeleteResource(EmployeeID);
                    EditSiteDetail(GlobalEmployeeName, EmployeeID, GlobalSiteID);
                    $("#Emp" + EmployeeID).trigger("click");
                    $("#siteTransfer").modal('hide');
                }
            }
            else {
                $("#confirmationmodal_New").modal('hide');
            }
        }
        //End of Added by Vishal Mane on 08/12/2025 to transfer site on same date

        //Click On Site Transfer siteTransfer Modal Show Or Hide
        function ResourceSiteTrasfer(Flag) {

            $("#cboSiteEmpSite").prop("disabled", false);
            $("#H5ResourceSite").text("Resource Site Transfer ");
            $("#CheckWhichModal").val(Flag);
            $("#txtSiteEffDate").val('');
            $("#LabelSite").text('Site');
            $("#LabelDate").text('Effective Date');
            GetEmpSite();
            GetEmpRole();

            if (Flag == true) {

                $("#txtHiddenEmployeeID").val('');
                var chk_box_checked_cnt = $('#ResourceSiteTblBody input[type="checkbox"]:checked').length;
                if (chk_box_checked_cnt != 0 || chk_box_checked_cnt != '') {

                    // For Checked Employee Name
                    SelectedEmployees = "";
                    $.each(ArrEmployeeName, function (i, item) {

                        SelectedEmployees += ArrEmployeeName[i] + ",";

                    });
                    SelectedEmployees = SelectedEmployees.replace(/,\s*$/, "");
                    $("#h5siteTransfer").text("Select the Site to which following Resources should be transferred: " + SelectedEmployees);

                    $("#siteTransfer").modal('show');
                    // For Checked Employee ID
                    SelectedCategoryIDs = "";
                    $.each(arrDocCatIds, function (i, item) {

                        SelectedCategoryIDs += arrDocCatIds[i] + ",";

                    });
                    SelectedCategoryIDs = SelectedCategoryIDs.replace(/,\s*$/, "");
                    $("#txtHiddenEmployeeID").val(SelectedCategoryIDs);
                }
                else {
                    $("#siteTransfer").modal('hide');
                    alertify.error("<%= MyBase.GetResourceString("A_PleaseSelectSite") %>")
                }
            }
            else {
                $("#siteTransfer").modal('show');
                $("#h5siteTransfer").text("Select the Site to which following Resources should be transferred : " + GlobalEmployeeName);

            }


        }

        //Edit Employee Site History
        function EditGetEmpSite(EmployeeID) {

            ResourceSiteDetailParameter = {
                ProjectID: encodeURI(ProjectID)
            }
            var param = JSON.stringify(ResourceSiteDetailParameter);
            var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/GetEmpSite", param, false);

            var objCbo = document.getElementById("CboSite" + EmployeeID);

            $("#CboSite" + EmployeeID + " option").remove();

            var objOption = document.createElement("OPTION");

            for (var i = 0; i < strResult.length; i++) {
                var Objresult = strResult[i];
                var objOption = document.createElement("OPTION");

                objCbo.options.add(objOption);

                objOption.text = Objresult.Name;
                objOption.value = Objresult.ProjectSiteID == 0 ? '' : Objresult.ProjectSiteID;


            }
        }

        //Date Text Box OnOnKeyPress
        function Date_OnKeyPress(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = (e.keyCode == 8 || e.keyCode == 46)
            {
                if (e.keyCode == 8 || e.keyCode == 46) {

                }
            }
            return ret;
        }

        //CheckBox Unabled Checked Ids
        function chkbxclickevent(CheckID, AddEmployeeName) {
            var EmployeeName = unescape(AddEmployeeName);

            var CheckID = parseInt(CheckID);
            var value = $("#" + CheckID).is(':enabled:checked');
            if (value == true) {
                if (arrDocCatIds.indexOf(CheckID) == -1) {
                    arrDocCatIds.push(CheckID);
                }
                if (ArrEmployeeName.indexOf(EmployeeName) == -1) {
                    ArrEmployeeName.push(EmployeeName);
                }

            } else {
                CheckID = parseInt(CheckID);
                if (arrDocCatIds.indexOf(CheckID) != -1) {

                    arrDocCatIds = jQuery.grep(arrDocCatIds, function (value) {
                        return value != CheckID;
                    });
                }
                if (ArrEmployeeName.indexOf(EmployeeName) != -1) {

                    ArrEmployeeName = jQuery.grep(ArrEmployeeName, function (value) {
                        return value != EmployeeName;
                    });
                }
            }
        }

        //CheckBox Unabled Checked Ids

        function BillingRatechkbxclickevent(CheckID) {

            var CheckID = parseInt(CheckID);
            var value = $("#" + CheckID).is(':enabled:checked');
            if (value == true) {
                if (ArrBillingRateChk.indexOf(CheckID) == -1) {
                    ArrBillingRateChk.push(CheckID);
                }

            } else {
                CheckID = parseInt(CheckID);
                if (ArrBillingRateChk.indexOf(CheckID) != -1) {

                    ArrBillingRateChk = jQuery.grep(ArrBillingRateChk, function (value) {
                        return value != CheckID;
                    });

                }
            }
        }

        // Show Or Not Delete Confirmation Modal
        function Deleteconfirmationmodal(Flag) {
            SelectedBillingRateChk = "";
            SelectedEmployeeSiteChk = "";
            $("#CheckModal").val('');
            if (Flag == true) {
                SelectedEmployeeSiteChk = "";
                $.each(ArrBillingRateChk, function (i, item) {
                    SelectedBillingRateChk += ArrBillingRateChk[i] + ",";
                });

                SelectedBillingRateChk = SelectedBillingRateChk.replace(/,\s*$/, "");

                //Start Count Of Unabled Check Box
                var id = "EmpBillingRatetblBody" + GlobalEmployeeID;
                var CheckedBillingRate = $('#' + id + ' input[type="checkbox"]:enabled').length;
                //End Count Of Unabled Check Box

                if (SelectedBillingRateChk == '' && CheckedBillingRate >= 0) {
                    $("#Deleteconfirmationmodal").modal('hide');
                    alertify.error('<%= MyBase.GetResourceString("A_ForDelete") %>');
                } else {
                    $("#CheckModal").val('Rate');
                    $("#Deleteconfirmationmodal").modal('show');
                }
            }
            else {
                SelectedEmployeeSiteChk = "";
                $.each(ArrEmployeeSiteChk, function (i, item) {

                    SelectedEmployeeSiteChk += ArrEmployeeSiteChk[i] + ",";

                });
                SelectedEmployeeSiteChk = SelectedEmployeeSiteChk.replace(/,\s*$/, "");

                //Start Count Of Unabled Check Box
                var id = "EmpSiteHistoryTblBody" + GlobalEmployeeID;
                var CheckedEmployeeSite = $('#' + id + ' input[type="checkbox"]:enabled').length;
                //End Count Of Unabled Check Box

                if (SelectedEmployeeSiteChk == '' && CheckedEmployeeSite >= 0) {
                    $("#Deleteconfirmationmodal").modal('hide');
                    alertify.error('<%= MyBase.GetResourceString("A_ForDelete") %>');
                } else {
                    $("#CheckModal").val('Site');
                    $("#Deleteconfirmationmodal").modal('show');
                }

            }
        }

        // For Delete Both Site And Rate History
        function DeleteData() {
            var CheckModal = $("#CheckModal").val();

            if (CheckModal == 'Rate') {
                DeleteEmployeeBillingRateHistory();
            } else {
                DeleteEmployeeSiteHistory();
            }

        }

        // Delete Selected Employee Billing Rate
        function DeleteEmployeeBillingRateHistory() {

            ResourceSiteDetailParameter = {
                strEmployeeBillingInfoID: encodeURI(SelectedBillingRateChk)
            }
            var param = JSON.stringify(ResourceSiteDetailParameter);
            var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/DeleteEmployeeBillingRateHistory", param, false);

            alertify.success(strResult);
            EditSiteDetail(GlobalEmployeeName, GlobalEmployeeID, GlobalSiteID);

            SelectedBillingRateChk = "";
        }

        //AjaxCall Function
        function AJAXCallWithResult(url, param, async) {

            $.ajax({
                url: encodeURI(strUrl) + url,
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

                    ajaxResult = data;
                },
                error: function (err) {
                    console.log(err);
                }
            });
            return ajaxResult;
        }

        // Employee Site Check Box 
        function EmployeeSitechkbxclickevent(CheckID) {

            var CheckID = parseInt(CheckID);
            var value = $("#" + CheckID).is(':enabled:checked');
            if (value == true) {
                if (ArrEmployeeSiteChk.indexOf(CheckID) == -1) {
                    ArrEmployeeSiteChk.push(CheckID);
                }

            } else {
                CheckID = parseInt(CheckID);
                if (ArrEmployeeSiteChk.indexOf(CheckID) != -1) {

                    ArrEmployeeSiteChk = jQuery.grep(ArrEmployeeSiteChk, function (value) {
                        return value != CheckID;
                    });

                }
            }
        }

        //Delete Selected Employee Site
        function DeleteEmployeeSiteHistory() {

            ResourceSiteDetailParameter = {
                strEmployeeSiteID: encodeURI(SelectedEmployeeSiteChk)
            }
            var param = JSON.stringify(ResourceSiteDetailParameter);
            var strResult = AJAXCallWithResult("/api/PM_ResourceSiteDetails/DeleteEmployeeSiteHistory", param, false);

            alertify.success(strResult);
            SelectedEmployeeSiteChk = "";
            EditSiteDetail(GlobalEmployeeName, GlobalEmployeeID, GlobalSiteID);

        }

        var currentToken = '';
        function generatetoken() {
            try {
                var ProjectID = $("#cboResourceProjects option:selected").val();

                if (ProjectID != undefined) {

                    var generatedtoken = ajaxCall("PM_ResourceSiteDetails.aspx/GeneratePK_Token", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: ProjectID }));

                    if (generatedtoken != undefined) {

                        currentToken = generatedtoken.d;
                        validatetoken();
                    }
                }
            }
            catch (ex) {
                //alert(ex.message());
            }
        }

        var PKToken;
        function validatetoken() {

            try {
                var ProjectID = $("#cboResourceProjects option:selected").val();

                PKToken = currentToken;

                if (ProjectID != undefined) {
                    var validatetoken = ajaxCall("PM_ResourceSiteDetails.aspx/ValidatePK_Token", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: ProjectID, PKToken: PKToken }));

                    if (validatetoken != undefined) {
                        if (validatetoken.d == false) {
                            window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                        }

                    }
                }
            }
            catch (ex) {
                alert(ex.message());
            }
        }

        function ajaxCall(url, type, contentType, dataType, data) {
            var ajaxResult;

            $.ajax({
                url: url,
                type: "POST",
                data: data,
                async: false,
                dataType: "json",
                contentType: "application/json;charset-utf=8",

                success: function (data) {

                    ajaxResult = data;
                },
                error: function (err) {

                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
            return ajaxResult;
        }


        //dynamically set height
        //function resizeSection() {
        //    var risktblheight = $(window).height();
        //    $('.scrollable-area').css({ 'height': risktblheight - 170, "overflow-y": "auto" });
        //}

        //$(window).on("load resize scroll", function (e) {
        //    resizeSection(this);
        //});

    </script>

</body>

</html>
