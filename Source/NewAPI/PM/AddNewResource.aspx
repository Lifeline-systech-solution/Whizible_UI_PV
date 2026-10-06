<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AddNewResource.aspx.vb" Inherits="PbNIT.AddNewResource" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
        <!-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
 <%CommonFunctions.General.PlotPageHeadTag("")%>
<head runat="server">
   <%-- <title></title>--%>
</head>
<body>
     <!-- Content Wrapper. Contains page content -->
    <div class="bgwhite wbs">
        <!-- Content Header (Page header) -->
    <!-- Content Header (Page header) -->
            <div class="graybg container-fluid pt-1 pb-1 resourcepanelheader">
                <div class="row">
                    <div class="col-sm-3">
                        <div class="toplinkss">
                            <!-- <a href="resource-request.html" class="btn btn-gray">Resource request List</a> --> <a href="javascript:;" data-toggle="modal" data-target="#resourcerequest" class="btn btn-white">Resource request</a>    
                        </div>
                    </div>
                    <div class="col-sm-6 form-inline text-center">
                        <div class="form-group">
                            <select class="form-control selectpicker col-sm-4">
                                <option>Select Project</option>
                                <option>Whizible</option>
                                <option>Helpdesk</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <div class="weekly_calender" id="weeklyviewcal">
                                <button data-toggle="tooltip" data-placement="top" title="Previous Week" id="prev"><i class="fas fa-caret-left"></i>
                                </button>
                                <div class="input-group-box">
                                    <div class="input-group" id="DateDemo">
                                        <input data-toggle="tooltip" data-placement="top" title="Select week date" class="form-control" type="text" id="weekPicker2" value="" />
                                    </div>
                                </div>
                                <button id="next" data-toggle="tooltip" data-placement="top" title="Next Week"><i class="fas fa-caret-right"></i>
                                </button>
                                <!-- /.input group -->
                            </div>
                            <div class="weekly_calender" id="dailyviewcal" style="display:none;">
                                <button data-toggle="tooltip" data-placement="top" title="Previous Day" class="prev-day"><i class="fas fa-caret-left"></i>
                                </button>
                                <div class="input-group-box">
                                    <div class="input-group" id="DateDemo">
                                        <input data-toggle="tooltip" data-placement="top" title="Select Day" id="dailyviewdatepicker" type="text" class="form-control" name="">
                                    </div>
                                </div>
                                <button class="next-day" data-toggle="tooltip" data-placement="top" title="Next Day"><i class="fas fa-caret-right"></i>
                                </button>
                                <!-- /.input group -->
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="filter pull-right resourcefltr">
                            <button data-toggle="collapse" data-target="#filterpanel"><i data-toggle="tooltip" data-placement="top" title="Advanced Filter" class="fas fa-filter"></i>
                            </button>
                        </div>
                        <div class="weeklyanddaily pull-right">
                            <div class="tab-slider--nav pull-right">
                                <ul class="tab-slider--tabs">
                                    <li class="tab-slider--trigger active" rel="Weeklytab" data-toggle="tooltip" data-placement="top" title="Weekly Task View"><span>Weekly</span>
                                    </li>
                                    <li data-toggle="tooltip" data-placement="top" title="Daily Task View" class="tab-slider--trigger" rel="Dailytab">Daily</li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--filter_panel_section_satrts_here-->
            <div id="filterpanel" class="collapse filterpanel" style="border-bottom: 12px solid #eee;">
                <div class="bglightgray container-fluid pt-1 pb-1 headertopp filterpanelheader">
                    <div class="row">
                        <div class="col-md-7 col-sm-7">
                            <div class="cust_tabpanel">
                                <ul class="nav nav-tabs">
                                    <li class="dropdown"><a class="dropdown-toggle" href="#" data-toggle="dropdown">My Filters  <span class="caret"></span></a>
                                        <ul id="MyFiltersdropdown" class="dropdown-menu MyFiltersdropdown" role="menu">
                                            <li>
                                                <label class="customradio">
                                                    <input class="myfilter_selectprocheckbox" data-toggle="tooltip" data-placement="bottom" id="project2" type="checkbox" name="project2" onchange="cbChange(this)"> <span data-toggle="tooltip" data-placement="right" title="Set Default filter" class="checkmark"></span>
                                                </label>
                                                <label class=""> <span for="project2" class="radiotextsty filtername">Project 2 and 3</span>
                                                </label>
                                                <div class="issfilter_actiondropdown">
                                                    <div class="custom_chckbox_markblue">
                                                        <input id="IssueselproOne" type="checkbox" name="">
                                                        <label data-toggle="tooltip" data-container="body" data-placement="bottom" title="Apply filter" for="IssueselproOne"></label>
                                                    </div> <span><i data-toggle="tooltip" data-container="body" data-placement="bottom" title="Edit filter" class="fas fa-pencil-alt" onclick="EditCategoryName();"></i></span>
                                                    <span><i data-toggle="tooltip" data-container="body" data-placement="bottom" title="Delete filter" class="far fa-trash-alt"></i></span>
                                                </div>
                                            </li>
                                            <li>
                                                <label class="customradio">
                                                    <input class="myfilter_selectprocheckbox" data-toggle="tooltip" data-placement="bottom" id="task" type="checkbox" name="task" onchange="cbChange(this)"> <span data-toggle="tooltip" data-placement="right" title="Set Default filter" class="checkmark"></span>
                                                </label>
                                                <label class=""> <span for="task" class="radiotextsty">Task and milestones</span>
                                                </label>
                                                <div class="issfilter_actiondropdown">
                                                    <div class="custom_chckbox_markblue">
                                                        <input id="IssueselproTwo" type="checkbox" name="">
                                                        <label data-toggle="tooltip" data-container="body" data-placement="bottom" title="Apply filter" for="IssueselproTwo"></label>
                                                    </div> <span><i data-toggle="tooltip" data-container="body" data-placement="bottom" title="Edit filter" class="fas fa-pencil-alt"></i></span>
                                                    <span><i data-toggle="tooltip" data-container="body" data-placement="bottom" title="Delete filter" class="far fa-trash-alt"></i></span>
                                                </div>
                                            </li>
                                            <li>
                                                <label class="customradio">
                                                    <input class="myfilter_selectprocheckbox" data-toggle="tooltip" data-placement="bottom" id="groupcompany" type="checkbox" name="groupcompany" onchange="cbChange(this)"> <span data-toggle="tooltip" data-placement="right" title="Set Default filter" class="checkmark"></span>
                                                </label>
                                                <label class=""> <span for="groupcompany" class="radiotextsty">For group company</span>
                                                </label>
                                                <div class="issfilter_actiondropdown">
                                                    <div class="custom_chckbox_markblue">
                                                        <input id="IssueselproThree" type="checkbox" name="">
                                                        <label data-container="body" data-toggle="tooltip" data-placement="bottom" title="Apply filter" for="IssueselproThree"></label>
                                                    </div> <span><i data-toggle="tooltip" data-container="body" data-placement="bottom" title="Edit filter" class="fas fa-pencil-alt"></i></span>
                                                    <span><i data-toggle="tooltip" data-container="body" data-placement="bottom" title="Delete filter" class="far fa-trash-alt"></i></span>
                                                </div>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><a href="#presetfilter" data-toggle="tab">Basic Filters</a>
                                    </li>
                                    <!-- <li><a href="#queryfilter" data-toggle="tab">Advanced Filters</a></li> -->
                                </ul>
                            </div>
                        </div>
                        <div class="col-md-5 col-sm-5">
                            <div class="form-inline pull-right">
                                <button class="btn borderbtn mrOnehalf clearfilterbtn" data-toggle="tooltip" data-placement="top" title="Delete">Clear All Filters</button>
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
                                    <div class="fp_button text-center hidden-xs centerbtn" style="margin:0 0 40px;">
                                        <button class="btn btnyellow" id="svfilterbtn" data-toggle="modal" data-target="#Issuesavefilter" data-dismiss="modal">Save and Apply</button>
                                        <button class="btn btnyellow">Apply</button>
                                    </div>
                                    <div class="row hidden-xs IB_filterlist">
                                        <!--basic filter start here-->
                                        <div class="form-inline">
                                            <div class="box box-solid p1" style="border-bottom:none; box-shadow: none; ">
                                                <div class="form-group ">
                                                    <label for="email">Skills:</label>
                                                    <select class="form-control">
                                                        <option>&lt;=</option>
                                                        <option>&lt;</option>
                                                        <option>&lt;&gt;</option>
                                                        <option>=</option>
                                                        <option>&gt;</option>
                                                        <option>&gt;=</option>
                                                    </select>
                                                    <select id="rskillfilter" class="form-control" multiple="multiple" data-live-search="true">
                                                        <option value="UX Designer">UX Designer</option>
                                                        <option value="Dot net developer">Dot net developer</option>
                                                        <option value="java developer">java developer</option>
                                                        <option value="Website designer">Website designer</option>
                                                        <option value="Content writer">Content writer</option>
                                                        <option value="Python developer">Python developer</option>
                                                    </select>
                                                </div>
                                                <div class="form-group ">
                                                    <label for="email">Organization Unit:</label>
                                                    <select class="form-control">
                                                        <option>&lt;=</option>
                                                        <option>&lt;</option>
                                                        <option>&lt;&gt;</option>
                                                        <option>=</option>
                                                        <option>&gt;</option>
                                                        <option>&gt;=</option>
                                                    </select>
                                                    <select id="roufilter" class="form-control" multiple="multiple" data-live-search="true">
                                                        <option value="Manage services">Manage services</option>
                                                        <option value="Design Services">Design Services</option>
                                                        <option value="Anaythic services">Anaythic services</option>
                                                        <option value="OU Unit one">OU Unit one</option>
                                                        <option value="OU Unit two">OU Unit two</option>
                                                        <option value="OU Unit three">OU Unit three</option>
                                                    </select>
                                                </div>
                                                <div class="form-group ">
                                                    <label for="email">Business Group:</label>
                                                    <select class="form-control">
                                                        <option>&lt;=</option>
                                                        <option>&lt;</option>
                                                        <option>&lt;&gt;</option>
                                                        <option>=</option>
                                                        <option>&gt;</option>
                                                        <option>&gt;=</option>
                                                    </select>
                                                    <select id="rbgfilter" class="form-control" multiple="multiple" data-live-search="true">
                                                        <option value="Business group one">Business group one</option>
                                                        <option value="Business group two">Business group two</option>
                                                        <option value="Business group three">Business group three</option>
                                                        <option value="Business group four">Business group four</option>
                                                    </select>
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
            <section class="content">
                <!--Weekly tab content start here-->
                <div id="Weeklytab" class="tab-slider--body">
                    <div class="row">
                        <div class="container-fluid SRtopfilter">
                            <div class="col-md-5 col-sm-5 col-xs-12">
                                <ul class="statustext hidden-xs">
                                    <li data-toggle="tooltip" data-placement="top" title="" class="criticle active" data-original-title="All"><a href="javascript:;"><span class="statustextno">20</span>All</a>
                                    </li>
                                    <li data-toggle="tooltip" data-placement="top" title="" class="criticle" data-original-title="Designer"><a href="javascript:;"><span class="statustextno">03</span>Designer</a>
                                    </li>
                                    <li data-toggle="tooltip" data-placement="top" title="" class="overdue" data-original-title="Developer"><a href="javascript:;"><span class="statustextno">05</span>Developer</a>
                                    </li>
                                    <li data-toggle="tooltip" data-placement="top" title="" class="pending" data-original-title="Tester"><a href="javascript:;"><span class="statustextno">05</span>Tester</a>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-sm-3">
                                <div class="weeklyanddaily availNDallocate">
                                    <div class="tab-slider--nav pull-right">
                                        <ul class="tab-slider--tabs">
                                            <li class="tab-slider--trigger active" rel="wbsavailbility" data-toggle="tooltip" data-placement="top" title="" data-original-title="Availibility"><span>Availibility</span>
                                            </li>
                                            <li data-toggle="tooltip" data-placement="top" title="" class="tab-slider--trigger" rel="wbsallocate" data-original-title="Allocated">Allocated</li>
                                        </ul>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>
                            <div class="col-md-4 col-sm-4 col-xs-12 text-right pt-1"> <a href="resource-allowcated.html" class="btn borderbtn">Back</a>
                                <button data-toggle="modal" data-target="#bulkallocation" data-dismiss="modal" class="btn borderbtnfill">Allocate resource</button>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                    <div class="bhwhite">
                        <div class="projectallocationpanel">

                            <!-- <table class="table table-bordered" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td width="27.3%" class="p-0">
                                        <table class="table table-bordered" width="100%" cellpadding="5" cellspacing="0">
                                            <tr>
                                                <td width="3%" class="">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="PRR1" class="chckHead">
                                                    <label for="PRR1"></label>
                                                </div>
                                            </td>
                                            <td class="">
                                                <input type="search" class="form-control" value="" id="searchCR" placeholder="search">
                                            </td>
                                            </tr>

                                            <tr>
                                              <td>&nbsp;</td>
                                            <td class="text-left sortbyrole">
                                                <div class="col-sm-4">47 People</div>
                                                <div class="col-sm-8">
                                                    <select class="form-control selectpicker">
                                                        <option>Sort by Role</option>
                                                        <option>Graphic designer</option>
                                                        <option>HTML Developer</option>
                                                    </select>
                                                </div>
                                            </td>  
                                            </tr>

                                            <tr>
                                              <td>
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="PRR2" class="chckHead">
                                                    <label for="PRR2"></label>
                                                </div>
                                            </td>
                                            <td class="text-left dropdown PRrolename">Annabel Willson
                                                <a href="javascript:;" class="nostyle hidden-xs UpDowncollapseArrow" data-toggle="collapse" data-target=".PRhiderow1" data-original-title="" title="">
                                                    <img class="uparrow" data-toggle="tooltip" data-placement="top" title="" src="dist/img/up.svg" alt="" class="" width="15px" data-original-title="Hide Task">
                                                    <img class="downarrow" data-toggle="tooltip" data-placement="top" title="" src="dist/img/down.svg" alt="" class="" width="15px" data-original-title="Hide Task">
                                                </a>
                                                <br/>
                                                <div class="smallsubtext"><span class="pull-left">Graphic designer</span>  <span class="pull-right">03 Projects</span>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="progress">
                                                    <div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>

                                            </td>  
                                            </tr>

                                            <tr>
                                                
                                            </tr>
                                            <tr>
                                                
                                            </tr>
                                            <tr>
                                                
                                            </tr>
                                            <tr>
                                                
                                            </tr>
                                            <tr>
                                                
                                            </tr>
                                            <tr>
                                                
                                            </tr>
                                            <tr>
                                                
                                            </tr>
                                        </table>
                                    </td>
                                    <td></td>
                                </tr>
                            </table> -->












                            <div class="JStableOuter">
                                <table id="table" class="PRtable">
                                    <thead>
                                      
                                    </thead>
                                    <tbody id="CRTable">
                                        <tr>
                                            <td class="">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="PRR1" class="chckHead">
                                                    <label for="PRR1"></label>
                                                </div>
                                            </td>
                                            <td class="">
                                                <input type="search" class="form-control" value="" id="searchCR" placeholder="search">
                                            </td>
                                            <td>
                                                <div class="tblmnthname">June</div>
                                            </td>
                                            <td>
                                                <div class="tblmnthname">Aug</div>
                                            </td>
                                            <td>
                                                <div class="tblmnthname">Sep</div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td class="text-left sortbyrole">
                                                <div class="col-sm-4">47 People</div>
                                                <div class="col-sm-8">
                                                    <select class="form-control selectpicker">
                                                        <option>Sort by Role</option>
                                                        <option>Graphic designer</option>
                                                        <option>HTML Developer</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td class="p-0">
                                               <table class="PRweekdaytbl" width="100%" cellspacing="0" cellpadding="10">
                                                    <tbody>
                                                        <tr>
                                                            <td>Week <span>01</span>
                                                            </td>
                                                            <td>Week <span>02</span>
                                                            </td>
                                                            <td>Week <span>03</span>
                                                            </td>
                                                            <td>Week <span>04</span>
                                                            </td>
                                                            <td>Week <span>05</span>
                                                            </td>
                                                            <td>Week <span>06</span>
                                                            </td>
                                                            <td>Week <span>07</span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>
                                                <table class="PRweekdaytbl" width="100%" cellspacing="0" cellpadding="10">
                                                    <tbody>
                                                        <tr>
                                                            <td>Week <span>08</span>
                                                            </td>
                                                            <td>Week <span>09</span>
                                                            </td>
                                                            <td>Week <span>10</span>
                                                            </td>
                                                            <td>Week <span>11</span>
                                                            </td>
                                                            <td>Week <span>12</span>
                                                            </td>
                                                            <td>Week <span>13</span>
                                                            </td>
                                                            <td>Week <span>14</span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>
                                                <table class="PRweekdaytbl" width="100%" cellspacing="0" cellpadding="10">
                                                    <tbody>
                                                        <tr>
                                                            <td>Week <span>15</span>
                                                            </td>
                                                            <td>Week <span>16</span>
                                                            </td>
                                                            <td>Week <span>17</span>
                                                            </td>
                                                            <td>Week <span>18</span>
                                                            </td>
                                                            <td>Week <span>19</span>
                                                            </td>
                                                            <td>Week <span>20</span>
                                                            </td>
                                                            <td>Week <span>21</span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="PRR2" class="chckHead">
                                                    <label for="PRR2"></label>
                                                </div>
                                            </td>
                                            <td class="text-left dropdown PRrolename">Annabel Willson
                                                <a href="javascript:;" class="nostyle hidden-xs UpDowncollapseArrow" data-toggle="collapse" data-target=".PRhiderow1" data-original-title="" title="">
                                                    <img class="uparrow" data-toggle="tooltip" data-placement="top" title="" src="dist/img/up.svg" alt="" class="" width="15px" data-original-title="Hide Task">
                                                    <img class="downarrow" data-toggle="tooltip" data-placement="top" title="" src="dist/img/down.svg" alt="" class="" width="15px" data-original-title="Hide Task">
                                                </a>
                                                <br/>
                                                <div class="smallsubtext"><span class="pull-left">Graphic designer</span>  <span class="pull-right">03 Projects</span>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="progress">
                                                    <div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
