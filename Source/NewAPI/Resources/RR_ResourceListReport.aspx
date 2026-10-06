<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RR_ResourceListReport.aspx.vb" Inherits="PbNIT.RR_ResourceListReport" %>

<!DOCTYPE html>

<html>  
 <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head runat="server">
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">--%>
   <%-- <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
  <%--  <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

  
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

        th {
            position: sticky;
            top: 0;
        }
        /*th {
            position: -webkit-sticky;
            position: sticky;
            top: 0;
            z-index: 2;
        }*/
        /*End of pagination style*/
    </style>

<body class="hold-transition skin-blue-light sidebar-mini fixed" >
    <%--  /*Added & Commented By Madhuri.K On 21-Aug-2024 For Loader Issues*/--%>
    <div class="" id="body-ResourceList"></div>
        <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-1 text-right graybg" style="display:table">
            <h5 class="pgtitle pull-left">Resource List(By Business Group/Organization Unit)</h5>

            <div class="dropdown filedownload pull-right" style="margin-top: 5px;">
                <%--<button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-toggle="tooltip" data-bs-placement="bottom" data-bs-original-title="Click here to download" class="fas fa-download"></i></button>--%>
                <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown"><i data-bs-toggle="tooltip" data-bs-placement="bottom" title="Click here to download" class="fas fa-download"></i></button>
                <ul class="dropdown-menu">
                    <li><a href="#" onclick="ExportResourceListReport('PDF');">
                        <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                    <li><a href="#" onclick="ExportResourceListReport('EXCEL');">
                        <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                    <li><a href="#" onclick="ExportResourceListReport('XML');">
                        <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                    <li><a href="#" onclick="ExportResourceListReport('RTF');">
                        <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Rtf</a></li>
                </ul>

            </div>

        </div>


        <div class="col-sm-12 pt-1 pb-1">
            <!--Grid filter start from here-->
            <div class="form-horizontal">
                <div class="row form-row">
                    <div class="col-sm-4 mb-1">
                        <label class="control-label required">Group By</label>
                        <select id="RLonchangeBy" class="form-control">
                            <option value="0">Select Group By</option>
                            <option value="BG">Business Group</option>
                            <option value="OU">Organization Unit</option>
                        </select>
                    </div>

                    <div class="col-sm-4">
                        <label class="control-label">Business Group</label>
                        <% CommonFunctions.HTMLControls.DrawComboBox("txtRLFilterBusinessGroupID", "usp_Whizible2_Sel_BusinessGroupsFilter",,, "class=""form-control"" onChange=""FillFilterOUForFilter(this.value)""",,,, ,)%>
                    </div>
                    <div class="col-sm-4 mb-1">
                        <label class="control-label">Organization Unit</label>
                        <% CommonFunctions.HTMLControls.DrawComboBox("txtRLFilterLocationID", "Select 0,'' ",,, "class='form-control'",,, ) %>
                    </div>

                    <div class="col-sm-4">
                        <label class="control-label">Role</label>
                        <% CommonFunctions.HTMLControls.DrawComboBox("txtRLFilterPostID", "usp_Whizible2_Sel_tbl_PM_Role",,, "class='form-control'",,,, ,) %>
                    </div>
                    <div class="col-sm-2">
                        <div class="" style="margin-top:-15px">
                            <br />
                            <br />
                            <button class="btn btnyellow" onclick="ApplyFilter();">Apply</button>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>


            </div>
            <!--Grid filter end here-->

            <div class="form-inline">
                <div class="clearfix"></div>
            </div>

        </div>
        <div class="clearfix"></div>
        <div class="content pt-0">
            <div class="resourcelist-wrapper">
                <!--<h5 class="text-center" style="color:#4263c1;">LOREM SYSTECH SOLUTIONS Pvt. Ltd.</h5>-->
                <!--<p class="text-center">Thhis Reports give the list of all the resources at a given point of time</p>
                <br/>-->

                <div class="ResourcelistRprtbyBG RsrsReportTblbox">
                    <div class="table-responsive">
                        <table id="IDrsrslistRprtTbl" class="table table-bordered rsrslistRprtTbl">
                            <thead>
                                <tr>
                                    <th>Business Group</th>
                                    <th>Organization Unit</th>
                                    <th>Employee Role</th>
                                    <th>Employee Code</th>
                                    <th>Resource Name</th>
                                    <th>Phone</th>
                                    <th>Email ID</th>
                                    <th>Date of Joining</th>
                                    <th>Address</th>
                                    <th>City</th>
                                    <th>State</th>
                                    <th>Country</th>
                                    <th>Date of Birth</th>
                                    <th>Blood Group</th>

                                </tr>
                            </thead>

                            <tbody id="tblResourceListMain">
                                <tr>
                                    <td colspan="14">Please select filter and click on apply</td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                    <!--<div id="pagination" class="pull-right"></div>-->
                </div>


                <div class="ResourcelistRprtbyOU RsrsReportTblbox">
                    <div class="table-responsive">
                        <table id="IDrsrslistRprtTbl2" class="table table-bordered rsrslistRprtTbl">
                            <thead>
                                <tr>
                                    <th>Organization Unit</th>
                                    <th>Business Group</th>
                                    <th>Employee Role</th>
                                    <th>Employee Code</th>
                                    <th>Resource Name</th>
                                    <th>Phone</th>
                                    <th>Email ID</th>
                                    <th>Date of Joining</th>
                                    <th>Address</th>
                                    <th>City</th>
                                    <th>State</th>
                                    <th>Country</th>
                                    <th>Date of Birth</th>
                                    <th>Blood Group</th>

                                </tr>
                            </thead>
                            <tbody id="tblResourceListOUMain">
                                <tr>
                                    <td colspan="14">Please select filter and click on apply</td>
                                </tr>

                            </tbody>
                        </table>
                    </div>
                    <div id="pagination" class="pull-right"></div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>



        <div class="clearfix"></div>
    </div>

    <!-- Save filter Modal start here-->
    <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Save Filter As</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
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
                                                <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn pull-right">Cancel</button>
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
    <!-- jQuery 2.1.4 -->
   <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
   --%> <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
   <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script>
        var NoDataFound = "No data found.";
        var TagID = '<%= m_TagId%>';
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var noOfRowsPerPage = 10;
        var strUrl = '';
        var ResourcelistTable;
        $(document).ready(function () {
            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            if (blnViewAccess == "True")
            {
                //Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
                BindPlaceholder("txtRLFilterBusinessGroupID", "Business Group");         
                BindPlaceholder("txtRLFilterPostID", "Role");         
                //End of Added By Chetan M. For Bind Filter Placeholder on 15 July 2021

                FillFilterOUForFilter(0);
                GetMaximumItemsToShowInList();
                var GroupBy = $('#RLonchangeBy').val();
                // $(".ResourcelistRprtbyOU").hide();
                $(".ResourcelistRprtbyBG").hide();
                // GetResourceListByBG(null,GroupBy);    
            } else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";
            }
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
        function FillFilterOUForFilter(params) {
            var strHTML = "";
            var BgID = $('#txtRLFilterBusinessGroupID').val();
            //Added by imran
            if (BgID == "") {
                BgID = 0;
            }
            //End of comment by imran 
            var objBGCODE = { BusinessGroupID: BgID }
            //if (BgID != "" && BgID > 0) {
            $.ajax({
                url: strUrl + '/api/RM_OpportunityRequest/GetOrgUnitForFilter',
                type: "POST",
                data: JSON.stringify(objBGCODE),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (objBGCODE) {
                        xhr.setRequestHeader("Params", encryptString(isJson(objBGCODE) ? objBGCODE : JSON.stringify(objBGCODE)));
                    }
                },
                success: function (data) {
                    //$("#cboOPRFilterLocationID").empty();
                   // strHTML += "<option value='0'></option>";
                    for (var i = 0; i < data.length; i++) {
                        var listComponent = data[i];
                        strHTML += ('<option value=' + listComponent.OUPoolID + ' >' + listComponent.Location + '</option>');

                    }
                    if (params != null && params > 0 && params != undefined)
                        $("#txtRLFilterLocationID").val(params);

                    $("#txtRLFilterLocationID").html(strHTML);
                     // Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
                    BindPlaceholder("txtRLFilterLocationID", "Organization Unit");    
                     //End of Added By Chetan M. For Bind Filter Placeholder on 15 July 2021
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
        function OnClickBGAndOU() {
            var GroupBy = $('#RLonchangeBy').val();
            console.log("GroupBy : ", GroupBy)
            if (GroupBy == "BG") {
                GetResourceListByBG(null, GroupBy);
                $(".ResourcelistRprtbyOU").hide();
                $(".ResourcelistRprtbyBG").show();
            }
            else if (GroupBy == "OU") {
                GetResourceListByOU(null, GroupBy);
                $(".ResourcelistRprtbyBG").hide();
                $(".ResourcelistRprtbyOU").show();
            }
            else {
                //GetResourceListByBG(null,GroupBy);
            }


        }

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
        //    $(".table").resize();
        //}).change();

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $(".table").resize();
        });

        $('.modal').on('show.bs.modal', function () {
            $(".table").resize();
        });
        $('.modal').on('show.bs.modal', function () {
            $(".table").resize();

        });

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
        function GetResourceListByBG(filterParams, ByBgOu) {
            var strHTML = "";
            //StartLoader("#body-ResourceList");
            var params = { RWhereClause: filterParams, ByOUBG: ByBgOu };
            $.ajax({
                url: strUrl + '/api/RR_ResourceList/GetResourceListByOUBG',
                type: "POST",
                data: JSON.stringify(params),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {  
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (params) {
                        xhr.setRequestHeader("Params", encryptString(isJson(params) ? params : JSON.stringify(params)));
                    }
                },
                success: function (data) {
                    var List = data;
                    console.log("List", List);
                    if (List.length > 0) {
                        if (ByBgOu == "BG") {
                            $.each(List, function (index, obj) {
                                strHTML += '<tr class="graybglight pgrow"><td colspan="14" class="text-left">' + obj.BusinessGroup + '</td></tr>'
                                $.each(obj.lstResourceReport, function (index, objrep) {
                                    strHTML += '<tr class="pgrow"><td class="text-left">&nbsp;</td><td class="text-center">' + objrep.Location + '</td><td class="text-center">' + objrep.RoleDescription + '</td><td class="text-center">' + objrep.EmployeeCode + '</td><td class="text-center">' + objrep.EmployeeName + '</td><td class="text-center">' + objrep.Phone + '</td><td class="text-center">' + objrep.EmailID + '</td><td class="text-center">' + objrep.JoiningDate + '</td><td class="text-center">' + objrep.Address + '</td><td class="text-center">' + objrep.City + '</td><td class="text-center">' + objrep.State + '</td><td class="text-center">' + objrep.Country + '</td><td class="text-center">' + objrep.BirthDate + '</td><td class="text-center">' + objrep.BloodGroup + '</td></tr>';
                                });
                            });
                        }
                    } else {
                        strHTML += '<tr><td class="text-center"colspan="14">' + NoDataFound + ' </td></tr>';
                    }

                    //$('#IDrsrslistRprtTbl').dataTable().fnDestroy();
                    $("#tblResourceListMain").html(strHTML);
                    //LoadPagination(data);
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
        function GetResourceListByOU(filterParams, ByBgOu) {
            var strHTML = "";
            //StartLoader("#body-ResourceList");
            var params = { RWhereClause: filterParams, ByOUBG: ByBgOu };
            $.ajax({
                url: strUrl + '/api/RR_ResourceList/GetResourceListByOUBG',
                type: "POST",
                data: JSON.stringify(params),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (params) {
                        xhr.setRequestHeader("Params", encryptString(isJson(params) ? params : JSON.stringify(params)));
                    }
                },
                success: function (data) {
                    var List = data;
                    if (List.length > 0) {
                        if (ByBgOu == "OU") {
                            $.each(List, function (index, obj) {
                                strHTML += '<tr class="graybglight pgrow"><td colspan="14" class="text-left">' + obj.Location + '</td></tr>'
                                $.each(obj.lstResourceReport, function (index, objrep) {
                                    strHTML += '<tr class="pgrow"><td class="text-left">&nbsp;</td><td class="text-center">' + objrep.BusinessGroup + '</td><td class="text-center">' + objrep.RoleDescription + '</td><td class="text-center">' + objrep.EmployeeCode + '</td><td class="text-center">' + objrep.EmployeeName + '</td><td class="text-center">' + objrep.Phone + '</td><td class="text-center">' + objrep.EmailID + '</td><td class="text-center">' + objrep.JoiningDate + '</td><td class="text-center">' + objrep.Address + '</td><td class="text-center">' + objrep.City + '</td><td class="text-center">' + objrep.State + '</td><td class="text-center">' + objrep.Country + '</td><td class="text-center">' + objrep.BirthDate + '</td><td class="text-center">' + objrep.BloodGroup + '</td></tr>';
                                });
                            });
                        }
                    }
                    else {
                        strHTML += '<tr><td class="text-center"colspan="14">' + NoDataFound + ' </td></tr>';

                    }

                    // $('#IDrsrslistRprtTbl').dataTable().fnDestroy();
                    $("#tblResourceListOUMain").html(strHTML);
                    //LoadPagination(data);
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
        function LoadPagination(data) {
            $.fn.DataTable.ext.pager.numbers_length = 5;
            ResourcelistTable = $('#IDrsrslistRprtTbl').dataTable({
                "dtat": data,
                "bFilter": false,
                //"retrieve": true,
                "fixedHeader": true,
                "lengthChange": false,
                "searching": false,
                "destroy": true,
                "sScrollY": (0.5 * $(window).height()),
                "iDisplayLength": noOfRowsPerPage,
                "bPaginate": true,
                "bJQueryUI": true,
                "bScrollCollapse": true,
                "bAutoWidth": true,
                "sScrollX": "100%",
                "sScrollXInner": "100%"
            });

        }
        //START FILTER
        function ApplyFilter() {
            var filterWhereClause2;
            var filter = "";
            currentFilterID = 0;
            var GroupBy = $('#RLonchangeBy').val();
            if (GroupBy == '0' || GroupBy == null || GroupBy == 'undefined' || GroupBy == "Invalid Date") {
                $("#RAonchangeBy").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select Group by.");
                return false;
            } else {
                var AllRLFilter = ["BusinessGroupID", "LocationID", "PostID"];
                //var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
                filterWhereClause2 = GenerateBasicFilterQuery("RL", AllRLFilter);

                if (GroupBy == "BG") {
                    GetResourceListByBG(filterWhereClause2, GroupBy);
                    $(".ResourcelistRprtbyOU").hide();
                    $(".ResourcelistRprtbyBG").show();
                }
                else {
                    GetResourceListByOU(filterWhereClause2, GroupBy);
                    $(".ResourcelistRprtbyOU").show();
                    $(".ResourcelistRprtbyBG").hide();
                }
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");
            }

        }

        function GenerateBasicFilterQuery(module, filterField) {
            try {
                var strqtext = "";
                var txtBoxvalue = 0;
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    // var strOp = $('#Cbo' + module + 'Filter' + filterField[i]).val();
                    var strTXT = $('#txt' + module + 'Filter' + filterField[i]).val();
                    if (strTXT != null && strTXT != 'undefined' && strTXT != "") {
                        strvalue = strTXT
                    }

                    if (filterField[i] == "BusinessGroupID" && strTXT != "") {
                        var asd = "tbl_PM_Employee.BusinessGroupID";

                        if (strqtext != "") strqtext += " AND ";
                        strqtext += asd + " = ";
                        strqtext += ' "' + strvalue + '"';
                    }
                    if (strvalue != "" && strvalue != undefined && strvalue != "0") {
                        if (filterField[i] == "LocationID" && strTXT != "") {
                            var asd = "tbl_PM_Employee.LocationID";

                            if (strqtext != "") strqtext += " AND ";
                            strqtext += asd + " = ";
                            strqtext += ' "' + strvalue + '"';
                        }
                    }

                    if (filterField[i] == "PostID" && strTXT != "") {
                        var asd = "tbl_PM_Employee.PostID";

                        if (strqtext != "") strqtext += " AND ";
                        strqtext += asd + " = ";
                        strqtext += ' "' + strvalue + '"';
                    }


                }

                strqtext = strqtext.replace('Over', '[Over]')
                strqtext = strqtext.replace(/'/g, "''");
                //strqtext = strqtext.replace(/"/g, "''");
                // console.log("strqtext", strqtext);
                return strqtext;
            }
            catch (ex) {
                //alert(ex.message);
            }
        }

        function ExportResourceListReport(filterParams) {
            var GroupBy = $('#RLonchangeBy').val();
            if (GroupBy == '0' || GroupBy == null || GroupBy == 'undefined' || GroupBy == "Invalid Date") {
                $("#RAonchangeBy").focus();
                validateflag = false;
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select Group by.");
                return false;
            } else {
                var filterParams1 =
                    {
                        RWhereClause: "",
                        ReportFormat: "",
                        ReportTab: "Project"
                    }

                var AllRLFilter = ["BusinessGroupID", "LocationID", "PostID"];
                filterWhereClause2 = GenerateBasicFilterQuery("RL", AllRLFilter);
                if (filterWhereClause2 != null && filterWhereClause2 != 'undefined') {
                    filterParams1.RWhereClause = filterWhereClause2;


                }
                var ReportsTab = $('#RLonchangeBy').val();

                filterParams1.ReportFormat = filterParams;
                filterParams1.ReportTab = ReportsTab;

                StartLoader("#body-ResourceList");
                $.ajax({
                    url: strUrl + '/api/RR_ResourceList/ExportDocument',
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
                        StopAjaxLoader("#body-ResourceList");
                    },
                    //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                    //error: function (err) {
                    //    console.log(err);
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //    StopAjaxLoader("#body-ResourceList");
                    //}
                     error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#body-ResourceList");
                }
                     //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                })
            }
        }
        //dynamically set height
        function resizeSection(tag) {
            var JStableOuter = $(window).height();
            //$('.JStableOuter > table, .PRweekdaytbl td::after').css({ 'height': JStableOuter - 215, "overflow-y": "auto" });

            var JStabledividerHeight = $(window).height();
            //$('.PRweekdaytbl td::after').css({ 'height': JStabledividerHeight - 215, "overflow-y": "auto" });
            $('.ResourcelistRprtbyBG .table-responsive').css({ 'height': JStableOuter - 240, "overflow-y": "auto" });
            $('.ResourcelistRprtbyOU .table-responsive').css({ 'height': JStableOuter - 240, "overflow-y": "auto" });
            ///$('.Resourcelis .dataTables_scrollBody').css({ 'height': JStableOuter - 240, "overflow-y": "auto" });

            //$(".PRweekdaytbl td::after").css({'height':JStableOuter});

        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });
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
