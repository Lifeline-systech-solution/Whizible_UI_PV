<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="frmTaskCreation.aspx.vb" Inherits="PbNIT.frmTaskCreation" %>

<!DOCTYPE html>

<html>
    <!-- Commented by Madhuri.k On 14-8-2024 for JQuery and Bootstrap version upgrade -->
            <%CommonFunctions.General.PlotPageHeadTag("")%>
<head runat="server">

<%--    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />


    <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
 
     <link rel="stylesheet" href="../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
    <link href="../General/loaderStylesheet.css" rel="stylesheet" />

<%--    <link rel="stylesheet" href="../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />--%>

    <script src="../General/CommonFunctions.js"></script>
<%--    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />--%>
    <link href="css/taskstylesheet.css?v=1" rel="stylesheet" />
    <link rel="stylesheet" href="assets/css/task.css?v=3.7" />
<%--    <link href="../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />
    <script src="../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
    <script src="assets/DatePicker/JS/jquery-1.12.4.js"></script>
<%--    <script src="../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
    <script src="../../Whizible2.0-new/plugins/chartjs/Chart.min.js"></script>
    <script src="assets/js/jquery.nicescroll.min.js"></script>

    <script src="assets/js/autosize.js"></script>


<%--      <script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>


        <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script>--%> 
  <%--End of Added By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes --%>

    <script> setFrameLoader();
    </script>
   
</head>
     <style type="text/css">
        #preloader {
            z-index: 10000;
        }

        .inactive {
            background-color: #b1aeae !important;
        }



        #tableTaskList tr td:nth-child(1) {
            width: 10%;
        }

        #tableTaskList tr td:nth-child(2) {
            word-break: break-all;
            width: 22%;
            text-align: left;
        }

        #tableTaskList tr td:nth-child(3) {
            /*word-break: break-all;*/
            width: 13%;
            text-align: center;
        }

        #tableTaskList tr td:nth-child(4) {
            /*word-break: break-all;*/
            width: 13%;
            text-align: center;
        }

        #tableTaskList tr td:nth-child(5) {
            width: 5%;
            text-align: center;
        }

        #tableTaskList tr td:nth-child(6) {
            width: 5%;
            text-align: center;
        }

        #tableTaskList tr td:nth-child(7) {
            width: 10%;
            text-align: center;
        }

        #tableTaskList tr td:nth-child(8) {
            width: 18%;
            text-align: left;
        }

        #tableTaskList tr td:nth-child(9) {
            width: 10%;
            text-align: left;
        }

        #tableTaskList tr td:nth-child(10) {
            width: 10%;
            text-align: left;
        }

        #search_table {
            /*order-right: 1px solid #ccc!important;
            border-left: 1px solid #ccc!important;
            border-top: 1px solid #ccc!important;
            border-top-left-radius: 5px!important;
            border-bottom-left-radius: 5px!important;*/
            width: 210px;
            padding: 6px 2px!important;
        }

        .results tr[visible='false'],
        .no-result {
            display: none;
        }

        .results tr[visible='true'] {
            display: table-row;
        }

        ::-moz-tree-row(hover), .table-responsive {
            width: 102%!important;
        }

        .progress-bar-danger {
            background-color: red!important;
        }
        /*.user-img {
    border-radius: 50%;
    width: 30px;
    margin-top: 10px;
}*/

        /*.select2-container--default .select2-selection--single {
            background-color: #fff;
           
            border-top: 0!important;
            border-right: 0!important;
            border-left: 0!important;
            border-bottom: 1px solid #ccc;
            border-radius: 0!important;
        }

            .select2-container--default .select2-selection--single .select2-selection__rendered {
                white-space: pre !important;
            }

        .select2-search__field {
            display: none;
        }

        .select2-container--default .select2-results > .select2-results__options {
            overflow-x: hidden !important;
        }*/

        html, body {
            padding: 0;
            margin: 0;
            overflow: hidden;
            overflow: -moz-scrollbars-none;
        }

        #content {
            position: absolute;
            left: 0;
            top: 0;
            right: -30px;
            bottom: -30px;
            padding-right: 15px;
            overflow-y: scroll;
            overflow-x: scroll;
            padding-bottom: 15px;
        }
    </style>
