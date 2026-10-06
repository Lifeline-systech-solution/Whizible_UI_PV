<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_Certification.aspx.vb" Inherits="PbNIT.RM_Certification" %>


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
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
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

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        body#bodyCertification-Details {
            padding-right: 0 !important;
        }

        .Resourcedetailpanel {
            margin: 40px 15px 0;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px;
            min-height:60vh;
        }

            .Resourcedetailpanel:hover {
                cursor: auto;
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

        .dataTable > thead > tr > th[class*="sort"]:after {
            content: "" !important;
        }

        table.dataTable thead > tr > th.sorting_asc,
        table.dataTable thead > tr > th.sorting_desc,
        table.dataTable thead > tr > th.sorting,
        table.dataTable thead > tr > td.sorting_asc,
        table.dataTable thead > tr > td.sorting_desc,
        table.dataTable thead > tr > td.sorting {
            padding-right: inherit;
        }

        /*body#bodycCertification-Details {
            padding-right: 0 !important;
        }*/

        /*.alertify-notifier li {
            word-break: normal !important;
            white-space: normal !important;
            background-color: red !important;
        }

        .alertifySuccess li {
            word-break: normal !important;
            white-space: normal !important;
            background-color: darkseagreen !important;
        }

        .alertify-notifier .ajs-message {
            width: 500px !important;
            height: 60px;
            word-break: break-word;
            background-color: red !important;
        }*/

        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999 !important;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
            /*word-break: break-all;*/
        }

        .clsShowHide {
            display: none !important;
        }

        .filterpanel .issfilter_actiondropdown {
            float: right;
        }

        .issfilter_actiondropdown {
            float: right;
        }

        .filterpanel .MyFiltersdropdown li span i {
            font-size: 14px;
            cursor: pointer;
            padding: 9px;
        }

        .unsavedHeading {
            color: red;
            font-style: italic;
            font-weight: 900;
        }

        .unsavedText {
            color: red;
            font-style: italic;
        }

        .editFilter {
            color: #1359a6;
            border: 1px;
            border-style: dotted;
            background: aliceblue;
        }

        .issuefilter_container .filterpanelbody {
            background: #ffffff;
        }

        .preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;
            /* border: 3px solid #ababab; */
            /* box-shadow: 1px 1px 10px #ababab; */
            border-radius: 15px;
            background: #ddd;
            /* background-color: white; */
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;
            /* background: url(../../../Whizible2.0-new/dist/img/loading.gif) rgba( 255, 255, 255, .8 ) 100% 100% no-repeat; */
            width: 100px;
            height: 100px;
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
        }

        .clTextCenter {
            text-align: center;
        }

        .clTextLeft {
            text-align: left;
        }

        .clTextRight {
            text-align: right;
        }

        .clsFilterHighlight {
            background: #1359a6 !important;
            color: #ffffff !important;
        }

        .btnrow {
            margin-top: 20px;
        }

         .filter button[aria-expanded="true"] {
            background: NONE;
            color: #4263c1;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }
.table thead tr th:last-child{ padding-right:8px!important;}/*Added by pradip on 14-7-21*/
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" >
    <div id="bodyCertification-Details"></div>
    <div class="bgwhite">
        <div class="container-fluid pt-1 pb-1 mb-0 text-right graybg" style="display:table">
            <h5 class="pgtitle pull-left">Certification</h5>
       
            <a href="javascript:;" class="mainclearalllink" onclick="closeFilterPanel()" data-bs-toggle="tooltip" data-placement="bottom" title=""><strong>Clear All</strong></a>
            <div class="filter inline pull-right">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-bs-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
            </div>
        </div>
        <!--filter panel-->
        <div id="filterpanel" class="filterpanel collapse">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                <div class="cust_tabpanel">
                    <ul class="nav nav-tabs">
                        <li class="dropdown">
                            <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false">My Filters  <span class="caret"></span></a>
                            <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                            </ul>
                        </li>
                        <li class="">
                            <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true">Basic Filters</a>
                        </li>


                    </ul>
                </div>

                <div class="Fwrapper">
                    <div class="tab-content">
                        <div id="basicfilters" class="tab-pane stackbasicfilter">
                            <div class="filterpanelbody">
                                <div class="text-center hidden-xs centerbtn">
                                    <button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" onclick="checkFiltervalidationForCRT();">Save and Apply</button>
                                    <button class="btn btnyellow" onclick="ApplyFlter()">Apply</button>
                                </div>
                                <br />

                                <div class="row">
                                    <div class="col-sm-5">
                                        <label>Certification</label>
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <select class="form-control input-sm" id="cboCRTFilterCertificationName">
                                                    <option value="Contains">Contains</option>
                                                    <option value="Ends With">Ends With</option>
                                                    <option value="Exact Word">Exact Word</option>
                                                    <option value="Not Contains">Not Contains</option>
                                                    <option value="Starts With">Starts With</option>
                                                </select>
                                            </div>
                                            <div class="col-sm-6 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtCRTFilterCertificationName", "txtCRTFilterCertificationName", "form-control input-sm", ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        &nbsp;
                                    </div>
                                </div>

                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>
        <!--end filter panel-->

           <div class="container-fluid pt-1 pb-1 text-right" style="display:table">
           <a href="javascript:;" class="btn borderbtn backbtn mr-1" data-bs-toggle="tooltip" id="AddCRT" data-bs-placement="bottom" title="Add Certification" onclick="EnableCertificationlist();"><span data-bs-toggle="modal" data-bs-target="#AddCertModal"><i class="fa fa-plus" aria-hidden="true"></i>Add </span></a>
            <button class="btn borderbtn mr-5" id="DeleteCRT" onclick="DeleteCertificationDetailsAfterConfirm();" title="Delete" data-bs-toggle="tooltip" data-placement="bottom">Delete</button>
            <%--Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
               <%--<a href="RM_ResourcePlanIndex.aspx" class="btn borderbtn backbtn" id="" data-bs-toggle="tooltip" data-placement="bottom" data-container="body" title="Back To Resource Plan">Back</a>--%>
          <%--End of Commented By Rutuja D. on 1 July 2021 For Hide Back Button--%>
           </div>
             
        <div class="content pt-1">
            <table class="table table-bordered" style="width: 100%;" id="tblcertification">
                <thead>
                    <tr>
                        <th class="text-left">Certification Name</th>
                        <th width="50">
                            <div class="custom_chckbox">
                                <input id="RCertificationListcheck0" class="chckHead" type="checkbox">
                                <label for="RCertificationListcheck0"></label>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="tblRCertification">
                </tbody>
            </table>
        </div>

        <div class="clearfix"></div>
    </div>


    <!--add modal start here-->
    <div class="modal custmodal fade" id="AddCertModal" aria-hidden="true">
        <input type="hidden" id="hdnCERT_UniqueIDTab" name="hdnCERT_UniqueIDTab">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Certification</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label class="required">Certification Name</label>
                        <% 'CommonFunctions.HTMLControls.DrawTextBox("txtCertification", "idtxtCertification", cssClass:="form-control", widthInPixel:=0, maxLength:=50,ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>
                        <% CommonFunctions.HTMLControls.DrawTextBox("txtCertification", "idtxtCertification", cssClass:="form-control", widthInPixel:=0, maxLength:=50, ToBeInserted:=" ") %>
                    </div>
                    <br />
                    <div class="text-center">
                        <button class="btn borderbtn" data-bs-dismiss="modal">Close</button>
                        <button class="btn btnyellow" onclick="SaveCertificationDetails(0);">Save</button>
                        <button class="btn btnyellow" id="btnSaveDetails" onclick="SaveCertificationDetails(1);">Save And Add</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--Add modal end here-->

    <!--add FILTER start here-->
    <div class="modal custmodal CertificationSavefilter_filter fade" id="CertificationSavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modalsmall ui-draggable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Save Filter As</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="cancelsaveapply();">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="CRTSavefilterfilterbox" class="box-panel">

                        <div class="box-body graybg">
                            <div class="form-group mb-0">
                                <div class="row">
                                    <div class="col-md-12 row">
                                        <label class="control-label col-md-4 p-0 text-right required">Filter Name :</label>
                                        <span class="col-md-8">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtCRTFilterName", "txtCRTFilterName", "form-control",, maxLength:=100, ToBeInserted:=" onkeypress='return AvoidSpace(this)'") %>
                                            <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtCRTFilterName", "txtCRTFilterName", "form-control",,,,,, ,,,,,,, True,,,,) %>--%>
                                            <div class="btnrow">
                                                <button class="btn btnyellow pull-left savefilter" id="btnSaveFilter" onclick="SaveCRTFilterDetails()">Save</button>
                                                <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn pull-right" onclick="cancelsaveapply()">Cancel</button>
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
    <!--Add FILTER end here-->

    <!--Delete confirm modal start here-->
    <div class="modal custmodal fade" id="DeleteConfirmMModal" aria-hidden="true">
        <div class="modal-dialog" role="document" style="width: 400px;">
            <div class="modal-content">
                <div class="modal-header">
                <h5 class="modal-title" id="">Delete Status</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <%-- <div class="form-group row">
                       <strong>Note:</strong>  Manager with Primary Responsible can not be deleted.
                    </div>--%>
                    <div class="notebox">
                        <strong>Note:</strong>  Certification which is in use cannot be deleted.<br />
                        <p id="showdeleterow"></p>
                    </div>

                    <div class="text-right">
                      <%--  <button class="btn btnyellow" onclick=" DeleteCertificationDetailsAfterConfirm()">Yes</button>--%>
                        <button class="btn borderbtn" data-bs-dismiss="modal">Ok</button>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!--delete modal end here-->
   
     <%--Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021--%>     
    <div id="deleteConfirmAlert" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true">
                        <div class="modal-dialog modalsmall ui-draggable">
                            <!-- Modal content-->
                            <div class="modal-content">
                                <div class="modal-header ui-draggable-handle">
                                    <button type="button" class="close" data-bs-dismiss="modal">×</button>
                                    <h4 class="modal-title">Delete Confirmation</h4>
                                </div>
                                <div class="modal-body">
                                    <input type="text" id="DFilterID" hidden="hidden" />
                                    <input type="text" id="DFilterName" hidden="hidden" />
                                    <input type="text" id="DIsApplyed" hidden="hidden" />
                                    <p id="deleteConfirmMsg"><center>Are you sure to delete the selected filter?</center></p>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn borderbtn pull-left uncheckbtn" data-bs-dismiss="modal">No</button>
                                    <button class="btn btnyellow" data-bs-toggle="modal" data-original-title="" data-bs-dismiss="modal" title="" onclick="confirmDelete()">Yes</button>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>    
       <%--End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021--%>
    
    
    <!-- REQUIRED JS SCRIPTS -->
    <!-- Bootstrap -->
   <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
   <%-- <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script> 
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>
    <script>
        //Remove tooltip Script added By Madhuri.K On 20-Aug-2024 Start here
        $('body').on('click', function () {
            $('.tooltip').remove();
        });
          //Remove tooltip Script added By Madhuri.K On 20-Aug-2024 End here

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();
		 //Added By Riddhesh Patil on 07-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of  Added By Riddhesh Patil
        var DeleteRecord = "Please select at least one record to delete.";
        var DeleteConfirm = "Are you sure, you want to delete the selected records?";
        var NoDataFound = "No data found.";
        var currentFilterID = 0;
        var currentDefaultFilterID = 0;
        var savedFilterName = ""
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';

        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var tableRisk = '';
        var tableHistoryRisk = '';
        var tablePlanRisk = '';
        var tableEarlyWarningRisk = '';
        var tableDocumentRisk = '';
        var tableMatrixRisk = '';
        var blnCreateContingencyTask = false;
        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var TagID = '<%= m_TagId%>';
        var strUrl = '';

        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';
        var noOfRowsPerPage = 10;

        var certificationTable;
        $(document).ready(function () {
            strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';

            if (blnAddAccess == "False") {
                $("#AddCRT").addClass("clsShowHide");
                $('#btnSaveDetails').attr("disabled", true);
            }
            else {
                $("#AddCRT").removeClass("clsShowHide");
                $('#btnSaveDetails').attr("disabled", false);
            }
            if (blnDeleteAccess == "False") {
                $("#DeleteCRT").addClass("clsShowHide");
            }
            else {
                $("#DeleteCRT").removeClass("clsShowHide");
            }            
            if (blnViewAccess == "True") {
                GetGetMaximumItemsToShowInList();
                GetMyCRTFilter(0);
                if (currentDefaultFilterID > 0) {
                    ApplySavedFilter(currentDefaultFilterID, 2);

                } else {
                    GetCertificateDetails(null);
                    FilterNotApplied();
                }
            }else {
                window.location.href = "../../NewAPI/Resources/UnauthorizePage.aspx";

            }
        });


        function EnableCertificationlist() {
            $('#idtxtCertification').attr("disabled", false);
            $('#btnSaveDetails').attr("disabled", false);
            $('#hdnCERT_UniqueIDTab').val(0);
            $('#idtxtCertification').val("");
            $('#AddCertModal').prop('checked', false);
        }

        $('#tblRCertification').on('click', '.clEditCertificationlink', function () {
            //var isCheckOrNOt = "No";
            //CurrentGRPTabObject = { Details: 'false', GrpManager: 'false', RoleGraph: 'false' };
            var $row = $(this).closest("tr");
            $tds = $row.find("td");
            $.each($tds, function (index, obj) {

                var hiddenField = $(this).find("#hdn_CertificationID").val();                
                if (hiddenField != 'undefined' && hiddenField != null) {
                    var eventId = hiddenField;
                   //alert(eventId);
                    $('#hdnCERT_UniqueIDTab').val(eventId);
                    $('#idtxtCertification').val($(this).text());
                    //$('#btnSaveDetails').attr("disabled", true);
                    //alert("ABCD111" + $('#hdn_VisaTypeId').html(eventId));
                }
                //if (index == 0) {
                //    $('#idtxtVisaType').val($(this).text());
                //    //alert("ABCD"+ $('#idtxtVisaType').val($(this).text()));
                //   }
                $('#AddCertModal').modal('show');
            });



        });

        function LoadPagination(data) {
            // console.log("console",data);
            //var businessGroupTable;
            $.fn.DataTable.ext.pager.numbers_length = 5;
            certificationTable = $('#tblcertification').dataTable({
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
                //Added by imran on 19-08-2022
                pageLength: 10,
                //End of comment by imran on 19-08-2022
                "aoColumnDefs": [{ 'bSortable': false, 'aTargets': [1] }]// Added By Pradip on 20 July 2021
            });

        }

        function GetGetMaximumItemsToShowInList() {
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
                        //Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                        //console.log(thrownError);
                        //alertify.set('notifier', 'position', 'top-right');
                        // alertify.notify(xhr.responseJSON.Message);

                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                        // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                

                    }
                    else {
                        // alertify.set('notifier', 'position', 'top-right');
                        // alertify.notify(thrownError);
                    }
                   
                    ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    //StopAjaxLoader("#bodyGlobal-Resource");
                }
            })

        }

        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);

        function resizeSection() {
            var tblheight = $(window).height();
            $('.dataTables_scrollBody').css({ 'height': tblheight - 240, "overflow-y": "auto" });

            //var tblheight = $(window).height();
            //$('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 0);
        });

        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
        });

        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
       //  var selectedCertificate = [];
        $(".chckHead").change(function () {
            var allPages = certificationTable.fnGetNodes();
            if (allPages.length > 0) {
                var checked = $(this).is(':checked');
                if (checked) {
                    $('input[type="checkbox"]', allPages).prop('checked', true);
                    var rows = $("#tblcertification").dataTable().fnGetNodes();
                    for (var i = 0; i < rows.length; i++) {
                        SelectedEmpID.push(parseInt($(rows[i]).find("#hdn_CertificationID").val()));
                    }

                } else {
                    $('input[type="checkbox"]', allPages).prop('checked', false);
                    SelectedEmpID = [];
                }
            }
        });

        // Changing state of CheckAll checkbox
        //$(".chcktbl").click(function () {

        //    if ($(".chcktbl").length == $(".chcktbl:checked").length) {
        //        $(".chckHead").prop("checked", true);
        //    } else {
        //        $(".chckHead").removeAttr("checked");
        //    }

        //});
        
        function checkUncheck() {

            if (certificationTable.$('input:checked').length == certificationTable.fnGetNodes().length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
                $(".chckHead").prop("checked", false);
            }
        }


         function cancelsaveapply() {
              if (currentFilterID == 0 || currentFilterID == null || currentFilterID == undefined || currentFilterID=="") {
              $('#txtCRTFilterName').val("");
            }
        }

        function GetCertificateDetails(CRTFilterParms) {
            //Added by imran on 19-08-2022
            if (CRTFilterParms == null || CRTFilterParms == "null" || CRTFilterParms == "") {
                var CRTFilterParms =
                {
                    CRTWhereClause: ""
                }
            }
            //End of comment by imran on 19-08-2022
             SelectedEmpID = [];
            var strHTML = "";
            StartLoader("#bodyCertification-Details");
            $.ajax({
                url: strUrl + '/api/RM_Certification/GetCertificateDetails',
                type: "POST",
                data: JSON.stringify(CRTFilterParms),
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (CRTFilterParms) {
                        xhr.setRequestHeader("Params", encryptString(isJson(CRTFilterParms) ? CRTFilterParms : JSON.stringify(CRTFilterParms)));
                    }
                },
                success: function (data) {
                    var certificateList = data;
                    //console.log("certificateList", certificateList);
                    if (certificateList.length > 0) {
                        $.each(certificateList, function (index, obj) {
                            if (blnEditAccess == "True") {
                                strHTML += '<tr><td class="text-left"> <a href="javascript:;" class="clEditCertificationlink"</a>' + obj.CertificationName + '<input type="hidden" name="hdn_CertificationID" id="hdn_CertificationID" value= ' + obj.CertificationID + '></td><td><div class="custom_chckbox"><input id="'+index+'" onclick="checkUncheck();GetSelectedCertification(this);" class="chcktbl" type="checkbox"><label for="'+index+'"></label></div></td></tr>';
                            }
                            else {
                                strHTML += '<tr><td class="text-left">' + obj.CertificationName + '<input type="hidden" name="hdn_CertificationID" id="hdn_CertificationID" value= ' + obj.CertificationID + '></td><td><div class="custom_chckbox"><input id="'+index+'" onclick="checkUncheck();GetSelectedCertification(this);" class="chcktbl" type="checkbox"><label for="'+index+'"></label></div></td></tr>';
                            }
                        });
                    }
                    //else {
                    //    strHTML += '<tr><td class="text-center" colspan="6">' + NoDataFound + '</td></tr>';
                    //}
                    $('#tblcertification').dataTable().fnDestroy();
                    $("#tblRCertification").html(strHTML);
                    LoadPagination(data);
                    StopAjaxLoader("#bodyCertification-Details");
                     $(".chckHead").prop("checked", false);
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    //StopAjaxLoader("#bodyCertification-Type");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
            
            })

        }
        function clearCertificationDetail() {
            $("#hdnCERT_UniqueIDTab").val(0);
            $("#idtxtCertification").val("");
            Details = {};
        }

        function SaveCertificationDetails(isFromSaveAndclick) {
            var certificationName = $("#idtxtCertification").val().replace(/'/g, "''");
            //alert(certificationName);
            if (certificationName != "") {
                if (checkSpecialCharacter(certificationName, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Certification Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#idtxtCertification").focus();
                    return false;
                }
            }
             if (certificationName.length > 0 && certificationName != ' ') {
                var certificationId = $("#hdnCERT_UniqueIDTab").val();
                var Details = {
                    CertificationID: certificationId > 0 ? certificationId : 0,
                    CertificationName: certificationName,
                    CreatedBy: encodeURI(UserName)

                };
                //console.log("Details", Details);           
                $.ajax({
                    url: strUrl + '/api/RM_Certification/SaveCertificationDetails',
                    method: 'Post',
                    data: JSON.stringify(Details),
                    dataType: 'json',
                    //async: false,
                    contentType: "application/json;charset-utf=8",

                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Details) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Details) ? Details : JSON.stringify(Details)));
                        }
                    },
                    success: function (data) {
                        if (isFromSaveAndclick == 0) {
                            if (data == "Certification Name already exist.") {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }                             
                            else {
                                $('#AddCertModal').modal('hide');
                                alertify.set('notifier', 'position', 'top-right');
                                setTimeout(function () { //Added By Rutuja For Alert Not Read in Script Testing. on 25 Nov 2021
                                    alertify.success(data);
                                }, 1000);
                                GetCertificateDetails();
                            }
                        }
                        else {
                            if (data == "Certification Name already exist.") {

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error(data);
                            }
                            else {
                                clearCertificationDetail();
                                $('#AddCertModal').modal('show');
                                alertify.set('notifier', 'position', 'top-right');
                                setTimeout(function () { //Added By Rutuja For Alert Not Read in Script Testing. on 25 Nov 2021
                                    alertify.success(data);
                                }, 1000);
                                GetCertificateDetails();
                            }
                        }
                        //  clearCertificationDetail();
                        //StopAjaxLoader("#bodyGlobal-Resource");
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                

                        }
                        else if (xhr.statusText == "Created" || xhr.statusText == "Updated") {
                            //CurrentGRPTabObject.GrpManager = 'false';
                            GetCertificateDetails();
                            // CurrentGRPTabObject.GrpManager = 'true';
                            StopAjaxLoader("#bodyCertification-Details");
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(thrownError);

                        }
                        ///window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        StopAjaxLoader("#bodyCertification-Details");
                        //if (isFromSaveAndclick == 0) {
                        //    $('#AddCertModal').modal('hide');
                        //}
                    }
                })
            }
            else {
                   $("#idtxtCertification").focus();
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Certification Name is mandatory");
                }
        }

        var SelectedEmpID = [];
        //var selectedCertificationUniqueId = '';
        function GetSelectedCertification(currentObject) {
           // debugger;
                var row = $(currentObject).closest("tr");
                if (row.find('input[type="checkbox"]').is(':checked')) {
                    SelectedEmpID.push(parseInt(row.find('#hdn_CertificationID').val()));
                }
                else {
                    if (SelectedEmpID != 'undefined' && SelectedEmpID.length > 0) {
                        var removeEmp = row.find('#hdn_CertificationID').val();
                         SelectedEmpID.remove(parseInt(removeEmp));
                        //SelectedEmpID.remove(removeEmp);
                    }
                }
        }
            
         Array.prototype.remove = function() {
                var what, a = arguments, L = a.length, ax;
                while (L && this.length) {
                    what = a[--L];
                    while ((ax = this.indexOf(what)) !== -1) {
                        this.splice(ax, 1);
                    }
                }
                return this;
        };

        function DeleteCertificationDetailsAfterConfirm() {
            var strHTML = "";
            var selectedCertificationUniqueId = SelectedEmpID.toString();
            if (selectedCertificationUniqueId.length > 0) {
                $.ajax({
                    url: strUrl + '/api/RM_Certification/DeleteCertificationDetails',
                    type: "POST",
                    data: JSON.stringify(selectedCertificationUniqueId),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        StartLoader("#bodyCertification-Details");
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (selectedCertificationUniqueId) {
                            xhr.setRequestHeader("Params", encryptString(isJson(selectedCertificationUniqueId) ? selectedCertificationUniqueId : JSON.stringify(selectedCertificationUniqueId)));
                        }
                    },
                    success: function (data) {
                        //if (data != "") {
                        //    alertify.set('notifier', 'position', 'top-right');
                        //    alertify.error(data);
                        //}

                        StopAjaxLoader("#bodyCertification-Details");
                        GetCertificateDetails();
                         //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        //strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could NOT be deleted.';
                        strHTML += '<strong>' + data.deletedCount + '</strong> Record(s) Deleted Successfully. </br><strong>' + data.notDeletedCount + '</strong> Record(s) Could Not be deleted.';
                         //Added & Commented By Dipali V On 1st Feb 2022 For Validation Alert Change
                        $('#showdeleterow').html(strHTML);
                        $('#DeleteConfirmMModal').modal('show');
                    },
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                            //console.log(thrownError);
                            //alertify.set('notifier', 'position', 'top-right');
                            //alertify.error(xhr.responseJSON.Message);
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                            // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                        }
                        else if (xhr.statusText == "OK") {  //200
                            GetCertificateDetails();
                            $('#DeleteConfirmMModal').modal('hide');
                            //alertify.set('notifier', 'position', 'top-right');
                            // alertify.notify("Deleted");
                        }

                        StopAjaxLoader("#bodyCertification-Details");
                        $('#DeleteConfirmMModal').modal('hide');
                    }
                })
            } else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error(DeleteRecord);
                return false;
            }
            SelectedEmpID = [];
            selectedCertificationUniqueId = "";
        }

        //fILTER
        function GenerateCRTBasicFilterQuery(module, filterField) {
            try {
                var strqtext = "";
                for (var i = 0; i < filterField.length; i++) {
                    var strvalue = '';
                    var strOp = $('#cbo' + module + 'Filter' + filterField[i]).val();
                    // var strOp = $('#cbo' + module + 'Filter' + filterField[i] + ' option:selected').val();
                    //alert($("#txt" + module + "Filter" + filterField[i]));
                    strvalue = $("#txt" + module + "Filter" + filterField[i]).val();

                    // strvalue = $("#txtBGFilterBgGroupName").val();
                     //Added By Chetan M on 28 July 2021 For IssueID = 29339
                    strvalue = strvalue.replace(/"/g, '""');
                    //End of Added By Chetan M on 28 July 2021 For IssueID = 29339
                    if (strvalue != "" && strvalue != undefined && strvalue != "0") {

                        if (strqtext != "") strqtext += " AND ";
                        if (strOp == "Contains") {

                            strqtext += filterField[i] + " LIKE ";
                            //strqtext += " ''%" + strvalue + "%''";
                            //Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                            //strqtext += ' "%' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                               // strqtext += ' "%`' + strvalue + 
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "%' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "%' + strvalue + '%"';
                            }
                            //End of Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                        }
                        else if (strOp == "Ends With") {
                            strqtext += filterField[i] + " LIKE ";
                            // strqtext += " ''%" + strvalue + "''";
                            //Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                            //strqtext += ' "%' + strvalue + '"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                //strqtext += ' "%`' + strvalue + '"';
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' "%' + strvalue + '"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "%' + strvalue + '"';
                            }
                            //End of Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                        }
                        else if (strOp == "Exact Word") {
                            strqtext += filterField[i] + " = ";
                            //strqtext += " ''" + strvalue + "''";
                            strqtext += ' "' + strvalue + '"';
                        }
                        else if (strOp == "Not Contains") {
                            strqtext += filterField[i] + " ";
                            //strqtext += " NOT LIKE ''%" + strvalue + "%''";
                             //Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                            //strqtext += ' NOT LIKE "%' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                strqtext += ' NOT LIKE "%' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' NOT LIKE "%' + strvalue + '%"';
                            }
                            //End of Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                        }
                        else if (strOp == "Starts With") {
                            strqtext += filterField[i] + " LIKE ";
                            // strqtext += " ''" + strvalue + "%''";
                             //Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                            //strqtext += ' "' + strvalue + '%"';
                            if (strvalue.indexOf('_') > -1 || strvalue.indexOf('%') > -1) {
                                strvalue = strvalue.replace(/%/g, "`%");
                                strvalue = strvalue.replace(/_/g, "`_");
                                 strqtext += ' "' + strvalue + '%"';
                                strqtext += ' escape "`"';
                            } else {
                                strqtext += ' "' + strvalue + '%"';
                            }
                            //End of Commented & Added By Chetan M on 28 July 2021 For IssueID = 29339
                        }
                        else {

                            strqtext += filterField[i] + " ";
                            if ($.isNumeric(strvalue) == false) {
                                strqtext += strOp + " ''" + strvalue + "''";
                            }
                            else {
                                strqtext += strOp + " " + strvalue + "";
                               // strqtext += strOp + ' "' + strvalue + '"';
                            }
                        }
                    }
                }

                strqtext = strqtext.replace('Over', '[Over]')
                strqtext = strqtext.replace(/'/g, "''");
                //strqtext = strqtext.replace(/"/g, "''");
                return strqtext;
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        function setfiltervalues(QueryText) {

            var currWhereClause = QueryText.toString().trim();

            currValue = currWhereClause.toString().trim();
            if (currValue.substring(currValue.length - 1) == ")") {
                currValue = currValue.substring(0, currValue.length - 1);
            }
            if (currValue.substring(0, 1) == "(") {
                currValue = currValue.substring(1);
            }
            currWhereClause = currValue;

            if (currWhereClause.indexOf("NOT LIKE") != -1) {
                currWhereClause = currWhereClause.replace("NOT LIKE", "notlike");
            }

            var str = currWhereClause;

            var regex = /'[^"]+'|[^\s]+/g;
            result = str.match(regex);

            var str = result.toString();
            var arr = str.match(/('.*?'|[^',\s]+)(?=\s*,|\s*$)/g);

            for (var i = 0; i < arr.length; i++) {
                //alert(arr[i]);
            }

            var arrFields = currWhereClause.split(" ");
            arrFields = str.match(/('.*?'|[^',\s]+)(?=\s*,|\s*$)/g);
            if (arrFields[0] == "CertificationName") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboCRTFilterCertificationName", "txtCRTFilterCertificationName");
            }
        }
        function setFilterComboValue(fieldName, fieldValue, flag) {
            //if (flag == undefined) {
            //    $("#" + fieldName).removeClass("selectpicker");
                $("#" + fieldName).val(fieldValue);
            //    $("#" + fieldName).addClass("selectpicker");
            //    $('.selectpicker').selectpicker('refresh');
            //}
            //if (flag == "class") {
            //    $("." + fieldName).removeClass("selectpicker");
            //    $("." + fieldName).val(fieldValue);
            //    $("." + fieldName).addClass("selectpicker");
            //    $('.selectpicker').selectpicker('refresh');
            //}
        }
        function setFilterOpComboFieldValue(currWhereClause, arrFields, OpComboName, ValueComboName) {
            if (arrFields[1] == "LIKE" && currWhereClause.indexOf("%'") != -1 && currWhereClause.indexOf("'%") != -1) {
                setFilterComboValue(OpComboName, "Contains");

            }
            if (arrFields[1] == "notlike") {
                setFilterComboValue(OpComboName, "Not Contains");
            }

            if (arrFields[1] == "=") {
                setFilterComboValue(OpComboName, "Exact Word");
            }

            if (arrFields[1] == "LIKE" && currWhereClause.indexOf("%'") != -1 && currWhereClause.indexOf("'%") == -1) {
                setFilterComboValue(OpComboName, "Starts With");
            }

            if (arrFields[1] == "LIKE" && currWhereClause.indexOf("%'") == -1 && currWhereClause.indexOf("'%") != -1) {
                setFilterComboValue(OpComboName, "Ends With");
            }

            var currValue = arrFields[2].replace("'%", "");
            currValue = currValue.replace("%'", "");
            currValue = currValue.toString().trim();
            if (currValue.substring(currValue.length - 1) == "'") {
                currValue = currValue.substring(0, currValue.length - 1);
            }
            if (currValue.substring(0, 1) == "'") {
                currValue = currValue.substring(1);
            }

            //Commented & added by mahesh on  27 july 2021
            //$("#" + ValueComboName).val(currValue);
            if (currValue == "") {
                $("#" + ValueComboName).val("'")
            } else {
                $("#" + ValueComboName).val(currValue);
            }
        }

        function ClearFilterDetails(flag) {
            if ($("#cboCRTFilterCertificationName").val() != "Contains") {
                setFilterComboValue("cboCRTFilterCertificationName", "Contains");
            }
            if ($("#txtCRTFilterCertificationName").val() != "") {
                $("#txtCRTFilterCertificationName").val("");
            }

            savedFilterName = "";

            if (flag == "") {
                $('*[id*=RiskselproOne_]').each(function () {

                    $(this).removeAttr("checked");
                });
            }

        }
        function clearTooltip() {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });
        }

        function FilterApplied() {
            $(".mainclearalllink").removeClass("clsShowHide");
            $(".filter >  button").addClass("clsFilterHighlight");
        }

        function FilterNotApplied() {
            $(".mainclearalllink").addClass("clsShowHide");
            $(".filter >  button").removeClass("clsFilterHighlight");
            $('#AdvanceFilterIcon').attr("aria-expanded", false);
        }

        function BindBasicFilters(qtext, module) {
            ClearBasicFilter(module);
            var isAnd = qtext.indexOf(' AND ');
            if (isAnd > 0) {
                var rowsAnd = qtext.split(' AND ');
                for (i = 0; i < rowsAnd.length; i++) {
                    BindBasicFilterValues(rowsAnd[i], module);
                }
            }
            else {
                BindBasicFilterValues(qtext, module);
            }
        }

        function BindBasicFilterValues(qtext, module) {
            //debugger
            var field = qtext.substr(0, qtext.indexOf(' '));
            var op = orgop = "";
            var val = valstr = "";

            var opstr = qtext.substr(qtext.indexOf(' '), qtext.length).trim();
            var opchar = opstr.substr(0, 1);
            if (opchar == "N" || opchar == "L") {
                if (opchar == "N") {
                    op = "Not Contains";
                    orgop = "NOT LIKE";
                    valstr = opstr.substr(orgop.length, opstr.length).trim();
                    val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 4);
                }
                if (opchar == "L") {
                    orgop = "LIKE";
                    valstr = opstr.substr(orgop.length, opstr.length).trim();
                    if (valstr.indexOf('%') == 1) {
                        if (valstr.substr(2, valstr.length).indexOf('%') > 0) {
                            op = "Contains";
                            val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 4);
                        }
                        else {
                            op = "Ends With";
                            val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 3);
                        }
                    }
                    else {
                        op = "Starts With";
                        val = valstr.substr(1, valstr.length - 3);
                    }
                }
            }
            else {
                op = opstr.substr(0, opstr.indexOf(' '));
                valstr = opstr.substr(op.length, opstr.length).trim();
                val = valstr.substr(1, valstr.length - 2);
            }
            if (op == '=') {
                var cbo = "cbo" + module + "Filter" + field;
                if ($("#" + cbo + " option[value='" + op + "']").length == 0) {
                    op = "Exact Word"
                }
            }
            $('#cbo' + module + 'Filter' + field).val(op).change();
            $('#txt' + module + 'Filter' + field).val(val).change();
        }
        function OpenBasicFilter() {
            //Start Script for edit basic filter           
            $(".stackbasicfilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("open");
            //End Script for edit basic filter
        }
        $(".mainclearalllink").click(function () {
            $(".filter").removeClass("active");
            //$('.filterpanel').collapse('toggle');                

            FilterNotApplied();
            $(".filter").removeClass("active");
            if ($('.filterpanel').hasClass("in")) {
                $('.filterpanel').removeClass("in");
            }
            $(".clsHideTooltip").each(function () {
                $(this).attr("data-original-title", "Apply filter");
            });
            $('[data-bs-toggle="tooltip"]').tooltip();

            fltPersonResponsible = "";
            currentappliedfilter = 0;
            currentFilterID = 0;
            currentappliedfilterclause = "";
            ClearFilterDetails("");
            GetCRTDetails(null);
            GetMyCRTFilter(0);//Added By Mahesh on 21 July 2021
        });

        function ApplyFlter() {
            currentFilterID = 0;
            if ($('#txtCRTFilterCertificationName').val() == "" && $('#txtCRTFilterCertificationName').val() == "" || $('#txtCRTFilterCertificationName').val() == " ") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
            } else {
                var filter = "";
                //if (filterwhereclause != 'undefined' && filterwhereclause != null) {
                var AllCRTFilter = ["CertificationName"];
                var filterWhereClause2 = GenerateCRTBasicFilterQuery("CRT", AllCRTFilter);
               // var filterWhereClause = (filterWhereClause2.replace(/'/g, "''")).replace(/"/g, "\''");
                 var filterWhereClause = (filterWhereClause2).replace(/"/g, "\'");
                //filterWhereClause = (filterWhereClause2.replace(/'/g, "''")).replace(/"/g, "\''");
                filter = { UniqueID: '0', CRTWhereClause: encodeURIComponent(filterWhereClause) }
                FilterApplied();
                //}

                //SaveBGFilterDetails();
                GetCertificateDetails(filter);
                 alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter applied successfully.");

            }

        }

        function GetCRTDetails(whereClause) {
            var filter = "";
            if (whereClause != null) {
                // var whereClauseFormated = whereClause.replace(/'/g, "\''");
                filter = { UniqueID: '0', CRTWhereClause: encodeURIComponent(whereClause) };
            }
            GetCertificateDetails(filter);
        }
        //FILTER VALIDATION
         function checkFiltervalidationForCRT()
         {
            var CRTname = $("#txtCRTFilterCertificationName").val() == "" ? null:$("#txtCRTFilterCertificationName").val();
             //alert(CRTname);
            if ((CRTname == null || CRTname == 'undefined' || CRTname == " "))
            {                
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Apply filter on at least one field');
                $('#CertificationSavefilter').modal('hide');
            }
            else {                
                $('#CertificationSavefilter').modal('show');
            }
        }
        function AvoidSpace(input) {
            if (/^\s/.test(input.value))
                input.value = '';
        }
        var savedFilterName = "";
        function SaveCRTFilterDetails() {
            //alert("HJHJDF");
            var fltFilterName = $("#txtCRTFilterName").val();
            //debugger;
            //$('#BgSavefilter').modal('show');
            // $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            if (fltFilterName == ""|| fltFilterName == " ") {
                //$('#BgSavefilter').modal('show');
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Please enter Filter Name');
                $('#CertificationSavefilter').modal('show');

                $("#txtCRTFilterName").focus();

                //return false
            }
            //else if ($("#txtCRTFilterName").val().trim().match(/[/\:*?<>|,"+-]/)) {
            //    $("#txtCRTFilterName").focus();
            //       $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            //    alertify.set('notifier', 'position', 'top-right');
            //    setTimeout(function () { //Added By Rutuja For Alert Not Read in Script Testing. on 25 Nov 2021
            //        alertify.error('Filter name cannot contain any of these /\:*?<>|,"+- characters.');
            //    }, 2000);
            //}
            else if (checkSpecialCharacter($("#txtCRTFilterName").val().trim(), WebConfigSpecialCharacters) == true) {
                $('#CertificationSavefilter').modal('show');
                $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtCRTFilterName").focus();

            }
            else {
                var filterExists = 0;
                //if (savedFilterName == "") {
                //    filterExists = ExistCRTFilter(fltFilterName);
                //    $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                //    $('#CertificationSavefilter').modal('show');
                //}

                //if (filterExists == 0) {
                //    $("#btnSaveFilter").attr("data-bs-dismiss", "modal");
                var AllCRTFilter = ["CertificationName"];
                //var isActiveFilter = 'True';/// $('#chkBgFilterIsActive').is(":checked");
                var filterWhereClause;
                var filterWhereClause2 = GenerateCRTBasicFilterQuery("CRT", AllCRTFilter);
                // var isActiveFilter = $('#chkBgFilterIsActive').is(":checked");
                //filterWhereClause2 += "AND Active=" + ' "' + isActiveFilter + '"';
                filterWhereClause = filterWhereClause2.replace(/"/g, "\'");

                var paramFilterID = 0;
                paramFilterID = currentFilterID;

                //if (currentFilterID != 0) {
                //    if (fltFilterName != savedFilterName) {
                //        paramFilterID = 0;
                //    }
                //}

                var paramFlag = 0;
                if (paramFilterID == 0) {
                    paramFlag = 0;
                }
                else {
                    paramFlag = 1;
                }

                var Parameters = {
                    TagID: encodeURI(TagID),
                    ProjectID: 0,
                    EmployeeID: encodeURI(SessionEmployeeId),
                    FilterName: encodeURI(fltFilterName),
                    LoginType: encodeURI(SessionLoginType),
                    CreatedBy: encodeURI(UserName),
                    WhereClause: encodeURIComponent(filterWhereClause),
                    Flag: encodeURI(paramFlag),
                    FilterID: encodeURI(paramFilterID)
                }


                $.ajax({
                    url: encodeURI(strUrl) + '/api/RM_MyFilter/SaveMyFilter',

                    method: 'Post',
                    data: JSON.stringify(Parameters),
                    dataType: "json",
                    async: false,
                    contentType: "application/json",  /*;charset-utf=8*/
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    success: function (data) {

                        if (data == "Filter name already exist") {
                            // alert(1);
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(data);
                            $("#btnSaveFilter").removeAttr("data-bs-dismiss");
                            // $('#OuSavefilter').modal('show');
                            // currentFilterID = 0;
                        }

                        else {
                            if (data != undefined && data != "") {
                                currentFilterID = data;
                                currentappliedfilter = currentFilterID;
                            }
                            $('#CertificationSavefilter').modal('hide');
                            //getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");
                            GetMyCRTFilter(0);
                            ApplyFlter();
                            FilterApplied();

                            savedFilterName = fltFilterName;
                            $("#txtCRTFilterName").val('');
                            //clearTooltip();
                            // ClearFilterDetails("");
                        }



                    },
                    // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                    //error: function (xhr, errorThrown) {
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    //},
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                    }
                    // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                

                });
                //}
            }
        }
        function GetMyCRTFilter(flag) {
            var Parameters = {
                ProjectID: 0,
                TagID: encodeURI(TagID),
                LoginType: encodeURI(SessionLoginType),
                EmployeeID: encodeURI(SessionEmployeeId)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/RM_MyFilter/GetMyFilters',
                method: 'POST',
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {
                    var strHTML = "";
                    var defaultFilterId = 0;
                    $("#MyFiltersdropdown").empty();
                    if ($("#MyFiltersdropdown").hasClass("dropdown-menu")) {

                    }
                    else {
                        $("#MyFiltersdropdown").addClass("dropdown-menu");
                    }

                    if (data.length != 0) {

                        for (var i = 0; i < data.length; i++) {
                            var ObjMyFilter = data[i];
                            strHTML += "<li>";
                            if (ObjMyFilter.SetDefault === true) {
                                defaultFilterId = ObjMyFilter.FilterId;
                                currentDefaultFilterID = defaultFilterId;

                                strHTML += "<label class='customradio'>";

                                strHTML += "<input class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-placement='bottom' id='" + ObjMyFilter.FilterId + "' type='radio' name='project2' onclick='SetDefaultFilter(this.id,&quot;default&quot;)' checked='checked'>";
                                strHTML += "<span data-bs-toggle='tooltip' data-placement='right' title='Remove Default filter' class='checkmark'></span>";
                                strHTML += "</label>";

                            }
                            else {
                                strHTML += "<label class='customradio'>";
                                strHTML += "<input class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-placement='bottom' id='" + ObjMyFilter.FilterId + "' type='radio' name='project2' onclick='SetDefaultFilter(this.id,&quot;&quot;)'>";
                                strHTML += "<span data-bs-toggle='tooltip' data-placement='right' title='Set Default filter' class='checkmark'></span>";
                                strHTML += "</label>";
                            }

                            strHTML += "<label class=''>";
                            strHTML += "<span for='project2' class='radiotextsty filtername'>" + ObjMyFilter.FilterName + "</span>";
                            strHTML += "</label>";

                            strHTML += "<div class='custom_chckbox_markblue'>";

                            var blnApply = false;
                            if (currentappliedfilter != 0 &&  flag!=3) {
                                if (currentappliedfilter == ObjMyFilter.FilterId) {
                                    blnApply = true;
                                }
                            }

                            if (ObjMyFilter.SetDefault == "True") {
                                strHTML += "<div class='custom_chckbox_markblue'>";

                                if (currentappliedfilter != 0 && flag!=3) {
                                    if (blnApply == true) {
                                        strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name='' >";
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                    }
                                    else {
                                        strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name='' >";
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                    }
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name='' >";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }

                                strHTML += "</div>";
                            }
                            else {
                                strHTML += "<div class='custom_chckbox_markblue'>";
                                if (blnApply == true) {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }
                            }

                            strHTML += "<span onclick='OpenBasicFilter()' class='edit_filter'>";

                            strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Edit filter' id='" + ObjMyFilter.FilterId + "' class='fas fa-pencil-alt' onclick='EditFilter(this.id);'></i>";

                            strHTML += "</span>";

                            strHTML += "<span>";
                            if (blnApply == true) {
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                               //strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id,3);'></i>";
                               strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;,3)></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                             }
                             else{
                                //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                              //strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id);'></i>";
                              strHTML += "<i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick=btnDeleteFilter(this.id,&quot;" + escape(ObjMyFilter.FilterName.replace(/'/g, "''")) + "&quot;)></i>";
                                //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
                             }

                            strHTML += "</span>";

                            strHTML += "</div>";

                            strHTML += "</li>";

                        }

                        $("#MyFiltersdropdown").html(strHTML);
                        if (strHTML != "" && defaultFilterId != 0 && flag != 0 && flag!=3) {
                            ApplySavedFilter(defaultFilterId, 1);
                        }
                        
                        $("#MyFiltersdropdown").removeClass("clsShowHide");
                    }
                    else {
                        $("#MyFiltersdropdown").addClass("clsShowHide");
                        $("#MyFiltersdropdown").removeClass("dropdown-menu");
                    }
                },
                //Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                //error: function (xhr, errorThrown) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                //},
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
           
            });
            clearTooltip();
        }

        function ExistCRTFilter(filtername) {

            var isFilterExists = 0;
            var Parameters = {
                FilterName: encodeURI(filtername),
                TagID: encodeURI(TagID),
                ProjectID: 0,
                EmployeeID: encodeURI(SessionEmployeeId),
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/RM_MyFilter/ExistMyFilter',
                method: 'POST',
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {

                    if (data == 0) {
                        isFilterExists = 0;
                    }
                    else if (data == 1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Filter already exit");
                        isFilterExists = 1;
                    }
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                //error: function (xhr, errorThrown) {
                //    isFilterExists = 1;
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                //},
                error: function (xhr, ajaxOptions, thrownError) {
                    isFilterExists = 1;
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
            });
            return isFilterExists;
        }

        //Delete filter
            //Commented & Added By Rutuja D. For Filter Issue on 7 July 2021
        //function DeleteFilter(FilterID,IsApplyed) {
        function DeleteFilter(FilterID, FilterName, IsApplyed) {
            //End of Commented & Added By Rutuja D. For Filter Issue on 7 July 2021
            $.ajax({
                url: strUrl + '/api/RM_MyFilter/DeleteMyFilter',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {
                    if (result == null) {
                        alertify.set('notifier', 'position', 'top-right');
                        //Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on 7 July 2021
                        //  alertify.success('Filter deleted successfully');
                        if (FilterName.indexOf("'") > -1) {
                            FilterName = FilterName.replace(/''/g, "'");
                        }
                        alertify.success("'" + FilterName + "'" + ' Filter deleted successfully');
                        //End of Commented & Added By Rutuja D. For Filter Delete Filter Name Display in Alert on 7 July 2021                        
                        if (IsApplyed == 3) {
                            GetCertificateDetails(null);
                        }
                        ClearFilterDetails("");
                        FilterNotApplied();
                        GetMyCRTFilter(0);
                        currentappliedfilter = 0;
                    }
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
            });
        }

        function EditFilter(FilterID) {
            savedFilterName = "";
            ClearFilterDetails("edit");
            $.ajax({
                url: strUrl + '/api/RM_MyFilter/EditMyFilter',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {

                    for (var i = 0; i < result.length; i++) {
                        var ObjFilterDtls = result[i];

                        var currentFilterName = ObjFilterDtls.FilterName;
                        currentFilterID = ObjFilterDtls.FilterId;
                        $("#txtCRTFilterName").val(currentFilterName);
                        savedFilterName = currentFilterName;
                        if (ObjFilterDtls.QueryText.toString().indexOf("AND") != -1) {

                            var arrFields = ObjFilterDtls.QueryText.split("AND");
                            try {
                                for (var i = 0; i < arrFields.length; i++) {
                                    setfiltervalues(arrFields[i]);
                                }
                            }
                            catch (ex) {
                                //alert(ex.message);
                            }
                        }
                        else {
                            var currWhereClause = ObjFilterDtls.QueryText.toString();
                            setfiltervalues(currWhereClause);
                        }//else                        
                    }
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
            });
        }

        //Apply saved filter
        //var currentappliedfilter = 0;
        //var currentappliedfilterclause = '';
        function ApplySavedFilter(FilterID, isDefault,isFromDefault) {
            //Changed  by mahesh on 21 july 2021 
            if (isFromDefault === undefined || isFromDefault == 'undefined' || isFromDefault == null) {
                isFromDefault = false;
            }
            if (isDefault == 3) {

                GetCRTDetails(null);
                GetMyCRTFilter(isDefault);
                FilterNotApplied();
                ClearFilterDetails(""); // Added By Reshma Chavan on 28th Jan 2022 for clearing filter
                $('#AdvanceFilterIcon').attr("aria-expanded", false);
                //added by mahesh on 21 july 2021
                if ((isFromDefault === false|| isFromDefault == 'false') && (isDefault == 3)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.success("Filter removed successfully.");
                }
            }


            if (isDefault == undefined || isDefault == 2) {
                currentappliedfilter = FilterID;
                $.ajax({
                    url: strUrl + '/api/RM_MyFilter/GetMyWhereClauseOfFilter',
                    method: 'POST',
                    data: JSON.stringify(FilterID),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                        if (FilterID) {
                            xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                        }
                    },
                    success: function (result) {
                        var Querytext = result;
                        if (Querytext != null) {
                            currentappliedfilterclause = Querytext;
                            GetCRTDetails(Querytext);
                        }
                        //Added By Reshma Chavan on 31st Jan 2022 for NOT displalying data after apply filter
                        if (Querytext.toString().indexOf("AND") != -1) {
                            var arrFields = Querytext.split("AND");
                            try {
                                for (var i = 0; i < arrFields.length; i++) {
                                    setfiltervalues(arrFields[i]);
                                }
                            }
                            catch (ex) {
                                //alert(ex.message);
                            }
                        }
                        else {
                            var currWhereClause = Querytext.toString();
                            setfiltervalues(currWhereClause);
                        }                      
                        //End of Added By Reshma Chavan on 31st jan 2022 for NOT displalying data after apply filter
                        FilterApplied();
                        if (currentDefaultFilterID > 0) {
                            FilterApplied();
                        }

                        if (currentDefaultFilterID == 0 || isDefault == undefined || isDefault == 2) {
                            GetMyCRTFilter(0);
                        }
                    },
                    // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                    //error: function (err) {
                    //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    //}
                    error: function (xhr, ajaxOptions, thrownError) {
                        if (ajaxOptions == "error") {
                            if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                                window.open("../../../Default.aspx", "_top");
                            } else {
                                window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                            }
                        }
                    }
                    // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                });
                if (isDefault == undefined) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Filter applied successfully.");
                }
            }

           
        }

        //To set the default filter.
        function SetDefaultFilter(FilterID, flag) {
            var removeDefault = 0;
            if (flag == "default") {
                removeDefault = 1;
            }
            var Parameters = {
                ProjectID: 0,
                LoginType: encodeURI(SessionLoginType),
                EmployeeID: encodeURI(SessionEmployeeId),
                TagID: encodeURI(TagID),
                FilterID: FilterID,
                Flag: removeDefault
            }

            $.ajax({
                url: strUrl + '/api/RM_MyFilter/SetMyDefaultFilter',
                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (result) {
                    alertify.set('notifier', 'position', 'top-right');
                    //alert(removeDefault);
                    if (removeDefault == 0) {
                        //alertify.success('Success');
                        // ApplySavedFilter(FilterID, 2);
                        ApplySavedFilter(FilterID, 2, true);//changed by Mahesh on 21 july
                        alertify.success('Filter Is Successfully Set As Default!');
                        $('#AdvanceFilterIcon').attr("aria-expanded", true);
                        FilterApplied();
                    }
                    else {
                        // alertify.success('Default');
                        // FilterNotApplied();
                        ApplySavedFilter(FilterID, 3, true);//changed by Mahesh on 21 july
                        alertify.success('Default Filter Is Successfully Removed!');
                        currentappliedfilter = 0;
                        $('#AdvanceFilterIcon').attr("aria-expanded", false);
                        FilterNotApplied();
                    }

                    GetMyCRTFilter(0);
                },
                // Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
                //error: function (err) {
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                //}
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                }
                // End of Commented & Integrate By Rutuja D. on 8 July 2021 for Session Expired Issue                
            });
        }

        //Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021
        function btnDeleteFilter(FilterID, FilterName, Flag) {
            FilterName = unescape(FilterName).trim();
            $('#DFilterID').val(FilterID);
            $('#DFilterName').val(FilterName);
            $('#DIsApplyed').val(Flag);
            $('#deleteConfirmAlert').modal('show');
        }

        function confirmDelete() {
            var FilterID = $('#DFilterID').val();
            var FilterName = $('#DFilterName').val();
            var FilterIsApplyed = $('#DIsApplyed').val();
            if (FilterIsApplyed == 3) {
                DeleteFilter(FilterID, FilterName, 3);
            } else {
                DeleteFilter(FilterID, FilterName);
            }
        }
        //End of Commented & Added By Rutuja D. For Filter Delete Issue on on 6 July 2021


        function closeFilterPanel() {
            $("#filterpanel").removeClass('show');
        }
        //function checkSpecialCharacter(value, WebConfigSpecialCharacters) {
        //    if (WebConfigSpecialCharacters != '') {
        //        var regularExpression = WebConfigSpecialCharacters;
        //        regularExpression += '"';
        //        var isSpecialCharacter = 0;
        //        for (var i = 0; i < regularExpression.length; i++) {
        //            if (value.indexOf(regularExpression[i]) != -1) {
        //                isSpecialCharacter = 1
        //            }
        //        }
        //        if (isSpecialCharacter == 1) {
        //            return true;
        //        }
        //        else {
        //            return false;
        //        }
        //    }
        //    else {
        //        return false;
        //    }
        //}
        function checkSpecialCharacter(value, WebConfigSpecialCharacters) {
            if (WebConfigSpecialCharacters != '') {
                var regularExpression = WebConfigSpecialCharacters;
                regularExpression += '"';
                var isSpecialCharacter = 0;
                for (var i = 0; i < regularExpression.length; i++) {
                    if (value.indexOf(regularExpression[i]) != -1) {
                        isSpecialCharacter = 1
                    }
                }
                if (isSpecialCharacter == 1) {
                    return true;
                }
                else {
                    return false;
                }
            }
            else {
                return false;
            }
        }
    </script>

</body>

</html>