<a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>   
                                                <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                                    <li><a class="dropdown-item" href="javascript:;" data-toggle="modal" data-target="#bulkallocation" data-dismiss="modal">Allocate</a>
                                                    </li>
                                                    <li><a class="dropdown-item" href="#">Change allocation</a>
                                                    </li>
                                                    <li><a class="dropdown-item" href="#">Release</a>
                                                    </li>
                                                </ul>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="PRpercentage PRstatusLightblue">25%</td>
                                                            <td class="PRpercentage PRstatusLightblue">25%</td>
                                                            <td class="PRpercentage PRstatusLightblue">100%</td>
                                                            <td class=""></td>
                                                            <td class=""></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="PRpercentage PRstatusRed">145%</td>
                                                            <td class="PRpercentage PRstatusYellow">&nbsp;</td>
                                                            <td class="PRpercentage PRstatusBlue">100%</td>
                                                            <td class="PRpercentage PRstatusRed">115%</td>
                                                            <td class="PRpercentage PRstatusBlue">100%</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <!--hidden row start here -->
                                        <tr class="PRhiderow1 collapse">
                                            <td>&nbsp;</td>
                                            <td>
                                                <!-- <table class="resourceprojectlist PRhiddentbl" width="100%" cellpadding="10" cellspacing="0">
    <tr>
        <td class="text-left">Project One</td>
        <td class="text-left">73%</td>
    </tr>
    <tr>
        <td class="text-left">Project One</td>
        <td class="text-left">73%</td>
    </tr>
    <tr>
        <td class="text-left">Project One</td>
        <td class="text-left">73%</td>
    </tr>