<body style="height: 826px; background: #fff;">
    <div id="loading"></div>
    <div id="content">
        <%--  <form id="form1" runat="server" style="margin-bottom: 10px;margin-top: 20px;">--%>
        <div style="margin-bottom: 10px; margin-top: 20px;">
            <div class="container-fluid">
                <!--First row starts here-->
                <div class="row ">
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 fixed-top">
                        <div class="col-sm-4" style="margin-left: 22px;">
                            <h4 class="page-title">Task Creation</h4>
                        </div>
                        <div class="align-right" style="float: right">
                              <button type="button" class="btn btn-default closetask" style="padding: 6px 12px!important; height: 32px;display:none">Back</button>
                            <button id="btnRefresh" name="btnRefresh" class="btn btn-default" onclick="Refresh()" style="height: 32px;"><i class="fa fa-refresh"></i>&nbsp;Refresh</button>
                            <button class="btn btn-success create" onclick="clearModalPopup()" style="background-color: #0288D1!important; height: 32px;">Create New task</button>

                        </div>
                    </div>
                </div>
                <!--First row ends here-->
                <hr style="margin-top: 2px;" />
                <!--Second row starts here-->
                <div class="row searchsprint">
                    <di class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12" id="floating-label" style="">
					
			<div class="form-group" style="margin-left: -13px;">
				<label class="control-label" style="">Select Sprint</label>
				<%--<select class="form-control" id="AssignResources">
					<option></option>
				<option>ABC</option>
				<option>XYZ</option>
				</select>--%>
                <%CommonFunctions.HTMLControls.DrawComboBox("cboSprint", "Select ''", , intCurrentSprintID, "form-control onChange=CboSprintonChange(this.value) data-bs-toggle='tooltip' title='Select Sprint'", True, , "form-control style='box-shadow: none!important; border-top-color: transparent;  border-left-color: transparent;border-right-color: transparent;'")%>
			</div>


				</div>
				<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12" id="floating-label" style="">
					 <div class="form-group">
				        <label class="control-label">Select User Story</label>
                         <%CommonFunctions.HTMLControls.DrawComboBox("cboUS", "Select ''", , , "class='form-control' style='padding: 6px 0px !important;' onchange='BindTaskListTbody()' onclick=Clear('cboUserstory1','spanUserstory1')", True, )%>

			        </div>
                </div>
                <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12" id="floating-label" style="">
					 <div class="form-group">
				        <label class="control-label">Select Status</label>
                         <%CommonFunctions.HTMLControls.DrawComboBox("cboStatus", "Select ''", , , "class='form-control' style='padding: 6px 0px !important;'", True, )%>

			        </div>
                </div>
				<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12  align-right search" style="float: right;width: 231px;" id="floating-label">
                    <div class="form-group">
				<label class="control-label">Search<span class="required"></span></label>
			 <%CommonFunctions.HTMLControls.DrawTextBox("search_table", "search_table", "form-control t", , , , , , , , , , "", , , , , , , )%>
					
				    </div>
				</div>
                </div>
            </div>
            <!--Second row ends here-->
            <%--<hr />--%>
            <!--Third Row Starts Here-->
            <div class="row  task">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="table-responsive">
                        <table class="table results" id="tableTaskList" style="">

                            <tbody id="tbodyTaskList">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!--Third Row Ends Here-->
        </div>
        <div class="modal createtaskforuser" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content col-lg-12 col-md-12 col-sm-12">
                    <div class="modal-header">
                        <button type="button" class="close hidetask" data-bs-dismiss="modal" data-bs-toggle="tooltip" title="Close">&times;</button>
                        <h4 class="modal-title">Create Task</h4>
                    </div>
                    <div class="modal-body col-lg-12 col-md-12 col-sm-12">
                        <div id="floating-label">
                            <div class="row">
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
                                    <label class="control-label select-label" style="opacity: 1; transform: translateY(-1px) scale(.94); margin-top: -19px; margin-bottom: 10px; font-size: 14px!important; color: #878787!important;">Select Sprint<span class="required"> *</span></label>
                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboSprintNew", "Select ''  ", , intCurrentSprintID, "form-control onChange=CboSprintNewonChange(this.value) data-bs-toggle='tooltip' title='Select Sprint'", , , "form-control style='box-shadow: none!important; border-top-color: transparent;  border-left-color: transparent;border-right-color: transparent;word-wrap:break-word;width:100%;'")%>
                                </div>
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
                                    <label class="control-label select-label" style="">Select User Story<span class="required"> *</span></label>
                                    <%--                          <%CommonFunctions.HTMLControls.DrawComboBox("cboUSNew", "Select ''", , , "class='form-control' style='padding: 6px 0px !important;'", True, )%>--%>
                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboUSNew", "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & Session("intprojectID") & "", , , "class='form-control' style='padding: 6px 0px !important;' onchange=ClearSpan('cboUserStory','spanUserStory')", True, )%>
                                </div>

                                <div class="form-group col-lg-12 col-md-12 col-sm-12 taskname focused">
                                    <label class="control-label ">Task Name<span class="required"> *</span></label>
                                    <%CommonFunctions.HTMLControls.DrawTextBox("AssigntxtTaskName", "AssigntxtTaskName", "form-control t", , 255, , , , , , , , "onkeyup='limitText(this,countTaskName,255);'", , , , , , , )%>
                                    <%--<input id="AssigntxtTaskName" type="text" class="form-control t" name="AssigntxtTaskName" maxlength="255" onkeyup="limitText(this,countTaskName,255);" />--%>
                                    <small name="countTaskName" id="countTaskName" style="float: right;">255</small>
                                </div>

                                <div class="form-group col-lg-12 col-md-12 col-sm-12">
                                    <label class="control-label">Task Note</label>
                                    <%CommonFunctions.HTMLControls.DrawTextArea("txtTaskNotes", "txtTaskNotes", "", "form-control", , , , , , , 2000, , , "height: 34px;line-height: 1.5!important;", , , , , "onkeyup='limitText(this,countTaskNote,2000)'", , , , , , , , , , )%>
                                    <%--<textarea class="form-control"  name="txtTaskNotes" id="txtTaskNotes" class="form-control" onkeyup="limitText(this,countTaskNote,2000)"  maxlength="2000"  style="height: 34px;line-height: 1.5!important;"></textarea>--%>
                                    <small name="countTaskNote" id="countTaskNote" style="float: right;">2000</small>
                                    <!-- <input type="text" class="form-control"/> -->
                                </div>
                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
                                    <label class="control-label select-label">Resource(s)<span class="required"> *</span></label>
                                    <%CommonFunctions.HTMLControls.DrawComboBox("cboAssignResourcesNew", "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", , , "class='form-control' style='padding: 6px 0px !important;' onchange=ClearSpan('cboPriority','spanPriority')", True, )%>
                                    <%--<select class="form-control" id="AssignResources1">
					<option></option>
				<option>ABC</option>
				<option>XYZ</option>
				</select>--%>
                                </div>



                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
                                     <%--Commented And Added By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes --%>
                                     <%--<label class="control-label">Work(hrs)<span class="required"> *</span></label>
                                    <%CommonFunctions.HTMLControls.DrawTextBox("txtTaskWorkhrsNew", "txtTaskWorkhrsNew", "form-control", , , , , , , , , , "", , , , , , , )%>--%>
                                   
                                     <label class="control-label">Work (H:M)<span class="required"> *</span></label>
                                    <%CommonFunctions.HTMLControls.DrawTextBox("txtTaskWorkhrsNew", "txtTaskWorkhrsNew", "form-control", , 8, , , , , , , , "", , , , , , , )%>
                                    <%--End of Added By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes --%>

                                    <%--	<input type="text" id="txtTaskWorkhrsNew" name="txtTaskWorkhrsNew" class="form-control"/>--%>
                                </div>


                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
                                    <label class="control-label">Start Date<span class="required"> *</span></label>
                                    <%CommonFunctions.HTMLControls.DrawTextBox("StartDateAssigntask", "StartDateAssigntask", "form-control", , , , , , , , , , "", , , , , , , )%>
                                    <%--<input  type="text" name="StartDateAssigntask" id="StartDateAssigntask"  class="form-control"/>--%>
                                </div>


                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
                                    <label class="control-label">End Date<span class="required"> *</span></label>
                                    <%CommonFunctions.HTMLControls.DrawTextBox("EndDateAssigntask", "EndDateAssigntask", "form-control", , , , , , , , , , "", , , , , , , )%>
                                    <%--<input type="text" name="EndDateAssigntask" id="EndDateAssigntask" class="form-control"/>--%>
                                </div>

                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
                                    <label class="control-label">Story Points</label>
                                    <%CommonFunctions.HTMLControls.DrawTextBox("txtStoryPointsNew", "txtStoryPointsNew", "form-control", , , , , , , , , , "", , , , , , , )%>
                                    <%--<input type="text" class="form-control" id="txtStoryPointsNew" name="txtStoryPointsNew"/>--%>
                                </div>

                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
                                    <label class="control-label select-label">Priority<span class="required"> *</span></label>
                                    <%CommonFunctions.HTMLControls.DrawComboBox("AssigntaskcboPriorities", "usp_NG2_Sel_tbl_IB_Priorities", , , "class='form-control' ", True, )%>
                                    <%--	<select class="form-control" id="AssignResources2">
				<option></option>
				<option>ABC</option>
				<option>XYZ</option>
				</select>--%>
                                </div>



                                <div class="form-group col-lg-6 col-md-6 col-sm-12">
                                    <label class="control-label select-label">Task Type<span class="required"> *</span></label>
                                    <%CommonFunctions.HTMLControls.DrawComboBox("AssigntaskcboTaskTypeNew", "usp_NG2_Sel_tbl_PM_Project_TaskTypes_Names " & Session("intprojectID") & "", , , "class='form-control' ", True, )%>
                                    <%--<select class="form-control" id="AssignResource3">
					<option></option>
				<option>Developement</option>
				<option>Design</option>
				</select>--%>
                                </div>

                                <div class="form-group col-lg-6 col-md-6 col-sm-12 checkbox" style="margin-left: -20px;">
                                    <div class="col-sm-6">
                                        <label class="control-label col-sm-8 col-xs-12 on-hold-label">On Hold</label>
                                        <div class="">
                                            <%CommonFunctions.HTMLControls.DrawCheckBox("chkHold", "chkHold", "", , , , , , , , , , )%>
                                            <%--<input type="checkbox" id="chkHold" name="chkHold" value="">--%>
                                        </div>
                                    </div>


                                    <div class="col-sm-6" style="margin-bottom: 15px;">
                                        <label class="control-label  col-sm-8 col-xs-12 billable-label">Billable</label>
                                        <div class="">
                                            <%CommonFunctions.HTMLControls.DrawCheckBox("chkBillable", "chkBillable", "", , , , , , , , , , )%>
                                            <%--<input type="checkbox" id="chkBillable" name="chkBillable" value="" >--%>
                                        </div>
                                    </div>
                                </div>


                                <div class="align-right">
                                    <!--  <button type="button" class="btn btn-default close hidetask" data-bs-toggle="modal" data-bs-target=".createtaskforuser" style="padding: 4px 12px!important;">Close</button> -->
                                    <button type="button" class="btn btn-success" id="btnSaveTask" onclick="SaveTask(0,'Save')" style="background-color: #0288D1!important">Save & Add</button>
                                    <button type="button" class="btn btn-success" onclick="SaveTask(0,'Save')" style="background-color: #0288D1!important">Save</button>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>



        <div class="createtask align-top" style="display: none;">


            <%--  <div class="modal-header">
           <h4 class="modal-title align-left page-title">Task Detail</h4>
    </div>--%>
            <div class="container-fluid formheight" style="width: 102%!important">
                <div class="col-lg-4 col-md-4 col-sm-12 overalltaskdetail" id="leftDivEditTask">
                    <div class="Sprintdetail col-lg-12 col-md-12 col-sm-12" id="floating-label">
                        <div class="col-lg-2 col-md-2 col-sm-2">
                            <img id="EmployeePhoto" src="this.src='../../Images/Photo/no-photo.png'" onerror="this.src='../../Images/Photo/no-photo.png'" class="user-img" data-bs-toggle="tooltip" title="" data-original-title="" />
                            <%--<%CommonFunctions.HTMLControls.DrawImage("this.src='../../Images/Photo/no-photo.png'", "EmployeePhoto", "onerror=this.src='../../Images/Photo/no-photo.png'", , , , , , , )%>--%>
                            <span class="user-text" id="spanEmployeeName"></span>
                        </div>
                        <div class="col-lg-10 col-md-10 col-sm-10 sprintwisetask">
                            <div class="form-group col-lg-12 col-md-12 col-sm-12">
                                <div class="details">Release Name</div>
                                <div class="" id="spanRealeaseName">-</div>
                            </div>
                            <div class="form-group col-lg-12 col-md-12 col-sm-12">

                                <div class="details">Sprint Name</div>
                                <div class="" id="spanSprintName">Sprint Name</div>
                            </div>

                            <div class="form-group col-lg-12 col-md-12 col-sm-12">

                                <%--<span id="spanUserStoryName"></span>--%>
                                <div class="control-label" style="margin-bottom:10px;margin-top:-19px">User Story</div>
                                <%CommonFunctions.HTMLControls.DrawComboBox("EditcboUS", "Select ''", , , "class='form-control'  onchange='BindTaskListTbody()' disabled", True)%>
                            </div>


                        </div>
                    </div>
                    <br />

                    <div class="taskdetail col-lg-12 col-md-12 col-sm-12 align">
                        <span class="overalltaskname">Task Name</span><br />
                        <span class="overalltask" id="spanTaskName" style="word-break: break-all;"></span>
                       <%-- <span class="taskdropdown" data-bs-toggle="modal" data-bs-target="#taskdetail" title="Select Task" data-bs-placement="bottom"><i class="fa fa-angle-down"></i></span>--%>
                        <div class="modal fade" id="taskdetail" role="dialog">
                            <div class="modal-dialog modal-md">
                                <div class="modal-content col-lg-12 col-md-12 col-sm-12">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-bs-dismiss="modal">&times;</button>
                                        <h4 class="modal-title">Select Task</h4>
                                    </div>
                                    <%--    id="taskname"--%>
                                    <div class="modal-body">
                                        <div class="col-lg-12 col-md-12 col-sm-12">
                                            <div class="checkbox checkbox-inline">
                                                <input type="checkbox" id="inlineCheckbox1" value="option1" />
                                                <label for="inlineCheckbox1">Task1 </label>
                                            </div>
                                            <div class="taskborder"></div>
                                            <div class="checkbox checkbox-inline">
                                                <input type="checkbox" id="Checkbox1" value="option2" />
                                                <label for="Checkbox1">Task2 </label>
                                            </div>
                                            <div class="taskborder"></div>
                                            <div class="checkbox checkbox-inline">
                                                <input type="checkbox" id="Checkbox2" value="option3" />
                                                <label for="Checkbox2">Task3 </label>
                                            </div>
                                            <div class="taskborder"></div>
                                        </div>
                                        <div class="col-lg-12 col-md-12 col-sm-12 savealign">
                                            <button type="button" class="btn savetask">Save</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-10 col-md-10 col-sm-10 align">
                        <span class="effort">Planned Effort</span>
                        <div class="progress">
                            <div class="progress-bar" id="PlannedEffortProgress" role="progressbar" aria-valuenow="10"
                                aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 progress-status">
                        <span title="Completion:100%" id="spanPlannedEffort" data-bs-toggle="tooltip">100</span>
                    </div>
                    <div class="col-lg-10 col-md-10 col-sm-10">
                        <span class="effort">Actual Effort</span>
                        <div class="progress">
                            <div class="progress-bar progress-bar-success" id="ActualEffortProgress" role="progressbar" aria-valuenow="70"
                                aria-valuemin="0" aria-valuemax="100" style="width: 70%">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 progress-status">
                        <span title="Completion:70%" data-bs-toggle="tooltip" id="spanActualEffort">70</span>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 align">
                        <span class="effort" id="spanPlanDate">Planned Start Date:2/2/2018 and End Date:2/2/2018 </span>
                        <br />
                        <span class="effort" id="spanActualDate">Actual Start Date:2/2/2018 and End Date:2/2/2018 </span>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 align" style="border-bottom: 1px solid orange; margin-bottom: 10px;">
                        <span class="overalltask">Overall Tasks and Userstories</span>
                    </div>
                    <canvas id="doughnut-chart" class="align" width="800" height="450" style="border: 1px solid #e0e0e0"></canvas>
                    <div class="col-lg-10 col-md-10 col-sm-10 align">
                        <span class="effort">Planned Effort</span>
                        <div class="progress" id="OverallPlannedEffort">
                            <div class="progress-bar" role="progressbar" aria-valuenow="100"
                                aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2  progress-status">
                        <span title="Completion:100%" data-bs-toggle="tooltip" id="spanTotalPlannedEffort">100</span>
                    </div>
                    <div class="col-lg-10 col-md-10 col-sm-10 ">
                        <span class="effort">Actual Effort</span>
                        <div class="progress">
                            <div id="OverallActualEffort" class="progress-bar progress-bar-success" role="progressbar"
                                aria-valuemin="0" aria-valuemax="100">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 col-md-2 col-sm-2 progress-status">
                        <span title="Completion:70%" data-bs-toggle="tooltip" id="spanTotalActualEffort">70</span>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 align categories">
                        <span>Total Task: <span id="spanTotalTask">20</span></span>
                        <span>Completed: <span id="spanCompletedTask">10</span></span>
                        <span>Open: <span id="spanOpenTask">10</span></span><br />
                        <span>Issues Task Total: <span id="spanTotalIssueTask">2</span></span>
                        <span>Closed: <span id="spanClosedTask">2</span></span>
                    </div>
                </div>
                <div class="row col-lg-8 col-md-8 col-sm-12 EditData" id="floating-label" style="border-left: 1px solid #ddd; margin-left: 0px;">
                    <div class="form-group col-lg-6 col-md-6 col-sm-12">
                        <label class="control-label select-label" style="opacity: 1; transform: translateY(-1px) scale(0.94); margin-top: -19px; font-size: 14px !important; color: rgb(135, 135, 135) !important; margin-bottom: 10px" disabled>Select Sprint</label>
                        <select class="form-control" id="cboSprintName_0" name="cboSprintName_0" disabled>
                        </select>
                    </div>
                    <div class="form-group col-lg-6 col-md-6 col-sm-12">
                        <label class="control-label select-label" style="transform: translateY(-1px) scale(0.94); margin-top: -19px; font-size: 14px !important; color: rgb(135, 135, 135) !important; margin-bottom: 10px" disabled>Select User Story</label>
                        <select class="form-control" id="cboUSName_0" name="cboUSName_0" disabled>
                        </select>
                    </div>
                    <div class="form-group col-lg-12 col-md-12 col-sm-12 taskname focused">
                        <label class="control-label " id="lblTaskName" style="">Task Name</label>
                        <%--<%CommonFunctions.HTMLControls.DrawTextBox("TaskName_0", "TaskName_0", "form-control t", , , , , , True, , , , "onkeyup='limitText(this,countTaskNameDetail,255);'", , , , , , , )%>--%>
                        <%CommonFunctions.HTMLControls.DrawTextArea("TaskName_0", "TaskName_0", "", "form-control t", , , , , , , , , , "line-height: 1.5!important;", True, True, , , "onkeyup='limitText(this,countTaskNameDetail,255);' disabled", , , , , , , , , , )%>
                        <%--<input id="TaskName_0" type="text" class="form-control t" name="TaskName_0"  onkeyup="limitText(this,countTaskNameDetail,255);" disabled/>--%>
                        <small name="countTaskNameDetail" id="countTaskNameDetail" style="float: right;">255</small>
                    </div>

                    <div class="form-group col-lg-12 col-md-12 col-sm-12 focused">
                        <label class="control-label" style="">Task Note</label>
                        <%CommonFunctions.HTMLControls.DrawTextArea("TaskNotes_0", "TaskNotes_0", "", "form-control", , , , , , , 2000, , , "line-height: 1.5!important;", True, True, , , "onkeyup='limitText(this,countTaskNoteDetail,2000)' onkeydown='AutoGrowTextArea(this)' disabled", , , , , , , , "Soft", , )%>
                        <%--<textarea class="form-control"  name="TaskNotes_0" id="TaskNotes_0" onkeyup="limitText(this,countTaskNoteDetail,2000);"   maxlength="2000" style="line-height: 1.5!important;"  disabled></textarea>--%>
                        <small name="countTaskNoteDetail" id="countTaskNoteDetail" style="float: right; height: 34px;">2000</small>
                        <!-- <input type="text" class="form-control"/> -->
                    </div>
                    <div class="form-group col-lg-6 col-md-6 col-sm-12 focused">
                        <label class="control-label select-label" style="">Resource(s)<span class="required"> *</span></label>
                        <%CommonFunctions.HTMLControls.DrawComboBox("cboAssignResources_0", "usp_Ng2_Sel_CurrentTeamMembers " & Session("intprojectID") & "", , , "class='form-control' onchange=ClearSpan('cboPriority','spanPriority') disabled", True, )%>
                    </div>




                    <div class="form-group col-lg-6 col-md-6 col-sm-12 focused">
                        <label class="control-label" style="">Work(hrs)<span class="required"> *</span></label>
                        <%CommonFunctions.HTMLControls.DrawTextBox("TaskHrs_0", "TaskHrs_0", "form-control", , , , , , , , , , "", , , , , , , )%>
                        <%--	<input type="text" id="TaskHrs_0" name="TaskHrs_0" class="form-control"/>--%>
                    </div>






                    <div class="form-group col-lg-6 col-md-6 col-sm-12 focused">
                        <label class="control-label" style="">Start Date<span class="required"> *</span></label>
                        <%CommonFunctions.HTMLControls.DrawTextBox("EditStartDateAssigntask_0", "EditStartDateAssigntask_0", "form-control", , , , , , , , , , "", , , , , , , )%>
                        <%-- <input  type="text" name="EditStartDateAssigntask_0" id="EditStartDateAssigntask_0"  class="form-control"/>--%>
                    </div>


                    <div class="form-group col-lg-6 col-md-6 col-sm-12 focused">
                        <label class="control-label" style="">End Date<span class="required"> *</span></label>
                        <%CommonFunctions.HTMLControls.DrawTextBox("EditEndDateAssigntask_0", "EditEndDateAssigntask_0", "form-control", , , , , , , , , , "", , , , , , , )%>
                        <%--<input type="text" name="EditEndDateAssigntask_0" id="EditEndDateAssigntask_0" class="form-control"/>--%>
                    </div>
                    <div class="form-group col-lg-6 col-md-6 col-sm-12 focused">
                        <label class="control-label" style="">Story Points</label>
                        <%CommonFunctions.HTMLControls.DrawTextBox("TaskStoryPoints_0", "TaskStoryPoints_0", "form-control", , , , , , , , , , "", , , , , , , )%>
                        <%-- <input type="text" class="form-control" id="TaskStoryPoints_0" name="TaskStoryPoints_0"/>--%>
                    </div>

                    <div class="form-group col-lg-6 col-md-6 col-sm-12 focused">
                        <label class="control-label select-label" style="">Priority<span class="required"> *</span></label>

                        <%CommonFunctions.HTMLControls.DrawComboBox("EditcboPriority_0", "usp_NG2_Sel_tbl_IB_Priorities", , , "class='form-control' ", True, )%>
                    </div>



                    <div class="form-group col-lg-6 col-md-6 col-sm-12 focused">
                        <label class="control-label select-label" style="">Task Type<span class="required"> *</span></label>

                        <%CommonFunctions.HTMLControls.DrawComboBox("EditcboTaskType_0", "usp_NG2_Sel_tbl_PM_Project_TaskTypes_Names " & Session("intprojectID") & "", , , "class='form-control' ", True, )%>
                    </div>
                    <div class="form-group col-lg-6 col-md-6 col-sm-12 checkbox" style="margin-left: -20px;">
                        <div class="col-sm-6">
                            <label class="control-label col-lg-8 col-md-8 col-sm-6 col-xs-12 on-hold-label">On Hold</label>

                            <div class="">
                                <%CommonFunctions.HTMLControls.DrawCheckBox("EditchkHold_0", "EditchkHold_0", "", , , , , , , , , , )%>
                                <%--<input type="checkbox" id="EditchkHold_0" name="EditchkHold_0" value="">--%>
                            </div>
                        </div>


                        <div class="col-sm-6" style="margin-bottom: 15px;">
                            <label class="control-label col-lg-8 col-md-8 col-sm-6 col-xs-12 billable-label">Billable</label>
                            <div class="">
                                <%CommonFunctions.HTMLControls.DrawCheckBox("EditchkBillable_0", "EditchkBillable_0", "", , , , , , , , , , )%>
                                <%--   <input type="checkbox" id="EditchkBillable_0" name="EditchkBillable_0" value="" >--%>
                            </div>
                        </div>
                    </div>





                    <div class="" style="float: right; margin-right: 40px;">
                      <%--  <button type="button" class="btn btn-default closetask" style="padding: 6px 12px!important; height: 32px;">Back</button>--%>
                        <button type="button" class="btn btn-success" id="Update_0" style="background-color: rgb(2, 136, 209) !important; height: 32px;">Update</button>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <%--  </form>--%>
