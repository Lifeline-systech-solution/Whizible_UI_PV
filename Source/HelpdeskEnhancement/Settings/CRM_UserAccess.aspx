<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_UserAccess.aspx.vb" Inherits="PbNIT.CRM_UserAccess" %>

<!DOCTYPE html>

<html >

<%CommonFunctions.General.PlotPageHeadTag("Role Access")%>
<head  runat="server">   
	<!-- Commented by Gauri on 14/08/24 for JQuery and Bootstrap version upgrade -->
    <%--<meta charset="utf-8" />--%>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Role Access</title>
     <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("User Access")%>--%>
    <!-- Bootstrap core CSS -->
    <%--<link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />--%>
    <%--<script src="../../../EnhancementFiles/OnlineFiles/js/jquery/2.1.4/jquery.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />--%>
   <link href="../../../EnhancementFiles/vendor/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom styles for this template -->

	
    <link href="../../../EnhancementFiles/css/editor.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/style.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/reqdetail.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/setting.css" rel="stylesheet" />
    <link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />
    <%--<link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />--%>
    <link href="../../../EnhancementFiles/css/timepicker.min.css" rel="stylesheet" />
	<%--<link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" />--%>
  
    <style>
/*Added By Yasmin on 18th july 2018*/

  .ui-tooltip {
	        padding: 4px!important;
	        position: absolute;
	        z-index: 9999;
	        max-width: 300px;
            background: #000 !important;
            color: #fff !important;
	        -webkit-box-shadow: 0!important;
	        box-shadow: 0 !important;
            border:none!important;
            font-size:11.5px!important;
        }
        .ui-tooltip-content::after, .ui-tooltip-content::before {
    top: 100%;
    border: solid transparent;
    content: " ";
    height: 0;
    width: 0;
    position: absolute;
}

.bottom .ui-tooltip-content::after {
    border-color: rgba(118, 118, 118, 0);
    border-top-color: #000;
    border-width: 6px;
    left: 50%;
    margin-left: -6px;
}

.bottom .ui-tooltip-content::before {
    border-color: rgba(118, 118, 118, 0);
    border-top-color: #000;
    border-width: 6px;
    left: 50%;
    margin-left: -6px;
}

.top .ui-tooltip-content::after {
    top: -6px;
    left: 50%;
    border-bottom-color: #000;
    
    border-width: 0 6px 6px;
    margin-left: -6px;
}

.top .ui-tooltip-content::before {
     border-color: rgba(118, 118, 118, 0);
     border-bottom-color: #000;
     top: -6px;
     left: 50%;
     border-width: 0 6px 6px;
     margin-left: -6px;
 }
    .v-tabs .tabcontent {
    float: left;
    padding: 0;
    border-style: solid;
    border-color: #647ea8;
    border-width:0px 0px 0px 0px!important; 
     width: 100%; 
    border-left: none;
    height: 1214px;
}
   .tablinks.active, .tablinks1.active, .h-tabs div.tab button.tablinks1.active, .h-tabs div.tab button.tablinks2.active, .h-tabs div.tab button.tablinks3.active {
    color: #4caac0 !important;
    border: none !important;
    text-decoration: underline !important;
}

   .content-wrapper {
    margin-left: 0px !important;
}
   .panel-body {
            OVERFLOW: auto!important;
            /*HEIGHT: 161PX!important;*/
            /*commented By Kashish for ui change*/
            /*width: 106%;*/
            padding-left: 4%!important;
}

        .pannel-section {
             overflow: auto!important;
             /*height: 454px;*/
             overflow-x: hidden!important;
             width: 101%!important;
             /*padding-right: 9%!important;*/
    /* padding-left: 0%; */
}
       
       #divRole .collapseOne2 {
            overflow:hidden!important;
            width:100%!important;
        }
        #divEmployee {
        /*overflow: auto!important;*/
            /*margin-bottom: 9px;*/
           height: 100%!important;
          }
        /*Added by yasmin for pagination alignment on 3rd july 2018*/
            .container-fluid {
                min-height: 100%!important;
            }

       
        #cboDepartment {
            height:29px!important;
        }
           #CboRole {
            height:29px!important;
        }
              #CboStatus {
            height:29px!important;
        }
              .h-tabs .bottom-bar .form-group {
                  padding: 0px 0!important;
}
        .clsGridTable {
            width:100%!important;
        }
           .clsTRColumnHeader th:nth-child(4) {
        text-align:center;
        }
         .clsTRColumnHeader th:nth-child(5) {
        text-align:center;
        }
        /*.table-responsive table tbody {
        overflow:auto;
        }*/
        #divRole .dataTables_wrapper .row:nth-child(1) {
        display:none;
        }

         
        .table-responsive {
        overflow:hidden;
        }

        /*#divRole .table-bordered .row:nth-child(1) {
            display:none!important;
        }*/
            #divRole .dataTables_scrollBody .clsTRColumnHeader{
           height:0PX!important;
        }

        #divRole .dataTables_paginate {
            float:right!important;
        }
          #divRole .dataTables_paginate ul {
             margin-top: 2%!important;
             margin-left: -5%!important;
        }
        .h-form .form-horizontal .control-label {
            font-weight:100!important;
        }
        .fa-pencil-square-o {
            color:#4caac0 !important;
        }
        #divRole .dataTables_scrollBody {
           overflow: auto!important;
            width: 100%!important;
            height: 132px!important;
            padding-right: 1.8%!important;
}

        #divRole .dataTables_scroll {
            overflow: hidden!important;
            width: 100%!important;

        }
           #divEmployee .dataTables_scrollBody {
             overflow: auto!important;
            width: 100%!important;
            height: 132px!important;
            padding-right: 2%!important;
        }

        #divEmployee .dataTables_scroll {
            overflow: hidden!important;
            width: 100%!important;

        }
         #divEmployee .dataTables_wrapper .row:nth-child(1) {
        display:none;
        }

        #divEmployee .dataTables_scrollBody .clsTRColumnHeader{
            height:0PX!important;
        }
          #divEmployee table tr tH:nth-child(4) {
               text-align:left;
            }

        #divEmployee .dataTables_paginate {
            float:right!important;
        }
          /*Commented by yasmin for pagination alignment on 3rd july 2018*/
          /*#divEmployee .dataTables_paginate ul {
             margin-top:1%!important;
             margin-left: -5%!important;
        }*/

        .h-tabs div#headingOne {
            height:36px!important;
        }
        /*Added by yasmin for pagination alignment on 3rd july 2018*/

        #divEmployee .dataTables_paginate {
            float: right!important;
            margin-right: 1PX;
            margin-top: -10px;
           
        }

        .form-control {
            font-weight:100!important;
        }
         
           #divEmployee table tr th {
             border:1px solid #ddd!important;
              
            }

            #divRole table tr th {
             border:1px solid #ddd!important;
              
            }
            .h-tabs .top-bar {
             padding: 11px 13px 1px 16px!important;
}
        div.tab {
            margin-left:-2%!important;
        }

        .bottom-bar {
            width:97.5%!important;
        }

         .h-tabs .table-responsive {
            border-bottom: 1px solid white!important;
        }
          .panel
        {
            margin-left:1.4%!important;
        }

        .h-tabs .bottom-bar .form-group {
            margin-left:-4%!important;
        }

        #CboDepartmentUnitEdit {
            height:29px!important;
        }

         #CboRoleEdit {
            height:29px!important;
        }

          #CboReportingTo {
            height:29px!important;
        }

           #CboEmplyeeType {
            height:29px!important;
        }
               #BusinessGroupID {
            height:29px!important;
        }
    #CboOrganizationUnit {
            height:29px!important;
        }

        .dataTables_info {
            margin-top:2%!important;
            font-size: 13px!important;
        }

        /*.right {
            margin-right:4%!important;
        }*/


        #CboRoleDepartMent {
            height:29px!important;
        }
         #CboModule {
            height:29px!important;
        }
        #Cbolevel {
              height:29px!important;
        }
        
         /*.faSettingSearch {
    position: absolute;
    margin-top: 14px;
    margin-left: 10px;
}*/
        .top-bar {
       padding-top :0px !important;
        }
         #UserMaster {
        width:100%;
          overflow:hidden;
      }
        #divEmployeeScroll {
        width:102%;
        padding-right:2%;
        overflow:auto;
      }
            .panel
        {
            margin-left:1.4% !important;
              margin-right:1.4% !important;
        }
             .panel-body .right {
        margin-right:35px;
        }
/*'/*Commented By Yasmin on 25th july 2018*/
        /*.col-xs-1 {
        border: 1px solid #ddd;
    border-radius: 35px;
        }*/
        .bros-btn .btn-default {
    color: #364660;
    padding: 3px 16px;
    background: #fff;
    border: 1px solid #d3cfd0;
    margin-left: 15px;
}

        #file {
        display:none;
        }
        .form-horizontal {
        overflow-x:hidden;
        }
        .bros-btn {
            float:none;
    margin: 4px 0px 15px -9PX;
    margin-top: -16px;
    margin-left: 5px!important;
    /*margin-top: 10px!important;*/
}
        #UploadImage .col-xs-1 {
        height:75PX!important;
        width:75PX !important;
        }

        #btnSelectFile {
        white-space:inherit;
        }
        #UploadImage {
        margin-left:72px;
        }
        /*#btnSelectFile:hover {
        font-size:11px !important;
        font-weight:normal !important;
        }*/
        /*#imgUser {
            height: 30px;
            width: 30px;
            border-radius: 50%;
        }*/
        /*Commented By Yasmin on 25th july 2018*/
        #imgUser {
    height: 75px;
    width: 75px;
    border-radius: 50%;
    /*margin-top: 16px;*/
    margin-left: -5px;
}

        #CboDeployable {
            height:29px!important;
             /*Added by Usha Pandit on 16.12.2017 for alignment */
             margin-top: 6px!important;
             /*End of addition*/
        }

        .right .btn-default {
            background-color:white!important;
            color:black!important;
        }
        .right .btn-default:hover {
            background:white !important;
            color:black !important;
	    }
        #divdelopable .col-sm-4{
           margin-top:0px!important;

        }

        #new{
           margin-top: 5px!important;

        }

         #new1{
           margin-top: 5px!important;

        }
        .h-form .form-horizontal .control-label {
            margin-top:12px!important;
        }
        #divdelopable
        {
            margin-top:6px;
        }
        #Bdate   {
        width: 177px!important;
        }
     #JoiningDate   {
        width: 177px!important;
        }
     #ExDate   {
        width: 177px!important;
        }
     #DateIssue   {
        width: 177px!important;
        }
     
    #LeavingDate   {
        width: 177px!important;
        }

    #TentativeLeavingDate   {
        width: 177px!important;
        }
      
        .fcal {
            float: left;
            /*'/*Added by Kashish for ui change*/
            margin-left: 40px!important;
            margin-top: 12px!important;
        }
    #checkSameasall{
    margin-top:14px;
    }
    #LDAPCHECk
    {margin-top:14px;
    }
    #fileUpload
    {display:none;
    }
    #EditImage
    {
    padding-left:11%;
    }
    #collapseOne8
    {
    height:auto !important;
    }
    
    /*#idPlus{
   
     display: block !important;
    color: #fff;
    float: right;
    padding-top: 5px;
    margin-left: 5px;

}*/
        #idPlus {
            display:inline-block !important;
        }
    #idStatus
    {
    margin-top:13px;
    }
        #tblEmployee {
    padding-left: 10px;
    padding-right: 10px;
}
        /*Dipali V on 22nd Dec 2017 For Button Border Color*/
        .btn-primary {
               border-color:none!important;
        }
          /*End of Dipali V on 22nd Dec 2017 For Button Border Color*/
 </style> 

  <body class="" id="page-top">
  <%--  //  <form id="employee">--%>
    <input type="hidden" id="hdnMode" name="hdnMode" value="" />
    <input type="hidden" id="hdnEmployeeID" name="hdnEmployeeID" value="" />
       <input type="hidden" id="hdnRoleID" name="hdnRoleID" value="" />
    <input type="hidden" id="hdnLoadFilterID" name="hdnLoadFilterID" value="" />
    
  <% WriteTabsControls("", "Load", "")%>

	<!-- -----Department in Working Hours button popup---------------------------->
	<div id="id15" class="modal">
  
  <form class="modal-content animate" action="/action_page.php">
    <div class="imgcontainer">
	<span class="appro-title">Working Hours</span>
      <span onclick="document.getElementById('id15').style.display='none'" class="close" title="Close Modal">&times;</span>
    </div>
    <div class="container">	
			<div class="h-tabs">
			<div class="table-responsive">          
									  <table class="table">
										<thead>
										  <tr>
											<th>Week Days</th>
											<th>Working Day</th>
											<th>From Time</th>
											<th>To Time</th>
											<th>Edit</th>
											<th></th>
										  </tr>
										</thead>
										<tbody>									  
										  <tr>
											<td>1-Monday</td>
											<td><input type="checkbox" id="checkall"></td>
											<td>3:30 AM</td>
											<td>4:30 AM</td>
											<td><i class="fa fa-pencil-square-o" aria-hidden="true" style="color:#1e88e5;"></i></td>		
											<td><button type="button" class="btn btn-default" style="background-color:#343660;color:#fff;">Save</button></td>
										  </tr>
											
										  <tr>
											<td>1-Monday</td>
											<td><input type="checkbox" id="checkall"></td>
											<td>3:30 AM</td>
											<td>4:30 AM</td>
											<td><i class="fa fa-pencil-square-o" aria-hidden="true" style="color:#1e88e5;"></i></td>	
											<td></td>
										  </tr>	
										  
										  <tr>
											<td>1-Monday</td>
											<td><input type="checkbox" id="checkall"></td>
											<td>3:30 AM</td>
											<td>4:30 AM</td>
											<td><i class="fa fa-pencil-square-o" aria-hidden="true" style="color:#1e88e5;"></i></td>
											<td></td>
										  </tr>	
										  
										  <tr>
											<td>2-Friday</td>
											<td><input type="checkbox" id="checkall"></td>
											<td>3:30 AM</td>
											<td>4:30 AM</td>
											<td><i class="fa fa-pencil-square-o" aria-hidden="true" style="color:#1e88e5;"></i></td>	
											<td></td>
										  </tr>								  
										</tbody>
									  </table>
									  </div>
				</div>	
    </div>
  </form>

      
