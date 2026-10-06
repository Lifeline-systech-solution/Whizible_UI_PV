<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_AddNewResource.aspx.vb" Inherits="PbNIT.PM_AddNewResource" %>

<!DOCTYPE html>
<html>
        <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Resource")%> 
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
   
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">--%>
    <!-- bootstrap select -->
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css?v=2">--%>
<%--    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/BS5_migration.css?v=0.1">
    <!-- animate css -->
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/daterangepicker.min.css">

    <!--advanced filter css-->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=3.1">
    <link href="../../../Whizible2.0-new/dist/css/bootstrap-multiselect.css" rel="stylesheet">

    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.2">
<%--    <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
    <link href="../../../Whizible2.0-new/plugins/select2/select2.css?v=3" rel="stylesheet" />
   
</head>
 <style type="text/css">
        .JStableOuter > table {
            overflow: initial; min-height:65vh;
        }

        .SRtopfilter ul.tab-slider--tabs {
            background: #f5f5f5;
            color: #464a4c;
        }

            .SRtopfilter ul.tab-slider--tabs li {
                color: #464a4c;
            }

        .SRtopfilter .tab-slider--tabs:after, .SRtopfilter .tab-slider--trigger.active {
            color: #fff;
        }

        .SRtopfilter .tab-slider--tabs {
            margin-top: 5px;
            height: 28px;
        }

        .SRtopfilter .tab-slider--trigger {
            padding: 8px 20px 8px 15px;
        }

        .PRweekdaytbl td span {
            display: block;
        }

        .multiselect-container {
            max-width: 260px;
        }

        .multiselect-filter .input-group .form-control {
            height: 32px;
        }

        .multiselect-filter .input-group .multiselect-clear-filter {
            padding: 6px 12px;
        }


        .projectallocationpanel .custom_chckbox label:before {
            margin-right: 0;
        }
        /*Added By Usha Pandit On 12.06.2020 For setting width for resource selection checkbox alignment*/
        .JStableOuter > table > tbody > tr > td:nth-child(1) {
            width: 25% !important
        }
        /*End Of Added By Usha Pandit On 12.06.2020 For setting width for resource selection checkbox alignment*/
        .JStableOuter > table > tbody > tr > td:nth-child(2) {
            position: relative;
            z-index: 1;
            /* display: block; */
            height: 40px;
            background-color: #fff;
            text-align: left;
            min-width: 240px;
            border-left-width: 0px;
            border-left: hidden;
            box-shadow: 0px 1px 0px 1px #ddd;
        }
        /*Modified by pradip on 09-01-2020*/

        .datelabel {
            margin: 8px 0 0;
            display: block;
        }

        .datelabelNew {
            margin: 8px 0 0;
            display: block;
            font-size: 15px;
        }

        .filter.float-end.resourcefltr {
            margin-top: 6px;
        }

        .PRrolename .UpDowncollapseArrow {
            margin-right: 0;
            opacity: 0.7;
        }

            .PRrolename .UpDowncollapseArrow:hover {
                opacity: 1;
            }

        /*#CRTable > tr:first-child > td {
            background: #e7edf0;
        }*/ /*Added by pradip on 08-01-2020*/

        .JStableOuter > table > thead > tr th {
            background: #e7edf0;
            height: 56px;width: 100vw;
        }
            /*Added by pradip on 08-01-2020*/
            .JStableOuter > table > thead > tr th:nth-child(2n) {
                z-index: 99; min-width:240px; width:240px; 
            }

        .JStableOuter > table > thead > tr > th:nth-child(1) {
            min-width: 30px; width:30px;
        }

        .monthheading {
            padding: 10px 40px;
        }

        .PRweekdaytbl td::after {
            display: none;
        }

        .PRsubinfotbl td {
            border: 1px solid #fff;
        }

        .weeklyanddaily {
            margin: 5px 0 0;
            line-height: 28px;
        }

        /*div#resourcerequest .modal-dialog {width: 60%;}*/
        .PRdailviewtable table tr td {
            font-size: 12px;
            min-width: auto;
            width: 10px;
        }

        .exprience select.form-select {
           padding: 6px 4px;display: inline-block;background-position: right 0.15rem center;width: 45px!important;
        }

        #Rskillsettab table.table.table-stripped {
            border: 1px solid #eee;
        }


        /*Css Added by pradip on 21-10-2019*/
        .JStableOuter > table > tbody > tr > td {
            min-width: auto;
            padding: 6px;
            font-size: 12px;
            background-color: none;
            min-width: 31px;
        }

            .JStableOuter > table > tbody > tr > td:first-child:nth-last-child(2) {
                min-width: auto;
                padding: 0 !important;
            }


        #CRTable .bootstrap-select > .dropdown-toggle {
            font-size: 13px;
        }

        .alertify-notifier {
            z-index: 99999 !important;
        }

        .modal {
            z-index: 9999 !important;
        }

        /*Added By Reshma on 7th Jan 2020*/
        .Green {
            color: green;
            /*background:green!important;*/
        }

        .red {
            color: red;
            /*background:red!important;*/
        }
        /*End Added By Reshma on 7th Jan 2020*/
        #Rrequesttab .form-inline .form-control {
            width: 200px !important;
        }

        #bulkallocation .select2-container {
            width: 330px !important;
        }

        #bulkallocation .select2-selection__choice {
            color: black !important;
        }

        /*.disabled {*/
        /*pointer-events: none;*/
        /*opacity: 0.6;
        }*/
        /*li.disabled a {pointer-events: none;}*/

        body {
            background: #ffffff;
        }

        .custmodal .custom_chckbox label:before {
            border-color: #464a4c;
        }

        /*style added by pradip on 07-1-2020*/
        .select2-container--default .select2-selection--multiple .select2-selection__choice {
            background: #e7edf0;
            color: #464a4c;
            font-size: 12px;
            margin-top: 7px;
        }

        .select2-container--default .select2-selection--multiple {
            border-radius: 4px !important;
        }

            .select2-container--default .select2-selection--multiple:focus {
                border-color: #ddd;
            }

        /*style added by pradip on 09-01-2020*/
        #CRTable tr.theadrow {
            display: none !important;
        }

        .projectallocationpanel .JStableOuter > table > tbody > tr > td:first-child {
            border-left-width: 0px;
            border-left: hidden;
            box-shadow: 0px 1px 0px 1px #ddd;
        }

        .projectallocationpanel .JStableOuter {
            border-left: 1px solid #ddd;
        }

        li.disabled {
            position: relative;
        }

            li.disabled a::after {
                position: absolute;
                content: "";
                width: 80px;
                height: 20px;
                font-size: 14px;
                /* font-family: FontAwesome; */
                font-family: FontAwesome;
                /* z-index: 999999999999; */
                background: url(../../../Whizible2.0-new/dist/img/ban-solid.svg) 0 0 no-repeat;
                background-size: 0px;
            }

            li.disabled:hover a::after {
                background-size: 14px;
            }
        .monthheading .nextMonth { top:10px; }
        tr.PRHide.collapse.in{ display:table-row!important;}/*Addeed by pradip on 14-01-2020*/

          /*Added By Reshma Chavan on 8th Oct 2020 For pagination CHnage*/
#Pagination button {
   
    border-color: #1359a6;
    border: 1px solid;

}

 #Pagination button:hover {
  background-color:#1359a6 ;
  color: white;
   border: 1px solid #1359a6;
}

.previous {
  background-color: #e9e9e9;
  color: #1359a6;
   border: 1px solid lightgrey;
}

.next {
  background-color: #e9e9e9;
  color: #1359a6;
   border:1px solid lightgrey;
        }
        .divtotal {
           
            margin-right: -14px;
            margin-top: 7px;
        }
        .spntotal {
            float:right;
        }
         .fa-disabled {
            opacity: 0.6;
            cursor: not-allowed;
            /*pointer-events: none;*/
        }
          .clsPaginationEnableDisable {
            pointer-events: none !important;
        }
    /*End of Added By Reshma Chavan on 8th Oct 2020 For pagination CHnage*/
    /*Added By Dipali V On 24th Feb 2021 For Note*/
        #ClsNote {
            color:red!important;
            font-size:12px!important;
        }
        #ClsNoteText {
            font-size:12px!important;
        }
     /*End of Added By Dipali V On 24th Feb 2021 For Note*/

.collapse.show{ display:table-row;}
.form-select:focus {
    border-color: #999999;
    outline: 0;
    box-shadow: none;
}
.form-group .input-group{ flex-wrap:unset;}
.custmodal .modal-content .modal-body {padding: 30px;}
.nav-tabs.popupboxtabs > li > a.active {
    background: #4263c1 !important;
    color: #fff !important;
    border: 1px solid #4263c1!important;
}
.nav-tabs.popupboxtabs > li > a {
    background: #fff !important;
    color: #444 !important;
    cursor:pointer!important;
    border-bottom:1px solid #ddd!important;
}
.nav-tabs.popupboxtabs > li > a {
    position: relative;
    display: block;
    padding: 10px 15px;
}
/*.nav-tabs.popupboxtabs > li.active > a {
    background: #4263c1 !important;
    color: #fff !important;
    border: 1px solid #4263c1!important;
}*/


    </style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="AddNewResource">


    <!-- Content Header (Page header) -->
    <div class="graybg container-fluid pt-1 pb-1 resourcepanelheader">
        <div class="row">
            <div class="col-sm-3">
                <% CommonFunctions.HTMLControls.DrawComboBox("cboProjects", "Select ''",,, "class='form-select' onChange='ChangeProject(this)' disabled",, ,, ) %>
            </div>
            <div class="col-sm-5 text-center d-flex d-flex text-start">
                <p class="col-sm-3 datelabelNew"><%= MyBase.GetResourceString("C_ProjectDuration") %> :- </p>
                <p class="datelabel" style="text-align: left;"></p>
            </div>
            <div class="col-sm-4">
               <%-- Added By Dipali V On 24th Feb 2021 For Note--%>
                <span id="ClsNote">Note :- </span><span id="ClsNoteText"> Availability % Is Calculated As Per Selected Month (Approximate Value).</span>
                <%--End of  Added By Dipali V On 24th Feb 2021 For Note--%>
                </div>
        </div>
    </div>
    <%--<div class="graybg container-fluid pt-1 pb-1 resourcepanelheader">
        <div class="row">
            <div class="col-sm-3">
                <label>A</label>
                <select class="form-control" id=""></select>
            </div>
            <div class="col-sm-3">
                <label>A</label>
                <select class="form-control" id=""></select>
            </div>
            <div class="col-sm-3">
                <label>A</label>
                <select class="form-control" id=""></select>
            </div>
            <div class="col-sm-3">
                <label>A</label>
                <select class="form-control" id=""></select>
            </div>
            <div class="col-sm-3">
                <label>A</label>
                <select class="form-control" id=""></select>
            </div>
            <div class="col-sm-3">
                <label>A</label>
                <select class="form-control" id=""></select>
            </div>
            <div class="col-sm-6" style="padding-top:12px;">
                <button type="button" class="btn btn-primary" style="float:right;">Apply Filter</button>
            </div>
        </div>
    </div>--%>
    <!--filter_panel_section_satrts_here-->
    <div id="filterpanel" class="collapse filterpanel" style="border-bottom: 12px solid #eee;">
        <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
            <div class="row">
                <div class="col-md-7 col-sm-7">
                    <div class="cust_tabpanel">
                        <ul class="nav nav-tabs">
                            <li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown" onclick="GetResourceFilters()" id="ResourceFilterlist">My Filters  <span class="caret"></span></a>
                                <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                </ul>
                            </li>
                            <li><a href="#presetfilter" data-bs-toggle="tab">Basic Filters</a>
                            </li>
                            <!-- <li><a href="#queryfilter" data-bs-toggle="tab">Advanced Filters</a></li> -->
                        </ul>
                    </div>
                </div>
                <div class="col-md-5 col-sm-5">
                    <div class="form-inline float-end">
                        <button class="btn borderbtn mrOnehalf clearfilterbtn" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete">Clear All Filters</button>
                    </div>
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
                                <button class="btn btnyellow" id="svfilterbtn" onclick="btnResourceSaveAndApplyFilter_Onclick()">Save and Apply</button>
                                <button class="btn btnyellow" onclick="btnResourceApplyFilter_Onclick()">Apply</button>
                            </div>
                            <div class="row hidden-xs IB_filterlist">
                                <!--basic filter start here-->
                                <div class="form-inline">
                                    <div class="box box-solid p1" style="border-bottom: none; box-shadow: none;">
                                        <div class="form-group ">
                                            <label for="email">Skills : </label>

                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceFilterSkillID", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select '",,,) %>


                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtResourceFilterSkillID", "usp_Whizible2_Sel_tbl_PM_Tools",,, "data-live-search='true'  multiple='multiple' class='form-select '",,,) %>
                                            <%--   <select id="rskillfilter" class="form-control" multiple="multiple" data-live-search="true">
                                                        <option value="UX Designer">UX Designer</option>
                                                        <option value="Dot net developer">Dot net developer</option>
                                                        <option value="java developer">java developer</option>
                                                        <option value="Website designer">Website designer</option>
                                                        <option value="Content writer">Content writer</option>
                                                        <option value="Python developer">Python developer</option>
                                                    </select>--%>
                                        </div>
                                        <div class="form-group ">
                                            <label for="email">Organization Unit : </label>


                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceFilterOrganizationUnit", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select '",,,) %>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtResourceFilterOrganizationUnit", "usp_Whizible2_Sel_tbl_PM_location",,, "class='form-select '",,,) %>
                                        </div>
                                        <div class="form-group ">
                                            <label for="email">Business Group : </label>

                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceFilterBussinessGroup", "usp_Whizible2_Sel_Filter_FillOperatorCombo 'COMBO'",,, "class='form-select '",,,) %>
                                            <% CommonFunctions.HTMLControls.DrawComboBox("txtResourceFilterBussinessGroup", "usp_Whizible2_Sel_tbl_CNF_BusinessGroups",,, "class='form-select '",,,) %>
                                        </div>
                                    </div>
                                </div>
                                <!--basic filter end here-->
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
                    <hr>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
    <!--filter panel-end-here-->



    <!-- Main content -->
    <section class="content pt-0">
        <div class="row">
            <div class="container-fluid SRtopfilter row">
                <div class="col-md-6 col-sm-6 col-xs-12">
                    <ul class="statustext hidden-xs" id="RoleCounts">
                        <li data-bs-toggle="tooltip" data-bs-placement="top" title="" class="criticle active" data-original-title="All" id="Role1"></li>
                        <li data-bs-toggle="tooltip" data-bs-placement="top" title="" class="criticle" data-original-title="Designer" id="Role2"></li>
                        <li data-bs-toggle="tooltip" data-bs-placement="top" title="" class="overdue" data-original-title="Developer" id="Role3"></li>
                        <li data-bs-toggle="tooltip" data-bs-placement="top" title="" class="pending" data-original-title="Tester" id="Role4"></li>
                    </ul>
                </div>
                <div class="col-sm-3">
                    <div class="weeklyanddaily availNDallocate">
                        <div class="tab-slider--nav float-end">
                            <ul class="tab-slider--tabs">
                                <li class="tab-slider--trigger active" rel="wbsavailbility" data-bs-toggle="tooltip" data-bs-placement="top" title="" data-original-title="Availability" onclick="changeView(1)"><span>Availability</span>
                                    <!--modified by pradip on 08-01-2020-->
                                </li>
                                <li data-bs-toggle="tooltip" data-bs-placement="top" title="" class="tab-slider--trigger" rel="wbsallocate" data-original-title="Allocated" onclick="changeView(0)">Allocated</li>
                            </ul>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-3 col-xs-12 text-end pt-1">
                    <%--Commented And Added By Reshma on 8th Jan 2020 For IssueID-21200--%>
                    <%--<a href="PM_Resources.aspx" class="btn borderbtn">Back</a>--%>
                    <a class="btn borderbtn" onclick="BackResources_Onclick()">Back</a>
                    <%--End Added By Reshma on 8th Jan 2020 For IssueID-21200--%>

                    <%-- Added by Dipali V On 27th Dec 2019 For Conditional Button Plotting--%>
                    <button id="btnAllocateResource" style="display: none;" onclick="PlotAllocateResources()" data-bs-toggle="modal" class="btn borderbtnfill"><%= MyBase.GetResourceString("C_AllocateResource") %></button>
                    <button id="btnResourceRequest" style="display: none;" onclick="PlotRequestResources()" class="btn borderbtnfill" data-bs-toggle="modal"><%= MyBase.GetResourceString("C_ResourceReq") %></button>
                    <%--  %--<a id="btnResourceRequest" style="display: none;" href="javascript:;" data-bs-toggle="modal" data-bs-target="#resourcerequest" class="btn btn-white float-end"></a>--%>
                    <%--End of Added by Dipali V On 27th Dec 2019 For Conditional Button Plotting--%>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
        <div class="clearfix"></div>
        <div class="bhwhite">
            <div class="projectallocationpanel">

                <div class="JStableOuter">
                    <table id="table" class="PRdailviewtable">
                        <thead>
                        </thead>
                        <tbody id="CRTable">
                        </tbody>
                    </table>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>

         <%-- //Added By Reshma chavan on 8th Oct 2020 for JDUpgrade Pagination Change--%>

         <div class=row style="margin-top:5px">
                
               <%--Commented By Reshma Chavan on 22nd Oct 2020 For Remove Total Records--%> 
              <div class='buttons col-sm-11'style="width: 85%;margin-top: 24px;">
                   <%--<span class="spntotal" id="TotalRecords"></span>
                   <span id="" class="spntotal"> Total Records : </span>--%>

               </div>
              <%--End of Commented By Reshma Chavan on 22nd Oct 2020 For Remove Total Records--%> 
                <div class='buttons col-sm-1' style="width:15%" id="Pagination" >
               

                    <nav aria-label="Page navigation example">
                      <ul class="pagination justify-content-end">
                         <li class="page-item"  id="btnprevious">
                          <a class="page-link" aria-label="Previous" onclick='PrevList()' data-bs-toggle="tooltip" title="Previous" id="LinkPrevious">
                            
                           <i class="fas fa-angle-double-left"></i>
                          </a>
                        </li>
                         <li class="page-item" id="btnnext">
                          <a class="page-link" aria-label="Next" onclick='NextList()' data-bs-toggle="tooltip" title="Next" id="LinkNext">
                            
                           <i class="fas fa-angle-double-right"></i>
                          </a>
                        </li>
                      </ul>
                    </nav>

            </div>
            </div>.
        <%--End of  //Added By Reshma Chavan on 8th Oct 2020 For JDUpgrade Pagination Change--%>
    </section>
   
    <div class="modal custmodal fade" id="bulkallocation" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <%-- Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>
                    <%--  <h5 class="modal-title" id="">Allocation details</h5>--%>
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("CAllocationdetails") %></h5>
                    <%--End of  Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-4 text-end">Resources <span style="color: red">*</span></label>
                            <div class="col-sm-8" id="DivResourcelist">
                                <select id="RAtaglist" class="form-select" multiple onchange="FillResourceArray()">
                                </select>
                                <input type="hidden" id="RAtaglisthidden" />

                                <!-- <br/><span class="notification-alert">Sam is 100% allocated from 12 June to 14 June</span> -->
                            </div>
                        </div>
                        <div class="form-group">
                            <%-- Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>
                            <%--<label class="col-sm-4 text-end">Project (pre-populated)</label>--%>
                            <label class="col-sm-4 text-end"><%= MyBase.GetResourceString("C_Project") %> <span style="color: red">*</span></label>
                            <%-- End of Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>
                            <div class="col-sm-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectAdd", "Select ''",,, "class='form-select' onChange='ChangeProject(this)' disabled",,, ,,) %>
                            </div>
                        </div>
                        <div class="form-group">
                            <%-- Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>
                            <%-- <label class="col-sm-4 text-end">Project Role</label>--%>
                            <label class="col-sm-4 text-end"><%= MyBase.GetResourceString("C_ProjecRole") %> <span style="color: red">*</span></label>
                            <%-- End of Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>
                            <div class="col-sm-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectRoleAdd", "usp_Whizible2_Sel_tbl_PM_Role_PopulateCombo",,, "class='form-select'",,, ) %>
                            </div>
                        </div>
                        <div class="form-group">
                            <%-- Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>

                            <%-- <label class="col-sm-4 text-end">Plan Start Date</label>--%>
                            <label class="col-sm-4 text-end"><%= MyBase.GetResourceString("C_pStartDate") %> <span style="color: red">*</span></label>
                            <%-- En of Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>

                            <div class="col-sm-8">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="PlanStartDate" readonly="readonly" style="background-color: white" onchange="GetResourceAllocation()">
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <%-- <label class="col-sm-4 text-end">Plan End Date</label>--%>
                            <%-- Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>

                            <%-- <label class="col-sm-4 text-end">Plan Start Date</label>--%>
                            <label class="col-sm-4 text-end"><%= MyBase.GetResourceString("C_pEtartDate") %> <span style="color: red">*</span></label>
                            <%-- En of Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>
                            <div class="col-sm-8">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="PlanEndDate" readonly="readonly" style="background-color: white" onchange="GetResourceAllocation()">
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>

                            </div>
                        </div>
                        <div class="form-group">
                            <%-- <label class="col-sm-4 text-end">% Allocation</label>--%>

                            <label class="col-sm-4 text-end"><%= MyBase.GetResourceString("C_Allocation") %>  <span style="color: red">*</span></label>
                            <%-- En of Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>
                            <div class="col-sm-8">
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtResourcePercentage", "txtResourcePercentage", "form-control", 200, 3,,,,,,,, "onkeypress='return restrictAlphabets(event)'autocomplete='off'") %>
                            </div>
                        </div>
                        <div class="form-group">


                            <%--  <label class="col-sm-4 text-end">Reporting to</label>--%>
                            <label class="col-sm-4 text-end"><%= MyBase.GetResourceString("C_ReportingTo") %> <span style="color: red">*</span></label>
                            <%-- End of Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>
                            <div class="col-sm-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboReportingToAdd", "Select ''",,, "class='form-select'", False,,, ,,) %>
                                <%-- Added by Chetan M on 10th Jan 2020 --%>   
                                <br/> <strong>'Reporting To' is not mandatory for the first resource. </strong>
                                <%-- End of added by Chetan M on 10th Jan 2020 --%>
                            </div>
                        </div>
                        <div class="form-group">
                            <%--  <label class="col-sm-4 text-end">Resource Status</label>--%>
                            <%--  <label class="col-sm-4 text-end">Reporting to</label>--%>
                            <label class="col-sm-4 text-end"><%= MyBase.GetResourceString("C_ResourceStatus") %>  <span style="color: red">*</span></label>
                            <%-- End of Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>
                            <div class="col-sm-8">
                                <%--Commented And Added By Reshma For Placeholder--%>
                                <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboResourceStatusAdd", "usp_Sel_tbl_PM_ProjectGroupResources_WhyNonBillable",,, "class='form-control'",,, ) %>--%>
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceStatusAdd", "usp_Whizible2_Sel_tbl_PM_ProjectGroupResources_WhyNonBillable",,, "class='form-select'",,, ) %>
                                <%--End Commented And Added By Reshma For Placeholder--%>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 text-end"><%= MyBase.GetResourceString("C_Work") %> <span style="color: red">*</span></label>
                            <%-- End of Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>
                            <div class="col-sm-8">
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtALWorkHrs", "txtALWorkHrs", "form-control",,,,,,,,,, "autocomplete='Off' maxlength='6'",,, True,,,, True) %>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-4">&nbsp;</label>
                            <div class="col-sm-8">
                                <div class="custom_chckbox" id="divIsDefaultApprover">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkIsDefaultApprover", "chkIsDefaultApprover",,,,, "onclick=Approver_onchange(this)") %>
                                    <label for="chkIsDefaultApprover"><%= MyBase.GetResourceString("C_IsDefaultApprover") %></label>
                                </div>
                                <div class="custom_chckbox" id="divIsResourceBillable">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkIsResourceBillable", "chkIsResourceBillable") %>
                                    <label for="chkIsResourceBillable"><%= MyBase.GetResourceString("C_Billable") %></label>
                                </div>
                                <div class="custom_chckbox" id="divIsProductOwner">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkIsProductOwner", "chkIsProductOwner") %>
                                    <label for="chkIsProductOwner"><%= MyBase.GetResourceString("C_IsProductOwner") %></label>
                                </div>
                            </div>

                        </div>



                        <div class="form-group">

                            <%-- <label class="col-sm-4 text-end">Responsibility</label>--%>
                            <label class="col-sm-4 text-end">Responsibilities</label>
                            <%-- End of Commented & Added by Dipali V On 27th Dec 2019 Resource File--%>
                            <div class="col-sm-8">
                                <textarea class="form-control" id="txtResponsibility" maxlength="1000" placeholder='Enter Responsibilities (Maxlength 1000 Char)'></textarea>
                            </div>
                        </div>
                        <br>
                        <div class="form-group">&nbsp;</div>
                        <div class="form-group text-center">
                            <button class="btn btnyellow" onclick="Allocate_OnClick()">Allocate</button>
                            <button class="btn borderbtn ml-1" onclick="cancelallocation()">Cancel</button>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!--modal-end-here-->
    <!--modal_start_here-->
    <div class="modal custmodal  fade" id="resourcerequest" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Resource Request</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <ul class="nav nav-tabs popupboxtabs">
                        <li class="" id="idReqDetails"><a class="active" href="#Rrequesttab" data-bs-toggle="tab">Request Details</a></li>
                        <%-- class="disabled"--%>
                        <li class="" id="idSkill"><a class="" href="#Rskillsettab" data-bs-toggle="tab">Skill Set </a></li>

                    </ul>
                    <div class="tab-content ">
                        <div class="tab-pane active" id="Rrequesttab">
                            <div class="row">
                                <div class="form-group row mb-3">
                                     <%-- Commented and added by Chetan M on 14th Jan 2020 for issue id 21225 --%>
                                    <%--<label class="col-sm-4">Project Role </label>--%>
                                    <label class="col-sm-4 required">Project Role </label>
                                    <%-- End of Commented and added by Chetan M on 14th Jan 2020 for issue id 21225 --%>
                                    <div class="col-sm-8">
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectRoleAdd", "usp_Whizible2_Sel_tbl_PM_Role_PopulateCombo",,, "class='form-select'",,, ) %>
                                    </div>
                                </div>
                                <div class="form-group row mb-3">
                                            <%--Commented And Added By Reshma Chavan on 7th March 2022 to change caption--%>
                                            <%--<label class="col-sm-4">No. Of Resources <span style="color: red">*</span></label>--%>
                                            <label class="col-sm-4"> No.of Resources<span style="color: red">*</span></label>
                                            <%--End of Commented And Added By Reshma Chavan on 7th March 2022 to change caption--%>
                                    <div class="col-sm-8 form-inline">
                                        <div class="form-group">
                                            <%--  <input type="text" class="form-control" value="06">--%>
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtnoofresource", "txtnoofresource", "form-control", 200, 3,,,,,,,, "onkeypress='return isNumberKey(event)' autocomplete='off'") %>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group row mb-3">
                                    <label class="col-sm-4">From Date  <span style="color: red">*</span></label>
                                    <div class="col-sm-8">
                                        <div class="input-group col-sm-12">
                                            <div class="input-group" id="DateDemo">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("RRstartdt", "RRstartdt", "form-control", 289, 3,,,,,,,, "autocomplete='off'") %>
                                                <%-- <input data-bs-toggle="tooltip" data-bs-placement="top" title="Select Start Date" class="form-control" type="text" id="RRstartdt" value="" />--%>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row mb-3">
                                    <label class="col-sm-4">To Date  <span style="color: red">*</span></label>
                                    <div class="col-sm-8">
                                        <div class="input-group  col-sm-12">
                                            <div class="input-group" id="DateDemo">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("RRenddt", "RRenddt", "form-control", 289, 3,,,,,,,, "autocomplete='off'") %>
                                                <%-- <input data-bs-toggle="tooltip" data-bs-placement="top" title="Select End date" class="form-control" type="text" id="RRenddt" value="" />--%>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row mb-3">
                                    <label class="col-sm-4">Allocation Unit <span style="color: red">*</span></label>
                                    <div class="col-sm-8 form-inline">
                                        <div class="form-group">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cbotype", "usp_Whizible2_Sel_RequestedType_tbl_PM_ResourceRequest",,, "class='form-select'",,, ) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row mb-3">
                                     <%--Commented And Added By Reshma Chavan on 7th March 2022 to change caption--%>
                                            <%--<label class="col-sm-4">Work Hours <span style="color: red">*</span></label>--%>
                                            <label class="col-sm-4">Work hours per resource<span style="color: red">*</span></label>
                                            <%--Commented And Added By Reshma Chavan on 7th March 2022 to change caption--%>
                                    <div class="col-sm-8 form-inline">
                                        <div class="form-group">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtRWorkHours", "txtRWorkHours", "form-control",,,,, "",,,,, "autocomplete='off' maxlength='6'",,, True,,,, True) %>
                                        </div>
                                        <%-- Allocation Unit <span style="color: red">*</span>--%>
                                        <%--  <div class="form-group">
                                                        <% CommonFunctions.HTMLControls.DrawComboBox("cbotype", "usp_Whizible2_Sel_RequestedType_tbl_PM_ResourceRequest",,, "class='form-control selectpicker'",,, ) %>
                                                   <%-- <select class="form-control selectpicker" id="cbotype">
                                                        <option value="HPD">Per Day </option>
                                                        <option value="TH">Total Hours</option>
                                                        <option value="P">% Of Day </option>
                                                        
                                                    </select>--%>

                                        <%--   </div>--%>
                                    </div>
                                </div>

                                <div class="form-group row mb-3">
                                    <label class="col-sm-4">Priority</label>
                                    <div class="col-sm-8 form-inline">
                                        <div class="form-group">

                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRPriority", "usp_Whizible2_Sel_tbl_HR_Parameters 2",,, "class='form-select'",,, ) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row mb-3">
                                    <%--Commented & Added By Rutuja D. 9 Jan 2020 For Adding New Id--%>
                                    <%--<label class="col-sm-4">Resource Pool </label>--%>
                                    <label class="col-sm-4" id="lblResourcePool">Resource Pool </label>

                                    <%--End of Commented & Added By Rutuja D. 9 Jan 2020 For Adding New Id--%>
                                    <div class="col-sm-8 form-inline">
                                        <div class="form-group">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboResourcePools", "usp_Whizible2_Sel_tbl_PM_ResourcePoolMaster_ForCombo",,, "class='form-select'",,, ) %>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group row mb-3">
                                    <label class="col-sm-4">Special Request</label>
                                    <div class="col-sm-8">
                                        <textarea id="txtSpecialRequest" class="form-control" maxlength="300" placeholder='Enter Special Request (Maxlength 300 Char)' autocomplete="off"></textarea>

                                    </div>
                                </div>

                                <div class="form-group row mb-3">&nbsp;</div>
                                <div class="form-group mb-3 text-center">
                                    <%-- <button class="btn btnyellow"  onclick="Request_onClick()">Request</button>--%>
                                    <button class="btn btnyellow" onclick="Request_onClick(0)">Next</button>
                                    <button class="btn borderbtn ml-1" onclick="cancelRequest()" data-bs-dismiss="modal">Cancel</button>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="Rskillsettab">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th width="30%">Skills</th>
                                        <th width="30%">Experience</th>
                                        <th width="30%">Proficiency</th>
                                        <th>&nbsp;</th>
                                    </tr>
                                </thead>
                                <tbody id="tbodySkill">
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="4">
                                            <button id="addskillsetrow" class="btn borderbtn">Add Skill Set</button>
                                          
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                            <div class="row">

                                <div class="form-group">&nbsp;</div>
                                <div class="form-group text-center">
                                    <button class="btn btnyellow" onclick="Back_onClick()">Back</button>
                                    <button class="btn btnyellow" onclick="Skill_onClick(1)" id="btnCreateReq">Create Request</button>
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal" onclick="cancelRequest()">Cancel</button>
                                </div>
                            </div>
                        </div>


                    </div>
                    <!-- /.content -->
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
    </div>
    <!--modal_end_here-->


    <!-- REQUIRED JS SCRIPTS -->
    
    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
  
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
    <!-- jqueryUI js -->
