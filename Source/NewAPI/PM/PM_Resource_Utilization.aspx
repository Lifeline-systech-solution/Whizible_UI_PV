<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Resource_Utilization.aspx.vb" Inherits="PbNIT.PM_Resource_Utilization" %>

<!DOCTYPE html>
<html>

     <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project Resource")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">    
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">   
    
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
   <!-- Font Awesome -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">--%>

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
     <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

</head>

    <style type="text/css">
         .alertify-notifier .ajs-message.ajs-error{
            color: #fff;
            background: rgba(217, 92, 92, 0,95);
            text-shadow: -1px -1px 0 rgba(0, 0, 0, 0,5);
        }

        .alertify-notifier {
            z-index: 999999!important;
        }

        .dataTables_scrollHeadInner {
            width: 100% !important
        }

            .dataTables_scrollHeadInner table {
                width: 100% !important
            }

        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important
        }

        a.clearalllink {
            font-weight: 700;
            margin: 7px 0 0 8px;
            display: none
        }

        .filter.float-end {
            margin: 2px 0 0 8px
        }

        table tr th {
            vertical-align: middle !important
        }

            table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before {
                margin-right: 0
            }

        #basicfilters label {
            line-height: 18px;
            text-align: right
        }

        h5.pgtitle {
            margin: 6px 0 0;
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

        table.dataTable thead th.sorting_asc:first-child:after, table.dataTable thead th.sorting:first-child:after, table.dataTable thead th.sorting_dsc:first-child:after {
            display: none
        }

        table.dataTable thead th:first-child {
            pointer-events: none
        }

        .legend {
            background: #fff;
            background: rgba(255,255,255,0.8);
            padding: 0;
            border: none;
            margin-bottom: 0;
            font-size: 13px
        }

            .legend li:first-child {
                margin-left: 0
            }

            .legend li {
                float: left;
                margin-left: 10px
            }

            .legend span {
                display: inline-block;
                width: 10px;
                height: 10px;
                margin-right: 6px
            }

        .totalrow td {
            background: #f5f5f5;
            font-weight: 700
        }

        .viewdropdwn .btn-group.form-control {
            width: 90% !important;
            margin-right: 5px
        }

        .viewdropdwn .form-control {
            width: 90% !important;
            margin-right: 5px;
            display: inline-block;
        }

        a.createviewicn {
            font-size: 16px
        }

        .text-center {
            text-align: center
        }

        tr.graybg {
            background: #e7edf0 !important
        }

        .custmodal .custom_chckbox label:before {
            border-color: #d2d6de
        }

        #addViewPopup .panel.panel-default {
            padding: 0
        }

        div.dataTables_wrapper div.dataTables_paginate {
            padding-bottom: 10px;
        }

