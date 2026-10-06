<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_Resource_Selection.aspx.vb" Inherits="Whizible.PM_Resource_Selection" %>

<!DOCTYPE html>
<html>

    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project Resource")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Project Resource</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1" />
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2" />
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2" />
	<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=2" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css?v=0" />
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1" />
	<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css?v=1.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1" />
    <link href="../../../Whizible2.0-new/plugins/select2/select2.css?v=3" rel="stylesheet" />

</head>

    <style type="text/css">
        /*resource skill set dropdown added by Imran 11-06-2021*/ 
        /*.alertify-notifier .ajs-message.ajs-error{
            color: #fff;
            background: rgba(217, 92, 92, 0,95);
            text-shadow: -1px -1px 0 rgba(0, 0, 0, 0,5);
        }*/
       
         .filter button.activefilter {
            background: #1359a6;
            color: #fff;
            padding: 4px 6px;
            font-size: 12px;
            border-radius: 4px
        }

        .exprience select.form-control {
            width: 50px;
            display: inline-block;
            padding-left: 4px;
            padding-right: 4px;
        }   

         .alertify-notifier {
            z-index: 9999;
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


        .mb-1 {
            margin-bottom: 10px;
        }

        a.clearalllink {
            font-weight: bold;
            margin: 3px 10px 0 10px;
            display: none;
        }

        #basicfilters label {
            text-align: right;
            padding-right: 0;
        }

        .filterpanelbody {
            padding: 30px;
            background: #f5f5f5;
        }
        /*css*/


        .dataTables_scrollBody {
            margin-bottom: 10px;
        }

        .borderbox {
            text-align: right;
            background: #f5f5f5;
            padding: 15px 15px 0px;
            border-radius: 4px;
        }

        .preloader {
        position: absolute;
        margin-top: -25px;
        margin-left: -400px;
        top: 50%;
        left: 50%;
        padding: 30px 15px 0px;           
        border-radius: 15px;
        background: #ddd;          
        background: url(../../../Whizible2.0-new/dist/img/loading.gif) 100% 100% no-repeat;          
        width: 100px;
        height: 100px;
        background-repeat: no-repeat;
        background-position: center;
        margin: -100px 0 0 -100px;
        z-index: 1002;
        text-align: center;
        }

        #bulkallocation .select2-container {
            width: 330px !important;
        }

        #bulkallocation .select2-selection__choice {
            color: black !important;
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

         table.dataTable thead th:first-child.sorting_asc:after, table.dataTable thead th:first-child.sorting_desc:after 
         {
            display: none!important;
        }

        /* Added by Dipali V on 13th May 2026 - Resource Selection grid: scroll outer wrapper (no DataTables scrollX/Y = no split thead/tbody) */
        #RsrsSelctionTableWrap {
            max-height: calc(100vh - 320px);
            overflow: auto;
            width: 100%;
        }
        #RsrsSelctionTble_wrapper {
            width: 100%;
        }
        #RsrsSelctionTble_wrapper table.dataTable {
            width: 100% !important;
        }

        #ClsNote {
            color: red !important;
            font-size: 12px !important;
        }
        #ClsNoteText {
            font-size:12px!important;
        }
        #FILENAME0 td {
            float:left;
            border:0
        }
     /*End of Added By Dipali V On 24th Feb 2021 For Note*/

     .projectDateCust{display:flex}

        tr.collapse.in {
            display: table-row;
        }

        .ui-datepicker {
            z-index: 9999 !important;
        }

        #resourcerequest .modal-header {
            display: table-cell;
        }

        #SaveSkillConformation  .modal-header {
            display: table-cell;
        }


        #resourcerequest .modal-dialog {
            margin: 30px auto !important;
            min-height: 100%;
        }

        .filterpanel .cust_tabpanel .MyFiltersdropdown.show {
            display: block;
        }

        td.exprience {
            display: inline-flex;
            border: none !important;
        }
        .exprience select.form-control {
            margin: 0px 5px;
            width: 47px !important;
        }
#Rrequesttab .form-group.text-center {
    display: block!important;
}
    
#bulkallocation .row .form-group {display: inline-flex;} 
.custmodal .modal-content .modal-body {padding: 30px;}
#bulkallocation .modal-dialog{margin-top: 20px;min-height: 92vh;}

#bulkallocation .row .form-group.text-center { 
    display: block;
}

.borderbox .col-sm-7 .form-control {width: 100%!important;text-overflow: ellipsis;overflow: hidden;}
th.sorting_disabled::after, th.sorting_disabled::before{display:none!important;}

/*ul.nav.nav-tabs.popupboxtabs {
  
     margin-bottom: auto!important;
}*/

.clsnoteskill{
    color:red;

}

</style>

<body class="hold-transition skin-blue-light sidebar-mini fixed"  id="AddNewResource">

     <div id="divPMResource" class="preloader"></div>

    <div class="bgwhite">

        <div class="container-fluid pt-1 pb-1 mb-1 text-right graybg clearfix">
            <h5 class="pgtitle pull-left">Resource Selection</h5>
            <%--<a class="clearalllink" id="PMProjectReviewClearAllFilter"><strong>Clear All</strong></a>--%>
             <a href="javascript:;" class="clearalllink" id="ResourceClearAllFilter"><strong><%= MyBase.GetResourceString("C_ClearAll") %></strong></a>
            <div class="filter inline pull-right">
                <%--<button data-bs-toggle="collapse" data-bs-target="#filterpanel" data-placement="bottom" title="" id="AdvanceFilterIcon" data-original-title="Filter" autocomplete="off"><i class="fas fa-filter"></i></button>--%>
                <button data-bs-toggle="collapse" data-bs-target=".filterpanelAR" data-original-title="" title="" id="ResourceFilter">
                    <i data-bs-toggle="tooltip" data-placement="bottom" title="" class="fas fa-filter" data-original-title="Filters"></i>
                </button>
            </div>
        </div>

        <!--filter panel-->
        <div id="ALfilterpanel" class="collapse filterpanel filterpanelAR" style="border-bottom: 12px solid #eee;">
            <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <div class="cust_tabpanel">
                            <ul class="nav nav-tabs">
                                <li class="dropdown keep-inside-clicks-open" id="liResourceALMyFiltersdropdown">
                                    <a class="dropdown-toggle" href="#" data-bs-toggle="dropdown" onclick="ResourceFilters()" id="ResourceMyFilter"><%= MyBase.GetResourceString("C_MyFilters") %><span class="caret"></span></a>
                                    <ul id="ResourceALMyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                        <li></li>

                                    </ul>
                                </li>
                                <li class="LIResourceALBasicFilter">
                                    <a href="#presetfilterAR" data-bs-toggle="tab" id="ResourceALBasicFilter"><%= MyBase.GetResourceString("C_BasicFilters") %></a>
                                </li>
                            </ul>
                        </div>

                        <div class="issuefilter_container">
                            <div class="tab-content issuefilter_tabcontent">
                                <div id="presetfilterAR" class="tab-pane stackbasicfilter">
                                    <div class="">
                                        <div class="text-center hidden-xs centerbtn">
                                            <%--<button class="btn btnyellow" id="svfilterbtn" data-bs-toggle="modal" data-bs-target="#Issuesavefilter" data-bs-dismiss="modal">Save and Apply</button>--%>
                                            <button class="btn btnyellow" id="svfilterbtn">Save and Apply</button>
                                            <button class="btn btnyellow" id="showsavefilter">Apply</button>
                                            <%-- <button class="btn btnyellow">Apply</button>--%>
                                        </div>
                                        <br />

                                        <div class="row">
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">User Name</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="FUNm">
                                                                <option>Contains</option>
                                                                <option>Ends With</option>
                                                                <option>Exact Words</option>
                                                                <option>Not Contains</option>
                                                                <option>Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <%=CommonFunctions.HTMLControls.DrawTextBox("txtUserName", "txtUserName", "form-control input-sm", , , , , , False, , , , "PlaceHolder='Enter User Name'", True, , , , , , True)%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Resource Name</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="FRNM">
                                                                <option>Contains</option>
                                                                <option>Ends With</option>
                                                                <option>Exact Words</option>
                                                                <option>Not Contains</option>
                                                                <option>Starts With</option>
                                                            </select>
                                                        </div>
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <%=CommonFunctions.HTMLControls.DrawTextBox("txtResourceName", "txtResourceName", "form-control input-sm", , , , , , False, , , , "PlaceHolder='Enter Resource Name'", True, , , , , , True)%>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Department</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="FDept">
                                                                <option>=</option>
                                                                <option><></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CmbFDepartment", "use_Sel_Whizible2_Department", 200,, "class='form-control selectpicke'", False,,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Buisness Group</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="FBG">
                                                                <option>=</option>
                                                                <option><></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CmbFBusinessGroup", "use_Sel_Whizible2_BusinessGroup", 200,, "class='form-control selectpicke'", False,,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Organization Unit</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="FOU">
                                                                <option>=</option>
                                                                <option><></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CmbFOrganizationUnit", "use_Sel_Whizible2_OrganizationUnit", 200,, "class='form-control selectpicke'", False,,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Role</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="FRole">
                                                                <option>=</option>
                                                                <option><></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CmbFRole", "use_Sel_Whizible2_Role", 200,, "class='form-control selectpicke'", False,,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Designation</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="FDesig">
                                                                <option>=</option>
                                                                <option><></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CmbFDesignation", "use_Sel_Whizible2_Designation", 200,, "class='form-control selectpicke'",,,,) %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-12 col-sm-6 form-group">
                                                <label class="col-sm-4">Vendor</label>
                                                <div class="col-sm-8">
                                                    <div class="row">
                                                        <div class="col-sm-4">
                                                            <select class="form-control input-sm" id="FVendor">
                                                                <option>=</option>
                                                                <option><></option>
                                                            </select>
                                                        </div>
                                                        <div class="col-xs-8 col-sm-8 pl-0">
                                                            <% 'Added by Dipali V on 6th May 2026 for vendor management - Vendor filter in direct resource allocation %>
                                                            <% CommonFunctions.HTMLControls.DrawComboBox("CmbFVendor", "usp_Whizible2_Sel_tbl_Whizible2_VendorMaster_Active", 200,, "class='form-control selectpicke'", False,,,) %>
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
                    </div>
                </div>
            </div>
        </div>
        <!--end filter panel-->
       
        <div class="content pt-1">
            <div class="pb-1 text-right" style="cursor: auto;">
                <button class="btn btnyellow" id="show" data-bs-toggle="tooltip" data-bs-title="Show">Show</button>                
                <button class="btn btnyellow" style="display:none" id="selectResource" data-bs-toggle="tooltip" title="Select Resource">Select Resource</button>
                <button class="btn btnyellow" style="display:none" id="btnResourceRequest" onclick="PlotRequestResources()" data-bs-toggle="tooltip" title="Resource Request"><%= MyBase.GetResourceString("C_ResourceReq") %></button>
                <button class="btn btnyellow" id="Back" data-bs-toggle="tooltip" title="Back">Back</button>
            </div>
            
            <div class="borderbox mb-1">
                <div class="row">
                    <div class="form-group">
                        <div class="col-sm-4 form-inline">
                            <label class="col-sm-5 required">Role</label>
                            <div class="col-sm-7">
                                <% CommonFunctions.HTMLControls.DrawComboBox("CmbRole", "use_Sel_Whizible2_Role", 200,, "class='form-control '", False,,) %>
                            </div>
                        </div>
                        <div class="col-sm-4 form-inline">
                            <label class="col-sm-5">Designation</label>
                            <div class="col-sm-7">
                                <% CommonFunctions.HTMLControls.DrawComboBox("CmbDesignation", "use_Sel_Whizible2_Designation", 200,, "class='form-control'",,,,) %>
                            </div>
                        </div>
                        <div class="col-sm-4 form-inline">
                            <label class="col-sm-5">Department</label>
                            <div class="col-sm-7">
                                <% CommonFunctions.HTMLControls.DrawComboBox("CmbDepartment", "use_Sel_Whizible2_Department", 185,, "class='form-control'", False,,,) %>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>

                <div class="row">
                    <div class="form-group">
                        <div class="col-sm-4 form-inline">
                            <label class="col-sm-5">Business Group</label>
                            <div class="col-sm-7">
                                <% CommonFunctions.HTMLControls.DrawComboBox("CmbBusinessGroup", "use_Sel_Whizible2_BusinessGroup", 200,, "class='form-control'", False,,,) %>
                            </div>
                        </div>
                        <div class="col-sm-4 form-inline">
                            <label class="col-sm-5">Organization Unit</label>
                            <div class="col-sm-7">
                                <% CommonFunctions.HTMLControls.DrawComboBox("CmbOrganizationUnit", "use_Sel_Whizible2_OrganizationUnit", 200,, "class='form-control'", False,,,) %>
                            </div>
                        </div>
                        <div class="col-sm-4 form-inline">
                            <label class="col-sm-5">Employee Name</label>
                         
                            <%-- Added By Vyankat B. on 19-Jun-2026 to trigger Show button click when Enter key is pressed in Employee Name textbox. --%>
                            <div class="col-sm-7">
                                <%=CommonFunctions.HTMLControls.DrawTextBox("txtEmpName", "txtEmpName", "form-control", , , , , , False, , , ,
                                            "PlaceHolder='Enter Employee Name' onkeypress='return EmployeeNameKeyPress(event)'", True, , , , , , True)%>
                            </div>
                            <%-- End of Added By Vyankat B. on 19-Jun-2026 to trigger Show button click when Enter key is pressed in Employee Name textbox. --%>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="form-group">
                        <div class="col-sm-4 form-inline">
                            <label class="col-sm-5">Vendor</label>
                            <div class="col-sm-7">
                                <% 'Added by Dipali V on 6th May 2026 for vendor management - Vendor filter in direct resource allocation %>
                                <% CommonFunctions.HTMLControls.DrawComboBox("CmbVendor", "usp_Whizible2_Sel_tbl_Whizible2_VendorMaster_Active", 200,, "class='form-control'", False,,,) %>
                            </div>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>

            <div id="RsrsSelctionTableWrap" class="rsrs-selection-table-wrap">
            <table id="RsrsSelctionTble"  class="table table-bordered tbl_rsrsselection" style="width: 100%;">
            <thead>
                <tr>
                    <th>User Name</th>
                    <th>Resource Name</th>
                    <th>Business Group</th>
                    <th>Department</th>
                    <th>Organization Unit</th>
                    <th>Role</th>
                    <th>Designation</th>
                    <th>Deployable</th>
                    <th>Resource Loading</th>
                    <th>
                        <input type="checkbox" id="Checkall"  class="custom-control-input"/>
                    </th>                    
                </tr>
            </thead>
        </table>
            </div>
                  
