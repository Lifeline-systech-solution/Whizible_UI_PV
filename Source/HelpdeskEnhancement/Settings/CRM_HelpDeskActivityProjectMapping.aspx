<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_HelpDeskActivityProjectMapping.aspx.vb" Inherits="PbNIT.CRM_HelpDeskActivityProjectMapping" %>

<!DOCTYPE html>

<html>

<%CommonFunctions.General.PlotPageHeadTag("Project Dashboard")%>
<head>

    <!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project Dashboard</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />

</head>

<style>
body{ background:#ffffff;}
.inline-block{display:inline-block}
.headertopp ul{align-items:center;margin:0;padding:0;vertical-align:middle}
.headertopp ul li .custom_radio{margin-top:6px}

    .dataTables_scrollBody thead tr[role="row"] {
        visibility: collapse !important;
    }

.radio [type="radio"]:checked, .radio [type="radio"]:not(:checked) {position: absolute;left: -9999px;}
.radio [type="radio"]:checked + label, .radio [type="radio"]:not(:checked) + label{position:relative;padding-left:28px;cursor:pointer;line-height:20px;display:inline-block;color:#464a4c; font-weight:500;}
.radio [type="radio"]:checked + label:before, .radio [type="radio"]:not(:checked) + label:before{content:'';position:absolute;left:0;top:0;width:16px;height:16px;border:1px solid #464a4c;border-radius:100%;background:transparent;}
.radio [type="radio"]:checked + label:after, .radio [type="radio"]:not(:checked) + label:after{content:'';width:10px;height:10px;background:#464a4c;position:absolute;top:3px;left:3px;border-radius:100%;-webkit-transition:all .2s ease;transition:all .2s ease}
.radio [type="radio"]:not(:checked) + label:after{opacity:0;-webkit-transform:scale(0);transform:scale(0)}
.radio [type="radio"]:checked + label:after{opacity:1;-webkit-transform:scale(1);transform:scale(1)}
.headertopp li .radio {margin-right: 30px;}

#EPMtbl tr th:first-child, #EPMtbl tr td:first-child{ text-align:left!important;}
    #EPMtbl tr:not(.exapndrow):hover{ background:#f7fcff;}
    tr.exapndrow {
        background: #f5f5f5;
        font-weight: bold;
    }
.bootstrap-select > .dropdown-toggle{ height:30px;}
    .modalpgHead {
        background: #4263c1;
        color: #fff;
        font-family: 'Roboto', sans-serif;
        font-size: 20px;
    }
#HelpRequestHistoryModal table tr th:first-child, #HelpRequestHistoryModal table tr td:first-child{ text-align:left!important; }
#HelpRequestHistoryModal table tr td.dataTables_empty {
    text-align: center!important;
}
#HelpRequestHistoryModal table tr th {position: relative;}
table.dataTable thead .sorting:after, table.dataTable thead .sorting_asc:after, table.dataTable thead .sorting_desc:after{display:none}

body{
    box-sizing: border-box!important;
    font-family: "Open Sans",sans-serif!important;
    font-size:12px!important;
}

.form-control {
    border-radius: 4px;
    font-size:12px!important;
}
.dataTables_paginate{margin-top:5px}
.dataTables_paginate .pagination .page-link {font-size: 12px!important;}
.modal-header{display:block}
</style>

<body class="hold-transition skin-blue-light sidebar-mini fixed" id="HelpdeskProjectMapping">

    
    <!-- Content Wrapper. Contains page content -->
    <div class="">

        <!-- Main content -->
        <div class="graybg container-fluid pt-1 pb-1 headertopp">
            <ul class="pull-left">
                <li class="inline-block">
                    <div class="radio" style="margin:0; padding-top:4px;">
                        <input type="radio" id="EPM" name="radio-group" checked>
                        <label for="EPM"><%= MyBase.GetResourceString("C_EmployeeProjectMapping") %></label>
                    </div>
                </li>
            </ul>
            <%If m_blnAddAccess = True Or m_blnEditAccess = True Then%>
                  <button class="btn btnyellow pull-right" style="margin-top:0px;" onclick="SaveData()"><%= MyBase.GetResourceString("C_Save") %></button>
              <%End If %>
            <div class="clearfix"></div>
        </div>

        <!--widget wrapper start here-->
        <div class="widget_category_panel collapse" id="dashwidget">
            <div class="widget_category_panelbody">
                <button type="button" class="btn btn-box-tool dashclosewidget">
                    <img src="dist/img/close-gray.svg" width="16px" alt="" title="" />
                </button>

                <div class="widgetheader"><h4>Widget category title</h4></div>

            </div>
        </div>
        <!--widget wrapper end here-->


        <div class="content pl-0 pr0">
            <table id="EPMtbl" class="table table-bordered EPMtbl" style="width:100%">
                <thead>
                    <tr>
                        <th><%= MyBase.GetResourceString("C_ResourceName") %></th>
                        <th width="30%"><%= MyBase.GetResourceString("C_Project") %></th>
                        <th>&nbsp;</th>
                    </tr>
                </thead>
                <tbody id="EPMtblBody">
                   
                                      
                </tbody>
            </table>
        </div>


    </div><!-- /.content -->
    <!--closemodal_start_here-->
    <div class="modal custmodal" id="HelpRequestHistoryModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><%= MyBase.GetResourceString("C_HelpRequestProjectHistory") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>

                </div>
                <div class="modal-body">
                   <table class="table table-stripped table-bordered" id="HelpRequestHistory">
                       <thead>
                           <tr>
                               <th class=""><%= MyBase.GetResourceString("C_OldProjectName") %></th>
                               <th><%= MyBase.GetResourceString("C_ModifiedDate") %></th>
                           </tr>
                       </thead>
                       <tbody id="HelpRequestHistoryBody">
                          
                       </tbody>
                   </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn borderbtn" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Cancel") %></button>
                    <!--<button type="button" class="btn btnyellow" data-bs-dismiss="modal">Yes</button>-->
                </div>
            </div>
        </div>
    </div>
    <!--closemodal_end_here-->
   
    <!-- REQUIRED JS SCRIPTS -->

    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script> 
   <%-- <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

        
    <script type="text/javascript">

       

    </script>

    <script>
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        var SessionProjectID =  '<%= Session("intProjectID") %>';
        var LoginType = '<%= Session("LoginType") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserID = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var AddAccess = "<%=m_blnAddAccess%>";
        var EditAccess = "<%= m_blnEditAccess%>";
        var DeleteAccess = "<%= m_blnDeleteAccess%>";
        var blnViewAccess ="<%= m_blnViewAccess%>";
        var EmployeeID;
        var EmployeeName = '';
        var ReportingTo;
        var ReportingName = '';
        var oldReportingName = '';
        var strHTMLProject = "";
        var arrEmployeeIDs = [];
        $(document).ready(function () {
           
            GetHelpdeskResourcesList();
           
        });

        function GetHelpdeskResourcesList() {

         
            var RequestParameters = {
                intUserID: encodeURI(UserID),                              
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/CRM_HelpdeskActivityProjectMapping/GetHelpdeskResourcesList", param, false);
            if (strResult != undefined) {
                $("#EPMtblBody").html("");
                var strHTML = "";
                for (var i = 0; i < strResult.length; i++) {
                    EmployeeID = strResult[i].EmployeeID;
                    EmployeeName = strResult[i].EmployeeName;
                    ReportingTo = strResult[i].ReportingTo;
                    ReportingName = strResult[i].ReportingName;
                    GetProjectList(EmployeeID);
                    if (ReportingName == null ||ReportingName== undefined || ReportingName =='') {
                        ReportingName = 'N/A';
                    }
                    if(ReportingName != oldReportingName) {
                        strHTML += '<tr class="exapndrow">'
                        strHTML += '<td>' + ReportingName + '</td>'
                        strHTML += '<td></td>'
                        strHTML += '<td></td>'
                        strHTML += '</tr>'
                    }
                  
                       strHTML +='<tr>'
                       strHTML += '<td>' + EmployeeName + '</td>'
                       strHTML += '<td>' + strHTMLProject + '</td>'                     
                       strHTML += '<td>'
                       strHTML += '<a href = "javascript:;" data-bs-toggle="modal" data-bs-target="" onclick="History_onClick(' + EmployeeID + ')"> History</a>'
                       strHTML += '</td>'
                       strHTML += '</tr>'
                       oldReportingName = ReportingName;
                      // arrEmployeeIDs[i] = EmployeeID;
                }
                 $("#EPMtblBody").html("");
                 $("#EPMtblBody").append(strHTML);
                 $('#EPMtbl').DataTable({                  
                    "paging": true,
                    "ordering": false,                                   
                    "pageLength": 20,
                    "scrollX": true,
                    "scrollY": true,
                    "searching": false,
                    "lengthChange": false,
                    
                });
                 setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 350);


        //start script - dynamically set height
        function resizeSection(tag) {
            var scrollbodyheight = $(window).height();
            $('#EPMtbl_wrapper .dataTables_scrollBody').css({ 'height': scrollbodyheight - 220 });

        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });
          //End script - dynamically set height
               
            }
        }

        //Get All Project List for Employee
        function GetProjectList(EmployeeID) {
           
            var SelectedProjectID = GetHelpdeskProject(EmployeeID);
            
            var RequestParameters = {
                intEmployeeID: encodeURI(EmployeeID),                            
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/CRM_HelpdeskActivityProjectMapping/GetHelpdeskProjectList", param, false);
            strHTMLProject = "";           
            var select = "Select Project";          
            if (strResult.length > 0) {
                strHTMLProject += '<select id="cboProject_'+ EmployeeID +'" name="cboProject_'+ EmployeeID +'" tabindex="1" Onchange="OnChangeProject(this.id)" class="form-control" selectpicker="">'
                strHTMLProject += '<option value="' + 0 + '">' + select + '</option>';
                for (var i = 0; i < strResult.length; i++) {
                    var ProjectID = strResult[i].ProjectId;
                    var ProjectName = strResult[i].ProjectName; 
                    if (SelectedProjectID == ProjectID) {
                        strHTMLProject += '<option value="' + ProjectID + '" Selected>' + ProjectName + '</option>';
                    }
                    else {
                        strHTMLProject += '<option value="' + ProjectID + '">' + ProjectName + '</option>';
                    }
                }
                strHTMLProject += '</select>';
            }
            else{
                strHTMLProject += '<select id="cboProject_'+ EmployeeID +'" name="cboProject_'+ EmployeeID +'" tabindex="1" Onchange="OnChangeProject(this.id)" class="form-control" selectpicker="">'
                strHTMLProject += '<option value="' + 0 + '">' + select + '</option>';                                             
                strHTMLProject += '<option value=""></option>';
                strHTMLProject += '</select>';
            }
           
        }
        
        //bind Selected Project To DropDown
        function GetHelpdeskProject(EmployeeID){
            var RequestParameters = {
                intEmployeeID: encodeURI(EmployeeID),                            
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/CRM_HelpdeskActivityProjectMapping/GetHelpdeskProject", param, false);
            if (strResult != undefined) {
                return strResult;
            }
        }

        //onchange function foe dropdown       
        var ProjectIDs='';
        var EmployeeIDs = '';    
        function OnChangeProject(id) {
            //Added by Riddhesh Patil on 03 Oct 2024 for clearing Project and Employee Id after saving data for History Issue
            ProjectIDs = '';
            EmployeeIDs = '';
            //End of Added by Riddhesh Patil on 03 Oct 2024 for clearing Project and Employee Id after saving data for History Issue
            var EmployeeID = id.split('_');
            EmployeeID = EmployeeID[1];                 
            var ProjectID = $('#' + id).val();
                      
            ProjectIDs = ProjectIDs + ProjectID + ',';
            EmployeeIDs = EmployeeIDs + EmployeeID + ',';
        }


        //function for Saving Data 
        function SaveData() {
            
            StartLoader("#HelpdeskProjectMapping");
                   
            //var ProjectIDs='';
            //var EmployeeIDs = '';           
            //for (var i = 0; i < arrEmployeeIDs.length; i++) {
            //    var EmployeeID = arrEmployeeIDs[i];

            //        var ProjectID = $('#cboProject_' + EmployeeID).val();
                  
            //            ProjectIDs = ProjectIDs + ProjectID + ',';
            //            EmployeeIDs = EmployeeIDs + EmployeeID + ',';
                  
            //}          
         
             var RequestParameters = {
                 strEmpolyeeIDs: encodeURI(EmployeeIDs),
                 strProjectIDs:encodeURI(ProjectIDs)
                            
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/CRM_HelpdeskActivityProjectMapping/SaveHelpdeskProjectActivitymapping", param, false);
            if (strResult != undefined) {              
                 alertify.set('notifier', 'position', 'top-right');
                 alertify.success("Project Mapped SuccessFully");
            }
             StopAjaxLoader("#HelpdeskProjectMapping");
        }

        //Get Resource History
        function History_onClick(EmployeeID) {
         
            $("#HelpRequestHistoryModal").modal('show');
            StartLoader("#HelpdeskProjectMapping");
            var RequestParameters = {
                intEmployeeID: encodeURI(EmployeeID),                            
            }
             $("#HelpRequestHistory").dataTable().fnDestroy();
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/CRM_HelpdeskActivityProjectMapping/GetHelpdeskProjectHistory", param, false);
            if (strResult != undefined) {
                $("#HelpRequestHistoryBody").html("");
                var strHTML = "";
                for (var i = 0; i < strResult.length; i++) {                    
                    var ProjectName = strResult[i].ProjectName;
                    var ModifiedDate = strResult[i].ModifiedDate;

                    strHTML += '<tr>'
                    strHTML += '<td>' + ProjectName + '</td>'
                    strHTML += '<td>' + ModifiedDate +'</td>'
                    strHTML +='</tr>'

                }
                $("#HelpRequestHistoryBody").html("");
                $("#HelpRequestHistoryBody").append(strHTML);
                PaginationHistory("#HelpRequestHistory");
            }
             StopAjaxLoader("#HelpdeskProjectMapping");
        }

         function PaginationHistory(PageID) {
            var stdTable1 = $(PageID).DataTable({
                "pageLength": 5,
                "lengthChange": false,
                "bFilter": false,
                "responsive": true,
                "scrollY":"120px",
                "retrieve": true,               
                "columnDefs": [{
                    'width': '15%',
                    "orderable": false                    
                },]
            });
           
             $('#HelpRequestHistoryModal').on('shown.bs.modal', function () {
              $.fn.dataTable.tables( {visible: true, api: true} ).columns.adjust();
             }); 
              setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 350);
            
        }
        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {

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
                    ajaxResult = data;
                },
                error: function (err) {
                    ajaxResult = undefined;
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }






        $("[data-toggle='tooltip']").tooltip();

        $(".progress span, .progress div").hover(function () {
            $(this).parent().tooltip("disable");
        }, function () {
            $(this).parent().tooltip("enable");
        });


        
        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 350);

      
    </script>



</body>
</html>