</table> -->
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl PRhiddentbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">4h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">1h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">3h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">4h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl PRhiddentbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsRed">20h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">10h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">10h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsRed">1h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">6h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <!--hidden row end-->
                                        <tr>
                                            <td>
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="PRR3" class="chckHead">
                                                    <label for="PRR3"></label>
                                                </div>
                                            </td>
                                            <td class="text-left dropdown PRrolename">Sam Jhonson
                                                <a href="javascript:;" class="nostyle hidden-xs UpDowncollapseArrow" data-toggle="collapse" data-target=".PRhiderow2" data-original-title="" title="">
                                                    <img class="uparrow" data-toggle="tooltip" data-placement="top" title="" src="dist/img/up.svg" alt="" class="" width="15px" data-original-title="Hide Task">
                                                    <img class="downarrow" data-toggle="tooltip" data-placement="top" title="" src="dist/img/down.svg" alt="" class="" width="15px" data-original-title="Hide Task">
                                                </a>
                                                <br/>
                                                <div class="smallsubtext"><span class="pull-left">Graphic designer</span>  <span class="pull-right">03 Projects</span>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="progress">
                                                    <div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
<a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>   
                                                <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                                    <li><a class="dropdown-item" href="#">Allocate</a>
                                                    </li>
                                                    <li><a class="dropdown-item" href="#">Change allocation</a>
                                                    </li>
                                                    <li><a class="dropdown-item" href="#">Release</a>
                                                    </li>
                                                </ul>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="PRpercentage PRstatusLightblue">25%</td>
                                                            <td class="PRpercentage PRstatusLightblue">25%</td>
                                                            <td class="PRpercentage PRstatusBlue">100%</td>
                                                            <td class="PRpercentage PRstatusLightblue">85%</td>
                                                            <td class="PRpercentage PRstatusLightblue">50%</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="PRpercentage PRstatusLightblue">45%</td>
                                                            <td class="PRpercentage PRstatusRed">110%</td>
                                                            <td class="PRpercentage PRstatusBlue">100%</td>
                                                            <td class="PRpercentage PRstatusLightblue">45%</td>
                                                            <td class="PRpercentage PRstatusLightblue">78%</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <!--hidden row start here -->
                                        <tr class="PRhiderow2 collapse">
                                            <td>&nbsp;</td>
                                            <td></td>
                                            <td>
                                                <table class="PRsubinfotbl PRhiddentbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">4h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">1h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">3h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">4h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl PRhiddentbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsRed">20h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">10h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">10h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsRed">1h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">6h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <!--hidden row end-->
                                        <tr>
                                            <td>
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="PRR4" class="chckHead">
                                                    <label for="PRR4"></label>
                                                </div>
                                            </td>
                                            <td class="text-left dropdown PRrolename">Jack Andrewson
                                                <a href="javascript:;" class="nostyle hidden-xs UpDowncollapseArrow" data-toggle="collapse" data-target=".PRhiderow3" data-original-title="" title="">
                                                    <img class="uparrow" data-toggle="tooltip" data-placement="top" title="" src="dist/img/up.svg" alt="" class="" width="15px" data-original-title="Hide Task">
                                                    <img class="downarrow" data-toggle="tooltip" data-placement="top" title="" src="dist/img/down.svg" alt="" class="" width="15px" data-original-title="Hide Task">
                                                </a>
                                                <br/>
                                                <div class="smallsubtext"><span class="pull-left">Graphic designer</span>  <span class="pull-right">03 Projects</span>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="progress">
                                                    <div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
