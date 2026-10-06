<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="IB_IssueToCopy.aspx.vb" Inherits="PbNIT.IB_IssueToCopy" %>

<!DOCTYPE html>
<html>
    <%CommonFunctions.General.PlotPageHeadTag("Issues")%>
<head>
    
    <!-- Commented by Gauri on 09/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title><%= MyBase.GetResourceString("C_PageTitle") %></title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.css?v=2">
    
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=3">--%>
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/AdminLTE.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz20_theme.css?v=0.1">
        <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

</head>

    <style type="text/css">
        h5.pgtitle {
            margin: 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px
        }

        .dblock {
            display: block
        }

        .mb-1 {
            margin-bottom: 10px
        }

        .dataTables_scrollBody {
            margin-bottom: 10px
        }
        /*New Style*/
        .topfltr .form-group {
            margin-right: 15px
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

        .filedownload {
            margin-left: 10px
        }

            .filedownload img {
                margin-right: 10px
            }

            .filedownload .dropdown-menu > li > a {
                padding: 3px 10px
            }

        .dataTables_paginate a.paginate_button.disabled {
            cursor: no-drop
        }

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

        span.time {
            display: block;
        }

        .mt-1 {
            margin-top: 10px;
        }

        .btn-light {
            background: #e2e6ea;
        }

        .stastusbtn {
            display: block;
            cursor: auto;
        }

        .btn-secondary {
            background: #5a6268;
            color: #fff !important;
        }

        .row.row-eq-height {
            display: flex;
        }
        /***********/
        /*collapsible panel css*/
        .togglerup .collapseup {
            display: block
        }

        .togglerup .collapsedown {
            display: none
        }

        .togglerdown .collapsedown {
            display: block
        }

        .togglerdown .collapseup {
            display: none
        }

        .colapsibleinfopanel .panel-title {
            font-size: 14px;
        }

        .hideinfoicon {
            position: absolute;
            right: 10px
        }

        .colapsibleinfopanel .panel.panel-default {
            padding: 0;
            position: relative
        }

        .colapsibleinfopanel .panel-default > .panel-heading {
            padding: 10px;
            background: #e7edf0
        }

            .colapsibleinfopanel .panel-default > .panel-heading a:hover, .profitabilityinfopanel .panel-default > .panel-heading a:focus {
                color: #464a4c
            }

            .colapsibleinfopanel .panel-default > .panel-heading a span img {
                opacity: .5
            }

                .colapsibleinfopanel .panel-default > .panel-heading a span img:hover {
                    opacity: 1
                }

        .colapsibleinfopanel {
            margin: 10px 0 10px !important;
            padding: 0 !important;
        }

        .infoToggler {
            margin: 5px 15px 0 0px;
        }
        /*End collapsible panel css*/
        .table thead tr th {
            padding: 8px;
        }

        .DTITblIDcontainer {
            max-height: 50vh;
        }

        .panel table {
            margin-bottom: 0;
        }

        .panel-group .panel {
            border-radius: 2px;
        }

        .colapsibleinfopanel .panel-title a:focus {
            color: #464a4c;
        }

        .panel-default.colapsibleinfopanel > .panel-heading.active {
            background-color: #c3dbff;
        }
/***************/
/*Accordian*/
button:focus:not(:focus-visible){box-shadow:none;background-color:var(--bs-accordion-active-bg);box-shadow:inset 0 calc(-1 * var(--bs-accordion-border-width)) 0 var(--bs-accordion-border-color)}
.accordion-button:focus{background:#f5f5f5}
.accordion-header button.accordion-button{color:#464a4c;font-weight:600;padding:.5rem;font-size:.9rem}
.accordion-button:hover{background:#e7f1ff}
.position-relative{position:relative}
span.badge.ml-1.position-relative.rounded-pill.bg-warning.text-dark{font-weight:500;background:none!important}
.rsrssSkillGraphTbl{width:100%;border:1px solid #ddd;background:#f5f5f5}
.panelHeadingCls{border-radius:0;padding:10px 0}
.panelHeadingCls h6{font-weight:700;margin:0}
/**/
.accordion-item:not(:first-of-type) {
    border-top: 1px solid #dee2e6;
    border-radius: 4px;
}
button.accordion-button.collapsed {
    border-bottom: 1px solid #dee2e6; background:#f5f5f5;
}
    .clsnote {
            font-size:10px;
        }

        #DTITblID_wrapper tr th:nth-child(1) {
            width:450px!important;
        }

        
        #DTITblID_wrapper tr td:nth-child(1) {
            width:450px!important;
        }

          #DTITblID_wrapper tr th:nth-child(2) {
            width:200px!important;
        }

        
        #DTITblID_wrapper tr td:nth-child(2) {
            width:125px!important;
        }

        #attachIssueTblID tr td:nth-child(2) {
            text-align:left!important;
        }

          #attachIssueTblID_wrapper tr th:nth-child(2) {
            text-align: left !important;
        }

