<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ProjectCommercialDashBoard.aspx.vb" Inherits="PbNIT.ProjectCommercialDashBoard" %>

<!DOCTYPE html>
<html>
        <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("Project Dashboard")%>
<head>
<%--    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project Dashboard</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/project-dashboard.css?v=0.6">
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />
   


</head>
    <style>
.inline-block{display:inline-block}
.headertopp ul{align-items:center;margin:0;padding:0;vertical-align:middle}
.headertopp ul li .custom_radio{margin-top:6px}
.defayltbox .box-header{background:#e7edf0;padding:10px}
.box.defayltbox.chartbox{border:1px solid #eee}
.custom_chckbox label:before{margin-right:0}

.CPTbl tr th:not(:first-child){ min-width:100px;}
.CPTbl tr th{ vertical-align:middle!important;}
.CPTbl tr th:nth-child(4){ min-width:240px;}
.CPTbl tr th:nth-child(1){ min-width:240px;}
.CPTbl tr th:nth-child(6){ min-width:170px;}
.CPTbl tr th:nth-child(3){ min-width:140px;}
.CPTbl tr th:nth-child(7),.CPTbl tr th:nth-child(8){ min-width:140px;}
.CPTbl tr th:nth-child(2){ min-width:170px;}
.progress{ background:#ccc;}
body .CPTbl tr:hover, body .CPTbl tr:focus {background: #eef9ff;}
span.scroreno {
    color: #4263c1;
    font-weight: 500;
    font-size: 6em;
}
ul.scoreprogress {margin: 0;padding: 0;}
ul.scoreprogress .progress{ height:5px;margin-bottom: 16px;background: #f5f5f5;}
ul.scoreprogress .progress .progress-bar{ background:#008bcc;}
.table tr td .progress {margin-top:0;}

/*.CPTbl th:first-child::after {display: none;}*/
table.dataTable thead th {position: relative;}
table.dataTable thead th:after {position: absolute;right: 5px;}
    table.dataTable thead .sorting_asc, table.dataTable thead .sorting_desc, table.dataTable thead .sorting {padding-right: 15px;}
.CPTbl tr th:nth-child(9) {min-width: 120px;}
.dataTables_scrollBody thead tr[role="row"] {visibility: collapse !important;}

/*custome radio button*/
.radio [type="radio"]:checked, .radio [type="radio"]:not(:checked) {position: absolute;left: -9999px;}
.radio [type="radio"]:checked + label, .radio [type="radio"]:not(:checked) + label{position:relative;padding-left:28px;cursor:pointer;line-height:20px;display:inline-block;color:#464a4c; font-weight:500;}
.radio [type="radio"]:checked + label:before, .radio [type="radio"]:not(:checked) + label:before{content:'';position:absolute;left:0;top:0;width:16px;height:16px;border:1px solid #464a4c;border-radius:100%;background:transparent;}
.radio [type="radio"]:checked + label:after, .radio [type="radio"]:not(:checked) + label:after{content:'';width:10px;height:10px;background:#464a4c;position:absolute;top:3px;left:3px;border-radius:100%;-webkit-transition:all .2s ease;transition:all .2s ease}
.radio [type="radio"]:not(:checked) + label:after{opacity:0;-webkit-transform:scale(0);transform:scale(0)}
.radio [type="radio"]:checked + label:after{opacity:1;-webkit-transform:scale(1);transform:scale(1)}
.headertopp li .radio {margin-right: 30px;}
/*custome radio button end*/
.widget_category_panelbody{ background:#fff; border-bottom:1px solid #ddd;}
.widgetcatbox:hover{ background:#f5f5f5;box-shadow: 5px 3px 8px 1px #ccc; color:#464a4c;}
.selpro .dropdown-menu{ max-height:400px!important; overflow-y:auto;}
/*Added By Dipali  V On 20th July 2020 For Adjust Div*/
    /*#bdyDelayinRealization {
        height:270px!important ;
    }
    #bdyAcruedCost {
        height:261px!important ;
    }
     #bdyScroe {
        height:248px!important ;
    }*/ /*commented css by pradip content 4-2-2021*/
     /*End of Added By Dipali  V On 20th July 2020 For Adjust Tooltip*/
     /*Added By Dipali  V On 20th July 2020 For Adjust Div*/
     .tooltip-inner {
    max-width: 100% !important;
}

    .ClsNoData {
        text-align:center!important;
    }

    i {
        cursor:pointer!important;
    }

    #bdyNGProfitability {
        height:241px!important;
    }

    .switch {
      margin-right:10px;
    }

    /*Added By Vidhi for alert*/
    .alertify-notifier {
        z-index: 99999;
    }

    /*End by Vidhi*/

   

    .Spancurrency {
        font-size:9px!important;
    }

    /*Added By Dipali  V On 20th July 2020 For Adjust Tooltip*/







    /*Added By Dipali V On 12th Aug 2020 For Loader Issues*/
    /*.preloader {
            position: absolute;
            margin-top: -25px;
            margin-left: -400px;
            top: 50%;
            left: 50%;
            padding: 30px 15px 0px;*/
            /* border: 3px solid #ababab; */
            /* box-shadow: 1px 1px 10px #ababab; */
            /*border-radius: 15px;
            background: #ddd;*/
            /* background-color: white; */
            /*background: url(../../../Whizible2.0/dist/img/loading.gif) 100% 100% no-repeat;*/
            /* background: url(../../../Whizible2.0/dist/img/loading.gif) rgba( 255, 255, 255, .8 ) 100% 100% no-repeat; */
            /*width: 100px;
            height: 100px;
            background-repeat: no-repeat;
            background-position: center;
            margin: -100px 0 0 -100px;
            z-index: 1002;
            text-align: center;
        }            
   .clsShowHide {
            display: none !important;
        }*/

    /*End of Added By Dipali V On 12th Aug 2020 For Loader Issues*/

    	


    /*For Pop up window*/


    /*added by vidhi form combobox*/
        select.bs-select-hidden, select.selectpicker {
            display: block !important;
            width : 100px;
        }
        /*End added by vidhi form combobox*/





		.arrowdisabled{ cursor:no-drop;}
		.arrowdisabled a{ pointer-events:none;} 
        .custmodal .custom_chckbox label:before{ border-color:#464a4c;margin-right: 0;}
        .input-sm button.btn.dropdown-toggle {height: 30px;}
        #PreProjecttbl tr td:nth-child(2n){ text-align:left;}
        .premiumProListwrap .bootstrap-select .dropdown-menu {
            min-width: 200px;
        }

    #PreProjecttbl tr th:nth-child(3), #PreProjecttbl tr th:nth-child(4){ min-width:100px;}

    /*simple pagination style*/
.simple-pagination{display:inline-block;padding-left:0;margin-top:1rem;margin-bottom:1rem;border-radius:.25rem}
.simple-pagination li{display:inline}
.simple-pagination .page-link,.simple-pagination .ellipse,.simple-pagination .current{display:inline-block;position:relative;float:left;padding:.5rem .75rem;margin-left:-1px;color:#0275d8;text-decoration:none;background-color:#fff;border:1px solid #ddd}
.simple-pagination li:first-child .page-link{margin-left:0;border-bottom-left-radius:.25rem;border-top-left-radius:.25rem}
.simple-pagination li:last-child .page-link{border-bottom-right-radius:.2rem;border-top-right-radius:.2rem}
.simple-pagination li.active .page-link,.simple-pagination li.active .page-link:focus,.simple-pagination li.active .page-link:hover,.simple-pagination li.active .current,.simple-pagination li.active .current:focus,.simple-pagination li.active .current:hover{z-index:2;color:#fff;cursor:default;background-color:#0275d8;border-color:#0275d8}

        .simple-pagination li.active .page-link, .simple-pagination li.active .page-link:focus, .simple-pagination li.active .page-link:hover, .simple-pagination li.active .current, .simple-pagination li.active .current:focus, .simple-pagination li.active .current:hover {
        background:#1359ac;}
/*End of pagination style*/

#PreProModalpopup .modal-dialog{ width:840px;}

/*Added style by pradip on 3-12-2020*/
.chartboxswitchAction{ text-align:right;}
.chartboxswitchAction .fas{ margin-left:10px;}
/*End Added by pradip*/

#PreProjecttbl tr th:last-child {
    min-width: 100px;
}
#PreProjecttbl tr th {
    min-width: 84px;
}
/*Added By Pradip 2022 For Aligment Issue*/
span.scroreno{ font-size:2em;}
/*Added by pradip on 4-2-2022*/
.row-eq-height .box.defayltbox.chartbox{ height:100%;}
div#tblgrid_wrapper {
    margin-top: 30px;
}
/*End Added by pradip on 4-2-2022*/



.dataTables_scrollBody thead .sorting:after {display: none;}   /*Commented and Added By RehanC for drop arrow issue on 7th April 2023*/


</style>
<body class="hold-transition skin-blue-light sidebar-mini fixed" id="bdyNewProjectDashBoard">


        <!-- Content Wrapper. Contains page content -->
   <%-- Added By Dipali V On 12th Aug 2020 for  loader issues--%>
       <div id="divCommercialDashboard" class="preloader">
      
         <div class="clsShowHide" id="maindiv">
    <%-- End of Added By Dipali V On 12th Aug 2020 for  loader issues--%>
        <div class="">
            <!-- Content Header (Page header) -->
            <!-- Main content -->
            <div class="graybg container-fluid pt-1 pb-1 headertopp">
                <%--<ul class="float-start">--%>
                <ul class="clearfix">
                <li class="inline-block">
                    <div class="radio">
                        <input type="radio" id="chkPremiumProjects" name="radio-group" value ="P" checked="checked">
                        <label for="chkPremiumProjects">Premium Projects</label>
                        
                    </div>
                </li>
                <li class="inline-block">
                    <div class="radio">
                        <input type="radio" id="chkAllProjects" name="radio-group" value ="A" >
                        <label for="chkAllProjects">All</label>
                    </div>
                </li>
            </ul>
               <%-- <ul class="float-end">
                    <li class="">
                        <a href="javascript:;" data-bs-toggle="collapse" data-bs-target="#dashwidget" class="btn nostylebtn"><i class="fas fa-plus-square"></i> Add Widget</a>
                    </li>
                </ul>--%>
            </div>

            <!--widget wrapper start here-->
           <%-- <div class="widget_category_panel collapse" id="dashwidget">
                <div class="widget_category_panelbody">
                    <button type="button" class="btn btn-box-tool dashclosewidget">
                        <img src="dist/img/close-gray.svg" width="16px" alt="" title="" />
                    </button>

                    <div class="widgetheader"><h4>Widget category title</h4></div>
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="widgetcatbox">
                                <div class="widgetcat_title">Milestone One</div>
                                <p><em>Widget details lorem ipsum doler sit amet, consectur adipiscing elit</em></p>
                                <div class="widgetcategory_Action">
                                    <span class="selectwidget"><i class="fas fa-check"></i></span>
                                    <span class="unselectwidget"><i class="fas fa-times"></i></span>
                                </div>

                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="widgetcatbox selected">
                                <div class="widgetcat_title">Milestone two</div>
                                <p><em>Widget details lorem ipsum doler sit amet, consectur adipiscing elit</em></p>
                                <div class="widgetcategory_Action">
                                    <span class="selectwidget"><i class="fas fa-check"></i></span>
                                    <span class="unselectwidget"><i class="fas fa-times"></i></span>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="widgetcatbox">
                                <div class="widgetcat_title">Milestone three</div>
                                <p><em>Widget details lorem ipsum doler sit amet, consectur adipiscing elit</em></p>
                                <div class="widgetcategory_Action">
                                    <span class="selectwidget"><i class="fas fa-check"></i></span>
                                    <span class="unselectwidget"><i class="fas fa-times"></i></span>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="widgetcatbox">
                                <div class="widgetcat_title">Milestone four</div>
                                <p><em>Widget details lorem ipsum doler sit amet, consectur adipiscing elit</em></p>
                                <div class="widgetcategory_Action">
                                    <span class="selectwidget"><i class="fas fa-check"></i></span>
                                    <span class="unselectwidget"><i class="fas fa-times"></i></span>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="widgetcatbox">
                                <div class="widgetcat_title">Milestone five</div>
                                <p><em>Widget details lorem ipsum doler sit amet, consectur adipiscing elit</em></p>
                                <div class="widgetcategory_Action">
                                    <span class="selectwidget"><i class="fas fa-check"></i></span>
                                    <span class="unselectwidget"><i class="fas fa-times"></i></span>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="widgetcatbox">
                                <div class="widgetcat_title">Milestone six</div>
                                <p><em>Widget details lorem ipsum doler sit amet, consectur adipiscing elit</em></p>
                                <div class="widgetcategory_Action">
                                    <span class="selectwidget"><i class="fas fa-check"></i></span>
                                    <span class="unselectwidget"><i class="fas fa-times"></i></span>
                                </div>
                            </div>
                        </div>


                    </div>
                </div>
            </div>--%>
            <!--widget wrapper end here-->

            <div class="bgwhite container-fluid pt-1 pb-1">
                <div class="row">
                    <div class="col-sm-6 form-inline">
                       <% CommonFunctions.HTMLControls.DrawComboBox("CboProject", "usp_Whizible2_Sel_AccessibleProjects_ForEmployee_WBS " & Session("intUserID"),,, "class='form-control'", False,, ) %>
                    
                       

                    </div>
                    <div class="col-sm-6 form-inline text-end">
                       <%-- <button data-bs-toggle="tooltip" data-bs-placement="bottom" title="Generate Report" class="btn borderbtn float-end">Generet Report</button>--%>
                          <a href="javascript:;" class="btn borderbtn" data-bs-toggle="modal" data-bs-target="#PreProModalpopup" onclick="LoadAllAccessibleProject()">Set Premium / Priority</a>
                    </div>

                </div>
            </div>

            <div class="content bgwhite">
                <div class="chartcontainer">
                    <div class="row row-eq-height">
                        <div class="col-sm-4">
                            <div class="box defayltbox chartbox">
                                <div class="box-header with-border"><h3 class="box-title">Overall Score</h3></div>
                                 <div class="box-body" id="bdyScroe">
                                <div class="row">
                                    <div class="col-sm-5">
                                        <span class="scroreno"></span>
                                    </div>
                                    <div class="col-sm-7 pl-0">
                                        <ul class="scoreprogress">
                                            <li>
                                                <label>Revenue <span class="Spancurrency">( Base Currency )</span></label>
                                                <div class="progress md-progress">
                                                    <div class="progress-bar" id="divRevenue-progress-bar" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" data-bs-toggle="tooltip" data-bs-placement="left" data-bs-container="body"></div>
                                                </div>
                                            </li>
                                            <li>
                                                <label>Effort</label>
                                                <div class="progress md-progress">
                                                    <div class="progress-bar" role="progressbar" id="divEffort-progress-bar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" data-bs-toggle="tooltip" data-bs-placement="left" data-bs-container="body"></div>
                                                </div>
                                            </li>
                                            <li>
                                                <label>Cost <span class="Spancurrency">( Base Currency )</span></label>
                                                <div class="progress md-progress">
                                                    <div class="progress-bar" role="progressbar" id="divCost-progress-bar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100" data-bs-toggle="tooltip" data-bs-placement="left" data-bs-container="body"></div>
                                                </div>
                                            </li>
                                           <%-- <li>
                                                <label>Quality</label>
                                                <div class="progress md-progress">
                                                    <div class="progress-bar" role="progressbar" id="divQuality-progress-bar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
                                            </li>--%>
                                        </ul>
                                    </div>
                                </div>

                            </div>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <div class="box defayltbox chartbox">
                                <div class="box-header with-border"><h3 class="box-title"> Gross/Net Profitability % </h3>
                                    <div class="chartboxswitchAction float-end">
                                    <label id="SWITCHNET" class="switch"  data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title=" Customer / Project"><input type="checkbox" checked="" id="IDNet" onchange="GetWhichGraph('Net',1)"><span class="slider_switch round"></span></label><i class="fas fa-angle-double-left" id="IDNetPrev" onclick="GetPrevNextData('Net','5','Prev')" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Previous Records"></i><i class="fas fa-angle-double-right" id="IDNetNext" onclick="GetPrevNextData('Net','5','Next')" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Next Records"></i>
                                       </div>
                                    </div>
                                <div class="box-body" id="bdyNGProfitability">
                                    <canvas id="NGProfitability" height="80"></canvas>

                                </div>
                                <div id="NetNodata" style="height:170px!important"></div>
                            </div>
                        </div>
                    </div>


                    <%--<div class="row">--%>
                    <div class="row" style="margin-top:30px;"><!--Added by pradip on 4-2-2022-->
                        <div class="col-sm-8">
                            <div class="box defayltbox chartbox">
                                <div class="box-header with-border"><h3 class="box-title">Accrued Revenue/Cost</h3>
                                    <div class="chartboxswitchAction float-end">
                                    <label id="SWITCHACCRUD" class="switch"  data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title=" Customer / Project"><input type="checkbox" checked="" id="IDAccrued" onchange="GetWhichGraph('Accrued',2)"><span class="slider_switch round"></span></label><i class="fas fa-angle-double-left" id="IDAccruedPrev" onclick="GetPrevNextData('Accrued','5','Prev')" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Previous Records"></i><i class="fas fa-angle-double-right" id="IDAccruedNext" onclick="GetPrevNextData('Accrued','5','Next')" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Next Records"></i> </div>
                                </div>
                                    <div class="box-body" id="bdyAcruedCost">
                                    <canvas id="AcruedCost" width="300" height="80"></canvas>

                                </div>
                                 <div id="AccruedNodata" style="height:170px!important"></div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="box defayltbox chartbox">
                                <div class="box-header with-border"><h3 class="box-title">Delay in Realization</h3></div>
                                <div class="box-body" id="bdyDelayinRealization">
                                    <canvas id="DelayinRealization" width="300" height="250"></canvas>
                                </div>
                                <div id="NOData" style="height:170px!important;"></div>
                            </div>
                        </div>
                    </div>

                    <div class="clearfix"></div>
                </div>

                <div class="table-responsive">
                    <table class="table table-bordered CPTbl" id="tblgrid">
                        <thead>
                            <tr>
                                <%--<th width="3%">
                                    <div class="custom_chckbox">
                                        <input type="checkbox" id="HPAll" class="chckHead">
                                        <label for="HPAll"></label>
                                    </div>
                                </th>--%>
                                <th class="text-start">Project List</th>
                                <th>Type</th>
                                <th>Total Milestone</th>
                                <th>Customer</th>
                                <th>On/Off</th>
                                <%--Added & Commented By Dipali V On 4th Feb 2021 For Rename Column--%>
                                <%--<th>Milestone Billing<span>(Planned Actual)</span></th>--%>
                                <th>Milestone Billing<span>(Planned/Actual)</span></th>
                                <%--End of Added & Commented By Dipali V On 4th Feb 2021 For Rename Column--%>
                                <th>% of Total Billing</th>
                                <th>Project Total Amount</th>
                                <th>RPP</th>
                                <th>Accrued Revenue</th>
                                <th>Accrued Cost</th>

                                <th>Gross Profitability</th>
                                <th>Net Profitability</th>
                                <th>Overhead</th>
                               <%-- <th>Buffer Efforts(Hrs)</th>--%>
                               <th>Delay in Realization(Days) <span> < 15  |  > 15 </span> </th>
                               
                            </tr>
                           <%-- <tr><th></th><th></th><th></th><th></th><th></th>
                             <th></th><th></th><th></th><th></th><th></th><th>
                             </th><th></th><th></th><th></th><th> < 15 </th><th> > 15</th></tr>--%>
                            
                        </thead>
                        <tbody id="tbodyProjectData">
                         
                        </tbody>
                    </table>
                </div>

            </div>

        </div><!-- /.content -->
             <%-- Added By Dipali V On 12th Aug 2020 for  loader issues--%>
       </div>
      </div>
    <%-- End of Added By Dipali V On 12th Aug 2020 for  loader issues--%>

    <!-- /.content -->
    <!-- Add Certification Modal start here-->
            <div class="modal custmodal fade" id="PreProModalpopup" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="">Premium Project</h5>
                            <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" onclick="Refresh()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                       
                        <div class="modal-body" style="padding:30px;">
                            <div class="premiumProListwrap">
                                <div class="pb-1">
                                    <div class="row">
                                        <div class="col-sm-2">
                                              <% CommonFunctions.HTMLControls.DrawComboBox("CboBGInSideMPopUP", "Select  'Select BG' ", ,, "class='form-control'", False,, ) %>
                                           
                                           
                                            <%--<select class="selectpicker form-control">
                                                <option>Select BG</option>
                                                <option>Business Group 1</option>
                                                <option>Business Group 2</option>
                                                <option>Business Group 3</option>
                                                <option>Business Group 4</option>
                                            </select>--%>
                                        </div>
                                        <div class="col-sm-2">
                                              <% CommonFunctions.HTMLControls.DrawComboBox("CboOUInSideMPopUP", "Select  'Select OU' ", ,, "class='form-control'", False,, ) %>
                                            <%--<select class="selectpicker form-control">
                                                <option>Select OU</option>
                                                <option>Organization Unit 1</option>
                                                <option>Organization Unit 2</option>
                                                <option>Organization Unit 3</option>
                                                <option>Organization Unit 4</option>
                                            </select>--%>
                                        </div>
                                        <div class="col-sm-3">
                                              <% CommonFunctions.HTMLControls.DrawComboBox("CboProjectInSideMPopUP", "Select  'Select Project' ", ,, "class='form-control'", False,, ) %>
                                           <%-- <select class="form-control selectpicker">
                                                <option>Whizible</option>
                                                <option>Timesheet</option>
                                                <option>HelpDesk</option>
                                            </select>--%>
                                        </div>
                                        <div class="col-sm-3">
                                            <div class="input-group">
                                                <input id="srchPPlist" type="text" class="search-query form-control" placeholder="Search" onkeyup="mysearchFunction()">
                                                <span class="input-group-btn">
                                                    <button class="btn btn-default" type="button" style="height:30px;">
                                                        <span class=" glyphicon glyphicon-search"></span>
                                                    </button>
                                                </span>
                                            </div>
                                        </div>

                                        <div class="col-sm-1">
                                            <button class="btn btnyellow" onclick="CallInsertionFun()">Save</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="table-responsive" style="max-height:260px;">
                                    <table id="PreProjecttbl" class="table table-bordered">
                                        <thead>
                                            <tr>
                                                <th>Project Name</th>
                                                <th>Description</th>
                                                <th>Start Date</th>
                                                <th>End Date</th>
                                                <th>Premium</th>
                                                <th>Priority</th>
                                            </tr>
                                        </thead>
                                        <tbody id="tbltbodyPreProjecttbl"> 
                                               
                                                    <%--<div class="custom_chckbox">
                                                         <% CommonFunctions.HTMLControls.DrawCheckBox("PPcheckbox", "PPcheckbox") %>
                                                       
                                                        <label for="PPcheckbox"></label>
                                                        
                                                    </div> --%>
                                                 
                                        </tbody>
                                    </table>
                                   
                                    <div id="pagination" class="float-end"></div>
                                   
                                
                             
                                </div>
                                
                            </div>

                            <div class="clearfix"></div>

                        </div>
                    </div>
                </div>
            </div>
            <!-- Add Certification Modal End here-->

          <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->

<%--    <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/chartjs/chart.funnel.bundled.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>
<%--    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>            
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>



    <script type = "text/javascript" >


         var strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
        $("[data-bs-toggle='tooltip']").tooltip();
        $(".progress span, .progress div").hover(function () {
            $(this).parent().tooltip("disable");
        }, function () {
            $(this).parent().tooltip("enable");
        });

        //close widget
        $(".dashclosewidget").click(function () {
            $(".widget_category_panel").removeClass("in");
        });


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
       
        //Popover script start here
        $(window).on("load", function () {            
            $('.user').each(function () {               
                var $this = $(this);
                $this.popover({
                    trigger: 'hover',
                    placement: 'right',//left
                    html: true,
                    content: $this.find('.userInfo').html()
                });
            });

           
        });
        //Popover script end here
         //Added by Vidhi For checkbox 
        var premiumCheckboxValue;

        $("#tbltbodyPreProjecttbl").change(function () {
           // alert("ok");
          
            if ($('input[type="checkbox"]').is(":checked")) {
                premiumCheckboxValue = "1";

            } else if ($('input[type="checkbox"]').is(":not(:checked)")) {
                premiumCheckboxValue = "0";
        
            }
                
        });

        /// Ende of Added by Vidhi For checkbox 


       // Added By Vidhi to Refresh the page 
        function Refresh() {
           // alert("Refresh");
            window.location.reload(true);
        }
        // End of Added By Vidhi to Refresh the page 


        //Added By Vidhi for po up window

         var projectidInsidePop = 0;
        var stateofChk;
        var BusinessGroupIDG = 0;
        var LocationIDG = 0;
        var TempDataAfterBGSelected = new Array();
        /// ended by vidhi for popo up window 



   
        var ProjectID = 0;
        var TotalProjectlength = "";
        var SelectedWhichgraph = "";
        var SelectedWhichgraphTab = "";
        var LoginId = '<%= Session("intLoginID") %>';
        $(document).ready(function () {
            //Commented and Added By RehanC for Tooltip issue on 7th April 2023
            $('body').on('click', function () {
                $('.tooltip').remove();
            });
            //End of Comment By RehanC on 7th April 2023
          /*Added & Commented By Dipali V On 12th Aug 2020 For Loader Issues*/
               $("#divCommercialDashboard").removeClass("center");
               $("#divCommercialDashboard").removeClass("preloader");
               $("#maindiv").removeClass('clsShowHide');
           /*End of Added & Commented By Dipali V On 12th Aug 2020 For Loader Issues*/

           StartLoader("#bdyNewProjectDashBoard");
            ListOfProject();
            $("#IDNetPrev").hide();
            $("#IDAccruedPrev").hide();
            GetCommercialDetails("PageLoad","0");
           StopAjaxLoader("#bdyNewProjectDashBoard");
        });



        $('input[name=radio-group]:radio').click(function () {
            //debugger;
            StartLoader("#bdyNewProjectDashBoard");
            GlobalCount = "";
            if (ProjectID != 0) {
                ProjectID = 0;
            }
             SelectedWhichgraph = "";
            //SelectedWhichgraphTab = "";
            TotalProjectlength = "";
            ListOfProject();

            $("#IDNetPrev").hide();
            $("#IDAccruedPrev").hide();
            GetCommercialDetails("PageLoad","0");
          
            StopAjaxLoader("#bdyNewProjectDashBoard");
        });


        $("#CboProject").on('change', function () {
            //debugger;
            GlobalCount = "";
            TotalProjectlength = "1";
              $("#IDNetPrev").hide();
            $("#IDAccruedPrev").hide();
            ProjectID = $("#CboProject").val();
            if (ProjectID == "" || ProjectID == null) {
                ProjectID = "0";
            }
            else {
                ProjectID: ProjectID;

            }
            SelectedWhichgraph = "";
           StartLoader("#bdyNewProjectDashBoard");
           
            GetCommercialDetails("PageLoad","0");
            StopAjaxLoader("#bdyNewProjectDashBoard");
        });

        var arrData = new Array();
        var allSelectedDataInsidePopUpWindow = new Array();
     
        function ListOfProject() {
          
         
            var ListOfProjectParameter = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                LoginID: encodeURI('<%= Session("intLoginID") %>'),
                Flag: ProjectID,
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectCommercialDashboard/GetProjectListDependingOnSelection',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(ListOfProjectParameter),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (ListOfProjectParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                    }
                },
                async: false,
                success: function (result) {
                    allSelectedDataInsidePopUpWindow = result;
                    $("#tblProjectData").dataTable().fnDestroy();
                    $('#tbodyProjectData').html('');
                    $("#CboProject").empty();

                    $("#CboProject").append('<option value="0">Select Project</option>');
                    if (result != undefined) {
                       
                        var Data = result;
                        var ProjectFilter = document.querySelector('input[name="radio-group"]:checked').value;
                        //Commented and Modified By RehanC not getting last array value on 7th April 2023
                        /*for (var i = 0; i <= Data.length; i++) {*/
                        for (var i = 0; i <= Data.length - 1; i++) {
                        //End of Modification By RehanC 
                           
                            var obj = Data[i];
                            TotalProjectlength = Data.length;
                            var selectedflag = obj.WhichType;
                            var ProjectName = obj.ProjectName;
                            var ProjectID = obj.ProjectID;
                           
                            if (ProjectFilter == "A") {
                                //Commented & Added By Dipali V On 11th Feb 2022 For List out All Project Under Project DropDown
                                //if (ProjectFilter == selectedflag) {
                                    $("#CboProject").append("<option value='" + ProjectID + "'>" + ProjectName + "</option>");
                                //End of Commented & Added By Dipali V On 11th Feb 2022 For List out All Project Under Project DropDown 
                            }
                            else {
                                 //Commented & Added By Dipali V On 11th Feb 2022 For List out All Project Under Project DropDown
                                if (ProjectFilter == selectedflag) {
                                    // debugger;
                                    $("#CboProject").append("<option value='" + ProjectID + "'>" + ProjectName + "</option>");
                                    //arrData.push(obj);
                                }
                                 //End of Commented & Added By Dipali V On 11th Feb 2022 For List out All Project Under Project DropDown
                            }
                        }
                    }
                },

                error: function (ER) {
                   // alert(ER);
                   // alert(ER.responseText);
                }
            });

          
           
        }
    
        function GetCommercialDetails(Flag,Count) {
           //debugger;
            //alert(SelectedWhichgraph)
            if (LoginId == null) {
                LoginId = 0;
            }

            if (SelectedWhichgraphTab == "") {
                if (Flag == "PageLoad") {
                    Flag = "Project";

                }
                else {
                    Flag = "Customer";
                }
            } else {

                Flag = SelectedWhichgraphTab;
            }
          
            var paramitersForCommercialDashboardFilter = {
                ProjectFilter: $("#chkAllProjects").is(":checked") ? "A" : "P",
                ProjectID: ProjectID,
                UserID: encodeURI('<%= Session("intUserID") %>'),
                LoginID: LoginId,
                Whichgraph: Flag,
                Count:Count,
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectCommercialDashboard/GetCommercialDetails',
                type: "POST",
                dataType: "json",
                contentType: "application/json;charset-utf=8",
                data: JSON.stringify(paramitersForCommercialDashboardFilter),
                async: false,
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (paramitersForCommercialDashboardFilter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(paramitersForCommercialDashboardFilter) ? paramitersForCommercialDashboardFilter : JSON.stringify(paramitersForCommercialDashboardFilter)));
                    }
                },
                success: function (result) {
                    //debugger;
                    if (result != null || result != undefined) {
                        //alert(SelectedWhichgraph);
                       //debugger;
                        if (SelectedWhichgraph == "Net") {
                           //globalNetCount= counter
                            getNetGrossProfitability(result);
                        }
                        else if (SelectedWhichgraph == "Accrued") {

                            getAcruedRevenueCost(result);
                        }
                        else {
                            getDelayinRealization(result);
                            GetOverallScore(result);
                            GetProjectData(result);
                            getNetGrossProfitability(result);
                            getAcruedRevenueCost(result);
                            
                          
                        }
                    }
                    
                },
                error: function (err) {
                    
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                }
            });
        }
        //end get all CommercialDetails




          //start chart for Overall Score
        function GetOverallScore(data) {
            //debugger;
            var getOverallScoreObj;
            if (data != null || data != undefined) {
                getOverallScoreObj = data.OverallScore;
            } else {
                getOverallScoreObj = null;
            }

          

            if (getOverallScoreObj != null) {
                $(".scroreno").text(getOverallScoreObj.Scroreno);
                //$("#divRevenue-progress-bar").css("width", getOverallScoreObj.Revenue + "%");
                //$("#divEffort-progress-bar").css("width", getOverallScoreObj.Effort + "%");
                //$("#divCost-progress-bar").css("width", getOverallScoreObj.Cost + "%");
                //$("#divQuality-progress-bar").css("width", getOverallScoreObj.Quality + "%");

                // $("#divRevenue-progress-bar").css("width", getOverallScoreObj.OverallRevenue + "%");
                //$("#divEffort-progress-bar").css("width", getOverallScoreObj.OverallEfforts + "%");
                //$("#divCost-progress-bar").css("width", getOverallScoreObj.OverallCost + "%");

                $("#divRevenue-progress-bar").css("width", getOverallScoreObj.OverallProjectRevenues + "%");
                $("#divEffort-progress-bar").css("width", getOverallScoreObj.OverallProjectEfforts + "%");
                $("#divCost-progress-bar").css("width", getOverallScoreObj.OverallProjectCosts + "%");



                 $("#divRevenue-progress-bar").attr("data-original-title", getOverallScoreObj.OverallProjectRevenues + "%");
                $("#divEffort-progress-bar").attr("data-original-title", getOverallScoreObj.OverallProjectEfforts + "%");
                $("#divCost-progress-bar").attr("data-original-title", getOverallScoreObj.OverallProjectCosts + "%");

                


            } else {
                $(".scroreno").text("0");
                $("#divRevenue-progress-bar").css("width", "0%");
                $("#divEffort-progress-bar").css("width", "0%");
                $("#divCost-progress-bar").css("width", "0%");

                $("#divRevenue-progress-bar").attr("data-original-title", "0%");
                $("#divEffort-progress-bar").attr("data-original-title", "0%");
                $("#divCost-progress-bar").attr("data-original-title", "0%");

                //$("#divQuality-progress-bar").css("width", "0%");
            }
        }
        //end chart for Overall Score

         
        //For Prev & Next Button should hide or show as per data available
        function Getshowhidebutton(RecordCount, Whichgraph) {
            
          //Commented By Dipali V On 4th Feb 2022 For Pre & Next Issue
            //RecordCount = GlobalCount;
            //End of Commented By Dipali V On 4th Feb 2022 For Pre & Next Issue
            //alert(TotalProjectlength);
            //alert(RecordCount);
            if ($("#CboProject").val() == "0") {//Added By Dipali V On if selected Project then should not display arrow
                if (GlobalCount != "") {
                    if (Number(RecordCount) < 5) {
                        $("#ID" + Whichgraph + "Prev").show();
                        $("#ID" + Whichgraph + "Next").hide();
                    }
                    else if (Number(RecordCount) >= 5) {
                        $("#ID" + Whichgraph + "Next").show();
                        $("#ID" + Whichgraph + "Prev").show();
                    }

                    else if (Number(RecordCount) >= TotalProjectlength) {
                        $("#ID" + Whichgraph + "Next").hide();
                        $("#ID" + Whichgraph + "Prev").show();
                    }
                } else {
                    $("#ID" + Whichgraph + "Next").show();
                    $("#ID" + Whichgraph + "Prev").hide();


                }
            }
        } 
         //End of For Prev & Next Button should hide or show as per data available
        //start chart for Nwt Profitability
        var myNGProfitabilityBarChart;
        function getNetGrossProfitability(data) {
            //;
           
            var IsNodataNetGrossProfitablity = 0;
            var getNetGrossProfitabilityObj;
            if (data != null || data != undefined) {
                getNetGrossProfitabilityObj = data.NetGrossProfitability;
                IsNodataNetGrossProfitablity = 0;
            } else {
                getNetGrossProfitabilityObj = null;
                IsNodataNetGrossProfitablity = 1;
            }
            //debugger;

            //debugger;
            if (getNetGrossProfitabilityObj.Projects.length < 5) {
                $("#IDNetNext").hide();
                $("#IDNetPrev").hide();
            } else {
                $("#IDNetNext").show();
                //$("#IDNetPrev").hide();
            }

            if (SelectedWhichgraph != "") {
                 Getshowhidebutton(getNetGrossProfitabilityObj.Projects.length, SelectedWhichgraph);
                
            }


           
            var globalTooltip = "";
            if (getNetGrossProfitabilityObj.Projects.length != 0) {
                $("#NetNodata").css("display", "none");
                $("#NetNodata").html("");
                $("#SWITCHNET").show();
                 $("#bdyNGProfitability").css("display", "block");
                var NGProfitability = document.getElementById("NGProfitability").getContext("2d");
                var NGProfitabilitydata;
                if (getNetGrossProfitabilityObj != null) {
                    //alert(getNetGrossProfitabilityObj.CurrencySymbol);
                    //alert(getNetGrossProfitabilityObj.CurrencySymbol);
                    NGProfitabilitydata = {
                        labels: getNetGrossProfitabilityObj.Projects ,
                        datasets: [{
                            label: "% Gross",
                            backgroundColor: "#0d95d3",
                            data: getNetGrossProfitabilityObj.Gross,
                            datalabels: {
                                color: 'white'
                            }
                        }, {
                            label: "% Net",
                            backgroundColor: "#4263c2",
                            data: getNetGrossProfitabilityObj.Net,
                            datalabels: {
                                color: 'white'
                                },
                           
                        }]
                    };
                } else {
                    NGProfitabilitydata = {
                        labels: [],
                        datasets: [{
                            label: "% Gross",
                            backgroundColor: "#0d95d3",
                            data: [],
                            datalabels: {
                                color: 'white'
                            }
                        }, {
                            label: "% Net",
                            backgroundColor: "#4263c2",
                            data: [],
                            datalabels: {
                                color: 'white'
                            }
                        }]
                    };
                }
                if (myNGProfitabilityBarChart != undefined && myNGProfitabilityBarChart != null) {
                    myNGProfitabilityBarChart.destroy();
                }
                myNGProfitabilityBarChart = new Chart(NGProfitability, {
                    type: 'bar',
                    data: NGProfitabilitydata,
                    //tooltip:"sdasd",
                    //options: {
                    //    legend: {
                    //        display: true,

                    //    },
                    //    barValueSpacing: 100,

                    //    scales: {
                    //        xAxes: [{
                    //            gridLines: {
                    //                display: false,
                    //                color: "rgba(0, 0, 0, 0)",
                    //            },

                    //            ticks: {
                    //                autoSkip: false,
                    //                maxRotation: 20,
                    //                minRotation: 30,
                    //                callback: function (value) {
                    //                    //debugger;
                    //                    globalTooltip = value;
                    //                    if (value.length > 12) {
                    //                        value = value.substr(0, 12);
                    //                        return value + "...";
                    //                    } else {
                    //                        return value;
                    //                    }
                    //                    //truncate
                                       
                    //                },
                    //            },

                    //            barPercentage: 1,
                    //            barThickness: 20,
                               
                    //        }],
                           
                    
                    //    }
                    //},

                    options: {
                         legend: {
                            display: true,

                        },
                        barValueSpacing: 100,
                        scales: {
                            xAxes: [{
                                ticks: {

                                    autoSkip: false,
                                    maxRotation: 20,
                                    minRotation: 10,

                                    callback: function (value) {
                                        //debugger;
                                        globalTooltip = value;
                                        if (value.length > 12) {
                                            value = value.substr(0, 20);
                                            return value + "...";
                                        } else {
                                            return value;
                                        }
                                        //truncate
                                       
                                    },
                                },
                                 barPercentage: 1,
                                 barThickness: 20,
                            }],
                             yAxes: [{
                                display: true,
                                ticks: {
                                    suggestedMin: 10,
                                    suggestedMax: 100,
                                    callback: function (value) { return value + "%" }
                                },
                                scaleLabel: {
                                    display: true,
                                    labelString: "Percentage"
                                }
                            }],
                        
                        },
                        tooltips: {
                            enabled: true,
                            mode: 'label',
                            callbacks: {
                                title: function (tooltipItems, data) {
                                    //debugger;
                                    //var STR = NGProfitabilitydata;
                                    if (SelectedWhichgraphTab == "Customer") {
                                        var idx = tooltipItems[0].index;
                                        return 'Customer Name : ' + data.labels[idx] + "\nProject Currency : " + getNetGrossProfitabilityObj.CurrencySymbol[idx] + "";

                                    }
                                    else {
                                        var idx = tooltipItems[0].index;
                                        return 'Project Name : ' + data.labels[idx] + "\nProject Currency : " + getNetGrossProfitabilityObj.CurrencySymbol[idx] + "";


                                    }
                                    //return globalTooltip;
                                },
                                label: function (tooltipItems, data) {
                                    var idx = tooltipItems.datasetIndex;
                                   // return data.dataset[idx];
                                    return data.datasets[idx].label + " : " + tooltipItems.yLabel + "%";
                                }
                            }
                        }
                    },
                });
         } 
        else {
                //if (IsNodataNetGrossProfitablity == 1) {
                //bdyAcruedCost
                //$("#NGProfitability").html("");
                //$("#bdyNGProfitabilityn").html("");
                $("#SWITCHNET").hide();
                //$("#IDNet").prop("disabled", true);
                $("#IDNetNext").hide();
                $("#IDNetPrev").hide();
                
                $("#bdyNGProfitability").css("display", "none");
                $("#NetNodata").css("display", "block");
                $("#NetNodata").html("<p class='ClsNoData' style='margin: 77px 0 10px'>No data available in table</p>");
            }
        }
        //End chart for Nwt Profitability

        //start chart for Acrued Revenue/Cost
        var myAcruedCostBarChart;
        function getAcruedRevenueCost(data) {
          // debugger;
            var AccuredIsNoData = 0;
            var getAcruedRevenueCostObj;
            //data = null;
            //alert(data.AcruedRevenueCost);
            if (data != null || data != undefined) {
                getAcruedRevenueCostObj = data.AcruedRevenueCost;
                AccuredIsNoData = 0;
            } else {
                getAcruedRevenueCostObj = null;
                AccuredIsNoData = 1;
            }


            if (getAcruedRevenueCostObj.Projects.length < 5) {
                $("#IDAccruedNext").hide();
                $("#IDAccruedPrev").hide();
             } else {
                  $("#IDAccruedNext").show();
            }

            if (SelectedWhichgraph != "") {
                Getshowhidebutton(getAcruedRevenueCostObj.Projects.length, SelectedWhichgraph);
            }
             
            if (getAcruedRevenueCostObj.Projects.length != 0) {
                 $("#bdyAcruedCost").css("display", "block");
                $("#AccruedNodata").css("display", "none");
                $("#SWITCHACCRUD").show();
                $("#AccruedNodata").html("");
                var AcruedCost = document.getElementById("AcruedCost").getContext("2d");
                var AcruedRevenueCostdata;
                if (getAcruedRevenueCostObj != null) {
                    AcruedRevenueCostdata = {
                        labels: getAcruedRevenueCostObj.Projects,
                        datasets: [{
                            label: "% Revenue",
                            backgroundColor: "#0d95d3",
                            data: getAcruedRevenueCostObj.AccruedRevenue,
                            datalabels: {
                                color: 'white'
                            }
                        }, {
                            label: "% Cost",
                            backgroundColor: "#4263c2",
                            data: getAcruedRevenueCostObj.AccruedCost,
                            datalabels: {
                                color: 'white'
                            }
                        }]
                    };
                } else {
                    AcruedRevenueCostdata = {
                        labels: [],
                        datasets: [{
                            label: "% Revenue",
                            backgroundColor: "#0d95d3",
                            data: [],
                            datalabels: {
                                color: 'white'
                            }
                        }, {
                            label: "% Cost",
                            backgroundColor: "#4263c2",
                            data: [],
                            datalabels: {
                                color: 'white'
                            }
                        }]
                    };
                }
                if (myAcruedCostBarChart != undefined && myAcruedCostBarChart != null) {
                    myAcruedCostBarChart.destroy();
                }
                myAcruedCostBarChart = new Chart(AcruedCost, {
                    type: 'bar',
                    data: AcruedRevenueCostdata,
                    //options: {
                    //    legend: {
                    //        display: true,
                    //    },
                    //    barValueSpacing: 100,
                    //    scales: {
                    //        xAxes: [{
                    //            gridLines: {
                    //                display: false,
                    //                color: "rgba(0, 0, 0, 0)",
                    //            },
                    //            ticks: {
                    //                autoSkip: false,
                    //                maxRotation: 20,
                    //                minRotation: 30
                    //            },
                    //            barPercentage: 1,
                    //            barThickness: 20,
                    //        }],
                    //        yAxes: [{
                    //            display: true,
                    //            ticks: {
                    //                suggestedMin: 10,
                    //                suggestedMax: 100,
                    //                callback: function (value) { return value + "%" }
                    //            },
                    //            scaleLabel: {
                    //                display: true,
                    //                labelString: "Percentage"
                    //            }
                    //        }]
                    //    }
                    //},
                    options: {
                         legend: {
                            display: true,

                        },
                        barValueSpacing: 100,
                        scales: {
                            xAxes: [{
                                ticks: {

                                    autoSkip: false,
                                    maxRotation: 20,
                                    minRotation: 10,

                                    callback: function (value) {
                                        //debugger;
                                        globalTooltip = value;
                                        if (value.length > 12) {
                                            value = value.substr(0, 20);
                                            return value + "...";
                                        } else {
                                            return value;
                                        }
                                        //truncate
                                       
                                    },
                                },
                                 barPercentage: 1,
                                 barThickness: 20,
                            }],
                             yAxes: [{
                                display: true,
                                ticks: {
                                    suggestedMin: 10,
                                    suggestedMax: 100,
                                    callback: function (value) { return value + "%" }
                                },
                                scaleLabel: {
                                    display: true,
                                    labelString: "Percentage"
                                }
                            }],
                        
                        },
                        tooltips: {
                            enabled: true,
                            mode: 'label',
                            callbacks: {
                                title: function (tooltipItems, data) {

                                    if (SelectedWhichgraphTab == "Customer") {
                                        var idx = tooltipItems[0].index;
                                        return 'Customer Name : ' + data.labels[idx] + "\nProject Currency : " + getAcruedRevenueCostObj.CurrencySymbol[idx] + "";

                                    } else {
                                        var idx = tooltipItems[0].index;
                                        return 'Project Name : ' + data.labels[idx] + "\nProject Currency : " + getAcruedRevenueCostObj.CurrencySymbol[idx] + "";
                                    }
                                        //return globalTooltip;
                                },
                                label: function (tooltipItems, data) {
                                    //;
                                    var idx = tooltipItems.datasetIndex;
                                   // return data.dataset[idx];
                                    return data.datasets[idx].label + " : " + tooltipItems.yLabel + "%";
                                }
                            }
                        }
                    },
                    plugins: {
                        datalabels: {
                            align: 'end',
                            anchor: 'end',
                            backgroundColor: function (context) {
                                return context.dataset.backgroundColor;
                            },
                            borderRadius: 4,
                            color: 'white',
                            formatter: function (value) {
                                return value + ' text ';
                            }
                        }
                    }
                });
            }
            else {
            //if (AccuredIsNoData==1 || data.AcruedRevenueCost.Projects==null) {
                //bdyAcruedCost
                //$("#AcruedCost").html("");
                //$("#bdyAcruedCost").html("");
                $("#SWITCHACCRUD").hide();
                //$("#IDAccrued").prop("disabled", true);
                 $("#IDAccruedNext").hide();
                $("#IDAccruedPrev").hide();
                 $("#bdyAcruedCost").css("display", "none");
                $("#AccruedNodata").css("display", "block");
                $("#AccruedNodata").html("<p class='ClsNoData' style='margin: 77px 0 10px'>No data available in table</p>");
                //$("#bdyAcruedCost").html("<p class='ClsNoData' style='margin: 77px 0 10px'>No data available in table</p>");
            }
           // alert(AccuredIsNoData);
        }
        //end chart for Acrued Revenue/Cost


         //start chart for Delay in Realization
        var myDelayinRealizationChart;
        function getDelayinRealization(data){
           //debugger;
            
            var IsNoDataDelayinRealizationChart = 0;
            var getDelayinRealizationObj;
            if (data != null || data != undefined) {
              
                getDelayinRealizationObj = data.DelayinRealization;
          //      IsNoDataDelayinRealizationChart = 0;
            } else {
               
                getDelayinRealizationObj = null;
                IsNoDataDelayinRealizationChart = 1;
            }
           
            // debugger;
           
            //debugger;
            if (data.DelayinRealization.Days[0] != "0"
                || data.DelayinRealization.Days[1] != "0") {
               // alert(1);

                var DelayinRealization = document.getElementById("DelayinRealization");
                 var DelayinRealizationdata;
                $("#NOData").html("");
                $("#NOData").css("display","none");
                $("#bdyDelayinRealization").css("display","block");
                //$("#bdyDelayinRealization").html("");
                if (getDelayinRealizationObj != null) {
                    
                    DelayinRealizationdata = {
                        labels: getDelayinRealizationObj.DaysAging,
                        datasets: [{
                            label: '',
                            backgroundColor: [

                                'rgba(255, 206, 86, 1)',
                                'rgba(235, 28, 36, 1)',
                            ],
                            borderColor: [


                                'rgba(255, 206, 86, 1)',
                                'rgba(235, 28, 36, 1)',
                            ],
                            borderWidth: 1,
                            data: getDelayinRealizationObj.Days
                        }]
                    };
                } 

                //if (myDelayinRealizationChart != undefined && myDelayinRealizationChart != null) {
                    //myDelayinRealizationChart.destroy();
                //}
                myDelayinRealizationChart = new Chart(DelayinRealization, {
                    type: 'pie',
                    data: DelayinRealizationdata,
                    options: {
                        cutoutPercentage: 80,
                        responsive: false,
                        legend: {
                            display: true,
                            position: 'right',
                            labels: {
                                fontColor: "#000080",
                            }
                        },
                    }
                });
                //debugger;
            }
            else
            {
                
                //debugger;
                var DelayinRealization = document.getElementById("DelayinRealization");
                var DelayinRealizationdata;
                if (getDelayinRealizationObj != null) {
                    DelayinRealizationdata = {
                        labels: [],
                        datasets: [{
                            label: '',
                            //backgroundColor: [

                            //    '',
                            //    '',
                            //],
                            //borderColor: [

                            //    '',
                            //    '',
                            //],
                            borderWidth: 1,
                            data: []
                        }]
                    };
                } 

                if (myDelayinRealizationChart != undefined && myDelayinRealizationChart != null) {
                    myDelayinRealizationChart.destroy();
                }
                myDelayinRealizationChart = new Chart(DelayinRealization, {
                    type: 'pie',
                    data: DelayinRealizationdata,
                    options: {
                        cutoutPercentage: 80,
                        responsive: false,
                        legend: {
                            display: true,
                            position: 'right',
                            labels: {
                                fontColor: "#000080",
                            }
                        },
                    }
                });
                $("#bdyDelayinRealization").css("display","none");
                $("#NOData").html("");
                $("#NOData").html("<p class='ClsNoData' style='margin: 77px 0 10px'>No data available in table</p>");

            }
        
            
        }
        //end chart for Delay in Realization


       //var CustomerDetails = "";
        function GetProjectData(data) {
            //debugger;
            var projectList;
            if (data != null || data != undefined) {
                projectList = data.ProjectData;
            } else {
                projectList = null;
            }
            $("#tblgrid").dataTable().fnDestroy();
            $('#tbodyProjectData').html('');
            var Body = "";
            if (projectList != null) {
               // Body = '<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td> < 15 </td><td> > 15</td></tr>';
                    
                $.each(projectList, function (index, item) {
                    //debugger;
                    if (item.CustomerContactName == 0) {

                        item.CustomerContactName = "<Not Specified>";
                    }

                    if ( item.CustomerConatctEmail == 0) {

                        item.CustomerConatctEmail = "<Not Specified>";
                    }

                     if (item.CustomerMobileNumber == 0) {

                        item.CustomerMobileNumber = "<Not Specified>";
                    }

                    //Added By Dipali V On 16th March 2023 For Check  GrossProfitability & NetProfitability Values
                    if (item.GrossProfitability > 0) {
                        item.GrossProfitability = item.GrossProfitability
                    } else {
                        item.GrossProfitability = 0;
                    }

                    if (item.NetProfitability > 0) {
                        item.NetProfitability = item.NetProfitability
                    } else {
                        item.NetProfitability = 0;
                    }
                     //End of Added By Dipali V On 16th March 2023 For Check  GrossProfitability & NetProfitability Values
                    //var CustomerDetails = '<td data-toggle="tooltip" data-placement="top" data-container="body" data-original-title="Customer Contact Name : -   ' + item.CustomerContactName + 'Customer Email ID : -   ' + item.CustomerConatctEmail + 'Customer Mobile No. : - ' + item.CustomerMobileNumber + '" >' + item.Customer + '</td>';
                    var CustomerDetails = '<td><div style=""><span data-html="true" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" title="Customer Email ID : -   ' + item.CustomerConatctEmail + '<br/> Customer Mobile No. : - ' + item.CustomerMobileNumber + '<br/> Customer Contact Name : -   ' + item.CustomerContactName + '" >' + item.Customer + '</span></div></td>';

                  
                    var tr = '<tr>'
                    tr += '<td class="text-start dropdown PRrolename">' + item.ProjectName + '</td>';
                    tr += '<td>' + item.Type + '</td>';
                    tr += '<td>' + item.TotalMilestone + '</td>';
                   // tr += '<td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Some long text <br/> Second line text \n Third line text" >' + item.Customer + '</td>';
                    tr += CustomerDetails;
                    tr += '<td>' + item.On + '/' + item.Off + '</td>';
                    var MilestnBilng = '<td class="MilestnBilng">' +
                        '<div class="progress">' +
                        '<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40"' +
                        'aria-valuemin="0" aria-valuemax="100" style="width: ' + item.MilestoneBilling + '%">' + item.MilestoneBilling + '%' +
                        '</div>' +
                        '</div>' +
                        '</td>';
                    tr += MilestnBilng;
                    tr += '<td>' + item.TotalBilling + '</td>';
                    tr += '<td <div style=""><span data-html="true" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-container="body" data-original-title="Project Total Amount ( Project Currency )">' + item.ProjectTotalAmount + ' ( '+ item.CurrencySymbol +')</span></div></td>';
                    //tr += '<td>' + item.RPP + '</td>';
                    tr += '<td>' + item.RPP+ '</td>';
                   // tr += '<td>' + item.AcruedRevenue + ' ( '+ item.CurrencySymbol +') </td>';
                    tr += '<td class="cursymbolTD">' + item.AcruedRevenue + ' <span class="cursymbol">( '+ item.CurrencySymbol +')</span> </td>';
                    tr += '<td class="cursymbolTD">' + item.AcruedCost +  ' ( '+ item.CurrencySymbol +')</td>';
                    //tr += '<td>' + item.GrossProfitability + "%" + '</td>';
                    //tr += '<td>' + item.NetProfitability + "%" + '</td>';
                    tr += '<td>' + parseFloat(item.GrossProfitability).toFixed(2) + "%" + '</td>';
                    tr += '<td>' + parseFloat(item.NetProfitability).toFixed(2) + "%" + '</td>';
                    tr += '<td>' + item.Overhead + '</td>';
                   tr += '<td>' + item.RealizationBelowThreshold + ' | ' + item.RealizationAboveThreshold + ' </td>';
                   //tr += '<td>' + item.RealizationBelowThreshold + '</td><td>' + item.RealizationAboveThreshold + '</td>';
                    tr += '</tr>';
                   // Body = '<tr><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td> < 15 </td><td> > 15</td></tr>';
                        
                    Body += tr;
                });
            }
           // debugger;
            Body = Body.replace('@@', '<br />')
            $('#tbodyProjectData').html("");
            $('#tbodyProjectData').html(Body);
            //alert(Body.replace('@@', '<br />'));
            $('#tblgrid').DataTable({
                "paging": true,
                "pageLength": 5,
                "bRetrieve": true,
                "scrollX": true,
                //"scrollY": "200px",
                "searching": false,
                "lengthChange": false,
                "columnDefs": [{ orderable: true, targets: [0] }]

            });
            setTimeout(function () {
                $.fn.dataTable.tables({ visible: true, api: true }).columns.adjust();
            }, 350);

            $('[data-bs-toggle="tooltip"]').tooltip();
            $('[data-bs-toggle="popover"]').popover();
        }

        //Added By Dipali V On 17th July 2020 For Toggle funtionality
        var SelectedWhichgraph1 = "";
        function GetWhichGraph(SelectedWhichgraph1, Count) {
            SelectedWhichgraph = SelectedWhichgraph1 ;
            var controlIDactive = $("#ID" + SelectedWhichgraph1).is(':checked');
           // debugger;
            Count = GlobalCount;
            //alert(controlIDactive);
            if (SelectedWhichgraph == "Net") {
                if (controlIDactive == true) {
                    SelectedWhichgraphTab = "Project";
                    GetCommercialDetails("Project",Count);

                } else {
                    SelectedWhichgraphTab = "Customer";
                    GetCommercialDetails("Customer",Count);

                }

               
            } else {

                if (controlIDactive == true) {

                    SelectedWhichgraphTab = "Project";
                    GetCommercialDetails("Project",Count);

                } else {
                    SelectedWhichgraphTab = "Customer";
                    GetCommercialDetails("Customer",Count);

                }

            }
        }

        var GlobalCount = "";
        function GetPrevNextData(Whichgraph, Count, Action) {
          //debugger;
            if (Whichgraph != SelectedWhichgraph) {
                GlobalCount = "";
            } 
            if (Action == "Prev") {
                 if (GlobalCount != "") {
                     GlobalCount = Number(GlobalCount) - Number(Count);

                } else {
                     GlobalCount = Number(Count) + Number(5);
                }
            }
            else {
                if (GlobalCount != "") {
                     GlobalCount =  Number(GlobalCount) + Number(Count);

                } else {
                    GlobalCount = Number(Count);
                }

            }
            //if (Number(GlobalCount) > 5) {
            //    $("#IDPrev").show();
            //} else {
            //    $("#IDPrev").prop("display", "none");
            //}
           // alert(GlobalCount);
           // debugger;
            GetWhichGraph(Whichgraph, GlobalCount);
        }


        //**   FUNCTIONS ADDED BY VIDHI FOR POP UP WINDOW   **

           // added by Vidhi if user made selection from the drop down inside the pop up window
        var selectedProjectDataDisplayInsidePopupWindow = new Array();
           var projectidInsidePop = 0;
        
        $("#CboProjectInSideMPopUP").on('change', function () { 
            //alert(1);
           $('#tbltbodyPreProjecttbl').html('');
            selectedProjectDataDisplayInsidePopupWindow = []; 
            projectidInsidePop = [];
            ProjectID = $("#CboProjectInSideMPopUP").val();         
            projectidInsidePop = ProjectID; 
           //  StartLoader("#PreProModalpopup");

            if (ProjectID == "0" || ProjectID == null) {              
                ProjectID = 0 ;                 
            }
            if (BusinessGroupIDG == 0) {
                //alert("NO")
                projectidInsidePop = [];
                projectidInsidePop = ProjectID;
                if (ProjectID == 0) {
                    DisplayProjectsInsidePopUpWindow(allSelectedDataInsidePopUpWindow);

                } else {
                   // alert(2);
                    
                     //StartLoader("#PreProModalpopup");
                    //test code
                    $("#pagination li").hide();
                    $("#pagination li.disabled, #pagination li.active, #pagination li:last-child").show();
                    //test code end
                    SelectedValueDisplayInsidePopupWindow(allSelectedDataInsidePopUpWindow);
                   // StopAjaxLoader("#PreProModalpopup");
                }
            }
            else {
               // alert(BusinessGroupIDG)BGOUFilterData

                if (LocationIDG == 0) {
                    // alert("NO");
                    projectidInsidePop = [];
                    projectidInsidePop = ProjectID;
                    if (ProjectID == 0) {
                        DisplayProjectsInsidePopUpWindow(DataAccordingToBG);

                    } else {
                        SelectedValueDisplayInsidePopupWindow(DataAccordingToBG);
                    }

                } else {
                    //  alert(LocationIDG);
                    //projectidInsidePop = [];
                    //projectidInsidePop = ProjectID;
                    if (ProjectID == 0) {
                        DisplayProjectsInsidePopUpWindow(BGOUFilterData);

                    } else {
                        //alert(3);
                        
                       SelectedValueDisplayInsidePopupWindow(BGOUFilterData);
                    }
                }

                
            }  
           // StopAjaxLoader("#PreProModalpopup");

        });
         // End by Vidhi if user made selection from the drop down inside the pop up window

        // Added by vidhi for selecting BG inside the pop up window 
        $("#CboBGInSideMPopUP").on('change', function () { 
            LoadAllOUInPopUP();
            selectedProjectDataDisplayInsidePopupWindow = []; 
           // projectidInsidePop = [];
            BusinessGroupIDG = $("#CboBGInSideMPopUP").val();
            if (BusinessGroupIDG == "0" || BusinessGroupIDG == null) {              
                BusinessGroupIDG = 0 ;               
            }
            if (BusinessGroupIDG == 0) {
                $("#CboProjectInSideMPopUP").html("");
                $("#CboProjectInSideMPopUP").append('<option value="0">Select Project</option>');
                    $.each(allSelectedDataInsidePopUpWindow, function () {
                         $("#CboProjectInSideMPopUP").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));

                    });
                 DisplayProjectsInsidePopUpWindow(allSelectedDataInsidePopUpWindow);
            } else {
                  //test code
                   // alert("testBG");
                    $("#pagination li").hide();
                    $("#pagination li.disabled, #pagination li.active, #pagination li:last-child").show();

                    //test code end
                // write and call method which fetch data according to BG
                  ListOfProjectAccordingToBGSelected();
            }
        });
        // End here by vidhi for selecting BG inside the pop up window

        //Added by Vidhi for selecting OU inside the pop up window
        $("#CboOUInSideMPopUP").on('change', function () {
            selectedProjectDataDisplayInsidePopupWindow = [];
            //projectidInsidePop = [];
            LocationIDG = $("#CboOUInSideMPopUP").val();
            if (LocationIDG == "0" || LocationIDG == null) {
                LocationIDG = 0;
            }
            if (LocationIDG == 0) {
                $("#CboProjectInSideMPopUP").html("");
                $("#CboProjectInSideMPopUP").append('<option value="0">Select Project</option>');
                $.each(DataAccordingToBG, function () {
                    $("#CboProjectInSideMPopUP").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));

                });
                DisplayProjectsInsidePopUpWindow(DataAccordingToBG);
            }
            else { 
                  //test code
                  //  alert("testOU");
                    $("#pagination li").hide();
                    $("#pagination li.disabled, #pagination li.active, #pagination li:last-child").show();

                    //test code end
                SelectedOUProjectDisplay(DataAccordingToBG);
                
            }
        });



        // End here by Vidhi for selecting OU inside the pop up window

           // Function added by Vidhi when user select one option from drop down inside the pop up window 
        function SelectedValueDisplayInsidePopupWindow(data) {
       
            for (var j = 0; j <= data.length; j++) {
                var obj = data[j];
                var currentProjectID = obj.ProjectID;
                //projectidInsidePop = [];
                //projectidInsidePop = currentProjectID;
                if (ProjectID == currentProjectID) {
                    selectedProjectDataDisplayInsidePopupWindow.push(obj);
                }
                 
                DisplayProjectsInsidePopUpWindow(selectedProjectDataDisplayInsidePopupWindow);
                GetListOfProjectStatus(selectedProjectDataDisplayInsidePopupWindow);
            }
        
        }
        /// End of Function added by Vidhi when user select one option from drop down inside the pop up window 



        
        // added by Vidhi Function to fetch  project according to BG and OU
        var BGOUFilterData = new Array();
        function SelectedOUProjectDisplay(data) {
            for (var j = 0; j <= data.length; j++) {
                var obj = data[j];
                var locid = obj.LocationID;

                if (LocationIDG == locid) {
                    selectedProjectDataDisplayInsidePopupWindow.push(obj);
                }
                BGOUFilterData = selectedProjectDataDisplayInsidePopupWindow;

                if (selectedProjectDataDisplayInsidePopupWindow.length == 0) {
                   // alert("No data ");
                    var strHtml = "";
                       
                        $('#tbltbodyPreProjecttbl').html('');
                        strHtml += '<tr>'
                        strHtml += '<td colspan="6">No data available in table</td>'
                        strHtml += '</tr>'
                        $("#tbltbodyPreProjecttbl").html("");
                        $("#tbltbodyPreProjecttbl").html(strHtml);

                } else {
                    $("#CboProjectInSideMPopUP").html("");
                    $("#CboProjectInSideMPopUP").append('<option value="0">Select Project</option>');
                    $.each(selectedProjectDataDisplayInsidePopupWindow, function () {
                        $("#CboProjectInSideMPopUP").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));

                    });

                    DisplayProjectsInsidePopUpWindow(selectedProjectDataDisplayInsidePopupWindow);
                    GetListOfProjectStatus(selectedProjectDataDisplayInsidePopupWindow);
                }
            }
        }
        /// End of added by Vidhi Function to fetch  project according to BG and OU




           //Added by vidhi to access all the project inside the popup window
        function LoadAllAccessibleProject() {
          //StartLoader("#PreProModalpopup"); 
            ListOfProjectInsideThePopWindow();       
            LoadAllBGInPopUP();
           // LoadAllOUInPopUP();
            GetListOfProjectStatus(allSelectedDataInsidePopUpWindow);
            // this  function is for pagination 
        $(function ($) {
            var items = $("#PreProjecttbl tbody tr.pgrow");

            var numItems = items.length;
            var perPage = 8;

            // Only show the first 2 (or first `per_page`) items initially.
            items.slice(perPage).hide();

            // Now setup the pagination using the `#pagination` div.
            $("#pagination").pagination({
                items: numItems,
                itemsOnPage: perPage,
                cssStyle: "light-theme",

                // This is the actual page changing functionality.
                onPageClick: function (pageNumber) {
                    // We need to show and hide `tr`s appropriately.
                    var showFrom = perPage * (pageNumber - 1);
                    var showTo = showFrom + perPage;

                    // We'll first hide everything...
                    items.hide()
                        // ... and then only show the appropriate rows.
                        .slice(showFrom, showTo).show();
                }
            });
            });
            // pagination code endede here

         //StopAjaxLoader("#PreProModalpopup");
        }
        // End by Vidhi to access all the project inside the popup window

        
         // Added by Vidhi to insert the selected value in table 
        function CallInsertionFun() {
             var checkboxValues = new Array;
            var login = encodeURI('<%= Session("intUserID") %>');

            $('#tbltbodyPreProjecttbl input[Class=chcktbl]').map(function () {
                checkboxValues.push(this.id);
                // return this.id;
            }).get().join();

            var CheckBoxValueip;
            try {

                for (var i = 0; i < checkboxValues.length; i++) {

                    var s = checkboxValues[i];
                    CheckBoxID = s.replace("PPcheckbox", "");
                    //alert(CheckBoxID);


                    if ($("#" + s).prop("checked")) {
                        // alert("here");

                        CheckBoxValueip = 1;
                    } else {
                        CheckBoxValueip = 0;


                    }
                    //if ($("#" + s).change) {}


                    var priority = $("#CboPremiumCheckbox" + CheckBoxID).val();
                    if (priority == "High") {
                        priority = 1;
                    } if (priority == "Medium") {
                        priority = 2;
                    } if (priority == "Low") {
                        priority = 3;
                    }
                    //alert(CheckBoxID);
                    //alert(CheckBoxValueip);
                    //alert(priority);
                    var ListOfProjectParameter = {
                        ProjectID: CheckBoxID,
                        CreatedBy: login,
                        Priority: priority,
                        Premium: CheckBoxValueip,


                    }
                    $.ajax({
                        url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/InsertDataIntoTable',// Path
                        type: "POST",                                       //HTTP TYPE get /post
                        data: JSON.stringify(ListOfProjectParameter),       // Parameters
                        dataType: "json",                                   //Retrun Type 
                        contentType: "application/json; charset=utf-8",     //
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                            if (ListOfProjectParameter) {
                                xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                            }
                        },
                        async: false,
                        success: function (result) {
                            //debugger;
                            // alert("Saved Successfully");

                        },
                        error: function (ER) {
                            //alert(ER);
                           // alert(ER.responseText);
                        }
                    });




                }
                 alertify.set('notifier', 'position', 'top-right');
                alertify.success("Saved Successfully.");
            }
            catch (ex) {
                // alert(ex.text);
            }        
            
        }


        // End of  Added by Vidhi to insert the selected value in table 



         // Added By Vidhi To Fetch the data for grid inside the pop up window
       
        function ListOfProjectInsideThePopWindow() {
            // debugger;
            var ListOfProjectParameter = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                LoginID: encodeURI('<%= Session("intLoginID") %>'),
                Flag: 0,
               // Flag: ProjectID

            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/DisplayGridDataInsidePopUP',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(ListOfProjectParameter),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (ListOfProjectParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                    }
                },
                async: false,
                success: function (result) {
                    //debugger; 
                    allSelectedDataInsidePopUpWindow = result;
                    $("#CboProjectInSideMPopUP").html("");
                    $("#CboProjectInSideMPopUP").append('<option value="0">Select Project</option>');
                    $.each(result, function () {
                         $("#CboProjectInSideMPopUP").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));

                    });

                    DisplayProjectsInsidePopUpWindow(result);
                   
                },
                error: function (ER) {
  
                }
            });
          

        }
        // End Added By Vidhi To Fetch the data for grid inside the pop up window


        // Added by Vidhi to fetch data according to BG and bind to Grid inside the pop up window
        var DataAccordingToBG = new Array();
    
        function ListOfProjectAccordingToBGSelected() {
            // debugger;
            var ListOfProjectParameter = {
                UserID: encodeURI('<%= Session("intUserID") %>'),
                LoginID: encodeURI('<%= Session("intLoginID") %>'),
                BusinessGroupID : BusinessGroupIDG,
                
            }
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/FetchDataAccordingtoBG',// Path
                type: "POST",                                       //HTTP TYPE get /post
                data: JSON.stringify(ListOfProjectParameter),       // Parameters
                dataType: "json",                                   //Retrun Type 
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                    if (ListOfProjectParameter) {
                        xhr.setRequestHeader("Params", encryptString(isJson(ListOfProjectParameter) ? ListOfProjectParameter : JSON.stringify(ListOfProjectParameter)));
                    }
                },
                async: false,
                success: function (result) {
                    //debugger; 
                    DataAccordingToBG = result;
                    if (result.length == 0) {
                        // alert(0);
                        var strHtml = "";
                       
                        $('#tbltbodyPreProjecttbl').html('');
                        strHtml += '<tr>'
                        strHtml += '<td colspan="6">No data available in table</td>'
                        strHtml += '</tr>'
                        $("#tbltbodyPreProjecttbl").html("");
                        $("#tbltbodyPreProjecttbl").html(strHtml);
                    

                    } else {

                       
                        $("#CboProjectInSideMPopUP").html("");
                        $("#CboProjectInSideMPopUP").append('<option value="0">Select Project</option>');
                        $.each(result, function () {
                            $("#CboProjectInSideMPopUP").append($("<option></option>").val(this['ProjectID']).html(this['ProjectName']));

                        });
                       
                        DisplayProjectsInsidePopUpWindow(result);
                        GetListOfProjectStatus(result);
                    }
                                
                },
                error: function (ER) {
  
                }
            });
          

        }

        // End of  Added by Vidhi to fetch data according to BG and bind to Grid inside the pop up window


        // Added by Vidhi to get the list of BG inside the pop up window
        function LoadAllBGInPopUP() {
             $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/DisplayBG',// Path
                type: "POST",                                       //HTTP TYPE get /post             
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                },
                async: false,
                success: function (result) {
                    //debugger;
                    $("#CboBGInSideMPopUP").html("");
                    $("#CboBGInSideMPopUP").append('<option value="0">Select BG</option>');
                    $.each(result, function () {
                        $("#CboBGInSideMPopUP").append($("<option></option>").val(this['BusinessGroupID']).html(this['BusinessGroup']));

                    });
                                         
                },
                error: function (ER) {
                    //alert(ER);
                    //alert(ER.responseText);
                }
            });

        }
        // End of  Added by Vidhi to get the list of BG inside the pop up window 

        //  Added by Vidhi to get the list of OU inside the pop up window 
        function LoadAllOUInPopUP() {
             $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/DisplayOU',// Path
                type: "POST",                                       //HTTP TYPE get /post             
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                },
                async: false,
                success: function (result) {
                    //debugger;
                    $("#CboOUInSideMPopUP").html("");
                    $("#CboOUInSideMPopUP").append('<option value="0">Select OU</option>');
                    $.each(result, function () {
                        $("#CboOUInSideMPopUP").append($("<option></option>").val(this['LocationID']).html(this['Location']));

                    });
                                         
                },
                error: function (ER) {
                    //alert(ER);
                    //alert(ER.responseText);
                }
            });

        }
        // End of Added by Vidhi to get the list of OU inside the pop up window 
        
        // Added by Vidhi to get the premium status of project
        var PremiumStatusHolder = new Array();
        var allSelectedDataInsidePopUpWindowProjectID = new Array();
        var NotPresentInNewTable = new Array();

        function GetListOfProjectStatus(Data) {
            //alert("here");
            $.ajax({
                url: encodeURI(strUrl) + '/api/PM_ProjectDashboard/GetProjectStatus',// Path
                type: "POST",                                       //HTTP TYPE get /post             
                contentType: "application/json; charset=utf-8",     //
                beforeSend: function (xhr) {
                    xhr.setRequestHeader('Authorization', 'bearer ' + sessionStorage.getItem("access_token-I"));
                },
                async: false,
                success: function (result) {
                    //debugger;
                    PremiumStatusHolder = result;

                    for (var i = 0; i < Data.length; i++) {
                        var obj = Data[i];
                        var pid = obj.ProjectID;
                        for (var j = 0; j < PremiumStatusHolder.length; j++) {
                            var obj3 = PremiumStatusHolder[j];
                            var pppid = obj3.ProjectID;
                             var priostatus = obj3.Priority;
                            if (priostatus == "H") {
                                priostatus = 1;
                            } if (priostatus == "M") {
                                priostatus = 2;
                            }if (priostatus == "L") {
                                priostatus = 3;
                            }
                            if (priostatus == " ") {
                                priostatus = 0;
                            }
                            var statusP = obj3.Premium;
                            if (pid == pppid) {
                               // alert("Same");
                                if (statusP == true) {
                                   //$("#PPcheckbox" + pppid).prop("checked", true);
                                  //  $(this).attr("id", "#PPcheckbox" + pppid).prop('checked', true);                                  
                                    $("#PPcheckbox" + pppid).prop("checked", true);


                                }
                                 $("#CboPremiumCheckbox" + pppid + " option[value='" + priostatus+ "']").prop('selected', true);
                            }
                                
                        }

                      
                    }

                                                           
                },
                error: function (ER) {
                    //alert(ER);
                    //alert(ER.responseText);
                }
            });

        }



        // End by Vidhi to get the premium status of project

        // Added by Vidhi to display projects on grid  in side the pop up window
      
        function DisplayProjectsInsidePopUpWindow(Data) {
                var strHtml = "";
                projectidInsidePop = [];// this array to hold the selected value from grid . here we clear array first
                //$("#PreProjecttbl").dataTable().fnDestroy();              
                $('#tbltbodyPreProjecttbl').html('');
                var Body = "";
                for (var i = 0; i < Data.length; i++) {

                    var ProjectName = Data[i]["ProjectName"];
                    var ProjectID = Data[i]["ProjectID"];
                    var Description = Data[i]["Description"];
                    var StartDate = Data[i]["StartDate"];
                    var EndDate = Data[i]["EndDate"];
                    projectidInsidePop = ProjectID;
                    strHtml += ' <tr class="pgrow">'

                    strHtml += ' <td>' + ProjectName + '</td>'
                    strHtml += ' <td>' + Description + '</td>'
                    strHtml += ' <td>' + StartDate + '</td>'
                    strHtml += ' <td>' + EndDate + '</td>'
                    // strHtml += '<td> <div class="custom_chckbox"><input id="PPcheckbox1" class="chcktbl" type="checkbox"> <label for="PPcheckbox1"></label></div> </td>'               
                    strHtml += '<td>'
                    strHtml += " <div class='custom_chckbox' id='PPCHK'>"
                    strHtml += " <input type='checkbox' id='PPcheckbox" + ProjectID + "' class='chcktbl' >"
                    // strHtml += " <input type='checkbox' id='PPcheckbox' value='" + ProjectID + "' class='chcktbl' >"                                           
                    strHtml += "  <label for='PPcheckbox" + ProjectID + "'></label>"
                    strHtml += " </div>"
                    strHtml += '</td'
                    strHtml += "<td>"
                    //strHtml += '<td>  <select class="form-control selectpicker input-sm" id="PremiumCheckbox"> <option>High</option> <option>Medium</option> <option>Low</option> </select> </td>'
                    strHtml += '<td>  <select class="form-control  input-sm" id= "CboPremiumCheckbox'  + ProjectID + '" ><option value="0">Select</option><option value="1">High</option> <option value="2">Medium</option> <option value="3">Low</option> </select> </td>' 
                    strHtml += "</td>"
                    strHtml += '</tr>'

                }
                //  Body += strHtml;
                $("#tbltbodyPreProjecttbl").html("");
                $("#tbltbodyPreProjecttbl").html(strHtml);
            


        }

        // End by Vidhi to display project on grid in side the pop up window
        //Search list
        function mysearchFunction() {
            var $rows = $('#PreProjecttbl tbody tr');
            $('#srchPPlist').keyup(function () {
                var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();

                $rows.show().filter(function () {
                    var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
                    return !~text.indexOf(val);
                    return !~text.indexOf(val);
                }).hide();
                $(".table").resize();
            });
        }
         //End Search list



        /// END OF FUNCTIONS ADDED BY VIDHI FOR POP UP WINDOW 











       
    </script>



</body>
</html>
