<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PM_ProjectHealthSheet_Help.aspx.vb" Inherits="PbNIT.PM_ProjectHealthSheet_Help" %>

<!DOCTYPE html>
<html>
    
    <!-- Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
    <%CommonFunctions.General.PlotPageHeadTag("Project Health Sheet Help")%>
    <!-- End of Commented by Gauri on 13/08/24 for JQuery and Bootstrap version upgrade -->
<head>
    <%--<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Project Health Sheet Help</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css?v=2">
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css?v=1">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
    <!-- Theme style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
    <!-- animate css -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap-5.2.2.min.css?v=0">
    <!-- custom style -->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
    <link href="../../../Whizible2.0-new/dist/css/BS5_migration.css" rel="stylesheet" />

    <!-- alertify -->
    <%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css?v=0.1">--%>
</head>
    
    <style type="text/css">
       /*CSS Added & Commented By Madhuri.K On 22-Aug-2024 For displaying panel-title with there text color start here*/
        .collapsed {
    display: block;
      }
        .panel-default > .panel-heading a {
    color: #000;
     }
        /*CSS Added & Commented By Madhuri.K On 22-Aug-2024 For displaying panel-title with there text color End here*/
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


        /*Added style by pradip on 6-1-2021*/
        h5.pgtitle {
            margin: 6px 0 0;
            font-weight: 700;
            color: #4263c1;
            font-size: 16px;
        }

        .contentnavlist ul {
            width: 100%;
        }

            .contentnavlist ul li {
                display: block;
                width: 100%;
                font-size: 16px;
                border-top: 1px solid #4263c1;
                border-bottom: 1px solid #4263c1;
            }

        .sectionHead {
            color: #4263c1;
            font-size: 16px;
            font-size: 20px;
            font-weight: bold;
        }

        .contentnavlist ul li a {
            padding: 10px 15px; display:block;
        }

        ol {
            margin: 0px 0px 0px 20px;
            padding: 0px;
        }

        ol {
            margin-left: 20px;
        }

            ol li {
                list-style-type: decimal;
                margin: 0 0 5px;
            }

        .notebox {
            padding: 10px;
            border-radius: 4px;
        }

        .RD_Accordian {
            margin: 10px 0px 0px;
        }

            .RD_Accordian .panel-heading {
                background: none;
                padding: 10px 0;
            }

            .RD_Accordian .panel.panel-default {
                padding: 0px;
                border: none;
            }

            .RD_Accordian .panel-title {
                font-size: 14px;
            }

            .RD_Accordian .panel-heading a:after {
                font-family: 'Glyphicons Halflings';
                content: "\2212";
                float: left;
                color: #333;
                margin-right: 10px; font-weight:bold;
            }

            .RD_Accordian .panel-heading a.collapsed:after {
                content: "\2b";
            }

            .RD_Accordian .panel-heading a:after {
                font-family: 'Glyphicons Halflings';
                content: "\2212";
                float: left;
                color: grey;
                margin-right: 10px;
            }

            .RD_Accordian .panel-heading a.collapsed:after {
                content: "\2b";
            }

        .notebox, .notebox p {
            font-size: 12px;
        }
		
.h5, h5 {font-size: 0.85rem;}	
.h1, .h2, .h3, h1, h2, h3 {
    margin-top: 20px;
    margin-bottom: 10px;
}	
		
    </style>

