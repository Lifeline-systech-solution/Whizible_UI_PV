<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjecKernel.aspx.vb" Inherits="PbNIT.PM_ProjecKernel" %>

<%--<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjecKernel.aspx.vb" Inherits="PbNIT.PM_ProjecKernel" %>--%>
<!DOCTYPE html>
<html>
    <!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
      <%CommonFunctions.General.PlotPageHeadTag("Project")%>
<head>
 
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
     <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.3.2.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">
  
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">--%>
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />

<%--    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

</head>
      <style>
         .practicesettinglist .table {
    margin-bottom: 0px;
}
        #tblkernel thead {
            display: none;
        }

        #tblkernel_wrapper {
            margin: 0px auto;
            width: 97% !important;
        }

        #tblkernel {
            width: 100% !important;
        }

        .alertify-notifier {
            z-index: 9999 !important;
        }
        /*Added by Omkar T on 11-01-20*/
#tblkernel_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sorting_asc:after,#tblkernel_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sorting_desc:after {/*left: 80px !important;*/ top:20px!important; }/*modified by pradip on 12-4-2023*/

    </style>
<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <div id="divProjectKernal" class="practicesettinglist">
        <div class="modalpgHead  pt-1 pb-1 col-sm-12">
            <span>Project Kernels</span>
        </div>
        <h5 class="float-start pl-20 pt-3 clearfix">Project Name : <span id="spnProjectName"></span></h5>
        <%--<b><span id="spnProjectName"></span></b>--%>
        <!--ps_list_table_start-->
        <div class="tab-pane pstbl_karnels pt-0 in active" id="pstbl_karnels">
            <table id="tblkernel" class="table table-stripped table-bordered tbl-keywords">
                <thead>
                    <tr>
                        <th><%= MyBase.GetResourceString("C_Kernels") %></th>
                        <th class="sm-wid">
                            <div class="custom_chckbox">
                                <input id="kernelsAll" class="chckHead" type="checkbox" onclick="checkAllCheckBox()">
                                <label for="kernelsAll"></label>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="tblbdykernel">
                   
                </tbody>
            </table><br /><br />
            <div class="root-add-btn pt-20 pl-20">
                
                <a href="javascript:;" class="btn borderbtn mr-5" id="addRow" onclick="AddKernel()"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %></a>
                <button id="delete-row" class="btn borderbtn" onclick="btnclickDeltedKernel()">Delete</button>
            </div>
        </div>
        <!--ps_list_table_end-->

        <!--Add new site modal end here-->

        <!--Add_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="addKernelsPopup" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Project_Kernels") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row mb-3">
                                <label class="control-label required col-sm-4 text-end"><%= MyBase.GetResourceString("C_Kernel") %> </label>
                                <span id="KernelId" class="col-sm-1"></span>
                                <div class="col-sm-6">
                                  
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboKernel", "usp_Whizible2_Sel_tbl_IB_Kernels",,, "class='form-select '",,,) %>
                                </div>
                            </div>
                        </div>
                        <!--<label class="control-label col-sm-4">&nbsp;</label>-->
                        <div class="btns-center btn-grp-new">
                            <button class="btn borderbtn" onclick="cancelData()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Close") %></button>
                            <button class="btn btnyellow float-end ml-1" onclick="AddKernelData()"><%= MyBase.GetResourceString("C_Save") %></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Add_new_Sub_tasktype_modal_end_here-->

        <!--Add_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="CPaddSubtaskModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Add New Sub Task</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-sm-4">Sub Task Type</label>
                                <div class="col-sm-8">
                                    <select class="form-select selectpicker">
                                        <option>Risk Analysis</option>
                                        <option>Requirement Analysis</option>
                                        <option>Feasibility Study</option>
                                        <option>Documentation</option>
                                        <option>Defect Analysis</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-sm-4">&nbsp;</label>
                                <div class="col-sm-8">
                                    <button data-bs-dismiss="modal" class="btn borderbtn">Close</button>
                                    <button data-bs-dismiss="modal" class="btn btnyellow float-end ml-1">Save</button>
                                    <button data-bs-dismiss="modal" class="btn btnyellow float-end">Save and Add</button>

                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!--Add_new_Sub_tasktype_modal_end_here-->

        <!--Delete_new_Sub_tasktype_modal_Start_here-->
        <div class="modal custmodal fade" id="CPdelSubtaskModal" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header"> 
                        <h5 class="modal-title" id="">Delete Sub Task</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <h5>
                                <center>Are you sure you want to delete these records?</center>
                            </h5>
                        </div>
                        <br />
                        <center>
                                    <button data-bs-dismiss="modal" class="btn borderbtn">No</button>
                                    <button data-bs-dismiss="modal" class="btn btnyellow ml-1">Yes</button>
                                </center>

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!--Delete_new_Sub_tasktype_modal_end_here-->
        <!--  DELETE kernel Modal Start here-->
        <div id="deleteProjectKernelinfomodal" class="modal fade custmodal" role="dialog">
            <div class="modal-dialog modalsmall">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h5 class="modal-title"><%= MyBase.GetResourceString("C_Delete") %></h5>
                    </div>

                    <div class="modal-body">

                        <span id="DeleteKernelId"></span>

                        <p align="center"><%= MyBase.GetResourceString("C_Delete_Confirmation") %></p>

                        <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" onclick="cancelKernelDelted()"><%= MyBase.GetResourceString("C_No") %></button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="DeleteKernelData()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Yes") %></button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <!-- DELETE kernel Modal end here-->

        <!-- ./wrapper -->
        <!-- REQUIRED JS SCRIPTS -->
    