/*Added by pradip on 7-4-2023*/
.accordion-button::after {
    content: "";
    font-size: 34px;
    background: url(../../../Whizible2.0-new/dist/img/down.svg) 0px 10px no-repeat;
    /* font-stretch: ultra-expanded; */
    background-size: 14px;
}

.accordion-button:not(.collapsed)::after {
    content: "";
    font-size: 34px;
    background: url(../../../Whizible2.0-new/dist/img/down.svg) 0px 10px no-repeat;
    /* font-stretch: ultra-expanded; */
    background-size: 14px;
}
/*End Added by pradip on 7-4-2023*/

    </style>

<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bodyIssueCopy">
    <div class="bgwhite">
        <div class="container-fluid pt-3 pb-3 text-end graybg">
            <h5 class="pgtitle float-start" id="idpageTiltle"><%= MyBase.GetResourceString("C_PageTitle") %></h5>
            <div class="clearfix"></div>
        </div>


        <div class="content pt-0">
         

               <div class="form-group row">
                 <div class="col-sm-6">
                    <div class="row">
                       <div class="pt-3 pb-3" style="cursor: auto;text-align:left">
                          <span class="clsnote">Note : Copy Discussion Threads / Attachment of Corresponding Helpdesk Request </span>
                     </div>
                            
                    </div>
                </div>
             <div class="col-sm-6">
                <div class="row">
                   <div class="pt-3 pb-3 text-end" style="cursor: auto;">
                      <a href="javascript:;" class="btn borderbtn mr-5" id="btncopytoissue" onclick="CopyToIssue()"><%= MyBase.GetResourceString("C_PageTitle") %></a>
                  </div>
                 </div>
               </div>
             </div>




            <!--accordian-container-->
            <div class="accordion" id="CIaccordionExample">
                <!--panel 1-->
                <div class="accordion-item mb-3">
                    <h2 class="accordion-header" id="CIheading1">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#CIcollapse1" aria-expanded="true" aria-controls="CIcollapse1">
                            <%= MyBase.GetResourceString("C_CopyDetails") %> 
                        </button>
                    </h2>
                    <div id="CIcollapse1" class="accordion-collapse collapse show" aria-labelledby="CIheading1" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <div class="form-group row">
                                <div class="col-sm-4">
                                    <div class="row">
                                        <label class="col-sm-4 text-end pr0"> <%= MyBase.GetResourceString("C_ReqID") %> : </label>
                                        <div class="col-sm-8"><b><span id="IblRequID"></span></b><span id="spnProjectID" style="display:none"></span></div>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="row">
                                        <label class="col-sm-4 text-end pr0"><%= MyBase.GetResourceString("C_IssueID") %> : </label>
                                        <div class="col-sm-8">
                                             <% CommonFunctions.HTMLControls.DrawComboBox("cboIssuedetails", "Select 0,'Select' ", 450,, "class='form-control'",,, ) %>
                                                                        
                                        </div>
                                    </div>

                                </div>
                                <div class="clearfix"></div>
                            </div>

                        </div>
                    </div>
                </div>
                <!--panel 1-->
                <!--panel 2-->
                <div class="accordion-item mb-3">
                    <h2 class="accordion-header" id="CIheading2">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#CIcollapse2" aria-expanded="true" aria-controls="CIcollapse2">
                           <%= MyBase.GetResourceString("C_DiscussionThreadsForIssue") %> 
                        </button>
                    </h2>
                    <div id="CIcollapse2" class="accordion-collapse collapse show" aria-labelledby="CIheading2" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <div class="table-responsive DTITblIDcontainer">
                                <table id="DTITblID" class="table table-stripped table-bordered" style="width:100%;">
                                    <thead>
                                        <tr>
                                            <th> <% = MyBase.GetResourceString("C_Comments") %> </th>
                                            <th> <%= MyBase.GetResourceString("C_DiscussionDate") %></th>
                                            <th> <%= MyBase.GetResourceString("C_CreatedBy") %></th>
                                            <th> <%= MyBase.GetResourceString("C_Select") %></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbodyDiscussion">
                                      
                                    </tbody>
                                </table>
                            </div>
                            <div style="display:none"><table><tbody id="tbodyDiscussionReplica"></tbody></table></div>
                        </div>
                    </div>
                </div>
                <!--panel 2-->
                <!--panel 3-->
                <div class="accordion-item mb-3">
                    <h2 class="accordion-header" id="CIheading3">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#CIcollapse3" aria-expanded="false" aria-controls="CIcollapse3">
                             <%= MyBase.GetResourceString("C_AttachmentsForIssue") %> 
                        </button>
                    </h2>
                    <div id="CIcollapse3" class="accordion-collapse collapse" aria-labelledby="CIheading3" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <div class="table-responsive attachissuecontainer">
                                <table id="attachIssueTblID" class="table table-stripped table-bordered" style="width:100%;">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th><%= MyBase.GetResourceString("C_OriginalFileName") %></th>
                                            <th><%= MyBase.GetResourceString("C_Description") %>  </th>
                                            <th><%= MyBase.GetResourceString("C_AttachedDate") %></th>
                                            <th><%= MyBase.GetResourceString("C_AttachedBy") %></th>
                                            <th><%= MyBase.GetResourceString("C_Select") %></th>
                                        </tr>
                                    </thead>
                                    <tbody id="tbodyAttachment">
                                      
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div style="display:none"><table><tbody id="tbodyAttachmentReplica"></tbody></table></div>
                </div>
                <!--panel 3-->

            </div>
            <!--accordian-container-end-here-->


        </div>

        <div class="clearfix"></div>
    </div>

    <!-- REQUIRED JS SCRIPTS -->

   <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
        <%--<script src="../../General/CommonValidations.js?v=2"></script>

     <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script>

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Issue").ToString%>'
        // Check or Uncheck All checkboxes
        var UserId ='<%=Session("intUserID")%>';
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

        //datatable
        $('#DTITblID').dataTable({
            "scrollY": true,
            "scrollX": false,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
            "scrollCollapse": true
        });
        $('#attachIssueTblID').dataTable({
            "scrollY": true,
            "scrollX": false,
            "paging": true,
            "pageLength": 5,
            "bLengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "bFilter": false,
            "ordering": false,
            "info": false,
            "scrollCollapse": true
        });
        

        $(".collapse").on('show.bs.collapse', function (e) {
            $(".table").resize();
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        });
        $(".collapse").on('hidden.bs.collapse', function (e) {
            $(".table").resize();
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        });
        $(".modal").on('show.bs.modal', function (e) {
            $(".table").resize();
        });
        $(".collapse").on('hidden.bs.modal', function (e) {
            $(".table").resize();
            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        });

        params = getParams();
        var CRMRequestID = unescape(params["RequestID"]);
        var SelectedDiscussionID = [];
        var SelectedAttachmentID = [];
        $(document).ready(function () {
            $("#IblRequID").text(CRMRequestID);
            //debugger;
            GetDetails();
           
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

        var FromWhere = unescape(params["FromWhere"]);
        function GetDetails() {
          //  debugger;
            var CRMRequestID = unescape(params["RequestID"]);
            var HDDetails = {
                CRMRequestID: encodeURI(CRMRequestID),
            }
            $("#cboIssuedetails").html("");
            var param = JSON.stringify(HDDetails);
            var strResult = AJAXCallWithResult("/api/IssueToCopy/GetDetails", param, false);
            if (strResult.length != 0) {
                for (var i = 0; i < strResult.length; i++) {
                   
                    var HDIssue = strResult[i];
                    var s = ('<option value=' + HDIssue.IssueID + ' >' + HDIssue.ISSUE + '</option>');
                  
                    $("#cboIssuedetails").append(s);
                    $("#spnProjectID").text(HDIssue.ProjectID);
                }
            }
           
           GetDiscussionDetails(CRMRequestID);
           GetAttachmentDetails(CRMRequestID);
        }
        

        function GetDiscussionDetails(CRMRequestID) {
            var HDDetails = {
                CRMRequestID: encodeURI(CRMRequestID),
            }
            var param = JSON.stringify(HDDetails);
            var strResult = AJAXCallWithResult("/api/IssueToCopy/GetDiscussionDetails", param, false);
            var StrDiscussionHTML = "";
            $("#DTITblID").dataTable().fnDestroy();
            $("#tbodyDiscussion").html("");
            $("#tbodyDiscussionReplica").html("");
            if (strResult.length != 0) {
                for (var i = 0; i < strResult.length; i++) {
                    StrDiscussionHTML += '<tr>';
                    StrDiscussionHTML += '<td>';
                    StrDiscussionHTML += '<textarea rows="2"  id="txtComments_' + strResult[i].CRMQueryDetailid + '" class="form-control" value="' + strResult[i].DiscussionThread + '" maxlength="500">' + strResult[i].DiscussionThread;
                    StrDiscussionHTML += '</textarea>';
                    StrDiscussionHTML += '</td>';
                    StrDiscussionHTML += ' <td>' + strResult[i].SubmittedDate + '</td>';
                    StrDiscussionHTML += ' <td>' + strResult[i].SubmittedBy + '</td>';
                    StrDiscussionHTML += ' <td>';
                    StrDiscussionHTML += ' <div class="custom_chckbox">';
                    StrDiscussionHTML += '<input id="chkSelect' + strResult[i].CRMQueryDetailid + '" class="chkSelectgrid" type="checkbox" name="chkSelect" value="' + strResult[i].CRMQueryDetailid + '"  onchange="chkSelectgrid(' + strResult[i].CRMQueryDetailid +')">';
                    StrDiscussionHTML += '<label for="chkSelect' + strResult[i].CRMQueryDetailid +'"></label>';
                    StrDiscussionHTML += '</div>';
                    StrDiscussionHTML += '</td>';
                    StrDiscussionHTML += '<input type=hidden id="hidSelectedDiscussion_' + strResult[i].CRMQueryDetailid + '" name="hidSelectedDiscussion_' + strResult[i].CRMQueryDetailid + '" value="' + strResult[i].CRMQueryDetailid + '">';
                    StrDiscussionHTML += '<input type=hidden id="hidSelectedDate_' + strResult[i].CRMQueryDetailid + '" name="hidSelectedDate_' + strResult[i].CRMQueryDetailid + '" value="' + strResult[i].SubmittedDate + '">';
                    StrDiscussionHTML += '</tr>';

                }
                $("#tbodyDiscussion").html('');
                $("#tbodyDiscussion").html(StrDiscussionHTML);
                $("#tbodyDiscussionReplica").html(StrDiscussionHTML);
                $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

                //datatable
                $('#DTITblID').dataTable({
                    "scrollY": true,
                    "scrollX": false,
                    "paging": true,
                    "pageLength": 5,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": true,
                    "retrieve": true,
                    "bFilter": false,
                    "ordering": false,
                    "info": false,
                    "scrollCollapse": true
                });
               
            }
        }

        function GetAttachmentDetails(CRMRequestID) {
            var HDDetails = {
                CRMRequestID: encodeURI(CRMRequestID),
            }
            var param = JSON.stringify(HDDetails);
            var strResult = AJAXCallWithResult("/api/IssueToCopy/GetAttachmentDetails", param, false);
            var StrAttachmentHTML = "";
            var IsDiscussionAttachment = 0;
            $("#attachIssueTblID").dataTable().fnDestroy();
            $("#tbodyAttachment").html("");
            $("#tbodyAttachmentReplica").html("");
            if (strResult.length != 0) {
                for (var i = 0; i < strResult.length; i++) {
                    StrAttachmentHTML += '<tr>';
                   // debugger;
                    if (strResult[i].DiscussionID != "0") {
                        StrAttachmentHTML += '<td><i class="far fa-comments" data-toggle="tooltip" data-placement="top" data-container="body" title="Discussion Attachment"></i></td>';
                    } else {
                        StrAttachmentHTML += '<td></td>';
                    }
                 
                   
                    StrAttachmentHTML += '<td>' + strResult[i].OriginalFileName + '</td>';
                    StrAttachmentHTML += '<td>' + strResult[i].Description + '</td>';
                    StrAttachmentHTML += '<td>' + strResult[i].DateAttached + '</td>';
                    StrAttachmentHTML += '<td>' + strResult[i].AttachedBy + '</td>';
                    StrAttachmentHTML += '<td>';
                    StrAttachmentHTML += '<div class="custom_chckbox">';
                    StrAttachmentHTML += '<input id="AIListCheck' + strResult[i].AttachmentId + '" name="AIListCheck" class="" type="checkbox" value="' + strResult[i].AttachmentId + '" onchange="chkAttachmentSelectgrid(' + strResult[i].AttachmentId +')">';
                    StrAttachmentHTML += '<label for="AIListCheck' + strResult[i].AttachmentId +'"></label>';
                    StrAttachmentHTML += '<input type=hidden id="hidSelectedAttachment_' + strResult[i].AttachmentId + '" name="hidSelectedDiscussion_' + strResult[i].AttachmentId + '" value="' + strResult[i].AttachmentId + '">';
                    StrAttachmentHTML += '</div>';
                    StrAttachmentHTML += '</td>';
                    StrAttachmentHTML += '</tr>';

                }
                $("#tbodyAttachment").html('');
                $("#tbodyAttachment").html(StrAttachmentHTML);
                $("#tbodyAttachmentReplica").html(StrAttachmentHTML);
                $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
                $('#attachIssueTblID').dataTable({
                    "scrollY": true,
                    "scrollX": false,
                    "paging": true,
                    "pageLength": 5,
                    "bLengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "destroy": true,
                    "retrieve": true,
                    "bFilter": false,
                    "ordering": false,
                    "info": false,
                    "scrollCollapse": true
                });

            }
        }


        function chkSelectgrid(ControlID) {
            //var allPages = qualificationsTable.fnGetNodes();
            // debugger;
            var checked = $("#chkSelect" + ControlID).is(':checked');
            if (checked) {
                SelectedDiscussionID.push(parseInt(ControlID));
            } else {
                //SelectedDiscussionID = [];
                SelectedDiscussionID = removeObjectWithId(SelectedDiscussionID, ControlID);
            }
        }


        function chkAttachmentSelectgrid(ControlID) {
            //var allPages = qualificationsTable.fnGetNodes();
            // debugger;
            var checked = $("#AIListCheck" + ControlID).is(':checked');
            if (checked) {
                SelectedAttachmentID.push(parseInt(ControlID));
            } else {
                //SelectedDiscussionID = [];
                SelectedAttachmentID = removeObjectWithId(SelectedAttachmentID, ControlID);
            }
        }


        function removeObjectWithId(arr, id) {
            const arrCopy = Array.from(arr);
            const objWithIdIndex = arrCopy.findIndex((obj) => obj.id === id);
            arrCopy.splice(objWithIdIndex, 1);
            return arrCopy;
        }

       
      
        function CopyToIssue() {
            var ArrMailComments = [];
            var Arrshowtocustomer = [];
            var i = 0;
            var AttachementList;
            var CommentsList = '';
            var objComments;
            var objDate;
            var comments = '';
            var CommentsforEmail = '';
            var objSelectDis;
            var strIsAttachment = 0;
            var strIsDiscussion = 0;
            var showToCust;
            var IsSeparatelyCopyDiscussion = "<%=IsSeparatelyCopyDiscussion%>";
           // debugger;
            /*------------------------ Discussion-----------------*/
            //var CheckedDiscussionCheckBox = $('input[name=chkSelect]:checked').map(function () {
            //    return this.value;
            //}).get().join(',');


            var CheckedDiscussionCheckBox = SelectedDiscussionID;
            if (CheckedDiscussionCheckBox.length > 0) {
                objSelectDis = CheckedDiscussionCheckBox;
            }

            //if (CheckedDiscussionCheckBox.length > 0) {
            //    objSelectDis = CheckedDiscussionCheckBox.split(",");
            //}

            if (objSelectDis != undefined) {
                for (i = 0; i < objSelectDis.length; i++) {
                    if (IsSeparatelyCopyDiscussion != "True") {
                        strIsDiscussion = 1;
                        objComments = $('#tbodyDiscussionReplica #txtComments_' + objSelectDis[i]).val();
                        objDate = $('#tbodyDiscussionReplica #hidSelectedDate_' + objSelectDis[i]).val();
                        comments = comments + ' Date: ' + objDate + ' Thread: ' + objComments + '$$****$$';
                        CommentsforEmail = CommentsforEmail + ' Date: ' + objDate + ' Thread: ' + objComments;
                        CommentsList = comments;
                        ArrMailComments.push(CommentsforEmail);
                    } else {
                        strIsDiscussion = 1;
                        objComments = $('#tbodyDiscussionReplica #txtComments_' + objSelectDis[i]).val();
                        objDate = $('#tbodyDiscussionReplica #hidSelectedDate_' + objSelectDis[i]).val();
                        CommentsforEmail = ' Date: ' + objDate + ' Thread: ' + objComments;
                       
                        ArrMailComments.push(CommentsforEmail);
                        if (CommentsList != '') {
                            CommentsList = CommentsList + ',' + ' Date: ' + objDate + ' Thread: ' + objComments + '$$****$$';
                        }
                        else {
                            CommentsList = ' Date: ' + objDate + ' Thread: ' + objComments + '$$****$$';
                        }
                        comments = CommentsList;
                    }
                }
            }

            //return;
            /*------------------------ Attachment-----------------*/
            var objSelectAttach;
            var AttachementList = '';
            var objAttachment;
            var K = 0;
            var IssueID = "";
            //var CheckedAttachmentCheckBox = $('input[name=AIListCheck]:checked').map(function () {
            //    return this.value;
            //}).get().join(',');

            //if (CheckedAttachmentCheckBox.length > 0) {
            //    objSelectAttach = CheckedAttachmentCheckBox.split(",");
            //}

            var CheckedAttachmentCheckBox = SelectedAttachmentID;
            if (CheckedAttachmentCheckBox.length > 0) {
                //objSelectAttach = CheckedAttachmentCheckBox.split(",");
                objSelectAttach = CheckedAttachmentCheckBox;
            }

            if (objSelectAttach != undefined) {
                for (K = 0; K < objSelectAttach.length; K++) {
                    strIsAttachment = 1;
                    objAttachment = $('#tbodyAttachmentReplica #hidSelectedAttachment_' + objSelectAttach[K]).val();
                    if (AttachementList != '') {
                        AttachementList = AttachementList + ',' + objAttachment;
                    }
                    else {
                        AttachementList = objAttachment;
                    }

                }
            }
            //return;
            if (strIsDiscussion == 1 || strIsAttachment == 1) {
                IssueID = $("#cboIssuedetails").val();
                var Mode = "CopyToIssue";
                var UserID = <%=Session("intUserID")%>;
                var HDDetails = {
                    CRMRequestID: encodeURI(CRMRequestID),
                    IssueID: encodeURI(IssueID),
                    comments: comments,
                    AttachementList: encodeURI(AttachementList),
                    Mode: encodeURI(Mode),
                    UserID: encodeURI(UserID),
                    CommentsList: CommentsList,
                    IsSeparatelyCopyDiscussion: encodeURI(IsSeparatelyCopyDiscussion)
                }
                var param = JSON.stringify(HDDetails);
                //return;
                var strResult = AJAXCallWithResult("/api/IssueToCopy/CopyToIssue", param, false);
                if (strResult != "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success('Details Copied Successfully.');
                    SelectedDiscussionID = [];
                    SelectedAttachmentID = [];
                }
            } else {
               // window.close();
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Select atleast one discussion or attachment to copy.');
                return false;
            }

            if (comments != '') {
                var ProjectId = $("#spnProjectID").text();
                if (IsSeparatelyCopyDiscussion != "True") {
                    window.open("../Email/SendEmail.aspx?MessageID=20004&RequestID=" + CRMRequestID + "&Comments=" + CommentsforEmail + "&ProjectID=" + ProjectId + "&ShowToCustomer=1&IssueID=" + IssueID, "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                } else {
                    //var arrmailcomments = ArrMailComments.split(",");
                    for (var i = 0; i < ArrMailComments.length; i++) {
                        window.open("../Email/SendEmail.aspx?MessageID=20004&RequestID=" + CRMRequestID + "&Comments=" + ArrMailComments[i] + "&ProjectID=" + ProjectId + "&ShowToCustomer=1&IssueID=" + IssueID, "", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                    }
                }
            }

            GetDiscussionDetails(CRMRequestID);
            GetAttachmentDetails(CRMRequestID);
        }


        //toggleicon
        function toggleIcon(e) {
            $(e.target)
                .prev('.panel-heading')
                .find(".infoToggler")
                .toggleClass('togglerdown togglerup');
        }
        $('.panel-group').on('hidden.bs.collapse', toggleIcon);
        $('.panel-group').on('shown.bs.collapse', toggleIcon);

        //active collapse panel
        $('.colapsibleinfopanel .panel-heading a').click(function () {
            $('.colapsibleinfopanel .panel-heading').removeClass('active');

            //If the panel was open and would be closed by this click, do not active it
            if (!$(this).closest('.colapsibleinfopanel .panel').find('.colapsibleinfopanel .panel-collapse').hasClass('in'))
                $(this).parents('.colapsibleinfopanel .panel-heading').addClass('active');
        });


        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {
            StartLoader("#bodyIssueCopy");
            $.ajax({
                url: encodeURI(strUrl + url),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                      xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_Issue"));
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
            StopAjaxLoader("#bodyIssueCopy");
            return ajaxResult;
        }

    </script>

</body>

</html>