<body class="hold-transition skin-blue-light sidebar-mini fixed">

    <div class="bgwhite">
        <div class="container-fluid pt-1 pb-1 mb-1 text-right graybg clearfix">
            <h5 class="pgtitle pull-left">Project Health Sheet</h5>

        </div>
         <div class="clearfix"></div>

        <div class="content pt-0">
            <div class="help_pg_wrapper pt-1">
                <p>
                    Project Sheet is a comprehensive report that presents the facts about the critical project parameters in a unified display. Project Sheet is based on SQERT Analysis, the industry standard for tracking project progress.
                    Project Sheet provides an objective measurement of the quality and quantity of efforts being put in for the in time completion of a project. Using the Project Sheet, the management can comprehend the celebrity of the project.
                </p>
                <br />
                <br />
                <h5>What do you want to do?</h5>
                <div class="contentnavlist">
                    <ul class="nav navbar-nav">
                        <li><a href="#section1">View Deliverable Details Report</a></li>
                    </ul>
                </div>
                <div class="clearfix"></div>
                <div id="section1" class="container-fluid">
                    <h2 class="sectionHead">Viewing Project Health Sheeet Report </h2>

                    <ol>
                        <li>On the <strong>Project</strong> menu, click Project Management and select <strong>Monitor and Control</strong>. Under <strong>Monitor and Control</strong> select <strong>Project Health Sheet.</strong></li>
                        <li>On the <strong>Project Health Sheet</strong> page, Select <strong>a Practice</strong> from the list. This will display the <strong>Projects</strong> of the selected <strong>Practice</strong> only.</li>
                        <li>Select the <strong>Business Group</strong>  to which the project is mapped.</li>
                        <li>Select the <strong>Organization Unit</strong> to which the project is mapped.</li>
                        <li>Select the <strong>Project</strong> whose <strong>Project Health Sheet</strong> is to be generated.</li>
                        <li>Select  the Project Group to which the project is associated.</li>
                        <li>From the <strong>Deliverable Type</strong> list select the deliverable type for which you wish to view the report. The details of all the deliverables defined for the selected deliverable will be displayed in the report.</li>
                        <li>By Default <strong>Reporting Period</strong> is selected.
                        <br />
                            <br />
                            <div class="notebox graybg">
                                <p><strong>NOTE:</strong></p>
                                <p>
                                    1. The reporting period is to be considered only for scope & quality. For effort, time & risk, all data from project start date till SQERT reporting date is considered.<br />
                                    2. If your Reporting Date is 18-Oct-2005, and Reporting Period is monthly, the report output will consider the values one month before 18 October.
                                </p>
                            </div>
                            <br />
                        </li>
                        <li>By Default <strong>Current Date</strong> is displayed as Reporting Date. you can change the same if required.</li>
                        <li>After you have entered the values, click on the Update SQERT Values link. The new window that pops up provides a Value text box and Description text area corresponding to each of the SQERT parameters enlisted under the same heading.
                            <br />
                            <br />
                            <div class="notebox graybg">
                                <ul>
                                    <li>The SQERT parameters are Scope, Quality, Efforts, Risk, Time.</li>
                                    <li>You can update the values for Scope and Quality only. The values for Efforts, Risk and Time are calculated by the system.
                                        It is mandatory to enter the description for each of the five parameters.  </li>
                                    <li>The updated values cannot be edited after they are locked. Even if any changes are made, they are not reflected in the report output.</li>

                                </ul>
                            </div>
                            <br />
                        </li>
                        <li>After all the values are registered, you must freeze the values. For this go to PROCESSES > SQERT Locking. </li>
                        <li>The default screen of this node enlists the projects for which the SQERT values have been updated. These are sorted by the Status, which can either be Locked or Unlocked.</li>
                        <li>Mark the flag fields corresponding to the project whose SQERT values are to be locked and save the page.</li>
                        <li>Alternatively, you can unlock the SQERT values. For this follow the same procedure.Once you freeze the SQERT values, you cannot edit them.</li>
                        <li>Click on the View Report link, to view the report output. Another window pops up. The header of this screen displays the Practice, Organization Unit, Project, Business Group of the Project for which the Project Health Sheet is generated. This window is divided into three sections, viz., 
                            <ol>
                                <li>SQERT Details</li>
                                <li>Earned Value Analysis</li>
                                <li>Graphs</li>
                            </ol>
                        </li>
                        <li>Details Of Report Output:</li>
                        <li>The SQERT Details section displays the following tables...
                            <ul>
                                <li>Issues: Displays the issue status as on date.</li>
                                <li>Key Achievements in the reporting period:  Displays the total tasks completed during the reporting period.</li>
                                <li>Targets to achieve in the next reporting period: Total tasks to be completed during the next reporting period</li>
                                <li>SQERT: The project analysis based on the SQERT parameters.</li>
                                <li>Baseline: Displays the details of change in scope.</li>
                                <li>Milestone: Displays milestone details for the selected project.</li>
                                <li>Active Resources: Displays the resources currently working on the project along with the planned and actual working hours.</li>
                            </ul>
                            <br />
                            <br />
                            <div class="notebox graybg">
                                <p><strong>NOTE:</strong></p>
                                <ul>
                                    <li>When you extract a report without selecting a Project, the system displays an analysis of all the projects to which you are assigned. Thus, a BU Manager can procure a report for his Business Group, by selecting the Business Unit only.
                                    </li>
                                </ul>
                            </div>
                            <br />
                        </li>
                        <li>Details Of Report Output:
                            <div class="RD_Accordian">
                                <div class="panel-group" id="accordion">
                                    <div class="panel panel-default" id="DOROpanel1">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-bs-toggle="collapse" data-target="#DOROcollapseOne"
                                                    href="#DOROcollapseOne">Issues
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="DOROcollapseOne" class="panel-collapse collapse show">
                                            <div class="panel-body">
                                                <p>You can view Issues under breakdown Issue Details, Ageing Analysis (Only open Issues), Shown to Customer, Total Open Issues.After clicking the number link of each section The popup tabulates the issue history under the headings <strong>Sr No.,  Issue ID, Summary,  Reported Date,  Issue Type, Sub Type, Priority, Severity, Due Date, and Reported By.</strong></p>

                                                <p><strong>Taken from :</strong> Issues</p>
                                                <p><strong>Description :</strong> The system takes into consideration all the issues reported and resolved during the selected Reporting Period.</p>
                                                <p><strong>Issue Details:</strong> Issues are displayed with Issue type, Open, Closed, Others, Total. to view the further breakdown, click Total link.</p>
                                                <p><strong>Ageing Analysis (Only open issues) :</strong> Only open issues rare displayed under Upto 5 Days, 5 To 10 Days, More Than 10 Days. Click on the number link to view the details of further breakdown.</p>
                                                <p><strong>Shown to Customer :</strong> The count of issues which are shown to customer are listed under this section. lick on the number link to view the details of further breakdown.</p>
                                                <p><strong>Total Over-Due Issues :</strong> The count of issues for which the Expected Date Of Resolution is less than current date are listed under this section. Click on the number link to view the details of further breakdown.</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel panel-default" id="DOROpanel2">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-bs-toggle="collapse" data-target="#DOROcollapse2"
                                                    href="#DOROcollapse2" class="collapsed">Key Achievements in the reporting period
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="DOROcollapse2" class="panel-collapse collapse">
                                            <div class="panel-body">
                                                <p>This section displays the total tasks and Deliverables completed during the reporting period</p>
                                                <p><strong>Tasks :</strong> Details of tasks are displayed under Total Planned, Completed, To be completed in next reporting period, and Tasks Slipping. This report considers both the Assigned and MPP tasks. Click on the number link to view the breakdown for planned task. It will display details with Task name, Resource Name, Start Date, End date, Actual Start Date, Actual End Date, Work (HRS), Actual Work (Hrs).</p>
                                                <p>
                                                    <strong>Taken from :</strong> 1. PROJECTS > Project Management > Execute > Task > Task Management.<br />
                                                    2. Timesheet
                                                </p>
                                                <p><strong>Deliverables :</strong> Details of Deliverables are displayed under Total Planned, Completed, To be completed in next reporting period, and Tasks Slipping. Click on the number link to view the breakdown for each Deliverable. Click on the number link to view the breakdown for planned deliverable.. It will display details with Deliverable name,</p>
                                                Resource Name, Start Date, End date, Actual Start Date, Actual End Date, Work (HRS), Actual Work (Hrs).
                                                <p><strong>Taken from :</strong> 1. PROJECTS > Project Settings > Deliverable Settings.</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel panel-default" id="DOROpanel3">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-bs-toggle="collapse" data-target="#DOROcollapse3"
                                                    href="#DOROcollapse3" class="collapsed">SQERT
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="DOROcollapse3" class="panel-collapse collapse">
                                            <div class="panel-body">
                                                <p>This table displays the values and description updated on the Update SQERT Values screen along with results of the SQERT Analysis. You can view the Ratings and Trends of the project progress, based on the analysis.</p>

                                                <p>1. Value :Scope (S)</p>
                                                <p>Taken from : User Entered</p>
                                                <p>Assumption : Any change in the baseline is considered change in the Scope of the project.</p>
                                                <p>1. Value :Scope (S)</p>
                                                <p>Taken from : User Entered</p>
                                                <p>Assumption : Any change in the baseline is considered change in the Scope of the project.</p>
                                                <p>2. Value :Quality (Q)</p>
                                                <p>Taken from : User Entered</p>
                                                <p>Assumption : Quality is a subjective entity so PM will define the values for this</p>
                                                <p>3.. Value :Effort (E)</p>
                                                <p>Taken from : TIMESHEET > Daily Activity > Update Task</p>
                                                <p>Assumption : Effort variance is calculated at the task level and all the tasks are taken into consideration. Here the YTD concept involved.  </p>
                                                <p>4.. Value :Risk (R)</p>
                                                <p>Taken from : PROJECTS > Project Management > Plan > Project Management > Risk</p>
                                                <p>Assumption : Risk Severity = Probability * Magnitude</p>
                                                <p>5.. Value :Time (T)</p>
                                                <p>Taken from : TIMESHEET > Daily Activity > Update Task</p>
                                                <p>Assumption : Schedule variance is calculated at the task level and all the tasks are taken into consideration. Here  the YTD concept involved.</p>
                                                <p>Description : After the values for Scope and Quality are updated, the Administrator must Lock the values under PROCESSES..</p>

                                                <p><strong>Formulae :</strong></p>
                                                <p>
                                                    <strong>1. Effort:</strong>  % Effort Variance = Actual Efforts - Estimated Efforts/Estimated Efforts * 100
                                                    <strong>2. Time:</strong> % Schedule Variance = ((Actual Schedule-Estimated Schedule)/Estimated Schedule) * 100
                                                    <strong>3. Risk:</strong>  Risk Severity=Probability*Magnitude
                                                </p>

                                                <p>Trend : The trend, upward or downward, for each of the parameters is displayed. The trend displayed here is an indicator of the project progress</p>
                                                <p>Ratings : The system flashes a smiley according to the trend of the parameter based on the outcome of the SQERT Analysis. Color Convention for Smiley</p>
                                                <p>
                                                    <strong>1.Red:</strong> When values fall in the Upper Range.<br />
                                                    <strong>2. Yellow:</strong> When values fall in the Middle Range<br />
                                                    <strong>3. Green:</strong> When values fall in the Lower Range
                                                </p>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel panel-default" id="DOROpanel4">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-bs-toggle="collapse" data-target="#DOROcollapse4"
                                                    href="#collapse4" class="collapsed">Milestone
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="DOROcollapse4" class="panel-collapse collapse">
                                            <div class="panel-body">
                                                <p><strong>Value:</strong> Milestone Name, Ready for Billing, Amount, Planned Start Date, Planned Completion Date, Actual Start Date, Actual End Date, Slippage (In Days), Milestone Status.</p>
                                                <p>
                                                    <strong>Taken from :</strong><br />
                                                    1. PROJECTS > Project Management > Plan > WBS > Milestone.<br />
                                                    2. Timesheet
                                                </p>
                                                <p><strong>Assumption:</strong> A milestone is defined in the system. Timesheet entries are made against the Milestone tasks. Status is updated according to the work accomplished on the milestone.</p>
                                                <p><strong>Description :</strong> After the values for Scope and Quality are updated, the Administrator must Lock the values under PROCESSES</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel panel-default" id="DOROpanel5">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-bs-toggle="collapse" data-target="#DOROcollapse5"
                                                    href="#DOROcollapseThree" class="collapsed">Baseline
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="DOROcollapse5" class="panel-collapse collapse">
                                            <div class="panel-body">
                                                <p><strong>Value:</strong> Reason For Change, Changed Date, Estimated Effort,  End Date</p>
                                                <p><strong>Taken from :</strong> 1. PROJECTS > Project Information</p>
                                                <p><strong>Assumption :</strong> The precise reason for the change in scope, The date of the change in the baseline, Additional efforts to accomplish the change in scope, The date on which the project is expected to complete with the change in scope is entered while creating a project.</p>
                                                <p><strong>Description :</strong> Any change in the baseline is considered change in the Scope of the proje</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel panel-default" id="DOROpanel6">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-bs-toggle="collapse" data-target="#DOROcollapse6"
                                                    href="#DOROcollapse6" class="collapsed">Active Resources
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="DOROcollapse6" class="panel-collapse collapse">
                                            <div class="panel-body">
                                                <p><strong>Value:</strong> Resource, Start Date, End Date, Work( Hrs), Actual Work (Hrs)</p>
                                                <p><strong>Taken from :</strong>  PROJECTS > Project Management> Execute > Task > Task Management.</p>
                                                <p>Timesheet</p>
                                                <p><strong>Assumption:</strong> All the resources working on the project till the reporting date. Tasks planned to be completed during the next reporting period. Timesheet entries are made against the Milestone tasks. Status is updated according to the work accomplished on the milestone</p>
                                                <p><strong>Description :</strong> After the values for Scope and Quality are updated, the Administrator must Lock the values under PROCESSES</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel panel-default" id="DOROpanel7">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-bs-toggle="collapse" data-target="#DOROcollapse7"
                                                    href="#DOROcollapseThree" class="collapsed">Earned Value Report
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="DOROcollapse7" class="panel-collapse collapse">
                                            <div class="panel-body">
                                                <p><strong>Value:</strong> Total Budgeted man Days</p>
                                                <p><strong>Description :</strong> The Total Budgeted Man Days stands for BCWS refer to the total efforts made for the completion of the project or the project phase for which the earned value is being computed.</p>
                                                <p><strong>Value:</strong> PV</p>
                                                <p><strong>Description :</strong> Planned Value (PV) is the sum of planned efforts</p>
                                                <p><strong>Value:</strong> EV</p>
                                                <p><strong>Description :</strong> Earned Value (EV) stands for BCWP, is the Sum of planned efforts for the completed tasks.</p>
                                                <p><strong>Value:</strong> AC</p>
                                                <p><strong>Description :</strong> Actual Cost (AC) stands for ACWP, is the sum of actual efforts for the completed tasks.</p>
                                                <p><strong>Value:</strong> CPI</p>
                                                <p><strong>Description :</strong> Cost Performance Index</p>
                                                <p><strong>Formula:</strong> Cost Performance Index = Earned Value/Actual Cost   CPI = BCWP/ACWP</p>
                                                <p><strong>Value:</strong> CV</p>
                                                <p><strong>Description :</strong> Cost Variance</p>
                                                <p><strong>Formula:</strong> Cost Variance=Earned Value-Actual Cost</p>
                                                <p>CV=BCWP -ACWP</p>
                                                <p><strong>Value</strong>: SPI</p>
                                                <p><strong>Description :</strong> Schedule Performance Index</p>
                                                <p><strong>Formula:</strong> Schedule Performance Index = Earned Value/Total Budgeted Man Days</p>
                                                <p>SPI = BCWP/BCWS</p>
                                                <p><strong>Value:</strong> SV</p>
                                                <p><strong>Description :</strong> Schedule Variance</p>
                                                <p><strong>Formula:</strong> Schedule Variance = Earned Value - Planned Value</p>
                                                <p>SV = BCWP &ndash; BCWS</p>
                                                <p><strong>Value:</strong> ETC</p>
                                                <p><strong>Description :</strong> Estimate To Complete</p>
                                                <p><strong>Formula:</strong> Schedule Variance = Earned Value - Planned Value</p>
                                                <p>Estimate To Complete = (Planned Value - Earned Value) / Cost Performance Index</p>
                                                <p>ETC= (BCWS-BCWP)/CPI</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel panel-default" id="DOROpanel8">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-bs-toggle="collapse" data-target="#DOROcollapse8"
                                                    href="#DOROcollapse8" class="collapsed">Total Task V/S Completion Status Graph
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="DOROcollapse8" class="panel-collapse collapse">
                                            <div class="panel-body">
                                                <p class="ListItem"><strong>T</strong>his is a doughnut graph that displays count of the tasks grouped by the percentage of tasks completed. Each percentage range is identified by unique color as mentioned on the screen. The number inside the dough nut graph signifies the count of tasks having percentage complete as upto 10 % , 11% to 20% so on.Total Tasks Planned</p>
                                                <p class="ListItem"><strong>Value:&nbsp;</strong>Total Tasks Planned</p>
                                                <p class="ListItem"><strong>Taken from :&nbsp; 1.</strong>PROJECTS &gt; Project Management &gt; Execute &gt; Task &gt; Task Management</p>
                                                <p class="ListItem"><strong>Value:&nbsp;</strong>Percentage Complete</p>
                                                <p class="ListItem"><strong>Taken from :&nbsp; 1.</strong>PROJECTS &gt; Project Management &gt; Execute &gt; Task &gt; Task Management</p>
                                                <p class="ListItem"><strong>Taken from :&nbsp;</strong>Timesheet &gt; Daily Activity &gt; Update Task</p>
                                                <p class="ListItem"><strong>Assumption :&nbsp;</strong>The total number of tasks planned for the selected Reporting Period are taken as 100% The percentage updated in the % Complete text box.</p>
                                                <p class="ListItem">&nbsp;<strong>Description :&nbsp;</strong>This graph takes into consideration the total number of tasks assigned to all the project resources along with the completion status in terms of percentage</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel panel-default" id="DOROpanel9">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-bs-toggle="collapse" data-target="#DOROcollapse9"
                                                    href="#DOROcollapse9" class="collapsed">Total Tasks V/S Completed Tasks Graph
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="DOROcollapse9" class="panel-collapse collapse">
                                            <div class="panel-body">
                                                <p>This graph displays the task status by resource.&nbsp;</p>
                                                <p><strong>Value:&nbsp;</strong>Total Tasks allocated to a resource</p>
                                                <p><strong>Taken from : 1.</strong>PROJECTS &gt; Project Management &gt; Execute &gt; Task &gt; Task Management</p>
                                                <p><strong>Value:&nbsp;</strong>Total tasks completed by a resource</p>
                                                <p><strong>Taken from : 1.</strong>PROJECTS &gt; Project Management &gt; Execute &gt; Task &gt; Task Management</p>
                                                <p>2. Timesheet &gt; Daily Activity &gt; Update Task</p>
                                                <p><strong>Value: </strong>Resources</p>
                                                <p><strong>Taken from : 1.</strong>PROJECTS &gt; Project Management &gt; Plan &gt; Resource Management &gt; Resources.</p>
                                                <p><strong>Assumptions :&nbsp;</strong>The total number of tasks planned for the selected Reporting Period are taken as 100% All the tasks for which the Is Task Complete check box is marked .Active Project Resources to whom tasks are assigned</p>
                                                <p><strong>Description :&nbsp;</strong>This graph displays resource-wise task status, i.e., number of tasks assigned to the resource and the number of tasks completed by the resource till the reporting date.</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel panel-default" id="DOROpanel10">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-bs-toggle="collapse" data-target="#DOROcollapse10"
                                                    href="#DOROcollapse10" class="collapsed">Total Tasks V/S Delay in Days (By Resource ) Graph
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="DOROcollapse10" class="panel-collapse collapse">
                                            <div class="panel-body">
                                                <p>This graph shows each resource's contribution to the schedule variance of the project. The variance in this case is calculated in terms of days. A delay, in terms of count of days, is identified by a unique color code</p>
                                                <p><strong>Value:&nbsp;</strong>Planned Start / End Date of a Task</p>
                                                <p><strong>Taken from : 1.</strong>PROJECTS &gt; Project Management &gt; Execute &gt; Task &gt; Task Management</p>
                                                <p><strong>Value:&nbsp;</strong>Actual Start Date-Actual End Date</p>
                                                <p><strong>Taken from : 1.</strong>PROJECTS &gt; Project Management &gt; Execute &gt; Task &gt; Task Management</p>
                                                <p>2. Timesheet &gt; Daily Activity &gt; Update Task</p>
                                                <p><strong>Value: </strong>Resources</p>
                                                <p><strong>Taken from : 1.</strong>PROJECTS &gt; Project Management &gt; Plan &gt; Resource Management &gt; Resources.</p>
                                                <p><strong>Assumptions :</strong>The total number of tasks planned for the selected Reporting Period are taken as 100%. All the tasks for which daily activity is logged. Active Project Resources to whom tasks are assigned</p>
                                                <p><strong>Description :&nbsp;</strong>This graph displays resource-wise task status, i.e., number of tasks assigned to the resource and the number of tasks completed by the resource till the reporting date.</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel panel-default" id="DOROpanel11">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-bs-toggle="collapse" data-target="#DOROcollapse11"
                                                    href="#DOROcollapse11" class="collapsed">Total Tasks V/S Delay in Days (By Project) Graph
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="DOROcollapse11" class="panel-collapse collapse">
                                            <div class="panel-body">
                                                <p>This graph shows the cumulative schedule variance of the project. The variance in this case is calculated in terms of days</p>
                                                <p><strong>Value:&nbsp;</strong>Planned Start / End Date of a Task</p>
                                                <p><strong>Taken from : 1.</strong>PROJECTS &gt; Project Management &gt; Execute &gt; Task &gt; Task Management</p>
                                                <p><strong>Value:&nbsp;</strong>Actual Start Date-Actual End Date</p>
                                                <p><strong>Taken from : 1.</strong>PROJECTS &gt; Project Management &gt; Execute &gt; Task &gt; Task Management</p>
                                                <p>2. Timesheet &gt; Daily Activity &gt; Update Task</p>
                                                <p><strong>Value: </strong>Resources</p>
                                                <p><strong>Taken from : 1.</strong>PROJECTS &gt; Project Management &gt; Plan &gt; Resource Management &gt; Resources.</p>
                                                <p><strong>Assumptions :</strong>The total number of tasks planned for the selected Reporting Period are taken as 100%. All the tasks for which daily activity is logged. Active Project Resources to whom tasks are assigned</p>
                                                <p><strong>Description :&nbsp;</strong>This graph displays resource-wise task status, i.e., number of tasks assigned to the resource and the number of tasks completed by the resource till the reporting date.</p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="panel panel-default" id="DOROpanel12">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-bs-toggle="collapse" data-target="#DOROcollapse12" href="#DOROcollapse12" class="collapsed">Monthly Resource Cost Graph
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="DOROcollapse12" class="panel-collapse collapse">
                                            <div class="panel-body">
                                                <p>This graph displays the role-wise cost of the project resources for a month's period. This graph considers the corporate role rate for calculation.</p>
                                                <p><strong>Value:&nbsp;</strong>Role Rate</p>
                                                <p><strong>Taken from : CONFIGURATION &gt; Application Administration &gt; Security &gt; Group &amp; Access &gt; Role&nbsp;</strong></p>
                                                <p><strong>Value: </strong>Project Role</p>
                                                <p><strong>Taken from : 1.</strong>PROJECTS &gt; Project Management &gt; Plan &gt; Resource Management &gt; Resources.</p>
                                                <p><strong>Value: </strong>Actual Efforts Spent By Resource</p>
                                                <p><strong>Taken from : </strong>TIMESHEET &gt; Daily Activity &gt; Update Task</p>
                                                <p><strong>Assumptions :</strong>The total number of tasks planned for the selected&nbsp;<strong>Reporting Period&nbsp;</strong>are taken as 100%. All the tasks for which daily activity is logged. The actual efforts logged in by the resources. sum of&nbsp;<strong>( Actual Efforts spent by resource * rate of resource role on project )</strong>&nbsp;for each month</p>
                                                <p><strong>Description :&nbsp;</strong>This graph displays cost to company for all the project resources as per their roles.&nbsp;</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ol>

                </div>

                <div class="clearfix"></div>
            </div>
        </div>



        <div class="clearfix"></div>
    </div>


    <!-- REQUIRED JS SCRIPTS -->
    <%-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <!-- jqueryUI js -->
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
 
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>

    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>

    <script>

        $("[data-bs-toggle='tooltip'], [data-bs-toggle='collapse'], [data-bs-toggle='dropdown']").tooltip();



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


    </script>

</body>

</html>
