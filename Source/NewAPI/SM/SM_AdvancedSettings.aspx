<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SM_AdvancedSettings.aspx.vb" Inherits="PbNIT.SM_AdvancedSettings" %>

<!DOCTYPE html>
<html>
            <!-- Commented by Param for JQuery and Bootstrap version upgrade -->
        <%CommonFunctions.General.PlotPageHeadTag("Advanced settings")%> 
	<head>
		<%--<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>Advanced settings</title>
		<!-- Tell the browser to be responsive to screen width -->

		<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
		<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
        <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    --%>  <%--  <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-select-1.13.18.min.css" />--%>
<%--		<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=2">
		<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/whiz.min.css?v=2">
		<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/font.css">--%>
<%--		<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/animate.css?v=2">--%>
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/dataTables.bootstrap5.min.css" />
		<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom.css?v=3">
		<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/style_custom_project.css?v=3.1">
		<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/adavanced_filter.css?v=0.1">
<%--		<link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />--%>
        <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" />   



      
	</head>
	  <style type="text/css">
		h5.pgtitle {
		margin: 6px 0 0;
		font-weight: 700;
		color: #4263c1;
		font-size: 16px;
		}
		.panel-heading {font-weight: 600;}
		.panel-default>.panel-heading{ background:#e7edf0;}
		.p-0{ padding:0!important;}    
		div.dataTables_wrapper div.dataTables_info{ float:left;}
		.dataTables_paginate{ margin-top:5px!important;}
		.table-fixed-header tbody tr th.text-right, .table tbody tr td.text-right, .table thead tr th.text-right {
		text-align: right!important;
		}
		.panel-body {
		padding: 10px;
		}
		.settings-para p{margin-bottom:0;}
		input[type="color"] {
		width:100%;
		cursor:pointer;
		background: #fff;
		border: none;
		padding: 0;
		}	
		#slider, #Warningslider1, #slider2, #slider3 {
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
		margin: 0.4em 0;
		}
		#slider:focus, #Warningslider1:focus, #slider2:focus, #slider3:focus {
		outline: none;
		}
		#slider::-webkit-slider-runnable-track, #Warningslider1::-webkit-slider-runnable-track, #slider2::-webkit-slider-runnable-track, #slider3::-webkit-slider-runnable-track {
		background-color: #e29214;
		height: 0.2em;
		margin: 0.4em 0;
		border-radius: 2px;
		}
		#slider::-moz-range-track, #Warningslider1::-moz-range-track, #slider2::-moz-range-track, #slider3::-moz-range-track {
		background-color: #e29214;
		height: 0.2em;
		border-radius: 2px;
		}
		#slider::-moz-focus-outer, #Warningslider1::-moz-focus-outer, #slider2::-moz-focus-outer, #slider3::-moz-focus-outer {
		border: 0;
		}
		#slider::-ms-track, #Warningslider1::-ms-track, #slider2::-ms-track, #slider3::-ms-track {
		background-color: #e29214;
		height: 0.2em;
		margin: 0.1em 0;
		border-radius: 2px;
		}
		#slider::-webkit-slider-thumb, #Warningslider1::-webkit-slider-thumb, #slider2::-webkit-slider-thumb, #slider3::-webkit-slider-thumb {
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
		background-color: #e29214;
		text-align: center;
		width: 1.2em;
		height: 1.2em;
		border: 1px solid #ccc;
		border-radius: 50%;
		cursor: pointer;
		box-sizing: border-box;
		margin-top: -0.5em;
		}
		#slider::-moz-range-thumb, #Warningslider1::-moz-range-thumb, #slider2::-moz-range-thumb, #slider3::-moz-range-thumb {
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance: none;
		background-color: #fff;
		text-align: center;
		width: 1.2em;
		height: 1.2em;
		border: 1px solid #ccc;
		border-radius: 50%;
		cursor: pointer;
		box-sizing: border-box;
		}
		#slider::-ms-thumb, #Warningslider1::-ms-thumb, #slider2::-ms-thumb, #slider3::-ms-thumb {
		margin: 0;
		}
		@media screen and (min-width: 767px){
			.range{display:flex;}
			.trackRange{display:flex; align-items:center;}
		}
		@media screen and (max-width: 767px){
			input[type="color"] {
				width: 50px;
			}
		}

    .amber {
        padding: 9px 9px 9px 9px;
        height: 21px;
        width:21px;
         margin-top: 17px;
        display: block;
        /*margin: auto;*/
        background: #f4cd0f;
        margin-left: 6px;

    }

    .green {
        padding: 9px 9px 9px 9px;
        height: 21px;
        width:21px;
         margin-top: 17px;
        display: block;
        /*margin: auto;*/
        background: #9dd824;
         margin-top: 17px;
           margin-left: 6px;
    }


    .red {
       padding: 9px 9px 9px 9px;
        height: 21px;
        width:21px;
         margin-top: 17px;
        display: block;
        /*margin: auto;*/
        background: #eb1c24;
          margin-left: 6px;
    }
    .green:active, .green:hover{background-color: #9dd824!important;}
    .red:active, .red:hover{background-color: #eb1c24!important;}
    .amber:active, .amber:hover{background-color: #f4cd0f!important;}
    td.text-right input{margin-left:auto}
    /* Added By Gauri On 29th Aug 2024 For Alignment Issue */
    .panel-default > .panel-heading {
        color: #333;
        font-weight: 500;
        padding: 10px 15px;
    }
    /* End of Added By Gauri On 29th Aug 2024 For Alignment Issue */
	</style>
	<body class="hold-transition skin-blue-light sidebar-mini fixed settings-para" id="BodyAdvancedsetting">
		<div class="bgwhite">
			<div class="pt-1 pb-1 graybg">
				<div class="col-sm-12">
					<h5 class="pgtitle pull-left"> <%= MyBase.GetResourceString("C_PAGECAPTION") %></h5>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="content pt-1">
				<div class="panel panel-default p-0">
					<div class="panel-heading"> <%= MyBase.GetResourceString("C_RESOURCE_ALLOCATION") %></div>
					<div class="container-fluid pt-1 text-right">
                        <%If m_blnAddAccess = True Or m_blnEditAccess = True Then %>
                        <button type="button" class="btn btnyellow mr-5" id="btnResourceAllocation" onclick="SaveResourceAllocationLevel()">Save</button>
                        <%End If %>
						
					</div>
					<div class="panel-body">
						<div id="settingsDetails" class="tab-pane active">
							<div class="row">
								<div class="col-sm-6 col-md-4 form-group">
									<label class="">&nbsp;</label>
									<div class="custom_chckbox">
                                         <% CommonFunctions.HTMLControls.DrawCheckBox("chkworkflowCheck", "chkworkflowCheck", "chcktbl",,,, "onchange='GetResourceWF()'") %>
										<label for="chkworkflowCheck"><%= MyBase.GetResourceString("C_WF_ENABLED") %></label>
									</div>
								</div>
								<div class="col-sm-6 col-md-3 form-group">
									<label><%= MyBase.GetResourceString("C_RESOURCE_LEVEL") %></label>
                                     <% CommonFunctions.HTMLControls.DrawComboBox("CboResourceAllocationLevel", "usp_whizible2_Sel_tbl_PM_ResourceAllocationLevel",,, "class='form-control'",,, ) %>
                               
								</div>
							</div>
							<div class="row">
								<div class="col-sm-12 form-group">
									<label class="">&nbsp;</label>
									<div class="custom_chckbox">
                                          <% CommonFunctions.HTMLControls.DrawCheckBox("chkexcellenceModel", "chkexcellenceModel", "chcktbl",,,, "") %>
										<label for="chkexcellenceModel"> <%= MyBase.GetResourceString("C_FOLLOW_CENTER") %> </label>
									</div>
									<p> <%= MyBase.GetResourceString("C_RESOURCE_NOTE") %></p>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="panel panel-default p-0">
					<div class="panel-heading"><%= MyBase.GetResourceString("C_RESOURCE_PER") %></div>
					<div class="container-fluid pt-1 text-right">
                        <%If m_blnAddAccess = True Or m_blnEditAccess = True Then %>
						<button class="btn btnyellow mr-5" id="btnResourceAllocationValue" onclick="ResourceAllocationValue()">Save</button>
                        <%End If %>
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-sm-8 col-md-4 form-group">
								<label><%= MyBase.GetResourceString("C_RESOURCE_EXTEND_UPTO") %></label>
								<div style="display:flex">
                                   <%-- <input type="text" class="form-control" maxlength="3" value="999"></input>--%>
                                    <%--Commented and Added By Riddhesh Patil on 11-Apr-2022--%>
                                   
                                     <%--<% CommonFunctions.HTMLControls.DrawTextBox("txtResourceAllocationValue", "txtResourceAllocationValue", "form-control", , 3,,,,,,,, " autocomplete='off'",,, True,,,, True) %>--%>
                                     <% CommonFunctions.HTMLControls.DrawTextBox("txtResourceAllocationValue", "txtResourceAllocationValue", "form-control", , 3,,,,,,,, "onkeypress='return Field_OnKeyPress(event)' autocomplete='off'",,, True,,,, True) %>
                        
                                   <%--End of Commenteed and Added By Riddhesh Patil on 11-Apr-2022      --%>        
									<span style="width:190px;">&nbsp;(e.g. 100,120,140)</span>
								</div>
								<p><%= MyBase.GetResourceString("C_RESOURCE_PER_NOTE") %></p>
							</div>
						</div>
					</div>
				</div>
			<div class="panel panel-default p-0">
					<div class="panel-heading"> <%= MyBase.GetResourceString("C_WEIGHTED_AVG") %></div>
					<div class="container-fluid pt-1 text-right">
                          <%If m_blnAddAccess = True Or m_blnEditAccess = True Then %>
						<button class="btn btnyellow mr-5" id="WeightAvarage" onclick="SaveDetails()">Save</button>
                        <%End If %>
					</div>
					<div class="panel-body">
					<div class="table-responsive">
						<table id="settingsTbl" class="table table-bordered settingsTbl" style="width:100%;">
							<thead>
								<tr>
									<th width="100" align="center" colspan="2"><%= MyBase.GetResourceString("C_WEIGHTED_AVG") %></th>
									<th class="text-left" colspan="6"><%= MyBase.GetResourceString("C_RNAGE_THRESHOLD") %> </th>
								</tr>
								<tr>
									<th width="30" class="text-left"><%= MyBase.GetResourceString("C_ITEMS") %></th>
									<th width="50" class="text-right">%</th>
									<th width="100" class="text-left" colspan="2"><%= MyBase.GetResourceString("C_ON_TRACK") %> </th>
									<th width="100" class="text-left" colspan="2"><%= MyBase.GetResourceString("C_WARNING") %> </th>
									<th width="100" class="text-left" colspan="2"> <%= MyBase.GetResourceString("C_OFF_TRACK") %></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-left"> <%= MyBase.GetResourceString("C_COST") %></td>
									<td class="text-right">
                                         <% CommonFunctions.HTMLControls.DrawTextBox("txtcostValue", "txtcostValue", "form-control text-end", 80,,,,,,,,, "onPaste='return false' onkeypress='return restrictAlphabets(event, &quot;txtcostValue&quot;)'; WT='1';autocomplete='off'; onblur='calculateSum()'",,, True,,,, True) %>
									</td>
									<td class="text-left" width="130">
										<span class="trackRange">
											<span id="TotalSpanCostGreen">>=0 && <=</span>&nbsp;&nbsp;
											<form>
												<div class="range">
                                                 <% CommonFunctions.HTMLControls.DrawTextBox("txtamount", "txtamount", "range__amount form-control", 50, 3,,,,,,,, "onPaste='return false' onkeypress='return restrictAlphabets(event, &quot;txtamount&quot;);' max='100' autocomplete='off' onblur=SetValue('ontrack')",,, True,,,, True) %>
									           	<%--<input class="range__amount" id="amount" oninput="slider.value=amount.value" type="text" max="100" value="0" maxlength="3" style="width:35px;"></input>--%>&nbsp;&nbsp;
													<input class="range__slider" id="slider" max="100" min="0" oninput="txtamount.value=slider.value" type="range" value="0" onChange="SetValue('ontrack')"></input>
												</div>
											</form>
										</span>
									</td>
									<td class="text-left" width="50">
										<%--<input type="color" value="#59c337" id="colorPicker1"></input>--%>
                                        <button class="btn green"> </button>
									</td>
									<td class="text-left" width="130">
										<span class="trackRange">
											<span id="TotalSpanCostWarningAmber"><span id="SpanCostWarningAmount"></span> && <=</span>&nbsp;&nbsp;
											<form>
												<div class="range">
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtWarningamount", "txtWarningamount", "range__amount form-control", 50, 3,,,,,,,, "onPaste='return false' onkeypress='return restrictAlphabets(event, &quot;txtWarningamount&quot;)' max='100' autocomplete='off'; onblur=SetValue('CostWarning')",,, True,,,, True) %>
									           
													<%--<input class="range__amount" id="amount1" oninput="Warningslider1.value=amount1.value" type="text" max="100" value="0" maxlength="3" style="width:35px;"></input>--%>
                                                    &nbsp;&nbsp;
													<input class="range__slider" id="Warningslider1" max="100" min="0" oninput="txtWarningamount.value=Warningslider1.value" type="range" value="0"  onChange="SetValue('CostWarning')"></input>
												</div>
											</form>
										</span>
									</td>
									<td class="text-left" width="50">
                                        <%--<input type="color" value="#f1bd29" id="colorPicker2"></input>--%>
                                         <button class="btn amber"> </button>

									</td>
									<%--<td class="text-left" width="100">>80</td>--%>
                                    <td class="text-left" width="100"><span id="TotalSpanCostOffTrackRed">><span id="SpanCostOffTrack"></span></span> </td>
									<td class="text-left" width="50">
                                        <%--<input type="color" value="#f91a43" id="colorPicker3"></input>--%>
                                          <button class="btn red"> </button>

									</td>
								</tr>
								<tr>
									<td class="text-left">Schedule</td>
									<td class="text-right">
                                        <%--<input id="scheduleValue" type="text" value="30" style="width:35px;"></input>--%>
                                           <% CommonFunctions.HTMLControls.DrawTextBox("txtscheduleValue", "txtscheduleValue", "form-control text-end", 80,,,,,,,,, "onPaste='return false' onkeypress='return restrictAlphabets(event, &quot;txtscheduleValue&quot;)' WT='1' autocomplete='off' onblur='calculateSum()'",,, True,,,, True) %>

									</td>
									<td class="text-left"><span id="TotalSpanscheduleGreen">>=0</span></td>
									<td class="text-left">
										<%--<input type="color" value="#59c337" id="colorPicker4"></input>--%>
                                          <button class="btn green"> </button>
									</td>
									<td class="text-left" width="100">
									<span class="trackRange">
											<span id="TotalSpanscheduleWarningAmber"><0 && >= </span>&nbsp;&nbsp;&nbsp;&nbsp;
											<form>
												<div class="range">
                                                     <% CommonFunctions.HTMLControls.DrawTextBox("txtScheduleamount2", "txtScheduleamount2", "range__amount form-control", 50, 3,,,,,,,, "onPaste='return false';   onkeypress='return allowNegativeNumber(event)';  max='0'; autocomplete='off'; onblur=SetValue('Schedule')",,, True,,,, True) %>
									           
													<%--<input class="range__amount" id="amount2" oninput="slider2.value=amount2.value" type="text" max="0" value="0" maxlength="3" style="width:35px;" step="-1"></input>--%>&nbsp;&nbsp;
													<input class="range__slider" id="slider2" max="0" min="-100" oninput="txtScheduleamount2.value=slider2.value" type="range" value="0" step="-1"  onChange="SetValue('Schedule')"></input>
												</div>
											</form>
										</span></td>
									<td class="text-left" width="50">
                                        <%--<input type="color" value="#f1bd29" id="colorPicker5"></input>--%>
                                         <button class="btn amber"> </button>

									</td>
									<td class="text-left" width="100"><span id="TotalSpanscheduleOffTrackRed">< <span id="SpanscheduleOffTrackRed"></span></span></td>
									<td class="text-left" width="50">
                                        <%--<input type="color" value="#f91a43" id="colorPicker6"></input>--%>
                                         <button class="btn red"> </button>

									</td>
								</tr>
								<tr>
									<td class="text-left"> <%= MyBase.GetResourceString("C_EFFORT") %></td>
									<td class="text-right">
                                        <%--<input id="effortValue" type="text" value="20" style="width:35px;"></input>--%>
                                         <% CommonFunctions.HTMLControls.DrawTextBox("txteffortValue", "txteffortValue", "form-control text-end", 80,,,,,,,,, "onPaste='return false' onkeypress='return restrictAlphabets(event, &quot;txteffortValue&quot;)'; WT='1';autocomplete='off'; onblur='calculateSum()'",,, True,,,, True) %>


									</td>
									<td class="text-left"><span id="TotalSpanEffortsGreen"><=0</span></td>
									<td class="text-left">
										<%--<input type="color" value="#59c337" id="colorPicker7"></input>--%>
                                        <button class="btn green"> </button>
									</td>
									<td class="text-left" width="100">
										<span class="trackRange">
											<span id="TotalSpanEffortsWarningAmber">>0 && <= </span>&nbsp;&nbsp;&nbsp;&nbsp;
											<form>
												<div class="range">
                                                    <% CommonFunctions.HTMLControls.DrawTextBox("txtEffortamount3", "txtEffortamount3", "range__amount form-control", 50, 3,,,,,,,, "onPaste='return false' onkeypress='return restrictAlphabets(event, &quot;txtEffortamount3&quot;)'; max='100'; autocomplete='off'; onblur=SetValue('Efforts')",,, True,,,, True) %>
									           
													<%--<input class="range__amount" id="amount3" oninput="slider3.value=amount3.value" type="text" max="100" value="0" maxlength="3" style="width:35px;"></input>--%>&nbsp;&nbsp;
													<input class="range__slider" id="slider3" max="100" min="0" oninput="txtEffortamount3.value=slider3.value" type="range" value="0" onChange="SetValue('Efforts')"></input>
												</div>
											</form>
										</span>
										</td>
									<td class="text-left" width="50">
                                        <%--<input type="color" value="#f1bd29" id="colorPicker8"></input>--%>
                                           <button class="btn amber"> </button>

									</td>
									<td class="text-left" width="100"><span id="TotalSpanEffortsOffTrackRed">><span id="SpanEffortsOffTrackRed"></span></span></td>
									<td class="text-left" width="50">
                                        <%--<input type="color" value="#f91a43" id="colorPicker9">

                                        </input>--%>
                                           <button class="btn red"> </button>

									</td>
								</tr>
								<tr>
									<td style="text-align:right!important" colspan="2"><b>100</b></td>
								</tr>
							</tbody>
						</table>
					</div>
					</div>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>
		<!-- REQUIRED JS SCRIPTS -->

<%--        <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
        <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
     <%--   <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap-select-1.13.18.min.js"></script>--%>
<%--        <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
<%--        <script src="../../../Whizible2.0-new/dist/js/common_filters.js"></script>--%>
<%--        <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>--%>
        <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>
   <%--     <script src="../../../Whizible2.0-new/dist/js/custom.js"></script>--%>
     <%--   <script src="../../../Whizible2.0-new/dist/js/loadingoverlay.min.js"></script>
        <script src="../../../Whizible2.0-new/dist/js/loadingoverlay_progress.js"></script>--%>
        <%--<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> --%>

		<script>
			$("[data-toggle='tooltip'], [data-toggle='collapse'], [data-toggle='dropdown'], [data-toggle='modal']").tooltip();
		    var  strUrl = '<%=System.Configuration.ConfigurationManager.AppSettings("WebAPIUrl-II").ToString%>';
            $(document).ready(function () {
                GetResourcealloction();
                GetResourceWF();
               
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

      //Added By Dipali V On 11th Nov 2021
        function GetResourceWF() {
           
                if ($("#chkworkflowCheck").prop('checked')) {
                    $("#CboResourceAllocationLevel").removeAttr("disabled");
                    $("#chkexcellenceModel").removeAttr("disabled");
                } else {
                    $("#CboResourceAllocationLevel").attr("disabled", true);
                    $("#chkexcellenceModel").attr("disabled", true);


                }

            }

     //To Get Resource Allocation Level Details
      function GetResourcealloction() {

                StartLoader("#BodyAdvancedsetting")
          var param = { };
                var data = AJAXCallWithResult("/api/SM_AvancedSetting/GetResourceAllocationLevel", param, false);
                if (data != "") {
                   // debugger;
                    $("#CboResourceAllocationLevel").val(data[0].ResourceAllocationLevel);
                    $("#txtResourceAllocationValue").val(data[0].SValue);
                    var AllowResourceAllocation = data[0].AllowResourceAllocation;
                    var RESOURCEPOOLMANDATORY = data[0].RESOURCEPOOLMANDATORY;
                    $("#txtcostValue").val(data[0].COST);
                    $("#txtscheduleValue").val(data[0].Schedule);
                    $("#txteffortValue").val(data[0].Efforts);
                    if (AllowResourceAllocation == true) {
                        $("#chkworkflowCheck").prop('checked', true);
                    }
                    if (RESOURCEPOOLMANDATORY == true) {
                        $("#chkexcellenceModel").prop('checked', true);
                    }

                    var CostGreenCriteria_New = ""; CostAmberCriteria_New = "";
                    var CostGreenCriteria = data[0].CostGreenCriteria;
                   // alert(CostGreenCriteria)l
                  //  if (CostGreenCriteria.includes("&&")) {
                    const myArray = CostGreenCriteria.split("&&");
                    CostGreenCriteria_New = myArray[1].replace("<=", "");
                    if (CostGreenCriteria_New != "") {
                        $('#txtamount').val(CostGreenCriteria_New.trim());
                        $("#slider").val(CostGreenCriteria_New.trim());
                        $("#SpanCostWarningAmount").text(CostGreenCriteria_New);

                    }

                    var CostAmberCriteria = data[0].CostAmberCriteria;
                     const CostAmberCriteriaArray = CostAmberCriteria.split("&&");
                    CostAmberCriteria_New = CostAmberCriteriaArray[1].replace("<=", "");
                    $('#txtWarningamount').val(CostAmberCriteria_New.trim());
                    $("#Warningslider1").val(CostAmberCriteria_New.trim());
                    //$("#SpanCostWarningAmount").text(CostAmberCriteria_New);
                    $("#SpanCostOffTrack").text(CostAmberCriteria_New);
                    


                    var CostRedCriteria = data[0].CostRedCriteria;

                    var SchduleGreenCriteria = data[0].SchduleGreenCriteria; 
                    var SchduleAmberCriteria = data[0].SchduleAmberCriteria;
                   const CostSchduleAmberCriteria = SchduleAmberCriteria.split("&&");
                    CostSchduleAmberCriteria_New = CostSchduleAmberCriteria[1].replace(">=", "");
                    $("#txtScheduleamount2").val(CostSchduleAmberCriteria_New.trim());
                    $("#slider2").val(CostSchduleAmberCriteria_New.trim());
                    $("#SpanscheduleOffTrackRed").text(CostSchduleAmberCriteria_New);


                    var SchduleRedCriteria = data[0].SchduleRedCriteria;

                    var CostEffortsAmberCriteria_New = "";
                   var EffortsGreenCriteria =  data[0].EffortsGreenCriteria;
                    var EffortsAmberCriteria = data[0].EffortsAmberCriteria;
                    const CostEffortsAmberCriteria = EffortsAmberCriteria.split("&&");
                    CostEffortsAmberCriteria_New = CostEffortsAmberCriteria[1].replace("<=", "");
                    $("#txtEffortamount3").val(CostEffortsAmberCriteria_New.trim());
                    $("#slider3").val(CostEffortsAmberCriteria_New);
                    $("#SpanEffortsOffTrackRed").text(CostEffortsAmberCriteria_New);


                    var EffortsRedCriteria =  data[0].EffortsRedCriteria;
                }
               
                StopAjaxLoader("#BodyAdvancedsetting")
            }

     //To Validate Resource Allocation Level Details
      function validateResourceAllocationLevel() {
                var validate = 0;
                //debugger;
                if ($("#chkworkflowCheck").prop('checked') == true) {
                    if ($("#CboResourceAllocationLevel").val() == "0") {
                        validate = 1;
                        //setTimeout(function () {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%= MyBase.GetResourceString("A_RESOURCE_ALLOCATION_LEVEL") %>', 'error');

                        // }, 350);
                        $("#CboResourceAllocationLevel").focus();
                        //return;
                    }

                }


                return validate;
            }

      //To Saved Resource Allocation Level Details
      function SaveResourceAllocationLevel() {
               
                if (validateResourceAllocationLevel() == 0) {
                    var AllowResourceAllocation = "";
                    var ResourceAllocationLevel = "";
                    var ResourcePool = "";
                    var ResourceAllocationValue = "";

                    if ($("#chkworkflowCheck").prop('checked')) {
                        AllowResourceAllocation = 1;
                    } else {
                        AllowResourceAllocation = 0;
                    }


                    var ResourceAllocationLevel = $("#CboResourceAllocationLevel").val();

                    var ResourcePool = $("#chkexcellenceModel").val();
                    if ($("#chkexcellenceModel").prop('checked')) {
                        ResourcePool = 1;
                    } else {
                        ResourcePool = 0;
                    }

                     var UserName = '<%= Session("strUserName") %>';
                    var ResourceAllocationValue = $("#txtResourceAllocationValue").val();

                    var ResourceDetails = {
                        ResourceAllocationLevel: encodeURI(ResourceAllocationLevel),
                        AllowResourceAllocation: encodeURI(AllowResourceAllocation),
                        ResourceAllocationValue: encodeURI(ResourceAllocationValue),
                        ResourcePool: encodeURI(ResourcePool),
                        UserName:encodeURI(UserName)

                    }
                    var param = JSON.stringify(ResourceDetails);
                    var data = AJAXCallWithResult("/api/SM_AvancedSetting/InsertResourceAllocationLevel", param, false);
                    if (data != "") {
                        //alert(data);
                        setTimeout(function () {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify(data, 'success', 10);

                        }, 350);
                        GetResourcealloction();
                    }

                }
            }

      //To Saved Resource Allocation Percentage
      function ResourceAllocationValue() {
                if ($("#txtResourceAllocationValue").val() == "") {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('<%= MyBase.GetResourceString("A_RESOURCE_ALLOCATION_PER_NOT_LEFT") %>', 'error');
                    $("#txtResourceAllocationValue").focus();
                    return;
                } else {
                    var ResourceAllocationValue = $("#txtResourceAllocationValue").val();
                    var ResourcePool = "";
                    if ($("#chkexcellenceModel").prop('checked')) {
                        ResourcePool = 1;
                    } else {
                        ResourcePool = 0;
                    }
                    var UserName = '<%= Session("strUserName") %>';
                  //  alert(UserName);
                    var ResourceDetails = {
                        ResourceAllocationValue: encodeURI(ResourceAllocationValue),
                        ResourcePool: encodeURI(ResourcePool),
                         UserName: encodeURI(UserName)
                    }
                    var param = JSON.stringify(ResourceDetails);
                    var data = AJAXCallWithResult("/api/SM_AvancedSetting/InsertResourceAllocation", param, false);
                    if (data != "") {
                        //alert(data);
                        setTimeout(function () {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify(data, 'success', 10);

                        }, 350);
                        GetResourcealloction();
                    }

                }
            }

      //To Set Value   
      function SetValue(flag) {
                if (flag == 'ontrack') {
                    if ($("#txtamount").val() != "") {
                        $("#slider").val($("#txtamount").val());
                         $("#SpanCostWarningAmount").text("");
                         $("#SpanCostWarningAmount").text($("#txtamount").val());
                        
                    }
                }
                if (flag == 'CostWarning') {
                    if ($("#txtWarningamount").val() != "") {
                        $("#Warningslider1").val($("#txtWarningamount").val());
                        $("#SpanCostOffTrack").text("");
                        $("#SpanCostOffTrack").text($("#txtWarningamount").val());
                    }
                }

                if (flag == 'Schedule') {
                    if ($("#txtScheduleamount2").val() != "") {
                        $("#slider2").val($("#txtScheduleamount2").val());
                        $("#SpanscheduleOffTrackRed").text("");
                        $("#SpanscheduleOffTrackRed").text($("#txtScheduleamount2").val());
                    }
                }
                 if (flag == 'Efforts') {
                    if ($("#txtEffortamount3").val() != "") {
                        $("slider3").val($("#txtEffortamount3").val());
                        $("#SpanEffortsOffTrackRed").text("");
                        $("#SpanEffortsOffTrackRed").text($("#txtEffortamount3").val());
                    }
                }
                //

            }

      //To Restrict Alphabets   
      function restrictAlphabets(e, flag, curId) {
                //debugger;

                var x = e.which || e.keycode;

                if ((x >= 48 && x <= 57) || x == 8 ||
                    (x >= 35 && x <= 40) || x == 46)
                    return true;
                else
                    return false;
            }
      
     //To Save  Weighted Average
       function SaveWeightedAverage() {
              
         var Cost = $("#txtcostValue").val();
         var Schedule = $("#txtscheduleValue").val();
         var Efforts = $("#txteffortValue").val();
                var CostOnTrack = $("#TotalSpanCostGreen").text() + $("#txtamount").val();
                var ScheduletOnTrack = ">=0";
                var EffortsOnTrack = "<=0";


                var CostWarning = $("#TotalSpanCostWarningAmber").text() + $("#txtWarningamount").val();
                var ScheduleWarning = $("#TotalSpanscheduleWarningAmber").text() + $("#txtScheduleamount2").val();
                var EffortsWarning = $("#TotalSpanEffortsWarningAmber").text() + $("#txtEffortamount3").val();

                var CostOffTrack = $("#TotalSpanCostOffTrackRed").text() 
                var ScheduleOffTrack = $("#TotalSpanscheduleOffTrackRed").text();
                 var EffortsOffTrack = $("#TotalSpanEffortsOffTrackRed").text();
               
                var UserName = '<%= Session("strUserName") %>';
         
         var ResourceDetails = {
             Cost: encodeURI(Cost),
             Schedule: encodeURI(Schedule),
             Efforts: encodeURI(Efforts),

             CostOnTrack: encodeURI(CostOnTrack), 
             ScheduletOnTrack: encodeURI(ScheduletOnTrack), 
             EffortsOnTrack: encodeURI(EffortsOnTrack), 

             CostWarning: encodeURI(CostWarning), 
              ScheduleWarning:encodeURI(ScheduleWarning),
             EffortsWarning: encodeURI(EffortsWarning), 

             CostOffTrack: encodeURI(CostOffTrack), 
              ScheduleOffTrack:encodeURI(ScheduleOffTrack), 
             EffortsOffTrack: encodeURI(EffortsOffTrack), 
             UserName: encodeURI(UserName)

         }
         var param = JSON.stringify(ResourceDetails);
         var data = AJAXCallWithResult("/api/SM_AvancedSetting/SaveWeightedAverageDetails", param, false);
         if (data != "") {
                    //alert(data);
            setTimeout(function () {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(data, 'success', 10);

             }, 350);
             GetResourcealloction();
          }

        }

     
      //To Save Last Section
      function SaveDetails() {
           if (ValidatecalculateSum() == 0) {
               if (validateOnTrackWarningOfftrack() == 0) {
                   SaveWeightedAverage();
               }
           }
         }


     //Validate Sum fo Average Weight
     function ValidatecalculateSum() {
         var sum = 0;
         var IsValidate = 0;
         if ($("#txtcostValue").val() == "") {
             IsValidate = 1;
             setTimeout(function () {
                 alertify.set('notifier', 'position', 'top-right');
                 alertify.notify('<%= MyBase.GetResourceString("A_COST_LEFT") %>', 'error', 10);
             }, 350);
             $("#txtcostValue").focus();
         }

        else if ($("#txtscheduleValue").val() == "") {
              IsValidate = 1;
             setTimeout(function () {
                 alertify.set('notifier', 'position', 'top-right');
                 alertify.notify('<%= MyBase.GetResourceString("A_SCHDULE_LEFT") %>', 'error', 10);
             }, 350);
              $("#txtscheduleValue").focus();

         }

        else if ($("#txteffortValue").val() == "") {
             IsValidate = 1;
             setTimeout(function () {
                 alertify.set('notifier', 'position', 'top-right');
                 alertify.notify('<%= MyBase.GetResourceString("A_EFFOORTS_LEFT") %>', 'error', 10);
             }, 350);
             $("#txteffortValue").focus();
         }

         if (IsValidate == 0) {
             $('input[WT="1"]').each(function () {
                 if (!isNaN(this.value) && this.value.length != 0) {
                     sum += parseFloat(this.value);
                 }
             });

             if (sum != "") {
                 if (sum > 100)
                 {
                     IsValidate = 1;
                     setTimeout(function () {
                         alertify.set('notifier', 'position', 'top-right');
                        <%-- alertify.notify('Weighted Average <%= MyBase.GetResourceString("A_SUM_CSE_100") %>', 'error', 10);--%>
                          alertify.notify('Weighted Average Sum Should not be greater than 100', 'error', 10);
                     }, 350);
                 }
                 else if  (sum < 100)
                 {
                     IsValidate = 1;
                     setTimeout(function () {
                         alertify.set('notifier', 'position', 'top-right');
                         alertify.notify('Weighted Average Sum Should not be less than 100', 'error', 10);
                     }, 350);
                 }
             }
         }



         return IsValidate;
        
      }

     function calculateSum() {

     }
     // Validate On track
            function validateOnTrackWarningOfftrack() {
                //debugger;
                var IsValidate = 0;
                if ($("#txtamount").val() == "") {
                    IsValidate = 1;
                    setTimeout(function () {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%= MyBase.GetResourceString("A_COSTONTRACK_LEFT") %>', 'error', 10);
                    }, 350);
                    $("#txtamount").focus();

                }

                else if ($("#txtamount").val() <= 0) {
                    IsValidate = 1;
                    setTimeout(function () {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%= MyBase.GetResourceString("A_COSTONTRACK_POSITIVE") %>', 'error', 10);
                    }, 350);
                    $("#txtamount").focus();

                }



                else if ($("#txtamount").val() > 100) {
                    IsValidate = 1;
                    setTimeout(function () {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%= MyBase.GetResourceString("A_COSTONTRACK_NOT_100") %>', 'error', 10);
                    }, 350);
                    $("#txtamount").focus();

                }

                //Warning
                else if ($("#txtWarningamount").val() == "") {
                    IsValidate = 1;
                    setTimeout(function () {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%= MyBase.GetResourceString("A_COST_WARNING_LEFT") %>', 'error', 10);
                    }, 350);
                    $("#txtWarningamount").focus();

                }
               
               // else if ($("#txtWarningamount").val() != "")
               // {
                else if (parseInt($("#txtWarningamount").val()) < parseInt($("#txtamount").val())) {
                    IsValidate = 1;
                    setTimeout(function () {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%= MyBase.GetResourceString("A_COST_WARNING_GREATER_THAN_COST_ON_TRACK") %>', 'error', 10);
                    }, 350);
                    $("#txtWarningamount").focus();
                }
                //}
                else if ($("#txtWarningamount").val() > 100) {
                    IsValidate = 1;
                    setTimeout(function () {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%= MyBase.GetResourceString("A_COST_WARNING_NOT_LEFT") %>', 'error', 10);
                    }, 350);
                    $("#txtWarningamount").focus();

                }

                    //txtEffortamount3
                
                else if ($("#txtScheduleamount2").val() == "") {
                    IsValidate = 1;
                    setTimeout(function () {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%= MyBase.GetResourceString("A_SCHDULE_WARNING_LEFT_BLANK") %>', 'error', 10);
                    }, 350);
                    $("#txtScheduleamount2").focus();

                }

                else if ($("#txtScheduleamount2").val() > 0) {
                    IsValidate = 1;
                    setTimeout(function () {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%= MyBase.GetResourceString("A_SCHDULE_WARNING_NEGATIVE") %>', 'error', 10);
                    }, 350);
                    $("#txtScheduleamount2").focus();

                }

                else if ($("#txtEffortamount3").val() == "") {
                    IsValidate = 1;
                    setTimeout(function () {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%= MyBase.GetResourceString("A_EFFORTS_OFF_TRACK") %>', 'error', 10);
                    }, 350);
                    $("#txtEffortamount3").focus();

                }
                else if ($("#txtEffortamount3").val() <= 0) {
                    IsValidate = 1;
                    setTimeout(function () {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%= MyBase.GetResourceString("A_EFFORTS_OFF_TRACK_POSITIVE") %>', 'error', 10);
                    }, 350);
                    $("#txtEffortamount3").focus();

                }
                 else if ($("#txtEffortamount3").val() > 100) {
                    IsValidate = 1;
                    setTimeout(function () {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('<%= MyBase.GetResourceString("A_EFFORTS_OFF_NOT_100") %>', 'error', 10);
                    }, 350);
                    $("#txtEffortamount3").focus();

                }
                return IsValidate;    
            }

          
     var ajaxResult;
    function AJAXCallWithResult(url, param, async) {
            //StartLoader("#bodyIssueDetails");
            $.ajax({
                url: encodeURI(strUrl + url),
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
                    //StopAjaxLoader("#bodyIssueDetails");
                    ajaxResult = data;
                },
                error: function (err) {
                    ajaxResult = undefined;
                    //alert(err.responseText);
                    window.location.href = "../../General/ErrorPage.aspx?Mode=AJAXError&Error=" + err + ""
                    console.log(err);
                }
            });
            return ajaxResult;
        }


           
     function allowNegativeNumber(e) {
                var charCode = (e.which) ? e.which : event.keyCode
                if (charCode > 31 && (charCode < 45 || charCode > 57)) {
                    return false;
                }
                return true;

            }


            //Added By Riddhesh Patil on 11-Apr-2022
            var specialKeys = new Array();
            specialKeys.push(8);
            function Field_OnKeyPress(e, fieldId) {
                // debugger;
                // console.log(fieldId);
                var keyCode = e.which ? e.which : e.keyCode

                var flag = 0;
                var ret = ((keyCode >= 48 && keyCode <= 57) || specialKeys.indexOf(keyCode) != -1)
                {
                    if ((keyCode >= 48 && keyCode <= 57) == false || (specialKeys.indexOf(keyCode)) == false) {
                        // $("#txtResourceDemand").focus();
                        // $("#txtProbabilityCurrent").focus();
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Please enter only numeric values.");
                    }
                }
                return ret;
            }
        //End of Added By Riddhesh Patil on 11-Apr-2022

        </script>
	</body>
</html>