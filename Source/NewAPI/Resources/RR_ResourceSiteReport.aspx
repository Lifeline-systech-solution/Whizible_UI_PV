<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RR_ResourceSiteReport.aspx.vb" Inherits="PbNIT.RR_ResourceSiteReport" %>

<!DOCTYPE html>
<html>   
     <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head runat="server">
  <%--  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">--%>
  <%--  <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
 <%--   <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

    

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


        /*New css start here*/
        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .rsrslistRprtTbl tr td {
            text-align: left;
        }

        .rsrslistRprtTbl tr th {
            min-width: 100px;
            text-align: left;
        }

            .rsrslistRprtTbl tr th:nth-child(3n), .rsrslistRprtTbl tr th:nth-child(8n) {
                min-width: 140px;
            }

            .rsrslistRprtTbl tr th:nth-child(9n) {
                min-width: 200px;
            }
            /*.rsrslistRprtTbl tr th{min-width: 90px;}*/
            .rsrslistRprtTbl tr th:first-child {
                min-width: 200px;
            }

        #IDrsrslistRprtTbl2 tr th:nth-child(2n) {
            min-width: 200px;
        }

        .rsrslistRprtTbl tr th {
        }

        #MEdetails .control-label, #basicfilters label {
            line-height: 18px;
            text-align: right;
        }
        /*simple pagination style*/
        .simple-pagination {
            display: inline-block;
            padding-left: 0;
            margin-top: 1rem;
            margin-bottom: 1rem;
            border-radius: .25rem
        }

            .simple-pagination li {
                display: inline
            }

            .simple-pagination .page-link, .simple-pagination .ellipse, .simple-pagination .current {
                display: inline-block;
                position: relative;
                float: left;
                padding: .5rem .75rem;
                margin-left: -1px;
                color: #0275d8;
                text-decoration: none;
                background-color: #fff;
                border: 1px solid #ddd
            }

            .simple-pagination li:first-child .page-link {
                margin-left: 0;
                border-bottom-left-radius: .25rem;
                border-top-left-radius: .25rem
            }

            .simple-pagination li:last-child .page-link {
                border-bottom-right-radius: .2rem;
                border-top-right-radius: .2rem
            }

            .simple-pagination li.active .page-link, .simple-pagination li.active .page-link:focus, .simple-pagination li.active .page-link:hover, .simple-pagination li.active .current, .simple-pagination li.active .current:focus, .simple-pagination li.active .current:hover {
                z-index: 2;
                color: #fff;
                cursor: default;
                background-color: #0275d8;
                border-color: #0275d8
            }

                .simple-pagination li.active .page-link, .simple-pagination li.active .page-link:focus, .simple-pagination li.active .page-link:hover, .simple-pagination li.active .current, .simple-pagination li.active .current:focus, .simple-pagination li.active .current:hover {
                    background: #1359ac;
                }

        .ResourceDetailRprtbySite > table > thead > tr > th {
            position: sticky;
            top: 0;
        }

         th {
            position: sticky;
            top: 0;
        }
        /*End of pagination style*/
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="body-ResourceSite">

    <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-1 text-right graybg" style="display:table">
            <h5 class="pgtitle pull-left">Resource Details by Site and Day</h5>

            <div class="dropdown filedownload pull-right" style="margin-top: 5px;">
                <%--<button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-toggle="tooltip" data-bs-placement="bottom" data-bs-original-title="Click here to download" class="fas fa-download"></i></button>--%>
                <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" data-bs-placement="bottom" title="Click here to download" class="fas fa-download"></i></button>
                <ul class="dropdown-menu">
                    <li><a href="#" onclick="ExportResourceSiteReport('PDF');">
                        <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                    <li><a href="#" onclick="ExportResourceSiteReport('EXCEL');">
                        <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                    <li><a href="#" onclick="ExportResourceSiteReport('XML');">
                        <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                    <li><a href="#" onclick="ExportResourceSiteReport('RTF');">
                        <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Rtf</a></li>
                </ul>

            </div>

        </div>


        <div class="col-sm-12 pt-1 pb-1">

            <!--Grid filter start from here-->
            <div class="form-horizontal">
                <div class="row form-row mb-1">
                    <div class="col-sm-4">
                        <label class="control-label required">Organize By</label>
                        <select id="RLonchangeBy" class="form-control">
                            <option value="0">Select Organize By</option>
                            <option value="Site">Site</option>
                            <option value="Resource">Resource</option>
                        </select>
                    </div>
                    <div class="col-sm-4">
                        <label class="control-label required">Project</label>
                        <%--                        <% CommonFunctions.HTMLControls.DrawComboBox("txtRSFilterProjectID", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee " & 61,,, "class='form-control',onChange = ""FillFilterSiteOnProject(this.value)""", True,,, ,) %>--%>
                        <% CommonFunctions.HTMLControls.DrawComboBox("txtRSFilterProjectID", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee " & Convert.ToInt32(Session("intUserId").ToString()),,, "class='form-control' onChange='javascript:FillFilterSiteOnProject(this.value),FillFilterResourceOnProject(this.value);'", False,,) %>
                    </div>

                    <div class="col-sm-4">
                        <label class="control-label">Organization Unit</label>
                        <% CommonFunctions.HTMLControls.DrawComboBox("txtRSFilterLocationID", "usp_Whizible2_Sel_GetOrgUnitForFilter",,, "class='form-control'",,,, , ) %>
                    </div>
                    <div class="clearfix"></div>
                </div>

                <div class="row form-row">
                    <div class="col-sm-4">
                        <label class="control-label required">Site</label>
                        <% CommonFunctions.HTMLControls.DrawComboBox("txtRSFilterSiteID", "Select 0,'' ",,, "class='form-control'",,, ) %>
                    </div>
                    <div class="col-sm-4">
                        <label class="control-label required">Resource</label>
                        <% CommonFunctions.HTMLControls.DrawComboBox("txtRSFilterEmployeeID", "Select 0,'' ",,, "class='form-control'",,, ) %>
                    </div>


                    <div class="col-sm-4" style="margin-top:5px">
                        <br />
                        <button class="btn btnyellow" onclick="ApplyFilter();">Apply</button>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
            <!--Grid filter end here-->

        </div>
        <div class="clearfix"></div>
        <div class="content pt-0">
            <div class="resourcelist-wrapper">
                <div class="ResourceDetailRprtbySite RsrsReportTblbox">
                    <div class="table-responsive" style="height: 60vh;">
                        <table id="IDrsrslistRprtTbl" class="table table-bordered rsrslistRprtTbl">
                            <thead>
                                <tr>
                                    <th>Site / Project</th>
                                    <th>Resource Name</th>
                                    <th>Date</th>
                                    <th>Normal Hours</th>
                                    <th>Normal Rate</th>
                                    <th>Normal Billing Total</th>
                                    <th>Extra Hour</th>
                                    <th>Extra Rate</th>
                                    <th>Extra Billing Total</th>
                                    <th>Billable Hours</th>
                                    <th>Billable Total</th>
                                    <th>Non-Billable Hours</th>
                                    <th>Non Billable Total</th>

                                </tr>
                            </thead>

                            <tbody id="tblResourceSiteMain">
                                <tr>
                                    <td colspan="14">Please select filter and click on apply</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <%--  <div id="pagination" class="pull-right"></div>--%>
                </div>


                <div class="ResourceDetailRprtbyDay RsrsReportTblbox">
                    <div class="table-responsive" style="height: 60vh;">
                        <table id="IDrsrslistRprtTbl2" class="table table-bordered rsrslistRprtTbl">
                            <thead>
                                <tr>
                                    <th>Resource Name</th>
                                    <th>Site / Project</th>
                                    <th>Date</th>
                                    <th>Normal Hours</th>
                                    <th>Normal Rate</th>
                                    <th>Normal Billing Total</th>
                                    <th>Extra Hour</th>
                                    <th>Extra Rate</th>
                                    <th>Extra Billing Total</th>
                                    <th>Billable Hours</th>
                                    <th>Billable Total</th>
                                    <th>Non-Billable Hours</th>
                                    <th>Non Billable Total</th>

                                </tr>
                            </thead>
                            <tbody id="tblResourceSiteResource">
                                <tr>
                                    <td colspan="14">Please select filter and click on apply</td>
                                </tr>
                            </tbody>
                        </table>
                        <%-- <div id="pagination2" class="pull-right"></div>--%>
                    </div>
                    <%--  <div id="pagination" class="pull-right"></div>--%>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>



        <div class="clearfix"></div>
    </div>

    <!-- Save filter Modal start here-->
    <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-dismiss="modal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Save Filter As</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="Issuesavrefilterbox" class="box-panel">

                        <div class="box-body graybg">
                            <div class="form-group mb-0">
                                <div class="row">
                                    <div class="col-md-12 row">
                                        <label class="control-label col-md-4 p-0 text-right">Filter Name :</label>
                                        <span class="col-md-8">
                                            <input type="text" class="form-control" name=""><br />
                                            <div class="btnrow">
                                                <button id="savefilterbtn" class="btn btnyellow pull-left">Save</button>
                                                <button data-dismiss="modal" class="btn canclesaveasbtn borderbtn pull-right">Cancel</button>
                                            </div>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
    </div>
    <!-- Save filter Modal End here-->
    <!-- REQUIRED JS SCRIPTS -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
  <%--  <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.simplePagination.js"></script>
<%--    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
    --%>
    <script>
        var IsResource = true;
        var IsSite = false;
        var NoDataFound = "No data found.";
        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var RoleDes = '';
        var SessionProjectId = '<%= Session("intProjectId") %>';
     <%--    var RoleName = '<%= Session("strRoleName") %>';--%>
        var selectedProjectID = '<%= Session("IntProjectID") %>';
        var TagID = '<%= m_TagId%>';
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var noOfRowsPerPage = 10;
        $(document).ready(function () {
            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            //FillFilterSiteOnProject(0);
            // FillFilterResourceOnProject(0);
            if (blnViewAccess == "True") {
                GetMaximumItemsToShowInList();
                // GetResourceAllocationByProject(null);
                var GroupBy = $('#RLonchangeBy').val();
                $(".ResourceDetailRprtbySite").hide();
                //  $(".ResourceDetailRprtbyDay").hide();
                //   GetResourceSiteBySite(null, GroupBy);
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }

            //Added By Chetan M. For Bind Filter Placeholder on 22 July 2021
            BindPlaceholder("txtRSFilterLocationID", "Organization Unit"); 
            $("#txtRSFilterSiteID").html("<option value='0'>Select Site</option>");
            $("#txtRSFilterEmployeeID").html("<option value='0'>Select Resource</option>");            
            //End of Added By Chetan M. For Bind Filter Placeholder on 22 July 2021

            //Added By Riddhesh Patil on 9 May 2023 for dropdown not closing Issue
            $("body").on("click", "[data-bs-toggle='dropdown']", function () {
                $(".nav-tabs [data-bs-toggle='dropdown']").find(".dropdown-menu, .dropdown-toggle").removeClass("show");
                $(this).closest(".dropdown']").find(".dropdown-menu, .dropdown-toggle").addClass("show");

            });

            $('body').on('click', function (e) {
                $('[data-bs-toggle="dropdown"]').each(function (e) {
                    // hide any open popovers when the anywhere else in the body is clicked
                    if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.dropdown .dropdown-menu').has(e.target).length === 0) {
                        $(".dropdown-menu").removeClass('show');
                    }
                });
            });
            //End of Added By Riddhesh Patil on 9 May 2023 for dropdown not closing Issue
        });
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

        function OnClickSiteAndResource() {
            IsSite = true;
            IsResource = false;
            var GroupBy = $('#RLonchangeBy').find(":selected").text();
            if (GroupBy == "Resource") {
                // GetResourceAllocationByProject(null);
                $(".ResourceDetailRprtbySite").hide();
                $(".ResourceDetailRprtbyDay").show();
                IsResource = true;
            }
            else if (GroupBy == "Site") {
                // GetResourceAllocationByResource(null);
                $(".ResourceDetailRprtbySite").show();
                $(".ResourceDetailRprtbyDay").hide();
                IsSite = true;
            }
            else {
                // GetResourceAllocationByProject(null);
            }


        }



        //$(function ($) {
        //    var items = $("#IDrsrslistRprtTbl tbody tr.pgrow");

        //    var numItems = items.length;
        //    var perPage = 8;

        //    // Only show the first 2 (or first `per_page`) items initially.
        //    items.slice(perPage).hide();

        //    // Now setup the pagination using the `#pagination` div.
        //    $("#pagination").pagination({
        //        items: numItems,
        //        itemsOnPage: perPage,
        //        cssStyle: "light-theme",

        //        // This is the actual page changing functionality.
        //        onPageClick: function (pageNumber) {
        //            // We need to show and hide `tr`s appropriately.
        //            var showFrom = perPage * (pageNumber - 1);
        //            var showTo = showFrom + perPage;

        //            // We'll first hide everything...
        //            items.hide()
        //                // ... and then only show the appropriate rows.
        //                .slice(showFrom, showTo).show();
        //        }
        //    });
        //});

        //$(function ($) {
        //    var items = $("#IDrsrslistRprtTbl2 tbody tr.pgrow");

        //    var numItems = items.length;
        //    var perPage = 8;

        //    // Only show the first 2 (or first `per_page`) items initially.
        //    items.slice(perPage).hide();

        //    // Now setup the pagination using the `#pagination` div.
        //    $("#pagination2").pagination({
        //        items: numItems,
        //        itemsOnPage: perPage,
        //        cssStyle: "light-theme",

        //        // This is the actual page changing functionality.
        //        onPageClick: function (pageNumber) {
        //            // We need to show and hide `tr`s appropriately.
        //            var showFrom = perPage * (pageNumber - 1);
        //            var showTo = showFrom + perPage;

        //            // We'll first hide everything...
        //            items.hide()
        //                // ... and then only show the appropriate rows.
        //                .slice(showFrom, showTo).show();
        //        }
        //    });
        //});
         //dynamically set height
        function resizeSection(tag) {
            var JStableOuter = $(window).height();
            //$('.JStableOuter > table, .PRweekdaytbl td::after').css({ 'height': JStableOuter - 215, "overflow-y": "auto" });

            var JStabledividerHeight = $(window).height();
            //$('.PRweekdaytbl td::after').css({ 'height': JStabledividerHeight - 215, "overflow-y": "auto" });
            $('.projectallocationpanel .JStableOuter').css({ 'height': JStableOuter - 80, "overflow-y": "auto" });
            //$(".PRweekdaytbl td::after").css({'height':JStableOuter});

        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });
        //Change table as per organized by
        //$("#RLonchangeBy").change(function () {
        //    $(this).find("option:selected").each(function () {
        //        var optionValue = $(this).attr("value");
        //        if (optionValue) {
        //            $(".RsrsReportTblbox").not("." + optionValue).hide();
        //            $("." + optionValue).show();
        //        } else {
        //            $(".RsrsReportTblbox").hide();
        //        }
        //    });

        //}).change();
        function FillFilterSiteOnProject(params) {
            var strHTML = "";
            var PID = $('#txtRSFilterProjectID').val();
            var objCODE = { ProjectID: PID }
            //if (BgID != "" && BgID > 0) {
            $.ajax({
                url: strUrl + '/api/RR_SiteReport/GetSites',
                type: "POST",
                data: JSON.stringify(objCODE),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                   xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objCODE) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objCODE) ? objCODE : JSON.stringify(objCODE)));
                    }
                },
                success: function (data) {
                    //$("#cboOPRFilterLocationID").empty();
                   // strHTML += "<option value='0'></option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.ProjectSiteID + ' >' + listComponent.Name + '</option>');

                    }
                    if (params != null && params > 0 && params != undefined)
                        $("#txtRSFilterSiteID").val(params);

                    $("#txtRSFilterSiteID").html(strHTML);
                    //Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
                    BindPlaceholder("txtRSFilterSiteID", "Site");     
                    //End of Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
                    //FillFilterResourceOnProject(PID);
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                 //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })

            //}
        }

        function FillFilterResourceOnProject(params) {
            var strHTML = "";
            var PID = $('#txtRSFilterProjectID').val();
            var objCODE = { ProjectID: PID }
            //if (BgID != "" && BgID > 0) {
            $.ajax({
                url: strUrl + '/api/RR_SiteReport/GetProjectResources',
                type: "POST",
                data: JSON.stringify(objCODE),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objCODE) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objCODE) ? objCODE : JSON.stringify(objCODE)));
                    }
                },
                success: function (data) {
                    //$("#cboOPRFilterLocationID").empty();
                    //strHTML += "<option value='0'></option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.EmployeeID + ' >' + listComponent.EmployeeName + '</option>');

                    }
                    if (params != null && params > 0 && params != undefined)
                        $("#txtRSFilterEmployeeID").val(params);

                    $("#txtRSFilterEmployeeID").html(strHTML);
            BindPlaceholder("txtRSFilterEmployeeID", "Resource");        

                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.notify(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyBusiness-group");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                 //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })

            //}
        }

        function GetMaximumItemsToShowInList() {
            // StartLoader("#bodyGlobal-Resource");
            $.ajax({
                url: strUrl + '/api/RM_GlobalResourcePool/GetMaximumItemsToShowInList',
                type: "POST",
                data: JSON.stringify(),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                },
                success: function (data) {
                    noOfRowsPerPage = data;
                    //alert(noOfRowsPerPage);
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.error(xhr.responseJSON.Message);
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(thrownError);
                    }


                }
            })

        }
        var validateflag;
        function checkValidationForExport() {
            var Emp = $("#txtRSFilterEmployeeID").val() == "" ? null : $("#txtRSFilterEmployeeID").val();
            var ProjID = $("#txtRSFilterProjectID").val() == "" ? null : $("#txtRSFilterProjectID").val();
            var OrganizedBy = $("#RLonchangeBy").val();

            if (OrganizedBy == null || OrganizedBy == 'undefined' || OrganizedBy == '0') {
                $("#RLonchangeBy").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select Organize By.");
                return false;
            }
            else if (ProjID == null || ProjID == 'undefined' || ProjID == 0) {
                $("#txtRSFilterProjectID").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select Project.");
                return false;
            }
            else {
                validateflag = true;
                return true;
            }
        }
        function checkValidation() {
            var Emp = $("#txtRSFilterEmployeeID").val() == "" ? null : $("#txtRSFilterEmployeeID").val();
            var ProjID = $("#txtRSFilterProjectID").val() == "" ? null : $("#txtRSFilterProjectID").val();
            var SiteID = $("#txtRSFilterSiteID").val() == "" ? null : $("#txtRSFilterSiteID").val();
            var OrganizedBy = $("#RLonchangeBy").val();
            if (OrganizedBy == null || OrganizedBy == 'undefined' || OrganizedBy == '0') {
                $("#RLonchangeBy").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select Organize By.");
                return false;
            }
            else if (ProjID == null || ProjID == 'undefined' || ProjID == 0) {
                $("#txtRSFilterProjectID").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select Project.");
                return false;
            }
            else if (ProjID == null || ProjID == 'undefined' || ProjID == 0) {
                $("#txtRSFilterProjectID").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select Project.");
                return false;
            }
            else if (SiteID == null || SiteID == 'undefined' || SiteID == 0) {
                $("#txtRSFilterSiteID").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select site.");
                return false;
            }
            else if (Emp == null || Emp == 'undefined' || Emp == 0) {
                $("#txtRSFilterEmployeeID").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select Resource.");
                return false;
            }

            else {
                validateflag = true;
                return true;
            }
        }


        function ExportResourceSiteReport(filterParams) {
            checkValidation();
            if (validateflag == true) {
                var filterParams1 =
                    {
                        ProjectID: "",
                        EmployeeID: "",
                        SiteID: "",
                        LocationID: "",
                        BySiteResource: "Site"
                    }

                var ProjID = $('#txtRSFilterProjectID').val();
                var EmpID = $('#txtRSFilterEmployeeID').val();
                var SID = $('#txtRSFilterSiteID').val();
                var LID = $('#txtRSFilterLocationID').val();
                var ReportsTab = $('#RLonchangeBy').val();
                filterParams1.ProjectID = ProjID;
                filterParams1.EmployeeID = EmpID;
                filterParams1.SiteID = SID;
                filterParams1.LocationID = LID;
                filterParams1.ReportFormat = filterParams;
                filterParams1.BySiteResource = ReportsTab;
                //}

                StartLoader("#body-ResourceSite");
                $.ajax({
                    url: strUrl + '/api/RR_SiteReport/ExportDocument',
                    type: "POST",
                    data: JSON.stringify(filterParams1),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (filterParams1) {
                            xhr.setRequestHeader("Params", encryptString(isJson(filterParams1) ? filterParams1 : JSON.stringify(filterParams1)));
                        }
                    },
                    success: function (data) {
                        if (data == "") {
                            // showAlert('Records not available to download Report.', 'alert-danger');
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error("Records not available to download Report.");
                            // alert("NOT");
                        }
                        else {
                            //C:\Applications\Whizible_2\Source\CRW
                            window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + data, "_report", "");
                        }
                        StopAjaxLoader("#body-ResourceSite");
                    },
                    //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    StopAjaxLoader("#body-ResourceSite");
                    //}
                     error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    }
                     //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                })
            } else {
                return false;
            }
        }

        function GetResourceSiteBySite(BySiteResource) {

            var strHTML = "";
            checkValidation();
            if (validateflag == true) {
                var filterParams1 =
                    {
                        ProjectID: "",
                        EmployeeID: "",
                        SiteID: "",
                        LocationID: "",
                        BySiteResource: "Site"
                    }

                var ProjID = $('#txtRSFilterProjectID').val();
                var EmpID = $('#txtRSFilterEmployeeID').val();
                var SID = $('#txtRSFilterSiteID').val();
                var LID = $('#txtRSFilterLocationID').val();
                var ReportsTab = $('#RLonchangeBy').val();
                filterParams1.ProjectID = ProjID;
                filterParams1.EmployeeID = EmpID;
                filterParams1.SiteID = SID;
                //added by imran on 22-08-2022
                if (LID == "") {
                    filterParams1.LocationID = 0;
                }
                else {
                    filterParams1.LocationID = LID;
                }
                //End of comment by imran on 22-08-2022
                
                //   filterParams1.ReportFormat = filterParams;
                filterParams1.BySiteResource = ReportsTab;

                $.ajax({
                    url: strUrl + '/api/RR_SiteReport/GetResourceListBySiteResource',
                    type: "POST",
                    data: JSON.stringify(filterParams1),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (filterParams1) {
                            xhr.setRequestHeader("Params", encryptString(isJson(filterParams1) ? filterParams1 : JSON.stringify(filterParams1)));
                        }
                    },
                    success: function (data) {
                        var List = data;
                        if (List.length > 0) {
                            // if (BySiteResource == "Site") {
                            $.each(List, function (index, obj) {
                                strHTML += '<tr class="graybglight pgrow"><td colspan="14" class="text-left">' + obj.SiteName + '</td></tr>'
                                $.each(obj.lstResourceReport, function (index, objrep) {
                                    //Comment and added by imran on 05-01-2022
                                    //strHTML += '<tr class="pgrow"><td class="text-left">&nbsp;</td><td class="text-center">' + objrep.ResourceName + '</td><td class="text-center">' + convert(objrep.Date) + '</td><td class="text-center">'
                                    strHTML += '<tr class="pgrow"><td class="text-left">&nbsp;</td><td class="text-center">' + objrep.ResourceName + '</td><td class="text-center">' + objrep.Date + '</td><td class="text-center">'
                                    //End comment by imran on 05-01-2022
                                        + objrep.NormalHours + '</td><td class="text-center">' + objrep.NormalRate + '</td><td class="text-center">' + objrep.NormalBillingTotal +
                                        '</td><td class="text-center">' + objrep.ExtraHour + '</td><td class="text-center">' + objrep.ExtraRate + '</td><td class="text-center">' +
                                        objrep.ExtraBillingTotal + '</td><td class="text-center">' + objrep.BillableHours + '</td><td class="text-center">' + objrep.BillableTotal +
                                        '</td><td class="text-center">' + objrep.NonBillableHours + '</td><td class="text-center">' + objrep.NonBillableTotal + '</td></tr>';
                                });
                            });

                            // }
                        }
                        else {

                            strHTML = '<tr><td class="text-center"colspan="13">' + NoDataFound + ' </td></tr>';
                        }
                        $(".ResourceDetailRprtbySite").show();
                        $(".ResourceDetailRprtbyDay").hide();
                        ///$('#IDrsrslistRprtTbl').dataTable().fnDestroy();
                        $("#tblResourceSiteMain").html(strHTML);
                        //LoadPagination("#IDrsrslistRprtTbl", data);
                        //StopAjaxLoader("#body-ResourceList");

                    },
                    // Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    //StopAjaxLoader("#body-ResourceList");
                    //}
                     error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    }
                     //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                })

            }
        }
        function GetResourceSiteByResource(BySiteResource) {
            var strHTML = "";
            //StartLoader("#body-ResourceList");
            checkValidationForExport();
            if (validateflag == true) {
                var filterParams1 =
                    {
                        ProjectID: "",
                        EmployeeID: "",
                        SiteID: "",
                        LocationID: "",
                        BySiteResource: "Resource"
                    }

                var ProjID = $('#txtRSFilterProjectID').val();
                var EmpID = $('#txtRSFilterEmployeeID').val();
                if (EmpID == "") {
                    EmpID = 0;
                }
                var SID = $('#txtRSFilterSiteID').val();
                if (SID == "") {
                    SID = 0;
                }
                var LID = $('#txtRSFilterLocationID').val();
                if (LID == "") {
                    LID = 0;
                }
                var ReportsTab = $('#RLonchangeBy').val();
                filterParams1.ProjectID = ProjID;
                filterParams1.EmployeeID = EmpID;
                
                filterParams1.SiteID = SID;
                filterParams1.LocationID = LID;
                //filterParams1.ReportFormat = filterParams;
                filterParams1.BySiteResource = ReportsTab;
                 
                $.ajax({
                    url: strUrl + '/api/RR_SiteReport/GetResourceListBySiteResource',
                    type: "POST",
                    data: JSON.stringify(filterParams1),
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (filterParams1) {
                            xhr.setRequestHeader("Params", encryptString(isJson(filterParams1) ? filterParams1 : JSON.stringify(filterParams1)));
                        }
                    },
                    success: function (data) {
                        var List = data;
                        if (List.length > 0) {
                            //if (BySiteResource == "Resource") {
                            $.each(List, function (index, obj)
                            {
                                strHTML += '<tr class="graybglight pgrow"><td colspan="14" class="text-left">' + obj.ResourceName + '</td></tr>'
                                $.each(obj.lstResourceReport, function (index, objrep) {
                                    //Comment and added by imran on 05-01-2022
                                    //strHTML += '<tr class="pgrow"><td class="text-left">&nbsp;</td><td class="text-center">' + objrep.SiteName + '</td><td class="text-center">' + convert(objrep.Date) + '</td><td class="text-center">'
                                    strHTML += '<tr class="pgrow"><td class="text-left">&nbsp;</td><td class="text-center">' + objrep.SiteName + '</td><td class="text-center">' + objrep.Date + '</td><td class="text-center">'
                                    //End comment by imran on 05-01-2022
                                        + objrep.NormalHours + '</td><td class="text-center">' + objrep.NormalRate + '</td><td class="text-center">' + objrep.NormalBillingTotal +
                                        //Comment And Added by imran on 29-12-2021 column name ExtraHours Mismatch
                                        //'</td><td class="text-center">' + objrep.ExtraHours + '</td><td class="text-center">' + objrep.ExtraRate + '</td><td class="text-center">' +
                                        '</td><td class="text-center">' + objrep.ExtraHour + '</td><td class="text-center">' + objrep.ExtraRate + '</td><td class="text-center">' +
                                        //End Comment by imran on 29-12-2021
                                        objrep.ExtraBillingTotal + '</td><td class="text-center">' + objrep.BillableHours + '</td><td class="text-center">' + objrep.BillableTotal +
                                        '</td><td class="text-center">' + objrep.NonBillableHours + '</td><td class="text-center">' + objrep.NonBillableTotal + '</td></tr>';
                                });
                            });

                            //}
                        }
                        else {
                            strHTML = '<tr><td class="text-center"colspan="13">' + NoDataFound + ' </td></tr>';
                        }
                        $(".ResourceDetailRprtbySite").hide();
                        $(".ResourceDetailRprtbyDay").show();

                        //$('#IDrsrslistRprtTbl2').dataTable().fnDestroy();
                        $("#tblResourceSiteResource").html(strHTML);
                        //LoadPagination("#IDrsrslistRprtTbl2", data);
                        //StopAjaxLoader("#body-ResourceList");

                    },
                    //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    //StopAjaxLoader("#body-ResourceList");
                    //}
                     error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    }
                     //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                })

            }
        }
        function LoadPagination(TableName, data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            ResourceTSTable = $(TableName).dataTable({
                "dtat": data,
                "bFilter": false,
                "retrieve": true,
                "fixedHeader": true,
                "scrollX": true,
                "scrollY": true,
                "scrollResize": true,
                "scrollcollapse": true,
                "iDisplayLength": noOfRowsPerPage,
                "lengthChange": false,
                "searching": false,
                "destroy": true,

            });

        }
        //START FILTER
        function ApplyFilter() {

            //var filterWhereClause2;
            //var filter = "";
            //currentFilterID = 0;
            //var AllRLFilter = ["ProjectID", "SiteID", "EmployeeID","LocationID"];
            ////var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
            //filterWhereClause2 = GenerateBasicFilterQuery("RS", AllRLFilter);
            //console.log("filterWhereClause2", filterWhereClause2);

            var GroupBy = $('#RLonchangeBy').val();
            if (GroupBy == "Site") {
                GetResourceSiteBySite(GroupBy);
            }
            else {
                GetResourceSiteByResource(GroupBy);
            }
            //Added By RehanC For not getting alert after Applying filter on 21st Mar 2023
            alertify.set('notifier', 'position', 'top-right');
            alertify.success("Filter Applied Successfully");
           //End of Comment Added By RehanC For not getting alert after Applying filter on 21st Mar 2023

        }
        function convert(str) {
            var date = new Date(str),
                mnth = ("0" + (date.getMonth() + 1)).slice(-2),
                day = ("0" + date.getDate()).slice(-2);
            return [date.getFullYear(), mnth, day].join("-");
        }

         //Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
        function BindPlaceholder(ID, Caption) {
            var textval = "Select " + Caption;
            if (document.getElementById(ID) != null) {
                document.getElementById(ID).insertBefore(new Option(textval, ''), document.getElementById(ID).firstChild);

                $("#" + ID + " option[value='']").prop('selected', true);
            }
        }
        //End of Added By Chetan M. For Bind Filter Placeholder on 15 July 2021

    </script>

</body>

</html>