<%--    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
<%--    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    
    <!--daterangepicker-->
    <!-- Commented and Added by Vishal Mane on 30/12/2025 for version upgrade of moment.js for W26 --> 
    <!-- <script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script> -->
    <script src="../../../Whizible2.0-new/dist/js/moment-2.30.1.js"></script>
    <!-- End of Commented and Added by Vishal Mane on 30/12/2025 for version upgrade of moment.js for W26 -->
<%--    <script src="../../../Whizible2.0-new/dist/js/jquery.daterangepicker.min.js"></script>--%>
    <%--    <script src="../../../Whizible2.0-new/dist/js/bootstrap-multiselect.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/multiselect.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/bootstrap-multiselect.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js?v=1.4"></script>--%>
    <script src="../../General/CommonValidations.js"></script>
    <!--Added for FILTER-->
    <script src="../../../Whizible2.0-new/dist/js/common_filters.js"></script>


    <!-- Bootstrap taglist -->
    <script src="../../../Whizible2.0-new/dist/js/bootstrap3-typeahead.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/bootstrap-tagsinput.js"></script>

<%--    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/plugins/select2/select2.js"></script>
    <script>

        //Script use for hide tooltip when click -  added by pradip
        $('body').tooltip({
            selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
            trigger: 'hover',
            container: 'body'
        }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
            $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
        });




        //start script for display dropdown hide behind div
        (function () {
            // hold onto the drop down menu                                             
            var dropdownMenu;

            // and when you show it, move it to the body                                     
            $(window).on('show.bs.dropdown', function (e) {

                // grab the menu        
                dropdownMenu = $(e.target).find('.multiselect-container.dropdown-menu');

                // detach it and append it to the body
                $('body').append(dropdownMenu.detach());

                // grab the new offset position
                var eOffset = $(e.target).offset();

                // make sure to place it where it would normally go (this could be improved)
                dropdownMenu.css({
                    'display': 'block',
                    'top': eOffset.top + $(e.target).outerHeight(),
                    'left': eOffset.left
                });
            });

            // and when you hide it, reattach the drop down, and hide it normally                                                   
            $(window).on('hide.bs.dropdown', function (e) {
                $(e.target).append(dropdownMenu.detach());
                dropdownMenu.hide();
            });
        })();
        //End script for display dropdown hide behind div


        $(document).on('click.bs.dropdown.data-api', '.dropdown.keep-inside-clicks-open', function (e) {
            e.stopPropagation();
        });



        $('[data-bs-toggle="tooltip"]').tooltip();






        //freez table
        $('.JStableOuter > table').scroll(function (e) {

            $('.JStableOuter > table > thead').css("left", -$(".JStableOuter > tbody").scrollLeft());

            $('.JStableOuter > table > thead > tr > th:nth-child(1)').css("left", $(".JStableOuter > table").scrollLeft() - 0);

            $('.JStableOuter > table > tbody > tr > td:nth-child(1), .JStableOuter > table > tbody > tr > td:nth-child(2)').css("left", $(".JStableOuter > table").scrollLeft());

            $('.JStableOuter > table > thead > tr > th:nth-child(2)').css("left", $(".JStableOuter > table").scrollLeft() - 0);
            $('.JStableOuter > table > tbody > tr > td:nth-child(2)').css("left", $(".JStableOuter > table").scrollLeft());


            $('.JStableOuter > table > thead').css("top", -$(".JStableOuter > tbody").scrollTop());
            $('.JStableOuter > table > thead > tr > th').css("top", $(".JStableOuter > table").scrollTop());

        });


       //colappse row
        //$(".UpDowncollapseArrow").click(function () {
        //    $(this).toggleClass("in");

        //});//commented by pradip on 14-01-2020

        //Tagsinput



        function AfterPlot() {
            //$('#RAtaglist').tagsinput({
            //    typeahead: {
            //        source: ['Amsterdam', 'Washington', 'Sydney', 'Beijing', 'Cairo'],
            //        afterSelect: function () {
            //            this.$element[0].value = '';
            //        }
            //    }
            //});

            $('#resourcetaglist').tagsinput({
                typeahead: {
                    source: ['Amsterdam', 'Washington', 'Sydney', 'Beijing', 'Cairo'],
                    afterSelect: function () {
                        this.$element[0].value = '';
                    }
                }
            });
            //auto search for corporate roles
            //$("#searchCR").on("keyup", function (e) {
              
                //var value = $(this).val().toLowerCase();
                //$("#CRTable tr").not(':first').filter(function () // modified by pradip on 09-01-2020
                //{
                //    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)                   

                //});

                   

                //if (whichflag != 0) {
                //    if (whichflag == "") {
                //        whichflag = 1;
                //    }
                //    else if (whichflag == 1) {
                //        whichflag = 1;
                //    }

                //}
                //else if (whichflag == 0) {
                //    whichflag = 0;
                //}

              
                //var input = $(this);
                //if (input.val() == "") {
                //     $(".UpDowncollapseArrow").removeClass("in");
                //    $(".PRHide").removeClass('collapse').css("display","none"); 
                   
                //} //Added by pradip on 14-01-2020  
                //intPageNo = 1;
                //if(e.which == 13)
                //BindData();
                
            //});

            
          
            $(".UpDowncollapseArrow").click(function () {
                $(this).toggleClass("in");
                //$(this).toggleClass("UpDowncollapseArrow in");
                $(this).closest(".PRHide").addClass('collapse in').css("display", "block");
                //Commented And Added By Usha Pandit On 09.04.2020 For javascript error on visibility check
                //if ($(".PRHide").isVisible()) {
                //    $(this).parent(".UpDowncollapseArrow").addClass("in");
                //}
                if ($(".PRHide").is(":visible")) {
                    $(this).parent(".UpDowncollapseArrow").addClass("in");
                }
                //End Of Added By Usha Pandit On 09.04.2020 For javascript error on visibility check
            });//Added by pradip on 14-01-2020


        }
    </script>

    <script type="text/javascript">
        //this is for file attache and drop script

        $('form input').change(function () {
            $('form p').text(this.files.length + " file(s) selected");
        });



        //availability and allocated
        $(".availNDallocate .tab-slider--nav li").click(function () {

            $(".tab-slider--body2").hide();
            var activeTab2 = $(this).attr("rel");
            $("#" + activeTab2).fadeIn();
            if ($(this).attr("rel") == "wbsallocate") {
                $('.availNDallocate .tab-slider--tabs').addClass('slide');
            } else {
                $('.availNDallocate .tab-slider--tabs').removeClass('slide');
            }
            $(".availNDallocate .tab-slider--nav li").removeClass("active");
            $(this).addClass("active");
        });
    </script>

    <script>
        //check and uncheck checkbox
        // Check or Uncheck All checkboxes
        $(".chckHead").change(function () {
            var checked = $(this).is(':checked');
            if (checked) {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", true);
                });
            } else {
                $(".chcktbl").each(function () {
                    $(this).prop("checked", false);
                });
            }
        });

        // Changing state of CheckAll checkbox 
        $(".chcktbl").click(function () {

            if ($(".chcktbl").length == $(".chcktbl:checked").length) {
                $(".chckHead").prop("checked", true);
            } else {
                $(".chckHead").removeAttr("checked");
            }

        });
        //Added By Dipali V On 27th Dec 2019 For Select only 10 Resources
        var arrChecked = new Array();
        //Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
        var arrSelectedEmployeeNames = new Array();
        var arrSelectedEmployeeIds = new Array();
        //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id

        function selectedCheckbox(obj) {
            if (obj.checked == true) {
                //Commented And Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                //arrChecked.push(this.id);
                arrChecked.push(obj.id);                
                var curSelectedEmployeeName = document.getElementById("SelectedEmployeeName_" + obj.value).value;
                arrSelectedEmployeeNames.push(curSelectedEmployeeName);
                arrSelectedEmployeeIds.push(obj.value);                
                //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
            }
            //Added By Rutuja D. 8 Jan 2020 For Uncheck Check Box Remove From Array
            else {
                if (obj.checked == false) {
                    //Commented And Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id   
                    //arrChecked.pop(this.id);
                    arrChecked = jQuery.grep(arrChecked, function (value) {
                        return value != obj.id;
                    });
                    arrSelectedEmployeeNames = jQuery.grep(arrSelectedEmployeeNames, function (value) {
                        return value != $("#SelectedEmployeeName_" + obj.value).val();
                    });
                    arrSelectedEmployeeIds = jQuery.grep(arrSelectedEmployeeIds, function (value) {
                        return value != obj.value;
                    });                    
                    //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                }
            }
            //End Added By Rutuja D. 8 Jan 2020 For Uncheck Check Box Remove From Array

            if (arrChecked.length > 10) {
                alertify.set('notifier', 'position', 'top-right');
                //Commented & Added By Rutuja D. 8 Jan 2020 For Alert is Wrong
                //alertify.error("You can not select greater than 10 Resources");
                alertify.error("You can not select more than 10 Resources");
                //Commented & Added By Rutuja D. 8 Jan 2020 For Alert is Wrong
                obj.checked = false;
                if (obj.checked == false) {
                    //Commented And Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                    //arrChecked.pop(this.id);
                    arrChecked = jQuery.grep(arrChecked, function (value) {
                        return value != obj.id;
                    });
                    arrSelectedEmployeeNames = jQuery.grep(arrSelectedEmployeeNames, function (value) {
                        return value != $("#SelectedEmployeeName_" + obj.value).val();
                    });
                    arrSelectedEmployeeIds = jQuery.grep(arrSelectedEmployeeIds, function (value) {
                        return value != obj.value;
                    });                    
                    //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                }                
                //Commented And Added By Usha Pandit On 13.04.2020 For javascript after selecting 10 records
                //$('#CRTable.chcktbl input[type="checkbox"]').is(":not(:checked)").attr("disabled", "disabled")
                $('#CRTable.chcktbl input[type="checkbox"]:not(:checked)').attr("disabled", "disabled");
                //End Of Added By Usha Pandit On 13.04.2020 For javascript after selecting 10 records
                return false;
            }


        }
        //End of Added By Dipali V On 27th Dec 2019 For Select only 10 Resources


        //script added for add skillset 
        var counter = 0;
        //Added by Chetan M on 17th Jan 2020 
        var AddSkillFlag = 0;
        var SkillValidationFlag = 0;
        //End of Added by Chetan M on 17th Jan 2020 

        $("#addskillsetrow").on("click", function () {
           
            //alert($("#tbodySkill tr").length);
            if ($("#tbodySkill tr").length < 1 && $("#cboSkillMaster0").val() != "0") {
                //Added by Chetan M on 17th Jan 2020 
                AddSkillFlag = 1;
                //End of Added by Chetan M on 17th Jan 2020 
                var newRow = $("<tr id='R" + counter + "'>");
                var cols = "";
                var strhtml = "";
                var strhtmlNew = "";
                var strPffhtml = "";
                var strProfficiencyhtmlNew = "";
                var StrHtmlYear = "";
                var finalmonth = "";
                var finalyear = "";
                var StrHtmlMonth = "";

                strhtmlNew = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboSkillMasterName", "select ''", , , "Mandatory=1 class=""form-control clsMandatoryFields""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                strhtmlNew = strhtmlNew.replace(/Name/g, counter);
                strhtml += strhtmlNew;
                cols += '<td> ' + strhtml + '</td>';

                StrHtmlMonth = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboMonthName", "usp_Sel_GetYears 0 ,30 ", 50,  , "Mandatory=1 class=""form-select clsMandatoryFields""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                StrHtmlMonth = StrHtmlMonth.replace(/Name/g, counter);
                finalmonth += StrHtmlMonth;


                StrHtmlYear = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboYearName", "usp_Sel_GetYears 0 ,11 ", 50, , "Mandatory=1 class=""form-select clsMandatoryFields""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                StrHtmlYear = StrHtmlYear.replace(/Name/g, counter);
                finalyear += StrHtmlYear;



                cols += '<td class="exprience"> ' + StrHtmlMonth + ' To ' + StrHtmlYear + '</td>';

                strProfficiencyhtmlNew = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboParametersName", "usp_Whizible2_Sel_tbl_HR_Parameters 7 ", , , "Mandatory=1 class=""form-select clsMandatoryFields""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                strProfficiencyhtmlNew = strProfficiencyhtmlNew.replace(/Name/g, counter);
                strPffhtml += strProfficiencyhtmlNew;
                cols += '<td> ' + strPffhtml + '</td>';
                cols += '<td><button class="ibtnDel nostylebtn"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Delete" onclick="SkillDelete_onclick()"></i></button></td>';
                newRow.append(cols);
                $("#Rskillsettab table").append(newRow);
                GetRequestSkillCombo(counter);
                counter++;
                $("select option").removeAttr("title");
            }
            else {

                alertify.set('notifier', 'position', 'top-right');
                alertify.error("You can add one skill at time");
                $("#cboSkillMaster0").focus();
                return;
            }
        });

        //Added by Chetan M on 17th Jan 2020
        function SkillDelete_onclick() {
            AddSkillFlag = 0;
        }
        //End of addded by Chetan M on 17th Jan 2020

        function GetSkillIsExternal() {

            var ResourceParameters = {
                RequestID: encodeURI(GlobalrequestID),
                ProjectID: encodeURI(ProjectID),

            }
            var param = JSON.stringify(ResourceParameters);
            var strResult = AJAXCallWithResult("/api/PM_AddNewResource/GetRequestSkillCombo", param, false);
            return strResult;
        }
        //Added By Dipali V On 30th Dce 2019 For Skill Functionality
        function GetRequestSkillCombo(counter) {

            var IsExternal = "";
            var ChkIsExternal = "";
            var strResult1 = GetSkillIsExternal();

            var ResourceParameters = {
                RequestID: encodeURI(GlobalrequestID),
                ProjectID: encodeURI(ProjectID),

            }
            var param = JSON.stringify(ResourceParameters);
            var strResult = AJAXCallWithResult("/api/PM_AddNewResource/GetRequestSkillCombo", param, false);
            // var IsExternal = "";
            if (strResult.length != 0) {

                var objCbo2 = document.getElementById("cboSkillMaster" + counter);
                $("#cboSkillMaster " + counter + " option").remove();
                $("#cboSkillMaster " + counter + " optgroup").remove();
                for (var i = 0; i < strResult1.length; i++) {
                    if (strResult[i].Flag == "") {
                        var Objresult = strResult[i];
                        var objOption = document.createElement("OPTION");
                        objCbo2.options.add(objOption);
                        objOption.value = Objresult.ToolID == null ? '' : Objresult.ToolID;
                        objOption.text = Objresult.Description;
                    }
                    else if (strResult1[i].Flag != "" && IsExternal != strResult1[i].Flag) {
                        IsExternal = strResult1[i].Flag;
                        var objOption1 = document.createElement("optgroup");
                        objCbo2.options.add(objOption1);
                        objOption1.label = IsExternal;
                        for (var j = 0; j < strResult.length; j++) {
                            ChkIsExternal = strResult[j].Flag;
                            if (IsExternal == ChkIsExternal) {
                                var Objresult = strResult[j];
                                var objOption = document.createElement("OPTION");
                                objCbo2.options.add(objOption);
                                objOption.value = Objresult.ToolID == null ? '' : Objresult.ToolID;
                                objOption.text = Objresult.Description;
                            }
                        }
                    }
                }
            }
            $('select option')
                .filter(function () {
                    return !this.value || $.trim(this.value).length == 0 || $.trim(this.text).length == 0;
                })
                .remove();
        }

       <%-- function GetRequestSkillDetails(requestID) {
            if (requestID == 0) {
                GlobalrequestID = GlobalrequestID;
            }
            GlobalrequestID = 152;
           // alert(GlobalrequestID);
            var ResourceParameters = {
                RequestID: encodeURI(GlobalrequestID)
            }
            var param = JSON.stringify(ResourceParameters);
            var strResult = AJAXCallWithResult("/api/PM_AddNewResource/GetRequestSkillDetails", param, false);
            
            var StrSkillShtml = "";
            if (strResult.length != 0)
            {
             
                $("#tbodySkill").html("");
                var StrHtmlYear = "";
                var finalmonth = "";
                var finalyear = "";
                var StrHtmlMonth = "";
                var strProfficiencyhtmlNew = "";
                var strPffhtml = "";
                for (i = 0; i <= strResult.length - 1; i++)
                {
                    StrSkillShtml = "<tr>";
                    StrSkillShtml += "<td>" + strResult[i].Skill + "</td>";

                    StrHtmlMonth = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboMonthName", "usp_Sel_GetYears 0 ,30 ", ,  , "Mandatory=1 class=""form-control clsMandatoryFields""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    StrHtmlMonth = StrHtmlMonth.replace(/Name/g, strResult[i].SkillID);
                    finalmonth += StrHtmlMonth;


                    StrHtmlYear = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboYearName", "usp_Sel_GetYears 0 ,11 ", , , "Mandatory=1 class=""form-control clsMandatoryFields""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    StrHtmlYear = StrHtmlYear.replace(/Name/g, strResult[i].SkillID);
                    finalyear += StrHtmlYear;

                    strProfficiencyhtmlNew = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboParameters1New", "usp_Whizible2_Sel_tbl_HR_Parameters 7 ", , , "Mandatory=1 class=""form-control clsMandatoryFields""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    strProfficiencyhtmlNew = strProfficiencyhtmlNew.replace(/New/g, strResult[i].SkillID);
                    strPffhtml += strProfficiencyhtmlNew;

                    StrSkillShtml += '<td class="exprience">';
                    StrSkillShtml += finalmonth;
                    StrSkillShtml += ' To';
                    StrSkillShtml += finalyear;
                    StrSkillShtml += ' </td>';
                   
                    StrSkillShtml += ' <td>';
                     StrSkillShtml += strPffhtml;
                    StrSkillShtml += ' </td>';
                    StrSkillShtml += '<td>';
                    StrSkillShtml += ' <button class="delskillset nostylebtn"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Delete"></i></button>';
                    StrSkillShtml += ' </td>';
                    StrSkillShtml += '</tr >';
                    Binddata(strResult[i].SkillID,strResult[i].ExpMonths,strResult[i].ExpYrs,strResult[i].Rating);
                }
                $("#tbodySkill").html(StrSkillShtml);
            
            }
        }--%>

        //function Binddata(ControlID,Months,Years,Rating) {
        //    
        //    $("#cboParameters1" + ControlID).val(Rating);
        //    $("#cboMonth" + ControlID).val(Months);
        //    $("#cboYear" + ControlID).val(Years);
        //   // $("#cboParameters" + ControlID).val();

        //}
        $("#Rskillsettab table").on("click", ".ibtnDel", function (event) {
            if (("#tbodySkill tr").length != 0) {
                $(this).closest("tr").remove();
                counter -= 1
            } else {
                $("#addskillsetrow").attr("disabled", true);
            }

        });

        //script added for add skillset 
        $("#Rskillsettab table").on("click", ".delskillset", function () {
            $(this).closest("tr").remove();
        });

        $('[data-bs-toggle="tooltip"]').tooltip({
            trigger: 'hover'
        })



        function bodyFreezeScroll() {
            var bodyWidth = $body.innerWidth();
            $body.css('overflow', 'hidden');
            $body.css('marginRight', ($body.css('marginRight') ? '+=' : '') + ($body.innerWidth() - bodyWidth))
        }

        function bodyUnfreezeScroll() {
            var bodyWidth = $body.innerWidth();
            $body.css('marginRight', '-=' + (bodyWidth - $body.innerWidth()))
            $body.css('overflow', 'auto');
        }

        $('#RRstartdt, #RRenddt').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            yearRange: 'c-100:c+100',
            dateFormat: 'dd M yy',
            onSelect: function (date) {
               // $('.modal').modal('handleUpdate')
                //bodyFreezeScroll();
            },
        });

      

    </script>
    <script>
        //Added By Riddhesh Patil on 18-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of Added By Riddhesh Patil
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'
        var SessionProjectID = "<%=m_ProjectId%>";
        var LoginType = '<%= Session("LoginType") %>';
        var RoleID = '<%= Session("intPostID") %>';
        var UserID = '<%= Session("intUserID") %>';
        var UserID = '<%= Session("intUserID") %>';
        var UserName = '<%= Session("strUserName") %>';
        var AddAccess = "<%=m_blnAddAccess%>";
        var EditAccess = "<%=m_blnEditAccess%>";
        var DeleteAccess = "<%= m_blnDeleteAccess%>";
        var blnViewAccess = "<%= m_blnViewAccess%>";
        var enableResourceAllocation;
        var MonthName;
        var TotalDays;
        var ProjectStartDate;
        
        $.ajax({
            url: strUrl + '/api/Common/GetCompanyInformation',
            type: "POST",
            dataType: "json",
            contentType: "application/json;charset-utf=8",
            async: false,
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
            },
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    var d = data[i];
                    
                    enableResourceAllocation = d.AllowResourceAllocation;
                    //alert(enableResourceAllocation);
                }
            },
            error: function (err) {
                console.log(err);
                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
            }
        });
        //Added by Dipali V On 28th Dec 2019 
        var AllFilterEnabled = 1;
        var IsAgile = "";
        var SelectedCurrentdate = "";
        var FilterRoleID = null;
        var Today = "";
        var GlobalrequestID = "";
        //End of Added by Dipali V On 28th Dec 2019 
        alertify.set('notifier', 'position', 'top-right');
        var GlobalApplyID;
        var GlobalFilterName;
        var GetDefaultFilterID = "";
        var FilterID;
        var QueryText = "";
        var arrskillIDFilter = new Array();
        var AllFields = ["SkillID", "OrganizationUnit", "BussinessGroup "];
        var whichflag = "1";
        var SearchText = "";
        var objWorkHoursOldVal = "";
        var FromWhereFlag = 0;
        //Added By Reshma Chavan On 8th Oct 2020 For JDUpgarde Pagination Change   
        var SearchRecords = 0;
        var TotalRecords = 0;
        var GlobalResourceAssignCount = 0;
        var intPageNo = 1;
         //End of Added By Reshma Chavan On 8th Oct 2020 For JDUpgarde Pagination Change
        $(document).ready(function () {

            $('.btn').tooltip({ trigger: 'hover' });
            $(function () {
                $('[data-bs-toggle="tooltip"]').tooltip() // Example from the documentation
                $('body').tooltip({ selector: "[title]", trigger: "hover", delay: { show: 1000, hide: 0 } }); // Issue #36253 reproduction
            });


            StartLoader("#AddNewResource")

            $(".modal").scroll(function () {
                $('#ui-datepicker-div').hide();
            });
            clearTooltip();
            // $('.selectpicker').attr('data-original-title', '');
            Date.prototype.toShortFormat = function () {

                var month_names = ["Jan", "Feb", "Mar",
                    "Apr", "May", "Jun",
                    "Jul", "Aug", "Sep",
                    "Oct", "Nov", "Dec"];

                var day = this.getDate();
                var month_index = this.getMonth();
                var year = this.getFullYear();

                return "" + day + " " + month_names[month_index] + " " + year;
            }
            SelectedCurrentdate = new Date();

            Parameters = getParameters();
            m_ProjectID = unescape(Parameters["ProjectID"]);
            m_ProjectName = unescape(Parameters["ProjectName"]);
            m_SelectedProjectID = unescape(Parameters["ProjectID"]);
            m_SelectedProjectName = unescape(Parameters["ProjectName"]);

            if (m_ProjectID != "undefined") {
                SessionProjectID = m_ProjectID;
                SessionProjectName = m_ProjectName;
                FillProjectCombox();
                CheckProjectOver();//Added By Rutuja D. 8 Jan 2020 For Project IS Over Or Not
            }
            else if (m_SelectedProjectID != "undefined") {
                SessionProjectID = m_SelecteProjectID;
                SessionProjectName = m_SelectedProjectName;
                FillProjectCombox();
                CheckProjectOver();//Added By Rutuja D. 8 Jan 2020 For Project IS Over Or Not
            }
            else {
                SessionProjectID = SessionProjectID;
                FillProjectCombox();
                CheckProjectOver();//Added By Rutuja D. 8 Jan 2020 For Project IS Over Or Not
            }
            AfterPlot();
            //$("#divRole select").attr("disabled", "disabled");//Added By Dipali V On by Default Role Filter should be disabled
            //Added By Dipali V On 27th Dec 2019 For ToolTip To Project DropDown
            m_SelectedProjectName = $("#cboProjects option:selected").text();
            //alert(m_SelectedProjectName);
            $("#cboProjects").attr("data-original-title", "");
            $("#cboProjects").attr("data-original-title", m_SelectedProjectName);
            $("#cboProjects").attr('data-bs-toggle', 'tooltip');
            $("#cboProjects").attr('data-bs-placement', 'bottom');
            //End of added By Dipali V On 27th Dec 2019 For ToolTip To Project DropDown         
            StopAjaxLoader("#AddNewResource");//added by Dipali V On 27th Dec 2019 For Loader on page load
            $("select option").removeAttr("title");

            $('#PlanEndDate,#PlanStartDate').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                yearRange: 'c-100:c+100',
                dateFormat: 'dd M yy'

            });

            $('.sortbyrole .selectpicker').selectpicker({
                container: 'body'
            });

            $(window).on("load resize scroll", function (e) {
                resizeSection(this);
                // alert(JStableOuter);
            });

            //Added By Rutuja D 8 Jan 2020 For Get Todays Date 
            $('#txtToday').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                yearRange: 'c-100:c+100',
                dateFormat: 'dd M yy'

            });
            $('#txtToday').datepicker('setDate', new Date());
            //End Added By Rutuja D 8 Jan 2020 For Get Todays Date 


            //dynamically set height
            function resizeSection(tag) {
                var JStableOuter = $(window).height();
                $('.JStableOuter > table').css({ 'height': JStableOuter - 175, "overflow-y": "auto" });

            }


            clearTooltip();

            $(function () {
                $('#txtResourceFilterSkillID, #roufilter, #rbgfilter').multiselect({
                    includeSelectAllOption: true,
                    enableCaseInsensitiveFiltering: true,
                    enableFiltering: true,
                    maxHeight: 200
                });
            });


            $('.multiselect-container').click(function (e) {
                var containerHeight = $(this).find("ul").outerHeight();
                $(this).find(".ms-drop").css({
                    'position': 'fixed',
                    'left': $(this).offset().left,
                    'top': $(this).offset().top,
                    'height': containerHeight,
                })
            });

            //start script for display dropdown hide behind div
            (function () {
                // hold onto the drop down menu                                             
                var dropdownMenu;

                // and when you show it, move it to the body                                     
                $(window).on('show.bs.dropdown', function (e) {

                    // grab the menu        
                    dropdownMenu = $(e.target).find('.multiselect-container.dropdown-menu');

                    // detach it and append it to the body
                    $('body').append(dropdownMenu.detach());

                    // grab the new offset position
                    var eOffset = $(e.target).offset();

                    // make sure to place it where it would normally go (this could be improved)
                    dropdownMenu.css({
                        'display': 'block',
                        'top': eOffset.top + $(e.target).outerHeight(),
                        'left': eOffset.left
                    });
                });

                // and when you hide it, reattach the drop down, and hide it normally                                                   
                $(window).on('hide.bs.dropdown', function (e) {
                    $(e.target).append(dropdownMenu.detach());
                    dropdownMenu.hide();
                });
            })();
            //End script for display dropdown hide behind div

            //script added by pradip on 09-01-2020
            $("#CRTable tr.theadrow").css("display", "none!important");
            $("#CRTable tr.theadrow").appendTo(".PRdailviewtable thead");

        });
        function prev_ONClick() {
            
            if (ProjectStartDate != '0') {
                StartLoader("#AddNewResource");
                SelectedEmployeeIDs = "";
                arrChecked = [];
                //Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                arrSelectedEmployeeNames = [];
                arrSelectedEmployeeIds = [];
                //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                GetDate('prev');
                //$("#searchCR").val("");
                BindData();
                StopAjaxLoader("#AddNewResource");
            }
        }
        function next_ONClick() {
            if (ProjectStartDate != '0') {
                StartLoader("#AddNewResource");
                SelectedEmployeeIDs = "";
                arrChecked = [];
                //Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                arrSelectedEmployeeNames = [];
                arrSelectedEmployeeIds = [];
                //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                GetDate('next');
                //$("#searchCR").val("");
                BindData();

                StopAjaxLoader("#AddNewResource");
            }
        }
        function GetDate(action) {
            var currentProjectId = $("#cboProjects option:selected").val();
            var resourceParameters = {
                intProjectID: currentProjectId,
                StartDate: ProjectStartDate
            }
            $.ajax({
                url: strUrl + '/api/PM_AddNewResource/GetMonthDates',
                type: "POST",
                data: JSON.stringify(resourceParameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (resourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(resourceParameters) ? resourceParameters : JSON.stringify(resourceParameters)));
                    }
                },
                success: function (data) {
                   
                    var Dates = data;
                    if (action == 'prev') {
                        MonthName = Dates[0].prevMonth;
                        if (Dates[0].prevDate != "0") {
                            ProjectStartDate = Dates[0].prevDate;
                        } else {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('You are on first Page', 'error');
                            return false;
                        }
                    }
                    else if (action == 'next') {
                        MonthName = Dates[0].nextMonth;
                        ProjectStartDate = Dates[0].nextDate;
                        if (Dates[0].nextDate != "0") {
                            ProjectStartDate = Dates[0].nextDate;
                        } else {
                            // ProjectStartDate = ProjectStartDate;
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('You are on last Page', 'error');
                            return false;
                        }
                    }
                    StopAjaxLoader("#bodyTSEntry");
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        function FillProjectCombox() {
            var sessionproj = 0;
            sessionproj = SessionProjectID;
            if (SessionProjectID == "") {
                sessionproj = 0;
            }

            var ResourceParameters = {
                UserID: encodeURI(UserID),
                ProjectID: encodeURI(sessionproj),
                LoginType: encodeURI(LoginType),
            }
            var param = JSON.stringify(ResourceParameters);
            var strResult = AJAXCallWithResult("/api/PM_Resources/GetProjectID", param, false);

            var objCbo1 = document.getElementById("cboProjects");
            $("#cboProjects option").remove();

            if (strResult.length != 0) {
                for (var i = 0; i < strResult.length; i++) {

                    var ObjAccessProj = strResult[i];

                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);

                    if (SessionProjectID == ObjAccessProj.ProjectID) {
                        objOption.text = ObjAccessProj.ProjectName;
                        objOption.value = ObjAccessProj.ProjectID;
                    }
                    else {
                        objOption.text = ObjAccessProj.ProjectName;
                        objOption.value = ObjAccessProj.ProjectID;
                    }
                    if (ObjAccessProj.ProjectID == "0") {
                        objOption.text = "Select Project";
                    }
                }
            }

            if (SessionProjectID != null && SessionProjectID != undefined && SessionProjectID != "") {
                jQuery("select#cboProjects option[value=" + SessionProjectID + " ]").attr("selected", "selected");
                ProjectID = SessionProjectID;

                $('[data-bs-toggle="tooltip"]').tooltip();


            } else {
                ProjectID = $("#cboProjects").val();
            }

            BindData();
        }
        function ChangeProject(obj) {
           
            arrChecked = [];
            //Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
            arrSelectedEmployeeNames = [];
            arrSelectedEmployeeIds = [];
            //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
            ProjectID = obj.value;
            StartLoader("#AddNewResource");
            IsAgile = 0;
            AllFilterEnabled = 1;
            BindData();
            cancelRequest();
            CheckProjectOver(); //Added By Rutuja D. 8 Jan 2020 For Project IS Over Or Not
            //alert(ProjectID);
            StopAjaxLoader("#AddNewResource");
        }
        //if (ProjectStartDate == '0') {
        //    ProjectStartDate = null
        //}
        function BindData() {
            var currentProjectId = $("#cboProjects option:selected").val();
            var resourceParameters = {
                intProjectID: currentProjectId,
                StartDate: ProjectStartDate
            }
            StartLoader("#bodyTSEntry");
            $.ajax({
                url: strUrl + '/api/PM_AddNewResource/GetResourceData',
                type: "POST",
                data: JSON.stringify(resourceParameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (resourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(resourceParameters) ? resourceParameters : JSON.stringify(resourceParameters)));
                    }
                },
                success: function (data) {
                    var Resources = data;
                   
                    if (whichflag != 0)
                    {
                        if (whichflag == "") {
                            whichflag = 1;
                        }
                        else if (whichflag == 1) {
                            whichflag = 1;
                        }

                    }
                    else if (whichflag == 0)
                    {
                        whichflag = 0;
                    }
                    
                    
                     //alert(whichflag);
                    BindHeader(Resources.ProjectDates);
                    BindRoleCounts(Resources.countLists);
                    BindFilter();
                   
                   
                    LoadDetails(whichflag, QueryText);

                    AfterPlot();
                    //Added By Dipali V On 27th Dec 2019 For ToolTip To Project DropDown
                    m_SelectedProjectName = $("#cboProjects option:selected").text();
                    $("#cboProjects").attr("data-original-title", "");
                    $("#cboProjects").attr("data-original-title", m_SelectedProjectName);
                    $("#cboProjects").attr('data-bs-toggle', 'tooltip');
                    $("#cboProjects").attr('data-bs-placement', 'bottom');
                    IsAgile = CheckIsAgileProject(ProjectID);
                    if (IsAgile == 0) {
                        $("#divIsProductOwner").hide();
                    }
                    else {
                        $("#divIsProductOwner").show();
                    }
                    //End of Added By Dipali V On 27th Dec 2019 For ToolTip To Project DropDown
                    StopAjaxLoader("#bodyTSEntry");
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }

        function CheckIsAgileProject(ProjectID) {
            var ResourceParameters = {
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ResourceParameters);
            var strResult = AJAXCallWithResult("/api/PM_Resources/CheckIsAgileProject", param, false);
            if (strResult != undefined) {
                return strResult;
            }

        }

        var GlobaltotalDays=0;
        function LoadDetails(flag, QueryText) {
            //alert(FilterRoleID);
           //Added By Reshma Chavan on 22nd Oct 2020 For Pagination Change
            GlobaltotalDays = GetTotaldaysInMonth(ProjectStartDate);
           //End of Added By Reshma Chavan on 22nd Oct 2020 For Pagination Change
            //added by dipali V On 28th Dec 2019 For Role Filter
            if (FilterRoleID == null) {
                //FilterRoleID = null;
                FilterRoleID = '<%= Session("intPostID") %>';
            }
            //End of added by dipali V On 28th Dec 2019 For Role Filter
            //Added By Reshma on 8th Jan 2020
            if (QueryText == null || QueryText == undefined) {
                QueryText = "";
            }
            else {
                QueryText = QueryText;
            }
            //End Added By Reshma on 8th Jan 2020
            

            var currentProjectId = $("#cboProjects option:selected").val();
            var resourceParameters = {
                intProjectID: currentProjectId,
                StartDate: ProjectStartDate,
                SelectedRoleID: FilterRoleID,
                QueryText: QueryText,
                //Added By Reshma Chavan on 8th Oct 2020 For JDUpgrade Pagination Change
                PageSize: GlobaltotalDays,
                PageNumber: intPageNo,
                //End of Added By Reshma Chavan on 8th Oct 2020 For JDUpgrade Pagination Change
                SearchText :$('#searchCR').val()
            }
            StartLoader("#bodyTSEntry");
            $.ajax({
                url: strUrl + '/api/PM_AddNewResource/GetResourceDetails',
                type: "POST",
                data: JSON.stringify(resourceParameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (resourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(resourceParameters) ? resourceParameters : JSON.stringify(resourceParameters)));
                    }
                },
                success: function (data) {
                   
                    var Resources = data;
                    // alert(flag);
                    BindGrid(Resources.headerLists, Resources.ResourceDetailsLists, flag);
                    //alert(AllFilterEnabled);
                    if (AllFilterEnabled == 1) {

                        $("#divRole select").removeAttr("disabled");
                        $("#divRole select option").removeAttr("title"); // Modified by pradip on 09-01-2020
                    }
                    else {
                        $("#divRole select").attr("disabled", "disabled");
                        $("#divRole select option").removeAttr("title"); // Modified by pradip on 09-01-2020
                    }
                    //Added By Dipali V On 9th Jan 2020 For Filter Issues
                    


                    if (whichflag != 0) {
                        if (whichflag == "") {
                            whichflag = 1;
                        }
                        else if (whichflag == 1) {
                            whichflag = 1;
                        }

                    }
                    else if (whichflag == 0) {
                        whichflag = 0;
                    }

                   
                    //End of Added By Dipali V On 9th Jan 2020 For Filter Issues
                    StopAjaxLoader("#bodyTSEntry");
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }
        function BindHeader(ProjectDates) {
            $(".datelabel").html("<b>" + ProjectDates.DateLabel + "</b>");
          
            
            if (enableResourceAllocation != undefined) {
                if (enableResourceAllocation == 0) {
                    $("#btnResourceRequest").css("display", "none");
                    $("#btnAllocateResource").css("display", "inline-block");
                }
                else {
                    $("#btnResourceRequest").css("display", "inline-block");
                    $("#btnAllocateResource").css("display", "none");
                }
            }
        }
        function BindRoleCounts(RoleCounts) {
          
            for (var i = 0; i < RoleCounts.length; i++) {
                var count = RoleCounts[i];
                //added By Dipali V On 27th Dec 2019 For Role Name If Bigger then
                if (count.Role.length < 15) {
                    $("#Role" + (i + 1)).html('<a href="javascript:;" ><span class="statustextno">' + count.RoleCount + '</span>' + count.Role + '</a>');
                }
                else {
                    var str = count.Role.substring(0, 15);
                    $("#Role" + (i + 1)).html('<a href="javascript:;" ><span class="statustextno">' + count.RoleCount + '</span>' + str + '...</a>');

                }
                //End of added By Dipali V On 27th Dec 2019 For Role Name If Bigger then
                $("#Role" + (i + 1)).attr("data-original-title", count.Role);
                $("#Role" + (i + 1)).attr("onclick", "ResourceCounterOnClick(this," + count.RoleID + ")");
                MonthName = count.ProjectStartMonth;
                ProjectStartDate = count.ProjectStartDate;
                TotalDays = count.TotalDays;
            }
            $(".tblmnthname").html('<input type="hidden" id="ProjectStartDate" value="' + ProjectStartDate + '" />' + MonthName);
        }
        function ResourceCounterOnClick(obj, RoleID) {
            StartLoader("#AddNewResource");
            arrChecked = [];
            //Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
            arrSelectedEmployeeNames = [];
            arrSelectedEmployeeIds = [];
            //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
            FilterRoleID = RoleID;
            if (whichflag != 0) {
                if (whichflag == "") {
                    whichflag = 1;
                }
                else if (whichflag == 1) {
                    whichflag = 1;
                }

            }
            else if (whichflag == 0) {
                whichflag = 0;
            }
                    
            LoadDetails(whichflag, QueryText);
            for (var i = 0; i < 4; i++) {
                if ($("#Role" + (i + 1)).hasClass("active"))
                    $("#Role" + (i + 1)).removeClass("active");
            }
            $(obj).addClass("active");
            var RoleCaption = $(obj).attr("data-original-title");
            if (RoleCaption == "All") {
                AllFilterEnabled = 1;
                $("#divRole select").removeAttr("disabled");
            } else {
                AllFilterEnabled = 0;
                $("#divRole select").attr("disabled", "disabled");
            }
            StopAjaxLoader("#AddNewResource");
        }


        function BindFilter() {

        }



        function changeView(flag) {
            StartLoader("#AddNewResource");
            arrChecked = [];
            //Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
            arrSelectedEmployeeNames = [];
            arrSelectedEmployeeIds = [];
            //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
            whichflag = flag;
            $("#searchCR").val("");
            LoadDetails(flag, QueryText);
            
            $(".UpDowncollapseArrow").click(function () {
                $(this).toggleClass("in");
                //$(this).toggleClass("UpDowncollapseArrow in");
                $(this).closest(".PRHide").addClass('collapse in').css("display", "block");

                //Commented And Added By Usha Pandit On 09.04.2020 For javascript error on visibility check
                //if ($(".PRHide").isVisible()) {
                //    $(this).parent(".UpDowncollapseArrow").addClass("in");
                //}
                if ($(".PRHide").is(":visible")) {
                    $(this).parent(".UpDowncollapseArrow").addClass("in");
                }
                //End Of Added By Usha Pandit On 09.04.2020 For javascript error on visibility check
                
            });//Added by pradip on 16-01-2020
            StopAjaxLoader("#AddNewResource");

        }

        //function GetRoleCombo() {
        //    var ResourceParameters = {

        //    }
        //    var param = JSON.stringify(ResourceParameters);
        //    var strResult = AJAXCallWithResult("/api/PM_Resources/GetRoleCombo", param, false);


        //}

		//Added by Nilesh Pingale On 22 June-2020 to fix the count of resources.
        function countUnique(iterable) {
            return new Set(iterable).size;
        }
        //End of Added by Nilesh Pingale On 22 June-2020 to fix the count of resources.

        function BindGrid(headerLists, ResourceDetailsLists, displayFlag) {
          
            StartLoader("#AddNewResource")

            var searchText = $('#searchCR').length!=0?$('#searchCR').val():"";
            var GridHTML = "";
            $("#CRTable").html("");
            GridHTML += '<tr class="theadrow">';
            GridHTML += '                  <th class="">';
            //GridHTML += '                      <div class="custom_chckbox">';
            //GridHTML += '                          <input type="checkbox" id="PRR1" class="chckHead">';
            //GridHTML += '                          <label for="PRR1"></label>';
            //GridHTML += '                      </div>';
            GridHTML += '                  </th>';
            GridHTML += '                  <th class="">';
            GridHTML += '                      <input type="search" class="form-control" value="'+searchText+'" id="searchCR" placeholder="search" onkeyup="ChangeFilter(event)" >';
            GridHTML += '                  </th>';
            GridHTML += '                  <th colspan="' + TotalDays + '">';
            GridHTML += '                      <div class="monthheading">';
            GridHTML += '                          <a class="montharrow prvMonth" id="prev" data-bs-toggle="tooltip" data-bs-container="body" data-title="Previous Month"><i class="fas fa-chevron-left" onclick="prev_ONClick()"></i></a>';
            GridHTML += '                          <div class="tblmnthname"><input type="hidden" id="ProjectStartDate" value="' + ProjectStartDate + '" />' + MonthName + '</div>';
            GridHTML += '                          <a class="montharrow nextMonth" id="next" data-bs-toggle="tooltip" data-bs-container="body" data-title="Next Month"><i class="fas fa-chevron-right" onclick="next_ONClick()"></i></a>';
            GridHTML += '                      </div>';
            GridHTML += '                  </th>';
            GridHTML += '              </tr>';
            ///////////////////Header Display Section///////////////////
            GridHTML += '<tr>';
            
            //Added by Nilesh Pingale On 22 June-2020 to fix the count of resources.
            var EmployeeIDList = [];
            for (var i = 0; i < ResourceDetailsLists.length; i++) {
                EmployeeIDList.push(ResourceDetailsLists[i].EmployeeID);
            }
            //End of Added by Nilesh Pingale On 22 June-2020 to fix the count of resources.            
               for (var i = 0; i < headerLists.length; i++) {
                var header = headerLists[i];
                var strhtml = "";
                if (i == 0) {
                    //strhtml += " <span id='Mandatory" + FieldName + "' value='1' style='color:red;'> * </span>"
                    strhtml = '<%=CommonFunctions.HTMLControls.DrawComboBox("CboRole", "usp_Whizible2_Getalltbl_PM_Role", , , "onchange='Role_onchange(this)' class=""form-select""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                    //strhtml = strhtml.replace(/FieldName/g, FieldName);
                    //strhtml += strhtml;
                    GridHTML += '                  <td>&nbsp;</td>';
                    GridHTML += '                  <td class="text-start sortbyrole">';
                    GridHTML += '                     <div class="row">';
                    //Added by Nilesh Pingale On 22 June-2020 to fix the count of resources.
                    // GridHTML += '                         <div class="col-sm-4">' + header.ResourceCount + ' People</div>';
                    GridHTML += '                         <div class="col-sm-4">' + countUnique(EmployeeIDList) + ' People</div>';
                    //End of Added by Nilesh Pingale On 22 June-2020 to fix the count of resources.
                    GridHTML += '                        <div class="col-sm-8" id="divRole">';
                    GridHTML += strhtml;
                    //GridHTML += '                            <select class="form-control selectpicker">';
                    //GridHTML += '                                <option>Sort by Role</option>';
                    //GridHTML += '                                <option>Graphic designer</option>';
                    //GridHTML += '                                <option>HTML Developer</option>';
                    //GridHTML += '                            </select>';
                    GridHTML += '                       </div>';
                    GridHTML += '                   </div>';
                    GridHTML += '                </td>';
                }
              
                if (header.IsWorking == 1) {
                    GridHTML += ' <td class="red">' + header.day + '<input type="hidden" value="' + header.date + '" /></td>';
                } else {
                    GridHTML += ' <td>' + header.day + '<input type="hidden" value="' + header.date + '" /></td>';
                }

            }
            GridHTML += '            </tr>';
            ///////////////////Details Display Section///////////////////
            var PrevEmployee, CurrEmployee, nextEmployee, Flag = 0;
            for (var j = 0; j < ResourceDetailsLists.length; j++) {
                var Details = ResourceDetailsLists[j];
                if (Details.IsLast == 1)
                    Flag = 0;
                else if (Details.IsLast == 2)
                    Flag = 1;

                if (j == 0)
                    PrevEmployee = 0;
                else
                    PrevEmployee = ResourceDetailsLists[j - 1].EmployeeID;

                CurrEmployee = Details.EmployeeID;
                if (ResourceDetailsLists[j + 1] == undefined)
                    nextEmployee = 0;
                else
                    nextEmployee = ResourceDetailsLists[j + 1].EmployeeID;

                if (Flag == 0) {
                    if (PrevEmployee != CurrEmployee) {
                        //Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                        var isChecked = false;
                        for (var i = 0; i < arrChecked.length; i++) {
                            if (arrChecked[i] == "PRR" + CurrEmployee) {                                
                                isChecked = true;
                                break; 
                            }
                        }
                        //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                        GridHTML += '<tr class="srchResourceDatarow">'; // modified by pradip on 09-01-2020

                        GridHTML += '                <td>';
                        /*Commented And Added By Usha Pandit On 12.06.2020 For setting width for resource selection checkbox alignment*/
                        //GridHTML += '                    <div class="custom_chckbox">';
                        GridHTML += '                    <div class="custom_chckbox" style="text-align:center;">';
                        /*End Of Added By Usha Pandit On 12.06.2020 For setting width for resource selection checkbox alignment*/
                        //Commented And Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                        //GridHTML += '                        <input type="checkbox" id="PRR' + CurrEmployee + '" name="SelectedResources" value="' + CurrEmployee + '" class="chcktbl" onchange="selectedCheckbox(this)">';
                        if (isChecked == true) {
                            GridHTML += '                        <input type="checkbox" id="PRR' + CurrEmployee + '" name="SelectedResources" value="' + CurrEmployee + '" class="chcktbl" onchange="selectedCheckbox(this)" checked>';
                        }
                        else {
                            GridHTML += '                        <input type="checkbox" id="PRR' + CurrEmployee + '" name="SelectedResources" value="' + CurrEmployee + '" class="chcktbl" onchange="selectedCheckbox(this)">';
                        }
                        //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                        GridHTML += '                        <label for="PRR' + CurrEmployee + '"></label>';
                        GridHTML += '<input type="hidden" id="SelectedEmployeeName_' + CurrEmployee + '" value="' + Details.EmployeeName + '" />';
                        GridHTML += '<input type="hidden" id="SelectedEmployeeID_' + CurrEmployee + '" value="' + CurrEmployee + '" />';
                        GridHTML += '                    </div>';
                        GridHTML += '                </td>';
                        GridHTML += '                <td class="text-start dropdown PRrolename">' + Details.EmployeeName;
                        GridHTML += '                                <a href="javascript:;" class="nostyle hidden-xs UpDowncollapseArrow" data-bs-toggle="collapse" data-bs-target=".PRhiderow' + CurrEmployee + '" data-original-title="" title="">';
                        GridHTML += '                                    <img class="uparrow" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/up.svg" alt="" class="" width="15px" data-original-title="Hide Details">';
                        GridHTML += '                                    <img class="downarrow" data-bs-toggle="tooltip" data-bs-placement="top" title="" src="../../../Whizible2.0-new/dist/img/down.svg" alt="" class="" width="15px" data-original-title="View Details">';
                        GridHTML += '                                </a>';
                        GridHTML += '                    <br />';
                        GridHTML += '                    <div class="smallsubtext">';
                        GridHTML += '                        <span class="float-start">' + Details.RoleDescription + '</span>  <span class="float-end">' + Details.TotalProjectAssigned + ' Projects</span>';
                        GridHTML += '                        <div class="clearfix"></div>';
                        GridHTML += '                    </div>';
                        GridHTML += '                </td>';
                    }
                }
                // Commented and Added By Reshma on 7th Jan 2020
               
                //if (displayFlag == 1)//avaiable
                //    if (Details.IsOverAvailable == 0) {
                //        GridHTML += ' <td class="PRpercentage PRstatusLightblue Green">' + Details.AvailablePercentage + '</td>';
                //    } else {
                //        GridHTML += ' <td class="PRpercentage PRstatusLightblue red">' + Details.AvailablePercentage + '</td>';
                //    }
                //else if (displayFlag == 0)//allocated
                //    if (Details.IsOverAllocated == 0) {
                //        GridHTML += '<td class="PRpercentage PRstatusLightblue Green">' + Details.AllocatedPercentage + '</td>';
                //    }
                //    else {
                //         GridHTML += '  <td class="PRpercentage PRstatusLightblue red">' + Details.AllocatedPercentage + '</td>';
                //    }
                if (displayFlag == 1)//avaiable
                    if (Details.IsOverAvailable == 0) {
                        GridHTML += ' <td class="PRpercentage PRstatusLightblue"><span class="Green">' + Details.AvailablePercentage + '</span></td>';
                    } else {
                        GridHTML += ' <td class="PRpercentage PRstatusLightblue "><span class="red">' + Details.AvailablePercentage + '</span></td>';
                    }
                else if (displayFlag == 0)//allocated
                    if (Details.IsOverAllocated == 0) {
                        GridHTML += '<td class="PRpercentage PRstatusLightblue "><span class="Green">' + Details.AllocatedPercentage + '</span></td>';
                    }
                    else {
                        GridHTML += '  <td class="PRpercentage PRstatusLightblue "><span class="red">' + Details.AllocatedPercentage + '</span></td>';
                    }
                //End of Commented and Added By Reshma on 7th Jan 2020

               
                // alert(CurrEmployee)
                //alert(nextEmployee)
                if (Flag == 1) {
                    if (nextEmployee != CurrEmployee) {
                        GridHTML += '            </tr>';

                        var currentProjectId = $("#cboProjects option:selected").val();
                        var resourceParameters = {
                            intProjectID: currentProjectId,
                            StartDate: ProjectStartDate,
                            intEmployeeID: CurrEmployee
                        }
                        $.ajax({
                            url: strUrl + '/api/PM_AddNewResource/GetResourceProjects',
                            type: "POST",
                            data: JSON.stringify(resourceParameters),
                            dataType: "json",
                            async: false,
                            contentType: "application/json;charset-utf=8",
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                                if (resourceParameters) {
                                    xhr.setRequestHeader("Params", encryptString(isJson(resourceParameters) ? resourceParameters : JSON.stringify(resourceParameters)));
                                }
                            },
                            success: function (data) {
                                var Resources = data;
                                //   <!--hidden row start here -->
                                GridHTML += '           <tr class="PRHide PRhiderow' + CurrEmployee + ' collapse">';
                                GridHTML += '               <td>&nbsp;</td>';
                                GridHTML += '               <td>';
                                GridHTML += '                   <table class="resourceprojectlist PRhiddentbl" width="100%" cellpadding="10" cellspacing="0">';
                                //Added & Commented By Dipali V On 2nd Jan 2020 For Grid Aligment ISsues
                                //GridHTML += '                       <tr>';
                                //End of Added & Commented By Dipali V On 2nd Jan 2020 For Grid Aligment ISsues
                                for (var i = 0; i < Resources.ResourceProjectsLists.length; i++) {
                                    var Projects = Resources.ResourceProjectsLists[i];
                                    GridHTML += '                       <tr>';
                                    GridHTML += '                           <td class="text-start">' + Projects.ProjectName + '</td>';
                                    GridHTML += '                           <td class="text-end">' + Projects.ResourcePercentage + '%</td>';
                                    GridHTML += '                       </tr>';
                                }
                                //Added & Commented By Dipali V On 2nd Jan 2020 For Grid Aligment ISsues
                                //GridHTML += '                       </tr>';
                                //End of Added & Commented By Dipali V On 2nd Jan 2020 For Grid Aligment ISsues
                                GridHTML += '                   </table>';
                                GridHTML += '               </td>';
                                GridHTML += '               <td colspan="31">&nbsp;</td>';
                                GridHTML += '           </tr>';
                                //                <!--hidden row end-->
                            },
                            error: function (err) {
                                console.log(err);
                                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                            }
                        })
                    }
                }
            }
            $("#CRTable").html(GridHTML);
            //Added By Reshma Chavan on 8th Oct 2020 For JDupgrade Pagination Change               
            Pagination()
            StopAjaxLoader("#AddNewResource")
             //End of Added By Reshma Chavan on 8th Oct 2020 For JDupgrade Pagination Change
            if (FilterRoleID != null && FilterRoleID != 0) {
                $('#CboRole').val(FilterRoleID);
            }
            else {
                $('#CboRole').val(0);
            }
        }

        function ChangeFilter(e) {
            intPageNo = 1;
            if (e.which == 13)
                BindData();
        }

         //Added By Reshma Chavan on 8th Oct 2020 For JDupgrade Pagination Change
        function GetTotaldaysInMonth(ProjectStartDate) {
             var resourceParameters = {
                StartDate: ProjectStartDate 
            }
            var param = JSON.stringify(resourceParameters);
            var strResult = AJAXCallWithResult("/api/PM_AddNewResource/GetTotaldaysInMonth", param, false);
            if (strResult != undefined) {
                return strResult;
            }
        }
        function Pagination() {
           
            //GetResourceDetailsCount(QueryText)
            var ProjectID = $('#cboProjects').val(); 
           if (parseInt(SearchRecords) == 0 ) {
                TotalRecords = GlobalResourceAssignCount;
            } else {
                TotalRecords = $("#CRTable tr").length;
            }
            //TotalRecords = GlobalResourceAssignCount;
            
            //if (ProjectID != 0) {
            //    //Added By  Dipali V On 2nd Sep 2020 For JDTIAC Upgarde
               
            //    var currentRecord = (intPageNo * GlobaltotalDays);
                
            //     if (parseInt(intPageNo) == 1) {
                    
            //         $("#btnprevious").addClass("fa-disabled");
            //         $("#btnnext").removeClass("fa-disabled");
            //         $("#LinkPrevious").removeAttr("Onclick");
            //         $("#LinkNext").attr("Onclick", "NextList()");
                     
                     
            //    }
            //    if (parseInt(currentRecord) > parseInt(TotalRecords) && intPageNo==1) {
                   
            //         $("#btnprevious").addClass("fa-disabled");
            //        $("#btnnext").addClass("fa-disabled");

            //         $("#LinkPrevious").removeAttr("Onclick");
            //         $("#LinkNext").removeAttr("Onclick");
            //    }
            //    //Added By Usha Pandit On 07.12.2020 to disable Next and Previous button if no records other than records on same page
            //    else if (parseInt(currentRecord) == parseInt(TotalRecords)) {
                   
            //         $("#btnprevious").addClass("fa-disabled");
            //        $("#btnnext").addClass("fa-disabled");

            //         $("#LinkPrevious").removeAttr("Onclick");
            //         $("#LinkNext").removeAttr("Onclick");
            //    }
            //    //End Of Added By Usha Pandit On 07.12.2020 to disable Next and Previous button if no records other than records on same page
            //    else if (parseInt(currentRecord) >= parseInt(TotalRecords)) {
                   
            //         $("#btnprevious").removeClass("fa-disabled");
            //         $("#btnnext").addClass("fa-disabled");
            //         $("#LinkPrevious").attr("Onclick", "PrevList()");
            //         $("#LinkNext").removeAttr("Onclick");

            //    }

            //     else if (parseInt(intPageNo) > 1 && parseInt(currentRecord) < parseInt(TotalRecords)) {
                  
            //           $("#btnprevious").removeClass("fa-disabled");
            //           $("#btnnext").removeClass("fa-disabled");
            //           $("#LinkPrevious").attr("Onclick", "PrevList()");
            //           $("#LinkNext").attr("Onclick", "NextList()");

            //    }
            //   if (parseInt(SearchRecords) == "1" && parseInt(currentRecord) >= parseInt(TotalRecords)) {
                   
            //         $("#btnprevious").addClass("fa-disabled");
            //         $("#btnnext").addClass("fa-disabled");
            //         $("#LinkPrevious").removeAttr("Onclick");
            //         $("#LinkNext").removeAttr("Onclick");


            //    }
               
            //} else {
            //    TotalRecords = 0;
              
            //    $("#btnprevious").addClass("fa-disabled");
            //    $("#btnnext").addClass("fa-disabled");
            //    $("#LinkPrevious").removeAttr("Onclick");
            //    $("#LinkNext").removeAttr("Onclick");

            //}
            //Added By Dipali V On 4th Sep 2020 For Show Total Issue Count
            //Added By Usha Pandit On 17.09.2020 for IE pagination next prev button disable issue
            if (isIE() == "IE") {
                if ($("#btnprevious").hasClass("fa-disabled")) {// && $("#btnnext").hasClass("fa-disabled")) {
                    $("#btnprevious").addClass("clsPaginationEnableDisable");
                    
                }
                else {
                    $("#btnprevious").removeClass("clsPaginationEnableDisable");
                   
                }
                if ($("#btnnext").hasClass("fa-disabled")) {// && $("#btnnext").hasClass("fa-disabled")) {
                   
                    $("#btnnext").addClass("clsPaginationEnableDisable");
                }
                else {
                    
                    $("#btnnext").removeClass("clsPaginationEnableDisable");
                }
            }
            //End Of Added By Usha Pandit On 17.09.2020 for IE pagination next prev button disable issue
            //Commented By Reshma Chavan on 22nd Oct 2020 For Remove Total Records
            //$("#TotalRecords").html("");
            //$("#TotalRecords").html(TotalRecords);
             //End of Commented By Reshma Chavan on 22nd Oct 2020 For Remove Total Records
             //End of Added By Dipali V On 4th Sep 2020 For Show Total  Count
              //End of Added By  Dipali V On 2nd Sep 2020 For JDTIAC Upgarde

        }

        //Added By Usha Pandit On 17.09.2020 for IE pagination next prev button disable issue
        function isIE() {
            var brwser = '';
            var ua = navigator.userAgent, tem,
                M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
            if (/trident/i.test(M[1])) {
                tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
                //return 'IE '+(tem[1] || '');
                return 'IE';
            }
            if (M[1] === 'Chrome') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                brwser = 'CR';
            }
            else if (M[1] === 'Firefox') {
                tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
                if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
                brwser = 'FF';
            }
            M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
            if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
            //return M.join(' ');
            return brwser;
        }
        //End Of Added By Usha Pandit On 17.09.2020 for IE pagination next prev button disable issue
        function PrevList() {
            StartLoader("#AddNewResource");//Added By Dipali V On 2nd Sep for JDTIAC Upgarde
            if (intPageNo <= 1) {
                intPageNo = 1;
            }
            else {
                intPageNo -= 1;
            }
                      
             BindData();          
            
             StopAjaxLoader("#AddNewResource");//Added By Dipali V On 2nd Sep for JDTIAC Upgarde
        }
        function NextList() {
            
            StartLoader("#AddNewResource");//Added By Dipali V On 2nd Sep for JDTIAC Upgarde

            intPageNo += 1;
          
             BindData();
            
              //End of Added By  Dipali V On 2nd Sep 2020 For JDTIAC Upgarde
            StopAjaxLoader("#AddNewResource");//Added By Dipali V On 2nd Sep for JDTIAC Upgarde
           
        }

        function GetResourceDetailsCount(QueryText) {
          
            //added by dipali V On 28th Dec 2019 For Role Filter
            if (FilterRoleID == null) {
                FilterRoleID = null;
            }
            //End of added by dipali V On 28th Dec 2019 For Role Filter
            //Added By Reshma on 8th Jan 2020
            if (QueryText == null || QueryText == undefined) {
                QueryText = "";
            }
            else {
                QueryText = QueryText;
            }
            //End Added By Reshma on 8th Jan 2020

            var currentProjectId = $("#cboProjects option:selected").val();
            var resourceParameters = {
                intProjectID: currentProjectId,
                StartDate: ProjectStartDate,
                SelectedRoleID: FilterRoleID,
                QueryText: QueryText,
               
            }
           
            $.ajax({
                url: strUrl + '/api/PM_AddNewResource/GetResourceDetailsCount',
                type: "POST",
                data: JSON.stringify(resourceParameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (resourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(resourceParameters) ? resourceParameters : JSON.stringify(resourceParameters)));
                    }
                },
                success: function (data) {
                    
                    GlobalResourceAssignCount = data.length;
                },
                error: function (err) {
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            })
        }
                     
         //End of Added By Reshma Chavan on 8th Oct 2020 For JDupgrade Pagination Change

        function Role_onchange(obj) {

            StartLoader("#AddNewResource");
            FilterRoleID = obj.value;
            if (whichflag != 0) {
                if (whichflag == "") {
                    whichflag = 1;
                }
                else if (whichflag == 1) {
                    whichflag = 1;
                }

            }
            else if (whichflag == 0) {
                whichflag = 0;
            }
                    

            //alert(FilterRoleID);
            LoadDetails(whichflag, QueryText);
            StopAjaxLoader("#AddNewResource");
        }

        function FillResourceArray() {
            SelectedEmployeeIDs = String($("#RAtaglist").val());
            $("#RAtaglisthidden").val(SelectedEmployeeIDs);  
        }

        var ResourceAvaliableAllocation = 0;//Added By Dipali V On 12nd Feb 2021 For Allocation %
        function PlotAllocateResources() {
            
            var flag = 0;
            var SelectedResourceNames = "", SelectedEmployeeIDs = "";
            var ResourceList = document.getElementsByName("SelectedResources");
            $("select option").removeAttr("title");
            var objRAtaglist = document.getElementById("RAtaglist");
            $("#RAtaglist option").remove();
            
            //Commented And Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
            //for (var i = 0; i < ResourceList.length; i++) {
            //    if (ResourceList[i].checked == true) {
            //        flag = 1;
            //        alert(ResourceList[i].id);
            //        var objOptionobjRAtaglist = document.createElement("OPTION");
            //        objRAtaglist.options.add(objOptionobjRAtaglist);
            //        objOptionobjRAtaglist.text = document.getElementById("SelectedEmployeeName_" + ResourceList[i].value).value;
            //        objOptionobjRAtaglist.value = document.getElementById("SelectedEmployeeID_" + ResourceList[i].value).value;

            //        if (SelectedResourceNames == "") {
            //            SelectedResourceNames += document.getElementById("SelectedEmployeeName_" + ResourceList[i].value).value;
            //        }
            //        else {
            //            SelectedResourceNames += ',' + document.getElementById("SelectedEmployeeName_" + ResourceList[i].value).value;
            //        }
            //        if (SelectedEmployeeIDs == "") {
            //            SelectedEmployeeIDs += document.getElementById("SelectedEmployeeID_" + ResourceList[i].value).value;
            //        }
            //        else {
            //            SelectedEmployeeIDs += ',' + document.getElementById("SelectedEmployeeID_" + ResourceList[i].value).value;
            //        }
            //    }
            //}
            for (var i = 0; i < arrChecked.length; i++) {               
                flag = 1;
                var objOptionobjRAtaglist = document.createElement("OPTION");
                objRAtaglist.options.add(objOptionobjRAtaglist);
                objOptionobjRAtaglist.text = arrSelectedEmployeeNames[i];
                objOptionobjRAtaglist.value = arrSelectedEmployeeIds[i];

                if (SelectedResourceNames == "") {
                    SelectedResourceNames += arrSelectedEmployeeNames[i];
                }
                else {
                    SelectedResourceNames += ',' + arrSelectedEmployeeNames[i];
                }
                if (SelectedEmployeeIDs == "") {
                    SelectedEmployeeIDs += arrSelectedEmployeeIds[i];
                }
                else {
                    SelectedEmployeeIDs += ',' + arrSelectedEmployeeIds[i];
                }
            }
            //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
            $("#RAtaglist").val(SelectedEmployeeIDs.split(","));
           
            $("#RAtaglist").select2();
            if (flag == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select at least one Resource.");
                $("#bulkallocation").modal('hide');
                return;
            }
            else {
                $("#bulkallocation").modal('show');
            }
            //document.getElementById("RAtaglist").value = SelectedResourceNames;
            document.getElementById("RAtaglisthidden").value = SelectedEmployeeIDs;

            var selectedProjectID = document.getElementById("cboProjects").value;
            var selectedProjectName = $("#cboProjects option:selected").text();
            var objCbo1 = document.getElementById("cboProjectAdd");
            $("#cboProjectAdd option").remove();
            var objOption = document.createElement("OPTION");
            objCbo1.options.add(objOption);
            objOption.text = selectedProjectName;
            objOption.value = selectedProjectID;
            jQuery("select#cboProjectAdd option[value=" + selectedProjectID + " ]").attr("selected", "selected");

            //Added Rutuja D. 8 Jan 2020 For Binding Default Value
            var CurrentDate = $("#txtToday").val();
            $("#PlanStartDate").val(CurrentDate);
            var result = GetProjectStartDateEndDate(ProjectID);
            for (var i = 0; i < result.length; i++) {
                var ProjectEndDate = result[i].expectedenddate;
            }
            //ProjectOver = CheckProjectOver();
             //alert(ProjectOver);
            // alert(ProjectEndDate);
          
         
            if (Date.parse(ProjectEndDate) > Date.parse(CurrentDate))
            {
                ProjectEndDate = ProjectEndDate;

            } else {
             ProjectEndDate = "";

            }
            //if (ProjectOver == 1) {
            //    $("#PlanEndDate").val("");
            //}
            //else {
                $("#PlanEndDate").val(ProjectEndDate);

            //}
            //End Added Rutuja D. 8 Jan 2020 For Binding Default Value


            //Commented & added by Dipali V On 27th Dec 2019 For Reported by Dropdown Data
            //cboReportingToAdd
            //var ResourceParameters = {
            //    intProjectID: selectedProjectID
            //}
            //var param = JSON.stringify(ResourceParameters);
            //var strResult = AJAXCallWithResult("/api/PM_AddNewResource/GetReportingTo", param, false);

            //var objCboReportingTo = document.getElementById("cboReportingToAdd");
            //$("#cboReportingToAdd option").remove();

            //if (strResult.length != 0) {
            //    for (var i = 0; i < strResult.length; i++) {
            //        var ObjAccessProj = strResult[i];
            //        var objOption = document.createElement("OPTION");
            //        objCboReportingTo.options.add(objOption);
            //        objOption.text = ObjAccessProj.EmployeeName;
            //        objOption.value = ObjAccessProj.EmployeeID;
            //    }
            //}

            GetReportingToInEditMode();

            var mystring = SelectedEmployeeIDs;
            SelectedEmployeeIDs = mystring.split(",");
            if (SelectedEmployeeIDs.length > 1) {

                //$("#chkIsDefaultApprover").prop("disabled", true);
                //$("#chkIsProductOwner").prop("disabled", true);
                $("#divIsDefaultApprover").css("display", "none");
                $("#divIsProductOwner").css("display", "none");

            }
            else {
                //  $("#chkIsDefaultApprover").prop("disabled", false);
                //$("#chkIsProductOwner").prop("disabled", false);
                $("#divIsDefaultApprover").css("display", "block");
                //debugger;
                //Added By Dipali V On 11th Feb 2021 For Validate Resource Avaliable %
                ResourceAvaliableAllocation = GetAvaliableAllocation(CurrentDate, ProjectEndDate, SelectedEmployeeIDs, selectedProjectID);
                $("#txtResourcePercentage").val(ResourceAvaliableAllocation);
                //End of Added By Dipali V On 11th Feb 2021 For Validate Resource Avaliable %
              
                if (IsAgile == 1) {
                    $("#divIsProductOwner").css("display", "block");
                }
            }
            clearTooltip();
            //SelectedEmployeeIDs = "";
            $('#bulkallocation').on('hidden.bs.modal', function (e) {
                $(this)
                    .find("input,textarea,select")
                    .val('')
                    .end()
                    .find("input[type=checkbox], input[type=radio]")
                    .prop("checked", "")
                    .end();
            });
            $("#cboReportingToAdd option:selected").text("Select Reporting To");
            //$("#RAtaglist").val("");


            $("#cboProjectRoleAdd").val("");
            //$("#RAtaglist").val("");
            $("#cboProjectRoleAdd").val(0);

            //End of Commented & added by Dipali V On 27th Dec 2019 For Reported by Dropdown Data


            //Added By Reshma on 7th Jan 2020 For IssueID-21380
            var DefaultApproverID = GetDefaultApprover();
            if (DefaultApproverID != "") {
                $("#cboReportingToAdd").val(DefaultApproverID);
            }
            else {
                $("#cboReportingToAdd").val("");
            }
            //End Added By Reshma on 7th Jan 2020 For IssueID-21380

             $("#btnCreateReq").removeAttr("disabled");

        }



        $("#DivResourcelist .select2").blur(function () {
            // alert();
           
            var SelectedResourcelength = $('#RAtaglist > option').length;
            if (SelectedResourcelength > 1) {

                $("#chkIsDefaultApprover").prop("disabled", true);
                $("#chkIsProductOwner").prop("disabled", true);

            }
            else {
                $("#chkIsDefaultApprover").prop("disabled", false);
                $("#chkIsProductOwner").prop("disabled", false);
            }
        });


        //Added By Dipali V On 24th Feb 2021 For Day Wise Resource Allocation
        function GetResourceAllocation() {
            var StartDate = $("#PlanStartDate").val();
            var EndDate = $("#PlanEndDate").val();
            var selectedProjectID = $("#cboProjectAdd").val(); 
            //RAtaglisthidden
            var SelectedEmployeeIDs = $("#RAtaglist").val()
            if (SelectedEmployeeIDs.length == 1) {
                //return;
                //Added By Dipali V On 11th Feb 2021 For Validate Resource Avaliable %
                ResourceAvaliableAllocation = GetAvaliableAllocation(StartDate, EndDate, SelectedEmployeeIDs, selectedProjectID);
                $("#txtResourcePercentage").val("");
                $("#txtResourcePercentage").val(ResourceAvaliableAllocation);
                //End of Added By Dipali V On 11th Feb 2021 For Validate Resource Avaliable %
            }
        }
          //End of Added By Dipali V On 24th Feb 2021 For Day Wise Resource Allocation
        //Commented & added by Dipali V On 27th Dec 2019 For Reported by Dropdown Data
        function ResourceDetailsForIsExternal() {
            // alert(ProjectID);
            var ResourceParameters = {
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ResourceParameters);
            var strResult = AJAXCallWithResult("/api/PM_Resources/GetReportingToInEditMode", param, false);
            return strResult;
        }



        
        //Added By Dipali V On 12th Feb 2021 For Get Resource Avaliable Allocation %
        function GetAvaliableAllocation(ExpectedStartDate,ExpectedEndDate,EmployeeID,ProjectID) {
            var AvaiableReAllocation = 0;
            var Data = {
                ExpectedStartDate: encodeURI(ExpectedStartDate),
                ExpectedEndDate: encodeURI(ExpectedEndDate),
                EmployeeID: encodeURI(EmployeeID),
                ProjectID: encodeURI(ProjectID),
               
            }
                //StartLoader
                //("#BodyCreateProject");
            $.ajax({
                url: encodeURI(strUrl + '/api/PM_Resources/GetAvaliableAllocation'),
                type: "POST",
                data: JSON .stringify(Data),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (Data) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Data) ? Data : JSON.stringify(Data)));
                    }
                },
                success: function (Result) {
                    if (Result != "") {
                        AvaiableReAllocation = Result;
                    }
                },
                error: function (err) {
                    // alert("error");
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return AvaiableReAllocation;
                
        }
        //End of Added By Dipali V On 12th Feb 2021 For Get Resource Avaliable Allocation %


        function GetReportingToInEditMode() {
            var IsExternal = "";
            var ChkIsExternal = "";
            var strResult1 = ResourceDetailsForIsExternal();
            var ResourceParameters = {
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ResourceParameters);
            var strResult = AJAXCallWithResult("/api/PM_Resources/GetReportingToInEditMode", param, false);
            if (strResult != "") {
                var objCbo1 = document.getElementById("cboReportingToAdd");
                $("#cboReportingToAdd option").remove();
                $("#cboReportingToAdd optgroup").remove();
                for (var i = 0; i < strResult1.length; i++) {
                    if (strResult[i].IsExternal == null) {
                        var Objresult = strResult[i];
                        var objOption = document.createElement("OPTION");
                        objCbo1.options.add(objOption);
                        objOption.value = Objresult.EmployeeID == null ? '' : Objresult.EmployeeID;
                        objOption.text = Objresult.EmployeeName;
                    }
                    if (strResult1[i].IsExternal != null && IsExternal != strResult1[i].IsExternal) {
                        IsExternal = strResult1[i].IsExternal;
                        var objOption1 = document.createElement("optgroup");
                        $("#cboReportingToAdd").append(objOption1);
                        objCbo1.options.add(objOption1);
                        objOption1.label = IsExternal;
                        for (var j = 0; j < strResult.length; j++) {
                            ChkIsExternal = strResult[j].IsExternal;
                            if (IsExternal == ChkIsExternal) {
                                var Objresult = strResult[j];
                                var objOption = document.createElement("OPTION");
                                objCbo1.options.add(objOption);
                                objOption.value = Objresult.EmployeeID == null ? '' : Objresult.EmployeeID;
                                objOption.text = Objresult.EmployeeName;
                            }
                        }
                    }
                }

            }

        }
        //End of Commented & added by Dipali V On 27th Dec 2019 For Reported by Dropdown Data

        //Added By Reshma on 7th Jan 2020 For IssueID-21380
        //function To get Default Approver
        function GetDefaultApprover() {
            var SelectedProjectID = document.getElementById("cboProjectAdd").value;
            var ProjectID = SelectedProjectID;
            var param = JSON.stringify(ProjectID);
            var strResult = AJAXCallWithResult("/api/PM_AddNewResource/GetDefaultApprover", param, false);
            if (strResult != undefined) {
                var GetDefaultApprover = strResult;
                return GetDefaultApprover;
            }
        }
        //End Added By Reshma on 7th Jan 2020 For IssueID-21380

        //Added By Reshma on 8th Jan 2020 For IssueID-21200
        //click on back button
        function BackResources_Onclick() {
            window.location.href = "PM_Resources.aspx?ProjectID=" + ProjectID + "&ProjectName=" + m_SelectedProjectName + "";

        }
        //End Added By Reshma on 8th Jan 2020 For IssueID-21200

        //Function for Validation dates
        var TentativeDateOfRelieving = "";
        var ResourceJoiningDate = "";
        function ValidateDates(ExpectedStartDate, ExpectedEndDate) {
           
            var checkval = 0;
            var result = GetProjectStartDateEndDate(ProjectID);

            for (var i = 0; i < result.length; i++) {
                var ObjDate = result[i];

                if (Date.parse(ObjDate.expectedStartdate) < Date.parse(ExpectedStartDate) && Date.parse(ObjDate.expectedenddate) < Date.parse(ExpectedEndDate)) {
                    //Commented & Added By Rutuja D. 8 Jan 2020 For Change Alert
                    //alertify.error("Start Date and End Date should be between the Project Start Date " + result[i].expectedStartdate + " And End Date " + result[i].expectedenddate + "");
                    alertify.error("Planned Start Date and Planned End Date should be between the Project Start Date " + result[i].expectedStartdate + " And End Date " + result[i].expectedenddate + "");
                    //End Commented & Added By Rutuja D. 8 Jan 2020 For Change Alert
                    $("#PlanEndDate").focus();
                    checkval = 1;
                }
                else if (Date.parse(ObjDate.expectedenddate) < Date.parse(ExpectedStartDate)) {
                    //Commented & Added By Rutuja D. 8 Jan 2020 For Change Alert
                    //alertify.error("Start Date should not be greater than 'Project End Date " + result[i].expectedenddate + "");
                    alertify.error("Planned Start Date should not be greater than 'Project End Date " + result[i].expectedenddate + "");
                    $("#PlanStartDate").focus();
                    checkval = 1;
                }
                 
                else if (Date.parse(ObjDate.expectedStartdate) > Date.parse(ExpectedStartDate)) {
                    //Commented & Added By Rutuja D. 8 Jan 2020 For Change Alert
                    //alertify.error("Start Date should not be less than 'Project Start Date " + result[i].expectedStartdate + "");
                    alertify.error("Planned Start Date should not be less than 'Project Start Date " + result[i].expectedStartdate + "");
                    //End Commented & Added By Rutuja D. 8 Jan 2020 For Change Alert
                    $("#PlanStartDate").focus();
                    checkval = 1;
                }
                else if (Date.parse(ObjDate.expectedenddate) < Date.parse(ExpectedEndDate)) {
                    //Commented & Added By Rutuja D. 8 Jan 2020 For Change Alert
                    //alertify.error("End Date should not be greater than 'Project End Date " + result[i].expectedenddate + "");
                    alertify.error("Planned End Date should not be greater than 'Project End Date " + result[i].expectedenddate + "");
                    //End Commented & Added By Rutuja D. 8 Jan 2020 For Change Alert

                    $("#PlanEndDate").focus();
                    checkval = 1;
                }

                else if (Date.parse(ObjDate.expectedStartdate) > Date.parse(ExpectedEndDate)) {
                    //Commented & Added By Rutuja D. 8 Jan 2020 For Change Alert
                    //alertify.error("End Date should not be less than 'Project Start Date " + result[i].expectedStartdate + "");
                    alertify.error("Planned End Date should not be less than 'Project Start Date " + result[i].expectedStartdate + "");
                    //End Commented & Added By Rutuja D. 8 Jan 2020 For Change Alert

                    $("#PlanEndDate").focus();
                    checkval = 1;
                }
                else if (Date.parse(ExpectedStartDate) > Date.parse(ExpectedEndDate)) {
                    //Commented & Added By Rutuja D. 8 Jan 2020 For Change Alert
                    //alertify.error("Start Date should not be greater than End date " + ExpectedEndDate + "");
                    alertify.error("Planned Start Date should not be greater than Planned End date " + ExpectedEndDate + "");
                    //End Commented & Added By Rutuja D. 8 Jan 2020 For Change Alert

                    $("#PlanStartDate").focus();
                    checkval = 1;
                }
                //else if (Date.parse(ExpectedEndDate) > Date.parse(TentativeDateOfRelieving)) {
                //    alertify.error("Resource End Date On Project should Be less than Resource Tentative Relieving Date " + TentativeDateOfRelieving + "");
                //    $("#PlanEndDate").focus();
                //    checkval = 1;
                //}
                //else if (Date.parse(ExpectedStartDate) < Date.parse(ResourceJoiningDate)) {
                //    alertify.error("Resource Start Date On Project should not be less than Resource Joining Date " + ResourceJoiningDate + "");
                //    $("#PlanStartDate").focus();
                //    checkval = 1;
                //}           
                else {
                    checkval = 0;
                }
            }
            return checkval;
        }

        //Get Project Start And End Date
        function GetProjectStartDateEndDate(ProjectID) {
            var param = JSON.stringify(ProjectID);
            var result = AJAXCallWithResult("/api/PM_Resources/GetProjectStartDateEndDate", param, false);
            if (result != undefined) {
                return result;
            }
        }


        function GetProjectOU(ProjectID) {
            //var strResult = "";
            //var param = JSON.stringify(ProjectID);
            //var result = AJAXCallWithResult("/api/PM_AddNewResource/GetProjectOU", param, false);
            // if (result != undefined)
            // { 
            //     for (var i = 0; i < result.length; i++)
            //     {
            //         var strResult = result[i].OU;
            //     }
            // }

            var RequestParameters = {
                RequestType: encodeURI($("#cbotype").val()),
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(RequestParameters);
            var strResult1 = AJAXCallWithResult("/api/PM_RequestedResources/GetMaxUnits", param, false);
            var m_strMaxUnits = strResult1;
            return m_strMaxUnits;
        }
        //Get Resource Joining and Reliving Date
        function GetResourceTentativeDateOfRelieving(NewProjectEmployeeRoleID) {
            var ResourceParameters = {
                ProjectEmployeeRoleID: encodeURI(NewProjectEmployeeRoleID),
            }
            var param = JSON.stringify(ResourceParameters);
            var result = AJAXCallWithResult("/api/PM_Resources/GetResourceTentativeDateOfRelieving", param, false);
            if (result != "") {
                return result;
            }
        }
        function cancelallocation() {
           
            SelectedEmployeeIDs = "";
            arrChecked = [];
            //Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
            arrSelectedEmployeeNames = [];
            arrSelectedEmployeeIds = [];
            //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
            $('#bulkallocation').on('hidden.bs.modal', function (e) {
                $(this)
                    .find("input,textarea,select")
                    .val('')
                    .end()
                    .find("input[type=checkbox], input[type=radio]")
                    .prop("checked", "")
                    .end();
            });
            $("#cboReportingToAdd option:selected").text("Select Reporting To");
            $("#RAtaglist").val("");

            $("#RAtaglisthidden").val("");
            $(".chcktbl").prop("checked", false);
            $("#bulkallocation").modal('hide');
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }



        function Allocate_OnClick() {
            var checkval = 0;
            var IsResourceBillable = 0;
            var IschkIsDefaultApprover = 0;
            var IschkIsProductOwner = 0;
            var SelectedProjectID = document.getElementById("cboProjectAdd").value;
            var SelectedRoleID = document.getElementById("cboProjectRoleAdd").value;
            var SelectedStartDate = document.getElementById("PlanStartDate").value;
            var SelectedEndDate = document.getElementById("PlanEndDate").value;
            var WorkHrs = document.getElementById("txtALWorkHrs").value;
            var ResourcePercentage = document.getElementById("txtResourcePercentage").value;
            var ReportingTo = document.getElementById("cboReportingToAdd").value;
            var ResourceStatus = document.getElementById("cboResourceStatusAdd").value;
            var Responsibility = document.getElementById("txtResponsibility").value;
            var SelectedResources = $("#RAtaglist").val();

              var strmsg="";
            //alert(SelectedResources);
            if (SelectedResources == null) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select at least one Resource.");
                $("#RAtaglist").focus();//ADDED BY DIPALI V ON 27TH DEC 2019 FOR FOCUS ON CONTROL
                $("#bulkallocation").removeAttr("data-bs-dismiss", "modal");
                return;
            }
            if (SelectedRoleID == '0') {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Project Role should not be left blank.");
                $("#cboProjectRoleAdd").focus();//ADDED BY DIPALI V ON 27TH DEC 2019 FOR FOCUS ON CONTROL
                return;
            }
            if (SelectedStartDate == '') {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error("Plan Start Date should not be left blank.");

                //Added By Rutuja D. 13 Jan 2020 For Wrong Alert
               // alertify.error('Plan Start Date  should not be left blank.');
                alertify.error('Planned Start Date  should not be left blank.');
                //End Added By Rutuja D. 13 Jan 2020 For Wrong Alert

                $("#PlanStartDate").focus();//ADDED BY DIPALI V ON 27TH DEC 2019 FOR FOCUS ON CONTROL
                return;
            }
            if (SelectedEndDate == '') {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.error("Plan End Date should not be left blank.");
                //Added By Rutuja D. 13 Jan 2020 For Wrong Alert
               // alertify.error('Plan End Date should not be left blank.');
                alertify.error('Planned End Date should not be left blank.');

                //End Added By Rutuja D. 13 Jan 2020 For Wrong Alert

                $("#PlanEndDate").focus();//ADDED BY DIPALI V ON 27TH DEC 2019 FOR FOCUS ON CONTROL
                return;
            }

            if (SelectedStartDate != "" || SelectedEndDate != "") {
                var Datecheckval = ValidateDates(SelectedStartDate, SelectedEndDate);
                if (Datecheckval == 0) {
                    checkval = 0;
                } else {
                    checkval = 1;
                }
            }

            //Commented & Added By RUtuja D. 8 Jan 2020 For Not Allowed Space Also 
            //if (ResourcePercentage == '' && checkval == 0) {
            if (isBlank(ResourcePercentage) && checkval == 0) {
                //Commented & Added By RUtuja D. 8 Jan 2020 For Not Allowed Space Also 
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('% Allocation should not be left blank');
                $("#txtResourcePercentage").focus();//ADDED BY DIPALI V ON 27TH DEC 2019 FOR FOCUS ON CONTROL
                checkval = 1;
                return;
            }

            if (checkSpecialCharacter(ResourcePercentage) == true && checkval == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('% Allocation cannot contain any of these {}|`~[]<>\:!"@#$%^&*()_+-=/ Characters');
                $("#txtResourcePercentage").focus()
                checkval = 1;
                return;
            }

            // if (ResourcePercentage != '' && checkval == 0) {
            //    if (ResourcePercentage ==  0) {
            //        alertify.set('notifier', 'position', 'top-right');
            //        alertify.error('% Allocation should be greater than 0');
            //        $("#txtResourcePercentage").focus();//ADDED BY DIPALI V ON 27TH DEC 2019 FOR FOCUS ON CONTROL
            //        checkval = 1;
            //        return;
            //    }
            //}

            if (ResourcePercentage != '' && checkval == 0) {
                if (ResourcePercentage < 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('% Allocation should be positive value');
                    $("#txtResourcePercentage").focus();//ADDED BY DIPALI V ON 27TH DEC 2019 FOR FOCUS ON CONTROL
                    checkval = 1;
                    return;
                }
                //Added By Usha Pandit On 01.07.2020 For correct validation for Resource percentage
                if (ResourcePercentage == 0) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Resource percentage should be greater than 0');
                    $("#txtResourcePercentage").focus();
                    checkval = 1;
                    return;
                }
                //End Of Added By Usha Pandit On 01.07.2020 For correct validation for Resource percentage
                 //Added By Dipali V On 12nd Feb 2021 For Validate Resource Avaliable %
                //debugger;
                if (parseFloat($('#txtResourcePercentage').val()) != "") {
                    if (ResourceAvaliableAllocation != "") {
                        if (parseFloat($('#txtResourcePercentage').val()) > parseFloat(ResourceAvaliableAllocation)) {
                            alertify.error('Resource Avaliable Allocation % ' + ResourceAvaliableAllocation);
                            $('#txtResourcePercentage').focus();
                            checkval = 1;
                            return;
                        }
                    }
                }
                 //End of Added By Dipali V On 12nd Feb 2021 For Validate Resource Avaliable %
               

            }

        
            if (ReportingTo == '' && checkval == 0) {
                if (CheckReportingTo() == 1) {
                 //Added by Chetan M on 10th Jan 2020
                    if (GetCountOfResources() > 0) {
                 //End of addtion by Chetan M on 10th Jan 2020
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error("Reporting To should not be left blank.");
                    $("#cboReportingToAdd").focus();//ADDED BY DIPALI V ON 27TH DEC 2019 FOR FOCUS ON CONTROL
                    checkval = 1;
                    return;
               //Added by Chetan M on 10th Jan 2020
                    }                   
               //End of addtion by Chetan M on 10th Jan 2020
                }


            }

            if (ResourceStatus == '' && checkval == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Status should not be left blank.");
                $("#cboResourceStatusAdd").focus();//ADDED BY DIPALI V ON 27TH DEC 2019 FOR FOCUS ON CONTROL
                checkval = 1;
                return;
            }



            if (WorkHrs == "" && checkval == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("A_WorkHrs") %>');
                $('#txtALWorkHrs').focus();
                checkval = 1;
                //Added By Rutuja D. 8 Jan 2020 For Display Multiple alert at time
                return;
                //End Added By Rutuja D. 8 Jan 2020 For Display Multiple alert at time

            }
          
            if (WorkHrs != '' && checkval == 0) {
                var result = WorkHoursValidation("txtALWorkHrs");
                if (result == true) {
                    checkval = 0;
                } else {
                    checkval = 1;
                }
            }

            if (checkval == 0) {

                if ($('#chkIsResourceBillable').is(":checked")) {
                    IsResourceBillable = 1;
                }
                else {
                    IsResourceBillable = 0;
                }

                if ($('#chkIsDefaultApprover').is(":checked")) {
                    IschkIsDefaultApprover = 1;
                }
                else {
                    IschkIsDefaultApprover = 0;
                }

                if (IsAgile == 1 || IsAgile != undefined) {
                    if ($('#chkIsProductOwner').is(":checked")) {
                        IschkIsProductOwner = 1;
                    }
                    else {
                        IschkIsProductOwner = 0;
                    }
                }
            }

            //if (WorkHrs.indexOf(":") == -1) {
            //    WorkHrs = WorkHrs;
            //} else {
            //    objWorkHoursOldVal = WorkHrs.split(":");
            //    WorkHrs = objWorkHoursOldVal[0];
            //}


            //added by Chetan M on 13rd Jan 2020
            if (WorkHrs.indexOf(":") > -1) {
                WorkHrs = WorkHrs;
            } else {
                WorkHrs = WorkHrs + ":00";
                //objWorkHoursOldVal = WorkHrs.split(":");
                //WorkHrs = objWorkHoursOldVal[0];
            }
             //End of added by Chetan M on 13rd Jan 2020


            var resourceParameters = {
                SelectedProjectID: SelectedProjectID,
                SelectedRoleID: SelectedRoleID,
                ExpectedStartDate: SelectedStartDate,
                ExpectedEndDate: SelectedEndDate,
                ResourcePercentage: ResourcePercentage,
                ReportingTo: ReportingTo,
                WorkHrs: WorkHrs,
                IsResourceBillable: IsResourceBillable,
                IschkIsDefaultApprover: IschkIsDefaultApprover,
                IschkIsProductOwner: IschkIsProductOwner,
                ResourceStatus: ResourceStatus,
                Responsibility: Responsibility,
                SelectedResources: $("#RAtaglisthidden").val()
            }
            if (checkval == 0) {
                //Commented By Dipali V On 5th March 2021 For Invalid alert Comme
                var param = JSON.stringify(resourceParameters);
                //var strValidation = AJAXCallWithResult("/api/PM_AddNewResource/ValidateResourceAllocation", param, false);
                //if (strValidation != "") {
                //    //alertify.set('notifier', 'position', 'top-right');
                //    //alertify.error(strValidation);
                //    //return;
                //    checkval = 0;
                //}
               // else {
                //End of Commented By Dipali V On 5th March 2021 For Invalid alert Comme
                    StartLoader("#AddNewResource");
                    var strResult = AJAXCallWithResult("/api/PM_AddNewResource/AllocateResources", param, false);
                    //alert(strResult);

                //Modified by Nikhil A on 1-March-2022
                if (strResult != undefined) {
                    if (strResult == 'SUCCESS') {
                        StopAjaxLoader("#AddNewResource");
                        alertify.set('notifier', 'position', 'top-right');
                        //Commented and added by Chetan M on 12th Jan 2020 for ISssue ID 21294
                        //alertify.success("Resource(s) allocated  on Project successfully.");
                        setTimeout(function () {
                            alertify.success("Resource(s) allocated  on Project successfully.");
                        }, 2000);
                    }
                     if (strResult != "SUCCESS") {
                            if (strResult.charAt(strResult.trim().length - 1) == ",") {
                            strResult = strResult.substr(0, strResult.trim().length - 1);
                         }
                        
                        var EmpName = strResult.split(',');
                        
                        if (EmpName.length >=0) {
                            for (var i = 0; i <= EmpName.length - 1; i++) {
                                 //strmsg = strmsg + EmpName[i] + "\n";
                                strmsg += EmpName[i] + "<br>";
                                
                            }
                            strmsg += "can not be added to project as their Project End date is greater than Tentative leaving date";
                        }
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error(strmsg);
                            StopAjaxLoader("#AddNewResource");
                    }
                    //End Of Added By Nikhil A on 1-March-2022
                    //End of Commented and added by Chetan M on 12th Jan 2020 for ISssue ID 21294
                    cancelallocation();
                    objWorkHoursOldVal = "";
                    arrChecked = [];
                    //Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                    arrSelectedEmployeeNames = [];
                    arrSelectedEmployeeIds = [];
                    //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                    LoadDetails(whichflag, null);
                    $("#bulkallocation").modal('hide');
                    StopAjaxLoader("#AddNewResource");
                }
               
                 StopAjaxLoader("#AddNewResource");
                
                //}
                //End of Commented By Dipali V On 5th March 2021 For Invalid alert Comme
            }
            //}
        }

        //Added by Chetan M on 10th Jan 2020
        function GetCountOfResources() {           
                     var param = JSON.stringify(ProjectID);
            var Count = AJAXCallWithResult("/api/PM_AddNewResource/GetCountOfResources", param, false);
            return Count;
        }
        //End of added by Chetan M on 10th Jan 2020

        //Function for Work Hrs Validation
        function WorkHoursValidation(ControlID) {
            var objHMEffort = document.getElementById(ControlID);
            var objVal = objHMEffort.value;
            var objOldVal = objHMEffort.value;
            objWorkHoursOldVal = objHMEffort.value;
            if (objHMEffort.value != "") {

                objHMEffort.value = objHMEffort.value.replace(":", ".");
                var isdigit = isNumeric(objHMEffort.value);
                objHMEffort.value = objOldVal;
                if (isdigit == false) {
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_PositiveNumericForNewAllocation") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_PositiveNumericWork") %>');
                    }
                    setFocus(objHMEffort);
                    return false;
                }

                var mm = objVal.split(":")[1];
                if (mm == "") {
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAlloHMFormat") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HMFormat") %>');
                    }
                    setFocus(objHMEffort);
                    return false;
                }

                if (objVal.indexOf(":") == -1) {
                    objHMEffort.value = objVal + ":00";
                    objVal = objHMEffort.value;
                }
                if (objHMEffort.value.indexOf(":") == -1) {
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAlloHMFormat") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HMFormat") %>');
                    }
                    setFocus(objHMEffort);
                    return false;
                }
                if (objHMEffort.value.indexOf(":") != -1) {
                    objHMEffort.value = objHMEffort.value.replace(':', '.');
                }

                var blnResult = disallowSpecialCharacters(objHMEffort);
                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAlloHMFormat") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HMFormat") %>');
                    }
                    setFocus(objHMEffort);
                    return false;
                }

                blnResult = disallowNonNumeric(objHMEffort);
                if (blnResult == true) {
                    objHMEffort.value = objOldVal;
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAlloHMFormat") %>');
                     }
                     else {
                         alertify.error('<%= MyBase.GetResourceString("A_HMFormat") %>');
                    }
                    setFocus(objHMEffort);
                    return false;
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
                if (hrs.indexOf("-") != -1) {
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_HoursNotZeroForNewAllocation") %>');
                    }
                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HoursNotZero") %>');
                    }
                    setFocus(objHMEffort);
                    return false;
                }
                if (hrs <= 0 && mins <= 0) {
                    if (ControlID == 'txtExtResourceNewAllocation') {
                        alertify.error('<%= MyBase.GetResourceString("A_NewAllocationGraterzero") %>');
                    }

                    else {
                        alertify.error('<%= MyBase.GetResourceString("A_HoursNotZero") %>');
                    }
                    setFocus(objHMEffort);
                    return false;
                }

                if (mins.length > 2) {
                    alertify.error("<%= MyBase.GetResourceString("A_MinInTwoDecimal") %>");
                    setFocus(objHMEffort);
                    return false;
                }


                if (mins > 59 || mins < 0) {

                    alertify.error("<%= MyBase.GetResourceString("A_MinInRange") %>");
                    setFocus(objHMEffort);
                    return false;
                }

                //GetRestrictByMinHours_MinHoursForDAEntry()              
                var strResult = AJAXCallWithResult("/api/PM_Resources/GetRestrictByMinHours_MinHoursForDAEntry", '', false);

                if (strResult != undefined) {
                    RestrictByMinHours = strResult.RestrictByMinHours;
                    MinHoursForDAEntry = strResult.MinHoursForDAEntry;
                }

                var MinDAENtryDisplay = "";
                var objMinWorkHrs = MinHoursForDAEntry;

                var MinDAEntry = objMinWorkHrs;

                var objRestrictByMinHours = RestrictByMinHours;


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
                if (objRestrictByMinHours == true) {
                    if (MinDAEntry == 0.016) {
                    }
                    else {
                        var minutes = WorkHour.split(':');

                        var p = minutes[0];
                        var dec = minutes[1];

                        if (dec.length > 2) {
                            dec = dec.substring(0, 2);
                        }
                        if (dec.length == 1) {
                            dec = dec + "0";
                        }
                       
                        if (dec == undefined) { dec = 0; }
                        d = (dec - 0) / 60 + (p - 0);

                        if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                            if (ControlID == 'txtExtResourceNewAllocation') {
                                alertify.error("Please enter the New Allocation in multiple of (" + MinDAENtryDisplay + ") min");

                            }

                            else {
                                alertify.error("Please Enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");

                            }
                            setFocus(objHMEffort);
                            return false;
                        }
                    }
                }

            }
            return true;
        }

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

        //Added by Chetan M on 14th Jan 2020
        var GblControlID = "";
        //End of Added by Chetan M on 14th Jan 2020
        //added by dipali v on 29th Dec For Save Request of resource 
        function Request_onClick(FromWhereFlag) {
          
            var checkval = 0;


          //UnCommented by Chetan M on 14th Jan 2020 for issueid = 21225
            if ($("#cboRRProjectRoleAdd").val() == "0") {
                alertify.error("Project Role Should not be left blank.");
                //Added by Chetan M on 14th Jan 2020
                GblControlID = "#cboRRProjectRoleAdd";
                //End of Added by Chetan M on 14th Jan 2020
                $("#cboRRProjectRoleAdd").focus();
                checkval = 1;
                return false;
            }
            //End of UnCommented by Chetan M on 14th Jan 2020 for issueid = 21225

            //if (checkval != 1) {
            if ($("#txtnoofresource").val() == "") {
                alertify.error("<%= MyBase.GetResourceString("C_A_NoofResource") %>");
                $("#txtnoofresource").focus();
                //Added by Chetan M on 14th Jan 2020
                GblControlID = "#txtnoofresource";
                //End of Added by Chetan M on 14th Jan 2020
                checkval = 1;
                return false;

            }
            //}

            //if (checkval != 1) {
            //    if ($("#txtnoofresource").val() == "0") {
            //        alertify.error("The value of No. Of Resources should be greater than 0.");
            //        $("#txtnoofresource").focus();
            //        checkval = 1;
            //        return false;
            //    }
            //}



            if (checkval != 1) {
                if ($("#txtnoofresource").val() != "") {
                    var value = $("#txtnoofresource").val();
                    var num = parseInt(value);
                    if (num < 1 || num > 999) {
                        alertify.error("The value of 'No. Of Resources' should be in the range of (1 - 999).");
                        $("#txtnoofresource").focus();
                        //Added by Chetan M on 14th Jan 2020
                        GblControlID = "#txtnoofresource";
                        //End of Added by Chetan M on 14th Jan 2020
                        checkval = 1;
                        return false;
                    }
                }
            }

            if (checkval != 1) {
                if ($("#RRstartdt").val() == "") {
                    alertify.error("<%= MyBase.GetResourceString("A_RRstartdt") %>");
                    $("#RRstartdt").focus();
                    //Added by Chetan M on 14th Jan 2020
                        GblControlID = "#RRstartdt";
                        //End of Added by Chetan M on 14th Jan 2020
                    checkval = 1;
                    return false;

                }
            }

            if (checkval != 1) {
                if ($("#RRenddt").val() == "") {
                    alertify.error("<%= MyBase.GetResourceString("A_RRTodt") %>");
                    $("#RRenddt").focus();
                    //Added by Chetan M on 14th Jan 2020
                        GblControlID = "#RRenddt";
                        //End of Added by Chetan M on 14th Jan 2020
                    checkval = 1;
                    return false;

                }
            }

         
            //if ($("#RRstartdt").val() != "" || $("#RRenddt").val() != "") {
            //    var Datecheckval = ValidateWithProjectDates($("#RRstartdt").val(), $("#RRenddt").val());
            //    if (Datecheckval == 0) {
            //        checkval = 0;
            //        //return false;
            //    } else {
            //        checkval = 1;
            //        return false;
            //    }
            //}
            //Commented By Rutuja D 10 Jan 2020 For Wrong Alert Sequence


            

            if (checkval != 1) {
                if ($("#cbotype").val() == "0") {
                    alertify.error("Allocation Unit Should not be left blank");
                    $("#cbotype").focus();
                     //Added by Chetan M on 14th Jan 2020
                    GblControlID = "#cbotype";
                    return false;
                     //End of Added by Chetan M on 14th Jan 2020     
                    checkval = 1;
                    return false;

                }
            }



           //UnCommented by Chetan M on 13th Jan 2020 for issueid = 21225
           if (checkval != 1) {
                if ($("#txtRWorkHours").val() == "") {
                    <%--//alertify.error("<%= MyBase.GetResourceString("A_RWorkHours") %>");--%>
                    alertify.error("Work Hours should not be left blank.");
                    $("#txtRWorkHours").focus();
                    //Added by Chetan M on 14th Jan 2020
                        GblControlID = "#txtRWorkHours";
                        //End of Added by Chetan M on 14th Jan 2020
                    checkval = 1;
                    return false;

                }
            }
            //Added By Riddhesh Patil on 15-NOV-2022 

            if (checkval != 1) {
                if (checkSpecialCharacter($("#txtSpecialRequest").val(), WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Special Request should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                     $("#txtSpecialRequest").focus();
                        chkval = 1;
                        return chkval;
                    }
            }
            //End of Comment Added By Riddhesh Patil
            //End of uncommented by Chetan M on 13th Jan 2020 for issueid = 21225


            // if (checkval != 1) {
            //    if ($("#txtRWorkHours").val() != "") {
            //        var value = $("#txtRWorkHours").val();
            //        var num = parseInt(value);
            //        if (num < 0 || num > 100)
            //        {
            //            alertify.error("Resource Work Hours should be in the range of 1-100");
            //            $("#txtRWorkHours").focus();
            //            checkval = 1;
            //            return false;
            //        }

            //    }
            //}

            //if (checkval != 1) {
            //    if ($("#cbotype").val() == "HPD") {
            //        if ($("#txtRWorkHours").val() != "") {
            //           
            //            var RWH = $("#txtRWorkHours").val();
            //            var result = GetProjectOU(ProjectID);
            //            if (parseInt(result) < parseInt(RWH))
            //            {
            //                alertify.error("Work hours can not be greater than the company work hours " + result);
            //                $("#txtRWorkHours").focus();
            //                checkval = 1;
            //                return false;

            //            } else
            //            {
            //                checkval = 0;
            //            }

            //        }
            //    }

            //}
            //return;

             //End Commented By Rutuja D 10 Jan 2020 For Wrong Alert Sequence
            //2020
            //if ($("#txtRWorkHours").val() != '' && checkval == 0) {
            if ($("#txtRWorkHours").val() != '' && checkval == 0 && $("#cbotype").val() != 'P') {
                 //2020
                var result = WorkHoursValidation("txtRWorkHours");
                if (result == true) {
                    checkval = 0;
                } else {
                    checkval = 1;
                    //Added by Chetan M on 14th Jan 2020
                    GblControlID = "#txtRWorkHours";
                    return false;
                     //End of Added by Chetan M on 14th Jan 2020      
                }
            }
            //Added By Usha Pandit On 14.02.2020 For work hour validation issue
            if ($("#txtRWorkHours").val() != '' && checkval == 0 && $("#cbotype").val() == 'P') {                
                var objEffort = document.getElementById("txtRWorkHours");
                blnResult = disallowNonNumeric(objEffort);
                if (blnResult == true) {
                    
                    
                    alertify.error('Please enter work hours in numeric format');
                    
                    setFocus(objEffort);
                    checkval = 1;
                    //Added by Chetan M on 14th Jan 2020
                    GblControlID = "#txtRWorkHours";
                    return false;
                }
            }
            //End Of Added By Usha Pandit On 14.02.2020 For work hour validation issue


            // Added By Rutuja D. 10 Jan 2020 For Work Hours Validation 
          
            if (checkval != 1) {
                var WorkHours = $("#txtRWorkHours").val();
                var ResourceType = $("#cbotype").val();
                var NoOfResources = $("#txtnoofresource").val();




                if (WorkHours != "") {
                    var ProjectID = $("#cboProjects").val();
                    if (WorkHours.indexOf(':') > -1) {
                        var RequestParameters = {
                            WorkHrs: encodeURI(WorkHours),
                            Flag: encodeURI(2),
                        }
                        var param = JSON.stringify(RequestParameters);
                        var WorkHours = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                    } else {
                        WorkHours = WorkHours;
                    }
                    RequestParameters = {
                        ProjectID: encodeURI(ProjectID),
                    }

                    var param = JSON.stringify(RequestParameters);
                    var ProjectBalHrs = AJAXCallWithResult("/api/PM_RequestedResources/GetProjectBalHrs", param, false);

                    var param = JSON.stringify(RequestParameters);
                    var intWorkHours = AJAXCallWithResult("/api/PM_RequestedResources/GetLocationWorkingHours", param, false);

                    var param = JSON.stringify();
                    var objResPer = AJAXCallWithResult("/api/PM_RequestedResources/GetresourceHrs", param, false);

                    maxhrs = parseFloat(intWorkHours) * parseInt(objResPer) / 100;
                    var fltTotalWorkHrs = parseFloat(WorkHours) * parseFloat(NoOfResources);

                    if (ResourceType == 'TH') {
                        if (ProjectBalHrs != null || ProjectBalHrs != undefined || ProjectBalHrs != '') {
                            if (parseFloat(ProjectBalHrs) < parseFloat(fltTotalWorkHrs)) {
                                alertify.error("<%= MyBase.GetResourceString("A_TotalWorkHours") %> " + ProjectBalHrs);
                                $('#txtRWorkHours').focus();
                                 //Added by Chetan M on 14th Jan 2020
                                 GblControlID = "#txtRWorkHours";
                                 return false;
                                  //End of Added by Chetan M on 14th Jan 2020     
                                checkval = 1;
                                return false;
                            }
                            else {
                                checkval = 0;
                            }

                        }
                    }
                    else if (ResourceType == 'HPD') {

                      //  var RequestParameters = {
                      //      WorkHrs: encodeURI(maxhrs),
                      //      Flag: encodeURI(1),
                      //  }
                      //  var param = JSON.stringify(RequestParameters);
                      //  var NewAllocationValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                      //var maxhrsHPD = NewAllocationValue
                          if (maxhrs.toString().indexOf(".") != -1) {
                           var  maxhrsHPD = maxhrs;
                        } else {
                           var maxhrsHPD = maxhrs + '.00';
                        }
                        if (parseFloat(WorkHours) > parseFloat(maxhrsHPD)) {
                            alertify.error('Work hours cannot be greater than the company work hours ' + maxhrs);
                            $('#txtRWorkHours').focus();
                             //Added by Chetan M on 14th Jan 2020
                                GblControlID = "#txtRWorkHours";
                                return false;
                                 //End of Added by Chetan M on 14th Jan 2020     
                            checkval = 1;
                            return false;
                        }
                        else {
                            checkval = 0;
                        }
                    }
                    else if (ResourceType == 'P') {


                       // var RequestParameters = {
                       //     WorkHrs: encodeURI(objResPer),
                       //     Flag: encodeURI(1),
                       // }
                       // var param = JSON.stringify(RequestParameters);
                       // var NewAllocationValue = AJAXCallWithResult("/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                       //var objResPerP = NewAllocationValue
                         if (objResPer.toString().indexOf(".") != -1) {
                         var objResPerP = objResPer;
                        } else {
                          var objResPerP = objResPer + '.00';
                        }
                        if (parseFloat(WorkHours) > parseInt(objResPerP)) {
                            alertify.error("<%= MyBase.GetResourceString("A_ResourcepercentageRange") %>" + objResPer);
                            $('#txtRWorkHours').focus();
                             //Added by Chetan M on 14th Jan 2020
                             GblControlID = "#txtRWorkHours";
                             return false;
                              //End of Added by Chetan M on 14th Jan 2020     
                            checkval = 1;
                            return false;
                        }
                        else {
                            checkval = 0;
                        }
                    }
                    else {
                        checkval = 0;
                    }
                }
            }



            //End Added By Rutuja D. 10 Jan 2020 For Work Hours Validation 



            //if (checkval != 1) {

            //    if ($("#cboResourcePools").val() == "") {
            //        alertify.error("Resource Pool should not be left blank");
            //        $("#cboResourcePools").focus();
            //        checkval = 1;
            //        return false;

            //    }
            //}
           
            if (ResourcePoolIsMandatory == 1) {      //Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory That Time Show Alert         
                if (checkval != 1) {

                    //if ($("#cboResourcePools").val() == "") {
                    if ($("#cboResourcePools").val() == "0" || $("#cboResourcePools").val() == 0) {
                        alertify.error("Resource Pool should not be left blank");
                        $("#cboResourcePools").focus();
                        //Added by Chetan M on 14th Jan 2020
                        GblControlID = "#cboResourcePools";
                        //End of Added by Chetan M on 14th Jan 2020
                        checkval = 1;
                        return false;

                    }
                } else {
                    checkval = 0;
                    return true;
                }
            }             //End Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory That Time Show Alert
            if (checkval == 0) {
              
                //var RequestParameters = {
                //    UserName: UserName,
                //    UserID: UserID,
                //    RequestDate: Today,
                //    SelectedProjectID: document.getElementById("cboProjects").value,
                //    SelectedRoleID: $("#cboRRProjectRoleAdd").val(),
                //    FromDate: $("#RRstartdt").val(),
                //    ToDate: $("#RRenddt").val(),
                //    NoOfResource: $("#txtnoofresource").val(),

                //    WorkHrs: $("#txtRWorkHours").val(),
                //    Type: $("#cbotype").val(),
                //    ResourcePool: $("#cboResourcePools").val(),
                //    Priority: $("#cboRPriority").val(),
                //    SpecialRequest: $("#txtSpecialRequest").val(),

                //}
                ////StartLoader("#AddNewResource");
                //var param = JSON.stringify(RequestParameters);
                //var StrResult = AJAXCallWithResult("/api/PM_AddNewResource/RequestResource", param, false);
               
                //if (StrResult != "") {

                //    $("#RequestAddconfirm").modal('show');
                //    //cancelRequest();
                //    GlobalrequestID = StrResult;
                //    //  GetRequestSkillDetails(GlobalrequestID)
                //    // $("#resourcerequest").modal('hide');
                //    //alert(GlobalrequestID);

                //}
               
                if (FromWhereFlag == 0) {

                    AddSkill();
                }
                else {
                    //    if ($("#idSkill").hasClass("active"))
                    //    {
                    if (checkval == 0 || checkval==true) {

                        //$("#cboRRProjectRoleAdd").focus();
                    } else {
                        //$("#idReqDetails").addClass("active");
                        //$("#idSkill").removeClass("active");
                        //$("#Rskillsettab").removeClass("active");
                        //$("#Rrequesttab").addClass("active");
                    }
                    //}

                }
            }
            
            if (checkval == 0) {
                checkval = true;
            } else {
                checkval = false;
            }
            return checkval;
        }


        function CreateRequest()
        {
           
             var RequestParameters = {
                    UserName: UserName,
                    UserID: UserID,
                    RequestDate: Today,
                    SelectedProjectID: document.getElementById("cboProjects").value,
                    SelectedRoleID: $("#cboRRProjectRoleAdd").val(),
                    FromDate: $("#RRstartdt").val(),
                    ToDate: $("#RRenddt").val(),
                    NoOfResource: $("#txtnoofresource").val(),

                    WorkHrs: $("#txtRWorkHours").val(),
                    Type: $("#cbotype").val(),
                    ResourcePool: $("#cboResourcePools").val(),
                    Priority: $("#cboRPriority").val(),
                    SpecialRequest: $("#txtSpecialRequest").val(),

                }
                //StartLoader("#AddNewResource");
                var param = JSON.stringify(RequestParameters);
                var StrResult = AJAXCallWithResult("/api/PM_AddNewResource/RequestResource", param, false);
               
                if (StrResult != "") {

                    //$("#RequestAddconfirm").modal('show');
                    //cancelRequest();
                    GlobalrequestID = StrResult;
                    //  GetRequestSkillDetails(GlobalrequestID)
                    // $("#resourcerequest").modal('hide');
                    //alert(GlobalrequestID);

                }

            return GlobalrequestID;
        }  

        function AddSkill()
        {
            //$("#RequestAddconfirm").modal('hide');
            //$("#idSkill").removeClass("disabled");
            $("#idReqDetails").removeClass("active");
            $("#idSkill").addClass("active");
            $("#Rskillsettab").addClass("active");
            $("#Rrequesttab").removeClass("active");


        }


        var arrSkill = new Array();
        var Skillname = "";
        var arryear = new Array();
        var arrmonth = new Array();
        var arrRate = new Array();
        var ProjectSkillAdd = 0;
        var arrSkillNotPRoject = "";
      
        function Skill_onClick(FromWhereFlag)
        {

            GlobalrequestID = "";
            var IsValid = Request_onClick(FromWhereFlag);
            //Added by Chetan M on 17th Jan 2020
            var objHdnFields1 = document.getElementsByClassName('clsMandatoryFields');
            //var ControlID = "#"+ objHdnFields1[0].id;
            //var ControlIDVal = ControlID.value();
            if (IsValid == true)
            {
                if ($("#cboSkillMaster0").val() == 0) {
                    alertify.error("Please enter the skill details.");
                    SkillValidationFlag = 1;
                    $("#cboSkillMaster0").focus();
                    IsValid = false;

                } else {
                    SkillValidationFlag = 0;
                    IsValid = true;
                   
                }
             
            }
            //End of added by Chetan M on 17th Jan 2020
            if (IsValid == true) {
                GlobalrequestID = CreateRequest();
                //Commented And Added By Reshma Chavan on 8th April 2021 For duplicate request insertion
                //$("#btnCreateReq").attr("disabled");
                $("#btnCreateReq").attr("disabled", true);
                //End of Commented And Added By Reshma Chavan on 8th April 2021 For duplicate request insertion

                if (GlobalrequestID != "") {
                    StartLoader("#AddNewResource");
                    var objHdnFields = document.getElementsByClassName('clsMandatoryFields');
                    var i = 0;

                    if (objHdnFields.length != "0") {
                        for (i = 0; i < objHdnFields.length; i++) {
                            var object = document.getElementById(objHdnFields[i].id);
                            var ControlID = objHdnFields[i].id;
                            if (ControlID.indexOf('Skill') > -1) {
                                arrSkill.push($("#" + ControlID).val());
                                if (Skillname == "") {
                                    Skillname = $("#" + ControlID).val();
                                } else {
                                    Skillname += "," + Skillname;
                                }

                            }

                            if (ControlID.indexOf('Year') > -1) {
                                arryear.push($("#" + ControlID).val());

                            }


                            if (ControlID.indexOf('Month') > -1) {
                                arrmonth.push($("#" + ControlID).val());

                            }

                            if (ControlID.indexOf('Parameters1') > -1) {
                                arrRate.push($("#" + ControlID).val());

                            }
                        }

                        var RequestParameters =
                        {
                            SkillName: Skillname,
                            SelectedProjectID: document.getElementById("cboProjects").value
                        }
                        var param = JSON.stringify(RequestParameters);
                        var StrResult = AJAXCallWithResult("/api/PM_AddNewResource/CheckSkillOnProjectNot", param, false);
                       // debugger;
                        //Added & Commented By Dipali V On 5th Oct 2021 already skill added the should not allow to add
                        if (StrResult.length != "0" &&  StrResult[0].Column1 != "0") {
                            //if (StrResult[0].Column1 != "0") {
                             //End of Added & Commented By Dipali V On 5th Oct 2021 already skill added the should not allow to add
                                for (i = 0; i < StrResult.length; i++) {
                                    if (arrSkillNotPRoject == "") {
                                        arrSkillNotPRoject = StrResult[i].Description;
                                    } else {
                                        if (arrSkillNotPRoject.indexOf(",") > -1) {
                                            arrSkillNotPRoject += "," + arrSkillNotPRoject;
                                        }
                                        else {
                                            arrSkillNotPRoject = arrSkillNotPRoject;
                                        }

                                    }
                                }

                                //End Of Added By Usha Pandit On 16.06.2020 For javascript error

                                $("#skillNames").text("");
                                $("#skillNames").text("'" + arrSkillNotPRoject + "'");
                                $("#SaveSkillConformation").modal('show');
                                ProjectSkillAdd = 1;
                            }
                        //}
                        else {
                            for (i = 0; i < arrSkill.length; i++) {
                                var RequestParameters =
                                {
                                    SkillName: arrSkill[i],
                                    Month: arrmonth[i],
                                    Year: arryear[i],
                                    Rating: arrRate[i],
                                    RequestID: GlobalrequestID,
                                    ProjectSkillAdd: ProjectSkillAdd,
                                    SelectedProjectID: $("#cboProjects").val()
                                }
                                StartLoader("#AddNewResource");
                                var param = JSON.stringify(RequestParameters);
                                var StrResult = AJAXCallWithResult("/api/PM_AddNewResource/SaveSkill", param, false);

                                if (StrResult != "") {
                                    StopAjaxLoader("#AddNewResource");
                                    //if (arrSkill[i] != "0") {
                                    //    alertify.set('notifier', 'position', 'top-right');
                                    //    alertify.success("Skill added successfully.");
                                    //} else {
                                    alertify.set('notifier', 'position', 'top-right');
                                    setTimeout(function () {
                                        alertify.success("Request sent successfully.");
                                    }, 1500);


                                    // }
                                    SendEmailClick();
                                    cancelRequest();
                                    GlobalrequestID = "";
                                    StopAjaxLoader("#AddNewResource");
                                    $("#resourcerequest").modal('hide');
                                    arrSkill = [];
                                    arrChecked = [];
                                    //Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                                    arrSelectedEmployeeNames = [];
                                    arrSelectedEmployeeIds = [];
                                  
                                    ProjectSkillAdd = 0;
                                    arrSkill = [];
                                    arrSkillNotPRoject = [];
                                    Skillname = "";
                                    //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                                    arrmonth = [];
                                    arrRate = [];
                                    arryear = [];
                                    $("#tbodySkill").html("");
                                }
                            }

                        }
                    } else {

                        StopAjaxLoader("#AddNewResource");
                       alertify.set('notifier', 'position', 'top-right');
                        setTimeout(function () {
                            alertify.success("Request sent successfully.");
                        }, 1500);
                                  
                        SendEmailClick();
                        cancelRequest();
                        GlobalrequestID = "";
                        StopAjaxLoader("#AddNewResource");
                        $("#resourcerequest").modal('hide');
                        arrSkill = [];
                        arrChecked = [];
                        //Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                        arrSelectedEmployeeNames = [];
                        arrSelectedEmployeeIds = [];
                        //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                        arrmonth = [];
                        arrRate = [];
                        arryear = [];
                        $("#tbodySkill").html("");

                    }
                }
                else {

                    //alertify.set('notifier', 'position', 'top-right');
                    //alertify.error("Request Details are mandatory");
                  <%--  if ($("#txtnoofresource").val() == "") {
                        alertify.error("<%= MyBase.GetResourceString("C_A_NoofResource") %>");
                        $("#txtnoofresource").focus();
                        checkval = 1;
                        return false;
                    }--%>

                    //$("#RequestAddconfirm").modal('hide');
                    $("#idReqDetails").addClass("active");
                    $("#idSkill").removeClass("active");
                    $("#Rskillsettab").removeClass("active");
                    $("#Rrequesttab").addClass("active");
                    //$("#cboRRProjectRoleAdd").focus();
                    return false;

                }
            }
            else {
                //Added by Chetan M on 17th Jan 2020
                if (SkillValidationFlag == 0) {
                    //End of Added by Chetan M on 17th Jan 2020
                     $("#idReqDetails").addClass("active");
                    $("#idSkill").removeClass("active");
                    $("#Rskillsettab").removeClass("active");
                    $("#Rrequesttab").addClass("active");
                    //Commented and Added by Chetan M on 14th Jan 2020
                     //$("#txtnoofresource").focus();                     
                     $(GblControlID).focus();
                     //End of Added by Chetan M on 14th Jan 2020
                    //$("#cboRRProjectRoleAdd").focus();
           //Added by Chetan M on 17th Jan 2020
                }      
          //End of Added by Chetan M on 17th Jan 2020

            }
        }


        function cancelToAddSkill() {

            ProjectSkillAdd = 0;
            arrSkill = [];
            arrmonth = [];
            arrRate = [];
            arryear = [];
            arrSkillNotPRoject = [];
            Skillname = "";
        }


        function ProjectSkill_onClick(ProjectSkillAdd) {

            var objHdnFields = document.getElementsByClassName('clsMandatoryFields');
            var i = 0;
            for (i = 0; i < objHdnFields.length; i++) {
                var object = document.getElementById(objHdnFields[i].id);
                var ControlID = objHdnFields[i].id;
                if (ControlID.indexOf('Skill') > -1) {
                    arrSkill.push($("#" + ControlID).val());

                }

                if (ControlID.indexOf('Year') > -1) {
                    arryear.push($("#" + ControlID).val());

                }


                if (ControlID.indexOf('Month') > -1) {
                    arrmonth.push($("#" + ControlID).val());

                }

                if (ControlID.indexOf('Parameters') > -1) {
                    arrRate.push($("#" + ControlID).val());

                }
            }


            for (i = 0; i < arrSkill.length; i++) {
                var RequestParameters =
                {
                    SkillName: arrSkill[i],
                    Month: arrmonth[i],
                    Year: arryear[i],
                    Rating: arrRate[i],
                    RequestID: GlobalrequestID,
                    ProjectSkillAdd: ProjectSkillAdd,
                    SelectedProjectID: document.getElementById("cboProjects").value
                }

                var param = JSON.stringify(RequestParameters);
                var StrResult = AJAXCallWithResult("/api/PM_AddNewResource/SaveSkill", param, false);
              
                if (StrResult != "") {
                   // alertify.set('notifier', 'position', 'top-right');
                    //alertify.success("Skill added successfully.");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.success("Request sent successfully.");
                    SendEmailClick();
                    cancelRequest();
                    $("#resourcerequest").modal('hide');
                    arrSkill = [];
                    arrmonth = [];
                    arrRate = [];
                    arryear = [];

                }
            }
        }



        //Send Email Functionality
        function SendEmailClick() {
         
            var RequestParameters = {
                RequestID: encodeURI(GlobalrequestID),
            }
            var param = JSON.stringify(RequestParameters);
            var strResult = AJAXCallWithResult("/api/PM_RequestedResources/SendEmail", param, false);

            var Flag = strResult

            if (Flag == 1) {
                window.open("../Email/SendEmail.aspx?MessageID=75&RequestID=" + GlobalrequestID + "", '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');

            }

        }

        function Back_onClick() {
            $("#idReqDetails").addClass("active");
            $("#idSkill").removeClass("active");
            $("#Rskillsettab").removeClass("active");
            $("#Rrequesttab").addClass("active");

        }
        function PlotRequestResources() {
            GlobalrequestID = "";
            $("#tbodySkill").html("");
            $("#resourcerequest").modal('show');

            $("#idReqDetails").addClass("active");
            $("#idSkill").removeClass("active");
            $("#Rskillsettab").removeClass("active");
            $("#Rrequesttab").addClass("active");
            //$("#idSkill").addClass("disabled");
            cancelRequest();
            if (GlobalrequestID != "") {
                // GetRequestSkillDetails(152)
            }
            //Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory That Time Show Alert
            CheckResourcePoolMandatory();
            if (ResourcePoolIsMandatory == 1) {
                $("#lblResourcePool").addClass('required');
            }
            else {
                $("#lblResourcePool").removeClass('required');
            }
            $("select option").removeAttr("title");


            //End Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory That Time Show Alert
            $('.btn').tooltip({ trigger: 'hover' });
            $('span').tooltip({ trigger: 'hover' });
            $('.ui-datepicker-calendar th span').tooltip('hide');
        }
        $("#btnResourceRequest").click(function () {

            clearTooltip();

        })

        function clearTooltip() {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });
        }
        function cancelRequest() {
            SelectedEmployeeIDs = "";
            arrChecked = [];
            //Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
            arrSelectedEmployeeNames = [];
            arrSelectedEmployeeIds = [];
            //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
             $("#btnCreateReq").removeAttr("disabled");
            $('#resourcerequest').on('hidden.bs.modal', function (e) {
                $(this)
                    .find("input,textarea,select")
                    .val('')
                    .end()
                    .find("input[type=checkbox], input[type=radio]")
                    .prop("checked", "")
                    .end();
            });
            $("#cboRRProjectRoleAdd").val(0);
            $("#cboRPriority").val(0);
            $("#cbotype").val(0);
            $("#cboResourcePools").val(0);

            $(".chcktbl").prop("checked", false);
            StopAjaxLoader("#AddNewResource");
            //$("#resourcerequest").modal('hide');
        }

        function NextSkill_onClick() {

            $("#resourcerequest .popupboxtabs li").first().removeClass("active");
            $("#resourcerequest .popupboxtabs li").last().addClass("active");
            $("#idSkill").addClass("active");
            $("#idReqDetails").removeClass("active");
            $("#Rskillsettab").addClass("active");
            $("#Rrequesttab").removeClass("active");

        }

        function ValidateWithProjectDates(FromDate, ToDate) {

            var checkval = 0;
            var result = GetProjectStartDateEndDate(ProjectID);
            Today = SelectedCurrentdate.toShortFormat();            

            for (var i = 0; i < result.length; i++)
            {               
                var ObjDate = result[i];
                if (Date.parse(ObjDate.expectedenddate) < Date.parse(FromDate)) {
                    alertify.error("From Date should not be greater than 'Project End Date " + result[i].expectedenddate + "");
                    $("#RRstartdt").focus();
                    //Added by Chetan M on 14th Jan 2020
                        GblControlID = "#RRstartdt";
                        //End of Added by Chetan M on 14th Jan 2020
                    checkval = 1;
                }
                else if (Date.parse(ObjDate.expectedStartdate) > Date.parse(FromDate) && Date.parse(ObjDate.expectedenddate) < Date.parse(ToDate)) {
                    alertify.error("From Date and To Date should be between the Project Start Date " + result[i].expectedStartdate + " And End Date " + result[i].expectedenddate + "");
                    $("#RRenddt").focus();
                    //Added by Chetan M on 14th Jan 2020
                        GblControlID = "#RRenddt";
                        //End of Added by Chetan M on 14th Jan 2020
                    checkval = 1;
                }
                else if (Date.parse(ObjDate.expectedStartdate) > Date.parse(FromDate)) {
                    alertify.error("From Date  should be  greater than or equal to 'Project Start Date " + result[i].expectedStartdate + "");
                    $("#RRstartdt").focus();
                     //Added by Chetan M on 14th Jan 2020
                        GblControlID = "#RRstartdt";
                        //End of Added by Chetan M on 14th Jan 2020
                    checkval = 1;
                }
                else if (Date.parse(ObjDate.expectedenddate) < Date.parse(ToDate)) {
                    alertify.error("To Date should not be greater than 'Project End Date " + result[i].expectedenddate + "");
                    $("#RRenddt").focus();
                     //Added by Chetan M on 14th Jan 2020
                        GblControlID = "#RRenddt";
                        //End of Added by Chetan M on 14th Jan 2020
                    checkval = 1;
                }

                else if (Date.parse(ObjDate.expectedStartdate) > Date.parse(ToDate)) {
                    alertify.error("To Date should not be less than 'Project Start Date " + result[i].expectedStartdate + "");
                    $("#RRenddt").focus();
                    //Added by Chetan M on 14th Jan 2020
                        GblControlID = "#RRenddt";
                        //End of Added by Chetan M on 14th Jan 2020
                    checkval = 1;
                }
                else if (Date.parse(FromDate) > Date.parse(ToDate)) {
                    alertify.error("From Date should be less than To date " + ToDate + "");
                    $("#RRstartdt").focus();
                    //Added by Chetan M on 14th Jan 2020
                        GblControlID = "#RRstartdt";
                        //End of Added by Chetan M on 14th Jan 2020
                    checkval = 1;
                }
                else if (Date.parse(FromDate) < Date.parse(Today)) {
                    alertify.error("From Date should not be less than Request date  " + Today + "");
                    $("#RRstartdt").focus();
                    //Added by Chetan M on 14th Jan 2020
                        GblControlID = "#RRstartdt";
                        //End of Added by Chetan M on 14th Jan 2020
                    checkval = 1;
                }
                else if (Date.parse(ToDate) < Date.parse(Today)) {
                    alertify.error("To Date should not be less than Request date" + Today + "");
                    $("#RRstartdt").focus();
                     //Added by Chetan M on 14th Jan 2020
                        GblControlID = "#RRstartdt";
                        //End of Added by Chetan M on 14th Jan 2020
                    checkval = 1;
                }
                else {
                    checkval = 0;
                }
            }
            return checkval;

        }

        //Filter Part
        function btnResourceSaveAndApplyFilter_Onclick() {
          
            //FOR sELECTED SKILL VALUES
            $("#txtResourceFilterSkillID option:selected").each(function () {
               
                var optionValue = $(this).val();
                var optionText = $(this).text();
                // console.log("optionText", optionText);
                // collect all values
                // selections.push(optionValue);
                arrskillIDFilter.push(optionValue);
            });


           // alert(arrskillIDFilter);
            if (AllFields != "SkillID") {
                QueryText = GenerateBasicFilterQuery('Resource', AllFields);
            }
            else {
                QueryText = "SkillID IN (" + arrskillIDFilter + ")";
            }
            //QueryText = QueryText.replace('ReportingTo', 'E.ReportingTo');
            if (QueryText.length > 0) {
                $('#Issuesavefilter').modal('show');

            } else {

                alertify.error('<%= MyBase.GetResourceString("A_Query") %>');
                $('#Issuesavefilter').modal('hide');
            }
        }

        //Only Apply Resource Filter
        function btnResourceApplyFilter_Onclick() {
            
            var QueryText = "";

            if (AllFields != "SkillID") {
                QueryText = GenerateBasicFilterQuery('Resource', AllFields);
            }
            else {
                QueryText = "SkillID IN (" + arrskillIDFilter + ")";
            }
            //QueryText = QueryText.replace('ReportingTo', 'E.ReportingTo');

            if (QueryText == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('<%= MyBase.GetResourceString("A_Query") %>');
            }
            else {

                //GetResourcesGirdList(ProjectID, QueryText);
                $(".filterpanel").removeClass("in");
                //$("#ResourceFilter").addClass('activefilter');
                // $("#ResourceClearAllFilter").css({ 'display': 'inline-block' });

            }
            return QueryText;

        }

        //function for save Resources  filter in table
        function ResourceSaveAndApplyFilter() {
          
            if (GlobalFilterName == undefined) {
                GlobalFilterName = "";
            }
            else {
                GlobalFilterName = GlobalFilterName;
            }
            var FilterName = $("#txtFilterName").val().trim();
            if (FilterName == "") {
                alertify.error('<%= MyBase.GetResourceString("A_FilterName") %>');
                $("#btnSaveAndApplyFilter").removeAttr("data-bs-dismiss", "");
                $("#txtFilterName").focus();
                return false;

            }
            else {
                if (FilterName != GlobalFilterName) {
                    Flag = 0;
                    FilterID = null;
                }
                else {
                    Flag = 1;
                }
                var filterExists = 0;
                if (FilterName != "" && GlobalFilterName == "") {
                    filterExists = checkDuplicateFilter(FilterName, 1220);
                }
                if (filterExists == 0) {
                    var QueryText = GenerateBasicFilterQuery('Resource', AllFields);
                    // QueryText = QueryText.replace('ReportingTo', 'E.ReportingTo');

                    var ResourceParameters = {
                        TagID: 1220,
                        ProjectID: encodeURI(ProjectID),
                        UserID: encodeURI(UserID),
                        FilterName: encodeURI(FilterName),
                        LoginType: encodeURI(LoginType),
                        QueryText: encodeURI(QueryText),
                        UserName: encodeURI(UserName),
                        FilterFlag: encodeURI(Flag),
                        FilterID: encodeURI(FilterID)
                    }
                    var param = JSON.stringify(ResourceParameters);
                    var strResult = AJAXCallWithResult("/api/PM_Resources/ResourcesSavedFilters", param, false);
                    if (strResult != null) {
                       
                        GlobalApplyID = "Apply" + strResult;
                        ApplyCheckResourceFilter(GlobalApplyID);

                        $("#btnSaveAndApplyFilter").attr("data-bs-dismiss", "modal");
                        $("#ResourceFilter").addClass("activefilter");
                        $("#ResourceClearAllFilter").css({ 'display': 'inline-block' });
                    }

                }
            }
        }



        var objIsDefaultApprove = 0;
        function Approver_onchange() {
          
            // if(objIsDefaultApprove==1)
            var ResourceParameters = {
                ProjectID: encodeURI(ProjectID),
                RoleID: encodeURI(document.getElementById("cboProjectRoleAdd").value),
            }
            var param = JSON.stringify(ResourceParameters);
            var result = AJAXCallWithResult("/api/PM_AddNewResource/CheckDefaultApprover", param, false);
            if (result != undefined) {
                if (result.length > 0) {
                   
                    if ($('#chkIsDefaultApprover').is(":checked")) {
                        objIsDefaultApprove = 1;
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('This will change the previously set Default Approver');
                        $("#chkIsDefaultApprover").focus();
                        return false;

                    }

                }
            }

        }



        function CheckReportingTo() {
            var objIsReportingTo = 0;
            var ResourceParameters = {
                ProjectID: encodeURI(ProjectID),
                RoleID: encodeURI(document.getElementById("cboProjectRoleAdd").value),
            }
            var param = JSON.stringify(ResourceParameters);
            var result = AJAXCallWithResult("/api/PM_AddNewResource/CheckReportingTo", param, false);
            if (result != undefined) {
                if (result.length > 0) {
                    objIsReportingTo = 1;
                }
                else {
                    objIsReportingTo = 0;
                }
            }
            return objIsReportingTo;
        }




        function GetResourceFilters() {

            var ResourceParameters = {
                ProjectID: encodeURI(ProjectID),
                TagID: 1220,
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID)
            }
            var param = JSON.stringify(ResourceParameters);
            var result = AJAXCallWithResult("/api/PM_Resources/ResourceFilters", param, false);
            if (result != undefined) {
              
                MyResourceFiltersList(result);
            }
            $(".LIResourceALBasicFilter").removeClass("active");
            $("#liResourceALMyFiltersdropdown").addClass("active");

        }


        //Milestone filter list
        function MyResourceFiltersList(result) {

            var strHTML = "";

            for (var i = 0; i < result.length; i++) {
                var FilterID = result[i]["FilterId"];
                var FilterName = result[i]["FilterName"];
                var QueryText = result[i]["QueryText"];

                strHTML += ' <li>'

                if (result[i].SetDefault == true) {
                    strHTML += '<label class="customradio">'
                    strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="Default' + FilterID + '" type="radio" name="project2" onclick="SetResourceDefaultFilter(this.id,&quot;Default&quot;)" checked="checked">'
                    strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Set Default filter" class="checkmark"></span>'
                    strHTML += '</label>'
                }
                else {
                    strHTML += '<label class="customradio">'
                    strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-bs-placement="bottom" id="Default' + FilterID + '" type="radio" name="project2" onchange="SetResourceDefaultFilter(this.id,&quot;&quot;)">'
                    strHTML += '<span data-bs-toggle="tooltip" data-bs-placement="right" title="Set Default filter" class="checkmark"></span>'
                    strHTML += '</label>'
                }

                strHTML += '<label class="">'
                strHTML += '<span for="project2" class="radiotextsty filtername">' + FilterName + '</span>'
                strHTML += '</label>'
                strHTML += '<div class="issfilter_actiondropdown">'

                if (result[i].SetDefault == true) {
                    strHTML += '<div class="custom_chckbox_markblue">'
                    strHTML += '<input id="ModuleselproOne" checked="" type="checkbox" name="">'
                    strHTML += '<label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Apply filter" for="IssueselproOne" id="Apply' + FilterID + '" onclick="ApplyCheckResourceFilter(this.id)" class="filterid"></label>'
                    strHTML += '</div>'
                }
                else {
                    strHTML += '<div class="custom_chckbox_markblue">'
                    strHTML += '<input id="ModuleselproOne" type="checkbox" name="">'
                    strHTML += '<label data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Apply filter" for="IssueselproOne" id="Apply' + FilterID + '" onclick="ApplyCheckResourceFilter(this.id)" class="filterid"></label>'
                    strHTML += '</div>'
                }

                strHTML += '<span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Edit filter" class="fas fa-pencil-alt" id="Edit' + FilterID + '" onclick="ResourcesEditFilter(this.id)" ></i></span>'

                if (result[i].SetDefault == true) {
                    strHTML += '<span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Delete filter" class="far fa-trash-alt" id="Default' + FilterID + '" onclick="DeleteDefaultResourceFilter(this.id)" ></i></span>'
                }
                else {
                    strHTML += '<span><i data-bs-toggle="tooltip" data-bs-container="body" data-bs-placement="bottom" title="Delete filter" class="far fa-trash-alt" id="' + FilterID + '" onclick="DeleteDefaultResourceFilter(this.id)"></i></span>'
                }
                strHTML += '</div>'
                strHTML += '</li>'


            }
            $("#MyFiltersdropdown").html(strHTML);
            $('[data-bs-toggle="tooltip"]').tooltip();

            if (GlobalApplyID != null) {
                ApplyCheckResourceFilter(GlobalApplyID);
            }
            else {
                ClearAppliedFilter(GlobalApplyID);
            }

        }

        //function for Apply Check
        function ApplyCheckResourceFilter(ApplyID) {
            if (GlobalApplyID == "") {

                GlobalApplyID = ApplyID;
            }
            else if (GlobalApplyID != "") {
                GlobalApplyID = ApplyID;
            }
            else {

                ApplyID = GlobalApplyID;

            }

            FilterID = ApplyID.replace("Apply", "");

            if (FilterID != undefined) {
                ResourceParameters = {
                    FilterID: encodeURI(FilterID),
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_Resources/EditFilterData',
                    type: "POST",
                    data: JSON.stringify(ResourceParameters),
                    dataType: "json",
                    async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                        if (ResourceParameters) {
                            xhr.setRequestHeader("Params", encryptString(isJson(ResourceParameters) ? ResourceParameters : JSON.stringify(ResourceParameters)));
                        }
                    },

                    success: function (result) {
                        for (var i = 0; i < result.length; i++) {
                            var QueryText = result[i].WhereClause;
                        }
                        if (QueryText != null) {
                            QueryText = QueryText.toString().replace(/'/g, "''");
                        }

                        var sibling = $('label[id^="Apply"]')

                        if ($("#" + ApplyID).parent().find("input").prop("checked") == true) {

                            $("#" + ApplyID).parent().find("input").prop("checked", true);
                            $("#" + ApplyID).removeAttr("data-original-title", "");
                            $("#" + ApplyID).attr("data-original-title", "Applied Filter");

                        }
                        else if ($("#" + ApplyID).parent().find("input").prop("checked") == false) {



                            $(sibling).each(function () {
                                var id = this.id;

                                if (ApplyID == this.id) {

                                    $("#" + id).parent().find("input").prop("checked", true);
                                    $("#" + id).removeAttr("data-original-title", "");
                                    $("#" + id).attr("data-original-title", "Applied Filter");
                                }
                                else {
                                    $("#" + id).parent().find("input").prop("checked", false);
                                    $("#" + id).removeAttr("data-original-title", "");
                                    $("#" + id).attr("data-original-title", "Apply Filter");
                                }

                            });

                        }
                        //GetResourcesList(ProjectID, QueryText);
                        LoadDetails(whichflag, QueryText);
                        $("#presetfilterAR").removeClass("active");
                        $("#ResourceFilter").addClass("activefilter");
                        $("#ResourceClearAllFilter").css({ 'display': 'inline-block' });
                        $("#MyFiltersdropdown").css('display', 'none');

                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }
        }
        //Check filter already Exists or not 
        function checkDuplicateFilter(FilterName, TagID) {

            var isFilterExists = 0;
            var ResourceParameters = {
                FilterName: encodeURI(FilterName),
                TagID: encodeURI(TagID),
                ProjectID: encodeURI(ProjectID),
                //Added By Usha Pandit On 09.11.2019 For checking resource specific filter  
                UserID: encodeURI(UserID),
                //End Of Added By Usha Pandit On 09.11.2019 For checking resource specific filter  
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Resources/chkFilterExists',

                method: 'Post',
                data: JSON.stringify(ResourceParameters),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (ResourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ResourceParameters) ? ResourceParameters : JSON.stringify(ResourceParameters)));
                    }
                },
                success: function (data) {

                    if (data == 0) {
                        isFilterExists = 0;
                    }
                    else if (data == 1) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('<%= MyBase.GetResourceString("A_FilterNameExists") %>');
                        $("#btnSaveAndApplyFilter").removeAttr("data-bs-dismiss", "");
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



        function SetResourceDefaultFilter(DefaultID, flag) {

            var RemoveDefault = 0;
            if (flag == "Default") {
                RemoveDefault = 1;
            }

            FilterID = DefaultID.replace("Default", "");
            if (FilterID != undefined) {
                ResourceParameters = {
                    ProjectID: encodeURI(ProjectID),
                    LoginType: encodeURI(LoginType),
                    UserID: encodeURI(UserID),
                    TagID: 1220,
                    FilterID: encodeURI(FilterID),
                    Flag: encodeURI(RemoveDefault)
                }
                var param = JSON.stringify(ResourceParameters);
                var strResult = AJAXCallWithResult("/api/PM_Resources/SetDefaultFilter", param, false);
                if (strResult != undefined) {
                    if (RemoveDefault == 0) {
                        FilterID = "Apply" + FilterID;
                        ApplyCheckResourceFilter(FilterID);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success(strResult);
                    }
                    else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.success("<%= MyBase.GetResourceString("A_ClearDefaultFilter") %>");
                        GetResourcesList(ProjectID, null);
                    }
                }
                if (strResult == "Set Default Filter Successfully") {
                    $("#ResourceFilter").addClass("activefilter");
                    $("#ResourceClearAllFilter").css({ 'display': 'inline-block' });
                } else {
                    $("#ResourceFilter").removeClass("activefilter");
                    $("#ResourceClearAllFilter").css({ 'display': 'none' });
                }

            }
        }

        //Restrict Special Charaters onkeypress
        function restrictSpecialChars(e) {

            var k;
            document.all ? k = e.keyCode : k = e.which;
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || (k >= 48 && k <= 57));
        }


        function checkSpecialCharacter(value) {
            var regularExpression = '{}|`~[]<>\:!"@#$%^&*()_+-=/';
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

        // Added By Rutuja D 8 Jan 2020 For Project Is over Or not 
        var ProjectOver = "";
        var ResourcePoolIsMandatory = "";
        function CheckProjectOver() {
            var param = JSON.stringify(ProjectID);
            var result = AJAXCallWithResult("/api/PM_AddNewResource/CheckProjectOver", param, false);
            ProjectOver = result;

        }
        // End Added By Rutuja D 8 Jan 2020 For Project Is over Or not

        //Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory Or Not
        function CheckResourcePoolMandatory() {
            var param = JSON.stringify();
            var result = AJAXCallWithResult("/api/PM_AddNewResource/CheckResourcePoolMandatory", param, false);
            ResourcePoolIsMandatory = result;

        }
        //End Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory Or Not


        //Resquest QueryString Parameter
        function getParameters() {

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
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }



        function restrictAlphabets(e) {

            var x = e.which || e.keycode;

            if ((x >= 48 && x <= 57) || x == 8 || (x >= 35 && x <= 40) || x == 46 || x == 58) {
                return true;
            }
            else {
                return false;
            }
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


       
    </script>

    <!-- Save filter Modal start here-->
    <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-keyboard="false" data-backdrop="static">
        <div class="modal-dialog" role="document">
            <div class="modal-content" id="DivSaveFilter">
                <div class="modal-header">
                    <h5 class="modal-title" id=""><%= MyBase.GetResourceString("C_SaveFilterAs") %></h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div id="Issuesavrefilterbox" class="box-panel">
                        <div class="box-body graybg">
                            <div class="form-group mb-0">
                                <div class="row">
                                    <div class="col-md-12 row">
                                        <label class="control-label col-md-4 p-0 text-end"><%= MyBase.GetResourceString("C_FilterName") %> <span style="color: red">*</span></label>
                                        <span class="col-md-8">

                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", "form-control",,,,,, ,,,, "PlaceHolder = 'Enter Filter Name (Maxlength 100 Char)' autocomplete='Off' maxlength='100' onkeypress='return restrictSpecialChars(event)'",,, True,,,,) %>
                                            <%--<input type="text" class="form-control" name="">--%><br />
                                            <div class="btnrow">
                                                <button class="btn btnyellow float-start savefilter" id="btnSaveAndApplyFilter" onclick="ResourceSaveAndApplyFilter()"><%= MyBase.GetResourceString("C_Save") %> </button>
                                                <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn float-end"><%= MyBase.GetResourceString("C_Cancel") %> </button>
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


    <div id="SaveSkillConformation" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modalsmall">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirmation</h4>
                </div>

                <div class="modal-body">

                    <p align="center"><span id="skillNames"></span>skill is not added to the Project,Do you wish to add?</p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                                <button class="btn borderbtn ml-1" data-bs-dismiss="modal" onclick="cancelToAddSkill()">No</button>
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button class="btn btnyellow ml-1 float-end" onclick="ProjectSkill_onClick(1)" data-bs-dismiss="modal">Continue</button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class="clearfix"></div>
    </div>



    <div id="RequestAddconfirm" class="modal fade custmodal" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modalsmall">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Confirmation</h4>
                </div>

                <div class="modal-body">

                    <p align="center">Resource request saved successfully. Add skills to the resource request.</p>

                    <div class="form-group mt-4">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 text-start">
                            </div>
                            <div class="col-xs-6 col-sm-6">
                                <button type="button" data-bs-dismiss="modal" class="btn btn-primary text-start" id="delete" onclick="AddSkill()">Ok</button>
                            </div>
                        </div>
                    </div>

                </div>

            </div>
        </div>
        <div class="clearfix"></div>
    </div>


    <%--Added By Rutuja D 8 Jan 2020 For Get Todays Date--%>
    <%CommonFunctions.HTMLControls.DrawTextBox("txtToday", "txtToday",, IsHidden:=True, EnableHTMLEncode:=True) %>
    <%--End Added By Rutuja D 8 Jan 2020 For Get Todays Date--%>

    <!-- Save filter Modal End here-->
</body>

</html>
