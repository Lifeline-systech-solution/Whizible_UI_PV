<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RM_OrganizationUnit.aspx.vb" Inherits="PbNIT.RM_OrganizationUnit" %>

<!DOCTYPE html> 

<html xmlns="http://www.w3.org/1999/xhtml">
      <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Resume")%> 
<head runat="server">
      
<%--    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Resume</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1" />
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>



</head>
        <style type="text/css">
        .clsShowHide {
            display: none !important;
        }

        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        a.clearalllink {
            font-weight: bold;
            margin: 7px 0px 0 8px;
            display: none;
        }

        .filter.pull-right {
            margin: 2px 0 0 8px;
        }

        table tr th {
            vertical-align: middle !important;
        }

            table tr td:last-child .custom_chckbox label:before, table tr th:last-child .custom_chckbox label:before {
                margin-right: 0;
            }

        .notebox {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 4px;
        }

        .alertify-notifier li {
            word-break: normal !important;
            white-space: normal !important;
            background-color: red !important;
        }

        .alertifySuccess li {
            word-break: normal !important;
            white-space: normal !important;
            background-color: darkseagreen !important;
        }

        .alertify-notifier .ajs-message {
            width: 500px !important;
            height: 60px;
            word-break: break-word;
            background-color: red !important;
        }

        /*.alertify-notifier ajs-top ajs-right {
            background-color: red !important;
        }*/

        .alertify-notifier {
            position: fixed;
            width: 0;
            overflow: visible;
            z-index: 99999;
            -webkit-transform: translate3d(0,0,0);
            transform: translate3d(0,0,0);
            word-break: break-all;
        }

        .dropdown-submenu .dropdown-submenu > a:after {
            border-color: transparent transparent transparent #fff;
            border-style: solid;
            border-width: 5px 0 5px 5px;
            content: " ";
            display: block;
            float: right;
            height: 0;
            margin-right: 10px;
            margin-top: 5px;
            width: 0;
        }

        .dropdown-submenu > .dropdown-submenu:hover a:after {
            border-color: transparent transparent transparent #464a4c;
        }

        /*Detailpanel*/
        .Resourcedetailpanel {
            margin: 40px 15px 0;
            display: none;
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        .pgdetailinner {
            padding: 10px;
        }

        .Resourcedetailpanel .tab-pane {
            padding: 20px 0;
        }

        tr.rowhiglight {
            background: #c3dbff;
        }

        .DisableContent {
            pointer-events: none;
            opacity: 0.5;
        }

            .DisableContent:hover {
                cursor: no-drop;
            }

        .dataTables_scrollBody.DisableContent {
            height: auto !important
        }

        ul.nav.nav-tabs.detailsubtabs {
            background: #f5f5f5;
            margin: -11px -11px;
            padding: 10px 10px 0;
            border: 1px solid #ddd;
            border-radius: 4px 4px 0 0;
        }

        .nav.detailsubtabs > li > a:hover, .nav.nav.detailsubtabs > li > a:active, .nav.nav.detailsubtabs > li > a:focus {
            background: #fff;
            color: #1359ac;
        }

        /*Resume Style*/
        /*.content-wrapper{background:#eee!important}*/
        #ResumeModal .modal-body {
            padding: 0;
        }

        .dataTable > thead > tr > th[class*="sort"]:after {
            content: "" !important;
        }

        table.dataTable thead > tr > th.sorting_asc,
        table.dataTable thead > tr > th.sorting_desc,
        table.dataTable thead > tr > th.sorting,
        table.dataTable thead > tr > td.sorting_asc,
        table.dataTable thead > tr > td.sorting_desc,
        table.dataTable thead > tr > td.sorting {
            padding-right: inherit;
        }

        .resumecontainer {
            max-width: 100%;
            margin: 0px auto;
            border: 1px solid #ddd;
            box-shadow: 0 1px 4px rgba(0,0,0,0.1);
            background: #fff;
            border-radius: 4px
        }

        .resumeHeader {
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }

            .resumeHeader figure {
                margin: 0 0 0 35px;
                border: 1px solid #ddd;
                height: 160px;
                width: 160px;
                line-height: 160px;
                background: #f5f5f5;
                border-radius: 100%;
            }

        .resumehdright.graybg {
            padding: 15px
        }

        .resumetblTitle {
            background: #4263c1 !important;
            color: #fff !important;
            font-size: 16px;
            font-weight: 400;
            padding: 4px 8px !important
        }

        .CandidateName h4 {
            color: #1359a6
        }

        .ResumeAsignmentDetails {
            display: block;
            text-align: left
        }

        .RProname strong {
            color: #1359ac !important
        }

        .resumebody {
            padding: 15px
        }

        .table-bordered tbody th {
            background: #e7edf0
        }

        .bankrow td {
            padding: 0 !important;
            height: 5px !important;
            border: none !important;
            line-height: 5px !important
        }

        .candidateContctinfo p {
            margin-bottom: 0;
            line-height: 18px;
            text-align: right
        }

            .candidateContctinfo p label {
                width: 100px
            }

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .dblock {
            display: block;
        }

        body#bodyBusiness-group {
            padding-right: 0 !important;
        }

        .preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;
            /* border: 3px solid #ababab; */
            /* box-shadow: 1px 1px 10px #ababab; */
            border-radius: 15px;
            background: #ddd;
            /* background-color: white; */
            background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;
            /* background: url(../../../Whizible2.0-new/dist/img/loading.gif) rgba( 255, 255, 255, .8 ) 100% 100% no-repeat; */
            width: 100px;
            height: 100px;
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
        }

        .clsFilterHighlight {
            background: #1359a6 !important;
            color: #ffffff !important;
        }

        .editFilter {
            color: #1359a6;
            border: 1px;
            border-style: dotted;
            background: aliceblue;
        }

        .filterpanel .issfilter_actiondropdown {
            float: right;
        }

        .filterpanel .MyFiltersdropdown li span i {
            font-size: 14px;
            cursor: pointer;
            padding: 9px;
        }

        .btnrow {
            margin-top: 20px;
        }
    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" >
        <%--  /*Added & Commented By Madhuri.K On 22-Aug-2024 For Loader Issues*/--%>
                    <div class="" id="bodyBusiness-group"></div> 
                        <div class="resumecontainer">
                        <div class="resumeHeader">
                            <div class="row">
                                <div class="col-xs-12 col-sm-3 text-center">
                                    <figure>
                                        <img style="margin: 0 auto;height: 165px;width: 250px;" id="employeeImage" class="img-circle img-responsive" alt="" >
                                    </figure>
                                </div>

                                <div class="col-xs-12 col-sm-9">
                                    <div class="resumehdright graybg">
                                        <div class="CandidateName pull-left" id="employeeName">
                                        </div>
                                        <div class="candidateContctinfo pull-right" id="employeeInformation">
                                        </div>
                                        <div class="clearfix"></div>
                                        <hr style="margin: 10px 0; border-color: #ddd;" />
                                        <!-- Added by Aditya J. - GDPR Settings-based field visibility on Resume page -->
                                        <strong id="gdprResumeCertQualificationHeader"> Certification and Qualification Details</strong><br />
                                        <div id="gdprResumeCertificationsBlock">
                                            <div id="certificationlist"></div>
                                        </div>
                                        <div id="gdprResumeQualificationsBlock">
                                            <div id="qualificationlist"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="resumebody">
                            <!-- Added by Aditya J. - GDPR Settings-based field visibility on Resume page -->
                            <table class="table table-stripped table-bordered" style="width: 100%;" id="gdprResumeAdvancedInfoBlock">
                                <thead>
                                    <tr>
                                        <th colspan="2" class="resumetblTitle text-left">Technical Skills</th>
                                    </tr>

                                </thead>
                                <tbody id="tbltechnicalskills">
                                </tbody>
                            </table>

                            <!-- Added by Aditya J. - GDPR Settings-based field visibility on Resume page -->
                            <table class="table table-stripped table-bordered" style="width: 100%;" id="gdprResumePrevWorkExpBlock">
                                <thead>
                                    <tr>
                                        <th colspan="2" class="resumetblTitle text-left">Previous Work Experience</th>
                                    </tr>

                                </thead>
                                <tbody id="tblpreviousworkexp">
                                </tbody>
                            </table>

                            <table class="table table-stripped table-bordered" style="width: 100%; margin-bottom: 0;">
                                <thead>
                                    <tr>
                                        <th colspan="5" class="resumetblTitle text-left">Current Assignments</th>
                                    </tr>
                                    <tr class="bankrow">
                                        <td colspan="5">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <th class="text-left">Project Name</th>
                                        <th style="width:390px">Duration<span>(Years/Month)</span></th>
                                        <th>Team<span>Size</span></th>
                                        <th>Role</th>
                                    </tr>
                                </thead>
                                <tbody id="tblEmployeeAssignment">
                                </tbody>
                            </table>

                            <!-- Added by Aditya J. - GDPR Settings-based field visibility on Resume page -->
                            <table class="table table-stripped table-bordered" style="width: 100%; margin-bottom: 0;" id="gdprResumePrevAssignmentBlock">
                                <thead>
                                    <tr>
                                        <th colspan="5" class="resumetblTitle text-left">Previous Assignments</th>
                                    </tr>
                                    <tr class="bankrow">
                                        <td colspan="5">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <th class="text-left">Project Name</th>
                                        <th style="width:300px">Duration<span></span></th>
                                        <th>Team<span>Size</span></th>
                                        <th>Role</th>
                                        <th>Skills Utilized</th>
                                    </tr>
                                </thead>
                                <tbody id="tblEmployeePreviousAssignment">
                                </tbody>
                            </table>

                            <br />
                            <%--<div class="text-center">
                                <button class="btn borderbtn" data-dismiss="modal">Close</button>
                            </div>--%>
                        </div>
                    </div>
    
   
    <!-- REQUIRED JS SCRIPTS -->
    <!-- jQuery -->
   <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>

    <script>

         $(document).ready(function () {
            GetResourceResume();
        });

        function cancledetailpanel() { }

        // ---------------------------------------------------------------------
        // Added by Aditya J. - GDPR Settings-based field visibility on Resume
        // Driven by the configuration saved in RM_GDPRSettings.aspx (API below).
        // ---------------------------------------------------------------------
        var gdprResumeFieldMap = [
            { key: 'BirthDate', selector: '#gdprResumeBirthDate' },
            { key: 'Email', selector: '#gdprResumeEmail' }
        ];

        var gdprResumeSubtabMap = [
            { key: 'AdvancedInfo', selector: '#gdprResumeAdvancedInfoBlock' },
            { key: 'Certifications', selector: '#gdprResumeCertificationsBlock' },
            { key: 'Qualifications', selector: '#gdprResumeQualificationsBlock' },
            { key: 'PrevWorkExp', selector: '#gdprResumePrevWorkExpBlock' },
            { key: 'PrevAssignment', selector: '#gdprResumePrevAssignmentBlock' }
        ];

        // Added by Aditya J. - GDPR Settings-based field visibility on Resume page
        // Cache original rendered data so hidden fields can be shown back when enabled.
        var gdprResumeOriginalCache = {};

        function gdprCacheOriginalIfNeeded(cacheKey, value) {
            if (gdprResumeOriginalCache[cacheKey] === undefined) {
                gdprResumeOriginalCache[cacheKey] = value;
            }
        }

        // Apply GDPR config { FieldName: IsVisible } to Resume DOM.
        function gdprApplyConfigOnResume(config) {
            // Added by Aditya J. - GDPR Settings-based field visibility on Resume page
            // As requested: show "NA" instead of hiding GDPR-disabled fields/sections.

            // DOB and Email rows (PII lines in header section)
            $.each(gdprResumeFieldMap, function (i, f) {
                var visible = (config[f.key] !== false && config[f.key] !== 0);
                var $row = $(f.selector);
                if (!$row.length) return;

                var $valueSpan = $row.find('span').last();
                var cacheKey = f.key + '_text';
                gdprCacheOriginalIfNeeded(cacheKey, $valueSpan.text());
                $valueSpan.text(visible ? gdprResumeOriginalCache[cacheKey] : 'NA');
                $row.show();
            });

            // Added by Aditya J. - GDPR Settings-based field visibility on Resume page
            // When Advanced Info is disabled, Phone No should be masked as NA.
            var advVisible = (config['AdvancedInfo'] !== false && config['AdvancedInfo'] !== 0);
            var $phoneRow = $('#gdprResumePhone');
            if ($phoneRow.length) {
                var $phoneValueSpan = $phoneRow.find('span').last();
                gdprCacheOriginalIfNeeded('Phone_text', $phoneValueSpan.text());
                $phoneValueSpan.text(advVisible ? gdprResumeOriginalCache['Phone_text'] : 'NA');
                $phoneRow.show();
            }

            // Advanced Info -> Technical Skills table
            //var advVisible = (config['AdvancedInfo'] !== false && config['AdvancedInfo'] !== 0);
            //gdprCacheOriginalIfNeeded('tbltechnicalskills_html', $('#tbltechnicalskills').html());
            //$('#tbltechnicalskills').html(
            //    advVisible
            //        ? gdprResumeOriginalCache['tbltechnicalskills_html']
            //        : '<tr><th>NA</th><td class="text-left">NA</td></tr>'
            //);

            // Prev Work Experience section
            var prevExpVisible = (config['PrevWorkExp'] !== false && config['PrevWorkExp'] !== 0);
            // Added by Aditya J. - GDPR Settings-based field visibility on Resume page
            // Requirement update: hide this tab/section when disabled (do not show NA row).
            $('#gdprResumePrevWorkExpBlock').toggle(prevExpVisible);

            // Prev Assignment section
            var prevAssignVisible = (config['PrevAssignment'] !== false && config['PrevAssignment'] !== 0);
            // Added by Aditya J. - GDPR Settings-based field visibility on Resume page
            // Requirement update: hide this tab/section when disabled (do not show NA row).
            $('#gdprResumePrevAssignmentBlock').toggle(prevAssignVisible);

            // Certifications block
            var certVisible = (config['Certifications'] !== false && config['Certifications'] !== 0);
            gdprCacheOriginalIfNeeded('certificationlist_html', $('#certificationlist').html());
            $('#certificationlist').html(certVisible ? gdprResumeOriginalCache['certificationlist_html'] : 'NA');
            $('#gdprResumeCertificationsBlock').show();

            // Qualifications block
            var qualVisible = (config['Qualifications'] !== false && config['Qualifications'] !== 0);
            gdprCacheOriginalIfNeeded('qualificationlist_html', $('#qualificationlist').html());
            $('#qualificationlist').html(qualVisible ? gdprResumeOriginalCache['qualificationlist_html'] : 'NA');
            $('#gdprResumeQualificationsBlock').show();

            // Keep header visible; if both hidden then text data still shows as NA.
            $('#gdprResumeCertQualificationHeader').show();

            // Fail-safe: keep same "permanent hide" behavior as used in other GDPR pages.
            $('.gdpr-permanent-hide').hide();
        }

        // Load GDPR config from RM_GDPRSettings.aspx-backed API and apply to Resume.
        function gdprLoadAndApplyConfigOnResume() {
            // Fail-open defaults: if API fails, keep everything visible.
            var config = {};
            var defaultKeys = ['BirthDate', 'Email', 'AdvancedInfo', 'Certifications', 'Qualifications', 'PrevWorkExp', 'PrevAssignment'];
            $.each(defaultKeys, function (i, k) { config[k] = true; });

            var gdprUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-W26API").ToString%>';

            $.ajax({
                url: gdprUrl + 'api/GDPR_Settings/GetGDPRFieldConfig',
                type: 'POST',
                data: JSON.stringify({}),
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                beforeSend: function (xhr) {
                    // Prefer W26API token; fallback to token already used by this page.
                    var token = sessionStorage.getItem("access_token_W26API");
                    if (!token) token = sessionStorage.getItem("access_token-I");
                    xhr.setRequestHeader('Authorization', 'bearer ' + token);
                },
                success: function (result) {
                    // Expected response shape from GDPR Settings API:
                    // result.data.RM_GDPR_FieldConfig[] => { fieldName, isVisible }
                    if (result && result.data && result.data.RM_GDPR_FieldConfig) {
                        $.each(result.data.RM_GDPR_FieldConfig, function (i, item) {
                            var fieldName = item.fieldName || item.FieldName;
                            var isVisible = (item.isVisible !== undefined && item.isVisible !== null) ? item.isVisible : item.IsVisible;
                            if (fieldName) config[fieldName] = isVisible;
                        });
                    }

                    // Added by Aditya J. - GDPR Settings-based field visibility on Resume
                    gdprApplyConfigOnResume(config);
                },
                error: function () {
                    // Added by Aditya J. - GDPR Settings-based field visibility on Resume
                    gdprApplyConfigOnResume(config);
                }
            });
        }

        function GetResourceResume() {
            var strHTML = "";
             var EmployeeID = '<%= Request.QueryString("EmployeeID")%>'
           
            var OuOuParameter = { EmployeeID: EmployeeID };
            var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            StartLoader("#bodyBusiness-group");
            $.ajax({
                url: strUrl + '/api/RM_OrganizationUnit/GetResourceResume',
                type: "POST",
                data: JSON.stringify(OuOuParameter),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (OuOuParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(OuOuParameter) ? OuOuParameter : JSON.stringify(OuOuParameter)));
                    }
                },
                success: function (data) {
                  
                    var MyEmployeeResume = data;
                    if (MyEmployeeResume.ProfileImage == null || MyEmployeeResume.ProfileImage == '' || MyEmployeeResume.ProfileImage == 'undefined') {
                        $('#employeeImage').prop('src', "../../../Whizible2.0-new/dist/img/blankprofile.png");
                    }
                    else {
                        $('#employeeImage').prop('src', "../" + MyEmployeeResume.ProfileImage);

                    }
                    if (MyEmployeeResume.EmployeeInfo != null) {
                        strHTML += '<h4 style="margin-top:0">' + MyEmployeeResume.EmployeeInfo.EmployeeName + '</h4><span>' + MyEmployeeResume.EmployeeInfo.Designation + '</span>';
                        $("#employeeName").html(strHTML);

                        // Added by Aditya J. - GDPR Settings-based field visibility on Resume page
                        // Wrap each GDPR-configurable field in a stable DOM id so it can be hidden/shown after API config load.
                        var strEmployeInfoHTML =
                            '<p id="gdprResumeBirthDate" style="margin-bottom:0"><label>Date of Birth : </label><span>' + MyEmployeeResume.EmployeeInfo.DOB + '</span></p>' +
                            '<p id="gdprResumePhone" style="margin-bottom:0"><label>Phone No : </label><span>' + MyEmployeeResume.EmployeeInfo.Phone + '</span></p>' +
                            '<p id="gdprResumeEmail" style="margin-bottom:0"><label>Email ID : </label><span><a href="mailto:quality05@lifeline-sys.com"></a>' + MyEmployeeResume.EmployeeInfo.EmailID + '</span></p>';
                        $("#employeeInformation").html(strEmployeInfoHTML);
                    }
                    if (MyEmployeeResume.EmployeeSkillslst != null && MyEmployeeResume.EmployeeSkillslst.length > 0) {

                        var strEmployeeSkillHTML = '<tr class="bankrow"><td colspan="2">&nbsp;</td></tr>';
                        $.each(MyEmployeeResume.EmployeeSkillslst, function (index, obj) {
                            console.log('obj.YearsOfExperiance');
                            console.log(obj.YearsOfExperiance);
                            console.log('obj.MonthsOfExperiance')
                            console.log(obj.MonthsOfExperiance)
                            if (obj.YearsOfExperiance=="") {
                                obj.YearsOfExperiance="0"
                            }
                             if (obj.MonthsOfExperiance=="") {
                                obj.MonthsOfExperiance="0"
                            }
                            strEmployeeSkillHTML += '<tr><th>' + obj.Tool + '</th> <td class="text-left">Experience of ' + obj.YearsOfExperiance + ' Years and ' + obj.MonthsOfExperiance + ' Months.</td> </tr>';

                        });
                        $("#tbltechnicalskills").html(strEmployeeSkillHTML);
                    }

                    if (MyEmployeeResume.EmployeeHistorylst != null && MyEmployeeResume.EmployeeHistorylst.length > 0) {

                        var strEmployeeHistoryHTML = '<tr class="bankrow"><td colspan="2">&nbsp;</td></tr>';
            
                        $.each(MyEmployeeResume.EmployeeHistorylst, function (index, obj) {

                            strEmployeeHistoryHTML += '<tr><td class="text-left"><strong>' + obj.OrganizationName + '</strong><span style="display:block;text-align:left">' + obj.PositionHeld + '</span></td> <td class="text-left">' + obj.PreviousWorkExperiance + '</td> </tr>';

                        });
                        $("#tblpreviousworkexp").html(strEmployeeHistoryHTML);
                    }

                    if (MyEmployeeResume.CurrentAssignments != null && MyEmployeeResume.CurrentAssignments.length > 0) {
                        var strEmployeeAssignmentHTML = '';

                        $.each(MyEmployeeResume.CurrentAssignments, function (index, obj) {

                            if (obj.DurationText != null) {
                                strEmployeeAssignmentHTML += '<tr><td class="RProname text-left"><strong>' + obj.ProjectName +' </strong><span class="ResumeAsignmentDetails">' + obj.Description + '</span></td><td><span style="display:block;text-align:center"> ' + obj.DurationText + '</span></td><td>' + obj.TeamSize + '</td>  <td>' + obj.RoleDescription + '</td> </tr>';
                            }
                            else
                            {
                                strEmployeeAssignmentHTML += '<tr><td class="RProname text-left"><strong>' + obj.ProjectName + '</strong><span class="ResumeAsignmentDetails">' + obj.Description + '</span></td><td>' + obj.Duration + '</td><td>' + obj.TeamSize + '</td>  <td>' + obj.RoleDescription + '</td> </tr>';
                            }

                        });
                        $("#tblEmployeeAssignment").html(strEmployeeAssignmentHTML);
                    }

                    if (MyEmployeeResume.PreviousAssignments != null && MyEmployeeResume.PreviousAssignments.length > 0) {
                        var strEmployeePreAssignmentHTML = '';                       
                        $.each(MyEmployeeResume.PreviousAssignments, function (index, obj) {
                            //Added by Chetan M on 7 Jul 2021 for Resume Issue
                            if (obj.DurationText == null) {
                                obj.DurationText = "0 Month(s)";
                            }
                            //End of Added by Chetan M on 7 Jul 2021 for Resume Issue
                            if (obj.DurationText != null) {
                                strEmployeePreAssignmentHTML += '<tr><td class="RProname text-left"><strong>' + obj.ProjectName + '</strong><span class="ResumeAsignmentDetails">' + obj.Description + '</span></td><td>' + obj.DurationText + '</span></td><td>' + obj.TeamSize + '</td>  <td>' + obj.Role + '</td><td>' + obj.SkillSet + '</td> </tr>';
                            }
                            else
                            {
                                strEmployeePreAssignmentHTML += '<tr><td class="RProname text-left"><strong>' + obj.ProjectName + '</strong><span class="ResumeAsignmentDetails">' + obj.Description + '</span></td><td></td><td>' + obj.TeamSize + '</td>  <td>' + obj.Role + '</td><td>' + obj.SkillSet + '</td> </tr>';
                            }
                            

                        });
                        $("#tblEmployeePreviousAssignment").html(strEmployeePreAssignmentHTML);
                    }


                    if (MyEmployeeResume.EmployeeCertificationlst != null && MyEmployeeResume.EmployeeCertificationlst.length > 0) {
                        var strCertificationHTML = '<ul>';
                        $.each(MyEmployeeResume.EmployeeCertificationlst, function (index, obj) {
                            var WithScore = " ";
                            if (obj.ActualScore!="" && obj.TotalScore!="") {
                                WithScore=' with score ' + obj.ActualScore + ' out of ' + obj.TotalScore +'.';
                            }
                           
                            if (obj.CertValidDate == "" || obj.CertValidDate == null) {
                                strCertificationHTML += '<li> Completed ' + obj.CertificationName + ' on ' + obj.CertDate + WithScore+ '</li>';
                                
                            }
                            else {
                                //commented and added by imran on 23-02-2022 for obj.CertValidDate == "01/01/1900" then cannot sho valid upto
                                //strCertificationHTML += '<li> Completed ' + obj.CertificationName + ' on ' + obj.CertDate + WithScore + 'It is valid upto ' + obj.CertValidDate + '.</li>';
                                if (obj.CertValidDate == "01/01/1900") {
                                     strCertificationHTML += '<li> Completed ' + obj.CertificationName + ' on ' + obj.CertDate + WithScore +'</li>';
                                }
                                else {
                                     strCertificationHTML += '<li> Completed ' + obj.CertificationName + ' on ' + obj.CertDate + WithScore + 'It is valid upto ' + obj.CertValidDate + '.</li>';
                                }
                                //End of comment by imran on 23-02-2022
                            }
                            
                            //strCertificationHTML += '<li>' + Completed + obj.CertificationName + on + obj.CertificationDate + 'with score' + obj.ActualScore + '. It is valid upto + obj.ValidUpto .' + '</li>';
                        });
                        strCertificationHTML += '</ul>';
                        $("#certificationlist").html(strCertificationHTML);
                    }

                    if (MyEmployeeResume.EmployeeQualificationlst != null && MyEmployeeResume.EmployeeQualificationlst.length > 0) {
                        var strQualificationHTML = '<ul>';
                        $.each(MyEmployeeResume.EmployeeQualificationlst, function (index, obj) {
                            //ADCCS (2019) from Pune with 0 GPA.
                            var QlWithPercentage =  ' '+obj.QualificationName + ' ( '+ obj.PassoutYear  +' ) '+ ' from ' + obj.University +'';
                            if (obj.Percentage!="" && obj.Percentage>0) {
                                QlWithPercentage += ' with score ' + obj.Percentage + '';
                            }
                            //strQualificationHTML += '<li>Completed '+ obj.QualificationName + from + obj.University + ' with score ' + obj.Percentage + '</li>';
                           strQualificationHTML += '<li>' + QlWithPercentage + '</li>';

                        });
                        strQualificationHTML += '</ul>';
                        $("#qualificationlist").html(strQualificationHTML);
                    }

                    // Added by Aditya J. - GDPR Settings-based field visibility on Resume
                    // Apply GDPR configurable hide/show after the resume DOM is filled.
                    gdprLoadAndApplyConfigOnResume();

                    StopAjaxLoader("#bodyBusiness-group");
                },
                //Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
                //error: function (err) {
                //    console.log(err);
                //    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                //    StopAjaxLoader("#bodyBusiness-group");
                //}
                 error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message=="Authorization has been denied for this request." || thrownError=="Unauthorized") {
                            window.open("../../../Default.aspx","_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                    StopAjaxLoader("#bodyBusiness-group");
                }
                 //End of Commented and Integrated by Chetan M on 9 Jul 2021 for Session Expire
            })
                ;
        }


    </script>

</body>
</html>
