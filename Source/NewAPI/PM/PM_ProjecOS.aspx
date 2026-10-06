<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjecOS.aspx.vb" Inherits="PbNIT.PM_ProjecOS" %>

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
  --%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />

   
</head>

    <style>
        /*CSS Added/commented ruby Madhuri.K content 02-Sep-2024 for adject space between pagination command count*/
     div.dataTables_wrapper div.dataTables_info {
    padding-top: 1px;
}

.dataTables_info {
    padding-top: 1px;
}
.dataTables_info {
    margin-top: 10px;
    float: left;
}
/*CSS Added/commented ruby Madhuri.K content 02-Sep-2024 for adject space between pagination command count*/
        #tblprojectos thead {
            display: none;
        }

        #pstbl_projectOs .tbl-keywords {
            margin-bottom: 0px;
        }

        #tblprojectos_wrapper {
            margin: 0px auto;
            width: 97% !important;
        }

        .table {
            width: 100% !important;
        }

        #pstbl_projectOs .root-add-btn {
            margin-left: 0px;
        }

        .alertify-notifier {
            z-index: 9999 !important;
        }
        /*Added by Omkar T on 11-01-20*/
#tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sorting_asc:after, #tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sorting_desc:after {/*left:50px !important;*/ top:20px!important;}/*modified by pradip on 12-4-2023*/
    </style>
   
<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <div id="divProjectOS" class="practicesettinglist">
        <!--ps_list_table_start-->
        <div class="tab-pane pstbl_projectOs pt-0 in active" id="pstbl_projectOs" style="border-top: 1px solid #ddd;">
            <div class="modalpgHead  pt-1 pb-1 col-sm-12">
                <span>Project OS</span>
            </div>
            <h5 class="pull-left pl-20 pt-3 clearfix">Project Name : <span id="spnProjectName"></span></h5>
          
            <table id="tblprojectos" class="table table-stripped table-bordered tbl-keywords">
                <thead>
                    <tr>
                        <th><%= MyBase.GetResourceString("C_OS") %></th>
                        <th class="sm-wid">
                            <div class="custom_chckbox">
                                <input id="projectOsAll" class="chckHead" type="checkbox" onclick="checkAllCheckBox()">
                                <label for="projectOsAll"></label>
                            </div>
                        </th>
                    </tr>
                </thead>
                <tbody id="tblbdyprojectos">
                   
                </tbody>
            </table><br /><br/>
            <div class="root-add-btn pt-20 pl-20">
                <a href="javascript:;" class="btn borderbtn mr-5" id="addRow" onclick="AddProjectOS()"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("C_Add") %></a>
                <button id="delete-row" class="btn borderbtn" onclick="btnclickDeltedProjectOS()">Delete</button>
            </div>
        </div>

        <!--Add new site modal end here-->

        <!--Add new project os start here-->
        <div class="modal custmodal fade" id="addOsPopup" aria-hidden="true">
            <div class="modal-dialog modalsmall ui-draggable" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_Project_OS") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group mb-3">
                            <div class="row mb-3 d-flex justify-content-center">
                                <label class="control-label required col-sm-4 text-right"><%= MyBase.GetResourceString("C_OS") %></label>
                                <span id="ProjectOSId" class="col-sm-1"></span>
                                <div class="col-sm-6">
                                    
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectos", "usp_Whizible2_Sel_tbl_IB_OS",,, "class='form-select '",,,) %>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 btns-center btn-grp-new">
                                <button data-bs-dismiss="modal" class="btn borderbtn" onclick="cancelProjectOSData()"><%= MyBase.GetResourceString("C_Close") %></button>
                                <button class="btn btnyellow pull-right ml-1" onclick="AddProjectOSData()"><%= MyBase.GetResourceString("C_Save") %></button>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>
        <!--Add new project os end here-->

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
                                    <button data-bs-dismiss="modal" class="btn btnyellow pull-right ml-1">Save</button>
                                    <button data-bs-dismiss="modal" class="btn btnyellow pull-right">Save and Add</button>

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

        <!--  DELETE Modal Start here-->
        <div id="deleteProjectOSinfomodal" class="modal fade custmodal" role="dialog">
            <div class="modal-dialog modalsmall ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                        <h5 class="modal-title"><%= MyBase.GetResourceString("C_Delete") %></h5>
                    </div>

                    <div class="modal-body">

                        <span id="DeleteProjectOSId"></span>

                        <p align="center"><%= MyBase.GetResourceString("C_Delete_Confirmation") %></p>

                        <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-left">
                                    <button class="btn borderbtn ml-1" onclick="cancelProjectOSDelted()"><%= MyBase.GetResourceString("C_No") %></button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 pull-right" onclick="DeleteProjectOSData()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("C_Yes") %></button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <!-- DELETE Modal end here-->




        <%--</section>--%>

        <%--</div>--%>
        <!-- /.content-wrapper -->
        <%--</div>--%>
         
        <!-- ./wrapper -->

             <!-- REQUIRED JS SCRIPTS -->
        <!-- Commented by Madhuri.K on 09-08-2024 for JQuery and Bootstrap version upgrade -->
