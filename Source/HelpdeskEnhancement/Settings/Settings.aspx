<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Settings.aspx.vb" Inherits="PbNIT.Settings" %>

<!DOCTYPE html>

<html lang="en">

<%CommonFunctions.General.PlotPageHeadTag("Admin Panel")%>
<head runat="server">    
	<!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />--%>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <%--<title>Admin Panel</title>
	 <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
	
    <link href="../../EnhancementFiles/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" />

    <link href="../../EnhancementFiles/css/editor.css" rel="stylesheet" />
    <link href="../../EnhancementFiles/css/style.css" rel="stylesheet" />
    <link href="../../EnhancementFiles/css/reqdetail.css" rel="stylesheet" />
    <link href="../../EnhancementFiles/css/setting.css" rel="stylesheet" />
    <link href="../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />
    <link href="../../EnhancementFiles/OnlineFiles/css/Jquery.ui.css" rel="stylesheet" />
    <link href="../../EnhancementFiles/css/timepicker.min.css" rel="stylesheet" />
	
</head>

	<style>
		/**********************Added By Bharat T on 16th-Oct-2017 for setting page ui changes***************************************/
		.content-wrapper {
		 margin-left: 0px !important;
		}
			div.table-responsive {
				height:270px;
				overflow:auto;
			}
	/**********************End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***************************************/

	</style>

<body>
    <input type="hidden" name="hdnTab" id="hdnTab" value="" />
    <input type="hidden" name="hdnSubTab" id="hdnSubTab" value="" />

    <form id="frmSettings" runat="server">
    <div id="MainDiv" style="overflow:auto;">

    <div class="content-wrapper">

      <div class="container-fluid">
		 <!---- HelpDesk---------------------->
