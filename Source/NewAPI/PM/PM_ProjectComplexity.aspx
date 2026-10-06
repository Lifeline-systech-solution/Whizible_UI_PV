<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectComplexity.aspx.vb" Inherits="PbNIT.PM_ProjectComplexity" %>

<!DOCTYPE html>
<html>
        <!-- Commented by Madhuri.K On 09-Aug-2024 for JQuery and Bootstrap version upgrade -->
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

    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
<%--    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>

  
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

        .alertify-notifier {z-index:9999;}
        body {background-color:#fff;}
        .pl-20 {padding-left:20px;}
        #Projectcomplextbl {margin:0 auto 20px;width:97%;}
        .tbl-role-access .multi-selectbox, .tbl-role-access .inp-select {padding:8px !important;text-align: center !important;}
        .inp-select .custom_chckbox {text-align: center;}

    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="ProjectComplexity">
    <% If m_blnComplexityViewAccess = True Then %>

    <div class="tab-pane pstbl_complexity practicesettinglist in active" id="Main_complexity" style="border-top: 1px solid #ddd;">
         <div class="modalpgHead  pt-1 pb-1 col-sm-12 mb-10">
            <span>&nbsp;&nbsp;<%= MyBase.GetResourceString("C_IssueComplexity") %></span>
        </div>
        <h5 class="float-start pl-20 pt-3 clearfix">Project Name : <span id="spanProjectName"></span></h5>  
        <div class="right-side-save">
            <div class="input-wid-30">
                <% If m_blnComplexityAddAccess = True Then %>
                <!-- Added By Gauri On 20th Aug 2024 For Alignment Issue -->
                <button type="submit" class="btn borderbtn mr-5" onclick="AddComplexity(0);"><i class="fa fa-plus" aria-hidden="true"></i>&nbsp;<%= MyBase.GetResourceString("C_Add") %></button>
                <!-- End of Added By Gauri On 20th Aug 2024 For Alignment Issue -->
                <% End If %>
                <% If m_blnComplexityDeleteAccess = True Then %>
                <button id="delete-Complex" class="btn borderbtn" onclick="HideOrShowDeleteModal();">Delete</button>
                <% End If %>
            </div>
        </div>
        <table class="table table-stripted table-bordered tbl-role-access" id="Projectcomplextbl">
            <thead>
                <tr>
                    <th><%= MyBase.GetResourceString("C_Complexity") %></th>
                    <th><%= MyBase.GetResourceString("C_CorporateComplexity") %></th>
                    <th class="text-center"><%= MyBase.GetResourceString("C_DefaultComplexity") %></th>
                    <th class="text-center multi-selectbox">
                        <div class="custom_chckbox">
                            <input type="checkbox" id="complexityAll" class="chckHead">
                            <label for="complexityAll"></label>
                        </div>
                    </th>
                </tr>
            </thead>
            <tbody id="Projectcomplextblbody">
            </tbody>
        </table>
         <!-- Add new complexity modal start here -->
    <div class="modal custmodal fade" id="ProjectcomplexityModal" aria-hidden="true" data-keyboard="false" data-backdrop="static">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_IssueComplexity") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <span id="SpanComplexityID"></span>
                            <label class="required"><%= MyBase.GetResourceString("C_Complexity") %></label>
                            <% CommonFunctions.HTMLControls.DrawTextBox("txtProjectComplexity", "txtProjectComplexity", "form-control",, 50,,,,,,,, "autocomplete='off'",,, True,,,, True) %>
                        </div>
                        <div class="col-sm-6">
                            <label class="required"><%= MyBase.GetResourceString("C_CorporateComplexity") %></label>
                            <div class="custom-dropdown">

                                <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectComplexity", "Select ''",,, "class='form-select'",,, ) %>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 mar10">
                            <div class="custom_chckbox modal-inn-check">
                                <% CommonFunctions.HTMLControls.DrawCheckBox("chkProjectDefComplexity", "chkProjectDefComplexity") %>

                                <label for="chkProjectDefComplexity"></label>
                            </div>
                            <label><%= MyBase.GetResourceString("C_DefaultComplexity") %></label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 btns-center btn-grp-new">
                             <button data-bs-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_Close") %></button>
                             <button class="btn btnyellow float-end ml-1" onclick="SaveComplexity()" id="btnSaveComplexity"><%= MyBase.GetResourceString("C_Save") %></button>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!-- Add new complexity modal end here -->

    </div>
    <% Else %>
    <div id="NotAuthorized">
        <h4>You are not authorized to view this record. </h4>
    </div>
    <% End If %>

    <!--ps_list_table_end-->

   
    <div id="NoProjectDivID" hidden="hidden">
        <h4><i class="fa fa-exclamation-triangle" aria-hidden="true"></i>You have not selected any project, please select the project.</h4>
    </div>
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
                                <select class="form-control selectpicker">
                                    <option>Risk Analysis</option>
                                    <option>Requirement Analysis</option>
                                    <option>Feasibility Study</option>
                                    <option>Documentation</option>
                                    <option>Defect Analysis</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="">
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
    <div class="modal custmodal fade" id="CPdelComplexityModal" aria-hidden="true" data-keyboard="false" data-backdrop="static">
        <div class="modal-dialog modal-md" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_ConfirmDelete") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <p class="text-center">Are you sure, you want to delete the selected records?</p>
                    </div>
                    
                    <div class="col-sm-12 btn-grp-new">
                                    <button data-bs-dismiss="modal" class="btn borderbtn"><%= MyBase.GetResourceString("C_No") %></button>
                                    <button data-bs-dismiss="modal" class="btn btnyellow ml-1" onclick="DeleteComplexity();"><%= MyBase.GetResourceString("C_Yes") %></button>
                                </div>

                    <div class="clearfix"></div>

                </div>
            </div>
        </div>
    </div>
    <!--Delete_new_Sub_tasktype_modal_end_here-->

    <!-- ./wrapper -->
    <!-- REQUIRED JS SCRIPTS -->

     <!-- Commented by Madhuri.K On 09-Aug-2024 for JQuery and Bootstrap version upgrade -->
     <%--   <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.7.1.min.js"></script>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.3.2.min.js"></script>
        <!-- jqueryUI js -->
        <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>         
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
        <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
        <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>

    <!-- custome js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js?v=1"></script>--%>

    <script>
        //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        alertify.set('notifier', 'position', 'top-right');

        //var ProjectID = '<%= ProjectID %>';

        var ProjectID;
        var ajaxResult = "";       

        $(document).ready(function () {
           
            $("#complexityAll").click(function () {

                $(".complexitychck").prop('checked', $(this).prop('checked'));
            });

            params = getParams();
            ProjectID = unescape(params["ProjectID"]);
            GetProjectName(ProjectID); 

            if (ProjectID != 0) {
                GetComplexityList();
            }
            else {
                StartLoader("#ProjectComplexity");
                $("#NoProjectDivID").show();
                $("#Main_complexity").hide();
                StopAjaxLoader("#ProjectComplexity");
            }

        });        
        //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
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
        function GetComplexityList() {

            StartLoader("#ProjectComplexity");
            var ComplexityID = 0;
            var ComplexityPrameters = {
                ComplexityID: encodeURI(ComplexityID),
                ProjectID: encodeURI(ProjectID)
            }
            var paramater = JSON.stringify(ComplexityPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetComplexityList", paramater, false);

            $("#Projectcomplextblbody").html('');
            //Added by Chetan M on 20th Dec 2019
            if (strResult.length == 0) {
                $("#complexityAll").attr('disabled', true);
                $("#Projectcomplextblbody").html('<tr><td colspan ="4" style="text-align:center !important;">There are no items to show in this view.</td></tr>');
            }
            else {
                $("#complexityAll").removeAttr('disabled');
                //End of addition by Chetan M on 20th Dec 2019
                var strHTML = "";
                for (var i = 0; i < strResult.length; i++) {

                    var ComplexityID = strResult[i]["ComplexityID"]
                    var Complexity = strResult[i]["Complexity"];
                    var CorporateComplexity = strResult[i]["CorporateComplexity"];
                    var DefaultComplexity = strResult[i]["DefaultComplexity"];

                    //Commented and addded by Chetan M on 21th Dec 2019
                    //if (DefaultComplexity == false) {
                    if (DefaultComplexity == false || DefaultComplexity == null || DefaultComplexity == undefined || DefaultComplexity == "Null") {
                        //End of addition by Chetan M on 21th Dec 2019
                        DefaultComplexity = "No";
                    }
                    else {
                        DefaultComplexity = "Yes";
                    }

                    strHTML += ' <tr>'
                    <% If m_blnComplexityEditAccess = True Then %>
                    strHTML += ' <td> <a id="' + ComplexityID + '" onclick="AddComplexity(this.id);">' + Complexity + '</a></td>'
                   <% ELSE %>                    
                    strHTML += ' <td> ' + Complexity + '</td>'
                    <% END If %>
                    strHTML += ' <td>' + CorporateComplexity + '</td>'
                    strHTML += ' <td class="text-center">' + DefaultComplexity + '</td>'
                    strHTML += ' <td class="text-center inp-select">'
                    strHTML += ' <div class="custom_chckbox">'
                    strHTML += ' <input type="checkbox" id="a' + ComplexityID + '" class="chckHead complexitychck" name="chckcomplexity" onchange="OnchangeCheckBox(this.id);">'
                    strHTML += '<label for="a' + ComplexityID + '"></label>'
                    strHTML += ' </div>'
                    strHTML += '</td>'
                    strHTML += '</tr>'
                }

                $("#Projectcomplextblbody").html("")
                $("#Projectcomplextblbody").html(strHTML);
                //Added by Chetan M on 20th Dec 2019
            }
            //End of addition by Chetan M on 20th Dec 2019

            StopAjaxLoader("#ProjectComplexity");
           
        }

        
        function GetComplexity() {
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetComplexity", '', false);

            var objCbo1 = document.getElementById("cboProjectComplexity");

            $("#cboProjectComplexity option").remove();

            for (var i = 0; i < strResult.length; i++) {
                var Objresult = strResult[i];
                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);

                objOption.text = Objresult.Complexity;
                objOption.value = Objresult.Complexity == 'Select Complexity' ? '' : Objresult.Complexity;

            }

        }

        function AddComplexity(ComplexityID) {           
            if (ComplexityID == 0) {
                $("#txtProjectComplexity").val('');
                $("#cboProjectComplexity").text('Select Complexity');
                $("#chkProjectDefComplexity").prop('checked', false);
                GetComplexity();
                $('#SpanComplexityID').attr('value', ComplexityID);
                $("#ProjectcomplexityModal").modal("show");
            }
            else {

                EditComplexity(ComplexityID);

            }

        }
        function checkSpecialCharacter(value) {            
            var regularExpression = '{}|`~[]<>\!"@#$%^&*()_+-=/';
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
        function getURLParameter(url, name) {
            return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
        }
        function refreshMyParent() {
            try {
                var newpath = opener.window.location.href;
                if (newpath.indexOf('FromWhereProjectId') == -1) {
                    newpath = opener.window.location.href.replace('#', '?');
                    newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_ProjectComplexity%>'&Mode=Edit&update=done";
                }
                newpath = newpath.toString().replace("&update=done", "");
                var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
                var currentToken = getURLParameter(newpath, "PKToken");

                newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_ProjectComplexity%>');
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
        function SaveComplexity() {
            
            $("#btnSaveComplexity").removeAttr("data-bs-dismiss", "modal");
            var Checkval = false;
            var ComplexityID = $("#SpanComplexityID").attr("value");
            var Complexity = $("#txtProjectComplexity").val();
            var CorporateComplexity = $("#cboProjectComplexity").val();
            //Added by Dipali V On 9th Dec 2020 For remove Select all Check once save done
            $("#complexityAll").prop('checked', false);
            //End of Added by Dipali V On 9th Dec 2020 For remove Select all Check once save done
           
            //Added by Chetan M on 20th Dec 2019
            Complexity = $.trim(Complexity);
            //End of addition by Chetan M on 20th Dec 2019
            if (Complexity == '') {
                alertify.error("<%= MyBase.GetResourceString("A_Complexity") %>");
                //Added by Chetan M on 20th Dec 2019
                $("#txtProjectComplexity").focus();
                //End of addition by Chetan M on 20th Dec 2019
                Checkval = false;
            }
            else if (CorporateComplexity == '') {
                alertify.error("<%= MyBase.GetResourceString("A_CorporateComplexity") %>");
                //Added by Chetan M on 20th Dec 2019
                $("#cboProjectComplexity").focus();
                //End of addition by Chetan M on 20th Dec 2019
                Checkval = false;
            }
            //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
            else if (checkSpecialCharacter(Complexity, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Complexity should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtProjectComplexity").focus();
                Checkval =  false;
            }
            //else if (checkSpecialCharacter(Complexity) == true) {
            //    alertify.error('Complexity cannot contain any of these /\\:*?<>|,"+- Characters');
            //    //Added by Chetan M on 20th Dec 2019
            //    $("#txtProjectComplexity").focus();
            //    //End of addition by Chetan M on 20th Dec 2019
            //    //alertify.error('"Complexity cannot contain any of these /\\:*?<>|,"+- Characters'');
            //    Checkval = false;
            //}
            //commented and added by omkar 31/12/2019
            //else if (ComplexityID == 0) {
            else if (ComplexityID >= 0) {
            //end of commented and added by omkar 31/12/2019
                var IsExist = GetExistingComplexityNames(Complexity, ComplexityID);
                if (IsExist == false) {
                    Checkval = false;
                }
                else {
                    Checkval = true;
                }
            }
            else {
                Checkval = true;
            }
            if (Checkval == true) {
                if ($('#chkProjectDefComplexity').is(":checked")) {
                    var DefaultComplexity = 1;
                }
                else {
                    var DefaultComplexity = 0;
                }

                var ComplexityPrameters = {
                    Complexity: encodeURI(Complexity),
                    CorporateComplexity: encodeURI(CorporateComplexity),
                    ProjectID: encodeURI(ProjectID),
                    DefaultComplexity: encodeURI(DefaultComplexity),
                    ComplexityID: encodeURI(ComplexityID)
                }
                var Parameter = JSON.stringify(ComplexityPrameters);
                var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/InsertORUpdateComplexity", Parameter, false);
                //Added by Chetan M on 6 Nov 2020 for IssueID = 28106
                if (strResult.indexOf('||') > -1) {
                    var DataArray = new Array();
                    DataArray = strResult.split("||");
                    ComplexityID = DataArray[0];
                    $('#SpanComplexityID').attr('value', ComplexityID);
                    strResult = DataArray[1];
                    //Added and commented by Vishal Mane on 03/06/2026 for Rate Limiting
                    alertify.success(strResult);
                    GetComplexityList();
                    refreshMyParent();
                    //End of Added and commented by Vishal Mane on 03/06/2026 for Rate Limiting
                }
                //Commented by Vishal Mane on 03 / 06 / 2026 for Rate Limiting
                //alertify.success(strResult);
                //GetComplexityList();
                //refreshMyParent();
                //End of Commented by Vishal Mane on 03 / 06 / 2026 for Rate Limiting
            }
        }

        function EditComplexity(ComplexityID) {

            GetComplexity();
            $('#SpanComplexityID').attr('value', ComplexityID);
            $("#ProjectcomplexityModal").modal("show");


            var ComplexityPrameters = {
                ComplexityID: encodeURI(ComplexityID),
                ProjectID: encodeURI(ProjectID)
            }
            var paramater = JSON.stringify(ComplexityPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetComplexityList", paramater, false);

            for (var i = 0; i < strResult.length; i++) {
                var ComplexityID = strResult[i]["ComplexityID"]
                var Complexity = strResult[i]["Complexity"];
                var CorporateComplexity = strResult[i]["CorporateComplexity"];
                var DefaultComplexity = strResult[i]["DefaultComplexity"];

            }
            
            $("#txtProjectComplexity").val(Complexity);

            $("#cboProjectComplexity").val(CorporateComplexity);
            //Commented and addded by Chetan M on 21th Dec 2019
            //if (DefaultComplexity == false) {
            if (DefaultComplexity == false || DefaultComplexity == null || DefaultComplexity == undefined || DefaultComplexity == "Null") {
                //End of addition by Chetan M on 21th Dec 2019
                $("#chkProjectDefComplexity").prop('checked', false);
            } else {
                $("#chkProjectDefComplexity").prop('checked', true);
            }


        }

        function HideOrShowDeleteModal() {
            var ComplexityID = "";

            //Loop through all checked CheckBoxes in GridView.
            var selectedID = new Array();
            $('#Projectcomplextbl input[type="checkbox"]:checked').each(function () {
                selectedID.push($(this).attr('id'));
            });

            $.each(selectedID, function (i, item) {

                ComplexityID += selectedID[i] + ",";

            });
            ComplexityID = ComplexityID.replace(/a/g, '');

            if (ComplexityID == '') {
                $("#CPdelComplexityModal").modal("hide");
                alertify.error("Please Select Atleast One Record To Delete.");

            }
            else {
                $("#CPdelComplexityModal").modal("show");
            }
        }

        function DeleteComplexity() {

            var ComplexityID = "";

            //Loop through all checked CheckBoxes in GridView.
            var selectedID = new Array();
            $('#Projectcomplextbl input[type="checkbox"]:checked').each(function () {
                selectedID.push($(this).attr('id'));
            });

            $.each(selectedID, function (i, item) {

                ComplexityID += selectedID[i] + ",";

            });
            ComplexityID = ComplexityID.replace(/a/g, '');
            if (ComplexityID.indexOf('complexityAll') > -1) {
                ComplexityID = ComplexityID.replace('complexityAll,', '');
            }

            var ErrorResult = "";
            var SuccessResult = "";
            var ComplexityPrameters = {

                ProjectID: encodeURI(ProjectID),
                DelComplexityIDs: encodeURI(ComplexityID)
            }
            var paramater = JSON.stringify(ComplexityPrameters);
            var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/DeleteComplexity", paramater, false);
            if (strResult.indexOf("&&") > -1) {
                var Data = strResult.split("&&");
                for (var i = 0; i < Data.length; i++) {
                    if (Data[i].indexOf("cannot") > -1) {
                        ErrorResult += Data[i];
                    }
                    else {
                        SuccessResult += Data[i];
                    }

                }
                if (ErrorResult != '') {
                    alertify.error(ErrorResult);
                }
                if (SuccessResult != '') {
                    alertify.success(SuccessResult);
                }

            }
            else {
                alertify.success(strResult);
            }

            GetComplexityList();
            $("#complexityAll").prop('checked', false);
            refreshMyParent();
        }

        function OnchangeCheckBox() {
            Checked();
        }

        function Checked() {
            var checke = "";
            var checked = "";

            checke = $('#Projectcomplextblbody input[type="checkbox"]').length;
            checked = $('#Projectcomplextblbody input[type="checkbox"]:checked').length;

            if (checke == checked) {
                $("#Projectcomplextbl > thead> tr > th.multi-selectbox> div > #complexityAll").prop("checked", true);
            }
            else {
                $("#Projectcomplextbl > thead> tr > th.multi-selectbox> div > #complexityAll").prop("checked", false);
            }
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
            var Parameter = { ProjectId: ProjectID }
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

        //validate Complexity Name Duplicate
        function GetExistingComplexityNames(ComplexityName, ComplexityID) {              
             var ComplexityPrameters = {
                 ProjectID: encodeURI(ProjectID),
                 ComplexityID: encodeURI(ComplexityID),
              }
              var paramater = JSON.stringify(ComplexityPrameters);
              var strResult = AJAXCallWithResult("/api/PM_ProjectSettings/GetExistingComplexityNames", paramater, false);          
              if (strResult != undefined) {
                  for (var i = 0; i < strResult.length; i++) {
                      if (ComplexityName.toString().toUpperCase() == strResult[i].Complexity.toString().toUpperCase()) {
                          alertify.error("'Complexity Name' Already Exists.");
                          $('#txtProjectComplexity').focus();
                          return false;                                                 
                      }                                          
                  }
                  return true;
              }
         } 
        //End Added By Reshma On 29Nov 2019
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

    </script>
</body>

</html>