<%--         <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>
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
            var ProjectOSeditaccess = "<%= m_PM_ProjectOSEditAccess.ToString() %>";
            var UserName = '<%= Session("strUserName") %>';
            var ViewAccess = '<%= m_PM_ProjectOSViewAccess %>';

            $(document).ready(function () {

                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divProjectOS").html(bodyHTML);
                    return;
                }
              <%If m_PM_ProjectOSAddAccess = False Then%>
            $("#pstbl_projectOs > div>a#addRow").hide();
            //alert("you have add access");
            //strHTML += '<a href="javascript:;" class="copy"><i data-toggle="tooltip" data-placement="bottom" data-container="body" title="Copy" class="far fa-copy Copy" id="CopySP' + SubProjectID + '" onclick="SubProjectEditAdd(this.id)" ></i></a> <a href="javascript:;" class="add" title="" data-toggle="tooltip" data-container="body" data-original-title="Save"> <img class="material-icons" src="dist/img/save.svg" alt="" width="16px">  </a>'
             <%End If %>
            <%If m_PM_ProjectOSDeleteAccess = False Then%>
            $("#pstbl_projectOs > div>#delete-row").hide();
            //alert("you have add access");
            //strHTML += '<a href="javascript:;" class="copy"><i data-toggle="tooltip" data-placement="bottom" data-container="body" title="Copy" class="far fa-copy Copy" id="CopySP' + SubProjectID + '" onclick="SubProjectEditAdd(this.id)" ></i></a> <a href="javascript:;" class="add" title="" data-toggle="tooltip" data-container="body" data-original-title="Save"> <img class="material-icons" src="dist/img/save.svg" alt="" width="16px">  </a>'
             <%End If %>
                // alert(editaccess);
                getProjectName(ProjectID);
                getProjectOSData(ProjectID);
            });



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

            $('#newprostartdate, #newproenddate').datepicker({
                autoclose: true,
                changeMonth: true,
                dateFormat: 'dd M yy'
            });


            $('#RRdate').datepicker({
                autoclose: true,
            });
            var ProjectOSids = [];
            var ProjectOS = [];
            var arrProjectOSIds = [];

            function getProjectOSData(ProjectId) {
                //var ProjectId = ProjectId;
                var projectosdata = {
                    ProjectID: ProjectId
                }
                $("#tblprojectos").dataTable().fnDestroy();
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetProjectOSDetails',
                    method: 'Post',
                    data: JSON.stringify(projectosdata),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (projectosdata) {
                            xhr.setRequestHeader("Params", encryptString(isJson(projectosdata) ? projectosdata : JSON.stringify(projectosdata)));
                        }
                    },
                    success: function (result) {
                        console.log(result);
                        //debugger
                        //spandatabind(result.ProjectClosureCount);
                        //taskids = [];
                        ProjectOSids = [];
                        ProjectOS = [];
                        arrProjectOSIds = [];
                        var GetProjectOSData = result.GetProjectOSData;
                        console.log();
                        
                        $("#tblbdyprojectos").empty();
                        var strHTML = "";
                       
                        for (var i = 0; i < GetProjectOSData.length; i++) {
                            var ProjectOSID = GetProjectOSData[i]["ProjectOSID"];
                            var OS = GetProjectOSData[i]["OS"];
                            ProjectOS.push(OS);
                            ProjectOSids.push(ProjectOSID);
                            strHTML += " <tr>";
                            if (ProjectOSeditaccess == "True") {


                                // strHTML += "<td><a href='#'  onClick='updateKernels("+Kernels+","+ProjectKernelID+")'>" + Kernels + "</a></td>"
                                strHTML += "<td><a href='#' id='lnk" + ProjectOSID + "'  onClick='updateProjectOS(this.id)'>" + OS + "</a></td>"
                            } else {
                                strHTML += "<td>" + OS + "</td>"
                            }
                            strHTML += "<td class='sm-wid'>"
                            strHTML += "<div class='custom_chckbox'>"
                            strHTML += "<input id='projectos" + ProjectOSID + "' class='chckernel' type='checkbox' onchange = 'ProjectOSchkbxclickevent(this.id)'>"
                            strHTML += "<label for='projectos" + ProjectOSID + "'></label>"
                            strHTML += "</div>"
                            strHTML += "</td>"
                            strHTML += "</tr>";




                        }
                        
                        $("#addOsPopup > div > div > div > div > div > div>select#cboProjectos option ").show();
                        //uncommented by omkar 18/3/2020
                        //Commented By Reshma on 21st Dec 2019 For IssueID-20966
                        if (ProjectOS != undefined || ProjectOS != null) {//Added By Dipali V 9th Jun 2020 For IssueID 24996
	                        for (var i = 0; i < ProjectOS.length; i++) {
	                            //Commented And Added By Usha Pandit On 10.06.2020 For escaping quotes in string
	                            //$("#addOsPopup > div > div > div > div > div > div>select#cboProjectos option[value='" + ProjectOS[i] + "']").hide();
                                var strProjectOS = ProjectOS[i].toString().replace(/'/g, "\\'");
                                //Commented By Usha Pandit On 02.09.2020 For close popup issue
	                            //$("#addOsPopup > div > div > div > div > div > div>select#cboProjectos option[value='" + strProjectOS + "']").hide();
                                //End Of Commented By Usha Pandit On 02.09.2020 For close popup issue
	                            //End Of Added By Usha Pandit On 10.06.2020 For escaping quotes in string
	                        }
                        }
                        //End Commented By Reshma on 21st Dec 2019 For IssueID-20966
                        //end of uncommeted by omkar 18/3/2020
                        //  $("#taskclosurtblbdy").html("");
                        $("#tblbdyprojectos").html(strHTML);
                        //$("#taskclosurtbl1").dataTable();
                        //Pagination("taskclosurtbl");
                        $('[data-toggle="tooltip"]').tooltip();
                        $("#tblprojectos").DataTable({
                            "scrollY": 'auto',
                            "scrollX": true,
                            "pageLength": 3,
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

                        //$("#taskclosurtbl").attr("class", "taskclosurtbl");
                        $("#tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled").css("outline", "0px");
                        if (strHTML == "") {
                            $("#tblprojectos tbody tr td").css("cssText", "text-align: center !important;");
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            function AddOption() {
                if ($("#addOsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboProjectos option[value='0']").length == 0) {


                    $("#addOsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboProjectos").prepend("<option value='0' > Select Project OS </option>");
                }
                $("#addOsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboProjectos").prop("selectedIndex", 0);
                // $('[data-toggle="tooltip"]').tooltip();

            }
            function AddProjectOS() {
                $('#ProjectOSId').attr('value', 0);
                AddOption();
                $("#addOsPopup > div > div > div > div > div > div>select#cboProjectos option ").show();
                //uncommented by omkar 18/3/2020
                //Commented By Reshma on 21st Dec 2019 For IssueID-20966
                //end of uncommetted by omkar 18/3/2020
                if (ProjectOS != undefined || ProjectOS!=null) {//Added By Dipali V 9th Jun 2020 For IssueID 24996
	                for (var i = 0; i < ProjectOS.length; i++) {
	                    //Commented And Added By Usha Pandit On 10.06.2020 For escaping quotes in string
	                    //$("#addOsPopup > div > div > div > div > div > div>select#cboProjectos option[value='" + ProjectOS[i] + "']").hide();
	                    var strProjectOS = ProjectOS[i].toString().replace(/'/g, "\\'");
	                    $("#addOsPopup > div > div > div > div > div > div>select#cboProjectos option[value='" + strProjectOS + "']").hide();
	                    //End Of Added By Usha Pandit On 10.06.2020 For escaping quotes in string
	                }
                }
                //End Commented By Reshma on 21st Dec 2019 For IssueID-20966
                $("#addOsPopup").modal("show");
            }
            var ProjectOSupdated = [];
            function AddProjectOSData() {


                var ProjectOSId = $("#ProjectOSId").attr("value");               

                ////alert(tagid);
                var ProjectOStext = $("#addOsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboProjectos option:selected").text();
                var ProjectOSvalue = $("#addOsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboProjectos option:selected").val();
                var flag = true;

                if (ProjectOSvalue == 0 || ProjectOSvalue == '0') {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Project_OS_blank") %>';
                    alertify.error(message);
                    $("#cboProjectos").focus();
                    //alertify.error("ProjectOS should not be left blank.");
                    flag = false;
                }
            if (ProjectOSId == 0) {
                if (ProjectOS.indexOf(ProjectOStext) != -1) {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Project_OS_exists") %>';
                    alertify.error(message);
                    // alertify.error("ProjectOS already exists.");
                    flag = false;
                }
            } else {
                //alert(Kernels);
                // alert(Kernelupdate);
                ProjectOSupdated = jQuery.grep(ProjectOS, function (value) {
                    return value != ProjectOSupdate;
                });
                // alert(Kernelsupdated);

                // console.log(Kernelsupdated);
                if (ProjectOSupdated.indexOf(ProjectOStext) != -1) {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_Project_OS_exists") %>';
                        alertify.error(message);
                        //alertify.error("ProjectOS already exists.");
                        flag = false;
                        ProjectOSupdated = [];
                    }
                }
                if (flag == true) {


                    if (ProjectOSId == 0) {
                        ////alert(tagid);
                        SaveUpdateProjectOS(ProjectOSId);
                        // DeleteLessonLearntData(deleteid);

                    } else {
                        SaveUpdateProjectOS(ProjectOSId);
                    }
                    //Commented By Usha Pandit On 02.09.2020 For close popup issue
                    //$("#ProjectOSId").removeAttr("value");
                    AddProjectOS();
                    //End Of Commented By Usha Pandit On 02.09.2020 For close popup issue
                }

            }
            function cancelProjectOSData() {

                var ProjectOSId = $("#ProjectOSId").attr("value");

                //alert(deleteDocumnetid);
                if (ProjectOSId != undefined || ProjectOSId != null) {//Added By Dipali v On 30th Jun 2020 For Javascript Issues
                    if (ProjectOSId.length != 0) {
                        ////alert(tagid);
                        // DeletedPhaseById(deleteid);

                        // $("#addOsPopup").modal("hide");//Commented By Dipali V On 20th May 2020 For Issue ID 23055
                        //Commented By Usha Pandit On 02.09.2020 For close popup issue
                        //$("#ProjectOSId").removeAttr("value");
                        //End Of Commented By Usha Pandit On 02.09.2020 For close popup issue
                        //GetProjectLessonsLearnedDetails(ProjectID);
                    }
                }

            }
            function getURLParameter(url, name) {
                return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
            }
            function refreshMyParent() {
                try {
                    var newpath = opener.window.location.href;    
                    if (newpath.indexOf('FromWhereProjectId') == -1) {
                        newpath = opener.window.location.href.replace('#', '?');
                        newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ProjecOS%>'&Mode=Edit&update=done";                        
                    }
                   
                    newpath = newpath.toString().replace("&update=done", "");

                    var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                    var currentToken = getURLParameter(newpath, "PKToken");

                    newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ProjecOS%>');
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
                catch (ex) {
                    //alert(ex.message);
                }
            }
            function SaveUpdateProjectOS(ProjectOSId) {
                // var kerneltext = $("#addKernelsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboKernel option:selected").val();
                var ProjectOStext = $('#cboProjectos :selected').text();
                
                var projectosdata = {
                    ProjectId: encodeURI(ProjectID),
                    CreatedBy: encodeURI(UserName),
                    ProjectOSID: encodeURI(ProjectOSId),
                    OS: encodeURI(ProjectOStext) 
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/SaveProjectOSData',
                    method: 'Post',
                    data: JSON.stringify(projectosdata),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (projectosdata) {
                            xhr.setRequestHeader("Params", encryptString(isJson(projectosdata) ? projectosdata : JSON.stringify(projectosdata)));
                        }
                    },
                    success: function (result) {
                        if (ProjectOSId == 0) {
                            alertify.set('notifier', 'position', 'top-right');
                            // alertify.success("ProjectOS add SuccessFully");
                            var message = '<%= MyBase.GetResourceString("C_Project_OS_add_SuccessFully") %>';
                            alertify.success(message);

                        } else {
                            alertify.set('notifier', 'position', 'top-right');
                            var message = '<%= MyBase.GetResourceString("C_Project_OS_Update_SuccessFully") %>';
                            alertify.success(message);
                            //  alertify.success("ProjectOS Update SuccessFully");
                        }
                        cancelProjectOSData();
                        getProjectOSData(ProjectID);
                        //Commented By Usha Pandit On 02.09.2020 For close popup issue
                        //$("#addOsPopup").modal("hide");
                        //End Of Commented By Usha Pandit On 02.09.2020 For close popup issue
                        //Added By Reshma on 19th Dec 2019 For IssueID-20816                                               
                        refreshMyParent();
                        //End Added By Reshma on 19th Dec 2019 For IssueID-20816   
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            var ProjectOSupdate;
            function updateProjectOS(id) {
                ProjectOSupdate = "";
                var Projectosid = id.replace('lnk', '');
                // alert(id);
                var Projectos = $("#" + id).text()
                ProjectOSupdate = Projectos;
                //alert(ProjectOSupdate);
                $('#ProjectOSId').attr('value', Projectosid);
                AddOption();
                //$('#addKernelsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboKernel').find("option[value='"+kernel+"']").attr('selected', 'selected');
                //$("#addOsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboProjectos option[value=" + Projectos + "]").show();

                //Commented And Added By Usha Pandit On 10.06.2020 For escaping quotes in string
                //$("#addOsPopup > div > div > div > div > div > div>select#cboProjectos option[value='" + Projectos + "']").show();
                var strProjectOS = Projectos.toString().replace(/'/g, "\\'");
                $("#addOsPopup > div > div > div > div > div > div>select#cboProjectos option[value='" + strProjectOS + "']").show();
                //End Of Added By Usha Pandit On 10.06.2020 For escaping quotes in string

                //Commented And Added By Usha Pandit On 10.06.2020 For escaping quotes in string
                //$("#addOsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboProjectos option[value='" + Projectos + "']").prop('selected', true);
                $("#addOsPopup > div > div > div.modal-body > div:nth-child(1) > div > div>select#cboProjectos option[value='" + strProjectOS + "']").prop('selected', true);
                //End Of Added By Usha Pandit On 10.06.2020 For escaping quotes in string

                $("#addOsPopup").modal("show");
                //GetProjectKernelList();


            }

            function ProjectOSchkbxclickevent(chkbxid) {

                //debugger
                var projectosid = chkbxid.replace("projectos", "");
                projectosid = parseInt(projectosid);
                var value = $("#" + chkbxid).is(':checked');
                if (value == true) {
                    if (arrProjectOSIds.indexOf(projectosid) == -1) {
                        arrProjectOSIds.push(projectosid);
                        //console.log(arrTaskIds);

                    }
                    if (arrProjectOSIds.length == ProjectOSids.length) {
                        $("#tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled > div>input#projectOsAll").prop('checked', true);
                    }
                } else {
                    projectosid = parseInt(projectosid);
                    if (arrProjectOSIds.indexOf(projectosid) != -1) {
                        //var pos = arrTaskIds.indexOf(taskid);
                        /// arrTaskIds.pop(pos);

                        arrProjectOSIds = jQuery.grep(arrProjectOSIds, function (value) {
                            return value != projectosid;
                        });

                        // console.log(arrTaskIds);
                        //#taskclosurtbl_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr>th#closeall>div #checkboxcloseall
                        var value1 = $("#tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled > div>input#projectOsAll").is(':checked');
                        //      alert(value1);
                        if (value1 == true) {


                            $("#tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled > div>input#projectOsAll").prop('checked', false);

                        }
                    }
                }
            }

            function checkAllCheckBox() {
                // alert("check all check box");
                //debugger;
                //     $("#taskclosurtbl").dataTable().fnDestroy();
                //        var oTable = $('#taskclosurtbl').dataTable({
                //    stateSave: true
                //});

                var allPages = $("#tblprojectos").dataTable().fnGetNodes();
                //console.log(allPages);
                var value = $("#tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled > div>input#projectOsAll").is(':checked');
                if (value == true) {
                    for (var i = 0; i < ProjectOSids.length; i++) {
                        var projectosid = ProjectOSids[i];
                        // $("#chk" + taskid+".chckHead ").prop( "checked", true );
                        //$('#chk' + taskid).is(":checked");
                        if (arrProjectOSIds.indexOf(projectosid) == -1) {
                            arrProjectOSIds.push(projectosid);

                        }
                    }
                    $(allPages).find("input[type='checkbox']").not(":disabled").prop('checked', true);

                    //     console.log(arrTaskIds);
                } else {
                    for (var i = 0; i < ProjectOSids.length; i++) {
                        var projectosid = ProjectOSids[i];
                        //$('#chk' + taskid+".chckHead ").removeAttr('checked');
                        $(allPages).find("input[type='checkbox']").not(":disabled").prop('checked', false);
                    }
                    arrProjectOSIds = [];
                    //    console.log(arrTaskIds);
                }
            }
            function btnclickDeltedProjectOS() {
                if (arrProjectOSIds.length > 0) {
                    $("#deleteProjectOSinfomodal").modal("show");
                } else {
                    alertify.set('notifier', 'position', 'top-right');

                    alertify.error("Please Select Atleast One Record To Delete.");
                }

            }

            function DeleteProjectOSData() {

                DeleteProjectOS();
                var value1 = $("#tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled > div>input#projectOsAll").is(':checked');
                //      alert(value1);
                if (value1 == true) {


                    $("#tblprojectos_wrapper > div.dataTables_scroll > div.dataTables_scrollHead > div > table > thead > tr > th.sm-wid.sorting_disabled > div>input#projectOsAll").prop('checked', false);

                }

            }
            function cancelProjectOSDelted() {

                $("#deleteProjectOSinfomodal").modal("hide");

            }
            

            function DeleteProjectOS() {

                if (arrProjectOSIds.length > 0) {
					//Added By Usha Pandit On 04.05.2020 For showing proper notification for OS deletion
                    var curResult = '';
                    //End Of Added By Usha Pandit On 04.05.2020 For showing proper notification for OS deletion
                    for (var i = 0; i < arrProjectOSIds.length; i++) {

                        var ProjectOSID = arrProjectOSIds[i];

                        var projectosdata = {
                            ProjectId: encodeURI(ProjectID),
                            ProjectOSID: ProjectOSID,

                        }
                        $.ajax({
                            url: encodeURI(strUrl) + '/api/PM_ProjectSettings/DeleteProjectOS',
                            method: 'Post',
                            data: JSON.stringify(projectosdata),
                            dataType: 'json',
                            async: false,
                            contentType: "application/json",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (projectosdata) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(projectosdata) ? projectosdata : JSON.stringify(projectosdata)));
                                }
                            },
                            success: function (result) {

                                //Commented And Added By Reshma On 19th Dec 2019 For IssueID-20815

                                //alertify.set('notifier', 'position', 'top-right');
                                <%--var message = '<%= MyBase.GetResourceString("C_Project_OS_Deleted_SuccessFully") %>';
                                alertify.success(message);
                                getProjectOSData(ProjectID);--%>

                                if (result != undefined) {
                                    //Commented And Added By Usha Pandit On 04.05.2020 For showing proper notification for OS deletion
                                    //if (result.indexOf('cannot') > -1) {
                                    //    alertify.set('notifier', 'position', 'top-right');
                                    //    alertify.error(result);

                                    //}
                                    //else {
                                    //    alertify.set('notifier', 'position', 'top-right');
                                    //    alertify.success(result);
                                    //}
                                    if (result != "") {
                                        if (curResult == "") {
                                            curResult = result + "\n";
                                        }
                                        else {
                                            curResult = curResult + " " + result + "\n";
                                        }
                                    }
                                    //End Of Added By Usha Pandit On 04.05.2020 For showing proper notification for OS deletion
                                }

                                //End Added By Reshma On 19th Dec 2019 For IssueID-20815


                            },
                            error: function (err) {
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        });
                    }
					//Added By Usha Pandit On 04.05.2020 For showing proper notification for OS deletion
                    if (curResult != undefined && curResult != null && curResult != "") {
                        curResult = curResult.replace(/\n/g, "<br />");
                        if (curResult.indexOf('cannot') > -1) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(curResult);
                        }
                        else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success(curResult);
                        }
                    }
                    //End Of Added By Usha Pandit On 04.05.2020 For showing proper notification for OS deletion
                    getProjectOSData(ProjectID);
                    // Added By Reshma on 19th Dec 2019 For IssueID-20816                         
                    refreshMyParent();
                    //End Added By Reshma on 19th Dec 2019 For IssueID-20816   

                }
            }

            function getProjectName(ProjectId) {
                //var ProjectId = ProjectId; 
                var projectosdata = {
                    ProjectID: ProjectId
                } 
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetProjectName',
                    method: 'Post',
                    data: JSON.stringify(projectosdata),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (projectosdata) {
                            xhr.setRequestHeader("Params", encryptString(isJson(projectosdata) ? projectosdata : JSON.stringify(projectosdata)));
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
