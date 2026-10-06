<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectMarketSegmentation.aspx.vb" Inherits="PbNIT.PM_ProjectMarketSegmentation" %>

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

        body {
            background-color: #fff;
        }

        .pl-20 {
            padding-left: 20px;
        }

        #MarketSegTbl {
            margin: 0 auto 20px;
            width: 97%;
        }
        /*Added By Usha Pandit On 07.07.2020 To wrap long text*/
        #MarketSegTbl tr td:nth-child(1) {
            word-break: break-all;
            width: 30%;
            text-align: left;
        }
        /*End Of Added By Usha Pandit On 07.07.2020 To wrap long text*/
    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="MarketSegmentation">
    <div id="divProjectMarketSegmentation">
        <% If m_blnMarketSegViewAccess = True Then %>

        <div id="Main_marketSeg">
            <!--ps_list_table_start-->
            <div class="tab-pane pstbl_marketSeg pt-0 practicesettinglist in active" id="pstbl_marketSeg" style="border-top: 1px solid #ddd;">
                <div class="modalpgHead  pt-1 pb-1 col-sm-12 mb-10">
                    <span>&nbsp;&nbsp;<%= MyBase.GetResourceString("C_MarketSegmentation") %></span>
                </div>
                <h5 class="float-start pl-20 pt-2 clearfix">Project Name : <span id="spanProjectName"></span></h5>
                <div class="right-btn">
                    <%  If m_blnMarketSegAddAccess = True And m_blnMarketSegEditAccess = True Then %>
                    <p><a href="#" class="btn btnyellow mr-5" id="MarketsegSave" onclick="AddMarketSegmentation();"><%= MyBase.GetResourceString("C_Save") %></a></p>
                    <% End If %>
                </div>

                <table class="table table-stripped table-bordered tbl-keywords" id="MarketSegTbl">
                    <thead>
                        <tr>
                            <th><%= MyBase.GetResourceString("C_ExternalMarket") %></th>
                            <th><%= MyBase.GetResourceString("C_Market") %></th>
                            <th><%= MyBase.GetResourceString("C_SubMarket") %></th>
                            <th class="sm-wid">
                                <div class="custom_chckbox">
                                    <input id="marketSegAll" class="chckHead" type="checkbox">
                                    <label for="marketSegAll"></label>
                                </div>
                            </th>
                        </tr>
                    </thead>
                    <tbody id="MarketSegTblbody">
                    </tbody>
                </table>
            </div>
            <!--ps_list_table_end-->
            <% Else %>
            <div id="" class="tab-pane active" style="height: 448px">
                <div style="text-align: center" class="box box-solid">
                    <br />
                    <br />
                    <br />
                    <br />

                    <p>You are not authorized to view this record. </p>

                    <br />
                    <br />
                    <br />
                    <br />
                </div>
            </div>
            <% End If %>
        </div>
        <!--Add new site modal end here-->
        <div id="NoProjectDivID" hidden="hidden">
            <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>You have not selected any project, please select the project.</h4>
        </div>

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
                            <div class="row mb-3">
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
                            <div class="row mb-3">
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

        <!-- REQUIRED JS SCRIPTS -->
      
   <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
        <!-- jqueryUI js -->
        <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>      
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>    
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
        <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
        <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>

        <!-- custome js -->
        <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>

         <script src="../../General/CommonValidations.js?v=1"></script>

        <script>


            var ajaxResult = "";
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
            alertify.set('notifier', 'position', 'top-right');

            var ProjectID;
            var ViewAccess = "<%= m_blnMarketSegViewAccess %>";

            $(document).ready(function () {
                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divProjectMarketSegmentation").html(bodyHTML);
                    return;
                }
                $("#marketSegAll").click(function () {
                    $(".marktchck").prop('checked', $(this).prop('checked'));
                });
                params = getParams();
                ProjectID = unescape(params["ProjectID"]);
                GetProjectName(ProjectID);
                if (ProjectID != 0) {
                    GetMarketSegmentationDetails();
                }
                else {
                    StartLoader("#MarketSegmentation");
                    $("#NoProjectDivID").show();
                    $("#Main_marketSeg").hide();
                    StopAjaxLoader("#MarketSegmentation");
                }
            });

            var SavedDomainID = [];
            var SavedMarketD = [];
            var SavedSubMarketID = [];
            var strExternalMarketCheckBoxIds = {};
            var strMarketCheckBoxIds = {};
            var strSubMarketCheckBoxIds = [];
            var ExternalMarketCheckBoxIds = [];
            var MarketCheckBoxIds = [];
            var strAllMarketSegIds;
            var strExternalMarketAllids = "";
            var strMarketAllids = "";
            var strsubMarketAllids = "";
            var arrMarketIds = [];
            var arrSubMarketIds = [];

            String.prototype.append = function (index, value) {
                return this.slice(0, index) + value + this.slice(index);
            };

            //Market Segmentation List Plotting
            function GetMarketSegmentationDetails() {
                SavedMarketD = [];
                SavedSubMarketID = [];
                SavedDomainID = [];
                StartLoader("#MarketSegmentation");
                var param = JSON.stringify(encodeURI(ProjectID));
                var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetMarketSegmentationDetails", param, false);

                var GetMarketSegmentationData = strResult.GetMarketSegmentationData;
                var GetExternalMarketIDs = strResult.GetExternalMarketIDs;
                var GetMarketIDs = strResult.GetMarketIDs;
                var GetSubMarketIDs = strResult.GetSubMarketIDs;

                for (var j = 0; j < GetExternalMarketIDs.length; j++) {
                    var DomainID = GetExternalMarketIDs[j]["DomainID"];
                    SavedDomainID.push(DomainID);
                }

                for (var j = 0; j < GetMarketIDs.length; j++) {
                    var MarketID = GetMarketIDs[j]["MarketID"];
                    SavedMarketD.push(MarketID);
                }

                for (var j = 0; j < GetSubMarketIDs.length; j++) {
                    var SubMarketID = GetSubMarketIDs[j]["SubMarketID"];
                    SavedSubMarketID.push(SubMarketID);
                }

                $("#MarketSegTblbody").html('');
                var strHTML = "";
                for (var i = 0; i < GetMarketSegmentationData.length; i++) {

                    var DomainID = GetMarketSegmentationData[i]["DomainId"]
                    var DomainName = GetMarketSegmentationData[i]["DomainName"];
                    var MarketId = GetMarketSegmentationData[i]["MarketId"];
                    var MarketName = GetMarketSegmentationData[i]["MarketName"];
                    var SubMarketId = GetMarketSegmentationData[i]["SubMarketId"];
                    var SubMarketName = GetMarketSegmentationData[i]["SubMarketName"];


                    if (DomainName == null) {
                        DomainName = "";
                    }
                    if (MarketName == null) {
                        MarketName = "";
                    }
                    if (SubMarketName == null) {
                        SubMarketName = "";
                    }


                    if (MarketName == "" && SubMarketName == "") {
                        strHTML += ' <tr>'
                        strHTML += ' <td>' + DomainName + '</td>'
                        strHTML += ' <td></td>'
                        strHTML += ' <td></td>'
                        strHTML += ' <td id="col' + DomainID + '" class="sm-wid">'
                        strHTML += ' <div class="custom_chckbox">'

                        if (SavedDomainID.indexOf(DomainID) != -1) {

                            strHTML += ' <input id="ExternalMarketName' + DomainID + '" class="chckHead marktchck" type="checkbox" onchange = "ExternalMarketSegchkboxclickevent(this.id,' + i + ')" checked >'
                        }
                        else {
                            strHTML += ' <input id="ExternalMarketName' + DomainID + '" class="chckHead marktchck" type="checkbox" onchange = "ExternalMarketSegchkboxclickevent(this.id,' + i + ')">'
                        }
                        strHTML += ' <label for="ExternalMarketName' + DomainID + '"></label>'
                        strHTML += ' </div>'
                        strHTML += '</td>'
                        strHTML += '</tr>'
                    }
                    else if (SubMarketName == "") {
                        strHTML += ' <tr>'
                        strHTML += ' <td></td>'
                        strHTML += ' <td>' + MarketName + '</td>'
                        strHTML += ' <td></td>'
                        strHTML += ' <td id="col' + DomainID + ':' + MarketId + '" class="sm-wid">'
                        strHTML += ' <div class="custom_chckbox">'

                        if (SavedMarketD.indexOf(MarketId) != -1) {
                            strHTML += ' <input id="MarketName' + DomainID + ':' + MarketId + '" class="chckHead marktchck" type="checkbox" checked onchange = "MarketSegchkboxclickevent(this.id,' + i + ')">'
                        }
                        else {
                            strHTML += ' <input id="MarketName' + DomainID + ':' + MarketId + '" class="chckHead marktchck" type="checkbox" onchange = "MarketSegchkboxclickevent(this.id,' + i + ')">'
                        }
                        strHTML += ' <label for="MarketName' + DomainID + ':' + MarketId + '"></label>'
                        strHTML += ' </div>'
                        strHTML += '</td>'
                        strHTML += '</tr>'
                        arrMarketIds.push(DomainID + ':' + MarketId);
                    }
                    else {
                        strHTML += ' <tr>'
                        strHTML += ' <td></td>'
                        strHTML += ' <td></td>'
                        strHTML += ' <td>' + SubMarketName + '</td>'
                        strHTML += ' <td id="col' + DomainID + ':' + MarketId + ':' + SubMarketId + '" class="sm-wid">'
                        strHTML += ' <div class="custom_chckbox">'

                        if (SavedSubMarketID.indexOf(SubMarketId) != -1) {
                            strHTML += ' <input id="SubMarketName' + DomainID + ':' + MarketId + ':' + SubMarketId + '" class="chckHead marktchck SubMarketName" type="checkbox" checked onchange = "SubMarketChkboxclickevent(this.id,' + i + ')">'
                        }
                        else {
                            strHTML += ' <input id="SubMarketName' + DomainID + ':' + MarketId + ':' + SubMarketId + '" class="chckHead marktchck SubMarketName" type="checkbox" onchange = "SubMarketChkboxclickevent(this.id,' + i + ')" >'
                        }
                        strHTML += ' <label for="SubMarketName' + DomainID + ':' + MarketId + ':' + SubMarketId + '"></label>'
                        strHTML += ' </div>'
                        strHTML += '</td>'
                        strHTML += '</tr>'
                        arrSubMarketIds.push(DomainID + ':' + MarketId + ':' + SubMarketId);
                    }


                }

                $("#MarketSegTblbody").html("")
                $("#MarketSegTblbody").html(strHTML);

                StopAjaxLoader("#MarketSegmentation");


            }

            function MarketSegCheckboxCheck() {
                var cnt = 1;
                strMarketAllids += "";
                $('#MarketSegTbl > tbody> tr').each(function (index, value) {

                    var allColumns = $(this).find('td');

                    $(allColumns).each(function (i, v) {

                        if (i == 3) {
                            var id = $(this).find('input[type=checkbox]').attr("id");

                            if ($(this).find('input[type="checkbox"]').is(':checked')) {

                                if (id.indexOf('ExternalMarketName') > -1) {
                                    id = id.replace('ExternalMarketName', '');
                                    var id1 = id + ":1";

                                    strExternalMarketCheckBoxIds[id] = id1;

                                } else if (id.indexOf('SubMarketName') > -1) {
                                    id = id.replace('SubMarketName', '');
                                    var id1 = id + ":1";
                                    strSubMarketCheckBoxIds.push(id1);
                                }
                                else if (id.indexOf('MarketName') > -1) {
                                    id = id.replace('MarketName', '');
                                    var id1 = id + ":1";

                                    strMarketCheckBoxIds[id] = id1;

                                }

                            } else {

                                if (id.indexOf('ExternalMarketName') > -1) {
                                    id = id.replace('ExternalMarketName', '');
                                    var id1 = id + ":0";

                                    strExternalMarketCheckBoxIds[id] = id1;
                                }
                                else if (id.indexOf('SubMarketName') > -1) {
                                    id = id.replace('SubMarketName', '');
                                    var id1 = id + ":0";
                                    strSubMarketCheckBoxIds.push(id1);
                                } else if (id.indexOf('MarketName') > -1) {
                                    id = id.replace('MarketName', '');
                                    var id1 = id + ":0";

                                    strMarketCheckBoxIds[id] = id1;

                                }
                            }

                        }

                    });
                });

                $.each(strExternalMarketCheckBoxIds, function (i, item) {

                    strExternalMarketAllids += strExternalMarketCheckBoxIds[i] + ",";

                });

                $.each(strMarketCheckBoxIds, function (i, item) {

                    var Marketval = strMarketCheckBoxIds[i];
                    var pos1 = Marketval.indexOf(":")
                    var MarketValue = Marketval.substring(0, pos1);

                    strMarketAllids += strExternalMarketCheckBoxIds[MarketValue] + "~" + strMarketCheckBoxIds[i] + ",";


                });

                for (var i = 0; i < strSubMarketCheckBoxIds.length; i++) {

                    var subMarketValuevalue = strSubMarketCheckBoxIds[i];
                    var pos1 = subMarketValuevalue.indexOf(":")
                    var pos2 = subMarketValuevalue.indexOf(":", subMarketValuevalue.indexOf(":") + 1);
                    var ExternalMarketValue = subMarketValuevalue.substring(0, pos1);
                    var MarketValue = subMarketValuevalue.substring(0, pos2);



                    strsubMarketAllids += strExternalMarketCheckBoxIds[ExternalMarketValue] + "~" + strMarketCheckBoxIds[MarketValue] + "~" + subMarketValuevalue + ","


                }
                strAllMarketSegIds = strExternalMarketAllids.replace('undefined', '') + strMarketAllids.replace('undefined', '') + strsubMarketAllids.replace('undefined', '');
                strAllMarketSegIds = strAllMarketSegIds.replace('undefined', '');
                strAllMarketSegIds = strAllMarketSegIds.slice(0, -1);

                console.log(strAllMarketSegIds);

            }
            function getURLParameter(url, name) {
                return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
            }
            function refreshMyParent() {
                try {
                    var newpath = opener.window.location.href;
                    if (newpath.indexOf('FromWhereProjectId') == -1) {
                        newpath = opener.window.location.href.replace('#', '?');
                        newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ProjectMarketSegmentation%>'&Mode=Edit&update=done";
                    }
                    newpath = newpath.toString().replace("&update=done", "");
                    var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                    var currentToken = getURLParameter(newpath, "PKToken");

                    newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ProjectMarketSegmentation%>');
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
            function AddMarketSegmentation() {
                strAllMarketSegIds = "";
                MarketSegCheckboxCheck();

                var MarketSegmentationParam = {
                    AllMarketSegIds: encodeURI(strAllMarketSegIds),
                    ProjectID: encodeURI(ProjectID)
                }
                var param = JSON.stringify(MarketSegmentationParam);
                var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/InsertMarketSegmentationDetails", param, false);
                //console.log(strResult);
                alertify.success("Market Segmentation Details Updated Successfully.")

                GetMarketSegmentationDetails()
                refreshMyParent();
                strAllMarketSegIds = "";
            }

            function ExternalMarketSegchkboxclickevent(id, row) {

                if (id.indexOf("SubMarketName") > -1) {
                    var Marketchkboxid = id.replace('SubMarketName', '');
                }
                else if (id.indexOf("ExternalMarketName") > -1) {
                    var Marketchkboxid = id.replace('ExternalMarketName', '');
                }
                else {
                    var Marketchkboxid = id.replace('MarketName', '');
                }


                for (var i = 0; i < arrMarketIds.length; i++) {
                    var MarketID = arrMarketIds[i];
                    var pos1 = MarketID.indexOf(':');

                    var MarketValue = MarketID.substring(0, pos1);

                    if (Marketchkboxid == MarketValue) {

                        var Marketchkboxid1 = MarketID.replace(":", "\\:");
                        var Marketchkbxid = "#col" + Marketchkboxid + " > div>input[type=checkbox]";
                        var SubMarketValue = "#col" + Marketchkboxid1 + " > div>input[type=checkbox]";

                        if ($(Marketchkbxid).is(':checked') == true) {


                            $(SubMarketValue).prop('checked', true);


                        } else {
                            $(SubMarketValue).prop('checked', false);

                        }

                    }
                }

                for (var j = 0; j < arrSubMarketIds.length; j++) {
                    var subMarketid = arrSubMarketIds[j];
                    var pos1 = subMarketid.indexOf(':');
                    var pos2 = subMarketid.indexOf(":", subMarketid.indexOf(":") + 1);

                    var MarketValue = subMarketid.substring(0, pos1);

                    if (Marketchkboxid == MarketValue) {

                        var Subchkboxid1 = subMarketid.replace(":", "\\:");

                        Subchkboxid1 = Subchkboxid1.append(pos2 + 1, "\\");
                        var MarketChkid = "#col" + Marketchkboxid + " > div>input[type=checkbox]";
                        var subMarketValue = "#col" + Subchkboxid1 + " > div>input[type=checkbox]";

                        if ($(MarketChkid).is(':checked') == true) {

                            $(subMarketValue).prop('checked', true);

                        } else {

                            $(subMarketValue).prop('checked', false);

                        }

                    }
                }

                MarketSegAllcheckkboxchekedORuncheckd();
            }

            function MarketSegchkboxclickevent(id, row) {
                if (id.indexOf("SubMarketName") > -1) {
                    var Marketchkboxid = id.replace('SubMarketName', '');
                    var Marketchkboxid2 = id.replace('SubMarketName', '');
                    var Marketchkboxid3 = id.replace('SubMarketName', '');

                }
                else if (id.indexOf("ExternalMarketName") > -1) {
                    var Marketchkboxid = id.replace('ExternalMarketName', '');
                    var Marketchkboxid2 = id.replace('ExternalMarketName', '');
                    var Marketchkboxid3 = id.replace('ExternalMarketName', '');
                }
                else {
                    var Marketchkboxid = id.replace('MarketName', '');
                    var Marketchkboxid2 = id.replace('MarketName', '');
                    var Marketchkboxid3 = id.replace('MarketName', '');
                }

                var pos1 = Marketchkboxid.indexOf(':');
                var MarketValue = Marketchkboxid.substring(0, pos1);

                var chkMarketboxid = "#col" + MarketValue + " > div>input[type=checkbox]";
                Marketchkboxid = Marketchkboxid.replace(":", "\\:");

                if ($(chkMarketboxid).is(':checked') == true) {

                } else {

                    $(chkMarketboxid).prop('checked', true);

                }


                Marketchkboxid2 = Marketchkboxid2.replace(":", "\\:");
                var chkMarketboxid = "#col" + Marketchkboxid2 + " > div>input[type=checkbox]";

                if ($(chkMarketboxid).is(':checked') == true) {

                    //for (var j = 0; j < arrSubMarketIds.length; j++) {
                    //    var SubMarketID = arrSubMarketIds[j];
                    //    var pos1 = SubMarketID.indexOf(':');
                    //    var pos2 = SubMarketID.indexOf(":", SubMarketID.indexOf(":") + 1);

                    //    var MarketValue = SubMarketID.substring(0, pos2);

                    //    if (Marketchkboxid3 == MarketValue) {

                    //        var Marketchkboxid1 = SubMarketID.replace(":", "\\:");

                    //        Marketchkboxid1 = Marketchkboxid1.append(pos2 + 1, "\\");

                    //        var subMarketValue = "#col" + Marketchkboxid1 + " > div>input[type=checkbox]";

                    //        $(subMarketValue).prop('checked', true);
                    //    }

                    //}


                }
                else {

                    for (var j = 0; j < arrSubMarketIds.length; j++) {
                        var SubMarketID = arrSubMarketIds[j];
                        var pos1 = SubMarketID.indexOf(':');
                        var pos2 = SubMarketID.indexOf(":", SubMarketID.indexOf(":") + 1);

                        var MarketValue = SubMarketID.substring(0, pos2);

                        if (Marketchkboxid3 == MarketValue) {

                            var Marketchkboxid1 = SubMarketID.replace(":", "\\:");

                            Marketchkboxid1 = Marketchkboxid1.append(pos2 + 1, "\\");

                            var subMarketValue = "#col" + Marketchkboxid1 + " > div>input[type=checkbox]";

                            $(subMarketValue).prop('checked', false);




                        }

                    }

                }
                MarketSegAllcheckkboxchekedORuncheckd();
            }

            function SubMarketChkboxclickevent(id, row) {
                if (id.indexOf("SubMarketName") > -1) {
                    var Marketchkboxid = id.replace('SubMarketName', '');
                }
                else if (id.indexOf("ExternalMarketName") > -1) {
                    var Marketchkboxid = id.replace('ExternalMarketName', '');
                }
                else {
                    var Marketchkboxid = id.replace('MarketName', '');
                }

                var pos1 = Marketchkboxid.indexOf(':');
                var pos2 = Marketchkboxid.indexOf(":", Marketchkboxid.indexOf(":") + 1);

                var MarketValue = Marketchkboxid.substring(0, pos1);
                var SubMarketValue = Marketchkboxid.substring(0, pos2);
                SubMarketValue = SubMarketValue.replace(":", "\\:");

                var chkbxid = "#col" + SubMarketValue + " > div>input[type=checkbox]";
                var chkMarketbxid = "#col" + MarketValue + " > div>input[type=checkbox]";

                Marketchkboxid = Marketchkboxid.replace(":", "\\:");
                Marketchkboxid = Marketchkboxid.append(pos2 + 1, "\\");

                if ($(chkMarketbxid).is(':checked') == true) {

                } else {

                    $(chkMarketbxid).prop('checked', true);
                }

                if ($(chkbxid).is(':checked') == true) {

                } else {

                    $(chkbxid).prop('checked', true);

                }

                MarketSegAllcheckkboxchekedORuncheckd();

            }

            //Check Or Unchecked All Check Box
            function MarketSegAllcheckkboxchekedORuncheckd() {
                var ck_box_cnt = $('#MarketSegTblbody input[type="checkbox"]').length;
                var chk_box_checked_cnt = $('#MarketSegTblbody input[type="checkbox"]:checked').length;
                if (ck_box_cnt == chk_box_checked_cnt) {
                    $('#MarketSegTbl > thead > tr > th.sm-wid > div>input#marketSegAll').prop('checked', true);
                } else {
                    $('#MarketSegTbl > thead > tr > th.sm-wid > div>input#marketSegAll').prop('checked', false);
                }
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

                        //StopAjaxLoader("#WBSBody");
                        ajaxResult = data;
                    },
                    error: function (err) {
                        //StopAjaxLoader("#WBSBody");
                        console.log(err);
                        //window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
                return ajaxResult;
            }

            //Added By Reshma On 29Nov 2019
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


            function GetProjectName(ProjectID) {
                //var ProjectID = ProjectID;
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
                        $("#spanProjectName").text(result);
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }
        //End Added By Reshma On 29Nov 2019



        </script>
    </div>
</body>

</html>