<a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>   
                                                <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                                    <li><a class="dropdown-item" href="javascript:;" data-toggle="modal" data-target="#bulkallocation" data-dismiss="modal">Allocate</a>
                                                    </li>
                                                    <li><a class="dropdown-item" href="#">Change allocation</a>
                                                    </li>
                                                    <li><a class="dropdown-item" href="#">Release</a>
                                                    </li>
                                                </ul>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="PRpercentage PRstatusLightblue">25%</td>
                                                            <td class="PRpercentage PRstatusLightblue">15%</td>
                                                            <td class="PRpercentage PRstatusLightblue">32%</td>
                                                            <td class="PRpercentage PRstatusLightblue">85%</td>
                                                            <td class="PRpercentage PRstatusRed">120%</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class=""></td>
                                                            <td class=""></td>
                                                            <td class="PRpercentage PRstatusBlue">100%</td>
                                                            <td class="PRpercentage PRstatusBlue">100%</td>
                                                            <td class="PRpercentage PRstatusBlue">100%</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <!--hidden row start here -->
                                        <tr class="PRhiderow3 collapse">
                                            <td>&nbsp;</td>
                                            <td></td>
                                            <td>
                                                <table class="PRsubinfotbl PRhiddentbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">4h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">1h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">3h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">4h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl PRhiddentbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsRed">20h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">10h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">10h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsRed">1h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">6h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <!--hidden row end-->
                                        <tr>
                                            <td>
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="PRR5" class="chckHead">
                                                    <label for="PRR5"></label>
                                                </div>
                                            </td>
                                            <td class="text-left dropdown PRrolename">Anand Singh
                                                <a href="javascript:;" class="nostyle hidden-xs UpDowncollapseArrow" data-toggle="collapse" data-target=".PRhiderow4" data-original-title="" title="">
                                                    <img class="uparrow" data-toggle="tooltip" data-placement="top" title="" src="dist/img/up.svg" alt="" class="" width="15px" data-original-title="Hide Task">
                                                    <img class="downarrow" data-toggle="tooltip" data-placement="top" title="" src="dist/img/down.svg" alt="" class="" width="15px" data-original-title="Hide Task">
                                                </a>
                                                <br/>
                                                <div class="smallsubtext"><span class="pull-left">Graphic designer</span>  <span class="pull-right">03 Projects</span>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="progress">
                                                    <div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
