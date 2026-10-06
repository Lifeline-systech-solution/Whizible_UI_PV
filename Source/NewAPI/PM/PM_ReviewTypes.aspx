<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ReviewTypes.aspx.vb" Inherits="PbNIT.PM_ReviewTypes" %>

<!DOCTYPE html>
<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Review Type")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--created by Vishal Mahajan 07-11-2019--%>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Review Type</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
    
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- bootstrap select -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.4">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <!-- media_queries -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">--%>

    <!-- bootstrap wysihtml5 - text editor -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">--%>

    <!--<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,400i,500,700" rel="stylesheet">-->

    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

</head>

    <style>
         .alertify-notifier {
            z-index: 99999 !important;
        }
         .alertify-notifier {
            color: #fff;
            background: rgba(217, 92, 92, 0,95);
            text-shadow: -1px -1px 0 rgba(0, 0, 0, 0,5);
        }
        input[type=checkbox][disabled] .custom_chckbox label {
            cursor: not-allowed;
        }

        .custom_chckbox input[type=checkbox][disabled] + label:before {
            margin-right: 15px;
            CURSOR: NOT-ALLOWED;
        }

        body {
            background: #fff;
        }

        .auditBtn-grp .text-start.disIn {
            margin-left: 10px;
        }

        .subreviewdiv {
            position: relative;
        }

            .subreviewdiv a.accordion-toggle {
                left: 0;
            }
        /*.modalpgHead {                   
            background: #4263c1;
            color: #fff;
            font-family: 'Roboto', sans-serif;
            font-size: 20px;
        }*/
        .modal-header{display:block}
    </style>

