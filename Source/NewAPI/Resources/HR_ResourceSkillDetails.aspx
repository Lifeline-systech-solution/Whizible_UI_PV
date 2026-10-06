<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HR_ResourceSkillDetails.aspx.vb" Inherits="PbNIT.HR_ResourceSkillDetails" %>

<!DOCTYPE html>
<html>
  <%--Commented by Param for JQuery and Bootstrap version upgrade--%>
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head>
 <%--   <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css">
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>



    
</head>
    <style type="text/css">
        .dataTables_scrollBody thead tr[role="row"] {
            visibility: collapse !important;
        }

        a.clearalllink {
            font-weight: bold;
            margin: 7px 0px 0 8px;
            display: none;
        }

        .filter.float-end {
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

        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .RsrsSkillView tr th:first-child, .RsrsSkillView tr th:nth-child(5) {
            min-width: 130px !important;
        }

        .legend ul {
            overflow: hidden;
            margin-bottom: 0;
            margin-top: 3px;
        }

        .legend li:first-child {
            margin-left: 0;
        }

        .legend li {
            float: left;
            list-style-type: none;
        }

        .legend span {
            display: inline-block;
            width: 12px;
            height: 12px;
            margin-right: 6px;
        }


        /*Resume Style*/
        .content-wrapper {
            background: #eee !important
        }

        .resumecontainer {
            max-width: 860px;
            margin: 0px auto;
            border: 1px solid #ddd;
            box-shadow: 0 1px 4px rgba(0,0,0,0.1);
            background: #fff;
            border-radius: 4px
        }

        .resumeHeader {
            padding: 15px 0;
            border-bottom: 1px solid #eee
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
        /*Resume Style end here*/

        .filter button[aria-expanded="true"] {
            background: none;
        }
        .form-select.input-sm {
    font-size: 12px!important;
}
    </style>

<body class="hold-transition skin-blue-light sidebar-mini fixed">
    <% If m_ViewAccess = True Then %>
    <div class="bgwhite">
        <div class="container-fluid pt-1 pb-1 mb-1 text-end graybg">
            <h5 class="pgtitle float-start"><%= MyBase.GetResourceString("C_ResourceSkillView") %></h5>
            <a href="javascript:;" class="clearalllink" style="" onclick="ClearAll()" id="ClearAllFilter" data-bs-toggle="tooltip" data-bs-placement="bottom" title=""><strong><%= MyBase.GetResourceString("C_ClearAll") %></strong></a>
            <div class="filter inline float-end">
                <button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-bs-placement="bottom" title="" id="AdvanceFilterIcon" data-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>
            </div>
            <div class="clearfix"></div>
        </div>
        <!--filter panel-->
        <div id="filterpanel" class="filterpanel collapse" style="margin-bottom: 10px;">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">

                <div class="cust_tabpanel">
                    <ul class="nav nav-tabs">
                        <li class="dropdown">
                            <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" aria-expanded="false" onclick="AllResourceFilters()"><%= MyBase.GetResourceString("C_MyFilters") %></a>
                            <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                            </ul>
                        </li>
                        <li class="">
                            <a href="#basicfilters" data-bs-toggle="tab" aria-expanded="true"><%= MyBase.GetResourceString("C_BasicFilters") %></a>
                        </li>


                    </ul>
                </div>

                <div class="Fwrapper">
                    <div class="tab-content">
                        <div id="basicfilters" class="tab-pane">
                            <div class="filterpanelbody">
                                <div class="text-center hidden-xs centerbtn">
                                    <button class="btn btnyellow" id="svfilterbtn" onclick="btnSaveAndApplyFilter_Onclick()"><%= MyBase.GetResourceString("C_SaveandApply") %></button>
                                    <button class="btn btnyellow" id="btnFilterApply" onclick="ResourceskillbtnApplyFilter()"><%= MyBase.GetResourceString("C_Apply") %></button>
                                </div>
                                <br />
                                <div class="row mb-3">
<div class="col-sm-6 form-group">
                        <div class="row">
                             <label class="col-sm-4"><%= MyBase.GetResourceString("C_ResourceName") %></label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRSDFilterEmployeeName", "Exec usp_Whizible2_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select input-sm'",) %>
                                            </div>
                                            <div class="col-sm-8 col-sm-8 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRSDFilterEmployeeName", "txtRSDFilterEmployeeName", "form-control input-sm",, 50,,,, ,,,, "autocomplete='off' maxlength='100'", ,, True,,,,) %>
                                            </div>
                                        </div>
                                    </div>

                                 </div>
                                   

                                </div>
                                <div class="col-sm-6 form-group">
                                    <div class="row">
                            <label class="col-sm-4"><%= MyBase.GetResourceString("C_PrimarySkills") %></label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRSDFilterPrimarySkills", "Exec usp_Whizible2_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select input-sm'",) %>
                                            </div>
                                            <div class="col-sm-8 col-sm-8 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRSDFilterPrimarySkills", "txtRSDFilterPrimarySkills", "form-control input-sm",, 50,,,, ,,,, "autocomplete='off' maxlength='100'", ,, True,,,,) %>
                                            </div>
                                        </div>
                                    </div>
                                    </div>
                                    

                                </div>
                                </div>
                                
                                <div class="row mb-3">
                                    <div class="col-sm-6 form-group">
                                        <div class="row">
                                <label class="col-sm-4"><%= MyBase.GetResourceString("C_TotalExperience") %></label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRSDFilterTotalExp", "Exec usp_Whizible2_Sel_Filter_FillOperatorCombo 'NUM'",,, "class='form-select input-sm'",) %>
                                            </div>
                                            <div class="col-sm-8 col-sm-8 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRSDFilterTotalExp", "txtRSDFilterTotalExp", "form-control input-sm",, 50,,,, ,,,, "autocomplete='off' maxlength='100'", ,, True,,,,) %>
                                            </div>
                                        </div>
                                    </div>
                                        </div>
                                </div>
                                <div class="col-sm-6 form-group">
                                    <div class="row">
                                    <label class="col-sm-4"><%= MyBase.GetResourceString("C_Experiencewithus") %></label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRSDFilterCurrentExp", "Exec usp_Whizible2_Sel_Filter_FillOperatorCombo 'NUM'",,, "class='form-select input-sm'",) %>
                                            </div>
                                            <div class="col-sm-8 col-sm-8 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("txtRSDFilterCurrentExp", "txtRSDFilterCurrentExp", "form-control input-sm",, 50,,,, ,,,, "autocomplete='off' maxlength='100'", ,, True,,,,) %>
                                            </div>
                                        </div>
                                    </div>
                                    </div>
                                    
                                </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-sm-6 form-group">
                                        <div class="row">
                                            <label class="col-sm-4"><%= MyBase.GetResourceString("C_OtherSkills") %></label>
                                    <div class="col-sm-8">
                                        <div class="row">
                                            <div class="col-sm-4">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRSDFilterSkills", "Exec usp_Whizible2_Sel_Filter_FillOperatorCombo 'CHAR'",,, "class='form-select input-sm'",) %>
                                            </div>
                                            <div class="col-sm-8 col-sm-8 pl-0">
                                                <% CommonFunctions.HTMLControls.DrawTextArea("txtRSDFilterSkills", "txtRSDFilterSkills", , "form-control",,,,,,,,,,,,,,,,,,,,,,,,,) %>
                                            </div>
                                        </div>
                                    </div>
                                        </div>
                                    

                                </div>
                                <div class="col-sm-12 col-sm-6 form-group">
                                    &nbsp;
                                </div>
                                </div>
                                

                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>
        <!--end filter panel-->


        <div class="content pt-1">
            <div class="form-group mb-3">
                <div class="col-sm-9">
                    <div class="pt-1">
                        <div class="row">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label for="email"><%= MyBase.GetResourceString("C_OrganizationStructure") %> : </label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboBGOU", "Select ''",,, "class='form-select' onChange='OnchangeSimpleFilter()'",, ,, ) %>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label for="email"><%= MyBase.GetResourceString("C_CategoryName") %> : </label>
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboCategoryName", "usp_Whizible2_sel_tbl_PM_Tools_Category_CategoryName",,, "class='form-select' onChange='OnchangeSimpleFilter()'",, ,, ) %>
                                </div>
                            </div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <label for="email"><%= MyBase.GetResourceString("C_OtherSkills") %> : </label>
                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtOtherSkill", "txtOtherSkill", "form-control",,,,,,,,,, "autocomplete='off'") %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                </div>
            </div>



            <table id="RsrsSkillView" class="table table-bordered RsrsSkillView" style="width: 100%;">
                <thead>
                    <tr>
                        <th><%= MyBase.GetResourceString("C_ResourceName") %></th>
                        <th><%= MyBase.GetResourceString("C_TotalExperience") %></th>
                        <th><%= MyBase.GetResourceString("C_Experiencewithus") %></th>
                        <th><%= MyBase.GetResourceString("C_PrimarySkills") %></th>
                        <th><%= MyBase.GetResourceString("C_ResourceLoading") %></th>
                        <th><%= MyBase.GetResourceString("C_Resume") %></th>
                        <th class="text-start"><%= MyBase.GetResourceString("C_OtherSkills") %></th>
                    </tr>
                </thead>
                <tbody id="RsrsSkillViewTblBody">
                </tbody>
            </table>
        </div>

        <div class="clearfix"></div>
    </div>
    <% Else %>
    <div id="NotAuthorized">
        <h4>You are not authorized to view this record. </h4>
    </div>
    <% End If %>


    <!-- ./wrapper -->

    <!-- Save filter Modal start here-->
    <div class="modal custmodal Issuesave_filter fade" id="RDSsavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-dismiss="modal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_SaveFilterAs") %></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="Issuesavrefilterbox" class="box-panel">

                        <div class="box-body graybg">
                            <div class="form-group mb-0">
                                <div class="row">
                                    <div class="col-md-12 row">
                                        <label class="control-label col-md-4 p-0 text-end"><%= MyBase.GetResourceString("C_FilterName") %> </label>
                                        <span class="col-md-8">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", "form-control",, 50,,,, ,,,, "autocomplete='off' maxlength='100'", ,, True,,,,) %><br />
                                            <div class="btnrow">
                                                <button id="savefilterbtn" class="btn btnyellow float-start" onclick="SaveFilterValidation()"><%= MyBase.GetResourceString("C_Save") %></button>
                                                <button data-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end"><%= MyBase.GetResourceString("C_Cancel") %></button>
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
    <!--resume modal start here-->
    <div class="modal custmodal fade" id="ResumeModal" aria-hidden="true" data-dismiss="modal">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Resume</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="resumecontainer">
                        <div class="resumeHeader">
                            <div class="row">
                                <div class="col-xs-12 col-sm-3 text-center">
                                    <figure>
                                        <img style="margin: 0 auto;" width="150" class="img-circle img-responsive" alt="" src="../../../Whizible2.0-new/dist/img/blankprofile.png">
                                    </figure>
                                </div>

                                <div class="col-xs-12 col-sm-9">
                                    <div class="resumehdright graybg">
                                        <div class="CandidateName float-start">
                                            <h4 style="margin-top: 0">John Dawyer</h4>
                                            <span>Business Development Manager</span>
                                        </div>
                                        <div class="candidateContctinfo float-end">
                                            <p style="margin-bottom: 0">
                                                <label>Date of Birth : </label>
                                                <span>09/08/1974</span>
                                            </p>
                                            <p style="margin-bottom: 0">
                                                <label>Phone No : </label>
                                                <span>1111 222 3333</span>
                                            </p>
                                            <p style="margin-bottom: 0">
                                                <label>Email ID : </label>
                                                <span><a href="mailto:quality05@lifeline-sys.com"></a>quality05@lifeline-sys.com</span>
                                            </p>
                                        </div>
                                        <div class="clearfix"></div>
                                        <hr style="margin: 10px 0; border-color: #ddd;" />
                                        <p style="margin-bottom: 0;">Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam</p>
                                        <!--<ul class="list-group">
                                            <li class="list-group-item">Name!</li>
                                            <li class="list-group-item">Company!</li>
                                            <li class="list-group-item">Job Description! </li>
                                            <li class="list-group-item"><i class="fa fa-phone"></i> Phone no. </li>
                                            <li class="list-group-item"><i class="fa fa-envelope"></i> Email-id </li>
                                        </ul>-->
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="resumebody">
                            <table class="table table-stripped table-bordered" style="width: 100%;">
                                <thead>
                                    <tr>
                                        <th colspan="2" class="resumetblTitle text-start">Technical Skills</th>
                                    </tr>

                                </thead>
                                <tbody>
                                    <tr class="bankrow">
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <th>JAVA</th>
                                        <td class="text-start">Experience of 2Months.</td>
                                    </tr>
                                    <tr>
                                        <th>SQL</th>
                                        <td class="text-start">Experience of 2Months.</td>
                                    </tr>
                                </tbody>
                            </table>

                            <table class="table table-stripped table-bordered" style="width: 100%; margin-bottom: 0;">
                                <thead>
                                    <tr>
                                        <th colspan="5" class="resumetblTitle text-start">Current Assignments</th>
                                    </tr>
                                    <tr class="bankrow">
                                        <td colspan="5">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <th class="text-start">Project Name</th>
                                        <th>Duration<span>(Years)</span></th>
                                        <th>Team<span>Size</span></th>
                                        <th>Role</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="RProname text-start">
                                            <strong>LifeLine Strategy Project (2019-20)</strong>
                                            <span class="ResumeAsignmentDetails">This project is created to conduct weekly review meetings,action items etc</span>
                                        </td>

                                        <td>From 08/05/2019</td>
                                        <td>11</td>
                                        <td>Project Manager Scrum Master</td>
                                    </tr>
                                    <tr>
                                        <td class="RProname text-start">
                                            <strong>LifeLine Strategy Project (2019-20)</strong>
                                            <span class="ResumeAsignmentDetails">This project is created to conduct weekly review meetings,action items etc</span>
                                        </td>

                                        <td>From 08/05/2019</td>
                                        <td>11</td>
                                        <td>Project Manager Scrum Master</td>
                                    </tr>
                                    <tr>
                                        <td class="RProname text-start">
                                            <strong>LifeLine Strategy Project (2019-20)</strong>
                                            <span class="ResumeAsignmentDetails">This project is created to conduct weekly review meetings,action items etc</span>
                                        </td>

                                        <td>From 08/05/2019</td>
                                        <td>11</td>
                                        <td>Project Manager Scrum Master</td>
                                    </tr>
                                    <tr>
                                        <td class="RProname text-start">
                                            <strong>LifeLine Strategy Project (2019-20)</strong>
                                            <span class="ResumeAsignmentDetails">This project is created to conduct weekly review meetings,action items etc</span>
                                        </td>

                                        <td>From 08/05/2019</td>
                                        <td>11</td>
                                        <td>Project Manager Scrum Master</td>
                                    </tr>
                                </tbody>
                            </table>
                            <br />
                            <div class="text-center">
                                <button class="btn borderbtn" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>
    <!--resume modal end here-->
    <!--resource loading start here-->
    <div class="modal custmodal fade" id="ResrsloadingModal" aria-hidden="true" data-dismiss="modal">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Resource Loading</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="resource_utilization_panel">
                        <div class="float-end pb-1">
                            <a href="javascript:;" class="btn borderbtn">Previous Year</a>
                            <a href="javascript:;" class="btn borderbtn">Next Year</a>
                            <div class="clearfix"></div>
                        </div>
                        <div class="tabcontent_body">

                            <div class="clearfix"></div>
                            <div class="graybg container-fluid pt-1 text-end">
                                <div class="row">
                                    <div class="col-sm-5">
                                        <p class="text-start float-start">
                                            <strong>Resource Loading for year 2019 to 2020</strong>
                                        </p>

                                    </div>
                                    <div class="col-sm-7 text-end">
                                        <span class="float-end"><strong>Resource : Ranok - Raonak[BUSINESS DEVELOPMENT MANAGER]</strong></span>
                                    </div>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-sm-8">
                                    <div class="resourceutilization_pie_chart">
                                        <canvas id="benchhours_pie_chart5" height="100"></canvas>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <div class="table-responsive">
                                        <table class="table table-bordered utlizationtbl">
                                            <tr>
                                                <th>Install Capacity</th>
                                                <td>2826 Hrs</td>
                                            </tr>
                                            <tr>
                                                <th>Available for allocation</th>
                                                <td>2826 Hrs</td>
                                            </tr>
                                            <tr>
                                                <th>Billable Hours</th>
                                                <td>0 Hrs</td>
                                            </tr>
                                            <tr>
                                                <th>Non Billable Hours</th>
                                                <td>0 Hrs</td>
                                            </tr>

                                        </table>
                                    </div>
                                    <small><strong>Note:</strong> <em>The "Install Capacity" is working hours for current financial year excluding Leaves</em></small>
                                </div>
                            </div>
                            <hr />
                            <h5>Monthly Loading (Fianancial Year)</h5>
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th width="22%" class="text-start">&nbsp;</th>
                                            <th>Apr</th>
                                            <th>May</th>
                                            <th>Jun</th>
                                            <th>Jul</th>
                                            <th>Aug</th>
                                            <th>Sep</th>
                                            <th>Oct</th>
                                            <th>Nov</th>
                                            <th>Dec</th>
                                            <th>Jan</th>
                                            <th>Feb</th>
                                            <th>Mar</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="text-start">Resource Utilization %</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                        </tr>
                                        <tr>
                                            <td class="text-start">Bench Hours</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                            <td>0.00</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <h5>Project Loading</h5>
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th width="22%" class="text-start">Project Name</th>
                                            <th>Apr</th>
                                            <th>May</th>
                                            <th>Jun</th>
                                            <th>Jul</th>
                                            <th>Aug</th>
                                            <th>Sep</th>
                                            <th>Oct</th>
                                            <th>Nov</th>
                                            <th>Dec</th>
                                            <th>Jan</th>
                                            <th>Feb</th>
                                            <th>Mar</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td class="text-start">Product PRE-SALES 2017-18</td>
                                            <td>100/30</td>
                                            <td>80/30</td>
                                            <td>100/30</td>
                                            <td>80/30</td>
                                            <td>100/30</td>
                                            <td>80/30</td>
                                            <td>100/30</td>
                                            <td>80/30</td>
                                            <td>100/30</td>
                                            <td>80/30</td>
                                            <td>100/30</td>
                                            <td>80/30</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>


                    </div>

                </div>

            </div>
        </div>
    </div>
    <!--resource loading modal end here-->
    <!-- REQUIRED JS SCRIPTS -->

    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>    
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%>


    <script>
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip();
        //datatable
        $('#RsrsSkillView').dataTable({
            //"ajax": '/api/data',
            "scrollY": true,
            "scrollX": true,
            //"scroller": true,
            "pageLength": 10,
            //"paging": false,
            "lengthChange": false,
            "bFilter": false,
            "ordering": false,
            "responsive": true,
            "destroy": false,
            "retrieve": true,
            "responsive": true
            //"scrollable":true,
            //"scrollCollapse": true
        });
        setTimeout(function () {
            $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
        }, 0);
        function resizeSection() {
            var tblheight = $(window).height();
            $('.dataTables_scrollBody').css({ 'height': tblheight - 260, "overflow-y": "auto" });

            var tblheight = $(window).height();
            $('.Resourcedetailpanel').css({ 'height': tblheight - 80 });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);
            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 0);
        });
        $("#filterpanel").on("show.bs.collapse", function () {
            //$(".clearalllink").css("display", "inline-block");
        });
        $("#filterpanel").on("hide.bs.collapse", function () {
            //$(".clearalllink").hide();
        });

    </script>

    <script>
        //Added By Riddhesh Patil on 16-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of Added By Riddhesh Patil
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        alertify.set('notifier', 'position', 'top-right');
        var UserID = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var LoginType = '<%= Session("LoginType") %>';
        var ajaxResult = "";
        var GlobalApplyID = "";
        var GlobalQueryText = "";
        var savedFilterName = "";
        var GlobalFilterID = "";
        var GlobalFilterName = "";
        var FilterID = "";
        var flag = 0;
        var GlobalFilterFlag = "";
        var DefaultFilterID = "";
        var AllFields = ["EmployeeName", "PrimarySkills", "TotalExp", "CurrentExp", "Skills"];
        $(document).ready(function () {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });
            $("#cboCategoryName").prepend("<option value='' selected='selected'>Select Category Name</option>");
            BindOrganizationStructure();
            GetDefaultFilter();
        });

        function GetSkillDetailList(QueryText) {
            if (QueryText == undefined || QueryText == '' || QueryText == null) {
                QueryText = "Null";
                $("#ClearAllFilter").hide();
                $(".filterpanel").removeClass('in');
                ClearBasicFilter("RSD");
                GlobalApplyID = '';
            }
            else {
                QueryText = QueryText;
            }

            var OrganizationUnitID = $("#cboBGOU").val();
            var CategoryID = $("#cboCategoryName").val();
            var Skill = $("#txtOtherSkill").val();
            if (OrganizationUnitID == undefined || OrganizationUnitID == '' || OrganizationUnitID == null) {
                OrganizationUnitID = "Null";
            }
            if (CategoryID == undefined || CategoryID == '' || CategoryID == null) {
                CategoryID = "Null";
            }
            if (Skill == undefined || Skill == '' || Skill == null) {
                Skill = "Null";
            } else {
                Skill = ' "%' + Skill + '%"';
                Skill = Skill.replace(/'/g, "''");
            }

            //StartLoader("#RDSBody");
            $("#RsrsSkillView").dataTable().fnDestroy();
            var Parameters = {
                QueryText: encodeURI(QueryText),
                OrganizationUnitID: encodeURI(OrganizationUnitID),
                CategoryID: encodeURI(CategoryID),
                Skill: encodeURI(Skill)
            }
            var param = JSON.stringify(Parameters);
            var strResult = AJAXCallWithResult("/api/HR_ResourceSkillDetails/GetSkillDetailList", param, false);
            $("#RsrsSkillViewTblBody").html('');
            var strHTML = "";
            for (var i = 0; i < strResult.length; i++) {
                var EmployeeID = strResult[i]["EmployeeID"];
                var EmployeeName = strResult[i]["EmployeeName"];
                var TotalExp = strResult[i]["TotalExp"];
                var CurrentExp = strResult[i]["CurrentExp"];
                var PrimarySkills = strResult[i]["PrimarySkills"];
                var Skills = strResult[i]["Skills"];

                strHTML += '<tr>'
                strHTML += '<td>' + EmployeeName + '</td>'
                strHTML += '<td>' + TotalExp + '</td>'
                strHTML += '<td>' + CurrentExp + '</td>'
                strHTML += '<td>' + PrimarySkills + '</td>'
                //strHTML += '<td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ResrsloadingModal">Resource Loading</a></td>'
                strHTML += '<td><a href="javascript:; onclick=ResourceUtilizationOnclick(' + EmployeeID + ')">Resource Loading</a></td>'
                //strHTML += '<td><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#ResumeModal">Resume</a></td>'
                strHTML += '<td><a href="javascript:; Onclick= Resume_OnClick(' + EmployeeID + ')">Resume</a></td>'
                strHTML += '<td class="text-start">' + Skills + '</td>'
                strHTML += '</tr>'
            }
            $("#RsrsSkillViewTblBody").html("")
            $("#RsrsSkillViewTblBody").html(strHTML);

            $('#RsrsSkillView').dataTable({
                "scrollY": true,
                "scrollX": true,
                "pageLength": 10,
                "lengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": true,
                "destroy": false,
                "retrieve": true,
                "responsive": true

            });

        }

        function OnchangeSimpleFilter() {
            GetSkillDetailList(GlobalQueryText);
        }

        $('#txtOtherSkill').keypress(function (e) {
            if (e.which == 13) {//Enter key pressed
                GetSkillDetailList(GlobalQueryText);//Trigger search button click event
            }
        });

        function BindOrganizationStructure() {
            var BusinessGroup = "";
            var ChkBusinessGroup = "";
            var strResult = AJAXCallWithResult("/api/HR_ResourceSkillDetails/GetOrganizationStructure", '', false);
            var objCbo1 = document.getElementById("cboBGOU")
            $("#cboBGOU option").remove();
            $("#cboBGOU optgroup").remove();
            for (var i = 0; i < strResult.length; i++) {
                if (strResult[i].BusinessGroup == "") {
                    var Objresult = strResult[i];
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    objOption.value = Objresult.LocationID == 0 ? '' : Objresult.LocationID;
                    objOption.text = Objresult.Location;
                }
                if (strResult[i].BusinessGroup != null && BusinessGroup != strResult[i].BusinessGroup) {
                    BusinessGroup = strResult[i]["BusinessGroup"];
                    var objOption1 = document.createElement("optgroup");
                    $("#cboReportingToAdd").append(objOption1);
                    objCbo1.options.add(objOption1);
                    objOption1.label = BusinessGroup;
                    for (var j = 0; j < strResult.length; j++) {
                        ChkBusinessGroup = strResult[j]["BusinessGroup"];
                        if (BusinessGroup == ChkBusinessGroup) {
                            var Objresult = strResult[j];
                            var Objresult = strResult[j];
                            var objOption = document.createElement("OPTION");
                            objCbo1.options.add(objOption);
                            objOption.value = Objresult.LocationID == null ? '' : Objresult.LocationID;
                            objOption.text = Objresult.Location;
                        }
                    }
                }
            }
        }

        

        //Function for direct to  Resource Loading Page
        function ResourceUtilizationOnclick(EmployeeID) {

            var ProjectName = "";
            var ProjectID = '<%= Session("intProjectID") %>'
            EmployeeID = EmployeeID;
           /* generatetokenResourceLoading(EmployeeID);*/

            window.open("../PM/PM_ResourceLoading.aspx?PKToken=" + m_CurrentToken + "&ProjectID=" + ProjectID + " &EmployeeID=" + EmployeeID + " &Link=AR" + "&ProjectName=" + ProjectName + "&MasterTagId=3861", "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 920) / 2 + ",top=" + (window.screen.height - 900) / 2 + ",width=900,height=600");

        }

<%--        var m_CurrentToken = '';
        function generatetokenResourceLoading(EmployeeID) {

            try {

                var ProjectID = '<%= Session("intProjectID") %>'

                var EmployeeID = EmployeeID;

                if (ProjectID != undefined) {
                    var generatedtoken = ajaxCall("HR_ResourceSkillDetails.aspx/GeneratePK_TokenUtilization", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: ProjectID, EmployeeID: EmployeeID }));
                    if (generatedtoken != undefined) {

                        m_CurrentToken = generatedtoken.d;
                        validatetokenResourceLoading(EmployeeID);
                    }
                }
            }
            catch (ex) {
                //alert(ex.message());
            }
        }--%>