<a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>   
                                                <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                                    <li><a class="dropdown-item" href="javascript:;" data-toggle="modal" data-target="#bulkallocation" data-dismiss="modal">Allocate</a>
                                                    </li>
                                                    <li><a class="dropdown-item" href="#">Change allocation</a>
                                                    </li>
                                                    <li><a class="dropdown-item" href="#">Release</a>
                                                    </li>
                                                </ul>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="PRpercentage PRstatusLightblue">25%</td>
                                                            <td class="PRpercentage PRstatusLightblue">35%</td>
                                                            <td class="PRpercentage PRstatusBlue">100%</td>
                                                            <td class="PRpercentage PRstatusLightblue">85%</td>
                                                            <td class=""></td>
                                                            <td class="PRpercentage PRstatusBlue">100%</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="PRpercentage PRstatusLightblue">45%</td>
                                                            <td class="PRpercentage PRstatusLightblue">10%</td>
                                                            <td class="PRpercentage PRstatusBlue">100%</td>
                                                            <td class="PRpercentage PRstatusBlue">100%</td>
                                                            <td class=""></td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <!--hidden row start here -->
                                        <tr class="PRhiderow4 collapse">
                                            <td>&nbsp;</td>
                                            <td></td>
                                            <td>
                                                <table class="PRsubinfotbl PRhiddentbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">4h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">1h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">3h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">4h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl PRhiddentbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsRed">20h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">10h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">10h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsRed">1h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">6h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <!--hidden row end-->
                                        <tr>
                                            <td>
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="PRR6" class="chckHead">
                                                    <label for="PRR6"></label>
                                                </div>
                                            </td>
                                            <td class="text-left dropdown PRrolename">Andrew Ford
                                                <a href="javascript:;" class="nostyle hidden-xs UpDowncollapseArrow" data-toggle="collapse" data-target=".PRhiderow5" data-original-title="" title="">
                                                    <img class="uparrow" data-toggle="tooltip" data-placement="top" title="" src="dist/img/up.svg" alt="" class="" width="15px" data-original-title="Hide Task">
                                                    <img class="downarrow" data-toggle="tooltip" data-placement="top" title="" src="dist/img/down.svg" alt="" class="" width="15px" data-original-title="Hide Task">
                                                </a>
                                                <br/>
                                                <div class="smallsubtext"><span class="pull-left">Graphic designer</span>  <span class="pull-right">03 Projects</span>
                                                    <div class="clearfix"></div>
                                                </div>
                                                <div class="progress">
                                                    <div class="progress-bar bg-success" role="progressbar" style="width: 25%" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
