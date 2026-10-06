<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="IssueList.aspx.vb" EnableSessionState="true" Inherits="PbNIT.IssueList"%>

<!DOCTYPE html>

<html>
    <%CommonFunctions.General.PlotPageHeadTag("Issues")%>
<head> 
    
    <!-- Commented by Gauri on 09/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Issues</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/bootstrap-datepicker.min.css" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_issues.css?v=2.10" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>

    <%--Added by imran 26-10-2021--%>
    <link href="IssueListStyle.css?v=4" rel="stylesheet" />
    <%--End Comment by imran 26-10-2021--%>

</head>
    
    <style>
        .form-group.indicatenote {left: 8rem;}
        .form-inline.viewapplyfield .input-group .btn {	margin-top: -8px}
        .modal-header{display:block}
        .listboxpanel button:hover {opacity: 1;background:#fff}
        .filterBDate{top:42px;right:1px}

        /*Changes added by Ashwini M on 27-3-2023*/
        .searchDate{left:125px}
        /*End of changes added by Ashwini M on 27-3-2023*/

        .table-outer{ margin:0; width:100%;}
        .issuefilter_container .filterpanelbody{ max-height:auto; overflow-y: auto;}
        /*.dropdown-menu {
    z-index: 999 !important;
}*/
        ul#ulSearch {
    z-index: 9999!important;
}
 .clscmbSerachControl {
            width: 200px !important;
        }
 /*Added by pradip on 12-4-2023*/
 .cust_tabpanel #SavedFiltersdropdown.show {
    z-index: 9!important;
}
 /*End Added by pradip on 12-4-2023*/
    </style>