</div>
	
<!-- ----- Request Type Mapping button popup---------------------------->
	<div id="id09" class="modal">
  
  <form class="modal-content animate" action="/action_page.php">
    <div class="imgcontainer">
	<span class="appro-title">Request Type Mapping</span>
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

<!-- ----- Shoe History in Sevirity button popup---------------------------->
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

<!-- ----- Show History in Email tab button popup---------------------------->
	<div id="id13" class="modal">
  
  <form class="modal-content animate" action="/action_page.php">
    <div class="imgcontainer">
	<span class="appro-title">Show History</span>
      <span onclick="document.getElementById('id13').style.display='none'" class="close" title="Close Modal">&times;</span>
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
											<td>Subject</td>
											<td>25 Augast 2017    3:30 AM</td>
											<td>IR submitted [Project: PROJECT_NAME IR ID: <IR_ID>].</td>
											<td>Admin</td>
										  </tr>											  
										  									  
										</tbody>
									  </table>
									  </div>
				</div>
    </div>
  </form>
</div>

<!-- popup -->
<!-- Modal -->
  <div class="modal fade filter-popup" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Modal Header</h4>
        </div>
        <div class="modal-body">
          <p>Some text in the modal.</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  <%-- </form>	--%>
  </body> 
	
    <%-- <script src="../../../EnhancementFiles/OnlineFiles/js/jquery/2.1.4/jquery.min.js"></script>
	
    <script src="../../../EnhancementFiles/OnlineFiles/js/Bootstrap/3.3.5/Bootstrap.min.js"></script>--%>

		<%--<script src="js/editor.js"></script>--%>
    <script src="../../../EnhancementFiles/js/editor.js"></script>

		<%--<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>
    <%--<script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>--%>
        <link href="../../../EnhancementFiles/OnlineFiles/datepicker/datepicker3.css" rel="stylesheet" />
<script src="../../../EnhancementFiles/OnlineFiles/datepicker/bootstrap-datepicker.js"></script>
<!-- Time picker -->
<%--<script src="js/timepicker.min.js"></script>
<script src="js/timepicker.js"></script>--%>
    <script src="../../../EnhancementFiles/js/timepicker.js"></script>
    <script src="../../../EnhancementFiles/js/timepicker.min.js"></script>

    <%--<script src="../../General/CommonFunctions.js"></script>
	 <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 
	<script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script>--%>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>
<!-- Time picker -->
<script src="js/timepicker.min.js"></script>
<script src="js/timepicker.js"></script>
<script>
    /*Added By Yasmin on 25th july 2018*/

		$(function(){
		    //$('#Bdate').timepicker();
		    //$('#DateIssue').timepicker();
		    
		    //$('#ExDate').timepicker();
		});
		$(function () {
		    $(document).tooltip({
		        position: {
		            my: "center bottom-20",
		            at: "center top",
		            using: function (position, feedback) {
		                $(this).css(position);
		                $(this)
                            .addClass(feedback.vertical);
		            }
		        }
		    });

		});
		$("[title]").click(function () {
		    $('.ui-tooltip').fadeOut('fast', function () {
		        $('.ui-tooltip').remove();
		    });
		});
</script>

<!-- End of time picker -->
   <script>
			$( function() {
			
			    $('#Bdate').datepicker({
			        orientation: "auto",
			    });
				$('#DateIssue').datepicker({
				});
				$('#DateIssue').focus(function () {
				    $("#ui-datepicker-div").css("top", parseFloat(parseFloat(String($("#ui-datepicker-div").css("top")).replace('px', ''))) - 240 + 'px')
				})
				$('#ExDate').datepicker({
				    orientation: "auto",
				});
				$('#ExDate').focus(function () {
				    $("#ui-datepicker-div").css("top", parseFloat(parseFloat(String($("#ui-datepicker-div").css("top")).replace('px', ''))) - 240 + 'px')
				})
				$('#JoiningDate').datepicker({
				    orientation: "auto",
				});
				$('#TentativeLeavingDate').datepicker({
				    orientation: "auto",
				});
				$('#LeavingDate').datepicker({
				    orientation: "auto",
				});
				
			} );
	</script>

    
<script>
			$(document).ready(function() {
				$("#txtEditor").Editor();
				$("#txtEditor1").Editor();
				$("#txtEditor2").Editor();
				$("#txtEditor3").Editor();
				$(function () {
				    $(document).tooltip({
				        position: {
				            my: "center bottom-20",
				            at: "center top",
				            using: function (position, feedback) {
				                $(this).css(position);
				                $(this)
                                    .addClass(feedback.vertical);
				            }
				        }
				    });

				});
			});
</script>
    

<script>
    var globalCityName, globalRoleID, intDivGridListHeight;
    var globalEmployeeID = 0;
    $('[data-toggle="tooltip"]').tooltip();
    $(document).click(function () {
        //alert(window.parent.parent.parent.location);
        $("#profileDropdwn", window.parent.parent.parent.document).parent().removeClass("open");
        $("#ulUserThemes", window.parent.parent.parent.document).parent().removeClass("open");

    })
    $(document).ready(function () {
         
        $('[data-toggle="tooltip"]').tooltip();
        $('.fa').tooltip();

        $(".dataTables_scrollHeadInner").each(function () {
           // $(this).css("width", dtwidth);
        });
        var TypeDiv; var accordion;
        TypeDiv = document.getElementById('divEmployee');
        accordion = document.getElementsByClassName('pannel-section');
        var intDivGridHeight
        imgsrc = $('#imgUser').attr('src'); //Added by Usha Pandit on 16.12.2017 for image upload validation
        RefreshPagePlot();
        //Added by Yogesh Jalamkar on 20-DEC-2017 Purpose: Default image should display.
        $('#imgUser').attr('src', '../../../Images/Photo/no-photo.png');
        $("#imgUser").css('margin-left', '-16px');
        $("#imgUser").css('margin-top', '-1px');
       
        //End by yogesh Jalamkar
    });

  
   // document.getElementById('hdnEmployeeID').value = "0"
