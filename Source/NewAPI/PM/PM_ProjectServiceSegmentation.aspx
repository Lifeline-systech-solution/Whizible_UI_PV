<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectServiceSegmentation.aspx.vb" Inherits="PbNIT.PM_ProjectServiceSegmentation" %>

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
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">--%>
  
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1" />

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    
</head>
    <style>
        div#NoProjectDivID {
            width: 60%;
            margin: 100px auto;
            text-align: center;
            background-color: #fff;
            padding: 50px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px 0px #ddd;
        }

        #NoProjectDivID i {
            font-size: 30px;
            vertical-align: middle;
            margin-right: 10px;
            color: #ed1c24;
        }

        #tblServiceSegmentation {
            margin: 0px auto;
            width: 97% !important;
        }

/*Added & Commented By Dipali V On 7th Dec 2020 for Alignment issue*/
.table-fixed-header tbody tr th, .table tbody tr td{
      word-break:break-all !important;

}
    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <div id="divProjectServiceSegmentation">
    <!--ps_list_table_start-->
    <div class="tab-pane pstbl_segmenatation pt-0 practicesettinglist in active" id="pstbl_segmenatation" style="border-top:1px solid #ddd;">
        <div class="modalpgHead pt-1 pb-1 col-sm-12 mb-10">
            <span>Service Segmentation</span>
        </div>
        <h5 class="float-start pl-20 pt-2 clearfix">Project Name : <span id="spnProjectName"></span></h5>
        <%--<b><span id="spnProjectName"></span></b>--%>
        <div class="right-btn mb-2">
            <%If m_PM_ProjectServiceSegmentationEditAccess = True Then%>
            <a href="#" onclick="btnclickSaveProjectServiceSegmentation()" class="btn btnyellow mr-5"><%= MyBase.GetResourceString("C_Save") %></a>
            <%End If %>
           
        </div>
                                                    <table id="tblServiceSegmentation" class="table table-stripped table-bordered tbl-keywords">
                                                        <thead>
                                                            <tr>
                                                                <th><%= MyBase.GetResourceString("C_Services") %></th>
                                                                <th><%= MyBase.GetResourceString("C_Service_Offerings") %></th>
                                                                <th><%= MyBase.GetResourceString("C_Sub_Service_Offerings") %></th>
                                                                <th class="sm-wid">
                                                                    <div class="custom_chckbox">
                                                                        <input id="serSegAll" class="chckHead" type="checkbox">
                                                                        <label for="serSegAll"></label>
                                                                    </div>
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody id="tblbdyServiceSegmentation"">
                                                           
                                                        </tbody>
                                                    </table>
         <div id="NoProjectDivID" hidden="hidden" >
        <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>You have not selected any project, please select the project.</h4>
    </div>
    </div>
    <!--ps_list_table_end-->
    
    <!--Add new site modal end here-->

               
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
                                    <h5><center>Are you sure, you want to delete the selected records?</center></h5>
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

    <!-- REQUIRED JS SCRIPTS -->
    
     
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
        <!-- jqueryUI js -->
        <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>      
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>    
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
        <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
        <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../General/CommonValidations.js"></script>--%>

    <script>

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';

        var ProjectID = "<%= Request.QueryString("ProjectID") %>";
        var UserName = '<%= Session("strUserName") %>';

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

        var ck_box_cnt;
        var blnViewAccess = '<%= m_PM_ProjectServiceSegmentationViewAccess%>';
        $(document).ready(function () {
            if (blnViewAccess == "False") {
                var bodyHTML = '';
                bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                $("#divProjectServiceSegmentation").html(bodyHTML);
                return;
            }
            $("#serSegAll").click(function () {
                
                $(".serSegchck").prop('checked', $(this).prop('checked'));
            });
              <%If m_PM_ProjectServiceSegmentationAddAccess = False Then%>
            $("#pstbl_segmenatation > div > p > a").hide();
            //alert("you have add access");
            //strHTML += '<a href="javascript:;" class="copy"><i data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Copy" class="far fa-copy Copy" id="CopySP' + SubProjectID + '" onclick="SubProjectEditAdd(this.id)" ></i></a> <a href="javascript:;" class="add" title="" data-bs-toggle="tooltip" data-bs-container="body" data-original-title="Save"> <img class="material-icons" src="dist/img/save.svg" alt="" width="16px">  </a>'
             <%End If %>
            GetServiceSegmentationDetails(ProjectID);
            ck_box_cnt = $('input[type="checkbox"]').length;
            getProjectName(ProjectID);
            // CheckBoxChecked();
        });
        function occurrences(string, substring) {
            var n = 0;
            var pos = 0;

            while (true) {
                pos = string.indexOf(substring, pos);
                if (pos != -1) { n++; pos += substring.length; }
                else { break; }
            }
            return (n);
        }
		var IsData = 0; //Added By Dipali V On 9th june 20202 For Issue ID 25000
        var arrSubserviceOfferingids = [];
        var arrserviceOfferingids = [];
        function GetServiceSegmentationDetails(ProjectId) {
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectSettings/GetServiceSegmentationDetails',
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
                    $("#tblbdyServiceSegmentation").empty();
                    var strHTML = "";
                    var GetServiceSegmentationData = result.GetServiceSegmentationData;

                    var GetServiceOfferingIDs = result.GetServiceOfferingIDs;
                    var arrGetServiceOfferingIDs = [];
                    for (var i = 0; i < GetServiceOfferingIDs.length; i++) {
                        var ServiceOfferingid = GetServiceOfferingIDs[i]["ServiceOfferingID"];
                        arrGetServiceOfferingIDs.push(ServiceOfferingid);

                    }
                    var GetServicesSegmentationIDs = result.GetServicesSegmentationIDs;

                    var arrGetServicesSegmentationIDs = [];
                    for (var i = 0; i < GetServicesSegmentationIDs.length; i++) {
                        var ServicesSegmentationid = GetServicesSegmentationIDs[i]["ServicesSegmentationID"];
                        arrGetServicesSegmentationIDs.push(ServicesSegmentationid);

                    }

                    var GetSubServiceOfferingIDs = result.GetSubServiceOfferingIDs;
                    var arrGetSubServiceOfferingIDs = [];
                    for (var i = 0; i < GetSubServiceOfferingIDs.length; i++) {
                        var SubServiceOfferingid = GetSubServiceOfferingIDs[i]["SubServiceOfferingID"];
                        arrGetSubServiceOfferingIDs.push(SubServiceOfferingid);

                    }

                    for (var i = 0; i < GetServiceSegmentationData.length; i++) {

                        var ServiceOfferingID = GetServiceSegmentationData[i]["ServiceOfferingID"];
                        var ServiceOfferingName = GetServiceSegmentationData[i]["ServiceOfferingName"];
                        var ServicesSegmentation = GetServiceSegmentationData[i]["ServicesSegmentation"];
                        var ServicesSegmentationID = GetServiceSegmentationData[i]["ServicesSegmentationID"];
                        var SubServiceOfferingID = GetServiceSegmentationData[i]["SubServiceOfferingID"];
                        var SubServiceOfferingName = GetServiceSegmentationData[i]["SubServiceOfferingName"];
                        if (SubServiceOfferingName == null && ServiceOfferingName == null) {
							IsData = 1; //Added By Dipali V On 9th june 20202 For Issue ID 25000

                            strHTML += '<tr>'
                            strHTML += '<td>' + ServicesSegmentation + '</td>'
                            strHTML += '<td></td>'
                            strHTML += '<td></td>'
                            strHTML += ' <td id="col' + ServicesSegmentationID + '" class="sm-wid">'
                            strHTML += '<div class="custom_chckbox">'
                            if (arrGetServicesSegmentationIDs.indexOf(ServicesSegmentationID) != -1) {                                                                
                                strHTML += '<input id="designchck' + ServicesSegmentationID + '" class="chckHead serSegchck" type="checkbox" onchange = "ProjectServicechkbxclickevent(this.id,' + i + ')" checked>'
                                //strHTML += '<input id="designchck'+ServicesSegmentationID+'" class="chckHead serSegchck" type="checkbox"  checked>'
                            } else {
                                strHTML += '<input id="designchck' + ServicesSegmentationID + '" class="chckHead serSegchck" type="checkbox" onchange = "ProjectServicechkbxclickevent(this.id,' + i + ')">'
                                //strHTML += '<input id="designchck'+ServicesSegmentationID+'" class="chckHead serSegchck" type="checkbox" >'
                            }
                            strHTML += '<label for="designchck' + ServicesSegmentationID + '"></label>'
                            strHTML += '</div>'
                            strHTML += '</td>'
                            strHTML += '</tr>'
                        } else if (SubServiceOfferingName == null) {



                            strHTML += '<tr>'
                            strHTML += '<td> </td>'
                            strHTML += '<td>' + ServiceOfferingName + '</td>'
                            strHTML += '<td></td>'
                            strHTML += ' <td id="col' + ServicesSegmentationID + ':' + ServiceOfferingID + '"  class="sm-wid">'
                            strHTML += '<div class="custom_chckbox">'
                            if (arrGetServiceOfferingIDs.indexOf(ServiceOfferingID) != -1) {
                                strHTML += '<input id="designchck' + ServicesSegmentationID + ':' + ServiceOfferingID + '" class="chckHead serSegchck" type="checkbox" onchange = "ProjectServiceOfferingchkbxclickevent(this.id,' + i + ')" checked>'
                            } else {
                                strHTML += '<input id="designchck' + ServicesSegmentationID + ':' + ServiceOfferingID + '" class="chckHead serSegchck" type="checkbox" onchange = "ProjectServiceOfferingchkbxclickevent(this.id,' + i + ')">'
                            }
                            strHTML += '<label for="designchck' + ServicesSegmentationID + ':' + ServiceOfferingID + '"></label>'
                            strHTML += '</div>'
                            strHTML += '</td>'
                            strHTML += '</tr>'
                            // arrserviceOfferingids.push('designchck'+ServicesSegmentationID+':'+ServiceOfferingID);
                            arrserviceOfferingids.push(ServicesSegmentationID + ':' + ServiceOfferingID);
                        } else {
                            strHTML += '<tr>'
                            strHTML += '<td> </td>'
                            strHTML += '<td></td>'
                            strHTML += '<td>' + SubServiceOfferingName + '</td>'
                            strHTML += ' <td id="col' + ServicesSegmentationID + ':' + ServiceOfferingID + ':' + SubServiceOfferingID + '" class="sm-wid">'
                            strHTML += '<div class="custom_chckbox">'
                            if (arrGetSubServiceOfferingIDs.indexOf(SubServiceOfferingID) != -1) {
                                strHTML += '<input id="designchck' + ServicesSegmentationID + ':' + ServiceOfferingID + ':' + SubServiceOfferingID + '" class="chckHead serSegchck" type="checkbox" onchange = "ProjectSubServiceOfferingchkbxclickevent(this.id,' + i + ')" checked>'
                            } else {
                                strHTML += '<input id="designchck' + ServicesSegmentationID + ':' + ServiceOfferingID + ':' + SubServiceOfferingID + '" class="chckHead serSegchck" type="checkbox" onchange = "ProjectSubServiceOfferingchkbxclickevent(this.id,' + i + ')">'
                            }
                            strHTML += '<label for="designchck' + ServicesSegmentationID + ':' + ServiceOfferingID + ':' + SubServiceOfferingID + '"></label>'
                            strHTML += '</div>'
                            strHTML += '</td>'
                            strHTML += '</tr>'
                            //arrSubserviceOfferingids.push('designchck'+ServicesSegmentationID+':'+ServiceOfferingID+':'+SubServiceOfferingID);
                            arrSubserviceOfferingids.push(ServicesSegmentationID + ':' + ServiceOfferingID + ':' + SubServiceOfferingID);
                        }

                    }
                    
                    $("#tblbdyServiceSegmentation").html(strHTML);
                    if (IsData != 1) { //Added By Dipali V On 9th june 20202 For Issue ID 25000
                         $('#serSegAll').prop('checked', false);
                    }
                    //Added By Usha Pandit On 26.05.2020 for check uncheck issue
                    $('*[id*=designchck]').click(function () {

                        var curId = $(this).attr("id");
                        count = occurrences(curId, ':');
                        
                        if (count == 0) {
                            var thisCheck = $(this);                            
                        }
                        if (count == 1) {
                            var thisCheck = $(this);

                            if (thisCheck.is(':checked')) {

                                $('*[id*="' + curId + ':"]').each(function () {

                                    $(this).prop("checked", true);
                                });
                            }
                            else {
                                var curParentId = curId.toString().substring(0, curId.toString().lastIndexOf(":"));
                                var cntLevel2Check = 0;
                                var cntLevel2UnCheck = 0;
                                var cntLevel2Total = 0;
                                var Level1Parent = '';
                                $('*[id*="' + curParentId + '"]').each(function () {

                                    var levelId = $(this).attr("id");
                                    curCount = occurrences(levelId, ':');

                                    if (curCount == 0) {
                                        Level1Parent = levelId;
                                    }
                                    if (curCount == 1) {
                                        var thisCheck = $(this);
                                        if (thisCheck.is(':checked')) {
                                            cntLevel2Check = cntLevel2Check + 1;
                                        }
                                        else {
                                            cntLevel2UnCheck = cntLevel2UnCheck + 1;
                                        }
                                        cntLevel2Total = cntLevel2Total + 1;
                                    }
                                });
                                $('*[id*="' + curId + ':"]').each(function () {

                                    $(this).prop("checked", false);
                                });
                                if (cntLevel2UnCheck == cntLevel2Total) {
                                    try {
                                        var curId = Level1Parent;

                                        $('[id="' + Level1Parent + '"]').addClass("clsUncheckLevel1");

                                        $('[id="' + Level1Parent + '"]').attr("checked", false);
                                        
                                    }
                                    catch (ex) {
                                        //alert(ex.message);
                                    }
                                }
                            }
                        }
                        if (count == 2) {
                            var thisCheck = $(this);
                            if (thisCheck.is(':checked')) {
                                var curParentId = curId.toString().substring(0, curId.toString().lastIndexOf(":"));
                                $('*[id*="' + curId + '"]').each(function () {
                                    var levelId = $(this).attr("id");
                                    curCount = occurrences(levelId, ':');
                                    
                                    if (curCount == 1) {
                                        $(this).prop("checked", true);
                                    }
                                });
                            }
                            else {
                                var curParentId = curId.toString().substring(0, curId.toString().lastIndexOf(":"));
                                var curLevel1ParentId = curId.toString().substring(0, curId.toString().indexOf(":"));
                                var cntLevel3Check = 0;
                                var cntLevel3UnCheck = 0;
                                var cntLevel3Total = 0;
                                var Level2Parent = '';
                                $('*[id*="' + curParentId + '"]').each(function () {
                                    var levelId = $(this).attr("id");
                                    curCount = occurrences(levelId, ':');

                                    if (curCount == 1) {
                                        Level2Parent = levelId;
                                    }
                                    if (curCount == 2) {
                                        var thisCheck = $(this);
                                        if (thisCheck.is(':checked')) {
                                            cntLevel3Check = cntLevel3Check + 1;
                                        }
                                        else {
                                            cntLevel3UnCheck = cntLevel3UnCheck + 1;
                                        }
                                        cntLevel3Total = cntLevel3Total + 1;
                                    }
                                });

                                if (cntLevel3UnCheck == cntLevel3Total) {
                                    try {
                                        var curId = Level2Parent;

                                        $('[id="' + Level2Parent + '"]').addClass("clsUncheck");                                        
                                        
                                        $('[id="' + Level2Parent + '"]').attr("checked", false);                                        

                                        





                                        var cntLevel2Check = 0;
                                        var cntLevel2UnCheck = 0;
                                        var cntLevel2Total = 0;
                                        var Level1Parent = '';
                                        $('*[id*="' + curLevel1ParentId + '"]').each(function () {

                                            var levelId = $(this).attr("id");
                                            curCount = occurrences(levelId, ':');

                                            if (curCount == 0) {
                                                Level1Parent = levelId;
                                            }
                                            if (curCount == 1) {
                                                var thisCheck = $(this);
                                                if (thisCheck.is(':checked')) {
                                                    cntLevel2Check = cntLevel2Check + 1;
                                                }
                                                else {
                                                    cntLevel2UnCheck = cntLevel2UnCheck + 1;
                                                }
                                                cntLevel2Total = cntLevel2Total + 1;
                                            }
                                        });
                                        if (cntLevel2UnCheck == cntLevel2Total) {
                                            try {
                                                var curId = Level1Parent;

                                                $('[id="' + Level1Parent + '"]').addClass("clsUncheckLevel1");

                                                $('[id="' + Level1Parent + '"]').attr("checked", false);

                                            }
                                            catch (ex) {
                                                //alert(ex.message);
                                            }
                                        }




                                        
                                    }
                                    catch (ex) {
                                        //alert(ex.message);
                                    }
                                }
                            }
                        }
                        
                    });
                        
                    //End Of Added By Usha Pandit On 26.05.2020 for check uncheck issue
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            //CheckBoxChecked();
            //Allchkbxchekedoruncheckd();
			if (IsData == 1) { //Added By Dipali V On 9th june 20202 For Issue ID 25000
                Allchkbxchekedoruncheckd();
            }
        }
        var strSericecheckboxids = {};
        var strSericeOfferingcheckboxids = {};
        var strsubSericeOfferingcheckboxids = [];
        var strAllids;
        var strserviceAllids = "";
        var strserviceofferingAllids = "";
        var strsubserviceOfferingAllids = "";
        function CheckBoxChecked() {

            $('#tblServiceSegmentation > tbody> tr').each(function (index, value) {
                // debugger
                var message = "";
                //var File;
                //var Date = "";
                var allColumns = $(this).find('td');

                $(allColumns).each(function (i, v) {

                    //console.log(this);

                    if (i == 3) {
                        var id = $(this).find('input[type=checkbox]').attr("id");
                        // console.log(id);


                        if ($(this).find('input[type="checkbox"]').is(':checked')) {
                            //console.log("checked");
                            id = id.replace('designchck', '');
                            var search_value = id;
                            var letter = ':'; /*Can take any letter, have put in a var if anyone wants to use this variable dynamically*/
                            letter = letter && "string" === typeof letter ? letter : "";
                            var count;
                            for (var i = count = 0; i < search_value.length; count += (search_value[i++] == letter));
                            //console.log(count);
                            if (count == 0) {
                                var id1 = id + ":1";
                                //strSericecheckboxids.push(id);
                                strSericecheckboxids[id] = id1;
                            } else if (count == 1) {
                                var id1 = id + ":1";
                                //strSericeOfferingcheckboxids.push(id);
                                strSericeOfferingcheckboxids[id] = id1;
                            } else if (count == 2) {
                                var id1 = id + ":1";
                                strsubSericeOfferingcheckboxids.push(id1);
                            }
                            //id = id + ":1";
                            //  console.log(id);
                            //strcheckboxids.push(id);
                        } else {
                            // console.log("unchecked");
                            id = id.replace('designchck', '');
                            var search_value = id;
                            var letter = ':'; /*Can take any letter, have put in a var if anyone wants to use this variable dynamically*/
                            letter = letter && "string" === typeof letter ? letter : "";
                            var count;
                            for (var i = count = 0; i < search_value.length; count += (search_value[i++] == letter));
                            //console.log(count);
                            // id = id + ":0";
                            // strcheckboxids.push(id);
                            // console.log(id);
                            if (count == 0) {
                                var id1 = id + ":0";
                                //strSericecheckboxids.push(id);
                                strSericecheckboxids[id] = id1;
                            } else if (count == 1) {
                                var id1 = id + ":0";
                                //strSericeOfferingcheckboxids.push(id);
                                strSericeOfferingcheckboxids[id] = id1;
                            } else if (count == 2) {
                                var id1 = id + ":0";
                                strsubSericeOfferingcheckboxids.push(id1);
                            }
                        }
                        //console.log(id);

                    }

                });
            });

            console.log(strSericecheckboxids);
            console.log(strSericeOfferingcheckboxids);
            console.log(strsubSericeOfferingcheckboxids);

            $.each(strSericecheckboxids, function (i, item) {
                //alert(data[i].PageName);
                //console.log(strSericecheckboxids[i]);
                for (var j = 0; j < 2; j++) {
                    strserviceAllids += strSericecheckboxids[i] + ",";
                }
            });

            $.each(strSericeOfferingcheckboxids, function (i, item) {
                //alert(data[i].PageName);
                //console.log(strSericeOfferingcheckboxids[i]);
                var serviceval = strSericeOfferingcheckboxids[i];
                var pos1 = serviceval.indexOf(":")
                var ServiceValue = serviceval.substring(0, pos1);
                for (var j = 0; j < 4; j++) {
                    strserviceofferingAllids += strSericecheckboxids[ServiceValue] + "~" + strSericeOfferingcheckboxids[i] + ",";
                }
                //serviceval=serviceval.subs
            });

            for (var i = 0; i < strsubSericeOfferingcheckboxids.length; i++) {
                var subservuceofferingvalue = strsubSericeOfferingcheckboxids[i];
                var pos1 = subservuceofferingvalue.indexOf(":")
                var pos2 = subservuceofferingvalue.indexOf(":", subservuceofferingvalue.indexOf(":") + 1);
                var ServiceValue = subservuceofferingvalue.substring(0, pos1);
                var ServiceOfferingValue = subservuceofferingvalue.substring(0, pos2);
                // strAllids += strSericecheckboxids[ServiceValue] + ","; 
                //strAllids += strSericecheckboxids[ServiceValue] + "~" + strSericeOfferingcheckboxids[ServiceOfferingValue] + ","; 
                for (var j = 0; j < 8; j++) {
                    strsubserviceOfferingAllids += strSericecheckboxids[ServiceValue] + "~" + strSericeOfferingcheckboxids[ServiceOfferingValue] + "~" + subservuceofferingvalue + ","
                }

                //strAllids += strAllids;
                //  console.log(strSericecheckboxids[ServiceValue]);
                //console.log(strSericeOfferingcheckboxids[ServiceOfferingValue]);
            }
            strAllids = strserviceAllids.replace('undefined', '') + strserviceofferingAllids.replace('undefined', '') + strsubserviceOfferingAllids.replace('undefined', '');
            strAllids = strAllids.replace('undefined', '');
            strAllids = strAllids.slice(0, -1);

            console.log(strAllids);
            //console.log(ProjectID);

        }
        function getURLParameter(url, name) {
            return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
        }
        function refreshMyParent() {
            try {
                var newpath = opener.window.location.href;
                if (newpath.indexOf('FromWhereProjectId') == -1) {
                    newpath = opener.window.location.href.replace('#', '?');
                    newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ProjectServiceSegmentation%>'&Mode=Edit&update=done";
                }
                newpath = newpath.toString().replace("&update=done", "");
                var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                var currentToken = getURLParameter(newpath, "PKToken");

                newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ProjectServiceSegmentation%>');
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
        function btnclickSaveProjectServiceSegmentation() {
            // alert("btn click");
            // var ck_box = $('input[type="checkbox"]:checked').length;
            // #tblbdyServiceSegmentation input[type="checkbox"]:checked
            // return in firefox or chrome console 
            // the number of checkbox checked
            //console.log(ck_box); 

            //if (ck_box > 0) {
            //alert(ck_box);			
		
		
		
		
		
			if (IsData == 1) { //Added By Dipali V On 9th june 20202 For Issue ID 25000
            strAllids = "";
            CheckBoxChecked();
            var servicesegmentation = {
                ProjectId: encodeURI(ProjectID),
                AllIds: encodeURI(strAllids)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectSettings/InsertSegmentationDetails',
                method: 'Post',
                data: JSON.stringify(servicesegmentation),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (servicesegmentation) {
                        xhr.setRequestHeader("Params", encryptString(isJson(servicesegmentation) ? servicesegmentation : JSON.stringify(servicesegmentation)));
                    }
                },
                success: function (result) {
                    alertify.set('notifier', 'position', 'top-right');
                    var message = '<%= MyBase.GetResourceString("C_ServiceSegmentation_Message") %>';
                    alertify.success(message);
                    GetServiceSegmentationDetails(ProjectID);
                    refreshMyParent();
                    //window.location.href = "PM_CreateProject.aspx?FromWhereProjectId=" + ProjectID + "&FromWhereData=C&PKToken=" + "<%= m_PKToken_ProjectServiceSegmentation %>" + "&Mode=Edit";
                    strAllids = "";
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            } else {
               
               //Added By Dipali V On 9th june 20202 For Issue ID 25000
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("There was no record to take any action");
                 //End of Added By Dipali V On 9th june 20202 For Issue ID 25000
            }
                 <%--} else {
                  alertify.set('notifier', 'position', 'top-right');
                         // var message = '<%= MyBase.GetResourceString("C_ServiceSegmentation_Message") %>';
                     alertify.success("");
            } --%>
        }

        function ProjectSubServiceOfferingchkbxclickevent(id, row) {
            var chkboxid = id.replace('designchck', '');
            var pos1 = chkboxid.indexOf(':');
            var pos2 = chkboxid.indexOf(":", chkboxid.indexOf(":") + 1);
            var ServiceValue = chkboxid.substring(0, pos1);
            var ServiceOfferingValue = chkboxid.substring(0, pos2);
            ServiceOfferingValue = ServiceOfferingValue.replace(":", "\\:");
            var chkbxid = "#col" + ServiceOfferingValue + " > div>input[type=checkbox]";
            var chkservicebxid = "#col" + ServiceValue + " > div>input[type=checkbox]";
            chkboxid = chkboxid.replace(":", "\\:");
            chkboxid = chkboxid.append(pos2 + 1, "\\");
            // chkboxid = chkboxid.replace(":", "\\:");
            //alert(chkservicebxid);
            
            if ($(chkservicebxid).is(':checked') == true) {                
                //alert("True");
            } else {
                // alert("false");
                // $(chkservicebxid).removeAttr('checked');
                //$(chkservicebxid).attr('checked' , true);
                //$(chkservicebxid).prop('selected' , true);
                //alert(77777);
                if ($(chkservicebxid).hasClass("clsUncheck")) {
                    $(chkservicebxid).removeClass("clsUncheck");
                }
                else if ($(chkservicebxid).hasClass("clsUncheckLevel1")) {
                    $(chkservicebxid).removeClass("clsUncheckLevel1");
                }
                else {
                    $(chkservicebxid).prop('checked', true);
                }
            }

            if ($(chkbxid).is(':checked') == true) {
                //alert("true");
                //var subserviceofferingid = "#col" + chkboxid + " > div>input[type=checkbox]";
                // $(subserviceofferingid).prop('selected' , true);
                //$(subserviceofferingid).attr('checked', true);
            } else {
                //alert("false");
                //var subserviceofferingid = "#col" + chkboxid + " > div>input[type=checkbox]";
                //$(chkbxid).prop('selected' , true);
                //$(chkbxid).removeAttr('checked');
                //$(chkbxid).attr('checked', true); 
                //  $(chkbxid).prop('selected' , true);
                //alert(5555);
                if ($(chkbxid).hasClass("clsUncheck")) {
                    $(chkbxid).removeClass("clsUncheck");
                }
                else if ($(chkbxid).hasClass("clsUncheckLevel1"))
                {
                    $(chkbxid).removeClass("clsUncheckLevel1");
                }
                else {
                    $(chkbxid).prop('checked', true);
                }

            }
            if (IsData == 1) { //Added By Dipali V On 9th june 20202 For Issue ID 25000
                Allchkbxchekedoruncheckd();
            }

        }
        String.prototype.append = function (index, value) {
            return this.slice(0, index) + value + this.slice(index);
        };


        function ProjectServicechkbxclickevent(id, row) {            
            var chkboxid = id.replace('designchck', '');
            for (var i = 0; i < arrserviceOfferingids.length; i++) {
                var serviceofferingid = arrserviceOfferingids[i];
                var pos1 = serviceofferingid.indexOf(':');

                var ServiceValue = serviceofferingid.substring(0, pos1);

                if (chkboxid == ServiceValue) {

                    var chkboxid1 = serviceofferingid.replace(":", "\\:");
                    var Servicechkbxid = "#col" + chkboxid + " > div>input[type=checkbox]";
                    var ServiceOfferingValue = "#col" + chkboxid1 + " > div>input[type=checkbox]";
                    
                    if ($(Servicechkbxid).is(':checked') == true) {

                        // alert($(Servicechkbxid).is(':checked'));
                        // $(ServiceOfferingValue).attr('checked', true);
                        //$(ServiceOfferingValue).prop('selected', true);
                        //alert(8888);
                        $(ServiceOfferingValue).prop('checked', true);


                    } else {
                        // alert($(Servicechkbxid).is(':checked'));
                        // $(ServiceOfferingValue).removeAttr('checked');
                        //  $(Servicechkbxid).removeAttr('checked');
                        // $(ServiceOfferingValue).attr('checked', false); 
                        //alert(1111);
                        $(ServiceOfferingValue).prop('checked', false);

                    }

                }
            }
            for (var j = 0; j < arrSubserviceOfferingids.length; j++) {
                var subserviceofferingid = arrSubserviceOfferingids[j];
                var pos1 = subserviceofferingid.indexOf(':');
                var pos2 = subserviceofferingid.indexOf(":", subserviceofferingid.indexOf(":") + 1);

                var ServiceValue = subserviceofferingid.substring(0, pos1);

                if (chkboxid == ServiceValue) {

                    var chkboxid1 = subserviceofferingid.replace(":", "\\:");
                    //chkboxid = chkboxid.replace(":", "\\:");
                    chkboxid1 = chkboxid1.append(pos2 + 1, "\\");
                    var Servicechkbxid = "#col" + chkboxid + " > div>input[type=checkbox]";
                    var subServiceOfferingValue = "#col" + chkboxid1 + " > div>input[type=checkbox]";

                    if ($(Servicechkbxid).is(':checked') == true) {

                        //alert(99999);
                        // $(subServiceOfferingValue).attr('checked', true);
                        //$(subServiceOfferingValue).prop('selected', true);
                        $(subServiceOfferingValue).prop('checked', true);

                    } else {

                        //$(subServiceOfferingValue).removeAttr('checked');
                        //$(Servicechkbxid).removeAttr('checked');
                        //  $(subServiceOfferingValue).attr('checked', false); 
                        //alert(2222);
                        $(subServiceOfferingValue).prop('checked', false);

                    }

                }
            }
            Allchkbxchekedoruncheckd();


        }

        function ProjectServiceOfferingchkbxclickevent(id, row) {
            var chkboxid = id.replace('designchck', '');    
            //alert(chkboxid);
            var pos1 = chkboxid.indexOf(':');
            //var pos2 = chkboxid.indexOf(":", chkboxid.indexOf(":") + 1);
            var ServiceValue = chkboxid.substring(0, pos1);
            //var ServiceOfferingValue = chkboxid.substring(0, pos2);
            //ServiceOfferingValue = ServiceOfferingValue.replace(":", "\\:");
            // var chkbxid = "#col" + ServiceOfferingValue + " > div>input[type=checkbox]";
            var chkservicebxid = "#col" + ServiceValue + " > div>input[type=checkbox]";
            chkboxid = chkboxid.replace(":", "\\:");
            // chkboxid = chkboxid.append(pos2+1, "\\");
            // chkboxid = chkboxid.replace(":", "\\:");
            // alert(chkservicebxid);
            if ($(chkservicebxid).is(':checked') == true) {
                //  alert("True");
            } else {
                //alert("false");
                //alert(1212345);
                //$(chkservicebxid).attr('checked' , true);
                if ($(chkservicebxid).hasClass("clsUncheck")) {
                    $(chkservicebxid).removeClass("clsUncheck");
                }
                else if ($(chkservicebxid).hasClass("clsUncheckLevel1"))
                {
                    $(chkservicebxid).removeClass("clsUncheckLevel1");
                }
                else {
                    $(chkservicebxid).prop('checked', true);
                }
                
                //$(chkservicebxid).prop('selected', true);
                //$(chkservicebxid).removeAttr('checked');
            }

            //if ($(chkbxid).is(':checked')==true) {
            // // alert("true");
            //    //var subserviceofferingid = "#col" + chkboxid + " > div>input[type=checkbox]";
            //   // $(subserviceofferingid).prop('selected' , true);
            //    //$(subserviceofferingid).attr('checked', true);
            //} else {
            //  //  alert("false");
            //     //var subserviceofferingid = "#col" + chkboxid + " > div>input[type=checkbox]";
            //    //$(chkbxid).prop('selected' , true);
            //    //$(chkbxid).removeAttr('checked');
            //    $(chkbxid).attr('checked', true); 
            //     $(chkbxid).prop('selected' , true);

            //}
            var chkboxid2 = id.replace('designchck', '');
            var chkboxid3 = id.replace('designchck', '');
            // //alert(chkboxid);
            // for (var j = 0; j < arrSubserviceOfferingids.length; j++) {
            //    var subserviceofferingid = arrSubserviceOfferingids[j];
            //    var pos1 = subserviceofferingid.indexOf(':');
            //    var pos2 = subserviceofferingid.indexOf(":", subserviceofferingid.indexOf(":") + 1);

            //var ServiceValue=subserviceofferingid.substring(0,pos2);

            //    if (chkboxid2==ServiceValue) {

            //        var chkboxid1 = subserviceofferingid.replace(":", "\\:");
            //        chkboxid2 = chkboxid2.replace(":", "\\:");
            //        chkboxid1 = chkboxid1.append(pos2+1, "\\");
            //        var Servicechkbxid = "#col" + chkboxid2 + " > div>input[type=checkbox]";
            //        var subServiceOfferingValue = "#col" + chkboxid1 + " > div>input[type=checkbox]";
            // //alert(Servicechkbxid);
            //        if ($(Servicechkbxid).is(':checked')==true) {


            //           // $(subServiceOfferingValue).attr('checked', true);
            //            //$(subServiceOfferingValue).prop('selected', true);
            //             $(subServiceOfferingValue).prop('checked', true);

            //} else {

            //            //$(subServiceOfferingValue).removeAttr('checked');
            //            //$(Servicechkbxid).removeAttr('checked');
            //  //  $(subServiceOfferingValue).attr('checked', false); 
            //              $(subServiceOfferingValue).prop('checked', false);

            //}

            //    }
            //}
            chkboxid2 = chkboxid2.replace(":", "\\:");
            var Servicechkbxid = "#col" + chkboxid2 + " > div>input[type=checkbox]";
            if ($(Servicechkbxid).is(':checked') == true) {

                //      for (var j = 0; j < arrSubserviceOfferingids.length; j++) {
                //    var subserviceofferingid = arrSubserviceOfferingids[j];
                //    var pos1 = subserviceofferingid.indexOf(':');
                //    var pos2 = subserviceofferingid.indexOf(":", subserviceofferingid.indexOf(":") + 1);

                //var ServiceValue=subserviceofferingid.substring(0,pos2);

                //    if (chkboxid3==ServiceValue) {

                //        var chkboxid1 = subserviceofferingid.replace(":", "\\:");

                //        chkboxid1 = chkboxid1.append(pos2+1, "\\");

                //        var subServiceOfferingValue = "#col" + chkboxid1 + " > div>input[type=checkbox]";

                //             $(subServiceOfferingValue).prop('checked', true);

                //alert(3333333);


                //}

                //    }


            } else {

                for (var j = 0; j < arrSubserviceOfferingids.length; j++) {
                    var subserviceofferingid = arrSubserviceOfferingids[j];
                    var pos1 = subserviceofferingid.indexOf(':');
                    var pos2 = subserviceofferingid.indexOf(":", subserviceofferingid.indexOf(":") + 1);

                    var ServiceValue = subserviceofferingid.substring(0, pos2);

                    if (chkboxid3 == ServiceValue) {

                        var chkboxid1 = subserviceofferingid.replace(":", "\\:");

                        chkboxid1 = chkboxid1.append(pos2 + 1, "\\");

                        var subServiceOfferingValue = "#col" + chkboxid1 + " > div>input[type=checkbox]";
                        //alert(subServiceOfferingValue);
                        $(subServiceOfferingValue).prop('checked', false);




                    }

                }
                
                //Added by Chetan M on 11th April 2020 for Issue ID = 23068
                //alert(1);
                //var FlagToCheck = 0;
                //var ServiceLineID;
                //for (var k = 0; k < arrserviceOfferingids.length; k++) {                   
                //    var CheckboxID = "designchck" + arrserviceOfferingids[k];   
                //    ServiceLineID = CheckboxID.substring(0,CheckboxID.length - 2)                   
                //    var Objchk = document.getElementById(CheckboxID);                    
                //    if (Objchk.checked) {
                //        FlagToCheck = 0;
                //        break;
                //    }
                //    else {
                //        FlagToCheck = 1;
                //    }                    
                //}
                //if (FlagToCheck == "1") {
                //    $("#"+ServiceLineID).prop('checked', false);
                //}
                //End of Added by Chetan M on 11th April 2020 for Issue ID = 23068

            }

            Allchkbxchekedoruncheckd();


        }

        function Allchkbxchekedoruncheckd() {
            ck_box_cnt = $('#tblbdyServiceSegmentation input[type="checkbox"]').length;
            var chk_box_checked_cnt = $('#tblbdyServiceSegmentation input[type="checkbox"]:checked').length;
            
            if (ck_box_cnt == chk_box_checked_cnt) {
                
                $('#tblServiceSegmentation > thead > tr > th.sm-wid > div>input#serSegAll').prop('checked', true);
            } else {
                $('#tblServiceSegmentation > thead > tr > th.sm-wid > div>input#serSegAll').prop('checked', false);
            }
        }


        function ChangeTabs(src, TagID, ParentTagID, responsivesrc) {
       // alert("click");
        <%--var EmployeeID;
        EmployeeID = '<%= Session("intUserID") %>';
        // alert(EmployeeID);
        if (EmployeeID == '') {
            alert('Your session is expired. Please login again.');
            window.location.href = "../../Default.aspx?Message=SessionExpired";
        }--%>
            // debugger; //Added By Dipali V On 3rd Sep for New WBS Link
            if (ParentTagID == 10 || ParentTagID == 405 || ParentTagID == 1085 || TagID == 21000 || TagID == 21002 || TagID == 22597 || TagID == 22598 || TagID == 22599 || TagID == 468 || TagID == 534 || TagID == 535 || TagID == 2118) {
                //if (document.getElementById("header_" + TagID) != null) {
                //    document.getElementById("mainHeadingTop").innerHTML = document.getElementById("header_" + TagID).value;
                //}
                //document.getElementById("frmNewVersion").src = src;
                //if (responsivesrc != undefined || responsivesrc != "") {
                //    document.getElementById("frmNewResponsiveVersion").src = responsivesrc;
                //}
                //End of Added By Dipali V On 3rd Sep for New WBS Link

            } else {

                $.ajax({
                    url: "../../General/Navigation.aspx/ChangeVersion",
                    data: JSON.stringify({ VersionID: "1" }),
                    dataType: "json",
                    contentType: "application/json",
                    type: "POST",
                    success: function (result) {
                        //  alert(result);
                        if (TagID == 5) {
                            window.open(src, "_self");
                        }
                        else {
                            window.open(src, "_self");
                        }
                    }
                })

            }
        }



        function getProjectName(ProjectId) {
            
            var Parameter = { ProjectID: ProjectID }
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
        // /Whizible2_Dev2/Source/NewAPI/NewAPI/PM/PM_ConfigureApprovers.aspx
        // /	../NewAPI/PM/PM_ConfigureApprovers.aspx

    </script>
</div>
</body>

</html>