<body id="bodyReviewType" class="hold-transition skin-blue-light sidebar-mini dashmain fixed ">
    <div id="divProjectReviewType">
        <!-- Bootsrap closable alert start-->
        <div id="CloseableAlert" class="alert autoclosablemsg animated slideInRight ClosaeblealertMsg">
            <button type="button" onclick="CloseShowAlert()" class="close">×</button>
            <p id="alertMsg"></p>
        </div>
        <!-- Bootsrap closable alert end -->
        <% If m_ViewAccess = True Then %>
        <!--ps_Review_Types_list_table_start-->
        <div class="tab-pane review-tbl in active" id="pstbl-reviewtype">
           
            <div class="modalpgHead pt-1 pb-1 col-sm-12">Review Type</div>
            <div class=" pt-1 pb-1 col-sm-12 text-end">
                    <h5 class="float-start mb-0">Project Name : <span id="spanProjectName"></span></h5>
                    <div class="">
                        <button type="submit" id="btnAddReviewType" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#ReviewTypePopup"><%= MyBase.GetResourceString("C_Add_New_ReviwType") %></button>
                    </div>
                </div>
           
            <div class="col-sm-12">
                <table id="" class="table table-stripped table-bordered">
                    <thead>
                        <tr>
                            <th class="text-start"><%= MyBase.GetResourceString("C_ReviewType") %></th>
                            <th class="text-start"><%= MyBase.GetResourceString("C_MappedtoCorporateReviewType") %></th>
                            <th class="text-end">&nbsp;
                            </th>
                        </tr>
                    </thead>
                    <tbody id="tbodyReviewType">
                    </tbody>
                </table>
            </div>
        </div>
        <!--ps_Review_Types_list_table_end-->
        <% Else %>
        <div id="NotAuthorized">
            <%--<h4>You Are Not Autorized to View This Record.</h4>--%>
        </div>
        <% End If %>
        <!--Add new site modal end here-->

        <!--Add review type modal start here-->

        <div class="modal custmodal fade" id="ReviewTypePopup" aria-hidden="true" style="">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ReviewType_Titile") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-12 mb-10" style="display:inline-flex">
                                    <label class="control-label col-sm-4"><%= MyBase.GetResourceString("C_ReviewType") %><span style="color: red;"> *</span></label>
                                    <div class="col-sm-8">
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtReviewType", "txtReviewType", "form-control",, 100,,,,,,,,,,,,,,, True) %>
                                    </div>
                                </div>
                                <div class="col-sm-12" style="display:inline-flex">
                                    <label class="control-label col-sm-4"><%= MyBase.GetResourceString("C_MappedtoCorporateReviewType") %><span style="color: red;"> *</span></label>
                                    <div class="col-sm-8">
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboCorporateReviewType", "usp_Sel_tbl_PM_CorporateReviewTypes_ForMapping " & IIf(Request.QueryString("ProjectID") = Nothing, 0, Request.QueryString("ProjectID")),,, "class='form-control'", False,, ) %>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="">
                            <div class="row">
                                <!--<label class="control-label col-sm-4">&nbsp;</label>-->
                                <div class="col-sm-12 btns-center btn-grp-new">
                                    <button data-bs-dismiss="modal" class="btn borderbtn">Close</button>
                                    <button onclick="saveReviewType()" class="btn btnyellow float-end ml-1">Save</button>
                                    <!--<button data-bs-dismiss="modal" class="btn btnyellow float-end">Save and Add</button>-->
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

        <!--Add review type moodal end here-->


        <!--Add review cause modal start here-->
        <div class="modal custmodal fade" id="ReviewCausePopup" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ReviewCause_Titile") %></h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-12 mb-10" style="display:inline-flex">
                                    <label class="control-label col-sm-4"><%= MyBase.GetResourceString("C_ReviewCause") %><span style="color: red;"> *</span></label>
                                    <div class="col-sm-8">
                                        <input type="hidden" id="PReviewTypeID" value="0" />
                                        <input type="hidden" id="PReviewCauseID" value="0" />
                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtReviewCause", "txtReviewCause", "form-control",, 200,,,,,,,,,,,,,,, True) %>
                                    </div>
                                </div>
                                <div class="col-sm-12" style="display:inline-flex">
                                    <label class="control-label col-sm-4"><%= MyBase.GetResourceString("C_MappedtoCorporateReviewCause") %><span style="color: red;"> *</span></label>
                                    <div class="col-sm-8">
                                        <%--<div class="custom-dropdown">--%>
                                        <select class="form-control" id="cboCorporateReviewCause">
                                        </select>
                                        <%--</div>--%>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="">
                            <div class="row">
                                <!--<label class="control-label col-sm-4">&nbsp;</label>-->
                                <div class="col-sm-12 btns-center btn-grp-new">

                                    <%If m_EditAccess = True Then %>
                                    <button data-bs-dismiss="modal" class="btn borderbtn">Close</button>
                                    <button class="btn btnyellow float-end ml-1 savereviewcause">Save</button>
                                    <%End If%>
                                    <%If m_EditAccess = False Then %>
                                    <button data-bs-dismiss="modal" style="margin-right: 14%;" class="btn borderbtn">Close</button>
                                    <%End If%>
                                </div>
                            </div>
                        </div>
                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!--Add review cause moodal end here-->

        <%--Delete Review Type Modal Starts--%>
        <div id="deleteReviewTypemodal" class="modal fade custmodal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modalmd ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" onclick="cancelReviewTypeDelete()" data-bs-dismiss="modal">×</button>
                        <h4 class="modal-title">Delete Confirmation</h4>
                    </div>

                    <div class="modal-body">
                        <span id="DeleteReviewTypeId"></span>
                        <p align="center">Are you sure you want to delete these records?</p>

                        <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" onclick="cancelReviewTypeDelete()">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="DeleteReviewType()" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <%--Delete Review Type Modal Ends--%>

        <%--Delete Review Cause Modal Starts--%>
        <div id="deleteReviewCausemodal" class="modal fade custmodal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modalmd ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" onclick="cancelReviewCauseDelete()" data-bs-dismiss="modal">×</button>
                        <h4 class="modal-title">Delete Confirmation</h4>
                    </div>

                    <div class="modal-body">
                        <span id=""></span>
                        <p align="center"><%= MyBase.GetResourceString("C_Delete_Confirmation") %></p>

                        <div class="mt-2">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" onclick="cancelReviewCauseDelete()">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="DeleteReviewCause()">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <%--Delete Review Cause Modal Ends--%>

        <!-- ./wrapper -->
        <!-- REQUIRED JS SCRIPTS -->
        
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
        <!-- jqueryUI js -->
        <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>       
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>        
        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
        <script src="../../General/CommonValidations.js"></script>
        <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>

        <%--created by Vishal Mahajan 07-11-2019--%>
        <script>
            //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
            var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
            var UserName = '<%= Session("strUserName") %>';
            var LoginId = '<%= Session("intLoginID") %>';
            var LoginType = '<%= Session("LoginType") %>';
            var RoleID = '<%= Session("intPostID") %>';
            var UserID = '<%= Session("intUserID") %>';
            var UserName = '<%= Session("strUserName") %>';
            var AddAccess ='<%= m_AddAccess %>';
            var EditAccess = '<%= m_EditAccess %>';
            var DeleteAccess = '<%= m_DeleteAccess %>';
            var ViewAccess = '<%= m_ViewAccess %>';
            var ProjectID;

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

            //start document ready created by Vishal Mahajan 07-11-2019
            $(document).ready(function () {
                if (ViewAccess == "False") {
                    var bodyHTML = '';
                    bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                    $("#divProjectReviewType").html(bodyHTML);
                    return;
                }
                params = getParams();
                ProjectID = unescape(params["ProjectID"]);
                
                GetProjectName(ProjectID);

                fillMappedCorporateReviewTypes();
                getAllReviewTypes();

                //set access permissions
                setUserAccess();

                $(document).on("click", ".closeIn", function () {
                    //Commented And Added by omkar On 20/12/2019
                    //$(this).closest(".collapse").removeClass("in");
                    //$(this).closest(".accordion-toggle").addClass("collapsed");
                    
                    var id = this.id;
                    id = id.replace("btncls", "lnk");
                    $(this).closest(".collapse").removeClass("in");
                    $("#" + id + ".accordion-toggle").addClass("collapsed");
                    //End Of Added by omkar On 20/12/2019
                    //$(".collapse").removeClass("in");
                    //$(".accordion-toggle").addClass("collapsed");
                });

                $(".nostylebtn").click(function () {
                    $(this).closest('tr').remove();
                    //$(this).closest('tr').next().remove();
                });

                //add new review type 
                $("#btnAddReviewType").click(function () {
                    clearAddReviewTypeControl();
                });

                //save review cause 
                $(".savereviewcause").click(function () {
                    saveReviewCause();
                });




                //all check event of review cause
                $(document).on("change", ".chckHead", function () {

                    var idcheckedchckHead = $(this)[0].id;
                    $("." + idcheckedchckHead).prop('checked', $(this).prop('checked'));
                });

                //individual check event of review cause 
                $(document).on("change", ".chcktbl", function () {
                    var reviewtypeid = $(this)[0].name;
                    var checkedtbl = $(this).is(':checked');
                    if (checkedtbl) {
                        var allchkchecked = 0;
                        var allchk = 0;

                        $("#tbodyReviewCause" + reviewtypeid).find(".chkAllReview" + reviewtypeid).each(function (index, chk) {
                            if ($(chk).is(':checked')) {
                                allchkchecked++;
                            }
                            allchk++;
                        });
                        if (allchkchecked == allchk) {
                            $("#chkAllReview" + reviewtypeid).prop("checked", true);
                        }
                    }
                    else {
                        $("#chkAllReview" + reviewtypeid).prop("checked", false);
                    }
                });

                $('[data-bs-toggle="tooltip"]').tooltip();
            });
            //end document ready        


            //All functions created by Vishal Mahajan 07-11-2019

            //set user acess
            function setUserAccess() {
                if (AddAccess == "False") {
                    $("#btnAddReviewType").prop('disabled', true);
                    $("#btnAddReviewType").hide();
                    $("#btnAddReviewType").attr('title', 'You Dont have access to add');
                }
            }
            //Added By Rehan C To add Validator for Special characters on 09th Nov 2022
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
            //clear addreview type control
            function clearAddReviewTypeControl() {
                $("#txtReviewType").val('');
                $("#cboCorporateReviewType").val('0');
            }

            function clearAddReviewCauseControl() {

                $("#PReviewTypeID").val('0');
                $("#PReviewCauseID").val('0');
                $("#txtReviewCause").val('');
                $("#cboCorporateReviewCause").val('');
            }

            function btnEditReviewType(PReviewTypeID) {

                StartLoader("#bodyReviewType");
                var reviewType = $("#txtReviewType" + PReviewTypeID).val().trim();
                var corporateReviewTypeID = $("#cmbCorporateReviewType_" + PReviewTypeID).val();
                var corporateReviewType = $("#cmbCorporateReviewType_" + PReviewTypeID + " option:selected").text();
                if (reviewType == '') {
                    showAlert('<%= MyBase.GetResourceString("C_ReviewType_ReviewTypeShouldNotBlank") %>', 'alert-danger');
                StopAjaxLoader("#bodyReviewType");
            } else if (corporateReviewTypeID == '' || corporateReviewTypeID == undefined || corporateReviewTypeID == 0) {
                showAlert('<%= MyBase.GetResourceString("C_ReviewType_CorporateReviewTypeMandatory") %>', 'alert-danger');
                StopAjaxLoader("#bodyReviewType");
            } else {
                var parameterReviewType = {
                    PReviewTypeID: PReviewTypeID,
                    PReviewType: reviewType.trim(),
                    CReviewTypeID: corporateReviewTypeID,
                    CReviewType: corporateReviewType,
                    ProjectID: ProjectID,
                    CreatedBy: encodeURI(UserName),
                    ModifiedBy: encodeURI(UserName)
                }
                //Check ReviewTypeName duplicate 
                $.ajax({
                    url: strUrl + '/api/PM_ReviewTypes/IsDuplicateReviewTypeName',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(parameterReviewType),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (parameterReviewType) {
                            xhr.setRequestHeader("Params", encryptString(isJson(parameterReviewType) ? parameterReviewType : JSON.stringify(parameterReviewType)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        if (!result) {
                            $.ajax({
                                url: strUrl + '/api/PM_ReviewTypes/SaveReviewType',// Path
                                type: "POST",                                       //HTTP TYPE get /post
                                data: JSON.stringify(parameterReviewType),       // Parameters
                                dataType: "json",                                   //Retrun Type 
                                contentType: "application/json; charset=utf-8",     //
                                beforeSend: function (xhr) {
                                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                    if (parameterReviewType) {
                                        xhr.setRequestHeader("Params", encryptString(isJson(parameterReviewType) ? parameterReviewType : JSON.stringify(parameterReviewType)));
                                    }
                                },
                                //async: false,
                                success: function (result) {
                                    StopAjaxLoader("#bodyReviewType");
                                    if (parseInt(result) > 0) {
                                        showAlert('<%= MyBase.GetResourceString("C_Update_ReviewType_Successfully") %>', 'alert-success');
                                        $("#spanReviewType" + PReviewTypeID).text(reviewType.trim());
                                        $("#spanCorporateReviewType" + PReviewTypeID).text(corporateReviewType.trim());
                                    } else {
                                        showAlert('<%= MyBase.GetResourceString("C_Data_ReviewType_not_update") %>', 'alert-danger');
                                    }
                                },
                                error: function (err) {
                                    StopAjaxLoader("#bodyReviewType");
                                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                                }
                            });
                        } else {
                            showAlert('<%= MyBase.GetResourceString("C_ReviewTypeAlreadyExists") %>', 'alert-danger');
                                StopAjaxLoader("#bodyReviewType");
                            }
                        },
                        error: function (err) {
                            StopAjaxLoader("#bodyReviewType");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
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
                        newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ReviewType%>'&Mode=Edit&update=done";
                    }
                    newpath = newpath.toString().replace("&update=done", "");
                    var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                    var currentToken = getURLParameter(newpath, "PKToken");

                    newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ReviewType%>');
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
            //save review type
            function saveReviewType() {
              
                var ReviewType = $("#txtReviewType").val();
                StartLoader("#bodyReviewType");
                if ($("#txtReviewType").val().trim() == '') {
                    showAlert('<%= MyBase.GetResourceString("C_ReviewType_ReviewTypeShouldNotBlank") %>', 'alert-danger');
                    $("#txtReviewType").focus();
                    StopAjaxLoader("#bodyReviewType");
                }
                //Added By Rehan C To add Validator for Special characters on 15th Nov 2022
                else if (checkSpecialCharacter(ReviewType, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Review Type should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtReviewType").focus();
                    StopAjaxLoader("#bodyReviewType");
                    return false;
                }
                else if ($("#cboCorporateReviewType").val() == '' || $("#cboCorporateReviewType").val() == 0) {

                    showAlert('<%= MyBase.GetResourceString("C_ReviewType_CorporateReviewTypeMandatory") %>', 'alert-danger');
                    $("#cboCorporateReviewType").focus();
                    StopAjaxLoader("#bodyReviewType");
                } else {
                    var parameterReviewType = {
                        PReviewTypeID: 0,
                        PReviewType: $("#txtReviewType").val().trim(),
                        CReviewTypeID: $("#cboCorporateReviewType").val(),
                        CReviewType: $("#cboCorporateReviewType option:selected").text(),
                        ProjectID: ProjectID,
                        CreatedBy: encodeURI(UserName),
                        ModifiedBy: encodeURI(UserName)
                    }
                    //Check ReviewTypeName duplicate 
                    $.ajax({
                        url: strUrl + '/api/PM_ReviewTypes/IsDuplicateReviewTypeName',// Path
                        type: "POST",                                       //HTTP TYPE get /post
                        data: JSON.stringify(parameterReviewType),       // Parameters
                        dataType: "json",                                   //Retrun Type 
                        contentType: "application/json; charset=utf-8",     //
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (parameterReviewType) {
                                xhr.setRequestHeader("Params", encryptString(isJson(parameterReviewType) ? parameterReviewType : JSON.stringify(parameterReviewType)));
                            }
                        },
                        async: false,
                        success: function (result) {
                            if (!result) {

                                $.ajax({
                                    url: strUrl + '/api/PM_ReviewTypes/SaveReviewType',// Path
                                    type: "POST",                                       //HTTP TYPE get /post
                                    data: JSON.stringify(parameterReviewType),       // Parameters
                                    dataType: "json",                                   //Retrun Type 
                                    contentType: "application/json; charset=utf-8",     //
                                    beforeSend: function (xhr) {
                                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                        if (parameterReviewType) {
                                            xhr.setRequestHeader("Params", encryptString(isJson(parameterReviewType) ? parameterReviewType : JSON.stringify(parameterReviewType)));
                                        }
                                    },
                                    //async: false,
                                    success: function (result) {

                                        StopAjaxLoader("#bodyReviewType");
                                        if (parseInt(result) > 0) {
                                            showAlert('<%= MyBase.GetResourceString("C_Save_ReviewType_Successfully") %>', 'alert-success');
                                            getAllReviewTypes();
                                            clearAddReviewTypeControl();
                                           // $("#ReviewTypePopup").modal("hide");//Commented By Dipali V On 20th May 2020 For Issue ID 23055
                                            //by vishal Mahajan 24-12-2019
                                            refreshMyParent();
                                            //by vishal Mahajan 24-12-2019
                                        } else {
                                            showAlert('<%= MyBase.GetResourceString("C_Data_ReviewType_not_saved") %>', 'alert-danger');
                                        }
                                    },
                                    error: function (err) {
                                        StopAjaxLoader("#bodyReviewType");
                                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                                    }
                                });
                            } else {
                                showAlert('<%= MyBase.GetResourceString("C_ReviewTypeAlreadyExists") %>', 'alert-danger');
                                StopAjaxLoader("#bodyReviewType");
                            }
                        },
                        error: function (err) {
                            StopAjaxLoader("#bodyReviewType");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
            }

            //save review cause
            function saveReviewCause() {

                StartLoader("#bodyReviewType");
                if ($("#txtReviewCause").val().trim() == '')
                {
                    showAlert('<%= MyBase.GetResourceString("C_ReviewCause_ReviewCauseShouldNotBlank") %>', 'alert-danger');
                StopAjaxLoader("#bodyReviewType");
                }
                else if (checkSpecialCharacter($("#txtReviewCause").val().trim(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Review Cause should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtReviewCause").focus();
                    StopAjaxLoader("#bodyReviewType");
                    return false;
                }
                else if ($("#cboCorporateReviewCause").val() == null || $("#cboCorporateReviewCause").val() == '' || $("#cboCorporateReviewCause").val() == 0)
                {
                showAlert('<%= MyBase.GetResourceString("C_ReviewCause_CorporateReviewCauseMandatory") %>', 'alert-danger');
                StopAjaxLoader("#bodyReviewType");
                }
                else {

                var parameterReviewCause = {
                    PReviewCauseID: $("#PReviewCauseID").val(),
                    PReviewCause: $("#txtReviewCause").val().trim(),
                    CReviewCauseID: $("#cboCorporateReviewCause").val(),
                    CReviewCause: $("#cboCorporateReviewCause option:selected").text(),
                    PReviewTypeID: $("#PReviewTypeID").val(),
                    ProjectID: ProjectID,
                    CreatedBy: encodeURI(UserName),
                    ModifiedBy: encodeURI(UserName)
                }

                //Check ReviewCauseName duplicate 
                $.ajax({
                    url: strUrl + '/api/PM_ReviewTypes/IsDuplicateReviewCauseName',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(parameterReviewCause),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (parameterReviewCause) {
                            xhr.setRequestHeader("Params", encryptString(isJson(parameterReviewCause) ? parameterReviewCause : JSON.stringify(parameterReviewCause)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        if (!result) {

                            $.ajax({
                                url: strUrl + '/api/PM_ReviewTypes/SaveReviewCause',// Path
                                type: "POST",                                       //HTTP TYPE get /post
                                data: JSON.stringify(parameterReviewCause),       // Parameters
                                dataType: "json",                                   //Retrun Type 
                                contentType: "application/json; charset=utf-8",     //
                                beforeSend: function (xhr) {
                                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                    if (parameterReviewCause) {
                                        xhr.setRequestHeader("Params", encryptString(isJson(parameterReviewCause) ? parameterReviewCause : JSON.stringify(parameterReviewCause)));
                                    }
                                },
                                //async: false,
                                success: function (result) {

                                    StopAjaxLoader("#bodyReviewType");
                                    if (parseInt(result) > 0) {
                                        <%--showAlert('<%= MyBase.GetResourceString("C_Save_ReviewCause_Successfully") %>', 'alert-success');--%>
                                        //by vishal Mahajan 24-12-2019
                                        if ($("#PReviewCauseID").val() == "0") {
                                            showAlert('<%= MyBase.GetResourceString("C_Save_ReviewCause_Successfully") %>', 'alert-success');
                                        } else {
                                            showAlert('<%= MyBase.GetResourceString("C_Update_ReviewCause_Successfully") %>', 'alert-success');
                                        }
                                        //by vishal Mahajan 24-12-2019
                                        getAllReviewCauses();
                                        clearAddReviewCauseControl();
                                        $("#ReviewCausePopup").modal("hide");
                                    } else {
                                        showAlert('<%= MyBase.GetResourceString("C_Data_ReviewCause_not_saved") %>', 'alert-danger');
                                    }
                                },
                                error: function (err) {
                                    StopAjaxLoader("#bodyReviewType");
                                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                                }
                            });
                        } else {
                            showAlert('<%= MyBase.GetResourceString("C_ReviewCauseAlreadyExists") %>', 'alert-danger');
                                StopAjaxLoader("#bodyReviewType");
                            }
                        },
                        error: function (err) {
                            StopAjaxLoader("#bodyReviewType");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });
                }
            }

            // add newreview cause
            function addReviewCauses(PReviewTypeID) {
                clearAddReviewCauseControl();
                fillMappedCorporateReviewCauses(PReviewTypeID);
                $("#PReviewTypeID").val(PReviewTypeID);
            }

            //fill all Mapped to Corporate Review Type
            var CorporateReviewTypeList = '';
            function fillMappedCorporateReviewTypes() {
                var parameterCorporateReviewType = {
                    ProjectID: ProjectID
                }

                $.ajax({
                    url: strUrl + '/api/PM_ReviewTypes/GetMappedCorporateReviewTypes',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(parameterCorporateReviewType),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (parameterCorporateReviewType) {
                            xhr.setRequestHeader("Params", encryptString(isJson(parameterCorporateReviewType) ? parameterCorporateReviewType : JSON.stringify(parameterCorporateReviewType)));
                        }
                    },
                    async: false,
                    success: function (result) {
                        CorporateReviewTypeList = result;                       
                        $("#cboCorporateReviewType").empty().append('<option value=0>Select Review Type</option>');
                        $.each(result, function () {
                            $("#cboCorporateReviewType").append($("<option></option>").val(this['CReviewTypeID']).html(this['CReviewType']));
                        });
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            //fill all Mapped to Corporate Review Cause
            function fillMappedCorporateReviewCauses(PReviewTypeID) {

                var parameterCorporateReviewCause = {
                    PReviewTypeID: PReviewTypeID
                }

                $.ajax({
                    url: strUrl + '/api/PM_ReviewTypes/GetMappedCorporateReviewCauses',// Path
                    type: "POST",                                       //HTTP TYPE get /post
                    data: JSON.stringify(parameterCorporateReviewCause),       // Parameters
                    dataType: "json",                                   //Retrun Type 
                    contentType: "application/json; charset=utf-8",     //
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (parameterCorporateReviewCause) {
                            xhr.setRequestHeader("Params", encryptString(isJson(parameterCorporateReviewCause) ? parameterCorporateReviewCause : JSON.stringify(parameterCorporateReviewCause)));
                        }
                    },
                    async: false,
                    success: function (result) {

                        $("#cboCorporateReviewCause").empty().append('<option value="0">Select Mapped to Corporate Review Cause</option>');
                        $.each(result, function () {
                            $("#cboCorporateReviewCause").append($("<option></option>").val(this['CReviewCauseID']).html(this['CReviewCause']));
                        });
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });

            }

            //edit binding of review causes
            function editReviewCauses(PReviewCauseID, CReviewCauseID, PReviewTypeID, editreviewanurtag) {
                $("#PReviewCauseID").val(PReviewCauseID);
                $("#PReviewTypeID").val(PReviewTypeID);
                var PReviewCause = editreviewanurtag.name;
                fillMappedCorporateReviewCauses(PReviewTypeID);
                $("#cboCorporateReviewCause").val(CReviewCauseID);
                $("#txtReviewCause").val(PReviewCause);
            }

            //delete ReviewType  
            function SetDeletedReviewTypeId(Id) {
                $('#DeleteReviewTypeId').attr('value', Id);
                $("#deleteReviewTypemodal").modal("show");
            }

            // cancel ReviewType Delete
            function cancelReviewTypeDelete() {
                $("#deleteReviewTypemodal").modal("hide");
                $("#DeleteReviewTypeId").removeAttr("value");
            }

            //start by Vishal Mahajan 12-10-2019
            var Common = {
                init: function () {
                    Common.endsWithForNotSupportedBrowser();
                },
                // endsWith for not supported browser. Eg. IE 10, IE 11.
                endsWithForNotSupportedBrowser: function () {
                    if (!String.prototype.endsWith) {
                        String.prototype.endsWith = function (searchString, position) {
                            var subjectString = this.toString();
                            if (typeof position !== 'number' || !isFinite(position) || Math.floor(position) !== position || position > subjectString.length) {
                                position = subjectString.length;
                            }
                            position -= searchString.length;
                            var lastIndex = subjectString.indexOf(searchString, position);
                            return lastIndex !== -1 && lastIndex === position;
                        };
                    }
                },
            };

            $(function () {
                Common.init();
            });
            //end by Vishal Mahajan 12-10-2019
            function DeleteReviewType() {

                var DeleteReviewTypeId = $("#DeleteReviewTypeId").attr("value");

                if (DeleteReviewTypeId.length != 0) {
                    var paramiters = {
                        PReviewTypeID: DeleteReviewTypeId,
                        ProjectID: ProjectID
                    }
                    StartLoader("#bodyReviewType");
                    $.ajax({
                        url: strUrl + '/api/PM_ReviewTypes/DeleteReviewType',
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json;charset-utf=8",
                        data: JSON.stringify(paramiters),
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (paramiters) {
                                xhr.setRequestHeader("Params", encryptString(isJson(paramiters) ? paramiters : JSON.stringify(paramiters)));
                            }
                        },
                        success: function (result) {

                            StopAjaxLoader("#bodyReviewType");
                            if (result.endsWith("successfully.")) {
                                $("#DeleteReviewTypeId").removeAttr("value");
                                showAlert(result, 'alert-success');
                                //by vishal Mahajan 24-12-2019
                                refreshMyParent();
                                //by vishal Mahajan 24-12-2019
                                getAllReviewTypes();
                            } else {
                                showAlert(result, 'alert-danger');
                            }
                        },
                        error: function (err) {
                            StopAjaxLoader("#bodyReviewType");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                        }
                    });

                }
            }

            function deleteReviewCauses(reviewtypeid) {
                var chkchecked = 0;
                $("#tbodyReviewCause" + reviewtypeid).find(".chkAllReview" + reviewtypeid).each(function (index, chk) {
                    if ($(chk).is(':checked')) {
                        chkchecked++;
                    }
                });
                if (chkchecked > 0) {
                    SetDeletedReviewCause(reviewtypeid);
                } else {
                    showAlert('<%= MyBase.GetResourceString("C_ReviewCause_Delete_SelectAtleastOneCheckBox") %>', 'alert-danger');
                }
            }

            //delete ReviewCause  
            function SetDeletedReviewCause(reviewtypeid) {
                $("#PReviewTypeID").val(reviewtypeid);
                $("#deleteReviewCausemodal").modal("show");
            }

            // cancel ReviewCause Delete
            function cancelReviewCauseDelete() {
                $("#PReviewTypeID").val('0');
                $("#deleteReviewCausemodal").modal("hide");
            }

            function DeleteReviewCause() {

                var chkchecked = 0;
                var PReviewCauseID = 0;
                var message = '';
                var reviewtypeid = $("#PReviewTypeID").val();
                if (reviewtypeid != '0' || reviewtypeid != '') {
                    StartLoader("#bodyReviewType");
                    $("#tbodyReviewCause" + reviewtypeid).find(".chkAllReview" + reviewtypeid).each(function (index, chk) {
                        if ($(chk).is(':checked')) {
                            chkchecked++;
                            PReviewCauseID = $(chk)[0].id.replace("chkReviewCause", "");
                            var paramiters = {
                                PReviewCauseID: PReviewCauseID,
                            }

                            $.ajax({
                                url: strUrl + '/api/PM_ReviewTypes/DeleteReviewCause',
                                type: "POST",
                                dataType: "json",
                                contentType: "application/json;charset-utf=8",
                                data: JSON.stringify(paramiters),
                                async: false,
                                beforeSend: function (xhr) {
                                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                    if (paramiters) {
                                        xhr.setRequestHeader("Params", encryptString(isJson(paramiters) ? paramiters : JSON.stringify(paramiters)));
                                    }
                                },
                                success: function (result) {

                                    message = message + result;
                                },
                                error: function (err) {
                                    StopAjaxLoader("#bodyReviewType");
                                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                                }
                            });
                        }
                    });
                    StopAjaxLoader("#bodyReviewType");
                }
                if (chkchecked == 0) {

                } else {

                    if (message.indexOf("cannot") != -1) {
                        showAlert(message, 'alert-danger');
                        if (message.indexOf("successfully") != -1) {
                            $(".reviewcause").prop('checked', false);
                            getAllReviewCauses();
                        }
                        //showAlert(message, 'alert-danger');
                    } else {
                        showAlert(message, 'alert-success');
                        $(".reviewcause").prop('checked', false);
                        getAllReviewCauses();
                        //showAlert(message, 'alert-success');
                    }
                    cancelReviewCauseDelete();
                }
            }

            //get all review types
            function getAllReviewTypes() {
                var paramitersReviewTypes = {
                    ProjectID: ProjectID
                }
                StartLoader("#bodyReviewType");
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ReviewTypes/GetReviewTypes',
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    data: JSON.stringify(paramitersReviewTypes),
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (paramitersReviewTypes) {
                            xhr.setRequestHeader("Params", encryptString(isJson(paramitersReviewTypes) ? paramitersReviewTypes : JSON.stringify(paramitersReviewTypes)));
                        }
                    },
                    success: function (result) {

                        $("#tbodyReviewType").html('');
                        var trs = '';
                        var trReviewTypeMater = '';
                        var innerReviewtbl = '';
                        var tbody_ofinnerReviewCauses = '';
                        var trReviewTypeMater_Causes = '';
                        if (result.length > 0) {
                            $.each(result, function (index, row) {
                                trReviewTypeMater = '<tr><td class="text-start">'
                                    //Commented And Added by omkar On 20/12/2019
                                    //+ '<div class="subreviewdiv"><a data-bs-toggle="collapse" data-bs-target="#Review' + row.PReviewTypeID + '" class="accordion-toggle collapsed" aria-expanded="false">'
                                    + '<div class="subreviewdiv"><a id="lnk' + row.PReviewTypeID + '" data-bs-toggle="collapse" data-bs-target="#Review' + row.PReviewTypeID + '" class="accordion-toggle collapsed" aria-expanded="false">'
                                    //End Of Added by omkar On 20/12/2019
                                    + '<img data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="" width="15px" data-original-title=""></a>'
                                    + '<span id="spanReviewType' + row.PReviewTypeID + '">' + row.PReviewType + '</span></div>'
                                    + '</td>'

                                    + '<td><span id="spanCorporateReviewType' + row.PReviewTypeID + '">' + row.CReviewType + '</span></td>'

                                    + '<td width="5%" class="text-center">'
                                    + (DeleteAccess == "False" ? '<a class="closeaction removerow nostylebtn" style="display: none;" title="You Dont have access to Delete" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body"><i class="far fa-trash-alt"></i></a>' : '<a class="closeaction removerow nostylebtn" onclick="SetDeletedReviewTypeId(' + row.PReviewTypeID + ')"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Delete"></i></a>')
                                    + '</td></tr>';
                                var CorporateReviewTypeDDL = $("<select></select>").attr("id", "cmbCorporateReviewType_" + row.PReviewTypeID).attr("class", "form-control");

                                if (CorporateReviewTypeList != '') {
                                    CorporateReviewTypeDDL.append("<option value=0> Select Mapped to Corporate Review Type</option>");
                                    $.each(CorporateReviewTypeList, function () {
                                        if (row.CReviewTypeID == this['CReviewTypeID']) {
                                            CorporateReviewTypeDDL.append($("<option selected='selected'></option>").val(this['CReviewTypeID']).html(this['CReviewType']));
                                        } else {
                                            CorporateReviewTypeDDL.append($("<option></option>").val(this['CReviewTypeID']).html(this['CReviewType']));
                                        }
                                    });
                                    //$("#cmbCorporateReviewType_" + row.PReviewTypeID).val(row.CReviewTypeID);
                                }

                                trReviewTypeMater_Causes = '<td colspan="5" class="hiddenRow subreviewTD text-start">'
                                    + '<div class="accordian-body collapse" id="Review' + row.PReviewTypeID + '" aria-expanded="true" style="">'
                                    + '<div class="row pt-1 pb-1 bgwhite">'
                                    + '<div class="col-sm-12">'
                                    + '<div class="row">'
                                    + ' <div class="col-sm-6"></div>'

                                    + '<div class="col-sm-6">'
                                    + '<div class="auditBtn-grp">'
                                    //Commented and Added by omkar on 20/12/2019
                                    //+ '<div class="text-start disIn"><a class="btn borderbtn closeIn" href="javascript:;">Close</a></div>'
                                    + '<div class="text-start disIn"><a id="btncls' + row.PReviewTypeID + '" class="btn borderbtn closeIn" href="javascript:;" onclick="closeCollapseBtn()">Close</a></div>'
                                    //End Of Added by omkar on 20/12/2019
                                    + '<div class="text-start disIn">'
                                    + (DeleteAccess == "False" ? '<a class="btn borderbtn" title="You Dont have access to Delete" style="display: none;" disabled="disabled" href = "javascript:;"> Delete</a ></div > ' : '<a class="btn borderbtn" onclick = "deleteReviewCauses(' + row.PReviewTypeID + ')" href = "javascript:;" > Delete</a ></div > ')
                                    + '<div class="text-start disIn">'
                                    + (EditAccess == "False" ? '<a class="btn btnyellow" title="You Dont have access to Edit" style="display: none;" disabled="disabled"  href = "javascript:;" > Save</a ></div >' : '<a class="btn btnyellow" onclick = "btnEditReviewType(' + row.PReviewTypeID + ')" href = "javascript:;" > <%= MyBase.GetResourceString("C_Edit_ReviewType") %></a ></div >')
                                + '<div class="text-start disIn">'
                                + (AddAccess == "False" ? '<button type="submit" class="btn btnyellow" data-bs-toggle="modal" style="display: none;" disabled="" title="You Dont have access to add">Add</button>' : '<button type="submit" class="btn btnyellow" data-bs-toggle="modal" onclick="addReviewCauses(' + row.PReviewTypeID + ')" data-bs-target="#ReviewCausePopup"><%= MyBase.GetResourceString("C_Add_New_ReviwCause") %></button>')
                                + '</div></div></div>'
                                + '</div>'
                                + '<br/>'
                                + '<div class="row">'
                                + '<div class="col-sm-6">'
                                + '<div class="auditform-field">'
                                + '<label><%= MyBase.GetResourceString("C_ReviewType") %><span style="color: red;"> *</span></label>'
                                + '<input type="text" maxlength="100" id="txtReviewType' + row.PReviewTypeID + '" name="" value="' + row.PReviewType + '" class="form-control">'
                                + '</div></div>'

                                + '<div class="col-sm-6">'
                                + '<div class="auditform-field">'
                                + '<label><%= MyBase.GetResourceString("C_MappedtoCorporateReviewType") %><span style="color: red;"> *</span></label>'
                                + '<div class="custom-dropdown">'
                                + CorporateReviewTypeDDL[0].outerHTML
                                + '</div></div></div>';

                            innerReviewtbl = '<div class="table-responsive col-sm-12 innerReviewtbl">'
                                + '<table id="" class="table table-stripped table-bordered">'
                                + '<thead><tr><th class="text-start"><%= MyBase.GetResourceString("C_ReviewCause") %></th><th class="text-start"><%= MyBase.GetResourceString("C_MappedtoCorporateReviewCause") %></th><th class="text-center">'
                                    + '<div class="form-check"><div class="custom_chckbox">'
                                    + (DeleteAccess == "False" ? '<input title="You Dont have access to Delete" style="display: none;" disabled="disabled" id="chkAllReview' + row.PReviewTypeID + '" class="reviewcause chckHead" type="checkbox">' : '<input id="chkAllReview' + row.PReviewTypeID + '" class="reviewcause chckHead" type="checkbox">')
                                    + '<label for="chkAllReview' + row.PReviewTypeID + '"></label>'
                                    + '</div></div></th></tr></thead>';
                                tbody_ofinnerReviewCauses = '<tbody id="tbodyReviewCause' + row.PReviewTypeID + '">';

                                if (row.listReviewTypeCauses.length > 0) {
                                    var tbodytrofinnerReviewCauses = '';
                                    $.each(row.listReviewTypeCauses, function (causeindex, causerow) {
                                        tbodytrofinnerReviewCauses = tbodytrofinnerReviewCauses
                                            + '<tr>'
                                            + '<td class="text-start">'
                                            + '<div class=""><a href="javascript:;" data-bs-toggle="modal" name="' + causerow.PReviewCause + '" onclick="editReviewCauses(' + causerow.PReviewCauseID + ',' + causerow.CReviewCauseID + ',' + causerow.PReviewTypeID + ',this)" data-bs-target="#ReviewCausePopup">' + causerow.PReviewCause + '</a></div> </td>'
                                            + '<td>' + causerow.CReviewCause + '</td >'
                                            + '<td width="5%" class="text-center">'
                                            + ' <div class="form-check">'
                                            + ' <div class="custom_chckbox">'
                                            + (DeleteAccess == "False" ? '<input title="You Dont have access to Delete" style="display: none;" disabled="disabled" name="' + row.PReviewTypeID + '" id="chkReviewCause' + causerow.PReviewCauseID + '" class="reviewcause chcktbl chkAllReview' + row.PReviewTypeID + '" type="checkbox">' : '<input name="' + row.PReviewTypeID + '" id="chkReviewCause' + causerow.PReviewCauseID + '" class="reviewcause chcktbl chkAllReview' + row.PReviewTypeID + '" type="checkbox">')
                                            + '<label for="chkReviewCause' + causerow.PReviewCauseID + '"></label>'
                                            + '</div></div></td></tr>';
                                    });
                                    tbody_ofinnerReviewCauses = tbody_ofinnerReviewCauses + tbodytrofinnerReviewCauses + '</tbody>';
                                } else {
                                    tbody_ofinnerReviewCauses = tbody_ofinnerReviewCauses + '</tbody>';
                                }

                                trs = trs + trReviewTypeMater + trReviewTypeMater_Causes + innerReviewtbl + tbody_ofinnerReviewCauses + '</table></div> </div></div>  </div> </div> </td>   </tr>';;
                            });
                            $("#tbodyReviewType").html(trs);
                        }
                        StopAjaxLoader("#bodyReviewType");
                        $('[data-bs-toggle="tooltip"]').tooltip();
                    },
                    error: function (err) {
                        StopAjaxLoader("#bodyReviewType");
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
            //end functions

            //get all review causes for specific review type
            function getAllReviewCauses() {
                StartLoader("#bodyReviewType");
                var paramitersReviewCauses = {
                    PReviewTypeID: $("#PReviewTypeID").val()
                }

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_ReviewTypes/GetReviewTypesCauses',
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json;charset-utf=8",
                    data: JSON.stringify(paramitersReviewCauses),
                    async: false,
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (paramitersReviewCauses) {
                            xhr.setRequestHeader("Params", encryptString(isJson(paramitersReviewCauses) ? paramitersReviewCauses : JSON.stringify(paramitersReviewCauses)));
                        }
                    },
                    success: function (result) {
                        //var PReviewTypeID = $("#PReviewTypeID").val();
                         //by vishal Mahajan 21-12-2019
                        var PReviewTypeID = $("#PReviewTypeID").val();
                        //by vishal Mahajan 21-12-2019
                        $("#chkAllReview" + PReviewTypeID).attr("checked",false);
                        
                        $("#tbodyReviewCause" + PReviewTypeID).html('');
                        if (result.length > 0) {
                            var tbodytrofinnerReviewCauses = '';
                            $.each(result, function (causeindex, causerow) {
                                tbodytrofinnerReviewCauses = tbodytrofinnerReviewCauses
                                    + '<tr>'
                                    + '<td class="text-start">'
                                    + '<div class=""><a href="javascript:;" data-bs-toggle="modal" name="' + causerow.PReviewCause + '" onclick="editReviewCauses(' + causerow.PReviewCauseID + ',' + causerow.CReviewCauseID + ',' + causerow.PReviewTypeID + ',this)" data-bs-target="#ReviewCausePopup">' + causerow.PReviewCause + '</a></div> </td>'
                                    + '<td>' + causerow.CReviewCause + '</td >'
                                    + '<td width="5%" class="text-center">'
                                    + ' <div class="form-check">'
                                    + ' <div class="custom_chckbox">'
                                    + '<input name="' + PReviewTypeID + '" id="chkReviewCause' + causerow.PReviewCauseID + '" class="reviewcause chcktbl chkAllReview' + PReviewTypeID + '" type="checkbox">'
                                    + '<label for="chkReviewCause' + causerow.PReviewCauseID + '"></label>'
                                    + '</div></div></td></tr>';
                            });
                            $("#tbodyReviewCause" + $("#PReviewTypeID").val()).html(tbodytrofinnerReviewCauses);
                        }
                        StopAjaxLoader("#bodyReviewType");
                    },
                    error: function (err) {
                        StopAjaxLoader("#bodyReviewType");
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
            //end functions
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
                var ProjectID = ProjectID;
                var Parameter = { ProjectID:ProjectID}
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
            //#region Alerts
            function showAlert(Msg, className, id) {
                //  
                $('.ClosaeblealertMsg').show();
                if (id != undefined) {
                    $('#' + id).prop("disabled", true);
                }
                if (className == 'alert-danger') {
                    $('#CloseableAlert').removeClass("alert-success");
                    $('#CloseableAlert').addClass("alert-danger");
                }
                else if (className == 'alert-success') {
                    $('#CloseableAlert').removeClass("alert-danger");
                    $('#CloseableAlert').addClass("alert-success");
                }
                $('#alertMsg').html(Msg);
                $('.ClosaeblealertMsg').delay(6000).fadeOut("fast", function () {
                    if (id != undefined) {
                        $('#' + id).prop("disabled", false);
                    }
                });
            }
            function CloseShowAlert() {
                $('.ClosaeblealertMsg').hide();
            }

            function showAlerts(Msg, className, id) {
                //  
                $('.ClosaeblealertMsg').show();
                if (id != undefined) {
                    $('#' + id).prop("disabled", true);
                }
                if (className == 'alert-danger') {
                    $('#CloseableAlerts').removeClass("alert-success");
                    $('#CloseableAlerts').addClass("alert-danger");
                }
                else if (className == 'alert-success') {
                    $('#CloseableAlerts').removeClass("alert-danger");
                    $('#CloseableAlerts').addClass("alert-success");
                }
                $('#alertMsgs').html(Msg);
                $('.ClosaeblealertMsg').delay(6000).fadeOut("fast", function () {
                    if (id != undefined) {
                        $('#' + id).prop("disabled", false);
                    }
                });
            }
            function CloseShowAlerts() {
                $('.ClosaeblealertMsg').hide();
            }
        //endregion


            function closeCollapseBtn() {
                $(".accordian-body").removeClass('show');
            }
        </script>
        <%--added by Vishal Mahajan 13-11-2019--%>
        
        <%--end--%>


    </div>
</body>

</html>