function openCity(evt, cityName) {
    var i, tabcontent3, tablinks3;
    globalCityName = cityName;
    tabcontent3 = document.getElementsByClassName("tabcontent3");
    for (i = 0; i < tabcontent3.length; i++) {
        tabcontent3[i].style.display = "none";
    }
    tablinks3 = document.getElementsByClassName("tablinks3");
    for (i = 0; i < tablinks3.length; i++) {
        tablinks3[i].className = tablinks3[i].className.replace(" active", "");
    }
  
    document.getElementById(cityName).style.display = "block";
    evt.currentTarget.className += " active";
    PlotGridControls(cityName);

}
// Get the element with id="defaultOpen" and click on it
//document.getElementById("defaultOpen3").click();


        function Page_OnClick(PageNumber) {
	        var strMode = $("#hdnMode").val();
	      //  RefreshGrid(globalCityName);
	    }
	    function PreviousePage(PageNumber) {
	        
	        if (PageNumber < 1 ) {
	            //alert("You are on the First page");
	            alertify.set('notifier', 'position', 'top-right');
	            alertify.notify('You are on the First page!', 'success');
	        }
	        else {
	            $("#hdnCurrentPage").val(PageNumber);
	            Page_OnClick(PageNumber);
	        }
	    }
	    //function NextPage(PageNumber) {
	    //    debugger;
	    //    var TotalNoOfPages = $("#hidNoOfPages").val();
	        
	    //    alert(TotalNoOfPages);
	    //    if (PageNumber > TotalNoOfPages) {
	    //        //alert("You are on the last page");
	    //        alertify.set('notifier', 'position', 'top-right');
	    //        alertify.notify('You are on the last page!', 'success');
	    //    }
	    //    else {
	    //        $("#hdnCurrentPage").val(PageNumber);
	    //        Page_OnClick(PageNumber);
	    //    }
	    //}
	    //function FirstPage(PageNumber) {	       
	    //    var TotalNoOfPages = $("#hidNoOfPages").val();

	      
	    //    if (PageNumber == $("#hdnCurrentPage").val()) {
	    //        //alert("You are on the First page");
	    //        alertify.set('notifier', 'position', 'top-right');
	    //        alertify.notify('You are on the First page!', 'success');
	    //    }
	    //    else {
	    //        $("#hdnCurrentPage").val(PageNumber);
	    //        Page_OnClick(PageNumber);
	    //    }
	    //}
	    //function LastPage(PageNumber) {
	    //    var TotalNoOfPages = $("#hidNoOfPages").val();	      

	    //    if (TotalNoOfPages == $("#hdnCurrentPage").val()) {
	    //        //alert("You are on the last page");
	    //        alertify.set('notifier', 'position', 'top-right');
	    //        alertify.notify('You are on the last page!', 'success');
	    //    }
	    //    else {
	    //        $("#hdnCurrentPage").val(PageNumber);
	    //        Page_OnClick(PageNumber);
	    //    }
	    //}

	 

	  
	    //function RefreshGrid(cityName) {
	    //    var strResult, data;
	    //    var GridParameter = {};


	    //    GridParameter.cityName = cityName;

	    //    data = JSON.stringify({ GridParameter: GridParameter, Department: "", Role : "", Status:"" });

	    //    strResult = AJAXCallWithResult(strPageName + "/RefreshGrid", data, false);

	    //    if (strResult.d != '')
	    //    {
	    //        if (String(cityName).toUpperCase() != "AUTOCLOSE")
	    //        {
	    //            $("#" + cityName + " .table-responsive:first").html(strResult.d);

	    //            $("#" + cityName + " .table-responsive:first table").addClass("table");
	    //        }
	    //    }

	    //    if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {

	    //        intDivGridListHeight = parseInt(window.innerHeight) - 360;
	    //        alert(intDivGridListHeight);
	    //    }
	    //    else {
	    //        //  intDivGridListHeight = (window.innerHeight / 3) + 6;
	    //        intDivGridListHeight = parseInt(window.innerHeight) - 360;
	    //        alert(intDivGridListHeight);
	    //    }
       
	    //    // $(".table-responsive tbody").css("overflow", "auto");
	    //    $(".table-responsive").css("height", intDivGridListHeight + "px");
	    //    $(".pannel-section").css("height", intDivGridListHeight + "px");

	        
	    //    datatables("divEmployee", 'SearchRquestType');
	    //    datatables("divRole", 'SearchRole');
	    //    setWidthEmployee();

	    //    //$("#divRole .panel-body").each(function () {
	    //    //    $(this).css("height", "161px");
	    //    //});

	    //    //$("#divEmployee .panel-body").each(function () {
	    //    //    $(this).css("height", "161px");
	    //    //});
    //}

	    var strPageName = "CRM_UserAccess.aspx";
	    function RefreshGrid(cityName) {
	       // debugger;
	        var strResult, data;
	        var GridParameter = {};
	        cityName = "UserMaster";
	        GridParameter.cityName = cityName;

	        data = JSON.stringify({ GridParameter: GridParameter , Department: "", Role : "", Status:"" });
	       // alert(data);
	        strResult = AJAXCallWithResult(strPageName + "/RefreshGrid", data, false);
	        var DivId;
	       // alert(strResult);
	        var DivSerach;
	        //alert(strResult.d);
	        if (strResult != '' && strResult != 'undefined') {
	            DivId = "divEmployee";
	            DivSerach = "SearchRquestType";
                
	            $("#" + cityName + " .table-responsive:first").html(strResult.d);

	            $("#" + cityName + " .table-responsive:first table").addClass("table");
	        }
	        RefreshPagePlot();

	    }

	    function RefreshPagePlot() {
	        // debugger;
	        var strResult, data;
	        var GridParameter = {};
             
	        DivId = "divEmployee";
	        DivSerach = "SearchRquestType";
	            
	        var TypeDiv; var accordion;
	       
	        var intDivGridHeight
	      
	        
	            intDivGridHeight = (window.innerHeight / 2);
	            intDivGridListHeight = parseInt(window.innerHeight);
	            if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
	                $('#divEmployeeScroll').css('height', intDivGridListHeight - 270 + "px");
	            }
	            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
	                $('#divEmployeeScroll').css('height', intDivGridListHeight - 270 + "px");
	            }
	            else {
	                $('#divEmployeeScroll').css('height', intDivGridListHeight - 270 + "px");
	            }
	            
	           
	        datatables(DivId, DivSerach);
	       
	    }
        function PlotGridControls(cityName) {
	        // debugger;
	        var strResult, data;
	        var GridParameter = {};

	        GridParameter.cityName = cityName;

	        data = JSON.stringify({ GridParameter: GridParameter, Department: "", Role: "", Status: "" });
	        // alert(data);
	        strResult = AJAXCallWithResult(strPageName + "/RefreshPlotControls", data, false);
	        var DivId;
	        // alert(strResult);
	        var DivSerach;
	        //alert(strResult.d);
	        if (strResult != '' && strResult != 'undefined') {
	            if (cityName == "UserMaster") {
	                DivId = "divEmployee";
	                DivSerach = "SearchRquestType";
	            }
	            else if (cityName == "RoleMaster") {
	                DivId = "divRole";
	                DivSerach = "SearchRole";
	            }
                $("#" + cityName).html(strResult.d);
	         
	        }
	        var TypeDiv; var accordion;
	        TypeDiv = document.getElementById('divEmployee');
	        accordion = document.getElementsByClassName('pannel-section');
	        var intDivGridHeight

	        if (WhichBrowser() == "IE") {
	            intDivGridHeight = (window.innerHeight / 2);

	            if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
	                //  alert(1);
	                intDivGridListHeight = parseInt(window.innerHeight) - 320;
	            }
	            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
	                //   alert(2);
	                intDivGridListHeight = parseInt(window.innerHeight) - 320;
	            }
	            else {

	                intDivGridListHeight = parseInt(window.innerHeight) - 500;
	            }
	            //  alert(intDivGridListHeight);
	            $('.pannel-section').css('height', intDivGridListHeight + "px");
	            //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);
	            $('#' + DivId).css('height', intDivGridListHeight + "px");
	        }
	        else {
	            intDivGridHeight = (window.innerHeight / 2);
	            // alert(intDivGridHeight);
	            if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1024) {
	                intDivGridListHeight = parseInt(window.innerHeight) - 385;
	            }
	            else if (parseInt(window.innerHeight) <= 768 && parseInt(window.innerWidth) <= 1366) {
	                intDivGridListHeight = parseInt(window.innerHeight) - 385;
	            }
	            else {

	                intDivGridListHeight = parseInt(window.innerHeight) - 500;
	            }

	            $('.panel-body').css('height', intDivGridListHeight - 20 + "px");
	            //  $('#divRequestTypes').css('height', intDivGridListHeight + 20);
	            $('#' + DivId).css('height', intDivGridListHeight + 15 + "px");
	        }

	        datatables(DivId, DivSerach);
	        // datatables("divEmployee", 'SearchRquestType');
	        // datatables("divRole", 'SearchRole');





	        // $(".table-responsive tbody").css("overflow", "auto");
	        // $(".table-responsive").css("height", intDivGridListHeight + "px");

	    }
	    function datatables(divID, txtBoxID) {
	        $('#' + divID + ' > table').removeClass("clsGridTable");
	        $('#' + divID + ' table').addClass("table table-bordered table-stripped");
	        var table = $('#' + divID + ' > table').DataTable({

	            responsive: true, "pageLength": 3,
	          //  scrollY: '116px',
	            pagingType: "simple_numbers",
	          //  scrollX: true,
	            language: {
	                //paginate: {
	                //    first: '<i class="fa fa-angle-left" data-toggle="tooltip" title="First"></i>',
	                //    next: 'Next <i class="fa fa-angle-double-right" title="Next"></i>',
	                //    previous: '<i class="fa fa-angle-double-left" title="Previous"> Previous</i>',
	                //    last: '<i class="fa fa-angle-right" title="Last"></i>'
	                //}
	            },
	        });
	        // debugger;
	        if (txtBoxID != "") {
	            $('#' + txtBoxID).on('keyup change', function () {
	                table.search($(this).val()).draw();
	            })
	        }
	    }
	    function SelectRoleAll_Checkbox(obj)
	    {
	       // $("input[name=chkchkRoleMasterSelect]").prop('checked', true);

	        if ($(obj).is(':checked'))
	            //  $("input[name=chkchkRoleMasterSelect]").prop('checked', true);
	            $("input[name=chkchkRoleMasterSelect]:not(:disabled)").prop('checked', true);
	        else
	            $("input[name=chkchkRoleMasterSelect]").prop('checked', false);
	    }


	    function SelectAll_Checkbox(obj)
	    {
	        var table = $('#divEmployee table').DataTable();
	        var rows = table.rows({ 'search': 'applied' }).nodes();

	        if ($(obj).is(':checked'))
	            // $("input[name=chkUserMasterSelect]").prop('checked', true);
	            //$("input[name=chkUserMasterSelect]:not(:disabled)").prop('checked', true);
	            $('input[type="checkbox"]:not(:disabled)', rows).prop('checked', true);
	        else
	            //$("input[name=chkUserMasterSelect]").prop('checked', false);
	            $('input[type="checkbox"]', rows).prop('checked', false);
	       
	    }

	    function Role_OnClick(ROLEID)
	    {
	        //alert(ROLEID);
	        globalRoleID = ROLEID;
	        document.getElementById('hdnRoleID').value = globalRoleID;
	        data = JSON.stringify({ RoleID: ROLEID });
	        strResult = AJAXCallWithResult("CRM_User_RoleAccess.aspx/GetRoleDetails", data, false);

	        if (strResult.d != "")
	        {
	            var arrResult = strResult.d.split("#$#");

	            //  alert(strResult.d);

	            $("#RoleDescription").val(arrResult[0]);
	            $("#Cbolevel").val(arrResult[2]);
	            $("#CboModule").val(arrResult[1]);

	           
	            if (arrResult[3] == "True") {
	              
	                $("#GenerateInvoice").prop('checked', true);

	            }
	            else {

	                $("#GenerateInvoice").prop('checked', false);
	            }
	          

	            if (arrResult[4] == "True") {

	                $("#SalesActivity").prop('checked', true);

	            }
	            else {

	                $("#SalesActivity").prop('checked', false);
	            }

	            if (arrResult[5] == "True") {

	                $("#CheckAssignment").prop('checked', true);

	            }
	            else {

	                $("#CheckAssignment").prop('checked', false);
	            }

	            $('#textBillingRate').val(arrResult[6]);
	            $('#TextCost').val(arrResult[7]);
	            $('#CboRoleDepartMent').val(arrResult[8]);

	            $("#collapseOne2").addClass('in')
	            
	        }
	    }
	  
	    function AddRole() {
	       
	     
	        $("#RoleButton").css("display", "none");
	        $("#tblrole").css("display", "none");
	      
	       // document.getElementById("#divRole.panel-body").style.setProperty("height", "450px", "!important");
	        $("#collapseOne2").addClass('in');
	       // document.getElementsByClassName('.bottom-bar')
	        $(".bottom-bar").css("margin-top", "1%")

	        // $("#divRole .panel-body").css("height", "450px")
	        $("#divRole .panel-body").each(function () {
	            $(this).css("height", "450px");
	        });
	        CancelRole();
	       
	    }

	
	    var RoleID;
	    function SaveRole()
	    {
	        //debugger;
	       if (ValidateRole() == 0)
	       {

	          // alert(ValidateRole());
	           //debugger;

	           if (document.getElementById('hdnRoleID').value == '') {
	               RoleID = 0;

	           }
	           else {

	               RoleID = globalRoleID;

	           }
	            var RoleDescription = $("#RoleDescription").val();
	            var Module = $("#CboModule").val();
	            var level = $("#Cbolevel").val();
                var textBillingRate = $('#textBillingRate').val();
	            var TextCost = $('#TextCost').val();
	            var CboRoleDepartMent = $('#CboRoleDepartMent').val();
	            var GenerateInvoicevalue, SalesActivityvalue, CheckAssignmentvalue;
	            var GenerateInvoice = document.getElementById('GenerateInvoice');
	            if (GenerateInvoice.checked == true) {
	               // alert(GenerateInvoice.checked);
	                 GenerateInvoicevalue = 1;

	            }
	            else {

	                 GenerateInvoicevalue = 0;
	            }
	            var SalesActivity = document.getElementById('SalesActivity'); 

	            if (SalesActivity.checked == true) {

	                SalesActivityvalue = 1;

	            }
	            else {

	                SalesActivityvalue = 0;
	            }

	            var CheckAssignment = document.getElementById('CheckAssignment');
	            if (CheckAssignment.checked == true) {

	                CheckAssignmentvalue = 1;

	            }
	            else {

	                CheckAssignmentvalue = 0;
	            }


	          
	            data = JSON.stringify({ RoleDescription: RoleDescription, ModuleValue: Module, level: level, textBillingRate: textBillingRate, TextCost: TextCost, CboRoleDepartMent: CboRoleDepartMent, GenerateInvoicevalue: GenerateInvoicevalue, SalesActivityvalue: SalesActivityvalue, CheckAssignmentvalue: CheckAssignmentvalue, RoleID: RoleID });
	          //  alert(data);
	            strResult = AJAXCallWithResult("CRM_User_RoleAccess.aspx/SaveRoleDescription", data, false);

	            if (strResult.d != "")
	            {


	                // alert(strResult.d);
	                alertify.set('notifier', 'position', 'top-right');
	                alertify.notify('Role Created successfully!!!!', 'success');
                   $("#collapseOne2").removeClass('in');
	                RefreshGrid('RoleMaster');
	               // var rowpos = $('#divRole .clsGridTable tr:last').position();
                   // $('#divRole').scrollTop(rowpos.top);
                  
	               
	               

	            }
	        }

 }



	    function ValidateRole() {
	        //debugger;
	        var checkvalue = 0;
	        var Flag = 0;
	        var strmsg = "";
	        var errorMsg = "<ul>"

	        var RoleDescription = document.getElementById('RoleDescription');
	        var CboModule = document.getElementById('CboModule');
	        var Cbolevel = document.getElementById('Cbolevel');
	        var textBillingRate = document.getElementById('textBillingRate');
	        var TextCost = document.getElementById('TextCost');
	        var CboRoleDepartMent = document.getElementById('CboRoleDepartMent');



	        if ($("#RoleDescription").val() == "") {
	            //  alertify.set('notifier', 'position', 'top-right');
	            strmsg = '- Role Description should not be left blank';
	            errorMsg += "<li>" + strmsg + "</li>";
	            //   alertify.notify('Employee Code Already Exists', 'error');
	            checkvalue = 1;
	           //  alertify.notify('Please Select  Role Description', 'error');
	            Flag = 1;
	           // checkvalue = 1;
	        }

	        if ($("#RoleDescription").val() != "") 
	        {
	            var StrRoleDescription = "<%=StrRoleDescription%>";
	            //alert(StrEmployeeCode);
	            if (StrRoleDescription.indexOf(',' + $('#RoleDescription').val() + ',') != -1) {
	                // alert("Title Already Exists");
	                strmsg = '- Role Description  Already Exists';
	                errorMsg += "<li>" + strmsg + "</li>";
	                //   alertify.notify('Employee Code Already Exists', 'error');
	                checkvalue = 1;

	            }
                 if (checkSpecialCharacter($('#RoleDescription').val()) == true) {
	                // alertify.set('notifier', 'position', 'top-right');
	                strmsg = '- A Role Description cannot contain any of these /\\:*?<>|,"+- Characters';
	                errorMsg += "<li>" + strmsg + "</li>";
	                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
	                checkvalue = 1;

                 }
	        }


	     
                  if ($("#Cbolevel").val() == "") {
                   
                    alertify.set('notifier', 'position', 'top-right');
                    strmsg = ' - Level should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                    //alertify.notify('Please Select  Level', 'error');
                    checkvalue = 1;
                }


                if ($("#textBillingRate").val() == "") 
                {
                    //alertify.set('notifier', 'position', 'top-right');
                    strmsg = ' - Standard Billing Rate should not be left blank';
                    errorMsg += "<li>" + strmsg + "</li>";
                   // alertify.notify('Please Enter Standard Billing Rate', 'error');
                    checkvalue = 1;
                }



               // if (checkvalue == 0) {
                if ($("#textBillingRate").val() != "") 
                {
                     

                        if (checkSpecialCharacter($('#textBillingRate').val()) == true) {
                            //alertify.set('notifier', 'position', 'top-right');
                            strmsg = ' - A  Standard Billing Rate cannot contain any of these /\\:*?<>|,"+- Characters';
                            errorMsg += "<li>" + strmsg + "</li>";
                            //alertify.notify('A  Standard Billing Rate cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                            checkvalue = 1;

                        }

                      else  if (RestrictNonNumeric(document.getElementById('textBillingRate')) == true) {
                            // alertify.set('notifier', 'position', 'top-right');
                            strmsg = ' - Please Enter only positive numeric value for Standard Billing Rate numeric values !!!';
                            errorMsg += "<li>" + strmsg + "</li>";
                            //alertify.notify('', 'error');
                            checkvalue = 1;

                        }
                }
                
               
                if ($("#TextCost").val() == "") 
                {
                    // alertify.set('notifier', 'position', 'top-right');
                    strmsg = ' - Please Enter Cost';
                    errorMsg += "<li>" + strmsg + "</li>";
                   // alertify.notify('Please Enter Cost', 'error');
                    checkvalue = 1;
                }
                


             
                if ($("#TextCost").val() != "") 
                {
                    
                        if (checkSpecialCharacter($('#TextCost').val()) == true) {
                           // alertify.set('notifier', 'position', 'top-right');
                            // alertify.notify('A  Cost cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                            strmsg = ' - A  Cost cannot contain any of these /\\:*?<>|,"+- Characters';
                            errorMsg += "<li>" + strmsg + "</li>";
                            checkvalue = 1;

                        }

                      else  if (RestrictNonNumeric(document.getElementById('TextCost')) == true) {
                            // alertify.set('notifier', 'position', 'top-right');
                            //alertify.notify('Please Enter only positive numeric value for Cost numeric values !!!', 'error');
                            strmsg = ' - Please Enter only positive numeric value for Cost numeric values !!!';
                            errorMsg += "<li>" + strmsg + "</li>";
                            checkvalue = 1;

                        }



                    }
                

              
                if ($("#CboModule").val() == "")
                {
                    //  alertify.set('notifier', 'position', 'top-right');
                         strmsg = ' - Please Select Module';
                         errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                       
                    }
               
               
                 if ($("#CboRoleDepartMent").val() == "") {
                     // alertify.set('notifier', 'position', 'top-right');
                     strmsg = ' - Please Select  Department/Unit';
                     errorMsg += "<li>" + strmsg + "</li>";
                   
                    checkvalue = 1;
                  }
                
                 if (strmsg != "")
                 {
                     alertify.set('notifier', 'position', 'top-right');
                     alertify.notify(errorMsg, 'error', 15);

                 }

            return checkvalue;
        }

	   
	    function AddSaveRole() {

	        SaveRole();
	        CancelRole();
	        //$("#RoleDescription").val("");
	        //$("#Cbolevel").val("");
	        //$("#CboModule").val("");
	        //$('#textBillingRate').val("");
	        //$('#TextCost').val("");
	        //$('#CboRoleDepartMent').val("");
	        //$('#TextCost').val("");
	        //$('#CboRoleDepartMent').val("");
	        //var GenerateInvoice = document.getElementById('GenerateInvoice');
	        //var SalesActivity = document.getElementById('SalesActivity');
	        //var CheckAssignment = document.getElementById('CheckAssignment');
	        //if (GenerateInvoice.checked == true) {
	        //    $("#GenerateInvoice").prop('checked', false);
	        //}
	        //else {
	        //    $("#GenerateInvoice").prop('checked', true);
	        //}


	        //if (SalesActivity.checked == true) {
	        //    $("#SalesActivity").prop('checked', false);
	        //}
	        //else {
	        //    $("#SalesActivity").prop('checked', true);
	        //}



	        //if (CheckAssignment.checked == true) {
	        //    $("#CheckAssignment").prop('checked', false);
	        //}
	        //else {
	        //    $("#CheckAssignment").prop('checked', true);
	        //}
	    }

	    function RoleListCheckBox_OnClick() {



	    }


	    function CancelRole() {

	        $("#RoleDescription").val("");
	        $("#Cbolevel").val("");
	        $("#CboModule").val("");
	        $('#textBillingRate').val("");
	        $('#TextCost').val("");
	        $('#CboRoleDepartMent').val("");

	        $('#TextCost').val("");
	        $('#CboRoleDepartMent').val("");
	      
	        //alert(GenerateInvoice.checked);
	        //if (GenerateInvoice.checked == false) {
	            $("#GenerateInvoice").prop('checked', false);
	       // }
	       // else {
	        //    $("#GenerateInvoice").prop('checked', true);
	       // }


	       // if (SalesActivity.checked == "True") {
	            $("#SalesActivity").prop('checked', false);
	        //}
	        //else {
	        //    $("#SalesActivity").prop('checked', true);
	       // }



	       // if (CheckAssignment.checked == "True") {
	            $("#CheckAssignment").prop('checked', false);
	       // }
	       // else {
	        //    $("#CheckAssignment").prop('checked', true);
	        //}
	    }

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

	 

	    function DeleteRole()
	    {
	       // alert();

	        var strRoleIDs;
	        strRoleIDs = $('input[name=chkchkRoleMasterSelect]:checked').map(function () {
	            return this.value;
	        }).get().join(',');


	        //alert(strRoleIDs);
	        //
	        if (strRoleIDs.length <= 0) {
	            return;
	        }
	        data = JSON.stringify({ RoleIDs: strRoleIDs });
	        strResult = AJAXCallWithResult(strPageName + "/DeleteRole", data, false);
	        if (strResult.d != "") {


	            //alertify.set('notifier', 'position', 'top-right');
	            //alertify.notify(strResult.d, 'error');

                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Role Deleted Succssfully", 'success');
                RefreshGrid('RoleMaster');
                CancelRole();
	        }
	       
	      
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
	                //Stop();
	            },
	            error: function (xhr, status, error) {
	                //Stop();
	                //StopAjaxLoader("body");
	                $(".loadingoverlay", parent.document).css("display", "none");
	                console.log(xhr.responseText);
	                //window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
	            }
	        });

	        return AjaxResult;
	    }

	    function DepartMentFilter_OnChange(Object) {
	    
	        var strResult, data;
	        var GridParameter = {};
	        var Department = $("#cboDepartment").val();
	        var Role = $("#CboRole").val();

	        if (Department == "0" || Department == "") {
	            Department = ""
	        }

	        if (Role == "0" || Role == "")
	        {
	            Role = ""
	        }
	       // debugger;
            var Status = $("#CboStatus").val();
           
	     //   alert(Status)
	        if (Status == -1)
	        {
	            Status = "";
            }
            //Commented by Usha Pandit on 22.05.2019 for getting Employee Result as per Selected Status
	        //if (Status == "Active") {
	        //    Status = 1;
	        //}
	        //else {
	        //    Status = 0;
            //  }
            //End of Commented by Usha Pandit on 22.05.2019 for getting Employee Result as per Selected Status
            
	        var cityName = "divEmployee";
	        GridParameter.cityName = cityName;
	        //alert(Role);
	        //alert(Status);
	       // var getvalue = Object.val();
	     
	       // alert(getvalue)
	        data = JSON.stringify({ GridParameter: GridParameter, Department: Department, Role: Role, Status: Status });
	   // alert(data);
	        strResult = AJAXCallWithResult("CRM_UserAccess.aspx/RefreshGrid", data, false);

	        if (strResult.d != "")
	        {
	            $("#divEmployee").html("");
	            $("#divEmployee").html(strResult.d);
	            datatables("divEmployee", 'SearchRquestType');
	          //  setWidthEmployee();
	            //RefreshGrid(globalCityName);
	            //var arrResult = strResult.d;
	        }
	    }

	    function setWidthEmployee() {
	        var tblTotal = document.getElementById("divEmployee").getElementsByClassName('dataTable')[0];
	     //   var tblDetails = document.getElementById("divEmployee").getElementsByClassName('dataTable')[1];
	        //if (WhichBrowser() != 'FF') {
	        if (tblDetails != null) {
	            tblTotal.style.width = tblDetails.offsetWidth + 'px';
	            width = tblDetails.offsetWidth + 'px';
	        }
	        // }
	        var FooterTableRow = tblTotal.rows[0];
	        var HeaderRow = tblDetails.rows[0];
	        for (var i = 0; i < tblTotal.rows[0].cells.length; i++) {
	            if (FooterTableRow.cells[i] != null)
	                if (HeaderRow.cells[i] != null) {
	                    FooterTableRow.cells[i].style.width = HeaderRow.cells[i].offsetWidth + 'px';
	                }
	        }


	    }

	    var BusinessGroupID, TypeID;
	    function BusinessGroup_Change(obj)
	    {

	        var url = "CRM_UserAccess.aspx/GetOU"
	        BusinessGroupID = obj.value;
	        //alert(BusinessGroupID);
	        data = JSON.stringify({ TypeID: BusinessGroupID });
	        CustomAJAXCall(url, data, BindDropdownOU);
	    }

	   
	    function BindDropdownOU(result) {

	        //alert(result.d);
	        var strArray = String(result.d).split("|")
	        var objCbo = document.getElementById("CboOrganizationUnit");
	        var i = 0;
	        objCbo.innerHTML = "";
	       // alert(strArray[0])

	        insBlankOpt(objCbo);

	        $.each(JSON.parse(strArray[0]), function (id, obj) {

	            var objOption = document.createElement("OPTION");
	            objCbo.options.add(objOption);
	            objOption.text = obj.Location
	            objOption.value = obj.OUPoolID;;

	        });
	    }

	    function insBlankOpt(objCbo) {
	        objOption = new Option();

	        objOption.text = "";
	        objOption.value = "";

	        if (WhichBrowser() == 'IE')
	            objCbo.add(objOption);
	        else
	            objCbo.add(objOption, null);
	    }
	    function WhichBrowser() {

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

	    function CustomAJAXCall(url, data, method) {
	        $.ajax({
	            type: "POST",
	            url: url,
	            data: data,
	            dataType: "json",
	            contentType: "application/json",
	            timeout: 180000,
	            async: false,
	            success: function (result) {
	                method(result);
	                //  Stop();
	            },
	            error: function (xhr, status, error) {
	                // Stop();
	                //  StopAjaxLoader("body");
	                console.log(xhr.responseText);
	                window.location.href = "../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
	            }
	        });

	    }
	 
	    function Employee_OnClick(EmployeeID) {
	        //alert(EmployeeID);
	      
	        globalEmployeeID = EmployeeID;
	        document.getElementById('hdnEmployeeID').value = globalEmployeeID;
	        data = JSON.stringify({ EmployeeID: EmployeeID });
	        strResult = AJAXCallWithResult("CRM_UserAccess.aspx/GetEmployeeDetails", data, false);

	        if (strResult.d != "") {
	            var arrResult = strResult.d.split("#$#");
	            
	           //alert(strResult.d);
	            document.getElementById("UserName").disabled = true;
	            $("#idFromLeavingDate").css("display", "block");
	            $("#FormStatus").css("display", "block");
	            $("#EmployeeName").val(arrResult[0]);
	            $("#EmployeeCode").val(arrResult[1]);
	            $("#UserName").val(arrResult[2]);
	           // alert(arrResult[3]);
	            if (arrResult[3] == "True") {

	                $("#LDAPCHECk").prop('checked', true);

	            }
	            else {
	                $("#LDAPCHECk").prop('checked', false);

	            }
	            $("#Bdate").val(arrResult[4]);
	          
	            
	            $("#Address").val(arrResult[5]);
	            $("#City").val(arrResult[6]);

	            $("#PinCode").val(arrResult[7]);
	            $("#State").val(arrResult[8]);
	            $("#Address2").val(arrResult[9]);
	            $("#City2").val(arrResult[10]);
	            $("#PinCode2").val(arrResult[11]);
	            $("#State2").val(arrResult[12]);

	            $("#CboRoleEdit").val(arrResult[13]);
	            // 15  & "#$#" & ReportingTo & "#$#" & PassportNumber & "#$#" & PP_PlaceOfIssue & "#$#" & PP_FullName & "#$#" & PP_DateOfIssue & "#$#" & NoofPagesLeft & "#$#" & DepartmentID & "#$#" & EmailID & "#$#" & PP_ExpiryDate & "#$#" & PP_ExpiryDate & ""
	            $("#CboEmplyeeType").val(arrResult[14]);
	            $("#CboReportingTo").val(arrResult[15]);

	            $("#PssportNo").val(arrResult[16]);
	            $("#PlcIssue").val(arrResult[17]);
	            $("#FullName").val(arrResult[18]);
	            $("#DateIssue").val(arrResult[19]);
	            //$("#SonWife").val(arrResult[21]);

	            //$("#ExDate").val(arrResult[22]);
	            $("#NoLeftPage").val(arrResult[20]);
	            $("#CboDepartmentUnitEdit").val(arrResult[21]);
	            $("#EmailID").val(arrResult[22]);
	            //$("#SonWife").val(arrResult[24]);

	            $("#ExDate").val(arrResult[23]);
                 
	            $("#CboDeployable").val(arrResult[26]);
	            $("#txtCosthrs").val(arrResult[25]);
	            $("#txtRatehrs").val(arrResult[24]);
	            //$("#BusinessGroupID").val(arrResult[27]);
	            //$("#CboOrganizationUnit").val(arrResult[29]);
	            
	            $("#SonWife").val(arrResult[30]);
	            $("#JoiningDate").val(arrResult[31]);
	           
	            $('#imgUser').attr("src", arrResult[32]);
	            $('#TentativeLeavingDate').val(arrResult[33]);
	            $('#LeavingDate').val(arrResult[34]);
	             
	            if (arrResult[35] == "True") {

	                $("#idStatus").prop('checked', true);

	            }
	            else {
	                $("#idStatus").prop('checked', false);

	            }

	            try {       //Added by Usha Pandit on 03 JAN 2018

	                imgsrc = $('#imgUser').attr('src');     //Added by Usha Pandit on 16.12.2017 for image upload validation
	                if (document.getElementById('idUploadImage') != null) {
	                    document.getElementById('idUploadImage').innerHTML = "";

	                    document.getElementById('idUploadImage').innerHTML = "<img id='imgUser' alt='Upload Image'  src='" + arrResult[32] + "' />";
	                }
	                $("#imgUser").css('margin-left', '-16px');
	                $("#imgUser").css('margin-top', '-1px');

	                $("#tblEmployee").css("display", "none")
	                $("#EmployeePagination").css("display", "none")
	                $("#EmployeeFilter").css("display", "none");
	                $("#EditImage").css("display", "block");
	                $("#imgUser").css('margin-left', '-16px');
	                $("#imgUser").css('margin-top', '-1px');
	                $("#collapseOne8").addClass('in');

	                if ($("#Addaccordion").hasClass("collapsed")) {
	                    $("#Addaccordion").removeClass("collapsed");
	                    $("#collapseOne8").addClass('height', 'auto !important');
	                }

	                if (arrResult[34] != "") {
	                    document.getElementById('LeavingDate').disabled = false;
	                }
	                if (arrResult[33] != "") {
	                    document.getElementById('idStatus').disabled = false;
	                }

	            //Added by Usha Pandit on 03 JAN 2018
	            }
	            catch (exception) {
	                //alert(exception.message);
	            }
	            //End of Added by Usha Pandit on 03 JAN 2018
            }
           
            RefreshPagePlot();           
	    }

	    function AddEmployee() {
	        // $("#EmployeeFilter").css("display", "none");
	        $("#tblEmployee").css("display", "none")
	        $("#EmployeePagination").css("display", "none")
	        $("#EmployeeFilter").css("display", "none");
	        $("#imgUser").removeAttr('src');
	        $("#imgUser").css("margin-top", "16px");
	        $("#imgUser").css("margin-left", "-5px");
	        $("#EmployeeName").val("");
	        $("#EmployeeCode").val("");
	        $("#UserName").val("");
	        document.getElementById("UserName").disabled = false;
	        $("#LDAPCHECk").prop('checked', false);
 	        $("#Bdate").val("");
	        $("#JoiningDate").val("");
	        
	        $("#Address").val("");
	        $("#City").val("");

	        $("#PinCode").val("");
	        $("#State").val("");
	        $("#Address2").val("");
	        $("#City2").val("");
	        $("#PinCode2").val("");
	        $("#State2").val("");

	        $("#CboRoleEdit").val("");

	        $("#CboEmplyeeType").val("");
	        $("#CboReportingTo").val("");
	        $("#PssportNo").val("");
	        $("#PlcIssue").val("");
	        $("#FullName").val("");
	        $("#DateIssue").val("");
	        $("#SonWife").val("");

	        //$("#ExDate").val(arrResult[22]);
	        $("#NoLeftPage").val("");
	        $("#CboDepartmentUnitEdit").val("");
	        $("#EmailID").val("");
	        //$("#SonWife").val(arrResult[24]);

	        $("#ExDate").val("");

	        $("#CboDeployable").val("");
	        $("#txtCosthrs").val("");
	        $("#txtRatehrs").val("");
	        //$("#BusinessGroupID").val("");
	        //$("#CboOrganizationUnit").val("");
	        document.getElementById('UploadImage').innerHTML = "";
	        document.getElementById('UploadImage').innerHTML = "<div class='col-xs-1' id='idUploadImage' ><div><div><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' title='Upload Image' alt='Upload Image' src='../../../Images/Photo/no-photo.png' /></a></div></div></div>";
	        $("#EditImage").css("display", "none");

	        $('#TentativeLeavingDate').val("");
	        $('#LeavingDate').val("");                 
	        $("#idStatus").prop('checked', false);
	        $("#idFromLeavingDate").css("display", "none");
	        $("#FormStatus").css("display", "none");
	        $("#collapseOne8").addClass('in');

	        if ($("#Addaccordion").hasClass("collapsed")) {
	            $("#Addaccordion").removeClass("collapsed");
	            $("#collapseOne8").addClass('height', 'auto !important');
	        }
	    }

        
	    function SameAsAll(obj) {

	        var CurrentAddess = $("#Address").val();
	        var CurrentCity = $("#City").val();
	        var CurrentState = $("#State").val();
	        var CurrentPincode = $("#PinCode").val();

	        if ($(obj).is(':checked'))
	        {



	            $("#Address2").val(CurrentAddess);
	            $("#City2").val(CurrentCity);
	            $("#State2").val(CurrentState);
	            $("#PinCode2").val(CurrentPincode);




	        }

	        else {



	        }
	    }

	    function AddData() 
	    {
	        //alert();
	      
	        if ($("#Address").val() != '' || $("#City").val() != '' || $("#State").val() != '' || $("#PinCode").val() != '')
	        {
	            $("input #checkSameasall").removeAttr("disabled");
	        }
	        else
	        {
	            $("input #checkSameasall").attr("disabled", true);
	        }
                  
	    }

	    function SaveEmployee(flag) {

	        if (validateEmployee() == 0)
	            // debugger;
	        {
	            // alert(document.getElementById('hdnEmployeeID').value);
	            //var EmployeeID1;
	            if (document.getElementById('hdnEmployeeID').value == '') {
	                EmployeeID1 = 0;

	            }
	            else {

	                EmployeeID1 = globalEmployeeID;

	            }
	            // if(globalEmployeeID!= 0)
	            //alert(EmployeeID1);
	            var FileNameCharCount;
	            var EmployeeName = $("#EmployeeName").val();
	            var EmployeeCode = $("#EmployeeCode").val();
	            var UserName = $("#UserName").val();

	            var LdapValue, CheckAssignmentvalue, idStatusValue;
	            var LDAPCHECk = document.getElementById('LDAPCHECk');
	            if (LDAPCHECk.checked == true) {
	               // alert(LDAPCHECk.checked);
	                LdapValue = 1;

	            }
	            else {

	                LdapValue = 0;
	            }

	            var Bdate = $('#Bdate').val();
	            var JoiningDate = $('#JoiningDate').val();
	            
	            var EmailID = $('#EmailID').val();





	            var Sameasall = document.getElementById('checkSameasall');
	            if (Sameasall.checked == true) {
	                //alert(Sameasall.checked);

	                var CurrentAddess = $("#Address").val();
	                var CurrentCity = $("#City").val();
	                var CurrentState = $("#State").val();
	                var CurrentPincode = $("#PinCode").val();

	                var CurrentAddess1 = CurrentAddess;
	                var CurrentCity1 = CurrentCity;
	                var CurrentState1 = CurrentState;
	                var CurrentPincode1 = CurrentPincode;


	            }
	            else {

	                var CurrentAddess = $("#Address").val();
	                var CurrentCity = $("#City").val();
	                var CurrentState = $("#State").val();
	                var CurrentPincode = $("#PinCode").val();

	                var CurrentAddess1 = $("#Address2").val();
	                var CurrentCity1 = $("#City2").val();
	                var CurrentState1 = $("#State2").val();
	                var CurrentPincode1 = $("#PinCode2").val();


	            }
                 
	            var CboRoleEdit = $('#CboRoleEdit').val();
	            var CboDepartmentUnitEdit = $('#CboDepartmentUnitEdit').val();
	            var CboEmplyeeType = $('#CboEmplyeeType').val();
	            var CboReportingTo = $('#CboReportingTo').val();
                 
	            var txtRatehrs = $('#txtRatehrs').val();
	            var txtCosthrs = $('#txtCosthrs').val();
	            var CboDeployable = $('#CboDeployable').val();

	            //var BusinessGroupID = $('#BusinessGroupID').val();
	            //var CboOrganizationUnit = $('#CboOrganizationUnit').val();
	            //alert(CboOrganizationUnit);
	            var PssportNo = $('#PssportNo').val();
	            var PlcIssue = $('#PlcIssue').val();
	            var FullName = $('#FullName').val();
	            var SonWife = $('#SonWife').val();
	            var DateIssue = $('#DateIssue').val();

	            if (DateIssue == "" || DateIssue==undefined) {

	                DateIssue = "";
	            }
	            var NoLeftPage = $('#NoLeftPage').val();
	            var ExDate = $('#ExDate').val();
	            if (ExDate == "" || ExDate == undefined) {

	                ExDate = "";
	            }

	            var TentativeLeavingDate = $('#TentativeLeavingDate').val();
	            if (TentativeLeavingDate == "" || TentativeLeavingDate == undefined) {

	                TentativeLeavingDate = "";
	            }
	          
	            var LeavingDate = $('#LeavingDate').val();
	            if (LeavingDate == "" || LeavingDate == undefined) {

	                LeavingDate = "";
	            }

	            var idStatus = document.getElementById('idStatus');
	            if (idStatus != null) {
	                if (idStatus.checked == true) {
	                    // alert(LDAPCHECk.checked);
	                    idStatusValue = 1;

	                }
	                else {

	                    idStatusValue = 0;
	                }
	            }
	            else {
	                idStatusValue = 0;
	            }
	            var strURL = "CRM_UserAccess.aspx";
	          
	            var formData = new FormData();
	            if (typeof fileObject == "undefined") {
	                formData.append('EmployeePhoto', "");
	            }
	            else {
	                formData.append('EmployeePhoto', fileObject[0]);
	            }
	            
	            if (fileObject != undefined) {
	                if (fileObject[0].name != '')
	                    FileNameCharCount = fileObject[0].name.length;

	                if (FileNameCharCount > 50) {
	                    alertify.set('notifier', 'position', 'top-right');
	                    alertify.notify('File name should not exceed 50 characters!', 'error');
	                    return;
	                }
	            }
	            formData.append('Mode', 'SaveEmployeeInfo');
	            formData.append('EmployeeName', EmployeeName);
	            formData.append('EmployeeCode', EmployeeCode);
	            formData.append('UserName', UserName);
	            formData.append('LdapValue', LdapValue);
	            formData.append('Bdate', Bdate);
	            formData.append('JoiningDate',JoiningDate);
                formData.append('EmailID', EmailID);
	            formData.append('CurrentAddess', CurrentAddess);
	            formData.append('CurrentAddess1', CurrentAddess1);
	            formData.append('CurrentCity', CurrentCity);
	            formData.append('CurrentCity1', CurrentCity1);
	            formData.append('CurrentState', CurrentState);
	            formData.append('CurrentState1', CurrentState1);
	            formData.append('CurrentPincode', CurrentPincode);
	            formData.append('CurrentPincode1', CurrentPincode1)
	            formData.append('CboRoleEdit', CboRoleEdit)
	            formData.append('CboDepartmentUnitEdit', CboDepartmentUnitEdit);
	            formData.append('CboEmplyeeType', CboEmplyeeType);
	            formData.append('CboReportingTo', CboReportingTo);
	            //, CboEmplyeeType: CboEmplyeeType

	           /// Cost Per Hours && Rate Per Hours
	            //formData.append('txtRatehrs', txtRatehrs);
	            //formData.append('txtCosthrs', txtCosthrs);

	            formData.append('CboDeployable', CboDeployable);
	            //formData.append('BusinessGroupID', BusinessGroupID);
	            //formData.append('CboOrganizationUnit', CboOrganizationUnit);

	            formData.append('PssportNo', PssportNo);
	            formData.append('DateIssue', DateIssue);
	            formData.append('PlcIssue', PlcIssue)
	            formData.append('ExDate', ExDate)
	            formData.append('FullName',FullName)
	            formData.append('SonWife', SonWife);
	            formData.append('NoLeftPage', NoLeftPage);
	            formData.append('TentativeLeavingDate', TentativeLeavingDate);
	            formData.append('LeavingDate', LeavingDate);
	            formData.append('idStatusValue', idStatusValue);
                formData.append('EmployeeID', EmployeeID1);
              //  alert(formData);
	            //if (typeof fileObject != "undefined") {
                //debugger;
	                setFrameLoader();
	                $.ajax({
	                    url: strURL,  //Server script to process data
	                    type: 'POST',
	                    data: formData,
	                    async: false,
	                    success: function (result) {
	                      //  document.getElementById('UploadImage').innerHTML="";
	                        //$('#UploadImage').html("");
	                        //alert(result);
	                        $('#UploadImage').html(result);
	                        $("#imgUser").css('margin-left', '-16px');
	                        $("#imgUser").css('margin-top', '-1px');
	                        alertify.set('notifier', 'position', 'top-right');
	                      
	                        if (EmployeeID1 == 0) {
	                            alertify.notify('Employee Created successfully', 'success');

	                        }
	                        else {
	                            alertify.notify('Employee  details updated successfully', 'success');
	                        }
	                       // alert(document.getElementById('hdnEmployeeIDValue').length);
	                       // alert(document.getElementById('hdnEmployeeIDValue').value);
	                        EmployeeID1 = document.getElementById('hdnEmployeeIDValue').value;
	                        document.getElementById('hdnEmployeeID').value = EmployeeID1;
	                        
	                        if (EmployeeID1 != "" && flag!="AddSave") {

	                            Employee_OnClick(EmployeeID1);
	                         
	                        }
	                        
	                        if (flag == "AddSave")
	                        {
	                            CancelEmployee();
	                        }
	                        RefreshGrid('UserMaster');
	                        
	                        setTimeout(function () {  RemoveFrameLoader(); }, 1000);
	                    },
	                    error: function (xhr, status, error) {
	                        setTimeout(function () { RemoveFrameLoader(); }, 1000);
	                        console.log(xhr.responseText);
	                    },
	                    cache: false,
	                    contentType: false,
	                    processData: false
	                });
	           

	            //data = JSON.stringify({
	            //    EmployeeName: EmployeeName, EmployeeCode: EmployeeCode,
	            //    UserName: UserName, LdapValue: LdapValue, Bdate: Bdate,JoiningDate:JoiningDate,
	            //    EmailID: EmailID, CurrentAddess: CurrentAddess, CurrentAddess1: CurrentAddess1,
	            //    CurrentCity: CurrentCity, CurrentCity1: CurrentCity1, CurrentState: CurrentState, CurrentState1: CurrentState1, CurrentPincode: CurrentPincode, CurrentPincode1: CurrentPincode1
                //     , CboRoleEdit: CboRoleEdit
                //     , CboDepartmentUnitEdit: CboDepartmentUnitEdit
                //     , CboEmplyeeType: CboEmplyeeType
                //      , CboReportingTo: CboReportingTo
	            //    //, CboEmplyeeType: CboEmplyeeType
                //     , txtRatehrs: txtRatehrs
                //      , txtCosthrs: txtCosthrs
                //      , CboDeployable: CboDeployable
                //      , BusinessGroupID: BusinessGroupID
                //      , CboOrganizationUnit: CboOrganizationUnit

                //     , PssportNo: PssportNo
                //     , DateIssue: DateIssue
                //      , PlcIssue: PlcIssue
                //     , ExDate: ExDate
                //      , FullName: FullName
                //      , SonWife: SonWife

                //      , NoLeftPage: NoLeftPage
                //    , EmployeeID: EmployeeID1


	            //});
	            //alert(data);
	          //  strResult = AJAXCallWithResult("CRM_UserAccess.aspx/SaveEmployeeDetails", data, false);

	            //if (strResult.d != "") {
                //    alertify.set('notifier', 'position', 'top-right');
	            //    alertify.notify('Employee Created successfully!!!!', 'success');
	            //    RefreshGrid('UserMaster');
	            //    $("#collapseOne8").removeClass('in');
	            //}
	        }
	    }
	   
	    var strPageName = "CRM_UserAccess.aspx"
	    function DeleteEmployee() {
	        // alert();

	        var strEmployeeIDs;
	        //strEmployeeIDs = $('input[name=chkUserMasterSelect]:checked').map(function () {
	        //    return this.value;
	        //}).get().join(',');

	        var table = $('#divEmployee table').DataTable();
	        var rows = table.rows({ 'search': 'applied' }).nodes();
	        if (document.getElementById('chkUserMaster').checked == true) {
	            strEmployeeIDs = $('input[type="checkbox"]:not(:disabled)', rows).map(function () {
	                return this.value;
	            }).get().join(',');
	        }
	        else {
	            strEmployeeIDs = $('input[name=chkUserMasterSelect]:checked').map(function () {
	                return this.value;
	            }).get().join(',');
	        }
	       // alert(strEmployeeIDs);
	        //alert(strRoleIDs);
	        //
	        if (strEmployeeIDs.length <= 0) {
	            alertify.set('notifier', 'position', 'top-right');        
	            alertify.notify('Please select at least one Employee for deletion', 'error');  
	            return;
	        }
	       
	        data = JSON.stringify({ strEmployeeIDs: strEmployeeIDs });
	        strResult = AJAXCallWithResult(strPageName + "/DeleteEmployee", data, false);
	        if (strResult.d == "1")
	        {
	            alertify.set('notifier', 'position', 'top-right');
	            alertify.notify('Employee deleted successfully.', 'success');
	            RefreshGrid('UserMaster');


	        }


	    }


	  
	 
	    function CancelEmployee()
	    {
	        $("#imgUser").removeAttr('src');
	        $("#imgUser").css("margin-top", "16px");
	        $("#imgUser").css("margin-left", "-5px");
	        $("#EmployeeName").val("");
	        $("#EmployeeCode").val("");
	        $("#UserName").val("");
	        document.getElementById('UserName').disabled = false;
	        if ($("#LDAPCHECk").prop('checked', true))
	        {

	            $("#LDAPCHECk").prop('checked', false);

	        }
	        
	        $("#Bdate").val("");
	        $("#JoiningDate").val("");
	        
	        $("#Address").val("");
	        $("#City").val("");

	        $("#PinCode").val("");
	        $("#State").val("");
	        $("#Address2").val("");
	        $("#City2").val("");
	        $("#PinCode2").val("");
	        $("#State2").val("");

	        $("#CboRoleEdit").val("");

	        $("#CboEmplyeeType").val("");
	        $("#CboReportingTo").val("");
	        $("#PssportNo").val("");
	        $("#PlcIssue").val("");
	        $("#FullName").val("");
	        $("#DateIssue").val("");
	        $("#SonWife").val("");

	        //$("#ExDate").val(arrResult[22]);
	        $("#NoLeftPage").val("");
	        $("#CboDepartmentUnitEdit").val("");
	        $("#EmailID").val("");
	        //$("#SonWife").val(arrResult[24]);

	        $("#ExDate").val("");

	        $("#CboDeployable").val("");
	        $("#txtCosthrs").val("");
	        $("#txtRatehrs").val("");
	        //$("#BusinessGroupID").val("");
	        //$("#CboOrganizationUnit").val("");

	        $('#TentativeLeavingDate').val("");
	        $('#LeavingDate').val("");
	        $("#idStatus").prop('checked', false);
	        document.getElementById('UploadImage').innerHTML = "";
	        document.getElementById('UploadImage').innerHTML = "<div class='col-xs-1' id='idUploadImage' ><div><div><input name='img[]' class='file' id='file' type='file'><a id='btnSelectFile' style='text-align: center;font-weight:normal,font-size:11px !important;' onclick='SelectFile();'  filecount='0'><img id='imgUser' title='Upload Image' alt='Upload Image' src='../../../Images/Photo/no-photo.png' /></a></div></div></div>";
	        $("#EditImage").css("display", "none");
	        $("#EmployeeFilter").css("display", "block");
	        $("#tblrole").css("display", "block");
	        $("#tblEmployee").css("display", "block");
	        $("#idFromLeavingDate").css("display", "none");
	        $("#FormStatus").css("display", "none");
	        RefreshGrid('UserMaster');
	        RefreshPagePlot();
	        $("#collapseOne8").addClass('in');

	        if ($("#Addaccordion").hasClass("collapsed")) {
	            $("#Addaccordion").removeClass("collapsed");
	            $("#collapseOne8").addClass('height', 'auto !important');
	        }
             //Added by Usha Pandit on 22.05.2019 for getting Employee Result as per Selected Status
            DepartMentFilter_OnChange();
            //End of Added by Usha Pandit on 22.05.2019 for getting Employee Result as per Selected Status
	    }

	   

	    function validateEmployee() {
	      //  debugger;
	        var checkValu = 0;
	        var checkvalue = 0;
	        var Flag = 0;
	        var checkvalue = 0;
	        var strmsg = "";
	        var errorMsg = "<ul>"
	        if ($("#EmployeeName").val() == "") {
	            strmsg = '- Employee name should not be left blank';
	            errorMsg += "<li>" + strmsg + "</li>";
                Flag = 1;
	            checkvalue = 1;
	        }
	      //  alert($('#EmployeeName').val());
	        if ($("#EmployeeName").val() != "") {
	          
                  if (checkSpecialCharacter($('#EmployeeName').val()) == true) {
                      // alertify.set('notifier', 'position', 'top-right');
                      strmsg = '- A Employee name cannot contain any of these /\\:*?<>|,"+- Characters';
                      errorMsg += "<li>" + strmsg + "</li>";
	             //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
	                checkvalue = 1;

	            }
	        }
             
	        if ($("#EmployeeCode").val() == "") {
                strmsg = ' - Employee Code should not be left blank';
	            errorMsg += "<li>" + strmsg + "</li>";
	            checkvalue = 1;
	        }

	       
	        //if ($("#EmployeeCode").val() != "") {

	           

	        //    if (checkSpecialCharacter($('#EmployeeCode').val()) == true) {
	        //        strmsg = '- A Employee Code cannot contain any of these /\\:*?<>|,"+- Characters';
	        //        errorMsg += "<li>" + strmsg + "</li>";
	        //        checkvalue = 1;

	        //    }
	        //}
	         
  	       
	        if ($("#UserName").val() == "") {
	           
	               
	            strmsg = '- User name should not be left blank';
	                errorMsg += "<li>" + strmsg + "</li>";
	                //   alertify.notify('A EmployeeName cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
	                checkvalue = 1;

	            
	        }


            var objUserID = $("#UserName").val();
            if (objUserID.indexOf("'") != -1) {
                strmsg = '- User name should not contain single quote.';
                errorMsg += "<li>" + strmsg + "</li>";
                checkvalue = 1;
            }
 
            if ($("#UserName").val() != "") {
                var UserName = $("#UserName").val();
                data = JSON.stringify({ UserName: UserName, EmailID: "", StrFlag: "UserName", globalEmployeeID: globalEmployeeID });
             
                var strResult1 = AJAXCallWithResult("CRM_UserAccess.aspx/IsDuplicateUserName", data, false);
                if (strResult1 != undefined) {
                    if (strResult1.d == "1") {
                        
                        strmsg = '- User Name already exists.';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                       
                    }
                }

            }

	        if ($("#Bdate").val() == "") {
                strmsg = '- Birth Date should not be left blank';
	            errorMsg += "<li>" + strmsg + "</li>";
	            checkvalue = 1;
	        }

	       // var objBD = dOC.getElementById('Bdate')



	        if ($("#Bdate").val() != "")
	        {
	            var url = 'CRM_UserAccess.aspx/CheckDateValidation';
	            var data = JSON.stringify({ BirthDate: $('#Bdate').val(), Joiningdate: $('#JoiningDate').val() });
	            if ($('#Bdate').val() != '')
	           {
	                $.ajax({
	                    type: "POST",
	                    url: url,
	                    data: data,
	                    dataType: "json",
	                    contentType: "application/json",
	                    async: false,
	                    timeout: 180000,
	                    success: function (result)
	                    {
	                       

	                        if (result.d == 1)
	                        {
	                            checkValu = 1;
	                           
	                        }
	                       
	                        else if (result.d == 3)
	                        {
	                            checkValu = 3;
	                        }
	                        else if (result.d == 4) {
	                            checkValu = 4;
	                        }

	                        else if (result.d == 5) {
	                            checkValu = 5;
	                        }
	                       
	                    },
	                 
	                });
	            
	                if (checkValu == 1)
	                {
	                    strmsg = '- The Birth Date should not be greater than Today Date'
	                    errorMsg += "<li>" + strmsg + "</li>";
	                    checkvalue = 1;
	                }
	                else if (checkValu == 3) {

	                    strmsg = '- The Birth Date should not be greater than Joining Date'
	                    errorMsg += "<li>" + strmsg + "</li>";
	                    checkvalue = 1;

	                }
	                else if (checkValu == 4) {

	                    strmsg = '- The Joining Date should not be greater than Today Date'
	                    errorMsg += "<li>" + strmsg + "</li>";
	                    checkvalue = 1;

	                }

	                else if (checkValu == 5) {

	                    strmsg = '- Joining Date should not be equal to Birth Date'
	                    errorMsg += "<li>" + strmsg + "</li>";
	                    checkvalue = 1;

	                }
	            }
	        }

	        if ($("#JoiningDate").val() == "")
	        {
	            strmsg = '- Joining Date should not be left blank';
	            errorMsg += "<li>" + strmsg + "</li>";
	            checkvalue = 1;
	        }
	        

	       
	       
	        //var ObjDateIssue = document.getElementById('DateIssue')
	       

	        //if ($("#Bdate").val() != "" && $("#JoiningDate").val() != "")
	        //{
	        //    var strDateCompare = 'Birth date Should not be less than Joining Date' + $("#JoiningDate").val()
	        //    if (Date.parse($('#Bdate').val()) > Date.parse($('#JoiningDate').val())) {
	        //        strmsg = strDateCompare;
	        //        errorMsg += "<li>" + strmsg + "</li>";
	        //        checkvalue = 1;
	               

	        //    }

	        //}

	        if ($("#EmailID").val() == "")
	        {
	            strmsg = '- Email ID should not be left blank';
	            errorMsg += "<li>" + strmsg + "</li>";
	            checkvalue = 1;
	        }


	      
	        if ($("#EmailID").val() != "") {
	            objTxt = $("#EmailID").val();
	            flag = ValidateEmailID(objTxt);
	            if (flag == false) {
	                strmsg = '- Email ID should be Valid';
	                errorMsg += "<li>" + strmsg + "</li>";
	                checkvalue = 1;


	            }
	        }
             
	        if ($("#EmailID").val() != "") {
	            var EmailID = $("#EmailID").val();
	            data = JSON.stringify({ UserName: "", EmailID: EmailID, StrFlag: "EmailID", globalEmployeeID: globalEmployeeID });
	     
	            var strResult1 = AJAXCallWithResult("CRM_UserAccess.aspx/IsDuplicateEmailID", data, false);
	            if (strResult1 != undefined) {
	                if (strResult1.d == "1") {

	                    strmsg = '- Email ID already exists.';
	                    errorMsg += "<li>" + strmsg + "</li>";
	                    checkvalue = 1;

	                }
	            }

	        }
	    
	      
	    if ($("#CboDeployable").val() == "") {
	        strmsg = '- Deployable should not be left blank';
	        errorMsg += "<li>" + strmsg + "</li>";
	        checkvalue = 1;
	    }
 
	    //if ($("#txtCosthrs").val() == "") {
	    //    strmsg = '- Cost per hour should not be left blank';
	    //    errorMsg += "<li>" + strmsg + "</li>";
	    //    checkvalue = 1;
	    //}

	    //else if ($("#txtCosthrs").val() != "")
	    //{ 
	    //    if (checkSpecialCharacter($('#txtCosthrs').val()) == true) {
	    //        strmsg = '- A Cost per hour cannot contain any of these /\\:*?<>|,"+- characters.';
	    //        errorMsg += "<li>" + strmsg + "</li>";
	    //        checkvalue = 1;

	    //    }

	    //    if (RestrictNonNumeric(document.getElementById('txtCosthrs')) == true) {
	    //        strmsg = '- Please enter only positive numeric value for Cost per hour';
	    //        errorMsg += "<li>" + strmsg + "</li>";
	    //        checkvalue = 1;

	    //    }

	    //}
	  
	    //if ($("#txtRatehrs").val() == "") {
        //    strmsg = '- Rate per hour should not be left blank';
	    //    errorMsg += "<li>" + strmsg + "</li>";
	    //    checkvalue = 1;
	    //    }

	    //    else if ($("#txtRatehrs").val() != "")
	    //    { 
	    //            if (RestrictNonNumeric(document.getElementById('txtRatehrs')) == true) {
	    //                strmsg = '- Please enter only positive numeric value for Rate per hour';
	    //                errorMsg += "<li>" + strmsg + "</li>";
	    //                checkvalue = 1;

	    //            }

	    //           if (checkSpecialCharacter($('#txtRatehrs').val()) == true) {
	    //               strmsg = '- A Rate per hour cannot contain any of these /\\:*?<>|,"+- characters.';
	    //               errorMsg += "<li>" + strmsg + "</li>";
	    //               checkvalue = 1;

	    //            }


	    //    }
	         
	            if ($("#Address").val() != "" || $("#Address2").val() != "") {
                     
	                var CurentAddress = $("#Address").val();
	                var Address = $("#Address2").val();
	                var CurentAddressIndex1 = CurentAddress.indexOf("<");
	                var CurentAddressIndex2 = CurentAddress.indexOf(">");
	                var AddressIndex1 = Address.indexOf("<");
	                var AddressIndex2 = Address.indexOf(">");
	                if (CurentAddressIndex1 > -1) {
	                    strmsg = "'- Permanent  Address' Should not contain '<' or '>' character.'";
	                    errorMsg += "<li>" + strmsg + "</li>";
	                    checkvalue = 1;
 
	                }
	                else if (CurentAddressIndex2 > -1) {

	                    strmsg = "'- Permanent Address' Should not contain '<' or '>' character.'";
	                    errorMsg += "<li>" + strmsg + "</li>";
	                    checkvalue = 1;
 
	                }
	                else if (AddressIndex1 > -1) {

	                    strmsg = "'- Current Address' Should not contain '<' or '>' character.'";
	                    errorMsg += "<li>" + strmsg + "</li>";
	                    checkvalue = 1;              
	                }
	                else if (AddressIndex2 > -1) {
	                 
	                    strmsg = "'- Current Address' Should not contain '<' or '>' character.'";
	                    errorMsg += "<li>" + strmsg + "</li>";
	                    checkvalue = 1;
	                }
            }
 
	      
	    if ($("#City").val() != "")
	        if (checkSpecialCharacter($('#City').val()) == true) {
	            strmsg = '- A City cannot contain any of these /\\:*?<>|,"+- Characters';
	            errorMsg += "<li>" + strmsg + "</li>";
	            checkvalue = 1;
	            $("#City").focus();

	        }
  
	    if ($("#City1").val() != "")
	        if (checkSpecialCharacter($('#City2').val()) == true) {
	            strmsg = '- A Current City cannot contain any of these /\\:*?<>|,"+- Characters';
	            errorMsg += "<li>" + strmsg + "</li>";
	            $("#City1").focus();
	            checkvalue = 1;

	        }
  
	        if ($("#State").val() != "")
	            if (checkSpecialCharacter($('#State').val()) == true) {
	                strmsg = '- A State City cannot contain any of these /\\:*?<>|,"+- Characters';
	                errorMsg += "<li>" + strmsg + "</li>";
	                $("#State").focus();
	                checkvalue = 1;

	            }
  
	        if ($("#State1").val() != "")
	            if (checkSpecialCharacter($('#State2').val()) == true) {
	                strmsg = '- A Current State City cannot contain any of these /\\:*?<>|,"+- Characters';
	                errorMsg += "<li>" + strmsg + "</li>";
	                $("#State1").focus();
	                checkvalue = 1;

	            }
  
	            if ($("#PinCode").val() != "")
	                if (checkSpecialCharacter($('#PinCode').val()) == true) {
	                    strmsg = '- A Pin Code cannot contain any of these /\\:*?<>|,"+- Characters';
	                    errorMsg += "<li>" + strmsg + "</li>";
	                    $("#PinCode").focus();
	                    checkvalue = 1;

	                }
  
	            if ($("#PinCode1").val() != "")
	                if (checkSpecialCharacter($('#PinCode2').val()) == true) {
	                    strmsg = '- A Current Pin Code cannot contain any of these /\\:*?<>|,"+- Characters';
	                    errorMsg += "<li>" + strmsg + "</li>";
	                    $("#PinCode1").focus();
	                    checkvalue = 1;

	                }
 
	            if ($("#CboRoleEdit").val() == "") {
                    strmsg = '- Role should not be left blank';
	                errorMsg += "<li>" + strmsg + "</li>";
	                checkvalue = 1;
	            }
 
	            if ($("#CboDepartmentUnitEdit").val() == "") {
                    strmsg = '- Department/Unit should not be left blank';
	                errorMsg += "<li>" + strmsg + "</li>";
	                checkvalue = 1;
	            }


	          if ($("#CboEmplyeeType").val() == "") {

	              strmsg = '- Employee Type should not be left blank';
	              errorMsg += "<li>" + strmsg + "</li>";
	              checkvalue = 1;
	              
	            }


	            if ($("#CboReportingTo").val() == "") {

	                strmsg = '- Reporting To should not be left blank';
	                errorMsg += "<li>" + strmsg + "</li>";
	               checkvalue = 1;
	        }

	         // if ($("#BusinessGroupID").val() == "") {

	         //     strmsg = '- Business Group To should not be left blank';
	         //     errorMsg += "<li>" + strmsg + "</li>";
	         //     checkvalue = 1;
	         //   }


	         // if ($("#CboOrganizationUnit").val() == "")
	         // {

	         //       strmsg = '- Organization Unit To should not be left blank';
	         //       errorMsg += "<li>" + strmsg + "</li>";
	         //       checkvalue = 1;
	         //}
 

	         
	        var ObjDateIssue = document.getElementById('DateIssue')
	        var ObjDateExpiry = document.getElementById('ExDate')
	        if (ObjDateIssue.value != "" && ObjDateExpiry.value != "")
	        {
	          var strDateCompare = "'- Date Issue should  be less than 'Expiry Date'" + $("#ExDate").val();
	          if (Date.parse($('#DateIssue').val()) > Date.parse($('#ExDate').val()))
	          {
	                        strmsg = strDateCompare;
	                        errorMsg += "<li>" + strmsg + "</li>";
	                       checkvalue = 1;
	                   // $('#SpanStartDate').text("Start Date should not be greater than Project End Date '" + ProjectEndDate + "'");
	                   
	                }
	            }
	     
	    if ($("#PssportNo").val() != "") {
	        if (checkSpecialCharacter($('#PssportNo').val()) == true) {
	            strmsg = '- A Passport Number cannot contain any of these /\\:*?<>|,"+- Characters';
	            errorMsg += "<li>" + strmsg + "</li>";
	            $("#PssportNo").focus();
	            checkvalue = 1;

	        }

	            }


	           if ($("#PlcIssue").val() != "") {
	                if (checkSpecialCharacter($('#PlcIssue').val()) == true) {
	                    strmsg = '- A Place Of Issue cannot contain any of these /\\:*?<>|,"+- Characters';
	                    errorMsg += "<li>" + strmsg + "</li>";
	                    $("#PlcIssue").focus();
	                    checkvalue = 1;

	                }

	            }


	              if ($("#FullName").val() != "") {
	                if (checkSpecialCharacter($('#FullName').val()) == true) {
	                    strmsg = '- A Full name cannot contain any of these /\\:*?<>|,"+- Characters';
	                    errorMsg += "<li>" + strmsg + "</li>";
	                   $("#FullName").focus();
	                    checkvalue = 1;

	                }

	            }


	              if ($("#SonWife").val() != "") {
	                if (checkSpecialCharacter($('#SonWife').val()) == true) {
	                    strmsg = '- A Son of/Wife of/Daughter cannot contain any of these /\\:*?<>|,"+- Characters';
	                    errorMsg += "<li>" + strmsg + "</li>";
	                    $("#SonWife").focus();
	                    checkvalue = 1;

	                }

	            }

	              if ($("#NoLeftPage").val() != "")
	            {
	                if (checkSpecialCharacter($('#NoLeftPage').val()) == true)
	                {
	                    strmsg = '- A No.of Pages Left of  cannot contain any of these /\\:*?<>|,"+- Characters';
	                    errorMsg += "<li>" + strmsg + "</li>";
	                   $("#NoLeftPage").focus();
	                    checkvalue = 1;

	                }

	                if (RestrictNonNumeric(document.getElementById('NoLeftPage')) == true) {
	                    strmsg = '- Please enter only positive numeric value for No.of Pages Left';
	                    errorMsg += "<li>" + strmsg + "</li>";
	                    checkvalue = 1;

	                }

	              }


	              if ($("#TentativeLeavingDate").val() != "") {
	                  var url = 'CRM_UserAccess.aspx/CheckLeavingDateValidation';
	                  var data = JSON.stringify({ TentativeLeavingDate: $('#TentativeLeavingDate').val(), LeavingDate: "" });
	                  if ($('#TentativeLeavingDate').val() != '') {
	                      $.ajax({
	                          type: "POST",
	                          url: url,
	                          data: data,
	                          dataType: "json",
	                          contentType: "application/json",
	                          async: false,
	                          timeout: 180000,
	                          success: function (result) {
	                              if (result.d == 1) {
	                                  checkValu = 1;

	                              }

	                          },

	                      });
	                  }
	              }
            //Added by Yogesh Jalamkar on 04-JAN-2017 Purpose:If staus is acive then leaving date should be mandatory
	              var idStatusvalue = document.getElementById('idStatus');
	              var oLeavingDate = GetObjectReference("", "LeavingDate");
	              var oJoiningDate = GetObjectReference("", "JoiningDate");

	              if (idStatusvalue != null) {
	                  if (idStatusvalue.checked == true) {

	                      if ($("#LeavingDate").val() == "") {
	                          strmsg = '- Please enter leaving date.';
	                          errorMsg += "<li>" + strmsg + "</li>";
	                          checkvalue = 1;
	                      }

	                      else if (new Date(oLeavingDate.value) < new Date(oJoiningDate.value)) {
	                          strmsg = '- Please enter Leaving Date greater than or equal to Joining Date.';
	                          errorMsg += "<li>" + strmsg + "</li>";
	                          checkvalue = 1;
	                      }
	                   

	                  }
	                  else {
	                      if (new Date(oLeavingDate.value) >= new Date(oJoiningDate.value)) {
	                          strmsg = '- Please enter Joining Date greater than Leaving Date.';
	                          errorMsg += "<li>" + strmsg + "</li>";
	                          checkvalue = 1;
	                      }
	                      else {
	                          $("#LeavingDate").val("");
	                      }
	                  }
	                 
	              }
            //End by Yogesh Jalamkar
	             
	                      if (checkValu == 1)
	                      {
	                          strmsg = '- Tentative Releaving Date should be Future Date.'
	                          errorMsg += "<li>" + strmsg + "</li>";
	                          checkvalue = 1;
	                      }
	              if (strmsg != "") {
	                  alertify.set('notifier', 'position', 'top-right');
	                  alertify.notify(errorMsg, 'error', 15);

	              }
	        return checkvalue;
	                  }

	    

    function ValidateEmailID1() {

       var objTxt1 = $("#EmailID").val();
        flag = ValidateEmailID(objTxt1);
        if (flag == false) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('EmailID Should be Valid', 'error', 15);


        }


    }
    function ValidateEmailID(strEmailList) {
        var strEmailArray;
        var intCtr
        var strNewEmailList
        if (strEmailList == "") {
            return false;
        }
        //Added By NikitaD of Send Mail functionality in 4.0
        //Added by swapnil aswale on 31/3/2016
        //if (strEmailList.charAt(strEmailList.length - 2) == ";") {
        if (strEmailList.charAt(strEmailList.trim().length - 1) == ";") {
            strNewEmailList = strEmailList.substr(0, strEmailList.trim().length - 1);
        }
            //Ended
        else {
            strNewEmailList = strEmailList;
        }
        strNewEmailList = strNewEmailList.replace(/ /g, '');
        //End Added By NikitaD of Send Mail functionality in 4.0
        objRegularExp = new RegExp("[\\,,\\ ,\\;]")
        strEmailArray = strNewEmailList.split(objRegularExp);

        if (strEmailArray.length == 0)
            return false;

        for (intCtr = 0; intCtr < strEmailArray.length; intCtr++) {
            if (isEmail(strEmailArray[intCtr]) == false) {
                //alert("Invalid Email ID = \"" + strEmailArray[intCtr] + "\"")
                return false;
            }
        }
        return true;
    }

    function isEmail(str) {
        /*
        '=====================================================================
        ' Procedure Name        :   isEmail
        ' Description           :   Generic function which validates if the Email Id entered by the user
        '							is in a proper format.	
        ' Purpose               :   To Validate the email id is in proper format or not
        ' Parameters Passed     :   Email ID which is to be validated
        ' Returns               :
        ' Parameters Affected   :   None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                :   UmaB
        ' Created               :   11th September 2000
        ' Revisions             :
        '=====================================================================
        */
        // Are regular expressions supported ?
        var supported = 0;

        if (window.RegExp) {
            var tempStr = "a";
            var tempReg = new RegExp(tempStr);
            if (tempReg.test(tempStr)) supported = 1;
        }

        if (!supported)
            return (str.indexOf(".") > 2) && (str.indexOf("@") > 0);

        var r1 = new RegExp("(@.*@)|(\\.\\.)|(@\\.)|(^\\.)");
        var r2 = new RegExp("^.+\\@(\\[?)[a-zA-Z0-9\\-\\.]+\\.([a-zA-Z]{2,3}|[0-9]{1,3})(\\]?)$");

        return (!r1.test(str) && r2.test(str));

    }
    function SelectFile() {
        var strFileCount = $("#btnSelectFile").attr("FileCount");
        var objCurrentFileControl = $("#file");

        objCurrentFileControl.click();
    }
    function readURL(input) {
        if ($("#file")[0].files && $("#file")[0].files) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#imgUser').attr("src", e.target.result);
                $("#imgUser").css('margin-left', '-16px');
                $("#imgUser").css('margin-top', '-1px');
                
            }

            reader.readAsDataURL($("#file")[0].files[0]);
        }
    }
    var fileObject;
    $(document).on('change', '.file', function () {
       
        var fileNameDisplay;
        $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
        
        var objtxtFileName = document.getElementById('file');

        var fileName = objtxtFileName.value;
        fileNameDisplay = fileName;
        var index = fileName.lastIndexOf("\\");
        if (index == -1)
            index = fileName.lastIndexOf("/");

        if (index != -1)
            fileName = fileName.substring(index + 1, fileName.length);
         
        //Added by Usha Pandit on 16.12.2017 for image upload validation
        if (validateUploadedFile(fileName) == false) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('Please upload files having extensions: .JPEG, .PNG, .BMP, .GIF, .TIF, .JPG only.', 'error');

            $("#imgUser").attr('src', imgsrc);
            return;
        }
        //End of addition

        fileObject = $("#file")[0].files;
        readURL();
      
       // ImportOnclick();
         
    });

    //Added by Usha Pandit on 16.12.2017 for image upload validation
    function validateUploadedFile(curFileName) {
        var validFile = false;
        var fileNameExt = curFileName.substr(curFileName.lastIndexOf('.') + 1);
        var validFileExtensions = ["jpg", "jpeg", "bmp", "gif", "png", "TIF"];
        for (var i = 0; i < validFileExtensions.length; i++) {
            var sCurExtension = validFileExtensions[i];
            if (fileNameExt.toLowerCase() == sCurExtension.toLowerCase()) {
                validFile = true;
                break;
            }
        }

        return validFile;
    }
    //End of addition

    function ImportOnclick() {
        //   debugger;
        var strURL = "CRM_RequestListNew.aspx";

        var formData = new FormData();
        formData.append('excelFile', fileObject[0]);
        formData.append('Mode', 'ProcessFile');
        formData.append('Mode', 'ProcessFile');

        if (typeof fileObject != "undefined") {
         
                setFrameLoader();
                $.ajax({
                    url: strURL,  //Server script to process data
                    type: 'POST',
                    data: formData,
                    async: false,
                    success: function (result) {
                         $('#tblFileDetails').html(result);
                       
                        setTimeout(function () { RemoveFrameLoader(); }, 1000);
                    },
                    error: function (xhr, status, error) {
                        setTimeout(function () { RemoveFrameLoader(); }, 1000);
                        console.log(xhr.responseText);
                   },
                    cache: false,
                    contentType: false,
                    processData: false
                });
         }
    }
    function LocationCopy_OnChange()
    { }

    function AddEmployeeSign(obj)
    {
    //  setWidthEmployee();
    }
      </script>
    
</head>
   
</html>