/*BS5 Changes*/
html body{font-family: 'Roboto', sans-serif;}
tr.rowheading {background: #f5f5f5;}
#RoleListtbl tr th{ min-width:80px;}
#RoleListtbl tr th:nth-child(3), #RoleListtbl tr td:nth-child(3){ text-align:left!important;}
table.dataTable thead > tr > th.sorting_asc_disabled:before, table.dataTable thead > tr > th.sorting_asc_disabled:after, table.dataTable thead > tr > th.sorting_desc_disabled:before, table.dataTable thead > tr > th.sorting_desc_disabled:after, table.dataTable thead > tr > td.sorting:before, table.dataTable thead > tr > td.sorting:after, table.dataTable thead > tr > td.sorting_asc:before, table.dataTable thead > tr > td.sorting_asc:after, table.dataTable thead > tr > td.sorting_desc:before, table.dataTable thead > tr > td.sorting_desc:after, table.dataTable thead > tr > td.sorting_asc_disabled:before, table.dataTable thead > tr > td.sorting_asc_disabled:after, table.dataTable thead > tr > td.sorting_desc_disabled:before, table.dataTable thead > tr > td.sorting_desc_disabled:after, .sorting_asc.sorting_disabled:after{display:none!important;}
#addViewPopup .col-sm-6 .form-group {margin-bottom: 15px;}
/*End BS5 changes*/
    </style>
    
<body class="hold-transition skin-blue-light sidebar-mini fixed"  id="ResourceBody">
    <div class="bgwhite">
        <div class="container-fluid pt-1 pb-1 mb-1 text-end graybg">
            <%-- Added And Commented by imran 09-08-2021--%>
            <%--  <h5 class="pgtitle float-start">Utilization</h5>--%>
            <h5 class="pgtitle float-start"> <%= MyBase.GetResourceString("C_ResourceUtilization") %> </h5>
            <%--End Of Added And Commented by imran 09-08-2021--%>
            <div class="clearfix"></div>
        </div>
        <div class="clearfix"></div>
        <div class="content pt-1">          
            <div class="borderbox mb-3 d-flex row">
                <div class="col-sm-3">
                    <select class="form-control form-select" id="cboResource" name="cboResource"></select>                   
                </div>

                <div class="col-sm-3">                 
                    <select class="form-control form-select" id="cboMonth" name="cboMonth"></select>   
                </div>

                <div class="col-sm-3">
                    <select class="form-control form-select" id="cboYear" name="cboYear"></select> 
                </div>

                <div class="col-sm-3 viewdropdwn">
                    <select class="form-control form-select" id="RUviewselector" name="cboRUviewselector"></select>
                    <a href="javascript:;" class="createviewicn" data-bs-toggle="modal" data-bs-target="#Creatviewmodale"><i class="fas fa-columns" data-bs-toggle="tooltip" title="Create View" data-bs-container="body"></i></a>  
                </div>
                 
                <div class="clearfix"></div>
            </div>


            <div id="DefaultTDatable">
                <table id="DefaultviewTable" class="table table-stripped table-bordered" style="width: 100%;">
                    <thead>
                        <tr>
                            <th><%= MyBase.GetResourceString("C_ResourceName") %></th>
                            <th><%= MyBase.GetResourceString("C_AllocationStatus") %></th>
                            <th><%= MyBase.GetResourceString("C_Month") %></th>
                            <th><%= MyBase.GetResourceString("C_Year") %></th>
                            <th><%= MyBase.GetResourceString("C_InstallCapacityHrs") %></th>
                            <th><%= MyBase.GetResourceString("C_AvailableHrs") %></th>
                            <th><%= MyBase.GetResourceString("C_PlannedHrs") %></th>
                            <th><%= MyBase.GetResourceString("C_ActualHrs") %></th>
                            <th><%= MyBase.GetResourceString("C_BillableHrs") %></th>
                            <th><%= MyBase.GetResourceString("C_BookedHrs") %></th>
                        </tr>
                    </thead>
                    <tbody id="DefaultviewTablethead"> </tbody>
                </table>
            </div>

             <%-- Dynamic Table Create --%>
             <div id="ResultArea"></div>

          <%-- //Added By imran mujawar 11-10-2021 on 28th Sep 2020 for Pagination Change--%>
           <div class="row" style="margin-top: 5px" id="DivPagination">
                <div class='buttons col-sm-11' style="width: 90%; margin-top: 24px;">
                    <span id="" class="spntotal">Total Records : </span>
                    <span class="spntotal" id="TotalRecords"></span>
                </div>
                <div class='buttons col-sm-1' style="width: 10%" id="Pagination">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-end">
                            <li class="page-item" id="btnprevious">
                                <a class="page-link" aria-label="Previous" onclick='PrevList()' title="Previous" id="LinkPrevious">
                                    <i class="fas fa-angle-double-left"></i>
                                </a>
                            </li>
                            <li class="page-item" id="btnnext">
                                <a class="page-link" aria-label="Next" onclick='NextList()' title="Next" id="LinkNext">
                                    <i class="fas fa-angle-double-right"></i>
                                </a>
                            </li>
                        </ul>
                    </nav>

                </div>
            </div>
           <%--End of  //Added By imran mujawar 11-10-2021 For Pagination Change--%>

         </div>

        <!-- Create View Modal start here-->
        <div class="modal custmodal fade" id="Creatviewmodale" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                       
                        <h5 class="modal-title" id=""> <%= MyBase.GetResourceString("C_Views") %> </h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="pb-1 text-end">
                            <button type="submit" class="btn borderbtn mr-5" id="adviewlist" data-bs-toggle="modal" data-bs-target="#addViewPopup"><i class="fa fa-plus" aria-hidden="true"></i> Add</button>
                            <a href="javascript:;" class="btn borderbtn" id="btnAddView"><%= MyBase.GetResourceString("C_ApplydefaultView") %></a>
                            <a href="javascript:;" class="btn borderbtn" id="btnDelete"><%= MyBase.GetResourceString("C_Delete") %></a>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-stripped table-bordered" id="RoleListtbl" style="width: 100%!important;">
                                <thead>
                                    <tr>
                                        <th><%= MyBase.GetResourceString("C_ViewType") %></th>
                                        <th><%= MyBase.GetResourceString("C_ViewNames") %></th>
                                        <th><%= MyBase.GetResourceString("C_Columns") %></th>
                                        <th><%= MyBase.GetResourceString("C_Filter") %></th>
                                        <th><%= MyBase.GetResourceString("C_Apply") %></th>
                                        <th> <input type='checkbox' id='Checkall' class='custom-control-input' /></th>
                                    </tr>
                                </thead>
                                <tbody id="RoleListtblbody">
                                </tbody>
                            </table>
                        </div>

                        <div class="text-center"><button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn"><%= MyBase.GetResourceString("C_Cancel") %></button></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Create View Modal End here-->
        <!-- Add View Modal start here-->
        <div class="modal custmodal fade" id="addViewPopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_MyViews") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" id="btnclose">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="pb-1 text-end">
                            <button type="submit" class="btn btnyellow mr-5" id="btnSaveUtiliti"><%= MyBase.GetResourceString("C_Save") %></button>
                            <a href="javascript:;" class="btn btnyellow" id="btnSaveAndAddUtiliti"><%= MyBase.GetResourceString("C_SaveAndApply") %></a>
                            <a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#Creatviewmodale" data-bs-dismiss="modal" id="btnback"><%= MyBase.GetResourceString("C_Back") %></a>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading"><%= MyBase.GetResourceString("H_MyViewHeader1") %></div>
                            <div class="panel-body">
                                <div class="row mb-3">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_ViewName") %></label>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtViewName", "txtViewName", "form-control",,,,,,,,,, "autocomplete='Off' maxlength='50'",,, True,,,, True) %>
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6"> 
                                        <input type="hidden" id="txthiddenViewid" name="txthiddenViewid" value="0" readonly>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <div class="panel panel-default">
                            <div class="panel-heading"><%= MyBase.GetResourceString("H_MyViewHeader2") %></div>
                            <div class="panel-body">
                                <div class="row mb-3">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column1") %></label>
                                                <select class="form-control form-select" id="cboColumn1" name="cboColumn1"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column2") %></label>
                                                <select class="form-control form-select" id="cboColumn2" name="cboColumn2"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column3") %></label>
                                            <select class="form-control form-select" id="cboColumn3" name="cboColumn3"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column4") %></label>
                                            <select class="form-control form-select" id="cboColumn4" name="cboColumn4"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column5") %></label>
                                            <select class="form-control form-select" id="cboColumn5" name="cboColumn5"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column6") %></label>
                                            <select class="form-control form-select" id="cboColumn6" name="cboColumn6"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column7") %></label>
                                            <select class="form-control form-select" id="cboColumn7" name="cboColumn7"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column8") %></label>
                                            <select class="form-control form-select" id="cboColumn8" name="cboColumn8"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column9") %></label>
                                            <select class="form-control form-select" id="cboColumn9" name="cboColumn9"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column10") %></label>
                                            <select class="form-control form-select" id="cboColumn10" name="cboColumn10"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>   
                                    
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column11") %></label>
                                            <select class="form-control form-select" id="cboColumn11" name="cboColumn11"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column12") %></label>
                                            <select class="form-control form-select" id="cboColumn12" name="cboColumn12"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column13") %></label>
                                            <select class="form-control form-select" id="cboColumn13" name="cboColumn13"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column14") %></label>
                                            <select class="form-control form-select" id="cboColumn14" name="cboColumn14"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column15") %></label>
                                            <select class="form-control form-select" id="cboColumn15" name="cboColumn15"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column16") %></label>
                                            <select class="form-control form-select" id="cboColumn16" name="cboColumn16"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column17") %></label>
                                            <select class="form-control form-select" id="cboColumn17" name="cboColumn17"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>

                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Column18") %></label>
                                            <select class="form-control form-select" id="cboColumn18" name="cboColumn18"></select> 
                                            <div class="clearfix"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>                       
                    </div>
                </div>
            </div>
        </div>
        <!-- Add View Modal End here-->

        <div class="clearfix"></div>
    </div>

    <!-- REQUIRED JS SCRIPTS -->
   
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
    <!-- jqueryUI js -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

     <!--Added for loader-->
    <!-- custome js -->
    <%--<script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js"></script>--%>

    <script>
        //Added By Rehan on 3rd Jan 2023
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        var ProjectID = '<%= Request.QueryString("ProjectID")%>';
        var UserID = '<%= Session("intUserID") %>';

        var RUviewselector = "";
        var GlobleViewID = 0;
        var GlobleViewName = '';
        var systemviewtypeCount = 0;
        //Added by imran on 15 Feb 2022 For Pagination Change
        var intPageNo = 1;
        var PageSize = 5;
        //End of Added by imran on 15 Feb 2022 For Pagination Change
        var GlobalResourceCount = 0;

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

        //Page load 
        $(document).ready(function ()
        {
            StartLoader("#ResourceBody");
            //fill month Added by imran 17-08-2021
            FillMonth();
            //end by imran 17-08-2021

            //Fill Resource view name Added by imran 16-08-2021
            FillUtilizationResourceView();  
            //End by imran 16-08-2021

            //View Combo Value Fill
            FillUtilizationResourceViewSaveCombo();
            StopAjaxLoader("#ResourceBody");
        });

        //Added by imran 18-08-2021 To get Default filter ViewID
        function FillUtilizationResourceViewID()
        {
           var ResourceParameters =
           {
               TagID: 3752,
               UserID :UserID
            }             
            $.ajax({
		        url: encodeURI(strUrl) + '/api/PM_ResourceUtilization/FetchFilterSelectedViewID',
		        type: "POST",
		        data: JSON.stringify(ResourceParameters),
		        dataType: "json",
		        async: false,
		        contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr)
                {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ResourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ResourceParameters) ? ResourceParameters : JSON.stringify(ResourceParameters)));
                    }
		        },
		        success: function (Result) 
		        {                        
                    if (Result.length > 0)
                    {
                        for (var i = 0; i < Result.length; i++)
                        {
                            var ObjMsg = Result[i];
                        }
                        GlobleViewID = ObjMsg.ViewID;
                        $("#RUviewselector").val(ObjMsg.ViewName.replace('%',' ').replace("'"," "));                       
                        $("#cbofilter").val(ObjMsg.ViewName.replace('%',' ').replace("'"," "));                       
                        
                        FetchValueAsPerSelectedView(ObjMsg.ViewName);

                        //Fill view DataList
                        GetViewDataList();
                    }
                    else
                    {
                        $("#UtilizationPopUp").modal('show');
                        $("#AvailabilityDatable").hide();
                        $("#ProjectDatable").hide(); 

                        //Added by imran 27-08-2021 if defalut set
                        $("#cbofilter").val('Default View');  

                        //Fill Default Filter
                        DefaultViewCreateHtmlTable();

                        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();

                        //Fill view DataList
                        GetViewDataList();
                    }
		        },
		        error: function (err) {
			        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
		        }
            });
        }
        
        //Fill Month
        function FillMonth()
        {
           var ResourceParameters =
           {
               ProjectID: ProjectID,
           }  
            $.ajax({
		        url: encodeURI(strUrl) + '/api/PM_ResourceUtilization/GetMonth',
		        type: "POST",
		        data: JSON.stringify(ResourceParameters),
		        dataType: "json",
		        async: false,
		        contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr)
                {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ResourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ResourceParameters) ? ResourceParameters : JSON.stringify(ResourceParameters)));
                    }
		        },
		        success: function (data) 
		        {                        
                    var s = '';  
                    for (var i = 0; i < data.length; i++) 
					{  
                        s += '<option value="' + data[i].MonthName + '">' + data[i].MonthName + '</option>';  
                    }  
                    $("#cboMonth").html(s);
                    FillYear();
		        },
		        error: function (err) {
			        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
		        }
            });
        }

        //Fill Year
        function FillYear()
        {
           var ResourceParameters =
           {
               ProjectID: ProjectID,
           }  
            $.ajax({
		        url: encodeURI(strUrl) + '/api/PM_ResourceUtilization/GetYear',
		        type: "POST",
		        data: JSON.stringify(ResourceParameters),
		        dataType: "json",
		        async: false,
		        contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr)
                {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ResourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ResourceParameters) ? ResourceParameters : JSON.stringify(ResourceParameters)));
                    }
		        },
		        success: function (data) 
		        {                        
                    var s = '<option value="Select Year">Select Year</option>';  
                    for (var i = 0; i < data.length; i++) 
					{  
                        s += '<option value="' + data[i].YearID + '">' + data[i].YearID + '</option>';  
                    }  
                    $("#cboYear").html(s);                        
		        },
		        error: function (err) {
			        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
		        }
            });
        }

        //Fill Utilization Resorce view name Added by imran 17-08-2021
        function FillUtilizationResourceView()
        {
           var ResourceParameters =
           {
               TagID: 3752,
               UserID :UserID
           }  
            $.ajax({
		        url: encodeURI(strUrl) + '/api/PM_ResourceUtilization/GetResourceView',
		        type: "POST",
		        data: JSON.stringify(ResourceParameters),
		        dataType: "json",
		        async: false,
		        contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr)
                {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ResourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ResourceParameters) ? ResourceParameters : JSON.stringify(ResourceParameters)));
                    }
		        },
		        success: function (data) 
		        {                        
                    var s = '';  
                    //For Filter Added by imran 18-08-2021                  
                    for (var i = 0; i < data.length; i++)
                    {  
                        s += '<option value="' + data[i].ViewName.replace('%',' ').replace("'"," ") + '">' + data[i].ViewName + '</option>';  
                    }  
                    $("#RUviewselector").html(s);                   
                    s = ''; 

                    //fill Resource Name
                    FillUtilizationResourceName();

                    //Get Default ViewName if set
                    FillUtilizationResourceViewID();
		        },
		        error: function (err) {
			        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
		        }
            });
        }

        //Fill Resource Name Added by imran 17-08-2021
        function FillUtilizationResourceName()
        {
           var ResourceParameters =
           {
               ProjectID: ProjectID,
           }  
            $.ajax({
		        url: encodeURI(strUrl) + '/api/PM_ResourceUtilization/GetResourceName',
		        type: "POST",
		        data: JSON.stringify(ResourceParameters),
		        dataType: "json",
		        async: false,
		        contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr)
                {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ResourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ResourceParameters) ? ResourceParameters : JSON.stringify(ResourceParameters)));
                    }
		        },
		        success: function (data) 
		        {                        
                    var s = '';  
                    for (var i = 0; i < data.length; i++) {  
                        s += '<option value="' + data[i].EmployeEName + '">' + data[i].EmployeEName + '</option>';  
                    }  
                    $("#cboResource").html(s); 

		        },
		        error: function (err) {
			        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
		        }
            });
        }

        //Change view script
        $(function ()
        {
            $('#RUviewselector').change(function ()
            {
                intPageNo = 1;
                $('.ViewselectorCLS').hide();
                $('#' + $(this).val()).show();
                //$('.table').resize();
            });
        });
               
        function resizeSection() {
            var tblheight = $(window).height();
            $('.dataTables_scroll .dataTables_scrollBody').css({ 'height': tblheight - 210, "overflow-y": "auto" });
        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });
               
        setTimeout(function () {
            $('#data-table').DataTable({
                responsive: true
            });
        }, 5000);

        //Added by imran 30-07-2021 Grid fill Default View 
        function DefaultViewCreateHtmlTable()
        {
            //$("#DefaultviewTable").dataTable().fnDestroy();

            var Parameters =
            {
                ProjectID: ProjectID,
                ResourceName: $("#cboResource option:selected").text(),
                Month: $("#cboMonth option:selected").text(),
                Year: $("#cboYear option:selected").text(),
                intPageNo : 0,
                PageSize:0
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ResourceUtilization/GetResourceUtilizationDefaultData',
                type: "POST",
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (strResult)
                {
                    GlobalResourceCount = strResult.length;
                     //Added by imran 15-02-2022 For Pagination
                      Pagination();
                    //End by imran 15-02-2022
                }
            });

            var Parameters =
            {
                ProjectID: ProjectID,
                ResourceName: $("#cboResource option:selected").text(),
                Month: $("#cboMonth option:selected").text(),
                Year: $("#cboYear option:selected").text(),
                intPageNo : intPageNo,
                PageSize:PageSize
            }

            //$("#DefaultviewTable").dataTable().fnDestroy();

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ResourceUtilization/GetResourceUtilizationDefaultData',
                type: "POST",
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (strResult)
                {       
                    $("#DefaultviewTablethead").html("");
                    var strHTML = "";
                    if (strResult.length > 0)
                    {
                        var gempnm = ''; 

                        var ttotCap = 0; var tAvailability = 0; var tPlaned = 0;
                        var tActual = 0; var tBillable = 0; var tBooked = 0;

                        var LttotCap = 0; var LtAvailability = 0; var LtPlaned = 0;
                        var LtActual = 0; var LtBillable = 0; var LtBooked = 0;

                        var bookedhrs = 0.00; var bhrs1 = 0.00; var Adddecimal = 0.00;
                        
                        for (var i = 0; i < strResult.length; i++)
                        {                           
                            //Total Calculation
                            ttotCap += strResult[i].InstallCapacityHrs;
                            tAvailability += strResult[i].AvailableHrs;
                            tPlaned += strResult[i].PlannedHrs;                           
                            tActual += strResult[i].ActualHrs;
                            tBillable += strResult[i].BillableHrs ;                            
                            bookedhrs += strResult[i].BookedHrs + 0.00;
                            tBooked = bookedhrs.toFixed(2);

                            if (gempnm == '')
                            {
                                strHTML += ' <tr class="rowheading">'
                                strHTML += ' <td>' + strResult[i].EmployeeName + '</td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += '</tr>';

                                gempnm = strResult[i].EmployeeName;

                                var imgpath = strResult[i].AllocationStatus;
                                imgpath = imgpath.replace("<IMG src='", "<IMG src='../");
                                strHTML += ' <tr>'
                                strHTML += ' <td></td>';
                                strHTML += ' <td>' + imgpath + '</td>';
                                strHTML += ' <td>' + strResult[i].MonthName + '</td>';
                                strHTML += ' <td>' + strResult[i].YearID + '</td>';

                                var tInstallCapacityHrs= (strResult[i].InstallCapacityHrs + 0.00);
                                tInstallCapacityHrs = tInstallCapacityHrs.toFixed(2);
                                strHTML += ' <td>' + tInstallCapacityHrs + '</td>';

                                var tAvailableHrs= (strResult[i].AvailableHrs + 0.00);
                                tAvailableHrs = tAvailableHrs.toFixed(2);
                                strHTML += ' <td>' + tAvailableHrs + '</td>';

                                var phrs= (strResult[i].PlannedHrs + 0.00);
                                phrs = phrs.toFixed(2);
                                strHTML += ' <td>' + phrs + '</td>';

                                var tActualHrs= (strResult[i].ActualHrs + 0.00);
                                tActualHrs = tActualHrs.toFixed(2);
                                strHTML += ' <td>' + tActualHrs + '</td>';

                                var tBillableHrs= (strResult[i].BillableHrs + 0.00);
                                tBillableHrs = tBillableHrs.toFixed(2);
                                strHTML += ' <td>' + tBillableHrs + '</td>';

                                var l= (strResult[i].BookedHrs + 0.00);
                                l = l.toFixed(2);
                                strHTML += ' <td>' + l + '</td>';
                                strHTML += '</tr>';
                                                                
                                //Single Line
                                LttotCap += strResult[i].InstallCapacityHrs;
                                LtAvailability += strResult[i].AvailableHrs;
                                LtPlaned += strResult[i].PlannedHrs;
                                LtActual += strResult[i].ActualHrs;
                                LtBillable += strResult[i].BillableHrs;                             
                                bhrs1 += strResult[i].BookedHrs + 0.00;
                                LtBooked = bhrs1.toFixed(2);
                            }
                            else if (gempnm == strResult[i].EmployeeName)
                            {
                                //Single Line
                                LttotCap += strResult[i].InstallCapacityHrs;
                                LtAvailability += strResult[i].AvailableHrs;
                                LtPlaned += strResult[i].PlannedHrs;
                                LtActual += strResult[i].ActualHrs;
                                LtBillable += strResult[i].BillableHrs;
                                bhrs1 += strResult[i].BookedHrs + 0.00;
                                LtBooked = bhrs1.toFixed(2);

                                var imgpath = strResult[i].AllocationStatus;
                                imgpath = imgpath.replace("<IMG src='", "<IMG src='../");
                                strHTML += ' <tr>'
                                strHTML += ' <td></td>';
                                strHTML += ' <td>' + imgpath + '</td>';
                                strHTML += ' <td>' + strResult[i].MonthName + '</td>';
                                strHTML += ' <td>' + strResult[i].YearID + '</td>';
                                var tInstallCapacityHrs= (strResult[i].InstallCapacityHrs + 0.00);
                                tInstallCapacityHrs = tInstallCapacityHrs.toFixed(2);
                                strHTML += ' <td>' + tInstallCapacityHrs + '</td>';

                                var tAvailableHrs= (strResult[i].AvailableHrs + 0.00);
                                tAvailableHrs = tAvailableHrs.toFixed(2);
                                strHTML += ' <td>' + tAvailableHrs + '</td>';

                                var phrs= (strResult[i].PlannedHrs + 0.00);
                                phrs = phrs.toFixed(2);
                                strHTML += ' <td>' + phrs + '</td>';

                                var tActualHrs= (strResult[i].ActualHrs + 0.00);
                                tActualHrs = tActualHrs.toFixed(2);
                                strHTML += ' <td>' + tActualHrs + '</td>';

                                var tBillableHrs= (strResult[i].BillableHrs + 0.00);
                                tBillableHrs = tBillableHrs.toFixed(2);
                                strHTML += ' <td>' + tBillableHrs + '</td>';

                                var l= (strResult[i].BookedHrs + 0.00);
                                l = l.toFixed(2);
                                strHTML += ' <td>' + l + '</td>';
                                strHTML += '</tr>';

                                strHTML += '</tr>';
                            }
                            else if (gempnm != strResult[i].EmployeeName)
                            {
                                strHTML += ' <tr>'
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td>' + (Math.round(LttotCap * 100) / 100).toFixed(2); + '</td>';
                                strHTML += ' <td>' + (Math.round(LtAvailability * 100) / 100).toFixed(2); + '</td>';
                                strHTML += ' <td>' + (Math.round(LtPlaned * 100) / 100).toFixed(2); + '</td>';
                                strHTML += ' <td>' + (Math.round(LtActual * 100) / 100).toFixed(2); + '</td>';
                                strHTML += ' <td>' + (Math.round(LtBillable * 100) / 100).toFixed(2);  + '</td>';                          
                                strHTML += ' <td>' + (Math.round(LtBooked * 100) / 100).toFixed(2); + '</td>';  
                                strHTML += '</tr>';

                                LttotCap = 0.00;
                                LtAvailability = 0.00;
                                LtPlaned = 0.00;
                                LtActual = 0.00;
                                LtBillable = 0.00;
                                LtBooked = 0.00;

                                strHTML += '<tr>'
                                strHTML += ' <td>' + strResult[i].EmployeeName + '</td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += '</tr>';

                                gempnm = strResult[i].EmployeeName;

                                var imgpath = strResult[i].AllocationStatus;
                                imgpath = imgpath.replace("<IMG src='", "<IMG src='../");
                                strHTML += ' <tr>'
                                strHTML += ' <td></td>';
                                strHTML += ' <td>' + imgpath + '</td>';
                                strHTML += ' <td>' + strResult[i].MonthName + '</td>';
                                strHTML += ' <td>' + strResult[i].YearID + '</td>';
                                 var tInstallCapacityHrs= (strResult[i].InstallCapacityHrs + 0.00);
                                tInstallCapacityHrs = tInstallCapacityHrs.toFixed(2);
                                strHTML += ' <td>' + tInstallCapacityHrs + '</td>';

                                var tAvailableHrs= (strResult[i].AvailableHrs + 0.00);
                                tAvailableHrs = tAvailableHrs.toFixed(2);
                                strHTML += ' <td>' + tAvailableHrs + '</td>';

                                var phrs= (strResult[i].PlannedHrs + 0.00);
                                phrs = phrs.toFixed(2);
                                strHTML += ' <td>' + phrs + '</td>';

                                var tActualHrs= (strResult[i].ActualHrs + 0.00);
                                tActualHrs = tActualHrs.toFixed(2);
                                strHTML += ' <td>' + tActualHrs + '</td>';

                                var tBillableHrs= (strResult[i].BillableHrs + 0.00);
                                tBillableHrs = tBillableHrs.toFixed(2);
                                strHTML += ' <td>' + tBillableHrs + '</td>';

                                var l= (strResult[i].BookedHrs + 0.00);
                                l = l.toFixed(2);
                                strHTML += ' <td>' + l + '</td>';
                                strHTML += '</tr>';
                                strHTML += '</tr>';

                                //Single Line
                                LttotCap += strResult[i].InstallCapacityHrs;
                                LtAvailability += strResult[i].AvailableHrs;
                                LtPlaned += strResult[i].PlannedHrs;
                                LtActual += strResult[i].ActualHrs;
                                LtBillable += strResult[i].BillableHrs;
                                // LtBooked += parseFloat(strResult[i].BookedHrs + 0.00);                                                             
                                bhrs1 += strResult[i].BookedHrs + 0.00;
                                LtBooked = bhrs1.toFixed(2);

                            }   
                        }

                        // Last Record Totol Show
                        strHTML += ' <tr>'
                        strHTML += ' <td></td>';
                        strHTML += ' <td></td>';
                        strHTML += ' <td></td>';
                        strHTML += ' <td></td>';
                        strHTML += ' <td>' + (Math.round(LttotCap * 100) / 100).toFixed(2); + '</td>';
                        strHTML += ' <td>' + (Math.round(LtAvailability * 100) / 100).toFixed(2); + '</td>';
                        strHTML += ' <td>' + (Math.round(LtPlaned * 100) / 100).toFixed(2); + '</td>';
                        strHTML += ' <td>' + (Math.round(LtActual * 100) / 100).toFixed(2); + '</td>';
                        strHTML += ' <td>' + (Math.round(LtBillable * 100) / 100).toFixed(2);  + '</td>';                          
                        strHTML += ' <td>' + (Math.round(LtBooked * 100) / 100).toFixed(2); + '</td>';  

                        //grand Total show
                        strHTML += ' <tr>'
                        strHTML += ' <td></td>';
                        strHTML += ' <td></td>';
                        strHTML += ' <td></td>';                  
                        strHTML += ' <td></td>';                  
                        strHTML += ' <td>' + (Math.round(ttotCap * 100) / 100).toFixed(2);  + '</td>';
                        strHTML += ' <td>' + (Math.round(tAvailability * 100) / 100).toFixed(2);  + '</td>';
                        strHTML += ' <td>' + (Math.round(tPlaned * 100) / 100).toFixed(2); + '</td>';
                        strHTML += ' <td>' + (Math.round(tActual * 100) / 100).toFixed(2); + '</td>';
                        strHTML += ' <td>' + (Math.round(tBillable * 100) / 100).toFixed(2);  + '</td>';
                        strHTML += ' <td>' + (Math.round(tBooked * 100) / 100).toFixed(2);  + '</td>';
                        strHTML += '</tr>';
                    }

                    $("#DefaultviewTablethead").html("");
                    $("#DefaultviewTablethead").append(strHTML);

                    $("#DefaultviewTablethead tr td img").attr("data-bs-toggle", "tooltip");

                    //Added by imran 15-02-2022 For Pagination
                        Pagination();
                    //End by imran 15-02-2022

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            $('table').resize();
        }
        //End By Imran 30-07-2021

        // Added by imran 17-08-2021 Fill dynamic Data Table fill
        function DynamicCreateDataTable()
        {
            $("#ResultArea").html("");
            var strHTML = '';          

            strHTML += '<table id="DynamicTable" class="table table-striped table-bordered table-hover">';
            strHTML += '<thead>';
            strHTML += '<tr>';

            var str = strUrl + '/api/PM_ResourceUtilization/GetResourceDynamicColumnFetch';   
            var resourceParameters =
                {
                    TagID: 3752,
                    ViewName:$("#RUviewselector option:selected").text()             
                }              
                $.ajax({
                url: str,
                type: "POST",
                data: JSON.stringify(resourceParameters),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr)
                {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (resourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(resourceParameters) ? resourceParameters : JSON.stringify(resourceParameters)));
                    }
                },
                success: function (result)
                {
                    var tsql = '';
                    var ObjMsg = result[0];
                    tsql = ObjMsg.Columns;

                    var tColumns = new Array();
                    tColumns = ObjMsg.Columns.split(','); 
                    //Header fill
                    for (var i = 0; i < tColumns.length; i++)
                    {
                        var Caption=GetControlName(tColumns[i]);
                        strHTML += ' <th>' + Caption + '</th>';
                    }
                    strHTML += '</tr>';
                    strHTML += '</thead>';
                    strHTML += '<tbody id="tbodyProjectTimesheet">';

                    var resourceParameters =
                     {
                         ProjectID: ProjectID,
                         ResourceName: $("#cboResource option:selected").text(),
                         Month: $("#cboMonth option:selected").text(),
                         Year: $("#cboYear option:selected").text(),
                         TSQL:tsql
                    }                     
                     str = strUrl + '/api/PM_ResourceUtilization/GetResourceDynamicColumnDataFetch';
                     $.ajax({
	                    url: str,
	                    type: "POST",
	                    data: JSON.stringify(resourceParameters),
	                    dataType: "json",
	                    contentType: "application/json;charset-utf=8",
	                    async: false,
	                    beforeSend: function (xhr)
	                    {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (resourceParameters) {
                                xhr.setRequestHeader("Params", encryptString(isJson(resourceParameters) ? resourceParameters : JSON.stringify(resourceParameters)));
                            }
	                    },
	                    success: function (result)
                        {
                            for (var i = 0; i < result.length; i++)
                            {
                                var UtilityObj = result[i];                               
                                strHTML += '<tr>'
                                //Data Fill
                                $.each(UtilityObj, function (key, value)
                                {
                                    if (key == "AllocationStatus")
                                    {
                                         var imgpath = value;
                                         imgpath = imgpath.replace("<IMG src='", "<IMG src='../");
                                         strHTML += '<td>' + imgpath+ '</td>';
                                    }
                                    else if (key == "BookedHrs")
                                    {
                                         var l= (value + 0.00);
                                             l = l.toFixed(2);
                                             strHTML += ' <td>' + l + '</td>';
                                    }
                                    else
                                    {
                                        strHTML += '<td>' + value + '</td>';
                                    }                                    
                                });
                                strHTML += '</tr>'
                            }
	                    },
	                    error: function (err)
	                    {}
                    });  
                    strHTML += '</tbody>';
                    strHTML += '</table>';
                    $("#ResultArea").html(strHTML);
                },
                error: function (err)
                {}
            });   

            $('#DynamicTable').dataTable({               
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true
            });
        }

        //Added by imran 30-07-2021 Grid fill  Project Allocation
        function ProjectCreateDataTable()
        {   
            var table = $('#ProjectAllocationviewTable').DataTable();
            table.destroy();
                      
            oTableStaticFlow = $("#ProjectAllocationviewTable").DataTable({
                "destroy": true,
                "scrollY": true,
                "scrollX": '100%',
                "paging": true,
                "pageLength": 10,
                "bLengthChange": false,
                "bFilter": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "bFilter": false,
                "ordering": false,
                "info": false,
                "ajax":
                {
                        'url': encodeURI(strUrl) + '/api/PM_ResourceUtilization/GetResourceUtilizationAvailabilityBasedData',                   
                        'data': function (d)
                        {      
                            d.ProjectID= ProjectID,
                            d.ResourceName= $("#cboResource option:selected").text(),
                            d.Month= $("#cboMonth option:selected").text(),
                            d.Year= $("#cboYear option:selected").text()
                            return JSON.stringify(d);
                        },
                        'type': "POST",               
                        'dataType': "json",
                        'async': false,                      
                        'beforeSend': function (xhr)
                        {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        },                        
                        'contentType': "application/json;charset-utf=8",
                        'dataType': "json",                       
                        dataSrc: function (result) 
                        {                               
                            var data = [];
                            for (var r1 in result) 
                            {                               
                                  
                                 var data1 = result[r1];
                                 var imgpath = data1['AllocationStatus'];
                                imgpath = imgpath.replace("<IMG src='", "<IMG src='../");
                                
                                data.push([                                   
                                    data1['EmployeeName'],
                                    imgpath,
                                    data1['MonthName'],
                                    data1['YearID'],
                                    data1['AvailableHrsPercent'],
                                    data1['PlannedHrsProjectAllocationPercent'],
                                    data1['ActualHrsProjectAllocationPercent'],
                                    data1['BillableHrsProjectAllocationPercent']                                   
                                ]);
                            }
                            return data;
                         }
                }, 
                "columnDefs":
                    [
                        { bSortable: false, targets: [1] }
                    ],
                "columns":
                    [                             
                        { "": "EmployeeName"},
                        { "": "AllocationStatus"},
                        { "": "MonthName"},
                        { "": "YearID"},
                        { "": "AvailableHrsPercent"},
                        { "": "PlannedHrsProjectAllocationPercent"},   
                        { "": "ActualHrsProjectAllocationPercent"},   
                        { "": "BillableHrsProjectAllocationPercent"} 
                    ],
                     "oLanguage": {
                            "sEmptyTable": ""
                     }
            });  
        }
        //End By Imran 30-07-2021
        
        
        //Added by imran 18-08-2021 when apply filter set view
        $(function ()
        {
            $("#RUviewselector").change(function ()
            {
                intPageNo = 1;
                StartLoader("#ResourceBody");
                if (GlobleViewName == '')
                {
                    RUviewselector = $(this).val();
                }
                else
                {
                    RUviewselector = GlobleViewName;
                    GlobleViewName = '';
                } 
                FetchValueAsPerSelectedView($('option:selected', this).text()); 
                StopAjaxLoader("#ResourceBody");
            });
            
            //Added by imran to set filter data 18-08-2021
            $("#cbofilter").change(function ()
            {
                StartLoader("#ResourceBody");
                if (GlobleViewName == '')
                {
                    RUviewselector = $(this).val();
                }
                else
                {
                    RUviewselector = GlobleViewName;
                    GlobleViewName = '';
                } 

                $("#RUviewselector").val($('option:selected', this).text());
                FetchValueAsPerSelectedView($('option:selected', this).text()); 
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("<%= MyBase.GetResourceString("A_ApplySuccessfully") %>");
                StopAjaxLoader("#ResourceBody");
            });
        });
        //end by imran 18-08-2021

        //Added by imran 18-08-2021
        function FetchValueAsPerSelectedView(k)
        {
            var RUviewselector = k;
           
            if (RUviewselector == "Default View")
            {
                $("#DivPagination").show();

                $("#DefaultTDatable").show();
                $("#AvailabilityDatable").hide();
                $("#ProjectDatable").hide();

                //var table = $('#DefaultviewTable').DataTable();
                //table.destroy();  
                
                $("#ResultArea").html("");
                DefaultViewCreateHtmlTable();               
            }
            else
            {
                $("#DivPagination").hide();

                $("#DefaultTDatable").hide();
                $("#ProjectDatable").hide();
                $("#AvailabilityDatable").show();

                //var AvailabilityAllocationviewTable = $('#AvailabilityAllocationviewTable').DataTable();
                //AvailabilityAllocationviewTable.destroy();

                //DynamicTableCreate
                DynamicCreateDataTable();                 
            }
        }
        //end by imran 30-07-2021

        //Added by imran 16-08-2021
        $(document).on('change',"#cboResource", function ()
        {
            intPageNo = 1;
            if ($("#RUviewselector option:selected").text() == "Default View") {
                DefaultViewCreateHtmlTable();
            }
            else
            {
                var table = $('#AvailabilityAllocationviewTable').DataTable();
                table.destroy();
                $('#AvailabilityAllocationviewTable').DataTable().clear().destroy();              
                DynamicCreateDataTable();    
            }
        });
        //End by imran 16-08-2021

        //Month value Added by imran 16-08-2021
        $(document).on('change',"#cboMonth", function ()
        {
            intPageNo = 1;
            if ($("#RUviewselector option:selected").text() == "Default View")
            {
                DefaultViewCreateHtmlTable();                               
            }
            else 
            {
                var table = $('#AvailabilityAllocationviewTable').DataTable();
                table.destroy();
                $('#AvailabilityAllocationviewTable').DataTable().clear().destroy();              
                DynamicCreateDataTable();                
            }           
        });
        //End by imran 16-08-2021

        //Added by imran 16-08-2021 View onchange to fill datatable
        $(document).on('change', "#cboYear", function ()
        {
            intPageNo = 1;
            if ($("#RUviewselector option:selected").text() == "Default View")
            {
                DefaultViewCreateHtmlTable();                               
            }
            else 
            {
                var table = $('#AvailabilityAllocationviewTable').DataTable();
                table.destroy();
                $('#AvailabilityAllocationviewTable').DataTable().clear().destroy();              
                DynamicCreateDataTable();                
            }           
        });
        //End By Imran 16-08-2021

        //Fetch Dropdown value Added by imran 16-08-2021    
        function FillUtilizationResourceViewSaveCombo()
        {
           var ResourceParameters =
           {
               TagID: 3752
           }  
            $.ajax({
		        url: encodeURI(strUrl) + '/api/PM_ResourceUtilization/GetResourceViewSaveCombo',
		        type: "POST",
		        data: JSON.stringify(ResourceParameters),
		        dataType: "json",
		        async: false,
		        contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr)
                {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ResourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ResourceParameters) ? ResourceParameters : JSON.stringify(ResourceParameters)));
                    }
		        },
		        success: function (data) 
		        {                        
                    var s = '<option value="0">' + 'Select Column' + '</option>';  
                    for (var i = 0; i < data.length; i++) {  
                        s += '<option value="' + data[i].ControlName + '">' + data[i].ControlCaption + '</option>';  
                        //console.log(  data[i].ControlName + ' ' +  data[i].ControlCaption);
                    }  
                    //Fill All View  Dropdown value of Column1-18
                    for (j = 0; j <= 18; j++)
                    {
                        $("#cboColumn" + j).html(s); 
                    }                    
		        },
		        error: function (err) {
			        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
		        }
            });
        }
        //end by imran 16-08-2021

        // For save Added by imran 16-08-2021
        var tflag = 0;
        var tcount = 0;
        var tColumnValues = '';
        $("#btnSaveUtiliti").click(function ()
        {
            CheckValidation();
        });

        //clear Form data Added by imran 16-08-2021
        $("#btnSavecancel").click(function ()
        {
            ClearFilterData();
        });

        //clear Form data Added by imran 16-08-2021
        $("#btnclose").click(function ()
        {
            ClearFilterData();
        });

        //clear Form data Added by imran 16-08-2021
        $("#btnback").click(function ()
        {
            ClearFilterData();
        });

        //Save or update data Added by imran 16-08-2021
        $("#btnSaveAndAddUtiliti").click(function ()
        {
            // tflag 1 means using for save and Add
            tflag = 1;
            CheckValidation();            
        });
        //End by imran 16-08-2021

        //Check Validation And Save or Update data Added by imran 16-08-2021
        function CheckValidation()
        {
            var viewname = $("#txtViewName").val();//Added By Rehan C
            tcount = 0;
            alertify.set('notifier', 'position', 'top-right');
            if ($("#txtViewName").val().trim() == "")
            {
                alertify.error("<%= MyBase.GetResourceString("E_ViewName") %>");
                $("#txtViewName").focus(); 
                tColumnValues = '';
                return false;
            }
            //Added By Rehan on 07/11/2022 To check validation for Special characters  on 11/11/2022
            if (checkSpecialCharacter(viewname, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('View Name Should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtViewName").focus();
                return false;
            }
            if ($("#txtViewName").val().trim().length > 50)
            {
                alertify.error("<%= MyBase.GetResourceString("A_ViewLength") %>");
                $("#txtViewName").focus(); 
                tColumnValues = '';
                return false;
            } 
           
            for (i = 1; i <= 18; i++)
            {
                var k = $("#cboColumn" + i).val(); 
                if (k == 0)
                {}
                else
                {
                    for (j = i+1; j <= 18; j++)
                    {
                        var t = $("#cboColumn" + j).val();
                        if (t == k)
                        {
                            alertify.error("<%= MyBase.GetResourceString("A_ThisColumnAlreadySelect") %>");
                            $("#cboColumn" + j).focus();
                            return false;
                        }
                    } 
                }                               
            }
            
            for (i = 1; i <= 18; i++)
            {
                var k = $("#cboColumn" + i).val();  
                if (k == 0)
                {
                    tcount += 1;
                }
                else
                {
                    if (tColumnValues == '')
                    {
                        tColumnValues = k;
                    }
                    else {
                          tColumnValues = tColumnValues + ',' + k;
                    }                  
                }
            }

            if (tcount == 18)
            {
                tcount = 0;
                alertify.error("<%= MyBase.GetResourceString("A_SelectAtLeastOneColumn") %>");
                return false;
            }
            else
            {   
                StartLoader("#ResourceBody");
                var Data = {
                    ViewId: encodeURI(0),
                    TagID: 3752,
                    UserId: encodeURI(UserID),
                    FilterId: '',
                    ViewName: $("#txtViewName").val().trim(),
                    Columns: tColumnValues,
                    HiddenViewID :$("#txthiddenViewid").val()
                }              
                
                $.ajax({
                    url: encodeURI(strUrl + '/api/PM_ResourceUtilization/GetResourceViewSaveData'),
                    type: "POST",
                    data: JSON.stringify(Data),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (Data) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Data) ? Data : JSON.stringify(Data)));
                        }
                    },
                    success: function (Result)
                    {
                        for (var i = 0; i < Result.length; i++)
                        {
                            var ObjMsg = Result[i];
                        }

                        if (ObjMsg.Msg == "0")
                        {
                            if (tflag == 1)
                            {        
                                GlobleViewName =$("#txtViewName").val();
                                GetViewDataList();                               
                                ViewNameFetch();
                                //Filter view set 31-08-2021 added by imran
                                $("#RUviewselector").val(GlobleViewName);
                                FetchValueAsPerSelectedView(GlobleViewName);
                                //End  by imran 31-08-2021
                                ClearFilterData();
                                alertify.success("<%= MyBase.GetResourceString("A_FilterAddedSuccessfully") %>");
                                // $("#addViewPopup").modal('hide');

                                //Added by imran on 10-02-2022
                                ApplyFilter(ObjMsg.ViewID+"~"+$("#txtViewName").val().trim(),1);
                                //End Of Comment By imran on 10-02-2022p

                                StopAjaxLoader("#ResourceBody");
                            }                            
                            else
                            {                               
                                GetViewDataList();
                                ClearFilterData();
                                //FillUtilizationResourceView();
                                ViewNameFetch();
                                alertify.success("<%= MyBase.GetResourceString("A_FilterAddedSuccessfully") %>");
                                StopAjaxLoader("#ResourceBody");
                            }
                        }                        
                        else if (ObjMsg.Msg == "1")
                        {
                            alertify.error("<%= MyBase.GetResourceString("A_AlreadyExits") %>");   
                            StopAjaxLoader("#ResourceBody");
                        }
                        else if (ObjMsg.Msg == 2)
                        {     
                            ClearFilterData(); 
                            GetViewDataList();                                  
                            ViewNameFetch();
                            //Added by imran on 10-02-2022 When Default set filter applied but when adding new column to view taht time refresh
                            FillUtilizationResourceView();
                            //End Of Comment By imran on 10-02-2022
                            alertify.success("<%= MyBase.GetResourceString("A_FilterUpdateSuccessfully") %>");
                            $("#addViewPopup").modal('hide');
                            StopAjaxLoader("#ResourceBody");
                        }
                        else
                        {StopAjaxLoader("#ResourceBody");}
                    },
                    error: function (err) {
                        StopAjaxLoader("#ResourceBody");
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
            StopAjaxLoader("#ResourceBody");
        }
        //end by imran 16-08-2021

        //Clear Filter Data Added by imran 16-08-2021
        function ClearFilterData()
        {
            tflag = 0;
            HiddenViewID = 0;
            tColumnValues = '';
            $("#txtViewName").val('');
            $("#txthiddenViewid").val('0');
            for (i = 1; i <= 18; i++)
            {
               $("#cboColumn" + i).prop('selectedIndex',0);
            }
            $('.modal-open .modal').css('overflow','auto');
        }
        //End by imran 16-08-2021

        //delete Selected Views data Added by imran 16-08-2021
        $("#btnDelete").click(function ()
        {
            alertify.set('notifier', 'position', 'top-right');

            var selectedids = new Array();
            $('input[name="checkitem"]:checked').each(function ()
            {
                selectedids.push(this.value);
            });

            if (selectedids.length == 0)
            {
                alertify.error("<%= MyBase.GetResourceString("A_SelectAtLeastOneRecord") %>");
                return false;
            }
            else
            {
                var ViewIds = '';

                for (i = 0; i < selectedids.length; i++)
                {
                    ViewIds += selectedids[i] +'`';
                }
                               
                var Data =
                    {
                        ViewId: ViewIds,
                        TagID: 3752                   
                    }    
               
                    $.ajax({
                        url: encodeURI(strUrl + '/api/PM_ResourceUtilization/UtilizationViewDataDelete'),
                        type: "POST",
                        data: JSON.stringify(Data),
                        dataType: "json",
                        contentType: "application/json;charset-utf=8",
                        async: false,
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (Data) {
                                xhr.setRequestHeader("Params", encryptString(isJson(Data) ? Data : JSON.stringify(Data)));
                            }
                        },
                        success: function (Result)
                        {
                            //Added by imran on 11-02-2022
                            $('#Checkall').prop('checked', false);
                            //End By imran on  11-02-2022

                            //Fill Utilization ViewList
                            GetViewDataList();
                            //Fill Dropdown Values
                            FillUtilizationResourceView();
                            alertify.success("<%= MyBase.GetResourceString("A_UtilizationViewDeleted") %>");
                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
            }           
        });
        //End by imran 16-08-2021

        //Added by imran 16-08-2021
        $("#btnAddView").click(function ()
        {
            SetDefaultFilter();
        });
        //end by imran 16-08-2021

        //Get View Data List Added by imran 16-08-2021
        var oTableStaticFlow = '';
        function GetViewDataList()
        {
           var Parameters =
            {
                TagID: 3752,               
                UserID:UserID
            }
            $("#RoleListtbl").dataTable().fnDestroy();

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ResourceUtilization/GetUtilizationViewData',
                type: "POST",
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (strResult)
                {   
                    $("#RoleListtblbody").html("");
                    var strHTML = "";
                    if (strResult.length > 0)
                    {
                        var gviewtype = '';                      

                        for (var i = 0; i < strResult.length; i++)
                        {    
                            if (gviewtype == '') {
                                strHTML += ' <tr>';
                                strHTML += ' <td>' + strResult[i].ViewType + '</td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' </tr>';

                                //fill Same data
                                strHTML += ' <tr>';
                                strHTML += ' <td></td>';

                                if (strResult[i].ViewName == 'Project Allocation based %')
                                {
                                    strHTML += '<td>' + strResult[i].ViewName + '</td>';
                                }
                                else
                                {
                                    strHTML += '<td> <a onclick=ApplyToUpdate("' + strResult[i].ViewID + '")> ' + strResult[i].ViewName + ' </a> </td>';
                                }                                

                                //strHTML += ' <td>' + strResult[i].Columns + '</td>';
                                var temparray = new Array(); var y = '';
                                temparray = strResult[i].Columns.split(',')
                                if (temparray.length <= 3)
                                {
                                    strHTML += ' <td>' + strResult[i].Columns + '</td>';
                                }
                                else
                                {
                                    var tno = 2;
                                    for (g = 0; g < temparray.length; g++)
                                    {
                                        if (g == tno)
                                        {
                                            y += temparray[g] + ', <br>';
                                            tno += 3;
                                        }
                                        else
                                        {
                                             y += temparray[g] + ',';
                                        }
                                    }                                   
                                     var t = y.charAt(y.length - 1)
                                   
                                    if (t == ",")
                                    {
                                        y = y.substring(0, y.length - 1);;                                       
                                        strHTML += ' <td>' + y + '</td>';
                                    }
                                    else
                                    {
                                        strHTML += ' <td>' + y + '</td>';
                                    }
                                }
                               
                                var k = strResult[i].FilterName;
                                if (k !== null && data !== '') {
                                    strHTML += ' <td>' + k + '</td>';
                                }
                                else {
                                    strHTML += ' <td>-</td>';
                                }

                                strHTML += '<td>';
                                if (strResult[i].ViewID == GlobleViewID) {
                                     strHTML += '<a>-</a>';    
                                }
                                else
                                {
                                     strHTML += ' <a onclick=ApplyFilter("' + strResult[i].ViewID +'~'+ strResult[i].ViewName.replace(/\s+/g, '%20') + '",0)> Apply </a>';    
                                }                                                            
                                strHTML += '</td>';

                                strHTML += '<td>';
                                if (strResult[i].ViewType == 'System Views')
                                {
                                    //strHTML += ' <input type="checkbox" id="' + strResult[i].ViewID + '" name="checkitem" class="checkitem" value="' + strResult[i].ViewID + '"  disabled/>';
                                    strHTML += '';
                                    systemviewtypeCount += 1;
                                }
                                else
                                {
                                    //Commented and added by imran on 15-12-2021 if that view is apply cannot delete that view
                                    //strHTML += ' <input type="checkbox" name="checkitem" class="checkitem" value="' + (strResult[i].ViewID) + '"/>';
                                    if (strResult[i].ViewID == GlobleViewID)
                                    {
                                        strHTML += '<a> </a>';
                                    }
                                    else {
                                        strHTML += ' <input type="checkbox" name="checkitem" class="checkitem" value="' + (strResult[i].ViewID) + '"/>';
                                    }
                                    //End Commented by imran on 15-12-2021 if that view is apply cannot delete that view                                      
                                }
                                
                                strHTML += '</td>';

                                strHTML += ' </div>';
                                strHTML += '</tr>';

                                gviewtype = strResult[i].ViewType
                            }
                            else if (gviewtype == strResult[i].ViewType) {
                                strHTML += ' <tr>';
                                strHTML += ' <td></td>';
                                if (strResult[i].ViewName == 'Project Allocation based %')
                                {
                                    strHTML += '<td>' + strResult[i].ViewName + '</td>';
                                }
                                else
                                {
                                    strHTML += '<td> <a onclick=ApplyToUpdate("' + strResult[i].ViewID + '")> ' + strResult[i].ViewName + ' </a> </td>';
                                }  
                                //strHTML += ' <td>' + strResult[i].Columns + '</td>';
                                var temparray = new Array(); var y = '';
                                temparray = strResult[i].Columns.split(',')
                                if (temparray.length <= 3)
                                {
                                    strHTML += ' <td>' + strResult[i].Columns + '</td>';
                                }
                                else
                                {
                                    var tno = 2;
                                    for (g = 0; g < temparray.length; g++)
                                    {
                                        if (g == tno)
                                        {
                                            y += temparray[g] + ', <br>';
                                            tno += 3;
                                        }
                                        else
                                        {
                                             y += temparray[g] + ',';
                                        }
                                    }    
                                    var t = y.charAt(y.length - 1)                                   
                                    if (t == ",")
                                    {
                                        y = y.substring(0, y.length - 1);;                                       
                                        strHTML += ' <td>' + y + '</td>';
                                    }
                                    else
                                    {
                                        strHTML += ' <td>' + y + '</td>';
                                    }                                    
                                }

                                var k = strResult[i].FilterName;
                                if (k !== null && data !== '') {
                                    strHTML += ' <td>' + k + '</td>';
                                }
                                else {
                                    strHTML += ' <td>-</td>';
                                }
                                strHTML += '<td>';
                                if (strResult[i].ViewID == GlobleViewID) {
                                     strHTML += '<a>-</a>';    
                                }
                                else
                                {
                                     strHTML += ' <a onclick=ApplyFilter("' + strResult[i].ViewID +'~'+ strResult[i].ViewName.replace(/\s+/g, '%20') + '",0)> Apply </a>';    
                                }  
                                strHTML += '</td>';
                                strHTML += '<td>';
                                if (strResult[i].ViewName == 'Project Allocation based %')
                                {
                                    //Commented and added by imran on 15-12-2021 if that view is apply cannot delete that view
                                    //strHTML +=' <input type="checkbox" id="' + strResult[i].ViewID + '" name="checkitem" class="checkitem" value="' + strResult[i].ViewID + '"  disabled/>';
                                    if (strResult[i].ViewID == GlobleViewID) {
                                        strHTML += '<a> </a>';
                                    }
                                    else {
                                        strHTML += ' <input type="checkbox" name="checkitem" class="checkitem" value="' + (strResult[i].ViewID) + '"/>';
                                    }
                                    //End Commented by imran on 15-12-2021 if that view is apply cannot delete that view                                    
                                }
                                else
                                {
                                    //Commented and added by imran on 15-12-2021 if that view is apply cannot delete that view
                                    //strHTML += ' <input type="checkbox" name="checkitem" class="checkitem" value="' + (strResult[i].ViewID) + '"/>';
                                     if (strResult[i].ViewID == GlobleViewID) {
                                        strHTML += '<a> </a>';
                                    }
                                    else {
                                        strHTML += ' <input type="checkbox" name="checkitem" class="checkitem" value="' + (strResult[i].ViewID) + '"/>';
                                    }
                                    //End Commented by imran on 15-12-2021 if that view is apply cannot delete that view
                                    
                                }
                                strHTML += '</td>';
                                strHTML += ' </div>';
                                strHTML += '</tr>';
                            }
                            else if (gviewtype != strResult[i].ViewType)
                            {
                                strHTML += ' <tr>';
                                strHTML += ' <td>' + strResult[i].ViewType + '</td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' <td></td>';
                                strHTML += ' </tr>';

                                //fill Same data
                                strHTML += ' <tr>';
                                strHTML += ' <td></td>';
                                if (strResult[i].ViewName == 'Project Allocation based %')
                                {
                                    strHTML += '<td>' + strResult[i].ViewName + '</td>';
                                }
                                else
                                {
                                    strHTML += '<td> <a onclick=ApplyToUpdate("' + strResult[i].ViewID + '")> ' + strResult[i].ViewName + ' </a> </td>';
                                }  

                                //strHTML += ' <td>' + strResult[i].Columns + '</td>';
                                var temparray = new Array(); var y = '';
                                temparray = strResult[i].Columns.split(',')
                                if (temparray.length <= 3)
                                {
                                    strHTML += ' <td>' + strResult[i].Columns + '</td>';
                                }
                                else
                                {
                                    var tno = 2;
                                    for (g = 0; g < temparray.length; g++)
                                    {
                                        if (g == tno)
                                        {
                                            y += temparray[g] + ', <br>';
                                            tno += 3;
                                        }
                                        else
                                        {
                                             y += temparray[g] + ',';
                                        }
                                    }                                   
                                    var t = y.charAt(y.length - 1)
                                   
                                    if (t == ",")
                                    {
                                        y = y.substring(0, y.length - 1);;                                       
                                        strHTML += ' <td>' + y + '</td>';
                                    }
                                    else
                                    {
                                        strHTML += ' <td>' + y + '</td>';
                                    }
                                }

                                var k = strResult[i].FilterName;
                                if (k !== null && data !== '') {
                                    strHTML += ' <td>' + k + '</td>';
                                }
                                else {
                                    strHTML += ' <td>-</td>';
                                }
                                strHTML += '<td>';
                                if (strResult[i].ViewID == GlobleViewID)
                                {
                                     strHTML += '<a>-</a>';    
                                }
                                else
                                {
                                     strHTML += ' <a onclick=ApplyFilter("' + strResult[i].ViewID +'~'+ strResult[i].ViewName.replace(/\s+/g, '%20') + '",0)> Apply </a>';  
                                } 
                                strHTML += '</td>';

                                strHTML += '<td>';
                                if (strResult[i].ViewType == 'System Views')
                                {
                                    //strHTML += ' <input type="checkbox" id="' + strResult[i].ViewID + '" name="checkitem" class="checkitem" value="' + strResult[i].ViewID + '"  disabled/>';
                                    strHTML += '';
                                    systemviewtypeCount += 1;
                                }
                                else
                                {
                                    //Commented and added by imran on 15-12-2021 if that view is apply cannot delete that view
                                    //strHTML += ' <input type="checkbox" id="' + strResult[i].ViewID + '" name="checkitem" class="checkitem" value="' + strResult[i].ViewID + '" />';
                                    //strHTML += ' <input type="checkbox" name="checkitem" class="checkitem" value="' + (strResult[i].ViewID) + '"/>';
                                     if (strResult[i].ViewID == GlobleViewID) {
                                        strHTML += '<a> </a>';
                                    }
                                    else {
                                        strHTML += ' <input type="checkbox" name="checkitem" class="checkitem" value="' + (strResult[i].ViewID) + '"/>';
                                    }                                    
                                    //End Commented  by imran on 15-12-2021 if that view is apply cannot delete that view
                                }
                                strHTML += '</td>';
                                strHTML += ' </div>';
                                strHTML += '</tr>';
                                gviewtype = strResult[i].ViewType
                            }                            
                        }
                    }
                    $("#RoleListtblbody").html("");
                    $("#RoleListtblbody").append(strHTML);
                    
                    oTableStaticFlow = $('#RoleListtbl').dataTable({  
                       "paging": true,
                       "pageLength":10,
                       "bLengthChange": false,
                       "bFilter": false,
                       "ordering": false,
                       "responsive": true,
                       "destroy": false,
                       "retrieve": true,
                       "bFilter": false,
                       "ordering": false,
                       "info": false,
                        "autowidth": false                       
                    });                    
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });             
        }
        //End By imran 16-08-2021

        //Check box check all Added by imran 16-08-2021
        //$('#Checkall').click(function (e)
        //{
        //    var table = $(e.target).closest('table');
        //    $('td input:checkbox', table).prop('checked', this.checked);
        //});
        
        $('.custom-control-input').click(function ()
        {
            var table = $('#RoleListtbl').DataTable();
            if ($(this).prop("checked") == true) {
                var rows1 = table.rows({ 'search': 'applied' }).nodes();
                $('input[type="checkbox"]', rows1).each(function () {
                    this.checked = true;
                });
            }
            else if ($(this).prop("checked") == false)
            {
                var rows2 = table.rows({ 'search': 'applied' }).nodes();
                $('input[type="checkbox"]', rows2).each(function () {
                    this.checked = false;
                });
            }
        });
        //End by imran 16-08-2021

        //Added by imran on 11-02-2022 For Check box check uncheck
        $(document).on('change', '.checkitem', function ()
        {
            var table = $("#RoleListtbl").DataTable();
            var checked = table.rows().nodes().to$().find('input[type="checkbox"].checkitem').length;
            var checked1 = table.rows().nodes().to$().find('input[type="checkbox"].checkitem:checked').length;
            if (checked == checked1)
            {
                $(".custom-control-input").prop("checked", true);
            }
            else {
                $(".custom-control-input").prop("checked", false);
            }
        });
        //End by imran on 11-02-2022 For Check box check uncheck

        //Click on grid View Name And Data Update to fetch lisat Added by imran 17-08-2021
        function ApplyToUpdate(data)
        {
            StartLoader("#ResourceBody");
            Fillmodalpopup(data);
            $("#addViewPopup").modal('show');
            StopAjaxLoader("#ResourceBody");           
        }
        //end by imran 17-08-2021

        // To fill data for update the view Added by imran 16-08-2021
        var a = '';
        function Fillmodalpopup(data)
        {
            a = data;
            $("#txthiddenViewid").val(a);
            var Parameters =
            {
                TagID: 3752,
                ViewId: a
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ResourceUtilization/GetResourceViewDataForUpdate',
                type: "POST",
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (strResult)
                { 
                    if (strResult.length > 0)
                    {
                        var tColumn = new Array;                       
                        for (var i = 0; i < strResult.length; i++)
                        {
                            $("#txtViewName").val(strResult[i].ViewName);
                            tColumn = strResult[i].Columns.split(",");
                        }
                                              
                        for (i = 0; i <= tColumn.length -1; i++)
                        {
                           $("#cboColumn" + (i+1)).val(tColumn[i]);
                        }
                    }
                }
            });
        }
        //End by imran 16-08-2021
        
        //Click on Apply Filter Added by imran 17-08-2021
        function ApplyFilter(data,flag)
        {           
            var items = new Array();
            items = data.split('~');
            var data = items[0];
            GlobleViewName = items[1].replace(/%20/g, " ");
            GlobleViewName = GlobleViewName.replace('%',' ').replace("'"," ");
            var Data = {
                    ViewId: data,
                    TagID: 3752,
                    UserId: UserID,
                    IsDefaultValue: 1
            }
            
                $.ajax({
                    url: encodeURI(strUrl + '/api/PM_ResourceUtilization/SaveFilterData'),
                    type: "POST",
                    data: JSON.stringify(Data),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (Data) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Data) ? Data : JSON.stringify(Data)));
                        }
                    },
                    success: function (Result)
                    {
                        alertify.set('notifier', 'position', 'top-right');
                        GlobleViewID = data;
                        $("#RUviewselector").val(GlobleViewName);
                        //$("#cbofilter").val(GlobleViewName);

                        for (var i = 0; i < Result.length; i++)
                        {
                            var ObjMsg = Result[i];
                        }

                        //Added By imran On 10-02-2022
                        FillUtilizationResourceView();
                        //End Of Comment By imran on 10-02-2022

                        if (ObjMsg.Msg == "0")
                        {
                            if (flag == 0) {
                                alertify.success("<%= MyBase.GetResourceString("A_ApplySuccessfully") %>");
                            }                            
                            //Fill View Apply status update Added by imran 18-08-2021
                            GetViewDataList();
                            //Fill View As per Selected view Added by imran 18-08-2021
                            FetchValueAsPerSelectedView(GlobleViewName);
                        }
                        else if (ObjMsg.Msg == "1")
                        {
                            if (flag == 0) {
                                alertify.success("<%= MyBase.GetResourceString("A_ApplySuccessfully") %>");
                            }
                            //Fill View Apply status update Added by imran 18-08-2021
                            GetViewDataList();
                            //Fill View As per Selected view Added by imran 18-08-2021
                            FetchValueAsPerSelectedView(GlobleViewName);
                        }
                        else {
                        }
                    },
                    error: function (err) {                       
                       // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });           
        }
        //end by imran 17-08-2021

        //Added by imran 18-08-2021 Set Default Filter
        function SetDefaultFilter()
        {
            var Data = {                   
                    TagID: 3752,
                    UserId: UserID                  
                }              
                $.ajax({
                    url: encodeURI(strUrl + '/api/PM_ResourceUtilization/SetDefaultFilter'),
                    type: "POST",
                    data: JSON.stringify(Data),
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (Data) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Data) ? Data : JSON.stringify(Data)));
                        }
                    },
                    success: function (Result)
                    {
                        alertify.set('notifier', 'position', 'top-right');
                        GlobleViewID = 0;
                      
                        for (var i = 0; i < Result.length; i++)
                        {
                            var ObjMsg = Result[i];
                        }

                        if (ObjMsg.Msg == "1")
                        {
                            alertify.success("<%= MyBase.GetResourceString("A_DefaultViewApply") %>"); 
                            GetViewDataList();
                            
                            //Set Default filter
                            GlobleViewName = 'Default View';
                            //$("#RUviewselector").prop('selectedIndex',0);                         

                            FetchValueAsPerSelectedView(GlobleViewName);
                            $("#RUviewselector").val('Default View');                         
                            $("#cbofilter").val('Default View');   
                        }
                        else {
                        }
                    },
                    error: function (err) {                       
                       // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                }); 
        }
        //end By imran 18-08-2021

        function GetControlName(CName)
        {
            switch (CName)
            {
                case "ActualHrsPercent":
                    return "Actual %";
                    break;
                case "ActualHrsProjectAllocationPercent":
                    return "Project Allocation Actual %";
                    break;
                case "ActualHrs":
                    return "Actual (Hrs)";
                    break;
                case "AllocationStatus":
                    return "Allocation Status";
                    break;
                case "AvailableHrsPercent":
                    return "Available %";
                    break;
                case "AvailableHrsProjectAllocationPercent":
                    return "Project Allocation Available %";
                    break;
                case "AvailableHrs":
                    return "Available (Hrs)";
                    break;
                case "BillableHrsPercent":
                    return "Billable %";
                    break;
                case "BillableHrsProjectAllocationPercent":
                    return "Project Allocation Billable %";
                    break;
                case "BillableHrs":
                    return "Billable (Hrs)";
                    break;
                case "BookedHrs":
                    return "Booked (Hrs)";
                    break;
                case "InstallCapacityHrs":
                    return "Install Capacity (Hrs)";
                    break;
                case "MonthName":
                    return "Month";
                    break;
                case "PlannedHrsPercent":
                    return "Planned %";
                    break;
                case "PlannedHrsProjectAllocationPercent":
                    return "Project Allocation Planned %";
                    break;
                case "PlannedHrs":
                    return "Planned (Hrs)";
                    break;
                case "EmployeeName":
                    return "Resource Name";
                    break;
                case "YearID":
                    return "Year";
                    break;
                default:
                return "";
              }
        }

        function ViewNameFetch()
        {
            var ResourceParameters =
            {
                TagID: 3752,
                UserID: UserID
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ResourceUtilization/GetResourceView',
                type: "POST",
                data: JSON.stringify(ResourceParameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ResourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ResourceParameters) ? ResourceParameters : JSON.stringify(ResourceParameters)));
                    }
                },
                success: function (data) {
                    var s = '';
                    for (var i = 0; i < data.length; i++) {
                        s += '<option value="' + data[i].ViewName.replace('%', ' ').replace("'", " ") + '">' + data[i].ViewName + '</option>';
                    }
                    $("#RUviewselector").html(s);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }


         // Added by imran 11-10-2021
            function Pagination() {
                TotalRecords = GlobalResourceCount;
                var currentRecord = (intPageNo * PageSize);
                if (parseInt(intPageNo) == 1) {
                    $("#btnprevious").addClass("fa-disabled");
                    $("#btnnext").removeClass("fa-disabled");
                    $("#LinkPrevious").removeAttr("Onclick");
                    $("#LinkNext").attr("Onclick", "NextList()");
                }
                if (parseInt(currentRecord) > parseInt(TotalRecords) && intPageNo == 1) {
                    $("#btnprevious").addClass("fa-disabled");
                    $("#btnnext").addClass("fa-disabled");

                    $("#LinkPrevious").removeAttr("Onclick");
                    $("#LinkNext").removeAttr("Onclick");
                }
                else if (parseInt(currentRecord) >= parseInt(TotalRecords)) {
                    $("#btnprevious").removeClass("fa-disabled");
                    $("#btnnext").addClass("fa-disabled");
                    $("#LinkPrevious").attr("Onclick", "PrevList()");
                    $("#LinkNext").removeAttr("Onclick");
                }

                else if (parseInt(intPageNo) > 1 && parseInt(currentRecord) < parseInt(TotalRecords)) {
                    $("#btnprevious").removeClass("fa-disabled");
                    $("#btnnext").removeClass("fa-disabled");
                    $("#LinkPrevious").attr("Onclick", "PrevList()");
                    $("#LinkNext").attr("Onclick", "NextList()");
                }

                if (isIE() == "IE") {
                    if ($("#btnprevious").hasClass("fa-disabled")) {
                        $("#btnprevious").addClass("clsPaginationEnableDisable");
                    }
                    else {
                        $("#btnprevious").removeClass("clsPaginationEnableDisable");
                    }
                    if ($("#btnnext").hasClass("fa-disabled")) {
                        $("#btnnext").addClass("clsPaginationEnableDisable");
                    }
                    else {
                        $("#btnnext").removeClass("clsPaginationEnableDisable");
                    }
                }
                $("#TotalRecords").html("");
                $("#TotalRecords").html(TotalRecords);
            }
            // End by imran 11-10-2021

            // Added by imran 11-10-2021
            function isIE() {
                var brwser = '';
                var ua = navigator.userAgent, tem,
                    M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
                if (/trident/i.test(M[1])) {
                    tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                    //return 'IE '+(tem[1] || '');
                    return 'IE';
                }
                if (M[1] === 'Chrome') {
                    tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                    if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                    brwser = 'CR';
                }
                else if (M[1] === 'Firefox') {
                    tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                    if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                    brwser = 'FF';
                }
                M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
                if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
                //return M.join(' ');
                return brwser;

            }
            // End by imran 11-10-2021

            // Added by imran 11-10-2021
            function PrevList() {
                StartLoader("#ResourceBody");
                gflag = 1;
                if (intPageNo <= 1) {
                    intPageNo = 1;
                }
                else {
                    intPageNo -= 1;
                }
                DefaultViewCreateHtmlTable();
                StopAjaxLoader("#ResourceBody");
            }
            // End by imran 11-10-2021

            // Added by imran 11-10-2021
            function NextList() {
                StartLoader("#ResourceBody");
                gflag = 1;
                intPageNo += 1;
                DefaultViewCreateHtmlTable();
                StopAjaxLoader("#ResourceBody");
            }
            // End by imran 11-10-2021
        //Added By Rehan For Special Character Validation on 3rd Jan 2023
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
	    //End of Comment By Rehan
    </script>
</body>
</html>