<!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
<%--        <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
       <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
        <!-- jqueryUI js -->
        <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>        
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
        <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
        <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
         <script src="../../General/CommonValidations.js"></script>--%>

        <script>
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

            var ProjectID = "<%= Request.QueryString("ProjectID") %>";
            var editaccess = "<%= m_PM_ProjectKernelEditAccess.ToString() %>";
            var UserName = '<%= Session("strUserName") %>';
            var ViewAccess = "<%= m_PM_ProjectKernelViewAccess %>";

            $(document).ready(function () {
                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divProjectKernal").html(bodyHTML);
                    return;
                }
              <%If m_PM_ProjectKernelAddAccess = False Then%>
            $("#pstbl_karnels > div>a#addRow").hide();
           
             <%End If %>
            <%If m_PM_ProjectKernelDeleteAccess = False Then%>
            $("#pstbl_karnels > div>#delete-row").hide();
            
             <%End If %>
                // alert(editaccess);
                getProjectKernelData(ProjectID);
                getProjectName(ProjectID);
            });

           
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

            $('#newprostartdate, #newproenddate').datepicker({
                autoclose: true,
                changeMonth: true,
                dateFormat: 'dd M yy'
            });


            $('#RRdate').datepicker({
                autoclose: true,
            });

            var Kernelids = [];
            var Kernels = [];
            function getProjectKernelData(ProjectId) {
                var ProjectId = ProjectId;
                $("#tblkernel").dataTable().fnDestroy();
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetKernelDetails',
                    method: 'Post',
                    data: JSON.stringify(ProjectId),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ProjectId) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ProjectId) ? ProjectId : JSON.stringify(ProjectId)));
                        }
                    },
                    success: function (result) {
                        console.log(result);

                        //spandatabind(result.ProjectClosureCount);
                        //taskids = [];
                        Kernelids = [];
                        Kernels = [];
                        arrKernelIds = [];
                        var GetKernelData = result.GetKernelData;
                        $("#tblbdykernel").empty();
                        var strHTML = "";
                        for (var i = 0; i < GetKernelData.length; i++) {
                            var ProjectKernelID = GetKernelData[i]["ProjectKernelID"];
                            var Kernel = GetKernelData[i]["Kernels"];
                            Kernels.push(Kernel);
                            Kernelids.push(ProjectKernelID);
                            strHTML += " <tr>";
                            if (editaccess == "True") {


                                // strHTML += "<td><a href='#'  onClick='updateKernels("+Kernels+","+ProjectKernelID+")'>" + Kernels + "</a></td>"
                                strHTML += "<td><a href='#' id='lnk" + ProjectKernelID + "'  onClick='updateKernels(this.id)'>" + Kernel + "</a></td>"
                            } else {
                                strHTML += "<td>" + Kernel + "</td>"
                            }
                            strHTML += "<td class='sm-wid'>"
                            strHTML += "<div class='custom_chckbox'>"
                            strHTML += "<input id='kernal" + ProjectKernelID + "' class='chckernel' type='checkbox' onchange = 'chkbxclickevent(this.id)'>"
                            strHTML += "<label for='kernal" + ProjectKernelID + "'></label>"
                            strHTML += "</div>"
                            strHTML += "</td>"
                            strHTML += "</tr>";




                        }
                        $("#addKernelsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboKernel option ").show();
                       
                        $("#tblbdykernel").html(strHTML);
                       
                        //$("#taskclosurtbl1").dataTable();
                        //Pagination("taskclosurtbl");
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        $("#tblkernel").DataTable({
                            "scrollY": 'auto',
                            "scrollX": true,
                            "pageLength": 5,
                            "lengthChange": false,
                            "bFilter": false,
                            "ordering": true,
                            "responsive": true,
                            "retrieve": true,
                            "columnDefs": [{
                                "targets": 1,
                                "orderable": false,
                            }]

                        });
                        //#tblkernel_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled
                        $("#tblkernel_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled").css("outline", "0px");
                        //$("#taskclosurtbl").attr("class", "taskclosurtbl");
                        if ($("#tblbdykernel").find("tr").find("td").hasClass("dataTables_empty")) {
                            $("#tblkernel tbody tr td").css("cssText", "text-align:center!important;");
                        }

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            function GetProjectKernelList() {
                if ($("#addKernelsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboKernel option[value='0']").length == 0) {

                    //Commented And Added By Reshma on 21st Dec 2019 For Selector
                    //$("#addKernelsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboKernel").prepend("<option value='0' >-- Select Kernel -- </option>");
                    $("#addKernelsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboKernel").prepend("<option value='0' > Select Kernel </option>");
                     //End Added By Reshma on 21st Dec 2019 For Selector
                }
                $("#addKernelsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboKernel").prop("selectedIndex", 0);
                // $('[data-bs-toggle="tooltip"]').tooltip();

            }

            function AddKernel() {
                $('#KernelId').attr('value', 0);
                GetProjectKernelList();
                $("#addKernelsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboKernel option ").show();
               
                $("#addKernelsPopup").modal("show");

            }
            function getURLParameter(url, name) {
                return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
            }
            function refreshMyParent() {
                var newpath = opener.window.location.href;
                if (newpath.indexOf('FromWhereProjectId') == -1) {
                    newpath = opener.window.location.href.replace('#', '?');
                    newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ProjecKernel%>'&Mode=Edit&update=done";
                }
                newpath = newpath.toString().replace("&update=done", "");
                var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                var currentToken = getURLParameter(newpath, "PKToken");
                newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ProjecKernel%>');
                newpath = newpath.toString().replace("FromWhereProjectId=" + currentFromWhereProjectId, "FromWhereProjectId=" + '<%= Request.QueryString("ProjectID") %>');
                newpath = newpath.toString().replace("FromWhereData=D", "FromWhereData=C");
                if (newpath.indexOf("Add#") != -1) {
                    newpath = newpath.toString().replace("Add#", "Edit&update=done");
                }
                else if (newpath.indexOf("Edit#") != -1) {
                    newpath = newpath.toString().replace("Edit#", "Edit&update=done");
                }
                else if (newpath.indexOf("Edit") != -1) {
                    newpath = newpath.toString().replace("Edit", "Edit&update=done");
                }
                opener.window.location.replace(newpath);
            }
            var Kernelsupdated = [];
            function AddKernelData() {

                //  //debugger
                var KernelId = $("#KernelId").attr("value");


                ////alert(tagid);
                var kerneltext = $("#addKernelsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboKernel option:selected").text();
                var kernelvalue = $("#addKernelsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboKernel option:selected").val();
                var flag = true;

                if (kernelvalue == 0 || kernelvalue == '0') {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Kernel_blank") %>';
                    alertify.error(message);
                    //alertify.error("Kernel should not be left blank.");
                    flag = false;
                }
                if (KernelId == 0) {
                    if (Kernels.indexOf(kerneltext) != -1) {
                        alertify.set('notifier', 'position', 'top-right');
                        var message = '<%= MyBase.GetResourceString("C_Kernel_exists") %>';
                        alertify.error(message);
                        //alertify.error("Kernel already exists.");
                        flag = false;
                    }
                } else {
                    //alert(Kernels);
                    // alert(Kernelupdate);
                    Kernelsupdated = jQuery.grep(Kernels, function (value) {
                        return value != Kernelupdate;
                    });
                    // alert(Kernelsupdated);

                    // console.log(Kernelsupdated);
                    if (Kernelsupdated.indexOf(kerneltext) != -1) {
                        alertify.set('notifier', 'position', 'top-right');
                        var message = '<%= MyBase.GetResourceString("C_Kernel_exists") %>';
                        alertify.error(message);
                        // alertify.error("Kernel already exists.");
                        flag = false;
                        Kernelsupdated = [];
                    }
                }
                if (flag == true) {


                    if (KernelId == 0) {
                        ////alert(tagid);
                        SaveUpdateKernel(KernelId);
                        // DeleteLessonLearntData(deleteid);

                    } else {
                        SaveUpdateKernel(KernelId);
                    }
                   
                    refreshMyParent();
                }

            }
            function cancelData() {

                var KernelId = $("#KernelId").attr("value");

                //alert(deleteDocumnetid);
                if (KernelId != undefined || KernelId != null) {//Added By Dipali v On 30th Jun 2020 For Javascript Issues
                    if (KernelId.length != 0) {
                      
                    }
                }


            }
            function SaveUpdateKernel(KernelId) {
                // var kerneltext = $("#addKernelsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboKernel option:selected").val();
                var kerneltext = $('#cboKernel :selected').text();

                var kernelsdata = {
                    ProjectId: encodeURI(ProjectID),
                    CreatedBy: encodeURI(UserName),
                    KernelId: encodeURI(KernelId),
                    Kernel: encodeURI(kerneltext)

                }

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/SaveKernelData',
                    method: 'Post',
                    data: JSON.stringify(kernelsdata),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (kernelsdata) {
                            xhr.setRequestHeader("Params", encryptString(isJson(kernelsdata) ? kernelsdata : JSON.stringify(kernelsdata)));
                        }
                    },
                    success: function (result) {
                        if (KernelId == 0) {
                            alertify.set('notifier', 'position', 'top-right');
                            var message = '<%= MyBase.GetResourceString("C_Kernel_add_SuccessFully") %>';
                            alertify.success(message);
                            //alertify.success("Kernel add SuccessFully");

                        } else {
                            alertify.set('notifier', 'position', 'top-right');
                            var message = '<%= MyBase.GetResourceString("C_Kernel_Update_SuccessFully") %>';
                            alertify.success(message);
                            // alertify.success("Kernel Update SuccessFully");
                        }
                        cancelData();
                        getProjectKernelData(ProjectID);

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            var arrKernelIds = [];
            function chkbxclickevent(chkbxid) {

                //debugger
                var kernelid = chkbxid.replace("kernal", "");
                kernelid = parseInt(kernelid);
                var value = $("#" + chkbxid).is(':checked');
                if (value == true) {
                    if (arrKernelIds.indexOf(kernelid) == -1) {
                        arrKernelIds.push(kernelid);
                        //console.log(arrTaskIds);

                    }
                    if (arrKernelIds.length == Kernelids.length) {
                        $("#tblkernel_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled > div>input#kernelsAll").prop('checked', true);
                    }
                } else {
                    kernelid = parseInt(kernelid);
                    if (arrKernelIds.indexOf(kernelid) != -1) {
                        //var pos = arrTaskIds.indexOf(taskid);
                        /// arrTaskIds.pop(pos);

                        arrKernelIds = jQuery.grep(arrKernelIds, function (value) {
                            return value != kernelid;
                        });

                        // console.log(arrTaskIds);
                        //#taskclosurtbl_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr>th#closeall>div #checkboxcloseall
                        var value1 = $("#tblkernel_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled > div>input#kernelsAll").is(':checked');
                        //      alert(value1);
                        if (value1 == true) {


                            $("#tblkernel_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled > div>input#kernelsAll").prop('checked', false);

                        }
                    }
                }
            }


            function checkAllCheckBox() {
              
                var allPages = $("#tblkernel").dataTable().fnGetNodes();
              
                var value = $("#tblkernel_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled > div>input#kernelsAll").is(':checked');
                if (value == true) {
                    for (var i = 0; i < Kernelids.length; i++) {
                        var kernelid = Kernelids[i];
                       
                        if (arrKernelIds.indexOf(kernelid) == -1) {
                            arrKernelIds.push(kernelid);

                        }
                    }
                    $(allPages).find("input[type='checkbox']").not(":disabled").prop('checked', true);

                } else {
                    for (var i = 0; i < Kernelids.length; i++) {
                        var kernelid = Kernelids[i];
                       
                        $(allPages).find("input[type='checkbox']").not(":disabled").prop('checked', false);
                    }
                    arrKernelIds = [];
                   
                }
            }

            function btnclickDeltedKernel() {
                if (arrKernelIds.length > 0) {
                    $("#deleteProjectKernelinfomodal").modal("show");
                } else {
                    alertify.set('notifier', 'position', 'top-right');

                    alertify.error("Please Select Atleast One Record To Delete.");
                }
            }

            function DeleteKernelData() {

                DeleteKernel();
                var value1 = $("#tblkernel_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled > div>input#kernelsAll").is(':checked');
                //      alert(value1);
                if (value1 == true) {


                    $("#tblkernel_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled > div>input#kernelsAll").prop('checked', false);

                }
                refreshMyParent();
            }
            function cancelKernelDelted() {

                $("#deleteProjectKernelinfomodal").modal("hide");

            }
            function DeleteKernel() {
                // var kernel = $("#addKernelsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboKernel").text();
                if (arrKernelIds.length > 0) {


                    var kernelsdata = {
                        ProjectId: encodeURI(ProjectID),
                        KernelIds: arrKernelIds,
                    }
                  //  alert(JSON.stringify(kernelsdata));
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_ProjectSettings/DeleteKernel',
                        method: 'Post',
                        data: JSON.stringify(kernelsdata),
                        dataType: 'json',
                        async: false,
                        contentType: "application/json",
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        },
                        success: function (result) {
                            console.log(result);
                            alertify.set('notifier', 'position', 'top-right');
                            var message = '<%= MyBase.GetResourceString("C_Kernel_Deleted_SuccessFully") %>';
                            if (result != null && result != "") {
                                
                                if (result.toString().indexOf("deleted successfully") != -1) {
                                    alertify.success(result);
                                }
                                else {
                                    alertify.error(result);
                                }
                            }
                            //alertify.success("Kernel Deleted SuccessFully");

                            getProjectKernelData(ProjectID);

                        },
                        error: function (err) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
            }
            var Kernelupdate;
            function updateKernels(id) {
                Kernelupdate = "";
                var kernelid = id.replace('lnk', '');                 
                var kernel = $("#" + id).text()
                Kernelupdate = kernel;
                $('#KernelId').attr('value', kernelid);
                GetProjectKernelList();
               
                var kernelValue = kernel.replace(/'/g, "\\'");
                $("#addKernelsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboKernel option[value='" + kernelValue + "']").show();
                $("#addKernelsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboKernel option[value='" + kernelValue + "']").prop('selected', true);
                //End Of Added By Usha Pandit On 11.06.2020 for escaping single quote

                $("#addKernelsPopup").modal("show");
                //GetProjectKernelList();


            }

            function getProjectName(ProjectId) {
                var Parameter = { ProjectId: ProjectId }

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetProjectName',
                    method: 'Post',
                    data: JSON.stringify(Parameter),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (Parameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameter) ? Parameter : JSON.stringify(Parameter)));
                        }
                    },
                    success: function (result) {
                        //console.log(result);
                        $("#spnProjectName").text(result);

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

        </script>
    </div>
</body>

</html>