</body>
<script type="text/javascript">

    $(window).load(function () {
        RemoveFrameLoader();
        // page is fully loaded, including all frames, objects and images
        //alert("window is loaded");
    });




    $('textarea').on('change keyup keydown paste cut load', function () {

        if ($(this).outerHeight() > this.scrollHeight) {
            $(this).height(1)
        }
        while ($(this).outerHeight() < this.scrollHeight + parseFloat($(this).css("borderTopWidth")) + parseFloat($(this).css("borderBottomWidth"))) {
            $(this).height($(this).height() + 1)
        }
    });
     //Added By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes
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
      //End of Added By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes
    function ParseDate(input) {

        theDate = new Date(parseInt(input.substring(6, 19)));
        var month = '' + (theDate.getMonth() + 1)
        var day = '' + theDate.getDate()
        var year = theDate.getFullYear()
        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;
        //alert((theDate.getMonth() + 1) + '/' + (theDate.getDate()) + '/' + (theDate.getFullYear()) )
        //alert([month, day, year].join('/'))
        //return theDate.toLocaleDateString();
        return [month, day, year].join('/');
    }

    var intSelectedUserStoryID = 0;
    var intSelectedSprintName = "";
    var strSelectedUS = "";
    var intSelectedSprintID = 0;
    var intNewSelectedSprintID = 0;
    $(document).ready(function () {

        //setFrameLoader();
        //$('.loader').fadeOut();
        cboSprintOnLoad();
        CboSprintNewonLoad();
        CboSprintonChange(intSelectedSprintID);
        CboSprintNewonChange(intSelectedSprintID);
        //$('#cboSprint').focus();
        //$('#cboUS').focus();
        //BindTaskListTbody();





        $('[data-bs-toggle="tooltip"]').tooltip();
        if ($(".modal").hasClass("in")) {
            $("#AssigntxtTaskName").focus();
        }
        $(".accordian").hide();
        //$(".view").click(function () {
        //    $(".accordian").animate({ opacity: 'toggle' }, 500);
        //});
        $(".createtask").hide();
        $(".createtaskforuser").hide();
        //$(".edittask").click(function () {
        //    debugger;
        //    $("#TaskName").focus();
        //    $(".task").hide();
        //    $(".accordian").hide();
        //    $(".createtask").show();
        //    // $("body").removeClass("overflow");
        //});

        $(".closetask").click(function () {
            //debugger;
            $(".task").show();
            $(".createtask").hide();
        });
        //$(".view").click(function () {
        //    $("#ViewtxtTaskName").focus();
        //});
        $(".create").click(function () {
            $(".createtaskforuser").show();
            $("#AssigntxtTaskName").focus();
            $(".modal").css({ "overflow-x": "hidden", "overflow-y": "auto" });
        });


        var windowheight = $(window).height();
        $('.table-responsive').css('height', windowheight - 150 + 'px');
        var formheight = $(window).height();
        $('.formheight').css('height', formheight - 130 + 'px');
        $(".formheight").css("overflow-y", "auto");
        $(".searchbox").on('focus blur', function () {
            $(".searchbox").css("border-bottom", "1px solid #ddd");
        });

    });
    function cboSprintOnLoad() {
        try {
            var url = "frmTaskCreation.aspx/GetSprintDropDown"

            data = JSON.stringify({});
            var result = AJAXCallWithResult(url, data, false);
            if (result.d != '[]|') {
                BindDropdownSprint(result)

            }
        }
        catch (ex) {
            console.log(ex.message);

        }
    }
    function BindDropdownSprint(result) {
        var strArray = String(result.d).split("|")
        objCbo1 = document.getElementById("cboSprintNew");
        $("#cboSprintNew option").remove();
        $.each(JSON.parse(strArray[0]), function (id, obj) {
            if (obj.IterationID == '<%= intCurrentSprintID%>' || obj.IterationStatus != 'Not Yet Started') {
                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);
                if (obj.IterationID == '<%= intCurrentSprintID%>') {
                    objOption.text = "Current -> " + obj.IterationName + "";
                    intSelectedSprintName = obj.IterationName;

                }
                else {

                    objOption.text = "" + obj.IterationStatus + " -> " + obj.IterationName + "";
                    //intSelectedSprintID = obj.IterationID;
                }
                objOption.value = obj.IterationID;

                if (id == 0) {
                    intSelectedSprintID = obj.IterationID;

                }

            }
            //intSelectedSprintID = obj.IterationID;
        });
        //CboSprintonChange(intSelectedSprintID);
    }

    function CboSprintNewonLoad() {
        try {
            var url = "frmTaskCreation.aspx/GetSprintDropDown"

            data = JSON.stringify({});
            var result = AJAXCallWithResult(url, data, false);
            if (result.d != '[]|') {
                BindDropdownCboSprintNew(result)

            }
        }
        catch (ex) {
            console.log(ex.message);

        }
    }
    function BindDropdownCboSprintNew(result) {
        var strArray = String(result.d).split("|")
        objCbo1 = document.getElementById("cboSprint");
        $("#cboSprint option").remove();
        $.each(JSON.parse(strArray[0]), function (id, obj) {
            if (obj.IterationID == '<%= intCurrentSprintID%>' || obj.IterationStatus != 'Not Yet Started') {
                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    if (obj.IterationID == '<%= intCurrentSprintID%>') {
                        objOption.text = "Current -> " + obj.IterationName + "";
                        intSelectedSprintName = obj.IterationName;
                    }
                    else {

                        objOption.text = "" + obj.IterationStatus + " -> " + obj.IterationName + "";
                    }
                    objOption.value = obj.IterationID;

                }
                //intSelectedSprintID = obj.IterationID;
            });
        }
        function BindTaskPriority(TaskID, Priority) {

            var result = ajaxCall("frmTaskCreation.aspx/GetTaskPriorities", "POST", "application/json", "json",
                               JSON.stringify({}));
            if (result.d != '[]|') {
                var strArray = String(result.d).split("|")
                objCbo1 = document.getElementById("EditcboPriority_" + TaskID + "");
                $("#EditcboPriority_" + TaskID + " option").remove();
                $.each(JSON.parse(strArray[0]), function (id, obj) {

                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    //Added by swapna 13-07-2018
                    objOption.text = obj.Priority;
                    objOption.value = obj.Priority;
                    if (obj.Priority == Priority) {
                        objOption.selected = "selected"
                    }

                    //End by swapna 13-07-2018
                });
            }
        }

        function BindTaskType(TaskID, EntityTypeID) {

            var result = ajaxCall("frmTaskCreation.aspx/GetTaskTypes", "POST", "application/json", "json",
                               JSON.stringify({}));
            if (result.d != '[]|') {
                var strArray = String(result.d).split("|")
                objCbo1 = document.getElementById("EditcboTaskType_" + TaskID + "");
                $("#EditcboTaskType_" + TaskID + " option").remove();
                $.each(JSON.parse(strArray[0]), function (id, obj) {

                    var objOption = document.createElement("OPTION");
                    objCbo1.options.add(objOption);
                    //Added by swapna 13-07-2018
                    objOption.text = obj.TaskType;
                    objOption.value = obj.TaskType;
                    if (obj.TaskType == EntityTypeID) {
                        objOption.selected = "selected"
                    }
                    //End by swapna 13-07-2018
                });
            }
        }
        function BindTaskListTbody() {
            //debugger;
            $("#tbodyTaskList").empty();
            var options = {
                format: 'mm/dd/yyyy',
                todayHighlight: true,
                autoclose: true,tbodyTaskList
            };
            //var FilterName = 'UserStory';
            intSelectedUserStoryID = $('#cboUS option:selected').val();
            if (intSelectedUserStoryID == 0) {
                intSelectedSprintID = $('#cboSprint option:selected').val();
                data = JSON.stringify({ UserStoryID: intSelectedSprintID, FilterName: 'Iteration' });
            }
            else {
                data = JSON.stringify({ UserStoryID: intSelectedUserStoryID, FilterName: 'UserStory' });
            }

            //alert(intSelectedUserStoryID);
            var url = "frmTaskCreation.aspx/ShowTasksList"

            var result = AJAXCallWithResult(url, data, false);
            BindDropDownStatus(result);
            if (result.d != '[]|') {
                var strArray = String(result.d).split("|")
                $.each(JSON.parse(strArray[0]), function (id, obj) {

                    var TaskPercentage = obj.TaskCompletionPercentage;
                    //if (TaskPercentage > 100) {
                    //    TaskPercentage = "-" + TaskPercentage;
                    //}
                    var TaskList = "  <tr  class='even' >" +
                        "<td class='status clsStatus'>";
                   
                    if (obj.IsActive == 'Active') {
                        if (obj.TaskStatusColor == "GREEN") {
                            TaskList += "<div class='btn btn-success btnwidth' data-bs-toggle='tooltip' title='Status' onclick='ResetStatusBtn(this)' >" + obj.IsActive + "</div> "
                        }
                        else {
                            TaskList += "<div class='btn btn-danger btnwidth' data-bs-toggle='tooltip' title='Status' onclick='ResetStatusBtn(this)' >" + obj.IsActive + "</div> "
                        }
                        
                    }
                    else {
                        if (obj.TaskStatusColor == "GREEN") {
                            TaskList += "<div class='btn btn-success inactive btnwidth' data-bs-toggle='tooltip' title='' data-original-title='Status' onclick='ResetStatusBtn(this)'>" + (obj.IsActive == 'Void' ? 'In Active' : obj.IsActive) + "</div>"
                        }
                        else {
                            TaskList += "<div class='btn btn-danger btnwidth' data-bs-toggle='tooltip' title='' data-original-title='Status' onclick='ResetStatusBtn(this)'>" + (obj.IsActive == 'Void' ? 'In Active' : obj.IsActive) + "</div>"
                        }
                    }
                    TaskList += "</td>" +
                        "<td>" +
                        "	<h5 class='task-name edittask' data-bs-toggle='tooltip' title='Task Name'  style='width: fit-content;    word-break: break-word;' > " + obj.ScrumTaskName + "</h5>" +
                        "	<span class='createdate'>Created Date: " + (obj.CreatedDate != null ? ParseDate(obj.CreatedDate) : "-") + "</span><br>" +
                        "	<span class='createdate'>Created By : " + obj.CreatedBy + "</span>" +
                        "</td>" +
                        "<td>" +
                        "	<h5 class='task-name' data-bs-toggle='tooltip' title='Planned Start Date'>" + (obj.StartDate != null ? ParseDate(obj.StartDate) : "-") + "</h5>" +
                        "	<span class='planstartdate'>Planned Start Date</span>" +
                        "</td>" +
                        "<td>" +
                        "	<h5 class='task-name' data-bs-toggle='tooltip' title='Planned End Date'>" + (obj.EndDate != null ? ParseDate(obj.EndDate) : "-") + "</h5>" +
                        "	<span class='planstartdate'>Planned End Date</span>" +
                        "</td>" +
                        "<td>" +
                        "	<h5 class='task-name storypoint' data-bs-toggle='tooltip' title='Planned Effort'>" + obj.Effort + "</h5>" +
                        "	<span class='planstartdate'>Effort</span>" +
                        "</td>" +
                        "<td>" +
                        "	<h5 class='task-name storypoint' data-bs-toggle='tooltip' title='Actual Effort'>" + obj.Actual + "</h5>" +
                        "	<span class='planstartdate'>Actual</span>" +
                        "</td>" +
                        "<td>" +
                        "	<h5 class='task-name storypoint' data-bs-toggle='tooltip' title='Story Point'>" + (obj.StoryPoint == null ? "0" : obj.StoryPoint) + "/" + (obj.ActualStoryPoints == null ? "0" : obj.ActualStoryPoints) + "</h5>" +
                        "	<span class='planstartdate'>Story Point</span>" +
                        "</td>" +
                        "<td>" +
                        "	<h5 class='task-status'>Completion with: " + TaskPercentage + "%</h5>";
                    if (TaskPercentage > 100) {
                        TaskList += "	<div class='progress' data-bs-toggle='tooltip' title='Completion:" + TaskPercentage + "%' style='height: 8px;margin-top: 20px!important;'>";
                        TaskList += "  <div class='progress-bar progress-bar-danger' role='progressbar' aria-valuenow='" + obj.TaskCompletionPercentage + "' aria-valuemin='0' aria-valuemax='100' style='width:" + obj.TaskCompletionPercentage + "%'>";
                        TaskList += " </div>";
                        TaskList += "</div>";
                    }
                    else {
                        TaskList += "	<div class='progress' data-bs-toggle='tooltip' title='Completion:" + TaskPercentage + "%' style='height: 8px;margin-top: 20px!important;'>";
                        TaskList += "  <div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='" + obj.TaskCompletionPercentage + "' aria-valuemin='0' aria-valuemax='100' style='width:" + obj.TaskCompletionPercentage + "%'>";
                        TaskList += " </div>";
                        TaskList += "</div>";
                    }
                    //alert(obj.IsActive);
                    //alert(obj.IsTaskCompleted);
                    //alert(obj.IsUserStoryComplete);
                    //alert(obj.IsIterationComplete);
                
                       TaskList += "</td>" +
                        "<td class='status'>" +
                        "<img src='../../Images/Photo/" + obj.SystemFilename + "' onerror=this.src='../../Images/Photo/no-photo.png'  class='user-img' data-bs-toggle='tooltip' title='' data-original-title='" + obj.AssignedTo + "'  />" +
                        "</td>" +
                        "<td class='status'>" +
                        "   <button class='btn btn-default view' data-bs-toggle='collapse' data-bs-target='#collapse_" + obj.TaskID + "' title='Quick View'  onmouseover='$(this).tooltip();'><i class='fa fa-folder'></i>&nbsp;View</button>" +
                        "</td>" +
                        "<td class='status'>" +
                        (obj.IsActive == 'Void' || obj.IsTaskCompleted == 1 || obj.IsUserStoryComplete == 1 || obj.IsIterationComplete == 1 ?
                            "<button class='btn btn-default Edit' data-bs-toggle='tooltip' title='Edit Task' onclick=OnClickEditTask(" + obj.TaskID + ") disabled> <i class='fa fa-pencil'></i> Edit</button > "
                            :
                            "<button class='btn btn-default Edit' data-bs-toggle='tooltip' title='Edit Task' onclick=OnClickEditTask(" + obj.TaskID + ")> <i class='fa fa-pencil'></i> Edit</button > "
                        )
                        +

                        "</td>" +
                        "</tr>" +
                        " <center>" +
                        "<tr id='collapse_" + obj.TaskID + "' class='collapse'>" +
                        " 	<td colspan='8' class='viewdetails center' style='    '> " +
                        " <div>" +
                        "	<form role='form' class='collapsedetails' id='floating-label'>" +
                        "	<div class='row'>" +
                        "		<div class='form-group col-lg-6 col-md-6 col-sm-12'>" +
                        "			<label class='control-label select-label' disabled style='color:#3e3939!important;'>Select Sprint</label>" +
                        "			<select id='cboSprintName_" + obj.TaskID + "' name='cboSprintName_" + obj.TaskID + "' style='' class='form-control' disabled>" +
                        "			<option value=" + obj.IterationID + ">" + obj.IterationName + "</option>" +
                        "			</select>" +
                        "		</div>" +
                        "		<div class='form-group col-lg-6 col-md-6 col-sm-12'>" +
                        "			<label class='control-label select-label' disabled  style='color:#3e3939!important;'>Select User Story</label>" +
                        "			<select id='cboUSName_" + obj.TaskID + "' name='cboUSName_" + obj.TaskID + "' style='' class='form-control' disabled>" +
                        "			<option value=" + obj.UserStoryID + ">" + obj.UserStoryName + "</option>" +
                        "			</select>" +
                        "		</div>" +
                        "		<div class='form-group col-lg-12 col-md-12 col-sm-12 taskname focused'>" +
                        "			<label class='control-label'  style='color:#3e3939!important;'>Task Name</label>" +
                        //"			<input id='TaskName_" + obj.TaskID + "' type='text' class='form-control' name='TaskName_" + obj.TaskID + "'  onkeyup='limitText(this,viewcountTaskName_" + obj.TaskID + ",255);' value='" + (obj.ScrumTaskName).replace(/'/g, '') + "' data-bs-toggle='tooltip' title='" + (obj.ScrumTaskName).replace(/'/g, '') + "' disabled />" +
                        "					<textarea class='form-control' style='line-height: 1.5!important;' name='TaskName_" + obj.TaskID + "' id='TaskName_" + obj.TaskID + "' onkeyup='limitText(this,viewcountTaskName_" + obj.TaskID + ",255);'  maxlength='2000' disabled>" + (obj.ScrumTaskName == null ? "" : obj.ScrumTaskName) + "</textarea>" +
                        "			<small name='viewcountTaskName_" + obj.TaskID + "' id='viewcountTaskName_" + obj.TaskID + "' style='float:right;'>255</small>" +
                        "		</div>" +

                        "<div class='form-group col-lg-12 col-md-12 col-sm-12 focused' >" +
                        "					<label class='control-label' style='color:#3e3939!important;'>Task Note</label>" +
                        "					<textarea class='form-control' style='line-height: 1.5!important;' name='TaskNotes_" + obj.TaskID + "' id='TaskNotes_" + obj.TaskID + "' onkeyup='limitText(this,viewcountTaskNote_" + obj.TaskID + ",2000);'  maxlength='2000' disabled>" + (obj.ScrumTaskDescription == null ? "" : obj.ScrumTaskDescription) + "</textarea>" +
                        "					 <small name='viewcountTaskNote_" + obj.TaskID + "' id='viewcountTaskNote_" + obj.TaskID + "' style='float:right;height: 34px;'>2000</small>" +

                        "				</div>" +
                        "		<div class='form-group col-lg-6 col-md-6 col-sm-12 focused'>" +
                        "			<label class='control-label select-label'  style='color:#3e3939!important;'>Resource(s)<span class='required'> *</span></label>" +
                        "			<select class='form-control' id='cboAssignResources_" + obj.TaskID + "' disabled   >" +
                        "					<option value='" + obj.EmployeeID + "'>" + obj.AssignedTo + "</option>" +

                        "			</select>" +
                           "		</div>			" +

                            //Commented And Added By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes 

                        //"		<div class='form-group col-lg-6 col-md-6 col-sm-12 focused'>" +
                        //"					<label class='control-label'  style='color:#3e3939!important;'>Work(hrs)<span class='required'> *</span></label>" +
                        //"					<input type='text' class='form-control' id='TaskHrs_" + obj.TaskID + "' value='" + obj.Effort + "' />" +
                        //   "			</div>	" +

                              "		<div class='form-group col-lg-6 col-md-6 col-sm-12 focused'>" +
                        "					<label class='control-label'  style='color:#3e3939!important;'>Work (H:M)<span class='required'> *</span></label>" +
                        "					<input type='text' class='form-control' maxlength = 8 id='TaskHrs_" + obj.TaskID + "' value='" + obj.Effort + "' />" +
                           "			</div>	" +
  //End of Added By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes 
                        "			<div class='form-group col-lg-6 col-md-6 col-sm-12 focused'>" +
                        "					<label class='control-label'  style='color:#3e3939!important;'>Start Date<span class='required'> *</span></label>" +
                        "					<input  type='text' name='EditStartDateAssigntask_" + obj.TaskID + "' id='EditStartDateAssigntask_" + obj.TaskID + "'  class='form-control' value='" + (obj.StartDate != null ? ParseDate(obj.StartDate) : "-") + "'/>" +
                        "			</div>" +
                        "			<div class='form-group col-lg-6 col-md-6 col-sm-12 focused'>" +
                        "					<label class='control-label'  style='color:#3e3939!important;'>End Date<span class='required'> *</span></label>" +
                        "					<input type='text' name='EditEndDateAssigntask_" + obj.TaskID + "' id='EditEndDateAssigntask_" + obj.TaskID + "' class='form-control' value='" + (obj.EndDate != null ? ParseDate(obj.EndDate) : "-") + "'/>" +
                        "			</div>" +
                        "		<div class='form-group col-lg-6 col-md-6 col-sm-12 focused'>" +
                        "					<label class='control-label'  style='color:#3e3939!important;'>Story Points</label>" +
                        "					<input type='text' class='form-control' id='TaskStoryPoints_" + obj.TaskID + "' value='" + (obj.StoryPoint == null ? "" : obj.StoryPoint) + "'/>" +
                        "			</div>		" +
                        "		<div class='form-group col-lg-6 col-md-6 col-sm-12 focused'>" +
                        "				<label class='control-label select-label'  style='color:#3e3939!important;'>Priority<span class='required'> *</span></label>" +
                        "				<select class='form-control' id='EditcboPriority_" + obj.TaskID + "' name='EditcboPriority_" + obj.TaskID + "'>" +
                        "				<option></option>" +
                        "				</select>" +
                   <%-- "<% CommonFunctions.HTMLControls.DrawComboBox("AssigntaskcboPriorities", "usp_NG2_Sel_tbl_IB_Priorities", , , "class='form-control' ", True ,True)%>"+--%>
                        "			</div>" +
                        "		<div class='form-group col-lg-6 col-md-6 col-sm-12 focused'>" +
                        "				<label class='control-label select-label'  style='color:#3e3939!important;'>Task Type<span class='required'> *</span></label>" +
                        "				<select class='form-control' id='EditcboTaskType_" + obj.TaskID + "' name='EditcboTaskType_" + obj.TaskID + "'>" +
                        "					<option></option>" +
                        "				<option>Developement</option>" +
                        "				<option>Design</option>" +
                        "				</select>" +
                        "			</div>" +
                        "			<div class='form-group col-lg-6 col-md-6 col-sm-12 checkbox' style='    margin-left: -20px;'>" +
                        "			<div class='col-sm-6'>" +
                        "				<label class='control-label col-sm-6 col-xs-12 on-hold-label'>On Hold</label>" +
                        "				<div class=''>" +
                        "					<input type='checkbox' id='EditchkHold_" + obj.TaskID + "' name='EditchkHold_" + obj.TaskID + "' checked='" + (obj.TaskOnHold == 1 ? "true" : "false") + "'>" +
                        "				</div>" +
                        "			</div>" +

                        "		<div class='col-sm-6' style='margin-bottom: 15px;'>" +
                        "				<label class='control-label  col-sm-6 col-xs-12 billable-label'>Billable</label>" +
                        "				<div class=''><input type='checkbox' id='EditchkBillable_" + obj.TaskID + "' name='EditchkBillable_" + obj.TaskID + "' checked='true' value='1' ></div>	" +
                        "			</div>" +
                        "	</div>" +

                        "</div>" +
                        "	<div class='modal-footer col-md-10 col-sm-10' style='float: right;'>" +
                        //"       <button type='button' class='btn btn-success' id='Update_" + obj.TaskID + "' onclick=SaveTask(" + obj.TaskID + ",'Update') style='background-color: rgb(2, 136, 209)!important'>Update</button>"

                        (obj.IsActive == 'Void' || obj.IsTaskCompleted == 1 || obj.IsUserStoryComplete == 1 || obj.IsIterationComplete == 1 ? "       <button type='button' class='btn btn-success' id='Update_" + obj.TaskID + "' style='background-color: rgb(2, 136, 209)!important' data-bs-toggle='tooltip' title=''  disabled >Update</button>" :
                           "       <button type='button' class='btn btn-success' id='Update_" + obj.TaskID + "' onclick=SaveTask(" + obj.TaskID + ",'Update') style='background-color: rgb(2, 136, 209)!important'>Update</button>")
                     +
                    "   </div>" +
                    "</form></div></td></tr></center>"

                    $("#tbodyTaskList").append(TaskList);
                    BindTaskPriority(obj.TaskID, obj.Priority);
                    BindTaskType(obj.TaskID, obj.EntityTypeID);
                    document.getElementById("EditchkHold_" + obj.TaskID + "").checked = (obj.TaskOnHold == 1 ? true : false);
                    document.getElementById("EditchkBillable_" + obj.TaskID + "").checked = (obj.BillableYN == 1 ? true : false);
                    limitText(document.getElementById("TaskName_" + obj.TaskID + ""), document.getElementById("viewcountTaskName_" + obj.TaskID + ""), 255);
                    limitText(document.getElementById("TaskNotes_" + obj.TaskID + ""), document.getElementById("viewcountTaskNote_" + obj.TaskID + ""), 2000);
                    $("#EditStartDateAssigntask_" + obj.TaskID + "").datepicker({
                        dateFormat: "mm/dd/yy",
                        changeMonth: true,
                        changeYear: true,
                        yearRange: '1900:2020'
                    });
                    $("#EditEndDateAssigntask_" + obj.TaskID + "").datepicker({
                        dateFormat: "mm/dd/yy",
                        changeMonth: true,
                        changeYear: true,
                        yearRange: '1900:2020'
                    });
                    getRows(obj.TaskID);
                });
                $('[data-bs-toggle="tooltip"]').tooltip();
            }
            else {
                var TaskList = ""
                TaskList = "<div class='col-md-6'><span style='text-align:center'> There are no items to show</span></div>"
                $("#tbodyTaskList").append(TaskList);
            }
            var showChar = 20;  // How many characters are shown by default
            var ellipsestext = "...";
            var moretext = "Show more >";
            var lesstext = "Show less";


            $('.more').each(function () {
                var content = $(this).html();

                if (content.length > showChar) {

                    var c = content.substr(0, showChar);
                    var h = content.substr(showChar, content.length - showChar);

                    var html = c + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';

                    $(this).html(html);
                }

            });

            $(".morelink").click(function () {
                if ($(this).hasClass("less")) {
                    $(this).removeClass("less");
                    $(this).html(moretext);
                } else {
                    $(this).addClass("less");
                    $(this).html(lesstext);
                }
                $(this).parent().prev().toggle();
                $(this).prev().toggle();
                return false;
            });

            $("#search_table").on("keyup", function () {
               
                var value = $(this).val().toLowerCase();
                $("#tbodyTaskList tr:even").filter(function () {
                
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                  //  $(".collapse").hide();
                    //$(this).removeClass("in");
                    //$(this).css("display", "");
                });
            });
            $('.form-control').on('focus blur', function (e) {
                $(this).parents('.form-group').toggleClass('focused', (e.type === 'focus' || this.value.length > 0));
            }).trigger('blur');
            $(".form-control").on("blur", function () {

                if ($('#cboUS').val() == 0) {
                    $('#cboUS').parent().removeClass("focused");
                }
                else if ($('#cboUSNew').val() == 0) {
                    $('#cboUSNew').parent().removeClass("focused");
                }
                 if ($('#cboStatus').val() == 0) {
                    $('#cboStatus').parent().removeClass("focused");
                }
            });
        }
        function ResetStatusBtn(btn) {
            btn.blur();
            $('.form-control').on('focus blur', function (e) {
                $(this).parents('.form-group').toggleClass('focused', (e.type === 'focus' || this.value.length > 0));
            }).trigger('blur');
        }
        function ValidateSprintAndUS(TaskID, Flag, strTaskID) {
            //debugger;
            var USID = 0

            if (Flag == 'Save') {
                USID = $('#cboUSNew option:selected').val()
            }
            else if (Flag == 'Update') {
                if (strTaskID != undefined) {
                    TaskID = strTaskID
                }

                USID = $('#cboUSName_' + TaskID + ' option:selected').val()
            }
            var result = ajaxCall("frmTaskCreation.aspx/ValidateSprintAndUS", "POST", "application/json", "json",
                                JSON.stringify({ UserStoryID: USID }));
            return (result.d)
        }
        function SaveTask(TaskID, Flag, strTaskID) {
            //debugger;



            if ((Flag == 'Save' ? validateTask() : ValidateEditTask(TaskID, strTaskID)) == 0) {
                if (ValidateSprintAndUS(TaskID, Flag, strTaskID) == 1) {
                    setFrameLoader();
                    var BillableValue, StoryPoints, PhaseVal, ModuleVal, SubProjectVal, MilestoneVal, ChangeRequestVal, DeliverableVal, OnHoldValue;
                    if (Flag == 'Save') {

                        var TaskID = 0;
                        var extraPara = [];
                        extraPara.push(TaskID);
                        var objTaskName = $('#AssigntxtTaskName').val();
                        var objTaskNote = $('#txtTaskNotes').val();
                        //alert(objTaskNote)
                        var objResource = $('#cboAssignResourcesNew').val();
                        var objTaskType = $('#AssigntaskcboTaskTypeNew').val();
                        var objWorkHrs = $('#txtTaskWorkhrsNew').val();
                        var objStartDate = $('#StartDateAssigntask').val();
                        var objEndDate = $('#EndDateAssigntask').val();
                        var objPriorities = $('#AssigntaskcboPriorities').val();
                        var objBillable = $('#chkBillable');
                        var objHold = $('#chkHold');
                        var objStoryPoints = $('#txtStoryPointsNew').val();
                        var USID = $('#cboUSNew option:selected').val()
                    }
                    else if (Flag == 'Update') {
                        var extraPara = [];
                        extraPara.push((strTaskID != undefined ? strTaskID : TaskID));
                        var objTaskName = $('#TaskName_' + TaskID).val();
                        var objTaskNote = $('#TaskNotes_' + TaskID).val();
                        var objResource = $('#cboAssignResources_' + TaskID).val();
                        var objTaskType = $('#EditcboTaskType_' + TaskID).val();
                        var objWorkHrs = $('#TaskHrs_' + TaskID).val();
                        var objStartDate = $('#EditStartDateAssigntask_' + TaskID).val();
                        var objEndDate = $('#EditEndDateAssigntask_' + TaskID).val();
                        var objPriorities = $('#EditcboPriority_' + TaskID).val();
                        var objBillable = $('#EditchkBillable_' + TaskID);
                        var objHold = $('#EditchkHold_' + TaskID);
                        var objStoryPoints = $('#TaskStoryPoints_' + TaskID).val();
                        var USID = $('#cboUSName_' + TaskID + ' option:selected').val()
                    }

                    if (objBillable[0].checked == true) {
                        BillableValue = 1;
                    }
                    else {
                        BillableValue = 0;
                    }
                    if (objHold[0].checked == true) {
                        chkHold = 1;
                    }
                    else {
                        chkHold = 0;
                    }
                    if (objStoryPoints == "") {
                        StoryPoints = 0;
                    }
                    else {
                        StoryPoints = objStoryPoints;
                    }
                    //alert(objTaskNote);
                    var URL = "frmTaskCreation.aspx/SaveTaskDetails"

                    var AssignTaskData = [];

                    AssignTaskData.push({
                        TaskID: (strTaskID != undefined ? strTaskID : TaskID),
                        TaskName: objTaskName, EmployeeID: objResource, WorkHrs: objWorkHrs, StartDate: objStartDate, EndDate: objEndDate,
                        Priority: objPriorities, TaskType: objTaskType, Billable: BillableValue, Hold: chkHold, PhaseVal: 0, ModuleVal: 0, SubProjectVal: 0,
                        MilestoneVal: 0, ChangeRequestVal: 0, DeliverableVal: 0, strProjectID: '<%= Session("intProjectID")%>', PracticeID: 0,
                        UserStoryID: USID, strEntity: "", StoryPoints: StoryPoints, TaskNote: objTaskNote, Flag: Flag
                    });



                    data = JSON.stringify({ AssignTaskData: AssignTaskData, UserStoryId: USID, });
                    if (Flag == 'Save') {
                        AJAXCallWithPara(URL, data, AfterSaveTask, extraPara);
                    }
                    else if (Flag == 'Update') {
                        AJAXCallWithPara(URL, data, EditSaveTask, extraPara);

                    }


                }
                else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("Task can not be created as User Story/Sprint get completed/not started", 'error', 5);
                }
            }

        }
        function clearModalPopup() {
            $('#AssigntxtTaskName').val('');
            $('#txtTaskNotes').val('');
            $('#cboAssignResourcesNew').val('');
            $('#AssigntaskcboTaskTypeNew').val('');
            $('#txtTaskWorkhrsNew').val('');
            $('#StartDateAssigntask').val('');
            $('#EndDateAssigntask').val('');
            $('#AssigntaskcboPriorities').val('');
            $('#txtStoryPointsNew').val('');

            $('#AssigntxtTaskName').focus();
            $('#txtTaskNotes').blur();
            $('#cboAssignResourcesNew').blur();
            $('#AssigntaskcboTaskTypeNew').blur();
            $('#txtTaskWorkhrsNew').blur();
            $('#StartDateAssigntask').blur();
            $('#EndDateAssigntask').blur();
            $('#AssigntaskcboPriorities').blur();
            $('#txtStoryPointsNew').blur();

            //$('#txtTaskNotes').trigger('keydown')
           // alert($('#cboSprint option:selected').val());
           // $("#cboSprintNew option:selected").val("" + $('#cboSprint option:selected').val() + "");

            $("#cboSprintNew option[value='" + $('#cboSprint option:selected').val() + "']").attr("selected", "selected")
            CboSprintNewonChange($('#cboSprint option:selected').val());
            //   $("#cboUSNew option:selected").val("0");

            document.getElementById("chkHold").checked = false;
        }
    function EditSaveTask(data, extraPara) {
        //debugger;
            RemoveFrameLoader();
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Task Updated successfully', 'success', 5);
            BindTaskListTbody();
        }
        function AfterSaveTask(data, extraPara) {
            RemoveFrameLoader();
            clearModalPopup();
            $("#txtTaskNotes").trigger("keyup");
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Task Created successfully', 'success', 5);
            BindTaskListTbody();
        }
        function CboSprintonChange(selectedSprint) {
            //alert(intSelectedSprintID);
            //debugger;
            try {
                var url = "frmTaskCreation.aspx/GetDropDownValues"
                if (selectedSprint == undefined || selectedSprint == "") {
                    selectedSprint = 0;
                }
                //if (intSelectedSprintID != 0) {
                //    selectedSprint = intSelectedSprintID;
                //}
                //selectedSprint = intSelectedSprintID;
                var result = ajaxCall("frmTaskCreation.aspx/GetDropDownValues", "POST", "application/json", "json",
                               JSON.stringify({ IterationID: selectedSprint }));
                //data = JSON.stringify({  IterationID: selectedSprint });
                //var result = AJAXCallWithResult(url, data, false);
                if (result.d != '[]|') {
                    BindDropdownUserStory(result);
                    

                }
                else {
                    intSelectedUserStoryID = 0;
                }
            }
            catch (ex) {
                console.log(ex.message);
                //alert(ex.message);

            }
        }
        function CboSprintNewonChange(selectedSprint) {
            //debugger;
            //alert(selectedSprint);
            try {

                if (selectedSprint == undefined || selectedSprint == "") {
                    selectedSprint = 0;
                }

                var result = ajaxCall("frmTaskCreation.aspx/GetDropDownValues", "POST", "application/json", "json",
                               JSON.stringify({ IterationID: selectedSprint }));

                if (result.d != '[]|') {
                    BindDropdownUserStoryNew(result);
                }

            }
            catch (ex) {
                console.log(ex.message);
                alert(ex.message);
            }
        }

        function BindDropdownUserStory(result) {
            //debugger;

            var strArray = String(result.d).split("|")


            objCbo1 = document.getElementById("cboUS");
            //$("#cboUS option").remove();

            $("#cboUS option").remove();
            var objOption = document.createElement("OPTION");
            objCbo1.options.add(objOption);

            objOption.value = 0;

            $.each(JSON.parse(strArray[0]), function (id, obj) {

                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);
                objOption.text = "" + obj.UserStoryID + " - " + obj.UserStoryName + ""
                objOption.value = obj.UserStoryID;
                intSelectedUserStoryID = obj.UserStoryID;

                strSelectedUS = $('#cboUS option:selected').text();


            });
            BindTaskListTbody();

        }
        //Added by Swapnagandha K. On 4/3/2019 New Requirement
    function BindDropDownStatus(result) {
         var strArray = String(result.d).split("|")
         var arr = [];

            objCbo1 = document.getElementById("cboStatus");
            //$("#cboUS option").remove();

            $("#cboStatus option").remove();
            var objOption = document.createElement("OPTION");
            objCbo1.options.add(objOption);

            objOption.value = 0;

            $.each(JSON.parse(strArray[0]), function (id, obj) {
                if ($.inArray(obj.IsActive, arr) == -1) {
                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);
                objOption.text = "" + (obj.IsActive == "Void" ? "In Active" : obj.IsActive) + ""
                    objOption.value = obj.IsActive;
                    arr.push(obj.IsActive);
                    }
        });
    }
    //End by Swapnagandha K.

    $("#cboStatus").change(function () {
        //  debugger;
        var filterValue = ($(this).val() == "Void" ? "In Active" : $(this).val());

        $("#tableTaskList tbody tr:even").each(function () {

            var row = $(this);
            var rowStatus = $(this).find(".clsStatus").find(".btn").html();
            if (filterValue == rowStatus) {
                row.show();
            }
            else {
                if (filterValue == 0) {
                    row.show();
                }
                else {
                    row.hide();
                }

            }

        })

     
});

        function BindDropdownUserStoryNew(result) {

            var strArray = String(result.d).split("|")


            objCbo1 = document.getElementById("cboUSNew");
            //$("#cboUS option").remove();
            $("#cboUSNew option").remove();
            var objOption = document.createElement("OPTION");
            objCbo1.options.add(objOption);
            objOption.value = 0;
            $.each(JSON.parse(strArray[0]), function (id, obj) {
                var objOption = document.createElement("OPTION");
                objCbo1.options.add(objOption);
                objOption.text = ""+ obj.UserStoryID +" - " + obj.UserStoryName +"";
                objOption.value = obj.UserStoryID;
            });
        }
        function validateTask() {
            //debugger;
            var checkFlag = 0;
            var strmsg = "";
            var errorMsg = "<ul>"
            var checkWorkHours = 1;

            if ($("#cboSprintNew").val() == 0) {
                strmsg = '- Sprint Name should not left blank.';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;
                if (checkFlag == 0) {
                    checkFlag = 1;
                    $("#cboSprintNew").focus();
                }
            }
            if ($("#cboUSNew").val() == 0) {
                strmsg = '- User Story should not left blank.';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;
                if (checkFlag == 0) {
                    checkFlag = 1;
                    $("#cboUSNew").focus();
                }
            }
            if ($("#AssigntxtTaskName").val() == "") {
                strmsg = '- Task Name should not left blank.';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;
                if (checkFlag == 0) {
                    checkFlag = 1;
                    $("#AssigntxtTaskName").focus();
                }
            }
            //Added By Riddhesh Patil on 11-NOV-2022 
            else if (checkSpecialCharacter($("#AssigntxtTaskName").val(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                alertify.error('Task Name should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                if (checkFlag == 0) {
                    checkFlag = 1;
                    $("#AssigntxtTaskName").focus();
                }
               
            }
            else if (checkSpecialCharacter($("#txtTaskNotes").val(), WebConfigSpecialCharacters) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.error('Task Note should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                if (checkFlag == 0) {
                    checkFlag = 1;
                    $("#txtTaskNotes").focus();
                }

            }
			//End of Added By Riddhesh Patil
            if ($("#cboAssignResourcesNew").val() == "") {
                strmsg = '- Resource should not left blank';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;
                if (checkFlag == 0) {
                    checkFlag = 1;
                    $("#cboAssignResourcesNew").focus();
                }
            }


            if ($("#txtTaskWorkhrsNew").val() == "") {
                strmsg = '- Work(Hrs) should not left blank';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;
                if (checkFlag == 0) {
                    checkFlag = 1;
                    checkWorkHours = 0;
                    $("#txtTaskWorkhrsNew").focus();
                }
            }


            if ($("#StartDateAssigntask").val() == "") {
                strmsg = '- Start Date should not left blank';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;

                if (checkFlag == 0) {
                    checkFlag = 1;
                    checkWorkHours = 0;
                    //$("#StartDateAssigntask").focus();
                }
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }

            if ($("#EndDateAssigntask").val() == "") {
                strmsg = '- End Date should not left blank';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;
                if (checkFlag == 0) {
                    checkFlag = 1;
                    checkWorkHours = 0;
                    //$("#EndDateAssigntask").focus();
                }
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }
            //Added By Riddhesh Patil on 11-NOV-2022 
            if ($("#txtStoryPointsNew").val() != "") {
                if (checkSpecialCharacter($("#txtStoryPointsNew").val(), WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Story Points should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    if (checkFlag == 0) {
                        checkFlag = 1;
                        $("#txtStoryPointsNew").focus();
                    }
                }
            }
			//End of Added By Riddhesh Patil
            if ($("#AssigntaskcboPriorities").val() == "") {
                strmsg = '- Priority should not left blank';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;
                if (checkFlag == 0) {
                    checkFlag = 1;
                    $("#AssigntaskcboPriorities").focus();
                }
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }
            if ($("#AssigntaskcboTaskTypeNew").val() == "") {
                strmsg = '- Task Type should not left blank';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;
                if (checkFlag == 0) {
                    checkFlag = 1;
                    $("#AssigntaskcboTaskTypeNew").focus();
                }
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }


            if ($("#StartDateAssigntask").val() != '' && $("#EndDateAssigntask").val() != '' && checkFlag == 0) {
                if (CompairDates1($("#StartDateAssigntask").val(), $("#EndDateAssigntask").val()) == 1 && CompairDates1($("#StartDateAssigntask").val(), $("#EndDateAssigntask").val()) != 0) {
                    // $('#dtEndDate').css('border-color', 'red');
                    // $('#dtEndDate').css('border-width', '1px');
                    strmsg = '- Please enter Task End Date greater than or equal to Task Start Date!'
                    errorMsg += "" + strmsg + "</br>";

                    // $('#spndtEndDate').text("Please enter Task End Date greater than or equal to Task Start Date!");
                    if (checkFlag != 1) {
                        //objEndDate.focus()
                    }
                    isValid = 1;
                    checkFlag = 1;
                    checkWorkHours = 0;
                }
            }
            if (checkFlag == 0) {
                var data = JSON.stringify({ ProjectID: '<%= Session("intProjectID")%>', StartDate: $("#StartDateAssigntask").val(), EndDate: $("#EndDateAssigntask").val() });
                var Newresult = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);

                if (Newresult.d != '') {
                    var arrResult = Newresult.d.split('##');

                    if (arrResult[0] == '1') {


                        strmsg = '-' + arrResult[1];
                        errorMsg += "" + strmsg + "</br>";
                        isValid = 1;
                        checkFlag = 1;
                        checkWorkHours = 0;
                    }
                    if (arrResult[0] == '2') {
                        strmsg = '-' + arrResult[1];
                        errorMsg += "" + strmsg + "</br>";
                        isValid = 1;
                        checkFlag = 1;
                        checkWorkHours = 0;
                    }


                }


            }

            if ($("#EndDateAssigntask").val() != '') {
                var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: $('#cboUSNew option:selected').val(), strStartDate: $("#StartDateAssigntask").val(), strEndDate: $("#EndDateAssigntask").val() }), false);
                if (result.d != "") {
                    var strMsg = String(result.d).split("_");
                    if (strMsg[0] == "1") {
                        // $('#spndtStartDate').text(strMsg[1]);
                        strmsg = '- ' + strMsg[1];
                        errorMsg += "" + strmsg + "</br>";

                    }
                    else {
                        //$('#spndtEndDate').text(strMsg[1]);
                        strmsg = '- ' + strMsg[1];
                        errorMsg += "" + strmsg + "</br>";

                    }
                    isValid = 1;
                    checkFlag = 1;
                    checkWorkHours = 0;
                }
            }
            if ($("#txtStoryPointsNew").val() != "") {
                if (isNaN($("#txtStoryPointsNew").val()) == true) {


                    strmsg = '- Please Enter only positive numeric value For Story Point';
                    errorMsg += "" + strmsg + "</br>";
                    isValid = 1;
                    checkFlag = 1;
                }
                else {

                    var n = $("#txtStoryPointsNew").val();
                    var result = (n - Math.floor(n)) !== 0;

                    if (result) {
                        strmsg = '- Please enter Story Points without decimal';
                        errorMsg += "" + strmsg + "</br>";
                        isValid = 1;
                        checkFlag = 1;
                    }
                }



            }

            if ($("#txtStoryPointsNew").val() == "0") {


                strmsg = '- Please Enter only positive numeric value greater than 0 For Story Point';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;
                checkFlag = 1;
            }
            if (checkFlag == 0) {
                var TaskID = "";
                if ($("#txtStoryPointsNew").val() != "") {
                    var data = JSON.stringify({ UserStoryID: $('#cboUSNew option:selected').val(), StoryPoints: $("#txtStoryPointsNew").val(), TaskID: "" });
                    var Newresult = AJAXCallWithResult("frmSprintPlanning.aspx/ValidateStoryPointss", data, false);
                    // alert(Newresult.d);
                    if (Newresult.d != '') {
                        strmsg = Newresult.d;
                        errorMsg += "" + strmsg + "</br>";
                        isValid = 1;
                        checkFlag = 1;
                        $("#txtStoryPointsNew").focus();
                    }
                }
            }

            if ($("#txtTaskWorkhrsNew").val() != "") {

                 //Commented And Added By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes

                //if (isNaN($("#txtTaskWorkhrsNew").val()) == true) {


                //    strmsg = '- Please Enter  only positive numeric value  For Work(Hrs)';
                //    errorMsg += "" + strmsg + "</br>";
                //    isValid = 1;
                //    checkFlag = 1;
                //    checkWorkHours = 0;
                //    //checkWorkHours = 0;
                //    $("#txtTaskWorkhrsNew").focus();
                //}

                //else if (($("#txtTaskWorkhrsNew").val() - 0) == 0) {

                //    strmsg = '- Please Enter only  Work(Hrs) greater than 0';
                //    errorMsg += "" + strmsg + "</br>";
                //    isValid = 1;
                //    checkFlag = 1;
                //    checkWorkHours = 0;
                //    $("#txtTaskWorkhrsNew").focus();
                //}

                //else if (parseFloat($("#txtTaskWorkhrsNew").val()) < 0 && $("#txtTaskWorkhrsNew").val() != '') {

                //    strmsg = '- Please enter positive Value For  Work(Hrs)';
                //    errorMsg += "" + strmsg + "</br>";
                //    isValid = 1;
                //    checkFlag = 1;
                //    checkWorkHours = 0;
                //    $("#txtTaskWorkhrsNew").focus();

                //}

                try {                    
                    var blnHMFormat = true;
                    var objHMEffort = document.getElementById("txtTaskWorkhrsNew");
                    var objVal = objHMEffort.value;
                    var objnewVal = objHMEffort.value;

                    objHMEffort.value = objHMEffort.value.replace(":", ".");
                    var isdigit = isNumeric(objHMEffort.value);
                    objHMEffort.value = objVal;

                    if (isdigit == false) {
                        strmsg = ' - Please Enter only positive numeric value For Work(Hrs) in H:M format.';
                        errorMsg +=   strmsg + "</br>";
                        blnHMFormat = false;
                        isValid = 1;
                        checkFlag = 1;
                    }


                    if (objHMEffort.value.indexOf(":") == -1) {                       
                        objHMEffort.value = objnewVal + ':00';
                        objnewVal = objHMEffort.value;
                    }

                    if (objHMEffort.value.indexOf(":") != -1) {
                        objHMEffort.value = objHMEffort.value.replace(':', '.');
                    }

                    //var blnResult = disallowSpecialCharacters(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                    var tempEffort = objHMEffort.value.replace('-', '');
                    if (checkSpecialCharacter(tempEffort) == true) {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = ' - Work(Hrs) cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters';
                        errorMsg += strmsg + "</br>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        objHMEffort.value = objVal;
                        isValid = 1;
                        checkFlag = 1;
                    } 
                    
                    if (blnHMFormat == true) {
                        if (RestrictNonNumeric(document.getElementById("txtTaskWorkhrsNew")) == true) {
                            strmsg = ' - Please enter Work(Hrs) in H:M format.';
                            errorMsg += strmsg + "";
                            objHMEffort.value = objVal;
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
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
                            strmsg = " - Please enter Work(Hrs) in H:M format.";
                            errorMsg += strmsg + "</br>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }

                        if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                            strmsg = ' - Hours should not be less than or equal to zero (0).';
                            errorMsg += strmsg + "</br>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }
                                                
                        if (blnHMFormat == true) {
                            if (mins.length > 2) {
                                strmsg = " - Please enter minutes in two decimal and less than 60.";
                                errorMsg += strmsg + "";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }
                        if (blnHMFormat == true) {
                            if (mins > 59 || mins < 0) {
                                strmsg = ' - Please enter minutes between (0-59) range';
                                errorMsg += strmsg + "</br>";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }
                    }                    

                    if ($("#StartDateAssigntask").val() != "" && $("#EndDateAssigntask").val() != "") {
                        if (checkWorkHours == 1) {

                            var data = JSON.stringify({ StartDate: $("#StartDateAssigntask").val(), EndDate :  $("#EndDateAssigntask").val() });
                            var cntDaysCountResult = AJAXCallWithResult("UserStoryDetails.aspx/getDateDiff", data, false);
                       
                            var dblTotalDuration = cntDaysCountResult.d;

                            //var dblTotalDuration = DateDiff($("#EditStartDateAssigntask_" + TaskID).val(), $("#EditEndDateAssigntask_" + TaskID).val(), "d") + 1;

                            data = JSON.stringify({ HMHours: WorkHour });
                            var decTotalWorkResult = AJAXCallWithResult("frmSprintPlanning.aspx/getDecimalHours", data, false);
                            var dblTotalWork = decTotalWorkResult.d;

                            dblAvgHoursPerDay = dblTotalWork / dblTotalDuration;

                            if (dblAvgHoursPerDay > 24) {

                                strmsg = ' - You cannot assign more than 24 hours work per day';
                                errorMsg += strmsg + "</br>";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }
                    }
                   
                    var MinDAENtryDisplay = "";

                    var data = JSON.stringify({ Flag: "MinHoursForDAEntry" });
                    var resMinHoursForDAEntry = AJAXCallWithResult("frmProductBacklog.aspx/getCompanyDetails", data, false);

                    var MinDAEntry = resMinHoursForDAEntry.d;

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

                    var data = JSON.stringify({ Flag: "RestrictByMinHours" });
                    var resRestrictByMinHours = AJAXCallWithResult("frmProductBacklog.aspx/getCompanyDetails", data, false);

                    if (resRestrictByMinHours.d == 'True') {
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
                                        strmsg = ' - Please enter the work Hours in multiple of (' + MinDAENtryDisplay + ') min';
                                        errorMsg += strmsg + "</br>";
                                        isValid = 1;
                                        checkFlag = 1;
                                    }
                                }
                            }
                        }
                    }
                    if (checkFlag == 1) {
                        objHMEffort.value = objVal;
                    }
                }
                catch (ex) {
                    alert(ex.message);
                }

                 //End of Added By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes

            }

            //Commented By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes
            //if (checkWorkHours == 1) {
            //    //debugger;
            //    // get total seconds between the times
            //    var StartDate = new Date($("#StartDateAssigntask").val());
            //    var EndDate = new Date($("#EndDateAssigntask").val());
            //    var delta = Math.abs(EndDate - StartDate) / 1000;
            //    var days = (Math.floor(delta / 86400)) + 1;
            //    delta -= days * 86400;

            //    days = days * 24;
            //    if ($("#txtTaskWorkhrsNew").val() > days) {
            //        strmsg = '- Work(Hrs) should not be greater than ' + days + ' Hours ';
            //        errorMsg += "" + strmsg + "</br>";
            //        isValid = 1;
            //        checkFlag = 1;
            //    }

            //}
            //End of Commented By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes
            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error', 5);

            }

            return checkFlag;
            return isValid;

        }
        function ValidateEditTask(TaskID, strTaskID) {
           
            //debugger;
            var checkFlag = 0;
            var strmsg = "";
            var errorMsg = "<ul>"
            var checkWorkHours = 1;

            if ($("#TaskHrs_" + TaskID).val() == "") {
                strmsg = '- Work(Hrs) should not left blank';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;
                if (checkFlag == 0) {
                    checkFlag = 1;
                    $("#TaskHrs_" + TaskID).focus();
                    checkWorkHours = 0;
                }
            }

            if ($("#EditStartDateAssigntask_" + TaskID).val() == "") {
                strmsg = '- Start Date should not left blank';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;

                if (checkFlag == 0) {
                    checkFlag = 1;
                    checkWorkHours = 0;
                    //$("#StartDateAssigntask").focus();
                }
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }

            if ($("#EditEndDateAssigntask_" + TaskID).val() == "") {
                strmsg = '- End Date should not left blank';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;
                if (checkFlag == 0) {
                    checkFlag = 1;
                    checkWorkHours = 0;
                    //$("#EndDateAssigntask").focus();
                }
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }
            if ($("#EditcboPriority_" + TaskID).val() == "") {
                strmsg = '- Priority should not left blank';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;
                if (checkFlag == 0) {
                    checkFlag = 1;
                    $("#EditcboPriority_" + TaskID).focus();
                }
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }
            if ($("#EditcboTaskType_" + TaskID).val() == "") {
                strmsg = '- Task Type should not left blank';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;
                if (checkFlag == 0) {
                    checkFlag = 1;
                    $("#EditcboTaskType_" + TaskID).focus();
                }
                //$("#txtEndDate" + htRowCount[i].value).focus();
            }


            if ($("#EditStartDateAssigntask_" + TaskID).val() != '' && $("#EditEndDateAssigntask_" + TaskID).val() != '' && checkFlag == 0) {
                if (CompairDates1($("#EditStartDateAssigntask_" + TaskID).val(), $("#EditEndDateAssigntask_" + TaskID).val()) == 1 && CompairDates1($("#EditStartDateAssigntask_" + TaskID).val(), $("#EditEndDateAssigntask_" + TaskID).val()) != 0) {
                    // $('#dtEndDate').css('border-color', 'red');
                    // $('#dtEndDate').css('border-width', '1px');
                    strmsg = '- Please enter Task End Date greater than or equal to Task Start Date!'
                    errorMsg += "" + strmsg + "</br>";

                    // $('#spndtEndDate').text("Please enter Task End Date greater than or equal to Task Start Date!");
                    if (checkFlag != 1) {
                        //objEndDate.focus()
                    }
                    isValid = 1;
                    checkFlag = 1;
                    checkWorkHours = 0;
                }
            }
            if (checkFlag == 0) {
                var data = JSON.stringify({ ProjectID: '<%= Session("intProjectID")%>', StartDate: $("#EditStartDateAssigntask_" + TaskID).val(), EndDate: $("#EditEndDateAssigntask_" + TaskID).val() });
                var Newresult = AJAXCallWithResult("frmProductBacklog.aspx/ValidateProjectDates", data, false);
                //alert(Newresult.d)    
                if (Newresult.d != '') {
                    var arrResult = Newresult.d.split('##');

                    if (arrResult[0] == '1') {


                        strmsg = '-' + arrResult[1];
                        errorMsg += "" + strmsg + "</br>";
                        isValid = 1;
                        checkFlag = 1;
                        checkWorkHours = 0;
                    }
                    if (arrResult[0] == '2') {
                        strmsg = '-' + arrResult[1];
                        errorMsg += "" + strmsg + "</br>";
                        isValid = 1;
                        checkFlag = 1;
                        checkWorkHours = 0;
                    }


                }


            }

            if ($("#EditEndDateAssigntask_" + TaskID).val() != '') {
                var result = AJAXCallWithResult('frmSprintPlanning.aspx/CheckIterationDates', JSON.stringify({ strUserStoryID: $('#cboUSName_' + TaskID + ' option:selected').val(), strStartDate: $("#EditStartDateAssigntask_" + TaskID).val(), strEndDate: $("#EditEndDateAssigntask_" + TaskID).val() }), false);
                if (result.d != "") {
                    var strMsg = String(result.d).split("_");
                    if (strMsg[0] == "1") {
                        // $('#spndtStartDate').text(strMsg[1]);
                        strmsg = '- ' + strMsg[1];
                        errorMsg += "" + strmsg + "</br>";

                    }
                    else {
                        //$('#spndtEndDate').text(strMsg[1]);
                        strmsg = '- ' + strMsg[1];
                        errorMsg += "" + strmsg + "</br>";

                    }
                    isValid = 1;
                    checkFlag = 1;
                    checkWorkHours = 0;
                }
            }
            if ($("#TaskStoryPoints_" + TaskID).val() != "") {
                if ($("#TaskStoryPoints_" + TaskID).val() < 0) {


                    strmsg = '- Please Enter only positive numeric value For Story Point';
                    errorMsg += "" + strmsg + "</br>";
                    isValid = 1;
                    checkFlag = 1;
                    $("#TaskStoryPoints_" + TaskID).focus();
                }
                else {

                    var n = $("#TaskStoryPoints_" + TaskID).val();
                    var result = (n - Math.floor(n)) !== 0;

                    if (result) {
                        strmsg = '- Please enter Story Points without decimal';
                        errorMsg += "" + strmsg + "</br>";
                        isValid = 1;
                        checkFlag = 1;
                        $("#TaskStoryPoints_" + TaskID).focus();
                    }
                }



            }

            if ($("#TaskStoryPoints_" + TaskID).val() == "0") {


                strmsg = '- Please Enter only positive numeric value greater than 0 For Story Point';
                errorMsg += "" + strmsg + "</br>";
                isValid = 1;
                checkFlag = 1;
                $("#TaskStoryPoints_" + TaskID).focus();
            }
            if (checkFlag == 0) {

                if ($("#TaskStoryPoints_" + TaskID).val() != "") {
                    var data = JSON.stringify({ UserStoryID: $('#cboUSName_' + TaskID + ' option:selected').val(), StoryPoints: $("#TaskStoryPoints_" + TaskID).val(), TaskID: (strTaskID != undefined ? strTaskID : TaskID) });
                    var Newresult = AJAXCallWithResult("frmSprintPlanning.aspx/ValidateStoryPointss", data, false);
                    // alert(Newresult.d);
                    if (Newresult.d != '') {
                        strmsg = Newresult.d;
                        errorMsg += "" + strmsg + "</br>";
                        isValid = 1;
                        checkFlag = 1;
                        $("#TaskStoryPoints_" + TaskID).focus();
                    }
                }
            }

            if ($("#TaskHrs_" + TaskID).val() != "") {

                 //Commented And Added By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes 

                //if ((isNaN($("#TaskHrs_" + TaskID).val()) == true)) {


                //    strmsg = '- Please Enter  only positive numeric value  For Work(Hrs)';
                //    errorMsg += "" + strmsg + "</br>";
                //    isValid = 1;
                //    checkFlag = 1;
                //    checkWorkHours = 0;
                //}

                //else if (($("#TaskHrs_" + TaskID).val() - 0) == 0) {

                //    strmsg = '- Please Enter only  Work(Hrs) greater than 0';
                //    errorMsg += "" + strmsg + "</br>";
                //    isValid = 1;
                //    checkFlag = 1;
                //    checkWorkHours = 0;
                //}

                //else if (parseFloat($("#TaskHrs_" + TaskID).val()) < 0 && $("#TaskHrs_" + TaskID).val() != '') {

                //    strmsg = '- Please enter positive Value For  Work(Hrs)';
                //    errorMsg += "" + strmsg + "</br>";
                //    isValid = 1;
                //    checkFlag = 1;
                //    $("#TaskHrs_" + TaskID).focus();
                //    checkWorkHours = 0;
                //}

                try {                    
                    var blnHMFormat = true;
                    var objHMEffort = document.getElementById("TaskHrs_" + TaskID);
                    var objVal = objHMEffort.value;
                    var objnewVal = objHMEffort.value;

                    objHMEffort.value = objHMEffort.value.replace(":", ".");
                    var isdigit = isNumeric(objHMEffort.value);
                    objHMEffort.value = objVal;

                    if (isdigit == false) {
                        strmsg = ' - Please Enter only positive numeric value For Work(Hrs) in H:M format.';
                        errorMsg +=   strmsg + "</br>";
                        blnHMFormat = false;
                        isValid = 1;
                        checkFlag = 1;
                    }


                    if (objHMEffort.value.indexOf(":") == -1) {                       
                        objHMEffort.value = objnewVal + ':00';
                        objnewVal = objHMEffort.value;
                    }

                    if (objHMEffort.value.indexOf(":") != -1) {
                        objHMEffort.value = objHMEffort.value.replace(':', '.');
                    }

                    //var blnResult = disallowSpecialCharacters(objHMEffort, "Please enter efforts in valid format hh:mm!!");
                    var tempEffort = objHMEffort.value.replace('-', '');
                    if (checkSpecialCharacter(tempEffort) == true) {
                        // alertify.set('notifier', 'position', 'top-right');
                        strmsg = ' - Work(Hrs) cannot contain any of these {}|`~[]<>\!"@#$%^&*()_+-=/ Characters';
                        errorMsg += strmsg + "</br>";
                        //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                        objHMEffort.value = objVal;
                        isValid = 1;
                        checkFlag = 1;
                    } 
                    
                    if (blnHMFormat == true) {
                        if (RestrictNonNumeric(document.getElementById("TaskHrs_" + TaskID)) == true) {
                            strmsg = ' - Please enter Work(Hrs) in H:M format.';
                            errorMsg += strmsg + "";
                            objHMEffort.value = objVal;
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
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
                            strmsg = " - Please enter Work(Hrs) in H:M format.";
                            errorMsg += strmsg + "</br>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }

                        if ((hrs <= 0 && mins <= 0) || hrs.indexOf("-") != -1) {
                            strmsg = ' - Hours should not be less than or equal to zero (0).';
                            errorMsg += strmsg + "</br>";
                            blnHMFormat = false;
                            isValid = 1;
                            checkFlag = 1;
                        }
                        
                        if (blnHMFormat == true) {
                            if (mins.length > 2) {
                                strmsg = " - Please enter minutes in two decimal and less than 60.";
                                errorMsg += strmsg + "";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }
                        if (blnHMFormat == true) {
                            if (mins > 59 || mins < 0) {
                                strmsg = ' - Please enter minutes between (0-59) range';
                                errorMsg += strmsg + "</br>";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }
                    }                    

                    if ($("#EditStartDateAssigntask_" + TaskID).val() != "" && $("#EditEndDateAssigntask_" + TaskID).val() != "") {
                        if (checkWorkHours == 1) {

                            var data = JSON.stringify({ StartDate: $("#EditStartDateAssigntask_" + TaskID).val(), EndDate :  $("#EditEndDateAssigntask_" + TaskID).val() });
                            var cntDaysCountResult = AJAXCallWithResult("UserStoryDetails.aspx/getDateDiff", data, false);
                       
                            var dblTotalDuration = cntDaysCountResult.d;

                            //var dblTotalDuration = DateDiff($("#EditStartDateAssigntask_" + TaskID).val(), $("#EditEndDateAssigntask_" + TaskID).val(), "d") + 1;

                            data = JSON.stringify({ HMHours: WorkHour });
                            var decTotalWorkResult = AJAXCallWithResult("frmSprintPlanning.aspx/getDecimalHours", data, false);
                            var dblTotalWork = decTotalWorkResult.d;

                            dblAvgHoursPerDay = dblTotalWork / dblTotalDuration;

                            if (dblAvgHoursPerDay > 24) {

                                strmsg = ' - You cannot assign more than 24 hours work per day';
                                errorMsg += strmsg + "</br>";
                                blnHMFormat = false;
                                isValid = 1;
                                checkFlag = 1;
                            }
                        }
                    }
                   
                    var MinDAENtryDisplay = "";

                    var data = JSON.stringify({ Flag: "MinHoursForDAEntry" });
                    var resMinHoursForDAEntry = AJAXCallWithResult("frmProductBacklog.aspx/getCompanyDetails", data, false);

                    var MinDAEntry = resMinHoursForDAEntry.d;

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

                    var data = JSON.stringify({ Flag: "RestrictByMinHours" });
                    var resRestrictByMinHours = AJAXCallWithResult("frmProductBacklog.aspx/getCompanyDetails", data, false);

                    if (resRestrictByMinHours.d == 'True') {
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
                                        strmsg = ' - Please enter the work Hours in multiple of (' + MinDAENtryDisplay + ') min';
                                        errorMsg += strmsg + "</br>";
                                        isValid = 1;
                                        checkFlag = 1;
                                    }
                                }
                            }
                        }
                    }
                    if (checkFlag == 1) {
                        objHMEffort.value = objVal;
                    }
                    var chkhr = '';
                    var chkmin = '';

                  
                    if (objHMEffort.value.toString().indexOf(":") != -1) {
                        chkhr = objHMEffort.value.split(":")[0];
                        chkmin = objHMEffort.value.split(":")[1];
                    }
                    if(chkhr.length == 1)
                    {
                        chkhr = "0" + chkhr;
                        objHMEffort.value = chkhr + ":" + chkmin;
                    }
                   
                }
                catch (ex) {
                    //alert(ex.message);
                }

                 //End of Added By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes

            }
           //Commented By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes
            //if (checkWorkHours == 1) {
            //    //debugger;
            //    // get total seconds between the times
            //    var StartDate = new Date($("#EditStartDateAssigntask_" + TaskID).val());
            //    var EndDate = new Date($("#EditEndDateAssigntask_" + TaskID).val());
            //    var delta = Math.abs(EndDate - StartDate) / 1000;
            //    var days = (Math.floor(delta / 86400)) + 1;
            //    delta -= days * 86400;

            //    days = days * 24;
                               
            //    if ($("#TaskHrs_" + TaskID).val() > days) {
            //        strmsg = '- Work(Hrs) should not be greater than ' + days + ' Hours ';
            //        errorMsg += "" + strmsg + "</br>";
            //        isValid = 1;
            //        checkFlag = 1;
            //    }

            //}
             //End of Commented By Usha Pandit on 04-Apr-2019 Purpose::Project Work field level changes
            if (strmsg != "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error', 5);

            }
            return checkFlag;
            return isValid;
        }

        /*Maxlength*/
        var IsFlagcountdownFN = 0;
        var IsFlagcountdownAC = 0;
        var IsFlagcountdownSummary = 0;
        var IsFlagSubus = 0;
        var IsFlag = 0;
        var IsFlagTaskname = 0;
        var IsFlagcountcountTaskNote = 0;
        var IsFlagcountcountTaskName = 0;
        function limitText(limitField, limitCount, limitNum) {
            //debugger;

            var length;
            if (limitField.value.length > limitNum) {
                limitField.value = limitField.value.substring(0, limitNum);
            } else {
                if (limitField.value.length == 0) {
                    limitCount.innerHTML = (limitNum - limitField.value.length);
                }
                else {
                    limitCount.innerHTML = (limitNum - limitField.value.length);
                }


                if (limitCount.innerHTML != 0) {
                    IsFlagcountdownSummary = 0;
                    IsFlagcountdownFN = 0;
                    IsFlagcountdownAC = 0;
                    IsFlagSubus = 0;
                    IsFlag = 0;
                    IsFlagTaskname = 0;
                    IsFlagcountcountTaskNote = 0;
                    IsFlagcountcountTaskName = 0;
                }
            }
            //if (limitCount.innerHTML == -20) {
            //    limitCount.innerHTML = 0;

            //    IsFlagcountcountTaskName = 0;

            //}
            if (limitCount.innerHTML == 0) {

                if (limitCount.id == 'countTaskNote') {
                    if (IsFlagcountdownFN != 1) {
                        //document.getElementById("countTaskNote").style.color = 'red' //when Char 0 length  then Color red
                        // $('#spanBusinessValue').html("You Can Enter Only 1000 Character");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('You Can Enter Only 2000 Character', 'error', 5);
                        IsFlagcountdownFN = 1;
                        return IsFlagcountdownFN;
                    }
                }
                else if (limitCount.id == 'countTaskName') {
                    if (IsFlagTaskname != 1) {
                        //document.getElementById("countTaskName").style.color = 'red' //when Char 0 length  then Color red
                        //$('#spanBusinessValue').html("You Can Enter Only 200 Character");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('You Can Enter Only 255 Character', 'error', 5);
                        IsFlagTaskname = 1;
                        return IsFlagTaskname;
                    }
                }
                else if (limitCount.id == 'countTaskNameDetail') {
                    //document.getElementById("countTaskNameDetail").style.color = 'red' //when Char 0 length  then Color red
                    //$('#spanBusinessValue').html("You Can Enter Only 200 Character");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You Can Enter Only 255 Character', 'error', 5);
                }
                else if (limitCount.id == 'countTaskNoteDetail') {
                    //document.getElementById("countTaskNoteDetail").style.color = 'red' //when Char 0 length  then Color red
                    //$('#spanBusinessValue').html("You Can Enter Only 200 Character");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You Can Enter Only 2000 Character', 'error', 5);
                }

                else if (limitCount.id == 'viewcountTaskNote') {
                    //document.getElementById("viewcountTaskNote").style.color = 'red' //when Char 0 length  then Color red
                    //$('#spanBusinessValue').html("You Can Enter Only 200 Character");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You Can Enter Only 2000 Character', 'error', 5);
                }
                else if (limitCount.id == 'viewcountTaskName') {
                    //document.getElementById("viewcountTaskName").style.color = 'red' //when Char 0 length  then Color red
                    //$('#spanBusinessValue').html("You Can Enter Only 200 Character");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('You Can Enter Only 255 Character', 'error', 5);
                }


            }


            //     if (limitField.clientHeight < limitField.scrollHeight) {
            //     limitField.style.height = limitField.scrollHeight + "px";
            //     if (limitField.clientHeight < limitField.scrollHeight) {
            //         limitField.style.height =
            //           (limitField.scrollHeight * 2 - limitField.clientHeight) + "px";
            //     }
            // }

        }
        function getRows(TaskID) {
            //debugger;
            if ($("#TaskNotes_" + TaskID).val() != undefined) {
                var numberOfColumns = 70;
                var numberOfLines = 1;
                //numberOfColumns = document.getElementById("txtActionItems").cols;

                var eachLine = $("#TaskNotes_" + TaskID).val().split('\n');

                var lineheight = $("#TaskNotes_" + TaskID).val();

                numberOfLineBreaks = (lineheight.match(/\n/g) || []).length;
                characterCount = lineheight.length + numberOfLineBreaks;

                if (characterCount > numberOfColumns) {
                    numberOfLines = parseInt(characterCount / numberOfColumns);
                    var height = document.getElementById("TaskNotes_" + TaskID).rows = numberOfLines;
                    $("#TaskNotes_" + TaskID).attr("style", "height: auto !important;line-height: 1.5 !important;");
                }
            }
            if ($("#TaskName_" + TaskID).val() != undefined) {
                var numberOfColumns = 70;
                var numberOfLines = 1;
                //numberOfColumns = document.getElementById("txtActionItems").cols;
                var eachLine = $("#TaskName_" + TaskID).val().split('\n');
                var lineheight = $("#TaskName_" + TaskID).val();
                numberOfLineBreaks = (lineheight.match(/\n/g) || []).length;
                characterCount = lineheight.length + numberOfLineBreaks;
                //alert(document.getElementById("TaskNotes_" + TaskID).scrollHeight);
                if (characterCount > numberOfColumns) {
                    numberOfLines = parseInt(characterCount / numberOfColumns);
                    var height = document.getElementById("TaskName_" + TaskID).rows = numberOfLines;
                    $("#TaskName_" + TaskID).attr("style", "height: auto !important;line-height: 1.5 !important;");
                }
            }
        }
        $(".form-control").on("blur", function () {
            //debugger;
            if ($('#cboUSNew').val() == 0) {
                $('#cboUSNew').parent().removeClass("focused");
            }
        });
        function ClearSpan(txt, span) {
            // debugger;
            if ($('#' + txt).val() == "") {
            }
            else if ($('#cboUSNew').val() == 0) {
                $('#cboUSNew').parent().removeClass("focused");

            }

            else {
                $('#' + txt).css('border-color', '#d8dade');
                $('#' + txt).css('border-width', '1px');
                $('#' + span).text("");
            }

        }
    function OnClickEditTask(TaskID) {
       
            //debugger;
            $(".closetask").css("display", "inline-block");
            $("#cboSprintNew").css('pointer-events', 'none');
            var result = ajaxCall("frmTaskCreation.aspx/GetTaskDetails", "POST", "application/json", "json", JSON.stringify({ TaskID: TaskID }));

             
            if (result.d != '[]|') {
                var strArray = String(result.d).split("|")
                $.each(JSON.parse(strArray[0]), function (id, obj) {
                    //alert(obj.ScrumTaskDescription);
                    // debugger;
                    var UserStoryName = $('#cboUS option:selected').text();
                    $("#spanSprintName").text(obj.IterationName);
                    $("#spanUserStoryName").text(obj.UserStoryName);
                    $("#spanRealeaseName").text((obj.ReleaseName == null ? "-" : obj.ReleaseName))
                    $("#cboSprintName_0").empty();
                    $("#cboUSName_0").empty();
                    $("#EditcboUS").empty();
                    $("#cboSprintName_0").append("<option value='" + obj.IterationID + "'>" + obj.IterationName + "</option>")
                    $("#cboUSName_0").append("<option value='" + obj.UserStoryID + "'>" + obj.UserStoryName + "</option>")
                    $("#EditcboUS").append("<option value='" + obj.UserStoryID + "'>" + obj.UserStoryName + "</option>")
                    $("#TaskName_0").val("" + obj.ScrumTaskName + "");

                    $("#cboAssignResources_0 option:selected").val(obj.AssignedToEmpID);
                    $("#cboAssignResources_0 option:selected").text(obj.AssignedTo);
                    document.getElementById("EmployeePhoto").src = "../../Images/Photo/" + obj.SystemFilename + "";
                    document.getElementById("EmployeePhoto").setAttribute("title", "" + obj.EmployeeName + "");
                    $('[data-bs-toggle="tooltip"]').tooltip();
                    $("#spanEmployeeName").text(obj.EmployeeName)

                    $("#spanPlannedEffort").text(obj.Effort);
                    $("#spanActualEffort").text(obj.Actual);


                    document.getElementById("ActualEffortProgress").style.width = "" + (obj.TaskCompletionPercentage == null ? 0 : obj.TaskCompletionPercentage) + "%"
                    document.getElementById("ActualEffortProgress").style.backgroundColor = "" + (obj.Actual > obj.Effort ? "#d9534f" : "#5cb85c") + ""


                    $("#TaskNotes_0").val("" + (obj.ScrumTaskDescription == null ? "" : obj.ScrumTaskDescription) + "")

                    $("#TaskHrs_0").val("" + obj.Effort + "")
                    $("#EditStartDateAssigntask_0").val("" + ParseDate(obj.StartDate) + "")
                    $("#EditEndDateAssigntask_0").val("" + ParseDate(obj.EndDate) + "")
                    $("#TaskStoryPoints_0").val("" + (obj.StoryPoint == null ? "" : obj.StoryPoint) + "")
                    $("#EditcboTaskType_0").val("" + obj.EntityTypeID + "")
                    $("#EditcboPriority_0 option:selected").val("" + obj.PriorityID + "")
                    $("#EditcboPriority_0 option:selected").text("" + obj.Priority + "");
                    if (obj.TaskOnHold == 1) {
                        document.getElementById("EditchkHold_0").checked = true;
                    }
                    else {
                        document.getElementById("EditchkHold_0").checked = false;
                    }
                    if (obj.BillableYN == 1) {
                        document.getElementById("EditchkBillable_0").checked = true;
                    }
                    else {
                        document.getElementById("EditchkBillable_0").checked = false;
                    }
                    if (obj.IsActive == 'Void') {

                        //document.getElementById("Update_0").setAttribute("data-bs-toggle", "tooltip")
                        document.getElementById("Update_0").setAttribute("title", "Task is In Active you cannot update Task")
                    }
                    else {
                        document.getElementById("Update_0").setAttribute("onclick", "SaveTask(0,'Update'," + obj.TaskID + ")");
                    }
                    $("#countTaskNameDetail").text((255 - (obj.ScrumTaskName == null ? 0 : ((obj.ScrumTaskName).length))));
                    $("#countTaskNoteDetail").text((2000 - (obj.ScrumTaskDescription == null ? 0 : ((obj.ScrumTaskDescription).length))));

                    $("#spanTaskName").text(obj.ScrumTaskName);
                    $("#taskname").text(obj.ScrumTaskName);
                    //debugger;
                    $("#spanPlanDate").text("Planned Start Date:" + ParseDate(obj.StartDate) + " and End Date:" + ParseDate(obj.EndDate) + " ");
                    $("#spanActualDate").text("Actual Start Date:" + (obj.ActualStartDate == null ? "-" : ParseDate(obj.ActualStartDate)) + " and End Date:" + (obj.ActualEndDate == null ? "-" : ParseDate(obj.ActualEndDate)) + " ");
                    BindOverallTask(obj.AssignedToEmpID);

                    getRows(0);
                    //debugger;
                    //$("#TaskNotes_0").append();
                    //if ($(".form-control").val() != "") {
                    //    $(this).parent().addClass("focused");

                    //}
                    //else if ($(".form-control").val() == "") {
                    //    $(this).parent().removeClass("focused");
                    //}
                    $(".taskdropdown").tooltip();
                    $.each($('.createtask  .form-control'), function () {
                        if ($(this).val() != "") {
                            $(this).parent().addClass("focused");
                            // alert('empty');
                        }
                        else {
                            $(this).parent().removeClass("focused");
                        }
                    });
                    $(".overalltask").each(function (i) {
                        var len = $(this).text().length;
                        if (len > 35) {
                            $(this).text($(this).text().substr(0, 35) + '..');
                        }
                    });
                });
            }
            // debugger;
            $("#TaskName").focus();
            $(".task").hide();
            $(".createtask").show();
            $(".searchsprint").hide();
            $(".accordian").hide();
            // $("body").removeClass("overflow");
        }

        function BindOverallTask(Assignedto) {
            //alert(Assignedto)
         
            var ActualEffortPercentage = 0;
            var iterationID = $('#cboSprintName_0 option:selected').val();
            var result = ajaxCall("frmTaskCreation.aspx/GetOverallTaskDetails", "POST", "application/json", "json",
                              JSON.stringify({ iterationID: iterationID, Assignedto: Assignedto }));
            if (result.d != '[]|') {
                var strArray = String(result.d).split("|")
                $.each(JSON.parse(strArray[0]), function (id, obj) {
                   
                    new Chart(document.getElementById("doughnut-chart"), {
                        type: 'doughnut',
                        data: {
                            labels: ["Completed", "In Progress", "To Do List"],
                            datasets: [
                              {
                                  label: "Status",
                                  backgroundColor: ["#4cae4c", "#eea236", "#337ab7"],
                                  data: [obj.CompletedTaskCount, obj.InProgressTaskCount, obj.ToDoTaskCount]
                              }
                            ]
                        },
                        options: {
                            title: {
                                display: true,
                                text: 'Task Completion',

                            },
                            legend: {
                                display: true,
                                position: "bottom",
                            }
                        },
                    });

                    ActualEffortPercentage = (obj.TotalActualEffort / obj.TotalPlannedEffort) * 100;
                    $("#spanTotalPlannedEffort").text(obj.TotalPlannedEffort);
                    $("#spanTotalActualEffort").text(obj.TotalActualEffort);

                    $("#spanTotalTask").text(obj.TotalTask);
                    $("#spanCompletedTask").text(obj.CompletedTask);
                    $("#spanOpenTask").text(obj.OpenTask);
                    $("#spanTotalIssueTask").text(obj.IssueTaskTotal);
                    $("#spanClosedTask").text(obj.CompletedTask);
                    //var ProgressbarVal ="<div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='50' aria-valuemin='0' aria-valuemax='100' style='width:50%'>"
                    //$("#OverallActualEffort").remove();
                    $("#OverallActualEffort").attr("aria-valuenow", "" + ActualEffortPercentage + "");
                    $("#OverallActualEffort").attr("style", "width:" + ActualEffortPercentage + "%")

                });
            }
            /*Added By Yasmin On 20-3-19*/
            var showChar = 20;  // How many characters are shown by default
            var ellipsestext = "...";
            var moretext = "Show more >";
            var lesstext = "Show less";


            $('.more').each(function () {
                var content = $(this).html();

                if (content.length > showChar) {

                    var c = content.substr(0, showChar);
                    var h = content.substr(showChar, content.length - showChar);

                    var html = c + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink">' + moretext + '</a></span>';

                    $(this).html(html);
                }

            });

            $(".morelink").click(function () {
                if ($(this).hasClass("less")) {
                    $(this).removeClass("less");
                    $(this).html(moretext);
                } else {
                    $(this).addClass("less");
                    $(this).html(lesstext);
                }
                $(this).parent().prev().toggle();
                $(this).prev().toggle();
                return false;
            });
            //$("#search_table").on("keyup", function () {
            //    debugger;
            //    var value = $(this).val().toLowerCase();
            //    $("#tbodyTaskList tr").filter(function () {
            //        debugger;
            //        $("#tbodyTaskList tr").toggle($("#tbodyTaskList tr").text().toLowerCase().indexOf(value) > -1);
            //        $(".collapse").hide();
            //    });
            //});
            $('.form-control').on('focus blur', function (e) {
                $(this).parents('.form-group').toggleClass('focused', (e.type === 'focus' || this.value.length > 0));
            }).trigger('blur');

            //var $rows = $('#tbodyTaskList tr');
            //$('.go').click(function () {
            //    var val = $.trim($('#search_table').val()).replace(/ +/g, ' ').toLowerCase();
            //    $rows.show().filter(function () {
            //        var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
            //        return !~text.indexOf(val);
            //    }).hide();
            //});
        }
        //function AutoGrowTextArea(textField) {
        //    debugger;
        //    //alert(textField.clientHeight);
        //    //alert(textField.scrollHeight);
        //    if (textField.clientHeight < textField.scrollHeight) {
        //        textField.style.height = textField.scrollHeight + "px";
        //        if (textField.clientHeight < textField.scrollHeight) {
        //            textField.style.height =
        //              (textField.scrollHeight * 2 - textField.clientHeight) + "px";
        //        }
        //    }
        //}
        //function auto_grow(element) {
        //    debugger;
        //    element.style.height = "5px";
        //    element.style.height = (element.scrollHeight) + "px";
        //}