<body class="hold-transition skin-blue-light sidebar-mini dashmain fixed">
    <%--  /*Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>

    <%--  /*Added & Commented By Madhuri.K On 21-Aug-2024 For Loader Issues*/--%>
  <div  id="bodyIssueList"></div>
         <div id="divissueList" class="preloader">
       <%-- <div class="clsShowHide" >--%>
         <div class="clsShowHide" id="maindiv">
              <%--  /*End of Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>

    <section class="content">

        <div class="issuelistscreen">
            <%--Issuemodulewrap_main--%>
            <div class="graybg container-fluid pt-1 pb-1 headertopp">
                <div class="row">
                    <%--<div class="col-md-2 col-sm-2 col-xs-2" id="cboIssueProjectsTooltip" data-toggle="tooltip" data-placement="bottom" title="Select Project" value="Select">--%>
                    <div class="col-md-3 col-sm-3 col-xs-8"><%-- modified by pradip on 1-10-2020 --%>
                        <%--<% CommonFunctions.HTMLControls.DrawComboBox("cboIssueProjects", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_IssueList " & Session("intUserID"),,, "class='form-control selectpicker' onChange='javascript:IssueProjectDrop_OnChange(this.value);'",,, ) %>--%>
                        <% CommonFunctions.HTMLControls.DrawComboBox("cboIssueProjects", "select '' ",,, "class='form-control issueselectprojects' onChange='javascript:IssueProjectDrop_OnChange(this.value);'", True,,) %>
                        <input type="hidden" id="projectid" />
                        <input type="hidden" id="roleid" />
                        <input type="hidden" id="viewtype" />
                        <input type="hidden" id="queryid" />
                        <input type="hidden" id="queryname" />
                        <input type="hidden" id="querytype" />
                        <input type="hidden" id="unappliedqueryid" />
                        <input type="hidden" id="editqueryid" />
                        <input type="hidden" id="editqueryCreatedByEmployeeID" />
                        <input type="hidden" id="unsavedquerytext" />
                        <input type="hidden" id="searchoptiontext" />
                       <%-- Dipali V 2021--%>
                        <input type="hidden" id="secondfilter" />
                         <input type="hidden" id="EmployeeID" />
                    </div>
                    <%--</div>--%>

                    <div class="col-md-1 col-sm-2 px-0">
                        <%If m_blnAddAccess = True Then%>
                        <%--                        commented & added By dipali V On 3rd Oct 2019 for Change Caption of issues--%>
                        <%--                        <a data-bs-toggle="tooltip" data-placement="bottom" title="New Issues" class="btn borderbtn h32" href="#" onclick="NewIssue_OnClick();">New Issues +</a>--%>
                        <a data-bs-toggle="tooltip" data-placement="bottom" title="Add Issue" class="btn borderbtn h32" href="#" onclick="NewIssue_OnClick();" style="width:110px">Add Issue +</a>
                        <%-- End of commented & added By dipali V On 3rd Oct 2019 for Change Caption of issues--%>
                        <%End If %>
                    </div>


                    <div class="col-md-4 col-sm-6 col-xs-8">

                        <ul class="headernavlist pl-0">
                            <%-- <li><a href="IssueList.aspx">Issue List</a></li>--%>
                            <%-- <li><a href="IssueList.aspx">Summary</a></li>--%>
                            <li><a href="#" id="DashboardButton">Dashboard</a></li>
                              <%If m_blnAddAccess = True Then%>
                            <li><a href="#" onclick="IssueTab_OnClick('CopyIssue')" id="copylink" data-bs-toggle="tooltip" data-placement="bottom">Issue Copying</a></li>
                              <%End If %>

                              <%If m_blnEditAccess = True Then%>
                              <li><a href="#" onclick="IssueTab_OnClick('UpdateIssue')" id="BulkUpdateButton" data-bs-toggle="tooltip" data-placement="bottom">Bulk Update</a></li>
                               <%End If %>
                             
                         </ul>

                    </div>
             <%-- modified by pradip on 1-10-2020 --%>
                    <div class="col-md-4 col-sm-12 col-xs-3 pull-right">
                        <div class="filter pull-right ml-1">
                            <button id="btnAdvancedFilter" data-bs-toggle="collapse" class="initial" data-placement="bottom" title="" data-bs-original-title="Filters" data-bs-toggle="tooltip">
                                <i class="fas fa-filter"></i>
                            </button>
                        </div>
                        <div class="form-group form-inline viewapplyfield pull-right">
                            <label data-bs-toggle="tooltip" title="View" data-placement="bottom"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#" onclick="View_onclick()">View</a></label>
                            <div class="input-group">
                                <%--<input type="text" id="viewApplied" class="form-control" placeholder="View Applied" style="width:93px"/>--%>
                                <input type="text" id="viewApplied" class="form-control" placeholder="View Applied" style="width:103px"/>
                                <input type="hidden" id="viewid" />
                                <input type="hidden" id="fieldlist" />
                                <input type="hidden" id="orderby" />
                                <span class="input-group-btn">
                                    <button class="btn btnyellow btn-flat" type="button" onclick="btnSetDefaultView()">Default</button>
                                </span>
                            </div>

                        </div>

                    </div>

                </div>
            </div>

            <div class="bgwhite container-fluid pt-1 pb-1 headertopp">
                <div class="row">
                    <!--Commented and added by pradip on 5-01-2021-->
                    <%--<div class="col-sm-6">--%>
                    <div class="col-sm-7">
                        <!--End of Commented and added by pradip on 5-01-2021-->
<div class="form-inline" style="display:inline-flex">
                            <%-- //Added By Dipali V On 25th Sep 2019 For IF Delete Access then only Button should display--%>
                            <%If m_blnDeleteAccess = True Then%>
                            <button id="btnDelete" onclick="btnDeleteIssue()" class="btn borderbtnred mrOnehalf" data-bs-toggle="tooltip" data-placement="top" title="Delete">
                                <i class="far fa-trash-alt"></i>
                            </button>
                            <%End If %>
                            <%--  //End of Added By Dipali V On 25th Sep 2019 For IF Delete Access then only Button should display--%>

                            <div class="input-group mrOnehalf">
                                <div class="input-group-btn" style="display:inline-flex">
                                    <input type="hidden" id="txtSearchBy" class="form-control" />
                                    <button id="btnSearchByIcon" type="button" class="btn clsControlHeight dropdown-toggle" data-bs-toggle="dropdown" tabindex="-1" style="padding: 0 4px;background:#f4f4f4">
                                        <img class="weeklycalender_icon" src="../../../Whizible2.0-new/dist/img/Search.svg" alt="" width="18px" style="margin:0 3px;" />
                                    </button>
                                    <button id="btnSearchBy" type="button" class="btn btn-default dropdown-toggle" data-bs-toggle="dropdown" tabindex="-1" style="padding: 0px 8px;">
                                        <span class="caret"></span>
                                        <span class="sr-only">Toggle Dropdown</span>
                                    </button>
                                    <ul id="ulSearch" class="dropdown-menu" role="menu">
                                    </ul>
                                </div>
                                <div id="searchby" style="margin-right: 3px;">
                                    <input id="searchby1" style="margin-left: 3px;" type="text" readonly="readonly" placeholder="Select Search Option..." class="form-control" />
                                </div>
                                <span></span>
                                <div class="input-group-btn">
                                    <button id="btnGo" onclick="btnApplySearch()" type="button" data-bs-toggle="tooltip" data-placement="top" title="Search" class="btn btn-success btn-default" tabindex="-1">Go</button>
                                </div>
                            </div>

                            <a id="lnkClearSearch" onclick="clearSearchOnClick()" href="#" data-bs-toggle="tooltip" data-placement="top" title="Clear" class="mrOnehalf mr-1" style="margin-top:4px">Clear</a>

                        </div>
                        
                    </div>

                    <%--Commented and added by pradip on 5-01-2021--%>
                   <%-- <div class="col-sm-6">--%>
                    <div class="col-sm-5 pe-0 ps-0">
                        <%--End of Commented and added by pradip on 5-01-2021--%>
                        <div class="form-inline pull-right ml-0">
                            <%--Commented And Added by Usha Pandit On 05.05.2021 For Alignment issue--%>
                            <%--<div class="form-group mrOnehalf" id="AccessFilter">--%>
                                <div class="form-group mrOnehalf" id="AccessFilter" style ="width:100px!important;">                                
                                    <%--End Of Added by Usha Pandit On 05.05.2021 For Alignment issue--%>
                                <select id="cboAccessFilter" class="form-control borderbtn"  onchange="StaticView_OnChange(this.value)">
                                    <option value="A">All Issues</option>
                                    <option value="M">My Issues</option>
                                   <%-- Added & Commented By Dipali V On 1st Nov 2021 For ReName Filter--%>
                                   <%-- <option value="S">Submitted Issues</option>--%>
                                     <option value="S">Reported By Me</option>
                                    <%-- Added & Commented By Dipali V On 1st Nov 2021 For ReName Filter--%>
                                    <option value="F">Flagged issues</option>
                                </select>
                            </div>
                            <button id="btnRefresh" onclick="btnRefreshClick()" class="btn refresh_btn mrOnehalf borderbtn" data-bs-toggle="tooltip" data-placement="top" title="Refresh"><i class="fas fa-sync"></i></button>
                            <%-- <button onclick="Openpage()">Old Issue</button>--%>
                            
                            
                            
                            <div class="form-group mrOnehalf" id="divExportReport">
                                <div class="dropdown filedownload borderbtn">
                                    <button class="btn nostylebtn dropdown-toggle borderbtn" data-bs-toggle="dropdown" data-bs-toggle="tooltip" aria-expanded="true" data-placement="top" title="Export" id="btnexport"><i class="fas fa-download"></i></button><!--removed text pradip on 19-5-->
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('PDF')">
                                                <img src="../../../Whizible2.0-new/dist/img/pdf.svg" width="18px">Pdf</a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('EXCEL')">
                                                <img src="../../../Whizible2.0-new/dist/img/xls.svg" width="18px">Xlsx</a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('XML')">
                                                <img src="../../../Whizible2.0-new/dist/img/xml.svg" width="18px">Xml</a>
                                        </li>
                                        <li>
                                            <a href="#" onclick="Export_PDFClick('TEXT')">
                                                <%--//Commented & Added By Dipali V On 5th April 2023 For Status Date Control Disabled--%>
                                                <%--<img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Doc</a>--%>
                                                <img src="../../../Whizible2.0-new/dist/img/doc.svg" width="18px">Text</a>
                                            <%--//End of Commented & Added By Dipali V On 5th April 2023 For Status Date Control Disabled--%>
                                        </li>
                                    </ul>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-8 col-sm-8">
                        <div class="form-group indicatenote pull-right">
                            <span style="font-size:12px;">(Prefix '$' indicates custom field)</span>
                        </div>                        


                    </div>

                </div>

            </div>

            <div id="issuefilterpanel" class="collapse">
                <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                    <div class="row">
                        <div class="col-md-7 col-sm-7">

                            <div class="cust_tabpanel">
                                <ul id="issuefiltertabs" class="nav nav-tabs">
                                    <%--                                 added & commented by dipali v On 24th Sep 2019 For Filter issues--%>
                                    <%--                                    <li id="tabSavedFilters" class="dropdown"><a class="dropdown-toggle" href="#" data-bs-toggle="dropdown">My Filters  <span class="caret"></span></a>--%>

                                    <li id="tabSavedFilters" class="dropdown"><a class="dropdown-toggle" href="#" data-bs-toggle="dropdown">Filters  <span class="caret"></span></a>
                                        <%--   End of   added & commented by dipali v On 24th Sep 2019 For Filter issues--%>
                                        <ul id="SavedFiltersdropdown" class="dropdown-menu" role="menu">

                                            <%--  <li><label class="customradio">
									<span for="project2" class="radiotextsty"></span>
										  <input class="myfilter_selectprocheckbox" data-bs-toggle="tooltip" data-placement="bottom" id="project2" type="checkbox" name="project2" onchange="cbChange(this)">
										  <span data-bs-toggle="tooltip" data-placement="right" title="Set Default filter" class="checkmark"></span>
										</label>
												<div class="issfilter_actiondropdown">
												
											<div class="custom_chckbox_markblue">
												<input id="IssueselproOne" type="checkbox" name="">
												<label data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Apply filter" for="IssueselproOne"></label>
												</div>	
												<span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Edit filter" class="fas fa-pencil-alt"></i></span>
												<span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Delete filter" class="far fa-trash-alt"></i></span>
												</div>
									</li>
									<li><label class="customradio">
									<span for="Taskmilestones" class="radiotextsty"></span>
										  <input class="myfilter_selectprocheckbox" id="Taskmilestones" type="checkbox" name="Taskmilestones"  onchange="cbChange(this)">
										  <span data-bs-toggle="tooltip" data-placement="right" title="Set Default filter" class="checkmark"></span>
										</label> 
												<div class="issfilter_actiondropdown"
>												<div class="custom_chckbox_markblue">
												<input id="IssueselproTwo" type="checkbox" name="">
												<label data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Apply filter" for="IssueselproTwo"></label>
												</div>	
												<span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Edit filter" class="fas fa-pencil-alt"></i></span>
												<span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Delete filter" class="far fa-trash-alt"></i></span>
												</div>
									</li>
									<li><label class="customradio">
									<span for="groupcompany" class="radiotextsty"></span>
										  <input class="myfilter_selectprocheckbox" id="groupcompany" type="checkbox" name="groupcompany" onchange="cbChange(this)">
										  <span data-bs-toggle="tooltip" data-placement="right" title="Set Default filter" class="checkmark"></span>
										</label>
												<div class="issfilter_actiondropdown"
>												<div class="custom_chckbox_markblue">
												<input id="IssueselproThree" type="checkbox" name="">
												<label  data-container="body" data-bs-toggle="tooltip" data-placement="bottom" title="Apply filter"for="IssueselproThree"></label>
												</div>	
												<span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Edit filter" class="fas fa-pencil-alt"></i></span>
												<span><i data-bs-toggle="tooltip" data-container="body" data-placement="bottom" title="Delete filter" class="far fa-trash-alt"></i></span>
												</div>
									</li>--%>
                                        </ul>



                                    </li>
                                    <li id="tabBasicFilter" class="basic active"><a href="#basicfilter" data-bs-toggle="tab">Basic Filters</a></li>
                                    <li style="display: none" id="tabAdvancedFilter" class="advanced"><a href="#queryfilter" data-bs-toggle="tab">Advanced Builder</a></li>
                                </ul>

                            </div>

                        </div>

                        <div id="divFilter" style="display: none;" class="col-md-5 col-sm-5">
                            <div class="form-inline pull-right">
                                <label class="mr-2">Applied Filter : <span id="spnappliedfilter"></span></label>
                                <button id="btnClearAllFilters" class="btn borderbtn mrOnehalf clearfilterbtn" data-bs-toggle="tooltip" data-placement="top" title="Clear All Filters">Clear All Filters</button>
                                <%--Added by imran 25-10-2021--%>
                                <input type="hidden" id="hquery" />
                                  <input type="hidden" id="hIsFilterClear" /><%--//Added By  Dipali 11th Nov 2021--%>
                                <%--End by imran 25-10-2021--%>
                            </div>

                        </div>

                    </div>

                </div>


                <div class="issuefilter_container">
                    <div class="tab-content issuefilter_tabcontent">
                        <div id="basicfilter" class="tab-pane">
                            <!--filter panel start here-->
                            <div class="filterpanelwrap">
                                <div class="filterpanelbody">
                                    <div style="text-align: center">
                                        <label class="editFilter" id="lblBasicFilterEdit"></label>
                                    </div>
                                    <div class="fp_button text-center hidden-xs centerbtn mt-0" style="margin-bottom: 30px;">
                                        <button class="btn btnyellow" id="btnSaveBasicFilterTop" onclick="btnSaveBasicFilter()">Save and Apply</button>
                                        <button class="btn btnyellow" id="btnApplyBasicFilterTop" onclick="btnApplyBasicFilter()">Apply</button>
                                    </div>

                                    <div class="row">
                                        <div class="col-sm-4">
                                            <div class="fplistbox" style="position:relative">
                                                <div class="fplist_title">Reported From</div>
                                                <%-- <input type="text" id="txtReportedFrom" style="width:95%;" class="form-control" onfocus = 'showCalendar(this.id);' onblur='validateDate(this)' placeholder="DD Month YYYY"/>--%>
                                                <input type="text" id="txtReportedFrom" style="width: 100%; background-color: white!important;" class="form-control" onfocus='showCalendar(this.id);' placeholder="DD MMM YYYY" readonly />

                                                <i class='fa fa-calendar filterBDate' onclick='showCalendar("txtReportedFrom");'></i>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox" style="position:relative">
                                                <div class="fplist_title">Reported To</div>
                                                <input type="text" id="txtReportedTo" style="width: 100%; background-color: white!important;" class="form-control" onfocus='showCalendar(this.id);' placeholder="DD MMM YYYY" readonly />
                                                <i class='fa fa-calendar filterBDate' onclick='showCalendar("txtReportedTo");'></i>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox" style="position:relative">
                                                <div class="fplist_title">Due Date From</div>
                                                <input type="text" id="txtDueDateFrom" style="width: 100%; background-color: white!important;" class="form-control" onfocus='showCalendar(this.id);' placeholder="DD MMM YYYY" readonly />
                                                <i class='fa fa-calendar filterBDate' onclick='showCalendar("txtDueDateFrom");'></i>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox" style="position:relative">
                                                <div class="fplist_title">Due Date To</div>
                                                <input type="text" id="txtDueDateTo" style="width: 100%; background-color: white!important;" class="form-control" onfocus='showCalendar(this.id);' placeholder="DD MMM YYYY" readonly />
                                                <i class='fa fa-calendar filterBDate' onclick='showCalendar("txtDueDateTo");'></i>
                                            </div>
                                        </div>

                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterType">Type<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterType" class="panel-collapse collapse">
                                                    <ul id="fType" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterSubType">Sub Type<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterSubType" class="panel-collapse collapse">
                                                    <ul id="fSubType" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox ">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterStatus">Status<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterStatus" class="panel-collapse collapse">
                                                    <ul id="fStatus" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterPriority">Priority<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterPriority" class="panel-collapse collapse">
                                                    <ul id="fPriority" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterSeverity">Severity<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterSeverity" class="panel-collapse collapse">
                                                    <ul id="fSeverity" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterComplexity">Complexity<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterComplexity" class="panel-collapse collapse">
                                                    <ul id="fComplexity" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterReportedBy">Reported By<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterReportedBy" class="panel-collapse collapse">
                                                    <ul id="fReportedBy" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterCodedByName">Coded By<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterCodedByName" class="panel-collapse collapse">
                                                    <ul id="fCodedByName" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterAssignToName">Responsible Person<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterAssignToName" class="panel-collapse collapse">
                                                    <ul id="fAssignToName" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterReportedInVersion">Reported in Version<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterReportedInVersion" class="panel-collapse collapse">
                                                    <ul id="fReportedInVersion" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterCorrectedInVersion">Corrected in Version<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterCorrectedInVersion" class="panel-collapse collapse">
                                                    <ul id="fCorrectedInVersion" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterModuleName">Module Name<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterModuleName" class="panel-collapse collapse">
                                                    <ul id="fModuleName" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterPhase">Source Phase<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterPhase" class="panel-collapse collapse">
                                                    <ul id="fPhase" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterFoundInPhase">Found In Phase<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterFoundInPhase" class="panel-collapse collapse">
                                                    <ul id="fFoundInPhase" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterFixedInPhase">Fixed In Phase<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterFixedInPhase" class="panel-collapse collapse">
                                                    <ul id="fFixedInPhase" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>



                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterDeliverable">Deliverable<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterDeliverable" class="panel-collapse collapse">
                                                    <ul id="fDeliverable" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterRootCause">Root Cause<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterRootCause" class="panel-collapse collapse">
                                                    <ul id="fRootCause" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterScrumRelease">Release<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterScrumRelease" class="panel-collapse collapse">
                                                    <ul id="fScrumRelease" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterScrumIteration">Sprint<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterScrumIteration" class="panel-collapse collapse">
                                                    <ul id="fScrumIteration" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                        <%--   </div>--%>
                                        <%--<div class="row hidden-xs">--%>
                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion" data-bs-target="#IBfilterScrumUserStory">User Story<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterScrumUserStory" class="panel-collapse collapse">
                                                    <ul id="fScrumUserStory" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>

                                        <%--////////////////////////////////////////////--%>

                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion"
                                                    data-bs-target="#IBfilterOS">
                                                    OS<i class="fas fa-angle-down pull-right"></i>
                                                </div>
                                                <div id="IBfilterOS" class="panel-collapse collapse">
                                                    <ul id="fOS" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion"
                                                    data-bs-target="#IBfilterKernel">
                                                    Kernel <i class="fas fa-angle-down pull-right"></i>

                                                </div>
                                                <div id="IBfilterKernel" class="panel-collapse collapse">
                                                    <ul id="fKernel" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion"
                                                    data-bs-target="#IBfilterShowToCustomer">
                                                    Show To Customer<i class="fas fa-angle-down pull-right"></i>
                                                </div>
                                                <div id="IBfilterShowToCustomer" class="panel-collapse collapse">
                                                    <ul id="fShowToCustomer" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>

                                        <%--<div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion"
                                                    data-bs-target="#IBfilterKeyWords">Key Words<i class="fas fa-angle-down pull-right"></i></div>
                                                <div id="IBfilterKeyWords" class="panel-collapse collapse">
                                                    <ul id="fKeyWords" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>--%>

                                        <div class="col-sm-4">
                                            <div class="fplistbox">
                                                <div class="fplist_title collapsed" data-bs-toggle="collapse" data-parent="#accordion"
                                                    data-bs-target="#IBfilterHardWare">
                                                    Hardware<i class="fas fa-angle-down pull-right"></i>
                                                </div>
                                                <div id="IBfilterHardWare" class="panel-collapse collapse">
                                                    <ul id="fHardWare" class="fplist">
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>


                                        <%--     //////////////////////////////////////////////////////////////////--%>
                                    </div>











                                </div>
                                <div class="fp_button text-center hidden-xs centerbtn mb-2">
                                    <button class="btn btnyellow" id="btnSaveBasicFilterBottom" onclick="btnSaveBasicFilter()">Save and Apply</button>
                                    <button class="btn btnyellow" id="btnApplyBasicFilterBottom" onclick="btnApplyBasicFilter()">Apply</button>
                                </div>

                            </div>
                        </div>
                        <!--filter panel end here-->
                    </div>

                    <div id="queryfilter" class="tab-pane" style="display: none">
                        <div id="filterpanel" class="filterpanelwrap">
                            <div class="filterpanelbody">
                                <div style="text-align: center">
                                    <label class="editFilter" id="lblAdvancedFilterEdit"></label>
                                </div>
                                <div class="row">
                                    <div class="col-sm-8 col-md-8">
                                        <div id="addlistfilter" class="addfilterpanel issueorder-list">
                                            <div class="addfilterrow">
                                                <div id="divFilterTable" class="order-list">
                                                    <button data-bs-toggle="tooltip" data-placement="bottom" data-container="body" title="Click here to Add More" id="addrow" class="">Add rules <i class="fas fa-plus"></i></button>

                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <br />

                                        <br />
                                        <br />
                                        <div class="col-sm-12">
                                            <div id="divAdvancedFilterSave" class="advancebuilder_save centerbtn">
                                                <button class="btn btnyellow" id="appendid" onclick="btnAppendClick()">Append</button>
                                                <button class="btn btnyellow" data-bs-toggle="modal" data-bs-target="#Issuesavefilter" data-bs-dismiss="modal" id="btnSaveAdvancedFilter" onclick="btnSaveAdvancedFilter()">Save and Apply</button>
                                                <button class="btn btnyellow" id="btnApplyAdvancedFilter" onclick="btnApplyAdvancedFilter()">Apply</button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-4 col-md-4">
                                        <div class="box box-panel box-solid graybg" id="divQueryText">
                                            <textarea id="queryText" class="form-control">

						        </textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <div class="clearfix"></div>
        </div>
        <!--<div class="divider">&nbsp;</div>-->
        <%-- Wrapper keeps pagination visible; only #resize_wrapper scrolls (see IssueListStyle.css) --%>
        <div class="issue-list-table-layout">
        <div class="table-outer table-outer-main pt-0">
            <div id="resize_wrapper">
                <table class="table table-bordered tbl_custm issuelisttable" id="issuelisttblmain" style="width: 100%;">
                    <thead class="header" id="issueHeader">
                        <tr>
                            <th>
                                <div class="custom_chckbox">
                                    <input type="checkbox" id="chkHeader" />
                                    <label for="chkHeader"></label>
                                </div>
                            </th>
                            <th>Issue ID</th>
                            <th>Reported Date</th>
                            <%-- <th>Request Type</th>--%>
                            <th>Summary</th>
                            <th>Type</th>
                            <th>Status</th>
                            <th>Sub Type</th>
                            <th>Priority</th>
                            <th>Last Updated</th>
                            <th><a href="#" data-bs-toggle="tooltip" data-placement="top" title="History"><i class="fa fa-history"></i></a></th>
                            <th><a href="#" data-bs-toggle="tooltip" data-placement="top" title="Flag to"><i class="far fa-flag"></i></a></th>
                            <th><a href="#" data-bs-toggle="tooltip" data-placement="top" title="Comments"><i class="far fa-comments"></i></a></th>
                            <%-- Added by Swapnagandha K. On 23 Oct 2019--%>
                            <th><a href="#" data-bs-toggle="tooltip" data-placement="top" title="Attachments"><i class="fas fa-paperclip"></i></a></th>
                            <th><a href="#" data-bs-toggle="tooltip" data-placement="top" title="Edit"><i class="far fa-edit"></i></a></th>
                            <%--End Added by Swapnagandha K. On 23 Oct 2019--%>
                        </tr>
                    </thead>
                    <tbody id="issueBody">
                    </tbody>
                </table>
            </div>
           
        </div>
       <%-- //Added bY Dipali v on 7th Sep 2020--%>
        <%--Added andcommented by Vishal Mane on 01/06/2026 from SBI Security Issues--%>
         <div class="row issue-list-pagination-row" style="margin-top:5px">
                
          
               <div class='buttons col-sm-10 divtotal'><span class="spntotal" id="TotalRecords" style="margin-right:-60px"></span><span id="" class="spntotal" style="margin-right:-19px"> Total Records : </span></div>
                <div class='buttons col-sm-2' id="Pagination" >
               <%--<button class='btn borderbtn ml-1 float-right next  ' title="Next" type='button' onclick='NextList()' style="float:right" id="btnnext"><i class="fas fa-angle-double-right"></i></button>
            
                <button class='btn borderbtn ml-1 previous' type='button' title="Previous" onclick='PrevList()' style="float:right" id="btnprevious"><i class="fas fa-angle-double-left"></i></button>
            --%>
                    <nav aria-label="Page navigation example">
                      <ul class="pagination justify-content-end">
                         <li class="page-item"  id="btnprevious">
                          <a class="page-link" aria-label="Previous" onclick='PrevList()' title="Previous" id="LinkPrevious" data-bs-toggle="tooltip">
                            
                           <i class="fas fa-angle-double-left"></i>
                          </a>
                        </li>
                         <li class="page-item" id="btnnext">
                          <a class="page-link" aria-label="Next" onclick='NextList()' title="Next" id="LinkNext" data-bs-toggle="tooltip">
                            
                           <i class="fas fa-angle-double-right"></i>
                          </a>
                        </li>
                      </ul>
                    </nav>

            </div>
            </div>
        </div>
        <%--End of  //Added bY Dipali v on 7th Sep 2020--%>
        <!-- Modal -->
        <div class="modal custmodal viewapplied fade" id="viewapplied" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="viewAppliedModal">View List</h5>
                        <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <div class="graybg container-fluid pt-1 pb-1 headertopp">
                            <ul class="headernavlist pull-right">
                                <%-- Added By Dipali V On 24th Sep for Clear view & apply Corporate view --%>
                                <li onclick="SetAsDefaultView(0);ApplyView(0);"><a href="javascript:;" id="licorporateview">Set Corporate View</a></li>
                                <%--End of  Added By Dipali V On 24th Sep for Clear view & apply Corporate view --%>
                                <li onclick="getViewFieldLists(0)"><a href="javascript:;" data-bs-toggle="modal" data-bs-target="#issueviewdetails" data-bs-dismiss="modal">Add New</a></li>
                                <li onclick="chkCheckUncheckAllViews(true)"><a href="#">Select All</a></li>
                                <li onclick="chkCheckUncheckAllViews(false)"><a href="#">Clear All</a></li>
                                <li class="ml-2">
                                    <button data-bs-toggle="tooltip" data-placement="top" title="" class="nostylebtn trashbtn pull-right" id="btnDeleteView" onclick="btnDeleteView()" data-bs-original-title="Delete"><i class="far fa-trash-alt"></i></button>
                                </li>

                            </ul>

                            <div class="clearfix"></div>
                        </div>
                        <p class="bgwhite container-fluid pt-1 pb-1 text-right">( Green color indicates Default Settings.)</p>

                        <!--<div class="divider">&nbsp;</div>-->
                        <div class="table-outer">
                            <div class="table-responsive">
                                <table class="table table-striped tbl_custm issuelisttable">
                                    <thead class="header">
                                        <tr>
                                            <th>View Name</th>
                                            <th>Created On</th>
                                            <th>Created By</th>
                                            <th>Display Fields</th>
                                            <th>Sort Order</th>
                                            <th>Set as Default</th>
                                            <th>Apply</th>
                                            <th>Select</th>
                                        </tr>
                                    </thead>
                                    <tbody id="viewlist">
                                    </tbody>
                                </table>
                                <div>
                                </div>

                                <div class="clearfix"></div>



                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </section>

    <!-- Modal -->
    <div class="modal custmodal viewdetail largcustmodal fade" id="issueviewdetails" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="viewDetails">View Details</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="viewdetails_modaltop">
                        <ul class="pull-right btnlistinline mb-1">
                            <li>
                                <button id="btnSaveView" class="btn btnyellow nobtnstyle-xs" onclick="SaveView_OnCLick();">Save</button>
                            </li>
                            <li class="ml-1">
                                <button data-bs-dismiss="modal" aria-label="Close" class="btn borderbtn nobtnstyle-xs" onclick="close_view()">Close</button>
                            </li>
                        </ul>
                        <div class="clearfix"></div>
                    </div>
                    <hr />
                    <p class="">
                        (Prefix '$' Indicates that is a custom field)<%--  (* Mandatory)--%>
                        <%--<span class="pull-right"><strong>View Id :</strong>--%>
                        <input id="detailViewId" type="hidden" />
                        <%--</span>--%>
                    </p>

                    <div class="clearfix"></div>

                    <div class="form-inline">
                        <label class="control-label">View Name : </label>
                        <div class="form-group">
                            <%--Commented & Added by Chetan M on 21th Jully 2020 for Issue ID = 24219--%>
                          <input id="viewName" style="width: 260px;" type="text" class="form-control" name="" style="width: 80%;" />
                             <%--<input id="viewName" style="width: 260px;" type="text" class="form-control" name="" style="width: 80%;"  maxlength="100"/>--%>
                                                      <%-- End of  Commented & Added by Chetan M on 21th Jully 2020 for Issue ID = 24219--%>
                        </div>
                    </div>
                    <br />

                    <!--listbox_start_here-->

                    <div id="addViewFields" class="">
                        <h5 id="viewDisplayFields" class=""><strong>Display Fields</strong></h5>

                        <div class="listboxpanel graybg">
                            <div class="row">
                                <div class="col-sm-5">
                                    <label>List of Fields</label>
                                    <select name="from[]" id="multiselect1" class="form-control" size="8" multiple="multiple">
                                    </select>
                                </div>

                                <div class="col-sm-1 p-0">
                                    <label>&nbsp;</label>
                                    <br />
                                    <br />
                                    <button type="button" id="multiselect1_rightAll" class="btn btn-block" style="width:60px;margin-bottom: 5px;"><i class="fas fa-forward" style="font-size:10px"></i></button>
                                    <button type="button" id="multiselect1_rightSelected" class="btn btn-block" style="width:60px;margin-bottom: 5px;"><i class="fas fa-chevron-right" style="font-size:10px"></i></button>
                                    <button type="button" id="multiselect1_leftSelected" class="btn btn-block" style="width:60px;margin-bottom: 5px;"><i class="fas fa-chevron-left" style="font-size:10px"></i></button>
                                    <button type="button" id="multiselect1_leftAll" class="btn btn-block" style="width:60px"><i class="fas fa-backward" style="font-size:10px"></i></button>
                                </div>

                                <div class="col-sm-5">
                                    <h5 id=""><strong>Selected Fields</strong></h5>
                                    <select name="to[]" id="multiselect1_to" class="form-control multiselect1_to" size="8" multiple="multiple"></select>
                                </div>

                                <div class="col-sm-1 pl-0">
                                    <label>&nbsp;</label>
                                    <br />
                                    <br />
                                    <button type="button" id="multiselect1_move_up" class="btn btn-block" style="width:50px;margin-bottom: 5px;"><i class="fas fa-arrow-up" style="font-size:12px"></i></button>
                                    <button type="button" id="multiselect1_move_down" class="btn btn-block col-sm-6" style="width:50px"><i class="fas fa-arrow-up" style="font-size:12px"></i></button>
                                </div>

                            </div>
                        </div>

                        <h5 id="viewSortFields" class=""><strong>Sort Fields</strong></h5>
                        <div class="listboxpanel graybg">
                            <div class="row">
                                <div class="col-sm-5">
                                    <label>List of Fields</label>
                                    <select name="from[]" id="multiselect2" class="form-control" size="8" multiple="multiple">
                                    </select>
                                </div>

                                <div class="col-sm-1 p-0">
                                    <label>&nbsp;</label>
                                    <br />
                                    <br />
                                    <button type="button" id="multiselect2_rightAll" class="btn btn-block" style="width:60px;margin-bottom: 5px;"><i class="fas fa-forward" style="font-size:10px"></i></button>
                                    <button type="button" id="multiselect2_rightSelected" class="btn btn-block" style="width:60px;margin-bottom: 5px;"><i class="fas fa-chevron-right" style="font-size:10px"></i></button>
                                    <button type="button" id="multiselect2_leftSelected" class="btn btn-block" style="width:60px;margin-bottom: 5px;"><i class="fas fa-chevron-left" style="font-size:10px"></i></button>
                                    <button type="button" id="multiselect2_leftAll" class="btn btn-block" style="width:60px"><i class="fas fa-backward" style="font-size:10px"></i></button>
                                </div>

                                <div class="col-sm-5">
                                    <h5 id=""><strong>Selected Fields</strong></h5>
                                    <select name="to[]" id="multiselect2_to" class="form-control multiselect2_to sorting" size="8" multiple="multiple"></select>

                                </div>

                                <div class="col-sm-1 pl-0">
                                    <label>&nbsp;</label>
                                    <br />
                                    <br />
                                    <button type="button" id="multiselect2_move_up" class="btn btn-block" style="width:50px;margin-bottom: 5px;"><i class="fas fa-arrow-up" style="font-size:12px"></i></button>
                                    <button type="button" id="multiselect2_move_down" class="btn btn-block col-sm-6" style="width:50px"><i class="fas fa-arrow-down" style="font-size:12px"></i></button>
                                </div>

                            </div>
                        </div>

                    </div>

                    <!--listbox_end_here-->

                </div>

            </div>
        </div>
    </div>
    <!--modalendhere-->

    <div class="modal custmodal fade" id="isstrackingflag" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Tracking Details</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="graybg pt-1 pb-1 headertopp">
                    <ul class="headernavlist pull-right">
                        <%If m_blnEditAccess = True Then%>
                        <li id="clearflag"><a href="#" onclick="ClearTrackingFlag()">Clear Flag</a></li>
                        <li id="saveflag"><a href="#" onclick="SaveTrackingDetails()">Save</a></li>
                        <%End If %>
                        <%-- <li><a href="#">Close</a></li>--%>
                        <%--<li><a href="#">?</a></li>--%>
                    </ul>

                    <div class="clearfix"></div>
                </div>
                <div class="modal-body">

                    <p><strong>Note : </strong>Flagging marks an item to remind you that it needs to be followed up. After it has been followed up, you can mark it complete.</p>
                    <h4><strong>Issue ID :</strong><label id="lblIssueID"> 16336</label></h4>
                    <p id="txtSummary"><strong>Issue :</strong> Test Case Code: 19 Scenario: To verify tool tip is provided to the filter option over the pop up window</p>
                    <p>&nbsp;</p>
                    <div class="form-panel">

                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-sm-4 text-right">Flag To <span id="MandatoryFlagto" style="color: red;">*</span> :</label>
                                <div class="col-sm-6 slctedtfirst">
                                    <% CommonFunctions.HTMLControls.DrawComboBox("cboFlagTo", "usp_whizible2_FlagTo_ComboFill ",,, "class='form-control'", False,,) %>
                                    <%-- <select class="form-control selectpicker">
                                                            <option>Review</option>
                                                            <option>Follow Up</option>                                                             
                                                        </select>--%>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-sm-4 text-right">Due Date <span id="MandatoryDueDate" style="color: red;">*</span> :</label>
                                <div class="col-sm-6">
                                    <div class="input-group">
                                        <%--Commented And Added By Usha Pandit On 16.06.2020 for restricting alphabates for Due Date--%>
                                        <%--<input id="trackingtype" type="text" class="form-control" autocomplete="off" />--%>
                                        <input id="trackingtype" type="text" class="form-control" onkeypress="return Date_OnKeyPress(event)" autocomplete="off" />
                                        <%--Commented And Added By Usha Pandit On 16.06.2020 for restricting alphabates for Due Date--%>
                                        <input id="hdnUniqueID" type="hidden" />
                                        <span class="input-group-btn">
                                            <button class="btn btncalendar" type="button"><i class="fas fa-calendar-alt"></i></button>
                                        </span>
                                    </div>


                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <label class="control-label col-sm-4 text-right">Complete :</label>
                                <div class="col-sm-6">
                                    <div class="custom_chckbox">
                                        <input type="checkbox" id="flagcomplete1" />
                                        <label for="flagcomplete1"></label>
                                    </div>
                                </div>
                            </div>
                        </div>



                    </div>


                    <div class="clearfix"></div>


                    <%--</section>--%>
                    <!-- /.content -->

                    <div class="clearfix"></div>

                </div>

            </div>

        </div>
    </div>

    <div class="modal custmodal Issuesave_filter fade" id="issuesavefilter" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="">Save Filter As</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">

                    <!--save_filter_As-->
                    <div id="Issuesavrefilterbox" class="box-panel">
                      <%--  Added By Dipali V On 1st Nov 2021 For Note--%>
                        <span class="ClsFilterNote"> Filter Saved Against Selected Project </span><span class="ClsFilterNoteRED">Note :-</span>
                        <%--End of Added By Dipali V On 1st Nov 2021 For Note--%>
                        <div class="box-body graybg">
                            <div class="form-group mb-0">
                                <div class="row">
                                    <div class="col-md-12 row">
                                        <label class="control-label col-md-4 p-0 text-right">Filter Name <span style="color: red;">*</span> :</label>
                                        <span class="col-md-8">
                                            <input id="newfiltername" type="text" class="form-control" name="" autocomplete="off" maxlength="100" /><br />
                                            <div class="btnrow">
                                                <button id="btnsavefilter" onclick="SaveFilter()" class="btn btnyellow pull-left">Save</button>
                                                <button id="btncancelsavefilter" class="btn borderbtn pull-right">Cancel</button>
                                            </div>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--save_filter_As-->





                    <!-- /.content -->

                    <div class="clearfix"></div>

                </div>

            </div>

        </div>
    </div>

    <div id="applyConfirmAlert" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal">×</button>
                    <h4 class="modal-title">Confirmation</h4>
                </div>
                <div class="modal-body">
                    <p id="applyConfirmMsg">
                    </p>
                </div>
                <div class="modal-footer">
                    <button class="btn borderbtn pull-left uncheckbtn" data-bs-dismiss="modal" onclick="DoNotApply()">No</button>
                    <button class="btn btnyellow" data-bs-toggle="modal" data-bs-original-title="" data-bs-dismiss="modal" title="" onclick="Apply()">Yes</button>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>

    <div id="deleteConfirmAlert" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal">×</button>
                    <h4 class="modal-title">Confirmation</h4>
                </div>
                <div class="modal-body">
                    <input type="text" id="deletetype" hidden="hidden" />
                    <input type="text" id="deleteid" hidden="hidden" />
                    <p id="deleteConfirmMsg"></p>
                </div>
                <div class="modal-footer">
                    <button class="btn borderbtn pull-left uncheckbtn" data-bs-dismiss="modal">No</button>
                    <button class="btn btnyellow" data-bs-toggle="modal" data-bs-original-title="" data-bs-toggle="tooltip" data-bs-dismiss="modal" title="" onclick="Delete()">Yes</button>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>

    <div id="leaveConfirmAlert" class="modal fade custmodal in" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog ui-draggable">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header ui-draggable-handle">
                    <button type="button" class="close" data-bs-dismiss="modal">×</button>
                    <h4 class="modal-title">Confirmation</h4>
                </div>
                <div class="modal-body">
                    <p id="leaveConfirmMsg">
                        There may be unsaved changes on Edit filter. Do you want to proceed without saving?
                    </p>
                </div>
                <div class="modal-footer">
                    <button id="leaveConfirmAlertNo" class="btn borderbtn pull-left uncheckbtn" data-bs-dismiss="modal">No</button>
                    <button id="leaveConfirmAlertYes" class="btn btnyellow" data-bs-toggle="modal" data-bs-original-title="" data-bs-toggle="tooltip" data-bs-dismiss="modal" title="">Yes</button>
                    <div class="clearfix"></div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
             </div>
             </div>

    <!-- REQUIRED JS SCRIPTS -->
    <%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> 
	<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/moment-2.29.4.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/issues_custom.js?date=<%=DateTime.Now %>"></script>--%>
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/jquery.freezeheader.js"></script>
    <script type="text/javascript" src="../../../Whizible2.0-new/dist/js/multiselectW.min.js"></script>
   <%-- <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script> 
    <%--<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>

    <script type="text/javascript">

        var tooltipTriggerList = [].slice.call(document.querySelectorAll("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']"))
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl)
        });


        //Added By Rehan C To check validation for Special characters  on 07th Nov 2022
        var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
        var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString%>';
        var pageSize = 15;
        var EmployeeID;
        var UserName;
        var LoginID;
        var loginType;
        var postId;
        var strQueryFieldList;
        var strFilterFieldList;
        var strOperatorList;
        var RoleId;
        var RoleLevel;
        var ProjectId;
        var fromfilterSpan = false;
        var counter = 0;
        var textlength1 = 25;
        var textlength2 = 20;
        var sli = "li_";
        var sf = "f";
        var sscrum = "Scrum";
        var sAnd = " AND ";
        var filteredit = false;
        var SessionProjectId = "";
        var issueIdList;
        var m_PKToken;
        var viewApplied;
        var hdnQueryText = "";
        var intPageNo = 1;
        //Added By Dipali V on 28th Oct 2021
        var SecondFilter = "";
        var FirstFilter = "";
        var EmployeeID = "";
        var QueryID = "";
        var QueryType = "";
        var ViewTypeFilter = "";  //Added By Reshma chavan on 29th oct 2021
        //End of Added By Dipali V on 28th Oct 2021

         //Added By Dipali V on 28th Oct 2021
       SecondFilter = "<%= Session("SFilter")%>";
        FirstFilter = "<%= Session("FFilter")%>";
        SavedQueryName = "<%= Session("SavedQueryName")%>";
        EmployeeID = "<%= Session("EmployeeID")%>";
        QueryID = "<%= Session("QueryID")%>";
        QueryType = "<%= Session("QueryType")%>";
        //End of Added By Dipali V on 28th Oct 2021
        ViewTypeFilter = "<%=Session("ViewTypeFilter")%>"; //Added By Reshma chavan on 29th oct 2021

        EmployeeID = '<%= Session("intUserID") %>';
        UserName = '<%= Session("strUserName") %>';
        LoginID = '<%= Session("intLoginID") %>';
        loginType = '<%= Session("LoginType") %>';
        postId = '<%= Session("intPostID") %>';
        RoleId = '<%= Session("IssueRoleId") %>';
        RoleLevel = '<%= Session("IssueRoleLevel") %>';
        //SelectedSetSessionProjectID = '<%= Session("SelectedProjectID") %>';
      <%--  ProjectId = '<%= Session("IssueProject") %>';--%>
        SessionProjectId = '<%= Session("IntProjectID") %>';
        SelectedSetSessionProjectID = SessionProjectId;
        var issuePID = '<%= Session("IssueProject") %>';

        <%--if (SessionProjectId == "") {
            ProjectId = '<%= Session("IssueProject") %>';
        
        }
        else {
            ProjectId = SessionProjectId;
        }--%>
        if (RoleId != "") {
            RoleId = RoleId;
        } else {
            RoleId = "<%=m_IssueRoleId%>";
        }
        //Added by Swapnagandha K. for Session Project Issue On 18-Oct-2019
        if (issuePID != "" && "<%= Request.QueryString("FromWhere")%>" == "Issue") {
            //EndAdded by Swapnagandha K. for Session Project Issue On 18-Oct-2019
            ProjectId = issuePID;
        }


        else if (SessionProjectId != "") {
            ProjectId = SessionProjectId;
        }
        else {
            ProjectId = 0;
        }
        
        if ('<%= Request.QueryString("ViewType")%>' != '') {

            $("#cboAccessFilter option[value='" + '<%= Request.QueryString("ViewType")%>' + "']").attr("selected", "selected");
           // StaticView_OnChange('<%= Request.QueryString("ViewType")%>');
        }
        //Added By Dipali V On JD Upgarde
        if ('<%= Request.QueryString("intPageNo")%>' != '') {
            intPageNo = '<%= Request.QueryString("intPageNo")%>';
        } else {
            intPageNo = intPageNo;
        }
         //End of Added By Dipali V On JD Upgarde
        //alert(intPageNo);
        //alert('<%= Request.QueryString("intPageNo")%>');
        function showDisplay() {
            //alert("s");
        }
        //$(document).ajaxStart(function () {
        //    
        //     StartLoader("#bodyIssueList");

        //}).ajaxSuccess(function () {
        //     StartLoader("#bodyIssueList");
        //});
        var globalApplyQuery = "";
        var SelectedCurrentdate = "";
        var SelectedHeader = "";
        var SearchRecords = "0";//Added By Dipali V On 2nd Sep 2020 For JDTIAC Upgarde
        var TotalRecords = 0;
        var GlobalIssueCount = 0;
        var globalsearchby1 = "";
       // SecondFilter = "";
        var IssueProjectOnchange = 0;
        var GlobalSelectedProject = "";
         var removedefault = 0;
        var GlobalQueryID = "";//Added By  Dipali V On 9th Nov 2021 For Filter
        var IsExport = 0; //Added By Reshma Chavan on 25th Oct 2021 For Export Report Change
        var IsBack = '<%= Request.QueryString("IsBack")%>';
          var GetDefaultSavedFilterID = 0;
        window.addEventListener('load', (event) => {
            if ('<%= Request.QueryString("IsBack")%>' == 1)
            {
                IsBack = 1;

            }
           
        });

        var selectedFirstFilter = "";
        $(document).ready(function ()
        {

            //$("body").on("click", ".nav-tabs [data-bs-toggle='dropdown']", function () {
            //    $(".nav-tabs [data-bs-toggle='dropdown']").find(".dropdown-menu, .dropdown-toggle").removeClass("show");
            //    $(this).closest(".nav-tabs']").find(".dropdown-menu, .dropdown-toggle").addClass("show");

            //});

            //$('body').on('click', function (e) {
            //    $('.nav-tabs [data-bs-toggle="dropdown"]').each(function (e) {
            //        // hide any open popovers when the anywhere else in the body is clicked
            //        if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.nav-tabs .dropdown-menu').has(e.target).length === 0) {
            //            $(".nav-tabs .dropdown-menu").removeClass('show');
            //        }
            //    });
            //});

            //$("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").hover(function () {
            //    $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown'], [data-bs-toggle='modal']").tooltip('update');
            //}); //added by pradip on 24-3-2023

            $("body").on("click", "[data-bs-toggle='dropdown']", function () {
                $(".nav-tabs [data-bs-toggle='dropdown']").find(".dropdown-menu, .dropdown-toggle").removeClass("show");
                $(this).closest(".dropdown']").find(".dropdown-menu, .dropdown-toggle").addClass("show");

            });

            $('body').on('click', function (e) {
                $('[data-bs-toggle="dropdown"]').each(function (e) {
                    // hide any open popovers when the anywhere else in the body is clicked
                    if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.dropdown .dropdown-menu').has(e.target).length === 0) {
                        $(".dropdown-menu").removeClass('show');
                    }
                });
            });
            //modified by pradip on 10-5-2023


            StartLoader("#bodyIssueList");
            viewApplied = "<%=m_ViewApplied%>";
            if (EmployeeID == "")
            {
                window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError";
            }

            $('#hIsFilterClear').val('')
            //Filter Clear if applied
            if (IsBack!= 1) {
                //clearsession("Load");
            }                    
            //  clearsession("ViewTypeFilter"); //Added By reshma chavan on 29th oct 2021
            //alert(SecondFilter);
            //alert(FirstFilter);
            <%--  /*Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>
            $("#divissueList").removeClass("center");
            $("#divissueList").removeClass("preloader");
            $("#maindiv").removeClass('clsShowHide');
            <%--  /*End of Added & Commented By Dipali V On 16th May 2020 For Loader Issues*/--%>

           //Added by Dipali V On 3rd April 2020 For Remove Tool Tip
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });$('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });
             //End of Added by Dipali V On 3rd April 2020 For Remove Tool Tip

            $(document).on("click", function () {
                $(".tooltip").removeClass('show');
            });

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

            loadDataTable();

            $('#multiselect1').multiselect();
            $('#multiselect2').multiselect();
            $('[data-bs-toggle="tooltip"]').click(function () {
                $('[data-bs-toggle="tooltip"]').tooltip("hide");
            });

            GetRoleSession();
            getIssueProjectList();

            $("#issuelisttblmain").parent("div.col-sm-12").addClass("table-responsive");
            $('[data-bs-toggle="tooltip"]').click(function () {
                $('[data-bs-toggle="tooltip"]').tooltip("hide");
            });

            SetSessionProject();
            getULSearch();

            //Dipali V On 28th Oct 2021 Filter Persist
            if (SecondFilter == "" && FirstFilter == "") {
                $("#btnSearchBy").text('Select');
                $("#btnSearchBy").html('Select' + " " + '<span class="caret"></span>')
            } 
            //End of Dipali V On 28th Oct 2021 Filter Persist
            StopAjaxLoader("#bodyIssueList");

            $('.fplistbox').on('click', 'input[type="checkbox"]', function () {
                //
                var ctr = this.name.split("_");
                var controlid = ctr[1];
                var TotalCheckbox = $("#" + controlid + " li").length;
                var Checkboxcount = $("#" + controlid + " input[type=checkbox]:checked").length;
                var options = document.getElementsByName(this.name);
                // alert(Checkboxcount);
                //  alert(TotalCheckbox);
                // alert($(this.name + ':checked').length);
                if ($(this).prop("checked") == true) {
                    //Commented and Added by Nilesh Pingale on 16th Mar 2020 (Issue ID : 23465, 23461) for uncheck on last uncheck not working
                    ////Added by dipali V on 9th Sep 2019 for uncheck all checkbox then All checkbox should
                    //if (TotalCheckbox - 1 == Checkboxcount) {
                    //    $(this).parents('.fplistbox').find('.checkAll').prop("checked", true);
                    //}
                    ////End of Added by dipali V on 9th Sep 2019 for uncheck all checkbox then All checkbox should
                    //$(this).parents('.fplistbox').find('.fplist_title').css({ 'background': '#2e51a2', 'color': '#ffffff' });
                    ////alert(this.name);
                    //for (var i = 0; i < options.length; i++) {
                    //    if (options[i].checked == true) {
                    //        $(this).parents('.fplistbox').find('.fplist_title').css({ 'background': '#2e51a2', 'color': '#ffffff' });
                    //        $(this).parents('.fplistbox').find('.checkAll').prop("checked", true);
                    //        break;
                    //    }
                    //}
                    //$(this).parents('.fplistbox').find('.checkAll').checked == true

                    if (TotalCheckbox - 1 == Checkboxcount || TotalCheckbox == Checkboxcount) {
                        $(this).parents('.fplistbox').find('.checkAll').prop("checked", true);
                        $(this).parents('.fplistbox').find('.fplist_title').css({ 'background': '#2e51a2', 'color': '#ffffff' });
                    }
                    if (Checkboxcount > 0 || TotalCheckbox == Checkboxcount) {
                        $(this).parents('.fplistbox').find('.fplist_title').css({ 'background': '#2e51a2', 'color': '#ffffff' });
                    }
                    else {
                        $(this).parents('.fplistbox').find('.fplist_title').css({ 'background': '#e7edf0', 'color': 'inherit' });
                    }
                    //End of Added by Nilesh Pingale on 16th Mar 2020 (Issue ID : 23465, 23461) for uncheck on last uncheck not working
			
                }
                else if ($(this).prop("checked") == false) {
                    //Commented and Added by Nilesh Pingale on 16th Mar 2020 (Issue ID : 23465, 23461) for uncheck on last uncheck not working
                    ////alert("Checkbox is unchecked.");
                    ////$(".fplist_title").css('background','#e7edf0');
                    ////debugger;
                    //var keep = false;
                    //var uncheckCount = 0;
                    //var options = document.getElementsByName(this.name);
                    //for (var i = 0; i < options.length; i++) {
                    //    if (options[i].checked == true) {
                    //        keep = true;
                    //        break;
                    //    }
                    //    else/* if (options[i].length == options.length && options[i].checked == false)*/ {
                    //        uncheckCount = uncheckCount + 1;
                    //        //$("#fComplexity .checkAll").prop("checked",false);
                    //        //}
                    //    }
                    //    //Added by dipali V on 9th Sep 2019 for uncheck all checkbox then All checkbox should
                    //    if (uncheckCount == options.length) {
                    //        // $(".checkAll").prop("checked",false);
                    //        $(this).parent('.fplistbox:first-child').find('.checkAll').prop("checked", false);
                    //        // $(this).find('.fplistbox .checkAll').prop("checked", false);
                    //    }
                    //    if (TotalCheckbox != Checkboxcount) {
                    //        $(this).parents('.fplistbox').find('.checkAll').prop("checked", false);
                    //    }
                    //    //End of Added by dipali V on 9th Sep 2019 for uncheck all checkbox then All checkbox should
                    //}
                    //if (!keep) $(this).parents('.fplistbox').find('.fplist_title').css({ 'background': '#e7edf0', 'color': 'inherit' });
                    //if (!keep) $(this).parents('.fplistbox').find('.checkAll').prop("checked", false);

                    for (var i = 0; i < options.length; i++) {
                        if (options[i].checked == false) {
                            //$(this).parents('.fplistbox').find('.fplist_title').css({ 'background': '#e7edf0', 'color': 'inherit' });
                            $(this).parents('.fplistbox').find('.checkAll').prop("checked", false);
                            break;
                        }
                    }
                    if (Checkboxcount > 0) {
                        $(this).parents('.fplistbox').find('.fplist_title').css({ 'background': '#2e51a2', 'color': '#ffffff' });
                    }
                    else {
                        $(this).parents('.fplistbox').find('.fplist_title').css({ 'background': '#e7edf0', 'color': 'inherit' });
                    }
                    //End of Added by Nilesh Pingale on 16th Mar 2020 (Issue ID : 23465, 23461) for uncheck on last uncheck not working
                }
            });
            $("#btncancelsavefilter").click(function () {
                $("#issuesavefilter").modal('hide');
            });
          
            // //Dipali V On 28th Oct 2021 Filter Persist
            //if (SecondFilter == "") {
            //    SecondFilter = $('#searchoptiontext').val();
            //}  if (FirstFilter == "") {
            //    FirstFilter = $('#unsavedquerytext').val();
            //}
            // var qidnew = $('#queryid').val()
            //// alert(qidnew);
            //if (FirstFilter != "" && SecondFilter != "" && ViewTypeFilter != "") {
            //    if (FirstFilter.indexOf("''") > -1) {
            //        //   FirstFilter = FirstFilter.replace(/\''/g, "'");
            //    } else {
            //        FirstFilter = FirstFilter.replace(/\'/g, "''");
            //    }

            //    // GetAppliedFilter();
            //    filterChange('', EmployeeID, qid, FirstFilter, SavedQueryName, "B", 'True');
            //    $("#divFilter").show();
            //    $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
            //    var pid = $("#projectid").val();

            //    //Nikhil--1

            //    //Commented By Nikhil Adkar
            //    var viewtype = $('#cboAccessFilter').val();
            
            //    getIssueList(pid, viewtype);
            //    //End of Commnetd BY Nikhil Adkar
            //    $("#cboAccessFilter").val(ViewTypeFilter);
            //    // $("#lnkClearSearch").css('FONT-WEIGHT', '900');
            //    $("#lnkClearSearch").addClass("ClearSencondfilter");
            //}
            //else if (FirstFilter != "" && SecondFilter != "") {
            //    if (FirstFilter.indexOf("''") > -1) {
            //        //   FirstFilter = FirstFilter.replace(/\''/g, "'");
            //    } else {
            //        FirstFilter = FirstFilter.replace(/\'/g, "''");
            //    }

            //    GetAppliedFilter();
            //    filterChange('', EmployeeID, qid, FirstFilter, SavedQueryName, "B", 'True');
            //    $("#divFilter").show();
            //    $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
            //    // $("#lnkClearSearch").css('FONT-WEIGHT', '900');
            //    $("#lnkClearSearch").addClass("ClearSencondfilter");
            //}
            ////Added By Reshma Chavan on 29TH Oct 2021 for Filter Persist
            //else if (FirstFilter != "" && ViewTypeFilter != "") {
            //    if (FirstFilter.indexOf("''") > -1) {
            //        //   FirstFilter = FirstFilter.replace(/\''/g, "'");
            //    } else {
            //        FirstFilter = FirstFilter.replace(/\'/g, "''");
            //    }

            //    GetAppliedFilter();
            //    filterChange('', EmployeeID, qid, FirstFilter, SavedQueryName, "B", 'True');
            //    $("#divFilter").show();
            //    $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
            //    var pid = $("#projectid").val();

            //    getIssueList(pid, ViewTypeFilter);
            //    $("#cboAccessFilter").val(ViewTypeFilter);
            //}
            //else if (SecondFilter != "" && ViewTypeFilter != '') {

            //    GetAppliedFilter();
            //    filterChange('', EmployeeID, 0, '', '', '');
            //    var pid = $("#projectid").val();

            //    //Commented and Added By Nikhil Adkar
            //    getIssueList(pid, ViewTypeFilter);
            //    //End of Commented by Nikhil Adkar
            //    $("#cboAccessFilter").val(ViewTypeFilter);
            //    // $("#lnkClearSearch").css('FONT-WEIGHT', '900');
            //    $("#lnkClearSearch").addClass("ClearSencondfilter");
            //}
            ////End of Added By Reshma Chavan on 29TH Oct 2021 for Filter Persist
            //else if (FirstFilter != "") {
            //    if (FirstFilter.indexOf("''") > -1) {
            //        //   FirstFilter = FirstFilter.replace(/\''/g, "'");
            //    } else {
            //        FirstFilter = FirstFilter.replace(/\'/g, "''");
            //    }
            //    filterChange('', EmployeeID, qidnew, FirstFilter, SavedQueryName, "B", 'True');
            //    $("#divFilter").show();
            //    $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
            //}
            //else if (SecondFilter != "") {
            //    //Dipali V on 2021

            //    GetAppliedFilter();
            //    // $("#lnkClearSearch").css('FONT-WEIGHT', '900');
            //    $("#lnkClearSearch").addClass("ClearSencondfilter");
            //}
            ////Added By Reshma Chavan on 29th oct 2021 for Filter Persist 
            //else if (ViewTypeFilter != "") {
            //    var pid = $("#projectid").val();

            //    getIssueList(pid, ViewTypeFilter);

            //    $("#cboAccessFilter option[value='" + ViewTypeFilter + "']").attr("selected", "selected");

            //}
            //else {
            //    var pid = $("#projectid").val();
            //    getIssueList(pid, ViewTypeFilter);
            //}
           //Added By reshma chavan on 17th Nov 2021 not applying grid filter
            GlobalSelectedProject = $("#cboIssueProjects").val();
            //End of Added By Reshma Chavan on 29th oct 2021 for Filter Persist 
            Pagination();
        });

        //Added By Rehan C To check validation for Special characters  on 07th Nov 2022
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
        function GetAppliedFilter() {
        
            if (SecondFilter.indexOf("LIKE") > -1) {
                var Result = SecondFilter.split("LIKE");
                s = Result[0].trim();
                id = Result[1].trim();
                var value = id.replace("'%", '');
                var value_New = value.replace("%'", '');
                if (value_New.indexOf("'") > -1) {
                    value_New = value_New.replace(/\'/g, "");
                }
                //debugger;
                if (s == "Type") {
                    sid = "Issue Type";
                }
                if (s == "IssueID") {
                    sid = "IssueID";
                    s = "Issue ID";
                    //$("#btnSearchBy").text(s);
                    $("#btnSearchBy").html(s + " " + '<span class="caret"></span>')
                }
                if (s == "Status") {
                    sid = "Status";
                }
                if (s == "AssignToName") {
                    sid = "Responsible Person";
                }
                if (s == "CreatorOrModifier") {
                    sid = "Submitted By";
                }
                if (s == "ReportedDate") {
                    sid = "ReportedDate";
                    s = "Reported Date";
                }
                if (s == "ShowToCustomer") {
                    sid = "Show To Customer";
                }
                if (s == "Deliverable") {
                    sid = "Deliverables";
                }
                if (s == "Summary") {
                    sid = "Summary";
                }
                if (s == "Description") {
                    sid = "Description";
                }
                if (s == "Discussion") {
                    sid = "Discussion";
                }
                globalsearchby1 = value_New;
                if (sid != "") {
                   searchOption(s, sid, "FromFilter");//Persist Filter
                }
            }
            else if ((SecondFilter.indexOf("Date") > -1) || SecondFilter.indexOf("Last Updated") > -1) {
                var DateNew = SecondFilter.split("AND");
                var GetFromDate = DateNew[0].match(/'([^']+)'/)[1];
                var GetToDate = DateNew[1].match(/'([^']+)'/)[1];
                if (SecondFilter.indexOf("ReportedDate") > -1) {
                    s = "Reported Date";
                    sid = "ReportedDate";
                }
                else if (SecondFilter.indexOf("LastUpdated") > -1) {
                    s = "Last Updated";
                    sid = "LastUpdated";
                }
                searchOption(sid, s, "FromFilter");
                $("#searchby1").val(GetFromDate);//Assign From Date To Controller
                $("#searchby2").val(GetToDate);//Assign To Date To Controller
                callSearch(SecondFilter);//Get Filter Data
            }
           
            if (SecondFilter != "") {
                $("#lnkClearSearch").addClass("ClearSencondfilter");
                //End of If Filter Applied then Clear Button Highlight
            }

        }


        function Pagination() {
            //debugger;
            var ProjectID = $('#cboIssueProjects').val(); 
            if (parseInt(SearchRecords) == 0 ) {
                TotalRecords = GlobalIssueCount;
            } else {
                 //Commented by imran 26-10-2021 Because if No Record Found get display that time it show one record
                //TotalRecords = $("#issueBody tr").length;
                //end Comment 26-10-2021
            }

            if (ProjectID != 0) {
                //Added By  Dipali V On 2nd Sep 2020 For JDTIAC Upgarde
                //var TotalRecords = $("#issueBody tr").length;
                // TotalRecords = GetFilteredIssueCount(ProjectID);
               // var currentRecord = (intPageNo * 100);
                var currentRecord = (intPageNo * 50);
                //alert(TotalRecords);
                 if (parseInt(intPageNo) == 1) {
                    //$("#btnprevious").attr("disabled", "disabled")
                     //$("#btnnext").removeAttr("disabled");

                     $("#btnprevious").addClass("fa-disabled");
                     $("#btnnext").removeClass("fa-disabled");
                     $("#LinkPrevious").removeAttr("Onclick");
                     $("#LinkNext").attr("Onclick", "NextList()");
                     
                     
                }
                if (parseInt(currentRecord) > parseInt(TotalRecords) && intPageNo==1) {
                    //$("#btnprevious").attr("disabled");
                    //$("#btnnext").attr("disabled", "disabled")
                     $("#btnprevious").addClass("fa-disabled");
                    $("#btnnext").addClass("fa-disabled");

                     $("#LinkPrevious").removeAttr("Onclick");
                     $("#LinkNext").removeAttr("Onclick");
                }
                else if (parseInt(currentRecord) >= parseInt(TotalRecords)) {
                    //$("#btnprevious").removeAttr("disabled");
                   // $("#btnnext").attr("disabled", "disabled")

                     $("#btnprevious").removeClass("fa-disabled");
                    $("#btnnext").addClass("fa-disabled");

                     $("#LinkPrevious").attr("Onclick", "PrevList()");
                     $("#LinkNext").removeAttr("Onclick");

                }

                 else if (parseInt(intPageNo) > 1 && parseInt(currentRecord) < parseInt(TotalRecords)) {
                   // $("#btnprevious").removeAttr("disabled");
                    //$("#btnnext").removeAttr("disabled");
                     $("#btnprevious").removeClass("fa-disabled");
                    $("#btnnext").removeClass("fa-disabled");

                       $("#LinkPrevious").attr("Onclick", "PrevList()");
                     $("#LinkNext").attr("Onclick", "NextList()");

                }
                if (parseInt(SearchRecords) == "1" && parseInt(currentRecord) >= parseInt(TotalRecords)) {
                    //$("#btnprevious").attr("disabled", "disabled")
                    //$("#btnnext").attr("disabled", "disabled")
                     $("#btnprevious").addClass("fa-disabled");
                    $("#btnnext").addClass("fa-disabled");
                     $("#LinkPrevious").removeAttr("Onclick");
                     $("#LinkNext").removeAttr("Onclick");


                }
            } else {
                TotalRecords = 0;
               // $("#btnprevious").attr("disabled", "disabled");
                //$("#btnnext").attr("disabled", "disabled");
                $("#btnprevious").addClass("fa-disabled");
                $("#btnnext").addClass("fa-disabled");
                 $("#LinkPrevious").removeAttr("Onclick");
                     $("#LinkNext").removeAttr("Onclick");

            }
            //Added By Dipali V On 4th Sep 2020 For Show Total Issue Count
            //Added By Usha Pandit On 17.09.2020 for IE pagination next prev button disable issue
            if (isIE() == "IE") {
                if ($("#btnprevious").hasClass("fa-disabled")) {// && $("#btnnext").hasClass("fa-disabled")) {
                    $("#btnprevious").addClass("clsPaginationEnableDisable");
                    //$("#btnprevious").css("cssText", "pointer-events: none!important;");
                }
                else {
                    $("#btnprevious").removeClass("clsPaginationEnableDisable");
                    //$("#btnprevious").css("pointer-events", "");
                }
                if ($("#btnnext").hasClass("fa-disabled")) {// && $("#btnnext").hasClass("fa-disabled")) {
                    //$("#btnnext").css("cssText", "pointer-events: none!important;");
                    $("#btnnext").addClass("clsPaginationEnableDisable");
                }
                else {
                    //$("#btnnext").css("pointer-events", "");
                    $("#btnnext").removeClass("clsPaginationEnableDisable");
                }
            }
            //End Of Added By Usha Pandit On 17.09.2020 for IE pagination next prev button disable issue
            $("#TotalRecords").html("");
            $("#TotalRecords").html(TotalRecords);
             //End of Added By Dipali V On 4th Sep 2020 For Show Total Issue Count
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
        
        function RefreshAllData() {
            viewApplied = <%=m_ViewApplied%>
            loadDataTable();
            $('#multiselect1').multiselect();
            $('#multiselect2').multiselect();
            $('[data-bs-toggle="tooltip"]').click(function () {
                $('[data-bs-toggle="tooltip"]').tooltip("hide");

            });
            // GetRoleSession();

            // getIssueProjectList();
            $("#issuelisttblmain").parent("div.col-sm-12").addClass("table-responsive");
            $('[data-bs-toggle="tooltip"]').click(function () {
                $('[data-bs-toggle="tooltip"]').tooltip("hide");

            });
            // SetSessionProject();
            getULSearch();
            $("#btnSearchBy").text('Select');
            $("#btnSearchBy").html('Select' + " " + '<span class="caret"></span>')
            //filterChange(0, 0, '', '', '');
            StopAjaxLoader("#bodyIssueList");

            $('.fplistbox').on('click', 'input[type="checkbox"]', function () {
                //
                var ctr = this.name.split("_");
                var controlid = ctr[1];
                var TotalCheckbox = $("#" + controlid + " li").length;
                var Checkboxcount = $("#" + controlid + " input[type=checkbox]:checked").length;
                // alert(Checkboxcount);
                //  alert(TotalCheckbox);
                // alert($(this.name + ':checked').length);
                if ($(this).prop("checked") == true) {
                    //Added by dipali V on 9th Sep 2019 for uncheck all checkbox then All checkbox should
                    if (TotalCheckbox - 1 == Checkboxcount) {
                        $(this).parents('.fplistbox').find('.checkAll').prop("checked", true);
                    }
                    //End of Added by dipali V on 9th Sep 2019 for uncheck all checkbox then All checkbox should
                    $(this).parents('.fplistbox').find('.fplist_title').css({ 'background': '#2e51a2', 'color': '#ffffff' });
                    //alert(this.name);				
                }
                else if ($(this).prop("checked") == false) {
                    //alert("Checkbox is unchecked.");
                    //$(".fplist_title").css('background','#e7edf0');
                    //
                    var keep = false;
                    var uncheckCount = 0;

                    var options = document.getElementsByName(this.name);
                    for (var i = 0; i < options.length; i++) {
                        if (options[i].checked == true) {

                            keep = true;
                            break;
                        }
                        else/* if (options[i].length == options.length && options[i].checked == false)*/ {
                            uncheckCount = uncheckCount + 1;
                            //$("#fComplexity .checkAll").prop("checked",false);
                            //}

                        }
                        //Added by dipali V on 9th Sep 2019 for uncheck all checkbox then All checkbox should
                        if (uncheckCount == options.length) {
                            // $(".checkAll").prop("checked",false);
                            $(this).parent('.fplistbox:first-child').find('.checkAll').prop("checked", false);
                            // $(this).find('.fplistbox .checkAll').prop("checked", false);
                        }

                        if (TotalCheckbox != Checkboxcount) {
                            $(this).parents('.fplistbox').find('.checkAll').prop("checked", false);
                        }
                        //End of Added by dipali V on 9th Sep 2019 for uncheck all checkbox then All checkbox should
                    }

                    if (!keep) $(this).parents('.fplistbox').find('.fplist_title').css({ 'background': '#e7edf0', 'color': 'inherit' });
                    if (!keep) $(this).parents('.fplistbox').find('.checkAll').prop("checked", false);
                }
            });

            $("#btncancelsavefilter").click(function () {
                $("#issuesavefilter").modal('hide');
            });

        }




        $("#searchby").on("keyup", ".clstxtSerachControl", function (event) {
            if ($('#searchby1').val().trim() != "") {
               
                btnApplySearch();
            }
            else {
                callSearch('');
            }
        });
       
        $("#searchby").change(function (event) {
            //Added By dipali V On 9th Oct 2019 For Clear filter
            if ($("#searchby1").val() == "-1") {
            
                callSearch('');
                var viewtype = $('#cboAccessFilter').val();
                var pid = $("#projectid").val();
                getIssueList(pid, ViewTypeFilter);
            }
            else {
               
                //Added By Usha Pandit On 25.05.2021 For applying correct filter
                if ($(this).find("i").hasClass("fa-calendar") == false) {
                   
                    btnApplySearch();
                    var viewtype = $('#cboAccessFilter').val();
                    var pid = $("#projectid").val();
                    getIssueList(pid, ViewTypeFilter);
                }
                //End Of Added By Usha Pandit On 25.05.2021 For applying correct filter
                //Commented By Usha Pandit On 07.05.2021 For wrong alert getting display on date selection
                //btnApplySearch();
                //End Of Commented By Usha Pandit On 07.05.2021 For wrong alert getting display on date selection
            }
            //End of Added By dipali V On 9th Oct 2019 For Clear filter
        });
       
        var issueTable;
        function loadDataTable() {
            //Added an dcommented by Vishal Mane on 01/06/2026 from SBI Security Issues
            //StartLoader("#bodyIssueList");
            //$.fn.DataTable.ext.pager.numbers_length = 5;
            // Scroll only the table body area; header stays sticky via CSS
            SetWindowHeight();
            var resizeWrapper = document.getElementById("resize_wrapper");
            if (resizeWrapper) {
                resizeWrapper.style.overflowX = "auto";
                resizeWrapper.style.overflowY = "auto";
            }
        }

        function btnAppendClick() {
            var output = "";
            output = GenerateAdvancedQuery();
            if (output != '' && output != null && output != undefined) {
                $('#unsavedquerytext').val(output);
            } else {
                if (output == '' || output == null) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Please form a query.', 'error');
                    return false;
                }
            }
            $('#queryText').val(output.replace(/''/g, "'"));
        }
        function GetRole(pid) {
            var issueParameters = {
                intEmployeeID: EmployeeID,
                ProjectID: pid,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/GetRole", param, false);
            if (strResult != undefined) {
                $('#roleid').val(strResult);
            }
        }

        function GetRoleSession() {
            $('#roleid').val(RoleId);
        }
        function getIssueProjectList() {
            // StartLoader("#bodyIssueList");
            //var SessionProjectID = 0;

            <%--alert('<%= Session("IssueProject") %>');--%>
            SessionProjectID = '<%= Session("intProjectID") %>';

            var issueParameters = {
                intEmployeeID: EmployeeID,
                strLoginID: LoginID,
                ProjectID: SessionProjectID,
                LoginType: loginType,
                SessionProjectID: '<%= Session("IntProjectID") %>',
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/GetProjectDropdownValues", param, false);
            if (strResult != undefined) {
                var selHTML = "";
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var ProjectID = d.ProjectID;
                    var ProjectName = d.ProjectName;
                    selHTML += "<option  value='" + ProjectID + "' >" + ProjectName + "</option>";
                }
                //  StopAjaxLoader("#bodyIssueList");
                $("#cboIssueProjects").html(selHTML);
                $('[data-bs-toggle="tooltip"]').tooltip();

            }
        }
        function SetSessionProject() {
           // debugger;
            if (ProjectId != null && ProjectId != 0) {
                //Commented And Added By Usha Pandit On 06.01.2021 For Project selection issue if project set as default 
                //$('#cboIssueProjects').val(ProjectId).change();
                //$('#projectid').val(ProjectId);                
                if (($("#cboIssueProjects option[value='" + ProjectId + "']").length) > 0) {
                    $('#cboIssueProjects').val(ProjectId).change();
                    $('#projectid').val(ProjectId);
                }
                //End Of Added By Usha Pandit On 06.01.2021 For Project selection issue if project set as default 
            }
        }

        //Commented and Added By Reshma Chavan on 25th Oct 2021 For Export Report Change
        //function getIssueList(pid, viewtype) {
        function getIssueList(pid, viewtype,IsExport) {
            //StartLoader("#bodyIssueList");
            //$('#issuelisttblmain').dataTable().fnDestroy();
           // debugger;
            getIssueListHeader(pid);

            //Commented and Added By Reshma Chavan on 25th Oct 2021
            //getIssueListBody(pid, viewtype);
            //Pagination()
            //loadDataTable();
            if (IsExport == undefined) {                
                IsExport = 0;
            }
            getIssueListBody(pid, viewtype,IsExport);
            if (IsExport == 0) {                
                Pagination()
                loadDataTable();
            }

            //End of Commented and Added By Reshma Chavan on 25th Oct 2021 For Export Report Change
            //StopAjaxLoader("#bodyIssueList");
        }

        function getULSearch() {
            var issueParameters = {
                LoginType: loginType,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/GetSearchOptions", param, false);
            if (strResult != undefined) {
                var selHTML = "";
                selHTML += "<li id='0' value='' onclick='searchOption(this.id, \"\", \"FromOnChange\")'><a href='#'>";
                selHTML += "<img class='weeklycalender_icon' src='../../../Whizible2.0-new/dist/img/Search.svg' alt='' width='15px' style='margin-right: 6px; '/>";
                selHTML += "Select";
                selHTML += "</a></li>"
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var oid = d.Id;
                    var ovalue = d.Value;
                    selHTML += "<li id='" + oid + "' value='" + ovalue + "' onclick='searchOption(this.id, \"" + ovalue + "\",\"FromOnChange\")'><a href='#'>";
                    selHTML += "<img class='weeklycalender_icon' src='../../../Whizible2.0-new/dist/img/Search.svg' alt='' width='15px' style='margin-right: 6px; '/>";
                    selHTML += " " + ovalue;
                    selHTML += "</a></li>"
                }
                $("#ulSearch").html(selHTML);
            }
        }

        //function searchOption(id, s) {
        function searchOption(id, s, whichaction) {
           // debugger;
            if (s != "IssueID") {
                $("#btnSearchBy").text(s);
                $("#txtSearchBy").val(id);
                 $("#btnSearchBy").html(s + " " + '<span class="caret"></span>');
            } else {
                $("#btnSearchBy").text(id);
                $("#txtSearchBy").val(s);
                $("#btnSearchBy").html(id + " " + '<span class="caret"></span>');
            }
           
            var pid = $('#projectid').val();
            var strResult, data;
            var issueParameters = {
                ProjectID: pid,
                intEmployeeID: EmployeeID,
                LoginType: loginType,
                ControlName: s,
            }
            data = JSON.stringify(issueParameters);
            strResult = AJAXCallWithResult("/api/Issue/GetSearchOptionControl", data, false);
            var selHTML = "";
            if (strResult != undefined) {
                var type = strResult.Type;
                var cmbData = strResult.lstControlCombo;
                $("#ulSearch").removeClass('show');//Added By Dipali V On 5th April 2023 For Close Filter
                if (type == "C") {
                    $("#btnGo").attr("disabled", "disabled");
                    selHTML += '<select class="form-control clscmbSerachControl" style="margin-left:3px;" id="searchby1">';
                    selHTML += "<option title='' value='-1'> Select " + s + " </option>";
                    if (cmbData != undefined) {
                        for (var i = 0; i < cmbData.length; i++) {
                            var d = cmbData[i];
                            var key = d.Key;
                            var value = d.Value;
                            selHTML += "<option title='" + value + "' value='" + key + "'>" + value + "</option>";
                        }
                    }
                    selHTML += "</select>";
                }
                else if (type == "D") {
                    $("#btnGo").removeAttr("disabled");
                     //Commented and Added By Reshma Chavan on 21st Oct 2020 For UI Reporated Date Issue
                    //selHTML += "<div style='margin-right:0px;'>";
                    selHTML += "<div style='margin-right:0;position:relative;'>";
                    //End of Commented and Added By Reshma Chavan on 21st Oct 2020 For UI Reporated Date Issue
                    //modify input field width by pradip on 5jan 2021

                    //Commented And Added By Usha Pandit On 05.05.2021 For alignment issue
                    selHTML += "<input type='text' autocomplete='off' readonly style='width:120px; margin-left:3px; margin-right:3px;' class='form-control' id='searchby1' placeholder='From'";
                    selHTML += " onfocus = '$(\"#searchby1\").datepicker({autoclose: true,changeMonth: true,dateFormat: \"dd M yy\"}); $(\"#searchby1\").datepicker(\"show\");'/>";
                    selHTML += "<i class='fa fa-calendar searchDate' onclick='showCalendar(\"searchby1\");'></i>";

                    //changes added by Ashwini M on 27-3-2023
                    selHTML += "<input type='text'  autocomplete='off' readonly style='width:120px; margin-right:3px;' class='form-control' id='searchby2' placeholder='To'";
                    selHTML += " onfocus = '$(\"#searchby2\").datepicker({autoclose: true,changeMonth: true,dateFormat: \"dd M yy\"}); $(\"#searchby2\").datepicker(\"show\");'/>";
                    selHTML += "<i class='fa fa-calendar searchDate' style='left:238px;' onclick='showCalendar(\"searchby2\");'></i>";
                    //End of changes added by Ashwini M on 27-3-2023

                    selHTML += "</div>";

                    //selHTML += "<input type='text' autocomplete='off' readonly style='width:120px; margin-left:3px; margin-right:3px;' class='form-control' id='searchby1' placeholder='From'";
                    //selHTML += " onfocus = '$(\"#searchby1\").datepicker({autoclose: true,changeMonth: true,dateFormat: \"dd M yy\"}); $(\"#searchby1\").datepicker(\"show\");'/>";
                    //selHTML += "<i class='fa fa-calendar searchDate' onclick='showCalendar(\"searchby1\");'></i>";
                    //selHTML += "<input type='text'  autocomplete='off' readonly style='width:120px; margin-left:3px; margin-right:3px;' class='form-control' id='searchby2' placeholder='To'";
                    //selHTML += " onfocus = '$(\"#searchby2\").datepicker({autoclose: true,changeMonth: true,dateFormat: \"dd M yy\"}); $(\"#searchby2\").datepicker(\"show\");'/>";
                    //selHTML += "<i class='fa fa-calendar searchDate' onclick='showCalendar(\"searchby2\");'></i>";
                    //selHTML += "</div>";
                    //End Of Added By Usha Pandit On 05.05.2021 For alignment issue
                }
                else {
                    if ($("#btnSearchBy").text().trim() == "") {
                        $("#btnGo").removeAttr("disabled");
                        selHTML += '<input id="searchby1" readonly="readonly" style="margin-left:3px;" placeholder="Select Search Option..." type="text" class="form-control" autocomplete="off"/>';
                        clearSearch();
                       // alert(2)
                    }
                    else {
                        $("#btnGo").attr("disabled", "disabled");
                        if (s == "Issue ID") {
                            selHTML += '<input id="searchby1" style="margin-left:3px;" type="text" placeholder="' + s + '" class="form-control clstxtSerachControl" autocomplete="off" onkeypress="return restrictAlphabets(event)"/>';
                        } else {
                            selHTML += '<input id="searchby1" style="margin-left:3px;" type="text" placeholder="' + s + '" class="form-control clstxtSerachControl" autocomplete="off"/>';
                        }

                    }
                }
            }
            $("#searchby").html(selHTML);
            //Dipali V On 28th Oct 2021 Filter Persist
            if (SecondFilter != "" && whichaction != "FromOnChange") {
                if (s != "IssueID" && s != "Reported Date" &&  s != "Last Updated") {
                    $("#btnSearchBy").text(s);
                    $("#txtSearchBy").val(id);
                    $("#btnSearchBy").html(s + " " + '<span class="caret"></span>');
                } 
                $("#searchby1").val(globalsearchby1);
                if (s != "Reported Date" &&  s != "Last Updated") {
                    btnApplySearch();
                }
            } else {
                $("#searchby").change(function (event) {
                   // debugger;
                    //Added By dipali V On 9th Oct 2019 For Clear filter
                    if ($("#searchby1").val() == "-1") {
                        callSearch('');
                           $("#lnkClearSearch").removeClass("ClearSencondfilter");

                    }
                    else {
                        //Added By Usha Pandit On 25.05.2021 For applying correct filter                    
                        if ($(this).find("i").hasClass("fa-calendar") == false) {
                            btnApplySearch();
                              $("#lnkClearSearch").addClass("ClearSencondfilter");

                        }

                    }
                    //End of Added By dipali V On 9th Oct 2019 For Clear filter
                });
               
                //Dipali V On 28th Oct 2021 Filter Persist
                if (SecondFilter == "") {
                    $("#searchoptiontext").val("");
                    //Commented And Added By reshma Chavan on 29th oct 2021 
                    //var viewtype = $("#viewtype").val();
                    var viewtype = $("#cboAccessFilter").val();
                    //End of Commented And Added By reshma Chavan on 29th oct 2021
                    //Commented by Nikhil Adkar on 31-May-2023
                    //getIssueList(pid, viewtype);
                    //End of Commented By Nikhil Adkar
                }
                if (SecondFilter != "" && whichaction === "FromOnChange") {
                    callSearch('');
                    $("#lnkClearSearch").removeClass("ClearSencondfilter");

                }
                //End of Dipali V On 28th Oct 2021 Filter Persist
            }
          
        }

        
       
       

        function GenerateSearch() {
            // 
            var output = "";
            var a = "", b = "";
            a = $('#searchby1').val();
            b = $('#searchby2').val();
            var searchby = $('#txtSearchBy').val();
            //added By dipali v On 28th sep 2019 for Replace sing qoute to space 
            //if ($("#btnSearchBy").text() == "Issue ID ")
            //{
            //Commented And Added By Reshma Chavan on 8th Nov 2021
            //a = a.replace(/'/g, ' ');
            if (a != '' && a != null && a != undefined) {
                a = a.replace(/'/g, ' ');
            }
            //End of Commented And Added By Reshma Chavan on 8th Nov 2021
            //}
            //End of added By dipali v On 28th sep 2019 for Replace sing qoute to space 
            if (a != '' && a != null && a != undefined) {
                //output += searchby + " LIKE '%" + a + "%' ";
                  output += searchby + " LIKE '%" + a + "%' ";
            }
            else {
                output = "";
                return output;
            }
            if (b != undefined) {
                if (b != '' && b != null) {
                    
                    output = searchby + " BETWEEN '" + a + "' AND DATEADD(d, 0, '" + b + "') ";
                    //Added By Usha Pandit On 25.05.2021 For applying correct filter
                    if (searchby == "LastUpdatedDate" || searchby =="ReportedDate") {
                        output = " CAST(" + searchby + " AS Date) " + " BETWEEN CAST('" + a + "' AS Date) AND CAST('" + b + "' AS Date) ";                        
                    }
                    //End Of Added By Usha Pandit On 25.05.2021 For applying correct filter
                    //var aDate = new Date(a);
                    //var bDate = new Date(b);
                    //if (aDate > bDate) {
                    //    alertify.set('notifier', 'position', 'top-right');
                    //    alertify.notify('To date should not be less than From date', 'error');
                    //    return false;
                    //}
                }
                else {
                    output = "";
                    return output;
                }
            }
            return output;
        }
        function btnApplySearch() {
           
           //debugger;
            if ("<%= Session("FFilter")%>" == "") {
                FirstFilter = $('#unsavedquerytext').val();
            } else {
                //Nikhil Adkar
                //FirstFilter = FirstFilter;
                FirstFilter = "<%= Session("FFilter")%>";
                FirstFilter = FirstFilter.replace(/\'/g, "''");
                //Nikhl Adkar
            }
             var output = GenerateSearch();
            if (FirstFilter != "" && output.indexOf("'") > -1) {
                if (output.indexOf("''") > -1) {

                } else {
                    output = output.replace(/\'/g, "''");
                }
            }


            if (FirstFilter != "" && SecondFilter!="" && FirstFilter.indexOf("'") > -1) {
                if (FirstFilter.indexOf("''") > -1) {

                } else {
                    FirstFilter = FirstFilter.replace(/\'/g, "''");
                }
            }
            $("#secondfilter").val(output);
            $('#unsavedquerytext').val(FirstFilter);
            
            var selectedOpt = $("#btnSearchBy").text();
           // alert(output);
            //return;
            if (output == "" || output == undefined) {
                //Added By Usha Pandit On 17.06.2020 for multiple alerts coming at a time
                alertify.dismissAll();
                //End Of Added By Usha Pandit On 17.06.2020 for multiple alerts coming at a time
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Select / Enter search text.', 'error');
                return false;
            }

            //Added By dipali V On 8th Oct 2019 For Date Validation
            if ((selectedOpt.indexOf("Date") > -1) || selectedOpt.indexOf("Last Updated") > -1) {
                //
                var fromdate = new Date($("#searchby1").val());
                var Todate = new Date($("#searchby2").val());
                if (fromdate > Todate) {                    
                    alertify.set('notifier', 'position', 'top-right');
                    //Commented And Added By Usha Pandit On 17.06.2020 for alert disappearing soon
                    //alertify.notify('From Date should be less than To Date.', 'error');
                    setTimeout(function () {
                        alertify.dismissAll();
                        alertify.notify('From Date should be less than To Date.', 'error');
                    }, 3000);
                    //End Of Added By Usha Pandit On 17.06.2020 for alert disappearing soon
                    $("#searchby1").focus()
                    return false;

                }
            }
            //End of Added By dipali V On 8th Oct 2019 For Date Validation
          
            callSearch(output);

            //Added By Nikhil Adkar
            var viewtype = $('#cboAccessFilter').val();
            var pid = $("#projectid").val();
            getIssueList(pid, viewtype);
            //End of Added By Nikhil Adkar
        }
        function clearSearch() {
           // debugger;
            $("#btnSearchBy").text(' Select ');
            $("#btnSearchBy").html(' Select ' + " " + '<span class="caret"></span>')
            $('#txtSearchBy').val('');
            var selHTML = '<input readonly="readonly"  autocomplete="off" type="text" style="margin-left:3px;" placeholder="Select Search Option..." id="searchby1" class="form-control"/>';
            $("#searchby").html(selHTML);
             //Added By Dipali V on 28th Oct 2021 For Clear Session
            clearsession("SecondFilter");
            //$("#cboAccessFilter").val("A");
            //Commented By Dipali V On 10th Nov 2021
           // clearsession("ViewTypeFilter");

            //End of Added By Dipali V on 28th Oct 2021 For Clear Session
            SearchRecords = "0";//Added By Dipali V On 2nd Sep 2020 ForJDTIAC Upgarde
            
            callSearch('');
            $("#lnkClearSearch").css('FONT-WEIGHT', '');
            $("#lnkClearSearch").css('color', '#1f71cc');
            $("#lnkClearSearch").removeClass("ClearSencondfilter");
            //debugger;
           //Added By Nikhil Adkar
            //var viewtype = $('#cboAccessFilter').val();
            //var pid = $("#projectid").val();
            //getIssueList(pid, viewtype);
            //End of Added By Nikhil Adkar
               
        }

        function clearSearchOnClick() {
            // debugger;
            $("#btnSearchBy").text(' Select ');
            $("#btnSearchBy").html(' Select ' + " " + '<span class="caret"></span>')
            $('#txtSearchBy').val('');
            var selHTML = '<input readonly="readonly"  autocomplete="off" type="text" style="margin-left:3px;" placeholder="Select Search Option..." id="searchby1" class="form-control"/>';
            $("#searchby").html(selHTML);
            //Added By Dipali V on 28th Oct 2021 For Clear Session
            clearsession("SecondFilter");
            //$("#cboAccessFilter").val("A");
            //Commented By Dipali V On 10th Nov 2021
            // clearsession("ViewTypeFilter");

            //End of Added By Dipali V on 28th Oct 2021 For Clear Session
            SearchRecords = "0";//Added By Dipali V On 2nd Sep 2020 ForJDTIAC Upgarde

            callSearch('');
            $("#lnkClearSearch").css('FONT-WEIGHT', '');
            $("#lnkClearSearch").css('color', '#1f71cc');
            $("#lnkClearSearch").removeClass("ClearSencondfilter");
            //debugger;
            //Added By Nikhil Adkar
            var viewtype = $('#cboAccessFilter').val();
            var pid = $("#projectid").val();
            getIssueList(pid, viewtype);
            //End of Added By Nikhil Adkar

        }

        function clearsession(WhichFilter) {
            var strSessionResult = ajaxCall("IssueList.aspx/clearsession", "POST", "application/json;charset=utf-8", "json",
                JSON.stringify({WhichFilter:WhichFilter}));
           // debugger;
            
            if (strSessionResult.d == "1") {
                if (WhichFilter == "Load") {
                    $("#secondfilter").val('');
                    $("#searchoptiontext").val('');
                    $('#searchoptiontext').val('');
                    $("#cboAccessFilter").val("A");
                    $('#unsavedquerytext').val("");
                   
                    //If Filter Applied then Clear Button Highlight
                    $("#lnkClearSearch").css('color', 'rgb(19, 89, 166)');
                    $("#lnkClearSearch").css('font-weight', '900!important');
                    //End of If Filter Applied then Clear Button Highlight
                }
                else if (WhichFilter == "SecondFilter") {
                    SecondFilter = "";
                    $("#secondfilter").val('');
                    $("#searchoptiontext").val('');
                    $('#searchoptiontext').val('');
                    //If Filter Applied then Clear Button Highlight
                    $("#lnkClearSearch").css('color', 'rgb(19, 89, 166)');
                    $("#lnkClearSearch").css('font-weight', '900!important');
                    //End of If Filter Applied then Clear Button Highlight
                }
                else if (WhichFilter == "ViewTypeFilter") {
                     $("#cboAccessFilter").val("A");
                }

                else {
                     $('#unsavedquerytext').val("");
                }
            }
        }


        function callSearch(stext) {
           // $("#secondfilter").val('');
            //$("#hquery").val('');
            $('#searchoptiontext').val(stext);
            var pid = $("#projectid").val();
            //Commented and Added By Reshma on 29th oct 2021
            //var viewtype = $("#viewtype").val();
            var viewtype = $("#cboAccessFilter").val();
            //End of Commented and Added By Reshma on 29th oct 2021
            if ('<%= Request.QueryString("intPageNo")%>' != "") {
                intPageNo = '<%= Request.QueryString("intPageNo")%>';//Added By Dipali V On 2nd Sep 2020 ForJDTIAC Upgarde
            } else {
                intPageNo = 1;
            }
           // SearchRecords = "1";//Added By Dipali V On 2nd Sep 2020 ForJDTIAC Upgarde
          //Commnetd By Nikhil Adkar
            //getIssueList(pid, viewtype);
            //End Of COmmneted BY Nikhil Adkar
             //Added By  Dipali V On 2nd Sep 2020 For JDTIAC Upgarde
            Pagination();
        }

        function changefoB(count, val) {

            $("#fB" + count).val(val);
            var pid = $('#projectid').val();
            var strResult, data;
            var issueParameters = {
                ProjectID: pid,
                intEmployeeID: EmployeeID,
                LoginType: loginType,
                ControlName: val,
                count: count
            }
            data = JSON.stringify(issueParameters);
            strResult = AJAXCallWithResult("/api/Issue/GetFilterControl", data, false);
            var selHTML = "";
            if (strResult != undefined) {
                var type = strResult.Type;
                var cmbData = strResult.lstControlCombo;
                if (type == "C") {
                    selHTML += '<select class="form-control" id="foDfilterRowCount" name="namefilterRowCount">';
                    if (cmbData != undefined) {
                        for (var i = 0; i < cmbData.length; i++) {
                            var d = cmbData[i];
                            var key = d.Key.toUpperCase();
                            var value = d.Value;
                            selHTML += "<option title='" + value + "' value='" + key + "'>" + value + "</option>";
                        }
                    }
                    selHTML += "</select>";
                    $('#addrow').prop('disabled', false).css({ 'opacity': '1' });
                }
                else if (type == "D") {
                    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
                        "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
                    var d = new Date();
                    var dt = d.getDay() + " " + months[d.getMonth()] + " " + d.getFullYear();
                    selHTML += "<div style='padding-right:0px;'>";
                    selHTML += "<input type='text' readonly  class='form-control' id='foDfilterRowCount' value = '" + dt + "' placeholder='" + val + "'";
                    selHTML += " onfocus = '$(\"#foDfilterRowCount\").datepicker({autoclose: true,changeMonth: true,dateFormat: \"dd M yy\"}); $(\"#foDfilterRowCount\").datepicker(\"show\");'/>";
                    selHTML += "<i class='fa fa-calendar' onclick='$(\"#foDfilterRowCount\").datepicker({autoclose: true,changeMonth: true,dateFormat: \"dd M yy\"}); $(\"#foDfilterRowCount\").datepicker(\"show\");' style='top:-22px;position:relative;float:left;right:-180px;'></i>";
                    selHTML += "</div>";
                    $('#addrow').prop('disabled', false).css({ 'opacity': '1' });
                }
                else {
                    selHTML += '<input type="text" id="foDfilterRowCount" class="advncfiltertextfieldvalue form-control" name="foDfilterRowCount"/>';
                    $('#addrow').prop('disabled', true).css({ 'opacity': '0.5' });
                }
                selHTML = selHTML.replace(/filterRowCount/g, count);
            }
            $("#fvalue" + count).html(selHTML);
        }

        function IssueProjectDrop_OnChange(pid) {
            StartLoader("#bodyIssueList");
            intPageNo = 1;
            SearchRecords = "0";
           // debugger;
            //Added by imran 25-10-2021
            //TotalRecords = GetFilteredIssueCount(pid);
            // End by imran 25-10-2021
            
            // StopAjaxLoader("#bodyIssueList")
            //Added By dipali V on 3rd Oct 2019 For if project not selected then we can not take any action on filter 
            if (pid == 0) {
                if ($('#issuefilterpanel').hasClass('collapse')) {
                    $('#issuefilterpanel').removeClass('collapse');
                    $('#issuefilterpanel').addClass('collapse');
                    $('#btnAdvancedFilter').attr('aria-expanded', true);
                    // $('#issuefilterpanel').hide();
                    //  setTab(true);
                }
                else {
                    $('#issuefilterpanel').addClass('collapse');
                    $('#btnAdvancedFilter').attr('aria-expanded', false);
                    // $('#issuefilterpanel').show();
                }
            }
            //End of Added By dipali V on 3rd Oct 2019 For if project not selected then we can not take any action on filter 
            //debugger;
            if ($('#viewtype').val() == "")
                $('#viewtype').val("A");
            var viewtype = $('#viewtype').val();
            //alert(pid);
            IssueProjectOnchange = 1;
            $("#projectid").val(pid);
            //debugger;
            //added by dipali with Project Specific
            if (SelectedSetSessionProjectID != "") {
                if (pid != SelectedSetSessionProjectID) {
                    if (SecondFilter !== "") {
                        SecondFilter = "";
                    }

                    if (FirstFilter !== "") {
                        FirstFilter = "";
                    }
                } else {
                    if ("<%= Session("SFilter")%>" != "") {
                        SecondFilter = "<%= Session("SFilter")%>";
                    } else {
                         SecondFilter = $('#searchoptiontext').val();
                    }

                    if ("<%= Session("FFilter")%>" != "") {
                        FirstFilter = "<%= Session("FFilter")%>";
                    }else {
                         FirstFilter = $('#unsavedquerytext').val();
                    }

                    if ("<%= Session("SavedQueryName")%>" != "") {
                        SavedQueryName = "<%= Session("SavedQueryName")%>";
                    }else {

                    }
                }
            } else {
                if (SecondFilter == "") {
                    SecondFilter = $('#searchoptiontext').val();
                }
           
                if (FirstFilter == "") {
                    FirstFilter = $('#unsavedquerytext').val();
                }

            }
//End of 
            //Commented By Dipali V On 5th July 2023
            //if (SecondFilter == "") {
            //    SecondFilter = $('#searchoptiontext').val();
            //}
            ////else if (FirstFilter == "") {
            //if (FirstFilter == "") {
                
            //    FirstFilter = $('#unsavedquerytext').val();
            //}
            //End of Commented By Dipali V On 5th July 2023
            if (SecondFilter == "") {
               
                searchOption(0, "","");
            }
            //$("#searchby1").val('');
            //callSearch('');
            //btnApplySearch();
            m_PKToken = GenerateToken();
            CheckProjectOver(pid);
            GetRole(pid);
            var rid = $('#roleid').val();
            getFilterFieldList(pid, rid);
            getFilterFieldOperators();
            $("#fieldlist").val("");
            $("#orderby").val("");
            if (viewApplied != "") {
                $("#viewid").val(viewApplied);
                viewApplied = "";
            }
            else {
                $("#viewid").val("");
            }
            $("#queryid").val("");
            if (FirstFilter == "") {
                $('#unsavedquerytext').val("");
                $("#queryText").val("");
                $("#lblAppliedFilter").text("");
            }
             //
            // $("#lblAppliedFilter").text("");
           // $("#queryText").val("");
            if (SecondFilter == "") {
                clearBasicFilterOptions();
                clearAdvancedFilter();
            }
            clearBasicFilterOptions();
            clearAdvancedFilter();
            //Commented By Nikhil Adkar on 31-May-2023 for performance 
            //getBasicFilterOptions();
            //End of Commneted by Nikhil Adkar on 31-May-2023
           
            getDefaultFilter();
           
            getSavedFilters(0, pid);

            //getBasicFilterOptions();
            GetIsAgileMethodologyApplied();
            if (GetDefaultSavedFilterID == 0) {
                GenerateAdvancedFilterTable();
            }

            //Commented By Dipali V On 1st Nov 2021
           // if (SecondFilter == "" && FirstFilter == "") {
                //getIssueList(pid, viewtype);
            if (GetDefaultSavedFilterID == 0) {//15th Dec 2021
                GetIssueData();
            } else {
                //Commented By Nikhil Adkar for Performance optimization
               //getIssueList(pid, viewtype);
                //End of Commented By Nikhil Adkar
            }
            //}
            //End of Commented By Dipali V On 1st Nov 2021
            ///////////////////////////////------------------------------------////////////////
            
            if (SecondFilter == "") {
                SecondFilter = $('#searchoptiontext').val();
            } if (FirstFilter == "") {
                FirstFilter = $('#unsavedquerytext').val();
            }
            var qidnew = $('#queryid').val()
            qid = qidnew;
            // alert(qidnew);
            if (FirstFilter != "" && SecondFilter != "" && ViewTypeFilter != "") {
                if (FirstFilter.indexOf("''") > -1) {
                    //   FirstFilter = FirstFilter.replace(/\''/g, "'");
                } else {
                    FirstFilter = FirstFilter.replace(/\'/g, "''");
                }

                GetAppliedFilter();
                filterChange('', EmployeeID, qid, FirstFilter, SavedQueryName, "B", 'True');
                $("#divFilter").show();
                $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                var pid = $("#projectid").val();

                //Nikhil--1

                //Commented By Nikhil Adkar
                var viewtype = $('#cboAccessFilter').val();

                getIssueList(pid, viewtype);
                //End of Commnetd BY Nikhil Adkar
                $("#cboAccessFilter").val(ViewTypeFilter);
                // $("#lnkClearSearch").css('FONT-WEIGHT', '900');
                $("#lnkClearSearch").addClass("ClearSencondfilter");
            }
            else if (FirstFilter != "" && SecondFilter != "") {
                if (FirstFilter.indexOf("''") > -1) {
                    //   FirstFilter = FirstFilter.replace(/\''/g, "'");
                } else {
                    FirstFilter = FirstFilter.replace(/\'/g, "''");
                }

                GetAppliedFilter();
                filterChange('', EmployeeID, qid, FirstFilter, SavedQueryName, "B", 'True');
                $("#divFilter").show();
                $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                // $("#lnkClearSearch").css('FONT-WEIGHT', '900');
                $("#lnkClearSearch").addClass("ClearSencondfilter");

                var viewtype = $('#cboAccessFilter').val();
                var pid = $("#projectid").val();
                getIssueList(pid, viewtype);
            }
            //Added By Reshma Chavan on 29TH Oct 2021 for Filter Persist
            else if (FirstFilter != "" && ViewTypeFilter != "") {
                if (FirstFilter.indexOf("''") > -1) {
                    //   FirstFilter = FirstFilter.replace(/\''/g, "'");
                } else {
                    FirstFilter = FirstFilter.replace(/\'/g, "''");
                }

                GetAppliedFilter();
                var pid = $("#projectid").val();
                filterChange('', EmployeeID, qid, FirstFilter, SavedQueryName, "B", 'True');
                $("#divFilter").show();
                $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                var pid = $("#projectid").val();

                getIssueList(pid, ViewTypeFilter);
                $("#cboAccessFilter").val(ViewTypeFilter);
            }
            else if (SecondFilter != "" && ViewTypeFilter != '') {

                GetAppliedFilter();
                filterChange('', EmployeeID, 0, '', '', '');
                $("#divFilter").show();
                $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                var pid = $("#projectid").val();

                //Commented and Added By Nikhil Adkar
                getIssueList(pid, ViewTypeFilter);
                //End of Commented by Nikhil Adkar
                $("#cboAccessFilter").val(ViewTypeFilter);
                // $("#lnkClearSearch").css('FONT-WEIGHT', '900');
                $("#lnkClearSearch").addClass("ClearSencondfilter");
            }
            //End of Added By Reshma Chavan on 29TH Oct 2021 for Filter Persist
            else if (FirstFilter != "") {
                if (FirstFilter.indexOf("''") > -1) {
                    //   FirstFilter = FirstFilter.replace(/\''/g, "'");
                } else {
                    FirstFilter = FirstFilter.replace(/\'/g, "''");
                }
                GetAppliedFilter();
                filterChange('', EmployeeID, qidnew, FirstFilter, SavedQueryName, "B", 'True');
                $("#divFilter").show();
                $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                var pid = $("#projectid").val();

                getIssueList(pid, ViewTypeFilter);
            }
            else if (SecondFilter != "") {
                //Dipali V on 2021

                GetAppliedFilter();
                // $("#lnkClearSearch").css('FONT-WEIGHT', '900');
                $("#lnkClearSearch").addClass("ClearSencondfilter");
                var pid = $("#projectid").val();

                getIssueList(pid, ViewTypeFilter);
            }
            //Added By Reshma Chavan on 29th oct 2021 for Filter Persist 
            else if (ViewTypeFilter != "") {
                var pid = $("#projectid").val();
                GetAppliedFilter();
                getIssueList(pid, ViewTypeFilter);

                $("#cboAccessFilter option[value='" + ViewTypeFilter + "']").attr("selected", "selected");

            }
            else {
                GetAppliedFilter();
                var pid = $("#projectid").val();
                getIssueList(pid, ViewTypeFilter);
            }
            /////////////////////////////---------------------------------------/////////////////


            //Commented and added by Divya J on 18 sept 2025 for Filtered Issue Count for Pointwest
            //Added By Dipali V On 4th Sep 2020 For Show Total Issue Count
            $("#TotalRecords").html("");
            //$("#TotalRecords").html(GlobalIssueCount);
            $("#TotalRecords").html(TotalRecords);
            //Commented and added by Divya J on 18 sept 2025 for Filtered Issue Count for Pointwest
           //End of Added By Dipali V On 4th Sep 2020 For Show Total Issue Count
            getViewList(pid);

            if ($('#spnappliedfilter').html() == "") {
                $("#lblBasicFilterEdit").hide();

            }
            StopAjaxLoader("#bodyIssueList");
            //Added By yasmin on 24-9-19 for responsive table
            $("#issuelisttblmain").parent("div.col-sm-12").addClass("table-responsive");


        }


        function GetIssueData() {
           // debugger;
            var pid = $("#projectid").val();
            if (SecondFilter == "") {
                SecondFilter = $('#searchoptiontext').val();
            }
            if (FirstFilter == "") {
                FirstFilter = $('#unsavedquerytext').val();
            }
            //Added By Dipali V On 8th Nov 2021 For Onchange Of project get pervious Filter
            if (GlobalSelectedProject == $("#cboIssueProjects").val()) {
                if (GlobalQueryID != "" || GlobalQueryID != undefined) {//Added By Dipali V On 11th Nov 2021 For Check Filter Apply or not
                    qid = GlobalQueryID;
                    $("#queryid").val(qid);
                }

            } else {
                if (GetDefaultSavedFilterID != 0) {
                    qid = GetDefaultSavedFilterID;
                    $("#queryid").val(qid);
                }
                else {
                    if (QueryID != "") {
                        qid = QueryID;
                    }
                    else {
                        qid = "";
                        qname = "";
                        $("#queryid").val(0);
                    }
                }
            }
            //End of Added By Dipali V On 8th Nov 2021 For Onchange Of project get pervious Filter
            // else if (ViewTypeFilter == "") {
            //    ViewTypeFilter = $('#cboAccessFilter').val();
            //}

            //Dipali V On 28th Oct 2021 Filter Persist
            if (FirstFilter != "" && SecondFilter != "" && ViewTypeFilter != "") {
                if (FirstFilter.indexOf("''") > -1) {
                    //   FirstFilter = FirstFilter.replace(/\''/g, "'");
                } else {
                    FirstFilter = FirstFilter.replace(/\'/g, "''");
                }
               
                GetAppliedFilter();
                filterChange('', EmployeeID, qid, FirstFilter, SavedQueryName, "B", 'True');
                $("#divFilter").show();
                $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                var pid = $("#projectid").val();
                //Commented and Added By Nikhil Adkar
                //getIssueList(pid, ViewTypeFilter);
                //End Of Commented and Added By Nikhil Adkar
                $("#cboAccessFilter").val(ViewTypeFilter);
                // $("#lnkClearSearch").css('FONT-WEIGHT', '900');
                $("#lnkClearSearch").addClass("ClearSencondfilter");
            }
            else if (FirstFilter != "" && SecondFilter != "") {
                if (FirstFilter.indexOf("''") > -1) {
                    //   FirstFilter = FirstFilter.replace(/\''/g, "'");
                } else {
                    FirstFilter = FirstFilter.replace(/\'/g, "''");
                }
               
                GetAppliedFilter();
                filterChange('', EmployeeID, qid, FirstFilter, SavedQueryName, "B", 'True');
                $("#divFilter").show();
                $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                // $("#lnkClearSearch").css('FONT-WEIGHT', '900');
                $("#lnkClearSearch").addClass("ClearSencondfilter");
            }
            //Added By Reshma Chavan on 29TH Oct 2021 for Filter Persist
            else if (FirstFilter != "" && ViewTypeFilter != "") {
                if (FirstFilter.indexOf("''") > -1) {
                    //   FirstFilter = FirstFilter.replace(/\''/g, "'");
                } else {
                    FirstFilter = FirstFilter.replace(/\'/g, "''");
                }
                //Project Specific Filter
               
                GetAppliedFilter();

                //filterChange('',EmployeeID, qid, FirstFilter, SavedQueryName, "B", 'True');
                if (GlobalSelectedProject == $("#cboIssueProjects").val()) {
                      //Added By Dipali V on 22nd Nov 2021 For Display Filter Name
                    selectedFirstFilter = FirstFilter;
                      //End of Added By Dipali V on 22nd Nov 2021 For Display Filter Name
                    filterChange('', EmployeeID, qid, FirstFilter, SavedQueryName, "B", 'True');
                    $("#divFilter").show();
                    $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                      //Added By Dipali V on 22nd Nov 2021 For Display Filter Name
                    FirstFilter = selectedFirstFilter;
                      //End of Added By Dipali V on 22nd Nov 2021 For Display Filter Name
                } else {
                   
                }
                // $("#divFilter").show();
                //End of Project Specific
                //$("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                //debugger;
                //Commented by Nikhil Adkar
                //getIssueList(pid, ViewTypeFilter);
                //End of Commneted By Nikhil Adkar
                $("#cboAccessFilter").val(ViewTypeFilter);
                //Added By Dipali V On 10th Nov 2021 If filter applied then heighlight
                if (SelectedSetSessionProjectID != "") {
                    if (pid == SelectedSetSessionProjectID) {
                        if (FirstFilter != "") {
                            $("#divFilter").show();
                            $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                        } else {
                            $("#lblBasicFilterEdit").hide();
                            $("#divFilter").hide();
                            $("#btnAdvancedFilter").css({ "background": "NONE", "color": "#464a4c" });

                        }
                    }
                } else {
                    if (FirstFilter != "" && qid == "") {
                        $("#divFilter").show();
                        $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                    } else {
                        $("#lblBasicFilterEdit").hide();
                        $("#divFilter").hide();
                        $("#btnAdvancedFilter").css({ "background": "NONE", "color": "#464a4c" });

                    }
                }
                //End of Added By Dipali V On 10th Nov 2021 If filter applied then heighlight
            }
            else if (SecondFilter != "" && ViewTypeFilter != '') {
                GetAppliedFilter();
                filterChange('', EmployeeID, 0, '', '', '');
                var pid = $("#projectid").val();

                //getIssueList(pid, ViewTypeFilter);
                $("#cboAccessFilter").val(ViewTypeFilter);
                // $("#lnkClearSearch").css('FONT-WEIGHT', '900');
                $("#lnkClearSearch").addClass("ClearSencondfilter");
            }
            //End of Added By Reshma Chavan on 29TH Oct 2021 for Filter Persist
            else if (FirstFilter != "") {
                if (FirstFilter.indexOf("''") > -1) {
                    //   FirstFilter = FirstFilter.replace(/\''/g, "'");
                } else {
                    FirstFilter = FirstFilter.replace(/\'/g, "''");
                }
                if (GlobalSelectedProject == $("#cboIssueProjects").val()) {
                    filterChange('', EmployeeID, qid, FirstFilter, SavedQueryName, "B", 'True');
                    $("#divFilter").show();
                    $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                } else {
                    var viewtype = $('#cboAccessFilter').val();
                    //Commented bY nikhil adkar
                    //getIssueList(pid, viewtype);
                    //End of Commented nu Nikhil Adkar
                    getSavedFilters(0, pid);
                   // Pagination();
                    $("#lblBasicFilterEdit").hide();
                    $("#divFilter").hide();
                    $("#btnAdvancedFilter").css({ "background": "NONE", "color": "#464a4c" });

                }

            }
            else if (SecondFilter != "") {
                //Dipali V on 2021
                GetAppliedFilter();
                // $("#lnkClearSearch").css('FONT-WEIGHT', '900');
                $("#lnkClearSearch").addClass("ClearSencondfilter");
            }
            //Added By Reshma Chavan on 29th oct 2021 for Filter Persist 
            else if (ViewTypeFilter != "") {
                var pid = $("#projectid").val();
                
                //Commented and Added By Nikhi Adkar
                //getIssueList(pid, ViewTypeFilter);
                //End of Commented and Added By Nikhil Adkar
                $("#cboAccessFilter option[value='" + ViewTypeFilter + "']").attr("selected", "selected");

            }
            //End of Added By Reshma Chavan on 29th oct 2021 for Filter Persist 
            if (GlobalSelectedProject == $("#cboIssueProjects").val()) {
                if ($('#spnappliedfilter').html() == "") {
                    $("#lblBasicFilterEdit").hide();
                } else {
                    $("#lblBasicFilterEdit").show();
                }
            } else {
                if ($('#spnappliedfilter').html() == "") {
                    $("#lblBasicFilterEdit").hide();
                } else {
                    $("#lblBasicFilterEdit").show();
                }

            }
        }


        function GetIsAgileMethodologyApplied() {
            var pid = $('#projectid').val();
            var issueParameters = {
                projectID: pid,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/GetIsAgileMethodologyApplied", param, false);
            if (strResult == 0) {
                $("#IBfilterScrumRelease").closest(".col-sm-4").hide();
                $("#IBfilterScrumIteration").closest(".col-sm-4").hide();
                $("#IBfilterScrumUserStory").closest(".col-sm-4").hide();
            }
            else {
                $("#IBfilterScrumRelease").closest(".col-sm-4").show();
                $("#IBfilterScrumIteration").closest(".col-sm-4").show();
                $("#IBfilterScrumUserStory").closest(".col-sm-4").show();
            }

        }
        function GenerateToken() {

            var SelectedProjectID = $("#projectid").val();

            var strSessionResult = ajaxCall("IssueList.aspx/GeneratePK_Token", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ ProjectID: SelectedProjectID }));
            return (strSessionResult.d);

        }
        function btnSetDefaultView() {
            if ($("#cboIssueProjects").val() != 0) {
                var vid = $('#viewid').val();
                SetAsDefaultView(vid);
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Select Project.', 'error');
                return false;
            }

        }

        function getIssueListHeader(pID) {
            var vid = $("#viewid").val();
            if (vid == "") {
                vid = 0;
            }
            var issueParameters = {
                intEmployeeID: EmployeeID,
                projectID: pID,
                LoginType: loginType,
                ViewID: vid,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/GetIssueHeader", param, false);
            if (strResult != undefined) {
                $("#viewApplied").val(strResult.ViewName);
                //Added by yasmin on 24-9-19 for tooltip of view name
                $('[data-bs-toggle="tooltip"]').tooltip();
                $("#viewApplied").attr("title", "");
                $("#viewApplied").attr("title", strResult.ViewName);
                $("#viewApplied").attr('data-bs-toggle', 'tooltip');
                $("#viewApplied").attr('data-bs-placement', 'bottom');
                $("#viewApplied").attr('readonly', true);
                $("#viewid").val(strResult.ViewId);                
                $("#fieldlist").val(strResult.FieldList);
                //Added By Dipali V On 22nd Dec 2021 For Custom Fields For Sorting
                var OrderBy = strResult.OrderBy;
                if (OrderBy != null) {
                    if (OrderBy.indexOf("$") > -1) {
                        OrderBy = OrderBy.replace("$", "");
                    } else {
                        OrderBy = strResult.OrderBy;
                    }
                }
                else {
                    OrderBy = strResult.OrderBy;
                }
                //End of Added By Dipali V On 22nd Dec 2021 For Custom Fields For Sorting
                $("#orderby").val(OrderBy);
                plotHeaderSection(strResult.UserFriendlyNameList);
                $("#issuelisttblmain").parent("div.col-sm-12").addClass("table-responsive");
            }
        }
        function plotHeaderSection(fieldList) {
            $("#issueHeader").html("");
            var htmlString = "";
            htmlString += '<tr>';
            htmlString += '     <th>';
            htmlString += '         <div class="custom_chckbox">';
            htmlString += '         <input type="checkbox" onclick="chkCheckUncheckAllIssues(this)" id="chkIssueListAll"/>';
            htmlString += '         <label for="chkIssueListAll"></label>';
            htmlString += '         </div>';
            htmlString += '     </th>';
            if (fieldList != null) {
                fieldList = "HID," + fieldList + ", Last Updated";
                var headerList = fieldList.split(',');
                 SelectedHeader = fieldList;//Added By Dipali V On 1st Sep JDTIAC Upgarde
                for (var i = 0; i < headerList.length; i++) {
                    if (i == 0) {
                        htmlString += '<th style="display:none">' + headerList[i] + '</th>';
                    }
                    else {
                        htmlString += '<th>' + headerList[i] + '</th>';
                    }
                }
            }
            htmlString += '    <th><a href="#" data-bs-toggle="tooltip" data-placement="top" title="History"  data-container="body"><i class="fa fa-history"></i></a></th>';
            htmlString += '    <th><a href="#" data-bs-toggle="tooltip" data-placement="top" title="Flag to"  data-container="body"><i class="far fa-flag"></i></a></th>';
            htmlString += '    <th><a href="#" data-bs-toggle="tooltip" data-placement="top" title="Comments"  data-container="body"><i class="far fa-comments"></i></a></th>';
            htmlString += '    <th><a href="#" data-bs-toggle="tooltip" data-placement="top" title="Attachments"  data-container="body"><i class="fas fa-paperclip"></i></a></th>';
            htmlString += '    <th><a href="#" data-bs-toggle="tooltip" data-placement="top" title="Edit"  data-container="body"><i class="far fa-edit"></i></a></th>';
            htmlString += '</tr>'
            $("#issueHeader").html(htmlString);
        }
        var SessionIssueSQL = "";
        var SessionDisplayMode = "";
        //Commented and Added By Reshma Chavan on 25th Oct 2021 For Export Report Change
        //function getIssueListBody(pID, sview) {
        function getIssueListBody(pID, sview, IsExport) {
          //  debugger;
            if (IsExport == undefined) {                
                IsExport = 0;
            }

            //End of Commented and Added By Reshma Chavan on 25th Oct 2021 For Export Report Change
            if (sview == undefined) {
                sview = "A";
            }
            var qid = $("#queryid").val();
           // debugger;
            //Added By Dipali V On 3rd Dec 2021 For Set Applied Filter
            if (SelectedSetSessionProjectID != "") {
                GlobalSelectedProject = SelectedSetSessionProjectID;
            }
            //End of Added By Dipali V On 3rd Dec 2021 For Set Applied Filter
            
            if (GlobalSelectedProject == $("#cboIssueProjects").val()) {

                if (SecondFilter == "") {
                    var stext = $('#searchoptiontext').val();
                } else {
                    stext = SecondFilter;
                }
                //Added By Reshma Chavan on 2nd Nov 2021 getting Crash
                if (stext.indexOf("''") > -1) {

                } else {
                    stext = stext.replace(/\'/g, "''");
                }
                //End of Added By Reshma Chavan on 2nd Nov 2021 getting Crash
                //Added By Dipali V On 3rd Dec 2021 For Set Applied Filter
                if (FirstFilter == "") {
                    var qtext = $('#unsavedquerytext').val();
                } else {
                    qtext = FirstFilter;
                   
                }//End of Added By Dipali V On 3rd Dec 2021 For Set Applied Filter

                if (qtext.indexOf("''") > -1) {

                } else {
                    qtext = qtext.replace(/\'/g, "''");
                    //Added By Dipali V On 3rd Dec 2021 For Set Applied Filter
                    $('#unsavedquerytext').val(qtext);
                    //End of Added By Dipali V On 3rd Dec 2021 For Set Applied Filter
                }


            } else {
               // stext = "";
               // qtext = "";

                if ($('#searchoptiontext').val() != "") {
                    stext = $('#searchoptiontext').val();
                } else {
                    stext = "";
                }
               
                if (stext.indexOf("''") > -1)
                {

                } else {
                    stext = stext.replace(/\'/g, "''");
                }

                if ($('#unsavedquerytext').val() != "") {
                    qtext = $('#unsavedquerytext').val();
                } else {
                    qtext = "";
                }

                if (qtext.indexOf("''") > -1)
                {

                } else {
                    qtext = qtext.replace(/\'/g, "''");
                }

            }
           
            //var qtext = $('#unsavedquerytext').val();
            var flist = $("#fieldlist").val();
           
            var forder = $('#orderby').val();           
            if (qid == "") {
                qid = 0;
            }

            if (forder == "") {
                forder = 'CreatedDate'
            }            

            var issueParameters = {
                intEmployeeID: EmployeeID,
                projectID: pID,
                LoginType: loginType,
                FieldList: flist,
                DisplayMode: sview,
                UserName: UserName,
                QueryID: qid,
                QueryText: qtext,
                SearchText: stext,
                OrderBy: forder,
                pagsize: 100,
                pageNumber:intPageNo,
                IsExport:IsExport,  //Added By Reshma Chavan on 25th Oct 2021 For Export Report Change
                RoleId: RoleId    //Added by Divya j on 18 Sept 2025 for updating Filtered issue count for Pointwest
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/GetIssueData", param, false);
            //
            //var strResult1 = strResult.split("_&&_")[0];
            //var strResult2 = strResult.split("_&&_")[1];
            if (strResult != undefined) {

          <%--<%= Session("IssueSQL") = "'+ strResult2 +'"%>--%>
                //SessionIssueSQL = strResult2;
                //SessionDisplayMode = sview;

                //replace(/filterRowCount/g, counter);
                var obj = strResult.issuedata;
                var strResult2 = strResult.strselect;
                SessionIssueSQL = strResult2;

                if (IsExport == 0) {  //Added By Reshma Chavan on 25th oct 2021 For Export Report Change
                    SessionDisplayMode = sview;
                    //var obj = JSON.parse(strResult1);
                    plotIssueBody(obj, flist);
                    //GetFilteredIssueCount

                //Added by imran 26-10-2021
                var TotalRec = GetFilteredIssueCount(pID);
                $("#TotalRecords").html(TotalRec);
                //End Comment by imran 26-102021
                Pagination();
                $("#issuelisttblmain").parent("div.col-sm-12").addClass("table-responsive");

              
                }
            }
           
            ////Added By Reshma Chavan on 8th Nov 2021
            var sviewType = "";
            //$("#cboAccessFilter").val(sview);
            if (sview == "M") {
                sviewType = "My Issues"
            }         
            else if (sview == "S") {
                sviewType = "Reported By Me"
            }
            else if (sview == "F") {
                sviewType = "Flagged issues"
            }
            else {
                sviewType = "All Issues"
            }
           // $('#AccessFilter *[title]').tooltip('disable');
           <%-- if (sviewType != "") {
                if ('<%= Request.QueryString("IsBack")%>' == "") {
                    $("#AccessFilter").attr("data-bs-toggle", "tooltip");
                    $("#AccessFilter").attr("title", "");
                    $("#cboAccessFilter").attr("title", "");
                    $("#AccessFilter").attr("title", sviewType);
                }
            }
            $('#AccessFilter > div > #cboAccessFilter').hover(function () {
                $('data-bs-toggle= tooltip ').tooltip('hide');
            });--%>
            $("#AccessFilter > div > button > span.filter-option.pull-left").text(sviewType);
            //End of Added By reshma Chavan on 8th Nov 2021 
        }


        function plotIssueBody(issueList, flist) {
            //
            issueIdList = "";
            flist = "IssueId," + flist;
            var fields = flist.split(',');
            $("#issueBody").html("");
            var htmlIssueBody = "";
            var IsData = 0;//Added By Dipali V On 3rd Sep 2020 For JDTIAC Upgarde & Pagination Change
            if (issueList != undefined || issueList != null) {
                for (var row = 0; row < issueList.length; row++) {
                    IsData = 1;//Added By Dipali V On 3rd Sep 2020 For JDTIAC Upgarde & Pagination Change
                    htmlIssueBody += '<tr>';
                    var issue = issueList[row];
                    htmlIssueBody += '     <td>';
                    htmlIssueBody += '         <div class="custom_chckbox">';
                    htmlIssueBody += '             <input type="checkbox" class="chkIssueItem" id="chkissuelist' + row.toString() + '" onclick="Selectall(this)"/>';
                    htmlIssueBody += '             <label for="chkissuelist' + row.toString() + '"></label>';
                    htmlIssueBody += '         </div>';
                    htmlIssueBody += '     </td>';
                    if (!Object.entries) {
                        Object.entries = function (obj) {
                            var ownProps = Object.keys(obj),
                                i = ownProps.length,
                                resArray = new Array(i); // preallocate the Array
                            while (i--)
                                resArray[i] = [ownProps[i], obj[ownProps[i]]];
                            return resArray;
                        };
                    }
                    var arriss = Object.entries(issue);
                    var cols = arriss.length;
                    for (var col = 0; col < arriss.length; col++) {
                        var cellval = arriss[col][1];
                        if (cellval == null) {
                            cellval = "";

                        }
                        if (cellval == "null") {
                            cellval = "";

                        }

                        if (col == 0) {
                            htmlIssueBody += '<td style="display:none">';
                            htmlIssueBody += '<input type="text" id="hid' + row.toString() + '" value="' + cellval + '"/>';
                            htmlIssueBody += '<input type="text" id="hSummary' + cellval + '" value="' + issue.Col3 + '"/>';
                            htmlIssueBody += '</td>';
                        }
                        else if (col == 1) {
                            htmlIssueBody += '     <td><a href="#" onclick="IssueID_OnClick(' + issue.Col0 + ');" data-bs-toggle="tooltip" data-placement="top" title="Edit">' + cellval + '</a></td>';
                        }
                        else if (col == cols - 1) {
                            if (cellval > 0) {
                                htmlIssueBody += '     <td><a href="#" onclick="IssueID_OnClick(' + issue.Col0 + ',\'tab_3\');" data-bs-toggle="tooltip" data-placement="top" title="Attachments"><span class="badge badge-light">' + cellval + '</span><i class="fas fa-paperclip"></i></a></td>';
                            }
                            else {
                                htmlIssueBody += '     <td><a href="#" onclick="IssueID_OnClick(' + issue.Col0 + ',\'tab_3\');" data-bs-toggle="tooltip" data-placement="top" title="Attachments"><i class="fas fa-paperclip"></i></a></td>';
                            }
                        }
                        else if (col == cols - 2) {
                            if (cellval > 0) {
                                htmlIssueBody += '     <td><a href="#" onclick="IssueID_OnClick(' + issue.Col0 + ',\'tab_1\');" data-bs-toggle="tooltip" data-placement="top" title="Discussion"><span class="badge badge-light">' + cellval + '</span><i class="far fa-comments"></i></a></td>';
                            }
                            else {
                                htmlIssueBody += '     <td><a href="#" onclick="IssueID_OnClick(' + issue.Col0 + ',\'tab_1\');" data-bs-toggle="tooltip" data-placement="top" title="Discussion"><i class="far fa-comments"></i></a></td>';
                            }
                        }
                        else if (col == cols - 3) {                           
                            if ("<%= Session("LoginType").ToString() %>" == 'E') { //Added By Usha Pandit On 06.05.2021 For Flag access to customer
                                if (cellval == "G") {
                                    htmlIssueBody += '     <td><a href="#" data-bs-toggle="tooltip" onclick=ShowTrackingDetails(' + issue.Col0 + ') data-placement="top" title="Flag to"><i class="fas fa-flag flag-success"></i></a></td>';
                                }
                                else if (cellval == "L") {

                                    htmlIssueBody += '     <td><a href="#" data-bs-toggle="tooltip" onclick=ShowTrackingDetails(' + issue.Col0 + ') data-placement="top" title="Flag to"><i class="far fa-flag flagred"></i></a></td>';
                                }
                                else if (cellval == "S") {
                                    htmlIssueBody += '     <td><a href="#" data-bs-toggle="tooltip" onclick=ShowTrackingDetails(' + issue.Col0 + ') data-placement="top" title="Flag to"><i class="far fa-flag flagorange"></i></a></td>';
                                }
                                else if (cellval == "B") {
                                    htmlIssueBody += '     <td><a href="#" data-bs-toggle="tooltip" onclick=ShowTrackingDetails(' + issue.Col0 + ') data-placement="top" title="Flag to"><i class="fa fa-flag"></i></a></td>';
                                }
                                else {
                                    htmlIssueBody += '     <td><a href="#" data-bs-toggle="tooltip" onclick=ShowTrackingDetails(' + issue.Col0 + ') data-placement="top" title="Flag to"><i class="far fa-flag"></i></a></td>';
                                }

                            }
                            //Added By Usha Pandit On 06.05.2021 For Flag access to customer
                            else {
                                if (cellval == "G") {
                                    htmlIssueBody += '     <td><a data-bs-toggle="tooltip" data-placement="top" title="Flag to"><i class="fas fa-flag flag-success"></i></a></td>';
                                }
                                else if (cellval == "L") {

                                    htmlIssueBody += '     <td><a data-bs-toggle="tooltip" data-placement="top" title="Flag to"><i class="far fa-flag flagred"></i></a></td>';
                                }
                                else if (cellval == "S") {
                                    htmlIssueBody += '     <td><a data-bs-toggle="tooltip" data-placement="top" title="Flag to"><i class="far fa-flag flagorange"></i></a></td>';
                                }
                                else if (cellval == "B") {
                                    htmlIssueBody += '     <td><a data-bs-toggle="tooltip" data-placement="top" title="Flag to"><i class="fa fa-flag"></i></a></td>';
                                }
                                else {
                                    htmlIssueBody += '     <td><a data-bs-toggle="tooltip" data-placement="top" title="Flag to"><i class="far fa-flag"></i></a></td>';
                                }
                            }
                            //Added By Usha Pandit On 06.05.2021 For Flag access to customer
                        }
                        else if (col == cols - 4) {
                            htmlIssueBody += '     <td><a href="#" onclick="IssueID_OnClick(' + issue.Col0 + ',\'tab_2\');" data-bs-toggle="tooltip" data-placement="top" title="History"><i class="fa fa-history"></i></a></td>';
                        }
                        else {
                            if (fields[col] == "Summary" || fields[col] == "Description") {
                                //
                                if (cellval.length > textlength1) {
                                    var cellvaldis = cellval.substr(0, textlength1 - 3) + "...";
                                    //Added By Dipali V On 3rd Sep 2019 For Tool Tip Issue
                                    //htmlIssueBody += '<td data-bs-toggle="tooltip" title="' + cellval +'" >' + cellvaldis + '</td>';
                                    htmlIssueBody += '<td data-bs-toggle="tooltip" title="' + cellval + '" data-container="body" data-placement="auto top">' + cellvaldis + '</td>';
                                    //End of Added By Dipali V On 3rd Sep 2019 For Tool Tip Issue
                                }
                                else {
                                    //Added By Rutuja D. on 20 March 2020 For Tool Tip Issue issueid = 23176

                                    //  htmlIssueBody += '     <td>' + cellval + '</td>';
                                    htmlIssueBody += '     <td data-bs-toggle="tooltip" title="' + cellval + '" data-container="body" data-placement="auto top">' + cellval + '</td>';
                                    //End Added By Rutuja D. on 20 March 2020 For Tool Tip Issue issueid = 23176
                                }
                            }
                            else if (fields[col] == "ProjectName") {
                                if (cellval.length > textlength2) {
                                    var cellvaldis = cellval.substr(0, textlength2 - 3) + "...";
                                    htmlIssueBody += '     <td title="' + cellval + '">' + cellvaldis + '</td>';
                                }
                                else {
                                    htmlIssueBody += '     <td>' + cellval + '</td>';
                                }
                            }
                            else {
                                //For Genric Commented & Added By Dipali v n 25th Sep 2019 
                                //cellval = (cellval == "" ? "&#x3;not specified&#x3E;" : cellval);
                                cellval = (cellval == "" || cellval == "0" ? "Not Specified" : cellval);
                                //End of For Genric Commented & Added By Dipali v n 25th Sep 2019 
                                htmlIssueBody += '     <td>' + cellval + '</td>';
                            }
                        }
                    }
                    htmlIssueBody += '     <td><a href="#" onclick="IssueID_OnClick(' + issue.Col0 + ');" data-bs-toggle="tooltip" data-placement="top" title="Edit"><i class="far fa-edit"></i></a></td>';
                    htmlIssueBody += '</tr>';
                    issueIdList += issue.Col0 + "|";
                }
                //Added By Dipali V On 3rd Sep 2020 For JDTIAC Upgarde & Pagination Change
                if (IsData != "1") {
                   
                    htmlIssueBody = "<tr><td colspan='" + SelectedHeader.length + "'>No data available in table</td></tr>"
                }
                //End of Added By Dipali V On 3rd Sep 2020 For JDTIAC Upgarde & Pagination Change
                $("#issueBody").html(htmlIssueBody);
            }
            $('[data-bs-toggle="tooltip"]').tooltip();
        }

        //added By dipali V On 9th oct 2019 For Select all check issue
        function Selectall(obj) {
            $('#issueBody input[type="checkbox"]').each(function () {
                //
                if ($(this).prop("checked") == true) {
                    $("#chkIssueListAll").prop("checked", true);
                }
                else {
                    $("#chkIssueListAll").prop("checked", false);
                    return false;
                }
            });

        }

        //End of added By dipali V On 9th oct 2019 For Select all check issue



        function getViewList(pID) {
            var issueParameters = {
                intEmployeeID: EmployeeID,
                projectID: pID,
                LoginType: loginType
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/GetViewList", param, false);
            if (strResult != undefined) {
                plotViewList(strResult);
            }
        }
        function ApplyView(viewid) {
            $('#viewapplied').modal('hide');
            $('#viewid').val(viewid);
            var pid = $("#projectid").val();
            var viewtype = $('#cboAccessFilter').val();
            //Added by imran 26-10-2021 For page comes to First
	            intPageNo = 1;
            //End by imran 26-10-2021
           
            getViewList(pid);
             //Commented By Dipali V  On 19th Nov 2021 For Get Order Wise
            //Uncommented By Dipali V On 6th July 2023 For View Apply
            //commented By Nikhil Adkar
           
            getIssueList(pid, viewtype);
               //commented By Nikhil Adkar 
            //End of Commented By Dipali V  On 19th Nov 2021 For Get Order Wise
          //End of Uncommented By Dipali V On 6th July 2023 For View Apply

        }
        function SetAsDefaultView(viewid) {
            //alert(viewid);
            var pid = $("#projectid").val();
            var issueParameters = {
                intEmployeeID: EmployeeID,
                projectID: pid,
                LoginType: loginType,
                ViewID: viewid,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/SetAsDefaultView", param, false);
            if (strResult != undefined) {
                if (strResult == "Success") {
                    alertify.set('notifier', 'position', 'top-right');
                    //Commented And Added By Usha Pandit On 16.03.2020 for rephrasing the alert
                    //alertify.notify('Successfully set the view as default!', 'success');
                    setTimeout(function () {
                        alertify.set('notifier', 'position', 'top-right');
                        //Commented & Added By Dipali V on 18th Feb 2021 For Alert Change issues
                        //alertify.notify('View Is Successfully Set As Default!', 'success');
                        //Commented and added by Chetan M on 21 June 2021 for alert issue
                        //alertify.notify('Corporate view default set successfully', 'success');
                        //End of Commented & Added By Dipali V on 18th Feb 2021 For Alert Change issues
                        if (viewid == 0) {
                            alertify.notify('Corporate view default set successfully', 'success');                            
                        }
                        else {
                            alertify.notify('View Is Successfully Set As Default!', 'success');
                        }
                        //End of Commented and added by Chetan M on 21 June 2021 for alert issue
                        
                    }, 3000);
                    
                    //End Of Added By Usha Pandit On 16.03.2020 for rephrasing the alert
                    //getDefaultFilter();
                    getViewList(pid);
                    //Commented & Added By Dipali V On 8th Nov 2021 For Filter Should Persist
                    //var viewtype = $('#viewtype').val();
                    //alert(viewtype);
                    var viewtype = $('#cboAccessFilter').val();
                    GetIssueData();
                    //Commented By Nikhil Adkar
                    //getIssueList(pid, viewtype);
                    //End of COmmented bY Nikhil Adkar
                     //End of Commented & Added By Dipali V On 8th Nov 2021 For Filter Should Persist
                    $("#issuelisttblmain").parent("div.col-sm-12").addClass("table-responsive");
                }
            }
        }
        function plotViewList(viewList) {
            $("#viewlist").html("");
            var htmlviewListBody = "";
            var vid = $('#viewid').val();
            var FiledName = "";
            for (var row = 0; row < viewList.length; row++) {
                htmlviewListBody += '<tr>';
                var v = viewList[row];
                if (v.Fields.indexOf("Iteration") > -1) {
                    FiledName = v.Fields.replace("Iteration", "Sprint");
                }
                else {
                    FiledName = v.Fields;
                }

                if (v.ViewType == "My Views") {
                    htmlviewListBody += '<td><a href="#" data-bs-toggle="modal" data-bs-target="#issueviewdetails" data-bs-dismiss="modal" onclick="getViewFieldLists(' + v.ViewId + ', \'' + v.ViewName + '\')">' + v.ViewName + '</a></td>';
                }
                else {
                    htmlviewListBody += '<td>' + v.ViewName + '</td>';
                }
                htmlviewListBody += '<td>' + v.CreatedDate + '</td>';
                htmlviewListBody += '<td>' + v.CreatedBy + '</td>';
                //htmlviewListBody += '<td>' + v.Fields.replace(/,/g, ", ") + '</td>';
                htmlviewListBody += '<td>' + FiledName.replace(/,/g, ", ") + '</td>';

                htmlviewListBody += '<td>' + v.SortBy.replace(/,/g, ", ") + '</td>';
                if (v.ViewId == v.DefaultViewId) {
                    htmlviewListBody += '<td class="text-success">Set as Default</td>';
                }
                else {
                    htmlviewListBody += '<td onclick=SetAsDefaultView(' + v.ViewId + ')><a href="#">Set as Default</a></td>';
                }
                htmlviewListBody += '<td onclick=ApplyView(' + v.ViewId + ')><a href="#">Apply</a></td>';
                htmlviewListBody += '     <td>';
                htmlviewListBody += '         <div class="custom_chckbox">';
                if (v.ViewType == "My Views") {
                    htmlviewListBody += '             <input type="checkbox" class="chkViewItem" id="chkviewlist' + v.ViewId.toString() + '"/>';
                }
                else {
                    htmlviewListBody += '             <input type="checkbox" class="chkViewItemRO" id="chkviewlist' + v.ViewId.toString() + ' readonly"/>';
                }
                htmlviewListBody += '             <label for="chkviewlist' + v.ViewId.toString() + '"></label>';
                htmlviewListBody += '         </div>';
                htmlviewListBody += '         <div id="hvid" style="visibility:hidden">' + v.ViewId.toString() + '</div>';
                htmlviewListBody += '     </td>';
                htmlviewListBody += '</tr>';

            }
            $("#viewlist").html(htmlviewListBody);
        }

        function chkCheckUncheckAllViews(flag) {
            $(".chkViewItem").prop('checked', flag);
        }
        function btnDeleteView() {
            var sel = $('.chkViewItem:checked').map(function () {
                return this.id.replace('chkviewlist', '');
            }).get().join(',');
            if (sel == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select view(s) for deletion!', 'error');
                return false;
            }
            $('#deletetype').val('V');
            $('#deleteid').val(sel);
            $('#deleteConfirmMsg').html("Are you sure to delete selected view(s)?");
            $('#deleteConfirmAlert').modal('show');
        }
        function DeleteView() {
            var pid = $("#projectid").val();
            var viewtype = $('#viewtype').val();
            var currentView = $('#viewid').val();
            var isAppliedView = false;
            var sel = $('.chkViewItem:checked').map(function () {
                var row = this.id.replace('chkviewlist', '');
                if (row == currentView) isAppliedView = true;
                return row;
            }).get().join(',');
            var issueParameters = {
                ViewList: sel,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/DeleteProjectView", param, false);
            if (strResult != undefined && strResult == "Success") {
			//Added By Dipali V On  4th Jun 2020 For Alert missing

                  setTimeout(function () {
                     alertify.set('notifier', 'position', 'top-right');
                     alertify.notify('View Deleted Successfully', 'success');
                }, 1000);
              
                //End of Added By Dipali V On  4th Jun 2020 For Alert missing
                getViewList(pid);
                if (isAppliedView == true) {
                    $('viewid').val(0);
                    //Commented By Nikhil Adkar
                    //getIssueList(pid, viewtype);
                    //End of Commnetd BY Nikhil Adkar
                }
            }
        }

        function getViewFieldLists(vid, vname) {

            StartLoader("#bodyIssueList");

            //Added By Dipali V On 16th April 2020 For hide tooltip
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });
           //End of Added By Dipali V On 16th April 2020 For hide tooltip
            var pid = $("#projectid").val();
            var rid = $('#roleid').val();
            // 
            //Added & commnetd by dipali V On 25th Sep 2019 For View name with multiple Project Group
            ///  $('#viewName').val(vname);
            if (vname != undefined) {
                //Commend Added by Swapnagandha K. For Issue - View Name Is not displaying Complete on 18 Oct 2019 
                //if (vname.indexOf("(") != -1) {
                //    varstrviewName = vname.split("(")
                //    $('#viewName').val(varstrviewName[0]);
                // } else {

                $('#viewName').val(vname);

                // }
                //Commend Added by Swapnagandha K. For Issue - View Name Is not displaying Complete on 18 Oct 2019 
            }
            else {
                //Added by Nikhil A on 15_nov-2019 for clearing the view name field while adding View
                $('#viewName').val('');
                // End of added by Nikhil A on 15_nov-2019 for clearing the view name field while adding View
            }
            //End of Added & commnetd by dipali V On 25th Sep 2019 For View name with multiple Project Group
            if (vid != 0) { $('#detailViewId').val(vid); }
            else { $('#detailViewId').val(""); }
            getViewFieldList('multiselect1', pid, vid, 'D', 0, rid);
            getViewFieldList('multiselect1_to', pid, vid, 'D', 1, rid);
            getViewFieldList('multiselect2', pid, vid, 'S', 0, rid);
            getViewFieldList('multiselect2_to', pid, vid, 'S', 1, rid);
            StopAjaxLoader("#bodyIssueList");
        }
        function getViewFieldList(lid, pid, vid, listType, isAccessible, roleId) {
            var issueParameters = {
                ProjectId: pid,
                intEmployeeID: EmployeeID,
                strLoginID: LoginID,
                LoginType: loginType,
                ViewID: vid,
                ListType: listType,
                IsAccessible: isAccessible,
                RoleId: roleId
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/GetProjectView_FieldList", param, false);
            if (strResult != undefined) {

                var selHTML = "";
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var FieldID = d.FieldID;
                    var FieldName = d.FieldName;
                    //Commented And Added By Usha Pandit On 01.07.2020 For crash due to single quote issue
                    //selHTML += "<option title='" + FieldName + "' value='" + FieldID + "'>" + FieldName + "</option>";                     
                    var strFieldID = FieldID.toString().replace(/\'/g, "@@");                   
                    selHTML += "<option title='" + FieldName + "' value='" + strFieldID + "'>" + FieldName + "</option>";                   
                    //End Of Added By Usha Pandit On 01.07.2020 For crash due to single quote issue
                }
                $("#" + lid).html(selHTML);
                
            }
        }
        //Added By Dipali V On 25th Sep for Sepcial Cha Resctirction
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
        //End of Added By Dipali V On 25th Sep for Sepcial Cha Resctirction
        function SaveView_OnCLick() {
            var vname = $('#viewName').val().toString().trim();
            if (vname == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please specify View Name.', 'error');
                $('#viewName').focus();
                return false;
            }
            //Added By Dipali V On 25th Sep for Sepcial Cha Resctirction
            if (vname != "") {
                var varstrviewName = vname.split("(");
                vname = varstrviewName[0];
                //if (checkSpecialCharacter($('#viewName').val()) == true) {
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify('View Name cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                //    $('#viewName').focus();
                //    return false;
                //}
            }
            //End of Added By Dipali V On 25th Sep for Sepcial Cha Resctirction
            var vid = $('#detailViewId').val();
            var pid = $('#projectid').val();
            // 
            var isDuplicate = FindDuplicateView(vname, vid);
            if (isDuplicate == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('View Name already exist. Please specify different name.', 'error');
                $('#viewName').focus();
                return false;
            }
            //Added by Chetan M on 21th Jully 2020 for Issue ID = 24219
            //Commented and Added by Chetan M on 21th Jully 2020 for Issue ID = 24219
            //if (vname.length >= 100) {
            if (vname.length > 100) {
                //End of Commente and Added by Chetan M on 21th Jully 2020 for Issue ID = 24219
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('View Name should be less than 100 characters.', 'error');
                $('#viewName').focus();
                return false;
            }
            //End of Added by Chetan M on 21th Jully 2020 for Issue ID = 24219
            var selFields = [];
            $.each($("#multiselect1_to option"), function () {                
                //Commented And Added By Usha Pandit On 01.07.2020 For crash due to single quote issue
                //selFields.push($(this).val());
                var curFieldVal = $(this).val();
                curFieldVal = curFieldVal.toString().replace(/\@@/g, "''");                
                selFields.push(curFieldVal);
                //End Of Added By Usha Pandit On 01.07.2020 For crash due to single quote issue
            });
            if (selFields.length == 0) {
                alertify.set('notifier', 'position', 'top-right');
                //alertify.notify('Please select at least one field to be diplayed in the view.', 'error');
                alertify.notify('Please select at least one field to be displayed in the view.', 'error');
                return false;
            }
            var selFieldList = selFields.join(",");
            var selSorts = [];
            $.each($("#multiselect2_to option"), function () {
                //debugger;
                var valtextvalues = "";
                var valtextorderNew = "";
                var val = $(this).val();
                var valtext = $(this).text().trim();
                if (valtext.indexOf(" DESC") > -1) {
                    valtextNew = valtext.split("DESC");
                    valtextorderNew = "DESC";
                } else {
                   // valtext = valtext.split(" ").join("");

                }

                if (valtext.indexOf(" ASC") > -1) {
                    valtextNew = valtext.split("ASC");
                    valtextorderNew = "ASC";
                } else {
                   // valtext = valtext.split(" ").join("");

                }



                if (valtextNew[0] != "") {
                    var valtextvalues = valtextNew[0].split(" ").join("");
                } else {
                    var valtextvalues = valtext.split(" ").join("");
                }

                var textvalue = valtextvalues + " " + valtextorderNew;

                if (textvalue != val) {
                    val = textvalue;
                }
              //Added By  Dipali V On 20th Nov 2021 For Check Already Exists or not
                if (val.indexOf(" DESC") == -1) {
                    if ($(this)[0].innerHTML.lastIndexOf(' DESC') > 0) {
                        val += ' DESC';
                    }
                    selSorts.push(val);
                } else {
                    // if ($(this)[0].innerHTML.lastIndexOf(' ASC') > 0) {
                    //    val += ' ASC';
                    //}
                    selSorts.push(val);
                } 
                 //End of Added By  Dipali V On 20th Nov 2021 For Check Already Exists or not
            });            
            var selSortList = selSorts.join(",");
           
            var issueParameters = {
                ViewID: vid,
                ProjectID: pid,
                LoginType: loginType,
                intEmployeeID: EmployeeID,
                ViewName: vname,
                FieldList: selFieldList,
                SortList: selSortList

            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/SaveView", param, false);
            if (strResult != undefined) {
                if (strResult == "Success") {
                    getViewList(pid);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('View Saved Successfully', 'success');
                    $('#issueviewdetails').modal('hide');
                    $('#viewapplied').modal('show');
                }
            }
        }

        function StaticView_OnChange(viewtype) {
	    //Added by imran 25-10-2021 we remove the filter data
            $('#viewtype').val(viewtype); //Added By Reshma Chavan
            $("#hquery").val('');
            SearchRecords = "0";
            clearBasicFilterOptions();
            clearAdvancedFilter();
            //filterChange('',0, 0, '', '', '');
           
            //$("#issuefilterpanel").addClass('collapse');
            //End by imran 25-10-2021
            //Commented By Reshma Chavan on 29th oct 2021
            //$('#viewtype').val(viewtype);
            var pid = $("#projectid").val();
            SearchRecords = "1";
			//Added by imran 25-10-2021 To set counter =0
            GlobalIssueCount = 0;
            //Commented and added by Divya J on 18 Sept 2025 for updating Filtered issue count for Pointwest
            //$("#TotalRecords").html(GlobalIssueCount);
            $("#TotalRecords").html(TotalRecords);
            //End of Commented and added by Divya J on 18 Sept 2025 for updating Filtered issue count for Pointwest
			//End Comment 25-10-2021
             //Commented By Nikhil Adkar
             getIssueList(pid, viewtype);
            //End of Commnetd BY Nikhil Adkar
            //Commented by imran 26-10-2021
            Pagination();
           // $("#btnAdvancedFilter").click();
            //End Comment
           }
        function btnRefreshClick() {
            intPageNo = 1;
            SearchRecords = "0";
            //added By Dipali v On 23rd Sep 2019 For Loader issue
            StartLoader("#bodyIssueList");
            //End of added By Dipali v On 23rd Sep 2019 For Loader issue
            var pid = $("#projectid").val();
             var viewtype = $("#cboAccessFilter").val();
           // var viewtype = $("#viewtype").val();
              //Commented By Nikhil Adkar
                    //getIssueList(pid, viewtype);
                    //End of Commnetd BY Nikhil Adkar
            //added By Dipali v On 23rd Sep 2019 For Loader issue

            RefreshAllData();
            // Commented  By VIDHI  for IssueID-27411
            //$("#searchby1").focus()       
            // End Commented  By VIDHI  for IssueID-27411
            StopAjaxLoader("#bodyIssueList");
            // Added By VIDHI  for IssueID-27411
            $("#btnRefresh").blur()
            // End  added By VIDHI  for IssueID-27411
            //End of added By Dipali v On 23rd Sep 2019 For Loader issue
        }
        function chkCheckUncheckAllIssues(item) {
            var flag = $(item).prop('checked');
            //Added By Dipali V On 22nd Sep 2020 For Issue List Changes
            //var table = $('#issuelisttblmain').DataTable();
            //var rows1 = table.rows({ 'search': 'applied' }).nodes();
            //$('input[type="checkbox"]', rows1).each(function () {
            //    this.checked = flag;
            //});
            //// $(".chkIssueItem").prop('checked', flag);


             //var table = $('#issuelisttblmain').DataTable();
            //var rows1 = table.rows({ 'search': 'applied' }).nodes();
            $('#issuelisttblmain input[type="checkbox"]').each(function () {
                this.checked = flag;
            });
            //End of Added By Dipali V On 22nd Sep 2020 For Issue List Changes
            // $(".chkIssueItem").prop('checked', flag);

        }


        function btnDeleteIssue() {
            var sel = $('.chkIssueItem:checked').map(function () {
                var row = this.id.replace('chkissuelist', '');
                return $('#hid' + row).val();
            }).get().join(',');

            if ($("#cboIssueProjects").val() == 0) {

                alertify.set('notifier', 'position', 'top-right');
                //Commented and added by Chetan M on 5 Jan 2021 for Issue fixing
                //alertify.notify('Please select the project', 'error');
                alertify.notify('Please Select Project', 'error');
                //End of Commented and added by Chetan M on 5 Jan 2021 for Issue fixing
                //alertify.notify('Are you sure you want to delete the selected Issues?', 'error')
                return false;

            }
            if (sel == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Select Issue(s) for deletion!', 'error');
                //alertify.notify('Are you sure you want to delete the selected Issues?', 'error')
                return false;
            }
            $('#deletetype').val('I');
            $('#deleteid').val(sel);
            $('#deleteConfirmMsg').html("Are you sure you want to delete the selected Issues?");
            $('#deleteConfirmAlert').modal('show');
        }
        function DeleteIssue(sel) {
            var pid = $("#projectid").val();
            var viewtype = $('#viewtype').val();
            var issueParameters = {
                IssueList: sel,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/DeleteIssues", param, false);
            if (strResult != undefined && strResult == "Success") {
                alertify.set('notifier', 'position', 'top-right');
                //Added By Usha Pandit On 04.06.2020 For adding delay to notification
                setTimeout(
                    function () {
                        alertify.notify('Selected Issue(s) deleted successfully!', 'success');
                    }, 3000);
                //End Of Added By Usha Pandit On 04.06.2020 For adding delay to notification
                $('#btnDelete').addClass("borderbtnred");
                //Commented By Nikhil Adkar
                 getIssueList(pid, viewtype);
                //End of Commnetd BY Nikhil Adkar
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                //Added & commented by dipali V On 23rd Sep 2019 For Assign Issue should not get Delete
                //alertify.notify(strResult, 'error');
                alertify.notify("Selected Issue is in used,You can not delete Issue,", 'error');
                //End of Added & commented by dipali V On 23rd Sep 2019 For Assign Issue should not get Delete
            }
        }

        function Delete() {
            $('#deleteConfirmAlert').modal('hide');
            var type = $('#deletetype').val();
            var id = $('#deleteid').val();
            switch (type) {
                case "F":
                    filterDelete(id);
                    break;
                case "I":
                    DeleteIssue(id);
                    break;
                case "V":
                    DeleteView();
                    break;
            };

            $('.nav-tabs [data-bs-toggle="dropdown"]').each(function (e) {
                // hide any open popovers when the anywhere else in the body is clicked
                if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.nav-tabs .dropdown-menu').has(e.target).length === 0) {
                    $(".nav-tabs .dropdown-menu").removeClass('show');
                }
            });

        }

        var ajaxResult;
        function AJAXCallWithResult(url, param, async) {


            //StartLoader("#bodyIssueList");
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
                    StopAjaxLoader("#bodyIssueList");
                    ajaxResult = data;
                    $("#issuelisttblmain").parent("div.col-sm-12").addClass("table-responsive");
                },
                error: function (err) {
                    StopAjaxLoader("#bodyIssueList");
                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
            return ajaxResult;
        }

        /*New Filter Start*/

        $(document).click(function (event) {

            var clickover = $(event.target);
            var _opened = $(".navbar-collapse").hasClass("navbar-collapse in");
            if (_opened === true && !clickover.hasClass("navbar-toggle")) {
                $("button.navbar-toggle").click();
            }
        });
        //$(window).on("beforeunload", function(e)
        //{
        //    if (filteredit == true) {
        //        //alert("you leaving this page");
        //        console.log("you leaving this page");
        //        e.cancelBubble = true;
        //        return false;
        //    }
        //});
        document.getElementById("leaveConfirmAlertNo").onclick = function () {
            filteredit = true;
            //$("#leaveCofirmAlert").hide();
        }
        document.getElementById("leaveConfirmAlertYes").onclick = function () {
            filteredit = false;
            //$("#leaveConfirmAlert").hide();
        }

        $("#addlistfilter").on("click", "#addrow", function () {


            counter += 1;
            if (counter == 0) {
                var rowcount = $("#divFilterTable ul").length;
                counter = rowcount + 1;
            }
            var rowcount1 = $("#divFilterTable ul").length;
            //counter = rowcount1;
            var newRow = $("<ul class='addrowsmore' id='addrowsmore" + counter + "'>");
            var cols = "";
            if (counter != 0) {

                cols += '<li class="andorswitch" "name' + counter + '"><div class="btn-group" id="foAfilterRowCount" data-bs-toggle="buttons"><label class="btn btn-default btn-on btn-sm active"><input type="radio" value="1" id="foAAndfilterRowCount" name="foAfilterRowCount" checked="checked">AND</label><label class="btn btn-default btn-off btn-sm "><input type="radio" value="0" id="foAorfilterRowCount" name="foAfilterRowCount" >OR</label></div></li>';
            }
            if (counter == 0) {
                $('button#addrow').prop('disabled', true).css({ 'opacity': '0.5' });
                cols += '<li style="width:110px"></li><li class=""><select id="foBfilterRowCount" onchange="changefoB(filterRowCount, this.value);" class="form-control" name="foBfilterRowCount">';
                //cols += '<li style="width:27px"></li>';
            }
            else {
                cols += '<li class=""><select id="foBfilterRowCount" onchange="changefoB(filterRowCount, this.value);" class="form-control" name="foBfilterRowCount">';
            }
            cols += strFilterFieldList;
            cols += '</select ></li > ';
            cols += '<li class=""><select id="foCfilterRowCount"  class="form-control" name="foCfilterRowCount">';
            cols += strOperatorList;
            cols += '</select ></li > ';
            cols += '<li id="fvaluefilterRowCount" class=""><input id="foDfilterRowCount" type="text" class="advncfiltertextfieldvalue form-control" name="foDfilterRowCount"/></li>';
            if (counter != 0) cols += '<li class="del_add_rules"><button data-bs-toggle="tooltip" data-placement="top" title="clear" id="ibtnDel" class="nostylebtn"><img src="../../../Whizible2.0-new/dist/img/close.svg" width="13px"></button></li>';

            cols = cols.replace(/filterRowCount/g, counter);
            newRow.append(cols);
            $("#divFilterTable").append(newRow);


            $("#divAdvancedFilterSave").show(0);
            $("#divQueryText").show(0);
        });

        $(".addfilterrow").on("click", "#ibtnDel", function (event) {

            $(this).closest("ul").remove();
            var id = $(this).closest("ul").attr('id').split("addrowsmore")[1];
            $("#queryfilterclear").find("#query_" + id).remove();
            btnAppendClick()

        });
        $('#addrow').prop('disabled', false);

        $('body').on("keyup", '.advncfiltertextfieldvalue', function () {
            if ($('.advncfiltertextfieldvalue').val() != '' && $('.advncfiltertextfieldvalue').val() != '') {
                $('#addrow').prop('disabled', false).css({ 'opacity': '1' });
            }
            else {
                $('#addrow').prop('disabled', true);
            }
        });

        $('.cust_tabpanel ul.nav.nav-tabs li.dropdown a').click(function () {
            var strHTML = "";
            var qnamearr_arr = [];
            $('#SavedFiltersdropdown').toggle();

        });

        $('.cust_tabpanel ul.nav.nav-tabs li.basic a').click(function () {
            $('#basicfilter').addClass('active');
            $('#queryfilter').removeClass('active');
            $('#queryfilter').hide();

            // alert('B')
        });
        $('.cust_tabpanel ul.nav.nav-tabs li.advanced a').click(function () {

            $('#queryfilter').addClass('active');
            $('#basicfilter').removeClass('active');
            $('#queryfilter').show();

            // alert('a')
        });
        $(window).on('click', function () {

            $("#SavedFiltersdropdown").hide();
            event.stopPropagation();
        });

        function getSavedFilters(qid, pid) {
            //debugger;
            //alert(GetDefaultSavedFilterID);
           // if (GetDefaultSavedFilterID != 0) {
               // var setqid = GetDefaultSavedFilterID;
           // } else {
                var setqid = $('#queryid').val();
           // }

            var issueParameters = {
                QueryID: qid,
                ProjectID: pid,
                intEmployeeID: EmployeeID,
                ListType: '',
                LoginType: loginType,
            }
            var param = JSON.stringify(issueParameters);

            var strResult = AJAXCallWithResult("/api/Issue/Getmyfilterquery", param, false);
            if (strResult != undefined) {
                var selHTML = "";
                for (var i = 0; i < strResult.length; i++) {

                    var d = strResult[i];
                    var qid = d.QueryID;
                    var qname = d.QueryName.replace(/'/g, '`');
                    var qtext = d.QueryText.replace(/'/g, '`');
                    var empid = d.intEmployeeID;
                    var chkd = d.IsDefault;

                    var qtype = d.QueryType;

                    selHTML += "<li id='filter" + qid + "'  name='" + qname + "'>";
                    selHTML += " <label class='customradio'>";
                    selHTML += "<span for='deffilter" + qid + "' class='radiotextsty'>" + qname + "</span>";

                    // if (chkd == true) {
                    if (GetDefaultSavedFilterID == qid) {
                        selHTML += "		<input class='myfilter_selectprocheckbox' checked data-bs-toggle='tooltip' data-placement='bottom' id='deffilter" + qid + "'  type='checkbox' onclick= 'SetAsDefaultFilter(" + qid + ",&quot;default&quot;);filterChange(\"OnChange_set\"," + empid + "," + qid + ",\"" + qtext + "\", \"" + qname + "\", \"" + qtype + "\", true)' name='" + qname + "'/>";
                        selHTML += "		<span data-bs-toggle='tooltip' data-placement='right' title='Default filter' class='checkmark'></span>";
                    }
                    else {
                        selHTML += "		<input class='myfilter_selectprocheckbox' type='checkbox' data-bs-toggle='tooltip' data-placement='bottom' id='deffilter" + qid + "' onclick= 'SetAsDefaultFilter(" + qid + ",&quot;&quot;);filterChange(\"OnChange_set\"," + empid + "," + qid + ",\"" + qtext + "\", \"" + qname + "\", \"" + qtype + "\", true)'   name='" + qname + "'/>";
                        selHTML += "		<span data-bs-toggle='tooltip' data-placement='right' title='Set Default filter' class='checkmark'></span>";
                    }
                    selHTML += "	</label>";
                    selHTML += "	<div class='issfilter_actiondropdown'>";
                    selHTML += "		<div class='custom_chckbox_markblue'>";
                    if (qid == setqid) {
                        selHTML += "			<input id='chkfilter" + qid + "' checked type='checkbox' onclick='filterChange(\"OnChange\"," + empid + "," + qid + ",\"" + qtext + "\", \"" + qname + "\", \"" + qtype + "\", true)' name=''/>";
                        selHTML += "			<label data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Applied filter' for='chkfilter" + qid + "' ></label>";
                    }
                    else {
                        selHTML += "			<input id='chkfilter" + qid + "'  type='checkbox' onclick='filterChange(\"OnChange\"," + empid + "," + qid + ",\"" + qtext + "\", \"" + qname + "\", \"" + qtype + "\", true)' name=''/>";
                        selHTML += "			<label data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Apply filter' for='chkfilter" + qid + "' ></label>";
                    }

                    selHTML += "</div>"
                    selHTML += "		<span onclick= 'btnEditFilter(" + qid + ",\"" + qtext + "\", \"" + qname + "\",\"" + qtype + "\"," + empid + ")'><i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Edit filter' class='fas fa-pencil-alt'></i></span>";
                    if (empid == EmployeeID) {

                        selHTML += "		<span onclick= btnDeleteFilter(" + qid + ")><i data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Delete filter' class='far fa-trash-alt'></i></span>";
                    }
                    else {
                        //selHTML += "		<span style='cursor: no-drop;'><i style='cursor: no-drop;' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='Edit filter' class='fas fa-pencil-alt'></i></span>";
                        selHTML += "		<span class='NoDrop' style='cursor: no-drop;'><i style='cursor: no-drop;opacity:0.5;' data-bs-toggle='tooltip' data-container='body' data-placement='bottom' title='You dont have access to delete filter' class='far fa-trash-alt'></i></span>";
                    }
                    selHTML += "	</div>";
                    selHTML += "</li>";
                }
                $("#SavedFiltersdropdown").html(selHTML);
            }
            //StopLoader();
        }

        function filterChange(FromWhere, empid, qid, qtext, qname, qtype, close) {
           // debugger;
            //Added By reshma Chavan on 18th Nov 2021 for UAT Issue Saved filter appended
            clearBasicFilterOptions();
            //End of Added By reshma Chavan on 18th Nov 2021 for UAT Issue Saved filter appended
            //alert(FirstFilter);
//
           // debugger;
            if (FromWhere == "OnChange") {
                clearSearch();
                $("#cboAccessFilter").val("A");
               
                $('#hIsFilterClear').val('')//
               
            }
             var pid = $("#projectid").val();
            //Added By Dipali V On 8tth Nov 2021 For Get FilterName
           // SavedQueryName = qname;
            GlobalSelectedProject = $("#cboIssueProjects").val();
            GlobalQueryID = qid;

           
            //End of Added By Dipali V On 8tth Nov 2021 For Get FilterName
            if (SelectedSetSessionProjectID != "") {
                if (pid != SelectedSetSessionProjectID) {
                    qtext = "";
                    qname = "";
                    SavedQueryName = "";
                    GlobalQueryID = "";
                } else {
                    if ($('#hIsFilterClear').val() == 1) {
                        if ("<%= Session("SavedQueryName")%>" != "") {
                            qname = "";

                        } else {
                            qname = qname;
                        }
                    } else {
                        qname = qname;
                    }

                    if (FirstFilter !== "") {
                        qtext = FirstFilter;
                    } else {
                        qtext = qtext;
                    }

                    SavedQueryName = qname;

                }
            } else {
                if ($('#hIsFilterClear').val() == 1) {
                    if ("<%= Session("SavedQueryName")%>" != "") {
                        qname = "";

                    } else {
                        qname = qname;
                    }
                } else {
                    qname = qname;
                }
                if (FirstFilter !== "") {
                    //qtext = FirstFilter;
                    qtext = FirstFilter;
                } else {
                    qtext = qtext;
                }
               
                SavedQueryName = qname;

            }
            qtext = qtext.replace(/`/g, "''");
            $('#unsavedquerytext').val(qtext);

            //Commented & Added By Dipali V On 10th Nov 2021
           // if (GetDefaultSavedFilterID != 0) {
                $("#queryid").val(qid);
           // }
              //End of Commented & Added By Dipali V On 10th Nov 2021
            $('#spnappliedfilter').html(qname.replace(/`/g, "'"));
            $("#queryname").val(qname);
            $("#EmployeeID").val(empid);
            $('#querytype').val(qtype);
           // $('#unsavedquerytext').val('');
          
            //start vishal mahajan 04-12-2019
            if ($('#spnappliedfilter').html() != '') {
                $("#lblBasicFilterEdit").show();
                $("#divFilter").show();
                $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                //$("#btnAdvFilter").css({ "background": "#1359a6", "color": "#fff" });//btnAdvancedFilter
            } else {
                $("#lblBasicFilterEdit").hide();
                $("#divFilter").hide();
                //Commented and added by Chetan M on 5th Aug 2020 for set the colour for filter icon
                 $("#btnAdvancedFilter").css({ "background": "NONE", "color": "#464a4c" });
                //$("#btnAdvFilter").css({ "background": "NONE", "color": "UNSET" });
                //Commented and added by Chetan M on 5th Aug 2020 for set the colour for filter icon
            }
            //end vishal mahajan 04-12-2019
            $('#spnappliedfilter').removeClass("unsavedHeading");
            $('#querytype').val(qtype);

            if (qid > 0) {
                counter = 0;
            }
            hdnQueryText = qtext;
			 //Added by imran 25-10-2021
            $("#hquery").val(qtext);
            //End by imran 25-10-2021
            
            // setTab(false);
            $('#tabBasicFilter').removeClass('active');
            //  $('#tabAdvancedFilter').addClass('active');
            $('#basicfilter').removeClass('active');

            //commented By dipali V On 13th Sep 2019 for show applied filter
            //clearAdvancedFilter();
            //clearBasicFilterOptions();
            //commented By dipali V On 13th Sep 2019 for show applied filter
            if (qtype == 'B') {
                $('#tabBasicFilter').addClass('active');
                $('#tabAdvancedFilter').removeClass('active');
                $('#basicfilter').addClass('active');
                $('#queryfilter').removeClass('active');

                $('#lblBasicFilterEdit').text(qname);
                $('#lblBasicFilterEdit').show();
                if (empid == EmployeeID) $('#editqueryid').val(qid);
                BindBasicFilterOptions(qtext);
                GenerateAdvancedFilterTable();
            }
            else {
                $('#tabBasicFilter').removeClass('active');
                $('#tabAdvancedFilter').addClass('active');
                $('#basicfilter').removeClass('active');
                $('#queryfilter').addClass('active');
                 $('#lblBasicFilterEdit').hide();//2021
                $('#queryText').val(qtext);
                $('#lblAdvancedFilterEdit').text(qname);
                $('#lblAdvancedFilterEdit').show();
                if (empid == EmployeeID) $('#editqueryid').val(qid);
                GenerateAdvancedFilterTable();
                BindAdvancedFilterTable(qtext.replace(/''/g, "'"));
            }
            var pid = $("#projectid").val();
            //Commented and added by Reshma chavan on 29th oct 2021
            //var viewtype = $("#viewtype").val();
            var viewtype = $("#cboAccessFilter").val();
			//End of Commented and added by Reshma chavan on 29th oct 2021
			//Added by imran 26-10-2021 For page comes to First
            intPageNo = 1;
            //End by imran 26-10-2021
            //Added & Uncommented by dipali v on 7th july 2023 for apply saved filter 
            if (FromWhere == "OnChange" || FromWhere == "OnChange_set") {
                //Commented by Nikhil Adkar
                getIssueList(pid, viewtype);
                //End of Commented By Nikhil Adkar
            }
             //End of Added & Uncommented by dipali v on 7th july 2023 for apply saved 
            getSavedFilters(0, pid);
          
			
            Pagination();
            //Added by yasmin for tooltip closing on 23-9-11
            $('[data-bs-toggle="tooltip"]').tooltip();
            $('[data-bs-toggle="tooltip"]').click(function () {
                $('[data-bs-toggle="tooltip"]').tooltip("hide");

            });

            
            //if (qtype == 'B') {
            //    BindBasicFilterOptions(qtext);
            //}
            //else {
            //    BindAdvancedFilterTable(qtext.replace(/''/g, "'"));
            //}
        }
        function SetAsDefaultFilter(qid, flag) {
            //fromfilterSpan = true;
           // debugger;
            var NewFlag = 0;
             $('#hIsFilterClear').val('');
            var dqid = qid;
            if (flag == "default") {
                dqid = 0;
            }
             $("#queryid").val(dqid);
            //$('input.myfilter_selectprocheckbox').not(obj).prop('checked', false).parents('#SavedFiltersdropdown li').removeClass('activefilter');
            var pid = $("#projectid").val();
            var viewtype = $('#viewtype').val();
            var issueParameters = {
                intEmployeeID: EmployeeID,
                projectID: pid,
                LoginType: loginType,
                QueryID: dqid,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/SetAsDefaultQuery", param, false);
            if (strResult != undefined) {
                if (strResult == "Success") {
                    alertify.set('notifier', 'position', 'top-right');
                    if (dqid != 0) {
                        NewFlag = 1;
                        removedefault = 1;
                        //Commented And Added By Usha Pandit On 16.03.2020 for rephrasing the alert
                        //alertify.notify('Successfully set the filter as default!', 'success');
                        alertify.notify('Filter Is Successfully Set As Default!', 'success');
                        //End Of Added By Usha Pandit On 16.03.2020 for rephrasing the alert
                    }
                    else {
                        NewFlag = 0;
                        removedefault = 0;
                        $('#hIsFilterClear').val('');
                       // GetDefaultSavedFilterID = 0;

                      //  $('#queryid').val('0');
                       // $('#queryid').val(0);
                        alertify.notify('Default Filter Is Successfully Removed!', 'success');
                       

                    }
                    //clearBasicFilterOptions();
                    //clearAdvancedFilter();
                    getDefaultFilter();
                    if (GetDefaultSavedFilterID == 0) {
                        GenerateAdvancedFilterTable();
                    }
					//Added by imran 26-10-2021 For page comes to First
                    intPageNo = 1;
                    //End by imran 26-10-2021
                    //debugger;
                     ////alert('dipali1234');
                    if (NewFlag == 0) {
                        $('#queryid').val(0);
                    }
                    getSavedFilters(0, pid);
                   
                }
            }
        }
        function btnEditFilter(qid, qtext, qname, qtype, QueryCreatedByEmployeeID) {

            $('#editqueryCreatedByEmployeeID').val(QueryCreatedByEmployeeID);
            //if (filteredit == true) {
            //    return false;
            //}
            hdnQueryText = qtext;
            filteredit = true;
            //fromfilterSpan = true;
            $('#querytype').val(qtype);
            // var abc = $('#querytype').val(qtype);
            //var mno= abc.text;

            //setTab(true);



            //$(' queryfilter').trigger('click');  
            //       $(window).on('click', function () {
            //    $("#SavedFiltersdropdown").hide();
            //    event.stopPropagation();
            //});	

            clearAdvancedFilter();
            clearBasicFilterOptions();
            //$('#lblAdvancedFilterEdit').show();

            // $('#btnAdvancedFilter').show();
            //  $('.cust_tabpanel ul.nav.nav-tabs li.advanced a').show();
            //   $('tabAdvancedFilter').show();

            if (qtype == 'B') {
                $('#tabBasicFilter').addClass('active');
                $('#tabAdvancedFilter').removeClass('active');
                $('#basicfilter').addClass('active');
                $('#queryfilter').removeClass('active');

                $('#lblBasicFilterEdit').text(qname);
                $('#lblBasicFilterEdit').show();
                $('#editqueryid').val(qid);

                BindBasicFilterOptions(qtext);
                GenerateAdvancedFilterTable();
            }
            else {
                $('#tabBasicFilter').removeClass('active');
                $('#tabAdvancedFilter').addClass('active');
                $('#basicfilter').removeClass('active');
                $('#queryfilter').addClass('active');
                 $('#lblBasicFilterEdit').hide();
                $('#queryText').val(qtext);
                $('#lblAdvancedFilterEdit').text(qname);
                $('#lblAdvancedFilterEdit').show();
                $('#editqueryid').val(qid);
                GenerateAdvancedFilterTable();
                BindAdvancedFilterTable(qtext);
                $('#addrow').prop('disabled', false).css({ 'opacity': '1' });
                //   $('tabAdvancedFilter').trigger('click');   
            }

        }
        function btnDeleteFilter(qid) {
 			//Added by imran 25-10-2021
            $("#hquery").val('');
            //End by imran 25-10-2021
            //fromfilterSpan = true;
            $('#deletetype').val('F');
            $('#deleteid').val(qid);
            $('#deleteConfirmMsg').html("Are you sure to delete the selected filter?");
            $('#deleteConfirmAlert').modal('show');
        }
        function filterDelete(qid) {
            var pid = $("#projectid").val();
            var viewtype = $('#viewtype').val();
            var setqid = $('#queryid').val();
            var issueParameters = {
                QueryID: qid,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/DeleteQuery", param, false);
            if (strResult != undefined) {
                if (strResult == "Success") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Filter deleted successfully!', 'success');
                    getSavedFilters(0, pid);
                    if (qid == setqid) {
                        $('#btnClearAllFilters').click();
                        SearchRecords = "0";
                    }
                }
            }
        }
        function getBasicFilterOptions() {
            //getFilterOptions('Status');
            //getFilterOptions('Type');
            //getFilterOptions('SubType');
            //getFilterOptions('Priority');

            //getFilterOptions('Severity');
            //getFilterOptions('Complexity');
            //getFilterOptions('ReportedBy');
            //getFilterOptions('CodedByName');

            //getFilterOptions('AssignToName');
            //getFilterOptions('ReportedInVersion');
            //getFilterOptions('CorrectedInVersion');
            //getFilterOptions('ModuleName');

            //getFilterOptions('Phase');
            //getFilterOptions('FoundInPhase');
            //getFilterOptions('FixedInPhase');
            //getFilterOptions('Deliverable');

            //getFilterOptions('RootCause');
            //getFilterOptions('ScrumRelease');
            //getFilterOptions('ScrumIteration');
            //getFilterOptions('ScrumUserStory');
            var strCombo = "Status,Type,SubType,Priority,Severity,Complexity,ReportedBy,CodedByName,AssignToName,ReportedInVersion,CorrectedInVersion,ModuleName,Phase,FoundInPhase,FixedInPhase,Deliverable,RootCause,ScrumRelease,ScrumIteration,ScrumUserStory,OS,Kernel,KeyWords,ShowToCustomer,HardWare";
            var pid = $('#projectid').val();
            var strResult, data;
            var issueParameters = {
                ProjectID: pid,
                intEmployeeID: EmployeeID,
                LoginType: loginType,
                ControlName: strCombo,
            }
            data = JSON.stringify(issueParameters);

            strResult = AJAXCallWithResult("/api/Issue/GetAllFilterControls", data, false);
            if (strResult != undefined) {
                for (var m = 0; m < strResult.length; m++) {
                    var filter = strResult[m].Type;
                    var cmbData = strResult[m].lstControlCombo;
                    var selHTML = "";

                    if (cmbData != undefined) {
                        if (cmbData.length > 0) selHTML += '<li><input class="checkAll"  type="checkbox"> All</li>';
                        for (var i = 0; i < cmbData.length; i++) {
                            var d = cmbData[i];
                            var key = d.Key.toUpperCase();

                            var value = d.Value;

                            selHTML += '<li>';
                            selHTML += "<input type='checkbox' name='" + sli + sf + filter + "' value='" + value + "'>" + value;
                            selHTML += "</li>";
                        }
                    }
                    $("#f" + filter).html(selHTML);
                    $('[data-bs-toggle="tooltip"]').click(function () {
                        $('[data-bs-toggle="tooltip"]').tooltip("hide");

                    });
                }
            }
        }
        function getFilterOptions(filter) {

            var pid = $('#projectid').val();
            var strResult, data;
            var issueParameters = {
                ProjectID: pid,
                intEmployeeID: EmployeeID,
                LoginType: loginType,
                ControlName: filter,
            }

            data = JSON.stringify(issueParameters);

            strResult = AJAXCallWithResult("/api/Issue/GetFilterControl", data, false);
            var selHTML = "";
            if (strResult != undefined) {
                var type = strResult.Type;
                var cmbData = strResult.lstControlCombo;

                if (type == "C") {
                    if (cmbData != undefined) {
                        if (cmbData.length > 0) selHTML += '<li><input class="checkAll"  type="checkbox"> All</li>';
                        for (var i = 0; i < cmbData.length; i++) {
                            var d = cmbData[i];
                            var key = d.Key.toUpperCase();

                            var value = d.Value;

                            selHTML += '<li>';
                            selHTML += "<input type='checkbox' name='" + sli + sf + filter + "' value='" + value + "'>" + value;
                            selHTML += "</li>";
                        }
                    }
                }
            }
            $("#f" + filter).html(selHTML);
            $('[data-bs-toggle="tooltip"]').click(function () {
                $('[data-bs-toggle="tooltip"]').tooltip("hide");

            });
        }
      
        function getDefaultFilter() {

            hdnQueryText = "";
            var pid = $("#projectid").val();
            var issueParameters = {
                intEmployeeID: EmployeeID,
                projectID: pid,
                LoginType: loginType,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/GetDefaultQuery", param, false);
            if (strResult != undefined) {
                $('#queryid').val(strResult.QueryID);
                GetDefaultSavedFilterID = strResult.QueryID;
                $('#querytype').val(strResult.QueryType);

                $('#spnappliedfilter').html(strResult.QueryName);

                if (strResult.QueryName != null) {
                    SavedQueryName = strResult.QueryName;  //Added By Dipali 9th oct 2021
                } else {
                    if (SavedQueryName != "") {
                        SavedQueryName = SavedQueryName;
                    }

                }
                //start vishal mahajan 04-12-2019
                if ($('#spnappliedfilter').html() != '') {
                    $("#lblBasicFilterEdit").show();
                    $("#divFilter").show();
                    //Added & Commented By Dipali V On 20th Dec 2019 For highlight Filter
                     $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                    //$("#btnAdvFilter").css({ "background": "#1359a6", "color": "#fff" });
                     //End of Added & Commented By Dipali V On 20th Dec 2019 For highlight Filter
                } else {
                    $("#lblBasicFilterEdit").hide();
                    $("#divFilter").hide();
                     //Added & Commented By Dipali V On 20th Dec 2019 For highlight Filter
                    //Commented and added by Chetan M on 5th Aug 2020 for set the colour for filter icon
                     $("#btnAdvancedFilter").css({ "background": "NONE", "color": "#464a4c" });//btnAdvancedFilter
                   // $("#btnAdvFilter").css({ "background": "NONE", "color": "UNSET" });//btnAdvancedFilter
                    //End of Commented and added by Chetan M on 5th Aug 2020 for set the colour for filter icon
                     //End of Added & Commented By Dipali V On 20th Dec 2019 For highlight Filter
                }
                //end vishal mahajan 04-12-2019
                if (strResult.QueryID > 0) {

                    //if ($("#btnAdvancedFilter").hasClass("initial") || $("#btnAdvancedFilter").hasClass("collapsed")) {
                    //    $("#btnAdvancedFilter").removeClass("initial");
                    //    $("#btnAdvancedFilter").click();
                    //    setTab(false);
                    //}
                    hdnQueryText = strResult.QueryText;
 					//Added by imran 25-10-2021
                    hdnQueryText = hdnQueryText.replace(/'/g, "''")
                    $("#hquery").val(hdnQueryText);
                    //Added By Dipali V on 8th Nov 2021 Getting page crash for default filter
                    if ($('#unsavedquerytext').val() == "") {
                        $('#unsavedquerytext').val(hdnQueryText);
                    }
                     //End of Added By Dipali V on 8th Nov 2021 Getting page crash for default filter
                    //End by imran 25-10-2021
                    counter = 0;
                    $('#editqueryid').val(strResult.QueryID);
                    if ($('#querytype').val() == 'Q') {
                        $('#queryText').val(strResult.QueryText);
                        GenerateAdvancedFilterTable();
                        BindAdvancedFilterTable(strResult.QueryText);
                        $('#lblAdvancedFilterEdit').text(strResult.QueryName);
                        $('#lblAdvancedFilterEdit').show();
                        $('#tabAdvancedFilter').addClass('active');
                        $('#tabBasicFilter').removeClass('active');
                    }
                    else {
                        BindBasicFilterOptions(strResult.QueryText);
                        $('#lblBasicFilterEdit').text(strResult.QueryName);
                        $('#lblBasicFilterEdit').show();
                        $('#tabBasicFilter').addClass('active');
                        $('#tabAdvancedFilter').removeClass('active');
                    }
                }
                else {
                    if (!$("#btnAdvancedFilter").hasClass("initial") && !$("#btnAdvancedFilter").hasClass("collapsed")) {
                        $("#btnAdvancedFilter").click();
                    }
                    $('#tabBasicFilter').removeClass('active');
                }
            }
            $('[data-bs-toggle="tooltip"]').click(function () {
                $('[data-bs-toggle="tooltip"]').tooltip("hide");

            });
            $("#issuelisttblmain").parent("div.col-sm-12").addClass("table-responsive");
        }
        $('#btnClearAllFilters').click(function () {
            //debugger;
 			//Added by imran 25-10-2021
            $("#hquery").val('');
            //End by imran 25-10-2021
            clearsession("FirstFilter");
            clearsession("ViewTypeFilter");
            SearchRecords = "0";
            clearBasicFilterOptions();
            clearAdvancedFilter();
            FirstFilter = "";
           
            filterChange(0, 0, '', '', '');
           
            //Remove Default Filter
            //var qid = $("#queryid").val();
            ///SetAsDefaultFilter(qid,'');
              //Remove Default Filter
            $("#issuefilterpanel").addClass('collapse');

            //Added by Divya J on 18 Sept 2025 for updating Filtered issue count for Pointwest
            // Added to refresh the issue list and count after clearing filters
            var pid = $("#projectid").val();
            var viewtype = $("#cboAccessFilter").val();
            getIssueList(pid, viewtype);
            //End of Added by Divya J on 18 Sept 2025 for updating Filtered issue count for Pointwest
            Pagination();
            GlobalQueryID = "";
            SelectedSetSessionProjectID = "";
            if ("<%= Session("SavedQueryName")%>" != "") {
                $('#hIsFilterClear').val('1')
            } else {
                 $('#hIsFilterClear').val('')
            }
            //Added By Dipali V on 22nd Nov 2021 For Display Filter Name
            selectedFirstFilter = "";
           // sessionStorage.removeItem('SavedQueryName');
           // GlobalSelectedProject = "";
          //Commented and Added by Divya J on 18 Sept 2025 for updating Filtered issue count for Pointwest
          //var pid = $("#projectid").val();
          //getIssueList(pid, ViewTypeFilter);
            $("#btnAdvancedFilter").click();
          //End of Added by Divya J on 18 Sept 2025 for updating Filtered issue count for Pointwest
           
        });
        function btnSaveBasicFilter() {
            if (!validateBasicFilterQuery()) return false;

            var query = generateBasicFilterQuery();
            if (query == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Select at least one filter option.", "error");
                return false;
            }
            $('#querytype').val('B');
            $('#unsavedquerytext').val(query);
            $('#newfiltername').val($('#lblBasicFilterEdit').text());
            $('#issuesavefilter').modal('show');
        }
        function SaveFilter() {
           // debugger;
              //filter clear
           // debugger;
            $("#hquery").val('');
            clearSearch();
            $("#cboAccessFilter").val("A");
              //End of filter clear
            var qname = $('#newfiltername').val().trim();
            if (qname == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please specify Filter Name.', 'error');
                //Added By Dipali V On 20th Dec 2019 For Filter Name Focus After Validation alter come
                $('#newfiltername').focus();
               //End of Added By Dipali V On 20th Dec 2019 For Filter Name Focus After Validation alter come
                return false;
            }
            //if (checkSpecialCharacter(qname) == true) {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('Filter Name cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
            //     //Added By Dipali V On 20th Dec 2019 For Filter Name Focus After Validation alter come
            //    $('#newfiltername').focus();
            //   //End of Added By Dipali V On 20th Dec 2019 For Filter Name Focus After Validation alter come
            //    //$('#newfiltername').focus();
            //    return false;
            //}
            //Added By Rehan C To check validation for Special characters  on 07th Nov 2022
            if (checkSpecialCharacter(qname, WebConfigSpecialCharacters) == true) {
                $("#btnSaveFilter").removeAttr("data-dismiss");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Filter Name cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                 //Added By Dipali V On 20th Dec 2019 For Filter Name Focus After Validation alter come
                $('#newfiltername').focus();
               //End of Added By Dipali V On 20th Dec 2019 For Filter Name Focus After Validation alter come
                //$('#newfiltername').focus();
                return false;
            }

            var qid = $('#editqueryid').val();
            var qCreatedByEmployeeID = $('#editqueryCreatedByEmployeeID').val();
            var isDuplicate = FindDuplicateFilter(qname, qid);
            if (isDuplicate == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Filter Name already exists. Specify different Name.', 'error');
                 //Added By Dipali V On 20th Dec 2019 For Filter Name Focus After Validation alter come
                $('#newfiltername').focus();
               //End of Added By Dipali V On 20th Dec 2019 For Filter Name Focus After Validation alter come
                return false;
            }
            if (qid != "" && $('#querytype').val() != 'B') {
                if (qCreatedByEmployeeID != EmployeeID) {
                    var OldQName = $('#lblAdvancedFilterEdit').text();
                    if (qname == OldQName) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('Filter Name already exists. Specify different Name.', 'error');
                         //Added By Dipali V On 20th Dec 2019 For Filter Name Focus After Validation alter come
                            $('#newfiltername').focus();
                           //End of Added By Dipali V On 20th Dec 2019 For Filter Name Focus After Validation alter come
                        return false;
                    }
                }
            }
            $('#newfiltername').val(qname);
            var pid = $('#projectid').val();
            var qtext = $('#unsavedquerytext').val();
            var qtype = $('#querytype').val();
            if (qid == "") {
                qid = 0;
            }
            var issueParameters = {
                ProjectID: pid,
                intEmployeeID: EmployeeID,
                LoginType: loginType,
                QueryName: qname,
                QueryText: qtext,
                QueryID: qid,
                QueryType: qtype,
            }
            data = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/SaveQuery", data, false);
            if (strResult != undefined && strResult != "") {
                $('#unappliedqueryid').val(strResult);
                $("#issuesavefilter").modal('hide');

                //$('#unsavedquerytext').val("");
                $("#hquery").val(qtext);//dipali V  on 15th dec for getting issue count correct
                getSavedFilters(0, pid);
                filteredit = false;
                var recordCount = GetFilteredIssueCount(pid);
                var msg = 'Your filter result returned {count} records. Do you want to view them?';
                msg = msg.replace('{count}', recordCount);
                $('#applyConfirmMsg').html('');
                $('#applyConfirmMsg').html(msg);
                $('#applyConfirmAlert').modal('show');
            }
        }
        function Apply() {
            //filter clear
           // debugger;
            clearSearch();
            if ($('#hIsFilterClear').val() == "1") {
                $('#hIsFilterClear').val('')
            }
            $("#cboAccessFilter").val("A");
              //End of filter clear
            var qname = $('#newfiltername').val().trim();
            var qid = $('#unappliedqueryid').val();
            var qtype = $('#querytype').val();

            var qtext = $('#unsavedquerytext').val();
            $('#unsavedquerytext').val("");
            $('#unappliedqueryid').val(0);
            $('#newfiltername').val('');
            SearchRecords = "1";
            //Added By Reshma Chavan on 2nd nov 2021 getting Crash
            //filterChange(EmployeeID, qid, qtext, qname, qtype, true);
            //filterChange('', EmployeeID, qid, qtext, qname, qtype, true);
            filterChange('OnChange', EmployeeID, qid, qtext, qname, qtype, true);
            //End of Added By Reshma Chavan on 2nd nov 2021 getting Crash
            //setTab(false);
			//modified by pradip on 16-12-2019 for collpase filterpanel
			$("#issuefilterpanel").addClass("collapse");
        }
        function DoNotApply() {
           
            $('#unappliedqueryid').val(0);
            $('#unsavedquerytext').val("");
            //Added By  Dipali V On 3rd Feb 2022 For If No then Filter Should not Apply
            $('#btnClearAllFilters').click();
            $("#applyConfirmAlert").modal('hide');
            SearchRecords = "0";
           //End of Added By  Dipali V On 3rd Feb 2022 For If No then Filter Should not Apply

        }
        function btnApplyBasicFilter() {
           // debugger;
            clearSearch();
            if (!validateBasicFilterQuery()) return false;

            var query = generateBasicFilterQuery();
            if (query == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Select at least one filter option.", "error");
                return false;
            }
             //Commented and added by imran 25-10-2021
            //Added By reshma chavan on 18th Nov 2021
            hdnQueryText = query;

            var hquery = hdnQueryText.replace(/`/g, "''");
            //hquery = hquery.replace(/\'/g, "");
            $("#hquery").val(hquery);
            //End Comment 25-10-2021
            //var qry = query.replace(/\'/g, "''");
            //if (qry.trim() != hquery.trim()) {
            clearAdvancedFilter();
            GenerateAdvancedFilterTable();
            //generateBasicFilterQuery();
            
           // debugger;
            if (SecondFilter.indexOf("''") > -1) {

            }
            else if (SecondFilter.indexOf("'") > -1) {
                SecondFilter = SecondFilter.replace(/\'/g, "''");
            }

            if (query.indexOf("''") > -1) {

            } else if (query.indexOf("'") > -1) {
                query = query.replace(/\'/g, "''");
            }
           
            $("#secondfilter").val(SecondFilter);
            $('#searchoptiontext').val(SecondFilter);
           // FirstFilter = query;
            // sessionStorage.setItem("SFilter", SecondFilter);
            $('#unsavedquerytext').val(query);
           
            globalApplyQuery = query;
            //Added By Dipali V On 11th Nov 2021 For Check Filter Apply or not
            FirstFilter = query;
            //End of Added By Dipali V On 11th Nov 2021 For Check Filter Apply or not
            $('#queryid').val(0);
            var pid = $("#projectid").val();
            //Added By Dipali V On 11th Nov 2021 For Check Filter Apply or not
            GlobalSelectedProject = pid;
            //End of Added By Dipali V On 11th Nov 2021 For Check Filter Apply or not
            //debugger;
          
            $('#cboAccessFilter').val("A");
            $("#cboAccessFilter option[value='A']").attr("selected", "selected");
            var viewtype = $('#cboAccessFilter').val();
          

			//Added by imran 25-10-2021 For page comes to First
            intPageNo = 1;
            //End by imran 25-10-2021
            //Uncommented By Dipali V On 6th July 2023 For Getting Filter Data
           //Commented By Nikhil Adkar
            getIssueList(pid, viewtype);
            //End of Uncommented By Dipali V On 6th July 2023 For Getting Filter Data
           //End of Commnetd BY Nikhil Adkar
            getSavedFilters(0, pid);
            if (filteredit == true) {
                var QName = $("#lblBasicFilterEdit").text();
                $('#spnappliedfilter').html(QName);
                //start vishal mahajan 04-12-2019
                if ($('#spnappliedfilter').html() != '') {
                    $("#lblBasicFilterEdit").show();
                    $("#divFilter").show();
                    //Added & Commented By Dipali V On 20nd Dec 2019 For Highlight Filter 
                    $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
                       //$("#btnAdvFilter").css({ "background": "#1359a6", "color": "#fff" });
                     //End of Added & Commented By Dipali V On 20nd Dec 2019 For Highlight Filter 
                } else {
                    $("#lblBasicFilterEdit").hide();
                    $("#divFilter").hide();
                     //Added & Commented By Dipali V On 20nd Dec 2019 For Highlight Filter 
                    //Commented and added by Chetan M on 5th Aug 2020 for set the colour for filter icon
                    //$("#btnAdvFilter").css({ "background": "NONE", "color": "UNSET" });
                    $("#btnAdvancedFilter").css({ "background": "NONE", "color": "#464a4c" });
                    //End of Commented and added by Chetan M on 5th Aug 2020 for set the colour for filter icon
                     //End of Added & Commented By Dipali V On 20nd Dec 2019 For Highlight Filter 
                }
                //end vishal mahajan 04-12-2019
                // $('#spnappliedfilter').addClass("unsavedHeading");
            }
            //start vishal mahajan 04-12-2019  
            $("#divFilter").show();
            $("#btnAdvancedFilter").css({ "background": "#1359a6", "color": "#fff" });
            //end vishal mahajan 04-12-2019

            ////$('#spnappliedfilter').html(" NA");
            ////$('#lblBasicFilterEdit').text('');
            ////$('#lblBasicFilterEdit').hide();
            // $('#spnappliedfilter').addClass("unsavedHeading");

            //start vishal mahajan 04-12-2019   
            //$('#basicfilter').removeClass('active');
            //end vishal mahajan 04-12-2019

            //}
            //else {         
            //    var qid = $('#queryid').val();
            //    var eqid = $('#editqueryid').val();
            //    var qtype = $('#querytype').val();
            //    var qname = $('#lblBasicFilterEdit').text();
            //    if (qid != eqid) {
            //        filterChange(EmployeeID, eqid, query, qname, qtype, true)
            //    }
            //}
			
			//modified by pradip on 16-12-2019 for collpase filterpanel
            $("#issuefilterpanel").addClass("collapse");
            //Commented by imran 25-10-2021 For Filter apply button gitting wrong count
            //SearchRecords = "1";
            //End comment by imran 25-10-2021
            Pagination();//Added By Dipali V On 4th Sep 2020 For Pagination
        }
        function appendSelectedOptions(ctrl, str) {
            optionList = "";
            var options = document.getElementsByName(sli + ctrl);
            for (var i = 0; i < options.length; i++) {
                if (options[i].checked == true) {
                    if (optionList == "") {
                        optionList += "''" + options[i].value + "''";
                    }
                    else {
                        optionList += "," + "''" + options[i].value + "''";
                    }


                }
            }
            if (optionList != "") {
                if (ctrl == 'fShowToCustomer') optionList = optionList.replace('Yes', '1').replace('No', '0');
                if (str != "") str += sAnd;
                str += " (" + ctrl.replace(sf, '').replace(sscrum, '') + " IN(" + optionList + ")) ";
            }

            return str;
        }
        function clearBasicFilterOptions() {
            SearchRecords = "0";
            $('#editqueryid').val('');
            $('#lblBasicFilterEdit').text('');
            $('#lblBasicFilterEdit').hide();
            $('#txtReportedFrom').val('');
            $('#txtReportedTo').val('');
            $('#txtDueDateFrom').val('');
            $('#txtDueDateTo').val('');
            clearSelectedOptions('fType');
            clearSelectedOptions('fSubType');
            clearSelectedOptions('fStatus');
            clearSelectedOptions('fPriority');

            clearSelectedOptions('fSeverity');
            clearSelectedOptions('fComplexity');
            clearSelectedOptions('fReportedBy');
            clearSelectedOptions('fCodedByName');

            clearSelectedOptions('fAssignToName');
            clearSelectedOptions('fReportedInVersion');
            clearSelectedOptions('fCorrectedInVersion');
            clearSelectedOptions('fModuleName');

            clearSelectedOptions('fPhase');
            clearSelectedOptions('fFoundInPhase');
            clearSelectedOptions('fFixedInPhase');
            clearSelectedOptions('fDeliverable');

            clearSelectedOptions('fRootCause');
            clearSelectedOptions('fScrumRelease');
            clearSelectedOptions('fScrumIteration');
            clearSelectedOptions('fScrumUserStory');
            clearSelectedOptions("fKeyWords");
            clearSelectedOptions("fShowToCustomer");
            clearSelectedOptions("fKernel");
            clearSelectedOptions("fOS");
            clearSelectedOptions("fHardWare");
            SearchRecords = "0";
            FirstFilter = "";
            Pagination();
        }
        function clearSelectedOptions(ctrl) {

            var options = document.getElementsByName(sli + ctrl);
            if (options.length > 0) {
                var alloptions = document.getElementById(ctrl);
                alloptions.children[0].firstChild.checked = false;
            }
            for (var i = 0; i < options.length; i++) {
                options[i].checked = false;
            }

            $("#" + ctrl).parents('.fplistbox').find('.fplist_title').css({ 'background': '#e7edf0', 'color': 'inherit' });
            $("#" + ctrl).parents('.fplistbox').find('.fplist_title').addClass("collapsed");
        }
        //Added By Usha Pandit On 17.03.2020 For validating reporting from to dates
        function CompairDates(obj1, Obj2) {
            //debugger;
            var date1 = new Date(obj1);
            var date2 = new Date(Obj2);
            if (date1 > date2) {
                return 1;
            }
            else if (date1 < date2) {
                return -1;
            }
            else {
                return 0;
            }
        }
        //End Of Added By Usha Pandit On 17.03.2020 For validating reporting from to dates
        function validateBasicFilterQuery() {
            var reportedFrom = $('#txtReportedFrom').val();
            var reportedTo = $('#txtReportedTo').val();
            var dueDateFrom = $('#txtDueDateFrom').val();
            var dueDateTo = $('#txtDueDateTo').val();
            if ((reportedFrom != "" && reportedTo == "")
                || (reportedFrom == "" && reportedTo != "")) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Select both 'Reported From' and 'Reported To'", "error");
                return false;
            }
            //Added By Usha Pandit On 17.03.2020 For validating reporting from to dates
            if (reportedFrom != "" && reportedTo != "") {
                if (CompairDates(reportedTo, reportedFrom) == -1) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Reported To date should not be less than Reported From date.', 'error');
                    return false;
                }
            }
            //End Of Added By Usha Pandit On 17.03.2020 For validating reporting from to dates
            if ((dueDateFrom != "" && dueDateTo == "")
                || (dueDateFrom == "" && dueDateTo != "")) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Select both 'Due Date From' and 'Due Date To'", "error");
                return false;
            }
            //Added by Nilesh Pingale on 19th Mar 2020 (Issue ID : 23451) for Due Date  is greater than Due Date To there  is no validation 
            if (dueDateFrom != "" && dueDateTo != "") {
                if (CompairDates(dueDateTo, dueDateFrom) == -1) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Due Date To should not be less than Due Date From.', 'error');
                    return false;
                }
            }
            //End of Added by Nilesh Pingale on 19th Mar 2020 (Issue ID : 23451) for Due Date  is greater than Due Date To there  is no validation 
            return true;
        }
        function generateBasicFilterQuery() {
            //  
            var reportedFrom = $('#txtReportedFrom').val();
            var reportedTo = $('#txtReportedTo').val();
            var dueDateFrom = $('#txtDueDateFrom').val();
            var dueDateTo = $('#txtDueDateTo').val();
            if ((reportedFrom != "" && reportedTo == "")
                || (reportedFrom == "" && reportedTo != "")) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Select both 'Reported From' and 'Reported To'", "error");
                return false;
            }
            if ((dueDateFrom != "" && dueDateTo == "")
                || (dueDateFrom == "" && dueDateTo != "")) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Select both 'Due Date From' and 'Due Date To'", "error");
                return false;
            }
            var query = "";

            //if ($("#hquery").val() != "") {
            //    query = $("#hquery").val();
            //} else {
            //    query = query;
            //}

            if (reportedFrom != "") {
                query += " (ReportedDate BETWEEN ''" + reportedFrom + "'' AND ''" + reportedTo + "'') "
            }
            if (dueDateFrom != "") {
                if (query != "") query += sAnd;
                query += " (DueDate BETWEEN ''" + dueDateFrom + "'' AND ''" + dueDateTo + "'') "
            }
            //  alert(query);
            query = appendSelectedOptions("fType", query);
            query = appendSelectedOptions("fSubType", query);
            query = appendSelectedOptions("fStatus", query);
            query = appendSelectedOptions("fPriority", query);

            query = appendSelectedOptions("fSeverity", query);
            query = appendSelectedOptions("fComplexity", query);
            query = appendSelectedOptions("fReportedBy", query);
            query = appendSelectedOptions("fCodedByName", query);

            query = appendSelectedOptions("fAssignToName", query);

            query = appendSelectedOptions("fReportedInVersion", query);
            query = appendSelectedOptions("fCorrectedInVersion", query);
            query = appendSelectedOptions("fModuleName", query);

            query = appendSelectedOptions("fPhase", query);
            query = appendSelectedOptions("fFoundInPhase", query);
            query = appendSelectedOptions("fFixedInPhase", query);
            query = appendSelectedOptions("fDeliverable", query);

            query = appendSelectedOptions("fRootCause", query);
            query = appendSelectedOptions("fScrumRelease", query);
            query = appendSelectedOptions("fScrumIteration", query);
            query = appendSelectedOptions("fScrumUserStory", query);

            query = appendSelectedOptions("fKeyWords", query);
            query = appendSelectedOptions("fShowToCustomer", query);
            query = appendSelectedOptions("fHardWare", query);

            query = appendSelectedOptions("fKernel", query);
            query = appendSelectedOptions("fOS", query);
            // alert(query);
            return query;
        }
        function GetFilteredIssueCount(pID) {
            var count = 0;
            var sview = $("#cboAccessFilter").val();
            var qid = $("#unappliedqueryid").val();

            // Always get current filter values, not just when project matches
            var qtext = $('#unsavedquerytext').val();
            var tquery = $("#hquery").val();
            var stext = $('#searchoptiontext').val();
            
            if (stext.indexOf("''") === -1) {
                stext = stext.replace(/\\'/g, "''");
            }
            //Added By Nikhil Adkar on 20-May-2026 for replacing single Quote with double quote in search text for getting correct count
            stext = stext.replace(/'/g, '"');
            //End of Added By Nikhil Adkar on 20-May-2026 for replacing single Quote with double quote in search text for getting correct count
            if (qid == "") { qid = 0; }

            var issueParameters = {
                intEmployeeID: EmployeeID,
                projectID: pID,
                LoginType: loginType,
                DisplayMode: sview,
                UserName: UserName,
                QueryID: qid,
                QueryText: qtext,
                SearchText: stext,
                FilterQuery: tquery,
                RoleId: RoleId   //Added by Divya J on 18 sept 2025 for updating filtered issue count for Pointwest
            };

            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/GetIssueCount", param, false);

            if (strResult !== undefined && strResult !== null) {
                if (strResult.TotalCount !== undefined) {
                    count = strResult.TotalCount;
                } else {
                    count = parseInt(strResult, 10) || 0;
                }
            }

            GlobalIssueCount = count;
            TotalRecords = count;
            return count;
        }



        //$(window).on("beforeunload", function(e)
        //{
        //    if (filteredit == true) {
        //        alert("you leaving this page");
        //        console.log("you leaving this page");
        //        e.cancelBubble = true;
        //        return false;
        //    }
        //});
        $('#btnAdvancedFilter').click(function () {
            //Added by Nilesh Pingale on 17th Mar 2020 (Issue ID: 23456) for clear existing selection on apply new filter
            //if ($('#spnappliedfilter').text() == "") {
            //Added by Nikhil Adkar on 31-May-2023 for performance issues
           // debugger;
            getBasicFilterOptions();
            var qtext = $('#unsavedquerytext').val();
            BindBasicFilterOptions(qtext);
            //End of Added By Nikhil Adkar
            if ($('#spnappliedfilter').text() == "" || $('#spnappliedfilter').text() == undefined) {
                 //Added By Dipali V On 24th Nov 2021 For if Apply filter then condition should be high light
                if ($('#unsavedquerytext').val() != "") {

                } else {
                    clearBasicFilterOptions();
                    clearAdvancedFilter();
                }
                //End of Added By Dipali V On 24th Nov 2021 For if Apply filter then condition should be high light
                $(".panel-collapse").removeClass('in');//added by  Dipali V On  16th April 2020 for after clear filter div should be close
                ////('#btnAdvancedFilter').attr('aria-expanded', true);
                //$('#btnAdvancedFilter').css('background-color', "none");
                //$('#btnAdvancedFilter').css('color', "unset");
                // var pid = $("#projectid").val();
                //var viewtype = $("#viewtype").val();
                //getIssueList(pid, viewtype);
            }
            //End of Added by Nilesh Pingale on 17th Mar 2020 (Issue ID: 23456) for clear existing selection on apply new filter
            var ProjectId = $('#cboIssueProjects').val();
            //   
            if (ProjectId == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Select Project', 'error');
                return;
            }
            if ($('#issuefilterpanel').hasClass('collapse')) {
                $('#issuefilterpanel').removeClass('collapse');
                $('#btnAdvancedFilter').attr('aria-expanded', true);
                //  setTab(true);
            }
            else {
                $('#issuefilterpanel').addClass('collapse');
                $('#btnAdvancedFilter').attr('aria-expanded', false);
            }
            $('#tabSavedFilters').removeClass('active');
            $('#tabBasicFilter').addClass('active');
            $('#basicfilter').addClass('active');
        });
        function setTab(show) {

            var qtype = $('#querytype').val();
            if (qtype == 'Q') {
                $('#tabBasicFilter').removeClass('active');
                $('#tabAdvancedFilter').addClass('active');
                $('#basicfilter').removeClass('active');
                if (show) {
                    $('#queryfilter').addClass('active');
                }
                else {
                    $('#queryfilter').removeClass('active');
                }
            }
            else {
                $('#tabAdvancedFilter').removeClass('active');
                $('#tabBasicFilter').addClass('active');
                $('#queryfilter').removeClass('active');
                if (show) {
                    $('#basicfilter').addClass('active');
                }
                else {
                    $('#basicfilter').removeClass('active');
                }
            }
        }
        function getFilterFieldList(pid, rid) {
            var issueParameters = {
                ProjectID: pid,
                RoleId: rid,
                intEmployeeID: EmployeeID,
                ExcludeCorporateField: 1,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/GetQueryFieldList", param, false);
            var selHTML = "";
            if (strResult != undefined) {
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var FieldID = d.FieldID.toUpperCase();
                    var FieldName = d.FieldName;
                    selHTML += '<option title="' + FieldName + '" value="' + FieldID + '">' + FieldName + '</option>';
                }
            }
            strFilterFieldList = selHTML;
        }
        function getFilterFieldOperators() {
            var param = JSON.stringify({ "ProjectID": 0 });
            var strResult = AJAXCallWithResult("/api/Issue/GetOperatorList", param, false);
            var selHTML = "";
            if (strResult != undefined) {
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var key = d.Key;
                    var value = d.Value;
                    selHTML += "<option title='" + value + "' value='" + key + "'>" + value + "</option>";
                }
            }
            strOperatorList = selHTML;
        }
        function btnApplyAdvancedFilter() {

            var output = "";
            output = GenerateAdvancedQuery();
            if (output != '' && output != null && output != undefined) {
                $('#unsavedquerytext').val(output);
            } else {
                if (output == '' || output == null) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Please form a query.', 'error');
                    return false;
                }
            }
            clearBasicFilterOptions();

            $('#queryid').val(0);
            var pid = $("#projectid").val();
           // var viewtype = $("#viewtype").val();
           //Commented & Added By Dipali V On 12th Nov 2021 For Getting Proper View Type
               // var viewtype = $('#viewtype').val();
                var viewtype = $('#cboAccessFilter').val();
           //End of Commented & Added By Dipali V On 12th Nov 2021 For Getting Proper View Type
              //Commented By Nikhil Adkar
                    //getIssueList(pid, viewtype);
                    //End of Commnetd BY Nikhil Adkar
            $('#spnappliedfilter').html("NA");
            $('#queryText').val(output.replace(/''/g, "'"));
            btnAppendClick();
            //$('#queryText').addClass("unsavedText");
            if (filteredit == true) {
                var QName = $("#lblAdvancedFilterEdit").text();
                $('#spnappliedfilter').html(QName);
                //start vishal mahajan 04-12-2019
                if ($('#spnappliedfilter').html() != '') {
                    $("#lblBasicFilterEdit").show();
                    $("#divFilter").show();
                    $("#btnAdvFilter").css({ "background": "#1359a6", "color": "#fff" });
                } else {
                    $("#lblBasicFilterEdit").hide();
                    $("#divFilter").hide();
                    //Commented and added by Chetan M on 5th Aug 2020 for set the colour for filter icon
                    $("#btnAdvFilter").css({ "background": "NONE", "color": "#464a4c" });
                    //$("#btnAdvFilter").css({ "background": "NONE", "color": "UNSET" });
                    //End of Commented and added by Chetan M on 5th Aug 2020 for set the colour for filter icon
                }
                //end vishal mahajan 04-12-2019
                // $('#spnappliedfilter').addClass("unsavedHeading");
            }

            $('#queryfilter').removeClass('active');
        }
        function btnSaveAdvancedFilter() {

            var output = "";
            output = GenerateAdvancedQuery();
            if (output != '' && output != null && output != undefined) {
                $('#unsavedquerytext').val(output);
            }
            else {
                if (output == '' || output == null) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('Please form a query.', 'error');
                    return false;
                }

            }
            $('#querytype').val('Q');
            $('#unsavedquerytext').val(output);
            $('#newfiltername').val($('#lblAdvancedFilterEdit').text());
            $('#issuesavefilter').modal('show');


        }
        function GenerateAdvancedQuery() {

            var rowcount = $("#divFilterTable ul").length;
            var output = "";
            var a = "", b = "", c = "", d = "";
            // var children = document.getElementById('divFilterTable').getElementsByTagName('ul');
            for (var i = 0; i < rowcount; i++) {
                //  var QNum =children[i].id.split("addrowsmore")[1];
                // if($("#foB" + i).length)
                var BID = $("#foB" + i);
                var CID = $("#foC" + i);
                var DID = $("#foD" + i);

                if (BID.length == 0) {
                    rowcount += 1;
                }

                b = $("#foB" + i).val();
                c = $("#foC" + i).val();
                d = $("#foD" + i).val();
                a = $("input[name='foA" + i + "']:checked").val();

                if (a != '' && a != null && a != undefined) {
                    var andor = (a == 1 ? "AND" : "OR");
                    output += andor + ' ';
                }
                if (b != '' && b != null && b != undefined) {
                    output += b;
                }
                else {
                    if ((b == '' || b == null) && (BID.length != 0)) {
                        output = "";
                        return output;
                    }
                }
                if (c != '' && c != null && c != undefined) {

                    output += " " + c + " ";
                }
                else {
                    if ((c == '' || c == null) && (CID.length != 0)) {
                        output = "";
                        return output;
                    }
                }
                if (d != '' && d != null && d != undefined) {
                    if (c == 'LIKE' || c == 'NOT LIKE')
                        output += " ''%" + d + "%'' ";
                    else
                        output += " ''" + d + "'' ";
                }
                else {
                    if ((d == '' || d == null) && (DID.length != 0)) {
                        output = "";
                        return output;
                    }
                }
            }
            return output;
        }
        function clearAdvancedFilter() {
            SearchRecords = "0";
            $('#divFilterTable').html('<button data-bs-toggle="tooltip" data-placement="bottom" data-container="body" title="" id="addrow" class="" data-bs-original-title="Click here to Add More">Add rules <i class="fas fa-plus"></i></button>');
            counter = 0;
            $('#queryText').val('');
            $('#queryText').removeClass("unsavedText");
            $('#divQueryText').hide();
            $('#divAdvancedFilterSave').hide();
            $('#lblAdvancedFilterEdit').text('');
            $('#lblAdvancedFilterEdit').hide();
            $('#editqueryid').val('');
            //Added By Reshma Chavan on 18th Nov 2021
            //$("#lblBasicFilterEdit").hide();
            //$('#spnappliedfilter').html("NA");
        }
        function GenerateAdvancedFilterTable() {

            //counter = 1;
            var newRow = $("<ul class='addrowsmore' id='addrowsmore" + counter + "'>");
            var cols = "";

            $('button#addrow').prop('disabled', true).css({ 'opacity': '0.5' });
            cols += '<li style="width:110px"></li><li class=""><select id="foBfilterRowCount" onchange="changefoB(' + counter + ', this.value);" class="form-control" name="foBfilterRowCount">';
            cols += strFilterFieldList;
            cols += '</select ></li > ';
            cols += '<li class=""><select id="foCfilterRowCount"  class="form-control" name="foCfilterRowCount">';
            cols += strOperatorList;
            cols += '</select ></li > ';
            cols += '<li id="fvaluefilterRowCount" class=""><input id="foDfilterRowCount" type="text" class="advncfiltertextfieldvalue form-control" name="foDfilterRowCount"/></li>';
            cols += '<li style="width:27px"></li>';
            //cols += '<li class="del_add_rules"><button data-toggle="tooltip" data-placement="top" title="clear" id="ibtnDel" class="nostylebtn"><img src="../../../Whizible2.0-new/dist/img/close.svg" width="13px"></button></li>';

            cols = cols.replace(/filterRowCount/g, counter);
            newRow.append(cols);
            $("#divFilterTable").append(newRow);
            counter++;
            $('#divQueryText').show();
            $('#divAdvancedFilterSave').show();
        }
        function BindAdvancedFilterTable(qtext) {

            qtext = qtext.toUpperCase();
            var isAnd = qtext.indexOf(' AND ');
            var isOr = qtext.indexOf(' OR ')
            var logOp = "";
            var totalRow = 0;
            if (isAnd > 0) {
                var rowsAnd = qtext.split(' AND ');
                for (i = 0; i < rowsAnd.length; i++) {
                    var isOrinAnd = rowsAnd[i].indexOf(' OR ')
                    if (isOrinAnd > 0) {
                        var rowsOr = rowsAnd[i].split(' OR ')
                        for (j = 0; j < rowsOr.length; j++) {
                            if (i == 0 && j == 0) {
                                logOp = "";
                            }
                            else if (j == 0) {
                                logOp = "1";
                            }
                            else {
                                logOp = "0";
                            }
                            if (totalRow > 0) BindAdvancedFilterNewRow(totalRow);
                            BindAdvancedFilterValues(totalRow, logOp, rowsOr[j]);
                            totalRow++;
                        }
                    }
                    else {
                        if (i == 0) {
                            logOp = "";
                        }
                        else {
                            logOp = "1";
                        }
                        if (totalRow > 0) BindAdvancedFilterNewRow(totalRow);
                        BindAdvancedFilterValues(totalRow, logOp, rowsAnd[i]);
                        totalRow++;
                    }

                }
            }
            else if (isOr > 0) {
                var rowsOr = qtext.split(' OR ')
                for (j = 0; j < rowsOr.length; j++) {
                    if (totalRow > 0) BindAdvancedFilterNewRow(totalRow);
                    if (j == 0) {
                        logOp = "";
                    }
                    else {
                        logOp = "0";
                    }
                    BindAdvancedFilterValues(totalRow, logOp, rowsOr[j]);
                    totalRow++;
                }
            }
            else {
                logOp = "";
                BindAdvancedFilterValues(totalRow, logOp, qtext);
            }
        }
        function BindAdvancedFilterNewRow(cnt) {

            var newRow = $("<ul class='addrowsmore' id='addrowsmore" + counter + "'>");
            var cols = "";
            cols += '<li class="andorswitch" "name' + counter + '"><div class="btn-group" id="foAfilterRowCount" data-bs-toggle="buttons"><label id="foAANDfilterRowCount" name="foAANDfilterRowCount" class="btn btn-default btn-on btn-sm active"><input type="radio" value="1" name="foAfilterRowCount">AND</label><label id="foAORfilterRowCount" name="foAORfilterRowCount" class="btn btn-default btn-off btn-sm "><input type="radio" value="0" name="foAfilterRowCount">OR</label></div></li>';
            cols += '<li class=""><select id="foBfilterRowCount" onchange="changefoB(filterRowCount, this.value);" class="form-control" name="foBfilterRowCount">';
            cols += strFilterFieldList;
            cols += '</select ></li > ';
            cols += '<li class=""><select id="foCfilterRowCount"  class="form-control" name="foCfilterRowCount">';
            cols += strOperatorList;
            cols += '</select ></li > ';
            cols += '<li id="fvaluefilterRowCount" class=""><input id="foDfilterRowCount" type="text" class="advncfiltertextfieldvalue form-control" name="foDfilterRowCount"/></li>';
            cols += '<li class="del_add_rules"><button data-bs-toggle="tooltip" data-placement="top" title="clear" id="ibtnDel" class="nostylebtn"><img src="../../../Whizible2.0-new/dist/img/close.svg" width="13px"></button></li>';

            cols = cols.replace(/filterRowCount/g, cnt);
            newRow.append(cols);
            $("#divFilterTable").append(newRow);
        }
        function BindAdvancedFilterValues(cnt, logOp, qtext) {

            var field = qtext.substr(0, qtext.indexOf(' '));
            var op = "";
            var valstr = "";

            var opstr = qtext.substr(qtext.indexOf(' '), qtext.length).trim();
            var opchar = opstr.substr(0, 1);
            if (opchar == "N" || opchar == "L") {
                if (opchar == "N") op = "NOT LIKE";
                if (opchar == "L") op = "LIKE";
                valstr = opstr.substr(op.length, opstr.length).trim();
                val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 4);
            }
            else {
                op = opstr.substr(0, opstr.indexOf(' '));
                valstr = opstr.substr(op.length, opstr.length).trim();
                val = valstr.substr(1, valstr.length - 2);
            }
            if (logOp != "") {
                $("input[name='foA" + cnt + "'][value=" + logOp + "]").attr('checked', 'checked');
                if (logOp == 1) {
                    $('#foAOR' + cnt).removeClass('active');
                    $('#foAAND' + cnt).addClass('active');

                }
                else {
                    $('#foAAND' + cnt).removeClass('active');
                    $('#foAOR' + cnt).addClass('active');
                }
            }
            $('#foB' + cnt).val(field).change();
            changefoB(cnt, field);
            $('#foC' + cnt).val(op).change();
            $('#foD' + cnt).val(val).change();

        }
        function BindBasicFilterOptions(qtext) {
            //
            qtext = qtext.replace(/\'/g, '`');
            qtext = qtext.replace(/``/g, '`');
            qtext = qtext.trim();
            var isRD = qtext.indexOf('ReportedDate');
            if (isRD > 0) {
                //qtext = qtext.replace(/\'/g, '`');
                var rd = qtext.substr(1, 51).replace(' BETWEEN ', '#').replace(' AND ', '#').replace(/`/g, '').split('#');
                $('#txtReportedFrom').val(rd[1]);
                $('#txtReportedTo').val(rd[2]);
                qtext = qtext.substr(54).replace(' AND ', '');
            }
            var isDD = qtext.indexOf('DueDate');
            if (isDD > 0) {
                //qtext = qtext.replace(/\'/g, '`');
                var dd = qtext.trim().substr(1, 46).replace(' BETWEEN ', '#').replace(' AND ', '#').replace(/`/g, '').split('#');
                $('#txtDueDateFrom').val(dd[1]); 3
                $('#txtDueDateTo').val(dd[2]);
                qtext = qtext.trim().substr(49).replace(' AND ', '');
            }
            var isAnd = qtext.indexOf(' AND ');
            if (isAnd > 0) {
                var rowsAnd = qtext.split(' AND ');
                for (i = 0; i < rowsAnd.length; i++) {
                    var fieldlength = rowsAnd[i].indexOf(' IN') - 1;
                    var field = rowsAnd[i].substr(1, fieldlength).replace('(', '').trim();
                    var optionstext = rowsAnd[i].substr(fieldlength + 5).replace(/`/g, '').replace('))', '').trim();
                    var arroptions = optionstext.split(',');
                    BindOptionValues(field, arroptions);
                }
            }
            else {
                var fieldlength = qtext.indexOf(' IN') - 1;
                var field = qtext.substr(1, fieldlength).replace('(', '').trim();
                var optionstext = qtext.substr(fieldlength + 5).replace(/`/g, '').replace('))', '').trim();
                var arroptions = optionstext.split(',');
                BindOptionValues(field, arroptions);
            }
        }
        function BindOptionValues(ctrl, arroptions) {
            //
            var liname = sli + sf + ctrl;
            var field = sf + ctrl;
            var options = document.getElementsByName(liname);
           
            
            $('#' + field).parents('.fplistbox').find('.fplist_title').css({ 'background': '#2e51a2', 'color': '#ffffff' });
            //Added by dipali V on 9th Sep 2019 for check one checkbox then all   should checkbox
            //if (arroptions.length == options.length)
            //    $('#' + field).parents('.fplistbox').find('.checkAll').prop("checked", true);
            //End of Added by dipali V on 9th Sep 2019 for check one checkbox then all   should checkbox
            for (var i = 0; i < arroptions.length; i++) {
                for (var j = 0; j < options.length; j++) {
                    if (arroptions[i] == options[j].value) {
                        options[j].checked = true;
                        break;
                    }
                }
            }
        }
        function FindDuplicateFilter(filter, id) {
            var filters = document.getElementById("SavedFiltersdropdown");
            for (var i = 0; i < filters.childNodes.length; i++) {
                if (filters.childNodes[i].innerText.trim().toUpperCase() == filter.toUpperCase() && filters.childNodes[i].id != "filter" + id) {
                    return true;
                    break;
                }
            }

        }
        //function FindDuplicateView(view) {
        //   // 
        //    var views = document.getElementById("viewlist");
        //    for (var i = 0; i < views.childNodes.length; i++) {

        //        var vname = views.childNodes[i].innerText;
        //        if (vname != null && vname != undefined) {
        //            vname = vname.substr(0, vname.indexOf('(') - 1);
        //            if (vname.toUpperCase() == view.toUpperCase()) {
        //                return true;
        //                break;
        //            }
        //        }
        //    }
        //}

        //replace following function
        function FindDuplicateView(view, vid) {
            //  
            var views = document.getElementById("viewlist");
            for (var i = 0; i < views.childNodes.length; i++) {
                var hvid = views.childNodes[i].cells[7].innerText.trim();
                if (vid != hvid) {
                    var vname = views.childNodes[i].innerText;
                    if (vname != null && vname != undefined) {
                        vname = vname.substr(0, vname.indexOf('(') - 1);
                        if (vname.toUpperCase() == view.toUpperCase()) {
                            return true;
                            break;
                        }
                    }
                }
            }
        }
        function IsEditFilter() {
            if (filteredit == true) {
                $("#leaveConfirmAlert").modal("show");
                //$("#leaveConfirmAlert").show();
            }
        }
        function clearAllFieldsFromTrascking() {
            //$('#cboFlagTo option').each(function () {
            //    $(this).removeAttr("selected");
            //});
            $("#cboFlagTo").val(-1).change();
            $('#clearflag').css('visibility', 'hidden');
            $("#trackingtype").val("");
            $("#flagcomplete1").prop("checked", false);

        }
        function ShowTrackingDetails(IssueID) {
            
            $("#isstrackingflag").modal("show");
            var Summery = $("#hSummary" + IssueID + "").val();
            $("#lblIssueID").text(IssueID);
            $("#txtSummary").html("<strong>Issue :</strong> " + Summery + "");
            clearAllFieldsFromTrascking();

            var issueParameters = {
                intEmployeeID: EmployeeID,
                ContextID: IssueID,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/GetTrackingDetails", param, false);
            if (strResult != undefined) {
                
                for (var i = 0; i < strResult.length; i++) {
                    var d = strResult[i];
                    var FlagTo = d.FlagTo;
                    var DueDate = d.DueDate;
                    var IsComplete = d.IsComplete;
                    $('#hdnUniqueID').val(d.UniqueID);
                    $('#clearflag').css('visibility', 'visible');
                    if (FlagTo != "") {
                        $('select[name=cboFlagTo]').val(FlagTo);
                        // $("#cboFlagTo option[value='" + FlagTo + "']").attr("selected", "selected");
                        $(".selectpicker").selectpicker('refresh');
                    }
                    //start vishal mahajan 04-12-2019
                    if (IsComplete == "1") {
                          $('#clearflag').css('visibility', 'hidden');
                    } else {
                          $('#clearflag').css('visibility', 'visible');
                    }
                    //end vishal mahajan 04-12-2019
                    var date = new Date(DueDate);
                    $("#trackingtype").datepicker('setDate', date);
                    // $("#trackingtype").val(DueDate);
                    if (IsComplete == "1") {
                        $("#flagcomplete1").prop("checked", true);
                    }
                    else {
                        $("#flagcomplete1").prop("checked", false);
                    }
                }
            }
        }
        function SaveTrackingDetails() {

            if ($("#cboFlagTo").val() == "-1") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Select Flag To.', 'error');
                //Added By Dipali V On 20th Sep 2019 For Control Focus
                $("#cboFlagTo").focus();
                return;
            }
            if ($("#trackingtype").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Select Due Date.', 'error');
                   $("#trackingtype").focus();
                return;
            }
            //Added By Dipali V On 20th Dec 2019 For Tracking Date Validation
            if ($("#trackingtype").val() != "") {
               // debugger;
                var GivenDate = $("#trackingtype").val();
               
                //var CurrentDate = $.datepicker.formatDate('yy/mm/dd', new Date());
                //GivenDate = $.datepicker.formatDate('yy/mm/dd', new Date(GivenDate));
                var CurrentDate = SelectedCurrentdate.toShortFormat();
                var checkval = 0;
                if ($("#flagcomplete1").prop("checked") == true)
                {
                    checkval=1;
                    if (ischeck == 1) {
                       // if ($("#trackingtype").val() < CurrentDate) {
                         if (Date.parse(GivenDate) < Date.parse(CurrentDate)) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Please enter Due date greater than or equal to today's date.", 'error');
                            $("#trackingtype").focus();
                            return;
                        }
                    }
                }
               // if (GivenDate >= CurrentDate) {
                 if (Date.parse(GivenDate) >= Date.parse(CurrentDate)) {



                }
                else
                {
                    if ($("#flagcomplete1").prop("checked") == false) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Please enter Due date greater than or equal to today's date.", 'error');
                        $("#trackingtype").focus();
                        return
                    }
                    //}
                }
				//Added By Rutuja D. on 21 Jun 2021 For Restrict DUe date should be less than Project EndDate IssueID = 30198
                var result = GetProjectStartDateEndDate();
                for (var i = 0; i < result.length; i++) {
                    var ObjDate = result[i];
                    if (Date.parse(ObjDate.expectedenddate) < Date.parse(GivenDate)) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Due date should not be greater than 'Project End Date " + result[i].expectedenddate + "'", 'error');
                        $("#trackingtype").focus();
                        return
                    }
                }
				//End Of Added By Rutuja D. on 21 Jun 2021 For Restrict DUe date should be less than Project EndDate IssueID = 30198

            }
             //End of Added By Dipali V On 20th Dec 2019 For Tracking Date Validation
           // return;
            var IssueID = $("#lblIssueID").text();

            var IsChecked = $("#flagcomplete1").is(':checked') ? 1 : 0;
            var DueDate = $("#trackingtype").val();
            var FlagTo = $("#cboFlagTo").val();
            var ProjectID = $("#projectid").val();

            var issueParameters = {
                intEmployeeID: EmployeeID,
                IssueID: IssueID,
                DueDate: DueDate,
                FlagTo: FlagTo,
                IsComplete: IsChecked,
                ProjectID: ProjectID
            }
            StartLoader("#bodyIssueList");
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/SaveTrackingDetails", param, false);
            if (strResult == "Success") {
                ShowTrackingDetails(IssueID);
                //Commented & Added By Dipali V On 12th Nov 2021 For Getting Proper View Type
               // var viewtype = $('#viewtype').val();
                var viewtype = $('#cboAccessFilter').val();
                  //End of Commented & Added By Dipali V On 12th Nov 2021 For Getting Proper View Type
                 //Commented By Nikhil Adkar
                getIssueList(ProjectID, viewtype);
                    //End of Commnetd BY Nikhil Adkar
                //Commented by dipali v on 3rd oct 2019 for rescrict to close popup
                //$("#isstrackingflag").modal("hide");
                StopAjaxLoader("#bodyIssueList");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Tracking Details saved successfully.", 'success');
                //End of Commented by dipali v on 3rd oct 2019 for rescrict to close popup
            }

        }

        var ischeck = 0;
        $("#trackingtype").change(function () {
           ischeck = 1;
           var IschangedDate = $("#trackingtype").val();

        });
        function ClearTrackingFlag() {
            var uid = $('#hdnUniqueID').val();
            var issueParameters = {
                UniqueID: uid,
            }
            var param = JSON.stringify(issueParameters);
            var strResult = AJAXCallWithResult("/api/Issue/ClearTrackingDetails", param, false);
            if (strResult == "Success") {
                ischeck = 0;
                $("#isstrackingflag").modal("hide");
                //var viewtype = $("#viewtype").val();
                 var viewtype = $("#cboAccessFilter").val();
                var pid = $('#projectid').val();
                //Uncommented by dipali v on 6th july 2023 For clear flag and get result of list
                  //Commented By Nikhil Adkar
                   getIssueList(pid, viewtype);
                    //End of Commnetd BY Nikhil Adkar
                //End of Uncommented by dipali v on 6th july 2023 For clear flag and get result of list
            }
        }
        function Export_PDFClick(ReportFormat) {
            //Added By Reshma Chavan on 25th oct 2021 For Export Report Change
            var pid = $('#projectid').val();
            //Commented & Added By Dipali V on 9th Nov 2021
            //var viewtype = $('#viewtype').val();
            var viewtype = $("#cboAccessFilter").val();
             //End of Commented & Added By Dipali V on 9th Nov 2021
            var IsExport = 1;
              //Commented By Nikhil Adkar
                    //getIssueList(pid, viewtype);
                    //End of Commnetd BY Nikhil Adkar
            //End of Added By Reshma Chavan on 25th oct 2021 For Export Report Change

            var SessionViewID = "", SessionProjectID = "";
            SessionViewID = $('#viewid').val();
            if (SessionViewID == "0") {
                SessionViewID = "";
            }
            SessionProjectID = $("#projectid").val();
            var strSessionResult = ajaxCall("IssueList.aspx/AssigntoSession", "POST", "application/json;charset=utf-8", "json", JSON.stringify({ strSQL: SessionIssueSQL, DisplayMode: SessionDisplayMode, ViewID: SessionViewID, ProjectID: SessionProjectID }));
            window.open("../../IB/IB_ShowReport.aspx?Mode=EXPORT&Format=" + ReportFormat + "&ProjectID=" + SessionProjectID + "");
            //Added By Reshma Chavan on 25th oct 2021 For Export Report Change           
            IsExport = 0;           
            //End of Added By Reshma Chavan on 25th oct 2021 For Export Report Change
        }
        $('#trackingtype,#txtReportedFrom,#txtReportedTo,#txtDueDateFrom,#txtDueDateTo').datepicker({
            autoclose: true,
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd M yy'
        });
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
                    $("#issuelisttblmain").parent("div.col-sm-12").addClass("table-responsive");
                },
                error: function (err) {

                    console.log(err);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + "";
                }
            });


            return ajaxResult;
        }

        //Added & commented by dipali V On 30th Sep 2019 For If Project Not selected then Alert Should come

        $("#divExportReport").click(function () {

            if ($("#cboIssueProjects").val() == 0) {
                $("#btnexport").removeAttr("data-bs-toggle");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Select Project', 'error');
                return;

            } else {

                $("#btnexport").attr("data-bs-toggle", "dropdown");
            }


        });


        $("#AccessFilter").click(function () {
            //
            if ($("#cboIssueProjects").val() == 0) {
                $("#AccessFilter").find('button').removeAttr("data-bs-toggle");
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Select Project', 'error');
                return;

            } else {

                $("#AccessFilter").find('button').attr("data-bs-toggle", "dropdown");
            }


        });
        //End of Added & commented by dipali V On 30th Sep 2019 For If Project Not selected then Alert Should come





        function IssueID_OnClick(IssueID, tab) {
            StartLoader("#bodyIssueList");
            var url = "<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString()%>";

            var ProjectID = $("#cboIssueProjects :selected").val();

            var ProjectName = $("#cboIssueProjects :selected").text();
            var validatedparameter = IssueID + ProjectID;
            var token;
            $.ajax({
                url: url + '/api/IB_IssueDetails/generateToken',
                type: 'POST',
                // data:JSON.stringify(projectId),
                data: JSON.stringify(validatedparameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (validatedparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(validatedparameter) ? validatedparameter : JSON.stringify(validatedparameter)));
                    }
                },
                success: function (result) {
                    //
                    //StartLoader("#bodyIssueList");
                    token = result;
                    //alert(token);
                    var vid = $('#viewid').val();
                    //Added by Swapnagandha K. On 24 Oct 2019 To Save Filter View Type
                    var vType = $('#cboAccessFilter').val();
                    //Commented And Added By Reshma Chavan on 29th oct 2021
                    //var secondfilter = $("#secondfilter").val();
                    var secondfilter = $('#searchoptiontext').val();
                    var FirstFilter = $("#unsavedquerytext").val();

                    if (secondfilter != "") {
                        if (secondfilter.indexOf("''") > -1) {
                            secondfilter = secondfilter.replace(/\''/g, "'");
                        }
                    }
                    if (FirstFilter != "") {
                        if (FirstFilter.indexOf("''") > -1) {
                            FirstFilter = FirstFilter.replace(/\''/g, "'");
                        }
                    }

                    var SavedQueryName = $("#queryname").val();
                    var EmployeeID = $("#EmployeeID").val();
                    var QueryID = $("#queryid").val();
                    var QueryType = $('#querytype').val();
                    // var QueryType = $('#querytype').val();

                    //alert(FirstFilter);
                    //alert(secondfilter);
                    //Added by Chetan ;M on 16 Feb 2021 for Attachment icon click Attachment details get displayed.
                    //var url1 = "IB_IssueDetail.aspx?ProjectID=" + ProjectID + "&PKToken=" + token + "&ProjectName=" + ProjectName + "&IssueID=" + IssueID + "&IssueIDList=" + issueIdList + "&ViewType=" + vType + "&View=" + vid + "&intPageNo=" + intPageNo+ "";
                    var url1 = "IB_IssueDetail.aspx?ProjectID=" + ProjectID + "&PKToken=" + token + "&ProjectName=" + ProjectName + " &IssueID=" + IssueID + " &IssueIDList=" + issueIdList + " &ViewType=" + vType + "&View=" + vid +
                        " &intPageNo=" + intPageNo + " &tab=" + tab + "&secondfilter=" + escape(secondfilter)
                        + "&FirstFilter=" + escape(FirstFilter) + "&SavedQueryName=" + escape(SavedQueryName) +
                        "&EmployeeID=" + escape(EmployeeID) + "&QueryID=" + escape(QueryID) + "&QueryType=" + escape(QueryType) + "";
                    //End of Added by Chetan M on 16 Feb 2021 for Attachment icon click Attachment details get displayed.
                    //End Added by Swapnagandha K. On 24 Oct 2019 To Save Filter View Type
                   // alert(url1);
                    window.location.href = url1;

                },
                error: function (xhr, errorThrown) {
                    // console.log(err);
                }
            });
        }
        //Ended by Chetan Muley To open IssueDetails Page and token generation on 27/6/2019
        function NewIssue_OnClick() {

            var url = "<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString()%>";
            var UserName = "<%= Session("strUserName").ToString() %>";
            //  RoleId = RoleId;


             <%--  var ProjectId = "<%= Session("intProjectID").ToString() %>";--%>
            var ProjectId = $("#cboIssueProjects :selected").val();
            if (ProjectId == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Select Project', 'error');
                return;
            }
            var validatedparameter = UserName + RoleId + ProjectId;
            var token;
            $.ajax({
                url: url + '/api/IB_AddNewIssue/generateToken',
                type: 'POST',
                // data:JSON.stringify(projectId),
                data: JSON.stringify(validatedparameter),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (validatedparameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(validatedparameter) ? validatedparameter : JSON.stringify(validatedparameter)));
                    }
                },
                success: function (result) {
                    var vid = $('#viewid').val();
                    StartLoader("#bodyIssueList");
                    token = result;
                    var HeaderCaption = $(parent.document.getElementById('mainHeadingTop'));
                    HeaderCaption.text("");
                    //HeaderCaption.text("Issues > Add New Issue");
                    var vType = $('#viewtype').val();
                    HeaderCaption.text("Issues > Add Issue");
                    var url1 = "IB_AddNewIssue.aspx?PKToken=" + token + "&UserName=" + UserName + "&RoleId=" + RoleId + "&ProjectId=" + ProjectId + "&View=" + vid + "&ViewType=" + vType;

                    window.location.href = url1;

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });

        }

        //$("#licorporateview").click(function () {


        //    $("#licorporateview").css("color", "#81cf09");
        //    //$("#licorporateview").addClass('text-success')
        //});

        $('#DashboardButton').click(function () {

            StartLoader("#bodyIssueList");
            var HeaderCaption = $(parent.document.getElementById('mainHeadingTop'));
            ProjectId = $('#cboIssueProjects').val();
            HeaderCaption.text("");
            //PageName = "IB_CopyIssue.aspx";
            HeaderCaption.text("Issues > Dashboard");
            var ProID = $('#cboIssueProjects option:selected').text();
            var vid = $('#viewid').val();
            var vType = $('#viewtype').val();
            var url = "IB_Dashboard.aspx?PKToken=<%=m_PKToken_FromIssueList%>&ProjectID=" + ProjectId + " &ProID=" + ProID + "&View=" + vid + "&ViewType=" + vType;
            window.location.href = url;

        });



        //Added By Dipali V On 24th Sep 2019 For View Should be apply we project was selected
        function View_onclick() {
            //Added By Dipali V On 16th April 2020 For hide tooltip
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('dispose');
            });
           //End of Added By Dipali V On 16th April 2020 For hide tooltip
            if ($('#cboIssueProjects').val() != "0") {

                $('#viewapplied').modal('show');
            }
            else {
                //Added By Dipali V On 13th Feb 2021 For Alter Change
                alertify.set('notifier', 'position', 'top-right');
                //alertify.notify('Please select project.', 'error');
                alertify.notify('Please Select Project.', 'error');
                //End of Added By Dipali V On 13th Feb 2021 For Alter Change
                $('#cboIssueProjects').focus()
                return;

            }



        }
        //End of Added By Dipali V On 24th Sep 2019 For View Should be apply we project was selected






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
        /*New Filter End */

        //Added By Dipali V On 13th Aug 2019 For Open Copy Issue with PK token
        function IssueTab_OnClick(Flag) {
            // debugger;
            //alert(Flag)
            //StartLoader("#bodyIssueList");
            var PageName = "";
            var ProjectName = "";
            var HeaderCaption = $(parent.document.getElementById('mainHeadingTop'));
            ProjectId = $('#cboIssueProjects').val();
            ProjectName = $('#cboIssueProjects option:selected').text();
            if (ProjectId == 0) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Please Select Project', 'error');
                return;
            }
            //debugger;
            var vid = $('#viewid').val();
            var vType = $('#viewtype').val();
            if (Flag == 'CopyIssue') {
                HeaderCaption.text("");
                //PageName = "IB_CopyIssue.aspx";
                HeaderCaption.text("Issues > Issue Copying");
                var url = "IB_CopyIssue.aspx?PKToken=<%=m_PKToken_FromIssueList%>&ProjectID=" + escape(ProjectId) + " &ProjectName=" + escape(ProjectName) + "&View=" + vid + "&RoleID=" + roleid + "&ViewType=" + vType;
                window.location.href = url;
            } else if (Flag == 'UpdateIssue') {
                HeaderCaption.text("");
                //PageName = "IB_BulkUpdate.aspx";
                HeaderCaption.text("Issues > Bulk Update");
                var url = "IB_BulkUpdate.aspx?PKToken=<%=m_PKToken_FromIssueList%>&ProjectID=" + escape(ProjectId) + " &ProjectName=" + escape(ProjectName) + "&View=" + vid + "&RoleID=" + roleid + "&ViewType=" + vType;
                console.log(url);
                window.location.href = url;
            }
            else if (Flag == 'cbolink') {
                //
                var Value = $("#" + Flag).val();
                if (Value != "") {
                    var LinkName = $("#" + Flag + " option:selected").attr("PageName");
                    // $( "#myselect option:selected" ).text();
                    var Attribute = $("#" + Flag + " option:selected").attr("Caption");

                    HeaderCaption.text("");
                    HeaderCaption.text("Issues > " + Attribute);
                    var url = "" + LinkName + "?PKToken=<%=m_PKToken_FromIssueList%>&ProjectID=" + ProjectId + " &ProjectName=" + ProjectName;
                    window.location.href = url;
                }
            }
        }

        function restrictAlphabets(e) {
            //

            //  $("#textNoOfResource").val();
            var x = e.which || e.keycode;
            if ((x >= 48 && x <= 57) || x == 8 ||
                (x >= 35 && x <= 40) || x == 46)
                return true;
            else
                return false;
        }


        function checkSpecialCharacter(value) {
            var regularExpression = '{}|`~[]<>\!"@#$%^&*()_+-=\'/';
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
        //End of Added By Dipali V On 13th Aug 2019 For Open Batch Issue with PK token

        //Added By Dipali V On 13th Aug 2019 For check Is Project Over Or Not
        var ProjectOver;
        function CheckProjectOver(pid) {
            // alert(pid);
            var url = "<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl").ToString()%>";
            issueParameters = {
                intProjectID: pid,
            }
            $.ajax({
                url: url + '/api/IB_CopyIssue/CheckProjectOver',
                type: 'POST',
                data: JSON.stringify(issueParameters),
                dataType: 'json',
                async: false,
                contentType: "application/json",
                beforeSend: function (xhr) {
                     xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token"));
                    if (issueParameters) {
                        xhr.setRequestHeader("Params", encryptString(isJson(issueParameters) ? issueParameters : JSON.stringify(issueParameters)));
                    }
                },
                success: function (result) {

                    ProjectOver = result;
                    if (ProjectOver == 1) {
                        $("#copylink").prop("onclick", null).off("click");
                        //$('#copylink').css('pointer-events', 'none');
                        $('#copylink').attr('title', 'Selected Project was over,You can not copy issue');
                        $("#BulkUpdateButton").prop("onclick", null).off("click");
                        $('#BulkUpdateButton').attr('title', 'Selected Project was over,You can not update issue in bulk');
                        //$('#BulkUpdateButton').css('pointer-events', 'none');
                    }
                    else if (ProjectOver == 0) {
                        $('#copylink').removeAttr('title', '');
                        $('#BulkUpdateButton').removeAttr('title', '');
                    }

                },
                error: function (xhr, errorThrown) {
                    //alert("error ");
                }
            });
        }


        $("#isstrackingflag .close").click(function () {
            $(".slctedtfirst li").removeClass("selected");

        });

        //Addded By pradip on 12 Nov 2019 for height calculation
        function SetWindowHeight() {
            var height = $(window).height();
            // Reserve space for top toolbar, filters, and pagination footer
            var layoutMaxHeight = height - 200;
            if (layoutMaxHeight < 220) {
                layoutMaxHeight = 220;
            }
            var paginationRowHeight = $(".issue-list-pagination-row").outerHeight(true) || 40;
            var tableAreaHeight = layoutMaxHeight - paginationRowHeight;
            if (tableAreaHeight < 160) {
                tableAreaHeight = 160;
            }
            $(".issue-list-table-layout").css("max-height", layoutMaxHeight + "px");
            $(".table-outer-main").css({ height: tableAreaHeight + "px", overflow: "hidden" });
            var resizeWrapper = document.getElementById("resize_wrapper");
            if (resizeWrapper) {
                resizeWrapper.style.height = "100%";
                resizeWrapper.style.overflowY = "auto";
                resizeWrapper.style.overflowX = "auto";
            }
        }
        $(window).on("load resize scroll", function (e) {
            SetWindowHeight(this);
        });

        //remove tooltip





        //remove tooltip
        $('body').tooltip({
            selector: '[data-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
            trigger: 'hover',
            container: 'body'
        }).on('click mousedown mouseup', '[data-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
            $('[data-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
        });


         //Added By Dipali V On 16th April 2020 For hide tooltip
        function close_view() {

          //Added By Dipali V On 16th April 2020 For hide tooltip
            $('body').tooltip({
                selector: '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])',
                trigger: 'hover',
                container: 'body'
            }).on('click mousedown mouseup', '[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])', function () {
                $('[data-bs-toggle="tooltip"], [title]:not([data-bs-toggle="popover"])').tooltip('destroy');
            });
           //End of Added By Dipali V On 16th April 2020 For hide tooltip
        }
         //End of Added By Dipali V On 16th April 2020 For hide tooltip

        //Added By Usha Pandit On 16.06.2020 for restricting alphabates for Due Date
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
        //End Of Added By Usha Pandit On 16.06.2020 for restricting alphabates for Due Date






        function Openpage() {
            window.location.href = "../../IB/IBIssueList.aspx?StartPage=1&FromWhere=BTS";

        }
        function PrevList() {
            StartLoader("#bodyIssueList");//Added By Dipali V On 2nd Sep for JDTIAC Upgarde
            if (intPageNo <= 1) {
                intPageNo = 1;
            }
            else {
                intPageNo -= 1;
            }
              var pid = $("#projectid").val();
            var viewtype = $('#viewtype').val();
            //getViewList(pid);
             //Added By Nikhil Adkar on 24-Mar-2026 for pagination is not working.
                    getIssueList(pid, viewtype);
            //End of Added By Nikhil Adkar on 24-Mar-2026 for pagination is not working.
            
             //Added By  Dipali V On 2nd Sep 2020 For JDTIAC Upgarde
            Pagination();
              //End of Added By  Dipali V On 2nd Sep 2020 For JDTIAC Upgarde
             StopAjaxLoader("#bodyIssueList");//Added By Dipali V On 2nd Sep for JDTIAC Upgarde
        }
        function NextList() {
            StartLoader("#bodyIssueList");//Added By Dipali V On 2nd Sep for JDTIAC Upgarde

            //Added By Reshma Chavan on 27th oct 2021 For No Data Available Random Issue 
            //intPageNo += 1;
            intPageNo ++;
            //End of Added By Reshma Chavan on 27th oct 2021 For No Data Available Random Issue

              var pid = $("#projectid").val();
            var viewtype = $('#viewtype').val();
            //getViewList(pid);
              //Commented By Nikhil Adkar
                    //getIssueList(pid, viewtype);
                    //End of Commnetd BY Nikhil Adkar
             //Added By  Dipali V On 2nd Sep 2020 For JDTIAC Upgarde
            Pagination();
              //End of Added By  Dipali V On 2nd Sep 2020 For JDTIAC Upgarde
             StopAjaxLoader("#bodyIssueList");//Added By Dipali V On 2nd Sep for JDTIAC Upgarde
        }
        //Script added by Pradip p on 2-9-2020
        function resizeSection() {

            var tblheight = $(window).height();
            $('.content').css({ 'height': tblheight - 30, "overflow-y": "auto" });
        }
        $(window).on("load resize scroll", function (e) {
            resizeSection(this);

        });    

		//Added By Rutuja D. on 21 Jun 2021 For Restrict DUe date should be less than Project EndDate IssueID = 30198
        function GetProjectStartDateEndDate() {
            var ProjectID = $("#projectid").val();
            var param = JSON.stringify(ProjectID);
            var result = AJAXCallWithResult("/api/Issue/GetProjectStartDateEndDate", param, false); $("#TotalRecords").html(TotalRecords);
            if (result != undefined) {
                return result;
            }
        }
        //End of Added By Rutuja D. on 21 Jun 2021 For Restrict DUe date should be less than Project EndDate IssueID = 30198

        $(".ui-datepicker").click(function () {
            $('.tooltip').remove();
        });

        $(".listboxpanel").click(function () {
            $('.tooltip').remove();
        });
        $(".listboxpanel").hover(function () {
            $('[data-bs-toggle="tooltip"], option').tooltip('update');
        });
        
      

    </script>

</body>
</html>
