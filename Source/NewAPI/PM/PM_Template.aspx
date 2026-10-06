<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Template.aspx.vb" Inherits="PbNIT.PM_Template" %>


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
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>

    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_projctsetting.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
    <!-- media_queries -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/media_queries.css?v=2">
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <!-- bootstrap wysihtml5 - text editor -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css">
</head>

    <style type="text/css">
      @media (min-width: 992px) {
    .collapsed {
        display: block;
        margin-right: 0%;
    }
}
.alertify-notifier { z-index: 9999 !important; }
.detailsubtabs li.active a.active {
    background: #4263c1;
    color: #fff;
}

#addSite .modal-body .form-group {margin-bottom: 15px;}
#addSite .modal-body .form-group label{ white-space:nowrap;}
.TemplateSiteDetailClass .form-group {display: flex;margin-bottom: 15px;}

/*Added by pradip on 7-4-2023*/
.detailsubtabs li{ margin-bottom:-2px;}
.detailsubtabs li a{ border:1px solid transparent; display:block;border-radius: 4px 4px 0 0;}
.nav.detailsubtabs>li>a:hover, .nav.detailsubtabs>li>a:active, .nav.detailsubtabs>li>a:focus{border: 1px solid #ddd;
    border-radius: 4px 4px 0 0; background:transparent; color:#1359ac; font-weight:500;}
.detailsubtabs li a.active, .detailsubtabs li a.active:focus-visible, .detailsubtabs li a.active:focus {border: 1px solid #ddd;background: #fff;border-bottom-color: transparent;color: #135a9c;font-weight: 500;}
.detailsubtabs li a:hover{ border-color:transparent!important; background:#f5f5f5!important;} 
/*End Added by pradip on 7-4-2023*/
    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed" id="bodyCutomerTemplate">

    <div id="template_tab" class="" style="overflow-y:auto;height: 100vh;">
        <div class="page-main-head">
            <h4><%= MyBase.GetResourceString("T_Site_Templates") %></h4>
        </div>
        <div class="right-side-save">
            <a href="javascript:;" data-bs-toggle="modal" id="linkAddTemplate" data-bs-target="#addTemplate" class="btn borderbtn"><i class="fa fa-plus" aria-hidden="true"></i><%= MyBase.GetResourceString("T_Add_Template") %></a>
        </div>
        <ul class="main-acco" id="ulTemplate">
        </ul>
        <!--Page modal start here-->


        <!--Add Template Modal start here-->
        <div class="modal custmodal fade" id="addTemplate" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("T_Add_Template") %></h5>
                        <button type="button" class="close" onclick="ClearAddNewTemplateControls()" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row form-group cont-center mb-3">
                            <div class="col-sm-6">
                                <label class="required"><%= MyBase.GetResourceString("T_Template_Name") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtTemplateName", "txtTemplateName", "form-control",, 50,,,, ,,,, "Autocomplete='off'",, ,,,,, True) %>
                                
                            </div>
                        </div>
                        <div class="center-align">
                            <a href="javascript:;" class="btn borderbtn mr-5" onclick="ClearAddNewTemplateControls()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("T_Close") %></a>
                            <a href="javascript:;" id="btnSaveNewTemplate" class="btn btnyellow" onclick="funsavenewtemplate()"><%= MyBase.GetResourceString("T_Save") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Add Template Modal end here-->


        <!--Add new site modal start here-->
        <div class="modal custmodal fade" id="addSite" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("T_Add_Site") %></h5>
                        <button type="button" onclick="ClearAddNewTaskControls()" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-sm-4"><%= MyBase.GetResourceString("T_Site_Master") %></label>
                                <div class="col-sm-8">
                                   
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboSiteMaster", "usp_Whizible2_sel_tbl_CNF_ProjectCostType ",,, "class='form-control form-select'", True,, ) %>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <label class="control-label required col-sm-4"><%= MyBase.GetResourceString("T_Site_Name") %></label>
                                <div class="col-sm-8">
                                   
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtTemplateSiteName", "txtTemplateSiteName", "form-control",, 50,,,, ,,,, "Autocomplete='off'",, ,,,,, True) %>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-sm-4"><%= MyBase.GetResourceString("T_City") %></label>
                                <div class="col-sm-8">
                                    
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtTemplateCity", "txtTemplateCity", "form-control",, 30,,,, ,,,, "Autocomplete='off'",, ,,,,, True) %>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <label class="control-label required col-sm-4"><%= MyBase.GetResourceString("T_Currency") %></label>
                                <div class="col-sm-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboTemplateSiteCurrency", "usp_Whizible2_sel_tbl_PM_CurrencyMaster",,, "class='form-control form-select'",,, ) %>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <label class="control-label required col-sm-4"><%= MyBase.GetResourceString("T_Rate_method") %></label>
                                <div class="col-sm-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboRateMethod", "Usp_Whizible2_Sel_tbl_PM_RateMethods ",,, "class='form-control form-select'",,, ) %>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <label class="control-label required col-sm-4"><%= MyBase.GetResourceString("T_Starting_day_of_week") %></label>
                                <div class="col-sm-8">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboStartingDayOfWeek", "Usp_Whizible2_Sel_WeekDays_DayNumbers ",,, "class='form-control form-select'",,, ) %>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <label class="control-label required col-sm-4">
                                    <%= MyBase.GetResourceString("T_Working_Days") %><span></span>
                                </label>
                                <div class="col-sm-8">
                                    <div class="row">
                                        <div class="col-sm-6">
                                            <%--<input type="text" id="wrkday" name="wrkday" class="form-control"></div>--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtWeekDays", "txtWeekDays", "form-control",, 1,,,, ,,,, "autocomplete='off' onPaste='return false' onkeypress='return restrictAlphabets(event, &quot;weekdays&quot;)'",, ,,,,, True) %>
                                        </div>
                                        <div class="col-sm-6 pl-0 pr-1"><span class="pt-half">Per Week <%--<%= MyBase.GetResourceString("C_PerWeek") %>--%></span></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label required col-sm-4">
                                    <%= MyBase.GetResourceString("T_Working_Hours") %><span></span>
                                </label>
                                <div class="col-sm-8">
                                    <div class="row">
                                        <div class="col-sm-6">
                                           
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtWorkHoursPerDay", "txtWorkHoursPerDay", "form-control",, 2,,,, ,,,, "autocomplete='off' onPaste='return false' onkeypress='return restrictAlphabets(event, &quot;workhrs&quot;)'",, ,,,,, True) %>
                                        </div>
                                        <div class="col-sm-6 pl-0"><span class="pt-half">Per Day <%--<%= MyBase.GetResourceString("C_PerDay") %>--%></span></div>
                                    </div>

                                </div>
                            </div>

                        </div>

                        <div class="form-group">
                            <div class="row">
                                <label class="control-label required col-sm-4">
                                    <%= MyBase.GetResourceString("T_Working_Hours") %><span></span>
                                </label>
                                <div class="col-sm-8">
                                    <div class="row">
                                        <div class="col-sm-6">
                                          
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtWorkHoursPerMonth", "txtWorkHoursPerMonth", "form-control",, 6,,,, ,,,, "autocomplete='off' onPaste='return false' onkeypress='return restrictAlphabets(event, &quot;workhrs&quot;)'",, ,,,,, True) %>
                                        </div>
                                        <div class="col-sm-6 pl-0"><span class="pt-half">Per Month <%--<%= MyBase.GetResourceString("C_PerMonth") %>--%></span></div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label required col-sm-4">
                                    <%= MyBase.GetResourceString("T_Working_Hours_Cap") %><span></span>
                                </label>
                                <div class="col-sm-8">
                                    <div class="row">
                                        <div class="col-sm-6">
                                           
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtWorkHoursCap", "txtWorkHoursCap", "form-control",, 6,,,, ,,,, "autocomplete='off' onPaste='return false' onkeypress='return restrictAlphabets(event, &quot;workhrs&quot;)'",, ,,,,, True) %>
                                        </div>
                                        <div class="col-sm-6 pl-0"><span class="pt-half">Per Day <%--<%= MyBase.GetResourceString("C_PerDay") %>--%></span></div>
                                    </div>

                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-sm-4">&nbsp;</label>
                                <div class="col-sm-8">
                                    &nbsp;
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-sm-4">&nbsp;</label>
                                <div class="col-sm-8">
                                    <a href="javascript:;" class="btn borderbtn mr-5" onclick="ClearAddNewTaskControls()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("T_Close") %></a>
                                    <button id="btnSaveTemplateNewSite" class="btn btnyellow"><%= MyBase.GetResourceString("T_Save") %></button>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

        <!--Add new site modal end here-->


        <!--Add New Role Modal start here-->
        <div class="modal custmodal fade" id="addRole" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id=""><%= MyBase.GetResourceString("T_Add_New_Role") %></h5>
                        <button type="button" class="close" onclick="ClearAddNewRoleControls()" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row form-group mb-3">
                            <div class="col-sm-6">
                                <label class="required"><%= MyBase.GetResourceString("T_Role_Name") %></label>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboTemplatesiteRole", "Usp_Whizible2_Sel_tbl_PM_Roles_ProjectSite", ,, " class='form-control'",,, ) %>
                               
                            </div>
                            <div class="col-sm-6">
                                <label class="required"><%= MyBase.GetResourceString("T_Normal_Rate") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRoleNormalRate", "txtRoleNormalRate", "form-control",, 9,,,, ,,,, "autocomplete='off' onkeypress='return restrictAlphabets(event, &quot;normalrate&quot;)'",, ,,,,, True) %>
                               
                            </div>
                        </div>
                        <div class="row form-group mb-3">
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("T_Extra_Rate") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRoleExtraRate", "txtRoleExtraRate", "form-control",, 9,,,, ,,,, "autocomplete='off' onkeypress='return restrictAlphabets(event, &quot;extrarate&quot;)'",, ,,,,, True) %>
                               
                            </div>
                            <div class="col-sm-6">
                                <label><%= MyBase.GetResourceString("T_Holiday_Rate") %></label>
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRoleHolidayRate", "txtRoleHolidayRate", "form-control",, 9,,,, ,,,, "autocomplete='off' onkeypress='return restrictAlphabets(event, &quot;holidayrate&quot;)'",, ,,,,, True) %>
                               
                            </div>
                        </div>
                        <div class="center-align">
                            <a href="javascript:;" class="btn borderbtn mr-5" onclick="ClearAddNewRoleControls()" data-bs-dismiss="modal"><%= MyBase.GetResourceString("T_Close") %></a>
                            <a href="javascript:;" id="btnSaveNewRole" class="btn btnyellow"><%= MyBase.GetResourceString("T_Save") %></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Add New Role Modal end here-->

        <div id="DivNotView" class="tab-pane" style="height: 587px; display: none">
            <div style="text-align: center; padding: 275px" class="box box-solid">
                <p><%= MyBase.GetResourceString("T_You_are_not_authorized_to_view_this_record") %></p>
            </div>
        </div>

        <!--Page modal end here-->
    </div>

    <!-- REQUIRED JS SCRIPTS -->
  
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>

    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>   
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>    
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <!-- Alertify js -->    
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <!-- Loader js -->
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>

    <script src="../../General/CommonFunctions.js"></script>
    <script src="../../General/CommonValidations.js?v=1"></script>--%>

    <script type="text/javascript">
        var strUrl = '<%= System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString %>';
        //Added By Riddhesh Patil on 18-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of Added By Riddhesh Patil
        var UserName = '<%= Session("strUserName") %>';
        var UserID = '<%= Session("intUserID") %>';
        var m_CustomerTemplateAddAccess = '<%= m_CustomerTemplateAddAccess %>';
        var m_CustomerTemplateDeleteAccess = '<%= m_CustomerTemplateDeleteAccess %>';
        var m_CustomerTemplateEditAccess = '<%= m_CustomerTemplateEditAccess %>';
        var m_CustomerTemplateViewAccess = '<%= m_CustomerTemplateViewAccess %>';

        var GblTemplateID = 0;
        var GblSiteID = 0;
        var Browser = isIE();
        $(document).ready(function () {

            StartLoader("#bodyCutomerTemplate");
            alertify.set('notifier', 'position', 'top-right');
            $('[data-bs-toggle="tooltip"]').tooltip();
            if (m_CustomerTemplateViewAccess == "False") {
                $("#DivNotView").show();
                $("#linkAddTemplate").hide();
                //$("#template_tab").hide();                
            }
            else if (m_CustomerTemplateAddAccess == "False") {
                $("#linkAddTemplate").hide();
                $(".linkAddNewSite").hide();
                $(".clslinkAddNewRole").hide();
                GetTemplateDetails();
            }
            else {
                GetTemplateDetails();
            }

            $(".closeAcco").click(function () {
                $(this).closest(".accordian-body").removeClass("in");
                $(".arrow-rotate").addClass("collapsed");
            });

            $("#custoAllSlt").click(function () {
                $(".custo-chck").prop('checked', $(this).prop('checked'));
            });

            $(".custo-chck").change(function () {
                if (!$(this).prop("checked")) {
                    $("#custoAllSlt").prop("checked", false);
                }
            });


            StopAjaxLoader("#bodyCutomerTemplate");
           
        });


        $("#cboSiteMaster").change(function () {
            if (this.value == "") {
                ClearAddNewTaskControls();
            }
            else {
                 //Addded by Chetan M on 19th Dec 2019
                GblCorpSiteID = this.value;                
                //End of addition by Chetan M on 19th Dec 2019
                var param = JSON.stringify(this.value);
                var strResult = AJAXCallWithResult("/api/PM_Template/GetCorporateLevelSiteData", param, false);
                if (strResult.length != 0) {
                    $("#txtTemplateSiteName").val(strResult[0].ProjectCostType);
                    $("#txtTemplateCity").val(strResult[0].City);
                    $("#cboTemplateSiteCurrency").val(strResult[0].CurrencyID);
                    $("#cboRateMethod").val(strResult[0].RateMethod);
                    $("#cboStartingDayOfWeek").val(strResult[0].StartingDayOfWeek);
                    $("#txtWeekDays").val(strResult[0].WeekDays);
                    $("#txtWorkHoursPerDay").val(strResult[0].WorkHrs);
                    $("#txtWorkHoursPerMonth").val(strResult[0].HoursPerMonth);
                    $("#txtWorkHoursCap").val(strResult[0].ExtraHoursCap);
                }
            }
        })


        //Added By Riddhesh Patil on 18-NOV-2022 
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
		//End of Added By Riddhesh Patil

        function checkDuplicateTemplate(TemplateName) {
            var param = JSON.stringify(TemplateName);
            var strResult = AJAXCallWithResult("/api/PM_Template/checkDuplicateTemplate", param, false);
            return strResult;
        }

        function funsavenewtemplate() {
            //alert();
        }

        $("#btnSaveNewTemplate").on("click", function () {
          
            var TemplateName = $("#txtTemplateName").val();
            //Commented & Added By Dipali V On 5th April 2023 For Saving with blank Space
            //if (TemplateName == '' || TemplateName== null) {
            if (TemplateName.trim() == '' || TemplateName.trim() == null) {
           //End of Commented & Added By Dipali V On 5th April 2023 For Saving with blank Space
                alertify.error("<%= MyBase.GetResourceString("T_Template_name_should_not_be_left_blank") %>");
                $("#txtTemplateName").focus();
            }
            //Commnet and Added By Riddhesh Patil on 15-NOV-2022 
            else if (checkSpecialCharacter(TemplateName, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Template Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtTemplateName").focus();
              
            }
			//End of Comment Added By Riddhesh Patil
            else if (checkDuplicateTemplate(TemplateName) == 1) {
                alertify.error("<%= MyBase.GetResourceString("T_Template_name_already_exists") %>");
                $("#txtTemplateName").focus();
            }
            else {
                var TemplateParameter = {
                    TemplateName: encodeURI(TemplateName),
                    UserName: encodeURI(UserName)
                }
                var param = JSON.stringify(TemplateParameter);
                var strResult = AJAXCallWithResult("/api/PM_Template/AddNewTemplate", param, false);

                if (strResult != null) {
                    alertify.success("<%= MyBase.GetResourceString("T_Added_Template_Successfully") %>");
                    $('#addTemplate').modal('toggle');
                    GetTemplateDetails();
                    //Commented and added By Riddhesh Patil on 11 May 2023
                   /* $('#liTemplateHref' + strResult).trigger('click');*/
                    $('#liTemplate' + strResult).trigger('click');
                    //End of Commented and added By Riddhesh Patil on 11 May 2023
                    $("#txtTemplateName").val('');
                }
            }
        })


        function GetTemplateDetails() {
            StartLoader("#bodyCutomerTemplate");
            var param = JSON.stringify();
            var strResult = AJAXCallWithResult("/api/PM_Template/GetTemplateDetails", param, false);
            var strHTML = '';
            $("#ulTemplate").empty();
            if (strResult.length == 0) {
                strHTML += '<li class="head-acco">'
                strHTML += '<td colspan="5"><%= MyBase.GetResourceString("T_There_are_no_items_to_show_in_this_view") %></td>'
                strHTML += '</li>'
                $("#ulTemplate").append(strHTML);
            }
            else {
                for (var i = 0; i < strResult.length; i++) {
                    strHTML = '';
                    strHTML += '<li class="head-acco liclsEditTemplate" id="liTemplate' + strResult[i].TemplateID + '">'
                   
                    strHTML += '<a data-bs-toggle="collapse" class="arrow-rotate collapsed clsEditTemplate" id="liTemplateHref' + strResult[i].TemplateID + '" onclick="GetTemplateSiteData(' + strResult[i].TemplateID + ')" data-bs-target="#template' + strResult[i].TemplateID + '" aria-expanded="false"><%= MyBase.GetResourceString("T_Template_Name") %> : ' + strResult[i].TemplateName + '<span class="fl-right down-arrow"><i class="fas fa-chevron-up"></i></span></a>'
                   
                    strHTML += '</li>'
                    strHTML += '<li class="hiddenRow subCustomField text-start">'
                    strHTML += '</li>'

                    strHTML += '<div class="accordian-body collapse" id="template' + strResult[i].TemplateID + '" aria-expanded="true" style="">'
                    strHTML += '<div class="right-side-save pt-10">'
                    strHTML += '<a href="javascript:;" onclick="CloseOpenTemplateRow(' + strResult[i].TemplateID +')" class="btn borderbtn mr-5 closeAcco"><%= MyBase.GetResourceString("T_Close") %></a>'
                    strHTML += '</div>'
                    strHTML += '<div class="col-md-12 col-sm-12 col-xs-9 float-start mb-10">'
                    strHTML += '<ul class="nav nav-tabs detailsubtabs">'
                    strHTML += '<li class="nav-item Compltedstep"><a href="#detailTab' + strResult[i].TemplateID + '" class="active" data-bs-toggle="tab" aria-expanded="true">Details</a></li>'
                    strHTML += '<li class="nav-item Compltedstep"><a href="#siteTab' + strResult[i].TemplateID + '" data-bs-toggle="tab" aria-expanded="true">Site</a></li>'
                    strHTML += '<li class="nav-item"><a href="#customerTab' + strResult[i].TemplateID + '" onclick="GetCustomerData(' + strResult[i].TemplateID + ')" data-bs-toggle="tab" aria-expanded="false"><%= MyBase.GetResourceString("T_Template_Customer_Mapping") %></a></li>'
                    strHTML += '</ul>'
                    strHTML += '<div class="clearfix"></div>'
                    strHTML += '</div>'
                    strHTML += '<div class="clearfix"></div>'
                    strHTML += '<div class="tab-content">'

                    // strHTML += '<div class="tab-pane active" id="detailTab' + strResult[i].TemplateID + '">'
                    strHTML += '<div class="tab-pane active show" id="detailTab' + strResult[i].TemplateID + '">'
                    strHTML += '<div class="right-side-save pt-10 mr-30">'
                    if (m_CustomerTemplateEditAccess == "True" && m_CustomerTemplateEditAccess != "False") {
                        strHTML += '<a href="javascript:;"   data-bs-toggle="tooltip"   data-placement="top" title="Update Template" onclick="UpdateTemplate(' + strResult[i].TemplateID + ',this.name)" name="' + strResult[i].TemplateName + '" class="btn btnyellow"><%= MyBase.GetResourceString("T_Save") %></a>'
                    }
                    strHTML += '</div>'
                    strHTML += '<div class="row pad pl-30 mb-10">'
                    strHTML += '<div class="col-sm-3">'
                    strHTML += '<label class="control-label required"><%= MyBase.GetResourceString("T_Template_Name") %></label>'
                    strHTML += '<input class="form-control" type="text" placeholder="" value="' + strResult[i].TemplateName + '" name="" id="TemplateDetailsName' + strResult[i].TemplateID + '">'
                    strHTML += '</div>'
                    strHTML += '<div class="col-sm-3">'
                    strHTML += '<label class="control-label"><%= MyBase.GetResourceString("T_Active") %></label>'

                    if (strResult[i].IsActive == true) {
                        strHTML += '<div class="inp-select"><div class="custom_chckbox"><input type="checkbox" id="ActiveTemplate' + strResult[i].TemplateID + '" class="chckHead" checked><label for="ActiveTemplate' + strResult[i].TemplateID + '"></label></div></div>'
                    }
                    else {
                        strHTML += '<div class="inp-select"><div class="custom_chckbox"><input type="checkbox" id="ActiveTemplate' + strResult[i].TemplateID + '" class="chckHead"><label for="ActiveTemplate' + strResult[i].TemplateID + '"></label></div></div>'
                    }

                    strHTML += '</div>'
                    strHTML += '</div>'
                    strHTML += '</div>'
                    strHTML += '<div class="tab-pane" id="siteTab' + strResult[i].TemplateID + '">'
                    if (m_CustomerTemplateEditAccess == "True") {
                        strHTML += '<div class="right-side-save pt-10 mr-30">'
                        strHTML += '<a href="javascript:;" data-bs-toggle="modal" onclick="AddNewSiteOnClick(' + strResult[i].TemplateID + ')" data-bs-target="#addSite" class="btn borderbtn mr-5 linkAddNewSite"><i class="fa fa-plus" aria-hidden="true"></i> <%= MyBase.GetResourceString("T_Add_Site") %></a>'
                        strHTML += '</div>'
                    }
                    else {

                    }
                   
                    strHTML += '<ul class="site-acco" id="TemplateSite' + strResult[i].TemplateID + '">'
                    strHTML += '</ul>'
                    strHTML += '</div>'
                    strHTML += '<div class="tab-pane" id="customerTab' + strResult[i].TemplateID + '">'
                    strHTML += '<div class="right-side-save pt-10 mr-30">'
                    if (m_CustomerTemplateEditAccess != "False") {
                        strHTML += '<a href="javascript:;"  data-bs-toggle="tooltip"   data-placement="top" title="Map Customer(s)" onclick="SaveMappedCustomer(' + strResult[i].TemplateID + ')" class="btn btnyellow"><%= MyBase.GetResourceString("T_Save") %></a>'
                    }
                    strHTML += '</div>'
                    strHTML += '<table class="table table-stripped table-bordered custo-tbl">'
                    strHTML += '<thead>'
                    strHTML += '<tr>'
                    strHTML += '<th><%= MyBase.GetResourceString("T_Customer_List") %></th>'
                    strHTML += '<th class="inp-select">'
                    strHTML += '<div class="custom_chckbox">'
                    //Commented and Added By Chetan M On 30 Nov 2020 for select all functionality
                   
                    strHTML += '<input type="checkbox" id="custoAllSlt' + strResult[i].TemplateID + '" class="chckHead classcustoAllSlt ">'
                    strHTML += '<label for="custoAllSlt' + strResult[i].TemplateID + '"></label>'
                    //End of Commentd and Added By Chetan M On 30 Nov 2020 for select all functionality
                    strHTML += '</div>'
                    strHTML += '</th>'
                    strHTML += '</tr>'
                    strHTML += '</thead>'
                    strHTML += '<tbody id="tbodyCustomer' + strResult[i].TemplateID + '">'

                    strHTML += '</tbody>'
                    strHTML += '</table>'
                    strHTML += '</div>'
                    strHTML += '</div>'
                    strHTML += '</div>'
                    $("#ulTemplate").append(strHTML);
                }
            }
            StopAjaxLoader("#bodyCutomerTemplate");
        }

        function UpdateTemplate(TemplateID, TName) {
            StartLoader("#bodyCutomerTemplate");
            var IsActive;

            if ($("#ActiveTemplate" + TemplateID).is(":checked")) {
                IsActive = 1;
            }
            else {
                IsActive = 0;
            }
            var TemplateName = $("#TemplateDetailsName" + TemplateID).val();
            if (TemplateName == "") {
                alertify.error("<%= MyBase.GetResourceString("T_Template_name_should_not_be_left_blank") %>");
                $("#TemplateDetailsName" + TemplateID).focus();
            }
            //Commnet and Added By Riddhesh Patil on 15-NOV-2022 
            else if (checkSpecialCharacter(TemplateName, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Template Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#TemplateDetailsName" + TemplateID).focus();

            }
			//End of Comment Added By Riddhesh Patil
            else if (TemplateName != TName && checkDuplicateTemplate(TemplateName) == 1) {
                alertify.error("<%= MyBase.GetResourceString("T_Template_name_already_exists") %>");
                $("#TemplateDetailsName" + TemplateID).focus();
            }
            else {
                var TemplateParameter = {
                    TemplateID: encodeURI(TemplateID),
                    TemplateName: encodeURI(TemplateName),
                    IsActive: encodeURI(IsActive)
                }
                var param = JSON.stringify(TemplateParameter);
                var strResult = AJAXCallWithResult("/api/PM_Template/UpdateSiteTemplate", param, false);
                if (strResult == null) {
                    alertify.success("<%= MyBase.GetResourceString("T_Updated_Template_Successfully") %>");
                    GetTemplateDetails();
                    //Commented and added By Riddhesh Patil on 11 May 2023
                    //$('#liTemplateHref' + TemplateID).trigger('click');
                    $('#liTemplate' + TemplateID).trigger('click');
                    //End of Commented and added By Riddhesh Patil on 11 May 2023
                }
            }
            StopAjaxLoader("#bodyCutomerTemplate");
        }

        function CloseOpenTemplateRow(TemplateID) {
            StartLoader("#bodyCutomerTemplate");
            $("#template" + TemplateID).removeClass('show');//Added by pradip on 7-4-2023
            $("#linkAddTemplate").attr('disabled', false);
            $("#linkAddTemplate").css({ 'pointer-events': 'auto', 'cursor': 'pointer' });
            if (Browser == "IE") {
                $(".liclsEditTemplate").attr("disabled", false);
                $(".liclsEditTemplate").css({ 'pointer-events': 'initial', 'cursor': 'pointer' });
            }
            else {
                $(".clsEditTemplate").attr("disabled", false);
                $(".clsEditTemplate").css({ 'pointer-events': 'initial', 'cursor': 'pointer' });
            }
            GetTemplateDetails();
            StopAjaxLoader("#bodyCutomerTemplate");
        }


        function GetTemplateSiteData(TemplateID) {

            StartLoader("#bodyCutomerTemplate");
            GblTemplateID = TemplateID;
           
            $(".linkAddNewSite").attr('disabled', false);

            var liTemplateID = "#liTemplate" + TemplateID;
            var ClassNames = $(liTemplateID + "> a").attr('class');
            if (ClassNames.indexOf('collapsed') > -1) {
                $("#linkAddTemplate").attr('disabled', true);
                $("#linkAddTemplate").css({ 'pointer-events': 'none' });
                
            }
            else {
                $("#linkAddTemplate").attr('disabled', false);
                $("#linkAddTemplate").css({ 'pointer-events': 'auto', 'cursor': 'pointer' });
               
            }
            GetCustomerData(TemplateID);

            if (Browser == "IE") {
                $(".liclsEditTemplate").attr("disabled", true);
                $(".liclsEditTemplate").css({ 'pointer-events': 'none' });
            }
            else {
                $(".clsEditTemplate").attr("disabled", true);
                $(".clsEditTemplate").css({ 'pointer-events': 'none' });
            }
           
            var TemplateParameter = {
                TemplateID: encodeURI(TemplateID)
            }
            var param = JSON.stringify(TemplateParameter);
            var strResult = AJAXCallWithResult("/api/PM_Template/GetTemplateSiteDetails", param, false);
            $("#TemplateSite" + TemplateID).empty();
            for (var i = 0; i < strResult.length; i++) {
                strHTML = '';              
                strHTML += '<li class="site-head-acco liclsEditTemplateSite" id="liTemplateSiteID' + strResult[i].SiteID + '"><a class="arrow-rotate collapsed clsEditTemplateSite" data-bs-toggle="collapse" id="liTemplateSiteIDHref' + strResult[i].SiteID + '" onclick="GetProjectSiteData(' + strResult[i].SiteID + ',' + TemplateID + ')" data-bs-target="#site' + strResult[i].SiteID + '">' + strResult[i].Name + '<span class="fl-right down-arrow"><i class="fas fa-chevron-up"></i></span></a>'
          

                strHTML += '</li>'
                strHTML += '<li class="hiddenRow subCustomField text-start">'
                strHTML += '<div class="accordian-body collapse" id="site' + strResult[i].SiteID + '" aria-expanded="true" style="">'
                strHTML += '<div class="CP_sitedetailpanelbody">'
                strHTML += '<div class="pt-1 pb-1">'
                strHTML += '<div class="right-side-save">'
                strHTML += '<a href="javascript:;" onclick="CloseOpenSiteDiv(' + strResult[i].SiteID + ')" class="btn borderbtn mr-5 closeAcco"><%= MyBase.GetResourceString("T_Close") %></a>'
                if (m_CustomerTemplateAddAccess == "True") {
                    strHTML += '<a href="javascript:;" id="LinkAddNewRole' + strResult[i].SiteID +'" class="btn borderbtn mr-5 add-able clslinkAddNewRole" data-bs-toggle="modal" data-bs-target="#addRole"><i class="fa fa-plus" aria-hidden="true"></i> <%= MyBase.GetResourceString("T_Add_New_Role") %></a>'
                }
                else {
                    strHTML += ''
                }

                if (m_CustomerTemplateEditAccess != "False") {
                    strHTML += '<a href="javascript:;"id="btnSaveNewSite' + strResult[i].SiteID + '" onclick="SaveSiteDetails(' + strResult[i].SiteID +')" class="btn btnyellow"><%= MyBase.GetResourceString("T_Save") %></a>'
                }
                strHTML += '</div>'
                strHTML += '<div class="col-md-12 col-sm-12 col-xs-9 float-start mb-20">'
                strHTML += '<ul class="nav nav-tabs detailsubtabs">'
                strHTML += '<li class="nav-item Compltedstep"><a id="detailClick' + strResult[i].SiteID + '" class="active" onclick="DetailsClick(' + strResult[i].SiteID + ')" href="#CPdetailtab' + strResult[i].SiteID +'" data-bs-toggle="tab" aria-expanded="true"><%= MyBase.GetResourceString("T_Details") %></a></li>'
                strHTML += '<li class="nav-item"><a id="RoleClick' + strResult[i].SiteID + '" onclick="GetSiteRoleData(' + strResult[i].SiteID + ')" href="#CProletab' + strResult[i].SiteID +'" data-bs-toggle="tab" aria-expanded="false"><%= MyBase.GetResourceString("T_Role") %></a></li>'
                strHTML += '</ul>'
                strHTML += '<div class="clearfix"></div>'
                strHTML += '</div>'
                strHTML += '<div class="tab-content">'
                strHTML += '<div id="CProletab' + strResult[i].SiteID + '" class="tab-pane">'
                strHTML += '<div class="table-responsive table-outer">'
                strHTML += '<table class="table table-stripped ratecardtble bgwhite">'
                strHTML += '<thead>'
                strHTML += '<tr>'
                strHTML += '<th width="35%" class="text-start"><%= MyBase.GetResourceString("T_Role") %></th>'
                strHTML += '<th><%= MyBase.GetResourceString("T_Normal_Rate") %></th>'
                strHTML += '<th><%= MyBase.GetResourceString("T_Extra_Rate") %></th>'
                strHTML += '<th><%= MyBase.GetResourceString("T_Holiday_Rate") %></th>'
                strHTML += '<th width="22%" class="addnewpanel_Actionlink">&nbsp;</th>'
                strHTML += '</tr>'
                strHTML += '</thead>'
                strHTML += '<tbody id="tbodySiteRole' + strResult[i].SiteID + '">'

                strHTML += '</tbody>'
                strHTML += '</table>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '<div id="CPdetailtab' + strResult[i].SiteID + '" class="tab-pane active">'

                strHTML += '<div class="siteandschedule_detail_panel">'
                strHTML += '<div class="panel-group " id="accordion' + strResult[i].SiteID + '" role="tablist" aria-multiselectable="true">'
                strHTML += '<div class="panel panel-default">'
                strHTML += '<div class="panel-heading" role="tab" id="headingOne' + strResult[i].SiteID + '">'
                strHTML += '<h4 class="panel-title">'
                strHTML += '<a data-bs-toggle="collapse" data-parent="#accordion" href="#SScollapse' + strResult[i].SiteID + '" aria-expanded="false" aria-controls="SScollapse' + strResult[i].SiteID +'" class="collapsed"><%= MyBase.GetResourceString("T_Site_detail") %></a>'
                strHTML += '</h4>'
                strHTML += '</div>'
                strHTML += '<div id="SScollapse' + strResult[i].SiteID + '" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne' + strResult[i].SiteID + '" aria-expanded="false" style="height: 0px;">'
                strHTML += '<div class="panel-body p-0">'
                strHTML += '<div class="formbody TemplateSiteDetailClass">'
                strHTML += '<div class="row">'
                strHTML += '<div class="form-group">'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label required"><%= MyBase.GetResourceString("T_Name") %></label>'
                strHTML += '<input class="form-control" type="text" placeholder="" value="' + strResult[i].Name + '" name="" id="sitedetailname' + strResult[i].SiteID + '">'
                strHTML += '</div>'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label"><%= MyBase.GetResourceString("T_Short_Name") %></label>'
                if (strResult[i].ShortName == null) {
                    strHTML += '<input class="form-control" type="text" placeholder="" value="" name="" id="siteshortname' + strResult[i].SiteID + '">'
                }
                else {
                    strHTML += '<input class="form-control" type="text" placeholder="" value="' + strResult[i].ShortName + '" name="" id="siteshortname' + strResult[i].SiteID + '">'
                }
                strHTML += '</div>'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label"><%= MyBase.GetResourceString("T_Address_Name") %></label>'
                if (strResult[i].Address == null) {
                    strHTML += '<input class="form-control" type="text" placeholder="" name="" id="siteaddress' + strResult[i].SiteID + '">'
                }
                else {
                    strHTML += '<input class="form-control" type="text" value="' + strResult[i].Address + '" placeholder="" name="" id="siteaddress' + strResult[i].SiteID + '">'
                }
                strHTML += '</div>'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label"><%= MyBase.GetResourceString("T_Country") %></label>'

                var inputTemplateName = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboTemplateSiteCountry", "usp_sel_tbl_PM_Country",,,, True, True, "form-control",,,, TabIndex:=1).ToString.Replace("'", "\'")%>';
                inputTemplateName = inputTemplateName.replace(/cboTemplateSiteCountry/g, "cboTemplateSiteCountry" + strResult[i].SiteID);
                strHTML += inputTemplateName;

                strHTML += '</div>'
                strHTML += '<div class="clearfix"></div>'
                strHTML += '</div>'
                strHTML += '<div class="form-group">'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label"><%= MyBase.GetResourceString("T_State") %></label>'
                if (strResult[i].State == null) {
                    strHTML += '<input class="form-control" type="text" name="" id="siteState' + strResult[i].SiteID + '">'
                }
                else {
                    strHTML += '<input class="form-control" type="text" value="' + strResult[i].State + '" name="" id="siteState' + strResult[i].SiteID + '">'
                }

                strHTML += '</div>'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label"><%= MyBase.GetResourceString("T_City") %></label>'
                if (strResult[i].City == null) {
                    strHTML += '<input class="form-control" type="text" name="" id="siteCity' + strResult[i].SiteID + '">'
                }
                else {
                    strHTML += '<input class="form-control" type="text" value="' + strResult[i].City + '" name="" id="siteCity' + strResult[i].SiteID + '">'
                }
                strHTML += '</div>'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label"><%= MyBase.GetResourceString("T_Zipcode") %></label>'
                if (strResult[i].Zip == null) {
                    strHTML += '<input class="form-control" type="text" placeholder="" name="" id="sitezipcode' + strResult[i].SiteID + '">'
                }
                else {
                    strHTML += '<input class="form-control" type="text" value="' + strResult[i].Zip + '" placeholder="" name="" id="sitezipcode' + strResult[i].SiteID + '">'
                }
                strHTML += '</div>'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label"><%= MyBase.GetResourceString("T_Phone") %></label>'
                if (strResult[i].Phone == null) {
                    strHTML += '<input class="form-control" type="text" placeholder="" name="" id="sitephoneno' + strResult[i].SiteID + '">'
                }
                else {
                    strHTML += '<input class="form-control" type="text" value="' + strResult[i].Phone + '" placeholder="" name="" id="sitephoneno' + strResult[i].SiteID + '">'
                }

                strHTML += '</div>'
                strHTML += '<div class="clearfix"></div>'
                strHTML += '</div>'
                strHTML += '<div class="form-group">'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label"><%= MyBase.GetResourceString("T_Fax") %></label>'
                if (strResult[i].Fax == null) {
                    strHTML += '<input class="form-control" type="text" placeholder="" name="" id="sitefax' + strResult[i].SiteID + '">'
                }
                else {
                    strHTML += '<input class="form-control" type="text" value="' + strResult[i].Fax + '" placeholder="" name="" id="sitefax' + strResult[i].SiteID + '">'
                }

                strHTML += '</div>'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label"><%= MyBase.GetResourceString("T_Email") %></label>'
                if (strResult[i].EmailID == null) {
                    strHTML += '<input class="form-control" type="text" placeholder="" name="company@gmail.com" id="siteemail' + strResult[i].SiteID + '">'
                }
                else {
                    strHTML += '<input class="form-control" type="text" placeholder="" value="' + strResult[i].EmailID + '" name="company@gmail.com" id="siteemail' + strResult[i].SiteID + '">'
                }

                strHTML += '</div>'
                strHTML += '<div class="clearfix"></div>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '<div class="panel panel-default">'
                strHTML += '<div class="panel-heading" role="tab" id="headingTwo' + strResult[i].SiteID + '">'
                strHTML += '<h4 class="panel-title">'
                strHTML += '<a class="collapsed" data-bs-toggle="collapse" data-parent="#accordion' + strResult[i].SiteID + '" href="#SScollapseScheduleDetails' + strResult[i].SiteID + '" aria-expanded="false" aria-controls="SScollapseScheduleDetails' + strResult[i].SiteID +'"><%= MyBase.GetResourceString("T_Schedule_detail") %></a>'
                strHTML += '</h4>'
                strHTML += '</div>'
                strHTML += '<div id="SScollapseScheduleDetails' + strResult[i].SiteID + '" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo' + strResult[i].SiteID + '" aria-expanded="false" style="height: 0px;">'
                strHTML += '<div class="panel-body p-0">'
                strHTML += '<div class="formbody TemplateSiteDetailClass">'
                strHTML += '<div class="row newproformrow">'
                strHTML += '<div class="form-group">'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label required"><%= MyBase.GetResourceString("T_Currency") %></label>'

                var inputTemplateName = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboTemplateSiteCurrency", "usp_sel_tbl_PM_CurrencyMaster",,,, True, True, "form-control",,,, TabIndex:=1).ToString.Replace("'", "\'")%>';
                inputTemplateName = inputTemplateName.replace(/cboTemplateSiteCurrency/g, "cboTemplateSiteCurrency" + strResult[i].SiteID);
                strHTML += inputTemplateName;

                strHTML += '</div>'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label required"><%= MyBase.GetResourceString("T_Rate_method") %></label>'

                var inputTemplateName = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboTemplateSiteRatemethod", "usp_Sel_RateMethods",,,, True, True, "form-control",,,, TabIndex:=1).ToString.Replace("'", "\'")%>';
                inputTemplateName = inputTemplateName.replace(/cboTemplateSiteRatemethod/g, "cboTemplateSiteRatemethod" + strResult[i].SiteID);
                strHTML += inputTemplateName;

                strHTML += '</div>'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label required"><%= MyBase.GetResourceString("T_Starting_day_of_week") %></label>'

                var inputTemplateName = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboTemplateSiteStartingdayofweek", "usp_WeekDays_DayNumbers",,,, True, True, "form-control",,,, TabIndex:=1).ToString.Replace("'", "\'")%>';
                inputTemplateName = inputTemplateName.replace(/cboTemplateSiteStartingdayofweek/g, "cboTemplateSiteStartingdayofweek" + strResult[i].SiteID);
                strHTML += inputTemplateName;

                strHTML += '</div>'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label required"><%= MyBase.GetResourceString("T_Working_days_per_week") %></label>'

                if (strResult[i].WeekDays == null) {
                    strHTML += '<input class="form-control" type="text" placeholder="" name="" onkeypress="return restrictAlphabets(event, &quot;workhrs&quot;)" id="siteWorkingdaysperweek' + strResult[i].SiteID + '">'
                }
                else {
                    strHTML += '<input class="form-control" type="text" placeholder="" name="" onkeypress="return restrictAlphabets(event, &quot;workhrs&quot;)" value="' + strResult[i].WeekDays + '" id="siteWorkingdaysperweek' + strResult[i].SiteID + '">'
                }

                strHTML += '</div>'
                strHTML += '<div class="clearfix"></div>'
                strHTML += '</div>'
                strHTML += '<div class="form-group">'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label required"><%= MyBase.GetResourceString("T_Working_hours_per_Day") %></label>'
                if (strResult[i].WorkHrs == null) {
                    strHTML += '<input class="form-control" type="text" placeholder="" name="" onkeypress="return restrictAlphabets(event, &quot;workhrs&quot;)" id="siteWorkinghoursperday' + strResult[i].SiteID + '">'
                }
                else {
                    strHTML += '<input class="form-control" type="text" placeholder="" name="" onkeypress="return restrictAlphabets(event, &quot;workhrs&quot;)" value="' + strResult[i].WorkHrs + '" id="siteWorkinghoursperday' + strResult[i].SiteID + '">'
                }

                strHTML += '</div>'
                strHTML += '<div class="col-sm-3">'
                strHTML += '<label class="control-label required"><%= MyBase.GetResourceString("T_Extra_hour_cap_per_day") %></label>'
                if (strResult[i].ExtraHoursCap == null) {
                    strHTML += '<input class="form-control" type="text" placeholder="" onkeypress="return restrictAlphabets(event, &quot;workhrs&quot;)" name="" id="siteExtrahourcapperweek' + strResult[i].SiteID + '">'
                }
                else {
                    strHTML += '<input class="form-control" type="text" placeholder="" onkeypress="return restrictAlphabets(event, &quot;workhrs&quot;)" name="" value="' + strResult[i].ExtraHoursCap + '" id="siteExtrahourcapperweek' + strResult[i].SiteID + '">'
                }

                strHTML += '</div>'
                strHTML += '<div class="col-sm-3">'
                //Added by Rutuja D. for new Style for allignment disturb  
                strHTML += '<label class="control-label required" Style="white-space:nowrap"><%= MyBase.GetResourceString("T_Working_hour_per_month") %></label>'
                //End of Added by Rutuja D. for new Style for allignment disturb
                if (strResult[i].HoursPerMonth == null) {
                    strHTML += '<input class="form-control" type="text" placeholder="" onkeypress="return restrictAlphabets(event, &quot;workhrs&quot;)" name="" id="siteWorkinghourpermonth' + strResult[i].SiteID + '">'
                }
                else {
                    strHTML += '<input class="form-control" type="text" placeholder="" onkeypress="return restrictAlphabets(event, &quot;workhrs&quot;)" name="" value="' + strResult[i].HoursPerMonth + '" id="siteWorkinghourpermonth' + strResult[i].SiteID + '">'
                }

                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '</div>'

                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '<div class="clearfix"></div>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '</div>'
                strHTML += '</li>'

                $("#TemplateSite" + TemplateID).append(strHTML);

                if (strResult[i].CountryID != 0 && strResult[i].CountryID != null) {
                    $("#cboTemplateSiteCountry" + strResult[i].SiteID).val(strResult[i].CountryID);
                }

                if (strResult[i].CurrencyID != 0 && strResult[i].CurrencyID != null) {
                    $("#cboTemplateSiteCurrency" + strResult[i].SiteID).val(strResult[i].CurrencyID);
                }
                if (strResult[i].RateMethod != 0 && strResult[i].RateMethod != null) {
                    $("#cboTemplateSiteRatemethod" + strResult[i].SiteID).val(strResult[i].RateMethod);
                }
                if (strResult[i].StartingDayOfWeek != 0 && strResult[i].StartingDayOfWeek != null) {
                    $("#cboTemplateSiteStartingdayofweek" + strResult[i].SiteID).val(strResult[i].StartingDayOfWeek);
                }
            }
            StopAjaxLoader("#bodyCutomerTemplate");
        }


        function SaveSiteDetails(SiteID) {
            var SiteName = $("#sitedetailname" + SiteID).val();
            var SiteShortName = $("#siteshortname" + SiteID).val();
            var SiteAddress = $("#siteaddress" + SiteID).val();
            var SiteCountryName = $("#cboTemplateSiteCountry" + SiteID).val();
            var SiteStateName = $("#siteState" + SiteID).val();
            var SiteCityName = $("#siteCity" + SiteID).val();
            var SiteZipcode = $("#sitezipcode" + SiteID).val();
            var SitePhoneNo = $("#sitephoneno" + SiteID).val();
            var SiteFaxNo = $("#sitefax" + SiteID).val();
            var SiteEmailID = $("#siteemail" + SiteID).val();
            var SiteCurrencyID = $("#cboTemplateSiteCurrency" + SiteID).val();
            var SiteRateMethod = $("#cboTemplateSiteRatemethod" + SiteID).val();
            var SiteStartingDayOfWeek = $("#cboTemplateSiteStartingdayofweek" + SiteID).val();
            var SiteWorkingDaysPerWeek = $("#siteWorkingdaysperweek" + SiteID).val();
            var SiteWorkingHoursPerDay = $("#siteWorkinghoursperday" + SiteID).val();
            var SiteExtraHoursCapPerDay = $("#siteExtrahourcapperweek" + SiteID).val();
            var SiteWorkingHoursPerMonth = $("#siteWorkinghourpermonth" + SiteID).val();

            var WorkHours1 = parseInt(SiteWorkingHoursPerDay);
            var WorkHoursCapPerDay1 = parseInt(SiteExtraHoursCapPerDay);
            var TotalWorkHours = WorkHours1 + WorkHoursCapPerDay1;

            if (SiteName == "") {
                alertify.error("<%= MyBase.GetResourceString("T_Site_Name_should_not_be_left_blank") %>");
                $("#sitedetailname" + SiteID).focus();
            }
            //else if (checkDuplicateSite(SiteName) == 1) {
            //    alertify.error("Site Name already Exists.");
            //    $("#sitedetailname" + SiteID).focus();
            //}            
            else if (SiteZipcode != "" && checkSpecialCharacter(SiteZipcode) == true) {
                alertify.notify("<%= MyBase.GetResourceString("T_Special_Characters") %>", 'error');
                $("#sitezipcode" + SiteID).focus();
            }
            else if (ValidateEmail(SiteEmailID) == false && SiteEmailID != "") {
                alertify.error("<%= MyBase.GetResourceString("T_Invalid_Email_Address") %>");
                $("#siteemail" + SiteID).focus();
            }
            else if (SiteCurrencyID == "" || SiteCurrencyID == "0") {
                alertify.error("<%= MyBase.GetResourceString("T_Currency_should_not_be_left_blank") %>");
                $("#cboTemplateSiteCurrency" + SiteID).focus();
            }
            else if (SiteRateMethod == "") {
                alertify.error("<%= MyBase.GetResourceString("T_Rate_Method_should_not_be_left_blank") %>");
                $("#cboTemplateSiteRatemethod" + SiteID).focus();
            }
            else if (SiteStartingDayOfWeek == "") {
                alertify.error("<%= MyBase.GetResourceString("T_Starting_Day_of_week_should_not_be_left_blank") %>");
                $("#cboTemplateSiteStartingdayofweek" + SiteID).focus();
            }
            else if (SiteWorkingDaysPerWeek == "" || SiteStartingDayOfWeek == '0') {
                alertify.error("<%= MyBase.GetResourceString("T_Working_Days_Per_week_should_not_be_left_blank") %>");
                $("#siteWorkingdaysperweek" + SiteID).focus();
            }
            else if (SiteWorkingDaysPerWeek > 7) {
                alertify.error("<%= MyBase.GetResourceString("T_The_value_of_Working_Days_per_week_should_be_in_range") %>");
                $("#siteWorkingdaysperweek" + SiteID).focus();
            }
            else if (SiteWorkingHoursPerDay == "") {
                alertify.error("<%= MyBase.GetResourceString("T_Working_Hours_Per_week_should_not_be_left_blank") %>");
                $("#siteWorkinghoursperday" + SiteID).focus();
            }
            else if (SiteWorkingHoursPerDay > 24) {
                alertify.error("<%= MyBase.GetResourceString("T_Working_hours_range") %>");
                $("#siteWorkinghoursperday" + SiteID).focus();
            }
            else if (SiteExtraHoursCapPerDay == "") {
                alertify.error("<%= MyBase.GetResourceString("T_Starting_hours_Cap_Per_week_should_not_be_left_blank") %>");
                $("#siteExtrahourcapperweek" + SiteID).focus();
            }
            else if (TotalWorkHours > 24) {
                alertify.error("<%= MyBase.GetResourceString("T_Total_Work_Hour_And_Extra_hour_cap_sum") %>");
                $("#siteExtrahourcapperweek" + SiteID).focus();
            }
            else if (SiteWorkingHoursPerMonth == "") {
                alertify.error("<%= MyBase.GetResourceString("T_Starting_hours_Per_Month_should_not_be_left_blank") %>");
                $("#siteWorkinghourpermonth" + SiteID).focus();
            }
            else if (SiteWorkingHoursPerMonth == "") {
                alertify.error("<%= MyBase.GetResourceString("T_Working_hours_per_month_range") %>");
                $("#siteWorkinghourpermonth" + SiteID).focus();
            }
            else {
                StartLoader("#bodyCutomerTemplate");
                var TemplateParameter = {
                    SiteName: encodeURI(SiteName),
                    TemplateID: encodeURI(GblTemplateID),
                    SiteShortName: encodeURI(SiteShortName),
                    City: encodeURI(SiteCityName),
                    WeekDays: encodeURI(SiteWorkingDaysPerWeek),
                    WorkHours: encodeURI(SiteWorkingHoursPerDay),
                    WorkHoursPerMonth: encodeURI(SiteWorkingHoursPerMonth),
                    WorkHoursCapPerDay: encodeURI(SiteExtraHoursCapPerDay),
                    UserName: encodeURI(UserName),
                    CurrencyID: encodeURI(SiteCurrencyID),
                    RateMethod: encodeURI(SiteRateMethod),
                    Address: encodeURI(SiteAddress),
                    CountryID: encodeURI(SiteCountryName),
                    State: encodeURI(SiteStateName),
                    Zip: encodeURI(SiteZipcode),
                    Fax: encodeURI(SiteFaxNo),
                    Phone: encodeURI(SitePhoneNo),
                    EmailID: encodeURI(SiteEmailID),
                    StartingDayOfWeek: encodeURI(SiteStartingDayOfWeek),
                    SiteID: encodeURI(SiteID)
                }

                var param = JSON.stringify(TemplateParameter);
                var strResult = AJAXCallWithResult("/api/PM_Template/SaveSiteDetails", param, false);
                if (strResult != null) {
                    alertify.success("<%= MyBase.GetResourceString("T_Updated_Site_Successfully") %>");
                    GetTemplateSiteData(GblTemplateID);
                    //Commented and added By Riddhesh Patil on 11 May 2023
                    //$("#liTemplateSiteIDHref" + SiteID).trigger('click');
                    $("#liTemplateSiteID" + SiteID).trigger('click');
                    //End of Commented and added By Riddhesh Patil on 11 May 2023

                    //$(".linkAddNewSite").attr('disabled', false);
                    //$(".linkAddNewSite").css({ 'pointer-events': 'auto', 'cursor': 'pointer' });
                }
                StopAjaxLoader("#bodyCutomerTemplate");
            }
        }


        function ValidateEmail(email) {
            var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
            if (!expr.test(email)) {
                return false;
            }
        }


        function checkDuplicateSite(SiteName) {
            var TemplateParameter = {
                TemplateID: encodeURI(GblTemplateID),
                SiteName: encodeURI(SiteName),
                TemplateID: encodeURI(GblTemplateID)
            }
            var param = JSON.stringify(TemplateParameter);
            var strResult = AJAXCallWithResult("/api/PM_Template/checkDuplicateSite", param, false);            
            return strResult;
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


        function GetCustomerData(TemplateID) {
            StartLoader("#bodyCutomerTemplate");
            var strHTML = '';
            var MappedCustomer = GetMappedCustomerToTemplate(TemplateID);

            var param = JSON.stringify();
            var strResult = AJAXCallWithResult("/api/PM_Template/GetCustomerData", param, false);
            $("#tbodyCustomer" + TemplateID).empty();
            for (var i = 1; i < strResult.length; i++) {
                strHTML = '';
                strHTML += '<tr>'
                strHTML += '<td>' + strResult[i].CustomerName + '</td>'
                strHTML += '<td class="inp-select">'
                strHTML += '<div class="custom_chckbox">'

                var CheckboxHTML = '';
                for (var j = 0; j < MappedCustomer.length; j++) {
                    if (MappedCustomer[j].CustomerID == strResult[i].Customer) {
                        CheckboxHTML = '<input type="checkbox" id="' + TemplateID + 'customer' + strResult[i].Customer + '" class="chckHead custo-chck" checked> <label for="' + TemplateID + 'customer' + strResult[i].Customer + '"></label>'
                        //CheckboxHTML = '<label for="customer' + strResult[i].Customer + '"></label>'
                        break;
                    }
                    else {
                        CheckboxHTML = '<input type="checkbox" id="' + TemplateID + 'customer' + strResult[i].Customer + '" class="chckHead custo-chck"> <label for="' + TemplateID + 'customer' + strResult[i].Customer + '"></label>'
                        //strHTML += '<label for="customer'+strResult[i].Customer+'"></label>'
                    }
                }
                if (MappedCustomer.length == 0) {
                    CheckboxHTML = '<input type="checkbox" id="' + TemplateID + 'customer' + strResult[i].Customer + '" class="chckHead custo-chck"> <label for="' + TemplateID + 'customer' + strResult[i].Customer + '"></label>'
                }
                strHTML += CheckboxHTML
                strHTML += '</div>'
                strHTML += '</td>'
                strHTML += '</tr>'
                $("#tbodyCustomer" + TemplateID).append(strHTML);
            }
             //Added By Chetan M On 30 Nov 2020 for select all functionality           
            if (MappedCustomer.length == strResult.length - 1) {
                $("#custoAllSlt"+GblTemplateID).prop('checked', true);               
            }
            else {
                $("#custoAllSlt"+GblTemplateID).prop("checked", false);
            }
             $(".classcustoAllSlt").click(function () {                 
                $(".custo-chck").prop('checked', $(this).prop('checked'));
            });
            $(".custo-chck").change(function () {                 
                var tbodyID = "#tbodyCustomer" + GblTemplateID;
                    var rowCount = $("#tbodyCustomer"+ GblTemplateID +" > tr").length;
                    var CheckedcheckedBoxes = $("input[type=checkbox]:checked", tbodyID);
                    if (rowCount == CheckedcheckedBoxes.length) {
                        $("#custoAllSlt"+GblTemplateID).prop('checked', true);
                    }
                    if (!$(this).prop("checked")) {
                        $("#custoAllSlt"+GblTemplateID).prop("checked", false);
                    }
                });
                //End Of Added By Chetan M On 30 Nov 2020  for select all functionality


            StopAjaxLoader("#bodyCutomerTemplate");
        }

        function GetMappedCustomerToTemplate(TemplateID) {
            var param = JSON.stringify(encodeURI(TemplateID));
            var strResult = AJAXCallWithResult("/api/PM_Template/GetMappedCustomerToTemplate", param, false);
            return strResult;
        }


        function SaveMappedCustomer(TemplateID) {
            var CustomerArray = new Array();
            var tbodyID = "#tbodyCustomer" + TemplateID;
            var CheckedcheckedBoxes = $("input[type=checkbox]:checked", tbodyID);
            if (CheckedcheckedBoxes.length == 0) {
                alertify.error("<%= MyBase.GetResourceString("T_Please_select_at_least_one_Customer") %>");
            }

            else {
                StartLoader("#bodyCutomerTemplate");
                for (var i = 0; i < CheckedcheckedBoxes.length; i++) {
                    var CheckBoxID = CheckedcheckedBoxes[i].id;
                    CheckBoxID = CheckBoxID.split("customer").pop();
                    //var CustomerID = CheckedcheckedBoxes[i].id.replace('customer', '');
                    //CustomerID = CustomerID.replace(TemplateID, '');
                    CustomerArray.push(CheckBoxID);
                }
                  //Added By Dipali V On 5th April 2023 For Saving Not Working
                CustomerArray = CustomerArray.toString();
                  //End of Added By Dipali V On 5th April 2023 For Saving Not Working
                console.log(CustomerArray);
                var TemplateParameter = {
                    TemplateID: encodeURI(TemplateID),
                    CustomerArr: CustomerArray,
                    UserName: encodeURI(UserName)
                }
                var param = JSON.stringify(TemplateParameter);
                var strResult = AJAXCallWithResult("/api/PM_Template/SaveMappedCustomer", param, false);
                if (strResult == null) {
                    alertify.success("<%= MyBase.GetResourceString("T_Mapped_Customer_to_the_Template") %>");
                    GetCustomerData(TemplateID);
                }
                StopAjaxLoader("#bodyCutomerTemplate");
            }
        }

        function CloseOpenSiteDiv(SiteID) {
            StartLoader("#bodyCutomerTemplate");
            $("#site" + SiteID).removeClass('show'); //Added by pradip on 7-4-2023
            $(".linkAddNewSite").attr('disabled', false);
            $(".linkAddNewSite").css({ 'pointer-events': 'auto', 'cursor': 'pointer' });

            var liTemplateSiteID = "#liTemplateSiteID" + SiteID;
            var ClassNames = $(liTemplateSiteID + "> a").addClass('collapsed');
            if (Browser == "IE") {
                $(".liclsEditTemplateSite").attr("disabled", false);
                $(".liclsEditTemplateSite").css({ 'pointer-events': 'initial', 'cursor': 'pointer' });
            }
            else {
                $(".clsEditTemplateSite").attr("disabled", false);
                $(".clsEditTemplateSite").css({ 'pointer-events': 'initial', 'cursor': 'pointer' });
            }

            StopAjaxLoader("#bodyCutomerTemplate");
        }

        $("#btnSaveNewRole").click(function () {

            var RoleName = $("#cboTemplatesiteRole").val();
            var RoleNormalRate = $("#txtRoleNormalRate").val();
            var RoleExtraRate = $("#txtRoleExtraRate").val();
            var RoleHolidayRate = $("#txtRoleHolidayRate").val();

            if (RoleName == "0") {
                alertify.error("<%= MyBase.GetResourceString("T_Role_Name_should_not_be_left_blank") %>");
                $("#cboTemplatesiteRole").focus();
            }
            else if (checkDuplicateRoleName(RoleName) == 1) {
                alertify.error("<%= MyBase.GetResourceString("T_Role_Name_already_exists") %>");
                $("#cboTemplatesiteRole").focus();
            }
            else if (RoleNormalRate == "") {
                alertify.error("<%= MyBase.GetResourceString("T_Normal_Rate_should_not_be_left_blank") %>");
                $("#txtRoleNormalRate").focus();
            }
            else {
                StartLoader("#bodyCutomerTemplate");
                //Commented and added by Chetan M. on 19th Dec 2019
                AddNewRoles(GblSiteID, RoleName, RoleNormalRate, RoleExtraRate, RoleHolidayRate, 1);

                //End of addition by Chetan M on 19th Dec 2019
                StopAjaxLoader("#bodyCutomerTemplate");
            }

        })
        //added by Chetan M. on 19th Dec 2019
        function AddNewRoles(GblSiteID,RoleName,RoleNormalRate,RoleExtraRate,RoleHolidayRate,alertFlag) {
            var TemplateParameter = {
                    TemplateID: parseInt(GblTemplateID),
                    SiteID: encodeURI(GblSiteID),
                    RoleID: encodeURI(RoleName),
                    NormalRate: encodeURI(RoleNormalRate),
                    ExtraRate: encodeURI(RoleExtraRate),
                    HolidayRate: encodeURI(RoleHolidayRate),
                    UserName: encodeURI(UserName)
                }
                var param = JSON.stringify(TemplateParameter);
                var strResult = AJAXCallWithResult("/api/PM_Template/SaveRoleData", param, false);
            if (strResult != null) {
                if (alertFlag == 1) {
                    alertify.success("<%= MyBase.GetResourceString("T_Added_role_successfully") %>");
                }                    
                    $('#addRole').modal('hide');
                    ClearAddNewRoleControls();
                    GetSiteRoleData(GblSiteID);
                }
        }
        //End of addition by Chetan M on 19th Dec 2019
        function checkDuplicateRoleName(RoleID) {
            var TemplateParameter = {
                RoleID: encodeURI(RoleID),
                SiteID: encodeURI(GblSiteID)
            }
            var param = JSON.stringify(TemplateParameter);
            var strResult = AJAXCallWithResult("/api/PM_Template/checkDuplicateRoleName", param, false);
            return strResult;
        }

        function GetSiteRoleData(SiteID) {
            StartLoader("#bodyCutomerTemplate");
            var strHTML = '';
            $("#LinkAddNewRole" + SiteID).show();
            $("#btnSaveNewSite" + SiteID).hide();
            $("#tbodySiteRole" + SiteID).empty();
            GetTemplateSiteRole(SiteID);
            var TemplateParameter = {
                TemplateID: encodeURI(GblTemplateID),
                SiteID: encodeURI(SiteID)
            }
            var param = JSON.stringify(TemplateParameter);
            var strResult = AJAXCallWithResult("/api/PM_Template/GetSiteRoleData", param, false);
            if (strResult.length == 0) {
                strHTML += '<tr>'
                strHTML += '<td colspan="5" style="text-align:center;"><%= MyBase.GetResourceString("T_There_are_no_items_to_show_in_this_view") %></td>'
                strHTML += '</tr>'
                $("#tbodySiteRole" + SiteID).append(strHTML);
            }
            else {
                for (var i = 0; i < strResult.length; i++) {
                    strHTML = '';
                    strHTML += '<tr class="ratecardedit_row">'
                    strHTML += '<td width="35%" class="text-start">' + strResult[i].RoleDescription + '</td>'
                    //Commented and added by Chetan M on 4th Jan 2020
                    //strHTML += '<td><input id="ANnormalrate' + strResult[i].SiteRoleID + '" type="text" onkeypress="return restrictAlphabets(event, &quot;normalrate&quot;)" class="textinput" value="' + (strResult[i].NormalRate).toFixed(2) + '" name=""></td>'
                    //strHTML += '<td><input id="ANextrarate' + strResult[i].SiteRoleID + '" type="text" onkeypress="return restrictAlphabets(event, &quot;extrarate&quot;)" class="textinput" value="' + (strResult[i].ExtraRate).toFixed(2) + '" name="" maxlength="11"></td>'
                    //strHTML += '<td><input id="ANholidayrate' + strResult[i].SiteRoleID + '" type="text" onkeypress="return restrictAlphabets(event, &quot;holidayrate&quot;)" class="textinput" value="' + (strResult[i].HolidayRate).toFixed(2) + '" name=""></td>'
                    strHTML += '<td><input id="ANnormalrate' + strResult[i].SiteRoleID + '" type="text" onkeypress="return restrictAlphabets(event, &quot;normalrate&quot;)" class="textinput" value="' + (strResult[i].NormalRate).toFixed(2) + '" name="" maxlength ="9"></td>'
                    strHTML += '<td><input id="ANextrarate' + strResult[i].SiteRoleID + '" type="text" onkeypress="return restrictAlphabets(event, &quot;extrarate&quot;)" class="textinput" value="' + (strResult[i].ExtraRate).toFixed(2) + '" name="" maxlength="9"></td>'
                    strHTML += '<td><input id="ANholidayrate' + strResult[i].SiteRoleID + '" type="text" onkeypress="return restrictAlphabets(event, &quot;holidayrate&quot;)" class="textinput" value="' + (strResult[i].HolidayRate).toFixed(2) + '" name="" maxlength="9"></td>'
                    //End of added by Chetan M on 4th Jan 2020
                    strHTML += '<td width="22%" class="addnewpanel_Actionlink">'
                    if (m_CustomerTemplateEditAccess == "True" && m_CustomerTemplateEditAccess != "False") {
                        strHTML += '<a class="ratecardedit" id="ratecardedit' + strResult[i].SiteRoleID +'" onclick="EditRoleData(this.id)" href="javascript:;"><%= MyBase.GetResourceString("T_Edit") %></a>'
                    }
                    strHTML += '<a class="cancleratecardedit" id="cancleratecardedit' + strResult[i].SiteRoleID +'" onclick="EditRoleData(this.id)" href="javascript:;"><%= MyBase.GetResourceString("T_Cancel") %></a>'
                    strHTML += '<a class="saveratecardedit" id="saveratecardedit' + strResult[i].SiteRoleID + '" onclick="SaveRoleData(' + strResult[i].SiteRoleID +')" href="javascript:;"><%= MyBase.GetResourceString("T_Save") %></a>'
                    strHTML += '</td>'
                    strHTML += '</tr>'
                    $("#tbodySiteRole" + SiteID).append(strHTML);
                }
            }
            StopAjaxLoader("#bodyCutomerTemplate");
        }

        function EditRoleData(ID) {
            if (ID.indexOf('cancleratecardedit') > -1) {
                GetSiteRoleData(GblSiteID);
                $(".clslinkAddNewRole").attr('disabled', false);
                $(".clslinkAddNewRole").css({ 'pointer-events': 'auto', 'cursor': 'pointer' });

            }
            else {
                StartLoader("#bodyCutomerTemplate");
                $("#" + ID).closest('.ratecardedit_row').toggleClass('ratecardedit_row_open');
                $(".clslinkAddNewRole").attr('disabled', true);
                $(".clslinkAddNewRole").css({ 'pointer-events': 'none' });
                StopAjaxLoader("#bodyCutomerTemplate");
            }
        }

        function SaveRoleData(SiteRoleID) {
            //alert(SiteRoleID);            
            var NormalRate = $("#ANnormalrate" + SiteRoleID).val();
            var ExtraRate = $("#ANextrarate" + SiteRoleID).val();
            var HolidayRate = $("#ANholidayrate" + SiteRoleID).val();

            if (NormalRate == "") {
                alertify.error("'Normal rate' cannot be left blank.");
                $("#ANnormalrate" + SiteRoleID).focus();
            }
            else {
                var TemplateParameter = {
                    TemplateID: encodeURI(GblTemplateID),
                    SiteID: encodeURI(GblSiteID),
                    SiteRoleID: encodeURI(SiteRoleID),
                    NormalRate: encodeURI(NormalRate),
                    ExtraRate: encodeURI(ExtraRate),
                    HolidayRate: encodeURI(HolidayRate),
                    UserName: encodeURI(UserName)
                }
                var param = JSON.stringify(TemplateParameter);
                var strResult = AJAXCallWithResult("/api/PM_Template/SaveRoleData", param, false);
                if (strResult != null) {
                    alertify.success("<%= MyBase.GetResourceString("T_Updated_Role_successfully") %>");
                    GetSiteRoleData(GblSiteID);
                    $(".clslinkAddNewRole").attr('disabled', false);
                    $(".clslinkAddNewRole").css({ 'pointer-events': 'auto', 'cursor': 'pointer' });
                }
            }
        }

        function DetailsClick(SiteID) {
            StartLoader("#bodyCutomerTemplate");
            $("#LinkAddNewRole" + SiteID).hide();
            $("#btnSaveNewSite" + SiteID).show();
            StopAjaxLoader("#bodyCutomerTemplate");
        }


        function AddNewSiteOnClick(TemplateID) {
            GblTemplateID = TemplateID;
        }

        function GetProjectSiteData(SiteID, TemplateID) {
            StartLoader("#bodyCutomerTemplate");
            GblSiteID = SiteID;
            GblTemplateID = TemplateID;
            GetTemplateSiteRole(SiteID);
            //$("#LinkAddNewRole" + SiteID).show();
            var liTemplateSiteID = "#liTemplateSiteID" + SiteID;
            var ClassNames = $(liTemplateSiteID + "> a").attr('class');
            if (ClassNames.indexOf('collapsed') > -1) {
                $(".linkAddNewSite").attr('disabled', true);
                $(".linkAddNewSite").css({ 'pointer-events': 'none' });
            }
            else {
                $(".linkAddNewSite").attr('disabled', false);
                $(".linkAddNewSite").css({ 'pointer-events': 'auto', 'cursor': 'pointer' });
            }

            if (Browser == "IE") {
                $(".liclsEditTemplateSite").attr("disabled", true);
                $(".liclsEditTemplateSite").css({ 'pointer-events': 'none' });
            }
            else {
                $(".clsEditTemplateSite").attr("disabled", true);
                $(".clsEditTemplateSite").css({ 'pointer-events': 'none' });
            }


            $("#LinkAddNewRole" + SiteID).hide();
            StopAjaxLoader("#bodyCutomerTemplate");
        }

        //Added by Chetan M on 19th Dec 2019
        var GblCorpSiteID = "";

        function GetRolesOfProjectSiteMaster(NewSiteID) {            
                var param = JSON.stringify(GblCorpSiteID);
            var strResult = AJAXCallWithResult("/api/PM_Template/GetRolesOfProjectSiteMaster", param, false);
            
            for (var i = 0; i < strResult.length; i++) {                
                AddNewRoles(NewSiteID,strResult[i].RoleID, strResult[i].NormalRate,strResult[i].ExtraRate,strResult[i].HolidayRate,0);
            }
        }
        //end of addition by Chetan m on 19th Dec 2019

        $("#btnSaveTemplateNewSite").click(function () {
            var SiteName = $("#txtTemplateSiteName").val();
            var City = $("#txtTemplateCity").val();
            var Currency = $("#cboTemplateSiteCurrency").val();
            var RateMethod = $("#cboRateMethod").val();
            var StartingDayOfWeek = $("#cboStartingDayOfWeek").val();
            var WeekDays = $("#txtWeekDays").val();
            var WorkHours = $("#txtWorkHoursPerDay").val();
            var WorkHoursPerMonth = $("#txtWorkHoursPerMonth").val();
            var WorkHoursCapPerDay = $("#txtWorkHoursCap").val();

            var WorkHours1 = parseInt(WorkHours);
            var WorkHoursCapPerDay1 = parseInt(WorkHoursCapPerDay);
            var TotalWorkHours = WorkHours1 + WorkHoursCapPerDay1;

            if (SiteName == "" || SiteName == null) {
                alertify.error("<%= MyBase.GetResourceString("T_Site_Name_should_not_be_left_blank") %>");
                $("#txtTemplateSiteName").focus();
            }
            //Commnet and Added By Riddhesh Patil on 15-NOV-2022 
            else if (checkSpecialCharacter(SiteName, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Site Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtTemplateSiteName").focus();

            }
			//End of Comment Added By Riddhesh Patil
            else if (checkDuplicateSite(SiteName) == 1) {
                alertify.error("<%= MyBase.GetResourceString("T_Site_Name_already_Exists") %>");
                $("#txtTemplateSiteName").focus();
            }
            //Commnet and Added By Riddhesh Patil on 15-NOV-2022 
            else if (checkSpecialCharacter(City, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('City Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtTemplateCity").focus();

            }
			//End of Comment Added By Riddhesh Patil
            else if (Currency == '0') {
                alertify.error("<%= MyBase.GetResourceString("T_Currency_should_not_be_left_blank") %>");
                $("#cboTemplateSiteCurrency").focus();
            }
            else if (RateMethod == '0') {
                alertify.error("<%= MyBase.GetResourceString("T_Rate_Method_should_not_be_left_blank") %>");
                $("#cboRateMethod").focus();
            }
            else if (StartingDayOfWeek == '0') {
                alertify.error("<%= MyBase.GetResourceString("T_Starting_Day_of_week_should_not_be_left_blank") %>");
                $("#cboStartingDayOfWeek").focus();
            }
            else if (WeekDays == "") {
                alertify.error("<%= MyBase.GetResourceString("T_Working_Days_Per_week_should_not_be_left_blank") %>");
                $("#txtWeekDays").focus();
            }
            else if (WeekDays > 7) {
                alertify.error("<%= MyBase.GetResourceString("T_The_value_of_Working_Days_per_week_should_be_in_range") %>");
                $("#txtWeekDays").focus();
            }
            else if (WorkHours == "") {
                alertify.error("<%= MyBase.GetResourceString("T_Working_Hours_Per_week_should_not_be_left_blank") %>");
                $("#txtWorkHoursPerDay").focus();
            }
            else if (WorkHours > 24) {
                alertify.error("<%= MyBase.GetResourceString("T_Working_hours_range") %>");
                $("#txtWorkHoursPerDay").focus();
            }
            else if (checkSpecialCharacter(WorkHours, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Working Hours should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtWorkHoursPerDay").focus();

            }
            else if (WorkHoursPerMonth == "") {
                alertify.error("<%= MyBase.GetResourceString("T_Starting_hours_Per_Month_should_not_be_left_blank") %>");
                $("#txtWorkHoursPerMonth").focus();
            }
            else if (WorkHoursPerMonth > 720) {
                alertify.error("<%= MyBase.GetResourceString("T_Working_hours_per_month_range") %>");
                $("#txtWorkHoursPerMonth").focus();
            }
            else if (WorkHoursCapPerDay == "") {
                alertify.error("<%= MyBase.GetResourceString("T_Working_Hours_Cap_should_not_be_left_blank") %>");
                $("#txtWorkHoursCap").focus();
            }
            else if (checkSpecialCharacter(WorkHoursCapPerDay, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Working Hours Cap should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtWorkHoursCap").focus();

            }
            else if (TotalWorkHours > 24) {
                alertify.error("<%= MyBase.GetResourceString("T_Total_Work_Hour_And_Extra_hour_cap_sum") %>");
                $("#txtWorkHoursCap").focus();
            }
            else {
                StartLoader("#bodyCutomerTemplate");
                var TemplateParameter = {
                    TemplateID: encodeURI(GblTemplateID),
                    SiteName: encodeURI(SiteName),
                    City: encodeURI(City),
                    CurrencyID: encodeURI(Currency),
                    RateMethod: encodeURI(RateMethod),
                    StartingDayOfWeek: encodeURI(StartingDayOfWeek),
                    WeekDays: encodeURI(WeekDays),
                    WorkHours: encodeURI(WorkHours),
                    WorkHoursPerMonth: encodeURI(WorkHoursPerMonth),
                    WorkHoursCapPerDay: encodeURI(WorkHoursCapPerDay),
                    UserName: encodeURI(UserName)
                }
                var param = JSON.stringify(TemplateParameter);
                var strResult = AJAXCallWithResult("/api/PM_Template/AddNewTemplateSite", param, false);
                if (strResult != null) {
                    alertify.success("<%= MyBase.GetResourceString("T_Added_Site_Successfully") %>");
                    GetTemplateSiteData(GblTemplateID);
                    //Commented and added By Riddhesh Patil on 11 May 2023
                    //$('#liTemplateSiteIDHref' + strResult).trigger('click');
                    $('#liTemplateSiteID' + strResult).trigger('click');
                    //End of Commented and added By Riddhesh Patil on 11 May 2023
                    $("#linkAddTemplate").attr('disabled', true);
                    $("#linkAddTemplate").css({ 'pointer-events': 'none' });
                    ClearAddNewTaskControls();
                    $('#addSite').modal('toggle');
                }
                else {
                 
                }
                StopAjaxLoader("#bodyCutomerTemplate");
            }
        })

        function ClearAddNewTaskControls() {
            $("#txtTemplateSiteName,#txtTemplateCity,#txtWeekDays,#txtWorkHoursPerDay,#txtWorkHoursPerMonth,#txtWorkHoursCap,#cboSiteMaster").val('');
            $("#cboTemplateSiteCurrency,#cboRateMethod,#cboStartingDayOfWeek").val('0');
        }

        function ClearAddNewRoleControls() {
            $("#cboTemplatesiteRole").val(0);
            $("#txtRoleNormalRate,#txtRoleExtraRate,#txtRoleHolidayRate").val('');
        }

        function ClearAddNewTemplateControls() {
            $("#txtTemplateName").val('');
        }

        function restrictAlphabets(e, flag, curId) {
            var x = e.which || e.keycode;
            if (flag == "resource") {
                GetOUDuration();
                GetOUHours();
            }
            if (flag == "costtocompany") {
                var curValue = $("#editCostToCompany" + curId).val();
                var curDecimalIndex = $("#editCostToCompany" + curId).val().indexOf('.');
                if (curDecimalIndex != -1) {
                    if (curValue.substring(curDecimalIndex, curDecimalIndex.length).length > 2) {
                        return false;
                    }
                }
            }

            if (flag == "reimbersable") {
                var curValue = $("#editReimbersable" + curId).val();
                var curDecimalIndex = $("#editReimbersable" + curId).val().indexOf('.');
                if (curDecimalIndex != -1) {
                    if (curValue.substring(curDecimalIndex, curDecimalIndex.length).length > 2) {
                        return false;
                    }
                }
            }
            if (flag == "billable") {
                var curValue = $("#editBillable" + curId).val();
                var curDecimalIndex = $("#editBillable" + curId).val().indexOf('.');
                if (curDecimalIndex != -1) {
                    if (curValue.substring(curDecimalIndex, curDecimalIndex.length).length > 2) {
                        return false;
                    }
                }
            }
            if (flag == "resource" || flag == "zipcode" || flag == "phno" || flag == "weekdays") {
                if ((x >= 48 && x <= 57) || x == 8 ||
                    (x >= 35 && x <= 40))
                    return true;
                else
                    return false;
            }
            else {
                if ((x >= 48 && x <= 57) || x == 8 ||
                    (x >= 35 && x <= 40) || x == 46)
                    return true;
                else
                    return false;
            }
        }


        function GetTemplateSiteRole(SiteID) {
            $.ajax({
                url: encodeURI(strUrl + '/api/PM_Template/GetTemplateSiteRole'),
                type: "POST",
                data: JSON.stringify(SiteID),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (SiteID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(SiteID) ? SiteID : JSON.stringify(SiteID)));
                    }
                },
                success: function (result) {
                    var objCboOU = document.getElementById('cboTemplatesiteRole');
                    if (objCboOU != null) {
                        $("#cboTemplatesiteRole").empty();

                        for (var i = 0; i < result.length; i++) {
                            var ObjStatus = result[i];
                            var objOption = document.createElement("OPTION");
                            objCboOU.options.add(objOption);
                            objOption.text = ObjStatus.roleDescription;
                            objOption.value = ObjStatus.Role;
                        }
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
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
                }
            });
            return ajaxResult;
        }


    </script>
</body>
</html>
