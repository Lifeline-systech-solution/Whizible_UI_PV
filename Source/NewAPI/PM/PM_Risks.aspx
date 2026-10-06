<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Risks.aspx.vb" Inherits="Whizible.PM_Risks" %>

<!DOCTYPE html> 
 
<html>
       <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Risk")%>
<head runat="server">
   <%-- <title>Risk</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />--%>

    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
   <%-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
<%-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" --%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css" />--%>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=2.0" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=2.8" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
   <%-- <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/bootstrap-datetimepicker.min.css" />--%>
    
  <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
 <%--   <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
<%--    <script src="../../General/CommonValidations.js"></script>--%>
    <script src="../../../Whizible2.0-new/plugins/slimScroll/jquery.slimscroll.min.js"></script>
 <%--   <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>--%>

    

    <script>

        //Added By Riddhesh Patil on 15-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of Added By Riddhesh Patil 
        //Added By Usha Pandit On 18.09.2019 for getting accessible projects in Project drop down
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var selectedProjectID = '<%= Session("intProjectId") %>';
        var currentselectedProjectID = '';
        var currentFilterID = 0;
        var currentDefaultFilterID = 0;
        var currentRiskID = 0;
        var currentDiscussionThreadId = 0;
        var currentDiscussionThreadLevel = '';
        var currentDiscussionThreadReplyIndex = 0;
        var currentResponsiblePerson = '';
        var currentHistoryRiskID = 0;
        var currentContingencyPlanID = 0;
        var currentMitigationPlanID = 0;
        var currentEarlyWarningID = 0;

        var currentPlanIDFlag = 0;

        var blnPlanRecordsExists = false;
        var blnEarlyWarningRecordsExists = false;
        var blnDocumentRecordsExists = false;

        var blnAddClick = false;

        var SessionLoginType = '<%= Session("LoginType") %>';
        var SessionEmployeeId = '<%= Session("intUserId") %>';
        var tableRisk = '';
        var tableHistoryRisk = '';
        var tablePlanRisk = '';
        var tableEarlyWarningRisk = '';
        var tableDocumentRisk = '';
        var tableMatrixRisk = '';
        var blnCreateContingencyTask = false;
        var RoleID = '<%= Session("intPostID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var TagID = '<%= m_TagId%>';
        var blnAccess = false;
        var blnAddAccess = '<%= m_blnAddAccess%>';
        var blnEditAccess = '<%= m_blnEditAccess%>';
        var blnDeleteAccess = '<%= m_blnDeleteAccess%>';
        var blnViewAccess = '<%= m_blnViewAccess%>';

        var currentCategory = '';
        var currentStatus = '';
        var currentStaticFilter = '';

        var counter = 0;

        var icnt = 1;
        var jcnt = 1;
        var kcnt = 1;
        var lcnt = 1;
        var dateToday = new Date();
        var maxlengthwanted = 100;        
        var flagTaskAssigned = 0;
        //End Of Added By Usha Pandit On 18.09.2019 for getting accessible projects in Project drop down

        // Script added by Pradip on 23-10-2019 for disable outer scroll
        $.fn.scrollGuard = function () {
            return this
                .on('mousewheel', function (e) {
                    var event = e.originalEvent;
                    var d = event.wheelDelta || -event.detail;
                    this.scrollTop += (d < 0 ? 1 : -1) * 30;
                    e.preventDefault();
                });
        };    

        $(function () {
            $('.slim-scroll').scrollGuard();
        });
        // End Script added by Pradip on 23-10-2019 for disable outer scroll

        //Script use for hide tooltip when click -  added by pradip

        function clearTooltip() {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
               // $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
            $('.nostylebtn').tooltip();
        }
        
        //End Script use for hide tooltip when click -  added by pradip

        $(document).ready(function () {
            //Added by Aditya J. on 19-08-2026 for restricting changes to closed projects     
            checkProjectIsClosed();
            //End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects  
            //  Added By Gauri On 21th Aug 2024 For click on matrix Issue
            $('.dropdown-menu').on('click', function(e) {
                e.stopPropagation();
            });          
            //  End of Added By Gauri On 21th Aug 2024 For click on matrix Issue
            //slimscroll
            alertify.set('notifier', 'position', 'top-right');//Added by Dipali V On 8th April 2020 For Alert Should be Up

            $('.slim-scroll').slimScroll({
                //your options
                opacity: 0
            }).mouseover(function () {
                $(this).next('.slimScrollBar').css('opacity', 0.4);
            });
            //slimscroll

            //Added By Usha Pandit On 18.09.2019 for getting accessible projects in Project drop down
            //GetTabAcess();
            if (blnViewAccess == "False") {
                var bodyHTML = '';
                //bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                bodyHTML = '<div style="text-align:center;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
                $("#divPMRisk").html(bodyHTML);
                return;
            }
            //$('#deleteinfomodal').modal('hide');            

            if (blnAddAccess == "False") {
                $("#AddRisk").addClass("clsShowHide");
            }
            else {
                $("#AddRisk").removeClass("clsShowHide");
            }

            FillProjectCombox();

            $("#AddRisk").click(function () {
                try {
                    if ($("#cboAccessibleProjects option:selected").val() == 0) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Please Select Project.");
                        $("#cboAccessibleProjects").focus();
                        return;
                    }
                    $("#RDpanel").show("");
                    $('html, body, .bgwhitewrap').animate({
                        scrollTop: $("#RDpanel").offset().top - 150
                    });

                    if ($('#RDpanel').is(':visible')) {
                        $("#Addrisk").css("pointer-events", "none");
                        $("#divAddRisk").css("pointer-events", "none");
                        $(".editRDpanel").css("pointer-events", "none");
                    }
                    $('#btnAddPlan').prop('disabled', true);
                    blnAddClick = true;
                    ClearRiskDetails();
                    currentHistoryRiskID = 0;
                    $("#cboRiskDetailPersonResponsible").removeClass("selectpicker");
                    var arrcboFieldName = ["cboRiskDetailPersonResponsible", "cboRiskDetailReviewer"];

                    FillReponsiblePersonCombo(currentselectedProjectID, arrcboFieldName);
                    /*$("#cboRiskDetailPersonResponsible").addClass("selectpicker");*/
                    /*$('.selectpicker').selectpicker('refresh');*/

                    getProjectRiskId();
                    $('#txtRiskDetailDateIdentifiedDisp').datepicker("setDate", dateToday);
                    $('#txtRiskDetailDateIdentified').datepicker("setDate", dateToday);
                    $(".clsEditMode").addClass("clsShowHide");
                    setFilterComboValue("cboRiskDetailStatus", 3);
                    $(".convAndatchmnt_panel").addClass("clsShowHide");
                    $('.nostylebtn').tooltip();
                }
                catch (ex) {
                    //alert(ex.message);
                }
            });


            $(".editRDpanel").click(function () {

                $("#RDpanel").show("");
                $('html, body, .bgwhitewrap').animate({
                    scrollTop: $("#RDpanel").offset().top - 150
                });

                if ($('#RDpanel').is(':visible')) {
                    $("#Addrisk, .editRDpanel").css("pointer-events", "none");
                }
            });

            $(".canclebtn").click(function () {
                hideRiskDetails();
            });


            var actions = $("#riskplan table td.actioncolumn").html();
            // Append table with add row form on add new button click
            $("#riskplan .add-new").click(function () {
                try {
                    $(this).attr("disabled", "disabled");
                    $(".RiskPlantbl").dataTable().fnDestroy();

                    if (blnPlanRecordsExists == false) {
                        $(".RiskPlantbl tbody").html("");
                    }
                    $('.editriskplan').prop('disabled', true);
                    var strResponsiblePersonHTML = '';
                    strResponsiblePersonHTML = FillReponsiblePersonComboNew("cboPMResponsiblePerson", 0);

                    var selHTMLTaskType = "";
                    selHTMLTaskType = getProjectTaskTypes("cboPMTaskType", 0, "", "");
                    var strRiskPlanHtml = '<%=CommonFunctions.HTMLControls.DrawTextArea("txtRiskPlan0", "txtRiskPlan0", , , , "form-control", "", , 200, 100, 2000,,,,,,,, "onkeyup='limitText(this,10,2000)'", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>';
                    var strDateOfPlanDisp = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtDateOfPlanDisp0", "txtDateOfPlanDisp0", "form-control", , , , "left", , , ToBeInserted:="onkeypress='return Date_OnKeyPress(event)'", returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    var strDateOfPlan = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtDateOfPlan0", "txtDateOfPlan0", "form-control", , , , "left", , , IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    //Commented And Added By Usha Pandit On 22.10.2020 For setting Max length For Duration
                    <%--var strDurationHtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtDuration0", "txtDuration0", "form-control", 50, , , "left", , , ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)' ", returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';--%>
                    var strDurationHtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtDuration0", "txtDuration0", "form-control", 50, 4, , "left", , , ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)' ", returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    //End Of Added By Usha Pandit On 22.10.2020 For setting Max length For Duration
                    //Commented And Added By Usha Pandit On 29.06.2020 for setting MaxLength - 5
		    <%--var strWorkHrsHtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs0", "txtWorkHrs0", "form-control", 60, , , "left", , , , returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';--%>
                    var strWorkHrsHtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs0", "txtWorkHrs0", "form-control", 60, 5, , "left", , , , returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    //End Of Added By Usha Pandit On 29.06.2020 for setting MaxLength - 5
                    var row = '<tr class="">'
                        + '<td class="text-start">'

                        + strRiskPlanHtml
                        + '</td>'
                        + '<td class="text-start">' //Response Type
                        + '<% CommonFunctions.HTMLControls.DrawComboBox("cboRiskPlanType_0", "usp_Whizible2_Sel_Plan_Type",,, "class=""form-control clsPlanWidth"" onChange=""ChangeResponseType(0)""",,,, ,).Replace("'", "\'")%>'
                        + '</td>'
                        + '<td class="text-start">' //Responsibility


                        + strResponsiblePersonHTML


                        + '</td>'

                        + '<td>'

                        + selHTMLTaskType
                        + '</td>'

                        + '<td>'

                        + '<div class="input-group clsDateGroupWidth">'

                        + strDateOfPlanDisp

                        + '<span class="input-group-btn">'
                        + '<button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>'
                        + '</span>'

                        + '</div>'
                        + strDateOfPlan

                        + '</td>'

                        + '<td>'

                        + '</td>'

                        + '<td>'

                        + strDurationHtml
                        + '</td > '
                        + '<td>'

                        + strWorkHrsHtml
                        + '</td > '

                        + '<td class="actioncolumn">'
                        + '<a href="javascript:;" title="Save" data-bs-toggle="tooltip" data-bs-container="body" onclick="SavePlanDetails(0)">'
                        + '<img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px">'
                        + '</a>'

                        + '<a class="nostylebtn cancelrowvalue" onclick = "cancelAddEdit(this, &quot;plan&quot;)" style = "display: inline;cursor:pointer;">'
                        + '<i class="fas fa-times" data-bs-toggle="tooltip" data-bs-placement="top" title="Cancel"></i>'
                        + '</a>'

                        + '</td>'
                        + '</tr>';
                    
                    $("#riskplan table tbody").append(row);
                    
                    tablePlanRisk = $('.RiskPlantbl').DataTable({
                        //"pageLength": 5,
                        "bdestroy": true,
                        "lengthChange": false,
                        "bAutoWidth": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        //"autoWidth": false,
                        //"scrollX":true,
                        "columns": [{ "width": "25px" }, { "width": "25px" }, { "width": "450px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }],
                        "drawCallback": function (settings) {
                            $('[data-bs-toggle="tooltip"]').tooltip();
                            setDatePicker("txtDateOfPlanDisp0", "txtDateOfPlan0");
                            if ($("#txtRiskPlan0").next("label").hasClass("required") == false) {
                                $("#txtRiskPlan0").after('&nbsp;<label class="control-label required" style="float:right;"></label>');
                            }
                            if ($("#cboRiskPlanType_0").next("label").hasClass("required") == false) {
                                $("#cboRiskPlanType_0").after('<label class="control-label required" style="float:right;"></label>');
                            }
                            if ($("#cboPMResponsiblePerson_0").next("label").hasClass("required") == false) {
                                $("#cboPMResponsiblePerson_0").after('<label class="control-label required" style="float:right;"></label>');
                            }
                            if ($("#cboPMTaskType_0").next("label").hasClass("required") == false) {
                                $("#cboPMTaskType_0").after('<label class="control-label required" style="float:right;"></label>');
                            }
                            if ($("#txtDuration0").next("label").hasClass("required") == false) {
                                $("#txtDuration0").after('<label class="control-label required" style="float:right;"></label>');
                            }
                            if ($("#txtWorkHrs0").next("label").hasClass("required") == false) {
                                $("#txtWorkHrs0").after('<label class="control-label required" style="float:right;"></label>');
                            }
                        }
                    });

                    tablePlanRisk.columns.adjust().draw();
                    setDatePicker("txtDateOfPlanDisp0", "txtDateOfPlan0");
                    if ($("#txtRiskPlan0").next("label").hasClass("required") == false) {
                        $("#txtRiskPlan0").after('&nbsp;<label class="control-label required" style="float:right;"></label>');
                    }
                    if ($("#cboRiskPlanType_0").next("label").hasClass("required") == false) {
                        $("#cboRiskPlanType_0").after('<label class="control-label required" style="float:right;"></label>');
                    }
                    if ($("#cboPMResponsiblePerson_0").next("label").hasClass("required") == false) {
                        $("#cboPMResponsiblePerson_0").after('<label class="control-label required" style="float:right;"></label>');
                    }
                    if ($("#cboPMTaskType_0").next("label").hasClass("required") == false) {
                        $("#cboPMTaskType_0").after('<label class="control-label required" style="float:right;"></label>');
                    }
                    if ($("#txtDuration0").next("label").hasClass("required") == false) {
                        $("#txtDuration0").after('<label class="control-label required" style="float:right;"></label>');
                    }
                    if ($("#txtWorkHrs0").next("label").hasClass("required") == false) {
                        $("#txtWorkHrs0").after('<label class="control-label required" style="float:right;"></label>');
                    }
                    //Added By Usha Pandit On 01.07.2020 For setting focus to next page
                    $(".paginate_button").each(function () {
                        if ($(this).attr("data-dt-idx") == 1) {
                            $(this).removeClass("current");
                        }
                        if ($(this).attr("data-dt-idx") == 2) {
                            if (cntRiskPlans >= 10) {
                                $(this).addClass("current");
                                $(this).trigger("click");
                                $("#txtRiskPlan0").focus();
                            }
                        }
                    });  
                    //End Of Added By Usha Pandit On 01.07.2020 For setting focus to next page
                }
                catch (ex) {
                    //alert(ex.message);
                }
            });

            $(document).on("click", "#riskplan .edit", function () {
                try {
                    //Added By Usha Pandit On 24.12.2020 For validation alert field blank issue
                    if ($(this).find("img").attr("src") == editImg) {
                        //End Of Added By Usha Pandit On 24.12.2020 For validation alert field blank issue
                        $(this).attr("disabled", "disabled");
                        $(".RiskPlantbl").dataTable().fnDestroy();

                        var PlanId = 0;
                        if (currentPlanIDFlag == "Contingency") {
                            PlanId = currentContingencyPlanID;
                        }

                        if (currentPlanIDFlag == "Mitigation") {
                            PlanId = currentMitigationPlanID;
                        }


                        var cnt = 1;
                        var curResponseType = "";

                        $(this).parents("tr").find("td").each(function () {
                            if (cnt == 1) {
                                var currentTDValue = $("#txtPlan_" + PlanId).val();
                                var currentTDId = "txtRiskPlan" + PlanId;

                                var strRiskPlanHtml = '<%=CommonFunctions.HTMLControls.DrawTextArea("txtRiskPlan" + "RiskCPlanId", "txtRiskPlan" + "RiskCPlanId", , , , "form-control", "", , 200, 100, 2000,,,,,,,, "onkeyup='limitText(this,10,2000)'", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>';
                                strRiskPlanHtml = strRiskPlanHtml.replace("<script src='..//..//responsive//Scripts//jquery-2.1.1.min.js'><//script>", PlanId);
                                //Added By Usha Pandit On 01.07.2020 for getting correct Plan Id
                                strRiskPlanHtml = strRiskPlanHtml.replace(/RiskCPlanId/g, PlanId);
                                //End Of Added By Usha Pandit On 01.07.2020 for getting correct Plan Id
                                var currentRow = strRiskPlanHtml;
                                $(this).html(currentRow);
                                //Added By Usha Pandit On 01.07.2020 for escaping single quotes
                                //$("#" + currentTDId).val(currentTDValue);
                                var strCurrentTDValue = currentTDValue.replace(/'/g, "\\'");
                                strCurrentTDValue = strCurrentTDValue.toString().replace(/\@@/g, '"');
                                $("#" + currentTDId).val(strCurrentTDValue);
                                //End Of Added By Usha Pandit On 01.07.2020 for escaping single quotes
                                $("#txtRiskPlan" + PlanId).after('&nbsp;<label class="control-label required"></label>');
                            }
                            if (cnt == 2) {
                                var currentID = $(this).children("div").find("select").attr("id");
                                var currentTDValue = $("#" + currentID + " option:selected").text();
                                var currentTDId = "cboRiskPlanType_" + PlanId;
                                curResponseType = currentTDValue;
                            }
                            if (cnt == 3) {
                                var currentID = $(this).children("input").attr("id");
                                var currentTDValue = $("#" + currentID).val();
                                var currentTDId = "cboPMResponsiblePerson_" + PlanId;
                                var strResponsiblePersonHTML = '';
                                strResponsiblePersonHTML = FillReponsiblePersonComboNew("cboPMResponsiblePerson", PlanId);

                                var currentRow = strResponsiblePersonHTML;

                                $(this).html(currentRow);
                                $("#" + currentTDId).val(currentTDValue);
                                if (curResponseType == "Mitigation Plan") {
                                    $("#" + currentTDId).removeClass("mandatory");
                                }
                                else {
                                    $("#" + currentTDId).after('<label class="control-label required" style="float:right;"></label>');
                                }
                            }
                            if (cnt == 4) {
                                var currentID = $(this).children("div").find("select").attr("id");
                                var currentTDValue = $("#" + currentID).val();
                                var currentTDId = "cboPMTaskType_" + PlanId;

                                var selHTMLTaskType = "";
                                selHTMLTaskType = getProjectTaskTypes("cboPMTaskType", PlanId, currentTDValue, "edit");
                                var currentRow = selHTMLTaskType;

                                $(this).html(currentRow);
                                $("#" + currentTDId).val(currentTDValue);
                                $("#" + currentTDId).after('<label class="control-label required" style="float:right;"></label>');
                            }
                            if (cnt == 5) {
                                var currentTDValue = $(this).text();
                                var currentTDId = "txtDateOfPlanDisp" + PlanId;
                                var currentTDHidId = "txtDateOfPlan" + PlanId;

                                var strDateOfPlanDisp = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtDateOfPlanDisp" + "RiskCPlanId", "txtDateOfPlanDisp" + "RiskCPlanId", "form-control", , , , "left", , , ToBeInserted:="onkeypress='return Date_OnKeyPress(event)'", returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                                var strDateOfPlan = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtDateOfPlan" + "RiskCPlanId", "txtDateOfPlan" + "RiskCPlanId", "form-control", , , , "left", , , IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                                strDateOfPlanDisp = strDateOfPlanDisp.replace(/RiskCPlanId/g, PlanId);
                                strDateOfPlan = strDateOfPlan.replace(/RiskCPlanId/g, PlanId);

                                var currentRow = '';

                                currentRow += '<div class="input-group clsDateGroupWidth">';
                                currentRow += strDateOfPlanDisp;
                                currentRow += '<span class="input-group-btn">';
                                currentRow += '<button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>';
                                currentRow += '</span>';
                                currentRow += '</div>';

                                currentRow += strDateOfPlan;
                                $(this).html(currentRow);
                                setDatePicker(currentTDId, currentTDHidId);

                                $('#' + currentTDId).datepicker("setDate", new Date(currentTDValue));
                                $('#' + currentTDHidId).datepicker("setDate", new Date(currentTDValue));
                                if (currentTDValue == "") {
                                    $('#' + currentTDId).val("");
                                    $('#' + currentTDHidId).val("");
                                }
                            }
                            if (cnt == 6) {
                                $(this).html("");
                            }
                            if (cnt == 7) {
                                var currentTDValue = $(this).text();
                                var currentTDId = "txtDuration" + PlanId;
                                //Commented And Added By Usha Pandit On 22.10.2020 For setting Max length For Duration
                            <%--var strDurationHtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtDuration" + "RiskCPlanId", "txtDuration" + "RiskCPlanId", "form-control", 50, , , "left", , , ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)' ", returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';--%>
                                var strDurationHtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtDuration" + "RiskCPlanId", "txtDuration" + "RiskCPlanId", "form-control", 50, 4, , "left", , , ToBeInserted:=" onkeypress='return Field_OnKeyPress(event)' ", returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                                //End Of Added By Usha Pandit On 22.10.2020 For setting Max length For Duration
                                strDurationHtml = strDurationHtml.replace(/RiskCPlanId/g, PlanId);
                                var currentRow = strDurationHtml;
                                $(this).html(currentRow);
                                $("#" + currentTDId).val(currentTDValue);
                                $("#" + currentTDId).after('<label class="control-label required" style="float:right;"></label>');
                            }
                            if (cnt == 8) {
                                var currentTDValue = $(this).text();
                                var currentTDId = "txtWorkHrs" + PlanId;

                                var strWorkHrsHtml = '<%=CommonFunctions.HTMLControls.DrawTextBox("txtWorkHrs" + "RiskCPlanId", "txtWorkHrs" + "RiskCPlanId", "form-control", 60, 5, , "left", , , , returnHTML:=True, EnableHTMLEncode:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                                strWorkHrsHtml = strWorkHrsHtml.replace(/RiskCPlanId/g, PlanId);
                                var currentRow = strWorkHrsHtml;
                                $(this).html(currentRow);
                                $("#" + currentTDId).val(currentTDValue);
                                $("#" + currentTDId).after('<label class="control-label required" style="float:right;"></label>');
                            }

                            if (cnt == 9) {
                                var currentRow = '<a class="edit_SH_Detail editriskplan nostylebtn edit" href="javascript:;" title="Save" data-bs-toggle="tooltip" data-bs-container="body" onclick="SavePlanDetails(' + PlanId + ')">'
                                    + '<img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px">'
                                    + '</a>'

                                    + '<a class="nostylebtn cancelrowvalue" onclick = "cancelAddEdit(this, &quot;plan&quot;)" style = "display: inline;cursor:pointer;">'
                                    + '<i class="fas fa-times" data-bs-toggle="tooltip" data-bs-placement="top" title="Cancel"></i>'
                                    + '</a>';
                                $(this).html(currentRow);
                            }

                            cnt++;
                        });
                        var strDateOfPlanDisp = "txtDateOfPlanDisp" + PlanId;
                        var strDateOfPlanHid = "txtDateOfPlan" + PlanId;

                        tablePlanRisk = $('.RiskPlantbl').DataTable({
                            //"pageLength": 5,
                            "bdestroy": true,
                            "lengthChange": false,
                            "bFilter": false,
                            "ordering": false,
                            "responsive": true,
                            "columns": [{ "width": "25px" }, { "width": "25px" }, { "width": "450px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }],
                            "drawCallback": function (settings) {
                                $('[data-bs-toggle="tooltip"]').tooltip();
                                setDatePicker(strDateOfPlanDisp, strDateOfPlanHid);

                            }
                        });

                        setDatePicker(strDateOfPlanDisp, strDateOfPlanHid);
                        //Added By Usha Pandit On 24.12.2020 For validation alert field blank issue
                    }
                    //End Of Added By Usha Pandit On 24.12.2020 For validation alert field blank issue
                }
                catch (ex) {
                    //alert(ex.message);
                }
            });




            $(document).on("click", "#riskEarlyWarnings .edit", function () {
                try {
                    $(this).attr("disabled", "disabled");
                    $(".RiskEarlyWarningtbl").dataTable().fnDestroy();

                    var EarlyWarningId = currentEarlyWarningID;
                    var cnt = 1;

                    $(this).parents("tr").find("td").each(function () {
                        if (cnt == 1) {
                            var currentTDValue = $("#txtEarlyWarning_" + EarlyWarningId).val();

                            var currentTDId = "txtEarlyWarning" + EarlyWarningId;

                            var strEarlyWarning = '<%=CommonFunctions.HTMLControls.DrawTextArea("txtEarlyWarning" + "EarlyWarningId", "txtEarlyWarning" + "EarlyWarningId", , , , "form-control", "", , 600, 100, 200,, "left",,,,,, "onkeyup='limitText(this,10,200)'", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>';
                            strEarlyWarning = strEarlyWarning.replace(/EarlyWarningId/g, EarlyWarningId);
                            var currentRow = strEarlyWarning;
                            $(this).html(currentRow);
                            $("#" + currentTDId).val(currentTDValue);
                            $("#" + currentTDId).attr('maxlength', '200');
                            $("#" + currentTDId).after('&nbsp;<label class="control-label required"></label>');
                        }
                        if (cnt == 2) {
                            var currentTDValue = $(this).text();
                            var currentTDId = "cboWarningStatus" + EarlyWarningId;

                            var strEarlyWarningStatus = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboWarningStatus" + "EarlyWarningId", "EXEC Usp_Whizible2_Sel_tbl_RTS_ProjectSpecificControlData 'ERW_STATUS'", , , "class=""form-control""", True, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                            strEarlyWarningStatus = strEarlyWarningStatus.replace(/EarlyWarningId/g, EarlyWarningId);
                            var currentRow = strEarlyWarningStatus;
                            $(this).html(currentRow);
                            $("#" + currentTDId).val(currentTDValue);
                            $("#" + currentTDId).after('&nbsp;<label class="control-label required"></label>');
                        }
                        if (cnt == 3) {
                            var currentTDValue = $(this).text();
                            var currentTDId = "chkEarlyWarningFlag" + EarlyWarningId;
                            var strEarlyWarningFlag = '<%= CommonFunctions.HTMLControls.DrawCheckBox("chkEarlyWarningFlag" + "EarlyWarningId", "chkEarlyWarningFlag" + "EarlyWarningId", ,  , , returnHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                            strEarlyWarningFlag = strEarlyWarningFlag.replace(/EarlyWarningId/g, EarlyWarningId);
                            var currentRow = strEarlyWarningFlag;
                            $(this).html(currentRow);

                            if (currentTDValue == "Yes") {
                                $("#" + currentTDId).prop("checked", true);
                            }
                            else {
                                $("#" + currentTDId).prop("checked", false);
                            }
                        }
                        if (cnt == 4) {
                            var currentRow = '<a class="edit_SH_Detail editearlywarning nostylebtn edit" href="javascript:;" title="Save" data-bs-toggle="tooltip" data-bs-container="body" onclick="SaveEarlyWarningDetails(' + EarlyWarningId + ')">'
                                + '<img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px">'
                                + '</a>'

                                + '<a class="nostylebtn cancelrowvalue" onclick = "cancelAddEdit(this, &quot;earlywarning&quot;)" style = "display: inline;cursor:pointer;">'
                                + '<i class="fas fa-times" data-bs-toggle="tooltip" data-bs-placement="top" title="Cancel"></i>'
                                + '</a>';
                            $(this).html(currentRow);
                        }
                        cnt++;
                    });

                    tableEarlyWarningRisk = $('.RiskEarlyWarningtbl').DataTable({
                        //"pageLength": 5,
                        "bdestroy": true,
                        "lengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "autoWidth": false,
                        //"columns": [{ "width": "25px" }, { "width": "25px" }, { "width": "25px" }, { "width": "20px" }],
                        "drawCallback": function (settings) {
                            $('[data-bs-toggle="tooltip"]').tooltip();
                        }
                    });
                }
                catch (ex) {
                    //alert(ex.message);
                }
            });

            $("#riskEarlyWarnings .add-new-early-warning").click(function () {
                try {
                    $(this).attr("disabled", "disabled");
                    $(".RiskEarlyWarningtbl").dataTable().fnDestroy();                    

                    if (blnEarlyWarningRecordsExists == false) {
                        $(".RiskEarlyWarningtbl tbody").html("");
                    }
                    $('.editearlywarning').prop('disabled', true);

                    var strEarlyWarning = '<%=CommonFunctions.HTMLControls.DrawTextArea("txtEarlyWarning0", "txtEarlyWarning0", , , , "form-control", "", , 600, 100, 200,, "left",,,,,, "onkeyup='limitText(this,10,200)'", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>';
                    var row = '<tr class="">'
                        + '<td class="text-start">'

                        + strEarlyWarning
                        + '</td>'
                        + '<td class="text-start">' //Warning Status
                        
                        + '<%=CommonFunctions.HTMLControls.DrawComboBox("cboWarningStatus0", "EXEC Usp_Whizible2_Sel_tbl_RTS_ProjectSpecificControlData 'ERW_STATUS'", , , "class=""form-control""", True, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>'
                        + '</td>'

                        + '<td class="text-start">' //Early Warning Flag

                        + '<%= CommonFunctions.HTMLControls.DrawCheckBox("chkEarlyWarningFlag0", "chkEarlyWarningFlag0", ,  , , returnHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>'
                        + '</td>'

                        + '<td class="actioncolumn">'
                        + '<a href="javascript:;" title="Save" data-bs-toggle="tooltip" data-bs-container="body" onclick="SaveEarlyWarningDetails(0)">'
                        + '<img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px">'
                        + '</a>'

                        + '<a class="nostylebtn cancelrowvalue" onclick = "cancelAddEdit(this, &quot;earlywarning&quot;)" style = "display: inline;cursor:pointer;">'
                        + '<i class="fas fa-times" data-bs-toggle="tooltip" data-bs-placement="top" title="Cancel"></i>'
                        + '</a>'

                        + '</td>'
                        + '</tr>';

                    $("#riskEarlyWarnings table tbody").append(row);

                    tableEarlyWarningRisk = $('.RiskEarlyWarningtbl').DataTable({
                        //"pageLength": 5,
                        "bdestroy": true,
                        "lengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        "autoWidth": false,
                        "drawCallback": function (settings) {
                            $('[data-bs-toggle="tooltip"]').tooltip();
                        }
                    });
                    if ($("#txtEarlyWarning0").next("label").hasClass("required") == false) {
                        $("#txtEarlyWarning0").after('<label class="control-label required"></label>');
                    }
                    if ($("#cboWarningStatus0").next("label").hasClass("required") == false) {
                        $("#cboWarningStatus0").after('&nbsp;<label class="control-label required" style="float:right;"></label>');
                    }
                    //Added By Usha Pandit On 01.07.2020 For setting focus to next page
                    $(".paginate_button").each(function () {
                        if ($(this).attr("data-dt-idx") == 1) {
                            $(this).removeClass("current");
                        }                        
                        if ($(this).attr("data-dt-idx") == 2) {
                            if (cntEarlyWarning >= 10) {
                                $(this).addClass("current");
                                $(this).trigger("click");
                                $("#txtEarlyWarning0").focus();
                            }
                        }
                    });  
                    //End Of Added By Usha Pandit On 01.07.2020 For setting focus to next page
                }
                catch (ex) {
                    //alert(ex.message);
                }
            });

            //Added by imran on 16-12-2021
            function checkAllFieldsWithFileValidation()
            {
                var Category = '';
                var Flag = true;                
                var ValidationFlag = false;

                $('#atchmentTable>#atchmentTableBody > tr.attachments').each(function (index, value)
                {
                    try {
                        var allColumns = $(this).find('td');
                        var checkCurrentFlag = true;;
                        $(allColumns).each(function (i, v)
                        {                            
                            if (i == 3) {
                                Description = $(this).find('textarea').val();
                            }
                            if (i == 2)
                            {                               
                                var id = $(this).find('*[id*=Afilname]').attr("id");
                                var curFileIndex = 0;
                                curFileIndex = id.replace(/Afilname/g, "");
                                var id = $('#atchmentTableBody > tr.attachments > td:nth-child(3)>#Afilname' + (curFileIndex));

                                var gerfileName = id[0].files[0];
                                var curFlag = Flag;                               
                                Flag = ValidateAttachment('Afilname' + (curFileIndex));
                                if (gerfileName != undefined && gerfileName != null) {
                                    formdata.append("file" + index, gerfileName);
                                } else {
                                    if (curFlag == true && Flag == false) {
                                        alertify.set('notifier', 'position', 'top-right');
                                        alertify.error("Please Select File.");
                                        Flag = false;
                                        ValidationFlag = true;
                                    }
                                }
                            }
                            if (i == 0) {
                                var id = $(this).find('*[id*=AsdCat]').attr("id");
                                var curCatIndex = 0;
                                curCatIndex = id.replace(/AsdCat/g, "");
                                CategoryName = $("#atchmentTableBody > tr.attachments > td:nth-child(1)>select#AsdCat" + (curCatIndex) + " option:selected").text();
                                Category = $("#atchmentTableBody > tr.attachments > td:nth-child(1)>select#AsdCat" + (curCatIndex)).val();
                                
                                if (Category == 0 && Flag == true) {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error("Please Select Category ");
                                    $("#atchmentTableBody > tr.attachments > td:nth-child(1)>select#AsdCat" + (curCatIndex)).focus();
                                    Flag = false;
                                    checkCurrentFlag = false;
                                    ValidationFlag = true;
                                }
                            }
                            if (i == 1) {
                                var id = $(this).find('*[id*=AsdsubCat]').attr("id");
                                var curSubCatIndex = 0;
                                curSubCatIndex = id.replace(/AsdsubCat/g, "");
                                SubCategoryName = $("#AsdsubCat" + (curSubCatIndex) + " option:selected").text();
                                SubCategory = $("#AsdsubCat" + (curSubCatIndex)).val();
                            }                            
                        });
                        if (checkCurrentFlag == false) {
                            Flag = false;
                        }                                              
                    }
                    catch (ex) {}
                });
                return ValidationFlag;
            }
            //End by imran on 16-12-2021

            //Attachment Section Starts
            //Add attachment script start here added by pradip on 07-10-2019
            //add attachment            
            $("#addattachnebtrow").on("click", function () {
                try {
                    //Added by Usha Pandit On 06.11.2019 For add new attachment multiple click issue
                    var cntDoc = 0;
                    
                    $("table.order_attchmentlist tbody tr").each(function () {
                        cntDoc = cntDoc + 1;                                              
                    });

                    //Added by imran on 16-12-2021  to check attachment is uploaded or not
                    if (cntDoc >= 1)
                    {
                        var FlagCheck = checkAllFieldsWithFileValidation();                      
                        if (FlagCheck == true) {
                            return;
                        }
                    }
                     //End by imran on 16-12-2021
                    if (cntDoc == 0) {
                        counter = 0;

                        icnt = 1;
                        jcnt = 1;
                        kcnt = 1;
                        lcnt = 1;
                    }  
                    //End Of Added by Usha Pandit On 06.11.2019 For add new attachment multiple click issue

                    $("#savedocument").prop('disabled', false);
                    $(".delattachbtn").prop('disabled', true);

                    var newRow = $("<tr class='attachments'>");
                    var cols = "";

                    //Commented And Added By Usha Pandit On 07-11-2019 For UI related changes
                    //cols += '<td><select id="AsdCat' + kcnt + '" class="form-control " onchange="CategoryOnChange(this.id,this);"><option></option></select><span style="color:red;">*</span></td>';
                    cols += '<td><select style="width: 150px;" id="AsdCat' + kcnt + '" class="form-control " onchange="CategoryOnChange(this.id,this);"><option></option></select><span style="color:red;">*</span></td>';
                    //End Of Added By Usha Pandit On 07-11-2019 For UI related changes

                    //Commented And Added By Usha Pandit On 07-11-2019 For UI related changes
                    //cols += '<td><select id="AsdsubCat' + lcnt + '" class="form-control"><option>--Select Sub Category --</option></select></td>';
                    cols += '<td><select style="width: 180px;" id="AsdsubCat' + lcnt + '" class="form-control"><option>--Select Sub Category --</option></select></td>';
                    //End Of Added By Usha Pandit On 07-11-2019 For UI related changes
                    //Commented & Added by Ajit L on 13/11/2024 for file upload restriction
                    //cols += '<td width="200"><input id="Afilname' + jcnt + '" type="file" name="img[]" class="file"> <div class="input-group col-sm-12 fileup"><span class="input-group-btn"><button class="browse browsebtn" type="button" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Select File" ><i class="fas fa-paperclip"></i></button></span><input id="FileName' + jcnt + '" type="text" class="form-control" disabled="" style="width: 110px;" placeholder="Upload Files"></td>'
                    cols += '<td width="200"><input id="Afilname' + jcnt + '" type="file" name="img[]" class="file" onchange="ValidateForexeinFile(this)"> <div class="input-group col-sm-12 fileup"><span class="input-group-btn"><button class="browse browsebtn" type="button" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Select File" ><i class="fas fa-paperclip"></i></button></span><input id="FileName' + jcnt + '" type="text" class="form-control" disabled="" style="width: 110px;" placeholder="Upload Files"></td>'
                    //End of Commented & Added by Ajit L on 13/11/2024 for file upload restriction
                    //Added By Usha Pandit On 23-10-2019 For UI related changes
                    //cols += '<td><textarea id="Adescription' + icnt + '" class="form-control" name="name' + counter + '"/><textarea</td>';   
                    //Commented & Added By Dipali V On 8th May 2020 For IssueID 24248
                   <%-- //var descTextArea= '<%=CommonFunctions.HTMLControls.DrawTextArea("Adescription" + "descrId", "Adescription" + "descrId", , "form-control", , "form-control", "", , 200, 100, 3000,,, "",,,,, " onkeyup='limitText(this,10,100)'", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>';--%>
                     var descTextArea= '<%=CommonFunctions.HTMLControls.DrawTextArea("Adescription" + "descrId", "Adescription" + "descrId", , "form-control", , "form-control", "", , 200, 100, 1000,,, "",,,,, " onkeyup='limitText(this,10,100)'", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>';
                     //End of Commented & Added By Dipali V On 8th May 2020 For IssueID 24248
                    descTextArea = descTextArea.replace(/descrId/g, icnt);
                    cols += '<td>' + descTextArea + '</td>';
                    //End Of Added By Usha Pandit On 23-10-2019 For UI related changes
                    cols += '<td></td>';
                    cols += '<td></td>';
                    cols += '<td style="text-align: center"><button class="ibtnDel nostylebtn" title=""><i class="fa fa-times" value="Delete"></i></button></td> </tr>';
                                        
                    newRow.append(cols);
                    var blnRowExists = false;
                    
                    $("table.order_attchmentlist tbody tr").each(function () {
                        if ($(this).find("td").hasClass("dataTables_empty")) {
                            $(this).remove();
                        }
                    });                                     
                    
                    if (blnRowExists == false) {
                        //$(".RiskDocumentTbl").dataTable().fnDestroy();
                        $("table.order_attchmentlist").append(newRow);

                        $('table.order_attchmentlist').find('.attachdate').datepicker();
                        //GetDocumentCategoryList("AsdCat" + k);
                        getDocumentCategoryList("AsdCat" + kcnt);
                        icnt++;
                        jcnt++;
                        kcnt++;
                        lcnt++;

                        counter++;

                        //alert(counter);
                        //MaxlengthArea();

                        //tableDocumentRisk = $('.RiskDocumentTbl').DataTable({
                        //    //"pageLength": 5,
                        //    "bdestroy": true,
                        //    "lengthChange": false,
                        //    "bFilter": false,
                        //    "ordering": false,
                        //    "responsive": true,
                        //    "bAutoWidth": false,
                        //    "paging": false,
                        //    "columns": [{ "width": "80px" }, { "width": "80px" }, { "width": "120px" }, { "width": "80px" }, { "width": "80px" }, { "width": "80px" }, { "width": "80px" }],
                        //    "drawCallback": function (settings) {
                        //        $('[data-bs-toggle="tooltip"]').tooltip();
                        //    }
                        //});
                    }
                }
                catch (ex) {
                    //alert(ex.message);
                }
            });

            $("#savedocument").click(function () {
                Flag = true;

                var formdata = new FormData();
                var LoginType = '<%= Session("LoginType") %>';
                var UserName = '<%= Session("strUserName") %>';

                var AttachedFileData = new Array();

                var d = new Date();

                var CategoryName;
                var SubCategoryName;
                var Category;
                var SubCategory;
                var PMParam = {
                    EmployeeID: SessionEmployeeId,
                    LoginType: SessionLoginType,
                    ProjectID: currentselectedProjectID,
                    RoleID: RoleID,
                    TagID: TagID
                };
                var PMDocumentParameter = {
                    RiskID: currentRiskID
                }
                $('#atchmentTable>#atchmentTableBody > tr.attachments').each(function (index, value) {
                    try {
                        var Description = "";
                        Description = $(this).find('textarea').val();
                        var allColumns = $(this).find('td');
                        var checkCurrentFlag = true;;
                        $(allColumns).each(function (i, v) {

                            console.log(this);

                            if (i == 3) {
                                Description = $(this).find('textarea').val();
                                //Added By Riddhesh Patil on 15-NOV-2022
                                if (checkSpecialCharacter(Description, WebConfigSpecialCharacters) == true) {
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                                    Flag = false;
                                    checkCurrentFlag = false;
                                }
                                  //End of Added By Riddhesh Patil on 15-NOV-2022
                            }
                            if (i == 2) {
                                //var id = $('#Afilname' + (index + 1));
                                var id = $(this).find('*[id*=Afilname]').attr("id");
                                var curFileIndex = 0;
                                curFileIndex = id.replace(/Afilname/g, "");
                                //alert("id  "+ id + ' Afilname' + (index + 1));
                                var id = $('#atchmentTableBody > tr.attachments > td:nth-child(3)>#Afilname' + (curFileIndex));

                                var gerfileName = id[0].files[0];


                                var curFlag = Flag;
                               
                                Flag = ValidateAttachment('Afilname' + (curFileIndex));

                                if (gerfileName != undefined && gerfileName != null) {
                                    formdata.append("file" + index, gerfileName);
                                } else {
                                    if (curFlag == true && Flag == false) {
                                        alertify.set('notifier', 'position', 'top-right');//Added by Dipali V On 8th April 2020 For Alert Should be Up
                                        alertify.error("Please Select File.");
                                        Flag = false;
                                         checkCurrentFlag = false;  
                                    }
                                }
                            }
                            if (i == 0) {
                                var id = $(this).find('*[id*=AsdCat]').attr("id");
                                var curCatIndex = 0;
                                curCatIndex = id.replace(/AsdCat/g, "");
                                CategoryName = $("#atchmentTableBody > tr.attachments > td:nth-child(1)>select#AsdCat" + (curCatIndex) + " option:selected").text();
                                Category = $("#atchmentTableBody > tr.attachments > td:nth-child(1)>select#AsdCat" + (curCatIndex)).val();
                                
                                if (Category == 0 && Flag == true) {
                                    alertify.error("Please Select Category ");
                                    $("#atchmentTableBody > tr.attachments > td:nth-child(1)>select#AsdCat" + (curCatIndex)).focus();
                                    Flag = false;
                                    checkCurrentFlag = false;                                    
                                }
                            }
                            if (i == 1) {
                                var id = $(this).find('*[id*=AsdsubCat]').attr("id");
                                var curSubCatIndex = 0;
                                curSubCatIndex = id.replace(/AsdsubCat/g, "");
                                SubCategoryName = $("#AsdsubCat" + (curSubCatIndex) + " option:selected").text();
                                SubCategory = $("#AsdsubCat" + (curSubCatIndex)).val();
                            }                            
                        });
                        if (checkCurrentFlag == false) {
                            Flag = false;
                        }
                        var item = {
                            Description: Description,
                            CategoryName: CategoryName,
                            Category: Category,
                            SubCategoryName: SubCategoryName,
                            SubCategory: SubCategory,
                            PMParam: PMParam,
                            PMDocumentParam: PMDocumentParameter
                        }
                        
                        AttachedFileData.push(item);                        
                    }
                    catch (ex) {
                        //alert(ex.message);
                    }
                });
                //alert(Flag);
                if (Flag == true) {
                    //Added by dipali v for avoid multiple click of attachment
                    $("#savedocument").prop('disabled', true);
                    //End of Added by dipali v for avoid multiple click of attachment
                }
                try {
                    formdata.append("AttachedFileData", JSON.stringify(AttachedFileData));
                    
                    if (Flag == true) {
                        $.ajax({
                            url: strUrl + '/api/PM_Risks/InsertDocumentAttachment',
                            type: "POST",
                            dataType: "json",
                            data: formdata,
                            contentType: false,
                            processData: false,
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            },
                            success: function (result) {
                                if (result == 'file save successfully') {
                                    alertify.success('<%= MyBase.GetResourceString("A_SDocument") %>');
                                    //$('.attachments').each(function (index, value) {
                                    $('#atchmentTable>#atchmentTableBody > tr.attachments').each(function (index, value) {
                                        $(this).remove();
                                    });

                                    counterFORattachment = 0;
                                    icnt = "1";
                                    jcnt = "1";
                                    kcnt = "1";
                                    lcnt = "1";

                                    $("#atchmentTableBody").empty();
                                    //$("#addattachnebtrow").prop('disabled', false);
                                    $("#savedocument").prop('disabled', true);
                                    $(".delattachbtn").prop('disabled', false);
                                    getDocumentDetails();
                                }
                                else {                                    
                                    $("#stakedetailpanel .main_graybgtbs li:nth-child(2) a, #stakedetailpanel .main_graybgtbs li:nth-child(3n) a").css("cursor", "pointer");
                                    $("#stakedetailpanel").hide('fast');
                                    $("#hidestaklist").show('fast');

                                    alertify.error(result);
                                }
                            },
                            error: function (ER,errorThrown) {
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + ER + "";
                            }
                        });
                    }
                }
                catch (ex) {
                    //alert(ex.message);
                }
            });

            $("table.order_attchmentlist").on("click", ".ibtnDel", function (event) {
                
                //getDocumentDetails();
                //counter = 0;
                $(this).closest("tr").remove();
                //counter -= 1;
                //icnt -= 1;
                //jcnt -= 1;
                //kcnt -= 1;
                //lcnt -= 1;
                //$("#addattachnebtrow").prop('disabled', false);
                //$("#savedocument").prop('disabled', true);
                $(".delattachbtn").prop('disabled', false);
                var blnEditableDocExists = false;
                $('*[id*=AsdCat]:visible').each(function () {
                    blnEditableDocExists = true;
                });
                if (blnEditableDocExists == false) {
                    $("#savedocument").prop('disabled', true);
                }
            });
            //End Of Added By Usha Pandit On 18.09.2019 for getting accessible projects in Project drop down


            $(".mainclearalllink").click(function () {
                $(".filter").removeClass("active");
                //$('.filterpanel').collapse('toggle');                

                FilterNotApplied();
                ChangeProject(1, 1);
                $(".filter").removeClass("active");
                if ($('.filterpanel').hasClass("in")) {
                    $('.filterpanel').removeClass("in");
                }
                //Added By Usha Pandit On 05.11.2019 For applied filter title
                //$(".clsHideTooltip").attr("title", "Apply filter");
                $(".clsHideTooltip").each(function () {
                    $(this).attr("data-original-title", "Apply filter");
                });
                $('[data-bs-toggle="tooltip"]').tooltip();
                //End Of Added By Usha Pandit On 05.11.2019 For applied filter title  
                fltProjectRiskID = "";
                fltRiskDescription = "";
                fltImpactDescription = "";
                fltRiskCategory = "";
                fltDateIdentified = "";
                fltOriginalPriority = "";
                fltChangePriority = "";
                fltProbability = "";
                fltImpact = "";
                fltMagnitude = "";
                fltRiskSource = "";
                fltRiskStatus = "";
                fltPersonResponsible = "";
                currentappliedfilter = 0;
                currentappliedfilterclause = "";
                $("#presetfilter").removeClass('active')
                $("#presetfilter").removeClass('show')
                //debugger;
                if ($("#tabpresetfilter a").hasClass("active")) {
                    $("#tabpresetfilter a").removeClass("active");
                }
            });

            $('[data-bs-toggle="tooltip"]').tooltip();

            //Added By Usha Pandit On 18.09.2019 for getting accessible projects in Project drop down            
            ChangeProject(1, 0);

            //$('#cboRiskCategory option').each(function () {

            //    $(this).attr("data-bs-toggle", "tooltip");               

            //    $(this).attr("data-bs-placement", "right");
            //});
            $('[data-bs-toggle="tooltip"]').tooltip();
            //$(".mainclearalllink").addClass("clsShowHide");
            //End Of Added By Usha Pandit On 18.09.2019 for getting accessible projects in Project drop down

            //Added By Usha Pandit On 24.09.2019 for getting accessible projects in Project drop down            
            $('#txtPMFilterDateIdentifiedDisp').datepicker({
                onSelect: function (dateText) {
                    $("#txtPMFilterDateIdentifiedDisp").datepicker('option', {
                        dateFormat: 'yy-mm-dd'
                    });
                    document.getElementById("txtPMFilterDateIdentified").value = this.value;

                    $("#txtPMFilterDateIdentifiedDisp").datepicker('option', {
                        dateFormat: 'd M yy'
                    });
                },
                autoclose: true,
                changeMonth: true,
                changeYear: true, //added by pradip on 09-04-2020
                dateFormat: 'd M yy'
            });
            $('#txtPMFilterDateIdentified').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true, //added by pradip on 09-04-2020
                dateFormat: 'yy-mm-dd'
            });

            var dateToday = new Date();

            $('#txtRiskDetailDateIdentifiedDisp').datepicker({
                onSelect: function (dateText) {
                    $("#txtRiskDetailDateIdentifiedDisp").datepicker('option', {
                        dateFormat: 'yy-mm-dd'
                    });
                    document.getElementById("txtRiskDetailDateIdentified").value = this.value;

                    $("#txtRiskDetailDateIdentifiedDisp").datepicker('option', {
                        dateFormat: 'd M yy'
                    });
                },
                autoclose: true,
                changeMonth: true,
                changeYear: true, //added by pradip on 09-04-2020
                dateFormat: 'd M yy',
                setDate: dateToday
            });
            $('#txtRiskDetailDateIdentified').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true, //added by pradip on 09-04-2020
                dateFormat: 'yy-mm-dd',
                setDate: dateToday
            });

            $('#txtRiskDetailReviewNotificationDateDisp').datepicker({
                onSelect: function (dateText) {
                    $("#txtRiskDetailReviewNotificationDateDisp").datepicker('option', {
                        dateFormat: 'yy-mm-dd'
                    });
                    document.getElementById("txtRiskDetailReviewNotificationDate").value = this.value;

                    $("#txtRiskDetailReviewNotificationDateDisp").datepicker('option', {
                        dateFormat: 'd M yy'
                    });
                },
                autoclose: true,
                changeMonth: true,
                changeYear: true, //added by pradip on 09-04-2020
                dateFormat: 'd M yy',
                minDate: 0
                //setDate: dateToday
            });
            $('#txtRiskDetailReviewNotificationDate').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true, //added by pradip on 09-04-2020
                dateFormat: 'yy-mm-dd'
                //setDate: dateToday
            });

            //End Of Added By Usha Pandit On 24.09.2019 for getting accessible projects in Project drop down

            //Start script for collapse conversation box
            $("[data-widget='collapse']").click(function () {
                //Find the box parent
                var box = $(this).parents(".box").first();

                //Find the body and the footer
                var bf = box.find(".box-body, .box-footer");
                if (!box.hasClass("collapsed-box")) {
                    box.addClass("collapsed-box");
                    bf.slideUp();
                } else {
                    box.removeClass("collapsed-box");
                    bf.slideDown();
                    getRiskDiscussions(currentRiskID);
                }
            });

            //End script for collapse conversation box            
        });
        $(document).on('click.bs.dropdown.data-api', '.dropdown.keep-inside-clicks-open', function (e) {
            e.stopPropagation();
        });

        //Added by Aditya J. on 19-08-2026 for restricting changes to closed projects     
        function checkProjectIsClosed() {

            debugger
            $.ajax({
                type: 'POST',
                dataType: 'JSON',
                contentType: 'application/json',
                url: 'PM_Risks.aspx/CheckProjectIsClosed',
                data: JSON.stringify({ ProjectID: $('#cboAccessibleProjects').val() }),
                success: function (Result) {
                },
                error: function (xhr) {
                }
            });
        }
        //End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects

        //Added by Ajit L on 13/12/2024 for restricting file which contain exe file embeded in it
        var isValidTypeExeCheck = ''
        async function ValidateForexeinFile(file) {
            var objFile = file;
            var fileName = objFile.files[0].name;
            var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

            isValidTypeExeCheck = false;
            //Commented and Added by Aditya J. on 25-11-2024
            //const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
            var ValidExtsExe = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
            //End of comment Added by Aditya J. on 25-11-2024
            isValidTypeExeCheck = ValidExtsExe.includes(extension);

            if (isValidTypeExeCheck) {
                const file = objFile.files[0];
                //await checkFileForExe(file);
                await validateDocFileForExe(file)
                    .then(() => {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("File is valid and ready to upload.");
                        //alert("File is valid and ready to upload.");
                    })
                    .catch(error => {
                        //Added by Ajit L on 21/11/2024
                        isValidTypeExeCheck = false;
                        var fileInput = objFile;
                        var fileNameInput = $(fileInput).closest('td').find('[id^="FileName"]');
                        // Before clearing:
                        console.log("Selected files before clearing:", fileInput.files);
                        $(fileInput).val(""); // Clear the file input
                        fileNameInput.val(""); // Clear the file name text input

                        // Clear the file input
                        $(objFile).val("");

                        // After clearing:
                        console.log("Selected files after clearing:", objFile.files);
                        //End of Added by Ajit L on 21/11/2024

                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");         
                        return;
                    });

                if (!isValidTypeExeCheck) {
                    return;
                }
            }
        }
         //End of Added by Ajit L on 13/12/2024 for restricting file which contain exe file embeded in it
        function setDatePicker(DateField1, DateField2) {
            //txtDateOfPlanDisp
            //txtDateOfPlan

            //$('#txtDateOfPlanDisp').datepicker({
            //    onSelect: function (dateText) {
            //        $("#txtDateOfPlanDisp").datepicker('option', {
            //            dateFormat: 'yy-mm-dd'
            //        });
            //        document.getElementById("txtDateOfPlan").value = this.value;

            //        $("#txtDateOfPlanDisp").datepicker('option', {
            //            dateFormat: 'd M yy'
            //        });
            //    },
            //    autoclose: true,
            //    changeMonth: true,
            //    dateFormat: 'd M yy'
            //});
            //$('#txtDateOfPlan').datepicker({
            //    autoclose: true,
            //    changeMonth: true,
            //    dateFormat: 'yy-mm-dd'
            //});
            $('#' + DateField1).datepicker({
                onSelect: function (dateText) {
                    $('#' + DateField1).datepicker('option', {
                        dateFormat: 'yy-mm-dd'
                    });
                    document.getElementById(DateField2).value = this.value;

                    $('#' + DateField1).datepicker('option', {
                        dateFormat: 'd M yy'
                    });
                },
                autoclose: true,
                changeMonth: true,
	        changeYear: true, //added by pradip on 09-04-2020
                dateFormat: 'd M yy'
            });
            $('#' + DateField2).datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true, //added by pradip on 09-04-2020
                dateFormat: 'yy-mm-dd'
            });
        }
        //dynamically set height
        function resizeSection() {
            var risktblheight = $(window).height();
            $('.bgwhitewrap').css({ 'height': risktblheight - 120, "overflow-y": "auto" });
        }

        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
        });

        $('.Risktbl').on('shown.bs.collapse', function () {
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust();
        });

        $('.RiskHistorytbl, .RiskPlantbl').on('shown.bs.collapse', function () {
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust();
        });

        $('a[data-bs-toggle="tab"]').on('shown.bs.tab', function (e) {
            $($.fn.dataTable.tables(true)).DataTable()
                .columns.adjust();
        });

        // Check or Uncheck All checkboxes        

        $('#Stakeholdername').click(function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });
        $('#stackstaus').click(function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });

        $('#stackrole').click(function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });

        $('#stackcategory').click(function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });

        $('#stacktype').click(function () {
            var table = $(this).parents('table').eq(0)
            var rows = table.find('tr:gt(0)').toArray().sort(comparer($(this).index()))
            this.asc = !this.asc;
            if (!this.asc) {
                rows = rows.reverse();
            }

            for (var i = 0; i < rows.length; i++) {
                table.append(rows[i]);
            }
        });

        function hideRiskDetails() {
            $("#RDpanel").hide("fast");
            //$("#Addrisk, .editRDpanel").css("pointer-events", "auto");
            $("#Addrisk, #divAddRisk, .editRDpanel").css({ 'pointer-events': "auto", "cursor": "pointer" });
            $('[href="#riskDetail"]').tab('show');
            $('#btnAddPlan').prop('disabled', false);
            blnAddClick = false;
            currentHistoryRiskID = 0;
            $(".clsEditMode").removeClass("clsShowHide");
        }
        function comparer(index) {
            return function (a, b) {
                var valA = getCellValue(a, index), valB = getCellValue(b, index)
                return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.toString().localeCompare(valB)
            }
        }
        function getCellValue(row, index) { return $(row).children('td').eq(index).text() }

        //filter-table

        //Start Script for edit basic filter
        $(".edit_filter").click(function () {
            $(".stackbasicfilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("open");
        });
        //Start Script for edit basic filter        

        //Added By Usha Pandit On 18.09.2019 for getting accessible projects in Project drop down
        //28.09.2019
        function EditEarlyWarningDetails(EarlyWarningnID) {
            currentEarlyWarningID = EarlyWarningnID;
            $('#btnEarlyWarning').prop('disabled', true);
        }
        function EditPlanDetails(PlanID, Flag) {
            currentPlanIDFlag = Flag;
            if (Flag == "Contingency") {
                currentContingencyPlanID = PlanID;
            }

            if (Flag == "Mitigation") {
                currentMitigationPlanID = PlanID;
            }

            $('#btnAddPlan').prop('disabled', true);
        }
        function cancelsavetask() {

        }
        function cancelAddEdit(e, flag) {
            if (flag == "plan") {
                getRiskPlanDetails();
            }
            if (flag == "earlywarning") {
                getRiskEarlyWarningsDetails();
            }
        }

        function editRiskDetails(RiskId) {
            var editRiskid = RiskId;
            editRiskid = editRiskid.toString().replace("Edit_Risk_", "");

            $("#RDpanel").show("");
            $('html, body, .bgwhitewrap').animate({
                scrollTop: $("#RDpanel").offset().top - 150
            });

            if ($('#RDpanel').is(':visible')) {
                $("#Addrisk").css("pointer-events", "none");
                $("#divAddRisk").css("pointer-events", "none");
                $(".editRDpanel").css("pointer-events", "none");
            }

            currentRiskID = editRiskid;
            currentHistoryRiskID = editRiskid;
            
            $("#savedocument").prop('disabled', true);
            $(".delattachbtn").prop('disabled', false);
            var arrcboFieldName = ["cboRiskDetailPersonResponsible", "cboRiskDetailReviewer"];
            FillReponsiblePersonCombo(currentselectedProjectID, arrcboFieldName);

            getRiskDetails(currentselectedProjectID, 0, "", "riskdetails", "");

            getRiskPlanDetails();
            $(".clsEditMode").removeClass("clsShowHide");

            var box = $("#panelDiscussion").parents(".box").first();
            var bf = box.find(".box-body, .box-footer");
            if (!box.hasClass("collapsed-box")) {
                box.addClass("collapsed-box");
                bf.slideUp();
            }
            $(".convAndatchmnt_panel").removeClass("clsShowHide");
            $('[href="#riskDetail"]').tab('show');
        }
        function formatAMPM(curdate) {
            var hours = curdate.getHours();
            var minutes = curdate.getMinutes();
            var ampm = hours >= 12 ? 'PM' : 'AM';
            hours = hours % 12;
            hours = hours ? hours : 12; // the hour '0' should be '12'
            minutes = minutes < 10 ? '0' + minutes : minutes;
            var strTime = hours + ':' + minutes + ' ' + ampm;
            return strTime;
        }
        function getMonthDateYear(curdate) {
            var cursubmitDate = '';
            var month = curdate.getMonth() + 1;
            var date = curdate.getDate();
            var year = curdate.getFullYear();
            cursubmitDate = date + '/' + month + '/' + year;
            return cursubmitDate;
        }
        function setReplyDiscussion(DiscussionID, ThreadLevel, ReplyIndex) {
            currentDiscussionThreadId = DiscussionID;
            currentDiscussionThreadLevel = ThreadLevel;
            currentDiscussionThreadReplyIndex = ReplyIndex;
            $("#txtRiskDiscussion").focus();
			
			//Added By Rutuja D. on 19 March 2020 For issueid = 23084
            //Commented & Added By Rutuja For Adding Space Before Replay Text
           // $("#btnSaveDiscussion").html('Reply');
            $("#btnSaveDiscussion").html(' Reply');
            //End Commented & Added By Rutuja For Adding Space Before Replay Text
            $("#btnSaveDiscussion").addClass('fa fa-reply')
            //End Added By Rutuja D. on 19 March 2020 For issueid = 23084
        }
        function saveDiscussion(RiskID) {
            var currentParentId = 0;
            var currentDiscussionLevel = "Level1";
            var currentReplyIndex = 0;
            if (currentDiscussionThreadId != 0) {
                currentParentId = currentDiscussionThreadId;
                currentDiscussionLevel = currentDiscussionThreadLevel;
                currentReplyIndex = currentDiscussionThreadReplyIndex;
            }
            var currentDiscussion = $("#txtRiskDiscussion").val();
            if (currentDiscussion == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%= MyBase.GetResourceString("A_Comment") %>', 'error', 5);
                $("#txtRiskDiscussion").focus();
                return;
            }
             //Added By Riddhesh Patil on 15-NOV-2022 
            else if (checkSpecialCharacter(currentDiscussion, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Comment should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtRiskDiscussion").focus();
                   return ;
            }
			//End of Added By Riddhesh Patil
            PMDiscussionsParameter = {
                RiskID: encodeURI(RiskID),
                ParentID: encodeURI(currentParentId),
                LoginID: encodeURI(SessionEmployeeId),
                DiscussionThread: encodeURI(currentDiscussion),
                SubmittedBy: encodeURI(UserName),
                LoginType: encodeURI(SessionLoginType),
                IsShowToCustomer: 0,
                DiscussionLevel: currentDiscussionLevel,
                ReplyIndex: currentReplyIndex
            }
            $.ajax({
                url: strUrl + '/api/PM_Risks/SaveDiscussion',
                method: 'Post',
                data: JSON.stringify(PMDiscussionsParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMDiscussionsParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMDiscussionsParameter) ? PMDiscussionsParameter : JSON.stringify(PMDiscussionsParameter)));
                    }
                },
                success: function (result) {
                    try {
                        getRiskDiscussions(currentRiskID);
                        if (currentDiscussionThreadId != 0) {
                            currentDiscussionThreadId = 0;
                        }
                    }
                    catch (ex) {
                        //alert(ex.message);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }
        function getReplyCount(DiscussionID) {
            var curReplyCount = 0;
            PMDiscussionsParameter = {
                RiskDiscussionID: encodeURI(DiscussionID)
            }
            $.ajax({
                url: strUrl + '/api/PM_Risks/GetDiscussionReplyCount',
                method: 'Post',
                data: JSON.stringify(PMDiscussionsParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMDiscussionsParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMDiscussionsParameter) ? PMDiscussionsParameter : JSON.stringify(PMDiscussionsParameter)));
                    }
                },
                success: function (result) {
                    if (result != "" || result != null) {
                        curReplyCount = result;
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
            return curReplyCount;
        }
        function getRiskDiscussions(RiskID) {
            try {
                PMDiscussionsParameter = {
                    RiskID: encodeURI(RiskID)
                }
                $.ajax({
                    url: strUrl + '/api/PM_Risks/GetRiskDiscussions',
                    method: 'Post',
                    data: JSON.stringify(PMDiscussionsParameter),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (PMDiscussionsParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(PMDiscussionsParameter) ? PMDiscussionsParameter : JSON.stringify(PMDiscussionsParameter)));
                        }
                    },
                    success: function (result) {
                        try {
                            var riskParentDiscussionsHTML = "";
                            var riskReplyDiscussionsHTML = "";
                            var riskEditDiscussionsHTML = "";
                            var resultParent = [];
                            var cntChild = 0;                            

                            var arrLevel2ParentDiscussionId = [];
                            var arrLevel2ParentReplyCount = [];
                                                        
                            var cntLevel2Parent = 0;
                            var blnLevel2Parent = false;
                            if (result.length > 0) {

                                for (var i = 0; i < result.length; i++) {
                                    var replyBody = "ReplyBody_" + result[i].RiskDiscussionID;
                                    if (result[i].ParentID == 0) {
                                        resultParent[i] = result[i];

                                        var ObjRiskDiscussionsDtls = result[i];
                                        riskParentDiscussionsHTML += "<div class='box-comment'>"; // div1

                                        var currentDiscussionId = ObjRiskDiscussionsDtls.RiskDiscussionID;
                                        var FullName = ObjRiskDiscussionsDtls.SubmittedBy;
                                        var ShortName = getShortName(FullName);
                                        var ThreadReplyCount = ObjRiskDiscussionsDtls.ReplyCount;
                                        var ReplyIndex = ThreadReplyCount + 1;
                                        var currentdt = new Date();
                                        var submitdt = new Date(ObjRiskDiscussionsDtls.SubmittedDate);
                                        var submitTime = '';

                                        submitTime = formatAMPM(submitdt);
                                        submitDate = getMonthDateYear(submitdt);

                                        var currentdt = currentdt.setHours(0, 0, 0, 0);
                                        var submitdt = submitdt.setHours(0, 0, 0, 0);

                                        var blnSubmitToday = false;
                                        if (currentdt == submitdt) {
                                            blnSubmitToday = true;
                                        }

                                        riskParentDiscussionsHTML += "<span class='usernameshort circle-bggreen float-start'>" + ShortName + "</span>";
                                        riskParentDiscussionsHTML += "<div class='comment-text'>"; // div2
                                        riskParentDiscussionsHTML += "<span class='username'>" + FullName;
                                        if (blnSubmitToday == true) {
                                            riskParentDiscussionsHTML += "<span class='text-muted'>" + submitTime + " Today</span>";
                                        }
                                        else {
                                            riskParentDiscussionsHTML += "<span class='text-muted'>" + submitTime + " On " + submitDate + "</span>";
                                        }
                                        riskParentDiscussionsHTML += "</span>";

                                        riskParentDiscussionsHTML += "<p style='word-break: break-word !important;' class='more'>" + ObjRiskDiscussionsDtls.DiscussionThread + "</p>";

                                        riskParentDiscussionsHTML += "<div class='clearfix'></div>";
                                                                                
                                        riskParentDiscussionsHTML += "<div class='replycomment'>"; // div3

                                        riskParentDiscussionsHTML += "<span class='float-start'><a href='javascript:;' onclick='setReplyDiscussion(" + currentDiscussionId + ", &quot;Level2&quot;," + ReplyIndex + ")'>Reply <i class='fas fa-reply'></i></a></span>";

                                        riskParentDiscussionsHTML += "<span class='float-start replycount'><a href='javascript:;'>" + ThreadReplyCount + " Replies </a></span>";

                                        riskParentDiscussionsHTML += "<div class='clearfix'>";
                                        riskParentDiscussionsHTML += "</div> ";

                                        for (var cntRecChild = 0; cntRecChild < ThreadReplyCount; cntRecChild++) {
                                            var indexChild = cntRecChild + 1;
                                            riskParentDiscussionsHTML += " ReplyBody_" + currentDiscussionId + "_" + indexChild;
                                        }

                                        riskParentDiscussionsHTML += "</div>"; // div3 end
                                        riskParentDiscussionsHTML += "</div>"; // div2 end
                                        riskParentDiscussionsHTML += "</div>"; // div1 end                                        
                                    } //result[i].ParentID==0 End If

                                    if (result[i].ParentID != 0) {
                                        var resultChild = result[i];

                                        if (resultChild.ReplyCount != 0) {
                                            arrLevel2ParentDiscussionId[cntLevel2Parent] = resultChild.RiskDiscussionID;
                                            arrLevel2ParentReplyCount[cntLevel2Parent] = resultChild.ReplyCount;
                                            
                                            cntLevel2Parent = cntLevel2Parent + 1;

                                            blnLevel2Parent = true;
                                        }

                                        if (resultChild.DiscussionLevel == "Level2") {
                                            cntChild = cntChild + 1;
                                        }

                                        try {
                                            for (var recParents = 0; recParents < resultParent.length; recParents++) {
                                                var curParentDiscussionId = resultParent[recParents].RiskDiscussionID;

                                                replyBody = "ReplyBody_" + curParentDiscussionId + "_" + cntChild;

                                                if (curParentDiscussionId == resultChild.ParentID && resultParent[recParents].ReplyCount != 0) {

                                                    var FullName = resultChild.SubmittedBy;
                                                    var ShortName = getShortName(FullName);

                                                    var ChildThreadReplyCount = resultChild.ReplyCount;
                                                    var ReplyIndex = ChildThreadReplyCount + 1;
                                                    var currentdt = new Date();
                                                    var submitdt = new Date(resultChild.SubmittedDate);
                                                    var submitTime = '';

                                                    submitTime = formatAMPM(submitdt);
                                                    submitDate = getMonthDateYear(submitdt);

                                                    var currentdt = currentdt.setHours(0, 0, 0, 0);
                                                    var submitdt = submitdt.setHours(0, 0, 0, 0);

                                                    var blnSubmitToday = false;
                                                    if (currentdt == submitdt) {
                                                        blnSubmitToday = true;
                                                    }

                                                    riskReplyDiscussionsHTML = "";
                                                    riskReplyDiscussionsHTML += "<div class='box-comment subbox_comment'>"; //div 1 for reply
                                                    riskReplyDiscussionsHTML += "<span class='usernameshort circle-bgblue float-start'>" + ShortName + "</span>";
                                                    riskReplyDiscussionsHTML += "<div class='comment-text'>"; //div 2 for comment-text
                                                    riskReplyDiscussionsHTML += "<span class='username'>" + FullName;
                                                    if (blnSubmitToday == true) {
                                                        riskReplyDiscussionsHTML += "<span class='text-muted'>" + submitTime + " Today " + "<b style='color:#1359a6'>" + ChildThreadReplyCount + " Replies</b>";
                                                    }
                                                    else {
                                                        riskReplyDiscussionsHTML += "<span class='text-muted'>" + submitTime + " On " + submitDate + " <b style='color:#1359a6'>" + ChildThreadReplyCount + " Replies</b>";
                                                    }
                                                    riskReplyDiscussionsHTML += "<a href='javascript:;' onclick='setReplyDiscussion(" + resultChild.RiskDiscussionID + ",&quot;Level3&quot;," + ReplyIndex + ")' class='ml-1 replilink'>Reply <i class='fas fa-reply'></i></a>";

                                                    riskReplyDiscussionsHTML += "</span>";
                                                    
                                                    riskReplyDiscussionsHTML += "</span>";

                                                    riskReplyDiscussionsHTML += "<p style='word-break: break-word !important;' class='more'>" + resultChild.DiscussionThread + "</p>";
                                                    riskReplyDiscussionsHTML += "<div class='clearfix'></div>";
                                                    riskReplyDiscussionsHTML += "</div>";//div 2 end for comment-text

                                                    if (blnLevel2Parent == true) {
                                                        for (var cntRecChildLevel2 = 0; cntRecChildLevel2 < ChildThreadReplyCount; cntRecChildLevel2++) {
                                                            var indexChildLevel2 = cntRecChildLevel2 + 1;
                                                            riskReplyDiscussionsHTML += " ReplyBody_" + resultChild.RiskDiscussionID + "_" + indexChildLevel2;                                                            
                                                        }
                                                    }

                                                    riskReplyDiscussionsHTML += "</div>"; //div 1 end for reply

                                                    riskParentDiscussionsHTML = riskParentDiscussionsHTML.replace(replyBody, riskReplyDiscussionsHTML);
                                                    $("#riskDiscussions").html(riskParentDiscussionsHTML);
                                                    if (cntChild == resultParent[recParents].ReplyCount) {
                                                        cntChild = 0;
                                                    }
                                                }


                                                if (arrLevel2ParentDiscussionId.length != 0) {
                                                    for (var recLevel2Parent = 0; recLevel2Parent < arrLevel2ParentDiscussionId.length; recLevel2Parent++) {
                                                        if (resultChild.ParentID == arrLevel2ParentDiscussionId[recLevel2Parent] && resultParent[recParents].ReplyCount != 0) {
                                                            replyBody = "ReplyBody_" + arrLevel2ParentDiscussionId[recLevel2Parent] + "_" + resultChild.ReplyIndex;
                                                            
                                                            var riskReply2ReplyDiscussionsHTML = "";
                                                            var FullName = resultChild.SubmittedBy;
                                                            var ShortName = getShortName(FullName);

                                                            var ChildThreadReplyCount = resultChild.ReplyCount;
                                                            var currentdt = new Date();
                                                            var submitdt = new Date(resultChild.SubmittedDate);
                                                            var submitTime = '';

                                                            submitTime = formatAMPM(submitdt);
                                                            submitDate = getMonthDateYear(submitdt);

                                                            var currentdt = currentdt.setHours(0, 0, 0, 0);
                                                            var submitdt = submitdt.setHours(0, 0, 0, 0);

                                                            var blnSubmitToday = false;
                                                            if (currentdt == submitdt) {
                                                                blnSubmitToday = true;
                                                            }

                                                            riskReply2ReplyDiscussionsHTML = "";
                                                            riskReply2ReplyDiscussionsHTML += "<div class='box-comment subbox_comment'>"; //div 1 for reply
                                                            riskReply2ReplyDiscussionsHTML += "<span class='usernameshort circle-bgblue float-start'>" + ShortName + "</span>";
                                                            riskReply2ReplyDiscussionsHTML += "<div class='comment-text'>"; //div 2 for comment-text
                                                            riskReply2ReplyDiscussionsHTML += "<span class='username'>" + FullName;
                                                            if (blnSubmitToday == true) {
                                                                riskReply2ReplyDiscussionsHTML += "<span class='text-muted'>" + submitTime + " Today ";
                                                            }
                                                            else {
                                                                riskReply2ReplyDiscussionsHTML += "<span class='text-muted'>" + submitTime + " On " + submitDate + " ";
                                                            }
                                                            
                                                            riskReply2ReplyDiscussionsHTML += "</span>";
                                                            riskReply2ReplyDiscussionsHTML += "</span>";
                                                            riskReply2ReplyDiscussionsHTML += "<p style='word-break: break-word !important;' class='more'>" + resultChild.DiscussionThread + "</p>";
                                                            riskReply2ReplyDiscussionsHTML += "<div class='clearfix'></div>";
                                                            riskReply2ReplyDiscussionsHTML += "</div>";//div 2 end for comment-text
                                                            riskReply2ReplyDiscussionsHTML += "</div>"; //div 1 end for reply
                                                            riskParentDiscussionsHTML = riskParentDiscussionsHTML.replace(replyBody, riskReply2ReplyDiscussionsHTML);
                                                            $("#riskDiscussions").html(riskParentDiscussionsHTML);
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                        catch (ex) {
                                            //alert(ex.message);
                                        }
                                    }//result[i].ParentID!=0 End If

                                    if (result[i].ReplyCount == 0) {
                                        $("#riskDiscussions").html(riskParentDiscussionsHTML);
                                    }
                                }
                            }
                            else {
                                $("#riskDiscussions").html(riskParentDiscussionsHTML);
                            }

                            riskEditDiscussionsHTML += '<div class="row">';                            

                            var ShortName = getShortName(UserName);
                            riskEditDiscussionsHTML += '<div class="col-sm-1"><span class="usernameshort circle-bggreen">' + ShortName + '</span></div>';
                            
                            riskEditDiscussionsHTML += '<div class="col-sm-11">';
                            riskEditDiscussionsHTML += '<div class="box-body pad">';
                            riskEditDiscussionsHTML += '<%=CommonFunctions.HTMLControls.DrawTextArea("txtRiskDiscussion", "txtRiskDiscussion", , "form-control", , "form-control", "", , , , 2000,,,,,,,, "placeholder = 'Please Enter Your Comment Here' onkeyup='limitText(this,10,1000)'", True, , , Wrap:="Soft", TabIndex:=1, EnableHTMLEncode:=True).ToString.Replace("'", "\'")%>';
                            riskEditDiscussionsHTML += '</div>';
                            riskEditDiscussionsHTML += '</div>';
                            riskEditDiscussionsHTML += '<div class="clearfix"></div>';
                            riskEditDiscussionsHTML += '</div>';
                            //Commented And Added By Usha Pandit On 11.06.2020 For adding space between reply icon and comment text (Corrected by Nilesh on 30 Jul 2020 by adding class clsWidthArrow)
                            //riskEditDiscussionsHTML += '<button type="submit" id="btnSaveDiscussion" onclick="saveDiscussion(' + RiskID + ')" name="say" value="" class="btn comentbtn btnyellow float-end"><i class="fa fa-reply"></i>Comment</button>';
                            riskEditDiscussionsHTML += '<button type="submit" id="btnSaveDiscussion" onclick="saveDiscussion(' + RiskID + ')" name="say" value="" class="btn comentbtn btnyellow float-end"><i class="fa fa-reply clsWidthArrow"></i> Comment</button>';
                            //End Of Added By Usha Pandit On 11.06.2020 For adding space between reply icon and comment text
                            riskEditDiscussionsHTML += '<div class="clearfix"></div>';

                            $("#riskEditDiscussion").html(riskEditDiscussionsHTML);
                        }
                        catch (ex) {
                            //alert(ex.message);
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    }
                });
                ShowLessMoreContent();
            }
            catch (ex) {
                //alert(ex.message);
            }
        }

        function ShowLessMoreContent() {
            var showChar = 250;
            var ellipsestext = "...";
            var moretext = "More";
            var lesstext = "Less";
            $('.more').each(function () {
                var content = $(this).html();

                if (content.length > showChar) {

                    var c = content.substr(0, showChar);
                    //Commented and added by Chetan M on 11th April 2020 for Issueid = 23206
                    //var h = content.substr(showChar - 1, content.length - showChar);
                    var h = content.substr(showChar, content.length - showChar);
                     //End of Commented and added by Chetan M on 11th April 2020 for Issueid = 23206

                    var html = c + '<span class="moreellipses">' + ellipsestext + '</span><span class="morecontent" style="word-break: normal;"><span>' + h + '</span><a href="" class="morelink" >' + moretext + '</a></span>';

                    $(this).html(html);
                }
            });

            $(".morelink").click(function () {
                if ($(this).hasClass("less")) {
                    $(this).removeClass("less");                    
                    $(this).html(moretext);
                } else {
                    $(this).addClass("less");                    
                    $(this).html("..." + lesstext);                   
                }
                $(this).parent().prev().toggle();
                $(this).prev().toggle();
                return false;
            });
        }
        function setTaskDetails(PlanId) {

            $('*[id*=Set_Task_]').each(function () {
                $(this).removeClass("clsplantask");
            });
            $("#Set_Task_" + PlanId).addClass("clsplantask");

            $('#txtCurrentStartDateDisp').datepicker({
                onSelect: function (dateText) {
                    $("#txtCurrentStartDateDisp").datepicker('option', {
                        dateFormat: 'yy-mm-dd'
                    });
                    document.getElementById("txtCurrentStartDate").value = this.value;

                    $("#txtCurrentStartDateDisp").datepicker('option', {
                        dateFormat: 'd M yy'
                    });
                },
                autoclose: true,
                changeMonth: true,
                changeYear: true, //added by pradip on 09-04-2020
                dateFormat: 'd M yy'
            });
            $('#txtCurrentStartDate').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true, //added by pradip on 09-04-2020
                dateFormat: 'yy-mm-dd'
            });

            $('#txtCurrentEndDateDisp').datepicker({
                onSelect: function (dateText) {
                    $("#txtCurrentEndDateDisp").datepicker('option', {
                        dateFormat: 'yy-mm-dd'
                    });
                    document.getElementById("txtCurrentEndDate").value = this.value;

                    $("#txtCurrentEndDateDisp").datepicker('option', {
                        dateFormat: 'd M yy'
                    });
                },
                autoclose: true,
                changeMonth: true,
                changeYear: true, //added by pradip on 09-04-2020
                dateFormat: 'd M yy'
            });
            $('#txtCurrentEndDate').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true, //added by pradip on 09-04-2020
                dateFormat: 'yy-mm-dd'
            });

            var TaskName = $("#txtRiskDetailDescription").val();
            var TaskNotes = $("#lblContingencyPlan_" + PlanId).text();
            var duration = $("#Duration_" + PlanId).text();
            var works = $("#ExpectedWork_" + PlanId).text();
            var dateofplans = $("#txtDateOfPlan_" + PlanId).text();
            var TaskType = $("#cboPMTaskType_" + PlanId + " option:selected").val();

            $('#txtCurrentStartDateDisp').datepicker("setDate", new Date(dateofplans));
            $('#txtCurrentStartDate').datepicker("setDate", new Date(dateofplans));

            var valid_days = parseInt(duration);
            var start_date = $('#txtCurrentStartDateDisp').val();

            var end_date = new Date(start_date); // pass start date here
            end_date.setDate(end_date.getDate() + valid_days);

            $('#txtCurrentEndDateDisp').datepicker("setDate", new Date(end_date));
            $('#txtCurrentEndDate').datepicker("setDate", new Date(end_date));

            if (dateofplans == "") {
                $('#txtCurrentStartDateDisp').datepicker("setDate", dateToday);
                $('#txtCurrentStartDate').datepicker("setDate", dateToday);
            }
            dateofplans = dateofplans.trim();

            $("#txtTaskName").val(TaskName);
            $("#txtTaskNotes").val(TaskNotes);

            var arrcboFieldName = ["cboEmployee"];
            FillReponsiblePersonCombo(currentselectedProjectID, arrcboFieldName, PlanId);

            $("#txtCurrentWork").val(works);

            var selHTMLTaskType = "";
            selHTMLTaskType = getProjectTaskTypes("cboTaskType", 0, "", "task");

            $("#cboTaskType").html(selHTMLTaskType);

            $("#cboTaskType > option").each(function () {

                if (this.text == TaskType) {
                    $("#cboTaskType").val(this.value);
                }
            });
            FillModuleCombox();
            FillSubProjectCombox();
            FillMilestoneCombox();
            FillChangeRequestCombox();
            FillUserStoryCombox();
            FillFeatureCombox();
        }
        function setDeleteRisk(RiskId) {
            //alert(RiskId);
            //$('*[id*=Delete_Risk_]').each(function () {
            //    $(this).removeClass("clsdeleterisk");
            //});
            $(".clsRiskDeleteRec").removeClass("clsdeleterisk");
            $("#" + RiskId).addClass("clsdeleterisk");
        }
        function setDeletePlan(PlanID) {
            $('*[id*=Delete_Plan_]').each(function () {
                $(this).removeClass("clsdeleteplan");
            });
            $("#" + PlanID).addClass("clsdeleteplan");
        }
        function setDeleteEarlyWarning(EarlyWarningID) {
            $('*[id*=Delete_EarlyWarning_]').each(function () {
                $(this).removeClass("clsdeleteEarlywarning");
            });
            $("#" + EarlyWarningID).addClass("clsdeleteEarlywarning");
        }
        function getProjectRiskId() {
            var PMParameter = {
                ProjectId: encodeURI(currentselectedProjectID)
            }
            $.ajax({
                url: strUrl + '/api/PM_Risks/GetProjectRiskId',
                method: 'Post',
                data: JSON.stringify(PMParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMParameter) ? PMParameter : JSON.stringify(PMParameter)));
                    }
                },
                success: function (result) {
                    var curProjectRiskId = result.toString();
                    $("#txtProjectRiskId").val(curProjectRiskId);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }
        function cancelDocumentDelete() {
            var tagid = $("#TagId").attr("value");
            var deleteid = $("#DeleteId").attr("value");
            var DeleteDocumentId = $("#DeleteDocumentId").attr("value");
           
            if (tagid == TagID && deleteid.length != 0) {
                $("#deletedocumentmodal").modal("hide");
                $("#TagId").removeAttr("value");
                $("#DeleteId").removeAttr("value");
            }

            if (DeleteDocumentId.length != 0) {
                $("#deletedocumentmodal").modal("hide");
                $("#DeleteDocumentId").removeAttr("value");
                getDocumentDetails();
            }
        }
        function DeleteRiskDocumentById(documentId) {
            PMDocumentParameter = {
                ProjectID: encodeURI(currentselectedProjectID),
                RiskID: parseInt(encodeURI(currentRiskID))
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Risks/DeleteRiskDocument',
                method: 'Post',
                data: JSON.stringify(encodeURI(documentId)),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (documentId) {
                        xhr.setRequestHeader("Params", encryptString(isJson(documentId) ? documentId : JSON.stringify(documentId)));
                    }
                },
                success: function (strResult) {
                    alertify.success('<%= MyBase.GetResourceString("A_DDocument") %>');
                    getDocumentDetails();
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }
        function DeleteDocument() {

            var DeleteDocumentId = $("#DeleteDocumentId").attr("value");

            if (DeleteDocumentId.length != 0) {
                DeleteRiskDocumentById(DeleteDocumentId);
                $("#DeleteDocumentId").removeAttr("value");
            }
        }
        function DeletedRiskAttachment(DocumentId) {
            $('#DeleteDocumentId').attr('value', DocumentId);
            $("#deletedocumentmodal").modal("show");
        }
        function deleteRiskDetails() {
            RiskId = $(".clsdeleterisk").attr('data-id');

            var PMParameter = {
                RiskID: encodeURI(RiskId),
                ProjectId: encodeURI(currentselectedProjectID)
            }

            $.ajax({
                url: strUrl + '/api/PM_Risks/DeleteRisk',
                method: 'Post',
                data: JSON.stringify(PMParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMParameter) ? PMParameter : JSON.stringify(PMParameter)));
                    }
                },
                success: function (result) {
                    if (result.toString().indexOf("deleted successfully") != -1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(result);
                        ClearFilterDetails("");
                        FilterNotApplied();
                        ChangeProject(1, 1);
                        currentappliedfilter = 0;
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(result);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }
        function SaveTaskDetails() {
            var curPlanID = $(".clsplantask").attr('data-id');
            var curPlanFlag = "";
            if ($(".clsplantask").hasClass("clsContingency")) {
                curPlanFlag = "Contingency";
            }
            if ($(".clsplantask").hasClass("clsMitigation")) {
                curPlanFlag = "Mitigation";
            }
        }
        function deletePlanDetails() {
            var curPlanID = $(".clsdeleteplan").attr('data-id');
            var curPlanFlag = "";
            if ($(".clsdeleteplan").hasClass("clsDelContingency")) {
                curPlanFlag = "Contingency";
            }
            if ($(".clsdeleteplan").hasClass("clsDelMitigation")) {
                curPlanFlag = "Mitigation";
            }
            var PMPlanParameter = {
                PlanID: encodeURI(curPlanID),
                Flag: curPlanFlag
            }

            $.ajax({
                url: strUrl + '/api/PM_Risks/DeletePlan',
                method: 'Post',
                data: JSON.stringify(PMPlanParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMPlanParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMPlanParameter) ? PMPlanParameter : JSON.stringify(PMPlanParameter)));
                    }
                },
                success: function (result) {                    
                    if (result.toString().indexOf("deleted successfully") != -1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(result);
                        getRiskPlanDetails();
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(result);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }

        function deleteEarlywarningDetails() {
            WarningID = $(".clsdeleteEarlywarning").attr('data-id');

            var PMEarlyWarningsParameter = {
                WarningID: encodeURI(WarningID)
            }

            $.ajax({
                url: strUrl + '/api/PM_Risks/DeleteEarlywarning',
                method: 'Post',
                data: JSON.stringify(PMEarlyWarningsParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMEarlyWarningsParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMEarlyWarningsParameter) ? PMEarlyWarningsParameter : JSON.stringify(PMEarlyWarningsParameter)));
                    }
                },
                success: function (result) {
                    if (result.toString().indexOf("deleted successfully") != -1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(result);
                        getRiskEarlyWarningsDetails();
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error(result);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }

        function checkDuplicateFilter(filtername) {
            var isFilterExists = 0;
            var Parameters = {
                FilterName: encodeURI(filtername),
                TagID: encodeURI(TagID),
                ProjectID: encodeURI(currentselectedProjectID),
                //Added By Usha Pandit On 09.11.2019 For checking resource specific filter  
                EmployeeID: encodeURI(SessionEmployeeId),
                //End Of Added By Usha Pandit On 09.11.2019 For checking resource specific filter  
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Risks/chkFilterExists',

                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {

                    if (data == 0) {
                        isFilterExists = 0;
                    }
                    else if (data == 1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('<%= MyBase.GetResourceString("A_FNameExists") %>');
                        isFilterExists = 1;
                    }
                },
                error: function (xhr, errorThrown) {                    
                    isFilterExists = 1;
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
            return isFilterExists;
        }
        var savedFilterName = "";
        function SaveFilterDetails() {
            var fltFilterName = $("#txtFilterName").val();
            //$("#btnSaveFilter").removeAttr("data-dismiss");
            $("#btnSaveFilter").removeAttr("data-bs-dismiss");
            if (fltFilterName == "") {
                alertify.set('notifier', 'position', 'top-right');
                //Commented And Added By Reshma Chavan on 8th Dec 2020 For Filter Rephrase alert
                //alertify.error('<%= MyBase.GetResourceString("A_FNameBlank") %>');
                alertify.error('Filter Name should not be blank');
                //End of Commented And Added By Reshma Chavan on 8th Dec 2020 For Filter Rephrase alert
                $("#txtFilterName").focus();
            }
            //Commnet and Added By Riddhesh Patil on 15-NOV-2022 
            else if (checkSpecialCharacter(fltFilterName, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtFilterName").focus();
                
            }
			//End of Comment Added By Riddhesh Patil
            else {
                var filterExists = 0;
                if (savedFilterName == "") {
                    filterExists = checkDuplicateFilter(fltFilterName);
                }

                if (filterExists == 0) {
                    $("#btnSaveFilter").attr("data-bs-dismiss", "modal");
                    var AllFieldsPMRisks = ["ProjectRiskID", "Description", "Notes", "RiskCategoryID", "DateIdentified", "OriginalPriority", "ChangePriority", "Probability", "Weight", "Severity", "RiskSourceId", "Status", "PersonResponsible"];
                    filterWhereClause = GenerateBasicFilterQuery("PM", AllFieldsPMRisks);
                    filterWhereClause = filterWhereClause.toString().replace(/\''/g, "'");

                    var paramFilterID = 0;
                    paramFilterID = currentFilterID;

                    if (currentFilterID != 0) {
                        if (fltFilterName != savedFilterName) {
                            paramFilterID = 0;
                        }
                    }

                    var paramFlag = 0;
                    if (paramFilterID == 0) {
                        paramFlag = 0;
                    }
                    else {
                        paramFlag = 1;
                    }

                    var Parameters = {
                        TagID: encodeURI(TagID),
                        ProjectID: encodeURI(currentselectedProjectID),
                        EmployeeID: encodeURI(SessionEmployeeId),
                        FilterName: encodeURI(fltFilterName),
                        LoginType: encodeURI(SessionLoginType),
                        CreatedBy: encodeURI(UserName),
                        WhereClause: encodeURI(filterWhereClause),
                        Flag: encodeURI(paramFlag),
                        FilterID: encodeURI(paramFilterID)
                    }

                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_Risks/SaveFilterDetails',

                        method: 'Post',
                        data: JSON.stringify(Parameters),
                        dataType: "json",
                        async: false,
                        contentType: "application/json",  /*;charset-utf=8*/
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (Parameters) {
                                xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                            }
                        },
                        success: function (data) {
                            if (data != undefined && data != "") {
                                currentFilterID = data;
                                currentappliedfilter = currentFilterID;
                            }
                            //Added By Reshma Chavan on 8th Dec 2020 for Filter alert issue
                            alertify.success('Filter applied Sucessfully');
                            //End of Added By Reshma Chavan on 8th Dec 2020 for Filter alert issue
                            getRiskDetails(currentselectedProjectID, 0, "", "saveapply", "");

                            FilterApplied();
                            getMyFilters(0);
                            savedFilterName = fltFilterName;
                            clearTooltip();
                            $("#presetfilter").removeClass('active')
                            $("#presetfilter").removeClass('show')
                            $("#Risksavefilter").modal('hide');
                            //debugger;
                            if ($("#tabpresetfilter a").hasClass("active"))
                            {
                                $("#tabpresetfilter a").removeClass("active");
                            }
                        },
                        error: function (xhr, errorThrown) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                        },
                    });
                }
            }
        }

        function ValidateRiskPlanDetails(PlanID) {
            try {
                var checkFlag = 0;
                var strmsg = "";
                var curResponseType = '';
                curResponseType = $("#cboRiskPlanType_" + PlanID + " option:selected").val();

                var strRiskPlan = $("#txtRiskPlan" + PlanID).val();
                
                var strResponsiblePerson = $("#cboPMResponsiblePerson_" + PlanID + " option:selected").val();
                var strTaskType = $("#cboPMTaskType_" + PlanID + " option:selected").val();
                var strDateOfPlan = $("#txtDateOfPlan" + PlanID).val();
                var strDateOfPlanDisp = $("#txtDateOfPlanDisp" + PlanID).val();
                if (strDateOfPlanDisp == "") {
                    strDateOfPlan = "";
                }
                var strDuration = $("#txtDuration" + PlanID).val();
                var strWorkHrs = $("#txtWorkHrs" + PlanID).val();
                
                //alert(strRiskPlan + "," + strResponsiblePerson + "," + strTaskType + "," + strDateOfPlan + "," + strDuration + "," + strWorkHrs + ",");
               //Added By Riddhesh Patil on 15-NOV-2022 
                if (checkSpecialCharacter(strRiskPlan, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Plan should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtRiskPlan" + PlanID).focus();
                    checkFlag = 1;
                    return checkFlag;
                }
			//End of Added By Riddhesh Patil
                if (curResponseType == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('<%= MyBase.GetResourceString("A_SPlan") %>', 'error', 5);
                    checkFlag = 1;
                    $("#cboRiskPlanType_" + PlanID).focus();
                    return checkFlag;
                }

                if (strRiskPlan == "" && curResponseType == "Contingency Plan") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('<%= MyBase.GetResourceString("A_ContingencyPlan") %>', 'error', 5);
                    checkFlag = 1;
                    $("#txtRiskPlan" + PlanID).focus();
                    return checkFlag;
                }

                if (strRiskPlan == "" && curResponseType == "Mitigation Plan") {
                    alertify.set('notifier', 'position', 'top-right');
                   //Commented and Added by Chetan M on 24th Jully 2020 for IssueID = 24536
                    <%--alertify.notify('<%= MyBase.GetResourceString("A_Action") %>', 'error', 5);--%>
                    alertify.notify('Plan should not be left blank.', 'error', 5);
                    //End of Commented and Added by Chetan M on 24th Jully 2020 for IssueID = 24536
                    checkFlag = 1;
                    $("#txtRiskPlan" + PlanID).focus();
                    return checkFlag;
                }
                if ((strResponsiblePerson == "" || strResponsiblePerson == "0") && curResponseType == "Contingency Plan") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('<%= MyBase.GetResourceString("A_Responsibility") %>', 'error', 5);
                    checkFlag = 1;
                    $("#cboPMResponsiblePerson_" + PlanID).focus();
                    return checkFlag;
                }
                if ((strTaskType == "" || strTaskType == "0")) { //&& curResponseType == "Contingency Plan"
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('<%= MyBase.GetResourceString("A_TaskType") %>', 'error', 5);
                    checkFlag = 1;
                    $("#cboPMTaskType_" + PlanID).focus();
                    return checkFlag;
                }

                if (strDateOfPlan != "") {
                    //alert(ValidateDateOfPlan(PlanID));
                    if (ValidateDateOfPlan(PlanID, "PlanDate") == 0) {
                        checkFlag = 0;
                    }
                    else {
                        checkFlag = 1;
                        //$("#txtDateOfPlanDisp" + PlanID).focus();
                        return checkFlag;
                    }
                }
                // debugger
                if (strDuration == "") { //&& curResponseType == "Contingency Plan"
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('<%= MyBase.GetResourceString("A_Duration") %>', 'error', 5);
                    checkFlag = 1;
                    $("#txtDuration" + PlanID).focus();
                    return checkFlag;
                }


                //Added By Dipali V On 8th May 2020 For Issue ID-24221
                //Commented And Added By Usha Pandit On 12.05.2021 For 0 duration validation
                //if (strDuration == "0") { //&& curResponseType == "Contingency Plan"
                if (strDuration == "0" || strDuration <= 0) {
                    //End Of Added By Usha Pandit On 12.05.2021 For 0 duration validation
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Duration should be greater than 0', 'error', 5);
                    checkFlag = 1;
                    $("#txtDuration" + PlanID).focus();
                    return checkFlag;
                }
                //End of Added By Dipali V On 8th May 2020 For Issue ID-24221

                if (strWorkHrs == "") { //&& curResponseType == "Contingency Plan"
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('<%= MyBase.GetResourceString("A_Work") %>', 'error', 5);
                    checkFlag = 1;
                    $("#txtWorkHrs" + PlanID).focus();
                  return checkFlag;
                }

                if (strWorkHrs != "") {//&& curResponseType == "Contingency Plan"
                    if (ValidateWorkHourFormat(PlanID) == 0) {
                        checkFlag = 0;
                         
                    }
                    else {
                        checkFlag = 1;
                        $("#txtWorkHrs" + PlanID).focus();
                        return checkFlag;
                    }
                }
               
                return checkFlag;
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        function ValidateDateOfPlan(PlanID, Flag) {
            var checkFlag = 0;
            var strDate = "";
            var ControlID = "";
            if (Flag == "PlanDate") {
                strDate = $("#txtDateOfPlan" + PlanID).val();
                //Added by dipali v on 24th dec 2020 for focus control
                ControlID = $("#txtDateOfPlan" + PlanID);
            }
            if (Flag == "IdentifiedDate") {
                strDate = $("#txtRiskDetailDateIdentified").val();
                 //Added by dipali v on 24th dec 2020 for focus control
                ControlID = $("#txtRiskDetailDateIdentified");
            }
            if (Flag == "ReviewDate") {
                strDate = $("#txtRiskDetailReviewNotificationDate").val();
                 //Added by dipali v on 24th dec 2020 for focus control
                ControlID = $("#txtRiskDetailReviewNotificationDate");
            }
            PMPlanParameter = {
                ProjectID: encodeURI(currentselectedProjectID),
                DateOfPlan: encodeURI(strDate)
            }
            strApiFunction = "/api/PM_Risks/ValidateDateOfPlan";

            $.ajax({
                url: encodeURI(strUrl) + strApiFunction,

                method: 'Post',
                data: JSON.stringify(PMPlanParameter),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMPlanParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMPlanParameter) ? PMPlanParameter : JSON.stringify(PMPlanParameter)));
                    }
                },
                success: function (data) {
                    if (data != undefined && data != "") {
                        //alert(data);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(data, 'error', 5);
                        checkFlag = 1;
                         //Added by dipali v on 24th dec 2020 for focus control
                        ControlID.focus();
                         //End of Added by dipali v on 24th dec 2020 for focus control
                        return checkFlag;
                    }
                    else {
                        //alert(33);
                        checkFlag = 0;
                        return checkFlag;
                    }
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
            //alert("checkFlag 11 " + checkFlag);
            return checkFlag;
        }
        function ValidateWorkHourFormat(PlanID) {
            var checkFlag = 0;
            try {
                var blnHMFormat = true;

                var objHMEffort = document.getElementById("txtWorkHrs" + PlanID);
                var objVal = objHMEffort.value;
                var objnewVal = objHMEffort.value;

                objHMEffort.value = objHMEffort.value.replace(":", ".");
                var isdigit = isNumeric(objHMEffort.value);
                objHMEffort.value = objVal;

                if (isdigit == false) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Please Enter only positive numeric value For Work(Hrs) in H:M format.', 'error', 5);
                    checkFlag = 1;
                    return checkFlag;
                }
                if (objHMEffort.value.indexOf(":") == -1) {
                    objHMEffort.value = objnewVal + ':00';
                    objnewVal = objHMEffort.value;
                }

                if (objHMEffort.value.indexOf(":") != -1) {
                    objHMEffort.value = objHMEffort.value.replace(':', '.');
                }

                var tempEffort = objHMEffort.value.replace('-', '');
                if (checkSpecialCharacter(tempEffort) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Work(Hrs) cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters', 'error', 5);

                    objHMEffort.value = objVal;
                    checkFlag = 1;
                    return checkFlag;
                }

                if (blnHMFormat == true) {
                    if (RestrictNonNumeric(objHMEffort) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Please enter Work(Hrs) in H:M format.', 'error', 5);

                        objHMEffort.value = objVal;
                        blnHMFormat = false;
                        checkFlag = 1;
                        return checkFlag;
                    }
                }

                objHMEffort.value = objHMEffort.value.replace('.', ':');

                var WorkHour = objHMEffort.value;

                WorkHour = WorkHour.trim();
                var idxColon = WorkHour.indexOf(':');

                var hrs = WorkHour.substring(0, idxColon);

                var mins = WorkHour.substring(idxColon + 1, WorkHour.length);

                if (mins.length == 1 && mins > 5) {
                    mins = mins + "0";
                }
                if (blnHMFormat == true) {
                    if (mins == "") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Please enter Work(Hrs) in H:M format.', 'error', 5);

                        blnHMFormat = false;
                        checkFlag = 1;
                        return checkFlag;
                    }

                    if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Hours should not be less than or equal to zero (0).', 'error', 5);

                        blnHMFormat = false;
                        checkFlag = 1;
                        return checkFlag;
                    }

                    if (blnHMFormat == true) {
                        if (mins.length > 2) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('Please enter minutes in two decimal and less than 60.', 'error', 5);

                            blnHMFormat = false;
                            checkFlag = 1;
                            return checkFlag;
                        }
                    }

                    if (blnHMFormat == true) {
                        if (mins > 59 || mins < 0) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('Please enter minutes between (0-59) range', 'error', 5);

                            blnHMFormat = false;
                            checkFlag = 1;
                            return checkFlag;
                        }
                    }
                }

                var MinDAENtryDisplay = "";
                var MinDAEntry = "";
                var RestrictByMinHours = "";
                $.ajax({
                    url: strUrl + '/api/PM_Risks/GetCompayInformation',

                    method: 'Post',
                    data: JSON.stringify({}),
                    dataType: "json",
                    async: false,
                    contentType: "application/json",  /*;charset-utf=8*/
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    },
                    success: function (data) {

                        if (data.length != 0) {

                            for (var i = 0; i < data.length; i++) {

                                var ObjCompInfo = data[i];
                                MinDAEntry = ObjCompInfo.MinHoursForDAEntry;
                                RestrictByMinHours = ObjCompInfo.RestrictByMinHours;


                                if (MinDAEntry == 0.25) {
                                    MinDAEntry = MinDAEntry
                                    MinDAENtryDisplay = "00:15"
                                }
                                else if (MinDAEntry == 0.50) {
                                    MinDAEntry = MinDAEntry
                                    MinDAENtryDisplay = "00:30"
                                }
                                else if (MinDAEntry == 0.75) {
                                    MinDAEntry = MinDAEntry
                                    MinDAENtryDisplay = "00:45"
                                }

                                if (RestrictByMinHours == 1) {
                                    if (MinDAEntry == 0.016) {
                                    }
                                    else {
                                        var minutes = WorkHour.split(':');

                                        var p = minutes[0];
                                        var dec = minutes[1];

                                        if (dec != undefined) {
                                            if (dec.length > 2) {
                                                dec = dec.substring(0, 2);
                                            }
                                            if (dec.length == 1) {
                                                dec = dec + "0";
                                            }

                                            if (dec == undefined) { dec = 0; }
                                            d = (dec - 0) / 60 + (p - 0);

                                            if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                                                if (blnHMFormat == true) {
                                                    alertify.set('notifier', 'position', 'top-right');
                                                    alertify.notify('Please enter the work Hours in multiple of (' + MinDAENtryDisplay + ') min', 'error', 5);
                                                    checkFlag = 1;
                                                }
                                            }
                                        }
                                    }
                                }
                                if (checkFlag == 1) {
                                    objHMEffort.value = objVal;
                                }
                                else {

                                    if (objHMEffort.value.toString().indexOf(":") != -1) {
                                        var chkhr = objHMEffort.value.split(":")[0];
                                        var chkmin = objHMEffort.value.split(":")[1];
                                        if (chkhr.length == 1) {
                                            chkhr = "0" + chkhr;
                                            objHMEffort.value = chkhr + ":" + chkmin;
                                        }

                                        if (chkmin.length == 1) {
                                            chkmin = chkmin + "0";
                                            objHMEffort.value = chkhr + ":" + chkmin;
                                        }
                                    }
                                }
                            }
                        }
                    },
                    error: function (xhr, errorThrown) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    },
                });
                return checkFlag;
            }
            catch (ex) {
                return 1;
                //alert(ex.message);
            }

        }
        //Added By Riddhesh Patil on 15-NOV-2022 
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

        function ValidateRiskDetails() {
            var checkFlag = 0;
            //var strmsg = "";

            var strRiskDetailDescription = $("#txtRiskDetailDescription").val();
            var strRiskDetailNotes = $("#txtRiskDetailNotes").val();

            var strRiskDetailRiskCategoryID = $("#cboRiskDetailRiskCategoryID option:selected").val();
            var strDateIdentified = $("#txtRiskDetailDateIdentified").val();
            var strDateIdentifiedDisp = $("#txtRiskDetailDateIdentifiedDisp").val();

            var strRiskDetailProbability = $("#cboRiskDetailProbability option:selected").val();
            var strRiskDetailImpact = $("#cboRiskDetailImpact option:selected").val();

            var strRiskDetailStatus = $("#cboRiskDetailStatus option:selected").val();

            var strReviewNotificationDate = $("#txtRiskDetailReviewNotificationDateDisp").val();
            var strReviewNotificationDateHid = $("#txtRiskDetailReviewNotificationDate").val();
            var intRiskDetailPersonReviewer = $("#cboRiskDetailReviewer option:selected").val();

            if (strDateIdentified == "") {                
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%= MyBase.GetResourceString("A_IdentificationDate") %>', 'error', 5);
                checkFlag = 1;
                $("#txtRiskDetailDateIdentified").focus();
                return checkFlag;
            }
            if (strDateIdentified != "") {
                checkFlag = ValidateDateOfPlan(0, "IdentifiedDate");
               
                if (checkFlag == 1) {
                    return checkFlag;
                }
            }
            if (strRiskDetailDescription == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%= MyBase.GetResourceString("A_Description") %>', 'error', 5);
                checkFlag = 1;
                $("#txtRiskDetailDescription").focus();
                return checkFlag;
            }
            //Added By Riddhesh Patil on 15-NOV-2022 
            if (checkSpecialCharacter(strRiskDetailDescription, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtRiskDetailDescription").focus();
                checkFlag = 1;
                return checkFlag;
            }
			//End of Added By Riddhesh Patil
            if (strRiskDetailNotes == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%= MyBase.GetResourceString("A_ImpactDescription") %>', 'error', 5);
                checkFlag = 1;
                $("#txtRiskDetailNotes").focus();
                return checkFlag;
            }
            //Added By Riddhesh Patil on 15-NOV-2022 
            if (checkSpecialCharacter(strRiskDetailNotes, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Impact Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtRiskDetailNotes").focus();
                checkFlag = 1;
                return checkFlag;
            }
			//End of Added By Riddhesh Patil

            if (strRiskDetailRiskCategoryID == "" || strRiskDetailRiskCategoryID == 0) {
                alertify.set('notifier', 'position', 'top-right');
                 <%--alertify.notify('<%= MyBase.GetResourceString("A_RiskCategory") %>', 'error', 5);--%>
                alertify.notify('Risk Category should not be left blank', 'error', 5);
                checkFlag = 1;
                $("#cboRiskDetailRiskCategoryID").focus();
                return checkFlag;
            }
            if (strRiskDetailStatus == "" || strRiskDetailStatus == "Select Status" || strRiskDetailStatus == "0") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%= MyBase.GetResourceString("A_Status") %>', 'error', 5);
                checkFlag = 1;
                $("#cboRiskDetailStatus").focus();
                return checkFlag;
            }
            if (strRiskDetailProbability == "" || strRiskDetailProbability == "0") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%= MyBase.GetResourceString("A_Probability") %>', 'error', 5);
                checkFlag = 1;
                $("#cboRiskDetailProbability").focus();
                return checkFlag;
            }
            if (strRiskDetailImpact == "" || strRiskDetailImpact == "0") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%= MyBase.GetResourceString("A_Impact") %>', 'error', 5);
                checkFlag = 1;
                $("#cboRiskDetailImpact").focus();
                return checkFlag;
            }
            if (strReviewNotificationDate != "") {                
                checkFlag = ValidateDateOfPlan(0, "ReviewDate");
                //if (ValidateDateOfPlan(0, "ReviewDate") == 0) {
                //    checkFlag = 0;
                //}
                
                if (checkFlag == 1) {
                    return checkFlag;
                }
                if (intRiskDetailPersonReviewer == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('<%= MyBase.GetResourceString("A_Reviewer") %>', 'error', 5);
                    checkFlag = 1;
                    $("#cboRiskDetailReviewer").focus();
                    return checkFlag;
                }
            }

            return checkFlag;
        }
        function ValidateEarlyWarningDetails(EarlyWarningID) {
            var checkFlag = 0;
            var strmsg = "";

            var strEarlyWarning = $("#txtEarlyWarning" + EarlyWarningID).val();

            var strWarningStatus = $("#cboWarningStatus" + EarlyWarningID + " option:selected").val();

            if (strEarlyWarning == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%= MyBase.GetResourceString("A_Warning") %>', 'error', 5);
                checkFlag = 1;
                $("#txtEarlyWarning" + EarlyWarningID).focus();
                return checkFlag;
            }
            //Added By Riddhesh Patil on 15-NOV-2022 
            if (checkSpecialCharacter(strEarlyWarning, WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Warning should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtEarlyWarning" + EarlyWarningID).focus();
                checkFlag = 1;
                return checkFlag;
            }
			//End of Added By Riddhesh Patil
            if (strWarningStatus == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('<%= MyBase.GetResourceString("A_WarningStatus") %>', 'error', 5);
                checkFlag = 1;
                $("#cboWarningStatus" + EarlyWarningID).focus();
                return checkFlag;
            }

            return checkFlag;
        }
        function SaveEarlyWarningDetails(EarlyWarningID) {
            if (ValidateEarlyWarningDetails(EarlyWarningID) == 0) {
                var strEarlyWarning = $("#txtEarlyWarning" + EarlyWarningID).val();

                var strWarningStatus = $("#cboWarningStatus" + EarlyWarningID + " option:selected").val();

                var currEarlyWarningFlag = 0;
                if ($("#chkEarlyWarningFlag" + EarlyWarningID).is(':checked')) {
                    currEarlyWarningFlag = 1;
                }
                PMEarlyWarningsParameter = {
                    RiskID: encodeURI(currentRiskID),
                    ProjectID: encodeURI(currentselectedProjectID),
                    Warning: encodeURI(strEarlyWarning),
                    WarningStatus: encodeURI(strWarningStatus),
                    EarlyWarningFlag: encodeURI(currEarlyWarningFlag),
                    UserName: encodeURI(UserName),
                    WarningID: EarlyWarningID
                }
                strApiFunction = "/api/PM_Risks/SaveRiskEarlyWarningsDetails";
                $.ajax({
                    url: encodeURI(strUrl) + strApiFunction,

                    method: 'Post',
                    data: JSON.stringify(PMEarlyWarningsParameter),
                    dataType: "json",
                    async: false,
                    contentType: "application/json",  /*;charset-utf=8*/
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (PMEarlyWarningsParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(PMEarlyWarningsParameter) ? PMEarlyWarningsParameter : JSON.stringify(PMEarlyWarningsParameter)));
                        }
                    },
                    success: function (data) {
                        if (data != undefined && data != "") {

                            currentEarlyWarningID = data;
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.success('<%= MyBase.GetResourceString("A_EarlyWarning") %>');

                            $('#btnEarlyWarning').prop('disabled', false);
                            $('.editearlywarning').prop('disabled', false);
                        }
                        getRiskEarlyWarningsDetails();
                    },
                    error: function (xhr, errorThrown) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    },
                });
            }
        }
        //Added By Usha Pandit On 24.12.2020 For validation alert field blank issue
        var editImg = '../../../Whizible2.0-new/dist/img/edit.svg';
        var saveImg = '../../../Whizible2.0-new/dist/img/save.svg';
        //End Of Added By Usha Pandit On 24.12.2020 For validation alert field blank issue
        function SavePlanDetails(PlanID) {
            try {
                if (ValidateRiskPlanDetails(PlanID) == 0) {
                    var strRiskPlan = $("#txtRiskPlan" + PlanID).val();
                    var strResponsiblePerson = $("#cboPMResponsiblePerson_" + PlanID + " option:selected").val();
                    var strTaskType = $("#cboPMTaskType_" + PlanID + " option:selected").val();
                    var curResponseType = $("#cboRiskPlanType_" + PlanID + " option:selected").val();

                    var strDateOfPlan = $("#txtDateOfPlan" + PlanID).val();
                    if ($("#txtDateOfPlanDisp" + PlanID).val() == "") {
                        strDateOfPlan = "";
                    }
                    var strDuration = $("#txtDuration" + PlanID).val();
                    var strWorkHrs = $("#txtWorkHrs" + PlanID).val();
                    var PMPlanParameter = "";
                    var strApiFunction = "";
                    if (strResponsiblePerson == "0" || strResponsiblePerson == undefined) {
                        strResponsiblePerson = "";
                    }

                    if (curResponseType == "Contingency Plan") {

                        PMPlanParameter = {
                            RiskID: encodeURI(currentRiskID),
                            ProjectID: encodeURI(currentselectedProjectID),
                            ContingencyPlan: encodeURI(strRiskPlan),
                            Responsibility: encodeURI(strResponsiblePerson),
                            TaskType: encodeURI(strTaskType),
                            DateOfPlan: encodeURI(strDateOfPlan),
                            ExpectedDuration: encodeURI(strDuration),
                            ExpectedWork: encodeURI(strWorkHrs),
                            UserName: encodeURI(UserName),
                            ContingencyPlanID: encodeURI(PlanID)
                        }
                        strApiFunction = "/api/PM_Risks/SavePlanDetails";
                    }
                    if (curResponseType == "Mitigation Plan") {

                        PMPlanParameter = {
                            RiskID: encodeURI(currentRiskID),
                            ProjectID: encodeURI(currentselectedProjectID),
                            Action: encodeURI(strRiskPlan),
                            Responsibility: encodeURI(strResponsiblePerson),
                            TaskType: encodeURI(strTaskType),
                            DateOfPlan: encodeURI(strDateOfPlan),
                            ExpectedDuration: encodeURI(strDuration),
                            ExpectedWork: encodeURI(strWorkHrs),
                            UserName: encodeURI(UserName),
                            MitigationPlanID: encodeURI(PlanID)
                        }
                        strApiFunction = "/api/PM_Risks/SaveMitigationPlanDetails";
                    }
                    $.ajax({
                        url: encodeURI(strUrl) + strApiFunction,

                        method: 'Post',
                        data: JSON.stringify(PMPlanParameter),
                        dataType: "json",
                        async: false,
                        contentType: "application/json",  /*;charset-utf=8*/
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (PMPlanParameter) {
                                xhr.setRequestHeader("Params", encryptString(isJson(PMPlanParameter) ? PMPlanParameter : JSON.stringify(PMPlanParameter)));
                            }
                        },
                        success: function (data) {
                            if (data != undefined && data != "") {
                                if (curResponseType == "Contingency Plan") {
                                    currentContingencyPlanID = data;
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.success('<%= MyBase.GetResourceString("A_CPlan") %>');
                                    getRiskDetails(currentselectedProjectID, 0, "", "riskdetails", "");
                                }
                                if (curResponseType == "Mitigation Plan") {
                                    currentMitigationPlanID = data;
                                    alertify.set('notifier', 'position', 'top-right');
                                    alertify.success('<%= MyBase.GetResourceString("A_MPlan") %>');
                                }

                                $('#btnAddPlan').prop('disabled', false);
                                $('.editriskplan').prop('disabled', false);

                                //getProjectRiskImpactStatus();
                                //ClearRiskDetails();
                            }
                            getRiskPlanDetails();
                        },
                        error: function (xhr, errorThrown) {
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                        },

                    });
                } else {
                    //Commented By Usha Pandit On 01.07.2020 for not refreshing plan details if validation errors are there
                    //getRiskPlanDetails();                    
                    //End Of Commented By Usha Pandit On 01.07.2020 for not refreshing plan details if validation errors are there
                }
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        
        function CreateContingencyTask() {
            blnCreateContingencyTask = true;
            SaveRiskDetails();
        }
        function SaveContingencyTask() {
            var PMPlanParameter = {
                RiskID: encodeURI(currentRiskID),
                ProjectID: encodeURI(currentselectedProjectID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Risks/SaveContingencyPlanTaskDetails',

                method: 'Post',
                data: JSON.stringify(PMPlanParameter),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMPlanParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMPlanParameter) ? PMPlanParameter : JSON.stringify(PMPlanParameter)));
                    }
                },
                success: function (data) {
                    if (data != undefined && data != "") {
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.success('Task created successfully');                       
                    }
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
        }
        function textAbstract(el, maxlength) {
            try {
                maxlength = maxlength = 70;
                let txt = $(el).text();
                if (el == null) {
                    return "";
                }
                if (txt.length <= maxlength) {
                    return txt;
                }
                let t = txt.substring(0, maxlength);
                let re = /\s+\S*$/;
                let m = re.exec(t);
                if (m != null) {
                    t = t.substring(0, m.index);                    
                    return t + "...";
                }
                else {  
                    $(el).parent().css("word-break", "break-all");
                    return t + "...";
                }
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        function SetRiskSaveDetails() {
            $("#btnSaveRisk").removeAttr("data-bs-target");
            if (ValidateRiskDetails() == 0) {
                var strRiskDetailStatus = $("#cboRiskDetailStatus option:selected").text();
                
                if (strRiskDetailStatus == "Occurred" && flagTaskAssigned == 1) {                    
                    $("#btnSaveRisk").attr("data-bs-target", "#SaveContingencyTask");
                }
                else {
                    SaveRiskDetails();
                }
            }
        }

        function SaveRiskDetails() {

            var curRiskId = 0;
            if (currentRiskID == 0) {
                curRiskId = 0;
            }
            else {
                curRiskId = currentRiskID;
            }
            if (curRiskId != 0) {

            }
            var intProjectRiskId = $("#txtProjectRiskId").val();
            var strDateIdentified = $("#txtRiskDetailDateIdentified").val();
            var strRiskDetailDescription = $("#txtRiskDetailDescription").val();
            var strRiskDetailNotes = $("#txtRiskDetailNotes").val();
            var strRiskDetailRiskCategoryID = $("#cboRiskDetailRiskCategoryID option:selected").val();
            var strRiskDetailOriginalPriority = $("#cboRiskDetailOriginalPriority option:selected").text();
            var strRiskDetailChangePriority = $("#cboRiskDetailChangePriority option:selected").text();

            var strRiskDetailMagnitude = $("#txtRiskDetailMagnitude").val();
            var strRiskDetailProbability = $("#cboRiskDetailProbability option:selected").val();
            var strRiskDetailImpact = $("#cboRiskDetailImpact option:selected").val();

            var strRiskDetailRiskSourceId = $("#cboRiskDetailRiskSourceId option:selected").val();
            var strRiskDetailStatus = $("#cboRiskDetailStatus option:selected").text();

            var strRiskDetailPersonResponsible = $("#cboRiskDetailPersonResponsible option:selected").text();
            var intRiskDetailPersonResponsibleId = $("#cboRiskDetailPersonResponsible option:selected").val();

            var strRiskDetailPersonReviewer = $("#cboRiskDetailReviewer option:selected").text();
            var intRiskDetailPersonReviewer = $("#cboRiskDetailReviewer option:selected").val();
            var strReviewNotificationDateDisp = $("#txtRiskDetailReviewNotificationDateDisp").val();
            var strReviewNotificationDate = $("#txtRiskDetailReviewNotificationDate").val();
            if (strReviewNotificationDateDisp == "") {
                strReviewNotificationDate = "";
            }
            if (intRiskDetailPersonResponsibleId == 0) {
                strRiskDetailPersonResponsible = "";
            }
            if ($("#cboRiskDetailOriginalPriority option:selected").val() == 0) {
                strRiskDetailOriginalPriority = "";
            }
            if ($("#cboRiskDetailChangePriority option:selected").val() == 0) {
                strRiskDetailChangePriority = "";
            }

            //var ReviewFlag = 0;
            //if ($("#chkReviewFlag").is(':checked')) {
            //    ReviewFlag = 1;
            //}
            
            if (ValidateRiskDetails() == 0) {

                if (strRiskDetailRiskSourceId == "") {
                    strRiskDetailRiskSourceId = 0;
                }

                var Parameters = {
                    ProjectRiskID: encodeURI(intProjectRiskId),
                    Description: encodeURI(strRiskDetailDescription),
                    Notes: encodeURI(strRiskDetailNotes),
                    RiskCategoryID: encodeURI(strRiskDetailRiskCategoryID),
                    DateIdentified: encodeURI(strDateIdentified),
                    OriginalPriority: encodeURI(strRiskDetailOriginalPriority),
                    ChangePriority: encodeURI(strRiskDetailChangePriority),
                    Probability: encodeURI(strRiskDetailProbability),
                    Weight: encodeURI(strRiskDetailImpact),
                    Severity: encodeURI(strRiskDetailMagnitude),
                    //Commented and Modified By RehanC for parameter mismatch issue on 6th April 2023
                    //RiskSourceId: encodeURI(strRiskDetailRiskSourceId,
                    RiskSourceId: parseInt(strRiskDetailRiskSourceId),
                    //End of Modification By RehanC on 6th April 2023
                    Status: encodeURI(strRiskDetailStatus),
                    PersonResponsible: encodeURI(strRiskDetailPersonResponsible),
                    PersonResponsibleId: encodeURI(intRiskDetailPersonResponsibleId),
                    ReviewerId: encodeURI(intRiskDetailPersonReviewer),
                    ReviewNotificationDate: encodeURI(strReviewNotificationDate),
                    ProjectID: encodeURI(currentselectedProjectID),
                    UserName: encodeURI(UserName),
                    RiskID: encodeURI(curRiskId)
                }

                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_Risks/SaveRiskDetails',

                    method: 'Post',
                    data: JSON.stringify(Parameters),
                    dataType: "json",
                    async: false,
                    contentType: "application/json",  /*;charset-utf=8*/
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (Parameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                        }
                    },
                    success: function (data) {
                        if (data != undefined && data != "") {
                            currentRiskID = data;
                            //Added by Chetan M on 19 Feb 2021 for Risk History refresh issue.
                            currentHistoryRiskID = data;
                            //End of Added by Chetan M on 19 Feb 2021 for Risk History refresh issue.
                              //Added By Dipali V On 29th April 2020 For Alert dismiss on IE
                                setTimeout(function () {
                                    alertify.set('notifier', 'position', 'top-right');
                                     alertify.success('<%= MyBase.GetResourceString("A_SRisk") %>');
                                    //End Of Added By Usha Pandit On 21.04.2020 to prevent alert disappearing soon
                                }, 350);
                                 //End of Added By Dipali V On 29th April 2020 For Alert dismiss on IE



                            if (blnCreateContingencyTask == true) {
                                SaveContingencyTask();
                            }
                            blnCreateContingencyTask = false;
                            getProjectRiskImpactStatus();
                            getRiskDetails(currentselectedProjectID, 0, "", "riskdetails", "");
                            $(".clsEditMode").removeClass("clsShowHide");
                            $('#btnAddPlan').prop('disabled', false);
                            $('#btnEarlyWarning').prop('disabled', false);
                            //ClearRiskDetails();
                        }
                        if (currentappliedfilterclause != "") {
                            getRiskDetails(currentselectedProjectID, 0, "", "defaultfilterapply", currentappliedfilterclause);
                        }
                        else {
                            getRiskDetails(currentselectedProjectID, 0, "", "", "");
                        }
                        //FilterApplied();
                        //savedFilterName = fltFilterName;
                    },
                    error: function (xhr, errorThrown) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    },
                });
            }
        }
        var specialKeys = new Array();
        specialKeys.push(8); //Backspace
        function Field_OnKeyPress(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
            {
                if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {

                }
            }
            return ret;
        }
        function Date_OnKeyPress(e) {
            var keyCode = e.which ? e.which : e.keyCode

            var flag = 0;
            var ret = (e.keyCode == 8 || e.keyCode == 46)
            {
                if (e.keyCode == 8 || e.keyCode == 46) {

                }
            }
            return ret;
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
        function RestrictNonNumeric(obj) {
            if (obj == null) { return false; }
            if (isBlank(getInputValue(obj))) { return false; }

            var dofocus = (arguments.length > 1) ? arguments[1] : true;
            if (!isNumeric(getInputValue(obj))) {
                if (dofocus) {
                    setFocus(obj);
                }
                return true;
            }
            return false;
        }
        function cancelsaveapply() {
            if (savedFilterName == "") {
                $("#txtFilterName").val("");
            }
        }
        function ClearRiskDetails() {
            if ($("#txtProjectRiskId").val() == "") {
                $("#txtProjectRiskId").val("");
            }
            if ($("#txtRiskDetailDateIdentifiedDisp").val()) {
                $('#txtRiskDetailDateIdentifiedDisp').val("");
            }
            if ($("#txtRiskDetailDateIdentified").val()) {
                $('#txtRiskDetailDateIdentified').val("");
            }
            if ($("#txtRiskDetailReviewNotificationDateDisp").val()) {
                $('#txtRiskDetailReviewNotificationDateDisp').val("");
            }
            if ($("#txtRiskDetailReviewNotificationDate").val()) {
                $('#txtRiskDetailReviewNotificationDate').val("");
            }
            if ($("#txtRiskDetailDescription").val()) {
                $("#txtRiskDetailDescription").val("");
            }
            if ($("#txtRiskDetailNotes").val()) {
                $("#txtRiskDetailNotes").val("");
            }
            if ($("#txtRiskDetailMagnitude").val()) {
                $("#txtRiskDetailMagnitude").val("");
            }
            if ($(".clsRiskCombo").val() != "") {
                setFilterComboValue("clsRiskCombo", 0, "class");
            }
            if ($("#cboRiskDetailRiskCategoryID").val() != 0) {
                setFilterComboValue("cboRiskDetailRiskCategoryID", 0);
            }
            if ($("#cboRiskDetailProbability").val() != 0) {
                setFilterComboValue("cboRiskDetailProbability", 0);
            }
            if ($("#cboRiskDetailImpact").val() != 0) {
                setFilterComboValue("cboRiskDetailImpact", 0);
            }
            //if ($("#cboRiskDetailOriginalPriority").val() != "") {
            //    setFilterComboValue("cboRiskDetailOriginalPriority", "");
            //}
            //if ($("#cboRiskDetailChangePriority").val() != "") {
            //    setFilterComboValue("cboRiskDetailChangePriority", "");
            //}
            //if ($("#cboRiskDetailRiskSourceId").val() != "") {
            //    setFilterComboValue("cboRiskDetailRiskSourceId", "");
            //}
            //Commented and Modified By RehanC for placeholder issue on 12th April 2023
            if ($("#cboRiskDetailOriginalPriority").val() != "") {
                setFilterComboValue("cboRiskDetailOriginalPriority", 0);
            }
            if ($("#cboRiskDetailChangePriority").val() != "") {
                setFilterComboValue("cboRiskDetailChangePriority", 0);
            }
            if ($("#cboRiskDetailRiskSourceId").val() != "") {
                setFilterComboValue("cboRiskDetailRiskSourceId", 0);
            }
            //End of Comment By RehanC on 12 April 2023

            //if ($("#chkReviewFlag").is(':checked') == true) {
            //    $("#chkReviewFlag").prop("checked", false);
            //}
            currentRiskID = 0;
            currentContingencyPlanID = 0;
            currentMitigationPlanID = 0;

            //getProjectRiskId();
        }
        function ClearFilterDetails(flag) {
            if ($("#txtFilterName").val() != "") {
                $("#txtFilterName").val("");
            }
            if ($("#cboPMFilterProjectRiskID").val() != "<") {
                setFilterComboValue("cboPMFilterProjectRiskID", "<");
            }
            if ($("#cboPMFilterDescription").val() != "Contains") {
                setFilterComboValue("cboPMFilterDescription", "Contains");
            }
            if ($("#cboPMFilterNotes").val() != "Contains") {
                setFilterComboValue("cboPMFilterNotes", "Contains");
            }
            if ($("#cboPMFilterRiskCategoryID").val() != "=") {
                setFilterComboValue("cboPMFilterRiskCategoryID", "=");
            }
            if ($("#txtPMFilterRiskCategoryID").val() != "0") {
                setFilterComboValue("txtPMFilterRiskCategoryID", "0");
            }
            if ($("#cboPMFilterOriginalPriority").val() != "=") {
                setFilterComboValue("cboPMFilterOriginalPriority", "=");
            }
            if ($("#cboPMFilterChangePriority").val() != "=") {
                setFilterComboValue("cboPMFilterChangePriority", "=");
            }

            if ($("#cboPMFilterRiskSourceId").val() != "=") {
                setFilterComboValue("cboPMFilterRiskSourceId", "=");
            }
            if ($("#cboPMFilterStatus").val() != "=") {
                setFilterComboValue("cboPMFilterStatus", "=");
            }
            if ($("#cboPMFilterPersonResponsible").val() != "=") {
                setFilterComboValue("cboPMFilterPersonResponsible", "=");
            }
            if ($("#txtPMFilterProjectRiskID").val()) {
                $("#txtPMFilterProjectRiskID").val("");
            }
            if ($("#txtPMFilterDescription").val()) {
                $("#txtPMFilterDescription").val("");
            }
            if ($("#txtPMFilterNotes").val()) {
                $("#txtPMFilterNotes").val("");
            }
            if ($("#txtPMFilterDateIdentifiedDisp").val()) {
                $("#txtPMFilterDateIdentifiedDisp").val("");
            }
            if ($("#txtPMFilterDateIdentified").val()) {
                $("#txtPMFilterDateIdentified").val("");
            }
            if ($("#txtPMFilterProbability").val()) {
                $("#txtPMFilterProbability").val("");
            }
            if ($("#txtPMFilterWeight").val()) {
                $("#txtPMFilterWeight").val("");
            }
            if ($("#txtPMFilterSeverity").val()) {
                $("#txtPMFilterSeverity").val("");
            }
            //if ($("#txtPMFilterOriginalPriority").val() != "Select Original Priority") {
            //    $("#txtPMFilterOriginalPriority").val("Select Original Priority");
            //}
            //if ($("#txtPMFilterChangePriority").val() != "Select Change Priority") {
            //    $("#txtPMFilterChangePriority").val("Select Change Priority");
            //}
              if ($("#txtPMFilterOriginalPriority").val() != "0") {
                $("#txtPMFilterOriginalPriority").val("0");
            }
            if ($("#txtPMFilterChangePriority").val() != "0") {
                $("#txtPMFilterChangePriority").val("0");

            }
            if ($("#txtPMFilterRiskSourceId").val() != 0) {
                $("#txtPMFilterRiskSourceId").val(0);
            }
            savedFilterName = "";

            if (flag == "") {
                $('*[id*=RiskselproOne_]').each(function () {
                    $(this).removeAttr("checked");
                });
            }
            if (flag == "") {
                if ($("#tabpresetfilter").hasClass("active")) {
                    $("#tabpresetfilter").removeClass("active");
                }
                if ($("#presetfilter").hasClass("active")) {
                    $("#presetfilter").removeClass("active");
                }
                $(".filter").removeClass("active");
                if ($('.filterpanel').hasClass("in")) {
                    $('.filterpanel').removeClass("in");
                }
            }
        }


        

        var fltProjectRiskID = "";
        var fltRiskDescription = "";
        var fltImpactDescription = "";
        var fltRiskCategory = "";
        var fltDateIdentified = "";
        var fltOriginalPriority = "";
        var fltChangePriority = "";
        var fltProbability = "";
        var fltImpact = "";
        var fltMagnitude = "";
        var fltRiskSource = "";
        var fltRiskStatus = "";
        var fltPersonResponsible = "";

        function SaveFilter(flag) {

            $("#btnSaveAndApply1").removeAttr("data-bs-target");
            $("#btnSaveAndApply2").removeAttr("data-bs-target");
            fltProjectRiskID = $("#txtPMFilterProjectRiskID").val();
            fltRiskDescription = $("#txtPMFilterDescription").val();
            fltImpactDescription = $("#txtPMFilterNotes").val();
            fltRiskCategory = $("#txtPMFilterRiskCategoryID option:selected").val();

            fltDateIdentified = $("#txtPMFilterDateIdentified").val();
            fltOriginalPriority = $("#txtPMFilterOriginalPriority").val();
            fltChangePriority = $("#txtPMFilterChangePriority").val();
            fltProbability = $("#txtPMFilterProbability").val();
            fltImpact = $("#txtPMFilterWeight").val();
            fltMagnitude = $("#txtPMFilterSeverity").val();
            fltRiskSource = $("#txtPMFilterRiskSourceId").val();
            
            fltRiskStatus = $("#txtPMFilterStatus option:selected").val();
            fltPersonResponsible = $("#txtPMFilterPersonResponsible option:selected").text();
            //alert(fltProjectRiskID + "," + fltRiskDescription+ "," + fltImpactDescription+ "," + fltRiskCategory+ "," + fltDateIdentified+ "," + fltOriginalPriority+ "," + fltChangePriority+ "," + fltProbability+ "," + fltImpact+ "," + fltMagnitude+ "," + fltRiskSource+ "," + fltRiskStatus+ "," + fltPersonResponsible)
            if (fltProjectRiskID == "" && fltRiskDescription == "" && fltImpactDescription == "" && fltRiskCategory == "0" && fltDateIdentified == "" && fltOriginalPriority == "" && fltChangePriority == "" && fltProbability == "" && fltImpact == "" && fltMagnitude == "" && fltRiskSource == "0" && fltRiskStatus == "0" && (fltPersonResponsible == "Select Responsible Person" || fltPersonResponsible == "")) {
                alertify.set('notifier', 'position', 'top-right');
                //Commented and Added By Reshma Chavan For Filter Rephrase alert
                //alertify.error('<%= MyBase.GetResourceString("A_FEmptyField") %>');
                alertify.error('Please Select at least one Filter Field.');
                 //End of Commented and Added By Reshma Chavan For Filter Rephrase alert
            }
            else {
                if (flag == 'saveapply') {
                    $("#btnSaveAndApply1").attr("data-bs-target", "#Risksavefilter");
                    $("#btnSaveAndApply2").attr("data-bs-target", "#Risksavefilter");
                }
                if (flag == 'apply') {
                    getRiskDetails(currentselectedProjectID, 0, "", flag, "");
                    FilterApplied();
                    currentappliedfilter = 0;
                    $("#presetfilter").removeClass('active')
                    $("#presetfilter").removeClass('show')
                    //debugger;
                    if ($("#tabpresetfilter a").hasClass("active")) {
                        $("#tabpresetfilter a").removeClass("active");
                    }
                }
                hideRiskDetails();
            }
            clearTooltip();
        }
        var currentToken = '';
        function generatetoken() {
            try {
                var ProjectID = $("#cboAccessibleProjects option:selected").val();

                if (ProjectID != undefined) {
                    var resultPKToken = ajaxCall("PM_Risks.aspx/GeneratePK_Token", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: ProjectID }));

                    if (resultPKToken != undefined) {
                        currentToken = resultPKToken.d;
                        validatetoken();
                    }
                }
            }
            catch (ex) {
                //alert(ex.message());
            }
        }
        function validatetoken() {
            try {
                var ProjectID = $("#cboAccessibleProjects option:selected").val();

                PKToken = currentToken;

                if (ProjectID != undefined) {
                    var resultPKToken = ajaxCall("PM_Risks.aspx/ValidatePK_Token", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: ProjectID, PKToken: PKToken }));

                    if (resultPKToken != undefined) {
                        if (resultPKToken.d == false) {
                            window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                        }
                    }
                }
            }
            catch (ex) {
                //alert(ex.message());
            }
        }
        function limitText(limitField, limitCount, limitNum) {            
            //limitField.value = limitField.value.replace(/'/g, "''");
            //var oldval = limitField.value;
            //limitField.value = limitField.value.replace(/(\r\n|\n|\r)/g, "  ");
            //oldval = oldval.replace(/(\r\n|\n|\r)/g, "**");
            
            if (limitField.value.length > limitNum) {                
                limitField.value = limitField.value.substring(0, limitNum); 
                //oldval = oldval.replace(/**/g, "(\r\n|\n|\r)");
                //limitField.value = oldval.substring(0, limitNum);
            } else {
                limitCount.innerHTML = (limitNum - limitField.value.length);

                if (limitCount.innerHTML != 0) {
                    //debugger;
                    IsFlagcountdownSummary = 0;
                    IsFlagcountdownFN = 0;
                    IsFlagcountdownAC = 0;
                    IsFlagSubus = 0;
                    IsFlag = 0;
                    // alert(limitCount.innerHTML);
                }
            }             
            
            //if (limitCount.innerHTML == 0) {

            //    if (limitCount.id == 'countdownFN') {
            //        if (IsFlagcountdownFN != 1) {
            //            document.getElementById("countdownFN").style.color = 'red' //when Char 0 length  then Color red
            //            // $('#spanBusinessValue').html("You Can Enter Only 1000 Character");
            //            alertify.set('notifier', 'position', 'top-right');
            //            alertify.notify('You Can Enter Only 1000 Character', 'error', 5);
            //            IsFlagcountdownFN = 1;
            //            return IsFlagcountdownFN;
            //        }
            //    }

            //    else {
            //        if (IsFlag != 1) {
            //            // document.getElementById("countdown").style.color = 'red' //when Char 0 length  then Color red
            //            // $('#spanUserDesc').html("You Can Enter Only 1000 Character");
            //            alertify.set('notifier', 'position', 'top-right');
            //            alertify.notify('You Can Enter Only 1000 Character', 'error', 5);
            //            IsFlag = 1;
            //            return IsFlag;
            //        }
            //    }
            //}
            //else {
            //    if (limitCount.id == 'countdownBU') {
            //        document.getElementById("countdownBU").style.color = 'black'
            //        //  $('#spanBusinessValue').text("");
            //    }
            //    else if (limitCount.id == 'countdownAC') {
            //        document.getElementById("countdownAC").style.color = 'black'
            //        // $('#spanAcceptanceCriteria').text("");
            //    }
            //    else if (limitCount.id == 'countdownFN') {
            //        document.getElementById("countdownFN").style.color = 'black'
            //        // $('#spanUserDesc').text("");
            //    }
            //    else {
            //        //document.getElementById("countdown").style.color = 'black'
            //        // $('#spanUserDesc').text("");
            //    }

            //}
            //if (limitField.clientHeight < limitField.scrollHeight) {
            //    limitField.style.height = limitField.scrollHeight + "px";
            //    if (limitField.clientHeight < limitField.scrollHeight) {
            //        limitField.style.height =
            //            (limitField.scrollHeight * 2 - limitField.clientHeight) + "px";
            //    }
            //} 

            //limitField.value = oldval;
        }
        var AjaxResult;
        function AJAXCallWithResult(url, data, async) {
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: "json",
                contentType: "application/json",
                async: async,
                success: function (result) {
                    AjaxResult = result;

                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });

            return AjaxResult;
        }
        function ajaxCall(url, type, contentType, dataType, data) {
            var ajaxResult;

            $.ajax({
                url: url,
                type: "POST",
                data: data,
                async: false,
                dataType: "json",
                contentType: "application/json;charset-utf=8",

                success: function (data) {

                    ajaxResult = data;
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });


            return ajaxResult;
        }

        function GetTabAcess() {
            var AccessParameters = {
                TagID: encodeURI(TagID),
                RoleID: encodeURI(RoleID),
                UserID: encodeURI(SessionEmployeeId),
                LoginType: encodeURI(SessionLoginType)
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Risks/GetTabAccess',
                type: 'POST',
                data: JSON.stringify(AccessParameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (AccessParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(AccessParameters) ? AccessParameters : JSON.stringify(AccessParameters)));
                    }
                },
                success: function (result) {
                    var TagAccess = result;
                    blnAccess = TagAccess;
                },
                error: function (err) {
                    blnAccess = false;
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }

        function getProjectRiskImpactStatus() {

            var PMParameter = {
                ProjectID: encodeURI(currentselectedProjectID)
            }
            $.ajax({
                url: strUrl + '/api/PM_Risks/GetProjectRiskImpactStatus',
                method: 'Post',
                data: JSON.stringify(PMParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMParameter) ? PMParameter : JSON.stringify(PMParameter)));
                    }
                },
                success: function (result) {
                    var statusHTML = '';
                    $(".statustext_outer").html(statusHTML);
                    statusHTML += ' <ul class="statustext hidden-xs">';


                    for (var i = 0; i < result.length; i++) {
                        statusHTML += ' <li data-bs-toggle="tooltip" id="ProbabilityMore" data-bs-placement="top" onclick="getStatusRiskDetails(&quot;ProbabilityMore&quot;)" title="" class="criticle clsStatusDeactive" data-original-title="Probability"><a href="javascript:;"><span class="statustextno">' + result[i].ProbabilityStatus + '</span>Probability 4 & more</a></li>';
                        statusHTML += ' <li data-bs-toggle="tooltip" id="ImpactMore" data-bs-placement="top" onclick="getStatusRiskDetails(&quot;ImpactMore&quot;)" title="" class="overdue clsStatusDeactive" data-original-title="Impact"><a href="javascript:;"><span class="statustextno">' + result[i].WeightStatus + '</span>Impact 4 & more</a></li>';
                        statusHTML += ' <li data-bs-toggle="tooltip" id="MagnitudeMore" onclick="getStatusRiskDetails(&quot;MagnitudeMore&quot;)" data-bs-placement="top" title="" class="pending clsStatusDeactive" data-original-title="Magnitude"><a href="javascript:;"><span class="statustextno">' + result[i].SeverityStatus + '</span>Magnitude 4 & more</a></li>';
                    }
                    statusHTML += '</ul>';
                    $(".statustext_outer").html(statusHTML);
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }
        function ChangeResponseType(PlanID) {
            var curResponseType = '';
            curResponseType = $("#cboRiskPlanType_" + PlanID + " option:selected").val();

            if (curResponseType == "Mitigation Plan") {
                $("#imgPMResponsiblePerson_" + PlanID).addClass("clsShowHide");
                $("#cboPMResponsiblePerson_" + PlanID).removeClass("mandatory");
                $("#cboPMResponsiblePerson_" + PlanID).next().remove();
            }
            if (curResponseType == "Contingency Plan") {
                $("#imgPMResponsiblePerson_" + PlanID).removeClass("clsShowHide");
                if ($("#cboPMResponsiblePerson_" + PlanID).next("label").hasClass("required") == false) {
                    $("#cboPMResponsiblePerson_" + PlanID).after('<label class="control-label required" style="float:right;"></label>');
                }
            }
        }
        var blnPlotProj = false;
        var blnPlotCategory = false;
        var blnPlotStatus = false;
        function ChangeProject(flag, clearflag) {
            try {
                //Added by Aditya J. on 19-08-2026 for restricting changes to closed projects  
                checkProjectIsClosed();
                //End of Added by Aditya J. on 19-08-2026 for restricting changes to closed projects  
                ClearFilterDetails("");
                //ClearRiskDetails();  Commented By RehanC for Category Filter Issue
                currentCategory = '';
                currentStatus = '';
                currentStaticFilter = '';
                currentappliedfilter = 0;
                currentappliedfilterclause = "";
                currentDefaultFilterID = 0;
                //$("#cboAccessibleProjects").attr("data-bs-placement", "bottom");
                //$('[data-bs-toggle="tooltip"]').tooltip();

                $(".statckmainheader button[data-id='cboAccessibleProjects']").tooltip({ placement: 'bottom' });
                $("#divRiskCategory button[data-id='cboRiskCategory'], #divRiskStatus button[data-id='cboRiskStatus']").tooltip({ placement: 'bottom' });
                $('.statckmainheader button[data-id="cboAccessibleProjects"]').attr('data-original-title', 'Select Project');
                $('#divRiskCategory button[data-id="cboRiskCategory"]').attr('data-original-title', 'Select Category');
                $('#divRiskStatus button[data-id="cboRiskStatus"]').attr('data-original-title', 'Select Status');
                //$("#divRiskCategory").removeAttr("data-original-title");
                $('.statckmainheader button[data-id="cboAccessibleProjects"]').hover(function (e) {
                    if (blnPlotProj == false) {
                        $(this).attr('data-original-title', 'Select Project');
                        $(this).removeAttr('title');
                        blnPlotProj = true;
                    }
                    else {
                        $(this).removeAttr('data-original-title');
                        blnPlotProj = false;
                    }
                });
                
                $('#divRiskCategory button[data-id="cboRiskCategory"]').hover(function (e) {
                    if (blnPlotCategory == false) {
                        $(this).attr('data-original-title', 'Select Category');
                        $(this).removeAttr('title');
                        blnPlotCategory = true;
                    }
                    else {
                        $(this).removeAttr('data-original-title');
                        blnPlotCategory = false;
                    }
                });
                $('#divRiskStatus button[data-id="cboRiskStatus"]').hover(function (e) {
                    if (blnPlotStatus == false) {
                        $(this).attr('data-original-title', 'Select Status');
                        $(this).removeAttr('title');
                        blnPlotStatus = true;
                    } else {
                        $(this).removeAttr('data-original-title');
                        blnPlotStatus = false;
                    }
                });

                //clearTooltip();
                //$("#addattachnebtrow").prop('disabled', false);
                $("#savedocument").prop('disabled', true);
                $(".delattachbtn").prop('disabled', false);
                $("#Addrisk, #divAddRisk, .editRDpanel").css({ 'pointer-events': "auto", "cursor": "pointer" });

                var currentProjectId = $("#cboAccessibleProjects option:selected").val();
                if (flag == 1 && clearflag == 0) {
                    if ($("#cboRiskCategory").val() != 0) {
                        $("#cboAccessibleProjects").removeClass("selectpicker");
                        $("#cboRiskCategory").val(0);
                        $("#cboRiskStatus").val(0);
                        /*$("#cboAccessibleProjects").addClass("selectpicker");*/
                    }
                    generatetoken();
                }
                if (currentProjectId == 0 || currentProjectId == undefined) {
                    //$(".filter").removeClass("active");
                    //if ($('.filterpanel').hasClass("in")) {
                    //    $('.filterpanel').removeClass("in");
                    //}
                    $('.riskmatrixpopup').addClass("clsDisablePointer");
                    $('#cboRiskCategory').prop('disabled', true);
                    $('#cboRiskStatus').prop('disabled', true);
                    $('.btnlistinline').addClass("clsDisablePointer");
                    $('.filedownload button').attr('disabled', true);
                    $('.mainclearalllink').css('pointer-events', 'none');
                    $('.mainclearalllink').parent().addClass("clsDisablePointer");
                    $('.mainfilter').attr('disabled', true);
                    $('.mainfilter').addClass("clsDisablePointer");
                    $('.mainfilter button').attr('disabled', true);
                    $('.statustext').attr('disabled', true);
                    $("#ProbabilityMore, #ImpactMore, #MagnitudeMore").css("pointer-events", "none");
                    $("#ProbabilityMore, #ImpactMore, #MagnitudeMore").removeClass("active");

                    $(".statustextno").each(function () {
                        if ($(this).text() != "0") {
                            $(this).text("0");
                        }
                    });
                    if (flag == 1) {
                        getRiskDetails(0, 0, "", "", "");
                    }
                    currentselectedProjectID = 0;
                    FilterNotApplied();
                }
                else {
                    StartLoader("#bodyPMRisk");
                    FilterNotApplied();
                    FillStatusCombox();

                    $('.riskmatrixpopup').removeClass("clsDisablePointer");
                    $('#cboRiskCategory').prop('disabled', false);
                    $('#cboRiskStatus').prop('disabled', false);
                    $('.btnlistinline').removeClass("clsDisablePointer");
                    $('.filedownload button').attr('disabled', false);
                    $('.mainclearalllink').css({ 'pointer-events': 'initial', 'cursor': 'pointer' });
                    $('.mainclearalllink').parent().removeClass("clsDisablePointer");
                    $('.mainfilter').attr('disabled', false);
                    $('.mainfilter').removeClass("clsDisablePointer");
                    $('.mainfilter button').attr('disabled', false);
                    $('.statustext').attr('disabled', false);
                    $("#divAddRisk, #ProbabilityMore, #ImpactMore, #MagnitudeMore").css({ 'pointer-events': "auto", "cursor": "pointer" });

                    currentselectedProjectID = currentProjectId;
                    if (flag == 1) {

                        icnt = 1;
                        jcnt = 1;
                        kcnt = 1;
                        lcnt = 1;

                        if (clearflag == 0) {
                            getMyFilters(1);
                        }
                        if (currentDefaultFilterID == 0) {
                            getRiskDetails(currentProjectId, 0, "", "", "");
                        }

                        var arrcboFieldName = ["txtPMFilterPersonResponsible"];
                        FillReponsiblePersonCombo(currentselectedProjectID, arrcboFieldName);

                        $("#txtPMFilterOriginalPriority > option").each(function () {
                            this.value = this.text;
                            if (this.text == "Select Original Priority") {
                                this.value = "";
                            }
                        });
                        $("#txtPMFilterChangePriority > option").each(function () {
                            this.value = this.text;
                            if (this.text == "Select Change Priority") {
                                this.value = "";
                            }
                        });
                        getProjectRiskImpactStatus();
                    }
                    if (flag == 2 || flag == 3) {
                        var selRiskCategory = "0";
                        var selRiskStatus = "";
                        selRiskCategory = $("#cboRiskCategory").val();
                        selRiskStatusId = $("#cboRiskStatus").val();
                        selRiskStatus = $("#cboRiskStatus option:selected").text();
                        if (selRiskStatusId == "0") {
                            selRiskStatus = "";
                        }
                        currentCategory = selRiskCategory;
                        currentStatus = selRiskStatus;
                        $(".clsStatusDeactive").removeClass("active");
                        getRiskDetails(currentProjectId, selRiskCategory, selRiskStatus, "", "");
                    }
                }

                try {
                    if ($(".Riskdetailpanel").css("display") != "none") {
                        $(".Riskdetailpanel").css({ 'display': "none" });
                    }
                }
                catch (ex) {
                    //alert(ex.message());
                }
                //$('.selectpicker').selectpicker('refresh');

            }
            catch (ex) {
                //alert(ex.message);
            }
            
            $("#cboRiskCategory").css({ 'width': '100px'});
       
            //$('.statckmainheader button[data-id="cboAccessibleProjects"]').removeAttr('data-original-title');
            //$('#divRiskCategory button[data-id="cboRiskCategory"]').removeAttr('data-original-title');
            //$('#divRiskStatus button[data-id="cboRiskStatus"]').removeAttr('data-original-title');
        }

        //Added By Usha Pandit On 28.09.2019 for generating where clause - Created By Mangesh Sir

        function GenerateBasicFilterQuery(module, AllFields) {
            try {
                
                var strqtext = "";
                for (var i = 0; i < AllFields.length; i++) {
                    var strvalue = '';

                    var strOp = $('select#cbo' + module + 'Filter' + AllFields[i] + ' option:selected').val();

                    strvalue = $("#txt" + module + "Filter" + AllFields[i]).val();

                    if (strvalue != "" && strvalue != undefined && strvalue != "0") {
                        if (strqtext != "") strqtext += " AND ";
                        if (strOp == "Contains") {
                            strqtext += AllFields[i] + " LIKE ";
                            //strqtext += " ''%" + strvalue + "%''";
                            strqtext += ' "%' + strvalue + '%"';
                        }
                        else if (strOp == "Ends With") {
                            strqtext += AllFields[i] + " LIKE ";
                           // strqtext += " ''%" + strvalue + "''";
                            strqtext += ' "%' + strvalue + '"';
                        }
                        else if (strOp == "Exact Word") {
                            strqtext += AllFields[i] + " = ";
                            //strqtext += " ''" + strvalue + "''";
                             strqtext += ' "' + strvalue + '"';
                        }
                        else if (strOp == "Not Contains") {
                            strqtext += AllFields[i] + " ";
                            //strqtext += " NOT LIKE ''%" + strvalue + "%''";
                              strqtext += ' NOT LIKE "%' + strvalue + '%"';
                        }
                        else if (strOp == "Starts With") {
                            strqtext += AllFields[i] + " LIKE ";
                           // strqtext += " ''" + strvalue + "%''";
                             strqtext += ' "' + strvalue + '%"';
                        }
                        else {

                            strqtext += AllFields[i] + " ";
                            if ($.isNumeric(strvalue) == false) {
                                //Commented And Added By Usha Pandit On 22.10.2020 For Crash on filter apply
                                //strqtext += strOp + " ''" + strvalue + "''";
                                strqtext += strOp + ' "' + strvalue + '"';
                                //End Of Added By Usha Pandit On 22.10.2020 For Crash on filter apply
                            }
                            else {
                                //strqtext += strOp + " " + strvalue + "";
                                //Commented And Added By Usha Pandit On 22.12.2020 For removing quote for numeric value
                                 //strqtext += strOp + ' "' + strvalue + '"';
                                strqtext += strOp + ' ' + strvalue;
                                //End Of Added By Usha Pandit On 22.12.2020 For removing quote for numeric value
                            }
                        }
                    }
                }
                
                strqtext = strqtext.replace('Over', '[Over]')
                strqtext = strqtext.replace(/'/g, "''");
                //Uncomment below line by imran on 26-08-2022 Filter error crash
                strqtext = strqtext.replace(/"/g, "''");
                //End of comment
                return strqtext;
            }
            catch (ex) {
                //alert(ex.message);
            }
        }

        function ClearBasicFilter(module) {
            $("[id*=cbo" + module + "Filter]").each(function (obj) {
                var cbo = this.id;
                $("#" + cbo + " option:first").prop('selected', 'selected');
            });

            $("[id*=txt" + module + "Filter]").each(function (obj) {
                var txt = this.id;
                $("#" + txt).val('').change();
            });
        }

        function BindBasicFilters(qtext, module) {
            ClearBasicFilter(module);
            var isAnd = qtext.indexOf(' AND ');
            if (isAnd > 0) {
                var rowsAnd = qtext.split(' AND ');
                for (i = 0; i < rowsAnd.length; i++) {
                    BindBasicFilterValues(rowsAnd[i], module);
                }
            }
            else {
                BindBasicFilterValues(qtext, module);
            }
        }

        function BindBasicFilterValues(qtext, module) {
            //debugger
            var field = qtext.substr(0, qtext.indexOf(' '));
            var op = orgop = "";
            var val = valstr = "";

            var opstr = qtext.substr(qtext.indexOf(' '), qtext.length).trim();
            var opchar = opstr.substr(0, 1);
            if (opchar == "N" || opchar == "L") {
                if (opchar == "N") {
                    op = "Not Contains";
                    orgop = "NOT LIKE";
                    valstr = opstr.substr(orgop.length, opstr.length).trim();
                    val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 4);
                }
                if (opchar == "L") {
                    orgop = "LIKE";
                    valstr = opstr.substr(orgop.length, opstr.length).trim();
                    if (valstr.indexOf('%') == 1) {
                        if (valstr.substr(2, valstr.length).indexOf('%') > 0) {
                            op = "Contains";
                            val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 4);
                        }
                        else {
                            op = "Ends With";
                            val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 3);
                        }
                    }
                    else {
                        op = "Starts With";
                        val = valstr.substr(1, valstr.length - 3);
                    }
                }
            }
            else {
                op = opstr.substr(0, opstr.indexOf(' '));
                valstr = opstr.substr(op.length, opstr.length).trim();
                val = valstr.substr(1, valstr.length - 2);
            }
            if (op == '=') {
                var cbo = "cbo" + module + "Filter" + field;
                if ($("#" + cbo + " option[value='" + op + "']").length == 0) {
                    op = "Exact Word"
                }
            }
            $('#cbo' + module + 'Filter' + field).val(op).change();
            $('#txt' + module + 'Filter' + field).val(val).change();
        }
        //End Of Added By Usha Pandit On 28.09.2019 for generating where clause - Created By Mangesh Sir

        function getStatusRiskDetails(StatusId) {
            $(".clsStatusDeactive").removeClass("active");
            $("#" + StatusId).addClass("active");
            if (StatusId == "ProbabilityMore") {
                getRiskDetails(currentselectedProjectID, 0, "", "probabilitymore", "");
            }
            else if (StatusId == "ImpactMore") {
                getRiskDetails(currentselectedProjectID, 0, "", "impactmore", "");
            }
            else if (StatusId == "MagnitudeMore") {
                getRiskDetails(currentselectedProjectID, 0, "", "magnitudemore", "");
            }
            if ($("#cboRiskCategory option:selected").val() != 0) {
                setFilterComboValue("cboRiskCategory", "0");
            }
            if ($("#cboRiskStatus option:selected").val() != 0) {
                setFilterComboValue("cboRiskStatus", "0");
            }

            FilterApplied();
            hideRiskDetails();
            clearTooltip();
        }
        function getShortName(fullName) {
           
            var details1 = new Array();
            details1[0] = new Array(fullName.length);

            var names = fullName.toString().split(".");
            if (fullName.toString().indexOf(".") != -1) {
                details1 = fullName.toString().split(".");
            }
            else if (fullName.toString().indexOf(",") != -1) {
                details1 = fullName.toString().split(",");
            }
            else {
                details1 = fullName.toString().split(" ");
            }

            var shortName = "";
            if (names.length > 0) {
                if ((details1[0][0]) == undefined) {                    
                    shortName = (details1[details1.length - 1][0]).toString().toUpperCase();
                }
                else {
                    shortName = (details1[0][0]).toString().toUpperCase() + (details1[details1.length - 1][0]).toString().toUpperCase();
                }
            }
            return shortName;
        }
        function getProjectTaskTypes(FieldName, ContingencyPlanID, curTaskType, Flag) {
            try {
                var selHTMLTaskType = "";

                PMTaskTypeParameter = {
                    ProjectID: encodeURI(currentselectedProjectID),
                    GetDefaultTaskType: 0
                }

                $.ajax({
                    url: strUrl + '/api/PM_Risks/GetProjectTaskTypes',
                    method: 'Post',
                    data: JSON.stringify(PMTaskTypeParameter),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (PMTaskTypeParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(PMTaskTypeParameter) ? PMTaskTypeParameter : JSON.stringify(PMTaskTypeParameter)));
                        }
                    },
                    success: function (resultTaskType) {
                        if (ContingencyPlanID == 0 && Flag == "") {
                            selHTMLTaskType += '<select id="' + FieldName + '_' + ContingencyPlanID + '" name=' + FieldName + '_' + ContingencyPlanID + '" tabindex="1" class="form-control clsTaskWidth">';
                        }
                        else if (ContingencyPlanID == 0 && Flag == "task") {
                            selHTMLTaskType += '<select id="' + FieldName + '" name="' + FieldName + '" tabindex="1" class="form-control">';
                        }
                        else {
                            if (Flag == "edit") {
                                selHTMLTaskType += '<select id="' + FieldName + '_' + ContingencyPlanID + '" name=' + FieldName + '_' + ContingencyPlanID + '" tabindex="1" class="form-control clsTaskWidth">';
                            }
                            else {
                                selHTMLTaskType += '<select id="' + FieldName + '_' + ContingencyPlanID + '" name=' + FieldName + '_' + ContingencyPlanID + '" disabled = "disabled" tabindex="1" class="form-control clsTaskWidth">';
                            }
                        }

                        if (resultTaskType.length > 0) {
                            if (ContingencyPlanID == 0) {
                                selHTMLTaskType += '<option title = "" value = "0"></option>';
                            }
                            for (var i = 0; i < resultTaskType.length; i++) {
                                var ObjRiskTaskType = resultTaskType[i];
                                var TaskTypeId = ObjRiskTaskType.TaskType;
                                var TaskType = ObjRiskTaskType.TaskType;
                                if (TaskType == curTaskType) {
                                    selHTMLTaskType += '<option selected title="' + TaskType + '" value="' + TaskTypeId + '">' + TaskType + '</option>';
                                }
                                else {
                                    selHTMLTaskType += '<option title="' + TaskType + '" value="' + TaskTypeId + '">' + TaskType + '</option>';
                                }
                            }
                        }
                        selHTMLTaskType += '</select>';
                        if ((ContingencyPlanID == 0 || Flag == "edit") && Flag != "task") {
                            //selHTMLTaskType += '<img id="imgPMTaskType_' + ContingencyPlanID + '" src="../../../Images/Star.gif" border="0">';
                        }
                    },
                    error: function (xhr, status, error) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    }
                });
                return selHTMLTaskType;
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        //Added By Usha Pandit On 01.07.2020 For setting focus to next page
        var cntEarlyWarning = 0;
        //End Of Added By Usha Pandit On 01.07.2020 For setting focus to next page
        function getRiskEarlyWarningsDetails() {
            try {                
                $('#btnEarlyWarning').prop('disabled', false);
                
                PMPlanParameter = {
                    RiskID: encodeURI(currentRiskID),
                    WarningID: 0
                }
                $(".RiskEarlyWarningtbl").dataTable().fnDestroy();

                var riskEarlyWarningHTML = "";

                $(".RiskEarlyWarningtbl tbody").html(riskEarlyWarningHTML);


                $.ajax({
                    url: strUrl + '/api/PM_Risks/GetRiskEarlyWarning',
                    method: 'Post',
                    data: JSON.stringify(PMPlanParameter),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (PMPlanParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(PMPlanParameter) ? PMPlanParameter : JSON.stringify(PMPlanParameter)));
                        }
                    },
                    success: function (result) {
                        try {

                            if (result.length > 0) {
                                //Added By Usha Pandit On 01.07.2020 For setting focus to next page
                                cntEarlyWarning = result.length;
                                //End Of Added By Usha Pandit On 01.07.2020 For setting focus to next page
                                blnEarlyWarningRecordsExists = true;
                                for (var i = 0; i < result.length; i++) {
                                    var ObjRiskEarlyWarningDtls = result[i];
                                    riskEarlyWarningHTML += '<tr>';
                                    riskEarlyWarningHTML += '<td class="text-start">';
                                    riskEarlyWarningHTML += '<div id="lblWarning_' + ObjRiskEarlyWarningDtls.WarningID + '" class="SHname" data-bs-toggle="tooltip" data-bs-placement="top">';
                                    riskEarlyWarningHTML += '<input type = "hidden" id="txtEarlyWarning_' + ObjRiskEarlyWarningDtls.WarningID + '" value="' + ObjRiskEarlyWarningDtls.Warning + '">';
                                    //riskEarlyWarningHTML += ObjRiskEarlyWarningDtls.Warning;
                                    //riskEarlyWarningHTML += '<div style="word-break: break-all;" class="lrgtext" data-bs-toggle="tooltip" data-bs-placement="right" title="' + ObjRiskEarlyWarningDtls.Warning + '"><span>' + ObjRiskEarlyWarningDtls.Warning + '</span></div>';
                                    riskEarlyWarningHTML += '<div style="word-break: break-word;" class="lrgtext"><span data-bs-toggle="tooltip" data-bs-placement="right" title="' + ObjRiskEarlyWarningDtls.Warning + '">' + ObjRiskEarlyWarningDtls.Warning + '</span></div>';
                                    riskEarlyWarningHTML += '</div>';
                                    riskEarlyWarningHTML += '</td>';


                                    riskEarlyWarningHTML += '<td class="text-start">';
                                    riskEarlyWarningHTML += '<div id="lblWarningStatus_' + ObjRiskEarlyWarningDtls.WarningID + '" class="SHname" data-bs-toggle="tooltip" data-bs-placement="top" title="Warning Status">';
                                    riskEarlyWarningHTML += ObjRiskEarlyWarningDtls.WarningStatus;
                                    riskEarlyWarningHTML += '</div>';
                                    riskEarlyWarningHTML += '</td>';

                                    riskEarlyWarningHTML += '<td class="text-start">';
                                    riskEarlyWarningHTML += '<div id="lblEarlyWarningFlag_' + ObjRiskEarlyWarningDtls.WarningID + '" class="SHname" data-bs-toggle="tooltip" data-bs-placement="top" title="Early Warning Flag">';

                                    if (ObjRiskEarlyWarningDtls.EarlyWarningFlag == 0) {
                                        riskEarlyWarningHTML += "No";
                                    }
                                    else {
                                        riskEarlyWarningHTML += "Yes";
                                    }

                                    riskEarlyWarningHTML += '</div>';
                                    riskEarlyWarningHTML += '</td>';

                                    riskEarlyWarningHTML += '<td class="actioncolumn">';
                                    riskEarlyWarningHTML += '<a href="javascript:;" class="add" title="Save" data-bs-toggle="tooltip" data-bs-container="body" onclick="SaveEarlyWarningDetails(' + ObjRiskEarlyWarningDtls.WarningID + ')">';
                                    riskEarlyWarningHTML += '<img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px">';
                                    riskEarlyWarningHTML += '</a>';
                                    if (blnEditAccess == "False") {

                                    }
                                    else {
                                        riskEarlyWarningHTML += '<a class="edit_SH_Detail editearlywarning nostylebtn edit" href="javascript:;" title="Edit" onclick="EditEarlyWarningDetails(' + ObjRiskEarlyWarningDtls.WarningID + ')" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body">';
                                        riskEarlyWarningHTML += '<img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px">';
                                        riskEarlyWarningHTML += '</a>';
                                    }
                                    if (blnDeleteAccess == "False") {

                                    }
                                    else {
                                        riskEarlyWarningHTML += '<button id="Delete_EarlyWarning_' + ObjRiskEarlyWarningDtls.WarningID + '" data-id=' + ObjRiskEarlyWarningDtls.WarningID + ' class="nostylebtn delete" onclick="setDeleteEarlyWarning(this.id)" data-bs-toggle="modal" data-bs-target="#deleteEarlywarningmodal"><i class="far fa-trash-alt" title="Delete" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body"></i></button>';
                                    }

                                    riskEarlyWarningHTML += '</td>';

                                    riskEarlyWarningHTML += '</tr>';
                                }
                            }

                        }
                        catch (ex) {
                            //alert(ex.message);
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    }
                });


                $(".RiskEarlyWarningtbl tbody").html(riskEarlyWarningHTML);
                $('.nostylebtn').tooltip();    
                tableEarlyWarningRisk = $('.RiskEarlyWarningtbl').DataTable({
                    //"pageLength": 5,
                    "bdestroy": true,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "autoWidth": false,
                    "drawCallback": function (settings) {
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        $('.lrgtext span').each(function (index, element) {
                            $(element).text(textAbstract(element, maxlengthwanted, " "));
                        });
                    }
                });
                if (riskEarlyWarningHTML == "") {
                    $(".RiskEarlyWarningtbl tbody tr td").prop("colspan", 8);
                }
                $('.lrgtext span').each(function (index, element) {
                    $(element).text(textAbstract(element, maxlengthwanted, " "));
                });
            }
            catch (ex) {
                //alert(ex.message);
            }
        }

        //Added By Usha Pandit On 01.07.2020 For setting focus to next page
        var cntRiskPlans = 0;
        //End Of Added By Usha Pandit On 01.07.2020 For setting focus to next page

        function getRiskPlanDetails() {
            try {   
                //Added By Usha Pandit On 01.07.2020 For setting focus to next page
                cntRiskPlans = 0;
                //End Of Added By Usha Pandit On 01.07.2020 For setting focus to next page

                $('#btnAddPlan').prop('disabled', false);
                
                PMPlanParameter = {
                    RiskID: encodeURI(currentRiskID)
                }
                $(".RiskPlantbl").dataTable().fnDestroy();

                var riskPlanHTML = "";

                $(".RiskPlantbl tbody").html(riskPlanHTML);
                
                $.ajax({
                    url: strUrl + '/api/PM_Risks/GetRiskPlans',
                    method: 'Post',
                    data: JSON.stringify(PMPlanParameter),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (PMPlanParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(PMPlanParameter) ? PMPlanParameter : JSON.stringify(PMPlanParameter)));
                        }
                    },
                    success: function (result) {
                        try {

                            if (result.length > 0) {
                                //Added By Usha Pandit On 01.07.2020 For setting focus to next page
                                cntRiskPlans = result.length;
                                //End Of Added By Usha Pandit On 01.07.2020 For setting focus to next page
                                blnPlanRecordsExists = true;
                                for (var i = 0; i < result.length; i++) {
                                    var ObjRiskPlanDtls = result[i];
                                    riskPlanHTML += '<tr>';
                                    riskPlanHTML += '<td class="text-start">';
                                    riskPlanHTML += '<div id="lblContingencyPlan_' + ObjRiskPlanDtls.ContingencyPlanID + '" class="SHname clsWidth">';
                                    //Added By Usha Pandit On 01.07.2020 for escaping single quotes
                                    //riskPlanHTML += '<input type = "hidden" id="txtPlan_' + ObjRiskPlanDtls.ContingencyPlanID + '" value="' + ObjRiskPlanDtls.ContingencyPlan + '">';
                                    var strContingencyPlan = ObjRiskPlanDtls.ContingencyPlan.toString().replace(/'/g, "\\'");
                                    //strContingencyPlan = strContingencyPlan.toString().replace(/"/g, '\\"');
                                    strContingencyPlan = strContingencyPlan.toString().replace(/\"/g, "@@");     
                                    riskPlanHTML += '<input type = "hidden" id="txtPlan_' + ObjRiskPlanDtls.ContingencyPlanID + '" value="' + strContingencyPlan + '">';
                                    //End Of Added By Usha Pandit On 01.07.2020 for escaping single quotes
                                    //Added By Usha Pandit On 23-10-2019 For UI related changes
                                    //riskPlanHTML += ObjRiskPlanDtls.ContingencyPlan;
                                    //riskPlanHTML += '<div style="word-break: break-all;" class="lrgtext" data-bs-toggle="tooltip" data-bs-placement="right" title="' + ObjRiskPlanDtls.ContingencyPlan + '"><span>' + ObjRiskPlanDtls.ContingencyPlan + '</span></div>';
                                    riskPlanHTML += '<div style="word-break: break-word;" class="lrgtext"><span data-bs-toggle="tooltip" data-bs-placement="right" data-bs-container="body" title="' + ObjRiskPlanDtls.ContingencyPlan + '">' + ObjRiskPlanDtls.ContingencyPlan + '</span></div>';
                                    //End Of Added By Usha Pandit On 23-10-2019 For UI related changes
                                    riskPlanHTML += '</div>';
                                    riskPlanHTML += '</td>';
                                    riskPlanHTML += '<td class="text-start">'; //Response Type
                                    riskPlanHTML += '<div class="tool-tip" data-bs-toggle="tooltip" data-bs-placement="top" title="Response Type">';

                                    riskPlanHTML += '<% CommonFunctions.HTMLControls.DrawComboBox("cboRiskPlanType_" + "currentCId", "usp_Whizible2_Sel_Plan_Type",, "Contingency Plan", " disabled=""disabled"" class=""form-control clsPlanWidth"" onChange=""ChangeResponseType(currentCId)""",,,, , ).Replace("'", "\'")%>';

                                    riskPlanHTML = riskPlanHTML.replace(/currentCId/g, ObjRiskPlanDtls.ContingencyPlanID);
                                    riskPlanHTML += '</div>';
                                    riskPlanHTML += '</td>';
                                    
                                    if (ObjRiskPlanDtls.Responsibility == "") {
                                        riskPlanHTML += '<td class="text-start"></td>';
                                    }
                                    else {
                                        riskPlanHTML += '<td class="text-start">';
                                        var FullName = ObjRiskPlanDtls.Responsibility;
                                        var ShortName = getShortName(FullName);
                                        //riskPlanHTML += '<span data-bs-toggle="tooltip" data-title="' + FullName + '" class="usernameshort circle-bggreen usernamecirclesmall">' + ShortName + '</span>';
                                        riskPlanHTML += '<span data-bs-toggle="tooltip" data-bs-container="body" data-title="' + FullName + '" class="usernameshort circle-bggreen usernamecirclesmall">' + ShortName + '</span>';
                                        riskPlanHTML += '<input type = "hidden" id="cboPMResponsiblePerson_' + ObjRiskPlanDtls.ContingencyPlanID + '" value="' + FullName + '">';
                                        riskPlanHTML += '</td>';
                                    }
                                    
                                    var selHTMLTaskType = "";
                                    selHTMLTaskType = getProjectTaskTypes("cboPMTaskType", ObjRiskPlanDtls.ContingencyPlanID, ObjRiskPlanDtls.TaskType, "");
                                    
                                    riskPlanHTML += '<td>';
                                    riskPlanHTML += '<div class="tool-tip" data-bs-toggle="tooltip" data-bs-placement="top" title="Task Type">';
                                    riskPlanHTML += selHTMLTaskType;
                                    riskPlanHTML += '</div>';
                                    riskPlanHTML += '</td>';

                                    riskPlanHTML += '<td>';
                                    riskPlanHTML += '<div class="clsDateWidth" id="txtDateOfPlan_' + ObjRiskPlanDtls.ContingencyPlanID + '" data-bs-toggle="tooltip" data-bs-placement="top" title="Date of Plan">';
                                    riskPlanHTML += ObjRiskPlanDtls.DateOfPlan;
                                    riskPlanHTML += '</div>';
                                    //riskPlanHTML += '<img src="../../../Whizible2.0-new/dist/img/calendar.svg" alt="" width="20px"></span>';
                                    riskPlanHTML += '</td>';
                                    //riskPlanHTML += '<td>Analysis</td>';
                                    riskPlanHTML += '<td>';
                                    
                                    if (ObjRiskPlanDtls.TaskID == 0) {
                                        riskPlanHTML += '<div data-bs-toggle="tooltip" data-bs-placement="top" title="Assign Task" style="cursor:pointer;">';
                                         //Commented by Chetan M on 13th April 2020 for IssueID = 23196
                                        //riskPlanHTML += '<a class="nostylebtn clsContingency" id="Set_Task_' + ObjRiskPlanDtls.ContingencyPlanID + '" onclick="setTaskDetails(' + ObjRiskPlanDtls.ContingencyPlanID + ')" data-id=""' + ObjRiskPlanDtls.ContingencyPlanID + '""  data-bs-target="#assigntaskmodal" data-bs-toggle="modal" style = "display: inline;">';
                                        //riskPlanHTML += '<i class="fas fa-plus" data-bs-target="#assigntaskmodal" title = "" data - toggle="tooltip" data - placement="top" data - container="body" data - original - title="Cancel" ></i >';
                                        //End of Commented by Chetan M on 13th April 2020 for IssueID = 23196
                                    }
                                    else {
                                        riskPlanHTML += '<a data-bs-toggle="tooltip" data-bs-placement="top" title="Task Details" href="javascript:;">' + ObjRiskPlanDtls.TaskType + '</a>';
                                    }
                                    riskPlanHTML += '</a>';
                                    riskPlanHTML += '</div>';
                                    riskPlanHTML += '</td>';

                                    riskPlanHTML += '<td>';
                                    riskPlanHTML += '<div style="width:50px!important;" id="Duration_' + ObjRiskPlanDtls.ContingencyPlanID + '" data-bs-toggle="tooltip" data-bs-placement="top" title="Duration">';
                                    riskPlanHTML += ObjRiskPlanDtls.ExpectedDuration;
                                    riskPlanHTML += '</div>';
                                    riskPlanHTML += '</td>';
                                    riskPlanHTML += '<td>';
                                    riskPlanHTML += '<div style="width:50px!important;" id="ExpectedWork_' + ObjRiskPlanDtls.ContingencyPlanID + '" data-bs-toggle="tooltip" data-bs-placement="top" title="Work (H:M)">';
                                    riskPlanHTML += ObjRiskPlanDtls.ExpectedWork;
                                    riskPlanHTML += '</div>';
                                    riskPlanHTML += '</td>';
                                    riskPlanHTML += '<td class="actioncolumn">';
                                    riskPlanHTML += '<a href="javascript:;" class="add" title="Save" data-bs-toggle="tooltip" data-bs-container="body" onclick="SavePlanDetails(' + ObjRiskPlanDtls.ContingencyPlanID + ')">';
                                    riskPlanHTML += '<img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px">';
                                    riskPlanHTML += '</a>';
                                    if (blnEditAccess == "False") {

                                    }
                                    else {
                                        if (ObjRiskPlanDtls.TaskID == 0) {
                                            riskPlanHTML += '<a class="edit_SH_Detail editriskplan nostylebtn edit" href="javascript:;" onclick="EditPlanDetails(' + ObjRiskPlanDtls.ContingencyPlanID + ',&quot;Contingency&quot;)" title="Edit" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body">';
                                            riskPlanHTML += '<img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px">';
                                            riskPlanHTML += '</a>';
                                        }
                                    }
                                    if (blnDeleteAccess == "False") {

                                    }
                                    else {
                                        if (ObjRiskPlanDtls.TaskID == 0) {
                                            riskPlanHTML += '<button id="Delete_Plan_' + ObjRiskPlanDtls.ContingencyPlanID + '" data-id=' + ObjRiskPlanDtls.ContingencyPlanID + ' class="nostylebtn clsDelContingency delete" onclick="setDeletePlan(this.id)" data-bs-toggle="modal" data-bs-target="#deleteplanmodal"><i class="far fa-trash-alt" title="Delete" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body"></i></button>';
                                        }
                                    }

                                    riskPlanHTML += '</td>';

                                    riskPlanHTML += '</tr>';
                                }
                            }
                        }
                        catch (ex) {
                            //alert(ex.message);
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    }
                });

                $.ajax({
                    url: strUrl + '/api/PM_Risks/GetRiskMitigationPlans',
                    method: 'Post',
                    data: JSON.stringify(PMPlanParameter),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (PMPlanParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(PMPlanParameter) ? PMPlanParameter : JSON.stringify(PMPlanParameter)));
                        }
                    },
                    success: function (result) {
                        try {

                            if (result.length > 0) {
                                //Added By Usha Pandit On 01.07.2020 For setting focus to next page
                                cntRiskPlans = cntRiskPlans + result.length;
                                //End Of Added By Usha Pandit On 01.07.2020 For setting focus to next page
                                blnPlanRecordsExists = true;
                                for (var i = 0; i < result.length; i++) {
                                    var ObjRiskPlanDtls = result[i];
                                    riskPlanHTML += '<tr>';
                                    riskPlanHTML += '<td class="text-start">';
                                    riskPlanHTML += '<div id="lblContingencyPlan_' + ObjRiskPlanDtls.MitigationPlanID + '" class="SHname clsWidth">';
                                    riskPlanHTML += '<input type = "hidden" id="txtPlan_' + ObjRiskPlanDtls.MitigationPlanID + '" value="' + ObjRiskPlanDtls.Action + '">';
                                    //Added By Usha Pandit On 23-10-2019 For UI related changes
                                    //riskPlanHTML += ObjRiskPlanDtls.Action;
                                    //riskPlanHTML += '<div style="word-break: break-all;" class="lrgtext" data-bs-toggle="tooltip" data-bs-placement="right" title="' + ObjRiskPlanDtls.Action + '"><span>' + ObjRiskPlanDtls.Action + '</span></div>';
                                    riskPlanHTML += '<div style="word-break: break-word;" class="lrgtext"><span data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="' + ObjRiskPlanDtls.Action + '">' + ObjRiskPlanDtls.Action + '</span></div>';
                                    //End Of Added By Usha Pandit On 23-10-2019 For UI related changes
                                    riskPlanHTML += '</div>';
                                    riskPlanHTML += '</td>';
                                    riskPlanHTML += '<td class="text-start">'; //Response Type
                                    //riskPlanHTML += '<div class="tool-tip" data-bs-toggle="tooltip" data-bs-placement="top" title="Response Type">';
                                    riskPlanHTML += '<div class="tool-tip" data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="top" title="Response Type">';
                                    riskPlanHTML += '<% CommonFunctions.HTMLControls.DrawComboBox("cboRiskPlanType_" + "currentCId", "usp_Whizible2_Sel_Plan_Type",, "Mitigation Plan", " disabled=""disabled"" class=""form-control clsPlanWidth"" onChange=""ChangeResponseType(currentCId)""",,, , , ).Replace("'", "\'")%>';

                                    riskPlanHTML = riskPlanHTML.replace(/currentCId/g, ObjRiskPlanDtls.MitigationPlanID);
                                    riskPlanHTML += '</div>';
                                    riskPlanHTML += '</td>';

                                    if (ObjRiskPlanDtls.Responsibility == "") {
                                        riskPlanHTML += '<td class="text-start"></td>';
                                    }
                                    else {
                                        riskPlanHTML += '<td class="text-start">';
                                        var FullName = ObjRiskPlanDtls.Responsibility;
                                        var ShortName = getShortName(FullName);
                                        riskPlanHTML += '<span data-bs-toggle="tooltip" data-title="' + FullName + '" class="usernameshort circle-bggreen usernamecirclesmall">' + ShortName + '</span>';
                                        riskPlanHTML += '<input type = "hidden" id="cboPMResponsiblePerson_' + ObjRiskPlanDtls.MitigationPlanID + '" value="' + FullName + '">';
                                        riskPlanHTML += '</td>';
                                    }

                                    var selHTMLTaskType = "";
                                    selHTMLTaskType = getProjectTaskTypes("cboPMTaskType", ObjRiskPlanDtls.MitigationPlanID, ObjRiskPlanDtls.TaskType, "");

                                    riskPlanHTML += '<td>';
                                    riskPlanHTML += '<div class="tool-tip" data-bs-toggle="tooltip" data-bs-placement="top" title="Task Type">';
                                    riskPlanHTML += selHTMLTaskType;
                                    riskPlanHTML += '</div>';
                                    riskPlanHTML += '</td>';

                                    riskPlanHTML += '<td>';
                                    riskPlanHTML += '<div class="clsDateWidth" id="txtDateOfPlan_' + ObjRiskPlanDtls.MitigationPlanID + '"  data-bs-toggle="tooltip" data-bs-placement="top" title="Date of Plan">';
                                    riskPlanHTML += ObjRiskPlanDtls.DateOfPlan;
                                    riskPlanHTML += '</div>';
                                    riskPlanHTML += '</td>';
                                    //riskPlanHTML += '<td><a href="javascript:;" >Analysis</a></td>';

                                    riskPlanHTML += '<td>';
                                    if (ObjRiskPlanDtls.TaskID == 0) {
                                        riskPlanHTML += '<div data-bs-toggle="tooltip" data-bs-placement="top" title="Assign Task" style="cursor:pointer;">';
                                       //Commented by Chetan M on 13th April 2020 for IssueID = 23196
                                        //riskPlanHTML += '<a class="nostylebtn clsContingency" id="Set_Task_' + ObjRiskPlanDtls.MitigationPlanID + '" onclick="setTaskDetails(' + ObjRiskPlanDtls.MitigationPlanID + ')" data-id=""' + ObjRiskPlanDtls.MitigationPlanID + '""  data-bs-target="#assigntaskmodal" data-bs-toggle="modal" style = "display: inline;">';
                                        //riskPlanHTML += '<i class="fas fa-plus" data-bs-target="#assigntaskmodal" title = "" data - toggle="tooltip" data - placement="top" data - container="body" data - original - title="Cancel" ></i >';
                                         //End of Commented by Chetan M on 13th April 2020 for IssueID = 23196
                                        riskPlanHTML += '</a>';
                                        riskPlanHTML += '</div>';
                                    }
                                    else {
                                        riskPlanHTML += '<a data-bs-toggle="tooltip" data-bs-placement="top" title="Task Details" href="javascript:;">' + ObjRiskPlanDtls.TaskType + '</a>';
                                    }
                                    riskPlanHTML += '</td>';

                                    if (ObjRiskPlanDtls.ExpectedDuration == 0) {
                                        riskPlanHTML += '<td>';
                                        riskPlanHTML += '</td>';
                                    }
                                    else {
                                        riskPlanHTML += '<td>';
                                        riskPlanHTML += '<div style="width:50px!important;" id="Duration_' + ObjRiskPlanDtls.MitigationPlanID + '" data-bs-toggle="tooltip" data-bs-placement="top" title="Duration">';
                                        riskPlanHTML += ObjRiskPlanDtls.ExpectedDuration;
                                        riskPlanHTML += '</div>';
                                        riskPlanHTML += '</td>';
                                    }
                                    riskPlanHTML += '<td>';
                                    riskPlanHTML += '<div style="width:50px!important;" id="ExpectedWork_' + ObjRiskPlanDtls.MitigationPlanID + '"  data-bs-toggle="tooltip" data-bs-placement="top" title="Work (H:M)">';
                                    riskPlanHTML += ObjRiskPlanDtls.ExpectedWork;
                                    riskPlanHTML += '</div>';
                                    riskPlanHTML += '</td>';
                                    riskPlanHTML += '<td class="actioncolumn">';
                                    riskPlanHTML += '<a href="javascript:;" class="add" title="Save" data-bs-toggle="tooltip" data-bs-container="body" onclick="SavePlanDetails(' + ObjRiskPlanDtls.MitigationPlanID + ')">';
                                    riskPlanHTML += '<img class="material-icons" src="../../../Whizible2.0-new/dist/img/save.svg" alt="" width="16px">';
                                    riskPlanHTML += '</a>';
                                    if (blnEditAccess == "False") {

                                    }
                                    else {
                                        if (ObjRiskPlanDtls.TaskID == 0) {
                                            riskPlanHTML += '<a class="edit_SH_Detail editriskplan nostylebtn edit" href="javascript:;" onclick="EditPlanDetails(' + ObjRiskPlanDtls.MitigationPlanID + ',&quot;Mitigation&quot;)" title="Edit" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body">';
                                            riskPlanHTML += '<img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px">';
                                            riskPlanHTML += '</a>';
                                        }
                                    }
                                    if (blnDeleteAccess == "False") {

                                    }
                                    else {
                                        if (ObjRiskPlanDtls.TaskID == 0) {
                                            riskPlanHTML += '<button id="Delete_Plan_' + ObjRiskPlanDtls.MitigationPlanID + '" data-id=' + ObjRiskPlanDtls.MitigationPlanID + ' class="nostylebtn clsDelMitigation delete" onclick="setDeletePlan(this.id)" data-bs-toggle="modal" data-bs-target="#deleteplanmodal"><i class="far fa-trash-alt" title="Delete" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body"></i></button>';
                                        }
                                    }

                                    riskPlanHTML += '</td>';

                                    riskPlanHTML += '</tr>';
                                }
                            }
                        }
                        catch (ex) {
                            //alert(ex.message);
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    }
                });
                //}
                
                $(".RiskPlantbl tbody").html(riskPlanHTML);
                
                tablePlanRisk = $('.RiskPlantbl').DataTable({
                    //"pageLength": 5,
                    "bdestroy": true,
                    "lengthChange": false,
                    "bFilter": false,
                    "ordering": false,
                    "responsive": true,
                    "bdestroy": true,
                    "lengthChange": false,
                    "columns": [{ "width": "25px" }, { "width": "25px" }, { "width": "450px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }],
                    "drawCallback": function (settings) {
                        $('[data-bs-toggle="tooltip"]').tooltip();
                        $('.lrgtext span').each(function (index, element) {
                            $(element).text(textAbstract(element, maxlengthwanted, " "));
                        });                        
                    }
                });
                if (riskPlanHTML == "") {
                    $(".RiskPlantbl tbody tr td").prop("colspan", 9);
                }
                $('.lrgtext span').each(function (index, element) {
                    $(element).text(textAbstract(element, maxlengthwanted, " "));
                });
                
                clearTooltip();
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        function CategoryOnChange(id, val) {
            var subcategoryid = id;
            var addstr = "sub";
            var position = 3;
            subcategoryid = [subcategoryid.slice(0, position), addstr, subcategoryid.slice(position)].join('');
            var category = val.value;
            getDocumentSubCategoryList(subcategoryid, category, null);
        }
        function getDocumentSubCategoryList(SubCategoryId, Category, SubCategory) {            
            //Commented and Modified By RehanC for parameter mismatch issue on 6th April 2023
            //var PMParam = {
            //    ProjectID: encodeURI(currentselectedProjectID)
            //} 
            if (SubCategory == null)
            { SubCategory = 0; }
            var RiskDocument = {
                SubCategory: encodeURI(SubCategory),
                Category: encodeURI(Category),
               // PMParam: PMParam,
                ProjectID: encodeURI(currentselectedProjectID)
            }
            //End of Modification By RehanC on 6th April 2023
            $.ajax({
                url: strUrl + '/api/PM_Risks/GetDocumentSubCategoryList',
                method: 'Post',
                data: JSON.stringify(RiskDocument),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (RiskDocument) {
                        xhr.setRequestHeader("Params", encryptString(isJson(RiskDocument) ? RiskDocument : JSON.stringify(RiskDocument)));
                    }
                },
                success: function (strResult) {
                    $("#atchmentTableBody > tr.attachments > td:nth-child(2)>select#" + SubCategoryId).empty();
                    if (strResult != undefined) {
                        var selHTML = "";
                        selHTML += "<option  value=0 >--Select Sub Category --</option>";
                        for (var i = 0; i < strResult.length; i++) {
                            //debugger;
                            var d = strResult[i];
                            var SubCategoryID = d.SubCategoryID;
                            var SubCategory = d.SubCategory;
                            selHTML += "<option  value='" + SubCategoryID + "' >" + SubCategory + "</option>";
                        }
                        //  StopAjaxLoader("#bodyIssueList");


                        $("#atchmentTableBody > tr.attachments > td:nth-child(2)>select#" + SubCategoryId).html(selHTML);
                        $('[data-bs-toggle="tooltip"]').tooltip();

                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }
        function getDocumentCategoryList(cboId) {
            var PMParam = {
                ProjectID: encodeURI(currentselectedProjectID),
                RoleID: encodeURI(RoleID)
            }
            $.ajax({
                url: strUrl + '/api/PM_Risks/GetDocumentCategoryList',
                method: 'Post',
                data: JSON.stringify(PMParam),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMParam) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMParam) ? PMParam : JSON.stringify(PMParam)));
                    }
                },
                success: function (strResult) {
                    $("#atchmentTableBody > tr.attachments > td:nth-child(1)>select#" + cboId).empty();
                    if (strResult != undefined) {
                        var selHTML = "";

                        selHTML += "<option  value=0  >--Select Category --</option>";
                        for (var i = 0; i < strResult.length; i++) {
                            //debugger;
                            var d = strResult[i];
                            var CategoryID = d.CategoryID;
                            var Category = d.Category;
                            selHTML += "<option  value='" + CategoryID + "'  >" + Category + "</option>";
                        }
                        // StopAjaxLoader("#bodyIssueList");


                        $("#atchmentTableBody > tr.attachments > td:nth-child(1)>select#" + cboId).html(selHTML);
                        $('[data-bs-toggle="tooltip"]').tooltip();

                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }
        var category = [];
        function getDocumentDetails(flag) {
            if (flag != undefined) {
                $("#savedocument").prop('disabled', true);
            }
            //Commented and Modified By RehanC for Parameter mismatch issue on 6th April 2023
            //var PMParam = {
            //    TagID: encodeURI(TagID),
            //    RoleID: encodeURI(RoleID)
            //}
            PMDocumentParameter = {
                ProjectID: encodeURI(currentselectedProjectID),
                //PMParam: PMParam,
                RiskID: parseInt(encodeURI(currentRiskID)),
                TagID: encodeURI(TagID),
                RoleID: encodeURI(RoleID)
            }
            //End of Modification By RehanC on 6th April 2023
            $.ajax({
                url: strUrl + '/api/PM_Risks/GetDocumentList',
                method: 'Post',
                data: JSON.stringify(PMDocumentParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMDocumentParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMDocumentParameter) ? PMDocumentParameter : JSON.stringify(PMDocumentParameter)));
                    }
                },
                success: function (result) {
                    try {
                        $(".RiskDocumentTbl").dataTable().fnDestroy();

                        var riskDocumentHTML = "";

                        $(".RiskDocumentTbl tbody").html(riskDocumentHTML);
						//Added By Usha Pandit On 11.06.2020 For getting correct count for document subtag
                        var DocumentCount = result.length;
                        //End Of Added By Usha Pandit On 11.06.2020 For getting correct count for document subtag
                        if (result.length > 0) {
                            blnDocumentRecordsExists = true;

                            var riskDocumentHTML = "";
                            for (var i = 0; i < result.length; i++) {
                                var data = result[i];
                                category.push(data.Category);
                            }
                            category = category.filter(
                                function (a) { if (!this[a]) { this[a] = 1; return a; } },
                                {}
                            );
                            for (var j = 0; j < category.length; j++) {

                                riskDocumentHTML += '<tr><td style="text-align: center;"><b>' + category[j] + '</b></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>';
                                for (var i = 0; i < result.length; i++) {
                                    var data = result[i];
                                    if (category[j] == data.Category) {
                                        var data = result[i];
                                        riskDocumentHTML += '<tr>';
                                        riskDocumentHTML += '<td> </td>';

                                        if (data.SubCategory != null) {
                                            riskDocumentHTML += '<td style="text-align: center;"> ' + data.SubCategory + '</td>';
                                        } else {
                                            riskDocumentHTML += '<td> </td>';
                                        }
                                        
                                        riskDocumentHTML += '<td style="text-align: center;"> <a href="#" onclick="DownloadReport(' + data.DocumentID + "," + currentselectedProjectID + "," + TagID + ')">' + data.FileName + '</a> </td>';
                                        //Added By Usha Pandit On 23-10-2019 For UI related changes
                                        //riskDocumentHTML += '<td style="text-align: center;"> ' + data.Description + '</td>';
                                        //riskDocumentHTML += '<td style="text-align: center;"> <div style="word-break: break-all;" class="lrgtext" data-bs-toggle="tooltip" data-bs-placement="right" title="' + data.Description + '"><span>' + data.Description + '</span></div></td>';
                                        
                                        riskDocumentHTML += '<td style="text-align: center;"> <div style="word-break: break-word;" class="lrgtext"><span data-bs-toggle="tooltip" data-bs-placement="right" title="' + data.Description + '">' + data.Description + '</span></div></td>';
                                        //End Of Added By Usha Pandit On 23-10-2019 For UI related changes
                                        riskDocumentHTML += '<td style="text-align: center;"> ' + data.FileSize.toFixed(2) + '</td>';
                                        riskDocumentHTML += '<td style="text-align: center;"> ' + data.UploadedDate + '</td>';

                                        if (blnDeleteAccess == "True") {
                                            riskDocumentHTML += '<td style="text-align: center;"> ' + '<button class="nostylebtn delattachbtn" title="" onclick="DeletedRiskAttachment(' + data.DocumentID + ')"><i class="far fa-trash-alt"></i></button>  </td>';
                                        } else {
                                            riskDocumentHTML += '<td> </td>';
                                        }
                                        riskDocumentHTML += '</tr>';
                                    }
                                }
                            }
                            category = [];
                        }
                        else {
                        }

                        $(".RiskDocumentTbl tbody").html(riskDocumentHTML);

                        tableDocumentRisk = $('.RiskDocumentTbl').DataTable({
                            //"pageLength": 5,
                            "bdestroy": true,
                            "lengthChange": false,
                            "bFilter": false,
                            "ordering": false,
                            "responsive": true,
                            "bAutoWidth": false,
                            "paging": false,
                            "columns": [{ "width": "80px" }, { "width": "80px" }, { "width": "120px" }, { "width": "80px" }, { "width": "80px" }, { "width": "80px" }, { "width": "80px" }],
                            "drawCallback": function (settings) {
                                $('[data-bs-toggle="tooltip"]').tooltip();
                                //Added By Usha Pandit On 23-10-2019 For UI related changes
                                $('.lrgtext span').each(function (index, element) {
                                    $(element).text(textAbstract(element, maxlengthwanted, " "));
                                });
                                //End Of Added By Usha Pandit On 23-10-2019 For UI related changes
                            }
							//Added By Usha Pandit On 11.06.2020 For getting correct count for document subtag
                            ,
                            "fnInfoCallback": function (oSettings, iStart, iEnd, iMax, iTotal, sPre) {
                                var customEnd = DocumentCount
                                var customTotal = DocumentCount
                                if (DocumentCount == 0) {
                                    iStart = 0;
                                }
                                var customInfo = "Showing " + iStart + " to " + customEnd + " of " + customTotal + " entries";
                                return customInfo;
                            }
                            //End Of Added By Usha Pandit On 11.06.2020 For getting correct count for document subtag
                        });

                        if (riskDocumentHTML == "") {
                            $(".RiskDocumentTbl tbody tr td").prop("colspan", 4);
                        }
                        //Added By Usha Pandit On 23-10-2019 For UI related changes
                        $('.lrgtext span').each(function (index, element) {
                            $(element).text(textAbstract(element, maxlengthwanted, " "));
                        });
                        //End Of Added By Usha Pandit On 23-10-2019 For UI related changes
                    }
                    catch (ex) {
                        //alert(ex.message);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }
        function ValidateAttachment(fileid) {
            var ValidateAttachmentFlag = true;
            
            var objFileName = document.getElementById(fileid);

            if (objFileName != null) {
                //if (disallowBlank(objFileName,"Please select the file")	) {return;}
                if (disallowSpecialCharacters(objFileName, 'Special character # is not allowed', true, '#')) { ValidateAttachmentFlag = false; return false; }

                if (disallowSpecialCharacters(objFileName, 'Single quotation mark is not allowed in file name', true, "'")) { ValidateAttachmentFlag = false; return false; }

                var countOfDot, FileNameCharCount;
                var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>';
                 //Added By Rutuja D. on 25 Dec 2020 For MaxFileSize Declaration
                var intMaxFileSize = '<%=ConfigurationManager.AppSettings("MaxFileSize")%>'
                 //End of Added By Rutuja D. on 25 Dec 2020 For MaxFileSize Declaration
                intMinFileSize = parseInt(intMinFileSize);
                if (objFileName.files['0'] != null) {
                    var intActualFileSize = (objFileName.files['0'].size);
                    //intActualFileSize = parseInt(intActualFileSize) / 1024;
                    intActualFileSize = parseInt(intActualFileSize);
                    var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>';
                    var validateExtensions;

                    if (objFileName.files['0'].name != '')
                        var countOfDot = objFileName.files['0'].name.split(".").length - 1;

                    if (countOfDot > 1) {
                        alertify.error('File with two or more extensions is not allowed!');
                        ValidateAttachmentFlag = false;
                        return false;
                    }

                    if (objFileName.files['0'].name != '')
                        FileNameCharCount = objFileName.files['0'].name.split(".")[0].length;

                    if (FileNameCharCount > 120) {

                        alertify.error('File name should not exceed 120 characters!');
                        ValidateAttachmentFlag = false;
                        return false;
                    }
                    //alert(intActualFileSize);

                    //Commented and added by Chetan M on 19 May 2021 for validate blank file
                     //if (intActualFileSize > intMinFileSize) {
                    //    alertify.error('File size should be less than or equal to ' + intMinFileSize + ' KB !');
                    //    ValidateAttachmentFlag = false;
                    //    return false;
                    //}
                    if (intActualFileSize < intMinFileSize) {
                        alertify.error('File size should be greater than or equal to ' + intMinFileSize + ' bytes !');
                        ValidateAttachmentFlag = false;
                        return false;
                    }
                    if (intMaxFileSize  < intActualFileSize) {
                        alertify.error('File size should not be greater than or equal to ' + intMaxFileSize + ' bytes !');
                        ValidateAttachmentFlag = false;
                        return false;
                    }
                    //End of Commented and added by Chetan M on 19 May 2021 for validate blank file
                   
                }
                else {
                    return false;
                }
            }
            // }
            //});
          
            return ValidateAttachmentFlag;
        }
        function getRiskHistoryDetails() {
            try {
                PMHistoryParameter = {
                    ProjectId: encodeURI(currentselectedProjectID),
                    RiskID: encodeURI(currentHistoryRiskID),
                    TagID: encodeURI(TagID)
                }
                $.ajax({
                    url: strUrl + '/api/PM_Risks/GetRiskHistory',
                    method: 'Post',
                    data: JSON.stringify(PMHistoryParameter),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (PMHistoryParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(PMHistoryParameter) ? PMHistoryParameter : JSON.stringify(PMHistoryParameter)));
                        }
                    },
                    success: function (result) {
                        try {
                            $(".RiskHistorytbl").dataTable().fnDestroy();

                            var riskHistoryHTML = "";

                            $(".RiskHistorytbl tbody").html(riskHistoryHTML);

                            if (result.length > 0) {
                                for (var i = 0; i < result.length; i++) {
                                    var ObjRiskHistoryDtls = result[i];

                                    //alert(ObjRiskHistoryDtls.NewValue);
                                    riskHistoryHTML += '<tr>';
                                    riskHistoryHTML += '<td>';
                                    //Commented & Added By Dipali V On 22nd may 2020 Forr ISsue ID 24536
                                    //riskHistoryHTML += ObjRiskHistoryDtls.Details;
                                   riskHistoryHTML += '<div style="word-break: break-word;" class="lrgtext"><span data-bs-toggle="tooltip" data-bs-placement="bottom" title="' +  ObjRiskHistoryDtls.Details + '">' +  ObjRiskHistoryDtls.Details + '</span></div>';
                                    riskHistoryHTML += '</td>';
                                    //End of Commented & Added By Dipali V On 22nd may 2020 Forr ISsue ID 24536
                                    riskHistoryHTML += '<td>';
                                    //Commented & Added By Dipali V On 22nd may 2020 Forr ISsue ID 24536
                                   // riskHistoryHTML += ObjRiskHistoryDtls.FieldName;
                                   riskHistoryHTML += '<div style="word-break: break-word;" class="lrgtext"><span data-bs-toggle="tooltip" data-bs-placement="bottom" title="' +  ObjRiskHistoryDtls.FieldName + '">' +  ObjRiskHistoryDtls.FieldName + '</span></div>';
                                    riskHistoryHTML += '</td>';
                                    //End of Commented & Added By Dipali V On 22nd may 2020 Forr ISsue ID 24536
                                    riskHistoryHTML += '<td>';
                                    //Commented & Added By Dipali V On 22nd may 2020 Forr ISsue ID 24536
                                    //riskHistoryHTML += ObjRiskHistoryDtls.Date;
                                    riskHistoryHTML += '<div style="word-break: break-word;" class="lrgtext"><span data-bs-toggle="tooltip" data-bs-placement="bottom" title="' +  ObjRiskHistoryDtls.Date + '">' +  ObjRiskHistoryDtls.Date + '</span></div>';
                                    riskHistoryHTML += '</td>';
                                    //End of Commented & Added By Dipali V On 22nd may 2020 Forr ISsue ID 24536
                                    riskHistoryHTML += '<td>';
                                    //Added By Usha Pandit On 23-10-2019 For UI related changes
                                    //riskHistoryHTML += ObjRiskHistoryDtls.Value;
                                    //riskHistoryHTML += '<div style="word-break: break-all;" class="lrgtext" data-bs-toggle="tooltip" data-bs-placement="bottom" title="' + ObjRiskHistoryDtls.Value + '"><span>' + ObjRiskHistoryDtls.Value + '</span></div>';
                                    riskHistoryHTML += '<div style="word-break: break-word;" class="lrgtext"><span data-bs-toggle="tooltip" data-bs-placement="bottom" title="' + ObjRiskHistoryDtls.Value + '">' + ObjRiskHistoryDtls.Value + '</span></div>';
                                    //End Of Added By Usha Pandit On 23-10-2019 For UI related changes
                                    riskHistoryHTML += '</td>';
                                    riskHistoryHTML += '<td>';
                                    //Added By Usha Pandit On 23-10-2019 For UI related changes
                                    //riskHistoryHTML += ObjRiskHistoryDtls.NewValue;
                                    //riskHistoryHTML += '<div style="word-break: break-all;" class="lrgtext" data-bs-toggle="tooltip" data-bs-placement="bottom" title="' + ObjRiskHistoryDtls.NewValue + '"><span>' + ObjRiskHistoryDtls.NewValue + '</span></div>';
                                    riskHistoryHTML += '<div style="word-break: break-word;" class="lrgtext"><span data-bs-toggle="tooltip" data-bs-placement="bottom" title="' + ObjRiskHistoryDtls.NewValue + '">' + ObjRiskHistoryDtls.NewValue + '</span></div>';
                                    //End Of Added By Usha Pandit On 23-10-2019 For UI related changes
                                    riskHistoryHTML += '</td>';
                                    if (ObjRiskHistoryDtls.ModifiedBy == "") {
                                        riskHistoryHTML += '<td></td>';
                                    }
                                    else {
                                        riskHistoryHTML += '<td>';
                                        var FullName = ObjRiskHistoryDtls.ModifiedBy;
                                        var ShortName = getShortName(FullName);
                                        riskHistoryHTML += '<span class="usernameshort circle-bggreen usernamecirclesmall" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="' + FullName + '">' + ShortName + '</span>';
                                        riskHistoryHTML += '</td>';
                                    }
                                    riskHistoryHTML += '</tr>';
                                }
                            }
                            else {

                            }

                            $(".RiskHistorytbl tbody").html(riskHistoryHTML);

                            tableHistoryRisk = $('.RiskHistorytbl').DataTable({
                                "pageLength": 5,
                                "bdestroy": true,
                                "lengthChange": false,
                                "bFilter": false,
                                "ordering": false,
                                "responsive": true,
                                "bAutoWidth": false,
                                "columns": [{ "width": "80px" }, { "width": "80px" }, { "width": "80px" }, { "width": "120px" }, { "width": "80px" }, { "width": "80px" }],
                                "drawCallback": function (settings) {
                                    $('[data-bs-toggle="tooltip"]').tooltip();
                                    //Added By Usha Pandit On 23-10-2019 For UI related changes
                                    $('.lrgtext span').each(function (index, element) {
                                        $(element).text(textAbstract(element, maxlengthwanted, " "));
                                    });
                                    //End Of Added By Usha Pandit On 23-10-2019 For UI related changes
                                }
                            });
                            
                            if (riskHistoryHTML == "") {
                                $(".RiskHistorytbl tbody tr td").prop("colspan", 6);
                            }
                            //Added By Usha Pandit On 23-10-2019 For UI related changes
                            $('.lrgtext span').each(function (index, element) {
                                $(element).text(textAbstract(element, maxlengthwanted, " "));
                            });
                            //End Of Added By Usha Pandit On 23-10-2019 For UI related changes
                        }
                        catch (ex) {
                            //alert(ex.message);
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    }
                });
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        //To Download Document
        function DownloadReport(DocumentID, ProjectID, MasterTagID) {
            var strTemp = '../../PM/PM_ViewDocument.aspx?FromWhere=PM&MasterTagID=' + MasterTagID + '&DocumentID=' + DocumentID + '&ProjectID=' + ProjectID + '';
            //var strTemp = '../../PM/PM_ViewDocument.aspx?FromWhere=PM&MasterTagID=' + MasterTagID + '&DocumentID=' + 624 + '&ProjectID=' + 2208 + '';
            window.open(strTemp);
        }

        //To download report
        function Export_Click(ReportFormat, curRiskId) {

            SessionRiskSQL = "";

            SessionProjectID = currentselectedProjectID;
            SessionCategory = '';
            SessionStatus = '';
            SessionStaticFilter = currentStaticFilter;
            SessionWhereClause = currentappliedfilterclause;
            if (currentCategory == '') {
                SessionCategory = 0;
            }
            else {
                SessionCategory = currentCategory;
            }
            if (currentStatus == '') {
                SessionStatus = '';
            }
            else {
                SessionStatus = currentStatus;
            }
            //var strSessionResult = ajaxCall("PM_Risks.aspx/ExportToReport", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ strSQL: SessionRiskSQL, RiskID: curRiskId, ProjectID: SessionProjectID, SessionCategory: SessionCategory, SessionStatus: SessionStatus, ReportFormat: ReportFormat }));
            PMReportParameter = {
                RiskID: encodeURI(curRiskId),
                ReportFormat: encodeURI(ReportFormat),
                Status: encodeURI(SessionStatus),
                RiskCategoryId: encodeURI(SessionCategory),
                ProjectId: encodeURI(SessionProjectID),
                StaticFilter: encodeURI(SessionStaticFilter),
                WhereClause: SessionWhereClause
            }
            $.ajax({
                url: strUrl + '/api/PM_Risks/ExportToReport',
                method: 'Post',
                data: JSON.stringify(PMReportParameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMReportParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMReportParameter) ? PMReportParameter : JSON.stringify(PMReportParameter)));
                    }
                },
                success: function (result) {
                    if (result != "0") {
                        window.open("../../CRW/CRW_ReportOutput.aspx?filename=" + result, "_report", "");
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });

        }

        //to get risk matrix
        function plotRiskMatrix() {
            try {
                PMParameter = {
                    EmployeeID: encodeURI(SessionEmployeeId),
                    ProjectId: encodeURI(currentselectedProjectID)
                }
                $.ajax({
                    url: strUrl + '/api/PM_Risks/GetRiskMatrix',
                    method: 'Post',
                    data: JSON.stringify(PMParameter),
                    dataType: 'json',
                    async: false,
                    contentType: "application/json",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (PMParameter) {
                            xhr.setRequestHeader("Params", encryptString(isJson(PMParameter) ? PMParameter : JSON.stringify(PMParameter)));
                        }
                    },
                    success: function (result) {
                        try {
                            //$(".RiskMatrixtbl").dataTable().fnDestroy();

                            var riskMatrixHTML = "";

                            if (result.length > 0) {

                                var arrProbabily = [];
                                var arrProbabilyLabel = [];
                                var arrImpactLabel = [];
                                var cntProb = 4;
                                var cntImpact = 0;
                                //Added By Dipali V On 1st Oct 2025 For W26 Product enhancement WH-PM-IS-7003,WH-PM-IS-7004,WH-PM-IS-7005
                                //Commented and added by Vishal Mane on 23/09/2025 to fix Risk Matrix plotting issue
                                //$("#cboRiskDetailProbability > option").each(function () {
                                //    if (this.text != "" && this.value != 0) {
                                //        arrProbabilyLabel[cntProb] = this.text;
                                //        cntProb -= 1;
                                //    }
                                //});
                                //$("#cboRiskDetailImpact > option").each(function () {
                                //    if (this.text != "" && this.value != 0) {
                                //        arrImpactLabel[cntImpact] = this.text;
                                //        cntImpact += 1;
                                //    }
                                //});
                                $("#cboRiskDetailProbability option").each(function () {
                                    var text = $(this).text().trim();
                                    var val = $(this).val();
                                    if (text !== "" && val !== "0") {
                                        arrProbabilyLabel[cntProb] = text;
                                        cntProb -= 1;
                                    }
                                });
                                $("#cboRiskDetailImpact option").each(function () {
                                    var text = $(this).text().trim();
                                    var val = $(this).val();
                                    if (text !== "" && val !== "0") {
                                        arrImpactLabel[cntImpact] = text;
                                        cntImpact += 1;
                                    }
                                });
                                //End of Commented and added by Vishal Mane on 23/09/2025 to fix Risk Matrix plotting issue
                                //End of Added By Dipali V On 1st Oct 2025 For W26 Product enhancement WH-PM-IS-7003,WH-PM-IS-7004,WH-PM-IS-7005
                                var cntProbabily = 0;
                                var cntProbabilyLabel = 0;

                                for (var i = 0; i < result.length; i++) {
                                    arrProbabily[cntProbabily] = result[i];
                                    if (arrProbabily.length == 5) {
                                        riskMatrixHTML += "<tr>";
                                        riskMatrixHTML += '<td class="matrix_label lable-y">' + arrProbabilyLabel[cntProbabilyLabel];
                                        riskMatrixHTML += '</td>';

                                        for (var j = 0; j < arrProbabily.length; j++) {
                                            var curClass = "";
                                            var curProb = arrProbabily[j].Probability;
                                            var curImp = arrProbabily[j].Impact;
                                            if (curProb == 1 && curImp <= 2) {
                                                curClass = "L";
                                            }
                                            if (curProb == 1 && curImp >= 3) {
                                                curClass = "M";
                                            }
                                            if (curProb == 2 && curImp == 1) {
                                                curClass = "L";
                                            }
                                            if (curProb == 2 && curImp >= 2 && curImp <= 4) {
                                                curClass = "M";
                                            }
                                            if (curProb == 2 && curImp == 5) {
                                                curClass = "H";
                                            }
                                            if (curProb == 3 && curImp <= 3) {
                                                curClass = "M";
                                            }
                                            if (curProb == 3 && curImp >= 4) {
                                                curClass = "H";
                                            }
                                            if (curProb == 4 && curImp <= 2) {
                                                curClass = "M";
                                            }
                                            if (curProb == 4 && curImp <= 4 && curImp >= 3) {
                                                curClass = "H";
                                            }
                                            if (curProb == 4 && curImp == 5) {
                                                curClass = "VH";
                                            }
                                            if (curProb == 5 && curImp == 1) {
                                                curClass = "M";
                                            }
                                            if (curProb == 5 && curImp <= 3 && curImp > 1) {
                                                curClass = "H";
                                            }
                                            if (curProb == 5 && curImp >= 4) {
                                                curClass = "VH";
                                            }

                                            riskMatrixHTML += "<td style='color:white;font-weight:500;width:85px;' class='" + curClass + "'>";
                                            riskMatrixHTML += arrProbabily[j].RiskCount;
                                            riskMatrixHTML += "</td>";
                                        }
                                        riskMatrixHTML += "</tr>";
                                        arrProbabily = [];
                                        cntProbabily = 0;
                                        cntProbabilyLabel = cntProbabilyLabel + 1;
                                    }
                                    else {
                                        cntProbabily = cntProbabily + 1;
                                    }
                                }
                                riskMatrixHTML += "<tr>";
                                riskMatrixHTML += "<td class='matrix_label'>";
                                riskMatrixHTML += "</td>";
                                for (var k = 0; k < arrImpactLabel.length; k++) {
                                    riskMatrixHTML += "<td style='width:85px;' class='matrix_label'>";
                                    riskMatrixHTML += arrImpactLabel[k];
                                    riskMatrixHTML += "</td>";
                                }
                                riskMatrixHTML += "</tr>";
                            }
                            else {

                            }

                            $(".RiskMatrixtbl tbody").html(riskMatrixHTML);
                            // $(".riskmatrixpopup").find("ul.dropdown-menu").preventDefault();
                            e.stopPropagation();

                        }
                        catch (ex) {
                            //alert(ex.message);
                        }
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                    }
                });
            }
            catch (ex) {
                //alert(ex.message);
            }
        }

        var blnConditionExists = false;
        function getRiskDetails(selProjectId, selCategory, selStatus, filterflag, filterwhereclause) {            
            try {
                currentStaticFilter = '';
                if (selProjectId != 0) {
                    var Parameters = {};

                    if (filterflag == "") {
                        Parameters = {
                            Flag: 0,
                            ProjectId: encodeURI(selProjectId),
                            RiskCategoryId: encodeURI(selCategory),
                            Status: encodeURI(selStatus),
                            RiskID: 0,
                            StatusText: ""
                        }
                    }
                    else if (filterflag == "riskdetails") {
                        Parameters = {
                            Flag: 0,
                            ProjectId: encodeURI(selProjectId),
                            RiskCategoryId: encodeURI(selCategory),
                            Status: encodeURI(selStatus),
                            RiskID: currentRiskID,
                            StatusText: ""
                        }
                    }
                    else if (filterflag == "probabilitymore" || filterflag == "impactmore" || filterflag == "magnitudemore") {
                        currentStaticFilter = filterflag;
                        currentCategory = '';
                        currentStatus = '';
                        Parameters = {
                            Flag: 0,
                            ProjectId: encodeURI(selProjectId),
                            RiskCategoryId: encodeURI(selCategory),
                            Status: encodeURI(selStatus),
                            RiskID: 0,
                            StatusText: filterflag
                        }
                    }
                    else {
                        var filterWhereClause = "";
                        if (filterflag == "defaultfilterapply") {
                            filterWhereClause = filterwhereclause;
                        }
                        else {
                            var AllFieldsPMRisks = ["ProjectRiskID", "Description", "Notes", "RiskCategoryID", "DateIdentified", "OriginalPriority", "ChangePriority", "Probability", "Weight", "Severity", "RiskSourceId", "Status", "PersonResponsible"];
                            filterWhereClause = GenerateBasicFilterQuery("PM", AllFieldsPMRisks);
                            
                            filterWhereClause = filterWhereClause.toString().replace(/\''/g, "'");
                            currentappliedfilterclause = filterWhereClause;
                        }
                       
                        Parameters = {
                            Flag: 1,
                            ProjectId: encodeURI(selProjectId),
                            RiskCategoryId: encodeURI(fltRiskCategory),
                            Status: encodeURI(fltRiskStatus),
                            ProjectRiskWhereClause: encodeURI(filterWhereClause),
                            RiskID: 0,
                            StatusText: ""
                        }
                    }
                    if (filterflag != "riskdetails") {
                        $(".Risktbl").dataTable().fnDestroy();
                    }

                    //alert(JSON.stringify(Parameters));
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_Risks/GetRiskDetails',

                        method: 'Post',
                        data: JSON.stringify(Parameters),
                        dataType: "json",
                        async: false,
                        contentType: "application/json",  /*;charset-utf=8*/
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                            if (Parameters) {
                                xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                            }
                        },
                        success: function (data) {                       
                            
                            if (filterflag != "riskdetails") {
                                var riskHTML = "";
                                $(".Risktbl tbody").html(riskHTML);
                                for (var i = 0; i < data.length; i++) {
                                    var ObjProjRisk = data[i];
                                    var ProjRiskId = ObjProjRisk.ProjectRiskID;
                                    var curRiskId = ObjProjRisk.RiskID;
                                    if (ProjRiskId == 0) {
                                        ProjRiskId = "NA";
                                    }
                                    riskHTML += '<tr>';
                                    riskHTML += '<td><span data-bs-toggle="tooltip" title="" class="idlabel">' + ProjRiskId + '</span></td>';                                                                                                    

                                    //riskHTML += '<td><div style="word-break: break-all;" class="lrgtext" data-bs-toggle="tooltip" data-bs-placement="right" title="' + ObjProjRisk.Description + '"><span>' + ObjProjRisk.Description + '</span></div></td>';
                                    riskHTML += '<td><div style="word-break: break-word;" class="lrgtext"><span data-bs-toggle="tooltip" data-bs-placement="right" title="' + ObjProjRisk.Description + '">' + ObjProjRisk.Description + '</span></div></td>';

                                    riskHTML += '<td>' + ObjProjRisk.DateIdentified + '</td>';
                                    riskHTML += '<td>' + ObjProjRisk.RiskCategory + '</td>';
                                    //riskHTML += '<td>' + ObjProjRisk.Probability + '</td>';
                                    //Added By Dipali V On 1st Oct 2025 For W26 Product enhancement WH-PM-IS-7003,WH-PM-IS-7004,WH-PM-IS-7005
                                    //Modified and added by Vishal Mane on 23/09/2025 to fix Issue as Probability, impact and Status value is getting wrong
                                    //var riskProbability = 0;
                                    //$("#cboRiskDetailProbability > option").each(function () {
                                    //    if (this.value == ObjProjRisk.Probability) {
                                    //        riskProbability = this.text;
                                    //    }
                                    //});
                                    var riskProbability = "";
                                    $("#cboRiskDetailProbability option").each(function () {
                                        if ($(this).val().toLowerCase() == ObjProjRisk.Probability.toString().toLowerCase()) {
                                            riskProbability = $(this).text();
                                            return false; // stop once found
                                        }
                                    });
                                    riskHTML += '<td>' + riskProbability + '</td>';
                                    //End of Modified and added by Vishal Mane on 23/09/2025 to fix Issue as Probability, impact and Status value is getting wrong

                                    //riskHTML += '<td>' + ObjProjRisk.Weight + '</td>';
                                    //Modified and added by Vishal Mane on 23/09/2025 to fix Issue as Probability, impact and Status value is getting wrong
                                    //var riskImpact = 0;
                                    //$("#cboRiskDetailImpact > option").each(function () {
                                    //    if (this.value == ObjProjRisk.Weight) {
                                    //        riskImpact = this.text;
                                    //    }
                                    //});
                                    var riskImpact = "";
                                    $("#cboRiskDetailImpact option").each(function () {
                                        if ($(this).val().toLowerCase() == ObjProjRisk.Weight.toString().toLowerCase()) {
                                            riskImpact = $(this).text();
                                            return false; // break loop once found
                                        }
                                    });
                                    riskHTML += '<td>' + riskImpact + '</td>';
                                    //End of Modified and added by Vishal Mane on 23/09/2025 to fix Issue as Probability, impact and Status value is getting wrong
                                    //End of Added By Dipali V On 1st Oct 2025 For W26 Product enhancement WH-PM-IS-7003,WH-PM-IS-7004,WH-PM-IS-7005
                                    riskHTML += '<td>' + ObjProjRisk.Severity + '</td>';
                                    riskHTML += '<td>' + ObjProjRisk.Status + '</td>';
                                                                    
                                    riskHTML += '<td class="editRDpanel" style="min-width:30px;">';
                                    if (blnEditAccess == "True") {
                                        riskHTML += '<a class="editRDpanel edit_SH_Detail" id="Edit_Risk_' + ObjProjRisk.RiskID + '" onclick="editRiskDetails(this.id)" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Edit" style="cursor:pointer;"><img src="../../../Whizible2.0-new/dist/img/edit.svg" width="16px" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Edit"></a>';                                        
                                    }
                                    if (blnDeleteAccess == "True") {
                                        riskHTML += '<button id="Delete_Risk_' + ObjProjRisk.RiskID + '" data-id=' + ObjProjRisk.RiskID + ' class="nostylebtn clsRiskDeleteRec" onclick="setDeleteRisk(this.id)" title="" data-bs-toggle="modal" data-bs-target="#deleteriskmodal"><i class="far fa-trash-alt" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Delete"></i></button>';
                                    }
                                    
                                    riskHTML += '<div class="dropdown filedownload dropdown-menu-center">';
                                    
                                    //riskHTML += '<button class="nostylebtn dropdown filedownload" data-bs-toggle="dropdown" autocomplete="off"><i class="fas fa-download" data-bs-toggle="tooltip" data-bs-placement="bottom" title="Download Report" ></i></button>';
                                    riskHTML += '<button class="nostylebtn dropdown filedownload" data-bs-toggle="dropdown" data-bs-placement="left" title="" autocomplete="off"><i class="fas fa-download" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Download Report" ></i></button>';
                                    riskHTML += '<ul class="dropdown-menu dropdown-toggle" data-bs-placement="right" id="fas-download">';
                                    riskHTML += '<li><a href="#" onclick="Export_Click(&quot;PDF&quot;, ' + curRiskId + ')">';
                                    riskHTML += '<img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px" >Pdf</a></li>';
                                    riskHTML += '<li><a href="#" onclick="Export_Click(&quot;EXCEL&quot;, ' + curRiskId + ')">';
                                    riskHTML += '<img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px" >Xlsx</a></li>';
                                    riskHTML += '<li><a href="#" onclick="Export_Click(&quot;XML&quot;, ' + curRiskId + ')">';
                                    riskHTML += '<img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px" >Xml</a></li>';
                                    riskHTML += '<li><a href="#" onclick="Export_Click(&quot;TEXT&quot;, ' + curRiskId + ')">';
                                    //Commented & Added By Dipali V On 21st March 2023 For Doc should be text
                                    //riskHTML += '<img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Doc</a></li>';
                                    riskHTML += '<img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Text</a></li>';
                                     //End of Commented & Added By Dipali V On 21st March 2023 For Doc should be text
                                    riskHTML += '</ul>';
                                    riskHTML += '</div>';

                                    

                                    riskHTML += '</td>';
                                    riskHTML += '</tr>';
                                }

                                $(".Risktbl tbody").html(riskHTML);


                                tableRisk = $('.Risktbl').DataTable({
                                    "pageLength": 5,
                                    "bdestroy": true,
                                    "lengthChange": false,
                                    "bFilter": false,
                                    "ordering": false,
                                    "responsive": true,
                                    //"columns": [{ "width": "80px" }, { "width": "80px" }, { "width": "120px" }, { "width": "80px" }, { "width": "80px" }, { "width": "80px" }, { "width": "80px" }, { "width": "80px" }, { "width": "80px" }],
                                    "columns": [ { "width": "25px" }, { "width": "25px" }, { "width": "450px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" }, { "width": "20px" } ],
                                    "drawCallback": function (settings) {
                                        $('[data-bs-toggle="tooltip"]').tooltip();                                        

                                        $('.lrgtext span').each(function (index, element) {
                                            $(element).text(textAbstract(element, maxlengthwanted, " "));
                                        });
                                    },
                                    "columnDefs": [{ "orderable": false, "targets": [0] }]
                                });                                

                                $('.lrgtext span').each(function (index, element) {
                                    $(element).text(textAbstract(element, maxlengthwanted, " "));
                                });
                            }
                            else {
                                //Set current risk details selected 
                                for (var i = 0; i < data.length; i++) {
                                    var ObjProjRisk = data[i];
                                    if (ObjProjRisk.ProjectRiskID == 0) {
                                        $("#txtProjectRiskId").val('');
                                    }
                                    else {
                                        $("#txtProjectRiskId").val(ObjProjRisk.ProjectRiskID);
                                    }

                                    $('#txtRiskDetailDateIdentifiedDisp').datepicker("setDate", new Date(ObjProjRisk.DateIdentified));
                                    $('#txtRiskDetailDateIdentified').datepicker("setDate", new Date(ObjProjRisk.DateIdentified));
                                    
                                    if (ObjProjRisk.ReviewNotificationDate != "" ) {
                                        $('#txtRiskDetailReviewNotificationDateDisp').datepicker("setDate", new Date(ObjProjRisk.ReviewNotificationDate));
                                        $('#txtRiskDetailReviewNotificationDate').datepicker("setDate", new Date(ObjProjRisk.ReviewNotificationDate));
                                    }
                                    else {
                                        $('#txtRiskDetailReviewNotificationDateDisp').val("");
                                        $('#txtRiskDetailReviewNotificationDate').val("");
                                    }
                                    $("#txtRiskDetailDescription").val(ObjProjRisk.Description);
                                    $("#txtRiskDetailNotes").val(ObjProjRisk.Notes);
                                    $("#cboRiskDetailRiskCategoryID").val(ObjProjRisk.RiskCategoryID);
                                    var curOriginalPriority = ObjProjRisk.OriginalPriority;
                                    var curChangePriority = ObjProjRisk.ChangePriority;
                                    if (curOriginalPriority == "") {
                                        curOriginalPriority = "Select Original Priority"
                                    }
                                    if (curChangePriority == "") {
                                        curChangePriority = "Select Change Priority"
                                    }

                                    /*Commented & Added By Dipali V On Priority Binding issue */
                                    //$("#cboRiskDetailOriginalPriority > option").each(function () {
                                    //    if (this.text == curOriginalPriority) {
                                    //        setFilterComboValue("cboRiskDetailOriginalPriority", this.value);
                                    //    }
                                    //});

                                    $("#cboRiskDetailOriginalPriority option").each(function () {
                                        if ($(this).text().trim().toLowerCase() == curOriginalPriority.toString().trim().toLowerCase()) {
                                            setFilterComboValue("cboRiskDetailOriginalPriority", $(this).val());
                                            return false; // stop once found
                                        }
                                    });

                                    //$("#cboRiskDetailChangePriority > option").each(function () {
                                    //    if (this.text == curChangePriority) {
                                    //        setFilterComboValue("cboRiskDetailChangePriority", this.value);
                                    //    }
                                    //});
                                    /*Commented & Added By Dipali V On Priority Binding issue */
                                    $("#cboRiskDetailChangePriority option").each(function () {
                                        if ($(this).text().trim().toLowerCase() == curChangePriority.toString().trim().toLowerCase()) {
                                            setFilterComboValue("cboRiskDetailChangePriority", $(this).val());
                                            return false; // stop once found
                                        }
                                    });

                                    $("#txtRiskDetailMagnitude").val(ObjProjRisk.Severity);

                                    $("#cboRiskDetailProbability").val(ObjProjRisk.Probability);
                                    $("#cboRiskDetailImpact").val(ObjProjRisk.Weight);
                                    $("#cboRiskDetailRiskSourceId").val(ObjProjRisk.RiskSourceId);

                                    setFilterComboValue("cboRiskDetailStatus", 0);
                                    var currStatus = ObjProjRisk.Status;
                                    //Added By Dipali V On 1st Oct 2025 For W26 Product enhancement WH-PM-IS-7003,WH-PM-IS-7004,WH-PM-IS-7005
                                    //Modified and added by Vishal Mane on 23/09/2025 to fix Issue as Probability, impact and Status value is getting wrong
                                    //$("#cboRiskDetailStatus > option").each(function () {
                                    //    if (this.text == currStatus) {
                                    //        setFilterComboValue("cboRiskDetailStatus", this.value);
                                    //    }
                                    //});
                                    $("#cboRiskDetailStatus option").each(function () {
                                        if ($(this).text().trim().toLowerCase() == currStatus.toString().trim().toLowerCase()) {
                                            setFilterComboValue("cboRiskDetailStatus", $(this).val());
                                            return false; // stop once found
                                        }
                                    });
                                    //End of Modified and added by Vishal Mane on 23/09/2025 to fix Issue as Probability, impact and Status value is getting wrong
                                    //End of Added By Dipali V On 1st Oct 2025 For W26 Product enhancement WH-PM-IS-7003,WH-PM-IS-7004,WH-PM-IS-7005
                                    currentResponsiblePerson = ObjProjRisk.PersonResponsible;

                                    setFilterComboValue("cboRiskDetailPersonResponsible", ObjProjRisk.PersonResponsibleId);
                                    setFilterComboValue("cboRiskDetailReviewer", ObjProjRisk.ReviewerId);
                                    flagTaskAssigned = ObjProjRisk.IsTaskAssigned;
                                }
                            }
                            StopAjaxLoader("#bodyPMRisk");
                        },
                        error: function (xhr, errorThrown) {                            
                            StopAjaxLoader("#bodyPMRisk");
                            window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                        },
                    });
                }
                else {
                    $(".Risktbl").dataTable().fnDestroy();
                    var riskHTML = "";
                    $(".Risktbl tbody").html(riskHTML);
                    tableRisk = $('.Risktbl').DataTable({
                        "pageLength": 5,
                        "bdestroy": true,
                        "lengthChange": false,
                        "bFilter": false,
                        "ordering": false,
                        "responsive": true,
                        //"scrollX": "100%",
                        "drawCallback": function (settings) {
                            $('[data-bs-toggle="tooltip"]').tooltip();
                            $('.dataTables_paginate').hide();
                        },
                        "columnDefs": [{ "orderable": false, "targets": [0] }]
                    });
                    $('.dataTables_paginate').hide();
                }
            }
            catch (ex) {
                //alert(ex.message);
            }
            clearTooltip();
        }
        function OpenBasicFilter() {
            //Start Script for edit basic filter           
            $(".stackbasicfilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("open");            
            //End Script for edit basic filter
        }
        function FilterApplied() {
            $(".mainclearalllink").removeClass("clsShowHide");
            $(".filter >  button").addClass("clsFilterHighlight");           
        }
        function FilterNotApplied() {
            $(".mainclearalllink").addClass("clsShowHide");
            $(".filter >  button").removeClass("clsFilterHighlight");
        }
        function setFilterComboValue(fieldName, fieldValue, flag) {
            if (flag == undefined) {
                $("#" + fieldName).removeClass("selectpicker");
                $("#" + fieldName).val(fieldValue);
                /*$("#" + fieldName).addClass("selectpicker");*/
                //$('.selectpicker').selectpicker('refresh');
            }
            if (flag == "class") {
                $("." + fieldName).removeClass("selectpicker");
                $("." + fieldName).val(fieldValue);
                /*$("." + fieldName).addClass("selectpicker");*/
                /*$('.selectpicker').selectpicker('refresh');*/
            }
        }
        function setFilterOpComboFieldValue(currWhereClause, arrFields, OpComboName, ValueComboName) {
            if (arrFields[1] == "LIKE" && currWhereClause.indexOf("%'") != -1 && currWhereClause.indexOf("'%") != -1) {
                setFilterComboValue(OpComboName, "Contains");

            }
            if (arrFields[1] == "notlike") {
                setFilterComboValue(OpComboName, "Not Contains");
            }

            if (arrFields[1] == "=") {
                setFilterComboValue(OpComboName, "Exact Word");
            }

            if (arrFields[1] == "LIKE" && currWhereClause.indexOf("%'") != -1 && currWhereClause.indexOf("'%") == -1) {
                setFilterComboValue(OpComboName, "Starts With");
            }

            if (arrFields[1] == "LIKE" && currWhereClause.indexOf("%'") == -1 && currWhereClause.indexOf("'%") != -1) {
                setFilterComboValue(OpComboName, "Ends With");
            }

            var currValue = arrFields[2].replace("'%", "");
            currValue = currValue.replace("%'", "");
            currValue = currValue.toString().trim();
            if (currValue.substring(currValue.length - 1) == "'") {
                currValue = currValue.substring(0, currValue.length - 1);
            }
            if (currValue.substring(0, 1) == "'") {
                currValue = currValue.substring(1);
            }
            //alert(currValue);
            //Added By Usha Pandit On 24.10.2020 For selecting correct drop down value
            currValue = currValue.toString().replace(/\"/g, "");
            //End Of Added By Usha Pandit On 24.10.2020 For selecting correct drop down value   
            $("#" + ValueComboName).val(currValue);
        }

        function setfiltervalues(QueryText) {

            var currWhereClause = QueryText.toString().trim();

            currValue = currWhereClause.toString().trim();
            if (currValue.substring(currValue.length - 1) == ")") {
                currValue = currValue.substring(0, currValue.length - 1);
            }
            if (currValue.substring(0, 1) == "(") {
                currValue = currValue.substring(1);
            }
            currWhereClause = currValue;

            if (currWhereClause.indexOf("NOT LIKE") != -1) {
                currWhereClause = currWhereClause.replace("NOT LIKE", "notlike");
            }

            var str = currWhereClause;
            
            //Added By Usha Pandit On 17.12.2020 For replacing " with ' sign
            str = str.toString().replace(/\"/g, "\'");  
            //End Of Added By Usha Pandit On 17.12.2020 For replacing " with ' sign
           
            var regex = /'[^"]+'|[^\s]+/g;
            result = str.match(regex);

            var str = result.toString();
            var arr = str.match(/('.*?'|[^',\s]+)(?=\s*,|\s*$)/g);
            //var arr = str.match(/(\([^\)]+\)|\S+|\s+)/);
            //var arr = str.match(/('.*?'|[^',\s]+[^(.*?),\s]+)(?=\s*,|\s*$)/g);
            for (var i = 0; i < arr.length; i++) {
                //alert(arr[i]);
            }

            var arrFields = currWhereClause.split(" ");
            arrFields = str.match(/('.*?'|[^',\s]+)(?=\s*,|\s*$)/g);
            if (arrFields[0] == "RiskCategoryID") {
                var currOpRiskCategory = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                //Added By Usha Pandit On 24.10.2020 For selecting correct drop down value
                currValue = currValue.toString().replace(/\"/g, "");
                //End Of Added By Usha Pandit On 24.10.2020 For selecting correct drop down value
                setFilterComboValue("cboPMFilterRiskCategoryID", currOpRiskCategory);
                setFilterComboValue("txtPMFilterRiskCategoryID", currValue);
            }
            if (arrFields[0] == "RiskSourceId") {
                var currOpRiskSource = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }

                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                //Added By Usha Pandit On 24.10.2020 For selecting correct drop down value
                currValue = currValue.toString().replace(/\"/g, "");
                //End Of Added By Usha Pandit On 24.10.2020 For selecting correct drop down value   
                setFilterComboValue("cboPMFilterRiskSourceId", currOpRiskSource);
                setFilterComboValue("txtPMFilterRiskSourceId", currValue);
            }

            if (arrFields[0] == "Status") {
                var currOpRiskStatus = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }

                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }

                setFilterComboValue("cboPMFilterStatus", currOpRiskStatus);

                $("#txtPMFilterStatus > option").each(function () {

                    if (this.text == currValue) {
                        setFilterComboValue("txtPMFilterStatus", this.value);
                    }
                });
            }
            if (arrFields[0] == "PersonResponsible") {
                var currOpPersonResponsible = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }

                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }
                
                //Added By Usha Pandit On 24.10.2020 For selecting correct drop down value
                currValue = currValue.toString().replace(/\"/g, "");
                //End Of Added By Usha Pandit On 24.10.2020 For selecting correct drop down value                 
                setFilterComboValue("cboPMFilterPersonResponsible", currOpPersonResponsible);

                $("#txtPMFilterPersonResponsible > option").each(function () {

                    if (this.text == currValue) {
                        //alert(this.text + ' ' + this.value);
                        setFilterComboValue("txtPMFilterPersonResponsible", this.value);
                    }
                });
            }

            if (arrFields[0] == "DateIdentified") {
                var currOpDateIdentified = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                if (currValue.substring(currValue.length - 1) == "'") {
                    currValue = currValue.substring(0, currValue.length - 1);
                }

                if (currValue.substring(0, 1) == "'") {
                    currValue = currValue.substring(1);
                }

                setFilterComboValue("cboPMFilterDateIdentified", currOpDateIdentified);

                $('#txtPMFilterDateIdentifiedDisp').datepicker("setDate", new Date(currValue));
                $('#txtPMFilterDateIdentified').datepicker("setDate", new Date(currValue));

            }

            try {
                if (arrFields[0] == "Probability") {
                    setFilterOpComboFieldValue(currWhereClause, arrFields, "cboPMFilterProbability", "txtPMFilterProbability");
                }
                if (arrFields[0] == "Weight") {
                    setFilterOpComboFieldValue(currWhereClause, arrFields, "cboPMFilterWeight", "txtPMFilterWeight");
                }
                if (arrFields[0] == "Severity") {
                    setFilterOpComboFieldValue(currWhereClause, arrFields, "cboPMFilterSeverity", "txtPMFilterSeverity");
                }
                if (arrFields[0] == "OriginalPriority") {
                    var currOpOriginalPriority = arrFields[1].toString().trim();
                    var currValue = arrFields[2].toString().trim();
                    if (currValue.substring(currValue.length - 1) == "'") {
                        currValue = currValue.substring(0, currValue.length - 1);
                    }
                    if (currValue.substring(0, 1) == "'") {
                        currValue = currValue.substring(1);
                    }                    
                    //Added By Usha Pandit On 24.10.2020 For selecting correct drop down value
                    currValue = currValue.toString().replace(/\"/g, "");
                    //End Of Added By Usha Pandit On 24.10.2020 For selecting correct drop down value                    
                    setFilterComboValue("cboPMFilterOriginalPriority", currOpOriginalPriority);
                    setFilterComboValue("txtPMFilterOriginalPriority", currValue);
                }
                if (arrFields[0] == "ChangePriority") {
                    var currOpChangePriority = arrFields[1].toString().trim();
                    var currValue = arrFields[2].toString().trim();
                    if (currValue.substring(currValue.length - 1) == "'") {
                        currValue = currValue.substring(0, currValue.length - 1);
                    }
                    if (currValue.substring(0, 1) == "'") {
                        currValue = currValue.substring(1);
                    }
                    //Added By Usha Pandit On 24.10.2020 For selecting correct drop down value
                    currValue = currValue.toString().replace(/\"/g, "");
                    //End Of Added By Usha Pandit On 24.10.2020 For selecting correct drop down value   
                    setFilterComboValue("cboPMFilterChangePriority", currOpChangePriority);
                    setFilterComboValue("txtPMFilterChangePriority", currValue);
                }
            }
            catch (ex) {
                //alert(ex.message);
            }
            if (arrFields[0] == "Notes") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboPMFilterNotes", "txtPMFilterNotes");
            }
            if (arrFields[0] == "ProjectRiskID") {
                var currOpProjectRiskID = arrFields[1].toString().trim();
                var currValue = arrFields[2].toString().trim();
                //Added By Usha Pandit On 24.10.2020 For selecting correct drop down value
                currValue = currValue.toString().replace(/\"/g, "");
                //End Of Added By Usha Pandit On 24.10.2020 For selecting correct drop down value   
                setFilterComboValue("cboPMFilterProjectRiskID", currOpProjectRiskID);
                setFilterComboValue("txtPMFilterProjectRiskID", currValue);
            }
            if (arrFields[0] == "Description") {
                setFilterOpComboFieldValue(currWhereClause, arrFields, "cboPMFilterDescription", "txtPMFilterDescription");
            }
        }
        //Edit filter
        function EditFilter(FilterID) {
            savedFilterName = "";
            ClearFilterDetails("edit");
            $.ajax({
                url: strUrl + '/api/PM_Risks/EditFilterData',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {                    
                    for (var i = 0; i < result.length; i++) {
                        var ObjFilterDtls = result[i];

                        var currentFilterName = ObjFilterDtls.FilterName;
                        currentFilterID = ObjFilterDtls.FilterId;
                        $("#txtFilterName").val(currentFilterName);
                        savedFilterName = currentFilterName;

                        if (ObjFilterDtls.QueryText.toString().indexOf("AND") != -1) {

                            var arrFields = ObjFilterDtls.QueryText.split("AND");
                            try {
                                for (var i = 0; i < arrFields.length; i++) {
                                    setfiltervalues(arrFields[i]);
                                }
                            }
                            catch (ex) {
                                //alert(ex.message);
                            }
                        }
                        else {
                            var currWhereClause = ObjFilterDtls.QueryText.toString();
                            setfiltervalues(currWhereClause);
                        }//else                        
                    }                  
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }

        //Delete filter
        function DeleteFilter(FilterID) {
            $.ajax({
                url: strUrl + '/api/PM_Risks/DeleteFilter',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {
                    if (result == null) {
                        alertify.set('notifier', 'position', 'top-right');
                        //Commented And Added By Reshma Chavan on 8th Dec 2020 For Rephrase alert
                        //alertify.success('<%= MyBase.GetResourceString("A_FDelete") %>');
                        alertify.success('Filter Deleted Successfully');
                         //End of Commented And Added By Reshma Chavan on 8th Dec 2020 For Rephrase alert
                        ClearFilterDetails("");
                        FilterNotApplied();
                        ChangeProject(1, 1);
                        getMyFilters(0);
                        currentappliedfilter = 0;
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }

        //Apply saved filter
        var currentappliedfilter = 0;
        var currentappliedfilterclause = '';
        function ApplySavedFilter(FilterID, isDefault) {
            if (isDefault == undefined || isDefault == 2) {
                currentappliedfilter = FilterID;
            }


            

            $.ajax({
                url: strUrl + '/api/PM_Risks/GetWhereClauseOfFilter',
                method: 'Post',
                data: JSON.stringify(FilterID),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (FilterID) {
                        xhr.setRequestHeader("Params", encryptString(isJson(FilterID) ? FilterID : JSON.stringify(FilterID)));
                    }
                },
                success: function (result) {
                    var Querytext = result;
                    if (isDefault == 3) {
                        Querytext = "";
                        getMyFilters(0);
                        currentappliedfilter = 0;
                    }
                    currentappliedfilterclause = Querytext;
                    getRiskDetails(currentselectedProjectID, 0, "", "defaultfilterapply", Querytext);
                    if (isDefault != 3) {
                        FilterApplied();
                    } else {
                        FilterNotApplied();
                    }
                    if (currentDefaultFilterID == 0 || isDefault == undefined || isDefault == 2) {
                        getMyFilters(0);
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }

        //To set the default filter.
        function SetDefaultFilter(FilterID, flag) {
            var removeDefault = 0;
            if (flag == "default") {
                removeDefault = 1;
            }
            var Parameters = {
                ProjectID: encodeURI(currentselectedProjectID),
                LoginType: encodeURI(SessionLoginType),
                EmployeeID: encodeURI(SessionEmployeeId),
                TagID: encodeURI(TagID),
                FilterID: FilterID,
                Flag: removeDefault
            }

            $.ajax({
                url: strUrl + '/api/PM_Risks/SetDefaultFilter',
                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (result) {
                    alertify.set('notifier', 'position', 'top-right');
                    if (removeDefault == 0) {
                        //Commented and Added By Reshma Chavan on 8th Dec 2020 For Filter alert Rephrase Issue
                        //alertify.success('<%= MyBase.GetResourceString("A_FDefault") %>');
                        alertify.success('Default Filter Set successfully.');
                        //End of Commented and Added By Reshma Chavan on 8th Dec 2020 For Filter alert Rephrase Issue                       

                        ApplySavedFilter(FilterID, 2);
                    }
                    else {
                         //Commented and Added By Reshma Chavan on 8th Dec 2020 For Filter alert Rephrase Issue
                        //alertify.success('<%= MyBase.GetResourceString("A_RDefault") %>');
                        alertify.success('Default Filter Removed Successfully');
                         //End of Commented and Added By Reshma Chavan on 8th Dec 2020 For Filter alert Rephrase Issue
                        FilterNotApplied();
                        ChangeProject(1, 1);
                        getMyFilters(0);
                        currentappliedfilter = 0;
                    }
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
        }

        function getMyFilters(flag) {
            var Parameters = {
                ProjectID: encodeURI(currentselectedProjectID),
                TagID: encodeURI(TagID),
                LoginType: encodeURI(SessionLoginType),
                EmployeeID: encodeURI(SessionEmployeeId)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Risks/GetMyFilters',

                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {
                    var strHTML = "";
                    var defaultFilterId = 0;
                    $("#MyFiltersdropdown").empty();
                    if ($("#MyFiltersdropdown").hasClass("dropdown-menu")) {

                    }
                    else {
                        $("#MyFiltersdropdown").addClass("dropdown-menu");
                    }

                    if (data.length != 0) {

                        for (var i = 0; i < data.length; i++) {

                            var ObjMyFilter = data[i];
                            strHTML += "<li>";

                            if (ObjMyFilter.SetDefault == "True") {
                                defaultFilterId = ObjMyFilter.FilterId;
                                currentDefaultFilterID = defaultFilterId;
                                strHTML += "<label class='customradio'>";

                                strHTML += "<input class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-bs-placement='bottom' id='" + ObjMyFilter.FilterId + "' type='checkbox' name='project2' onchange='SetDefaultFilter(this.id,&quot;default&quot;)' checked='checked'>";
                                strHTML += "<span data-bs-toggle='tooltip' data-bs-placement='right' title='Set Default filter' class='checkmark'></span>";
                                strHTML += "</label>";

                            }
                            else {
                                strHTML += "<label class='customradio'>";
                                strHTML += "<input class='myfilter_selectprocheckbox' data-bs-toggle='tooltip' data-bs-placement='bottom' id='" + ObjMyFilter.FilterId + "' type='checkbox' name='project2' onchange='SetDefaultFilter(this.id,&quot;&quot;)'>";
                                strHTML += "<span data-bs-toggle='tooltip' data-bs-placement='right' title='Set Default filter' class='checkmark'></span>";
                                strHTML += "</label>";
                            }

                            strHTML += "<label class=''>";
                            strHTML += "<span for='project2' class='radiotextsty filtername'>" + ObjMyFilter.FilterName + "</span>";
                            strHTML += "</label>";

                            strHTML += "<div class='issfilter_actiondropdown'>";
                            var blnApply = false;
                            if (currentappliedfilter != 0) {
                                if (currentappliedfilter == ObjMyFilter.FilterId) {
                                    blnApply = true;
                                }
                            }

                            if (ObjMyFilter.SetDefault == "True") {
                                strHTML += "<div class='custom_chckbox_markblue'>";
                                if (currentappliedfilter != 0) {
                                    if (blnApply == true) {
                                        strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name='' >";
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                    }
                                    else {
                                        strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name='' >";
                                        strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                    }
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name='' >";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                }                                

                                strHTML += "</div>";
                            }
                            else {
                                strHTML += "<div class='custom_chckbox_markblue'>";
                                if (blnApply == true) {                                    
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' checked='' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Applied filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id,3)'></label>";
                                }
                                else {
                                    strHTML += "<input id='RiskselproOne_" + ObjMyFilter.FilterId + "' type='checkbox' name=''>";
                                    strHTML += "<label class='clsHideTooltip' data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Apply filter' for='RiskselproOne_" + ObjMyFilter.FilterId + "' id='" + ObjMyFilter.FilterId + "' onclick='ApplySavedFilter(this.id)'></label>";
                                }
                                

                                strHTML += "</div>";
                            }

                            strHTML += "<span onclick='OpenBasicFilter()' class='edit_filter'>";

                            strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Edit filter' id='" + ObjMyFilter.FilterId + "' class='fas fa-pencil-alt' onclick='EditFilter(this.id);'></i>";

                            strHTML += "</span>";

                            strHTML += "<span>";

                            strHTML += "<i data-bs-toggle='tooltip' data-bs-container='body' data-bs-placement='bottom' title='Delete filter' id='" + ObjMyFilter.FilterId + "' class='far fa-trash-alt' onclick='DeleteFilter(this.id);'></i>";

                            strHTML += "</span>";

                            strHTML += "</div>";

                            strHTML += "</li>";
                        }

                        $("#MyFiltersdropdown").html(strHTML);

                        if (strHTML != "" && defaultFilterId != 0 && flag != 0) {
                            ApplySavedFilter(defaultFilterId, 1);
                        }

                        $("#MyFiltersdropdown").removeClass("clsShowHide");
                    }
                    else {
                        $("#MyFiltersdropdown").addClass("clsShowHide");
                        $("#MyFiltersdropdown").removeClass("dropdown-menu");
                    }
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
            clearTooltip();
        }

        function FillProjectCombox() {
            
            var sessionproj = 0;
            sessionproj = selectedProjectID; 
            if (selectedProjectID == "") {
                sessionproj = 0;
            }
            
            var Parameters = {
                EmployeeId: encodeURI(SessionEmployeeId),
                ProjectId: encodeURI(sessionproj),
                LoginType: encodeURI(SessionLoginType)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Risks/GetProjectID',

                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("cboAccessibleProjects");
                    $("#cboAccessibleProjects option").remove();

                    if (data.length != 0) {
                        for (var i = 0; i < data.length; i++) {

                            var ObjAccessProj = data[i];

                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);

                            if (selectedProjectID == ObjAccessProj.ProjectId) {                                
                                objOption.text = ObjAccessProj.ProjectName;
                                objOption.value = ObjAccessProj.ProjectId;
                            }
                            else {                                
                                objOption.text = ObjAccessProj.ProjectName;
                                objOption.value = ObjAccessProj.ProjectId;
                            }
                            if (ObjAccessProj.ProjectId == "0") {
                                objOption.text = "Select Project";
                            }
                        }
                    }
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
            if (selectedProjectID != null && selectedProjectID != undefined && selectedProjectID != "") {
                $("#cboAccessibleProjects").val(selectedProjectID);
            }
        }

        function FillModuleCombox() {
            var PMModuleParameter = {
                ProjectID: encodeURI(currentselectedProjectID),
                ModuleID: 0,
                Mode: 'A',
                TaskID: 0
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Risks/GetProjectModules',

                method: 'Post',
                data: JSON.stringify(PMModuleParameter),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMModuleParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMModuleParameter) ? PMModuleParameter : JSON.stringify(PMModuleParameter)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("cboModuleID");
                    $("#cboModuleID option").remove();

                    var objOption = document.createElement("OPTION");
                    objOption.text = "";
                    objOption.value = 0;
                    objCbo1.options.add(objOption);

                    if (data.length != 0) {
                        for (var i = 0; i < data.length; i++) {

                            var ObjProjModule = data[i];

                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);

                            objOption.text = ObjProjModule.ModuleName;
                            objOption.value = ObjProjModule.ModuleID;
                        }
                    }
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
        }
        function FillSubProjectCombox() {
            var PMSubProjectParameter = {
                ProjectID: encodeURI(currentselectedProjectID),
                SubProjectID: 0,
                Mode: 'T',
                TaskID: 0
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Risks/GetSubProjectDetails',

                method: 'Post',
                data: JSON.stringify(PMSubProjectParameter),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMSubProjectParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMSubProjectParameter) ? PMSubProjectParameter : JSON.stringify(PMSubProjectParameter)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("cboSubProjectID");
                    $("#cboSubProjectID option").remove();

                    var objOption = document.createElement("OPTION");
                    objOption.text = "";
                    objOption.value = 0;
                    objCbo1.options.add(objOption);

                    if (data.length != 0) {
                        for (var i = 0; i < data.length; i++) {

                            var ObjProjModule = data[i];

                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);

                            objOption.text = ObjProjModule.SubProjectName;
                            objOption.value = ObjProjModule.SubProjectID;
                        }
                    }
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
        }
        function FillMilestoneCombox() {
            var PMMilestoneParameter = {
                ProjectID: encodeURI(currentselectedProjectID),
                Mode: 'T',
                TaskID: 0
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Risks/GetMilestoneDetails',

                method: 'Post',
                data: JSON.stringify(PMMilestoneParameter),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMMilestoneParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMMilestoneParameter) ? PMMilestoneParameter : JSON.stringify(PMMilestoneParameter)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("cboMilestoneID");
                    $("#cboMilestoneID option").remove();

                    var objOption = document.createElement("OPTION");
                    objOption.text = "";
                    objOption.value = 0;
                    objCbo1.options.add(objOption);

                    if (data.length != 0) {
                        for (var i = 0; i < data.length; i++) {

                            var ObjProjModule = data[i];

                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);

                            objOption.text = ObjProjModule.Milestone;
                            objOption.value = ObjProjModule.MilestoneID;
                        }
                    }
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
        }
        function FillChangeRequestCombox() {
            var PMChangeRequestParameter = {
                ProjectID: encodeURI(currentselectedProjectID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Risks/GetChangeRequestDetails',

                method: 'Post',
                data: JSON.stringify(PMChangeRequestParameter),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMChangeRequestParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMChangeRequestParameter) ? PMChangeRequestParameter : JSON.stringify(PMChangeRequestParameter)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("cboChangeRequestID");
                    $("#cboChangeRequestID option").remove();

                    var objOption = document.createElement("OPTION");
                    objOption.text = "";
                    objOption.value = 0;
                    objCbo1.options.add(objOption);

                    if (data.length != 0) {
                        for (var i = 0; i < data.length; i++) {

                            var ObjProjModule = data[i];

                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);

                            objOption.text = ObjProjModule.ChangeRequestSummary;
                            objOption.value = ObjProjModule.ChangeRequestID;
                        }
                    }
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
        }
        function FillUserStoryCombox() {
            var PMUserStoryParameter = {
                ProjectID: encodeURI(currentselectedProjectID)
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Risks/GetUserStoryDetails',

                method: 'Post',
                data: JSON.stringify(PMUserStoryParameter),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMUserStoryParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMUserStoryParameter) ? PMUserStoryParameter : JSON.stringify(PMUserStoryParameter)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("cboUserStory");
                    $("#cboUserStory option").remove();

                    var objOption = document.createElement("OPTION");
                    objOption.text = "";
                    objOption.value = 0;
                    objCbo1.options.add(objOption);

                    if (data.length != 0) {
                        for (var i = 0; i < data.length; i++) {

                            var ObjProjModule = data[i];

                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);

                            objOption.text = ObjProjModule.UserStoryName;
                            objOption.value = ObjProjModule.UserStoryID;
                        }
                    }
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
        }
        function FillFeatureCombox() {
            var PMFeatureParameter = {
                ProjectID: encodeURI(currentselectedProjectID),
                SubProjectID: 0,
                Mode: 'T',
                TaskID: 0
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Risks/GetFeatureDetails',

                method: 'Post',
                data: JSON.stringify(PMFeatureParameter),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (PMFeatureParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(PMFeatureParameter) ? PMFeatureParameter : JSON.stringify(PMFeatureParameter)));
                    }
                },
                success: function (data) {
                    var objCbo1 = document.getElementById("cboProjectFeatureID");
                    $("#cboProjectFeatureID option").remove();

                    var objOption = document.createElement("OPTION");
                    objOption.text = "";
                    objOption.value = 0;
                    objCbo1.options.add(objOption);

                    if (data.length != 0) {
                        for (var i = 0; i < data.length; i++) {

                            var ObjProjModule = data[i];

                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);

                            objOption.text = ObjProjModule.FeatureName;
                            objOption.value = ObjProjModule.ProjectFeatureID;
                        }
                    }
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
        }
        function FillReponsiblePersonComboNew(FieldName, Index) {
            var strResponsiblePersonHTML = '';
            var curRiskId = 0;
            if (Index == 0) {
                curRiskId = 0;
            }
            else {
                curRiskId = currentRiskID;
            }
            var Parameters = {
                ProjectId: encodeURI(currentselectedProjectID),
                RiskID: curRiskId,
                Parameter: 'R'
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Risks/GetResponsiblePerson',

                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (resultResponsiblePerson) {
                    try {

                        strResponsiblePersonHTML += '<select id="' + FieldName + "_" + Index + '" name="' + FieldName + "_" + Index + '" tabindex="1" class="form-control planRispPerson">';

                        if (resultResponsiblePerson.length > 0) {
                            strResponsiblePersonHTML += '<option title = "" value = "0"></option>';
                            for (var i = 0; i < resultResponsiblePerson.length; i++) {
                                var ObjResponsiblePerson = resultResponsiblePerson[i];
                                var ResponsiblePerson = ObjResponsiblePerson.UserName;

                                strResponsiblePersonHTML += '<option title="' + ResponsiblePerson + '" value="' + ResponsiblePerson + '">' + ResponsiblePerson + '</option>';
                            }
                        }
                        strResponsiblePersonHTML += '</select>';                        
                    }
                    catch (ex) {
                        //alert(ex.message);
                    }
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
            return strResponsiblePersonHTML;
        }
        function FillReponsiblePersonCombo(curProjectId, arrcboFieldName, PlanId) {
            //In edit mode, released resources
            //and inactive resources should not be displayed so passing Riskid and parameter 'R'
            //to check if resource is released, will not be displayed in dropdwon 
            //but if released resource is mapped to any riskid resource will be displayed only for that risk

            var Parameters = {
                ProjectId: encodeURI(curProjectId),
                RiskID: currentRiskID,
                Parameter: 'R'
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Risks/GetResponsiblePerson',

                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                success: function (data) {
                    if (data.length != 0) {
                        for (var i = 0; i < arrcboFieldName.length; i++) {

                            var objCbo = document.getElementById(arrcboFieldName[i]);

                            $("#" + arrcboFieldName[i] + " option").remove();
                            var currentEmpField = arrcboFieldName[i];
                            var objOption = document.createElement("OPTION");

                            if (arrcboFieldName[i] == "cboRiskDetailPersonResponsible" || arrcboFieldName[i] == "txtPMFilterPersonResponsible") {
                                objOption.text = "Select Responsible Person";
                            }
                            
                            if (arrcboFieldName[i] == "cboRiskDetailReviewer") {
                                objOption.text = "Select Reviewer";
                            }
                            
                            objOption.value = 0;

                            objCbo.options.add(objOption);
                            for (var j = 0; j < data.length; j++) {

                                var ObjPersonResponsible = data[j];
                                var ResponsiblePerson = ObjPersonResponsible.UserName;
                                var ResponsiblePersonId = ObjPersonResponsible.EmployeeID;

                                var objOption = document.createElement("OPTION");

                                objCbo.options.add(objOption);

                                objOption.text = ResponsiblePerson;
                                objOption.value = ResponsiblePersonId;
                                if (arrcboFieldName[i] == "txtPMFilterPersonResponsible") {
                                    objOption.text = ResponsiblePerson;
                                    objOption.value = ResponsiblePerson;
                                }
                            }

                            if (PlanId != undefined && PlanId != "") {
                                var currentTDId = "cboPMResponsiblePerson_" + PlanId;
                                var vals = $("#" + currentTDId).val();

                                $("#" + currentEmpField + " > option").each(function () {

                                    if (this.text == vals) {
                                        $("#" + currentEmpField).val(this.value);
                                    }
                                });
                            }
                        }
                    }
                    else {
                        for (var i = 0; i < arrcboFieldName.length; i++) {
                            var objCbo = document.getElementById(arrcboFieldName[i]);
                            $("#" + arrcboFieldName[i] + " option").remove();
                            var objOption = document.createElement("OPTION");
                            objOption.text = "";
                            objOption.value = 0;

                            objCbo.options.add(objOption);
                        }
                    }
                },
                error: function (xhr, errorThrown) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                },
            });
        }

        function FillStatusCombox() {
            try {

                $.ajax({
                    url: strUrl + '/api/PM_Risks/GetRiskStatus',

                    method: 'Post',
                    data: JSON.stringify({}),
                    dataType: "json",
                    async: false,
                    contentType: "application/json",  /*;charset-utf=8*/
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    },
                    success: function (data) {

                        var objCbo1 = document.getElementById("txtPMFilterStatus");
                        $("#txtPMFilterStatus option").remove();

                        if (data.length != 0) {
                            for (var i = 0; i < data.length; i++) {

                                var ObjRiskStatus = data[i];
                                var RiskStatus = ObjRiskStatus.Status;

                                var objOption = document.createElement("OPTION");
                                objCbo1.options.add(objOption);

                                if (ObjRiskStatus.Status == "Select Status") {
                                    objOption.text = RiskStatus;
                                    objOption.value = 0;
                                }
                                else {
                                    objOption.text = RiskStatus;
                                    objOption.value = RiskStatus;
                                }
                            }
                        }

                    },
                    error: function (xhr, errorThrown) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + xhr + "";
                    },
                });
            }
            catch (ex) {
                //alert(ex.message);
            }
        }
        //End Of Added By Usha Pandit On 18.09.2019 for getting accessible projects in Project drop down

        //Added by Ajit L on 13/11/2024 for exe file containing file upload restriction
        //function validateDocFileForExe(file) {
        //    return new Promise((resolve, reject) => {
        //        const reader = new FileReader();
        //        reader.onload = function (e) {
        //            const arrayBuffer = e.target.result;
        //            const uint8 = new Uint8Array(arrayBuffer);
        //            // Function to search for a specific byte sequence
        //            const containsSignature = (signature) => {
        //                for (let i = 0; i < uint8.length - signature.length + 1; i++) {
        //                    let found = true;
        //                    for (let j = 0; j < signature.length; j++) {
        //                        if (uint8[i + j] !== signature[j]) {
        //                            found = false;
        //                            break;
        //                        }
        //                    }
        //                    if (found) return true;
        //                }
        //                return false;
        //            };
        //            // Check for 'MZ' signature (common for Windows EXE files)
        //            const mzSignature = [0x4D, 0x5A]; // 'M' 'Z'
        //            if (containsSignature(mzSignature)) {
        //                reject("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
        //                return;
        //            }
        //            // Additional checks can be added here (e.g., searching for .exe strings)
        //            // Example: Check for ".exe" string in ASCII
        //            const exeString = [0x2E, 0x65, 0x78, 0x65]; // '.' 'e' 'x' 'e'
        //            if (containsSignature(exeString)) {
        //                reject("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
        //                return;
        //            }
        //            // If no signatures are found, the file is considered safe
        //            resolve();
        //        };
        //        reader.onerror = function () {
        //            reject("Error reading the file. Please try again.");
        //        };
        //        // Read the file as an ArrayBuffer
        //        reader.readAsArrayBuffer(file);
        //    });
        //}
        //Added by Ajit L on 13/11/2024 for exe file containing file upload restriction
        //start bootstrap datepicker css  
        $('#mnthfield1').datepicker({
            autoclose: true,
            changeYear: true, //added by pradip on 09-04-2020
        });

        // Delete row on delete button click
        $(document).on("click", ".delattachbtn", function () {
            //Commented By Usha Pandit On 06.11.2019 For not removing row after clicking on delete button of document or closing delete modal popup 
            //$(this).parents("tr").remove();
            //End Of Commented By Usha Pandit On 06.11.2019 For not removing row after clicking on delete button of document or closing delete modal popup 
            //$(".add-new").removeAttr("disabled");
        });

        //add attachment end here

        //select file
        $(document).on('click', '.browse', function () {
            var file = $(this).parent().parent().parent().find('.file');
            file.trigger('click');
        });
        $(document).on('change', '.file', function () {
            $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
        });

        //start script - Name lenght of task closure step


//Add attachment script end here
        //Attachment Section Ends

        function closetskinfobox() {
            $('.riskmatrixpopup img.closetskinfobox').click(function () {
                $(".riskmatrixpopup").find("ul.dropdown-menu").removeClass("show");
            });
        }


        $(document).on("mouseout", 'th span, .ui-corner-all', function () {
            $(".tooltip").remove();
        });
        
    </script>
</head>
    <style type="text/css">
        .table-scrollable {
            height: 300px;
        }

        .issuefilter_container {
            margin-bottom: 10px;
            background: #fff;
        }

        .stackbasicfilter .box > .form-group {
            margin-bottom: 5px;
        }

        div#DataTables_Table_0_info {
            float: left;
            padding-left: 15px;
        }

        div.dataTables_wrapper div.dataTables_paginate {
            margin: 0 15px 15px;
            white-space: nowrap;
            text-align: right;
            float: right;
        }

        .dataTables_scroll {
            margin-bottom: 10px;
            border-bottom: 1px solid #ddd;
        }
        
        .clsShowHide {
            display: none !important;
        }

        .clsDisablePointer {
            pointer-events: none !important;
        }

        .clsEnablePointer {
            pointer-events: initial !important;
        }

        .clsNoAccess {
            cursor: no-drop;
        }

        /*::-webkit-scrollbar {
            display: none;
        }

        */
        /*body { overflow:hidden;
        }*/
        .input-group-btn button.btn.btncalendar { padding:4px 12px;
        }       

        .dataTables_paginate a.paginate_button.current {
            background: #1359a6;
            transition: 0.4s ease-in-out 0s;
            color: #fff;
            cursor: pointer;
        }


         /* Added by Vyankat B. on 1st April 2026 for highlighting the filter button when clicked */
     
        .mainfilter button[aria-expanded="true"] {
            background: #1359a6;
            color: #fff;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }
        /* End of Added by Vyankat B. on 1st April 2026 for highlighting the filter button when clicked */ 

        .filter button[aria-expanded="true"] {
            background: none;
            color: #464a4c;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px;
        }

        .clsFilterHighlight {
            background: #1359a6 !important;
            color: #ffffff !important;
        }
       
        [data-id="cboPMFilterDescription"], [data-id="cboPMFilterNotes"], [data-id="cboPMFilterProjectRiskID"], [data-id="cboPMFilterRiskCategoryID"], [data-id="cboPMFilterDateIdentified"], [data-id="txtPMFilterRiskCategoryID"], [data-id="cboPMFilterOriginalPriority"], [data-id="txtPMFilterOriginalPriority"], [data-id="cboPMFilterChangePriority"], [data-id="txtPMFilterChangePriority"], [data-id="cboPMFilterProbability"], [data-id="cboPMFilterWeight"], [data-id="cboPMFilterSeverity"], [data-id="cboPMFilterRiskSourceId"], [data-id="txtPMFilterRiskSourceId"], [data-id="cboPMFilterStatus"], [data-id="txtPMFilterStatus"], [data-id="cboPMFilterPersonResponsible"], [data-id="txtPMFilterPersonResponsible"] {
            height: 28px !important;
        }

        .stackbasicfilter .form-inline .btn-group {
            padding: 0;
        }

        #riskhistory table tr td:first-child {
            text-align: center;
        }

        #RiskPlantbl tbody tr td:nth-child(2) {
            width: 25% !important;
        }

        div#RDpanel {
            border-top: 15px solid #eee;
            height: 81vh;
        }

        .Risktbl td a i {
            color: #464a4c;
        }

        .Risktbl tbody tr td:nth-child(2) {
            width: 25% !important;
        }
        .Risktbl tbody tr td:nth-child(3) {
            width: 5% !important;
        }
        .Risktbl tbody tr td:nth-child(7) {
            width: 5% !important;
        }
        /*.Risktbl tbody tr td:nth-child(2) {
            width: 25% !important;
        }*/
        .lrgtext {
            text-align: left; word-wrap:break-word;
        }

        .Riskdetailpanel.collapse {
            transition: height 0.01s;
        }
        /*table.table td .add {display: none;}*/
        /*table.table tbody tr:last-child td .edit{ display: none; }*/
        #riskplan th {
            vertical-align: middle;
        }

        table.table td .add {
            display: none;
        }

        table.table td .cancelrowvalue {
            display: none;
        }

        /*.RiskPlantbl tr:last-child select {
            width: 100px;
            margin: 0 auto;
        }

        #riskplan th:last-child {
            width: 100px;
            min-width: 70px;
        }

        #riskplan th:nth-child(3) {
            width: 70px !important;
            min-width: 70px;
        }

        #riskplan th {
            width: 70px !important;
            min-width: 70px;
        }*/

        .RiskPlantbl tr:last-child .form-control {
            margin: 0 auto;
        }
		/*Commented and added new by Nilesh P on 30 Jul 2020*/
        /*.clsWidth {
            width: 200px !important;
        }

        .clsPlanWidth {
            width: 160px !important;
        }

        .clsTaskWidth {
            width: 140px !important;
        }

        .clsDateWidth {
            width: 110px !important;
        }*/
        
        
        .clsWidthArrow {
            padding-right: 5px;
        }

        .clsWidth {
            /*width:200px !important;*/
            width: 110px !important;
        }

        .clsPlanWidth {
            /*width: 160px !important;*/
            width: 170px !important;
        }

        .clsTaskWidth {
            /*width: 140px !important;*/
            width: 180px !important;
        }
        
        .clsDateWidth {
            width: 80px !important;
        }
        /*Commented and added new by Nilesh P on 30 Jul 2020*/
        .clsDateGroupWidth {
            width: 160px !important;
        }

        .tool-tip {
            display: inline-block;
        }

            .tool-tip [disabled] {
                pointer-events: none;
            }

        .clsDateColor {
            background-color: white !important;
        }
        .editRDpanel > a, .editRDpanel > div, .editRDpanel > button {
            display: inline-block;
        }
        .tooltip-inner {
            min-width: 100px;
            max-width: 600px;
            word-break: break-word;
            z-index: 9999999;
            white-space: normal;
            word-wrap: break-word;
            height: auto;
        }
        .alertify-notifier.ajs-right { z-index:99999;}

        .ui-datepicker select {
            outline: none;
            overflow: hidden;
            text-indent: 0.01px;
            background: url("../../../Whizible2.0-new/dist/img/dropdown-arrow.svg") no-repeat 95% !important;
            -webkit-appearance: none;
            -moz-appearance: none;
            -ms-appearance: none;
            -o-appearance: none;
            appearance: none;
            background-size: 10px !important;
            appearance: none;
            padding-right: 21px !important;
        }
        @media all and (-ms-high-contrast:none) {
            select {
                padding-right: 30px !important;
            }
            /* IE10 */

        }
 _:-ms-fullscreen, :root select { padding-right: 30px!important; background-position-x:108% !important; background-size:52px !important;}
  _:-ms-fullscreen, :root select.planRispPerson { background-size:30px !important;}
        select::-ms-expand {
            display: none;
        }
        /*Added By Usha Pandit On 05.11.2019 For break long word in alertify*/
        .ajs-success {
            overflow-wrap: break-word !important;
            word-wrap: break-word !important;
        }
        /*End Of Added By Usha Pandit On 05.11.2019 For break long word in alertify*/

/*New styele added by pradip on20-03-2020*/
.stacktabdetail .tab-pane{position:relative;}
.tab-pane .btnlistinline {
    margin: 10px 0 0;
    padding: 0;
    position: absolute;
    top: -56px;
    right: 15px;
}/*End styles added by pradip on20-03-2020*/


 select {
  width: 200px;
  max-width: 100%;
  /* So it doesn't overflow from it's parent */
}

option {
  /* wrap text in compatible browsers */
  -moz-white-space: pre-wrap;
  -o-white-space: pre-wrap;
  white-space: pre-wrap;
  /* hide text that can't wrap with an ellipsis */
  overflow: hidden;
  text-overflow: ellipsis;
  /* add border after every option */
  border-bottom: 1px solid #DDD;
}
/*Added by Chetan M on 24th Jully 2020 for IssueID = 24536*/
        .cboRiskCategory1 {
        max-width: 130px;
        }
        /*End of Added by Chetan M on 24th Jully 2020 for IssueID = 24536*/
 		
        /*Added By Usha Pandit On 05.11.2020 For Add Plan Button border display issue*/
        .clsBorder {
            border-bottom: 5px solid transparent!important;
            border-left: 5px solid transparent!important;
            border-right: 5px solid transparent!important;
        }
        /*End Of Added By Usha Pandit On 05.11.2020 For Add Plan Button border display issue*/

        /*Added By Pradip P on 10 Jun 2021*/ 
        #atchmentTableBody tr td {
            word-break: break-word;
        }
        /*End of Added By Pradip P on 10 Jun 2021*/ 

        .w140{width:140px!important;margin-right:0!important}
        .modal-header{display:block}
        .show{display:revert!important}

        #ui-datepicker-div .ui-datepicker-header .ui-datepicker-prev .tooltip.show{display:none!important;opacity:0!important
        }
        .selectWidth{
            width: 160px;
        }
        /* Added By Gauri On 04th Sep 2024 For Alignment Issue */
        /* .issfilter_actiondropdown {
            position: relative;
            top: 0;
            right: 0;
        }*/
        .show {
            display: block !important;
        } 
        /* End of Added By Gauri On 04th Sep 2024 For Alignment Issue */
        
    </style>
<body id="bodyPMRisk" class="hold-transition skin-blue-light sidebar-mini fixed">
    <div id="divPMRisk">
        <div class="graybg container-fluid pt-1 pb-1 statckmainheader">
            <div class="row">
                <div class="col-sm-3">
                    <% CommonFunctions.HTMLControls.DrawComboBox("cboAccessibleProjects", "SELECT 1",,, "class='form-control bgwhite' onChange='ChangeProject(1, 0)'",,, ) %>
                </div>
                <div class="col-sm-9 form-inline text-end">
                    <div class="form-group riskmatrixpopup">
                        <button type="button" class="btn btn-default nostylebtn dropdown-toggle" data-bs-toggle="dropdown" onclick="plotRiskMatrix()">                            
                            <img src="../../../Whizible2.0-new/dist/img/risk-matrix.svg" alt="" width="22px" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-container="body" title="Click here to view Risk Matrix">
                        </button>
                        <ul class="dropdown-menu" role="menu">
                            <li>
                                <button class="btn borderbtn riskmatrixbtn" style="pointer-events: none;"><%= MyBase.GetResourceString("C_RiskMatrix") %></button>
                                
                                <button class="nostylebtn float-end" data-bs-toggle="toggle">
                                    <img class="closetskinfobox" src="../../../Whizible2.0-new/dist/img/close-gray.svg" alt="" width="22px;" onclick="closetskinfobox()"></button>

                                <div class="riskmatrixtbl" id="">
                                    <table class="table table-bordered table-responsive RiskMatrixtbl" id="rMatrix">
                                        <thead>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>

                            </li>
                        </ul>
                    </div>                    
                    <div class="form-group dropdown" id="divRiskCategory" style="display:inline-flex;margin-right:-10px">
                        <% CommonFunctions.HTMLControls.DrawComboBox("cboRiskCategory", "usp_Whizible2_Sel_tbl_PM_RiskCategories",,, " class='form-control bgwhite clsRiskCombo cboRiskCategory1 w140 pr-1' onChange='ChangeProject(2, 0)'",,,) %>
                        <div id="tooltip_container"></div>
                    </div>
                    
                    <div class="form-group dropdown" id="divRiskStatus">
                        <% CommonFunctions.HTMLControls.DrawComboBox("cboRiskStatus", "usp_Whizible2_Sel_tbl_PM_RiskStatus",,, "class='form-control bgwhite' onChange='ChangeProject(3, 0)'",,, ) %>
                    </div>

                    <div class="form-group">
                        <a href="javascript:;" class="mainclearalllink"><strong><%= MyBase.GetResourceString("C_ClearAll") %></strong></a>
                    </div>
                    <div class="form-group">
                        <div class="filter mainfilter float-end col-sm-offset-1">
                            <%--Commented And Added By Usha Pandit On 05.11.2019 For Filter Tooltip--%>
                            <%--<button data-bs-toggle="collapse" data-bs-target="#filterpanel"><i data-bs-toggle="tooltip" data-bs-placement="bottom" title="Advanced Filter" class="fas fa-filter"></i></button>--%>
                            <button data-bs-toggle="collapse" data-bs-target="#filterpanel"><i data-bs-toggle="tooltip" data-bs-placement="bottom" title="Filter" class="fas fa-filter"></i></button>
                            <%-- End Of Added By Usha Pandit On 05.11.2019 For Filter Tooltip--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--Filter Starts--%>
        <!--filter_panel_section_satrts_here-->
        <div id="filterpanel" class="collapse filterpanel">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                <div class="row">
                    <div class="col-md-7 col-sm-7">
                        <div class="cust_tabpanel">
                            <ul class="nav nav-tabs">
                                <li class="dropdown"><a class="dropdown-toggle" href="#" data-bs-toggle="dropdown"><%= MyBase.GetResourceString("C_MyFilters") %> <span class="caret"></span></a>
                                    <%--<li class="dropdown"><a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" >My Filters  <span class="caret"></span></a>--%>
                                    <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                    </ul>
                                </li>
                                <li id="tabpresetfilter"><a href="#presetfilter" data-bs-toggle="tab"><%= MyBase.GetResourceString("C_BasicFilters") %></a>
                                </li>

                                <%--</li>--%>
                            </ul>
                        </div>
                    </div>
                    <div class="col-md-5 col-sm-5">
                    </div>
                </div>
            </div>
            <div class="issuefilter_container">
                <div class="tab-content issuefilter_tabcontent">

                    <div id="presetfilter" class="tab-pane stackbasicfilter">
                        <!--filter panel start here-->
                        <div class="filterpanelwrapbasicfilter">
                            <div class="filterpanelbody" id="accordion">
                                <div class="fp_button text-center hidden-xs centerbtn" style="margin: 0 0 40px;">
                                    <button class="btn btnyellow clsFltSaveApply" id="btnSaveAndApply1" onclick="SaveFilter('saveapply')" data-bs-toggle="modal">Save and Apply</button>
                                    <button class="btn btnyellow clsFltSave" id="btnApply1" onclick="SaveFilter('apply')">Apply</button>
                                </div>

                                <div class="row hidden-xs IB_filterlist">
                                    <!--basic filter start here-->
                                    <div class="form-inline">
                                        <div class="box box-solid p1">
                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_ProjectRiskID") %></label>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterProjectRiskID", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'NUM'",,, "class='form-control'",,, ) %>

                                                <%--comment and added by imran on 22-12-2021 max length added because crash comming--%>
                                                <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterProjectRiskID", "txtPMFilterProjectRiskID", "form-control",,,,,, ,,,, " onkeypress='return Field_OnKeyPress(event)' onpaste='return false;' autocomplete='off'",, ,,,,, True) %>--%>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterProjectRiskID", "txtPMFilterProjectRiskID", "form-control",,,,,, ,,,, " onkeypress='return Field_OnKeyPress(event)' onpaste='return false;' autocomplete='off'  maxlength='3'",, ,,,,, True) %>
                                                <%--End comment by imran on 22-12-2021--%>
                                                <div class="clearfix"></div>
                                            </div>

                                        </div>

                                        <div class="box box-solid p1">
                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_Description") %></label>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterDescription", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-control'",,, ) %>

                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="form-group" style="width: 61%">
                                                <%CommonFunctions.HTMLControls.DrawTextArea("txtPMFilterDescription", "txtPMFilterDescription", "", "form-control", , , , , , , 2000, , , "line-height: 1.5!important;", , , , , "onkeyup='limitText(this,10,1000)'", , , , , , , , , , True)%>
                                            </div>
                                            <br />
                                            <div class="form-group">
                                                <label for="email"><%= MyBase.GetResourceString("C_ImpactDescription") %></label>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterNotes", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-control'",,, ) %>

                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="form-group" style="width: 61%">

                                                <%CommonFunctions.HTMLControls.DrawTextArea("txtPMFilterNotes", "txtPMFilterNotes", "", "form-control", , , , , , , 2000, , , "line-height: 1.5!important;", , , , , "onkeyup='limitText(this,10,1000)'", , , , , , , , , , True)%>
                                            </div>
                                            <br />
                                        </div>

                                        <div class="box box-solid p1">
                                            <div class="form-group col-sm-6" style="padding-left: 0px;">
                                                <label for="email"><%= MyBase.GetResourceString("C_RiskCategory") %></label>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterRiskCategoryID", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-control'",,, ) %>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtPMFilterRiskCategoryID", "usp_Whizible2_Sel_tbl_PM_RiskCategories",,, "class='form-control bgwhite' ",,, ) %>
                                            </div>
                                            <div class="form-group col-sm-6" style="padding-left: 0px;">
                                                <label for="email"><%= MyBase.GetResourceString("C_DateIdentified") %></label>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterDateIdentified", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'DATE'",,, "class='form-control'",,, ) %>
                                                                                               

                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterDateIdentifiedDisp", "txtPMFilterDateIdentifiedDisp", "form-control clsDateColor",,,,,, , ,,, "onkeypress='return Date_OnKeyPress(event)' onpaste='return false;' autocomplete='off'",, ,,,,, True) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterDateIdentified", "txtPMFilterDateIdentified", "form-control clsDateColor",,,,,, , True,, True, "",, ,,,,, True) %>

                                                <div class="clearfix"></div>

                                            </div>
                                            <div class="clearfix"></div>

                                            <div class="form-group col-sm-6" style="padding-left: 0px;">
                                                <label for="email"><%= MyBase.GetResourceString("C_OriginalPriority") %></label>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterOriginalPriority", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-control'",,, ) %>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtPMFilterOriginalPriority", "usp_Whizible2_Sel_Risk_Priority 'Original'",,, "class='form-control bgwhite' ",,, ) %>
                                            </div>
                                            <div class="form-group col-sm-6" style="padding-left: 0px;">
                                                <label for="email"><%= MyBase.GetResourceString("C_ChangePriority") %></label>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterChangePriority", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-control'",,, ) %>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtPMFilterChangePriority", "usp_Whizible2_Sel_Risk_Priority 'Change'",,, "class='form-control'",,, ) %>

                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="clearfix"></div>

                                            <div class="form-group col-sm-6" style="padding-left: 0px;">
                                                <label for="email"><%= MyBase.GetResourceString("C_Probability") %></label>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterProbability", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'NUM'",,, "class='form-control'",,, ) %>

                                                <%--<input id="txtPMFilterProbability" type="text" name="" class="form-control">--%>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterProbability", "txtPMFilterProbability", "form-control",, 5,,,, ,,,, "onkeypress='return Field_OnKeyPress(event)' onpaste='return false;' autocomplete='off'",, ,,,,, True) %>
                                            </div>
                                            <div class="form-group col-sm-6" style="padding-left: 0px;">
                                                <label for="email"><%= MyBase.GetResourceString("C_Impact") %></label>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterWeight", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'NUM'",,, "class='form-control'",,, ) %>

                                                <%--<input id="txtPMFilterWeight" type="text" name="" class="form-control">--%>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterWeight", "txtPMFilterWeight", "form-control",, 5,,,, ,,,, "onkeypress='return Field_OnKeyPress(event)' onpaste='return false;' autocomplete='off'",, ,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="clearfix"></div>
                                            <div class="form-group col-sm-6" style="padding-left: 0px;">
                                                <label for="email"><%= MyBase.GetResourceString("C_Magnitude") %></label>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterSeverity", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'NUM'",,, "class='form-control'",,, ) %>

                                                <%--<input id="txtPMFilterSeverity" type="text" name="" class="form-control">--%>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtPMFilterSeverity", "txtPMFilterSeverity", "form-control",, 5,,,, ,,,, "onkeypress='return Field_OnKeyPress(event)' onpaste='return false;' autocomplete='off'",, ,,,,, True) %>
                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="form-group col-sm-6" style="padding-left: 0px;">
                                                <div class="">
                                                    <label for="email"><%= MyBase.GetResourceString("C_RiskSource") %></label>
                                                    
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterRiskSourceId", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-control me-0'",,, ) %>
                                                    <!-- Added CSS class By Gauri On 21th Aug 2024 For Alignment Issue -->
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("txtPMFilterRiskSourceId", "usp_Whizible2_Sel_Risks_Source",,, "class='form-control selectWidth'",,, ) %>
                                                    <!-- End of Added CSS class By Gauri On 21th Aug 2024 For Alignment Issue -->
                                                    
                                                    <div class="clearfix"></div>
                                                </div>
                                            </div>
                                            <div class="clearfix"></div>

                                            <div class="form-group col-sm-6" style="padding-left: 0px;">
                                                <label for="email"><%= MyBase.GetResourceString("C_Status") %></label>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterStatus", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-control'",,, ) %>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtPMFilterStatus", "SELECT 1",,, "class='form-control'",,, ) %>
                                            </div>
                                            <div class="form-group col-sm-6" style="padding-left: 0px;">
                                                <label for="email"><%= MyBase.GetResourceString("C_PersonResponsible") %></label>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboPMFilterPersonResponsible", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-control'",,, ) %>

                                                <% CommonFunctions.HTMLControls.DrawComboBox("txtPMFilterPersonResponsible", "SELECT 1",,, "class='form-control'",,, ) %>

                                                <div class="clearfix"></div>
                                            </div>
                                            <div class="clearfix"></div>

                                        </div>

                                    </div>
                                    <!--basic filter end here-->
                                    <div class="clearfix"></div>
                                </div>

                                <div class="fp_button text-center hidden-xs centerbtn">
                                    <button class="btn btnyellow clsFltSaveApply" id="btnSaveAndApply2" onclick="SaveFilter('saveapply')" data-bs-toggle="modal" data-bs-dismiss="modal">Save and Apply</button>
                                    <button class="btn btnyellow clsFltSave" id="btnApply2" onclick="SaveFilter('apply')">Apply</button>
                                </div>
                            </div>
                        </div>

                        <br />
                        <br />
                    </div>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!--filter panel-end-here-->
        <%--Filter Ends--%>

        <%--Timesheet Starts--%>
        <div class="timesheetrow container-fluid bgwhite ts_headerbot">
            <div class="row">
                <div class="col-md-4 col-sm-4 col-sm-4 float-end">
                    <ul class="float-end btnlistinline">
                        <li data-bs-toggle="tooltip" data-bs-placement="top" title="Click here for download">
                            <div class="dropdown filedownload">
                                <button class="nostylebtn dropdown-toggle" data-bs-toggle="dropdown" data-bs-placement="bottom" title="" autocomplete="off"><i class="fas fa-download"></i></button>

                                <ul class="dropdown-menu" id="fas-download">
                                    <li><a href="#" onclick="Export_Click(&quot;PDF&quot;, 0)">
                                        <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a></li>
                                    <li><a href="#" onclick="Export_Click(&quot;EXCEL&quot;, 0)">
                                        <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a></li>
                                    <li><a href="#" onclick="Export_Click(&quot;XML&quot;, 0)">
                                        <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a></li>
                                    <li><a href="#" onclick="Export_Click(&quot;TEXT&quot;, 0)">
                                        <%--<img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Doc</a></li>--%>
                                        <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Text</a></li>
                                </ul>
                            </div>

                        </li>
                        <li class="hidden-xs" id="divAddRisk">
                            <a id="AddRisk" class="btn borderbtn ml-1 nobtnstyle-xs">Add Risk</a>
                        </li>
                    </ul>
                </div>
                <div class="col-md-8 col-sm-8 col-sm-8">
                    <div class="statustext_outer">
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
        <%--Timesheet Ends--%>

        <%--Risk Grid Starts--%>
        <!-- Main content -->
        <section class="content pt-0">

            <div class="bgwhitewrap">
                <%--<div>--%>
                <table class="table bgwhite table-bordered table-fixed-header Risktbl" style="width: 100%;">
                    <thead>
                        <tr>
                            <th class="nosort" width="20%"><%= MyBase.GetResourceString("C_RiskId") %></th>
                            <%--<th><%= MyBase.GetResourceString("C_Reports") %></th>--%>
                            <th width="60%"><%= MyBase.GetResourceString("C_Description") %></th>
                            <th width="5%"><%= MyBase.GetResourceString("C_IdentificationDate") %></th>
                            <th width="5%"><%= MyBase.GetResourceString("C_Category") %></th>
                            <th width="5%"><%= MyBase.GetResourceString("C_Probability") %></th>
                            <th width="5%"><%= MyBase.GetResourceString("C_Impact") %></th>
                            <th width="5%"><%= MyBase.GetResourceString("C_Magnitude") %></th>
                            <th width="5%"><%= MyBase.GetResourceString("C_Status") %></th>
                            <%--<th><%= MyBase.GetResourceString("C_Responsibility") %></th>
                        <th><%= MyBase.GetResourceString("C_RiskSource") %></th>--%>
                            <th style="min-width:80px;">&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
                <%-- </div>--%>

                <br />
                <br />

                <!--comment_section_start_here-->


                <!--comment_section_end_here-->

                <div class="clearfix"></div>



                <%--28.09.2019--%>
                <!---Risk detail section start here-->
                <div id="RDpanel" class="Riskdetailpanel" style="display: none;">
                    <div class="pt-1 pb-1">
                        <div class="col-md-12 col-sm-12 col-sm-12 float-start">
                            <ul class="nav nav-tabs detailsubtabs " role="tablist">
                                <li class="clsTabs" id="tabriskDetail"><a href="#riskDetail" class="active" role="tab" data-bs-toggle="tab">Details</a>
                                </li>
                                <li class="clsTabs" id="tabriskplans"><a href="#riskplan" id="tabriskplan" onclick="getRiskPlanDetails()" class="clsEditMode" role="tab" data-bs-toggle="tab">Plans</a>
                                </li>
                                <li class="clsTabs" id="tabriskEarlyWarnings"><a href="#riskEarlyWarnings" id="tabearlywarnings" onclick="getRiskEarlyWarningsDetails()" class="clsEditMode" role="tab" data-bs-toggle="tab">Early Warnings</a>
                                </li>
                                <li class="clsTabs" id="tabriskhistorys"><a href="#riskhistory" id="tabriskhistory" onclick="getRiskHistoryDetails()" class="clsEditMode" role="tab" data-bs-toggle="tab">History</a>
                                </li>
                                <li class="clsTabs" id="tabriskattachments"><a href="#riskattachments" id="tabattachments" onclick="getDocumentDetails('new')" class="clsEditMode" rol="tab" data-bs-toggle="tab">Documents</a>
                                </li>
                            </ul>
                        </div>

                        <div class="clearfix"></div>

                    </div>
                    <div class="stackmaintab stacktabdetail">

                        <div class="tab-content">
                            <!--customer stakeholders tab end here-->
                            <div class="tab-pane active" id="riskDetail">
                                <ul class="float-end btnlistinline">
                                    <li class="ml-1">
                                        <button class="btn borderbtn nobtnstyle-xs canclebtn">Cancel</button>
                                        <!-- <button class="btn borderbtn nobtnstyle-xs editbtn">Edit</button> -->
                                        <button class="btn btnyellow nobtnstyle-xs" id="btnSaveRisk" data-bs-target="#SaveContingencyTask" data-bs-toggle="modal" onclick="SetRiskSaveDetails()">Save</button>
                                    </li>
                                </ul>
                                <div class="tabcontent_body">
                                    <div class="form-group">
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_ProjectRiskID") %></label>
                                            <input id="txtProjectRiskId" type="text" class="form-control" disabled="disabled">
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_DateIdentified") %></label>
                                            <div class="input-group">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRiskDetailDateIdentifiedDisp", "txtRiskDetailDateIdentifiedDisp", "form-control clsDateColor",,,,,, , False,,, "onkeypress='return Date_OnKeyPress(event)'",, ,,,,, True) %>
                                                <input id="txtRiskDetailDateIdentified" type="hidden" name="" class="form-control">
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_OriginalPriority") %></label>

                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRiskDetailOriginalPriority", "usp_Whizible2_Sel_Risk_Priority 'Original'",,, " class='form-control bgwhite clsRiskCombo' ",,, ) %>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_ChangePriority") %></label>

                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRiskDetailChangePriority", "usp_Whizible2_Sel_Risk_Priority 'Change'",,, "class='form-control clsRiskCombo'",,, ) %>
                                        </div>

                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-6">
                                            <label class="control-label required"><%= MyBase.GetResourceString("C_Description") %></label>
                                            <%CommonFunctions.HTMLControls.DrawTextArea("txtRiskDetailDescription", "txtRiskDetailDescription", "", "form-control", , , , , , , 500, , , , , , , , "onkeyup='limitText(this,10,500)'", , , , , , , , , , True)%>
                                        </div>
                                        <div class="col-sm-6">
                                            <label class="control-label required"><%= MyBase.GetResourceString("C_ImpactDescription") %></label>
                                            <%CommonFunctions.HTMLControls.DrawTextArea("txtRiskDetailNotes", "txtRiskDetailNotes", "", "form-control", , , , , , , 1000, , , , , , , , "onkeyup='limitText(this,10,1000)'", , , , , , , , , , True)%>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>


                                    <div class="form-group">
                                        <div class="col-sm-3">
                                            <label class="control-label required"><%= MyBase.GetResourceString("C_RiskCategory") %></label>

                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRiskDetailRiskCategoryID", "usp_Whizible2_Sel_tbl_PM_RiskCategories",,, "class='form-control bgwhite clsRiskCombo'",,,, ,) %>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label required"><%= MyBase.GetResourceString("C_Status") %></label>

                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRiskDetailStatus", "usp_Whizible2_Sel_tbl_PM_RiskStatus",,, "class='form-control clsRiskCombo'",,,, , ) %>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_RiskSource") %></label>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRiskDetailRiskSourceId", "usp_Whizible2_Sel_Risks_Source",,, "class='form-control clsRiskCombo'",,, ) %>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_PersonResponsible") %></label>

                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRiskDetailPersonResponsible", "SELECT 1",,, "class='form-control clsRiskCombo'",,, ) %>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-3">
                                            <label class="control-label required"><%= MyBase.GetResourceString("C_Probability") %></label>
                                            <%--Added comment by imran on 16-12-2021 dropdown nothing selected display --%>
                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboRiskDetailProbability", "Usp_Whizible2_Sel_Probability_Impact_Data 'Probability'",,, "class='form-control selectpicker clsRiskCombo' ", True,,, , ) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRiskDetailProbability", "Usp_Whizible2_Sel_Probability_Impact_Data 'Probability'",,, "class='form-control clsRiskCombo' ", False,,, , ) %>
                                            <%--End comment by imran on 16-12-2021--%>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label required"><%= MyBase.GetResourceString("C_Impact") %></label>
                                            <%--Added comment by imran on 16-12-2021 dropdown nothing selected display --%>
                                            <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboRiskDetailImpact", "Usp_Whizible2_Sel_Probability_Impact_Data 'Impact'",,, "class='form-control selectpicker clsRiskCombo'", True,,, , ) %>--%>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRiskDetailImpact", "Usp_Whizible2_Sel_Probability_Impact_Data 'Impact'",,, "class='form-control clsRiskCombo'", False,,, , ) %>
                                            <%--End comment by imran on 16-12-2021--%>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Magnitude") %></label>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtRiskDetailMagnitude", "txtRiskDetailMagnitude", "form-control",,,,,, True,,,, ,, ,,,,, True) %>
                                        </div>


                                        <div class="clearfix"></div>
                                    </div>

                                    <div class="form-group">
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_Reviewer") %></label>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRiskDetailReviewer", "SELECT 1",,, "class='form-control clsRiskCombo'",,, ) %>
                                        </div>
                                        <div class="col-sm-3">
                                            <label class="control-label"><%= MyBase.GetResourceString("C_ReviewNotificationDate") %></label>
                                            <div class="input-group">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRiskDetailReviewNotificationDateDisp", "txtRiskDetailReviewNotificationDateDisp", "form-control clsDateColor",,,,,, False, False,, False, "autocomplete = 'off' onkeypress='return Date_OnKeyPress(event)'",,, ,,,,) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRiskDetailReviewNotificationDate", "txtRiskDetailReviewNotificationDate", "form-control", 200,,,,, False,,, True,,,, ,,,,) %>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                        <%--<div class="col-sm-3">
                                        <label class="control-label">&nbsp;</label>
                                        <div>
                                            <label class="control-label"><%= MyBase.GetResourceString("C_ReviewFlag") %></label>                                            
                                            <%CommonFunctions.HTMLControls.DrawCheckBox("chkReviewFlag", "chkReviewFlag", "custom_chckbox clsCheckBox", False, , , "style='width: 30px;height:15px;'", , , , , , )%>
                                        </div>
                                    </div>--%>

                                        <div class="col-sm-3">
                                            <label class="control-label">&nbsp;</label>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-sm-4">
                                            <label class="control-label">&nbsp;</label>
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                            </div>
                            <!--customer stakeholders tab end here-->

                            <div class="tab-pane" id="riskplan">
                                <ul class="float-end btnlistinline">
                                    <li class="ml-1">
                                        <button class="btn borderbtn nobtnstyle-xs canclebtn">Cancel</button>
                                        <%-- <button class="btn borderbtn nobtnstyle-xs canclebtn">Cancel</button>
                                    <button class="btn btnyellow nobtnstyle-xs">Save</button>--%>
                                    </li>
                                </ul>
                                <div class="tabcontent_body">
                                    <div class="headercontainer">
                                        <table class="order-list table bgwhite table-bordered RiskPlantbl" style="width: 100%;">
                                            <thead>
                                                <tr>
                                                    <th style="min-width: 30%" class="nosort">
                                                        <%= MyBase.GetResourceString("C_Plan") %>
                                                    </th>
                                                    <th>
                                                        <%= MyBase.GetResourceString("C_ResponseType") %>
                                                    </th>
                                                    <th>
                                                        <%= MyBase.GetResourceString("C_Responsibility") %>
                                                    </th>
                                                    <th>
                                                        <%= MyBase.GetResourceString("C_TaskType") %>
                                                    </th>
                                                    <th>
                                                        <%= MyBase.GetResourceString("C_DateofPlan") %>
                                                    </th>
                                                    <th>
                                                        <%= MyBase.GetResourceString("C_AssignTask") %>
                                                    </th>
                                                    <th>
                                                        <%= MyBase.GetResourceString("C_Duration") %>
                                                    </th>
                                                    <th>
                                                        <%= MyBase.GetResourceString("C_Work") %>                                                    
                                                    </th>
                                                    <th width="100px" class="text-center"></th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <%--Risk Plan Dummy Data --%>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <%--Commented And Added By Usha Pandit On 05.11.2020 For Add Plan Button border display issue--%>
                                                    <%--<td class="text-start">
                                                        <button id="btnAddPlan" class="btn borderbtn nobtnstyle-xs add-new">+ Add Plan</button>
                                                    </td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>--%>
                                                
                                                    <td class="text-start clsBorder">
                                                        <button id="btnAddPlan" class="btn borderbtn nobtnstyle-xs add-new" style="width:102px">+ Add Plan</button>
                                                    </td>
                                                    <td class="clsBorder">&nbsp;</td>
                                                    <td class="clsBorder">&nbsp;</td>
                                                    <td class="clsBorder">&nbsp;</td>
                                                    <td class="clsBorder">&nbsp;</td>
                                                    <td class="clsBorder">&nbsp;</td>
                                                    <td class="clsBorder">&nbsp;</td>
                                                    <td class="clsBorder">&nbsp;</td>
                                                    <td class="clsBorder">&nbsp;</td>
                                                    <%--End Of Added By Usha Pandit On 05.11.2020 For Add Plan Button border display issue--%>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!--customer stakeholders tab end here-->
                            <div class="tab-pane" id="riskEarlyWarnings">
                                <ul class="float-end btnlistinline">
                                    <li class="ml-1">
                                        <button class="btn borderbtn nobtnstyle-xs canclebtn">Cancel</button>
                                        <%-- <button class="btn borderbtn nobtnstyle-xs cancleEarlywarningbtn">Cancel</button>                                   
                                    <button class="btn btnyellow nobtnstyle-xs" onclick="SaveEarlyWarningDetails()">Save</button>--%>
                                    </li>
                                </ul>
                                <div class="tabcontent_body">
                                    <div class="headercontainer">
                                        <div class="addtbl tablecontainer">
                                            <table class="order-list table bgwhite table-bordered table-fixed-header RiskEarlyWarningtbl" style="width: 100%">
                                                <thead>
                                                    <tr>
                                                        <th style="min-width: 30%" class="nosort">
                                                            <%= MyBase.GetResourceString("C_Warning") %>
                                                        </th>
                                                        <th>
                                                            <%= MyBase.GetResourceString("C_WarningStatus") %>
                                                        </th>
                                                        <th>
                                                            <%= MyBase.GetResourceString("C_EarlyWarningFlag") %>
                                                        </th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td class="text-start">
                                                            <button id="btnEarlyWarning" class="btn borderbtn nobtnstyle-xs add-new-early-warning">+ Add Early Warning</button>
                                                        </td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                        <td>&nbsp;</td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--Stackreport tab end here-->
                            <!--customer stakeholders tab end here-->
                            <div class="tab-pane" id="riskhistory">
                                <ul class="float-end btnlistinline">
                                    <li class="ml-1">
                                        <button class="btn borderbtn nobtnstyle-xs canclebtn">Cancel</button>
                                        <%--<button class="btn borderbtn nobtnstyle-xs canclebtn">Cancel</button>                                    
                                    <button class="btn btnyellow nobtnstyle-xs">Save</button>--%>
                                    </li>
                                </ul>
                                <div class="tabcontent_body">
                                    <div class="headercontainer">
                                        <div class="tablecontainer">
                                            <table class="order-list table-fixed-header RiskHistorytbl table bgwhite table-bordered" style="width: 100%;">
                                                <thead>
                                                    <tr>
                                                        <th class="nosort"><%= MyBase.GetResourceString("C_Tab") %></th>
                                                        <th><%= MyBase.GetResourceString("C_ModifiedFields") %></th>
                                                        <th width="15%"><%= MyBase.GetResourceString("C_ModifiedDate") %></th>
                                                        <th width="15%">Old Value</th>
                                                        <th width="15%"><%= MyBase.GetResourceString("C_NewValue") %></th>
                                                        <th width="15%"><%= MyBase.GetResourceString("C_ModifiedBy") %>
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--customer stakeholders tab end here-->

                            <!--tab start for upload documents-->
                            <!--attachment tab start here -->
                            <div id="riskattachments" class="tab-pane">
                                <ul class="float-end btnlistinline">
                                    <li class="ml-1">
                                        <button class="btn borderbtn nobtnstyle-xs canclebtn">Cancel</button>
                                    </li>
                                </ul>
                                <div class="commentboxbody">
                                    <div class="all_attachedfileslist col-sm-12">
                                        <table id="atchmentTable" class="table table-fixed-header table-stripped order_attchmentlist RiskDocumentTbl">
                                            <thead>
                                                <tr>
                                                    <th width="45%" class="nosort"><%= MyBase.GetResourceString("C_DocumentCategory") %></th>
                                                    <th><%= MyBase.GetResourceString("C_DocumentSubCategory") %></th>
                                                    <th><%= MyBase.GetResourceString("C_DocumentName") %></th>
                                                    <th><%= MyBase.GetResourceString("C_Description") %></th>
                                                    <th><%= MyBase.GetResourceString("C_FileSize") %></th>
                                                    <th><%= MyBase.GetResourceString("C_UploadDate") %></th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody id="atchmentTableBody">
                                            </tbody>
                                            <tfoot>
                                                <%--<tr>--%>
                                                <td class="text-start">
                                                    <button id="addattachnebtrow" value="Add Row" class="btn borderbtn" style="width:180px">+ Add New Attachment</button>
                                                </td>
                                                <%--<td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>
                                                <td></td>--%>
                                                <td colspan="6">
                                                    <button id="savedocument" type="button" disabled="disabled" class="btn btnyellow ml-1 float-end">Upload</button>
                                                </td>
                                                <%--</tr>--%>
                                            </tfoot>
                                        </table>

                                    </div>
                                </div>
                            </div>
                            <!--attachment tab end here -->
                            <!--tab start for upload document-->

                            <div class="clearfix"></div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                    <br />
                    <br />
                    <!--comment_section_start_here-->
                    <div class="col-sm-12 convAndatchmnt_panel">
                        <div class="box box-solid collapsed-box">
                            <div class="box-header with-border">
                                <h3 class="box-title">All Conversation</h3>
                                <div class="box-tools float-end">
                                    <button type="button" class="btn btn-box-tool" data-widget="collapse" id="panelDiscussion">
                                        <i class="fas fa-chevron-down"></i>
                                    </button>
                                </div>
                                <!-- /.box-tools -->
                            </div>
                            <!-- /.box-header -->
                            <div class="box-body">
                              
                                        <div class="conversationbox">
                                            <%--riskDiscussions--%>
                                            <div class="col-sm-12">
                                                <div class="box-footer box-comments pt-0 mt-0 col-md-12 slim-scroll" id="riskDiscussions">
                                                    <%--Added By Usha Pandit On 23-10-2019 For UI related changes--%>
                                                    <%--Removed HTML Content--%>
                                                    <%--End Of Added By Usha Pandit On 23-10-2019 For UI related changes--%>
                                                </div>

                                                <div class="commentedtitor col-sm-12" id="riskEditDiscussion">
                                                    <!-- the comment box -->

                                                    <%--Added By Usha Pandit On 23-10-2019 For UI related changes--%>
                                                    <%--Removed HTML Content--%>
                                                    <%--End Of Added By Usha Pandit On 23-10-2019 For UI related changes--%>
                                                </div>

                                            </div>

                                        </div>

                            </div>
                            <!-- /.box-body -->
                        </div>
                    </div>
                    <!--comment_section_end_here-->
                    <div class="clearfix"></div>
                </div>
                <div class="clearfix"></div>
            </div>

            <!--Risk detail section end here-->
            <%--28.09.2019--%>


            <%--</div>--%>
            <!--bgwhite div end here-->

        </section>
        <!--section end here-->
        <%--Risk Grid Ends--%>

        <%--Delete Modal Starts--%>
        <!--All modal start here-->
        <%-- Risk Modal--%>
        <div id="deleteriskmodal" class="modal fade custmodal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modalsmall ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" data-bs-dismiss="modal">×</button>
                        <h4 class="modal-title">Delete</h4>
                    </div>

                    <div class="modal-body">
                        <p align="center">Are you sure you want to delete this record?</p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-sm-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-sm-6 col-sm-6">
                                    <%--<input type="hidden" name="currentRiskId" id="currentRiskId" value="">--%>
                                    <button class="btn btnyellow ml-1 float-end" onclick="deleteRiskDetails()" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <div id="deleteplanmodal" class="modal fade custmodal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modalsmall ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" data-bs-dismiss="modal">×</button>
                        <h4 class="modal-title">Delete</h4>
                    </div>

                    <div class="modal-body">
                        <p align="center">Are you sure you want to delete this record?</p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-sm-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-sm-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="deletePlanDetails()" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <div id="deleteEarlywarningmodal" class="modal fade custmodal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modalsmall ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" data-bs-dismiss="modal">×</button>
                        <h4 class="modal-title">Delete</h4>
                    </div>

                    <div class="modal-body">
                        <p align="center">Are you sure you want to delete this record?</p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-sm-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-sm-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="deleteEarlywarningDetails()" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <div id="deletedocumentmodal" class="modal fade custmodal" role="dialog" aria-hidden="false">
            <div class="modal-dialog modalsmall ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" data-bs-dismiss="modal">×</button>
                        <h4 class="modal-title">Delete</h4>
                    </div>

                    <div class="modal-body">
                        <span id="TagId"></span>
                        <span id="DeleteId"></span>
                        <span id="DeleteDocumentId"></span>
                        <p align="center">Do you want to Delete ?</p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-sm-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" onclick="cancelDocumentDelete()">No</button>
                                </div>
                                <div class="col-sm-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="DeleteDocument()" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <%--Delete Modal Ends--%>
        <%--Filter Save modal Added By Usha Pandit On 25.09.2019 For Save And Apply Filter Popup--%>
        <!-- Save filter Modal start here-->
        <div class="modal custmodal Risksave_filter fade" id="Risksavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="Risksavefilterbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <label class="control-label col-md-4 p-0 text-end">Filter Name <span style="color:red">*</span> :</label>
                                            <span class="col-md-8">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", "form-control",,,,,, ,,,,,,, True,,,,) %>
                                                <%--<input type="text" class="form-control" name="">--%><br />
                                                <div class="btnrow">
                                                    <button class="btn btnyellow float-start savefilter" id="btnSaveFilter" onclick="SaveFilterDetails()">Save</button>
                                                    <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end" onclick="cancelsaveapply()">Cancel</button>
                                                </div>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>

        <!-- Invoke Contingency Modal-->
        <div class="modal custmodal SaveContingency fade" id="SaveContingencyTask" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-dismiss="modal">
            <div class="modal-dialog modalsmall ui-draggable">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header ui-draggable-handle">
                        <button type="button" class="close" data-bs-dismiss="modal">×</button>
                        <h4 class="modal-title"><%= MyBase.GetResourceString("C_ContingencyPlanAsTask") %></h4>
                    </div>

                    <div class="modal-body">
                        <p align="center"><%= MyBase.GetResourceString("A_InvokeContingencyPlan") %></p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-sm-6 col-sm-6 text-start">
                                    <button class="btn borderbtn ml-1" onclick="SaveRiskDetails()" data-bs-dismiss="modal">No</button>
                                </div>
                                <div class="col-sm-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 float-end" onclick="CreateContingencyTask()" data-bs-dismiss="modal">Yes</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

        <div class="modal custmodal fade" id="assigntaskmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-dismiss="modal">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="width: 800px;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Assign Task</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="assigntaskbox" class="box-panel">

                            <div class="box-body graybg">
                                <div class="form-group mb-0">
                                    <div class="row">
                                        <div class="col-md-12 row">
                                            <%--<label class="control-label col-md-4 p-0 text-end"><%= MyBase.GetResourceString("C_TaskName") %></label>
                                        <span class="col-md-8">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", "form-control", 200,,,,, ,,,,,,, True,,,,) %>
                                           

                                        </span>
                                        <label class="control-label col-md-4 p-0 text-end"><%= MyBase.GetResourceString("C_TaskNotes") %></label>
                                        <span class="col-md-8">
                                            <%CommonFunctions.HTMLControls.DrawTextArea("txtTaskNotes", "txtTaskNotes", "", "form-control", , , , , , , 2000, , , "line-height: 1.5!important;", , , , , "onkeyup='limitText(this,10,1000)'", , , , , , , , , , True)%>
                                        </span>

                                        <label class="control-label col-md-4 p-0 text-end"><%= MyBase.GetResourceString("C_Resource") %></label>

                                        <span class="col-md-8">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", "SELECT 1",,, "disabled = 'disabled' class='form-control'",,, ) %>
                                        </span>
                                        <label class="control-label col-md-4 p-0 text-end"><%= MyBase.GetResourceString("C_EstimationType") %></label>

                                        <span class="col-md-8">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectEstimationTypeID", "SELECT 1",,, "class='form-control'",,, ) %>
                                        </span>
                                        <label class="control-label col-md-4 p-0 text-end"><%= MyBase.GetResourceString("C_Work") %></label>
                                        <span class="col-md-8">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrentWork", "txtCurrentWork", "form-control", 200,,,,, ,,,,,,, True,,,,) %>
                                        </span>
                                        <span class="col-md-12">
                                            <label class="control-label col-md-4 p-0 text-end"><%= MyBase.GetResourceString("C_StartDate") %></label>
                                            <span class="col-md-6">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrentStartDateDisp", "txtCurrentStartDateDisp", "form-control", 200,,,,, True,,,,,,, True,,,,) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrentStartDate", "txtCurrentStartDate", "form-control", 200,,,,, True,,, True,,,, True,,,,) %>
                                            </span>
                                            <label class="control-label col-md-4 p-0 text-end"><%= MyBase.GetResourceString("C_EndDate") %></label>
                                            <span class="col-md-6">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrentEndDateDisp", "txtCurrentEndDateDisp", "form-control", 200,,,,, ,,,,,,, True,,,,) %>
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrentEndDate", "txtCurrentEndDate", "form-control", 200,,,,, ,,, True,,,, True,,,,) %>
                                            </span>
                                        </span>
                                        <span class="col-md-8">
                                            <div class="btnrow">
                                                <button data-bs-dismiss="modal" class="btn btnyellow float-start savetask" id="btnSaveTask" onclick="SaveTaskDetails()">Save</button>
                                                <button data-bs-dismiss="modal" class="btn canclesavetaskbtn borderbtn float-end" onclick="cancelsavetask()">Cancel</button>
                                            </div>
                                        </span>--%>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <label class="control-label p-0 text-end required"><%= MyBase.GetResourceString("C_TaskName") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtTaskName", "txtTaskName", "form-control", 200,,,,, ,,,,,,, True,,,,) %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label class="control-label p-0 text-end"><%= MyBase.GetResourceString("C_TaskNotes") %></label>
                                                    </td>
                                                    <td>
                                                        <%CommonFunctions.HTMLControls.DrawTextArea("txtTaskNotes", "txtTaskNotes", "", "form-control", , , , , , , 2000, , , "line-height: 1.5!important;", , , , , "onkeyup='limitText(this,10,1000)'", , , , , , , , , , True)%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label class="control-label p-0 text-end required"><%= MyBase.GetResourceString("C_Resource") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", "SELECT 1",,, "disabled = 'disabled' class='form-control'",,, ) %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label class="control-label p-0 "><%= MyBase.GetResourceString("C_EstimationType") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectEstimationTypeID", "SELECT ''",,, "class='form-control'",,, ) %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label class="control-label p-0 text-end required"><%= MyBase.GetResourceString("C_Work") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrentWork", "txtCurrentWork", "form-control", 200,,,,, ,,,,,, , ,,,,) %>
                                                    </td>
                                                    <td>
                                                        <label class="control-label p-0 text-end"><%= MyBase.GetResourceString("C_Billable") %></label>
                                                    </td>
                                                    <td>
                                                        <%CommonFunctions.HTMLControls.DrawCheckBox("chkBillable", "chkBillable", "", , , , , , , , , , )%>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label class="control-label p-0 text-end required"><%= MyBase.GetResourceString("C_StartDate") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrentStartDateDisp", "txtCurrentStartDateDisp", "form-control", 200,,,,, True,,,,,, , ,,,,) %>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrentStartDate", "txtCurrentStartDate", "form-control", 200,,,,, True,,, True,,,, True,,,,) %>
                                                    </td>
                                                    <td>
                                                        <label class="control-label p-0 text-end required"><%= MyBase.GetResourceString("C_EndDate") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrentEndDateDisp", "txtCurrentEndDateDisp", "form-control", 200,,,,, ,,,,,, , ,,,,) %>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtCurrentEndDate", "txtCurrentEndDate", "form-control", 200,,,,, ,,, True,,,, True,,,,) %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label class="control-label p-0 text-end required"><%= MyBase.GetResourceString("C_Priority") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_Whizible2_Sel_tbl_IB_Priorities 1",,, "class='form-control'",,,, , ) %>
                                                    </td>
                                                    <td>
                                                        <label class="control-label p-0 text-end"><%= MyBase.GetResourceString("C_Deliverable") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableID", "txtDeliverableID", "form-control", 200,,,,, ,,,,,, , ,,,,) %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label class="control-label p-0 text-end required"><%= MyBase.GetResourceString("C_TaskType") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboTaskType", "SELECT 1",,, "class='form-control'",,,, , ) %>
                                                    </td>
                                                    <td>
                                                        <label class="control-label p-0 text-end"><%= MyBase.GetResourceString("C_Module") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboModuleID", "SELECT 1",,, "class='form-control'", True,, ) %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label class="control-label p-0 text-end"><%= MyBase.GetResourceString("C_SubProject") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboSubProjectID", "SELECT 1",,, "class='form-control'",,,, , ) %>
                                                    </td>
                                                    <td>
                                                        <label class="control-label p-0 text-end"><%= MyBase.GetResourceString("C_Milestone") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboMilestoneID", "SELECT 1",,, "class='form-control'", True,, ) %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label class="control-label p-0"><%= MyBase.GetResourceString("C_ChangeRequest") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboChangeRequestID", "SELECT 1",,, "class='form-control'",,,, , ) %>
                                                    </td>
                                                    <td>
                                                        <label class="control-label p-0 required"><%= MyBase.GetResourceString("C_UserStory") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboUserStory", "SELECT 1",,, "class='form-control'", True,, ) %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label class="control-label p-0 text-end"><%= MyBase.GetResourceString("C_Release") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtRelease", "txtDeliverableID", "form-control", 200,,,,, ,,,,,, , ,,,,) %>
                                                    </td>
                                                    <td>
                                                        <label class="control-label p-0 text-end"><%= MyBase.GetResourceString("C_Sprint") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtIteration", "txtDeliverableID", "form-control", 200,,,,, ,,,,,, , ,,,,) %>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <label class="control-label p-0 text-end"><%= MyBase.GetResourceString("C_StoryPoint") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("txtStoryPoint", "txtStoryPoint", "form-control", 200,,,,, ,,,,,, , ,,,,) %>
                                                    </td>
                                                    <td>
                                                        <label class="control-label p-0 text-end"><%= MyBase.GetResourceString("C_Feature") %></label>
                                                    </td>
                                                    <td>
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectFeatureID", "SELECT 1",,, "class='form-control'", True,, ) %>
                                                    </td>
                                                </tr>
                                            </table>
                                            <span class="col-md-8">
                                                <div class="btnrow">
                                                    <button data-bs-dismiss="modal" class="btn btnyellow float-start savetask" id="btnSaveTask" onclick="SaveTaskDetails()">Save</button>
                                                    <button data-bs-dismiss="modal" class="btn canclesavetaskbtn borderbtn float-end" onclick="cancelsavetask()">Cancel</button>
                                                </div>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="clearfix"></div>

                    </div>
                </div>
            </div>
        </div>
        <!-- Save filter Modal End here-->
        <%--Filter Save modal Added By Usha Pandit On 25.09.2019 For Save And Apply Filter Popup--%>
        <!--All modal end here-->
    </div>
</body>
</html>