<%--        var m_PKToken;
        function validatetokenResourceLoading(EmployeeID) {

            try {
                var ProjectID = '<%= Session("intProjectID") %>'
                var EmployeeID = EmployeeID;
                m_PKToken = m_CurrentToken;

                if (ProjectID != undefined) {
                    var validatetoken = ajaxCall("HR_ResourceSkillDetails.aspx/ValidatePK_TokenUtilization", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: ProjectID, EmployeeID: EmployeeID, PKToken: m_PKToken }));

                    if (validatetoken != undefined) {
                        if (validatetoken.d == false) {
                            window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                        }

                    }
                }
            }
            catch (ex) {
                alert(ex.message());
            }
        }--%>


        /////////////////////  Resume Token Generation Code //////////////////////////////////
        function Resume_OnClick(EmployeeID) {
           /* GeneratePK_TokenResumePage(EmployeeID)*/
            window.open("../Resources/RM_Resume.aspx?PKToken=" + R_CurrentToken + " &EmployeeID=" + EmployeeID + "&TagId=3861&MasterTagId=3861", "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 920) / 2 + ",top=" + (window.screen.height - 900) / 2 + ",width=900,height=600");
        }
        //var R_CurrentToken = '';
        //function GeneratePK_TokenResumePage(EmployeeID) {
        //    try {
        //        var EmployeeID = EmployeeID;
        //        var generatedtoken = ajaxCall("HR_ResourceSkillDetails.aspx/GeneratePK_TokenResumePage", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ EmployeeID: EmployeeID }));
        //        if (generatedtoken != undefined) {
        //            R_CurrentToken = generatedtoken.d;
        //            ValidatePK_TokenResumePage(EmployeeID);
        //        }

        //    }
        //    catch (ex) {
        //        //alert(ex.message());
        //    }
        //}

        //var R_PKToken;
        //function ValidatePK_TokenResumePage(EmployeeID) {
        //    try {
        //        var EmployeeID = EmployeeID;
        //        R_PKToken = R_CurrentToken;
        //        var validatetoken = ajaxCall("HR_ResourceSkillDetails.aspx/ValidatePK_TokenResumePage", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ EmployeeID:EmployeeID, PKToken: R_PKToken }));
        //        if (validatetoken.d == false) {
        //            window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
        //        }
        //    }
        //    catch (ex) {
        //        alert(ex.message());
        //    }
        //}

        /////////////////////  End Resume Token Generation Code //////////////////////////////////


        function ajaxCall(url, type, contentType, dataType, data) {
            var ajaxResult;

            $.ajax({
                url: url,
                type: "POST",
                data: data,
                async: false,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
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
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (param) {
                        xhr.setRequestHeader("Params", encryptString(isJson(param) ? param : JSON.stringify(param)));
                    }
                },
                success: function (data) {
                    ajaxResult = data;
                },
                error: function (xhr, ajaxOptions, thrownError) {
                    if (ajaxOptions == "error") {
                        if (xhr.responseJSON.Message == "Authorization has been denied for this request." || thrownError == "Unauthorized") {
                            window.open("../../../Default.aspx", "_top");
                        } else {
                            window.location.href = "../../General/default.aspx.aspx?Mode=AJAXError&Error=" + xhr.responseJSON.Message + ""
                        }
                    }
                },
            });
            return ajaxResult;
        }

        //Filter Part Start From Here

        //Only Apply Filter
        function ResourceskillbtnApplyFilter() {
            var QueryText = "";
            QueryText = GenerateBasicFilterQuery('RSD', AllFields);
            if (QueryText == "") {
                alertify.error("Please select at least on filter.");
            } else {
                GlobalQueryText = QueryText;
                GetSkillDetailList(QueryText);
                $("#filterpanel").removeClass("in");
                $("#AdvanceFilterIcon").addClass("activefilter");
                $(".clearalllink").css("display", "inline-block");
            }
        }


        // Create Filter Query
        function GenerateBasicFilterQuery(module, AllFields) {
            var strqtext = "";
            for (var i = 0; i < AllFields.length; i++) {
                var strvalue = '';
                var strOp = $('select#cbo' + module + 'Filter' + AllFields[i] + ' option:selected').val();
                var strCHK = $('#chk' + module + 'Filter' + AllFields[i]).is(":checked");
                if ($("#txt" + module + "Filter" + AllFields[i]).val() != null) {
                    strvalue = $("#txt" + module + "Filter" + AllFields[i]).val().trim();
                }
                if (strvalue != "" && strvalue != "0" && strvalue != null && strvalue != "null") {
                    if (strqtext != "") strqtext += " AND ";
                    if (strOp == "Contains") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += ' "%' + strvalue + '%"';
                    }
                    else if (strOp == "Ends With") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += ' "%' + strvalue + '"';
                    }
                    else if (strOp == "Exact Word") {
                        strqtext += AllFields[i] + " = ";
                        strqtext += ' "' + strvalue + '"';
                    }
                    else if (strOp == "Not Contains") {
                        strqtext += AllFields[i] + " ";
                        strqtext += ' NOT LIKE "%' + strvalue + '%"';
                    }
                    else if (strOp == "Starts With") {
                        strqtext += AllFields[i] + " LIKE ";
                        strqtext += ' "' + strvalue + '%"';
                    }
                    else {
                        strqtext += AllFields[i] + " ";
                        strqtext += strOp + ' "' + strvalue + '"';
                    }
                }

                if (strOp == "=" && strCHK == true) {
                    if (strqtext != "" && strqtext != '' && strqtext != null && strqtext != undefined) {
                        strqtext += ' AND '
                    }
                    if (strvalue == "" || strvalue == undefined) {
                        strqtext += AllFields[i] + " = " + '"' + strCHK + '"';
                    }
                    else {
                        strqtext += AllFields[i] + "=" + '"' + strCHK + '"';
                    }
                }
                if (strOp == "<>" && strCHK == true) {
                    if (strqtext != "" && strqtext != '' && strqtext != null && strqtext != undefined) {
                        strqtext += ' AND '
                    }
                    if (strvalue == "" || strvalue == undefined) {
                        strqtext += AllFields[i] + " <> " + '"' + strCHK + '"';
                    }
                    else {
                        strqtext += AllFields[i] + "<>" + '"' + strCHK + '"';
                    }
                }

            }
            strqtext = strqtext.replace('Over', '[Over]');
            strqtext = strqtext.replace(/'/g, "''");
            return strqtext;
        }



        function btnSaveAndApplyFilter_Onclick() {
            var QueryText = "";
            QueryText = GenerateBasicFilterQuery('RSD', AllFields);
            if (QueryText == "") {
                //alertify.error("<%= MyBase.GetResourceString("A_SelOneFilter") %>");
                alertify.error("Please select at least on filter.");
            } else {
                $("#RDSsavefilter").modal('show');
                $(".canclesaveasbtn").click(function () {
                    $("#txtFilterName").val('');
                });
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

        //Function to save the filter and Apply the filter 
        function SaveFilterValidation() {
            var FilterName = $("#txtFilterName").val();
            FilterID = GlobalFilterID;
            if (FilterName != GlobalFilterName) {
                FilterID = 0;
            }

            FilterName = FilterName.replace(/'/g, "''");
            if (FilterName != "" && FilterName != null) {

                var filterExists = 0;
                if (savedFilterName == "") {
                    filterExists = checkDuplicateFilter(GlobalFilterFlag, GlobalFilterID, FilterName, 3861);
                }
                if (filterExists == 0) {
                    //Commnet and Added By Riddhesh Patil on 15-NOV-2022 
                    if (checkSpecialCharacter(FilterName, WebConfigSpecialCharacters) == true) {
                        $("#savefilterbtn").removeAttr("data-bs-dismiss");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtFilterName").focus();


                    }
                    //End of Comment Added By Riddhesh Patil
                    else {
                   SavedFilters(FilterName);
                    //$("#txtFilterName").val("");
                    $("#RDSsavefilter").modal('hide');
                }
            }
            else {
                alertify.error("<%= MyBase.GetResourceString("A_FilterNameBlank") %>");
                $("#txtFilterName").focus();
            }

        }


        //For Duplicated Filter
        function checkDuplicateFilter(Flag, FilterID, filtername, TagID) {
            var isFilterExists = 0;
            var Parameters = {
                Flag: encodeURI(Flag),
                FilterID: encodeURI(FilterID),
                FilterName: encodeURI(filtername),
                TagID: encodeURI(TagID),
                UserID: UserID,
            }
            var param = JSON.stringify(Parameters);
            var data = AJAXCallWithResult("/api/HR_ResourceSkillDetails/chkFilterExists", param, false);
            if (data == 0) {
                isFilterExists = 0;
            }
            else if (data == 1) {
                alertify.error("<%= MyBase.GetResourceString("A_FNameAlredyExist") %>");
                $("#txtFilterName").focus();
                isFilterExists = 1;
            }
            return isFilterExists;
        }

        //SaveAndApply Filter Functionality
        function SavedFilters(FilterName) {

            // var FilterName = $("#txtFilterName").val();

            if (FilterName != GlobalFilterName && FilterID == "0") {
                Flag = 0;
            }
            else {
                Flag = 1;
            }
            var QueryText = GenerateBasicFilterQuery('RSD', AllFields);

            if (QueryText != '') {
                Parameter = {
                    TagID: 3861,
                    UserID: encodeURI(UserID),
                    FilterName: encodeURI(FilterName),
                    LoginType: encodeURI(LoginType),
                    QueryText: encodeURI(QueryText),
                    UserName: encodeURI(UserName),
                    Flag: encodeURI(Flag),
                    FilterID: encodeURI(FilterID)

                }
                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/HR_ResourceSkillDetails/SavedFilters", param, false);

                if (strResult != null) {
                    GlobalFilterName = FilterName;
                    GlobalFilterID = strResult;
                    GlobalApplyID = strResult;
                    GlobalApplyID = "Apply" + GlobalApplyID
                    FilterID = strResult;
                    $('.filterpanelModule').removeClass('in');
                    ApplyCheckFilter(GlobalApplyID);
                    alertify.success("<%= MyBase.GetResourceString("A_FilterApplied") %>");
                    $(".clearalllink").css("display", "inline-block");
                    $("#filterpanel").removeClass("in");
                    $("#AdvanceFilterIcon").removeClass("activefilter");
                }
            }
        }

        // Getting QueryText From Perticular FilterID
        function ApplyCheckFilter(ApplyID) {

            if (GlobalApplyID == "") {

                GlobalApplyID = ApplyID;

            }
            else if (GlobalApplyID != ApplyID) {

                GlobalApplyID = ApplyID;

            }
            else {

                ApplyID = GlobalApplyID;
            }
            var FilterID = ApplyID.replace("Apply", "");

            if (FilterID != undefined) {
                Parameter = {
                    FilterID: encodeURI(FilterID),
                }
                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/HR_ResourceSkillDetails/GetWhereClauseFilter", param, false);

                var QueryText = strResult;
                if (QueryText != null) {
                    QueryText = QueryText.toString().replace(/'/g, "''");
                }
                GlobalQueryText = QueryText;
                GetSkillDetailList(QueryText)
                var sibling = $('label[id^="Apply"]')
                if ($("#" + ApplyID).parent().find("input").prop("checked") == true) {

                    $("#" + ApplyID).parent().find("input").prop("checked", true);
                    $("#" + ApplyID).removeAttr("data-original-title", "");
                    $("#" + ApplyID).attr("data-original-title", "Applied Filter");

                }
                else if ($("#" + ApplyID).parent().find("input").prop("checked") == false) {

                    $(sibling).each(function () {
                        var IsApplyFilter = 0;
                        var id = this.id;
                        if (ApplyID == this.id) {
                            IsApplyFilter = 1;
                            $("#" + id).parent().find("input").prop("checked", true);
                            $("#" + ApplyID).removeAttr("data-original-title", "");
                            $("#" + ApplyID).attr("data-original-title", "Applied Filter");
                        }

                        else if ("Default" + ApplyID == this.id) {
                            if (IsApplyFilter != 1) {
                                $("#" + id).parent().find("input").prop("checked", true);
                                $("#" + ApplyID).removeAttr("data-original-title", "");
                                $("#" + ApplyID).attr("data-original-title", "Applied Filter");
                            }
                        }
                        else {
                            $("#" + id).parent().find("input").prop("checked", false);
                            $("#" + ApplyID).removeAttr("data-original-title", "");
                            $("#" + ApplyID).attr("data-original-title", "Applied Filter");
                        }
                    });
                }
                $(".clearalllink").css("display", "inline-block");
                $(".filter button").css("background", "#1359a6");
                $(".fa-filter").css("color", "#FFFFFF");

            }
        }

        // List Of All Module Filters
        function AllResourceFilters() {

            Parameter = {
                TagID: 3861,
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID)
            }

            var param = JSON.stringify(Parameter);
            var strResult = AJAXCallWithResult("/api/HR_ResourceSkillDetails/AllResourceFilters", param, false);
            MyFiltersList(strResult);

        }


        // Plotting Filter In My Filter DropDown
        function MyFiltersList(result) {

            var strHTML = "";
            for (var i = 0; i < result.length; i++) {
                var FilterID = result[i]["FilterId"];
                var FilterName = result[i]["FilterName"];
                var QueryText = result[i]["QueryText"];
                if (result[i].SetDefault == true) { DefaultFilterID = FilterID; }
                strHTML += ' <li>'
                if (result[i].SetDefault == true) {
                    strHTML += '<label class="customradio">'
                    strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="Default' + FilterID + '" type="radio" name="project2" checked="checked" onclick="SetDefaultFilter(this.id,&quot;default&quot;)">'
                    strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Set Default Filter" class="checkmark"></span>'
                    strHTML += '</label>'
                    strHTML += '<label class="">'
                    strHTML += '<span for="project2" class="radiotextsty filtername">' + FilterName + '</span>'
                    strHTML += '</label>'
                    strHTML += '<div class="issfilter_actiondropdown">'
                    strHTML += '<div class="custom_chckbox_markblue">'
                    strHTML += '<input id="ModuleselproOne" checked="" type="checkbox" name="">'
                    strHTML += '<label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Apply filter" for="IssueselproOne" id="Apply' + FilterID + '" onclick="ApplyCheckFilter(this.id)" class="filterid"></label>'
                    strHTML += '</div>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Edit Filter" class="fas fa-pencil-alt" id="Edit' + FilterID + '" onclick="EditFilter(this.id)"></i></span>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Delete Filter" class="far fa-trash-alt" id="Default' + FilterID + '" onclick="DefaultDeleteFilter(this.id)"></i></span>'
                }
                else {
                    strHTML += '<label class="customradio">'
                    strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="Default' + FilterID + '" type="radio" name="project2" onclick="SetDefaultFilter(this.id)">'
                    strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Set Default Filter" class="checkmark"></span>'
                    strHTML += '</label>'
                    strHTML += '<label class="">'
                    strHTML += '<span for="project2" class="radiotextsty filtername">' + FilterName + '</span>'
                    strHTML += '</label>'
                    strHTML += '<div class="issfilter_actiondropdown">'
                    strHTML += '<div class="custom_chckbox_markblue">'
                    strHTML += '<input id="ModuleselproOne" type="checkbox" name="">'
                    strHTML += '<label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Apply Filter" for="IssueselproOne" id="Apply' + FilterID + '" onclick="ApplyCheckFilter(this.id)" class="filterid"></label>'
                    strHTML += '</div>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Edit Filter" class="fas fa-pencil-alt" id="Edit' + FilterID + '" onclick="EditFilter(this.id)"></i></span>'
                    strHTML += '<span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Delete Filter" class="far fa-trash-alt" id="' + FilterID + '" onclick="DefaultDeleteFilter(this.id)"></i></span>'
                }
                strHTML += '</div>'
                strHTML += '</li>'
            }
            $("#MyFiltersdropdown").html(strHTML);
            $('[data-bs-toggle="tooltip"]').tooltip();
            if (GlobalApplyID != null && GlobalApplyID != "") {
                ApplyCheckFilter(GlobalApplyID);
            }
            else {
                ClearFilterApplied();
            }

        }

        //To clear the applied filter arrow after click on clear filter button
        function ClearFilterApplied() {
            var sibling = $('label[id^="Apply"]');
            $(sibling).each(function () {
                var id = this.id;
                if ($("#" + id).parent().find("input").prop("checked") == true) {
                    $("#" + id).parent().find("input").prop("checked", false);
                    $("#" + id).removeAttr("data-original-title", "");
                    $("#" + id).attr("data-original-title", "Apply Filter");
                }
            });
        }

        //Get the default filter
        function GetDefaultFilter() {

            Parameter = {
                TagID: 3861,
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID)
            }

            var param = JSON.stringify(Parameter);
            var strResult = AJAXCallWithResult("/api/HR_ResourceSkillDetails/GetDefaultFilter", param, false);
            FilterID = strResult.FilterID;
            var QueryText = strResult.QueryText;
            if (QueryText != null) {
                GlobalApplyID = "Apply" + FilterID;
                QueryText = QueryText.toString().replace(/'/g, "''");
                GlobalQueryText = QueryText;
                $(".clearalllink").css("display", "inline-block");
                $(".filter button").css("background", "#1359ac");
                $(".fa-filter").css("color", "#ffffff");
                GlobalFilterID = FilterID;

            }
            else {
                $(".clearalllink").css({ "display": "none" });
                $(".filter").css("color", "transperent");
                $(".fa-filter").css("color", "#464a4c");
            }

            GetSkillDetailList(QueryText);
        }


        //Clear Applied Filter
        function ClearBasicFilter(IdCaption) {

            $("[id*=cbo" + IdCaption + "Filter]").each(function (obj) {
                var cbo = this.id;
                $("#" + cbo + " option:first").prop('selected', 'selected');
            });
            $("[id*=txt" + IdCaption + "Filter]").each(function (obj) {
                var txt = this.id;
                if ($("#" + txt)[0].nodeName == "INPUT" || $("#" + txt)[0].nodeName == "TEXTAREA") {
                    $("#" + txt).val('').change();
                }
                else {
                    $("#" + txt + " option:first").prop('selected', 'selected');
                }
            });

        }

        //SetDefault Filter         
        function SetDefaultFilter(DefaultFilterID, flag) {
            var removeDefault = 0;
            if (flag == "default") {
                removeDefault = 1;
            }
            var FilterID = DefaultFilterID.replace("Default", "");
            if (FilterID != undefined) {
                Parameter = {
                    LoginType: encodeURI(LoginType),
                    UserID: encodeURI(UserID),
                    TagID: 3861,
                    FilterID: encodeURI(FilterID),
                    Flag: removeDefault

                }
                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/HR_ResourceSkillDetails/SetDefaultFilter", param, false);
                if (removeDefault == 0) {
                    FilterID = "Apply" + FilterID;
                    ApplyCheckFilter(FilterID);
                    alertify.success("<%= MyBase.GetResourceString("A_SetdefaultFilter") %>");
                    $(".filterpanel ").removeClass('in');
                    $(".clearalllink").css("display", "inline-block");
                    $(".filter button").css("background", "#1359ac");
                    $(".fa-filter").css("color", "#ffffff");

                } else {
                    FilterID = "Apply" + FilterID;
                    ApplyCheckFilter(FilterID);
                    GlobalQueryText = null;
                    GetSkillDetailList(null);
                    alertify.success("<%= MyBase.GetResourceString("A_RemovedDefaultFilter") %>");
                    $(".filterpanel ").removeClass('in');
                    $(".clearalllink").css({ "display": "none" });
                    $(".filter button").css("background", "none");
                    $(".fa-filter").css("color", "#464a4c");
                }
            }
        }

        //Edit ModuleFilter 
        function EditFilter(EditID) {
            Flag = 1;
            FilterID = EditID.replace("Edit", "");
            if (FilterID != "") {
                GlobalFilterID = FilterID;
                GlobalFilterFlag = 1;

                var param = JSON.stringify(encodeURI(FilterID));
                var result = AJAXCallWithResult("/api/HR_ResourceSkillDetails/EditFilterData", param, false);
                for (var i = 0; i < result.length; i++) {
                    var QueryText = result[i].WhereClause;
                    GlobalFilterName = result[i].FilterName;
                }
                BindBasicFilters(QueryText, "RSD");
                $("#txtFilterName").val(GlobalFilterName);
                //Click on Edit SaveAndApply Section Will Be Display
                $(".filterpanel").addClass("in");
                $(".filterpanelbody").addClass("active");
                $('.nav-tabs li:last-child').addClass('active');
                $('#basicfilters').addClass('active');

            }
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
            $('#chk' + module + 'Filter' + field).prop('checked', val);
        }

        function ClearAll() {
            ClearBasicFilter('RSD')
            GetSkillDetailList(null);
            $(".clearalllink").hide();
            GlobalApplyID = "";
            GlobalQueryText = "";
            savedFilterName = "";
            GlobalFilterID = "";
            GlobalFilterName = "";
            FilterID = "";
            $(".clearalllink").css({ "display": "none" });
            //$(".filter button").css("color", "transperent");
            $(".filter button").css("background", "");
            $(".fa-filter").css("color", "#464a4c");
        }


        //Delete Filter 
        function DefaultDeleteFilter(DefaultID) {
            GlobalQueryText = null;
            if (DefaultID.indexOf("Default") > -1) {
                var FilterID = DefaultID.replace("Default", "");
                DeleteFilter(FilterID);
                BindStageList(null);
                $('.filterpanelModule').removeClass('in');
            }
            else {
                DeleteFilter(DefaultID);
                GetDefaultFilter();
            }
        }


        function DeleteFilter(FilterID) {
            if (FilterID != undefined) {
                Parameter = {
                    FilterID: encodeURI(FilterID),
                }

                var param = JSON.stringify(Parameter);
                var strResult = AJAXCallWithResult("/api/HR_ResourceSkillDetails/DeleteFilter", param, false);

                alertify.success("<%= MyBase.GetResourceString("A_FilterDelete") %>");
                ClearBasicFilter("RSD");
                AllStageFilters();

            }
            $(".filter button").css("background", "none");
            $(".fa-filter").css("color", "#464a4c");
        }


        //Filter Part END Here


    </script>
</body>

</html>