<%--		 <div class="help-desk" data-spy="affix" data-offset-top="100">
							<div class="row">						
									<div class="req-dsk-kn new-req-head">									
									<div class="col-md-12">
									<ul>
										<li><h4 style="border: none;height: 32px;margin-top: -11px;font-size: 14px;font-weight: 600;">Setting  <i class="fa fa-cog" aria-hidden="true"></i></h4></li>										
										<li class="active"><a href="#">Requests</a></li>
										<li><a href="#">Dashboard</a></li>
										<li><a href="#">Knowledge</a></li>
										
										<!-- <li class="new-r-btn"><button type="button" class="btn btn-default">New Request<i class="fa fa-plus" aria-hidden="true"></i></button></li> -->
									</ul>
									</div>
									</div>
									
							</div>
			</div>--%>
          <!---- End HelpDesk---------------------->

		<!---------------------------- Vertical Tabs----------------------------->	
			<div class="request-details-pg">
				<div class="v-tabs">
				<div class="tab">
					<h4>Setting<i class="fa fa-cog" aria-hidden="true"></i></h4>
				  <button class="tablinks" type="button" onclick="openCity(event, 'Request')" id="defaultOpen">Request</button>
				  <button class="tablinks" type="button" onclick="openCity(event, 'Email')">Email</button>
				  <button class="tablinks" type="button" onclick="openCity(event, 'SAL')">SAL</button>
				  <button class="tablinks" type="button" onclick="openCity(event, 'Users')">Users & Role Access</button>
				  <button class="tablinks" type="button" onclick="openCity(event, 'Others')">Others</button>
				</div>

				<div id="Request" class="tabcontent">
				  
				  <div class="setting-src">
								<div class="row">
									<div class="col-md-6">
										<div class="left">
										<h3>Request</h3>											
										</div>
									</div>
									<div class="col-md-6">
										<div class="right search-bar">
											<button class="search-bt"><i class="fa fa-search" aria-hidden="true"></i></button>
											<%--<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search History" title="Type in a name">--%>
                                            <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                <%=CommonFunctions.HTMLControls.DrawTextBox("myInput", "myInput", "form-control", , ToBeInserted:="placeholder='Search History' title='Type in a name' onkeyup='myFunction();' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
										</div>
									</div>
								</div>
				  </div>
		<!--------------------------------------Request inner Horizontal Tabs---------------------------------------------------------->
		
								<div class="h-tabs">
																	
									<div class="tab">
									  <button class="tablinks1" type="button" onclick="openCity1(event, 'Type')" id="defaultOpen1">Type</button>
									  <button class="tablinks1" type="button" onclick="openCity1(event, 'Subtype')">Subtype</button>
									  <button class="tablinks1" type="button" onclick="openCity1(event, 'Status')">Status</button>
									  <button class="tablinks1" type="button" onclick="openCity1(event, 'Priority')">Priority</button>
									  <button class="tablinks1" type="button" onclick="openCity1(event, 'Severity')">Severity</button>
									  <button class="tablinks1" type="button" onclick="openCity1(event, 'Department')">Department</button>
									  <button class="tablinks1" type="button" onclick="openCity1(event, 'Autoclose')">Autoclose</button>
									</div>
					<!---------------------------- Type Tabs----------------------------->
									<div id="Type" class="tabcontent1 h-type">
									  <div class="type-top-bar top-bar">
										<ul class="left">
											<li>
                                                  <%--/**********************Added By Bharat T on 16th-Oct-2017 for setting page ui changes***************************************/--%>
												 <%--<select class="form-control" id="sel1" style="width:129px;">
															<option>Department</option>
															<option>2</option>
															<option>3</option>
															<option>4</option>
												 </select>--%>

                                                <%CommonFunctions.HTMLControls.DrawComboBox("sel1", "usp_Sel_tbl_PM_DepartmentMaster ", 129, , "class='form-control' ", True)%>
                                                  <%--/**********************End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***************************************/--%>
											</li>											
											<li>
                                                <%--/**********************Added By Bharat T on 16th-Oct-2017 for setting page ui changes***************************************/--%>
											<%--	<select class="form-control" id="sel1" style="width:129px;">
															<option>Request Type</option>
															<option>2</option>
															<option>3</option>
															<option>4</option>
														  </select>--%>
                                                <%CommonFunctions.HTMLControls.DrawComboBox("sel1", "usp_CRM_RequestType_Filter 'Admin','E' ", 129, , "class='form-control' ", True)%>
                                                <%--/**********************End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***************************************/--%>
											</li>
											<li class="search-bar">
											<button class="search-bt"><i class="fa fa-search" aria-hidden="true"></i></button>
                                                 <%--/**********************Added By Bharat T on 16th-Oct-2017 for setting page ui changes***************************************/--%>
											<%--<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search History" title="Type in a name">--%>
                                                <%=CommonFunctions.HTMLControls.DrawTextBox("myInput", "myInput", "form-control", , ToBeInserted:="placeholder='Search History' title='Type in a name' onkeyup=""myFunction();"" ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                 <%--/**********************End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***************************************/--%>
											</li>
										</ul>
										<ul class="right">
											<li class="save"><button type="button" class="btn btn-default">Save</button></li>
											<li class="clearall"><button type="button" class="btn btn-default">Clear All</button></li>
											<li class="chk"><input type="checkbox" id="checkall">Select All</li>
										</ul>
										</div>
										<div class="table-responsive" id="divRequestTypeGrid">       
                                            <%-- Added By Bharat T on 16th-Oct-2017 for setting page ui changes --%>   
									  <%--<table class="table">
										<thead>
										  <tr>
											<th>Request Type</th>
											<th>SubRequest Type</th>
											<th>Group Email</th>
											<th>Approved Required</th>
											<th>New Value</th>
										  </tr>
										</thead>
										<tbody>									  
										  <tr>
											<td>Clarification</td>
											<td>Download Reports</td>
											<td></td>
											<td><input type="checkbox" id="Checkbox1"></td>
											<td><input type="checkbox" id="Checkbox2"></td>											
										  </tr>
											
										  <tr>
											<td>Unable to View Data</td>
											<td>Database Crash</td>
											<td></td>
											<td><input type="checkbox" id="Checkbox3"></td>
											<td><input type="checkbox" id="Checkbox4"></td>
										  </tr>	
										  
										  <tr>
											<td>Unable to Edit</td>
											<td>Edit Bar is not Working</td>
											<td></td>
											<td><input type="checkbox" id="Checkbox5"></td>
											<td><input type="checkbox" id="Checkbox6"></td>
										  </tr>	
										  
										  <tr>
											<td>System Crashed</td>
											<td>Unable to Open</td>
											<td></td>
											<td><input type="checkbox" id="Checkbox7"></td>
											<td><input type="checkbox" id="Checkbox8"></td>
										  </tr>									  
										</tbody>
									  </table>--%>
                                            <%WriteRequestTabGrid("Type", "")%>
                                            <%--End of  Added By Bharat T on 16th-Oct-2017 for setting page ui changes --%>   
									  </div>
									  <div class="bottom-bar">
									  <div class="pannel-section">
										  <div class="col-md-12 col-sm-12">
											
											<div class="panel-group wrap" id="accordion" role="tablist" aria-multiselectable="true">
											  <div class="panel">
												<div class="panel-heading" role="tab" id="headingOne">
													<h3><span style="border-right: 1px solid;padding-right: 10px;">Type</span><span style="padding-left:10px;">CR - </span><span style="font-style:italic;">Change Request</span></h3>
												  <h4 class="panel-title">
												<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
												 <i class="fa fa-plus"></i>
												<i class="fa fa-minus"></i>
												</a>
											  </h4>
												</div>
												<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
												  <div class="panel-body">
													<form class="form-horizontal" action="/action_page.php">
														<div class="form-group">
														  <label class="control-label col-sm-3" for="request type">Request Type*</label>
														  <div class="col-sm-9">
															<%--<input type="text" class="form-control" id="requesttype" placeholder="Enter Request Type" name="requesttype">--%>
                                                                 <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "requesttype", "form-control", , ToBeInserted:="placeholder='Enter Request Type' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-3" for="request type code">Request Type Code*</label>
														  <div class="col-sm-9">
															<%--<input type="text" class="form-control" id="requesttypecode" placeholder="Enter Request Type Code" name="requesttypecode">--%>

                                                                  <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttypecode", "requesttypecode", "form-control", , ToBeInserted:="placeholder='Enter Request Type Code' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														</div>
														<div class="form-group">
																<div class="top-bar">
																	<ul class="left">
																		<li>SubRequest Type</li>											
																		
																	</ul>
																	<ul class="right">
																		<li>
																			<select class="form-control" id="sel1"style="">
																						<option>Select the value</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
																			 </select>
																		</li>
																		<li class="clearall"><button type="button" class="btn btn-default">Add<i class="fa fa-plus" aria-hidden="true"></i></button></li>
																		<li class="clearall"><button onclick=""  type="button" class="btn btn-default"  title="Delete">Delete<i class="fa fa-trash-o" aria-hidden="true"style="left: 53px;top: 8px;"></i></button></li>
																		<li class="clearall"><button type="button" class="btn btn-default">Clear All</button></li>
																	</ul>
																</div>
														</div>
														<div class="form-group">
															<div class="table-responsive">          
															  <table class="table">
																<thead>
																  <tr>											
																	<th>SubRequest Type</th>											
																	<th><input type="checkbox" id="checkall"></th>
																  </tr>
																</thead>
																<tbody>									  
																  <tr>
																	<td>CR</td>											
																	<td><input type="checkbox" id="checkall"></td>											
																  </tr>
																	
																								  
																</tbody>
															  </table>
															  </div>
														</div>
														<div class="form-group">        
														  <div class="right">
														  <button type="submit" class="btn btn-default" style="background-color:#343660;color:#fff;">Submit</button>
														  <button type="button" class="btn btn-default" style="border:none;border-left:1px solid;">Save and Add<i class="fa fa-plus" aria-hidden="true"></i></button>
														  </div>
														</div>
													</form>
												  </div>
												</div>
											  </div>
											  <!-- end of panel -->
											</div>
											<!-- end of #accordion -->

										  </div>
										  <!-- end of wrap -->

										</div>
									  </div>
									</div>
				<!----------------------------Subtype Tabs----------------------------->
									<div id="Subtype" class="tabcontent1 h-type h-form">
									  <div class="type-top-bar top-bar">
										<ul class="left">											
											<li class="search-bar">
											<button class="search-bt"><i class="fa fa-search" aria-hidden="true"></i></button>
											<%--<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search History" title="Type in a name">--%>

                                                <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("myInput", "myInput", "form-control", , ToBeInserted:="placeholder='Search History' title='Type in a name' onkeyup='myFunction()'", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
											</li>
										</ul>
										<ul class="right">
											<li class="clearall"><button type="button" class="btn btn-default">Inherit Status Flow</button></li>
											<li class="clearall"><button type="button" class="btn btn-default">Add<i class="fa fa-plus" aria-hidden="true"></i></button></li>
											<li class="clearall"><button onclick=""  type="button" class="btn btn-default"  title="Delete">Delete<i class="fa fa-trash-o" aria-hidden="true"></i></button></li>
											<li class="clearall"><button type="button" class="btn btn-default">Clear All</button></li>
										</ul>
										</div>
										<div class="table-responsive">          
									  <table class="table">
										<thead>
										  <tr>
											<th>Request SubType Code</th>
											<th>Request SubType</th>
											<th>Task Type</th>
											<th>Configure Status Flow</th>
											<th><input type="checkbox" id="checkall"></th>
										  </tr>
										</thead>
										<tbody>									  
										  <tr>
											<td>CR</td>
											<td>Change Request</td>
											<td>Product Support</td>
											<td>Configure Status Flow</td>
											<td><input type="checkbox" id="checkall"></td>											
										  </tr>
											
										  <tr>
											<td>Unable to View Data</td>
											<td>Database Crash</td>
											<td>Product Support</td>
											<td>Configure Status Flow</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>	
										  
										  <tr>
											<td>HD-Conf</td>
											<td>Edit Bar is not Working</td>
											<td>Product Support</td>
											<td>Configure Status Flow</td>
											<td><input type="checkbox" id="Checkbox14"></td>
										  </tr>	
										  
										  <tr>
											<td>FD-kji</td>
											<td>Unable to Open</td>
											<td>Product Support</td>
											<td>Configure Status Flow</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>									  
										</tbody>
									  </table>
									  </div> 
									   <div class="bottom-bar">
									  <div class="pannel-section">
										  <div class="col-md-12 col-sm-12">
											
											<div class="panel-group wrap" id="accordion" role="tablist" aria-multiselectable="true">
											  <div class="panel">
												<div class="panel-heading" role="tab" id="headingOne">
													<h3><span style="border-right: 1px solid;padding-right: 10px;">Sub Type</span><span style="padding-left:10px;">CR - </span><span style="font-style:italic;">Change Request</span></h3>
												  <h4 class="panel-title">
												<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne1" aria-expanded="true" aria-controls="collapseOne">
												 <i class="fa fa-plus"></i>
												<i class="fa fa-minus"></i>
												</a>
											  </h4>
												</div>
												<div id="collapseOne1" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
												  <div class="panel-body">
													<form class="form-horizontal" action="/action_page.php">
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Request SubType Code*</label>
														  <div class="col-sm-4">
															<%--<input type="text" style="width:135px;" class="form-control" id="Text3"  name="requesttype">--%>
                                                                  <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text3", "form-control", , ToBeInserted:="style='width:135px;' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														  <label class="control-label col-sm-2" for="request type">Work Hours*</label>
														  <div class="col-sm-4">
															<%--<input type="text"  style="width:54px;" class="form-control" id="Text4" placeholder="24" name="requesttype">--%>

                                                                 <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text4", "form-control", , ToBeInserted:="style='width:54px;' placeholder=24 ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Request Type*</label>
														  <div class="col-sm-4">
															<%--<input type="text" style="width:219px;" class="form-control" id="Text5"  name="requesttype">--%>
                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text5", "form-control", , ToBeInserted:="style='width:219px;' placeholder='' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>

														  </div>
														  <label class="control-label col-sm-2" for="request type">Attachment Mandatory</label>
														  <div class="col-sm-4">
															<input type="checkbox" style="width:11px;" id="checkall">
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">SLA Red Threshold*</label>
														  <div class="col-sm-4">
															<%--<input type="text" style="width:135px;" class="form-control" id="Text6"  name="requesttype">--%>
                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text6", "form-control", , ToBeInserted:="style='width:135px;' placeholder='' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														  <label class="control-label col-sm-2" for="request type">SLA Yellow Threshold*</label>
														  <div class="col-sm-4">
															<%--<input type="text" style="width:135px;" class="form-control" id="Text7"  name="requesttype">--%>

                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text7", "form-control", , ToBeInserted:="style='width:135px;' placeholder='' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Task Type*</label>
														  <div class="col-sm-4">
															<select class="form-control" id="sel1" style="width:219px;">
																						<option>Task Type</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
														  </div>
														  <label class="control-label col-sm-2" for="request type"></label>
														  <div class="col-sm-4">
															
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Guidelines For Requestor</label>
														  <div class="col-sm-4">
															<textarea style="width:208px;" class="form-control" rows="2" id="comment"></textarea>
														  </div>
														  <label class="control-label col-sm-2" for="request type">Guidelines For Asignee</label>
														  <div class="col-sm-4">
															<textarea style="width:208px;" class="form-control" rows="2" id="comment"></textarea>
														  </div>
														</div>
														<div class="form-group">        
														  <div class="col-sm-offset-8 col-sm-4">
														  <button type="submit" class="btn btn-default" style="background-color:#343660;color:#fff;">Attachment</button>
														  <button type="submit" class="btn btn-default" style="background-color:#343660;color:#fff;">Submit</button>
														  <button type="button" class="btn btn-default" style="border:none;border-left:1px solid;">Save and Add<i class="fa fa-plus" aria-hidden="true"style="padding-left: 5px;padding-left: 5px;"></i></button>
														  </div>
														</div>
													</form>
												  </div>
												</div>
											  </div>
											  <!-- end of panel -->
											</div>
											<!-- end of #accordion -->

										  </div>
										  <!-- end of wrap -->

										</div>
									  </div>
									</div>
				<!---------------------------- Status Tabs----------------------------->
									<div id="Status" class="tabcontent1 h-type h-form">
									  <div class="type-top-bar top-bar">
										<ul class="left">											
											<li class="search-bar">
											<button class="search-bt"><i class="fa fa-search" aria-hidden="true"></i></button>
											<%--<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search History" title="Type in a name">--%>
                                                 <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("myInput", "myInput", "form-control", , ToBeInserted:=" placeholder='Search History' title='Type in a name' onkeyup=""myFunction();"" ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
											</li>
										</ul>
										<ul class="right">											
											<li class="clearall"><button onclick=""  type="button" class="btn btn-default"  title="Delete">Delete<i class="fa fa-trash-o" aria-hidden="true"></i></button></li>
											<li class="clearall"><button type="button" class="btn btn-default">Clear All</button></li>
										</ul>
										</div>
										<div class="table-responsive">          
									  <table class="table">
										<thead>
										  <tr>
											<th>Request Status Code</th>
											<th>Request Status</th>
											<th>System Status</th>
											<th>Order Number</th>
											<th><input type="checkbox" id="checkall"></th>
										  </tr>
										</thead>
										<tbody>									  
										  <tr>
											<td>T_ACK</td>
											<td>ACKNOWLEDGED</td>
											<td>Close</td>
											<td>25</td>
											<td><input type="checkbox" id="checkall"></td>											
										  </tr>
											
										  <tr>
											<td>fg-hjik</td>
											<td>ASSIGNED</td>
											<td>Response</td>
											<td>36</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>	
										  
										  <tr>
											<td>HD-Conf</td>
											<td>ACKNOWLEDGED</td>
											<td>Response</td>
											<td>24</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>	
										  
										  <tr>
											<td>FD-kji</td>
											<td>ACKNOWLEDGED</td>
											<td>Response</td>
											<td>98</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>									  
										</tbody>
									  </table>
									  </div> 
									  <div class="bottom-bar">
									  <div class="pannel-section">
										  <div class="col-md-12 col-sm-12">
											
											<div class="panel-group wrap" id="accordion" role="tablist" aria-multiselectable="true">
											  <div class="panel">
												<div class="panel-heading" role="tab" id="headingOne">
													<h3><span style="border-right: 1px solid;padding-right: 10px;">Status</span><span style="padding-left:10px;">T_ACK- ACKNOWLEDGED</span><span style="float:right;"><button type="button" class="btn"style="margin-top: -14px;">Add</button> <button onclick="document.getElementById('id10').style.display='block'"  type="button" class="btn btn-default reply-btn" style="background-color:#343660;color:#fff;margin-top: -12px;""  title="Show History"style="margin-top: -14px;">Show History</button></span></h3>
												  <h4 class="panel-title">
												<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne2" aria-expanded="true" aria-controls="collapseOne">
												 <i class="fa fa-plus"></i>
												<i class="fa fa-minus"></i>
												</a>
											  </h4>
												</div>
												<div id="collapseOne2" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
												  <div class="panel-body">
													<form class="form-horizontal" action="/action_page.php">
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Request Status Code*</label>
														  <div class="col-sm-4">
															<%--<input type="text" style="width:135px;" class="form-control" id="Text9"  name="requesttype">--%>
                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text9", "form-control", , ToBeInserted:="style='width:135px;' placeholder='' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														  <label class="control-label col-sm-2" for="request type">Order Number</label>
														  <div class="col-sm-4">
															<%--<input type="text"  style="width:54px;" class="form-control" id="Text10" placeholder="24" name="requesttype">--%>
                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text10", "form-control", , ToBeInserted:="style='width:54px;' placeholder='24' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Request Status*</label>
														  <div class="col-sm-4">
															<%--<input type="text" style="width:219px;" class="form-control" id="Text11"  name="requesttype">--%>
                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text11", "form-control", , ToBeInserted:="style='width:219px;' placeholder='' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														  <label class="control-label col-sm-2" for="request type"></label>
														  <div class="col-sm-4">
															
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">System Status*</label>
														  <div class="col-sm-4">
															<select class="form-control" id="sel1" style="width:219px;">
																						<option>Task Type</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
														  </div>
														  <label class="control-label col-sm-2" for="request type"></label>
														  <div class="col-sm-4">
															
														  </div>
														</div>
														<div class="form-group">        
														  <div class="col-sm-offset-9 col-sm-3">														  
														  <button type="submit" class="btn btn-default" style="background-color:#343660;color:#fff;">Save</button>
														  <button type="button" class="btn btn-default" style="border:none;border-left:1px solid;">Save and Add<i class="fa fa-plus" aria-hidden="true"style="padding-left: 5px;padding-left: 5px;"></i></button>
														  </div>
														</div>
													</form>
												  </div>
												</div>
											  </div>
											  <!-- end of panel -->
											</div>
											<!-- end of #accordion -->

										  </div>
										  <!-- end of wrap -->

										</div>
									  </div>
									</div>
					<!---------------------------- Priority Tabs----------------------------->
									<div id="Priority" class="tabcontent1 h-form">
									  <div class="type-top-bar top-bar">
										<ul class="left">											
											<li class="search-bar">
											<button class="search-bt"><i class="fa fa-search" aria-hidden="true"></i></button>
											<%--<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search History" title="Type in a name">--%>
                                                 <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("myInput", "myInput", "form-control", , ToBeInserted:="placeholder='Search History' onkeyup='myFunction()' title='Type in a name' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
											</li>
										</ul>
										<ul class="right">											
											<li class="clearall"><button onclick=""  type="button" class="btn btn-default"  title="Delete">Delete<i class="fa fa-trash-o" aria-hidden="true"></i></button></li>
											<li class="clearall"><button type="button" class="btn btn-default">Clear All</button></li>
										</ul>
										</div>
										<div class="table-responsive">          
									  <table class="table">
										<thead>
										  <tr>
											<th>Request Priority Code</th>
											<th>Request Priority</th>
											<th>Order Number</th>
											<th><input type="checkbox" id="checkall"></th>
										  </tr>
										</thead>
										<tbody>									  
										  <tr>
											<td>T_ACK</td>
											<td>P1 - URGENT</td>
											<td>25</td>
											<td><input type="checkbox" id="checkall"></td>											
										  </tr>
											
										  <tr>
											<td>fg-hjik</td>
											<td>P1 - HIGH</td>
											<td>36</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>	
										  
										  <tr>
											<td>HD-Conf</td>
											<td>P1 - LOW</td>
											<td>24</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>	
										  
										  <tr>
											<td>FD-kji</td>
											<td>P1 - HIGH</td>
											<td>98</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>									  
										</tbody>
									  </table>
									  </div>
									  <div class="bottom-bar">
									  <div class="pannel-section">
										  <div class="col-md-12 col-sm-12">
											
											<div class="panel-group wrap" id="accordion" role="tablist" aria-multiselectable="true">
											  <div class="panel">
												<div class="panel-heading" role="tab" id="headingOne">
													<h3><span style="border-right: 1px solid;padding-right: 10px;">Priority</span><span style="padding-left:10px;">T_ACK - ACKNOWLEDGED </span><span style="float:right;"><button type="button" class="btn"style="margin-top: -14px;">Add</button> <button onclick="document.getElementById('id11').style.display='block'"  type="button" class="btn btn-default reply-btn" style="background-color:#343660;color:#fff;margin-top: -12px;""  title="Show History"style="margin-top: -14px;">Show History</button></span></h3>
												  <h4 class="panel-title">
												<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne3" aria-expanded="true" aria-controls="collapseOne">
												 <i class="fa fa-plus"></i>
												<i class="fa fa-minus"></i>
												</a>
											  </h4>
												</div>
												<div id="collapseOne3" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
												  <div class="panel-body">
													<form class="form-horizontal" action="/action_page.php">
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Request Priority Code*</label>
														  <div class="col-sm-4">
															<%--<input type="text" style="width:135px;" class="form-control" id="Text13"  name="requesttype">--%>
                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text13", "form-control", , ToBeInserted:="style='width:135px;' placeholder='' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														  <label class="control-label col-sm-2" for="request type">Order Number*</label>
														  <div class="col-sm-4">
															<%--<input type="text"  style="width:54px;" class="form-control" id="Text14" placeholder="24" name="requesttype">--%>
                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text14", "form-control", , ToBeInserted:="style='width:54px;' placeholder='24' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Request Priority*</label>
														  <div class="col-sm-4">
															<%--<input type="text" style="width:219px;" class="form-control" id="Text15"  name="requesttype">--%>
                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text15", "form-control", , ToBeInserted:="style='width:219px;' placeholder='' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														  <label class="control-label col-sm-2" for="request type"></label>
														  <div class="col-sm-4">
															
														  </div>
														</div>														
														<div class="form-group">        
														  <div class="col-sm-offset-9 col-sm-3">														  
														  <button type="submit" class="btn btn-default" style="background-color:#343660;color:#fff;">Save</button>
														  <button type="button" class="btn btn-default" style="border:none;border-left:1px solid;">Save and Add<i class="fa fa-plus" aria-hidden="true"style="padding-left: 5px;padding-left: 5px;"></i></button>
														  </div>
														</div>
													</form>
												  </div>
												</div>
											  </div>
											  <!-- end of panel -->
											</div>
											<!-- end of #accordion -->

										  </div>
										  <!-- end of wrap -->

										</div>
									  </div>
									</div>
			<!---------------------------- Severity Tabs----------------------------->						
									<div id="Severity" class="tabcontent1 h-form">
									  <div class="type-top-bar top-bar">
										<ul class="left">											
											<li class="search-bar">
											<button class="search-bt"><i class="fa fa-search" aria-hidden="true"></i></button>
											<%--<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search History" title="Type in a name">--%>
                                                 <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                <%=CommonFunctions.HTMLControls.DrawTextBox("myInput", "myInput", "form-control", , ToBeInserted:="placeholder='Search History' title='Type in a name' onkeyup='myFunction();' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
											</li>
										</ul>
										<ul class="right">											
											<li class="clearall"><button onclick=""  type="button" class="btn btn-default"  title="Delete">Delete<i class="fa fa-trash-o" aria-hidden="true"></i></button></li>
											<li class="clearall"><button type="button" class="btn btn-default">Clear All</button></li>
										</ul>
										</div>
										<div class="table-responsive">          
									  <table class="table">
										<thead>
										  <tr>
											<th>Request Severity Code</th>
											<th>Request Severity</th>
											<th><input type="checkbox" id="checkall"></th>
										  </tr>
										</thead>
										<tbody>									  
										  <tr>
											<td>T_ACK</td>
											<td>PS2 - CRITICAL</td>
											<td><input type="checkbox" id="checkall"></td>											
										  </tr>
											
										  <tr>
											<td>fg-hjik</td>
											<td>S2 - MAJOR</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>	
										  
										  <tr>
											<td>HD-Conf</td>
											<td>S2 - CRITICAL</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>	
										  
										  <tr>
											<td>FD-kji</td>
											<td>S2 - CRITICAL</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>									  
										</tbody>
									  </table>
									  </div>
									  <div class="bottom-bar">
									  <div class="pannel-section">
										  <div class="col-md-12 col-sm-12">
											
											<div class="panel-group wrap" id="accordion" role="tablist" aria-multiselectable="true">
											  <div class="panel">
												<div class="panel-heading" role="tab" id="headingOne">
													<h3><span style="border-right: 1px solid;padding-right: 10px;">Sub Type</span><span style="padding-left:10px;">CR - </span><span style="font-style:italic;">Change Request</span><span style="float:right;"><button type="button" class="btn"style="margin-top: -14px;">Add</button> <button onclick="document.getElementById('id12').style.display='block'"  type="button" class="btn btn-default reply-btn" style="background-color:#343660;color:#fff;margin-top: -12px;""  title="Show History"style="margin-top: -14px;">Show History</button></span></h3>
												  <h4 class="panel-title">
												<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne4" aria-expanded="true" aria-controls="collapseOne">
												 <i class="fa fa-plus"></i>
												<i class="fa fa-minus"></i>
												</a>
											  </h4>
												</div>
												<div id="collapseOne4" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
												  <div class="panel-body">
													<form class="form-horizontal" action="/action_page.php">
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Request Severity Code*</label>
														  <div class="col-sm-4">
															<%--<input type="text" style="width:135px;" class="form-control" id="Text17"  name="requesttype">--%>
                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text17", "form-control", , ToBeInserted:="style='width:135px;' placeholder='' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														  <label class="control-label col-sm-2" for="request type"></label>
														  <div class="col-sm-4">
															
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Request Severity*</label>
														  <div class="col-sm-4">
															<%--<input type="text" style="width:219px;" class="form-control" id="Text18"  name="requesttype">--%>
                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text18", "form-control", , ToBeInserted:="style='width:219px;' placeholder='' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														  <label class="control-label col-sm-2" for="request type"></label>
														  <div class="col-sm-4">
															
														  </div>
														</div>														
														<div class="form-group">        
														  <div class="col-sm-offset-9 col-sm-3">														  
														  <button type="submit" class="btn btn-default" style="background-color:#343660;color:#fff;">Save</button>
														  <button type="button" class="btn btn-default" style="border:none;border-left:1px solid;">Save and Add<i class="fa fa-plus" aria-hidden="true"style="padding-left: 5px;padding-left: 5px;"></i></button>
														  </div>
														</div>
													</form>
												  </div>
												</div>
											  </div>
											  <!-- end of panel -->
											</div>
											<!-- end of #accordion -->

										  </div>
										  <!-- end of wrap -->

										</div>
									  </div>
									</div>
				<!---------------------------- Department Tabs----------------------------->
									<div id="Department" class="tabcontent1 h-form">
									  <div class="type-top-bar top-bar">
										<ul class="left">											
											<li class="search-bar">
											<button class="search-bt"><i class="fa fa-search" aria-hidden="true"></i></button>
											<%--<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search History" title="Type in a name">--%>
                                                   <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                <%=CommonFunctions.HTMLControls.DrawTextBox("myInput", "myInput", "form-control", , ToBeInserted:="placeholder='Search History' title='Type in a name' onkeyup='myFunction();' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
											</li>
										</ul>
										<ul class="right">											
											<li class="clearall"><button type="button" class="btn btn-default">Add<i class="fa fa-plus" aria-hidden="true"></i></button></li>
											<li class="clearall"><button onclick=""  type="button" class="btn btn-default"  title="Delete">Delete<i class="fa fa-trash-o" aria-hidden="true"></i></button></li>
											<li class="clearall"><button type="button" class="btn btn-default">Clear All</button></li>
										</ul>
										</div>
										<div class="table-responsive">          
									  <table class="table">
										<thead>
										  <tr>
											<th>Short Name</th>
											<th>Department</th>
											<th>Expose to Customer</th>	
											<th><input type="checkbox" id="checkall"></th>
										  </tr>
										</thead>
										<tbody>									  
										  <tr>
											<td>CR</td>
											<td>ACCOUNTING AND FINANCE</td>
											<td>No</td>											
											<td><input type="checkbox" id="checkall"></td>											
										  </tr>
											
										  <tr>
											<td>fg-hjik</td>
											<td>Resource Management</td>
											<td>Yes</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>	
										  
										  <tr>
											<td>HD-Conf</td>
											<td>Marketting and Sales</td>
											<td>No</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>	
										  
										  <tr>
											<td>FD-kji</td>
											<td>IT And Research</td>
											<td>Yes</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>									  
										</tbody>
									  </table>
									  </div>
									  <div class="bottom-bar">
									  <div class="pannel-section">
										  <div class="col-md-12 col-sm-12">
											
											<div class="panel-group wrap" id="accordion" role="tablist" aria-multiselectable="true">
											  <div class="panel">
												<div class="panel-heading" role="tab" id="headingOne">
													<h3><span style="border-right: 1px solid;padding-right: 10px;">Department Master</span><span style="font-style:italic;padding-left:10px;">- ADD New Department</span></h3>
												  <h4 class="panel-title">
												<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne5" aria-expanded="true" aria-controls="collapseOne">
												 <i class="fa fa-plus"></i>
												<i class="fa fa-minus"></i>
												</a>
											  </h4>
												</div>
												<div id="collapseOne5" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
												  <div class="panel-body">
													<form class="form-horizontal" action="/action_page.php">
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Short Name**</label>
														  <div class="col-sm-4">
															<%--<input type="text" style="width:135px;" class="form-control" id="Text20"  name="requesttype">--%>
                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text20", "form-control", , ToBeInserted:="style='width:135px;' placeholder='' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														  <label class="control-label col-sm-3" for="request type">Expose to Customer*</label>
														  <div class="col-sm-3">
															<input type="checkbox" style="width:11px;" id="checkall">
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Department*</label>
														  <div class="col-sm-4">
															<%--<input type="text" style="width:219px;" class="form-control" id="Text21"  name="requesttype">--%>
                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text21", "form-control", , ToBeInserted:="style='width:219px;' placeholder='' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														  <label class="control-label col-sm-3" for="request type">Expose to Product Ececution </label>
														  <div class="col-sm-3">
															<input type="checkbox" style="width:11px;" id="checkall">
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Department Head*</label>
														  <div class="col-sm-4">
															<select class="form-control" id="sel1" style="width:219px;">
																						<option>Task Type</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
														  </div>
														  <label class="control-label col-sm-3" for="request type">Allow to delete Discussion Thread</label>
														  <div class="col-sm-3">
															<input type="checkbox" style="width:11px;" id="checkall">
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Customer Mapping*</label>
														  <div class="col-sm-4">
															<select class="form-control" id="sel1" style="width:219px;">
																						<option>Task Type</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
														  </div>
														  <label class="control-label col-sm-3" for="request type">Project Mapping</label>
														  <div class="col-sm-3">
															<select class="form-control" id="sel1" style="width:219px;">
																						<option>Task Type</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Configure HRM*</label>
														  <div class="col-sm-4">
															<select class="form-control" id="sel1" style="width:219px;">
																						<option>Task Type</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
														  </div>
														  <label class="control-label col-sm-3" for="request type">Email Mapping</label>
														  <div class="col-sm-3">
															<select class="form-control" id="sel1" style="width:219px;">
																						<option>Task Type</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
														  </div>
														</div>
														<div class="form-group">        
														  <div class="col-sm-12">
															<div class="left">
																<button type="button" class="btn btn-default" style="background-color:#343660;color:#fff;">Work Hours</button>
														    </div>
															<div class="right">
															  <button onclick="document.getElementById('id09').style.display='block'"  type="button" class="btn btn-default reply-btn" style="background-color:#343660;color:#fff;"  title="Request Type Mapping">Request Type Mapping</button>
															  <button type="button" class="btn btn-default" style="background-color:#343660;color:#fff;">Working Hours</button>
															  <button type="button" class="btn btn-default" style="background-color:#343660;color:#fff;">Save</button>
															  <button type="button" class="btn btn-default" style="border:none;border-left:1px solid;">Save and Add<i class="fa fa-plus" aria-hidden="true"style="padding-left: 5px;padding-left: 5px;"></i></button>
														  </div>
														  </div>
														</div>
													</form>
												  </div>
												</div>
											  </div>
											  <!-- end of panel -->
											</div>
											<!-- end of #accordion -->

										  </div>
										  <!-- end of wrap -->

										</div>
									  </div>
									</div>																	
					<!---------------------------- Autoclose Tabs----------------------------->		
									<div id="Autoclose" class="tabcontent1 h-type">
									  <h3>Autoclose Requests</h3>
									  <div class="auto-desc">
									  <p>Close Inactive Resolved Incedents</p>
									  <p>Select a duration after which inactive incidents will be moved from resolved state to Closed.
										 Note that an Incident is considered inactive when it has no new comments and no changes
										 are made to the incident ‘s fields  
									  </p>
									  </div>
									  <div class="auto-day-sel">
									  <select class="form-control" id="sel1" style="width:219px;">
																						<option>Days</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
										</select>
									</div>
									<div class="left auto-sec-btn">
														
										<button type="button" class="btn btn-default" style="background-color:#343660;color:#fff;">Save</button>
										<button type="button" class="btn btn-default">Cancle</button>
									 </div>
									</div>									
									
								
								</div>
						</div>
				
				<div id="Email" class="tabcontent">
				   <div class="setting-src">
								<div class="row">
									<div class="col-md-6">
										<div class="left">
										<h3>Email</h3>											
										</div>
									</div>
									<div class="col-md-6">
										<div class="right search-bar">
											<button class="search-bt"><i class="fa fa-search" aria-hidden="true"></i></button>
											<%--<input type="text" id="myInput" onkeyup="myFunction()" placeholder="Search History" title="Type in a name">--%>
                                                <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                <%=CommonFunctions.HTMLControls.DrawTextBox("myInput", "myInput", "form-control", , ToBeInserted:="placeholder='Search History' title='Type in a name' onkeyup='myFunction();' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
										</div>
									</div>
								</div>
				  </div> 
				  
				  <div class="h-tabs">
																
									<div class="tab">
									  <button class="tablinks2" type="button" onclick="openCity2(event, 'EmailListner')" id="defaultOpen2">Email Listner</button>
									  <button class="tablinks2" type="button" onclick="openCity2(event, 'EmailSettings')"> Email Settings</button>											          
									</div>
					<!---------------------------- Email Tabs----------------------------->
									<div id="EmailListner" class="tabcontent2 h-type h-form">
									   <div class="type-top-bar top-bar">
										<ul class="left">											
											<li class="search-bar">
											<button class="search-bt"><i class="fa fa-search" aria-hidden="true"></i></button>
											<%--<input type="text" id="Text23" onkeyup="myFunction()" placeholder="Search in table" title="Type in a name">--%>
                                                  <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                <%=CommonFunctions.HTMLControls.DrawTextBox("Text23", "Text23", "form-control", , ToBeInserted:="placeholder='Search in table' title='Type in a name' onkeyup='myFunction();' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
											</li>
										</ul>
										<ul class="right">											
											<li class="clearall"><button onclick=""  type="button" class="btn btn-default"  title="Delete">Delete<i class="fa fa-trash-o" aria-hidden="true"></i></button></li>
											<li class="clearall"><button type="button" class="btn btn-default">Clear All</button></li>
											<li>
												<div class="top-pagination">
													<ul class = "pagination">
														<li><a href = "#">&laquo;</a></li>
														<li><a href = "#">&#8249;</a></li>
														<li><a href = "#" style="background: #c0c0c0;color:#000;font-weight:600;">1-20 of 80</a></li>
														<li><a href = "#">&#8250;</a></li>
														<li><a href = "#">&raquo;</a></li>
													</ul>
												</div>
											</li>
										</ul>
										</div>
										<div class="table-responsive">          
									  <table class="table">
										<thead>
										  <tr>
											<th>Message Id</th>
											<th>Subject</th>
											<th>Send Mail</th>
											<th>Show Popup Paged</th>
											<th><input type="checkbox" id="checkall"></th>
										  </tr>
										</thead>
										<tbody>									  
										  <tr>
											<td>459</td>
											<td>DELIVERABLE_NAME</td>
											<td class="yes">Yes</td>
											<td class="yes">Yes</td>
											<td><input type="checkbox" id="checkall"></td>											
										  </tr>
											
										  <tr>
											<td>698</td>
											<td>PROJECT_NAME : Communication Plan - COMMUNICATION_ITEM NED</td>
											<td class="no">No</td>
											<td class="no">No</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>	
										  
										  <tr>
											<td>453</td>
											<td>REVIEW_TYPE to be conducted from REVIEW_START_DATE REVIEW_END_DATE.GED</td>
											<td class="no">No</td>
											<td class="yes">Yes</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>	
										  
										  <tr>
											<td>365</td>
											<td>Assigned as responsible person !! Project: PROJECT_NAME; IssueID: ISSUE_ID]</td>
											<td class="no">No</td>
											<td class="yes">Yes</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>
											
											<tr>
											<td>453</td>
											<td>REVIEW_TYPE to be conducted from REVIEW_START_DATE REVIEW_END_DATE.GED</td>
											<td class="yes">Yes</td>
											<td class="no">No</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>
										  
										  <tr>
											<td>698</td>
											<td>PROJECT_NAME : Communication Plan - COMMUNICATION_ITEM NED</td>
											<td class="no">No</td>
											<td class="yes">Yes</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>
										  
										  <tr>
											<td>453</td>
											<td>REVIEW_TYPE to be conducted from REVIEW_START_DATE REVIEW_END_DATE.GED</td>
											<td class="yes">Yes</td>
											<td class="no">No</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>
										  
										  <tr>
											<td>698</td>
											<td>PROJECT_NAME : Communication Plan - COMMUNICATION_ITEM NED</td>
											<td class="no">No</td>
											<td class="no">No</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>
										  
										  <tr>
											<td>460</td>
											<td>REVIEW_TYPE to be conducted from REVIEW_START_DATE REVIEW_END_DATE.GED</td>
											<td class="yes">Yes</td>
											<td class="yes">Yes</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>
										  
										  <tr>
											<td>460</td>
											<td>PROJECT_NAME : Communication Plan - COMMUNICATION_ITEM NED</td>
											<td class="no">No</td>
											<td class="no">No</td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>										  
										  
										</tbody>
									  </table>
									  </div>
									  <div class="top-pagination">
													<ul class = "pagination" style="margin-bottom: 14px;">
														<li><a href = "#">&laquo;</a></li>
														<li><a href = "#">&#8249;</a></li>
														<li><a href = "#" style="background: #c0c0c0;color:#000;font-weight:600;">1-20 of 80</a></li>
														<li><a href = "#">&#8250;</a></li>
														<li><a href = "#">&raquo;</a></li>
													</ul>
												</div>
									  <div class="bottom-bar">
									  <div class="pannel-section">
										  <div class="col-md-12 col-sm-12">
											
											<div class="panel-group wrap" id="accordion" role="tablist" aria-multiselectable="true">
											  <div class="panel">
												<div class="panel-heading" role="tab" id="headingOne">
													<h3><span style="border-right: 1px solid;padding-right: 10px;">Email Setting</span><span style="padding-left:10px;">Message Id-468 </span><span style="float:right;">Show History</span></h3>
													
												  <h4 class="panel-title">
												<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne7" aria-expanded="true" aria-controls="collapseOne">
												 <i class="fa fa-plus"></i>
												<i class="fa fa-minus"></i>
												</a>
											  </h4>
												</div>
												<div id="collapseOne7" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
												  <div class="panel-body">
													<form class="form-horizontal" action="/action_page.php">
														<div class="form-group">
														
														  <label class="control-label col-sm-2" for="request type">Purpose</label>
														  <div class="col-sm-4">
															<%--<input type="text" style="width:135px;" class="form-control" id="Text24"  name="requesttype">--%>
                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text24", "form-control", , ToBeInserted:="style='width:135px;' placeholder='' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														  <label class="control-label col-sm-3" for="request type">Subject</label>
														  <div class="col-sm-3">
															<%--<input type="text" style="width:135px;" class="form-control" id="Text25"  name="requesttype">--%>
                                                               <%--/**********Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
                                                                <%=CommonFunctions.HTMLControls.DrawTextBox("requesttype", "Text25", "form-control", , ToBeInserted:="style='width:135px;' placeholder='' ", returnHTML:=False, EnableHTMLEncode:=True).Replace("'", "\'")%>
                                                                    <%--/**********End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***********/--%>
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Body</label>
														  <div class="col-sm-4">
															<textarea style="width:208px;" class="form-control" rows="2" id="comment"></textarea>
														  </div>
														  <label class="control-label col-sm-3" for="request type">SendEmail*</label>
														  <div class="col-sm-3">
															<input type="checkbox" style="width:11px;" id="checkall">
														  </div>
														  <label class="control-label col-sm-3" for="request type">Show Popup Page*</label>
														  <div class="col-sm-3">
															<input type="checkbox" style="width:11px;" id="checkall">
														  </div>
														</div>
														<div class="form-group">
														  <label class="control-label col-sm-2" for="request type">Comments</label>
														  <div class="col-sm-4">
															<textarea style="width:208px;" class="form-control" rows="2" id="comment"></textarea>
														  </div>
														  <label class="control-label col-sm-3" for="request type"></label>
														  <div class="col-sm-3">															
														  </div>
														</div>														
														<div class="form-group">        
														  <div class="col-sm-12">															
															<div class="right">															  
															  <button type="button" class="btn btn-default" style="background-color:#343660;color:#fff;">Save</button>
															  <button type="button" class="btn btn-default" style="border:none;border-left:1px solid;">Save and Add<i class="fa fa-plus" aria-hidden="true"style="padding-left: 5px;padding-left: 5px;"></i></button>
														  </div>
														  </div>
														</div>
													</form>
												  </div>
												</div>
											  </div>
											  <!-- end of panel -->
											</div>
											<!-- end of #accordion -->

										  </div>
										  <!-- end of wrap -->

										</div>
									 </div>
								</div>
							<div id="EmailSettings" class="tabcontent2">
							  <h3>SAL</h3>
							  <p>Tokyo is the capital of Japan.</p>
							</div>	
								
							
						</div>
				</div>

				<div id="SAL" class="tabcontent">
				  <h3>SAL</h3>
				  <p>Tokyo is the capital of Japan.</p>
				</div>
				
				<div id="Users" class="tabcontent">
				  <h3>Users</h3>
				  <p>Tokyo is the capital of Japan.</p>
				</div>
				
				<div id="Others" class="tabcontent">
				  <h3>Others</h3>
				  <p>Tokyo is the capital of Japan.</p>
				</div>
			</div>
			</div>
			
		</div>
      
      <!-- /.container-fluid -->

    </div>
    <!-- /.content-wrapper -->
    </div>
    </form>

    	
<!-- ----- Request Type Mapping button popup---------------------------->
	<div id="id09" class="modal">
  
  <form class="modal-content animate" action="/action_page.php">
    <div class="imgcontainer">
	<span class="appro-title">Add Note</span>
      <span onclick="document.getElementById('id09').style.display='none'" class="close" title="Close Modal">&times;</span>
    </div>
    <div class="container-fluid">	
		<div class="form-group">
			<label class="control-label col-sm-3" for="request type">Department</label>
			<div class="col-sm-9">
				<select class="form-control" id="sel1" style="width:219px;">
																						<option>Department</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-3" for="request type code">Request Type</label>
			<div class="col-sm-9">
				<select class="form-control" id="sel1" style="width:219px;">
																						<option>Request Type</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
			</div>
		</div>	
		<div class="h-tabs">
			<div class="table-responsive">          
									  <table class="table">
										<thead>
										  <tr>
											<th>Request Type</th>
											<th>SubRequest Type</th>
											<th>Group Email</th>
											<th>Approved Required</th>
											<th>New Value</th>
										  </tr>
										</thead>
										<tbody>									  
										  <tr>
											<td>Clarification</td>
											<td>Download Reports</td>
											<td></td>
											<td><input type="checkbox" id="checkall"></td>
											<td><input type="checkbox" id="checkall"></td>											
										  </tr>
											
										  <tr>
											<td>Unable to View Data</td>
											<td>Database Crash</td>
											<td></td>
											<td><input type="checkbox" id="checkall"></td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>	
										  
										  <tr>
											<td>Unable to Edit</td>
											<td>Edit Bar is not Working</td>
											<td></td>
											<td><input type="checkbox" id="checkall"></td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>	
										  
										  <tr>
											<td>System Crashed</td>
											<td>Unable to Open</td>
											<td></td>
											<td><input type="checkbox" id="checkall"></td>
											<td><input type="checkbox" id="checkall"></td>
										  </tr>									  
										</tbody>
									  </table>
									  </div>
				</div>
    </div>
  </form>
</div>

   <!-- ----- Show History in status button popup---------------------------->
	<div id="id10" class="modal">
  
  <form class="modal-content animate" action="/action_page.php">
    <div class="imgcontainer">
	<span class="appro-title">Show History</span>
      <span onclick="document.getElementById('id10').style.display='none'" class="close" title="Close Modal">&times;</span>
    </div>
    <div class="container-fluid">	
		<div class="form-group">
			<label class="control-label col-sm-3" for="request type">Modified Field</label>
			<div class="col-sm-9">
				<select class="form-control" id="sel1" style="width:219px;">
																						<option>Department</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-3" for="request type code">Modified By</label>
			<div class="col-sm-9">
				<select class="form-control" id="sel1" style="width:219px;">
																						<option>Modified By</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
			</div>
		</div>	
		<div class="h-tabs">
			<div class="table-responsive">          
									  <table class="table">
										<thead>
										  <tr>
											<th>Modified Field</th>
											<th>Modified Date</th>
											<th>Value</th>
											<th>Modified By</th>
										  </tr>
										</thead>
										<tbody>
										  <tr>
											<td>T_ACK</td>
											<td>25 Augast 2017    3:30 AM</td>
											<td>User Escalated</td>
											<td>Admin</td>
										  </tr>											  
										  									  
										</tbody>
									  </table>
									  </div>
				</div>
    </div>
  </form>
</div>


<!-- ----- Shoe History in Priority button popup---------------------------->
	<div id="id11" class="modal">
  
  <form class="modal-content animate" action="/action_page.php">
    <div class="imgcontainer">
	<span class="appro-title">Show History</span>
      <span onclick="document.getElementById('id11').style.display='none'" class="close" title="Close Modal">&times;</span>
    </div>
    <div class="container-fluid">	
		<div class="form-group">
			<label class="control-label col-sm-3" for="request type">Modified Field</label>
			<div class="col-sm-9">
				<select class="form-control" id="sel1" style="width:219px;">
																						<option>Department</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-3" for="request type code">Modified By</label>
			<div class="col-sm-9">
				<select class="form-control" id="sel1" style="width:219px;">
																						<option>Modified By</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
			</div>
		</div>	
		<div class="h-tabs">
			<div class="table-responsive">          
									  <table class="table">
										<thead>
										  <tr>
											<th>Modified Field</th>
											<th>Modified Date</th>
											<th>Value</th>
											<th>Modified By</th>
										  </tr>
										</thead>
										<tbody>
										  <tr>
											<td>T_ACK</td>
											<td>25 Augast 2017    3:30 AM</td>
											<td>UREGENT</td>
											<td>Admin</td>
										  </tr>											  
										  									  
										</tbody>
									  </table>
									  </div>
				</div>
    </div>
  </form>
</div>

<!-- ----- Shoe History in Priority button popup---------------------------->
	<div id="id12" class="modal">
  
  <form class="modal-content animate" action="/action_page.php">
    <div class="imgcontainer">
	<span class="appro-title">Show History</span>
      <span onclick="document.getElementById('id12').style.display='none'" class="close" title="Close Modal">&times;</span>
    </div>
    <div class="container-fluid">	
		<div class="form-group">
			<label class="control-label col-sm-3" for="request type">Modified Field</label>
			<div class="col-sm-9">
				<select class="form-control" id="sel1" style="width:219px;">
																						<option>Department</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
			</div>
		</div>
		<div class="form-group">
			<label class="control-label col-sm-3" for="request type code">Modified By</label>
			<div class="col-sm-9">
				<select class="form-control" id="sel1" style="width:219px;">
																						<option>Modified By</option>
																						<option>2</option>
																						<option>3</option>
																						<option>4</option>
															</select>
			</div>
		</div>	
		<div class="h-tabs">
			<div class="table-responsive">          
									  <table class="table">
										<thead>
										  <tr>
											<th>Modified Field</th>
											<th>Modified Date</th>
											<th>Value</th>
											<th>Modified By</th>
										  </tr>
										</thead>
										<tbody>
										  <tr>
											<td>T_ACK</td>
											<td>25 Augast 2017    3:30 AM</td>
											<td>UREGENT</td>
											<td>Admin</td>
										  </tr>											  
										  									  
										</tbody>
									  </table>
									  </div>
				</div>
    </div>
  </form>
</div>
	<%--<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>



    <script src="../../EnhancementFiles/vendor/popper/popper.min.js"></script>

	
    <script src="../../EnhancementFiles/js/editor.js"></script>

	
 
    <script src="../../EnhancementFiles/js/timepicker.js"></script>
    <script src="../../EnhancementFiles/js/timepicker.min.js"></script>
    <%--<script src="../General/CommonFunctions.js"></script>--%>
<script>
    $(function () {
        $('#timepicker1').timepicker();
        $('#timepicker2').timepicker();
    });
</script>

<!-- End of time picker -->
   <script>
       $(function () {
           $("#datepicker").datepicker();
           $("#datepicker1").datepicker();
           $("#datepicker2").datepicker();
       });
	</script>

    
<script>
    var strPageName = "Settings.aspx";
    $(document).ready(function () {
        $("#txtEditor").Editor();
        $("#txtEditor1").Editor();
        $("#txtEditor2").Editor();
        $("#txtEditor3").Editor();

    });
</script>
  
    <script src="js/sb-admin.min.js"></script>
<script>
    function RefreshGrid(cityName) {
        var strResult, data;
        var GridParameter = {};


        GridParameter.cityName = cityName;

        data = JSON.stringify({ GridParameter: GridParameter });

        strResult = AJAXCallWithResult(strPageName + "/RefreshGrid", data, false);

        if (strResult.d != '') {
            if (String(cityName).toUpperCase() != "AUTOCLOSE") {
                $("#" + cityName + " .table-responsive:first").html(strResult.d);

                $("#" + cityName + " .table-responsive:first table").addClass("table");
            }
        }
    }
    function openCity(evt, cityName) {
        var i, tabcontent, tablinks;
        tabcontent = document.getElementsByClassName("tabcontent");     
        
        for (i = 0; i < tabcontent.length; i++) {
            tabcontent[i].style.display = "none";
        }
        tablinks = document.getElementsByClassName("tablinks");
        for (i = 0; i < tablinks.length; i++) {
            tablinks[i].className = tablinks[i].className.replace(" active", "");
        }

        document.getElementById(cityName).style.display = "block";
        evt.currentTarget.className += " active";

        //Added By Bharat T on 17th-Oct-2017 for tab section flag
        $("#hdnTab").val(cityName);
        $("#hdnSubTab").val($("#" + cityName + " button.active").text());

        console.log($("#hdnTab").val())
        console.log($("#hdnSubTab").val())
    }

    // Get the element with id="defaultOpen" and click on it
    document.getElementById("defaultOpen").click();
</script>
<script>
    function openCity1(evt, cityName) {
        var i, tabcontent1, tablinks1;

        tabcontent1 = document.getElementsByClassName("tabcontent1");

        //Added By Bharat T on 17th-Oct-2017 for sub tab section flag
        $("#hdnSubTab").val(cityName);
       

        for (i = 0; i < tabcontent1.length; i++) {
            tabcontent1[i].style.display = "none";
        }
        tablinks1 = document.getElementsByClassName("tablinks1");
        for (i = 0; i < tablinks1.length; i++) {
            tablinks1[i].className = tablinks1[i].className.replace(" active", "");
        }

        RefreshGrid(cityName);

        document.getElementById(cityName).style.display = "block";
        evt.currentTarget.className += " active";

        console.log($("#hdnTab").val())
        console.log($("#hdnSubTab").val())
    }
    // Get the element with id="defaultOpen" and click on it
    document.getElementById("defaultOpen1").click();
</script>
<script>
    function openCity2(evt, cityName) {
        var i, tabcontent2, tablinks2;
        tabcontent2 = document.getElementsByClassName("tabcontent2");

        //Added By Bharat T on 17th-Oct-2017 for sub tab section flag
        if ($("#hdnTab").val() == 'Email')
                $("#hdnSubTab").val(cityName);

        for (i = 0; i < tabcontent2.length; i++) {
            tabcontent2[i].style.display = "none";
        }
        tablinks2 = document.getElementsByClassName("tablinks2");
        for (i = 0; i < tablinks2.length; i++) {
            tablinks2[i].className = tablinks2[i].className.replace(" active", "");
        }
        document.getElementById(cityName).style.display = "block";
        evt.currentTarget.className += " active";

        console.log($("#hdnTab").val())
        console.log($("#hdnSubTab").val())
    }
    // Get the element with id="defaultOpen" and click on it
    document.getElementById("defaultOpen2").click();
</script>
<script>
    // Get the modal for Request Type button popup
    $('.modal').draggable();
    var modal = document.getElementById('id09');

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>
    <script>
        /**********************Added By Bharat T on 16th-Oct-2017 for setting page ui changes***************************************/
        $(window).load(function () {
            /**********************************Added By Bharat T on 5th-Oct-2017 for to display page in full view*************************************************/
            var ObjTd = window.frames.parent.document.getElementById('tdTree')
            var ObjImg = window.frames.parent.document.getElementById('ImgShowHide')
            var ObjLeftnavigation = window.frames.parent.document.getElementById('tblLeftNavigation')

            if (ObjTd != null && ObjImg != null) {

                ObjTd.style.display = 'none';
                ObjImg.src = '../../Images/Home/RightMove.gif';
                ObjLeftnavigation.style.display = '';
            }

            var bodyHeight = window.innerHeight - $('#MainDiv').offset().top;

            $('#MainDiv').css('height', bodyHeight - 10 + 'px');
            //*********************************************Bharat**************************************************************

            $(".table-responsive table.clsGridTable").addClass("table");
        });
    /**********************End of Added By Bharat T on 16th-Oct-2017 for setting page ui changes***************************************/
    </script>
</body>
</html>