</div>

        <!-- Save filter Modal start here-->
        <div class="modal custmodal Issuesave_filter fade" id="Issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="">Save Filter As</h5>
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
                                            <label class="control-label col-md-4 p-0 text-right">Filter Name :</label>
                                            <div class="col-md-8">
                                                <span id="spanTagId"></span>
                                                 <% CommonFunctions.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", "form-control",, 100,,,, ,,,, "autocomplete='off'", ,, True,,,,) %>
                                                 <%--  <input type="text" class="form-control" name="">--%><br />
                                                 <div class="btnrow">
                                                        <button class="btn btnyellow pull-left savefilter" id="btnSaveAndApplyFilter">Save</button>
                                                        <button data-bs-dismiss="modal" class="btn canclesaveasbtn borderbtn pull-right" id="btnCancel">Cancel</button>
                                                 </div>
                                            </div>
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

        <div class="clearfix"></div>

        <div class="modal custmodal  fade" id="bulkallocation" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel"  aria-hidden="true" data-bs-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header" style="display:inline-block">
                   
                    <h5 class="modal-title" id="">Allocation Details</h5>                  
                    <button type="button" id="btnclose" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="form-group">
                            <label class="col-sm-4 text-right">Resources <span style="color: red">*</span></label>
                            <div class="col-sm-8" id="DivResourcelist">
                                <select id="RAtaglist" class="form-control" multiple onchange="FillResourceArray()">
                                </select>
                                <input type="hidden" id="RAtaglisthidden" />                               
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 text-right"> Project <span style="color: red">*</span></label>
                            <div class="col-sm-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectAdd", "Select ''",,, "class='form-control' onChange='ChangeProject(this)' disabled",,, ,,) %>
                            </div>
                        </div>
                        <div class="form-group">                         
                            <label class="col-sm-4 text-right">Project Role <span style="color: red">*</span></label>
                            <div class="col-sm-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboProjectRoleAdd", "usp_Whizible2_Sel_tbl_PM_Role_PopulateCombo",,, "class='form-control'",,, ) %>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 text-right">Planned Start Date <span style="color: red">*</span></label>
                            <div class="col-sm-8">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="PlanStartDate" style="background-color:#fff;" onchange="GetResourceAllocation()">
                                    <span class="input-group-btn">
                                        <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">                           
                            <label class="col-sm-4 text-right">Planned End Date <span style="color: red">*</span></label>                       
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
                            <label class="col-sm-4 text-right">% Allocation <span style="color: red">*</span></label>                           
                            <div class="col-sm-8">
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtResourcePercentage", "txtResourcePercentage", "form-control", 200, 3,,,,,,,, "onkeypress='return restrictAlphabets(event)'autocomplete='off'") %>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 text-right">Reporting To <span style="color: red">*</span></label>                          
                            <div class="col-sm-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboReportingToAdd", "Select ''",,, "class='form-control'", False,,, ,,) %>
                                <br/> <strong>'Reporting To' is not mandatory for the first resource. </strong>
                                 
                            </div>
                        </div>
                        <div class="form-group">                          
                            <label class="col-sm-4 text-right">Resource Status <span style="color: red">*</span></label>
                            <div class="col-sm-8">
                                <% CommonFunctions.HTMLControls.DrawComboBox("cboResourceStatusAdd", "usp_Whizible2_Sel_tbl_PM_ProjectGroupResources_WhyNonBillable",,, "class='form-control'",,, ) %>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 text-right"> Work (H:M) <span style="color: red">*</span></label>
                            <div class="col-sm-8">
                                <% CommonFunctions.HTMLControls.DrawTextBox("txtALWorkHrs", "txtALWorkHrs", "form-control",,,,,,,,,, "autocomplete='Off' maxlength='6'",,, True,,,, True) %>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="control-label col-sm-4">&nbsp;</label>
                            <div class="col-sm-8">
                                <div class="custom_chckbox" id="divIsDefaultApprover">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkIsDefaultApprover", "chkIsDefaultApprover",,,,, "onclick=Approver_onchange(this)") %>
                                    <label for="chkIsDefaultApprover"> Is Default Approver </label>
                                </div>
                                <div class="custom_chckbox" id="divIsResourceBillable">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkIsResourceBillable", "chkIsResourceBillable") %>
                                    <label for="chkIsResourceBillable">Billable</label>
                                </div>
                                <div class="custom_chckbox" id="divIsProductOwner">
                                    <% CommonFunctions.HTMLControls.DrawCheckBox("chkIsProductOwner", "chkIsProductOwner") %>
                                    <label for="chkIsProductOwner">Is Product Owner </label>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group">                           
                            <label class="col-sm-4 text-right">Responsibilities </label>
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

        <%--Added By Imran on 24-06-2021  for Resource Request--%>
        <div class="modal custmodal  fade" id="resourcerequest" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true" data-bs-backdrop="static" data-keyboard="false"  style="height:660px!important">
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
                                <li class="active" id="idReqDetails"><a href="#Rrequesttab"  data-bs-toggle="tab"  id="liareq" class="active">Request Details</a></li>
                                <%-- class="disabled"--%>
                                <li id="idSkill"><a href="#Rskillsettab"  data-bs-toggle="tab" id="liaskill">Skill Set </a></li>
                            </ul>
                            <ul style="display:none;margin-top: -28px;" id="skillnote" sty><li><span class="clsnoteskill"> Note : As per configuration, skill is not mandatory for raising resource request</span></li></ul>
                            <div class="tab-content ">
                                <div class="tab-pane active" id="Rrequesttab">
                                    <div class="row">

                            <%--Added by dipali V on 12th Nov 2022 For Sonata Customzation--%>
                                  <div class="form-group">
                                    <label class="col-sm-4 required" id="lblTypeOfReq" style="display:inline-flex">Type of Requirement </label>
                                   <div class="col-sm-8">
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectTOReq", "usp_Whizible2_Sel_TypeOfRequirement",,, "Onchange='ValidateReEmployeeName(this.value)' class='form-control'",,, ) %>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-sm-4">Replacement Employee Name <span id="spncboRRProjectRepEmployeeName" style="display:none;color:red">*</span></label>
                                   <div class="col-sm-8">
                                        <% CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectRepEmployeeName", "usp_Whizible2_Sel_ProjectAllocateActiveResource " & Session("intProjectID") & "",,, "class='form-control' disabled",,, ) %>
                                       <span id="spnidresourceEmployee" style="color:red;font-size:10px;display:none">Note : - Resource should release manually from project</span>
                                    </div>
                                </div>
                               <%-- End of Added by dipali V on 12th Nov 2022 For Sonata Customzation--%>



                                        <div class="form-group">
                                            <%-- Commented and added by Chetan M on 14th Jan 2020 for issue id 21225 --%>
                                            <%--<label class="col-sm-4">Project Role </label>--%>
                                            <label class="col-sm-4 required">Project Role </label>
                                            <%-- End of Commented and added by Chetan M on 14th Jan 2020 for issue id 21225 --%>
                                            <div class="col-sm-8">
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectRoleAdd", "usp_Whizible2_Sel_tbl_PM_Role_PopulateCombo",,, "class='form-control'",,, ) %>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">Vendor</label>
                                            <div class="col-sm-8">
                                                <% 'Added by Dipali V on 6th May 2026 for vendor management - Vendor selection in resource request creation %>
                                                <% CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectVendor", "usp_Whizible2_Sel_tbl_Whizible2_VendorMaster_Active",,, "class='form-control'",,, ) %>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <%--Commented And Added By Reshma Chavan on 7th March 2022 to change caption--%>
                                            <%--<label class="col-sm-4">No. Of Resources <span style="color: red">*</span></label>--%>
                                            <label class="col-sm-4"> No.of Resources<span style="color: red">*</span></label>
                                            <%--End of Commented And Added By Reshma Chavan on 7th March 2022 to change caption--%>
                                            <div class="col-sm-8 pl-0 pr-0">
                                             <div class="input-group col-sm-12">
                                                    <%--  <input type="text" class="form-control" value="06">--%>
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtnoofresource", "txtnoofresource", "form-control", 200, 3,,,,,,,, "onkeypress='return isNumberKey(event)' autocomplete='off'") %>
                                                </div>
                                            </div>
                                        </div>
                                        <!--   <div class="form-group">
                                    <label class="col-sm-4">Configuration</label>
                                    <div class="col-sm-8">
                                    <select class="form-control selectpicker">
                                      <option>Select</option>
                                      <option></option>
                                      <option></option>
                                    </select>
                                    </div>
                                    </div> -->
                                        <div class="form-group">
                                            <label class="col-sm-4">From Date  <span style="color: red">*</span></label>
                                              <div class="col-sm-8 pl-0 pr-0">
                                        <div class="input-group col-sm-12">
                                                    <div class="input-group datefielddiv">
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("RRstartdt", "RRstartdt", "form-control", , ,,,, , True, "white",, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>
                                                        <span class="input-group-btn">
                                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">To Date  <span style="color: red">*</span></label>
                                             <div class="col-sm-8 pl-0 pr-0">
                                        <div class="input-group col-sm-12">
                                                    <div class="input-group datefielddiv" id="DateDemo">
                                                        <% CommonFunctions.HTMLControls.DrawTextBox("RRenddt", "RRenddt", "form-control",,,,,,, True, "white",, "onPaste='return false' onkeypress='return Date_OnKeyPress(event)' Autocomplete='off'",,, True,,,, True) %>

                                                        <%--<% CommonFunctions.HTMLControls.DrawTextBox("RRenddt", "RRenddt", "form-control", 289, 3,,,,,,,, "autocomplete='off'") %>--%>
                                                        <%-- <input data-bs-toggle="tooltip" data-placement="top" title="Select End date" class="form-control" type="text" id="RRenddt" value="" />--%>
                                                        <span class="input-group-btn">
                                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-sm-4">Allocation Unit <span style="color: red">*</span></label>
                                              <div class="col-sm-8 pl-0 pr-0">
                                        <div class="input-group  col-sm-12">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cbotype", "usp_Whizible2_Sel_RequestedType_tbl_PM_ResourceRequest",,, "class='form-control'",,, ) %>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <%--Commented And Added By Reshma Chavan on 7th March 2022 to change caption--%>
                                            <%--<label class="col-sm-4">Work Hours <span style="color: red">*</span></label>--%>
                                            <label class="col-sm-4">Work hours per resource<span style="color: red">*</span></label>
                                            <%--Commented And Added By Reshma Chavan on 7th March 2022 to change caption--%>
                                             <div class="col-sm-8 pl-0 pr-0">
                                             <div class="input-group  col-sm-12">
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

                                        <div class="form-group">
                                            <label class="col-sm-4">Priority</label>
                                             <div class="col-sm-8 pl-0 pr-0">
                                        <div class="input-group  col-sm-12">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboRPriority", "usp_Whizible2_Sel_tbl_HR_Parameters 2",,, "class='form-control'",,, ) %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <%--Commented & Added By Rutuja D. 9 Jan 2020 For Adding New Id--%>
                                            <%--<label class="col-sm-4">Resource Pool </label>--%>
                                            <label class="col-sm-4" id="lblResourcePool">Resource Pool </label>

                                            <%--End of Commented & Added By Rutuja D. 9 Jan 2020 For Adding New Id--%>
                                            <div class="col-sm-8 pl-0 pr-0">
                                             <div class="input-group  col-sm-12">
                                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboResourcePools", "usp_Whizible2_Sel_tbl_PM_ResourcePoolMaster_ForCombo",,, "class='form-control'",,, ) %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">Special Request</label>
                                            <div class="col-sm-8">
                                                <textarea id="txtSpecialRequest" class="form-control" maxlength="300" placeholder='Enter Special Request (Maxlength 300 Char)' autocomplete="off"></textarea>

                                            </div>
                                        </div>


                                            <%-- Added by dipali V on 12th Nov 2022 For Sonata Customzation--%>
                                   <div class="form-group">
                                       <label class="col-sm-4 required" id="lbldepartment">Department </label>
                                       <div class="col-sm-8">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectDepartment", "usp_Whizible2_Sel_tbl_PM_DepartmentMaster",,, "class='form-control'",,, ) %>
                                        </div>
                                   </div>

                                  <div class="form-group">
                                       <label class="col-sm-4 required" id="lbllocation">Location </label>
                                       <div class="col-sm-8">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectLocation", "usp_Whizible2_Sel_tbl_PM_LocationMaster",,, "class='form-control'",,, ) %>
                                        </div>
                                   </div>

                                <div class="form-group">
                                       <label class="col-sm-4 required" id="lblEngagementModel">Engagement Model </label>
                                       <div class="col-sm-8">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectEngagementModel", "usp_Whizible2_Sel_EngagementModel",,, "class='form-control'",,, ) %>
                                        </div>
                                   </div>

                                 <div class="form-group">
                                       <label class="col-sm-4 required" id="lblBillablePosition">Billable Position </label>
                                       <div class="col-sm-8">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectBillablePosition", "usp_Whizible2_Sel_BillablePosition",,, "Onchange='ValidateBillingStartDate(this.value)' class='form-control'",,, ) %>
                                        </div>
                                   </div>

                                   <div class="form-group">
                                    <label class="col-sm-4">Billing Start Date <span id="spnRRillingStartDate" style="display:none;color:red">*</span></label>
                                    <div class="col-sm-8 ">
                                        <div class="input-group">
                                            <div class="input-group datefielddiv" id="DateDemo">
                                                <% CommonFunctions.HTMLControls.DrawTextBox("RRillingStartDate ", "RRillingStartDate", "form-control", , 3,,,,, True, "white",, "onchange='ValidateNatureofRequest()' autocomplete='off' disabled") %>
                                                <%-- <input data-bs-toggle="tooltip" data-placement="top" title="Select End date" class="form-control" type="text" id="RRenddt" value="" />--%>
                                                <span class="input-group-btn">
                                                    <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                       <label class="col-sm-4 required" id="lblSOWAv">SOW Available</label>
                                       <div class="col-sm-8">
                                            <% CommonFunctions.HTMLControls.DrawComboBox("cboRRProjectSOWAvailable", "usp_Whizible2_Sel_SOWAvailable",,, "onchange='ValidateNatureofRequest()' class='form-control'",,, ) %>
                                        </div>
                                   </div>

                                 <div class="form-group">
                                    <label class="col-sm-4">Nature of Request</label>
                                    <div class="col-sm-8 pl-0 pr-0">
                                        <div class="input-group  col-sm-12">
                                            <% CommonFunctions.HTMLControls.DrawTextBox("txtRNatureofRequest", "txtRNatureofRequest", "form-control",,,,, "",,,,, "autocomplete='off' disabled",,, True,,,, True) %>
                                        </div>
                                        
                                    </div>
                                </div>


                            <%--      <div class="attacment-file">
                                        <label class="col-sm-4"></label>
                                       <div class="col-sm-8">
                                            <div class="form-group">
                                                <div id="FileControlUploadDiv">
                                                    <%=CommonFunctions.HTMLControls.DrawFileControl("txtFileName0", "txtFileName0", , 74, , , , , , "onkeydown='return false;' onbeforepaste='return false;' onpaste='return false;' onchange='addFileinGrid()' style='display:none !important;' class='clsFileControl'", False,True)%>
                                                </div>
                                                <div class="input-group col-xs-12">
                                                     <span class="input-group-btn">
                                                         <input  type="file" name="img[]" class="file" id="MLAfilname0">
                                                         <div class="input-group col-xs-12 fileup"><span class="input-group-btn">
                                                             <button class="browse btn btn-primary input-lg" type="button"><i class="fas fa-paperclip" data-bs-toggle="tooltip" data-placement="bottom" data-container="body" title="JD Attachment"></i>JD Attachment</button></span></div>
                                                             <input type="text" class="form-control" disabled="" placeholder="Upload Files" style="background-color:white;border:none">
                                                       
                                                    </span>
                                                </div>
                                            </div>
                                   </div>
                                      
                                   </div>--%>


                                 <div class="attacment-file">
                                       <label class="col-sm-4 required" id="lblJDattachment">JD Attachment</label>
                                       <div class="col-sm-8" style="float:right; padding-left:0">
                                              <div class="form-group">
                                              <div id="FileControlUploadDiv" style="float:right">
                                               <%=CommonFunctions.HTMLControls.DrawFileControl("txtFileName0", "txtFileName0", , 74, , , , , , "onkeydown='return false;' onbeforepaste='return false;' onpaste='return false;' onchange='addFileinGrid()' style='display:none !important;' class='clsFileControl'", False, True)%>
                                               </div>
                                                            <div class="input-group col-xs-12">
                                                                <span class="input-group-btn">
                                                                    <button class="btn borderbtn" id="btnSelectFile" filecount="0" onclick="SelectFile();" type="button" title="JD Attachments" data-bs-toggle="tooltip"><i class="fa fa-paperclip mr-1" aria-hidden="true" title="JD Attachments" data-bs-toggle="tooltip"></i>JD Attachments</button>
                                                                </span>
                                                                 <%--&nbsp;<span style="color:red" id="SpnJDMandatory">*</span>--%>
                                                            </div>
                                                        </div>
                                     
                                            <div id="divAttachments" class="bottom-bar" style="">
                                                <div class="row">
                                                    <div class="col-sm-12 ">
                                                        <table id="tblFiles" style="display: none; width:100%; margin-top: -5%; margin-left:3px" class="clsGridTable table mb-0" >

                                                          <%--  <thead class="clsTRColumnHeader" align="left">
                                                                <tr>
                                                                    <th width="5%"></th>
                                                                    <th width="15%">Files</th>
                                                                    <th width="12%" width="49%">Comments</th>
                                                                    <th>Document Type</th>                                                                                
                                                                    <th width="20%">Document Sub Type</th>                                                                                
                                                                    <th width="25%">Remove</th>
                                                                </tr>
                                                            </thead>--%>
                                                            <tbody>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                                    </div>
                                                    </div>






                                        <div class="form-group">&nbsp;</div>
                                        <div class="form-group text-center">
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
                                                <th width="30%">Core Competency</th>
                                                <th>&nbsp;</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbodySkill">
                                        </tbody>
                                        <tfoot>
                                            <tr>
                                                <td  colspan="4">
                                                    <button id="addskillsetrow" class="btn borderbtn">Add Skill Set</button>
                                                    <%-- </td>
                                                    <td></td>
                                                    <td></td>
                                                    <td>--%>
                                                    <%--<button class="delskillset nostylebtn" disabled></button>--%>
                                                    <%-- <i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body" data-original-title="Delete" ></i>--%>
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

        <%--Added By Imran on 24-06-2021  for Skill confirmation --%>
        <div id="SaveSkillConformation" class="modal fade custmodal" role="dialog"  aria-hidden="true" data-bs-backdrop="static" data-keyboard="false" >
            <div class="modal-dialog modalsmall">
                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-bs-dismiss="modal" onclick="cancelToAddSkill()">&times;</button>
                        <h5 class="modal-title">Confirmation</h4>
                    </div>

                    <div class="modal-body">

                        <p align="center"> <span id="skillNames"></span>&nbsp; skill is not added to the Project,Do you wish to add?</p>

                        <div class="form-group mt-4">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 text-left">
                                    <button class="btn borderbtn ml-1" data-bs-dismiss="modal" onclick="cancelToAddSkill()">No</button>
                                </div>
                                <div class="col-xs-6 col-sm-6">
                                    <button class="btn btnyellow ml-1 pull-right" onclick="ProjectSkill_onClick(1)" data-bs-dismiss="modal">Continue</button>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="clearfix"></div>
        </div>

    </div>

    <!-- REQUIRED JS SCRIPTS -->
    
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
    <!-- alertify -->
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../EnhancementFiles/New_CommonFunctions.js"></script>
    <%--<script src="../../General/CommonValidations.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js?v=1.4"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
    <script src="../../../Whizible2.0-new/plugins/select2/select2.js"></script>
     <!--Added for FILTER-->
    <script src="../../../Whizible2.0-new/dist/js/common_filters.js"></script>
    

    <%--Added New Page By Imran 24-06-2021--%>
    <script>
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        //Added By Riddhesh Patil on 18-NOV-2022 
        var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
       //End of Added By Riddhesh Patil
        var ProjectID;
        var ProjectName;

        var strUrlAPI = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>'

        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-Project").ToString%>'
        var UserID = '<%= Session("intUserID") %>';
        //var SessionProjectID = "<%=ResourceProjectID%>";
        var UserName = '<%= Session("strUserName") %>';
        var LoginType = '<%= Session("LoginType") %>';
        var RoleID = '<%= Session("intPostID") %>';

        ProjectID = '<%= Request.QueryString("ProjectID")%>';
        var SessionProjectID = ProjectID;
        ProjectName = '<%= Request.QueryString("ProjectName")%>'; 
        ProjectName = unescape(ProjectName);//Added By Dipali V On 9th May 2023 For Project Name Truncate
        var arrChecked = new Array();
        var arrSelectedEmployeeNames = new Array();
        var arrSelectedEmployeeIds = new Array();
       
        var IsAgile = "";
        var oTableStaticFlow = "";

        var arrskillIDFilter = new Array();
        //Added By dipali v on 14th Nov 2022 For Sonata Customzation
        var arrGlobalrequestID = new Array();
        var SelectedCurrentdate = "";
        var ResourceAvaliableAllocation = "";

        // Added by imran 02-08-2021 filter variable
        var GlobalFilterName;
        var GlobalFilterFlag = 0;
        var GlobalFilterID = "";
        var GlobalApplyID;
        //End by imran 

        //19-07-2021 For filter Data
        var showsavefilter = 0;
        //Database column names
        var MLAllFields = ["UserName", "EmployeeName", "Department", "BusinessGroup", "Location", "RoleDescription", "DesignationName", "VendorName"];
        var MLAllFields1 = ["FUNm", "FRNM", "FDept", "FBG", "FOU", "FRole", "FDesig", "FVendor"];
        var MLAllFields2 = ["txtUserName", "txtResourceName", "CmbFDepartment", "CmbFBusinessGroup", "CmbFOrganizationUnit", "CmbFRole", "CmbFDesignation", "CmbFVendor"];
        var clearAllid = 0;
        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
        /* Added By Dipali V On 15th Nov 2022 For Sonata Customzation*/
        var Count_Request_ResourceSkill = '<%=Count_Request_ResourceSkill%>';
        var IsRequestResourceSkillMandatory = '<%=IsRequestResourceSkillMandatory%>';
        var IsResourceSkillCoreCompetencyMandatory = '<%=IsResourceSkillCoreCompetencyMandatory%>';
        var IsResourceRequestsplittingbased = '<%=IsResourceRequestsplittingbased%>';
        var IsResourceRequestNewFieldsManatory = '<%=IsResourceRequestNewFieldsManatory%>';
        /* End of Added By Dipali V On 15th Nov 2022 For Sonata Customzation*/
        var IsFileadded = 0;

        // Added By Vyankat B. on 19-Jun-2026 to trigger Show button click on Enter key press in Employee Name textbox.
        function EmployeeNameKeyPress(event) {

            if (event.key === "Enter" || event.keyCode === 13) {

                $('#show').click();

                return false;
            }

            return true;
        }
        // End of Added By Vyankat B. on 19-Jun-2026 to trigger Show button click on Enter key press in Employee Name textbox.

        //Added by Dipali V on 6th May 2026 for vendor management - set vendor placeholder without replacing first SP row
        function SetVendorDropdownPlaceholder() {
            if ($("#CmbVendor option[value='0']").length === 0) {
                $("#CmbVendor").prepend($("<option/>", { value: "0", text: "Select Vendor" }));
            }
            if ($("#CmbFVendor option[value='0']").length === 0) {
                $("#CmbFVendor").prepend($("<option/>", { value: "0", text: "Select Vendor" }));
            }
            if ($("#cboRRProjectVendor option[value='0']").length === 0) {
                $("#cboRRProjectVendor").prepend($("<option/>", { value: "0", text: "Select Vendor" }));
            }
            $("#CmbVendor").val("0");
            $("#CmbFVendor").val("0");
            $("#cboRRProjectVendor").val("0");
        }
        //Added by Codex on 11th May 2026 for project-level vendor mapping on resource selection page
        function FillProjectLevelVendorDropdowns(includeVendorID, selectedVendorID) {
            var projectIDForVendor = parseInt(SessionProjectID, 10) || 0;
            var requestParameters = {
                IncludeVendorID: includeVendorID || 0,
                ProjectID: projectIDForVendor
            };
            var vendorResult = AJAXCallWithResult("/api/PM_RequestedResources/GetVendorDropdown", JSON.stringify(requestParameters), false);
            var controls = ["#CmbVendor", "#CmbFVendor", "#cboRRProjectVendor"];
            for (var c = 0; c < controls.length; c++) {
                var ddl = $(controls[c]);
                ddl.empty();
                ddl.append($("<option/>", { value: "0", text: "Select Vendor" }));
                if (vendorResult != null) {
                    for (var i = 0; i < vendorResult.length; i++) {
                        ddl.append($("<option/>", { value: vendorResult[i].VendorID, text: vendorResult[i].VendorName }));
                    }
                }
                if (controls[c] === "#cboRRProjectVendor" && (selectedVendorID || 0) > 0) {
                    ddl.val((selectedVendorID || 0).toString());
                } else {
                    ddl.val("0");
                }
            }
        }
        $(document).ready(function () 
        {
           // alert(ProjectID + ' ' + SessionProjectID);

            $("#CmbRole").val(RoleID);
            FillProjectLevelVendorDropdowns(0, 0);
            SetVendorDropdownPlaceholder();

            //Fill Datatable
            $("#ResourceClearAllFilter").hide();            
            ResourceFilters();
            $(".LIResourceALBasicFilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("active");
            $('ul#ResourceALBasicFilter li a:last').parents('li').addClass('active');
            $(".LIResourceALBasicFilter").addClass("active");
             $("#presetfilterAR").addClass("active");
            
            $("#divPMResource").removeClass("preloader");
            $(".table").resize();
            // Added by Dipali V on 13th May 2026 - Purpose:-Keep resource selection grid column widths correct on window resize (no scrollX/Y split).
            $(window).on("resize.rsrsSelectionGrid", function () {
                if ($.fn.DataTable.isDataTable("#RsrsSelctionTble")) {
                    $("#RsrsSelctionTble").DataTable().columns.adjust();
                }
                resizeSection();
            });

            //Added By Dipali V On 12th Nov 2022 For Sonata Customzation
            const month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            //debugger;
            const today = new Date();
            today.setDate(today.getDate() + 30);
            const yyyy = today.getFullYear();
            let mm = month[today.getMonth()]; // Months start at 0!
            let dd = today.getDate();

            if (dd < 10) dd = '0' + dd;
            if (mm < 10) mm = '0' + mm;
            const formattedToday = dd + ' ' + mm + ' ' + yyyy;
            $("#RRillingStartDate").val(formattedToday);
          
            $('#PlanEndDate,#PlanStartDate,#RRillingStartDate').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                yearRange: 'c-100:c+100',
                dateFormat: 'dd M yy',
                //onSelect: function (date, datepicker) {
                //    $(".tooltip").removeClass('show');
                //}//added by pradip on 23-12-2022 for tooltip issue

            });

            if (IsResourceRequestNewFieldsManatory == 0 || IsResourceRequestNewFieldsManatory == "False") {
                $("#lblTypeOfReq").removeClass("required");
                $("#spncboRRProjectRepEmployeeName").css("display", "none");
                $("#spnidresourceEmployee").css("display", "none");
                $("#lbldepartment").removeClass("required");
                $("#lbllocation").removeClass("required");
                $("#lblJDattachment").removeClass("required");
                $("#lblEngagementModel").removeClass("required");
                $("#lblBillablePosition").removeClass("required");
                $("#lblSOWAv").removeClass("required");
                $("#spnRRillingStartDate").css("display", "none");
                $("#SpnJDMandatory").css("display", "none");
            }

            $(".tooltip").removeClass('show');
             //End of Added By Dipali V On 12th Nov 2022 For Sonata Customzation
       

            $('#PlanEndDate,#PlanStartDate,#RRillingStartDate').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd M yy',
                //onSelect: function (date, datepicker) {
                //    $(".tooltip").removeClass('show');
                //}//added by pradip on 23-12-2022 for tooltip issu
            });

            //Hidden Date Show
            $('#txtToday').datepicker({
                autoclose: true,
                changeMonth: true,
                dateFormat: 'dd M yy',
                //onSelect: function (date, datepicker) {
                //    $(".tooltip").removeClass('show');
                //}//added by pradip on 23-12-2022 for tooltip issu
            });
            $('#txtToday').datepicker('setDate', new Date());

            //Resource Request Date format
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

            //Added by Imran 28-06-2021 Check Resource Request  Or  Allocate Resource Button Visible 
            $.ajax({
            url: strUrl + '/api/Common/GetCompanyInformation',
            type: "POST",
            dataType: "json",
            contentType: "application/json;charset-utf=8",
            async: false,
            beforeSend: function (xhr) {
                xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
            },
               success: function (data)
               {
                   for (var i = 0; i < data.length; i++)
                   {
                    var d = data[i];                    
                       enableResourceAllocation = d.AllowResourceAllocation;

                       if (enableResourceAllocation == 0) {
                            $("#selectResource").css("display", "inline-block");
                            $("#btnResourceRequest").css("display", "none");
                       }
                       else {
                            $("#selectResource").css("display", "none");
                            $("#btnResourceRequest").css("display", "inline-block");
                       }
                    }
                },
               error: function (err)
               {
                console.log(err);
                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
            }
        });
            //End By Imran 28-06-2021
        });

         function cancelToAddSkill() {

             ProjectSkillAdd = 0;
             arrSkill = [];
             arrmonth = [];
             arrRate = [];
             arryear = [];
             arrSkillNotPRoject = [];
             arrIsCoreCompetency = [];
             Skillname = "";
        }

        function removeDuplicates(arr) {
            return arr.filter((item,
                index) => arr.indexOf(item) === index);
        }


         //Added by Imran on 24-06-2021 
        function PlotRequestResources()
        {   
            $('input').filter(':checkbox').prop('checked', false);
            $("#tblFiles").html('');
            GlobalrequestID = 0;
            $("#tbodySkill").html("");
            $("#resourcerequest").modal('show');

            $("#idReqDetails").addClass("active");
            $("#idSkill").removeClass("active");
            $("#Rskillsettab").removeClass("active");
            $("#Rrequesttab").addClass("active");
            //$("#idSkill").addClass("disabled");
            cancelRequest();
            if (GlobalrequestID != 0) {
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

            $("#resourcerequest").modal('show');
            $(".tooltip").removeClass('show');
            addReqDetails();
            $('.btn').tooltip({ trigger: 'hover' });
            $('span').tooltip({ trigger: 'hover' });
            $('.ui-datepicker-calendar th span').tooltip('hide');
            $('.tooltip-inner').tooltip('hide');


        }

        $("#cboRRProjectLocation").on("change", function () {

            $('.btn').tooltip({ trigger: 'hover' });
            $('span').tooltip({ trigger: 'hover' });
            $('.ui-datepicker-calendar th span').tooltip('hide');
            $('.tooltip-inner').tooltip('hide');
            $(".tooltip").removeClass('show');
        });


        $('#resourcerequest').on('change', '.form-control', function () {

            $('.btn').tooltip({ trigger: 'hover' });
            $('span').tooltip({ trigger: 'hover' });
            $('.ui-datepicker-calendar th span').tooltip('hide');
            $('.tooltip-inner').tooltip('hide');
        });
        //Added by imran 24-06-2021 Grid fill
        function CreateDataTable()
        {
            //debugger;
            if ($.fn.DataTable.isDataTable("#RsrsSelctionTble")) {
                $("#RsrsSelctionTble").DataTable().destroy();
            }

            var tot = 0;  var url="";
            var Parameters
            //showsavefilter=1 means for filter
            if (showsavefilter == 1)
            {
                $("#CmbRole").prop('selectedIndex',0);
                $("#CmbDesignation").prop('selectedIndex',0);
                $("#CmbDepartment").prop('selectedIndex',0);
                $("#CmbBusinessGroup").prop('selectedIndex',0);
                $("#CmbOrganizationUnit").prop('selectedIndex',0);
                $("#CmbVendor").prop('selectedIndex',0);
                $("#txtEmpName").val('');
                url= encodeURI(strUrl) + '/api/PM_Resource_Selection/GetResourcesListAsPerBasicFilter'
            }
            else
            {
               ClearFilter();
               url= encodeURI(strUrl) + '/api/PM_Resource_Selection/GetResourcesList'
            }

            oTableStaticFlow = $("#RsrsSelctionTble").DataTable({
                "processing": true,
                "destroy": true,
                "paging": true,
                "autoWidth": true,
                "pageLength": 10,
                "bLengthChange": false,
                "bFilter": false,
                "ordering": false,
                "responsive": false,
                "retrieve": true,
                "info": false,               
                
                "ajax":
                {
                        'url': url,                   
                        'data': function (d)
                        {      
                            if (showsavefilter == 0)
                            {   
                                d.ProjectID = SessionProjectID
                                d.Role = $("#CmbRole option:selected").text(),
                                d.DesignationName = $("#CmbDesignation option:selected").text(),
                                d.Department = $("#CmbDepartment option:selected").text(),
                                d.BusinessGroup = $("#CmbBusinessGroup option:selected").text(),
                                d.Location = $("#CmbOrganizationUnit option:selected").text(),
                                d.Vendor = $("#CmbVendor option:selected").text(),
                                d.EmployeeName = $("#txtEmpName").val().trim()  
                                //Added by imran trim() to remove space when show
                                Parameters = JSON.stringify(d);
                                return JSON.stringify(d);
                            }
                            else
                            {
                                showsavefilter = 0;

                                d.ProjectID = SessionProjectID
                                d.FDept = $("#FDept option:selected").text(),
                                d.Department = $("#CmbFDepartment option:selected").text(),
                                d.FBG = $("#FBG option:selected").text(),
                                d.BusinessGroup = $("#CmbFBusinessGroup option:selected").text(),
                                d.FOU = $("#FOU option:selected").text(),
                                d.Location = $("#CmbFOrganizationUnit option:selected").text(),
                                d.FRole = $("#FRole option:selected").text(),
                                d.Role = $("#CmbFRole option:selected").text(),
                                d.FDesig = $("#FDesig option:selected").text(),
                                d.DesignationName = $("#CmbFDesignation option:selected").text(),
                                d.FVendor = $("#FVendor option:selected").text(),
                                d.Vendor = $("#CmbFVendor option:selected").text(),
                                d.FUNm = $("#FUNm option:selected").text(),
                                d.UserName = $("#txtUserName").val().trim(),
                                d.FRNM = $("#FRNM option:selected").text(),
                                d.ResourceName = $("#txtResourceName").val().trim()  
                                //Added by imran .trim() function 19-08-2021
                                Parameters = JSON.stringify(d);
                                return JSON.stringify(d);
                            }   
                        },
                        'type': "POST",               
                        'dataType': "json",
                        'async': false,                      
                        'beforeSend': function (xhr)
                        {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                            if (Parameters) {
                                xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                            }
                        },                        
                        'contentType': "application/json;charset-utf=8",
                        'dataType': "json",                       
                        dataSrc: function (result) 
                        {                               
                            var data = [];
                            for (var r1 in result) 
                            {
                                tot += 1;
                                var data1 = result[r1];                               
                                data.push([
                                    data1['UserName'],
                                    data1['EmployeeName'],
                                    data1['BusinessGroup'],
                                    data1['Department'],
                                    data1['Location'],
                                    data1['RoleDescription'],
                                    data1['DesignationName'],
                                    data1['Deployable'],
                                    data1['EmployeeID'] + '~' + data1['RoleId'],
                                    data1['EmployeeID'] + '~' + data1['EmployeeName']
                                ]);
                            }
                            return data;
                         }
                },                    
                "columns":
                    [     
                        {
                            "data": 0,
                            "render": function (data, type, row, meta) {
                                var nm = String(row[1] || "").replace(/\s+/g, '%20');
                                return "<a href='javascript:;' onclick=ResourceNameClick('" + nm + "')>" + row[0] + "</a>";
                            }
                        },
                        { "data": 1 },
                        { "data": 2 },
                        { "data": 3 },
                        { "data": 4 },
                        { "data": 5 },
                        { "data": 6 },
                        { "data": 7 },
                        {
                            "data": 8,
                            "render": function (data, type, row, meta) {
                                return "<a href='javascript:;' onclick=ResourceLoading('" + data + "')>Resource Loading</a>";
                            }
                        },
                        {
                            "data": 9,
                            "orderable": false,
                            "render": function (data, type, row, meta) {
                                return "<input type='checkbox' id='" + data + "' name='checkitem' class='checkitem' value='" + data + "' onchange='selectedCheckbox(this)'/>";
                            }
                        }
                    ],
                //Added by Dipali V on 6th May 2026 for vendor management - keep header/tbody alignment after Show/filter reload
                //Added by Dipali V on 13th May 2026 - Purpose:-No scrollX/Y split table; adjust columns after draw for width stability.
                "drawCallback": function () {
                    var dtApi = $("#RsrsSelctionTble").DataTable();
                    dtApi.columns.adjust();
                    resizeSection();
                },
                "initComplete": function () {
                    var dtApi = $("#RsrsSelctionTble").DataTable();
                    setTimeout(function () {
                        dtApi.columns.adjust();
                        resizeSection();
                    }, 50);
                }
            });

            $(".table").resize();
        }

        //Resource Name Alert
        function ResourceNameClick(id)
        {
            var Empnm = id.replace(/%20/g,' ');          
            //alert(Empnm);
        }

        //Click on grid resource loading
        function ResourceLoading(data)
        {
            var EmpId = "";
            var RoleId = "";
            var n = data.split('~');
            EmpId = n[0];
            RoleId = n[1];
            generatetokenResourceLoading(RoleId, EmpId);

            //return false;
            var url = "../PM/PM_ResourceLoading.aspx?PKToken=" + m_CurrentToken + "&ProjectEmployeeRoleID=" + RoleId + "&ProjectID=" + ProjectID + " &EmployeeID=" + EmpId + "&UserID=" + UserID + "&ProjectName=" + ProjectName + "&OldNewUi=" + UserID;
            window.location.href = url;
        }

        //Clear All hide show Filter  value
        function ClearFilter()
        {
            $("#txtFilterName").val('');
            $("#FUNm").val("Contains");          
            $("#txtUserName").val("");
            $("#FRNM").val("Contains");
            $("#txtResourceName").val("");
            $("#FDept").val("=");
            $('#CmbFDepartment').prop('selectedIndex',0);
            $("#FBG").val("=");
            $('#CmbFBusinessGroup').prop('selectedIndex',0);           
            $("#FOU").val("=");            
            $('#CmbFOrganizationUnit').prop('selectedIndex',0);
            $("#FRole").val("=");
            $('#CmbFRole').prop('selectedIndex',0);           
            $("#FDesig").val("=");
            $('#CmbFDesignation').prop('selectedIndex',0);
            $("#FVendor").val("=");
            $('#CmbFVendor').prop('selectedIndex',0);
        }

        function resizeSection()
        {
            var tblheight = $(window).height();
            var h = Math.max(220, tblheight - 360);
            // Added by Dipali V on 13th May 2026 - Purpose:-Outer scroll when DataTables scrollY disabled (no .dataTables_scrollBody).
            $("#RsrsSelctionTableWrap").css({ "max-height": h, "overflow": "auto" });
            var $legacyBody = $("#RsrsSelctionTble_wrapper .dataTables_scrollBody");
            if ($legacyBody.length) {
                $legacyBody.css({ "height": h, "overflow-y": "auto" });
            }
        }

        //Generate token value
        var m_CurrentToken = '';
        function generatetokenResourceLoading(ResourceUTProjectEmployeeRoleID, ResourceUTEmployeeID)
        {
            try
            {
                var ProjectEmployeeRoleID = ResourceUTProjectEmployeeRoleID;
                var EmployeeID = ResourceUTEmployeeID;
                if (ProjectID != undefined)
                {                    
                    var generatedtoken = ajaxCall("PM_Resource_Selection.aspx/GeneratePK_TokenUtilization", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: ProjectID, ProjectEmployeeRoleID: ProjectEmployeeRoleID, EmployeeID: EmployeeID }));
                    if (generatedtoken != undefined)
                    {
                        m_CurrentToken = generatedtoken.d;      
                        validatetokenResourceLoading(m_CurrentToken,ResourceUTProjectEmployeeRoleID, ResourceUTEmployeeID);
                    }
                }
            }
            catch (ex)
            {}
        }

         //Added By Dipali V On 24th Feb 2021 For Day Wise Resource Allocation
        function GetResourceAllocation()
        {
            var StartDate = $("#PlanStartDate").val();
            var EndDate = $("#PlanEndDate").val();
            var selectedProjectID = $("#cboProjectAdd").val(); 
            //RAtaglisthidden
            var SelectedEmployeeIDs = $("#RAtaglist").val()
            if (SelectedEmployeeIDs.length == 1) {
                //return;
                //Added By Dipali V On 11th Feb 2021 For Validate Resource Avaliable %
                //Added By Dipali V On 28th March 2023 For Resource Allocation Issue
                //ResourceAvaliableAllocation = GetAvaliableAllocation(StartDate, EndDate, SelectedEmployeeIDs, selectedProjectID);
                ResourceAvaliableAllocation = GetAvaliableAllocation(StartDate, EndDate, SelectedEmployeeIDs.toString(), selectedProjectID);
                //End of Added By Dipali V On 28th March 2023 For Resource Allocation Issue
                $("#txtResourcePercentage").val("");
                $("#txtResourcePercentage").val(ResourceAvaliableAllocation);                 
                //End of Added By Dipali V On 11th Feb 2021 For Validate Resource Avaliable %
            }
        }

        //Check Validate  token value
        var m_PKToken;
        function validatetokenResourceLoading(m_CurrentToken,ResourceUTProjectEmployeeRoleID, ResourceUTEmployeeID) {
            try {              
                var ProjectEmployeeRoleID = ResourceUTProjectEmployeeRoleID;
                var EmployeeID = ResourceUTEmployeeID;
                m_PKToken = m_CurrentToken;

                if (ProjectID != undefined) {
                    var validatetoken = ajaxCall("PM_Resource_Selection.aspx/ValidatePK_TokenUtilization", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: ProjectID, ProjectEmployeeRoleID: ProjectEmployeeRoleID, EmployeeID: EmployeeID, PKToken: m_PKToken }));
                    if (validatetoken != undefined)
                    {
                        if (validatetoken.d == false) {
                            window.location.href = "../../General/CommonPage.aspx?MasterTagID=1836";
                        }
                    }
                }
            }
            catch (ex) {
                //alert(ex.message());
            }
        }

        //Added by imran 24-06-2021 Check and uncheck All gied check box
        $("#Checkall").change(function ()
        {          
            //oTableStaticFlow.page(392-1).draw(false);
            
            var info = oTableStaticFlow.page.info();          
            var tmax = ((info.page + 1) * 10) - 1;                       
            if (tmax == 9)
            {
                 var tmin = 9;
            }
            else {
                 var tmin = tmax - 10;
            }          

            arrSelectedEmployeeNames=[];
            arrSelectedEmployeeIds=[];
            arrChecked = [];
            var cells = oTableStaticFlow.column(9).nodes(), state = this.checked;

            for (var i = 0; i < cells.length; i += 1)
            {              
                //if (i <= 9)
                //{
                //     cells[i].querySelector("input[type='checkbox']").checked = state;
                //}

                if (i < tmin && tmax == 9)
                {                      
                     cells[i].querySelector("input[type='checkbox']").checked = state;
                }
                else if (i >= tmin + 1 && i <= tmax + 1)
                {
                     cells[i-1].querySelector("input[type='checkbox']").checked = state;
                }
            }

            var grid = document.getElementById("RsrsSelctionTble");           
            var checkBoxes = grid.getElementsByTagName("INPUT");
            var message = "";
            for (var i = 0; i < checkBoxes.length; i++)
            {
                if (checkBoxes[i].checked)
                {
                    var Empid; var Empnm; var tdata;                     

                    tdata =  checkBoxes[i].value.split('~');
                    Empid = tdata[0];
                    Empnm = tdata[1];
                    arrSelectedEmployeeNames.push(Empnm);
                    arrSelectedEmployeeIds.push(Empid);
                    arrChecked.push(Empid);
                }
            }
        });

        //Added by imran 08-07-2021 When popup open click on cross icon that time all the values clear
        $("#btnclose").click(function ()
        {
            SelectedEmployeeIDs = "";
            arrChecked = [];
            arrSelectedEmployeeNames = [];
            arrSelectedEmployeeIds = [];
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
            $("#Checkall").prop("checked", false);

            //Clear DatatableCheckbox
            ClearCheckbox();
        });
        //End by imran 08-07-2021

        //Added By Imran 02-08-2021
        $("#Back").click(function ()
        {
            window.location.href = "PM_Resources.aspx";
        });
        //end By Imran 02-08-2021

        //Added by imran Grid value as per criteria show data
        $("#show").click(function ()
        {
            arrSelectedEmployeeNames=[];
            arrSelectedEmployeeIds=[];
            arrChecked = [];

            $('input').filter(':checkbox').prop('checked', false);
            alertify.set('notifier', 'position', 'top-right');

            if ( $("#CmbRole option:selected").text() == "Select Role" && $("#CmbDesignation option:selected").text() == "Select Designation" && $("#CmbDepartment option:selected").text() == "Select Department" && $("#CmbBusinessGroup option:selected").text() == "Select Business Group" && $("#CmbOrganizationUnit option:selected").text() == "Select Organization Unit")
            {
                alertify.error('Select Role');
                $("#CmbRole").focus();
                return;
                //$("#txtEmpName").val('');
                //StartLoader("#AddNewResource");         
                //CreateDataTable();
                //StopAjaxLoader("#AddNewResource");
            }
            else
            {
                if ($("#CmbRole option:selected").text() == "Select Role")
                {
                    $("#txtEmpName").val('');
                    alertify.error('Select Role From Filter Section');
                    $("#CmbRole").focus();              
                }
                else
                {
                    StartLoader("#AddNewResource");         
                    CreateDataTable();
                    StopAjaxLoader("#AddNewResource");
                    $("#divPMResource").removeClass("preloader");               
                } 
            }

            $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();
            $('table.tbl_rsrsselection').resize();

        });
        //End By Imran 


         //Added by imran 19-07-2021  Filter
        $("#showsavefilter").click(function ()
        {
            arrSelectedEmployeeNames=[];
            arrSelectedEmployeeIds=[];
            arrChecked = [];

            $('input').filter(':checkbox').prop('checked', false);

            var MLQueryText = BtnApplyMLBasicQuery();  

            if (MLQueryText.length > 0)
            {
                showsavefilter = 1;
                StartLoader("#AddNewResource");         
                CreateDataTable();
                //Added by imrn 10-08-2021 To show clear all and selected filter in color
                $("#ResourceClearAllFilter").show();
                $("#ResourceFilter").addClass("activefilter"); 

                $(".filterpanel ").removeClass("in");
                $("#DivStakeholderFilter").addClass("active");
                $("#presetfilter").removeClass("active");
                $("#basicfilterli").hasClass("active");
                {
	                $("#basicfilterli").removeClass("active");
                }
                $("#btnAdvFilter").attr("aria-expanded", false);
                $("#filterpanel").removeClass("in"); 
                $("#Issuesavefilter").modal('hide');
            }
            else
            {
                alertify.set('notifier', 'position', 'top-right');
                setTimeout(function ()
                {
                   alertify.error("Please Select at least one Filter Field.");
                }, 2000);              
            }           
            // end By imran 10-08-2021
            StopAjaxLoader("#AddNewResource");
            $("#divPMResource").removeClass("preloader");
                                   
        });
        //End By Imran 19-07-2021

        // Added by Imran 24-06-2021 Select Resource Button click
        $("#selectResource").click(function ()
        {        
            alertify.set('notifier', 'position', 'top-right');
            var selectedLanguage = [];
            ResourceAvaliableAllocation = "";

            //Datatable with pagination Selected Checkbox value save
            var rows = $("#RsrsSelctionTble").dataTable().fnGetNodes();
            for (var i = 0; i < rows.length; i++)
            {             
                if ($(rows[i]).find('input[name="checkitem"]:checked').is(':checked'))
                {
                    var Empnm = $(rows[i]).find('input[name="checkitem"]:checked').val().replace(/%20/g,' '); 
                    selectedLanguage.push(Empnm);
                }
            }

            if (selectedLanguage.length == 0)
            {
                alertify.error("Select Atleast One Resource", "error");                
                return false;
            }
            else if (arrChecked.length > 10)
            {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("You can not select more than 10 Resources");
            }
            else
            {              
                var flag = 0;
                var SelectedResourceNames = "", SelectedEmployeeIDs = "";
                $("select option").removeAttr("title");
                var objRAtaglist = document.getElementById("RAtaglist");
                $("#RAtaglist option").remove();


              
                for (var i = 0; i < arrChecked.length; i++) {

                    if (arrSelectedEmployeeIds[i] == "on")
                        continue;

                    flag = 1;
                    var objOptionobjRAtaglist = document.createElement("OPTION");
                    objRAtaglist.options.add(objOptionobjRAtaglist);
                    objOptionobjRAtaglist.text = arrSelectedEmployeeNames[i];
                    objOptionobjRAtaglist.value = arrSelectedEmployeeIds[i];
                    if (SelectedEmployeeIDs == "") {
                        SelectedEmployeeIDs += arrSelectedEmployeeIds[i];
                    }
                    else {
                        SelectedEmployeeIDs += ',' + arrSelectedEmployeeIds[i];
                    }
                }
                
            $("#RAtaglist").val(SelectedEmployeeIDs.split(",")); 
            //$("#RAtaglist").select2();

            if (flag == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select at least one Resource.");
                $("#bulkallocation").modal('hide');
                return;
            }
            else
            {
                $("#bulkallocation").modal('show');
            }
                
            document.getElementById("RAtaglisthidden").value = SelectedEmployeeIDs;
            var selectedProjectID = ProjectID;
            var selectedProjectName = ProjectName;

            var objCbo1 = document.getElementById("cboProjectAdd");
            $("#cboProjectAdd option").remove();
            var objOption = document.createElement("OPTION");
            objCbo1.options.add(objOption);
            objOption.text = selectedProjectName;
            objOption.value = selectedProjectID;
            jQuery("select#cboProjectAdd option[value=" + selectedProjectID + " ]").attr("selected", "selected");
         
            var CurrentDate = $("#txtToday").val();
            $("#PlanStartDate").val(CurrentDate);

            var result = GetProjectStartDateEndDate(ProjectID);

            for (var i = 0; i < result.length; i++) {
                var ProjectEndDate = result[i].expectedenddate;
            }

            if (Date.parse(ProjectEndDate) > Date.parse(CurrentDate))
            {
                ProjectEndDate = ProjectEndDate;

            } else {
             ProjectEndDate = "";

            }           
            $("#PlanEndDate").val(ProjectEndDate);            
                            
            var mystring = SelectedEmployeeIDs;          
            SelectedEmployeeIDs = mystring.split(",");

           
            if (SelectedEmployeeIDs.length > 1)
            {
                $("#txtResourcePercentage").val('');
                $("#divIsDefaultApprover").css("display", "none");
                $("#divIsProductOwner").css("display", "none");
            }
            else
            {
                $("#divIsDefaultApprover").css("display", "block");
                
                Empid = SelectedEmployeeIDs;
                ResourceAvaliableAllocation = "";
                //Added By Dipali V On 28th March 2023 For Resource Allocation Issue
                //ResourceAvaliableAllocation = GetAvaliableAllocation(CurrentDate, ProjectEndDate, Empid, selectedProjectID);
                ResourceAvaliableAllocation = GetAvaliableAllocation(CurrentDate, ProjectEndDate, Empid.toString(), selectedProjectID);
                //End of Added By Dipali V On 28th March 2023 For Resource Allocation Issue
                $("#txtResourcePercentage").val(ResourceAvaliableAllocation);              
                               
                IsAgile = CheckIsAgileProject(ProjectID);
                if (IsAgile == 0) {
                        $("#divIsProductOwner").hide();
                    }
                    else {
                        $("#divIsProductOwner").show();
                    }
                }

             // ReportingTo Combo Fill
             GetReportingToInEditMode();

              // clearTooltip();
           
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
        
            $("#cboProjectRoleAdd").val("");          
            $("#cboProjectRoleAdd").val(0);
          
            var DefaultApproverID = GetDefaultApprover();
            if (DefaultApproverID != "") {
                $("#cboReportingToAdd").val(DefaultApproverID);
            }
            else {
                $("#cboReportingToAdd").val("");
            }
          
             $("#btnCreateReq").removeAttr("disabled");
               $("#bulkallocation").modal('show');
            }           
        });


        //function on Save and Apply button in Milestone
        $("#svfilterbtn").click(function ()
        {
            //Tag id 36009 resource selection temporarly
            var TagID = 36009;
            var MLQueryText = BtnApplyMLBasicQuery();

            if (MLQueryText.length > 0)
            {
                $('#spanTagId').attr('value', TagID);
                $("#Issuesavefilter").modal("show");
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Please Select at least one Filter Field.");
            }
            return false; 
        });

        //Filter SAve and apply query generate
        function BtnApplyMLBasicQuery()
        {
            var MLQueryText = "";

            for (var i = 0; i < MLAllFields.length; i++)
            {
                var MilestoneFilterText = '';
                var MLFilterOperator = $('select#' + MLAllFields1[i] + ' option:selected').text();

                if (i <= 1) {
                    var MilestoneFilterText = $('#' + MLAllFields2[i]).val().trim();                   
                }
                else {
                    var MilestoneFilterText = $('select#' + MLAllFields2[i] + ' option:selected').text();
                }                

                MilestoneFilterText = MilestoneFilterText.replace(/'/g, "''''")               

                if (MilestoneFilterText != "" && MilestoneFilterText != "0" && MilestoneFilterText != "null" && MilestoneFilterText != null)
                {
                    if (MLFilterOperator == "Contains") {
                        if (MLQueryText != "") {
                            MLQueryText += " AND V_tbl_PM_Resource_Selection." + MLAllFields[i] + " LIKE ";
                            MLQueryText += " ''%" + MilestoneFilterText + "%'' ";
                        }
                        else {
                            MLQueryText += " tbl_PM_Milestones." + MLAllFields[i] + " LIKE ";
                            MLQueryText += " ''%" + MilestoneFilterText + "%''";
                        }
                    }
                    else if (MLFilterOperator == "Ends With") {
                        if (MLQueryText != "") {                           
                            MLQueryText += " AND V_tbl_PM_Resource_Selection." + MLAllFields[i] + " LIKE ";  
                            MLQueryText += " ''%" + MilestoneFilterText + "''";
                        }
                        else {
                            MLQueryText += " V_tbl_PM_Resource_Selection." + MLAllFields[i] + " LIKE ";
                            MLQueryText += " ''%" + MilestoneFilterText + "''";
                        }
                    }
                    else if (MLFilterOperator == "Exact Words")
                    {
                        if (MLQueryText != "")
                        {                           
                            MLQueryText += " AND V_tbl_PM_Resource_Selection." + MLAllFields[i] + " = ";
                            MLQueryText += " ''" + MilestoneFilterText + "''";
                        }
                        else {                           
                            MLQueryText += " V_tbl_PM_Resource_Selection." + MLAllFields[i] + " = ";
                            MLQueryText += " ''" + MilestoneFilterText + "''";
                        }
                    }
                    else if (MLFilterOperator == "Not Contains")
                    {
                        if (MLQueryText != "") {                           
                            MLQueryText += " AND V_tbl_PM_Resource_Selection." + MLAllFields[i] + "";                           
                            MLQueryText += " NOT LIKE ''" + MilestoneFilterText + "%''";
                        }
                        else {                           
                            MLQueryText += " V_tbl_PM_Resource_Selection." + MLAllFields[i] + " ";
                            MLQueryText += " NOT LIKE ''" + MilestoneFilterText + "%''";
                        }
                    }
                    else if (MLFilterOperator == "Starts With")
                    {
                        if (MLQueryText != "") {                           
                            MLQueryText += " AND V_tbl_PM_Resource_Selection." + MLAllFields[i] + "";
                            MLQueryText += " LIKE ''" + MilestoneFilterText + "%''";
                        }
                        else {                           
                            MLQueryText += " V_tbl_PM_Resource_Selection." + MLAllFields[i] + " ";
                            MLQueryText += " LIKE ''" + MilestoneFilterText + "%''";
                        }
                    }   
                    else if (MLFilterOperator == "<>")
                    {
                        if (MilestoneFilterText == "Select Department" || MilestoneFilterText == "Select Business Group" || MilestoneFilterText == "Select Organization Unit" || MilestoneFilterText == "Select Role" || MilestoneFilterText == "Select Designation") {

                        }
                        else
                        {
                            if (MLQueryText != "")
                            {
                                MLQueryText += " AND V_tbl_PM_Resource_Selection." + MLAllFields[i] + "";
                                MLQueryText += " <> ''" + MilestoneFilterText + "''";
                            }
                            else {
                                MLQueryText += " V_tbl_PM_Resource_Selection." + MLAllFields[i] + " ";
                                MLQueryText += " <> ''" + MilestoneFilterText + "''";
                            }
                        }                        
                    }

                    else if (MLFilterOperator == "=") 
                    {
                        if (MilestoneFilterText == "Select Department" || MilestoneFilterText == "Select Business Group" || MilestoneFilterText == "Select Organization Unit" || MilestoneFilterText == "Select Role" || MilestoneFilterText == "Select Designation") {

                        }
                        else
                        {
                            if (MLQueryText != "")
                            {
                                MLQueryText += " AND V_tbl_PM_Resource_Selection." + MLAllFields[i] + "";                               
                                MLQueryText += "= ''" + MilestoneFilterText + "''";
                            }
                            else
                            {
                                MLQueryText += " V_tbl_PM_Resource_Selection." + MLAllFields[i] + " ";
                                MLQueryText += "= ''" + MilestoneFilterText + "''";
                            }
                        }
                    }

                }                
            }
            return MLQueryText;
        }


        //Function to save the filter and Apply the filter 
        var savedFilterName = "";
        $("#btnSaveAndApplyFilter").click(function ()
        {          
            var tagid = $("#spanTagId").attr("value");
            var FilterName = $("#txtFilterName").val();          
            if (FilterName != GlobalFilterName)
            {               
                FilterID = 0;
                FilterId = 0;
            }
            ////End Added By rutuja D. on 24 OCt 2020 For Set FilterID 0
            FilterName = FilterName.replace(/'/g, "''");
            if (FilterName != "" && FilterName != null)
            {
                var filterExists = 0;
                if (savedFilterName == "")
                {
                    filterExists = checkDuplicateFilter(GlobalFilterFlag, GlobalFilterID, FilterName, tagid);
                }  
                      
                if (filterExists == 0)
                {
                    //Commnet and Added By Riddhesh Patil on 15-NOV-2022 
                    if (checkSpecialCharacter(FilterName, WebConfigSpecialCharacters) == true) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Filter Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                        $("#txtFilterName").focus();
                        addReqDetails();
                        return false;

                    }
			//End of Comment Added By Riddhesh Patil
                   else  if (tagid == 36009)
                    {                       
                        MilestoneSaveAndApplyFilter(FilterName);
                        $("#txtFilterName").val("");

                      
                        //$("#StakeholderClearAllFilter").show();                     
                        //$(".filterpanel ").removeClass("in");
                        //$("#DivStakeholderFilter").addClass("active");
                        //$("#presetfilter").removeClass("active");
                        //$("#basicfilterli").hasClass("active");
                        //{
                        //    $("#basicfilterli").removeClass("active");
                        //}
                        //$("#btnAdvFilter").attr("aria-expanded", false);
                        //$("#filterpanel").removeClass("in");   

                        $("#StakeholderClearAllFilter").show();                     
                        $(".filterpanel ").removeClass("in");
                        $("#DivStakeholderFilter").addClass("active");
                        $("#presetfilter").removeClass("active");
                        $("#basicfilterli").hasClass("active");
                        {
                        $("#basicfilterli").removeClass("active");
                        }
                        $("#btnAdvFilter").attr("aria-expanded", false);
                        $("#filterpanel").removeClass("in"); 
                        $("#Issuesavefilter").modal('hide');

                        $("#ResourceClearAllFilter").show();
                        $("#ResourceFilter").addClass("activefilter"); 

                    }                   
                    $("#Issuesavefilter").modal('hide');
                }
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Filter Name should not be blank");
                $("#txtFilterName").focus();               
            }
        });

        //For Duplicated Filter
        function checkDuplicateFilter(Flag, FilterID, filtername, TagID)
        {
            var isFilterExists = 0;
            var Parameters = {
                Flag: encodeURI(Flag),
                FilterID: encodeURI(FilterID),
                FilterName: encodeURI(filtername),
                TagID: encodeURI(TagID),
                ProjectID: encodeURI(ProjectID),              
                UserID: encodeURI('<%= Session("intUserID") %>'),
            }

            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Resource_Selection/chkFilterExists',
                method: 'Post',
                data: JSON.stringify(Parameters),
                dataType: "json",
                async: false,
                contentType: "application/json",  /*;charset-utf=8*/
                //beforeSend: function (xhr) {
                //    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                //},
                //added by Aditya J. on 05-09-2024
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    if (Parameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Parameters) ? Parameters : JSON.stringify(Parameters)));
                    }
                },
                //End of added by Aditya J. on 05-09-2024
                success: function (data)
                {                 
                    if (data == 0)
                    {
                        isFilterExists = 0;
                    }
                    else if (data == 1)
                    {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error('Filter Name Already Exists');
                        $("#txtFilterName").focus();
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
        //End  of For Duplicated Filter


        // Milestone SaveAndApply Filter Functionality
        function MilestoneSaveAndApplyFilter(FilterName)
        {      
            
            if (GlobalFilterName == undefined) {
                GlobalFilterName = "";
                FilterID="0"
            }
            else if (GlobalFilterName == "") {
               FilterID="0"
            }          

            if (FilterName.toString().trim() != GlobalFilterName.toString().trim() && FilterID == "0") {
                Flag = 0;
            }
            else {
                Flag = 1;
            }          
            FilterName = FilterName.replace(/'/g, "''");
            var MLQueryText = BtnApplyMLBasicQuery();
            var WBSParameters = {
                TagID: 36009,
                ProjectID: ProjectID,
                UserID: encodeURI(UserID),
                FilterName: encodeURI(FilterName),
                LoginType: encodeURI(LoginType),
                QueryText: encodeURI(MLQueryText),
                UserName: encodeURI(UserName),
                TaskFlag: encodeURI(Flag),
                FilterID: encodeURI(FilterID)
            }           
                 
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Resource_Selection/MilestoneSavedFilters',
                type: "POST",
                data: JSON.stringify(WBSParameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                //beforeSend: function (xhr) {
                //    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                //},
                //added by Aditya J. on 05-09-2024
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    if (WBSParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(WBSParameters) ? WBSParameters : JSON.stringify(WBSParameters)));
                    }
                },
                //End of added by Aditya J. on 05-09-2024
                success: function (data)
                {                   
                    console.log(data);
                    if (data != null)
                    {          
                        alertify.set('notifier', 'position', 'top-right');  
                        setTimeout(function ()
                        {
                           alertify.notify('Filter applied Sucessfully', 'success');
                        }, 2000);
                       // alertify.notify('Filter applied Sucessfully', 'success');

                        //data = 'Edit' + data;                        
                        ResourcesEditFilter(data);                       

                        $(".filterpanelML").removeClass('in');
                        $("#DivModuleFilter").addClass("active");
                        $("#DivMilestoneFilter").addClass("active");
                        $("#MilestoneClearAllFilter").css({ 'display': 'inline-block', 'float': 'right', 'margin': '-46px 33px 0' });
                        $("#MilestoneClearAllFilter").insertAfter("#MLtabMilestone .filter");
                    }
                },
                error: function (err) { 
                    alert("Error");
                   // window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }

        //function for get list of milestone filters
        function ResourceFilters()
        {
            
            // clearTooltip();      //Commented by Vishal Mane on 12/09/2025 to fix Screen overlapping issue on resource allocation page
           //debugger;
            var ResourceParameters = {
                ProjectID: SessionProjectID,
                TagID: 36009,
                LoginType: encodeURI(LoginType),
                UserID: encodeURI(UserID)
            }       
        
             $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Resource_Selection/ResourceFilters',
                type: "POST",
                data: JSON.stringify(ResourceParameters),
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    if (ResourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ResourceParameters) ? ResourceParameters : JSON.stringify(ResourceParameters)));
                    }
                },
                success: function (result)
                {   
                    if (result.length == 0)
                    {
                        CreateDataTable(); 
                        MyResourceFiltersList(result);
                    }
                    else
                    {
                        if (result != undefined)
                        {
                            MyResourceFiltersList(result);
                        }
                         $(".LIResourceALBasicFilter").removeClass("active");
                         $("#liResourceALMyFiltersdropdown").addClass("active");
                    } 
                },
                error: function (err) {                   
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            }); 
        }

        //Milestone filter list
        function MyResourceFiltersList(result)
        {
            var strHTML = "";
            var DefaultFilterId = 0;

            for (var i = 0; i < result.length; i++) 
            {
                var FilterID = result[i]["FilterId"];
                var FilterName = result[i]["FilterName"];
                var QueryText = result[i]["QueryText"];
                              
                strHTML += ' <li>'

                if (result[i].SetDefault == true)
                {                    
                    FilterID = FilterID ;
                    DefaultFilterId = FilterID;
                   // ResourcesEditFilter(FilterID);
                     
                    strHTML += '<label class="customradio">'
                    strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-placement="bottom" id="Default' + FilterID + '" type="radio" name="project2" onclick="SetResourceDefaultFilter(this.id,&quot;Default&quot;)" checked="checked">'
                    strHTML += '<span data-bs-toggle="tooltip" data-placement="right" title="Set Default filter" class="checkmark"></span>'
                    strHTML += '</label>'
                }
                else
                {   
                    //$("#ResourceClearAllFilter").hide();
                    strHTML += '<label class="customradio">'
                    strHTML += '<input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-placement="bottom" id="Default' + FilterID + '" type="radio" name="project2" onchange="SetResourceDefaultFilter(this.id,&quot;&quot;)">'
                    strHTML += '<span data-bs-toggle="tooltip" data-placement="right" title="Set Default filter" class="checkmark"></span>'
                    strHTML += '</label>'
                }

                strHTML += '<label class="">'
                strHTML += '<span for="project2" class="radiotextsty filtername">' + FilterName + '</span>'
                strHTML += '</label>'
                strHTML += '<div class="issfilter_actiondropdown">'

                if (result[i].SetDefault == true)
                {
                    strHTML += '<div class="custom_chckbox_markblue">'
                    strHTML += '<input id="ModuleselproOne" checked="" type="checkbox" name="">'
                    strHTML += '<label data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Apply filter" for="IssueselproOne" id="Apply' + FilterID + '" onclick="ApplyCheckResourceFilter(this.id)" class="filterid"></label>'
                    strHTML += '</div>'
                }
                else
                {
                    if (GlobalApplyID == FilterID)
                    {
                        strHTML += '<div class="custom_chckbox_markblue">'
                        strHTML += '<input id="ModuleselproOne" checked="" type="checkbox" name="">'
                        strHTML += '<label data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Applied filter" for="IssueselproOne" id="Apply' + FilterID + '" onclick="ApplyCheckResourceFilter(this.id)" class="filterid"></label>'
                        strHTML += '</div>'
                    }
                    else
                    {
                        strHTML += '<div class="custom_chckbox_markblue">'
                        strHTML += '<input id="ModuleselproOne" type="checkbox" name="">'
                        strHTML += '<label data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Apply filter" for="IssueselproOne" id="Apply' + FilterID + '" onclick="ApplyCheckResourceFilter(this.id)" class="filterid"></label>'
                        strHTML += '</div>'
                    }
                }

                strHTML += '<span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Edit filter" class="fas fa-pencil-alt" id="Edit' + FilterID + '" onclick="ResourcesEditFilterClick(this.id)" ></i></span>'

                if (result[i].SetDefault == true) {
                    strHTML += '<span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Delete filter" class="far fa-trash-alt" id="Default' + FilterID + '" onclick="DeleteDefaultResourceFilter(this.id)" ></i></span>'
                }
                else {
                    strHTML += '<span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Delete filter" class="far fa-trash-alt" id="' + FilterID + '" onclick="DeleteDefaultResourceFilter(this.id)"></i></span>'
                }
                strHTML += '</div>'
                strHTML += '</li>'

            }
            $("#ResourceALMyFiltersdropdown").html(strHTML);
            $('[data-bs-toggle="tooltip"]').tooltip();

            //alert(DefaultFilterId);
            //DefaultFilterId = DefaultFilterId.replace('Edit', '');
            if (DefaultFilterId != 0)
            {
                ResourcesEditFilter(DefaultFilterId);
                $("#ResourceClearAllFilter").show();  
                $("#ResourceFilter").addClass("activefilter"); 

                //if (GlobalApplyID == 0)
                //{
                //    ResourcesEditFilter(DefaultFilterId);
                //    $("#ResourceClearAllFilter").show();  
                //    $("#ResourceFilter").addClass("activefilter");  
                //}                
            }
            else
            {
                showsavefilter == 0;
                CreateDataTable(); 
            }
        }


         //Set Resource Default filter
        function SetResourceDefaultFilter(DefaultID, flag)
        {      
            StartLoader("#AddNewResource");
            GlobalApplyID = 0;

            //clear Filter Values
            ClearFilter();           
            
            var RemoveDefault = 0;
            if (flag == "Default")
            {
                RemoveDefault = 1;
            }

            FilterID = DefaultID.replace("Default", "");
            FilterID = FilterID.replace("Edit", "");

            if (FilterID != undefined)
            {
                ResourceParameters = {
                    ProjectID: encodeURI(ProjectID),
                    LoginType: encodeURI(LoginType),
                    UserID: encodeURI(UserID),
                    TagID: 36009,
                    FilterID: encodeURI(FilterID),
                    Flag: encodeURI(RemoveDefault)
                }
                var param = JSON.stringify(ResourceParameters);
                $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Resource_Selection/SetDefaultFilter',
                type: "POST",
                data: param,
                dataType: "json",
                async: false,
                contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr)
                    {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    },
                    success: function (strResult)
                    {                      
                        if (strResult != undefined)
                        {                           
                            if (RemoveDefault == 0)
                            {
                                ResourceFilters(); 
                                alertify.set('notifier', 'position', 'top-right');
                                setTimeout(function () {
                                    alertify.success(strResult);
                                }, 2000);
                                //alertify.success(strResult);
                            }
                            else
                            {                                
                                ResourceFilters(); 
                                alertify.set('notifier', 'position', 'top-right');
                                setTimeout(function () {
                                    alertify.success("<%= MyBase.GetResourceString("A_ClearDefaultFilter") %>");
                                }, 2000);
                                //alertify.success("<%= MyBase.GetResourceString("A_ClearDefaultFilter") %>");                              
                            }
                        }                       
                                             
                        if (strResult == "Set Default Filter Successfully")
                        {  
                            $("#ResourceFilter").addClass("activefilter");
                            $("#ResourceClearAllFilter").css({ 'display': 'inline-block' });            
                        }
                        else
                        {
                            $("#ResourceFilter").removeClass("activefilter");
                            $("#ResourceClearAllFilter").css({ 'display': 'none' });
                        }

                        $("#StakeholderClearAllFilter").show();                     
                        $(".filterpanel ").removeClass("in");
                        $("#DivStakeholderFilter").addClass("active");
                        $("#presetfilter").removeClass("active");
                        $("#basicfilterli").hasClass("active");
                        {
	                        $("#basicfilterli").removeClass("active");
                        }
                        $("#btnAdvFilter").attr("aria-expanded", false);
                        $("#filterpanel").removeClass("in"); 
                        $("#Issuesavefilter").modal('hide');

                        $(".LIResourceALBasicFilter").addClass("active");
                        $(".cust_tabpanel .keep-inside-clicks-open").removeClass("active");
                        $('ul#ResourceALBasicFilter li a:last').parents('li').addClass('active');
                        $(".LIResourceALBasicFilter").addClass("active");
                        $("#presetfilterAR").addClass("active");

                    },
                    error: function (err) {                   
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });                
            }
            StopAjaxLoader("#AddNewResource");
        }
        
        var ajaxResult;
        function AJAXCallWithResult(url, param, async)
        {
            $.ajax({
                url: encodeURI(strUrl + url),
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
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

        //function for delete and page filters
        function DeleteDefaultResourceFilter(DefaultID)
        {     
            $(".LIResourceALBasicFilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("active");
            $('ul#ResourceALBasicFilter li a:last').parents('li').addClass('active');
           
            // clearTooltip();      //Commented by Vishal Mane on 12/09/2025 to fix Screen overlapping issue on resource allocation page
            StartLoader("#AddNewResource");           
            ClearFilter();
            var FilterID = DefaultID.replace("Default", "");
                FilterID = FilterID.replace("Edit", "");           
            DeleteResourceFilter(FilterID);
            ResourceFilters();

            $("#txtFilterName").val('');

            $("#ResourceClearAllFilter").hide();
            $("#ResourceFilter").removeClass("activefilter"); 

            $(".filterpanel ").removeClass("in");
            $("#DivStakeholderFilter").addClass("active");
            $("#presetfilter").removeClass("active");
            $("#basicfilterli").hasClass("active");
            {
                $("#basicfilterli").removeClass("active");
            }
            $("#btnAdvFilter").attr("aria-expanded", false);
            $("#filterpanel").removeClass("in"); 
            $("#Issuesavefilter").modal('hide');

            $(".LIResourceALBasicFilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("active");
            $('ul#ResourceALBasicFilter li a:last').parents('li').addClass('active');
            $(".LIResourceALBasicFilter").addClass("active");
            $("#presetfilterAR").addClass("active");

            StopAjaxLoader("#AddNewResource");
        }

        function clearTooltip() {
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
              //  $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
        }

        ////Delete Resource Filter 
        function DeleteResourceFilter(FilterID)
        {
            if (FilterID != undefined) {
                ResourceParameters = {
                    FilterID: encodeURI(FilterID),
                }
                $.ajax({
                    url: encodeURI(strUrl) + '/api/PM_Resource_Selection/DeleteFilterData',
                    type: "POST",
                    data: JSON.stringify(ResourceParameters),
                    dataType: "json",
                    async: false,
                    contentType: "application/json;charset-utf=8",
                    beforeSend: function (xhr) {
                        xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    },
                    success: function (result)
                    {
                        alertify.set('notifier', 'position', 'top-right');
                        //alertify.success(result);
                        setTimeout(function ()
                        {
                            alertify.success(result);
                        }, 2000);  
                    },
                    error: function (err) {
                        window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    }
                });
            }  
        }

        //EditResources Filter 
        function ResourcesEditFilter(EditID)
        {           
            StartLoader("#AddNewResource");
            
            Flag = 1;
            //FilterID = EditID.replace("Edit", "");
            GlobalApplyID = EditID;
            
            $(".stackbasicfilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("active");
            $('ul#ResourceALBasicFilter li a:last').parents('li').addClass('active');

            //Click on Edit SaveAndApply Section Will Be Display
            ResourceParameters = {
                FilterID: encodeURI(GlobalApplyID),
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Resource_Selection/EditFilterData',
                method: 'Post',
                data: JSON.stringify(ResourceParameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                //beforeSend: function (xhr) {
                //    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                //},
                //added by Aditya J. on 05-09-2024
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    if (ResourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ResourceParameters) ? ResourceParameters : JSON.stringify(ResourceParameters)));
                    }
                },
                //End of added by Aditya J. on 05-09-2024
                success: function (result)
                {
                    for (var i = 0; i < result.length; i++)
                    {
                        var QueryText = result[i].WhereClause;
                        GlobalFilterName = result[i].FilterName;
                    }      
                    var FilterName = $("#txtFilterName").val(GlobalFilterName);
                    $(".LIResourceALBasicFilter").addClass("active");   

                   
                    var MlQueryText = QueryText.split("AND");
                    for (var j = 0; j < MlQueryText.length; j++)
                    {
                        var mlQuery = MlQueryText[j];
                        mlQuery = $.trim(mlQuery);

                        //UserName
                        if (mlQuery.indexOf('UserName') > -1)
                        {          
                            if (mlQuery.indexOf('NOT LIKE') > -1)
                            {
                                $("select#FUNm option:contains('Not Contains')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('NOT LIKE')[1]; //Splits the string after NOT LIKE comes
                                mlQuery = $.trim(mlQuery); //Removes starting and ending whitespaces
                                mlQuery = mlQuery.replace(/%/g, ""); //Removes % sign
                                mlQuery = mlQuery.replace(/'/g, ""); //Removes single quotes
                                $('#txtUserName').val(mlQuery);
                            } 

                            if (mlQuery.indexOf('=') > -1)
                            {
                                $("select#FUNm option:contains('Exact Word')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('=')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");
                                $('#txtUserName').val(mlQuery);
                            }

                            if (mlQuery.indexOf('LIKE') > -1) 
                            {                              
                                mlQuery = mlQuery.split('LIKE')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");

                                if (mlQuery.charAt(0) == '%' && mlQuery[mlQuery.length - 1] == '%')
                                {                                     
                                    $("#FUNm option[value=Contains]").prop('selected', true);
                                    mlQuery = mlQuery.replace(/%/g, "");
                                    $('#txtUserName').val(mlQuery);
                                }
                                else if (mlQuery.charAt(0) == '%')
                                {                                   
                                    //$("#FUNm option[value='Ends With']").prop('selected', true);
                                     $("select#FUNm option:contains('Ends With')").attr('selected', 'selected');
                                    mlQuery = mlQuery.replace(/%/g, "");
                                    $('#txtUserName').val(mlQuery);
                                }
                                else if (mlQuery[mlQuery.length - 1] == '%') {
                                    $("#FUNm option[value='Starts With']").prop('selected', true);
                                    mlQuery = mlQuery.replace(/%/g, "");
                                    $('#txtUserName').val(mlQuery);
                                }
                            }

                        }

                        //Resource Name
                        if (mlQuery.indexOf('EmployeeName') > -1)
                        {          
                            if (mlQuery.indexOf('NOT LIKE') > -1)
                            {
                                $("select#FRNM option:contains('Not Contains')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('NOT LIKE')[1]; //Splits the string after NOT LIKE comes
                                mlQuery = $.trim(mlQuery); //Removes starting and ending whitespaces
                                mlQuery = mlQuery.replace(/%/g, ""); //Removes % sign
                                mlQuery = mlQuery.replace(/'/g, ""); //Removes single quotes
                                $('#txtResourceName').val(mlQuery);
                            } 

                            if (mlQuery.indexOf('=') > -1)
                            {
                                $("select#FRNM option:contains('Exact Word')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('=')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");
                                $('#txtResourceName').val(mlQuery);
                            }

                            if (mlQuery.indexOf('LIKE') > -1) 
                            {                              
                                mlQuery = mlQuery.split('LIKE')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");

                                if (mlQuery.charAt(0) == '%' && mlQuery[mlQuery.length - 1] == '%')
                                {                                     
                                    $("#FRNM option[value=Contains]").prop('selected', true);
                                    mlQuery = mlQuery.replace(/%/g, "");
                                    $('#txtResourceName').val(mlQuery);
                                }
                                else if (mlQuery.charAt(0) == '%')
                                {                                   
                                    //$("#FUNm option[value='Ends With']").prop('selected', true);
                                     $("select#FRNM option:contains('Ends With')").attr('selected', 'selected');
                                    mlQuery = mlQuery.replace(/%/g, "");
                                    $('#txtResourceName').val(mlQuery);
                                }
                                else if (mlQuery[mlQuery.length - 1] == '%') {
                                    $("#FRNM option[value='Starts With']").prop('selected', true);
                                    mlQuery = mlQuery.replace(/%/g, "");
                                    $('#txtResourceName').val(mlQuery);
                                }
                            }
                        }

                        //Business Group
                        if (mlQuery.indexOf('BusinessGroup') > -1)
                        {
                           
                            if (mlQuery.indexOf('<>') > -1)
                            {
                                $("select#FBG option:contains('<>')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('<>')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");
                                $("#CmbFBusinessGroup option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                            }
                            else
                            {
                                $("select#FBG option:contains('=')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('=')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, ""); 
                                $("#CmbFBusinessGroup option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);                                                          
                            }
                        }

                        //Department
                        if (mlQuery.indexOf('Department') > -1)
                        {
                            if (mlQuery.indexOf('<>') > -1)
                            {
                                $("select#FDept option:contains('<>')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('<>')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");
                                $("#CmbFDepartment option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                            }
                            else
                            {
                                $("select#FDept option:contains('=')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('=')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, ""); 
                                $("#CmbFDepartment option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                                                          
                            }
                        }

                        //OU
                        if (mlQuery.indexOf('Location') > -1)
                        {
                            if (mlQuery.indexOf('<>') > -1)
                            {
                                $("select#FOU option:contains('<>')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('<>')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");
                                $("#CmbFOrganizationUnit option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                            }
                            else
                            {
                                $("select#FOU option:contains('=')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('=')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, ""); 
                                $("#CmbFOrganizationUnit option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                                                          
                            }
                        }

                        //Role
                        if (mlQuery.indexOf('RoleDescription') > -1)
                        {
                            if (mlQuery.indexOf('<>') > -1)
                            {
                                $("select#FRole option:contains('<>')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('<>')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");
                                $("#CmbFRole option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                            }
                            else
                            {
                                $("select#FRole option:contains('=')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('=')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, ""); 
                                $("#CmbFRole option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                                                          
                            }
                        }

                        //DesignationName
                        if (mlQuery.indexOf('DesignationName') > -1)
                        {
                            if (mlQuery.indexOf('<>') > -1)
                            {
                                $("select#FDesig option:contains('<>')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('<>')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");
                                $("#CmbFDesignation option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                            }
                            else
                            {
                                $("select#FDesig option:contains('=')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('=')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, ""); 
                                $("#CmbFDesignation option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);                                                          
                            }
                        }                       
                    }

                    //$("#StakeholderClearAllFilter").show();                     
                    //$(".filterpanel ").removeClass("in");
                    //$("#DivStakeholderFilter").addClass("active");
                    //$("#presetfilter").removeClass("active");
                    //$("#basicfilterli").hasClass("active");
                    //{
	                   // $("#basicfilterli").removeClass("active");
                    //}
                    //$("#btnAdvFilter").attr("aria-expanded", false);
                    //$("#filterpanel").removeClass("in"); 
                    //$("#Issuesavefilter").modal('hide');

                    //$("#ResourceClearAllFilter").show();
                    //$("#ResourceFilter").addClass("activefilter"); 

                    //Fill Table
                    showsavefilter = 1;                         
                    CreateDataTable();                   
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#AddNewResource");
        }

        //function for Apply Check
        function ApplyCheckResourceFilter(ApplyID)
        {
            StartLoader("#AddNewResource");
            ApplyID = ApplyID.replace('Apply', '');
           
            ResourcesEditFilter(ApplyID);
            $("#ResourceClearAllFilter").show();
            $("#ResourceFilter").addClass("activefilter"); 

            //$(".LIResourceALBasicFilter").addClass("active");
            //$(".cust_tabpanel .keep-inside-clicks-open").removeClass("active");
            //$('ul#ResourceALBasicFilter li a:last').parents('li').addClass('active');
            //$(".LIResourceALBasicFilter").addClass("active");
            //$("#presetfilterAR").addClass("active");

            $("#StakeholderClearAllFilter").show();                     
            $(".filterpanel ").removeClass("in");
            $("#DivStakeholderFilter").addClass("active");
            $("#presetfilter").removeClass("active");
            $("#basicfilterli").hasClass("active");
            {
	            $("#basicfilterli").removeClass("active");
            }
            $("#btnAdvFilter").attr("aria-expanded", false);
            $("#filterpanel").removeClass("in"); 
            $("#Issuesavefilter").modal('hide');

            $("#ResourceClearAllFilter").show();

                    //$("#ResourceFilter").addClass("activefilter"); 
            StopAjaxLoader("#AddNewResource");
        }


         //Editicon click to show filter data
        function ResourcesEditFilterClick(EditID)
        {           
            StartLoader("#AddNewResource");

            Flag = 1;
            FilterID = EditID.replace("Edit", "");
           
            ////Click on Edit SaveAndApply Section Will Be Display
            $(".stackbasicfilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("active");
            $('ul#ResourceALBasicFilter li a:last').parents('li').addClass('active');

            //Click on Edit SaveAndApply Section Will Be Display
            ResourceParameters = {
                FilterID: encodeURI(FilterID),
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_Resource_Selection/EditFilterData',
                method: 'Post',
                data: JSON.stringify(ResourceParameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                //beforeSend: function (xhr) {
                //    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                //},
                //added by Aditya J. on 05-09-2024
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    if (ResourceParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ResourceParameters) ? ResourceParameters : JSON.stringify(ResourceParameters)));
                    }
                },
                //End of added by Aditya J. on 05-09-2024
                success: function (result)
                {
                    for (var i = 0; i < result.length; i++)
                    {
                        var QueryText = result[i].WhereClause;
                        GlobalFilterName = result[i].FilterName;
                    }      
                    var FilterName = $("#txtFilterName").val(GlobalFilterName);
                    $(".LIResourceALBasicFilter").addClass("active");
                   
                    var MlQueryText = QueryText.split("AND");
                    for (var j = 0; j < MlQueryText.length; j++)
                    {
                        var mlQuery = MlQueryText[j];
                        mlQuery = $.trim(mlQuery);

                        //UserName
                        if (mlQuery.indexOf('UserName') > -1)
                        {          
                            if (mlQuery.indexOf('NOT LIKE') > -1)
                            {
                                $("select#FUNm option:contains('Not Contains')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('NOT LIKE')[1]; //Splits the string after NOT LIKE comes
                                mlQuery = $.trim(mlQuery); //Removes starting and ending whitespaces
                                mlQuery = mlQuery.replace(/%/g, ""); //Removes % sign
                                mlQuery = mlQuery.replace(/'/g, ""); //Removes single quotes
                                $('#txtUserName').val(mlQuery);
                            } 

                            if (mlQuery.indexOf('=') > -1)
                            {
                                $("select#FUNm option:contains('Exact Word')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('=')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");
                                $('#txtUserName').val(mlQuery);
                            }

                            if (mlQuery.indexOf('LIKE') > -1) 
                            {                              
                                mlQuery = mlQuery.split('LIKE')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");

                                if (mlQuery.charAt(0) == '%' && mlQuery[mlQuery.length - 1] == '%')
                                {                                     
                                    $("#FUNm option[value=Contains]").prop('selected', true);
                                    mlQuery = mlQuery.replace(/%/g, "");
                                    $('#txtUserName').val(mlQuery);
                                }
                                else if (mlQuery.charAt(0) == '%')
                                {                                   
                                    //$("#FUNm option[value='Ends With']").prop('selected', true);
                                     $("select#FUNm option:contains('Ends With')").attr('selected', 'selected');
                                    mlQuery = mlQuery.replace(/%/g, "");
                                    $('#txtUserName').val(mlQuery);
                                }
                                else if (mlQuery[mlQuery.length - 1] == '%') {
                                    $("#FUNm option[value='Starts With']").prop('selected', true);
                                    mlQuery = mlQuery.replace(/%/g, "");
                                    $('#txtUserName').val(mlQuery);
                                }
                            }

                        }

                        //Resource Name
                        if (mlQuery.indexOf('EmployeeName') > -1)
                        {          
                            if (mlQuery.indexOf('NOT LIKE') > -1)
                            {
                                $("select#FRNM option:contains('Not Contains')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('NOT LIKE')[1]; //Splits the string after NOT LIKE comes
                                mlQuery = $.trim(mlQuery); //Removes starting and ending whitespaces
                                mlQuery = mlQuery.replace(/%/g, ""); //Removes % sign
                                mlQuery = mlQuery.replace(/'/g, ""); //Removes single quotes
                                $('#txtResourceName').val(mlQuery);
                            } 

                            if (mlQuery.indexOf('=') > -1)
                            {
                                $("select#FRNM option:contains('Exact Word')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('=')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");
                                $('#txtResourceName').val(mlQuery);
                            }

                            if (mlQuery.indexOf('LIKE') > -1) 
                            {                              
                                mlQuery = mlQuery.split('LIKE')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");

                                if (mlQuery.charAt(0) == '%' && mlQuery[mlQuery.length - 1] == '%')
                                {                                     
                                    $("#FRNM option[value=Contains]").prop('selected', true);
                                    mlQuery = mlQuery.replace(/%/g, "");
                                    $('#txtResourceName').val(mlQuery);
                                }
                                else if (mlQuery.charAt(0) == '%')
                                {                                   
                                    //$("#FUNm option[value='Ends With']").prop('selected', true);
                                     $("select#FRNM option:contains('Ends With')").attr('selected', 'selected');
                                    mlQuery = mlQuery.replace(/%/g, "");
                                    $('#txtResourceName').val(mlQuery);
                                }
                                else if (mlQuery[mlQuery.length - 1] == '%') {
                                    $("#FRNM option[value='Starts With']").prop('selected', true);
                                    mlQuery = mlQuery.replace(/%/g, "");
                                    $('#txtResourceName').val(mlQuery);
                                }
                            }
                        }

                        //Business Group
                        if (mlQuery.indexOf('BusinessGroup') > -1)
                        {
                           
                            if (mlQuery.indexOf('<>') > -1)
                            {
                                $("select#FBG option:contains('<>')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('<>')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");
                                $("#CmbFBusinessGroup option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                            }
                            else
                            {
                                $("select#FBG option:contains('=')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('=')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, ""); 
                                $("#CmbFBusinessGroup option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);                                                          
                            }
                        }

                        //Department
                        if (mlQuery.indexOf('Department') > -1)
                        {
                            if (mlQuery.indexOf('<>') > -1)
                            {
                                $("select#FDept option:contains('<>')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('<>')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");
                                $("#CmbFDepartment option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                            }
                            else
                            {
                                $("select#FDept option:contains('=')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('=')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, ""); 
                                $("#CmbFDepartment option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                                                          
                            }
                        }

                        //OU
                        if (mlQuery.indexOf('Location') > -1)
                        {
                            if (mlQuery.indexOf('<>') > -1)
                            {
                                $("select#FOU option:contains('<>')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('<>')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");
                                $("#CmbFOrganizationUnit option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                            }
                            else
                            {
                                $("select#FOU option:contains('=')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('=')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, ""); 
                                $("#CmbFOrganizationUnit option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                                                          
                            }
                        }

                        //Role
                        if (mlQuery.indexOf('RoleDescription') > -1)
                        {
                            if (mlQuery.indexOf('<>') > -1)
                            {
                                $("select#FRole option:contains('<>')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('<>')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");
                                $("#CmbFRole option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                            }
                            else
                            {
                                $("select#FRole option:contains('=')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('=')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, ""); 
                                $("#CmbFRole option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                                                          
                            }
                        }

                        //DesignationName
                        if (mlQuery.indexOf('DesignationName') > -1)
                        {
                            if (mlQuery.indexOf('<>') > -1)
                            {
                                $("select#FDesig option:contains('<>')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('<>')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, "");
                                $("#CmbFDesignation option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);
                            }
                            else
                            {
                                $("select#FDesig option:contains('=')").attr('selected', 'selected');
                                mlQuery = mlQuery.split('=')[1];
                                mlQuery = $.trim(mlQuery);
                                mlQuery = mlQuery.replace(/'/g, ""); 
                                $("#CmbFDesignation option").filter(function ()
                                {
                                    return $(this).text().trim() == mlQuery;
                                }).prop('selected', true);                                                          
                            }
                        }                       
                    }

                    //$("#StakeholderClearAllFilter").show();                     
                    //$(".filterpanel ").removeClass("in");
                    //$("#DivStakeholderFilter").addClass("active");
                    //$("#presetfilter").removeClass("active");
                    //$("#basicfilterli").hasClass("active");
                    //{
	                   // $("#basicfilterli").removeClass("active");
                    //}
                    //$("#btnAdvFilter").attr("aria-expanded", false);
                    //$("#filterpanel").removeClass("in"); 
                    //$("#Issuesavefilter").modal('hide');

                    //$("#ResourceClearAllFilter").show();
                    //$("#ResourceFilter").addClass("activefilter"); 

                                      
                },
                error: function (err) {
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            StopAjaxLoader("#AddNewResource");
        }

        $("#ResourceClearAllFilter").click(function ()
        {      
            StartLoader("#AddNewResource");
            GlobalApplyID = 0;
            $("#txtFilterName").val('');

            ClearFilter();
            $("#CmbRole").val(RoleID);

            //ResourceFilters(); 
            CreateDataTable();
          
            $("#ResourceClearAllFilter").hide();
            $("#ResourceFilter").removeClass("activefilter"); 

            $("#StakeholderClearAllFilter").show();                     
            $(".filterpanel ").removeClass("in");
            $("#DivStakeholderFilter").addClass("active");
            $("#presetfilter").removeClass("active");
            $("#basicfilterli").hasClass("active");
            {
	            $("#basicfilterli").removeClass("active");
            }
            $("#btnAdvFilter").attr("aria-expanded", false);
            $("#filterpanel").removeClass("in"); 
            $("#Issuesavefilter").modal('hide');

            $(".LIResourceALBasicFilter").addClass("active");
            $(".cust_tabpanel .keep-inside-clicks-open").removeClass("active");
            $('ul#ResourceALBasicFilter li a:last').parents('li').addClass('active');
            $(".LIResourceALBasicFilter").addClass("active");
            $("#presetfilterAR ").addClass("active");

            StopAjaxLoader("#AddNewResource");
            //window.location.reload();
        });

        $("#filterpanel").on("show.bs.collapse", function () {
            $(".clearalllink").css("display", "inline-block");
            $(".table").resize();
        });

        $("#filterpanel").on("hide.bs.collapse", function () {
            $(".clearalllink").hide();
            $(".table").resize();
        });

        $(window).on("load resize scroll", function ()
        {
            resizeSection(this);
        });

        // added by imran 01-07-2021 Add Value To selected multiple check box value
        function selectedCheckbox(obj)
        {         
            var Empid; var Empnm; var tdata;           

            obj.id = obj.id.replace(/%20/g,' ');
            tdata = obj.id.split('~');
            Empid = tdata[0];
            Empnm = tdata[1];
           
              if (obj.checked == true)
              {                    
                  arrSelectedEmployeeNames.push(Empnm);
                  arrSelectedEmployeeIds.push(Empid);
                  arrChecked.push(Empid)
              }  
              else
              {
                  if (obj.checked == false)
                  {
                        arrChecked = jQuery.grep(arrChecked, function (value)
                        {
                            return value != Empid;
                        });
                        arrSelectedEmployeeNames = jQuery.grep(arrSelectedEmployeeNames, function (value)
                        {
                            return value != Empnm;
                        });
                        arrSelectedEmployeeIds = jQuery.grep(arrSelectedEmployeeIds, function (value)
                        {
                                return value !=Empid;
                        });                                                     
                }
            }

            if (arrChecked.length > 10) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("You can not select more than 10 Resources");                           
                return false;
            }
        }
        //End by imran01-07-2021

        //Get Project Start And End Date
        function GetProjectStartDateEndDate(ProjectID) {
            var param = JSON.stringify(ProjectID);  
            var result = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_Resource_Selection/GetProjectStartDateEndDate", param, false);         
            if (result != undefined) {
                return result;
            }
        }

        function GetReportingToInEditMode()
        {
            var IsExternal = "";
            var ChkIsExternal = "";
            var strResult1 = ResourceDetailsForIsExternal();
            var ResourceParameters = {
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ResourceParameters);
            var strResult = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_Resource_Selection/GetReportingToInEditMode", param, false);
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

        function ResourceDetailsForIsExternal()
        {          
            var ResourceParameters = {
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ResourceParameters);
            var strResult = AJAXCallWithResult(encodeURI(strUrl) +"/api/PM_Resource_Selection/GetReportingToInEditMode", param, false);
            return strResult;
        }

        //Available Allocation check
        function GetAvaliableAllocation(ExpectedStartDate, ExpectedEndDate, EmployeeID, ProjectID)
        {
            var AvaiableReAllocation = 0;
            var Data = {
                ExpectedStartDate: ExpectedStartDate,
                ExpectedEndDate: ExpectedEndDate,
                EmployeeID: EmployeeID,
                ProjectID: ProjectID,               
            }           
            $.ajax({
                url: encodeURI(strUrl + '/api/PM_Resource_Selection/GetAvaliableAllocation'),
                type: "POST",
                data: JSON.stringify(Data),
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                    //Added By Dipali V On 28th March 2023 For Resource Allocation Issue
                    if (Data) {
                        xhr.setRequestHeader("Params", encryptString(isJson(Data) ? Data : JSON.stringify(Data)));
                    }
                    //End of Added By Dipali V On 28th March 2023 For Resource Allocation Issue
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

        //function To get Default Approver
        function GetDefaultApprover() {
            var SelectedProjectID = document.getElementById("cboProjectAdd").value;
            var ProjectID = SelectedProjectID;
            var param = JSON.stringify(ProjectID);
            var strResult = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_Resource_Selection/GetDefaultApprover", param, false);
            if (strResult != undefined) {
                var GetDefaultApprover = strResult;
                return GetDefaultApprover;
            }
        }

        //In List box multiple item select 
        $("#DivResourcelist .select2").blur(function () {
                     
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

        //Check Agil or Not
        function CheckIsAgileProject(ProjectID) {
            var ResourceParameters = {
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ResourceParameters);
            var strResult = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_Resource_Selection/CheckIsAgileProject", param, false);
            if (strResult != undefined) {
                return strResult;
            }
        }

        //Cancelation
        function cancelallocation()
        {
            StartLoader("#AddNewResource");

            SelectedEmployeeIDs = "";
            arrChecked = [];
            arrSelectedEmployeeNames = [];
            arrSelectedEmployeeIds = [];
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
            $("#Checkall").prop("checked", false);

            //Clear DatatableCheckbox
            ClearCheckbox();
            $("#bulkallocation").modal('hide');
            StopAjaxLoader("#AddNewResource");
        }

        //clear all check mark in grid
        function ClearCheckbox()
        {
            var cells = oTableStaticFlow.column(9).nodes(), state = this.checked;
            for (var i = 0; i < cells.length; i += 1)
            {
                    cells[i].querySelector("input[type='checkbox']").checked = state;
            }
        }

        //Added by imran 24-06-2021 To Save Allocate resource button click
        function Allocate_OnClick()
        {
            //debugger;
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
            if (SelectedResources == null)
            {
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
//Commnet and Added By Riddhesh Patil on 15-NOV-2022 
             if (checkSpecialCharacter(ResourcePercentage, WebConfigSpecialCharacters) == true && checkval == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('% Allocation should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                $("#txtResourcePercentage").focus();
                 checkval = 1;
                 addReqDetails();
                return;
            }
			//End of Comment Added By Riddhesh Patil

            // if (ResourcePercentage != '' && checkval == 0) {
            //    if (ResourcePercentage ==  0) {
            //        alertify.set('notifier', 'position', 'top-right');
            //        alertify.error('% Allocation should be greater than 0');
            //        $("#txtResourcePercentage").focus();//ADDED BY DIPALI V ON 27TH DEC 2019 FOR FOCUS ON CONTROL
            //        checkval = 1;
            //        return;
            //    }
            //}

           
            if (ResourcePercentage != '' && checkval == 0)
            {
                if (ResourcePercentage < 0)
                {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('% Allocation should be positive value');
                    $("#txtResourcePercentage").focus();//ADDED BY DIPALI V ON 27TH DEC 2019 FOR FOCUS ON CONTROL
                    checkval = 1;
                    return;
                }

                //Added By Usha Pandit On 01.07.2020 For correct validation for Resource percentage
                if (ResourcePercentage == 0)
                {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Resource percentage should be greater than 0');
                    $("#txtResourcePercentage").focus();
                    checkval = 1;
                    return;
                }
                //End Of Added By Usha Pandit On 01.07.2020 For correct validation for Resource percentage
                 //Added By Dipali V On 12nd Feb 2021 For Validate Resource Avaliable %

                if (parseFloat($('#txtResourcePercentage').val()) != "")
                {
                    if (ResourceAvaliableAllocation != "")
                    {
                        if (parseFloat($('#txtResourcePercentage').val()) > parseFloat(ResourceAvaliableAllocation)) {
                            alertify.error('Resource Avaliable Allocation % ' + ResourceAvaliableAllocation);
                            $('#txtResourcePercentage').focus();
                            checkval = 1;
                            return;
                        }
                    }
                }

                //if (parseFloat($('#txtResourcePercentage').val()) != "")
                //{
                //    ResourceAvaliableAllocation = parseFloat($('#txtResourcePercentage').val());

                //    if (ResourceAvaliableAllocation != "")
                //    {
                //        if (parseFloat($('#txtResourcePercentage').val()) > parseFloat(ResourceAvaliableAllocation)) {
                //            alertify.error('Resource Avaliable Allocation % ' + ResourceAvaliableAllocation);
                //            $('#txtResourcePercentage').focus();
                //            checkval = 1;
                //            return;
                //        }
                //    }
                //}
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
                alertify.error('WorkHrs should not be left blank.');
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

             if (Responsibility != "") {
                if (checkSpecialCharacter(Responsibility, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Responsibilities should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtResponsibility").focus();
                    checkval = 1;
                    addReqDetails();
                    return;
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

                if (IsAgile == 1 || IsAgile != undefined)
                {
                    if ($('#chkIsProductOwner').is(":checked"))
                    {
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

            if (checkval == 0)
            {
                StartLoader("#AddNewResource");
                var param = JSON.stringify(resourceParameters);
                var strResult = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_Resource_Selection/AllocateResources", param, false);
                //alert(strResult);
                if (strResult != undefined) {

                   
                    //Modified by Nikhil A on 1-March-2022
                    if (strResult =='SUCCESS') {
                        alertify.set('notifier', 'position', 'top-right');
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
                    //End OF Modified by Nikhil A
                    //Clear DatatableCheckbox
                    ClearCheckbox();
                    //Added By Dipali V On 6th Aug 2021  For Refresh Issue
                    $("#ResourceClearAllFilter").hide();
                    ResourceFilters();
                    //End of Added By Dipali V On 6th Aug 2021  For Refresh Issue
                    $("#Checkall").prop("checked", false);

                    cancelallocation();
                    objWorkHoursOldVal = "";
                    arrChecked = [];

                    arrSelectedEmployeeNames = [];
                    arrSelectedEmployeeIds = [];
                    $("#bulkallocation").modal('hide');
                    StopAjaxLoader("#AddNewResource");
                }
                
                 StopAjaxLoader("#AddNewResource");
            }

            $('table.tbl_rsrsselection').resize(); //Added by pradip on 9-5-2023
        }
        //End by imran 24-06-2021

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

        //Check special character
        function checkSpecialCharacter(value) {
            var regularExpression = WebConfigSpecialCharacters;
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

        //Check Reporting To
        function CheckReportingTo()
        {
            var objIsReportingTo = 0;
            var ResourceParameters = {
                ProjectID: encodeURI(ProjectID),
                RoleID: encodeURI(document.getElementById("cboProjectRoleAdd").value),
            }
            var param = JSON.stringify(ResourceParameters);
            var result = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_Resource_Selection/CheckReportingTo", param, false);
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

        function GetCountOfResources() {           
            var param = JSON.stringify(ProjectID);
            var Count = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_Resource_Selection/GetCountOfResources", param, false);
            return Count;
        }

        //Hours validation check
        function WorkHoursValidation(ControlID)
        {
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
                var strResult = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_Resource_Selection/GetRestrictByMinHours_MinHoursForDAEntry", '', false);

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

         function FillResourceArray() {
            SelectedEmployeeIDs = String($("#RAtaglist").val());
            $("#RAtaglisthidden").val(SelectedEmployeeIDs);  
        }

        function addReqDetails() {
            //debugger;
            $("#idReqDetails").addClass("active");
            $("#idSkill").removeClass("active");
            $("#Rskillsettab").removeClass("active");
            $("#Rskillsettab").removeClass("show");
            $("#Rskillsettab a").removeClass("active");
            $("#Rrequesttab").addClass("active");

            $("#liareq").addClass("active");
            $("#liaskill").removeClass("active");
              //Added By Dipali V On 12th May 2023 For Note Should display if skill non mandatory
            if (IsRequestResourceSkillMandatory == true || IsRequestResourceSkillMandatory ==  "True") {
                $("#skillnote").css('display', 'none')
            } else {
                $("#skillnote").css('display', 'block')
            }
              //End of Added By Dipali V On 12th May 2023 For Note Should display if skill non mandatory
        }


        //Ajax call P{ass parameters}
        function ajaxCall(url, type, contentType, dataType, data)
        {
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
                    
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });
            return ajaxResult;
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
        function Request_onClick(FromWhereFlag)
        {          
            alertify.set('notifier', 'position', 'top-right');
            $('.btn').tooltip({ trigger: 'hover' });
            $('span').tooltip({ trigger: 'hover' });
            $('.ui-datepicker-calendar th span').tooltip('hide');
            $('.tooltip-inner').tooltip('hide');
            var checkval = 0;
            //Added B Dipali V On 12th Nov 2022 For SOnata Customzation
            if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                if ($("#cboRRProjectTOReq").val() == "0") {
                    alertify.error("Type of Requirement Should not be left blank.");
                    GblControlID = "#cboRRProjectTOReq";
                    $("#cboRRProjectTOReq").focus();
                    addReqDetails();
                    checkval = 1;
                    return false;
                }

            }

            if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                if ($("#cboRRProjectTOReq").val() == "2") {
                    if ($("#cboRRProjectRepEmployeeName").val() == "0") {
                        alertify.error("Replacement Employee Name Should not be left blank.");
                        GblControlID = "#cboRRProjectRepEmployeeName";
                        $("#cboRRProjectRepEmployeeName").focus();
                        addReqDetails();
                        checkval = 1;
                        return false;
                    }
                }
            }
            //End of Added By Dipali V On 12th Nov 2022 For SOnata Customzation


          //UnCommented by Chetan M on 14th Jan 2020 for issueid = 21225
            if ($("#cboRRProjectRoleAdd").val() == "0") {
                alertify.error("Project Role Should not be left blank.");
                //Added by Chetan M on 14th Jan 2020
                GblControlID = "#cboRRProjectRoleAdd";
                //End of Added by Chetan M on 14th Jan 2020
                $("#cboRRProjectRoleAdd").focus();
                checkval = 1;
                addReqDetails();
                return false;
            }
            //End of UnCommented by Chetan M on 14th Jan 2020 for issueid = 21225

            //if (checkval != 1) {
            if ($("#txtnoofresource").val() == "") {
                alertify.error("<%= MyBase.GetResourceString("C_A_NoofResource") %>");
                $("#txtnoofresource").focus();
                //Added by Chetan M on 14th Jan 2020
                GblControlID = "#txtnoofresource";
                addReqDetails();
                //End of Added by Chetan M on 14th Jan 2020
                checkval = 1;
                return false;

            }


            //Added By Dipali V On 12th Nov 2022 For SOnata Customzation
            if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                if (checkval != 1) {
                    if ($("#cboRRProjectTOReq").val() == "2") {
                        if ($("#txtnoofresource").val() > 1 || $("#txtnoofresource").val() == 0) {
                            alertify.error("In case of Replacement Request, No. Of Resources should be 1.");
                            $("#txtnoofresource").focus();
                            addReqDetails();
                            checkval = 1;
                            return false;
                        }
                    }
                }
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
                        addReqDetails();
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
                    addReqDetails();
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
                    addReqDetails();
                    return false;

                }
            }

         
            if ($("#RRstartdt").val() != "" || $("#RRenddt").val() != "") {
                var Datecheckval = ValidateWithProjectDates($("#RRstartdt").val(), $("#RRenddt").val());
                if (Datecheckval == 0) {
                    checkval = 0;
                    //return false;
                } else {
                    checkval = 1;
                    addReqDetails();
                    return false;
                }
            }
            //Commented By Rutuja D 10 Jan 2020 For Wrong Alert Sequence


            if (checkval != 1) {
                if ($("#cbotype").val() == "0") {
                    alertify.error("Allocation Unit Should not be left blank");
                    $("#cbotype").focus();
                     //Added by Chetan M on 14th Jan 2020
                    GblControlID = "#cbotype";
                    addReqDetails();
                     //End of Added by Chetan M on 14th Jan 2020     
                    checkval = 1;
                    return false;

                }
            }

           //UnCommented by Chetan M on 13th Jan 2020 for issueid = 21225
           if (checkval != 1) {
                if ($("#txtRWorkHours").val() == "") {
                    alertify.error("<%= MyBase.GetResourceString("A_RWorkHours") %>");
                    //alertify.error("Work Hours should not be left blank.");
                    $("#txtRWorkHours").focus();
                    //Added by Chetan M on 14th Jan 2020
                        GblControlID = "#txtRWorkHours";
                        //End of Added by Chetan M on 14th Jan 2020
                    checkval = 1;
                    addReqDetails();
                    return false;

               }

               //Added By Dipali V On 25th April 2023 For Allocation % should be allow zero
               if ($("#txtRWorkHours").val() <= 0) {
                   alertify.error('Work hours per resource should not be less than or equal to zero(0)');
                   $('#txtRWorkHours').focus();
                   GblControlID = "#txtRWorkHours";
                   checkval = 1;
                   addReqDetails();
                   return false;
               }
                 //End of Added By Dipali V On 25th April 2023 For Allocation % should be allow zero


            }
            //Added By Riddhesh Patil on 15-NOV-2022 
            if (checkval != 1) {
                
                if (checkSpecialCharacter($("#txtSpecialRequest").val(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Special Request should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    $("#txtSpecialRequest").focus();
                    chkval = 1;
                    addReqDetails();
                    return false;
                }
			
            }
            //End of Added By Riddhesh Patil
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

            //Added By Dipali V On 12th Nov 2022 For SOnata Customzation
            if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                if (checkval != 1) {
                    if ($("#cboRRProjectDepartment").val() == "0") {
                        alertify.error("Department Should not be left blank.");
                        GblControlID = "#cboRRProjectDepartment";
                        $("#cboRRProjectDepartment").focus();
                        checkval = 1;
                        addReqDetails();
                        return false;
                    }
                }
            }
            //Added by Dipali V on 6th May 2026 for vendor management - mandatory vendor selection in resource request creation
            //if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
            //    if (checkval != 1) {
            //        if ($("#cboRRProjectVendor").val() == "0") {
            //            alertify.error("Vendor Should not be left blank.");
            //            GblControlID = "#cboRRProjectVendor";
            //            $("#cboRRProjectVendor").focus();
            //            checkval = 1;
            //            addReqDetails();
            //            return false;
            //        }
            //    }
            //}

            if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                if (checkval != 1) {
                    if ($("#cboRRProjectLocation").val() == "0") {
                        alertify.error("Location Should not be left blank.");
                        GblControlID = "#cboRRProjectLocation";
                        $("#cboRRProjectLocation").focus();
                        checkval = 1;
                        addReqDetails();
                        return false;
                    }
                }
            }

            if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                if (checkval != 1) {
                    if ($("#cboRRProjectEngagementModel").val() == "0") {
                        alertify.error("Engagement Model Should not be left blank.");
                        GblControlID = "#cboRRProjectEngagementModel";
                        $("#cboRRProjectEngagementModel").focus();
                        checkval = 1;
                        addReqDetails();
                        return false;
                    }
                }
            }

            if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                if (checkval != 1) {
                    if ($("#cboRRProjectBillablePosition").val() == "0") {
                        alertify.error("Billable Position Should not be left blank.");
                        GblControlID = "#cboRRProjectBillablePosition";
                        $("#cboRRProjectBillablePosition").focus();
                        checkval = 1;
                        addReqDetails();
                        return false;
                    }
                }
            }

            if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                if (checkval != 1) {
                    if ($("#cboRRProjectBillablePosition").val() == "2") {
                        if ($("#RRillingStartDate").val() == "") {
                            alertify.error("Billing Start Date Should not be left blank.");
                            GblControlID = "#RRillingStartDate";
                            $("#RRillingStartDate").focus();
                            checkval = 1;
                            addReqDetails();
                            return false;
                        }
                    }
                }
            }

            if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                if (checkval != 1) {
                    if ($("#cboRRProjectSOWAvailable").val() == "0") {
                        alertify.error("SOW Available Should not be left blank.");
                        GblControlID = "#cboRRProjectSOWAvailable";
                        $("#cboRRProjectSOWAvailable").focus();
                        checkval = 1;
                        addReqDetails();
                        return false;
                    }
                }
            }
            //debugger;
            if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                if (checkval != 1) {
                    if (IsFileadded == 0) {
                        alertify.error("JD Attachment Should not be left blank.");
                        checkval = 1;
                        addReqDetails();
                        return false;
                    }
                }
            }

            if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                //Added By Dipali V On 14th Nov 2022 For Sonata Customzation
                ValidateAttachmentFlag = ValidateAttachment();
                //End of Added By Dipali V On 14th Nov 2022 For Sonata Customzation

                if (ValidateAttachmentFlag == true) {
                    checkval = 0;
                } else {
                    checkval = 1;
                    addReqDetails();
                }
            }
               //End of Added By Dipali V On 12th Nov 2022 For SOnata Customzation






            if ($("#txtRWorkHours").val() != '' && checkval == 0 && $("#cbotype").val() != 'P') {
                 //2020
                var result = WorkHoursValidation("txtRWorkHours");
                if (result == true) {
                    checkval = 0;
                } else {
                    checkval = 1;
                    //Added by Chetan M on 14th Jan 2020
                    GblControlID = "#txtRWorkHours";
                    addReqDetails();
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
                    addReqDetails();
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
                var NoOfResources = parseInt($("#txtnoofresource").val());

                if (WorkHours != "") {
                    var ProjectID = SessionProjectID;
                    if (WorkHours.indexOf(':') > -1) {
                        var RequestParameters = {
                            WorkHrs: encodeURI(WorkHours),
                            Flag: encodeURI(2),
                        }
                        var param = JSON.stringify(RequestParameters);
                        var WorkHours = AJAXCallWithResult(encodeURI(strUrl) +"/api/PM_RequestedResources/ConvertDecimalToHourViceVersa", param, false);
                    } else {
                        WorkHours = WorkHours;
                    }
                    RequestParameters = {
                        ProjectID: encodeURI(ProjectID),
                    }

                    var param = JSON.stringify(RequestParameters);
                    var ProjectBalHrs = AJAXCallWithResult(encodeURI(strUrl) +"/api/PM_RequestedResources/GetProjectBalHrs", param, false);

                    var param = JSON.stringify(RequestParameters);
                    var intWorkHours = AJAXCallWithResult(encodeURI(strUrl) +"/api/PM_RequestedResources/GetLocationWorkingHours", param, false);

                    var param = JSON.stringify();
                    var objResPer = AJAXCallWithResult(encodeURI(strUrl) +"/api/PM_RequestedResources/GetresourceHrs", param, false);

                    maxhrs = parseFloat(intWorkHours) * parseInt(objResPer) / 100;
                    var fltTotalWorkHrs = parseFloat(WorkHours) * parseFloat(NoOfResources);

                    if (ResourceType == 'TH') {
                        if (ProjectBalHrs != null || ProjectBalHrs != undefined || ProjectBalHrs != '') {
                            if (parseFloat(ProjectBalHrs) < parseFloat(fltTotalWorkHrs)) {
                                alertify.error("<%= MyBase.GetResourceString("A_TotalWorkHours") %> " + ProjectBalHrs);
                                $('#txtRWorkHours').focus();
                                 //Added by Chetan M on 14th Jan 2020
                                 GblControlID = "#txtRWorkHours";
                                addReqDetails();
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
                            addReqDetails();
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
                            addReqDetails();
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
                        addReqDetails();
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
                //    SelectedProjectID: SessionProjectID,
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


        var savefile = 0;
        function attachement(arrGlobalrequestID) {
            //debugger;
            var formData = new FormData();
            var objFileGrid = document.getElementById('tblFiles');

            //Added by dipali V on 11th Sep 2019 for multiple insertation of attachments
            fileObject = [];
            $("#FileControlUploadDiv [type=File]").each(function (j, val) {
                if ($(this)[0].files.length != 0) {
                    fileObject[(j)] = $(this)[0].files;
                }
            })

            for (var i = 0; i < fileObject.length; i++) {
                if (fileObject[i] != null || fileObject[i] != undefined) {
                    formData.append(fileObject[i][0].name, fileObject[i][0]);
                    // formData.append(arrGlobalrequestID[k], arrGlobalrequestID[k]);
                    OldFileName = $("#FILENAME0 td:nth-child(1)").text();
                }
            }

            if (savefile == 0) {
                if (formData != "[]") {
                    $.ajax({
                        url: encodeURI(strUrl + '/api/PM_AddNewResource/FileUplaod'),
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false,
                        method: 'POST',
                        type: 'POST',
                        async: false,
                        beforeSend: function (xhr) {
                            // xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                        },
                        success: function (result) {
                            if (result.length > 0) {
                                var ProjectId = '<%=Session("intProjectID")%>';
                                var UserName = '<%=Session("strUserName")%>';
                                for (var k = 0; k < arrGlobalrequestID.length; k++) {
                                    var UploadFileParameter = [ProjectId, arrGlobalrequestID[k], $("#FILENAME0 td:nth-child(1)").text(), result[0], UserName];
                                    $.ajax({
                                        url: encodeURI(strUrl) + '/api/PM_AddNewResource/FileUplaodSaveDB',
                                        method: 'Post',
                                        data: JSON.stringify(UploadFileParameter),
                                        dataType: 'json',
                                        async: false,
                                        contentType: "application/json",

                                        beforeSend: function (xhr) {
                                            //xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                                        },
                                        success: function (result) {
                                            if (result == "Successfully uploaded file") {
                                                savefile = 1;
                                            }

                                        },
                                        error: function (xhr, errorThrown) {
                                            //alert("error ");
                                        }
                                    });
                                }
                            }
                            else {
                                if (fileObject.length == 0 && (IsResourceRequestNewFieldsManatory == 0 || IsResourceRequestNewFieldsManatory == "False")) {
                                    savefile = 1;
                                }
                            }
                        },
                        error: function (xhr, errorThrown) {
                            // alert("error ");
                        }
                    });
                } else {
                    if (IsResourceRequestNewFieldsManatory == 0 || IsResourceRequestNewFieldsManatory == "False") {
                        savefile = 1;
                    }
                }
            }
            return savefile;

        }



        var arrSkill = new Array();
        var Skillname = "";
        var arryear = new Array();
        var arrmonth = new Array();
        var arrRate = new Array();
        var ProjectSkillAdd = 0;
        var arrSkillNotPRoject = "";
        var arrIsCoreCompetency = new Array();
        var uniqueSkillNames = [];
        // Skill Click To Add Multiple or single skill set
        function Skill_onClick(FromWhereFlag)
        {
            alertify.set('notifier', 'position', 'top-right');

            GlobalrequestID = 0;
            var IsValid = Request_onClick(FromWhereFlag);
            //Added by Chetan M on 17th Jan 2020
            var objHdnFields1 = document.getElementsByClassName('clsMandatoryFields');
            //var ControlID = "#"+ objHdnFields1[0].id;
            //var ControlIDVal = ControlID.value();
          
            if (IsValid == true) {
                if (IsRequestResourceSkillMandatory == 1 || IsRequestResourceSkillMandatory == "True") {
                    if ($("#tbodySkill tr").length > 0) {
                        if ($("#cboSkillMaster0").val() == 0) {
                            alertify.error("Please enter the skill details.");
                            SkillValidationFlag = 1;
                            $("#cboSkillMaster0").focus();
                            AddSkill();

                            Skillname = "";
                            IsValid = false;

                        } else {
                            SkillValidationFlag = 0;
                            IsValid = true;
                        }
                    }
                    else {
                        //alertify.error("Add at least " + parseInt(Count_Request_ResourceSkill) + " skill set.");
                        alertify.error("Please enter at least one skill set");
                        SkillValidationFlag = 1;
                        AddSkill();
                        $("#cboSkillMaster0").focus();
                        IsValid = false;
                        Skillname = "";
                    }

                }
                else {
                    IsValid == true;
                }
                //End of added by Chetan M on 17th Jan 2020

            }

            if (IsValid == true)
            {
                //GlobalrequestID = CreateRequest();               
                CreateRequest();
                if (arrGlobalrequestID != "") {
                    attachement(arrGlobalrequestID);
                }
               // $("#btnCreateReq").attr("disabled");
                if (arrGlobalrequestID != "" && savefile == 1)
                {
                    StartLoader("#AddNewResource");
                    //Imran 07-07-2021 Add Skill set values if objHdnFields.length=0 then Direct Email send
                    var objHdnFields = document.getElementsByClassName('clsMandatoryFields');
                    var i = 0;
                    var IsCoreCompetency = 0;
                    
                    if (objHdnFields.length != "0")
                    {
                        for (i = 0; i < objHdnFields.length; i++) {
                            var object = document.getElementById(objHdnFields[i].id);
                            var ControlID = objHdnFields[i].id;
                            if (ControlID.indexOf('Skill') > -1) {
                                arrSkill.push($("#" + ControlID).val());
                                if (Skillname == "") {
                                    Skillname = $("#" + ControlID).val();
                                } else {
                                    Skillname += "," + $("#" + ControlID).val();
                                }
                               // Skillname = removeDuplicates(Skillname);
                            }

                            if (ControlID.indexOf('Year') > -1) {
                                if ($("#" + ControlID).val() != "") {
                                    arryear.push($("#" + ControlID).val());
                                }
                            }

                            if (ControlID.indexOf('Month') > -1) {
                                if ($("#" + ControlID).val() != "") {
                                    arrmonth.push($("#" + ControlID).val());
                                }
                            }

                            if (ControlID.indexOf('Parameters') > -1) {
                                if ($("#" + ControlID).val() != "") {
                                    arrRate.push($("#" + ControlID).val());
                                }
                            }

                            if (ControlID.indexOf('CheckCoreCompantency') > -1) {
                                var IsCoreCompetencychecked = 0;
                                if ($("#" + ControlID).is(":checked")) {
                                    IsCoreCompetencychecked = 1
                                } else {
                                    IsCoreCompetencychecked = 0;
                                }
                                arrIsCoreCompetency.push(IsCoreCompetencychecked);

                                if ($("#" + ControlID).is(":checked")) {
                                    IsCoreCompetency = IsCoreCompetency + 1;
                                }
                            }
                        }

                        //Added By Dipali V On 22nd Dec 2022 For Remove CoreCompency
                        if (IsRequestResourceSkillMandatory == 1 || IsRequestResourceSkillMandatory == "True") {
                            if (IsCoreCompetency == 0 && (IsResourceSkillCoreCompetencyMandatory == 1 || IsResourceSkillCoreCompetencyMandatory == "True")) {
                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error("Please select at least one skill as core competency.");
                                $("#" + ControlID).focus();
                                AddSkill();
                                arrSkill = [];
                                arrChecked = [];
                                arrSelectedEmployeeNames = [];
                                arrSelectedEmployeeIds = [];
                                arrmonth = [];
                                arrRate = [];
                                arryear = [];
                                // arrGlobalrequestID = [];
                                arrIsCoreCompetency = [];
                                Skillname = "";
                                return;
                            }
                        }
                        
                        var RequestParameters =
                        {
                            SkillName: Skillname,
                            SelectedProjectID: SessionProjectID
                        }
                        //debugger;
                        var param = JSON.stringify(RequestParameters);
                        var StrResult = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_AddNewResource/CheckSkillOnProjectNot", param, false);
                        if (StrResult.length != "0" && StrResult[0].Description != "") {
                            for (i = 0; i < StrResult.length; i++) {
                                //if (arrSkillNotPRoject == "") {
                                arrSkillNotPRoject = StrResult[i].Description;
                                //} else {
                                //    if (arrSkillNotPRoject.indexOf(",") > -1) {
                                //        arrSkillNotPRoject += "," + arrSkillNotPRoject;
                                //    }
                                //    else {
                                //        //arrSkillNotPRoject = arrSkillNotPRoject;
                                //        arrSkillNotPRoject += "," + StrResult[i].Description;
                                //    }

                                //}
                            }
                            $("#skillNames").text("");
                            $("#skillNames").text( "'" + arrSkillNotPRoject + "'"  );
                            $("#SaveSkillConformation").modal('show');
                            ProjectSkillAdd = 1;
                        }
                        else
                        {
                            for (k = 0; k < arrGlobalrequestID.length; k++) {
                                for (j = 0; j < arrSkill.length; j++) {
                                    var RequestParameters =
                                    {
                                        SkillName: arrSkill[j],
                                        Month: arrmonth[j],
                                        Year: arryear[j],
                                        Rating: arrRate[j],
                                        RequestID: arrGlobalrequestID[k],
                                        ProjectSkillAdd: ProjectSkillAdd,
                                        SelectedProjectID: SessionProjectID,
                                        //Added By Dipali V On 14th Nov 2022 For Sonata Customzation
                                        IsCoreCompetency: arrIsCoreCompetency[j]
                                    }
                                    StartLoader("#AddNewResource");
                                    var param = JSON.stringify(RequestParameters);
                                    var StrResult = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_AddNewResource/SaveSkill", param, false);

                                    if (StrResult != "") {
                                        StopAjaxLoader("#AddNewResource");
                                        //if (arrSkill[i] != "0") {
                                        //    alertify.set('notifier', 'position', 'top-right');
                                        //    alertify.success("Skill added successfully.");
                                        //} else {  // }

                                        //alertify.set('notifier', 'position', 'top-right');
                                        //setTimeout(function () {
                                        //    alertify.success("Request sent successfully.");
                                        //}, 1500);

                                        ////Added by imran 09-08-2021
                                        //$("#ResourceClearAllFilter").hide();
                                        //ResourceFilters();
                                        ////End By imran 09-08-2021

                                        //SendEmailClick();
                                        //cancelRequest();
                                        //GlobalrequestID = "";
                                        //StopAjaxLoader("#AddNewResource");
                                        //$("#resourcerequest").modal('hide');
                                        //arrSkill = [];
                                        //arrChecked = [];
                                        ////Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                                        //arrSelectedEmployeeNames = [];
                                        //arrSelectedEmployeeIds = [];
                                        ////End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                                        //arrmonth = [];
                                        //arrRate = [];
                                        //arryear = [];
                                        //$("#tbodySkill").html("");
                                    }
                                }
                            }

                            alertify.set('notifier', 'position', 'top-right');
                            setTimeout(function () {
                                alertify.success("Request sent successfully.");
                            }, 1500);


                            // }
                            SendEmailClick();
                            cancelRequest();
                            GlobalrequestID = "0";
                            StopAjaxLoader("#AddNewResource");
                            $("#resourcerequest").modal('hide');
                            arrSkill = [];
                            arrChecked = [];
                            //Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                            arrSelectedEmployeeNames = [];
                            arrGlobalrequestID = [];
                            arrSelectedEmployeeIds = [];
                            //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                            arrmonth = [];
                            arrRate = [];
                            arryear = [];
                            //Added By Dipali V On 14th Nov 2022 For Sonata Customzation
                            arrIsCoreCompetency = [];
                            IsFileadded = 0;
                            savefile = 0;
                            $("#tbodySkill").html("");
                            arrSkillNotPRoject = "";
                          //End of Added By Dipali V On 14th Nov 2022 For Sonata Customzation

                        }
                    }
                    else
                    {
                        StopAjaxLoader("#AddNewResource");
                        alertify.set('notifier', 'position', 'top-right');
                        setTimeout(function () {
                            alertify.success("Request sent successfully.");
                        }, 1500);

                        SendEmailClick();
                        cancelRequest();
                        GlobalrequestID = "0";
                        StopAjaxLoader("#AddNewResource");
                        $("#resourcerequest").modal('hide');
                        arrSkill = [];
                        arrChecked = [];
                        //Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                        arrSelectedEmployeeNames = [];
                        arrSelectedEmployeeIds = [];
                        arrGlobalrequestID = [];
                        //End Of Added By Usha Pandit On 24.03.2021 For selecting checkbox with correct id
                        arrmonth = [];
                        arrRate = [];
                        arryear = [];
                        IsFileadded = 0;
                        savefile = 0;
                        //Added By Dipali V On 14th Nov 2022 For Sonata Customzation
                        arrIsCoreCompetency = [];
                        arrSkillNotPRoject = "";
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

        //Send Email Functionality
        function SendEmailClick()
        {
            var RequestParameters = {
                RequestID: encodeURI(GlobalrequestID),
            }
            var param = JSON.stringify(RequestParameters);
           // var strResult = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_RequestedResources/SendEmail", param, false);
            var strResult = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_AddNewResource/SendEmail", param, false);

            var Flag = strResult
            if (Flag == 1) {
                for (var n = 0; n < arrGlobalrequestID.length; n++) {
                    window.open("../Email/SendEmail.aspx?MessageID=75&RequestID=" + arrGlobalrequestID[n] + "", '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=200,top=100,width=650,height=550');

                }
            }
        }

        function ProjectSkill_onClick(ProjectSkillAdd) {
           // debugger;
            arrSkill = [];
            arrmonth = [];
            arrRate = [];
            arryear = [];
            arrIsCoreCompetency = [];
            var objHdnFields = document.getElementsByClassName('clsMandatoryFields');
            var i = 0;
            for (i = 0; i < objHdnFields.length; i++) {
                var object = document.getElementById(objHdnFields[i].id);
                var ControlID = objHdnFields[i].id;
                if (ControlID.indexOf('Skill') > -1) {
                    if ($("#" + ControlID).val() != "") {
                        arrSkill.push($("#" + ControlID).val());
                    }
                    arrSkill = removeDuplicates(arrSkill);

                }

                if (ControlID.indexOf('Year') > -1) {
                    if ($("#" + ControlID).val() != "") {
                        arryear.push($("#" + ControlID).val());
                    }
                    //arryear = removeDuplicates(arryear);
                }


                if (ControlID.indexOf('Month') > -1) {
                    if ($("#" + ControlID).val() != "") {
                        arrmonth.push($("#" + ControlID).val());
                    }
                    //arrmonth = removeDuplicates(arrmonth);

                }

                if (ControlID.indexOf('Parameters') > -1) {
                    if ($("#" + ControlID).val() != "") {
                        arrRate.push($("#" + ControlID).val());
                    }
                    arrRate = removeDuplicates(arrRate);

                }



                //Added By Dipali V On 14th Nov 2022 For Sonata Customzation
                if (ControlID.indexOf('CheckCoreCompantency') > -1) {
                    var IsCoreCompetencychecked = 0;
                    if ($("#" + ControlID).is(":checked")) {
                        IsCoreCompetencychecked = 1
                    } else {
                        IsCoreCompetencychecked = 0;
                    }
                    arrIsCoreCompetency.push(IsCoreCompetencychecked);
                    //arrIsCoreCompetency = removeDuplicates(arrIsCoreCompetency);
                }
                //End of Added By Dipali V On 14th Nov 2022 For Sonata Customzation

            }
            for (k = 0; k < arrGlobalrequestID.length; k++) {
                for (l = 0; l < removeDuplicates(arrSkill).length; l++) {
                    var RequestParameters =
                    {
                        SkillName: arrSkill[l],
                        Month: arrmonth[l],
                        Year: arryear[l],
                        Rating: arrRate[l],
                        //RequestID: GlobalrequestID,
                        RequestID: arrGlobalrequestID[k],
                        ProjectSkillAdd: ProjectSkillAdd,
                        SelectedProjectID:SessionProjectID,
                        //Added By Dipali V On 14th Nov 2022 For Sonata Customzation
                        IsCoreCompetency: arrIsCoreCompetency[l]
                    }

                    var param = JSON.stringify(RequestParameters);
                    var StrResult = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_AddNewResource/SaveSkill", param, false);
                    // return;
                    if (StrResult != "") {
                        //Commented By Dipali V On 14th Nov 2022 For Sonata Customzation
                        //// alertify.set('notifier', 'position', 'top-right');
                        ////alertify.success("Skill added successfully.");
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.success("Request sent successfully.");
                        //SendEmailClick();
                        //cancelRequest();
                        //$("#resourcerequest").modal('hide');
                        //arrSkill = [];
                        //arrmonth = [];
                        //arrRate = [];
                        //arryear = [];
                        //End of commented By Dipali V On 14th Nov 2022 For Sonata Customzation
                    }
                }
            }

            //Added By Dipali V On 14th Nov 2022 For Sonata Customzation
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
            arrGlobalrequestID = [];
            IsCoreCompetency = [];
            IsFileadded = 0;
            savefile = 0;
            arrSkillNotPRoject = "";
            //End of Added By Dipali V On 14th Nov 2022 For Sonata Customzation
        }

       function CreateRequest()
       {

           var NoOFResouce = "";
           var ResourceNOOf = "";
           if (IsResourceRequestsplittingbased == 1 || IsResourceRequestsplittingbased == "True") {
               NoOFResouce = parseInt($("#txtnoofresource").val());
               ResourceNOOf = 1;
           } else {
               NoOFResouce = 1;
               ResourceNOOf = parseInt($("#txtnoofresource").val());
           }
           var UserName = '<%=Session("strUserName")%>'
           if (arrGlobalrequestID == "") {
               NoOFResouce = parseInt(NoOFResouce);
               for (M = 0; M < NoOFResouce; M++) {
                   var RequestParameters = {
                       UserName: UserName,
                       UserID: UserID,
                       RequestDate: Today,
                       //SelectedProjectID: SessionProjectID,
                       SelectedProjectID: SessionProjectID,
                       SelectedRoleID: $("#cboRRProjectRoleAdd").val(),
                       FromDate: $("#RRstartdt").val(),
                       ToDate: $("#RRenddt").val(),
                      // NoOfResource: $("#txtnoofresource").val(),
                       NoOfResource: ResourceNOOf,
                       WorkHrs: $("#txtRWorkHours").val(),
                       Type: $("#cbotype").val(),
                       ResourcePool: $("#cboResourcePools").val(),
                       Priority: $("#cboRPriority").val(),
                       SpecialRequest: $("#txtSpecialRequest").val(),
                       //Added By Dipali V On 14th Nov 2022 For Sonata Customzation
                       TypeofRequirement: $("#cboRRProjectTOReq").val(),
                       ReplacementEmployeeName: $("#cboRRProjectRepEmployeeName").val(),
                       Department: $("#cboRRProjectDepartment").val(),
                       Vendor: $("#cboRRProjectVendor").val(),
                       Location: $("#cboRRProjectLocation").val(),
                       EngagementModel: $("#cboRRProjectEngagementModel").val(),
                       BillablePosition: $("#cboRRProjectBillablePosition").val(),
                       BillingStartDate: $("#RRillingStartDate").val(),
                       SOWAvailable: $("#cboRRProjectSOWAvailable").val(),
                       NatureofRequest: $("#txtRNatureofRequest").val(),
                       UserName : UserName
                        //End of Added By Dipali V On 14th Nov 2022 For Sonata Customzation

                   }
                   //StartLoader("#AddNewResource");
                   var param = JSON.stringify(RequestParameters);
                   var StrResult = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_AddNewResource/RequestResource", param, false);

                   if (StrResult != "") {

                       //$("#RequestAddconfirm").modal('show');
                       //cancelRequest();

                       GlobalrequestID = StrResult;
                       arrGlobalrequestID.push(GlobalrequestID);
                       //  GetRequestSkillDetails(GlobalrequestID)
                       // $("#resourcerequest").modal('hide');
                       //alert(GlobalrequestID);
                   }
               }
               // return arrGlobalrequestID;
               console.log(arrGlobalrequestID);
           }
       }
       //Cancel to clear popup Resource value
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
           $("#cboRRProjectTOReq").val(0);
           $("#cboRRProjectRepEmployeeName").val(0);
           $("#cboRRProjectDepartment").val(0);
           $("#cboRRProjectVendor").val(0);
           $("#cboRRProjectLocation").val(0);
           $("#cboRRProjectEngagementModel").val(0);
           $("#cboRRProjectBillablePosition").val(0);
           $("#cboRRProjectSOWAvailable").val(0);
           $(".tooltip").removeClass('show');

            $(".chcktbl").prop("checked", false);
            StopAjaxLoader("#AddNewResource");
            //$("#resourcerequest").modal('hide');
        }

       //script added for add skillset 
        var counter = 0;
        //Added by Chetan M on 17th Jan 2020 
        var AddSkillFlag = 0;
        var SkillValidationFlag = 0;
        //End of Added by Chetan M on 17th Jan 2020 
        var arrCount = new Array();
        $("#addskillsetrow").on("click", function ()
        {           
            $(".tooltip").removeClass('show');
            //if ($("#tbodySkill tr").length < 1 && $("#cboSkillMaster0").val() != "0")        
            if ($("#tbodySkill tr").length < Count_Request_ResourceSkill) 
            {
                //Added by Chetan M on 17th Jan 2020 
                AddSkillFlag = 1;
                arrCount = [];
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

                StrHtmlMonth = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboMonthName", "usp_Sel_GetYears 0 ,30 ", 50,  , "Mandatory=1 class=""form-control clsMandatoryFields""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                StrHtmlMonth = StrHtmlMonth.replace(/Name/g, counter);
                finalmonth += StrHtmlMonth;
                
                StrHtmlYear = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboYearName", "usp_Sel_GetYears 0 ,11 ", 50, , "Mandatory=1 class=""form-control clsMandatoryFields""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                StrHtmlYear = StrHtmlYear.replace(/Name/g, counter);
                finalyear += StrHtmlYear;

                cols += '<td class="exprience"> ' + StrHtmlMonth + ' To ' + StrHtmlYear + '</td>';

                strProfficiencyhtmlNew = '<%=CommonFunctions.HTMLControls.DrawComboBox("cboParametersName", "usp_Whizible2_Sel_tbl_HR_Parameters 7 ", , , "Mandatory=1 class=""form-control clsMandatoryFields""", False, ReturnAsHTML:=True, TabIndex:=1).ToString.Replace("'", "\'")%>';
                strProfficiencyhtmlNew = strProfficiencyhtmlNew.replace(/Name/g, counter);
                strPffhtml += strProfficiencyhtmlNew;

                cols += '<td> ' + strPffhtml + '</td>';
                cols += '<td><input type="checkbox" id="CheckCoreCompantency' + counter + '" name="CheckCoreCompantency' + counter + '"  class="clsMandatoryFields" onclick="validateCoreCompantency(this.id)"></td>';
                cols += '<td><button class="ibtnDel nostylebtn"><i class="far fa-trash-alt" title="" data-bs-toggle="tooltip" data-placement="top" data-container="body" data-original-title="Delete" onclick="SkillDelete_onclick()"></i></button></td>';


                newRow.append(cols);
                $("#Rskillsettab table").append(newRow);
                GetRequestSkillCombo(counter);
     
                $("#cboMonth" + counter).prepend(new Option("Select Year", "0"));
                $("#cboMonth" + counter).val("0");
                $("#cboYear" + counter).prepend(new Option("Select Month", "0"));
                $("#cboYear" + counter).val("0");

                counter++;
                getblankrow(counter);
                $("select option").removeAttr("title");
            }
            else {

                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Maximum " + Count_Request_ResourceSkill + " skills are allowed to add");
                $("#cboSkillMaster" + Count_Request_ResourceSkill).focus();
                return;
            }
        });


        /* Added By Dipali V On 22nd Dec 2022 For Remove Corepencny*/
        function validateCoreCompantency(SelectedCoreCompantency) {
            // $(".clsMandatoryFields").prop("checked", false);
            // $("#" + SelectedCoreCompantency).prop("checked", true);

        }

        function GetCorecompentancy(SelectedProficiency) {
            //alert(SelectedProficiency);
            // debugger;
            //var Id = SelectedProficiency.replace("cboParameters","");
            //if ($("#" + SelectedProficiency).val()!= "0") {
            //    $("#CheckCoreCompantency" + Id).removeAttr("disabled");
            //} else {
            //    $("#CheckCoreCompantency" + Id).prop("disabled",true);
            //}


        }


        function getblankrow(counter) {
            for (var i = 0; i < counter - 1; i++) {
                //debugger;
                if ($("#cboMonth" + i).val() == "") {
                    $("#cboMonth" + i).prepend(new Option("Select Year", "0"));
                    $("#cboMonth" + i).val("0");
                }

                //if ($("#cboMonth" + i).val() == "0") {
                //    $("#cboMonth" + i).prepend(new Option("Select Year", "0"));
                //    $("#cboMonth" + i).val("0");
                //}

                if ($("#cboYear" + i).val() == "") {
                    $("#cboYear" + i).prepend(new Option("Select Month", "0"));
                    $("#cboYear" + i).val("0");
                }

                //if ($("#cboYear" + i).val() == "0") {
                //    $("#cboYear" + i).prepend(new Option("Select Month", "0"));
                //    $("#cboYear" + i).val("0");
                //}
            }
        }

        function SkillDelete_onclick() {
            AddSkillFlag = 0;
        }

        //Skill Combo Fill
        function GetRequestSkillCombo(counter)
        {       
            var IsExternal = "";
            var ChkIsExternal = "";
            var strResult1 = GetSkillIsExternal();

            var ResourceParameters = {
                RequestID: encodeURI(GlobalrequestID),               
                //Change By Imran  SessionProjectID inseted of ProjectID
                ProjectID: encodeURI(SessionProjectID),
            }

            var param = JSON.stringify(ResourceParameters);           
            var strResult = AJAXCallWithResult(encodeURI(strUrl) +"/api/PM_AddNewResource/GetRequestSkillCombo", param, false);
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

        //click back popup buttongo to previous tab
        function Back_onClick() {
            $("#idReqDetails").addClass("active");
            $("#idSkill").removeClass("active");
            $("#Rskillsettab").removeClass("active");
            $("#Rrequesttab").addClass("active");
        }
        
        function GetSkillIsExternal() {

            var ResourceParameters = {
                RequestID: encodeURI(GlobalrequestID),
                ProjectID: encodeURI(ProjectID),
            }
            var param = JSON.stringify(ResourceParameters);
            var strResult = AJAXCallWithResult(encodeURI(strUrl) +"/api/PM_AddNewResource/GetRequestSkillCombo", param, false);
            return strResult;
        }

        $("#Rskillsettab table").on("click", ".ibtnDel", function (event) {
            if (("#tbodySkill tr").length != 0) {
                $(this).closest("tr").remove();
                counter -= 1
            } else {
                $("#addskillsetrow").attr("disabled", true);
            }

        });

        $('#RRstartdt, #RRenddt,#RRillingStartDate').datepicker({
                autoclose: true,
                changeMonth: true,
                changeYear: true,
            dateFormat: 'dd M yy',
            //onSelect: function (date, datepicker) {
            //    $(".tooltip").removeClass('show');
            //}//added by pradip on 23-12-2022 for tooltip issu
        });


        //(".ui-datepicker-header").on("mouseenter", function () {
        //    alert();
        //    $('.ui-datepicker-header th span').tooltip('hide');
        //});
        //project Date Validate
        function ValidateWithProjectDates(FromDate, ToDate)
        {
            var checkval = 0;
            var result = GetProjectStartDateEndDate(ProjectID);   
            Today = SelectedCurrentdate.toShortFormat();
           
            for (var i = 0; i < result.length; i++) {
               
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

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

        var ResourcePoolIsMandatory = "";

        //Added By Rutuja D. 9 Jan 2020 For Check Resource Pool Is Mandatory Or Not
        function CheckResourcePoolMandatory() {
            var param = JSON.stringify();
            var result = AJAXCallWithResult(encodeURI(strUrl) +"/api/PM_AddNewResource/CheckResourcePoolMandatory", param, false);
            ResourcePoolIsMandatory = result;          
        }

        function AddSkill()
        {
            //$("#RequestAddconfirm").modal('hide');
            //$("#idSkill").removeClass("disabled");
            $("#idReqDetails").removeClass("active");
            $("#idSkill").addClass("active");
            $("#Rskillsettab").addClass("active");
            $("#Rrequesttab").removeClass("active");
            $("#Rrequesttab").removeClass("show");
            $("#liareq").removeClass("active");
            $("#liaskill").addClass("active");
            $(".tooltip").removeClass('show');
          
          
        }


        $("#liaskill").on("click", function () {
            if (IsRequestResourceSkillMandatory == true || IsRequestResourceSkillMandatory == "True") {
                $("#skillnote").css('display', 'none')
            } else {
                $("#skillnote").css('display', 'block')
            }
        });

        $("#liareq").on("click", function () {
            $("#skillnote").css('display', 'none')
            //Added By Dipali V On 12th May 2023 For Note Should display if skill non mandatory
            if (IsRequestResourceSkillMandatory == true || IsRequestResourceSkillMandatory == "True") {
                $("#skillnote").css('display', 'none')
            } else {
                $("#skillnote").css('display', 'block')
            }
              //End of Added By Dipali V On 12th May 2023 For Note Should display if skill non mandatory
        });
        

        //Added By Dipali V On 12th Nov 2022 For Sonata Customzation
        function ValidateReEmployeeName(selectedvalue) {
            if (selectedvalue == 2) {
                $("#spncboRRProjectRepEmployeeName").css("display", "inline-block");
                $("#spnidresourceEmployee").css("display", "inline-block");
                $("#cboRRProjectRepEmployeeName").removeAttr("disabled");
            } else {
                $("#spncboRRProjectRepEmployeeName").css("display", "none");
                $("#spnidresourceEmployee").css("display", "none");
                $("#cboRRProjectRepEmployeeName").attr("disabled", "disabled");
                $("#cboRRProjectRepEmployeeName").val("0");
            }
        }

        var selectedAddedDate = "";
        function ValidateBillingStartDate(selectedvalue) {
            if (selectedvalue == 1) {

                if (IsResourceRequestNewFieldsManatory == 1 || IsResourceRequestNewFieldsManatory == "True") {
                    $("#spnRRillingStartDate").css("display", "inline-block");
                }
                $("#RRillingStartDate").removeAttr("disabled");
                const month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                const today = new Date();
                today.setDate(today.getDate() + 30);
                const yyyy = today.getFullYear();
                let mm = month[today.getMonth()]; // Months start at 0!
                let dd = today.getDate();

                if (dd < 10) dd = '0' + dd;
                if (mm < 10) mm = '0' + mm;
                const formattedToday = dd + ' ' + mm + ' ' + yyyy;
                $("#RRillingStartDate").val(formattedToday);
                selectedAddedDate = formattedToday;

            } else {
                $("#spnRRillingStartDate").css("display", "none");
                $("#RRillingStartDate").attr("disabled", "disabled");

            }
        }

        function ValidateNatureofRequest() {
           //debugger;
            if ($("#cboRRProjectSOWAvailable").val() != "") {
                if ($("#cboRRProjectSOWAvailable").val() == "1") {
                    if ($("#RRillingStartDate").val() != "") {
                        if (selectedAddedDate == undefined) {
                            const month = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                            const today = new Date();
                            today.setDate(today.getDate() + 30);
                            const yyyy = today.getFullYear();
                            let mm = month[today.getMonth()]; // Months start at 0!
                            let dd = today.getDate();

                            if (dd < 10) dd = '0' + dd;
                            if (mm < 10) mm = '0' + mm;
                            const formattedToday = dd + ' ' + mm + ' ' + yyyy;
                            selectedAddedDate = formattedToday
                        }
                       
                        var ResourceParameters = {
                            RillingStartDate: $("#RRillingStartDate").val(),
                            AddedDate: selectedAddedDate,
                        }
                        var param = JSON.stringify(ResourceParameters);
                        var result = AJAXCallWithResult(encodeURI(strUrl) + "/api/PM_AddNewResource/ValidateNatureofRequest", param, false);
                        if (result != "") {
                            $("#txtRNatureofRequest").val(result[0].Column1);
                        }
                    }
                } else {
                    $("#txtRNatureofRequest").val("Normal");
                }

            }
        }


        //Added By Dipali V On 14th Nov 2022 For Sonata Customzation
        function SelectFile() {
            $('.btn').tooltip({ trigger: 'hover' });
            $('.btn:focus').tooltip({ trigger: 'hover' });
            $(".tooltip").removeClass('show'); //added by pradip on 23-12-2022 for tooltip issue
            var strFileCount = $("#btnSelectFile").attr("FileCount");
            var objCurrentFileControl = $("#txtFileName" + strFileCount);
            if (FileCount_toDisable == 5) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("User can attach maximum five files at a time.", 'error', 25);
                return;
            }
            objCurrentFileControl.click();

        }

        $(".form-control").change(function () {
            //alert();
            $('.btn').tooltip({ trigger: 'hover' });
            $('.btn:focus').tooltip({ trigger: 'hover' });
            $(".tooltip").removeClass('show'); //added by pradip on 23-12-2022 for tooltip issue
        });

       

        var FileCount_toDisable = 0;
        
        var fileObject = [];
        var fileObject1 = [];
        var AllfileData = [];
        async function addFileinGrid() {      
            var data = new FormData();
            fileObject = [];
            fileObject1 = [];
            AllfileData = [];
            var FileCount = 0;
            IsFileadded = 0;
            $("#tblFiles").html('');
            ValidateAttachmentFlag = true;
            var objtxtFileName = document.getElementById('txtFileName' + FileCount);

             //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
            var objFile = objtxtFileName;
            var fileName = objtxtFileName.value;
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
                        var fileInput = objFile;
                        var fileNameInput = $(fileInput).closest('td').find('[id^="FileName"]');
                        // Before clearing:
                        console.log("Selected files before clearing:", fileInput.files);
                        $(fileInput).val(""); // Clear the file input
                        fileNameInput.val(""); // Clear the file name text input
                        //End of Added by Ajit L on 21/11/2024

                        console.log(error);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                        //alert("Upload restricted: The DOC file contains an embedded executable (EXE) file.");
                        isValidTypeExeCheck = false;
                        $(objtxtFileName).val("");
                        /*$(objFileName).attr("placeholder", "Upload File");*/
                        //showAlert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'alert-danger');
                        return;
                    });



                if (!isValidTypeExeCheck) {
                    return;
                }
            }

            //$(objtxtFileName).val("");

             //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not

            var fileName = objtxtFileName.value;
            var files = objtxtFileName.files;

            for (var i = 0; i < files.length; i++) {
                data.append(files[i].name, files[i]);
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_AddNewResource/GetFileType',
                data: data,
                cache: false,
                contentType: false,
                processData: false,
                method: 'POST',
                type: 'POST',
                async: false,
                beforeSend: function (xhr) {
                    //xhr.setRequestHeader('Authorization', 'bearer ' + localStorage.getItem("access_token"));
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
                },
                success: function (result) {

                    if (result == true) {
                        AllfileData.push(FileCount);
                        IsFileadded += 1;
                        var objtxtFileName = document.getElementById('txtFileName' + FileCount);
                        var objFileGrid = document.getElementById('tblFiles');
                        objFileGrid.style.display = "";
                        var newRow = objFileGrid.insertRow(objFileGrid.rows.length);
                        objtxtFileName.style.display = "none";
                        newRow.id = 'FILENAME' + FileCount;
                        newRow.name = 'txtFileName';
                        newRow.className = "clsTREven";
                        var newCell = newRow.insertCell(0);
                        newCell.innerHTML = "<i class='fa fa-file-pdf-o' aria-hidden='true'></i>";
                        var index = fileName.lastIndexOf("\\");
                        if (index == -1)
                            index = fileName.lastIndexOf("/");

                        if (index != -1)
                            fileName = fileName.substring(index + 1, fileName.length);

                        newCell.innerHTML = fileName;
                        parentTD = objtxtFileName.parentNode;
                        objtxtFileName.style.display = "none";
                        FileCount++;
                        var objtxtFileName = document.getElementById('txtFileName' + FileCount);
                        objtxtFileName.style.display = "none";
                        objtxtFileName.disabled = true;
                        $("#btnSelectFile").attr("FileCount", FileCount);

                    } else {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Invalid Content Type!!");
                        var index = fileName.lastIndexOf("\\");
                        if (index == -1)
                            index = fileName.lastIndexOf("/");

                        if (index != -1)
                            fileName = fileName.substring(index + 1, fileName.length);
                        //alert(fileName);
                        data.delete(fileName);
                    }


                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });


        }
        //End of Added By Dipali V On 14th Nov 2022 For Sonata Customzation

        //Added By Dipali V On 14th Nov 2022 For Sonata Customzation
        var ValidateAttachmentFlag = true;
        function ValidateAttachment() {
            $('#tblFiles tr').each(function () {

                var id = $(this).attr("id");
                if (id != undefined) {
                    var Filecount = id.split("FILENAME")[1];
                    var objFileName = document.getElementById('txtFileName' + Filecount);
                    if (objFileName != null) {

                        if (disallowSpecialCharacters(objFileName, 'Special character # is not allowed', true, '#')) { ValidateAttachmentFlag = false; return false; }

                        if (disallowSpecialCharacters(objFileName, 'Single quotation mark is not allowed in file name', true, "'")) { ValidateAttachmentFlag = false; return false; }

                        var countOfDot, FileNameCharCount;
                        var intMinFileSize = '<%=ConfigurationManager.AppSettings("inFileSize")%>'
                        var intActualFileSize = (objFileName.files['0'].size);
                        var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>'
                        var validateExtensions;

                        validateExtensions = strFileExtension.split(",");
                        if (strFileExtension.length > 0) {
                            var allowSubmit = false;
                            var file = objFileName.value;
                            var extension = file.slice(file.lastIndexOf('.') + 1).toLowerCase();

                            for (var cnt = 0; cnt < validateExtensions.length; cnt++) {
                                var strExtn;
                                strExtn = validateExtensions[cnt];
                                if (strExtn.toLowerCase() == extension) { allowSubmit = true; }

                            }
                            if (allowSubmit == false) {

                                alertify.set('notifier', 'position', 'top-right');
                                alertify.error("Only files with extensions " + (validateExtensions.join(", ", "").toUpperCase()) + " are  allowed!!!");
                                ValidateAttachmentFlag = false;
                                return false;

                            }

                        }

                        if (objFileName.files['0'].name != '')
                            var countOfDot = objFileName.files['0'].name.split(".").length - 1;

                        if (countOfDot > 1) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('File with two or more extensions is not allowed!');
                            ValidateAttachmentFlag = false;
                            return false;
                        }

                        if (objFileName.files['0'].name != '')
                            FileNameCharCount = objFileName.files['0'].name.split(".")[0].length;

                        if (FileNameCharCount > 120) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('File name should not exceed 120 characters!');
                            ValidateAttachmentFlag = false;
                            return false;
                        }

                        if (intActualFileSize < intMinFileSize) {

                            alertify.set('notifier', 'position', 'top-right');
                            alertify.error('File size should be greater than or equal to ' + intMinFileSize + ' bytes !');
                            ValidateAttachmentFlag = false;
                            return false;

                        }

                    }
                }
            });
            return ValidateAttachmentFlag;
        }
        //End of Added By Dipali V On 12th Nov 2022 For Sonata Customzation



        //added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
        //function validateDocFileForExe(file) {

        //    return new Promise((resolve, reject) => {
        //        //debugger;

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

        //End of added by Riddhesh Patil on 13 Nov 2024for checking exe file present in document or not
        var ajaxResult;
        // Resolves API URL: absolute URLs unchanged; relative paths (e.g. /api/...) use WebAPIUrl-Project (strUrl).
        function AJAXCallWithResult(url, param, async) {
            var requestUrl;
            if (!url) {
                requestUrl = url;
            } else if (url.indexOf("http://") === 0 || url.indexOf("https://") === 0) {
                requestUrl = encodeURI(url);
            } else {
                requestUrl = encodeURI(strUrl) + (url.charAt(0) === "/" ? url : "/" + url);
            }
            $.ajax({
                url: requestUrl,
                type: "POST",
                data: param,
                async: async,
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token_project"));
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
        function restrictAlphabets(evt) {
            evt = (evt) ? evt : window.event;
            var charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
    </script>
    
     <%CommonFunctions.HTMLControls.DrawTextBox("txtToday", "txtToday",, IsHidden:=True, EnableHTMLEncode:=True) %>
     <%--End New Page By Imran 24-06-2021--%>
</body>
</html>