</script>

<script type="text/javascript">

    var windowheight = $(window).height();
    $('.table-responsive').css('height', windowheight - 200 + 'px');
    var formheight = $(window).height();
    $('.formheight').css('height', formheight - 200 + 'px');
    $(".formheight").css("overflow-y", "auto");
    $(".EditData").css({ "height": formheight });
    //Task Detail script
    $(".createtask").hide();
    $(".edittask").click(function () {
        //debugger;
        $(".searchsprint").hide();
        $("#TaskName").focus();
        $(".task").hide();
        $(".accordian").hide();
        $(".createtask").show();
        // $("body").removeClass("overflow");
    });



    //$(".Edit").click(function () {
    //    //debugger;
    //    $("#TaskName").focus();
    //    $(".task").hide();
    //    $(".createtask").show();
    //    $(".searchsprint").hide();
    //    $(".accordian").hide();
    //    // $("body").removeClass("overflow");
    //});
    $(".view").click(function () {
        $("#ViewtxtTaskName").focus();
    });
    $(".closetask").click(function () {
        $(".searchsprint").show();
        $(".task").show();
        $(".createtask").hide();
        $(".collapse").removeClass("in");
        $(this).css("display", "none");
        $("#cboSprintNew").css('pointer-events', 'unset');
    });

    $(".create").click(function () {
        clearModalPopup();
        $(".createtaskforuser").show();
        $("#AssigntxtTaskName").focus();
        $(".modal").css({ "overflow-x": "hidden", "overflow-y": "auto" });
    });


    $(".hidetask").click(function () {
        $(".createtaskforuser").hide();
    });
    $(".searchbox").focus(function () {
        $(".searchbox").css("border-bottom", "1px solid #ddd");
    });
    $(".btn").click(function () {
        $(".btn").css("outline", "none");
    });

    $('#EditStartDateAssigntask_0').datepicker({
        dateFormat: "mm/dd/yy",
        changeMonth: true,
        changeYear: true,
        yearRange: '1900:2020'
    });
    $('#EditEndDateAssigntask_0').datepicker({
        dateFormat: "mm/dd/yy",
        changeMonth: true,
        changeYear: true,
        yearRange: '1900:2020'
    });
    var date_input = $('input[name="StartDateAssigntask"]'); //our date input has the name "date"

    var options = {

        dateFormat: "mm/dd/yy",
        changeMonth: true,
        changeYear: true,
        yearRange: '1900:2020',
        onSelect: function () {
            // The "this" keyword refers to the input (in this case: #someinput)
            this.focus();
        }

    };
    date_input.datepicker(options).focus();

    //End task
    var enddate = $('input[name="EndDateAssigntask"]'); //our date input has the name "date"

    var options = {
        dateFormat: "mm/dd/yy",
        changeMonth: true,
        changeYear: true,
        yearRange: '1900:2020',
        onSelect: function () {
            // The "this" keyword refers to the input (in this case: #someinput)
            this.focus();
        }
    };
    enddate.datepicker(options);
    $('.form-control').on('focus blur', function (e) {
        $(this).parents('.form-group').toggleClass('focused', (e.type === 'focus' || this.value.length > 0));
    }).trigger('blur');

    function Refresh() {
        //window.location.reload(true);
        setFrameLoader();
        BindTaskListTbody();
        //$(".closetask").click();
        $("#btnRefresh").blur();
        //$("#tbodyTaskList").load(window.location.href + " #tbodyTaskList");
        RemoveFrameLoader();
    }
    function CompairDates1(obj1, Obj2) {
        var date1 = obj1;
        var date2 = Obj2;
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




    $(document).ready(function () {
        //$("#tbodyTaskList.even tr:even").css("background-color", "gainsboro");
        //$("#tbodyTaskList.even tr:odd").css("background-color", "ghostwhite");
        $(".create").click(function () {
            $("#AssigntxtTaskName").focus();
        });
        $('textarea').each(function () {
            // this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
        }).on('input', function () {
            this.style.height = 'auto';
            this.style.height = (this.scrollHeight) + 'px';
        });
        //$("#tbodyTaskList tr").each(function () {
        //    debugger;
        //    if (!$("tr").hasClass('collapse')) {
        //        $("tr").css("background-color", "#000");
        //    }
        //    else {
        //        $("tr").css("background-color", "grey");
        //    }
        //});
        if ($('#cboUS').val() == 0) {
            $('#cboUS').parent().removeClass("focused");
        }
         if ($('#cboStatus').val() == 0) {
            $('#cboStatus').parent().removeClass("focused");
        }
        $(".form-control").on("blur", function () {
            //debugger;
            if ($('#cboUS').val() == 0) {
                $('#cboUS').parent().removeClass("focused");
            }

            else if ($('#cboUSNew').val() == 0) {
                $('#cboUSNew').parent().removeClass("focused");
            }
           
        });
    });
    $(document).click(function () {
        $(".tooltip").removeClass("in").fadeIn(1000);;
    });
</script>
<script type="text/javascript">

    function searchTable() {


        var searchTerm = $("#search_table").val();
        var listItem = $('.results tbody').children('tr');
        var searchSplit = searchTerm.replace(/ /g, "'):containsi('")

        $.extend($.expr[':'], {
            'containsi': function (elem, i, match, array) {
                return (elem.textContent || elem.innerText || '').toLowerCase().indexOf((match[3] || "").toLowerCase()) >= 0;
            }
        });

        $(".results tbody tr").not(":containsi('" + searchSplit + "')").each(function (e) {
            $(this).attr('visible', 'false');
        });

        $(".results tbody tr:containsi('" + searchSplit + "')").each(function (e) {
            $(this).attr('visible', 'true');
        });

        var jobCount = $('.results tbody tr[visible="true"]').length;
        $('.counter').text(jobCount + ' item');

        if (jobCount == '0') { $('.no-result').show(); }
        else { $('.no-result').hide(); }


    }


    function ajaxCall(url, type, contentType, dataType, data) {
        var ajaxResult;
        $.ajax({
            url: url,
            type: type,
            contentType: contentType,
            dataType: dataType,
            data: data,
            async: false,
            success: function (result) {
                ajaxResult = result;
            },
            error: function (xhr) {
                console.log(xhr);
            }
        })

        return ajaxResult;
    }
    var AjaxResult;
    function AJAXCallWithResult(url, data, async) {
        $.ajax({
            type: "POST",
            url: url,
            data: data,
            dataType: "json",
            contentType: "application/json",
            //timeout: 180000,
            async: async,
            success: function (result) {
                AjaxResult = result;
                $(".loadingoverlay", parent.document).css("display", "none");
                // Stop();
            },
            error: function (xhr, status, error) {
                //  Stop();
                //   StopAjaxLoader("body");
                $(".loadingoverlay", parent.document).css("display", "none");
                console.log(xhr.responseText);
                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
            }
        });

        return AjaxResult;
    }
    var strresult;
    function AJAXCallWithPara(url, data, method, para) {
        $.ajax({
            type: "POST",
            url: url,
            data: data,
            dataType: "json",
            contentType: "application/json",
            //timeout: 180000,
            success: function (strresult) {
                // AjaxResult = result;
                method(strresult, para);
                // $(".loadingoverlay", parent.document).css("display", "none");
                // Stop();
            },
            error: function (xhr, status, error) {
                // Stop();
                // StopAjaxLoader("body");
                // $(".loadingoverlay", parent.document).css("display", "none");
                console.log(xhr.responseText);
                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
            }
        });
        return strresult
    }

    //Added By Riddhesh Patil on 22/12/2022
    var WebConfigSpecialCharacters = '<%=ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
    //End of Added By Riddhesh Patil on 22/12/2022


    //Added By Riddhesh Patil on 22/12/2022
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
		//End of Added By Riddhesh Patil on 22/12/2022

</script>
</html>