<a class="btn btn-secondary dropdown-toggle projectCRmenu dropdown-menu-right" href="javascript:;" id="projectCRmenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-ellipsis-v"></i></a>   
                                                <ul class="dropdown-menu dropdownlinks" aria-labelledby="projectCRmenu">
                                                    <li><a class="dropdown-item" href="javascript:;" data-toggle="modal" data-target="#bulkallocation" data-dismiss="modal">Allocate</a>
                                                    </li>
                                                    <li><a class="dropdown-item" href="#">Change allocation</a>
                                                    </li>
                                                    <li><a class="dropdown-item" href="#">Release</a>
                                                    </li>
                                                </ul>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="PRpercentage PRstatusLightblue">25%</td>
                                                            <td class="PRpercentage PRstatusLightblue">35%</td>
                                                            <td class=""></td>
                                                            <td class="PRpercentage PRstatusLightblue">85%</td>
                                                            <td class=""></td>
                                                            <td class="PRpercentage PRstatusBlue">100%</td>
                                                            <td class="PRpercentage PRstatusRed">110%</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class="PRpercentage PRstatusRed">105%</td>
                                                            <td class="PRpercentage PRstatusRed">110%</td>
                                                            <td class="PRpercentage PRstatusLightblue">10%</td>
                                                            <td class="PRpercentage PRstatusLightblue">45%</td>
                                                            <td class="PRpercentage PRstatusLightblue">78%</td>
                                                            <td>&nbsp;</td>
                                                            <td>&nbsp;</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <!--hidden row start here -->
                                        <tr class="PRhiderow5 collapse">
                                            <td>&nbsp;</td>
                                            <td></td>
                                            <td>
                                                <table class="PRsubinfotbl PRhiddentbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">4h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">1h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">3h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">4h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>
                                                <table class="PRsubinfotbl PRhiddentbl" width="100%" cellpadding="10" cellspacing="0">
                                                    <tbody>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsRed">20h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">10h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsWhite">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">10h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class=""><span class="PRhrs PRhrsRed">1h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsYellow">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsRed">6h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsSkyblue">2h</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                            <td class=""><span class="PRhrs PRhrsGray">&nbsp;</span>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <!--hidden row end-->
                                    </tbody>
                                </table>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                    <!--Weekly tab content end here-->
                    <!--Daily tab content start here-->
                    <div id="Dailytab" class="tab-slider--body" style="display:none;">Daily Content</div>
                    <!--Daily tab content End here-->
            </section>
            <div class="modal custmodal  fade" id="bulkallocation" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true" data-dismiss="modal">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Allocation details</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="form-group">
                                    <label class="col-sm-4 text-right">Resources</label>
                                    <div class="col-sm-8">
                                        <div class="inputtags">
                                            <input id="RAtaglist" type="text" class="form-control" rows="3" value="Test1,Test2, test3, test4, ThisIsABigVeryBigTest" />
                                        </div>
                                        <!-- <br/><span class="notification-alert">Sam is 100% allocated from 12 June to 14 June</span> -->
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 text-right">Project (pre-populated)</label>
                                    <div class="col-sm-8">
                                        <select class="form-control selectpicker">
                                            <option>Select Project</option>
                                            <option>Timesheet</option>
                                            <option>Help desk</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 text-right">Project Role</label>
                                    <div class="col-sm-8">
                                        <select class="form-control selectpicker">
                                            <option>Graphics designer</option>
                                            <option>Developer</option>
                                            <option>Supervisor</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 text-right">Plan Start Date</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" value="June 08 2018">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 text-right">Plan End Date</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" value="June 21 2018">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 text-right">Reporting to</label>
                                    <div class="col-sm-8">
                                        <select class="form-control selectpicker">
                                            <option>Annabel Willson</option>
                                            <option>Sam Jhonson</option>
                                            <option>Jack Andrewson</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 text-right">Resource Status</label>
                                    <div class="col-sm-8">
                                        <select class="form-control selectpicker">
                                            <option>Retrive</option>
                                            <option>Buffor</option>
                                            <option>Shadow</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-4 text-right">Responsibility</label>
                                    <div class="col-sm-8">
                                        <textarea class="form-control"></textarea>
                                    </div>
                                </div>
                                <br>
                                <div class="form-group">&nbsp;</div>
                                <div class="form-group text-center">
                                    <button class="btn borderbtn borderbtnfill" data-dismiss="modal">Allocate</button>
                                    <button class="btn borderbtn ml-1" data-dismiss="modal">Cancle</button>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!--modal-end-here-->
            <!--modal_start_here-->
            <div class="modal custmodal  fade" id="resourcerequest" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true" data-dismiss="modal">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Resource request</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <ul class="nav nav-tabs popupboxtabs">
                                <li class="active"> <a href="#Rrequesttab" data-toggle="tab">Request</a>
                                </li>
                                <li class=""> <a href="#Rskillsettab" data-toggle="tab">Skillset</a>
                                </li>
                            </ul>
                            <div class="tab-content ">
                                <div class="tab-pane active" id="Rrequesttab">
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-sm-4">Select Project role</label>
                                            <div class="col-sm-8">
                                                <select class="form-control selectpicker">
                                                    <option>Whizible</option>
                                                    <option>Timesheet</option>
                                                    <option>Help desk</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">No. of resources</label>
                                            <div class="col-sm-8 form-inline">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" value="06">
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
                                            <label class="col-sm-4">Start date and end date</label>
                                            <div class="col-sm-8">
                                                <div class="input-group-box">
                                                    <div class="input-group" id="DateDemo">
                                                        <input data-toggle="tooltip" data-placement="top" title="Select week date" class="form-control" type="text" id="weekPicker3" value="" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">Working hours</label>
                                            <div class="col-sm-8 form-inline">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" value="06">
                                                </div>type
                                                <div class="form-group">
                                                    <select class="form-control selectpicker">
                                                        <option>Hours per day</option>
                                                        <option>% of day</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">Status</label>
                                            <div class="col-sm-8 form-inline">
                                                <div class="form-group">
                                                    <select class="form-control selectpicker">
                                                        <option>Select status</option>
                                                        <option></option>
                                                        <option></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">Resource Pool</label>
                                            <div class="col-sm-8 form-inline">
                                                <div class="form-group">
                                                    <select class="form-control selectpicker">
                                                        <option></option>
                                                        <option></option>
                                                        <option></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">Responsibility</label>
                                            <div class="col-sm-8">
                                                <textarea class="form-control"></textarea>
                                                <!-- <br/><a href="#">Add comment</a> -->
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">&nbsp;</label>
                                            <div class="col-sm-8">
                                                <div class="file_attach">
                                                    <form>
                                                        <input type="file" multiple>
                                                        <p>Attache file or drop here</p>
                                                        <button type="submit">Upload</button>
                                                    </form>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                        </div>
                                        <div class="form-group">&nbsp;</div>
                                        <div class="form-group text-center">
                                            <button class="btn borderbtn borderbtnfill" data-dismiss="modal">Request</button>
                                            <button class="btn borderbtn ml-1" data-dismiss="modal">Cancle</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="Rskillsettab">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th width="36%">Skills</th>
                                                <th>Experience</th>
                                                <th>Proficiency</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Databse</td>
                                                <td class="exprience">
                                                    <input width="50" class="form-control" type="text" name="">to
                                                    <input width="50" class="form-control ml-1" type="text" name="">Years</td>
                                                <td>
                                                    <select class="form-control selectpicker">
                                                        <option>Fresher</option>
                                                        <option>Imidiate</option>
                                                        <option>Advanced</option>
                                                        <option>Master</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Skillset 2</td>
                                                <td class="exprience">
                                                    <input width="50" class="form-control" type="text" name="">to
                                                    <input width="50" class="form-control ml-1" type="text" name="">Years</td>
                                                <td>
                                                    <select class="form-control selectpicker">
                                                        <option>Fresher</option>
                                                        <option>Imidiate</option>
                                                        <option>Advanced</option>
                                                        <option>Master</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Skillset 3</td>
                                                <td class="exprience">
                                                    <input width="50" class="form-control" type="text" name="">to
                                                    <input width="50" class="form-control ml-1" type="text" name="">Years</td>
                                                <td>
                                                    <select class="form-control selectpicker">
                                                        <option>Fresher</option>
                                                        <option>Imidiate</option>
                                                        <option>Advanced</option>
                                                        <option>Master</option>
                                                    </select>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>Skillset 4</td>
                                                <td class="exprience">
                                                    <input width="50" class="form-control" type="text" name="">to
                                                    <input width="50" class="form-control ml-1" type="text" name="">Years</td>
                                                <td>
                                                    <select class="form-control selectpicker">
                                                        <option>Fresher</option>
                                                        <option>Imidiate</option>
                                                        <option>Advanced</option>
                                                        <option>Master</option>
                                                    </select>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                    <div class="row">
                                        <!--  <div class="form-group">
          <label class="col-sm-3">Skills</label>
          <div class="col-sm-9"><div class="inputtags">
            <input id="resourcetaglist" type="text" class="form-control" rows="3" value="Test1,Test2, test3, test4, ThisIsABigVeryBigTest"  />
          </div></div>
          </div>
          
          <div class="form-group">
          <label class="col-sm-3">Experience</label>
          <div class="col-sm-9">
          <div class="form-inline experience_duration">
          <div class="for-group">
          <input type="text" id="Expyearfrom" class="form-control" value="0"> <span>to</span>  <input type="text"  class="form-control" id="Expyearfrom" value="5"> Years</div>
          </div>
          </div>
          </div>
          
           <div class="form-group">
          <label class="col-sm-3">Proficiency</label>
          <div class="col-sm-9 proficiency">
         
         <div class="custom_chckbox">
                <input type="checkbox" id="ffresher" class="chcktbl">
                <label for="ffresher">Fresher</label>
        </div>
        <div class="custom_chckbox">
                <input type="checkbox" id="fImidiate" class="chcktbl">
                <label for="fImidiate">Imidiate</label>
        </div>
        <div class="custom_chckbox">
                <input type="checkbox" id="fAdvance" class="chcktbl">
                <label for="fAdvance">Advanced</label>
            </div>
        <div class="custom_chckbox">
                <input type="checkbox" id="fMaster" class="chcktbl">
                <label for="fMaster">Master</label>
            </div>  
         
         
           </div>
          </div> -->
                                        <div class="form-group">&nbsp;</div>
                                        <div class="form-group text-center">
                                            <button class="btn borderbtn borderbtnfill" data-dismiss="modal">Send</button>
                                            <button class="btn borderbtn ml-1" data-dismiss="modal">Cancle</button>
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
            <!--modal_start_here-->
            <div class="modal custmodal  fade" id="resourcerequest" tabindex="-1" role="dialog" aria-labelledby="resourcerequestlabel" aria-hidden="true" data-dismiss="modal">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Resource request</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"> <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <ul class="nav nav-tabs popupboxtabs">
                                <li class="active"> <a href="#Rrequesttab" data-toggle="tab">Request</a>
                                </li>
                                <li class=""> <a href="#Rskillsettab" data-toggle="tab">Skillset</a> 
                                </li>
                            </ul>
                            <div class="tab-content ">
                                <div class="tab-pane active" id="Rskillsettab">
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-sm-3">Skills</label>
                                            <div class="col-sm-9">
                                                <div class="inputtags">
                                                    <input id="resourcetaglist" type="text" class="form-control" rows="3" value="Test1,Test2, test3, test4, ThisIsABigVeryBigTest" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3">Experience</label>
                                            <div class="col-sm-9">
                                                <div class="form-inline experience_duration">
                                                    <div class="for-group">
                                                        <input type="text" id="Expyearfrom" class="form-control" value="0"> <span>to</span> 
                                                        <input type="text" class="form-control" id="Expyearfrom" value="5">Years</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-3">Proficiency</label>
                                            <div class="col-sm-9 proficiency">
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="ffresher" class="chcktbl">
                                                    <label for="ffresher">Fresher</label>
                                                </div>
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="fImidiate" class="chcktbl">
                                                    <label for="fImidiate">Imidiate</label>
                                                </div>
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="fAdvance" class="chcktbl">
                                                    <label for="fAdvance">Advanced</label>
                                                </div>
                                                <div class="custom_chckbox">
                                                    <input type="checkbox" id="fMaster" class="chcktbl">
                                                    <label for="fMaster">Master</label>
                                                </div>
                                            </div>
                                        </div>
                                        <br>
                                        <div class="form-group">&nbsp;</div>
                                        <div class="form-group text-center">
                                            <button class="btn borderbtn ml-1" data-dismiss="modal">Cancle</button>
                                            <button class="btn btnyellow" data-dismiss="modal">Next</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane" id="Rrequesttab">
                                    <div class="row">
                                        <div class="form-group">
                                            <label class="col-sm-4">Select Project role</label>
                                            <div class="col-sm-8">
                                                <select class="form-control selectpicker">
                                                    <option>Whizible</option>
                                                    <option>Timesheet</option>
                                                    <option>Help desk</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">No. of resources</label>
                                            <div class="col-sm-8 form-inline">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" value="06">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">Configuration</label>
                                            <div class="col-sm-8">
                                                <select class="form-control selectpicker">
                                                    <option>Select</option>
                                                    <option></option>
                                                    <option></option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">Start date and end date</label>
                                            <div class="col-sm-8">
                                                <div class="input-group-box">
                                                    <div class="input-group" id="DateDemo">
                                                        <input data-toggle="tooltip" data-placement="top" title="Select week date" class="form-control" type="text" id="weekPicker3" value="" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">Works hours</label>
                                            <div class="col-sm-8 form-inline">
                                                <div class="form-group">
                                                    <input type="text" class="form-control" value="06">
                                                </div>type
                                                <div class="form-group">
                                                    <select class="form-control selectpicker">
                                                        <option>Per day</option>
                                                        <option></option>
                                                        <option></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">Status</label>
                                            <div class="col-sm-8 form-inline">
                                                <div class="form-group">
                                                    <select class="form-control selectpicker">
                                                        <option>Select status</option>
                                                        <option></option>
                                                        <option></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">Reporting to</label>
                                            <div class="col-sm-8 form-inline">
                                                <div class="form-group">
                                                    <select class="form-control selectpicker">
                                                        <option>Billable</option>
                                                        <option></option>
                                                        <option></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">Responsibility</label>
                                            <div class="col-sm-8">
                                                <textarea class="form-control"></textarea>
                                                <br/><a href="#">Add comment</a>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-sm-4">&nbsp;</label>
                                            <div class="col-sm-8">
                                                <div class="file_attach">
                                                    <form>
                                                        <input type="file" multiple>
                                                        <p>Attache file or drop here</p>
                                                        <button type="submit">Upload</button>
                                                    </form>
                                                </div>
                                                <div class="clearfix"></div>
                                            </div>
                                        </div>
                                        <br>
                                        <div class="form-group">&nbsp;</div>
                                        <div class="form-group text-center">
                                            <button class="btn borderbtn borderbtnfill" data-dismiss="modal">Request</button>
                                            <button class="btn borderbtn ml-1" data-dismiss="modal">Cancle</button>
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
        </div>
            <!-- /.content-wrapper -->
</body>
</html>
