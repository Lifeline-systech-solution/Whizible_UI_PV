<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_RequestDetails_UnCategorised.aspx.vb" Inherits="PbNIT.CRM_RequestDetailsUncategorized" %>

<!DOCTYPE html>
<html lang="en">
    <%CommonFunctions.General.PlotPageHeadTag("Admin Panel")%>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Admin Panel</title>
        <%--<%CommonFunctions.General.PlotPageHeadTag("Admin Panel")%>--%>
        <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("Setting")%>--%>
        
        <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
        <!-- Bootstrap core CSS -->
        <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" /> -->
<%--	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">--%>
    <!-- Custom fonts for this template --> 
<%--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">--%>
      <link href="../../../EnhancementFiles/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
    <!-- Custom styles for this template -->
	<!-- Plugin CSS -->	 
	<%-- <link href="css/style.css" rel="stylesheet">--%>
            
	<%-- <link href="css/reqdetail.css" rel="stylesheet">
        
	 <link href="css/setting.css" rel="stylesheet">--%>
   <%-- <link href="css/sb-admin.css" rel="stylesheet">--%>
         <link href="../../../EnhancementFiles/css/style.css" rel="stylesheet" />
      <link href="../../../EnhancementFiles/css/reqdetail.css?v=1.1" rel="stylesheet" />
      <link href="../../../EnhancementFiles/css/setting.css" rel="stylesheet" />
      <link href="../../../EnhancementFiles/css/sb-admin.css" rel="stylesheet" />
	<%--<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">	--%>
      <!-- <link href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" rel="stylesheet" /> -->
<%--	<link rel="stylesheet" href="css/timepicker.min.css">--%>
      <link href="../../../EnhancementFiles/css/timepicker.min.css" rel="stylesheet" />
      <!-- <link href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" rel="stylesheet" /> -->

  </head>
  
	<style>
	    /*.tab-section {
	        visibility: hidden;
	    }*/
	    body .tab-section button:focus, body .tab-section button.tablinks.active {
	        background: #fff !important;
	        color: #364660 !important;
	        float: right !important;
	        font-weight: 600 !important;
	        font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
	        padding: 6px 12px !important;
	        border: 1px solid #8c8c8c !important;
	    }

	    #divCustomer .modal-content {
	        width: auto !important;
	        height: auto !important;
	        padding-bottom: 15px;
	    }

	    #Product {
	        padding: 0px !important;
	    }

	    .req-title {
	        color: #fff;
	    }

	    .quest-info-new {
	        padding: 18px 0 12px 20px;
	    }

	    .dropdown-menu {
	        width: 250px;
	    }

	    .fa-check {
	        cursor: pointer;
	        color: #33df40;
	        font-size: 16px;
	    }

	    .fa-close {
	        cursor: pointer;
	        color: red;
	        font-size: 16px;
	    }

	    .dtPicker {
	        width: 85px !important;
	    }

	    #idSubject {
	        font-weight: normal !important;
	        font-size: 15px !important;
	    }

	    .request-date:last-child {
	        font-style: italic;
	        font-size: 13px;
	    }

	    .request-date {
	        font-weight: normal !important;
	    }

	    .discus-chat ul li span {
	        font-size: 11px !important;
	        font-weight: 600;
	        font-style: italic;
	        margin-right: 10px;
	    }
	    /*Added By Vidya Jadhav ON 18 Oct 2017 For UI changes*/
	    select {
	        border-radius: 0;
	        height: 27px;
	        padding: 2px;
	        font-size: 11px !important;
	    }

	    .lblnodatadiscussion {
	        text-align: CENTER;
	        font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
	        font-weight: 100;
	        width: 100%;
	    }
	    /**Addede By Dipali V Add Css For Attachment Tab For Add Attachment*/
	    #Attachments {
	        margin-top: 2%;
	    }

	    #addattachmenttab {
	        float: right;
	        margin-top: 1%;
	        margin-right: 2%;
	    }

	    #tblFilesadd {
	        width: 96%;
	        margin-top: 1%;
	        /* padding: 33%; */
	        margin-left: 2%;
	        margin-right: 2%;
	    }

	    #divAttachment {
	        width: 476px !important;
	        margin-left: -11% !important;
	    }

	    button.btn.btn-default.download {
	        margin-right: -9%;
	    }

	    #divHistory table tr td:nth-child(1) {
	        width: 22% !important;
	    }

	    #CboFieldName {
	        height: 30px !important;
	    }

	    #CboModifiedBy {
	        height: 30px !important;
	    }
	    /**End of Addede By Dipali V Add Css For Attachment Tab For Add Attachment*/
	    .attch-top-bar ul {
	        float: right !important;
	        margin-right: -18% !important;
	    }

	    #spnPriority {
	        background-color: orange !important;
	    }

	    .internalrequest {
	        background-color: #f6eee4 !important;
	    }

	    .content-wrapper {
	        margin-left: 0px !important;
	        /*margin-top:-1%;*/
	    }

	    .read-more-wrap {
	        width: auto !important;
	    }



	    #divCustomField {
	        width: 100%;
	        /*overflow: auto;*/
	    }


	    .form-group {
	        border-bottom: 1px solid #ebedf2 !important;
	        padding-bottom: 5px !important;
	    }

	    .odd-discus-chat {
	        /*height:auto !important;*/
	    }

	    .img-circle {
	        height: 41px;
	        width: 43px;
	    }
	    /*Added By Vidya Jadhav ON 18 Oct 2017 For UI changes*/
	    #spnDescription {
	        /*font-style: italic;*/
	    }

	    #divHistory .dataTables_wrapper .row:first-child {
	        display: none;
	    }

	    #divHistory .dataTables_wrapper .row:last-child {
	        display: none;
	    }

	    .dataTables_empty {
	        text-align: center;
	    }

	    #idCalender {
	        top: 6px;
	        position: absolute;
	        margin-left: 74px;
	    }

	    .time-picker {
	        margin-top: 0px !important;
	    }

	    .clsStatusBox {
	        padding-right: 0px;
	        padding-left: 0px;
	        width: 100%;
	    }

	    .clsDateControl {
	        margin-top: 10px;
	        float: right;
	        margin-left: 10PX;
	        /* margin-right: 59px;*/
	    }

	    .clsdate {
	        width: 58% !important;
	    }
	    /*End Of Added By Vidya Jadhav ON 18 Oct 2017 For UI changes*/


	    /*Reference from reqdetails.css*/
	    #id07 .modal-content {
	        height: 500px;
	        width: 630px;
	    }

	    #id07 .container {
	        width: 620px;
	    }
	    /*End of Reference from reqdetails.css*/

	    #id07 .form-control {
	        padding: 0px;
	    }


	    /*Dipali V On 31st oct 2017*/

	    .newclass {
	        border: 1px solid white !important;
	        border-color: white !important;
	    }

	    #FlagTracking .modal-content {
	        width: 488px !important;
	        height: 340px !important;
	    }

	    .newclass:hover {
	        border: 1px solid white !important;
	        border-color: white !important;
	    }

	    .editor button.btn.btn-default.cancle, .editor button.btn.btn-default.save {
	        margin-top: 3% !important;
	    }

	    #Deliverable .sdate {
	        margin-left: 13px !important;
	        font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
	    }

	    #Deliverable #datepicker {
	        margin-left: 7% !important;
	    }

	    .fa-calendar:before {
	        color: #343660 !important;
	    }

	    .sdate {
	        font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
	    }

	    .form-control inp-date {
	        color: #343660 !important;
	        font-size: 14px !important; /* Modified By Madhuri.K On 26-03-2026 */
	    }


	    .close:hover {
	        color: #fff !important;
	    }

	    #btnSave:hover {
	        color: white !important;
	    }

	    #frmAttachmentDiv .right ul {
	        margin-right: 0% !important;
	    }



	    /*div#History, #Activities, #Attachments, #Association, #Type, #Subtype {
        border: 1px solid #c9c2c2!important;
        float: left;
        width: 100%;
        border-bottom: 1PX solid white!important;
        }*/

	    #divHistory {
	        margin-top: 1%;
	    }

	    .Backbutton {
	        color: white !important;
	        background: #343660 !important;
	        WIDTH: 64PX !important;
	        FONT-SIZE: 11.5PX !important; /* Modified By Madhuri.K On 26-03-2026 */
	        HEIGHT: 21PX !important;
	        FONT-WEIGHT: 600 !important;
	        /* MARGIN-BOTTOM: 0PX; */
	        LINE-HEIGHT: 0% !important;
	    }

	    .detail-inner .form-group {
	        width: 100%;
	        float: left;
	        padding: 0 15px 5px 12px !important;
	        border-bottom: 1px solid #ebedf2;
	        margin-bottom: 0;
	    }

	    /*End of Dipali V On 31st oct 2017*/
	    /* Added By Vidya Jadhav ON 14 Nov 2017 For UI Changes*/
	    @media (min-width: 768px) and (min-width: 1024px) {
	        #Discussion .row:not(.divRowHeader) {
	            margin-right: 33px;
	        }
	        /*#Discussion .odd-discus-chat:after
            {               
                left:748px !important;
                /*top:130px;*/
	        /*bottom:0px;*/
	        /*}*/
	        .odd-discus-chat:after {
	            right: -57px !important;
	            /* top: auto; */
	            bottom: 0px;
	        }

	        #btnBack {
	            padding-right: 0px;
	        }

	        /*.odd-discus-chat:before
        {    top: 102px;
        
        }*/
	        .odd-discus-chat {
	            height: auto;
	            width: 100%;
	        }

	        .discus-part {
	            margin-left: 34px !important;
	        }

	        #idCalender {
	            top: 12px;
	            position: absolute;
	            margin-left: 130px;
	        }

	        /*End Of Added By Vidya Jadhav ON 14 Nov 2017 For UI Changes*/
	    }
	    /*#divDiscussionScroll
        {
            overflow:auto;    
        }*/


	    @media (min-width: 768px) and (min-width: 1325px) {

	        .odd-discus-chat {
	            border-radius: 15px;
	            padding: 5px;
	            display: flex;
	            float: left;
	            width: 100% !important;
	            height: 124px;
	            border: 1px solid #cfd8dc;
	            background: #fff;
	            box-shadow: 0px 0 40px -10px #c3c8d1;
	            background: #cfd8dc;
	            border-top-left-radius: 15px;
	            border-bottom-right-radius: 0;
	            height: auto !important;
	        }


	        .discus-part {
	            margin-left: 34px !important;
	        }

	        .odd-discus-chat:before {
	            width: 0;
	            height: auto !important;
	            content: "";
	            top: 6px !important;
	            left: 808px !important;
	            position: relative;
	            border-top: 20px solid transparent;
	            border-right: 37px solid transparent;
	            border-bottom: 10px solid #cfd8dc;
	            border-left: 0 solid;
	            background-image: none;
	        }

	        .odd-chat {
	            padding-left: 16px !important;
	        }

	        .text-l {
	            float: left;
	            padding-right: 10px;
	            width: 100%;
	        }

	        #idCalender {
	            top: 12px !important;
	            position: absolute;
	            margin-left: 130px;
	        }
	    }

	    .content-wrapper {
	        min-width: 0px !important;
	    }

	    .req-del-from {
	        margin-top: 16px;
	    }

	    .checked1 {
	        color: orange;
	    }

	    .checked {
	        color: orange;
	        font-size: 20px;
	    }

	    #SpnRatingMsg {
	        font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
	        text-align: center;
	        margin-left: -15%;
	    }

	    .clslabel {
	        font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
	        font-weight: normal !important;
	    }

	    /*#btngroupcnlsave {
	        float: right !important;
	    }*/

	    #lblfeedback {
	        margin-left: -4% !important;
	        font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
	    }

	    #btnsave {
	        background-color: #364660 !important;
	        color: white;
	    }

	    #btncancel {
	        background-color: #364660 !important;
	        color: white;
	    }

	    #Feedbackdata {
	        width: 100% !important;
	        /* background-color:white!important;*/
	    }

	    #Feedback .modal-content {
	        background-color: #fefefe;
	        margin: 5% auto 15% auto;
	        border: 1px solid #888;
	        width: 640px !important;
	        height: 282px !important;
	    }


	    #divfeedback {
	        width: 94% !important;
	    }

	    .tblfeedback {
	        width: 94% !important;
	    }

	        .tblfeedback tr td {
	            width: 22% !important;
	        }

	        .tblfeedback tr {
	            height: 30px !important;
	        }

	    #btnBack {
	        text-align: center;
	        padding-right: 12px;
	    }

	    #btnSave1 {
	        MARGIN-LEFT: 11px;
	    }

	    .discus-chat .row {
	        float: left;
	        width: 100%;
	    }

	    pre {
	        display: block;
	        padding: 9.5px;
	        margin: 0 0 10px;
	        font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
	        line-height: 1.42857143;
	        color: #333;
	        word-break: normal;
	        word-wrap: break-word;
	        background-color: transparent !important;
	        border: none !important;
	        border-radius: 4px;
	        font-family: Times New Roman, Times, serif;
	    }
	    /*.odd-discus-chat:after{
        right: -57px !important;
        bottom: 0px;
        }*/
	    .add-forwd-btn button {
	        font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
	    }

	    #btnBack:hover {
	        color: white !important;
	    }


	    #btnSave1:hover {
	        color: white !important;
	    }

	    .odd-discus-chat .col-xs-1 {
	        padding-left: 16px;
	    }

	    .odd-chat .right {
	        margin-right: -69px;
	    }

	    .avatar {
	        /*margin:  15px -5PX 5px -3PX;*/
	        margin: 11px -21PX 9px -5PX;
	        padding-right: 0PX;
	    }

	    .read-more-wrap {
	        WHITE-SPACE: normal;
	    }

	    .clsFileControl {
	        display: none;
	    }

	    .clsFileControl {
	        display: none;
	    }

	    .clsFileControl1 {
	        display: none;
	    }

	    .clsFileControl1 {
	        display: none;
	    }

	    #idSearchHistory {
	        position: absolute;
	        margin-top: 10px;
	        margin-left: 10px;
	        left: 0px;
	    }

	    .odd-discus-chat .col-xs-1 {
	        padding-left: 29px;
	    }

	    .histry-src select {
	        width: 125px;
	    }

	    .classevenDiscuss .right {
	        MARGIN-RIGHT: -68PX;
	    }

	    .alertify-notifier .ajs-message {
	        width: 300px;
	        word-break: break-word;
	    }

	    #divHistory table th {
	        font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
	        margin-left: 16px;
	    }

	    #divAttachments table th {
	        font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
	        margin-left: 16px;
	    }

	    #Discussion pre {
	        FONT-FAMILY: "Open Sans",sans-serif;
	    }

	    #divAttachments .dataTables_wrapper .row:first-child {
	        display: none;
	    }

	    #divAttachments .dataTables_wrapper .row:last-child {
	        display: none;
	    }

	    #id03 .modal-content {
	        width: 501px;
	        height: 360px;
	    }

	    .cust-file h5 {
	        font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
	        margin-left: 15px;
	    }
	    /*Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing */
	    .readWrap {
	        white-space: pre-wrap;
	    }

	    #DivAttachmentadd .modal-content {
	        background-color: #fefefe;
	        margin: 5% auto 15% auto;
	        border: 1px solid #888;
	        width: 643px;
	        height: 314px;
	    }

	    #btnaddsave {
	        width: 106px !important;
	        height: 33px !important;
	        margin-top: 1% !important;
	        float: right !important;
	        margin-right: 2% !important;
	    }

	    #idDivLblAddDis {
	        padding-bottom: 13px;
	        margin-bottom: 2px;
	    }

	    .styleClass {
	        margin-right: 46px;
	    }

	    .table-responsive table th {
	        font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
	    }

	    #spnPriority {
	        font-size: 10px !important;
	    }

	    .assign-drop-grp select.form-control:not([size]):not([multiple]) {
	        height: 34px;
	    }

	    #Deliverable select.form-control:not([size]):not([multiple]) {
	        height: 34px;
	    }

	    .editor input {
	        font-size: 11px;
	    }

	    .editor textarea {
	        font-size: 11px;
	    }

	    .clsFileControl {
	        visibility: hidden;
	        display: none !important;
	    }

	    .clsFileControl1 {
	        visibility: hidden;
	        display: none !important;
	    }

	    /*End Of Added By Vidya Jadhav ON 23 Nov 2017 For HelpDesk Issue Fixing */
	    /*Added by Yogesh jalamkar on 12-DEC-2017 Purpose:issue fixing issueid:9627*/
	    #divIssueDetails .form-group {
	        background: none !important;
	    }

	    #CboActivityStatus {
	        display: inline-block;
	        FONT-WEIGHT: 500 !important; /*Issue id:9567*/
	    }

	    #CboActivity {
	        display: inline-block;
	        FONT-WEIGHT: 500 !important; /*Issue id:9567*/
	    }

	    #btnNewAttachmentFile {
	        text-decoration: underline;
	        padding-bottom: 13px;
	        margin-bottom: 2px;
	    }

	    #divAttachments {
	        height: 70%;
	    }

	    #StatusChangeTime {
	        z-index: 1;
	    }

	    input.form-control:not([type=button]) {
	        width: 100% !important;
	    }

	    .clstblApprove {
	        margin-bottom: 0px !important;
	    }

	    #btnReject, #btnApprove {
	        margin-top: 10px;
	    }

	    #StatusChangeTime {
	        margin-top: 0PX !important;
	    }

	    .bootstrap-timepicker {
	        margin-top: 6px;
	    }

	    .bootstrap-timepicker-widget {
	        width: 150px;
	    }
	    /*End by yogesh Jalamkar*/

	    /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
	    .form-control:-ms-input-placeholder { /* IE 10+ */
	        color: #bbb !important;
	    }

	    #txtTime {
	        width: 121px !important;
	        height: 26px;
	        padding: 0;
	        font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
	        border-radius: 21px;
	        padding-left: 16px !important;
	        border-color: #ddd;
	        font-size: 11.5px !important; /* Modified By Madhuri.K On 26-03-2026 */
	        font-weight: 100 !important;
	        outline: none;
	        margin-top: 6px !important;
	    }

	    .tab-section button:focus, .v-tabs .h-tabs div.tab button {
	        outline: none !important;
	        border: 1px solid #ddd !important;
	        border-bottom: none !important;
	        padding: 5px;
	    }
	    /*Added By Dipali V On 3rd Jan 2018 For Button Font Color*/
	    .updtae-btn:hover {
	        color: white !important;
	    }


	    .reqeust-discu h2 {
	        color: #fff;
	        line-height: 29px;
	        margin: 0;
	        float: none;
	    }
	    /*end of Added By Dipali V On 3rd Jan 2018 For Button Font Color*/

	    /*Added by Usha Pandit on 29.12.2018 for mail body font issue*/
	    .quest-info-new span {
	        font-size: 11.5px; /* Modified By Madhuri.K On 26-03-2026 */
	    }
	    /*End of Added by Usha Pandit on 28.12.2018 for mail body font issue*/
	</style>

  <body class="" id="page-top" onload="window_onload()">

        <input type="hidden" id="hdnPageNumber" value="0" />
      <input type="hidden" id="hdnPageFlag" value="0" />
      <input type="hidden" id="hdnLoadFilterID" value="0" />
       <input type="hidden" id="hdnStatusFilterID" value="0" />
       <input type="hidden" id="hdnDateFilterID" value="0" />

       <div id="MainDiv" style="overflow:auto;">
    <!-- Navigation -->
   <%--<div style="text-align: right;padding-right: 68px;"><button type="button" class="btn Backbutton" id="btnBack" style="color:white;background: #343660;" onclick=Back_OnClick()>Back</button></div>--%>
          <%-- <div style="text-align: right;padding-right: 68px;"><button type="button" class="btn" id="btnBack" style="color:white;background: white;" onclick=Back_OnClick()><i class='fa fa-backward'  style='color:black !important;font-size:20px' aria-hidden='true' title="Back"></i></button></div>--%>
           
    <div class="content-wrapper">

      <div class="container-fluid">
	  <!---- HelpDesk---------------------->
		  
			
		<div class="request-details-pg">		
			
			<div class="row">
				   <%PageInit()%>
                				
				<%--<div class="col-lg-4">
					<div class="request-detail">
						<div class="detail-inner">
						<h2>Request Details</h2>
						<form action="/action_page.php"class="req-del-from">
							<div class="row">
								<div class="form-group">
									<button type="button" class="btn updtae-btn">Update</button>
								</div>
							</div>
							<div class="row">								
								<div class="form-group">
									<div class="col-sm-6">
									  <label for="sel1">Status</label>
									  <select class="form-control" id="Select15">
										<option>Status</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>
									</div>
									  <div class="col-sm-6  ">
									  <label for="sel1">Date</label>
									  <div class="bootstrap-timepicker input-group">
										  <input type="text" class="form-control time-picker" id="timepicker1" >
										  <span class="input-group-addon add-on"><i class="fa fa-clock-o"></i></span>
									  </div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="form-group">
									<div class="col-sm-6">
									  <label for="sel1">Priority</label>
									  <select class="form-control" id="Select16">
										<option>Priority</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>
									</div>
									  <div class="col-sm-6">
									  <label for="sel1">Assigned To</label>
									  <select class="form-control" id="Select17">
										<option>Assigned To</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>
									</div>									
								</div>
							</div>
							<div class="row">								
								<div class="form-group">
									<div class="col-sm-6">
									  <label for="sel1">Request Type</label>
									  <select class="form-control" id="Select18">
										<option>Request Type</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>
									</div>
									  <div class="col-sm-6">
									  <label for="sel1">Request sub-Type</label>
									  <select class="form-control" id="Select19">
										<option>Request sub-Type</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>
									</div>
								</div>
							</div>							
							
							<div class="row">
								<div class="form-group">
									<div class="col-sm-6">
									  <label for="sel1">Project</label>
									  <select class="form-control" id="Select20">
										<option>Project</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>
									</div>
									  <div class="col-sm-6">
									  <label for="sel1">Product</label>
									  <select class="form-control" id="Select21">
										<option>Product</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>
									</div>
									<div class="col-sm-6">
									  <label for="sel1">Department</label>
									  <select class="form-control" id="Select22">
										<option>Department</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>
									</div>
									<div class="col-sm-6">
									  <label for="sel1">Module/Component</label>
									  <select class="form-control" id="Select23">
										<option>Module/Component</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>
									</div>									
									<div class="col-sm-6">
									  <label for="sel1">Organization Type</label>
									  <select class="form-control" id="Select24">
										<option>Organization Type</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>
									</div>
								</div>
							</div>							
							<div class="row">
								<div class="form-group">									
									  <label class="col-sm-12" for="sel1">Time Zone</label>
									  <div class="col-sm-12">
									  <select class="form-control" id="Select25">
										<option>Time Zone</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="form-group">									
									  <label class="control-label col-sm-4	" for="key">Key words</label>
									  <div class="col-sm-8">
									   <input type="text" class="form-control" id="key" placeholder="Enter Key word">
									  </div>									
								</div>
							</div>
							<div class="cust-file"><h5>Custome Field</h5>
							
							<div class="row">
								<div class="form-group">								
									<label class="control-label col-sm-2" for="date">Label2</label>
										<div class="col-sm-10">
										<input type="text" class="form-control" id="Text1" placeholder="Select Date">										 
										</div>								  									
								</div>
								
							</div>
							<div class="row">
								<div class="form-group">								
									<label class="control-label col-sm-2" for="status">Status</label>
										<div class="col-sm-4">
										  <input type="text" class="form-control" id="status">
										</div>	

									<label class="control-label col-sm-2" for="status">Status</label>
										<div class="col-sm-4">
										  <input type="text" class="form-control" id="Text2">
										</div>	
								</div>
							</div>
							
							<div class="row">
								<div class="form-group">								
									<button type="button" class="btn updtae-btn">Update</button>								  									
								</div>
							</div>
							
							</div>
						</form>
					</div>
					</div>
				</div>--%>
			   </div>
			</div>
		</div>
			
		</div>
      
      <!-- /.container-fluid -->

    </div>
    <!-- /.content-wrapper -->

  <!-- ----- Reply button popup ---------------------------->
	<div id="id06" class="modal">
  
  <form class="modal-content animate" action="/action_page.php">
    <div class="imgcontainer">
	<span class="appro-title">Reply</span>
      <span onclick="document.getElementById('id06').style.display='none'" class="close" title="Close">&times;</span>
    </div>

    <div class="container">
		
							<div class="form-group">
							  <label for="to"class="col-md-1">To</label>
							  <div class="col-md-9">
							  <input type="text" class="form-control" id="to" placeholder="Enter Subject" name="to"><span><button type="button" class="btn btn-default cancle-icon-btn"><i class="fa fa-times" aria-hidden="true"></i></button></span>
							  </div>
							  <div class="col-md-2">
								<span><a href="#">Cc  </a></span><span><a href="#">Bcc</a></span>
							  </div>
							</div>							
							<div class="form-group">
							  <label for="cc" class="col-md-1">Cc</label>
							  <div class="col-md-9">
							  <input type="text" class="form-control" id="cc" placeholder="Enter Subject" name="cc"><span><button type="button" class="btn btn-default cancle-icon-btn"><i class="fa fa-times" aria-hidden="true"></i></button></span>
							   </div>
							    <div class="col-md-2">								
							  </div>
							</div>
							<div class="form-group">
							  <label for="bcc" class="col-md-1">Bcc</label>
							  <div class="col-md-9">
							  <input type="text" class="form-control" id="bcc" placeholder="Enter Subject" name="bcc"><span><i class="fa fa-times" aria-hidden="true"></i></span>
							   </div>
							    <div class="col-md-2">
								
							  </div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
							  <label for="subject">Subject*</label>
							  <input type="text" class="form-control" id="subject" placeholder="Enter Subject" name="subject">
							  </div>
							</div>
							<div class="form-group">
							  <label for="subject">Description*</label>
							  <textarea  class="form-control"  placeholder="Enter Description" name="desc2"></textarea> 
							</div>	
							<div class="top-bar">
								<ul class="left">
									<li>
										<button type="submit" class="btn btn-default attch left"><i class="fa fa-paperclip" aria-hidden="true" title="Attachment"></i>Attachment</button>
									</li>
											
								</ul>
								<ul class="right">
									<li class="save"style="border:none;">
										<button type="submit" class="btn btn-default">Send</button>
									</li>
									<li>
										<button type="submit" class="btn btn-default cancle" style="background-color:#343660!important" title="Cancel">Cancel</button>
									</li>
								</ul>
							</div>							
							
							
							
						
    </div>
  </form>
</div>
<!-- ----- Forward button popup ---------------------------->
	<div id="id08" class="modal">
  
  <form class="modal-content animate" action="/action_page.php">
    <div class="imgcontainer">
	<span class="appro-title">Forward</span>
      <span onclick="document.getElementById('id08').style.display='none'" class="close" title="Close">&times;</span>
    </div>

    <div class="container">
		
							<div class="form-group">
							  <label for="to"class="col-md-1">To</label>
							  <div class="col-md-9">
							  <input type="text" class="form-control" id="Text3" placeholder="Enter Subject" name="to"><span><button type="button" class="btn btn-default cancle-icon-btn"><i class="fa fa-times" aria-hidden="true"></i></button></span>
							  </div>
							  <div class="col-md-2">
								<span><a href="#">Cc  </a></span><span><a href="#">Bcc</a></span>
							  </div>
							</div>							
							<div class="form-group">
							  <label for="cc" class="col-md-1">Cc</label>
							  <div class="col-md-9">
							  <input type="text" class="form-control" id="Text4" placeholder="Enter Subject" name="cc"><span><button type="button" class="btn btn-default cancle-icon-btn"><i class="fa fa-times" aria-hidden="true"></i></button></span>
							   </div>
							    <div class="col-md-2">								
							  </div>
							</div>
							<div class="form-group">
							  <label for="bcc" class="col-md-1">Bcc</label>
							  <div class="col-md-9">
							  <input type="text" class="form-control" id="Text5" placeholder="Enter Subject" name="bcc"><span><i class="fa fa-times" aria-hidden="true"></i></span>
							   </div>
							    <div class="col-md-2">
								
							  </div>
							</div>
							<div class="form-group">
								<div class="col-md-12">
							  <label for="subject">Subject*</label>
							  <input type="text" class="form-control" id="Text6" placeholder="Enter Subject" name="subject">
							  </div>
							</div>
							<div class="form-group">
							  <label for="subject">Description*</label>
							  <textarea  class="form-control"  placeholder="Enter Description" name="desc2"></textarea> 
							</div>	
							<div class="top-bar">
								<ul class="left">
									<li>
										<button type="submit" class="btn btn-default attch left"><i class="fa fa-paperclip" aria-hidden="true"></i>Attachment</button>
									</li>
											
								</ul>
								<ul class="right">
									<li class="save"style="border:none;">
										<button type="submit" class="btn btn-default">Send</button>
									</li>
									<li>
										<button type="submit" class="btn btn-default cancle">Cancle</button>
									</li>
								</ul>
							</div>							
							
							
							
						
    </div>
  </form>
</div>
 <!-- ----- Add note button popup---------------------------->
	<div id="id07" class="modal">
  
  <form enctype="multipart/form-data" class="modal-content animate" id="frmAttachmentDiv" action="/action_page.php" method="post">
    <div class="imgcontainer">
	<span class="appro-title">Add New Discussion</span>
      <span onclick="Close_AddNote()" class="close" title="Close">&times;</span>
    </div>

    <div class="container">	
						<div class="form-group">
							  <label for="subject">Comment *</label>
							  <%-- Added By Bharat T on 20th-Oct-2017 for Attachment CHanges --%>
							  <%--<textarea  class="form-control"  placeholder="Enter Description" name="desc3"></textarea>--%> 
                            <%=CommonFunctions.HTMLControls.DrawTextArea("txtNewDiscussion", "txtNewDiscussion", , "form-control", , , , ,  , 110, maxLength:=4000, value:="", ToBeInserted:=" placeholder='Enter Description(Maxlength 4000 Chars)'").Replace("'", "\'")%>
                            <%--End of  Added By Bharat T on 20th-Oct-2017 for Attachment CHanges --%>
							</div>		
        
        <% If (m_strLoginType <> "C" And m_strReuestLoginType.ToUpper() = "C") Then%>
        <div class="form-group" style="margin-bottom:0px">
             <label for="IsShowToCustomer">Is Show To Customer *</label>
            <Input type="checkbox" name="chkIsShowToCustomer" id="chkIsShowToCustomer" class="clsCheckBox" CHECKED />
        </div>	
        <%End If%>
        <div class="form-group">
             <label for="Status" >Status </label>
           <%=CommonFunctions.HTMLControls.DrawComboBox("cboDiscussionStatus", "usp_CRM_Get_RequestStatus " & m_lngQueryID.ToString & "," & HttpContext.Current.Session("intPostID"), 200, m_intStatusID.ToString, " class='form-control' ", , , , False).Replace("'", "\'")%>
             <%--onchange=javascript:cboStatus_OnChange()--%>
							</div>							
							<div class="top-bar">
								<ul class="left">
									<li>
										 <%-- Added By Bharat T on 20th-Oct-2017 for Attachment CHanges --%>
										<button type="button" class="btn btn-default attch left" id="btnSelectFile" FileCount="0" onclick="SelectFile();"><i class="fa fa-paperclip" aria-hidden="true" "></i>Attachment</button>
                                        <div id="FileControlUploadDiv">
                                            <%=CommonFunctions.HTMLControls.DrawFileControl("txtFileName0", "txtFileName0", , 74, , , , , , "onkeydown='return false;' onbeforepaste='return false;' onpaste='return false;' onchange='addFileinGrid()' style='display:none;' class='clsFileControl'", False)%>
                                        </div>
                                         <%--End of  Added By Bharat T on 20th-Oct-2017 for Attachment CHanges --%>
									</li>
											
								</ul>
								<ul class="right" style="margin-right:0%!important;">
									<li class="save"style="border:none;">										
                                        <%-- Added onclick By Bharat T on 25th-Oct-2017 --%>
										<button type="button" class="btn btn-default save" id="SaveNote" onclick="AddNoteClick();"  title="Save Discussion" data-toggle='tooltip' data-placement='top' data-container='body'>Submit</button>
                                         <%-- End of Added onclick By Bharat T on 25th-Oct-2017 --%>
									</li>
									<li>
										<button type="button" class="btn btn-default save"  id="CancelNote" onclick="Cancel_Note()" title="Clear">Clear</button></li>
								</ul>
							</div>

        <%-- Added By Bharat T on 20th-Oct-2017 for Attachment CHanges --%>
        <div class="bottom-bar" style="height:120px;overflow:auto;">
                    <table id="tblFiles" style="display:none;width:100%;" class="clsGridTable table">
                        <thead class="clsTRColumnHeader" align="left" style="font-size:12px">
                            <tr>
                                <th></th> 
                                <th>Files</th> 
                                <th>Comments</th> 
                                <%If m_strLoginType <> "C" Then%>
                                <th>Document Status(Checked if internal)</th>  
                                <%End If%>
                                 <th>Remove</th>  
                            </tr>                                                                                
                        </thead>
                        <tbody>
                          
                        </tbody>
                    </table>
            </div>
						<%-- End of Added By Bharat T on 20th-Oct-2017 for Attachment CHanges --%>
						
    </div>
  </form>
</div>

      




<!------ Attachment Icon---------------------->
<div id="id03" class="modal">
  
  <form class="modal-content animate" action="/action_page.php">
    <div class="imgcontainer2">
	<span class="appro-title">Attachments</span>
      <span onclick="document.getElementById('id03').style.display='none'" class="close" title="Close"  data-toggle='tooltip' data-placement='right'>&times;</span>
    </div>

    <div class="container">
			<div class="attachment">
				<div class="row">
					<div class="col-md-12">
						<button type="button" id="btnDownloadZip" QueryID="001" QueryDetailID="002" class="btn btn-default download save" onclick="DownloadZip(this);" title ='Download All(Zip)'><i class="fa fa-download" aria-hidden="true"></i>Download All (Zip)</button>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-12">
					<div class="down-info" id="attachmentMainDiv">
						 
					</div>
					</div>
				</div>		
			</div>
    </div>	

  </form>  
</div>


<%--Dipali V On 31st Oct 2017--%>

      <!---------- Flag icon---------->
<div id="FlagTracking" class="modal">
  
  <form class="modal-content animate" action="/action_page.php">
    <div class="imgcontainer2">
	<span class="appro-title">Tracking Details</span>
      <span onclick="document.getElementById('FlagTracking').style.display='none'" class="close" title="Close">&times;</span>
    </div>

    <div class="container">
			<div class="trac-detail">
				<div class="row">
					<div class="col-md-12">
						<p class="flag-info" style="width:42%">Flagging marks an item to remind you that it needs to be followed up.
							After it has been followed up, you can mark it complete.</p>
					</div>
				</div>
				
				<div class="row">
					<div class="col-md-12">
					<div class="help-que" style="width:42% ; background-color:white">
					<%--	<p class="help"><span>Request ID</span><span class="right">Id:<span style="font-weight:300;" id="spnRequestID"></span></span></p>--%>
                        	<p class="help" style="font-weight:normal;font-size:12px;"><span>Request ID : </span><span style="font-weight:normal;font-size:12px;" id="spnRequestID"></span</p>
						<p class="que" data-toggle="tooltip" data-placement="left" title="Subject" style="font-weight:normal;font-size:12px;">Can I View By Columns and Rows?</p>
					</div>
					</div>
				</div>
				<div class="un-flag">
				<div class="row">				
					<div class="col-xs-4">

                        <% CommonFunctions.HTMLControls.DrawComboBox("cbFlagTo", "usp_FlagTo_ComboFill", 230, , "class='form-control' onblur=""javascript:cbFlagTo_OnBlur()""", True, , , , , , 1)%>
						
					</div>
					<div class="col-xs-8" style="padding-right:0px;margin-left:-7%">						
										<input type="text" class="form-control" id="dtDueDate" placeholder="Due Date" style="width: 120px!important;"> 
											<i class="fa fa-calendar" onclick="$('#dtDueDate').datepicker();$('#dtDueDate').datepicker('show');"></i>
                        <label style="position: relative;top: -33px;right: -104px;">*</label>
					</div>
					
					
				</div>
				</div>
				<div class="checkbox">
				<div class="row">
                        <input type="hidden" id="hdnRequestID1" name="hdnRequestID1" />
                        <input type="hidden" id="hdnFlagUniqueID1" name="hdnFlagUniqueID1" />
					<div class="col-xs-3" style="width:15%!important">						
						  <input type="checkbox" id="chkComplete" value=""><label>Complete</label>
					</div>
					<div class="col-xs-3" style="width:10%!important">
					
					</div>
					<div class="col-xs-6" style="margin-left:39px;">		
                        	<button type="button" class="btn btn-default" id="btnClearFlag" onclick="ClearFlag();" >UnFlag</button>		
						  <button type="button" class="btn btn-default" onclick="SaveFlag();">Save</button>
					</div>
					</div>
				</div>
			</div>
    </div>
  </form>
</div>
       <%--   Added By Dipali V On 14th Nov 2017--%>
      <div id="Feedback" class="modal">
  
  <form class="modal-content animate" action="/action_page.php">
    <div class="imgFeedback">
	<span><i class='fa fa-thumbs-o-up' aria-hidden='true' style="margin-top:1.7%;margin-left:1%"></i></span><span class="appro-title" style="margin-left:15px!important;color:white">FeedBack</span>
      <span onclick="close_feedback()" class="close" title="Close">&times;</span>
    </div>

    <div class="container" id="Feedbackdata">
			
    </div>
  </form>
</div>



<div id="divCustomer" class="modal" data-backdrop="static">
  <div class="modal-dialog modal-md">
  <form class="modal-content animate" action="/action_page.php">
    <div class="imgFeedback">
	<span class="appro-title" style="margin-left:15px!important;color:white">Add New Customer</span>
      <span class="close" data-dismiss="modal" title="Close">&times;</span>
    </div>

    <div id="divCustomerdata">
			<div class='form-group'>
                <label class='control-label col-sm-4 col-xs-4' style="text-align:right" for='request type'>Customer Name*</label>
                <div class='col-sm-8 col-xs-8'>
                <%CommonFunctions.HTMLControls.DrawTextBox("CustomerName", "CustomerName", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Customer Name' ", , EnableHTMLEncode:=True)%>
                </div>
                <label class='control-label col-sm-4 col-xs-4' style="text-align:right" for='request type'>Abbreviated Name*</label>
                <div class='col-sm-8 col-xs-8'>
                <%CommonFunctions.HTMLControls.DrawTextBox("CustomerAbbrName", "CustomerAbbrName", "form-control", , , , , , , , , , " class='form-control'  placeholder='Enter Abbreviated Name' ", , EnableHTMLEncode:=True)%>
                </div>
                <label class='control-label col-sm-4 col-xs-4' style="text-align:right" for='request type'>Email ID*</label>
                <div class='col-sm-8 col-xs-8'>
                <%CommonFunctions.HTMLControls.DrawTextBox("CustomerEmail", "CustomerEmail", "form-control", , , m_strEmailID, , , , , , , " class='form-control'  placeholder='Enter Email ID' ", , EnableHTMLEncode:=True)%>
                </div>
                 <label class='control-label col-sm-4 col-xs-4' style="text-align:right" for='request type'>Department*</label>
                <div class='col-sm-8 col-xs-8'>
                <%CommonFunctions.HTMLControls.DrawComboBox("CboDepartmentCustomer", "usp_NG2_Sel_DepartmentList " & Session("intUserID"), , "", "class='form-control' " & Style & "", False, False)%>
                </div>
            </div>
            <div class='' id='btngroupcnlsave'>
                <div class='' id='btngroupcnlsave1'>
                    <button type='button' class='btn updtae-btn'  onclick="CancelCustomer()" style='margin-left:4px'  title='Cancel'>Cancel</button>
                    <button type='button' class='btn updtae-btn' onclick='SaveCustomer()' title='Save Customer'>Save</button>
                </div>
            </div>
    </div>
  </form>
      </div> 
    <style>
        #divCustomerdata .form-control {
            width: 200px !important;
            height: 36px !important;
        }

        #divCustomerdata .form-group {
            margin-top: 10px;
        }

        #divCustomerdata .control-label {
            margin-top: 13px;
            font-weight: normal;
        }

        #btngroupcnlsave1 {
            margin: 0px 35%;
        }

        input.form-control:not([type=button]) {
            /*Commented by Nilam R on 31.12.2018 for status change time custom field alignment issue*/
            /*margin-bottom: 9px!important;*/
            /*End of Commented by Nilam R on 31.12.2018 for status change time custom field alignment issue*/
            margin-top: 2px !important;
        }

        @media (min-width: 576px) {
            .modal-dialog {
                max-width: 500px;
                margin: 30px auto !important;
            }
        }
    </style>
</div>


      
    <%--  Added By Dipali V On 24th Nov 2017 For Attachment Tab For new attachment--%>
       <div id="dIvaddattachment" class="modal">
            <form class="modal-content animate" action="" method="post" accept-charset="utf-8">
                                       
            <div class="imgcontainer2">
               	<span class="appro-title">Add New Attachment</span>
                <%--<span onclick="document.getElementById('dIvaddattachment').style.display='none'" class="close" title="Close">&times;</span>--%>
                  <span onclick="Close_NewAttachment()" class="close" title="Close">&times;</span>
           </div>
            <div class="attacment-file">
                 <div class="form-group">
                                              
                       <div id="Addattachemt">
                                <%=CommonFunctions.HTMLControls.DrawFileControl("txtaddattachment0", "txtaddattachment0", , 74, , , , , , "onkeydown='return false;' onbeforepaste='return false;' onpaste='return false;' onchange='addFileinGridnew()' style='display:none !important;' class='clsFileControl1'", False, True)%>
                      </div>
                    <div class="input-group col-xs-12">
                                                    <%--      <input type="text" class="form-control input-lg" disabled placeholder="attacment files">--%>
                           <span class="input-group-btn">
                           <button class="browse btn btn-primary input-lg" id="addattachmenttab" filecount="0" onclick="SelectAddnewFile();" type="button" style="width:106px!important;height:33px!important" title="Add Attachments"><i class="fa fa-paperclip" aria-hidden="true" title="Add Attachments"></i> Attachment</button>
                                 <button class="browse btn btn-primary input-lg" id="btnaddsave"  type="button" style="width:106px!important;height:33px!important" title="Save" onclick="SaveAttachmentDetails()">Save</button>
                           </span>
                    </div>
                 </div>
            </div>
          
                   <div id="divAttachments" class="bottom-bar" style="overflow:auto">

                                        <table id="tblFilesadd" style="display: none; margin-top: 1%" class="clsGridTable table">
                                            <thead class="clsTRColumnHeader" align="left">
                                                <tr>
                                                    <th></th>
                                                    <th>Files</th>
                                                    <th>Comments</th>
                                                    <%If HttpContext.Current.Session("LoginType") = "E" Then%>
                                                        <th>Document Status(Checked if internal)</th>                                                   
                                                    <%End If%>
                                                    
                                                    <th>Remove</th>
                                                </tr>
                                            </thead>
                                          <tbody>
                                        </tbody>
                                    </table>
                          </div>                      
         
                     </form> 
                 </div>
      <%--  End of Added By Dipali V On 24th Nov 2017 For Attachment Tab For new attachment--%>
     
     <%--  End of  Added By Dipali V On 14th Nov 2017--%> 
<!--------------------- end Flag icon------------------->
<%--End of Dipali V On 31st Oct 2017--%>

<!--End Attachment Icon -->

     
    
</body>
    <!-- Bootstrap core JavaScript -->
    <!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
		<%--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>--%>


		<%--<script src="vendor/popper/popper.min.js"></script>--%>
      <script src="../../../EnhancementFiles/vendor/popper/popper.min.js"></script>
		<%--<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>--%>
    <!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
  <%--  <link href="../../../EnhancementFiles/OnlineFiles/datepicker/datepicker3.css" rel="stylesheet" />
<script src="../../../EnhancementFiles/OnlineFiles/datepicker/bootstrap-datepicker.js"></script>--%>
    <!-- <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script> -->
         <script src="../../../EnhancementFiles/js/sb-admin.js"></script>
    <%--  <script src="../../../EnhancementFiles/js/editor.js"></script>--%>
    
<!-- Time picker -->
<%--<script src="js/timepicker.min.js"></script>
<script src="js/timepicker.js"></script>--%>
   
<script src="../../../EnhancementFiles/js/timepicker.js"></script>
<script src="../../../EnhancementFiles/js/timepicker.min.js"></script>
<!-- <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script>

<script src="../../General/CommonFunctions.js"></script>
    <script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 


    <script src="../../../Whizible2.0-new/dist/js/jquery.dataTables-1.13.1.min.js"></script> -->
<script src="../../../EnhancementFiles/vendor/datatables/dataTables.bootstrap4.js"></script>
    <script src="../../../Whizible2.0-new/dist/js/dataTables.bootstrap5.min.js"></script>

<script>

    $(function () {

        $('#timepicker1').timepicker();
        $('#timepicker2').timepicker();
        $('#StatusChangeTime').timepicker(
            {
                format: 'hh:mm',
                use24hours: true,
                showMeridian: false,
                'timeFormat': 'H:i',
                upArrowStyle: 'fa fa-chevron-up',
                downArrowStyle: 'fa fa-chevron-down',
            });
        try {
            $("#btnAttachement").click();
        }
        catch (e) {
        }

    });
</script>

<!-- End of time picker -->
   <script>
       $(function () {
           $("#datepicker").datepicker();
           $("#datepicker1").datepicker();
           $("#datepicker2").datepicker();
           $("#dtStatusChangedate").datepicker();
           $("#dtExpResdate").datepicker();
       });
	</script>

    
<script>
    $(document).ready(function () {

        //    debugger;
        var bodyHeight = window.innerHeight - $('#MainDiv').offset().top;
        //    alert(bodyHeight);
        $('#MainDiv').css('height', bodyHeight - 10 + 'px');

        $('.collapse.in').prev('.panel-heading').addClass('active');
        $('#accordion, #bs-collapse')
            .on('show.bs.collapse', function (a) {
                $(a.target).prev('.panel-heading').addClass('active');
            })
            .on('hide.bs.collapse', function (a) {
                $(a.target).prev('.panel-heading').removeClass('active');
            });
        var ObjTd = window.frames.parent.document.getElementById('tdTree')
        var ObjImg = window.frames.parent.document.getElementById('ImgShowHide')
        var ObjLeftnavigation = window.frames.parent.document.getElementById('tblLeftNavigation')

        if (ObjTd != null && ObjImg != null) {

            ObjTd.style.display = 'none';
            ObjImg.src = '../../Images/Home/RightMove.gif';
            ObjLeftnavigation.style.display = '';
        }
        //  $("#txtEditor").Editor();
        //  $("#txtEditor1").Editor();
        //  $("#txtEditor2").Editor();
        //  $("#txtEditor3").Editor();
        if (document.getElementById('CboSubRequestType') != null)
            document.getElementById('CboSubRequestType').onchange();
        DisableControls();
        // $('.fa').tooltip();

        // $('.quest-info p').tooltip();

        //alert(window.innerHeight);
        //alert(window.innerWidth);
        //Added By Vaijat K ON 04/12/2017 For Issue ID - 9632
        var strIsRequestApprover = '<%=CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_NG2_IsRequestApprover " & m_lngQueryID & "," & Session("intUserID"), True), "")%>';
        if (strIsRequestApprover == '1') {
            $("#CboDepartment").attr("disabled", "disabled");
            $("#CboAssignTo").attr("disabled", "disabled");
            $("#cboProduct").attr("disabled", "disabled");
            $("#CboModuleComponent").attr("disabled", "disabled");
        }
        //End Added By Vaijat K ON 04/12/2017 For Issue ID - 9632
        RefreshCount();
        $('#divAprroveReject .dropdown-menu').on("click.bs.dropdown", function (e) {
            e.stopPropagation();
            e.preventDefault();
        });

        Customer_New_Onchange(document.getElementById("CboCustomer"));
    });

    function RefreshCount() {
        //Added By Vaijat K ON 13/12/2017 For Refreshing count
        $.ajax({
            url: "../../General/Navigation.aspx/GetDataCountAJAX",
            data: JSON.stringify({ id: "1" }),
            type: "POST",
            dataType: "json",
            contentType: "application/json",
            success: function (result) {
                var strResult = String(result.d).split("|");
                $("#alertCount", window.parent.parent.document).html(strResult[0]);
                $("#NotificationCount", window.parent.parent.document).html(strResult[1]);
                $("#DiscussionCount", window.parent.parent.document).html(strResult[2]);
            },
            error: function (xhr) {
                console.log(xhr);
            }
        })
        //End Added By Vaijat K ON 13/12/2017 For Refreshing count
    }
    function window_onload() {

        $('#StatusChangeTime').timepicker(
            {
                format: 'hh:mm',
                use24hours: true,
                showMeridian: false,
                'timeFormat': 'H:i',
                upArrowStyle: 'fa fa-chevron-up',
                downArrowStyle: 'fa fa-chevron-down',
            });


        //Added By Bharat T on 21st-Nov-2017 for request list page state saving
        var PageNumber = getParameterByName("PageNumber");
        var PageFlag = getParameterByName("PageFlag");
        var LoadFilterID = getParameterByName("LoadFilterID");
        var strStatusFilterID = getParameterByName("StatusFilterID");
        var strDateFilterID = getParameterByName("DateFilterID");

        $("#hdnPageNumber").val(PageNumber);
        $("#hdnPageFlag").val(PageFlag);
        $("#hdnLoadFilterID").val(LoadFilterID);
        $("#hdnStatusFilterID").val(strStatusFilterID);
        $("#hdnDateFilterID").val(strDateFilterID);
        //End of Added By Bharat T on 21st-Nov-2017 for request list page state saving

    }

</script>
    <!-- Custom scripts for this template -->
    <%--<script src="js/sb-admin.min.js"></script>--%>

	

<script>
    var RequestID = document.getElementById('hdnRequestID').value;


    function openCity1(evt, cityName) {
        var i, tabcontent1, tablinks1;
        tabcontent1 = document.getElementsByClassName("tabcontent1");

        for (i = 0; i < tabcontent1.length; i++) {
            tabcontent1[i].style.display = "none";
        }
        tablinks1 = document.getElementsByClassName("tablinks1");


        for (i = 0; i < tablinks1.length; i++) {
            tablinks1[i].className = tablinks1[i].className.replace(" active", "");
        }

        // if (cityName != "Discussion") {
        RefreshIssueTab(cityName);
        //$('.fa').tooltip();
        //$('.attach-lnk').tooltip();
        // }
        document.getElementById(cityName).style.display = "block";
        if (evt != undefined) {
            if (!evt.currentTarget) {
                evt.currentTarget.className += " active";
            }
        }
    }

    // Get the element with id="defaultOpen" and click on it
    var strPageName = "CRM_RequestDetails_UnCategorised.aspx";
    function RefreshIssueTab(cityName) {
        var strResult, data;
        var GridParameter = {};


        GridParameter.cityName = cityName;
        var DepartmentID = document.getElementById('hdnDepartmentID').value;
        data = JSON.stringify({ RequestID: RequestID, Flag: cityName, DepartmentID: DepartmentID });

        strResult = AJAXCallWithResult(strPageName + "/GetAssociationTabs", data, false);
        //  alert(strResult.d);
        if (strResult.d != '') {

            document.getElementById(cityName).innerHTML = "";
            document.getElementById(cityName).innerHTML = strResult.d;
            $('#timepicker2').timepicker();
            $("#datepicker").datepicker();
            $("#datepicker1").datepicker();
            $("#datepicker2").datepicker();
            $('#StatusChangeTime').timepicker(
                {
                    format: 'hh:mm',
                    use24hours: true,
                    showMeridian: false,
                    'timeFormat': 'H:i',
                    upArrowStyle: 'fa fa-chevron-up',
                    downArrowStyle: 'fa fa-chevron-down',
                });

        }
        //if(getParameterByName("FromWhere").toUpperCase() == "SAVEDELIVERABLEREFRESH")
        //{
        //    var i, tabcontent1;

        //    tabcontent1 = document.getElementsByClassName("tabcontent1");
        //    for (i = 0; i < tabcontent1.length; i++) {
        //        tabcontent1[i].style.display = "none";
        //    }


        //    var cityName1 ="Deliverable";
        //    document.getElementById(cityName1).style.display = "block";
        //}
    }

    var strPageName = "CRM_RequestDetails_UnCategorised.aspx";

    function RefreshGrid(cityName) {

        var strResult, data;
        var GridParameter = {};
        GridParameter.cityName = cityName;
        var FieldName = "null";
        var ModifiedBy = "null";
        var filterflag = "Load";
        //if (cityName == "History")
        //{
        //    FieldName = document.getElementById('CboFieldName').value;
        //    ModifiedBy = document.getElementById('CboModifiedBy').value;
        //}
        data = JSON.stringify({ RequestID: RequestID, Flag: cityName, FieldName: FieldName, ModifiedBy: ModifiedBy, filterflag: filterflag });

        strResult = AJAXCallWithResult(strPageName + "/RequestDetailsTabs", data, false);
        //  alert(strResult.d);
        if (strResult.d != '') {
            document.getElementById(cityName).innerHTML = "";
            // alert(strResult.d);
            document.getElementById(cityName).innerHTML = strResult.d;
            //Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Page Changes
            if (cityName == 'History') {
                datatables('divHistory', 'txtSearchHistory');
            }


            if (cityName == 'Attachments') {
                //  $("#divHistory .dataTables_wrapper .row:first-child").hide();
                // datatables('divAttachments', '');
            }

            //End Of Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Page Changes

            if (cityName == "Association") {
                document.getElementById("defaultOpen1").click();
            }
            //$('.fa').tooltip();
            //$('.attach-lnk').tooltip();

        }

    }
    //Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Page Changes
    function datatables(divID, txtBoxID) {

        //$('#' + divID + ' > table').removeClass("clsGridTable");
        // $('#' + divID + ' table').addClass("table table-striped table-bordered table-hover");
        //  $('#' + divID + ' > table').css("border", "1px solid #DDD");
        var table = $('#' + divID + ' > table').DataTable({
            "ordering": false
        });
        if (divID == "divAttachments") {
            $("#" + divID + "dataTable table").css("width", "100%");
            $("#" + divID + "dataTable table th:nth-child(6)").css("width", "10%");
        }

        if (txtBoxID != "") {
            $('#' + txtBoxID).on('keyup change', function () {
                table.search($(this).val()).draw();
            })
        }
    }
    //End of Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Page Changes
    var ProjectID;
    function Project_Onchnge(obj) {
        var url = "CRM_RequestDetails_UnCategorised.aspx/PlotIssueDetails"
        ProjectID = obj.value;
        // alert(ProjectID)
        if (ProjectID == "") {

            ProjectID = "";
        }
        // alert(obj);
        var IssueType = "";
        data = JSON.stringify({ ProjectID: ProjectID, RequestID: RequestID, IssueType: IssueType });
        CustomAJAXCall(url, data, BindDropdownProject);
    }

    //  Added by Yogesh Jalamkar on 28-NOV-2017 Purpose:Issue status should be depend on Issue type
    function IssueType_Onchnge(obj) {
        var url = "CRM_RequestDetails_UnCategorised.aspx/PlotIssueDetails"
        ProjectID = $("#CboIssueProject").val();
        // alert(ProjectID)
        if (ProjectID == "") {

            ProjectID = "";
        }
        // alert(obj);
        var strIssueType = obj.value;
        data = JSON.stringify({ ProjectID: ProjectID, RequestID: RequestID, IssueType: strIssueType });
        CustomAJAXCall(url, data, BindDropdownProject);
    }
    //End by Yogesh Jalamkar
    function BindDropdownProject(result) {

        // var strArray = String(result.d);
        var objCbo = document.getElementById("divIssueDetails");
        var i = 0;
        objCbo.innerHTML = "";
        objCbo.innerHTML = result.d;

    }


    function Customer_Onchange(obj, LoginID, ProjectID) {

        var url = "CRM_RequestDetails_UnCategorised.aspx/GetProductCombo"
        var CustomerID = obj.value;
        // var ProjectID1 = ProjectID;
        // var RequestID = "81490";

        data = JSON.stringify({ CustomerID: CustomerID, RequestID: RequestID, ProjectID: ProjectID, LoginID: LoginID });
        CustomAJAXCall(url, data, BindDropdownProduct);
    }

    function BindDropdownProduct(result) {

        var strArray = String(result.d).split("|")
        var objCbo = document.getElementById("CboIssueProduct");
        var i = 0;
        objCbo.innerHTML = "";

        if (objCbo.value != '') {
            insBlankOpt(objCbo);
        }
        $.each(JSON.parse(strArray[0]), function (id, obj) {

            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = obj.ProductVersion
            objOption.value = obj.ProductVersionID;

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


    function RequestType_OnChange(obj, DepartmentID) {

        var url = "CRM_RequestDetails_UnCategorised.aspx/GetRequestType"
        RequestTypeID = obj.value;

        var CustomerID = 0;
        var EmployeeID = 0;
        //    CustomerID = document.getElementById('hdnCustomerID').value;
        //  EmployeeID = document.getElementById('hdnEmployeeID').value;

        //Commented and added by Yogesh Jalamkar on 29-NOV-2017 Purpose: Issue fixing
        //data = JSON.stringify({ TypeID: DepartmentID, WhichList: 'SubRequestType', RequestTypeID: '', CustomerID: CustomerID, EmployeeID: EmployeeID });
        data = JSON.stringify({ TypeID: $("#CboDepartment").val(), WhichList: 'SubRequestType', RequestTypeID: RequestTypeID, CustomerID: $("#CboCustomer").val(), EmployeeID: '<%=Session("intUserID")%>', QueryID: document.getElementById('hdnRequestID').value });
        //End of addition by Yogesh Jalamkar

        //  data = JSON.stringify({ TypeID: DepartmentID, WhichList: 'SubRequestType', RequestTypeID: RequestTypeID });
        CustomAJAXCall(url, data, BindDropdownSubRequestType);
    }

    function BindDropdownSubRequestType(result) {

        // alert(result.d);
        var strArray = String(result.d).split("|")
        var objCbo = document.getElementById("CboSubRequestType");
        var i = 0;
        objCbo.innerHTML = "";


        insBlankOpt(objCbo);

        $.each(JSON.parse(strArray[0]), function (id, obj) {

            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = obj.SubRequestType
            objOption.value = obj.SubRequestTypeID;;

        });
    }

    function Product_OnChange(obj) {

        var url = "CRM_RequestDetails_UnCategorised.aspx/GetModuleOrComponent"
        var ProductID = obj.value;
        data = JSON.stringify({ ProductID: ProductID });

        CustomAJAXCall(url, data, BindDropdownModule1);

    }

    function BindDropdownModule1(result) {

        var strArray = String(result.d).split("|")

        console.log(strArray[0]);
        var objCbo = document.getElementById("CboModuleComponent");
        var i = 0;
        objCbo.innerHTML = "";

        if (objCbo.value != '') {
            insBlankOpt(objCbo);
        }

        $.each(JSON.parse(strArray[0]), function (id, obj) {

            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = obj.Component
            objOption.value = obj.ComponentID;;
        });
    }

    function SubRequestType_OnChange(obj) {

        //var url = "CRM_RequestDetails_UnCategorised.aspx/PlotCustomFields"
        //var DepartmentID = document.getElementById('CboDepartment').value;
        //var RequestTypeID = document.getElementById('CboRequestType').value;

        //SubRequestTypeID = obj.value;

        ////Added By Vidya Jadhav ON 25 Oct 2017 For Request Details-Custom field Plotting
        //var CustomerID = 0;
        //data = JSON.stringify({ DepartmentID: DepartmentID, RequestTypeID: RequestTypeID, SubRequestTypeID: SubRequestTypeID, CustomerID: CustomerID, RequestID: RequestID });
        //// alert(data);
        //CustomAJAXCall(url, data, PlotCustomFieldSuccess);
    }
    function PlotCustomFieldSuccess(result) {
        //   debugger;

        var resultArr = result.d.split("####");
        //  alert(resultArr[0]);
        var WholeScript = '';
        document.getElementById('divCustomField').innerHTML = "";
        document.getElementById('divCustomField').innerHTML = resultArr[0];

        if (document.getElementById('CustomFieldList') != null) {
            if (document.getElementById('CustomFieldList').value == "") {
                document.getElementById('divCustomField').style.textAlign = "center";
                document.getElementById('divCustomField').innerHTML += "<label style='text-align:center;FONT-SIZE:12px;vertical-align:top;font-weight:normal;'>There is no custom fileds mapped to this sub request type</label>";
            }
        }
        // document.getElementById('divGuidelines').innerHTML = "";
        //document.getElementById('divGuidelines').innerHTML = resultArr[2];
        var e = document.getElementById('MainScript');
        WholeScript += resultArr[1];
        if (e != null)
            e.innerHTML = '';

        var script = "  document.getElementById('btnSave').onclick = function(){ " + WholeScript + " SaveRequest_OnClick(); }; document.getElementById('btnSave1').onclick = function(){ " + WholeScript + " SaveRequest_OnClick(); }; "

        // script += " function ValidateCustomField(){ "+ WholeScript +" } "

        //   var CreateTaskscript = " document.getElementByTagName('Title=Create Tasks').onclick = function(){ " + WholeScript + " } ";

        //script += "<\/script>"

        var newsc = script;
        //  alert(newsc);
        if (e != null)
            e.innerHTML = newsc;
        //  alert(e.innerHTML);
        if (e != null)
            $.globalEval(e.innerHTML);

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
                window.location.href = "../../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
            }
        });

    }
    function TaskProject_Onchange(obj) {
        var url = "CRM_RequestDetails_UnCategorised.aspx/GetTaskType"
        var ProjectID = obj.value;
        var RequestID = $("#hdnRequestID").val();
        data = JSON.stringify({ ProjectID: ProjectID, RequestID: RequestID });
        CustomAJAXCall(url, data, BindDropdownTaskType);


    }

    function BindDropdownTaskType(result) {

        var strArray = String(result.d).split("|")
        var objCbo = document.getElementById("cboTaskType");

        var i = 0;
        objCbo.innerHTML = "";

        if (objCbo.value != '') {
            insBlankOpt(objCbo);
        }
        $.each(JSON.parse(strArray[0]), function (id, obj) {

            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = obj.TaskType
            objOption.value = obj.TaskTypeID;;
        });
        var objCbo1 = document.getElementById("CboTaskAssignTo");
        objCbo1.innerHTML = "";

        if (objCbo1.value != '') {
            insBlankOpt(objCbo1);
        }
        // alert(strArray[1]);
        $.each(JSON.parse(strArray[1]), function (id, obj) {

            var objOption = document.createElement("OPTION");
            objCbo1.options.add(objOption);
            objOption.text = obj.UserName;
            objOption.value = obj.EmployeeID;
        });

        $("#datepicker1").val(strArray[2]);
        $("#idWorkHours").val(strArray[3]);

    }


    function DeliverableProject_Onchange(obj) {
        var url = "CRM_RequestDetails_UnCategorised.aspx/GetDeliverableType"
        var ProjectID = obj.value;
        data = JSON.stringify({ ProjectID: ProjectID });
        CustomAJAXCall(url, data, BindDropdownDeliverableType);
    }

    function BindDropdownDeliverableType(result) {
        var strArray = String(result.d).split("|")
        var objCbo = document.getElementById("cboDeliverableType");

        var i = 0;
        objCbo.innerHTML = "";

        if (objCbo.value != '') {
            insBlankOpt(objCbo);
        }
        $.each(JSON.parse(strArray[0]), function (id, obj) {
            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = obj.LabelSchedule
            objOption.value = obj.ScheduleID;
        });
        // document.getElementById('divDeliverableDate').style.display = "block";        
        PlotCustomField();
    }

    function DeliverableType_Onchange() {
        PlotCustomField();
        document.getElementById('divDeliverableDate').style.display = "block";

    }

    function SaveActivity() {

        var ActivityStatus = $("#CboActivityStatus").val();
        var Activity = $("#CboActivity").val();
        //Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Page Changes
        var TimeSpent = $("#txtTime").val();
        // alert(TimeSpent);
        //Added by yogesh Jalamkar on 12-DEC-2017 Purpose:Issue fixing issue id: 9626
        var TotalTodaysTime = $("#hdnTodaysTotalTimeSpent").val();
        if (parseFloat(TimeSpent) < 0 && TimeSpent != '') {
            //alert('Please enter positive number');
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please enter positive number.', 'error');

            $("#txtTime").focus();
            return;
        }
        if (isNumeric(TimeSpent) == false && TimeSpent != '') {
            //alert('Please enter numeric value');
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please enter numeric value.', 'error');
            $("#txtTime").focus();
            return;
        }
        if (TimeSpent != '' && Activity == '') {
            //alert('Please select the Activity');
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please select the Activity.', 'error');
            $("#CboActivity").focus();
            return;
        }
        if (TimeSpent == '' && Activity != '') {
            // alert('Please enter Time');
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please enter Time.', 'error');
            $("#txtTime").focus();
            return;
        }

        if (parseFloat(TotalTodaysTime) + parseFloat(TimeSpent) > 24 * 60) {
            //alert('Total minutes in one day should be less than equal to 1440 minutes. \n You can add more ' + (1440 - parseFloat(TotalTodaysTime)) + ' minutes for today.');
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Total minutes in one day should be less than equal to 1440 minutes. \n You can add more ' + (1440 - parseFloat(TotalTodaysTime)) + ' minutes for today.', 'error');

            $("#txtTime").focus();
            return;
        }
        //End by yogesh Jalamkar

        //Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Page Changes
        data = JSON.stringify({ RequestID: RequestID, TimeSpent: TimeSpent, ActivityStatus: ActivityStatus, Activity: Activity });
        //  alert(data);
        strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/SaveActivity", data, false);

        RefreshGrid('Activities');

    }

    function FilterOnchange(obj) {
        // alert();
        var strResult, data;
        var GridParameter = {};
        //  GridParameter.cityName = cityName;
        var FieldName = "null";
        var ModifiedBy = "null";
        var filterflag = "Filter";
        FieldName = document.getElementById('CboFieldName').value;
        ModifiedBy = document.getElementById('CboModifiedBy').value;

        data = JSON.stringify({ RequestID: RequestID, Flag: 'History', FieldName: FieldName, ModifiedBy: ModifiedBy, filterflag: filterflag });
        //  alert(data);
        strResult = AJAXCallWithResult(strPageName + "/RequestDetailsTabs", data, false);
        //  alert(strResult.d);
        if (strResult.d != '') {
            document.getElementById('History').innerHTML = "";
            document.getElementById('History').innerHTML = strResult.d;
            //  $("#divHistory .dataTables_wrapper .row:first-child").hide();
            //Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Page Changes
            datatables('divHistory', 'txtSearchHistory');
            //End Of Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Page Changes

        }
    }

    function DeleteAttachment() {

        var strAtachmentIDs;
        strAtachmentIDs = $('input[name=CheckAttachment]:checked').map(function () {
            return this.value;
        }).get().join(',');

        if (strAtachmentIDs.length <= 0) {
            //Added By Dipali V 0n 23th Nov 2017 For HD Changes
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('- Please Select at least one Record', 'error', 15);

            //End of Added By Dipali V 0n 23th Nov 2017 For HD Changes
            return;
        }

        data = JSON.stringify({ AttachmentID: strAtachmentIDs });

        strResult = AJAXCallWithResult(strPageName + "/DeleteAttachment", data, false);
        RefreshGrid('Attachments');

        //Added By Dipali V 0n 23th Nov 2017 For HD Changes
        alertify.set('notifier', 'position', 'top-right');
        alertify.notify('- Attachment Deleted successfully', 'success');

        //End of Added By Dipali V 0n 23th Nov 2017 For HD Changes
        //Added By Bharat T on 21st-Nov-2017 for request list page state saving
        var PageNumber = $("#hdnPageNumber").val();
        var PageFlag = $("#hdnPageFlag").val();
        var LoadFilterID = $("#hdnLoadFilterID").val();
        var StatusFilterID = $("#hdnStatusFilterID").val();
        var DateFilterID = $("#hdnDateFilterID").val();
        //End of Added By Bharat T on 21st-Nov-2017 for request list page state saving

        // debugger;
        var objFormAttachmentDiv = document.getElementById("frmAttachmentDiv");
        objFormAttachmentDiv.action = "CRM_RequestDetails_UnCategorised.aspx?FromWhere=AttachmentDelete&QueryID=" + RequestID + "";

        objFormAttachmentDiv.action += "&PageNumber=" + PageNumber + "&PageFlag=" + PageFlag + "&LoadFilterID=" + LoadFilterID + "&StatusFilterID=" + StatusFilterID + "&DateFilterID=" + DateFilterID + "";
        // alertify.set('notifier', 'position', 'top-right');
        // alertify.notify('Discussion Deleted successfully!!!!', 'success')

        objFormAttachmentDiv.submit();
    }
    //Commented and Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes
    function SelectAll_Checkbox() {
        if (document.getElementById('checkall').checked == true) {
            $("input[name=checkall]").prop('checked', true);
        }
        else {
            $("input[name=checkall]").prop('checked', false);
        }
    }

    function ValidateRequestDetails() {
        var checkvalue = 0;

        var Flag = 0;
        var strmsg = "";
        var errorMsg = "<ul>"
        var DepartmentID = document.getElementById('CboDepartment');
        var RequestType = document.getElementById('CboRequestType');
        var SubRequestType = document.getElementById('CboSubRequestType');

        //Added by Usha Pandit on 14.01.2019 for exp. date of resolution validation
        var hidSubmitDt = $('#txtHiddenSubmittedDate').val()

        var Browser = WhichBrowser();

        if ($("#dtExpResdate") != null) {
            if ($("#dtExpResdate").val() != undefined) {
                if (Browser == "FF" || Browser == "IE" || Browser == "CR") {
                    if (Date.parse($("#dtExpResdate").val().toString().replace(/-/g, ' ')) < Date.parse(hidSubmitDt.replace(/-/g, ' '))) {

                        strmsg = '- Please enter exp. date of resolution greater than or equal to submitted date';
                        errorMsg += "<li>" + strmsg + "</li>";
                        checkvalue = 1;
                    }
                }
            }
        }

        //End of Added by Usha Pandit on 14.01.2019 for exp. date of resolution validation

        //if ($("#txtsubject").val() == "") {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify('Please enter subject', 'error');
        //    checkvalue = 1;
        //}

        //if ($("#txtEditor").val() == "") {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify('Please enter description', 'error');
        //    checkvalue = 1;
        //}

        //if ($("#CboDepartment").val() == "") {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify('Please select Department', 'error');
        //    checkvalue = 1;
        //}
        //if ($("#CboRequestType").val() == "") {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify('Please select Request Type', 'error');
        //    checkvalue = 1;
        //}
        //if ($("#CboSubRequestType").val() == "") {
        //    alertify.set('notifier', 'position', 'top-right');
        //    alertify.notify('Please select Sub Request Type', 'error');
        //    checkvalue = 1;
        //}
        //Added & Commented By Dipali V On 14th Nov 2017 For Validation Changes
        if ($("#CboDepartment").val() == "" || $("#CboDepartment").val() == null) {
            strmsg = '- Department should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            checkvalue = 1;
        }

        if ($("#CboRequestType").val() == "" || $("#CboRequestType").val() == null) {
            strmsg = '- Request Type should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            checkvalue = 1;
        }

        if ($("#CboSubRequestType").val() == "" || $("#CboSubRequestType").val() == null) {
            strmsg = '- Request Sub-Type should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            checkvalue = 1;
        }


        if ($("#CboStatus").val() == "") {
            strmsg = '- Status should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            checkvalue = 1;
        }

        if ($("#CboPriority").val() == "") {
            strmsg = '- Priority should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            checkvalue = 1;
        }
        if ($("#CboLocation").val() == "") {
            strmsg = '- Organization Unit should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            //   alertify.notify('Employee Code Already Exists', 'error');
            checkvalue = 1;
        }
        if ($("#dtExpResdate").val() == "" && document.getElementById("dtExpResdate").disabled == false) {
            strmsg = '- Exp. Date of Resolution should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            //   alertify.notify('Employee Code Already Exists', 'error');
            checkvalue = 1;
        }

        //Added by Sagar N on 12-March-2019 Purpose :: IssueID - 15810
        //var hidSubmittedDate = new Date($("#txtHiddenSubmittedDate").val()).setHours(0, 0, 0, 0);
        //var expResDate = new Date($("#dtExpResdate").val()).setHours(0, 0, 0, 0);
        //var dateFlag = 0;
        //if (expResDate >= hidSubmittedDate) {

        //}
        //else {
        //    strmsg = '- Exp. Date of Resolution should less than submitted date ( '+ new Date($("#txtHiddenSubmittedDate").val()).toDateString()  +' )';
        //    errorMsg += "<li>" + strmsg + "</li>";
        //    checkvalue = 1;
        //}
        //End of Added by Sagar N on 12-March-2019 Purpose :: IssueID - 15810

        if ($("#CboCustomer").val() == "" && $("#CboCustomer").val() == 0) {
            strmsg = '- Please Select Customer.';
            errorMsg += "<li>" + strmsg + "</li>";
            checkvalue = 1;
        }
        if (strmsg != "") {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 15);

        }

        return checkvalue;

    }

    //End of Added & Commented By Dipali V On 14th Nov 2017 For Validation Changes
    var globalRating = "", Isfeedbackcomment = 0, FeedbackComment = "", LoginType = "";
    function SaveRequest_OnClick() {

        try {
            //  debugger;
            // if(Isfeedbackcomment==0)
            //{
            IsCboStatusdisabled = document.getElementById('CboStatus')
            LoginType = $("#hidstrLoginType").val();
            //  alert(IsCboStatusdisabled.disabled);
            //  document

            if (IsCboStatusdisabled.disabled == false) {
                if ($("#CboStatus").val() == "2" && LoginType == "C") {

                    displayFeedback();
                }


                else {

                    if (ValidateRequestDetails() == 0) {
                        var Subject = $("#idSubject").html();
                        var Description = $("#spnDescription").html();
                        var Department = $("#CboDepartment").val();
                        var RequestType = $("#CboRequestType").val();
                        var SubRequestType = $("#CboSubRequestType").val();
                        var Priority = $("#CboPriority").val();
                        var Product = $("#cboProduct").val();
                        var ModuleComponent = $("#CboModuleComponent").val();
                        var Location = $("#CboLocation").val();
                        var TimeZone = $("#CboTimeZone").val();
                        var ExpResoulDate = $("#dtExpResdate").val();
                        var cboStatusOld = $("#cboStatusOld").val();
                        var Status = $("#CboStatus").val();
                        var AssignTo = $("#CboAssignTo").val();
                        var txtResolutionDateOld = $("#txtResolutionDateOld").val();
                        //   alert()
                        var hidtxtAssignTo = $("#CboAssignTo").val();
                        var DeliverableID = $("#DeliverableID").val();
                        var StatusChangedate = $("#dtStatusChangedate").val();
                        var StatusChangeTime = $("#StatusChangeTime").val();
                        var Keywords = $("#txtKeyWords").val();
                        var CboSeverity = $("#CboSeverity").val();
                        var ExpResoulDate = $("#dtExpResdate").val();

                        if (StatusChangedate == "" || StatusChangedate == undefined) {
                            StatusChangedate = "";
                        }
                        if (StatusChangeTime == "" || StatusChangeTime == undefined) {
                            StatusChangeTime = "";
                        }
                        if (Keywords == "" || Keywords == undefined) {
                            Keywords = "";
                        }
                        var cboAssignToOld = $("#cboAssignToOld").val();

                        // alert(Keywords);
                        if (ExpResoulDate == "" || ExpResoulDate == undefined) {
                            ExpResoulDate = "";
                        }
                        if (TimeZone == "" || TimeZone == undefined) {
                            TimeZone = "";
                        }
                        //var m_strCustomFieldList = $("#CustomFieldList").val();
                        var CC = $("#cc").val();

                        if (document.getElementById('CboModuleComponent') == null) {
                            ModuleComponent = "";

                        }
                        if (document.getElementById('cboProduct') == null) {
                            Product = "";

                        }

                        var strTypeInaccessibleCustomFieldList = $("#TypeInaccessibleCustomFieldList").val();

                        // alert(m_strCustomFieldList);

                        //if (m_strCustomFieldList != null)
                        //    //   debugger;
                        //    var ArrCustomFieldList = m_strCustomFieldList.split(",");
                        //var CustomFieldValue = "";
                        //for (var i = 0; i < ArrCustomFieldList.length; i++) {
                        // debugger;
                        //Commented and added by Yogesh Jalamkar on 20-DEC-2017 Purpose: Issue fixing issue id = 
                        //if (CustomFieldValue == "")
                        //{ CustomFieldValue = $('#' + ArrCustomFieldList[i]).val(); }
                        //else {
                        //    CustomFieldValue += ',' + $('#' + ArrCustomFieldList[i]).val();
                        //    if (CustomFieldValue.indexOf("undefined") != -1) {
                        //        //alert(1);
                        //        CustomFieldValue.replace('undefined', "");
                        //    }
                        //    if (i == 0)
                        //    { CustomFieldValue = $('#' + ArrCustomFieldList[i]).val(); }
                        //    else {
                        //        CustomFieldValue += ',' + $('#' + ArrCustomFieldList[i]).val();
                        //        if (CustomFieldValue.indexOf("undefined") != -1) {
                        //            //alert(1);
                        //            CustomFieldValue.replace('undefined', "");
                        //        }
                        //    }
                        //    //End by YOgesh Jalamkar
                        //}

                        //if (CustomFieldValue == "" || CustomFieldValue == undefined) {
                        //    CustomFieldValue = "";
                        //}
                        //if (m_strCustomFieldList == "") {
                        //    m_strCustomFieldList = "";
                        //}

                        var CustomerID = 0;
                        var EmployeeID = 0;

                        if (Location == undefined || typeof Location == "undefined") {
                            Location = "";
                        }

                        if (AssignTo == undefined || typeof AssignTo == "undefined") {
                            AssignTo = "";
                        }

                        if (txtResolutionDateOld == undefined || typeof txtResolutionDateOld == "undefined") {
                            txtResolutionDateOld = "";
                        }

                        if (hidtxtAssignTo == undefined || typeof hidtxtAssignTo == "undefined") {
                            hidtxtAssignTo = "";
                        }

                        if (DeliverableID == undefined || typeof DeliverableID == "undefined") {
                            DeliverableID = "";
                        }

                        if (StatusChangedate == undefined || typeof StatusChangedate == "undefined") {
                            StatusChangedate = "";
                        }

                        if (StatusChangeTime == undefined || typeof StatusChangeTime == "undefined") {
                            StatusChangeTime = "";
                        }

                        if (Keywords == undefined || typeof Keywords == "undefined") {
                            Keywords = "";
                        }

                        if (CboSeverity == undefined || typeof CboSeverity == "undefined") {
                            CboSeverity = "";
                        }

                        if (cboAssignToOld == undefined || typeof cboAssignToOld == "undefined") {
                            cboAssignToOld = "";
                        }

                        // CustomerID = document.getElementById('hdnCustomerID').value;
                        //  EmployeeID = document.getElementById('hdnEmployeeID').value;


                        var SaveRequestDetialsData = [];
                        //
                       
                        SaveRequestDetialsData.push({
                            RequestID: RequestID, Subject: Subject, Description: Description, Department: Department, RequestType: RequestType, SubRequestType: SubRequestType, Priority: Priority, Product: Product,
                            ModuleComponent: ModuleComponent, Location: Location, TimeZone: TimeZone, ExpResoulDate: ExpResoulDate, CustomerID: CustomerID, EmployeeID: EmployeeID, Status: Status, cboStatusOld: cboStatusOld, Project: "",
                            AssignTo: AssignTo, cboAssignToOld: cboAssignToOld, txtResolutionDateOld: txtResolutionDateOld, hidtxtAssignTo: hidtxtAssignTo
                            , DeliverableID: DeliverableID, StatusChangedate: StatusChangedate, StatusChangeTime: StatusChangeTime, Keywords: Keywords, CboSeverity: CboSeverity, FeedbackComment: FeedbackComment, globalRating: globalRating, strCustomerID: $("#CboCustomer").val()
                        });

                        data = JSON.stringify({ SaveRequestDetialsData: SaveRequestDetialsData });

                        //  alert(data);
                        //data = JSON.stringify({ Subject: Subject, Description: Description, Department: Department, RequestType: RequestType, SubRequestType: SubRequestType, Priority: Priority, Product: Product, ModuleComponent: ModuleComponent, Location: Location, TimeZone: TimeZone, Status: "", Project: "", AssignTo: "", objCustomField: m_strCustomFieldList, CustomFieldValue: CustomFieldValue, ExpResoulDate: ExpResoulDate, CC: CC, CustomerID: CustomerID, EmployeeID: EmployeeID });
                        //  alert(data);

                        //Added by Usha Pandit on 12.03.2019 for duplicate Request Creation Issue
                        $(".convert-btn").prop('disabled', true);
                        //End of Added by Usha Pandit on 12.03.2019 for duplicate Request Creation Issue

                        strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/SaveRequestDetails", data, false);
                        //Added by Usha Pandit on 12.03.2019 for duplicate Request Creation Issue
                        if (strResult.d != undefined) {
                            //End of Added by Usha Pandit on 12.03.2019 for duplicate Request Creation Issue
                            var Result = String(strResult.d).split("||");
                            //   debugger;
                            var MsgFlags = [];
                            MsgFlags = (Result[1]).split(",");
                            var intCount = 0;
                            for (intCount = 0; intCount < MsgFlags.length; intCount++) {
                                {
                                    if (MsgFlags[intCount] == "44") {
                                        //window.open("../../../Source/General/CRMSendEmail.aspx?MessageID=44&MultipleRequests=0&QueryID=" + RequestID + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 460) / 2 + ",width=600,height=460");

                                        //Commented and Added by Usha Pandit on 12.03.2019 for duplicate Request Creation Issue
                                        <%--window.open("../EmailSettings/CRMSendEmail.aspx?MessageID=44&QueryID=" + RequestID + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");--%>
                                        window.open("../EmailSettings/CRMSendEmail.aspx?MessageID=44&QueryID=" + Result[0] + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                                        //End of Added by Usha Pandit on 12.03.2019 for duplicate Request Creation Issue
                                    }
                                    if (MsgFlags[intCount] == "544") {
                                        //window.open("../../Source/General/CRMSendEmail.aspx?MessageID=44&MultipleRequests=0&QueryID=" + RequestID + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 460) / 2 + ",width=600,height=460");

                                        <%--window.open("../EmailSettings/CRMSendEmail.aspx?MessageID=544&QueryID=" + RequestID + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");--%>
                                        window.open("../EmailSettings/CRMSendEmail.aspx?MessageID=544&QueryID=" + Result[0] + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                                        <%--End of Added by Usha Pandit on 12.03.2019 for duplicate Request Creation Issue--%>
                                    }
                                    if (MsgFlags[intCount] == "45") {
                                        //window.open("../../Source/General/CRMSendEmail.aspx?MessageID=44&MultipleRequests=0&QueryID=" + RequestID + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 460) / 2 + ",width=600,height=460");

                                        <%--window.open("../EmailSettings/CRMSendEmail.aspx?MessageID=45&QueryID=" + RequestID + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");--%>
                                        window.open("../EmailSettings/CRMSendEmail.aspx?MessageID=45&QueryID=" + Result[0] + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                                        //End of Added by Usha Pandit on 12.03.2019 for duplicate Request Creation Issue
                                    }
                                }


                            }
                            // displayFeedback();
                            if ($("#CboStatus").val() == "2") {
                                DisableControls();
                            }
                            window.parent.location.href = "../Settings/HelpdeskTab.aspx?QueryID=" + Result[0];
                            //window.parent.location.href = "CRM_RequestDetailsNew.aspx?Mode=EDIT&FromWhere=DB&QueryEditAccess=True&PageFlag=SR&PageNumber=1&QueryID=" + Result[0];

                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('- Request Details are saved successfully', 'success');
                        }

                    }

                }


            }
        }
        catch (ex) {
            alert(ex.message);
            //$("#btnSave1").each(function()
            //{              
            //    $(this).prop('disabled', false);
            //});
        }
    }

    function DisableControls() {
        if ("<%=intRequestStatus%>" == 2) {
            var Subject = document.getElementById('txtsubject');
            var Description = document.getElementById('txtEditor');
            var Department = document.getElementById('CboDepartment');
            var RequestType = document.getElementById('CboRequestType');
            var SubRequestType = document.getElementById('CboSubRequestType');
            var Priority = document.getElementById('CboPriority');
            var Product = document.getElementById('cboProduct');
            var ModuleComponent = document.getElementById('CboModuleComponent');
            var Location = document.getElementById('CboLocation');
            var TimeZone = document.getElementById('CboTimeZone');
            var ExpResoulDate = document.getElementById('dtExpResdate');
            var Status = document.getElementById('CboStatus');
            var CboAssignTo = document.getElementById('CboAssignTo');
            var StatusChangedate = document.getElementById('dtStatusChangedate');
            var StatusChangeTimeValue = document.getElementById('m_strStatusChangeTimeValue');
            //    debugger;
            // Subject.disabled = true;
            // Description.disabled = true;
            Department.disabled = true;
            RequestType.disabled = true;
            SubRequestType.disabled = true;
            Priority.disabled = true;
            if (Product != null) {
                Product.disabled = true;
            }
            if (ModuleComponent != null) {
                ModuleComponent.disabled = true;
            }
            if (Location != null) {
                Location.disabled = true;
            }
            if (TimeZone != null) {
                TimeZone.disabled = true;
            }
            if (ExpResoulDate != null) {
                ExpResoulDate.disabled = true;
            }
            if (Status != null) {
                Status.disabled = true;
            }
            if (CboAssignTo != null) {
                CboAssignTo.disabled = true;
            }
            if (StatusChangeTimeValue != null) {
                StatusChangeTimeValue.disabled = true;

            }

            if (StatusChangeTimeValue != null) {
                StatusChangeTimeValue.disabled = true;
            }

            $("#idCalender").css("pointer-events", "none");
            $(".add-on").css("pointer-events", "none");
            $("#btnSave1").css("display", "none");

        }

    }
    //End Of Commented and Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes

</script>


	<script>
        // Get the modal for Reply button popup
        $('.modal').draggable();
        var modal = document.getElementById('id06');

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
</script>
<script>
    // Get the modal for Add Note button popup
    $('.modal').draggable();
    var modal = document.getElementById('id07');

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }


    var AjaxResult;
    function AJAXCallWithResult(url, data, async) {
        AjaxResult = "";
        $.ajax({
            type: "POST",
            url: url,
            data: data,
            dataType: "json",
            contentType: "application/json",
            //timeout: 180000,
            async: false,
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

    //Added By Bharat T on 25th-Oct-2017 for requst details page changes
    function AddNoteClick() {
        $("#SaveNote").hide();//Added By Dipali V On 14th july 2020
        var objtxtNewDiscussion = document.getElementById("txtNewDiscussion");
        var objFormAttachmentDiv = document.getElementById("frmAttachmentDiv");
        var IsShowToCustomer = "False";

        if (document.getElementById("chkIsShowToCustomer") != null) {
            if (document.getElementById("chkIsShowToCustomer").checked == true)
                IsShowToCustomer = "True";
            else
                IsShowToCustomer = "False";
        }
        else {
            IsShowToCustomer = "True";
        }


        if (Trim(objtxtNewDiscussion.value) == "") {
            alertify.set('notifier', 'position', 'top-right');
            //alertify.notify('- Discussion cannot be left blank!', 'error');
            alertify.notify('- Comment cannot be left blank.', 'error', 15);
            $("#SaveNote").show();//Added By Dipali V On 14th july 2020
            //setFocus(objtxtNewDiscussion);
            return;
        }
        else {
            if (disallowMaxlengthViolation(objtxtNewDiscussion, 4000)) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please enter your comments in less than 4000 characters.', 'error');
                $("#SaveNote").show();//Added By Dipali V On 14th july 2020
                return;
            }
        }

        //Integrated by Yogesh Jalamkar on 29-Nov-2017 Purpose: for Mime type
        //for (var j = 0; j < tblFiles.rows.length ; j++) {
        //    if (j != 0){
        //        if ($("#txtFileName" + (j - 1))[0] != undefined)
        //            fileObject[(j - 1)] = $("#txtFileName" + (j - 1))[0].files;
        //    }
        //} 

        fileObject = [];
        $("#FileControlUploadDiv [type=file]").each(function (j, val) {
            if ($(this)[0].files.length != 0) {
                fileObject[(j)] = $(this)[0].files;
            }
        })
        var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
        var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>'
        var validateExtensions = strFileExtension.split(",");

        for (var i = 0; i < fileObject.length; i++) {
            if (fileObject[i] != null || fileObject[i] != undefined) {
                if (fileObject[i].length > 0) {
                    var allowSubmit = false;
                    var intActualFileSize = (fileObject[i][0].size);
                    //formData.append("TxtComment_" + [i], document.getElementById('txtComments' + [i]).value);
                    // formData.append("Internal_" + [i], 1);
                    if (intActualFileSize < intMinFileSize) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('- File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'error', 25);
                        $("#SaveNote").show();//Added By Dipali V On 14th july 2020
                        return;
                    }
                    var file = fileObject[i][0].name;
                    var extension = file.slice(file.lastIndexOf('.') + 1).toLowerCase();
                    for (var cnt = 0; cnt < validateExtensions.length; cnt++) {
                        var strExtn;
                        strExtn = validateExtensions[cnt];
                        if (strExtn.toLowerCase() == extension) { allowSubmit = true; }
                    }
                    if (allowSubmit == false) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Only files with extensions " + (validateExtensions.join(", ", "").toUpperCase()) + " are  allowed!!!", 'error', 25);
                        $("#SaveNote").show();//Added By Dipali V On 14th july 2020
                        return;
                    }
                }
            }
        }

        //End by yogesh Jalamkar
        //Commented by Vidya Jadhav on 29-NOV-2017
        //$(".clsFileControl").show();
        //End by Vidya Jadhav 

        //Added By Bharat T on 21st-Nov-2017 for request list page state saving
        var PageNumber = $("#hdnPageNumber").val();
        var PageFlag = $("#hdnPageFlag").val();
        var LoadFilterID = $("#hdnLoadFilterID").val();
        var StatusFilterID = $("#hdnStatusFilterID").val();
        var DateFilterID = $("#hdnDateFilterID").val();
        //End of Added By Bharat T on 21st-Nov-2017 for request list page state saving

        objFormAttachmentDiv.action = "CRM_RequestDetails_UnCategorised.aspx?Action=SaveDiscussion&QueryID=" + <%=m_lngQueryID%> +"&IsShowToCustomer=" + IsShowToCustomer + "";

        objFormAttachmentDiv.action += "&PageNumber=" + PageNumber + "&PageFlag=" + PageFlag + "&LoadFilterID=" + LoadFilterID + "&StatusFilterID=" + StatusFilterID + "&DateFilterID=" + DateFilterID + "";

        objFormAttachmentDiv.submit();

    }

    function SelectFile() {
        var strFileCount = $("#btnSelectFile").attr("FileCount");
        var objCurrentFileControl = $("#txtFileName" + strFileCount);

        if (FileCount_toDisable == 5) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify("User can attach maximum five files at a time.", 'error', 25);

        }
        objCurrentFileControl.click();


    }

    var FileCount = 0;
    var FileCount_toDisable = 0;
    var fileObject = [];
    function addFileinGrid() {

        var objtxtFileName = document.getElementById('txtFileName' + FileCount);
        var objFileGrid = document.getElementById('tblFiles');
        objFileGrid.style.display = "";
        var newRow = objFileGrid.insertRow(objFileGrid.rows.length);

        newRow.id = 'FILENAME' + FileCount;
        newRow.name = 'txtFileName';
        newRow.className = "clsTREven";
        var newCell = newRow.insertCell(0);
        newCell.innerHTML = "<i class='fa fa-file-pdf-o' aria-hidden='true'></i>";

        newCell = newRow.insertCell(1);
        var fileName = objtxtFileName.value;
        var index = fileName.lastIndexOf("\\");
        if (index == -1)
            index = fileName.lastIndexOf("/");

        if (index != -1)
            fileName = fileName.substring(index + 1, fileName.length);

        newCell.innerHTML = fileName;

       <%If HttpContext.Current.Session("LoginType") = "C" Then%>
        newCell = newRow.insertCell(2);
        newCell.innerHTML = "<Textarea wrap='Hard'  name='txtComments' id='txtComments' class='clsTextArea' style='width:200px  ; height:50px  ; text-align:Left'  ></Textarea>";

        newCell = newRow.insertCell(3);
        newCell.innerHTML = "<A class='Menu' style='' HREF='Javascript:RemoveAttachement(" + FileCount + ")' Title='Remove Attachment' >(Remove)</A>";
        <%Else%>
        newCell = newRow.insertCell(2);
        newCell.innerHTML = "<Textarea wrap='Hard'  name='txtComments' id='txtComments' class='clsTextArea' style='width:200px  ; height:50px  ; text-align:Left'  ></Textarea>";

        newCell = newRow.insertCell(3);
        newCell.innerHTML = "Internal <Input type=checkbox name='chkIsShowToCustomer" + FileCount + "' id='chkIsShowToCustomer" + FileCount + "' class='clsCheckBox' style='width:auto!important;margin-left:4%;vertical-align:bottom;margin-top:7%'>";

        newCell = newRow.insertCell(4);
        newCell.innerHTML = "<A class='Menu' style='' HREF='Javascript:RemoveAttachement(" + FileCount + ")' Title='Remove Attachment' >(Remove)</A>";
         <%End If%>


        parentTD = objtxtFileName.parentNode;
        objtxtFileName.style.display = "none";

        FileCount++;
        FileCount_toDisable++;

        var FileControl;
        FileControl = document.createElement("INPUT");
        FileControl.type = "FILE";
        FileControl.id = "txtFileName" + FileCount;
        FileControl.name = "txtFileName" + FileCount;
        FileControl.className = 'clsTextBox clsFileControl';
        FileControl.size = 100;
        FileControl.style = "display:none;";


        FileControl.onkeydown = function () { return false; };
        FileControl.onbeforepaste = function () { return false; };
        FileControl.onpaste = function () { return false; };
        FileControl.onkeydown = function () { return false; };
        FileControl.onbeforepaste = function () { return false; };
        FileControl.onpaste = function () { return false; };
        FileControl.onchange = addFileinGrid;

        if (FileCount_toDisable == 5) {

            FileControl.disabled = true;
        }


        parentTD.appendChild(FileControl);
        $("#btnSelectFile").attr("FileCount", FileCount);

    }

    function RemoveAttachement(FileNO) {

        var objTR = document.getElementById('FILENAME' + FileNO);
        var toRemoveFileControl = document.getElementById('txtFileName' + FileNO);
        var objFileGrid = document.getElementById('tblFiles');

        objFileGrid.deleteRow(objTR.rowIndex);

        toRemoveFileControl.parentNode.removeChild(toRemoveFileControl);
        document.getElementById("txtFileName" + FileCount).disabled = false;

        if (objFileGrid.rows.length == 1) {
            objFileGrid.style.display = 'none';
        }
        //Added by yogesh Jalamkar Purpose: File extension issue
        fileObject = [];
        //End by Yogesh Jalamkar
        FileCount_toDisable--;
    }

    function DownloadAttachment(QueryID, QueryDetailID) {
        var strResult, data;

        data = JSON.stringify({ QueryID: QueryID, QueryDetailID: QueryDetailID });
        strResult = AJAXCallWithResult(strPageName + "/GetAttachmentGrid", data, false);

        if (strResult.d != '') {
            $("#btnDownloadZip").attr("QueryID", QueryID);
            $("#btnDownloadZip").attr("QueryDetailID", QueryDetailID);

            $("#attachmentMainDiv").html(strResult.d);
            document.getElementById('id03').style.display = 'block';

            $("#divAttachment table").addClass("table table-bordered");
            $("#divAttachment table thead th").css("white-space", "nowrap");
        }
    }
    function Back_OnClick() {
        //Added By Bharat T on 21st-Nov-2017 for request list page state saving
        var PageNumber = $("#hdnPageNumber").val();
        var PageFlag = $("#hdnPageFlag").val();
        var LoadFilterID = $("#hdnLoadFilterID").val();
        var StatusFilterID = $("#hdnStatusFilterID").val();
        var DateFilterID = $("#hdnDateFilterID").val();
        //End of Added By Bharat T on 21st-Nov-2017 for request list page state saving

        window.location.href = "../RequestList/CRM_UnCategorizedRequestList.aspx?Mode=RequestListPageBack&PageNumber=" + PageNumber + "&PageFlag=" + PageFlag + "&LoadFilterID=" + LoadFilterID + "&StatusFilterID=" + StatusFilterID + "&DateFilterID=" + DateFilterID + "";

    }
    //Download Attachment File
    function Document_OnClick_For_CRM(strSystemFileName, strOriginalFileName) {
        //Note : in Attachment.aspx which gets called while uploading a file from Helpdesk Page the FolderNames are hard coded in PerformAction method. Hence Fromwhere is Hard coded	        
        var strTemp = '../../General/ViewAttachment.aspx?FromWhere=CRM&FileName=' + strOriginalFileName + '&SystemFileName=' + strSystemFileName;
        window.open(strTemp);
    }


    //End of Added By Bharat T on 25th-Oct-2017 for requst details page changes
</script>
    <script>
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
            $('p [data-toggle="tooltip"]').tooltip();
            $("#divDiscussionScroll").css("height", window.innerHeight + 'px');
            $("#btnCustomer").tooltip();
            //$('.attach-lnk').tooltip();
            //$('.fa').tooltip();

        });



        <%--Dipali V On 31st Oct 2017--%>
        function Flag_OnClick(RequestID) {
            //alert();
            //debugger;
            var strResult, data;

            $("#hdnRequestID1").val(RequestID);
            $("#spnRequestID").html(RequestID);

            data = JSON.stringify({ RequestID: RequestID });
            strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/GetFlagDetails", data, false);

            if (strResult.d != "") {
                var arrResult = strResult.d.split("#$#");

                $("#btnClearFlag").show();

                if (arrResult[0] == '0') {
                    $("#btnClearFlag").hide();
                }
                $("#hdnFlagUniqueID1").val(arrResult[0]);

                if (String(arrResult[1]).toLowerCase() == "true") {
                    $("#chkComplete").prop("checked", true);
                }
                else {
                    $("#chkComplete").prop("checked", false);
                }

                $("#dtDueDate").val(arrResult[2]);
                $("#cbFlagTo").val(arrResult[3]);

                $(".que").text(arrResult[4]);
            }

            document.getElementById('FlagTracking').style.display = 'block'
            //$("#FlagTracking").css("display", "block")
        }




        function ClearFlag() {
            // debugger;
            var strResult, data, RequestID, FlagUniqueID;

            RequestID = $("#hdnRequestID1").val();
            FlagUniqueID = $("#hdnFlagUniqueID1").val();

            data = JSON.stringify({ FlagUniqueID: FlagUniqueID, RequestID: RequestID });
            var FinalResult = "";
            strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/ClearRequestFlag", data, false);
            FinalResult = strResult.d.split("||")
            if (FinalResult[0] == "1") {
                document.getElementById('FlagTracking').style.display = 'none';
                $("#spnflag").html(FinalResult[1]);
                $("#spnflag").tooltip();

            }
        }

        function SaveFlag() {
            var strResult, data, RequestID;
            var FlagParameters = {};
            var objFlagTo, objDueDate, objCheckComplete;

            objFlagTo = $("#cbFlagTo");
            objDueDate = $("#dtDueDate");
            objCheckComplete = $("#chkComplete");
            RequestID = $("#hdnRequestID1").val();

            FlagParameters.RequestID = RequestID;
            FlagParameters.FlagTo = objFlagTo.val();
            FlagParameters.DueDate = objDueDate.val();
            FlagParameters.ProjectID = "0";
            var CheckValue = 0;

            if ($("#dtDueDate").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please select due date.', 'error');
                return;
            }
            //Added By Aniruddh Gujar on 21-Dec-2017 Purpose::To validate the Due date
            else {
                var url = 'CRM_RequestDetails_UnCategorised.aspx/CheckDueDate';
                var data = JSON.stringify({ DueDate: $("#dtDueDate").val() });

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
                            CheckValue = 1;
                        }
                    },
                });
                if (CheckValue == 1) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- Due Date should not be less than Todays Date.', 'error');
                    return;
                }
            }
            //End of Added By Aniruddh Gujar on 21-Dec-2017 Purpose::To validate the Due date

            if (objCheckComplete.is(':checked'))
                FlagParameters.IsComplete = "1";
            else
                FlagParameters.IsComplete = "0";

            data = JSON.stringify({ FlagParameters: FlagParameters });
            var FinalResult = "";
            strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/SaveRequestFlag", data, false);
            FinalResult = strResult.d.split("||")
            // alert(FinalResult[1]);
            // alert(FinalResult[0]);
            if (FinalResult[0] == "1") {

                // alert(FinalResult);
                // alert(FinalResult[1]);

                document.getElementById('FlagTracking').style.display = 'none';
                // $("#spnflag").html("");
                $("#spnflag").html(FinalResult[1]);
                $("#spnflag").tooltip();
                // var PageNumber = document.getElementById("hdnCurrentPage").value;
                // var strMode = $("#hdnMode").val();

                RefreshGrid('sla');
            }
        }

        function Delete_Discussion(RequestID, RequestDetailID) {


            //Added By Bharat T on 21st-Nov-2017 for request list page state saving
            var PageNumber = $("#hdnPageNumber").val();
            var PageFlag = $("#hdnPageFlag").val();
            var LoadFilterID = $("#hdnLoadFilterID").val();
            var StatusFilterID = $("#hdnStatusFilterID").val();
            var DateFilterID = $("#hdnDateFilterID").val();
            //End of Added By Bharat T on 21st-Nov-2017 for request list page state saving

            // debugger;
            var objFormAttachmentDiv = document.getElementById("frmAttachmentDiv");
            objFormAttachmentDiv.action = "CRM_RequestDetails_UnCategorised.aspx?Action=DeleteDiscussion&RequestDetailID=" + RequestDetailID + "&QueryID=" + RequestID + "";

            objFormAttachmentDiv.action += "&PageNumber=" + PageNumber + "&PageFlag=" + PageFlag + "&LoadFilterID=" + LoadFilterID + "&StatusFilterID=" + StatusFilterID + "&DateFilterID=" + DateFilterID + "";
            // alertify.set('notifier', 'position', 'top-right');
            // alertify.notify('Discussion Deleted successfully!!!!', 'success')

            objFormAttachmentDiv.submit();




            // var url = "CRM_RequestDetails_UnCategorised.aspx/DeleteDiscussions";
            // var data = JSON.stringify({ RequestDetailID: RequestDetailID, RequestID: RequestID });
            //// CustomAJAXCall(url, data, Delete_MultipleDiscussions_Success);
            // strResult = AJAXCallWithResult(url, data, false);
            // if (strResult.d == "1")
            // {
            //     //alert(strResult.d)

            //     alertify.set('notifier', 'position', 'top-right');
            //     alertify.notify('Discussion Deleted successfully!!!!', 'success');
            //     //document.getElementById('FlagTracking').style.display = 'none';

            //     // var PageNumber = document.getElementById("hdnCurrentPage").value;
            //     // var strMode = $("#hdnMode").val();

            //     RefreshGrid('Discussion');
            // }
        }





        function Assign_OnClick() {
            var objform;
            var objdivlist;
            var objtxtSummary;
            var objtxtDescription;
            var objcboProject;
            var objcboAssignTo;
            var objcboStatus;
            var objcboType;
            var mode;
            //var objTaskType, objWorkHrs, objStartDate, objEndDate;
            //var dblTotalWork;

            objTaskType = GetObjectReference('AssignIssue', 'cboTaskType');
            objtxtSummary = GetObjectReference('AssignIssue', 'summary');
            objtxtDescription = GetObjectReference('AssignIssue', 'desc');
            objcboProject = GetObjectReference('AssignIssue', 'CboIssueProject');
            objcboAssignTo = GetObjectReference('AssignIssue', 'objcboAssignTo');
            objcboStatus = GetObjectReference('AssignIssue', 'CboIssueStatus');
            objcboType = GetObjectReference('AssignIssue', 'CboIssueType');

            //objWorkHrs = GetObjectReference('AssignIssue', 'txtWork');
            // objStartDate = GetObjectReference('AssignIssue', 'txtStartDate');
            // objEndDate = GetObjectReference('AssignIssue', 'txtEndDate');
            // objSubmittedDate = GetObjectReference('AssignIssue', 'txtHiddenSubmittedDate');
            mode = "ASSIGN_ISSUE";
            var strAction = "";
            var strEmployeeList = ""
            var strQueryList = "81732"
            //var hidProjectStartDate, hidProjectEndDate;
            // hidProjectStartDate = GetObjectReference('AssignIssue', 'hidProjectStartDate');
            // hidProjectEndDate = GetObjectReference('AssignIssue', 'hidProjectEndDate');

            // added By purvaj on 7 Nov 2008 for Whiziblesem 8.0
            // validation currentwork should be greater than actual work hours filled
            //objActualWork = GetObjectReference('frmTaskAssignment', 'hid_txtActualWork');
            //if (objWorkHrs != null && objActualWork != null && parseFloat(objWorkHrs.value) < parseFloat(objActualWork.value)) {
            //    alert('Current Work hours should be greater than Actual work hours (' + objActualWork.value + ').');
            //    objWorkHrs.focus();
            //    objWorkHrs.select();
            //    return;
            //}
            // End addition purvaj

            //Added by SavitaS on 18 Jan 2006
            //Commented and Added by Dhanashri S on 22 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
            //if (mode == "ASSIGN_TASK" || mode == "ASSIGN_TASK,ADD_NEW" || mode == "ASSIGN_MULTIPLE_TASKS")
            //if (mode == "ASSIGN_TASK" || mode == "ASSIGN_TASK,ADD_NEW" || mode == "ASSIGN_MULTIPLE_TASKS" || mode == "ASSIGN_ISSUE")
            //    //End of comment and addition by Dhanashri S on 22 Aug 2016 
            //{

            //var lngProjectAllocatedHours = '0';
            //var lngProjectHours = '0';
            //var lngBalanceHours;
            //if (disallowBlank(objcboProject, "Project cannot be blank !", true)) return;
            //if (disallowBlank(objTaskType, "Task Type cannot be blank !", true)) return;
            //if (disallowBlank(objWorkHrs, "Work Hrs cannot be blank !", true)) return;
            //if (disallowBlank(objStartDate, "Start Date cannot be blank !", true)) return;
            //if (disallowBlank(objEndDate, "End Date cannot be blank !", true)) return;
            //if (disallowNonNumeric(objWorkHrs, "Please enter numeric value for Work Hrs !", 1) == true) return;
            ////Added by Chakshuta H on 22nd-Aug-2016 Purpose::Qa issue fixing
            //if (objStartDate != null && objSubmittedDate != null)
            //    //End Of Added by Chakshuta H on 22nd-Aug-2016 Purpose::Qa issue fixing
            //{
            //    if (disallowDate1LessThanDate2(objStartDate, objSubmittedDate, "'Start Date' cannot be less than 'Request Submission Date' -" + objSubmittedDate.value) == true) {
            //        return;
            //    }

            //    if (disallowDate1GreaterThanDate2(objStartDate, objEndDate, "Please enter End Date greater than Start Date") == true) {
            //        return;
            //    }
            //}
            ////Added by Chakshuta H on 22nd-Aug-2016 Purpose::Qa issue fixing
            //if (objWorkHrs != null) {
            //    //End Of Added by Chakshuta H on 22nd-Aug-2016 Purpose::Qa issue fixing
            //    if ((parseFloat(lngProjectAllocatedHours) + parseFloat(objWorkHrs.value)) > parseFloat(lngProjectHours)) {
            //        lngBalanceHours = (parseFloat(lngProjectHours) - parseFloat(lngProjectAllocatedHours));
            //        alert("Total work(hours) of tasks should not exceed the Project Work Hours (" + parseFloat(lngProjectHours).toFixed(2) + ")\n Balanced work hours are " + parseFloat(lngBalanceHours).toFixed(2));
            //        return;
            //    }
            //    dblTotalWork = objWorkHrs.value;
            //    if ((dblTotalWork / 0.25) != parseInt(dblTotalWork / 0.25)) {
            //        strMsg = "Please specify the work (hours) <=> in multiples of <==> hours.\nThis is necessary because the user can only fill a minimum of <==> hours in the timesheet.";
            //        strMsg = replaceSubstring(strMsg, "<=>", "");
            //        strMsg = replaceSubstring(strMsg, "<==>", "0.25");
            //        alert(strMsg);
            //        setFocus(objWorkHrs);
            //        return;
            //    }
            //}

            //if (objStartDate != null && objEndDate != null) {
            //    dtstart = getDate(objStartDate.value);
            //    dtEnd = getDate(objEndDate.value);
            //    dblTotalDuration = DateDiff(dtstart, dtEnd, "d") + 1;
            //    dblAvgHoursPerDay = dblTotalWork / dblTotalDuration;
            //    if (dblAvgHoursPerDay > 24) {
            //        alert("You cannot assign more than 24 hours work per day");
            //        setFocus(objWorkHrs);
            //        return;
            //    }

            //    if (dblTotalWork <= 0) {
            //        alert("Please enter only numeric value greater than 0 for Work Hrs !");
            //        setFocus(objWorkHrs);
            //        return;
            //    }
            //}


            /*		if ((mode == "ASSIGN_TASK" || mode == "ASSIGN_TASK,ADD_NEW")||mode =="ASSIGN_MULTIPLE_TASKS" ) //&& "0//" != "0" 
                    {//*/
            //if (('0' != '0') || ('0' != '0') || ('0' != '0'))
            //{
            //    if ("False" == "True") {
            //        if ((objcboAssignTo.value != 0) || (objTaskType.value != 0) || (objcboProject.value != 0)) {
            //            // alert("Timesheet has been filled by the resources ,so cannot assign !");
            //            alertify.set('notifier', 'position', 'top-right');
            //            alertify.notify('Timesheet has been filled by the resources ,so cannot assign !', 'error');
            //            objcboAssignTo.value = 0;
            //            objTaskType.value = 0;
            //            objcboProject.value = 0;
            //            return;
            //        }
            //    }
            //}
            //Added by PrashantD on 25 Feb 2006 for IssueID 1936

            //if (hidProjectStartDate && hidProjectStartDate.value != "0") {
            //    if (disallowDate1GreaterThanDate2(hidProjectStartDate, objStartDate, "Please enter Start Date not less than Project Start Date " + hidProjectStartDate.value) == true) {
            //        return;
            //    }
            //}
            //if (hidProjectEndDate && hidProjectEndDate.value != "0") {
            //    if (disallowDate1GreaterThanDate2(objEndDate, hidProjectEndDate, "Please enter End Date not greater than Project End Date " + hidProjectEndDate.value) == true) {
            //        return;
            //    }
            //}

            //end of addition by PrashantD on 25 Feb 2006 for whiziblesem 6 IssueID 1936


            //if (0 == 1) {
            //    if (ValidateResourceDate(objStartDate, objEndDate) == false)
            //        return false;
            //}


            //if (objcboAssignTo != null) {

            //    if (strAction != "EDIT") {
            //        if (strEmployeeList.indexOf(',' + objcboAssignTo.value + ',') != -1) {
            //            alert("Task has been already assigned to this resource against request ID - " + strQueryList);
            //            return;
            //        }
            //    }
            //}

            //if (strAction == "EDIT") {
            //    if (0 != 0) {
            //        if (objcboAssignTo != null) {
            //            if (objcboAssignTo.value != 0) {
            //                if (strEmployeeList.indexOf(',' + objcboAssignTo.value + ',') != -1) {
            //                    alert("Task has been already assigned to this resource against request ID - " + strQueryList);
            //                    return;
            //                }
            //            }
            //        }
            //    }
            //}

            // }


            if (mode != "ASSIGN") {
                var objProductVersionID = GetObjectReference('AssignIssue', 'ProductVersionID');
                var objCustomerID = GetObjectReference('AssignIssue', 'CustomerID');
                if (disallowBlank(objcboProject, "Please select the project")) return;
                if (disallowBlank(objCustomerID, "Please select the Customer")) return;
                if (disallowBlank(objProductVersionID, "Please select the Product")) return;


            }

            if (mode == "ASSIGN_ISSUE") {
                if (disallowBlank(objtxtSummary, "Please enter the summary")) return;
                if (disallowMaxlengthViolation(objtxtSummary, 512, "Please enter the summary within 512 characters")) return;
                if (disallowBlank(objtxtDescription, "Please enter the description")) return;
            }

            if (disallowBlank(objcboAssignTo, "Please select the resource")) return;
            if (mode == "ASSIGN_ISSUE") {
                if (disallowBlank(objcboStatus, "Please select the issue status")) return;
                if (disallowBlank(objcboType, "Please select the issue type")) return;
            }


            var MenuTags = document.getElementsByTagName('A');
            for (i = 0; i < MenuTags.length; i++) {
                if (MenuTags[i].className == "Menu") {
                    //MenuTags[i].style.display= "none";
                    MenuTags[i].parentNode.style.display = "none";
                }
            }
            setFrameLoader();

            objform.action = "CRM_RequestAssignment.aspx?Action=SAVE&Mode=ASSIGN_ISSUE&QueryID=81732&PKToken=549PtoB4qfyunzFpuSZT9w"
            objform.submit()


        }




        //Added by Dipali V On 1st Nov 2017 For Save Assign Issue 

        function Save_AssignIssue(RequestID) {

            if (ValidateAssignIssue() == 0) {

                // debugger;
                var summary = $("#summary").val();
                var desc = $("#desc").val();
                var CboIssueProject = $("#CboIssueProject").val();
                var objcboAssignTo = $("#CboEmployee").val();
                var CboCustomer;
                if (objcboAssignTo == undefined) {
                    objcboAssignTo = "";
                }
                var CboIssueStatus = $("#CboIssueStatus").val();
                var CboIssueType = $("#CboIssueType").val();
                var CboIssueProject = $("#CboIssueProject").val();

                var CboIssuePriority = $("#CboIssuePriority").val();
                var CboIssueSeverity = $("#CboIssueSeverity").val();
                if ($("#CboCustomer").val() == undefined && $("#CboIssueProduct").val() == undefined && $("#CboIssueComponent").val() == undefined) {
                    var CboIssueProduct = "";
                    var CboIssueComponent = "";
                    CboCustomer = "";

                }
                else {


                    var CboIssueProduct = $("#CboIssueProduct").val();
                    var CboIssueComponent = $("#CboIssueComponent").val();
                    CboCustomer = $("#CboCustomer").val();

                }
                if (CboCustomer == undefined) {
                    CboCustomer = "";
                }
                data = JSON.stringify({ summary: summary, desc: desc, CboIssueProject: CboIssueProject, objcboAssignTo: objcboAssignTo, CboIssueStatus: CboIssueStatus, CboIssueType: CboIssueType, CboIssuePriority: CboIssuePriority, CboIssueSeverity: CboIssueSeverity, CboCustomer: CboCustomer, CboIssueProduct: CboIssueProduct, CboIssueComponent: CboIssueComponent, RequestID: RequestID });
                // alert(data);
                strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/SaveAssignIssue", data, false);

                if (strResult.d != '') {

                    //alert(strResult.d);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- Request Assigned As Issue  successfully!!!!', 'success')
                    RefreshGrid('Association');
                    // alert(strResult.d)
                }



            }


        }

        //End by Dipali V On 1st Nov 2017 For Save Assign Issue 

        //Added by Dipali V On 1st Nov 2017 For Clear Assign Issue Control
        function Clear_AssignIssue() {

            //Commented by yogesh Jalamkar on 12-DEC-2017 Purpose: Issue fixing issue id:9627.
            //$("#summary").val("");
            //$("#desc").val("");
            //End by yogesh Jalamkar
            $("#CboIssueProject").val("");
            $("#CboEmployee").val("");
            $("#CboIssueStatus").val("");
            $("#CboIssueType").val("");
            $("#CboIssueProject").val("");

            $("#CboIssuePriority").val("");
            $("#CboIssueSeverity").val("");
            $("#CboCustomer").val("");
            $("#CboIssueProduct").val("");
            $("#CboIssueComponent").val("");


        }

        //End of Added by Dipali V On 1st Nov 2017 For Clear Assign Issue Control

        //Added by Dipali V On 1st Nov 2017 For Valdation Assign Issue 
        function ValidateAssignIssue() {
            var checkvalue = 0;

            var objtxtSummary = document.getElementById('summary');
            var objtxtDescription = document.getElementById('desc');
            var objcboProject = document.getElementById('CboIssueProject');
            var objcboAssignTo = document.getElementById('objcboAssignTo');
            var CboIssueStatus = document.getElementById('CboIssueStatus');
            var objcboType = document.getElementById('CboIssueType');
            var CboCustomer = document.getElementById("CboCustomer");

            if ($("#summary").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please enter summary', 'error');
                checkvalue = 1;
            }

            if (objtxtSummary.length > 512) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please enter the summary within 512 characters', 'error');
                checkvalue = 1;

            }

            if ($("#desc").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please enter Description', 'error');
                checkvalue = 1;
            }

            if ($("#CboIssueProject").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please select Project', 'error');
                checkvalue = 1;
            }

            if ($("#CboIssueType").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please select Issue Type', 'error');
                checkvalue = 1;
            }
            if ($("#CboIssueStatus").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please select Issue Status', 'error');
                checkvalue = 1;
            }
            //Commented by yogesh Jalamkar on 12-DEC-2017 Purpose: Issue fixing issue id:9627.
            //if ($("#CboIssuePriority").val() == "") {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('Please select Priority', 'error');
            //    checkvalue = 1;
            //}
            //if ($("#CboIssueSeverity").val() == "") {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('Please select Severity', 'error');
            //    checkvalue = 1;
            //}
            //if ($("#CboIssueSeverity").val() == "") {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('Please select Severity', 'error');
            //    checkvalue = 1;
            //}
            //End by yogesh Jalamkar

            if ($("#CboCustomer").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please select Customer', 'error');
                checkvalue = 1;
            }

            if ($("#CboIssueProduct").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please select Product', 'error');
                checkvalue = 1;
            }


            return checkvalue;

        }

        //End by Dipali V On 1st Nov 2017 For Valdation Assign Issue 

        function AssignTasks(RequestID, DepartmentID) {
            // debugger;
            if (ValidateTask() == 0) {//Added By Dipali V On 2nd Nov 2017
                var cboTaskProject = $("#cboTaskProject").val();
                var cboTaskType = $("#cboTaskType").val();
                var CboTaskAssignTo = $("#CboTaskAssignTo").val();
                var datepicker1 = $("#datepicker1").val();
                var datepicker2 = $("#datepicker2").val();
                //Commented and Added By Vidya Jadhav ON 25 Oct 2017 For Request Details Changes
                var Work = $("#idWorkHours").val();

                data = JSON.stringify({ DepartmentID: DepartmentID, cboTaskProject: cboTaskProject, cboTaskType: cboTaskType, CboTaskAssignTo: CboTaskAssignTo, datepicker1: datepicker1, datepicker2: datepicker2, RequestID: RequestID, Work: Work });
                // alert(data);
                strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/SaveAssignTask", data, false);
                // alert(strResult);
                RefreshIssueTab('Task');
            }
        }


        function ValidateTask() {
            // debugger;
            var checkvalue = 0;
            var objcboProject = document.getElementById('cboTaskProject');
            var objcboType = document.getElementById('cboTaskType');
            var objcboAssignTo = document.getElementById('CboTaskAssignTo');
            var ObjTaskStartDate = document.getElementById('datepicker1');
            var ObjTaskEndDate = document.getElementById('datepicker2');
            var StrWorkHrs = document.getElementById('idWorkHours');
            var objSubmittedDate = document.getElementById('txtHiddenSubmittedDate');

            var lngProjectHours, lngProjectAllocatedHours, ResourceAssignExistOrNot;
            var hidProjectStartDate1, hidProjectEndDate1, m_bitResourceValidation;
            var flag = 0;


            var lngBalanceHours;
            var dblTotalWork;

            if ($("#cboTaskProject").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please Select Project', 'error');
                checkvalue = 1;
            }

            if ($("#cboTaskType").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please Select Task Type', 'error');
                checkvalue = 1;
            }

            if ($("#CboTaskAssignTo").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please Select Assign To', 'error');
                checkvalue = 1;
            }


            if ($("#idWorkHours").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please Enter Work hrs', 'error');
                checkvalue = 1;

            }
            else if (RestrictNonNumeric(document.getElementById('idWorkHours'), false) == true) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please Enter Work hrs numeric values !!!', 'error');
                checkvalue = 1;
                flag = 1;
            }


            if ($("#datepicker1").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please Select Start Date', 'error');
                checkvalue = 1;
            }

            if ($("#datepicker2").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please Select End Date', 'error');
                checkvalue = 1;
            }





            if ($('#cboTaskProject').val() != "") {

                var url = 'CRM_RequestDetails_UnCategorised.aspx/WorkHrsValidationwithProjectHr';
                var data = JSON.stringify({ Project: $("#cboTaskProject").val(), RequestID: RequestID });
                if (flag == 0) {
                    $.ajax({
                        type: "POST",
                        url: url,
                        data: data,
                        dataType: "json",
                        contentType: "application/json",
                        async: false,
                        timeout: 180000,
                        success: function (result) {
                            if (result.d != '') {

                                var FinalResult = result.d.split("||")
                                lngProjectHours = FinalResult[0]
                                lngProjectAllocatedHours = FinalResult[1]
                                hidProjectStartDate1 = FinalResult[2]
                                hidProjectEndDate1 = FinalResult[3]
                                m_bitResourceValidation = FinalResult[4]
                                ResourceAssignExistOrNot = FinalResult[5]
                                //  alert(ResourceAssignExistOrNot);
                            }

                        },
                        error: function (xhr, status, error) {
                            console.log(xhr.responseText);
                            window.location.href = "../../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                        }
                    });
                }
            }

            var hidProjectEndDate = $('#hidProjectEndDate');
            var hidProjectStartDate = document.getElementById('hidProjectStartDate');


            $("#hidProjectStartDate").val(hidProjectStartDate1);
            $("#hidProjectEndDate").val(hidProjectEndDate1);

            //var ProjectDate="Please enter Start Date not less than Project Start Date " + hidProjectStartDate1
            //var ProjectEndDate="Please enter End Date not greater than Project End Date " + hidProjectEndDate1
            //if($("#datepicker1").val() != "")
            //{

            //    if (hidProjectStartDate1 && hidProjectStartDate1.value != "0")
            //    {
            //        if (disallowDate1GreaterThanDate2(hidProjectStartDate,ObjTaskStartDate)== true)
            //        {
            //            alertify.set('notifier', 'position', 'top-right');
            //            alertify.notify(ProjectDate, 'error');
            //            checkvalue = 1;
            //        }			
            //    }

            //}


            //if($("#datepicker2").val() != "")
            //{
            //    if (hidProjectEndDate1 && hidProjectEndDate1.value != "0")
            //    {
            //        if (disallowDate1GreaterThanDate2(ObjTaskEndDate,hidProjectEndDate)== true)
            //        {
            //            alertify.set('notifier', 'position', 'top-right');
            //            alertify.notify(ProjectEndDate, 'error');
            //            checkvalue = 1;
            //        }		
            //    }				

            //}



            if ($('#datepicker1').val() != "" && $('#datepicker2').val() != "" && $("#cboTaskProject").val()) {
                var url = 'CRM_RequestDetails_UnCategorised.aspx/CheckDateValidation';
                var data = JSON.stringify({ Project: $("#cboTaskProject").val(), ObjTaskStartDate: $('#datepicker1').val(), ObjTaskEndDate: $('#datepicker2').val() });
                if ($('#datepicker1').val() != '') {
                    $.ajax({
                        type: "POST",
                        url: url,
                        data: data,
                        dataType: "json",
                        contentType: "application/json",
                        async: false,
                        timeout: 180000,
                        success: function (result) {
                            if (result.d == 5) {
                                checkvalue = 5;
                            }
                            else if (result.d == 2) {
                                checkvalue = 2;
                            }
                            else if (result.d == 3) {
                                checkvalue = 3;
                            }
                            else if (result.d == 4) {
                                checkvalue = 4;
                            }
                            //else if (result.d == 5) {
                            //    checkvalue = 5;
                            //}
                        },
                        error: function (xhr, status, error) {
                            console.log(xhr.responseText);
                            window.location.href = "../../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                        }
                    });


                    var ProjectDate = "Please enter Start Date should be greater than Project Start Date " + hidProjectStartDate1
                    var ProjectEndDate = "Please enter End Date should be less than Project End Date " + hidProjectEndDate1
                    var strEndDateCompare = "Please enter End Date greater than Start Date" + $("#datepicker1").val();
                    var strSubmittedDateCompare = "'Start Date'cannot be less than 'Request Submission Date'" + $("#txtHiddenSubmittedDate").val();
                    if (checkvalue == 3) {
                        //$('#SpantxtStartDate_' + +htRowCount[i].value).text("Start Date should be greater or equal to Project start date");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(ProjectDate, 'error');
                        checkvalue = 1;
                    }

                    if (checkvalue == 4) {
                        //$('#SpantxtEndDate_' + htRowCount[i].value).text("End Date should be less or equal to Project End date");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(ProjectEndDate, 'error');
                        checkvalue = 1;
                    }

                    if (checkvalue == 5) {
                        //$('#SpantxtEndDate_' + htRowCount[i].value).text("End Date should be less or equal to Project End date");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(strEndDateCompare, 'error');
                        checkvalue = 1;
                    }

                    if (checkvalue == 2) {
                        //$('#SpantxtEndDate_' + htRowCount[i].value).text("End Date should be less or equal to Project End date");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('- Start Date should not be greater than  End date', 'error');
                        checkvalue = 1;
                    }



                }
            }

            else {

                // debugger;

                var strDateCompare = "'Start Date'cannot be less than 'Request Submission Date'" + $("#txtHiddenSubmittedDate").val();
                var Result = "";

                if (ObjTaskStartDate != null && ObjTaskStartDate.value != "") {
                    var url = 'CRM_RequestDetails_UnCategorised.aspx/CheckDateFormat';
                    var data = JSON.stringify({ TaskStartDate: ObjTaskStartDate.value, SubmittedDate: objSubmittedDate.value });
                    $.ajax({
                        type: "POST",
                        url: url,
                        data: data,
                        dataType: "json",
                        contentType: "application/json",
                        async: false,
                        timeout: 180000,
                        success: function (result) {
                            if (result.d != "") {
                                Result = result.d;
                            }
                        },
                        error: function (xhr, status, error) {
                            console.log(xhr.responseText);
                            window.location.href = "../../../Source/General/ErrorPage.aspx?Mode=AJAXError&Error=" + error + ""
                        }
                    });
                    if (Result == "2") {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(strDateCompare, 'error');
                        checkvalue = 1;
                    }
                }
                else {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strDateCompare, 'error');
                    checkvalue = 1;
                }
                //if (disallowDate1LessThanDate2(ObjTaskStartDate, objSubmittedDate) == true)



            }

            //var strDateCompare = "'Start Date'cannot be less than 'Request Submission Date'" + $("#txtHiddenSubmittedDate").val();
            //if (ObjTaskStartDate != null && ObjTaskEndDate != null)

            //{
            //    if (disallowDate1LessThanDate2(ObjTaskStartDate, objSubmittedDate) == true)
            //    {

            //        //"'Start Date' cannot be less than 'Request Submission Date' -" + objSubmittedDate.value

            //        alertify.set('notifier', 'position', 'top-right');
            //        alertify.notify(strDateCompare, 'error');
            //        checkvalue = 1;
            //    }

            //    //if (disallowDate1GreaterThanDate2(ObjTaskStartDate, ObjTaskEndDate) == true)
            //    //{

            //    //    alertify.set('notifier', 'position', 'top-right');
            //    //    alertify.notify(strEndDateCompare, 'error');
            //    //    checkvalue = 1;
            //    //}
            //}



            if (StrWorkHrs != null) {
                if (flag == 0) {
                    if ((parseFloat(lngProjectAllocatedHours) + parseFloat(StrWorkHrs.value)) > parseFloat(lngProjectHours)) {

                        lngBalanceHours = (parseFloat(lngProjectHours) - parseFloat(lngProjectAllocatedHours));
                        var hrsValidation = "Total work(hours) of tasks should not exceed the Project Work Hours (" + parseFloat(lngProjectHours).toFixed(2) + ")\n Balanced work hours are " + parseFloat(lngBalanceHours).toFixed(2)
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(hrsValidation, 'error');
                        checkvalue = 1;
                    }


                    dblTotalWork = StrWorkHrs.value;
                    if ((dblTotalWork / <%=CommonFunctions.Application.MinHoursForDAEntry%>) != parseInt(dblTotalWork / <%=CommonFunctions.Application.MinHoursForDAEntry%>)) {	////////////////////////////////////////////	
                        strMsg = "Please specify the work (hours) <=> in multiples of <==> hours.\nThis is necessary because the user can only fill a minimum of <==> hours in the timesheet.";
                        strMsg = replaceSubstring(strMsg, "<=>", "");
                        strMsg = replaceSubstring(strMsg, "<==>", "<%=CommonFunctions.Application.MinHoursForDAEntry%>");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify(strMsg, 'error');
                        checkvalue = 1;

                    }



                    if (dblTotalWork <= 0 && $("#idWorkHours").val() != "") {
                        // alert("Please enter only numeric value greater than 0 for Work Hrs !");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Please enter only numeric value greater than 0 for Work Hrs !", 'error');
                        checkvalue = 1;
                    }


                    var RecoureAssign;
                    RecoureAssign = 'Task has been already assigned to this resource against request ID - ' + RequestID
                    if (ResourceAssignExistOrNot != null && ResourceAssignExistOrNot != undefined) {
                        if (ResourceAssignExistOrNot.indexOf(',' + objcboAssignTo.value + ',') != -1) {

                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify(RecoureAssign, 'error');
                            checkvalue = 1;



                        }
                    }

                }
            }


            if (('<%=m_lngOldAssignTo%>' != '0') || ('<%=m_lngOldTaskTypeID%>' != '0') || ('<%=m_lngOldProjectID%>' != '0')) {
                if ("<%=m_blnHasTimesheetDetails%>" == "True") {
                    if ((objcboAssignTo.value != <%=m_lngOldAssignTo%>) || (objTaskType.value != <%=m_lngOldTaskTypeID%>) || (objcboProject.value != <%=m_lngOldProjectID%>)) {
                        //alert ("Timesheet has been filled by the resources ,so cannot assign !");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify("Timesheet has been filled by the resources ,so cannot assign !", 'error');

                        objcboAssignTo.value = <%=m_lngOldAssignTo%> ;
                        objTaskType.value = <%=m_lngOldTaskTypeID%> ;
                        objcboProject.value = <%=m_lngOldProjectID%> ;
                        checkvalue = 1;
                    }
                }
            }



            if ($("#datepicker1").val() != "" && $("#datepicker2").val() != "") {
                dtstart = $("#datepicker1").val();
                dtEnd = $("#datepicker2").val();

                dblTotalDuration = DateDiff(dtstart, dtEnd, "d") + 1;
                dblAvgHoursPerDay = dblTotalWork / dblTotalDuration;
                // alert(dblAvgHoursPerDay);
                // alert(dblTotalDuration);
                if (dblAvgHoursPerDay > 24) {    ///////////////////////////////////////////
                    //  alert("You cannot assign more than 24 hours work per day");
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("You cannot assign more than 24 hours work per day", 'error');
                    checkvalue = 1;
                }

                if (m_bitResourceValidation == 1) {
                    if (ValidateResourceDate(ObjTaskStartDate, ObjTaskEndDate) == false)
                        checkvalue = 1;
                }
            }






            return checkvalue;

        }

        var strResult
        function ValidateResourceDate(objSDt, objEDt) {

            //  debugger;
            var objResourceStartDate, objResourceEndDate, objEmp;
            var strUrl;
            var objcboProject = $('#cboTaskProject').val();

            var objcboAssignTo = $('#CboTaskAssignTo').val();


            if (objSDt != null) {
                strUrl = "../../General/XMLHttp.aspx?TagID=0&Mode=CRM_RequestAssignment&CurrentStartDate=" + encodeURIComponent(objSDt.value) + "&CurrentEndDate=" + encodeURIComponent(objEDt.value) + "&EmployeeID=" + objcboAssignTo + "&ProjectID=" + objcboProject;
                ValidateResourceDate_XML(strUrl);
                if (strResult != null && strResult != "") {
                    // alert(strResult);
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strResult, 'error');
                    checkvalue = 1;

                }

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



        function Clear_AssignTask() {
            $("#cboTaskProject").val("");
            $("#cboTaskType").val("");
            $("#CboTaskAssignTo").val("");
            $("#datepicker1").val("");
            $("#datepicker2").val("");
            $("#idWorkHours").val("");


        }


        function ClearDeliverables() {

            $("#title").val("");
            $("#Codetemplate").val("");
            $("#cboDeliverableProject").val("");
            $("#cboDeliverableType").val("");
            $("#datepicker").val("");
            $("#desc1").val("");


        }

        function SaveDeliverables() {
            if (ValidateDeliverables() == 0) {


                var cbotitle = $("#title").val();
                // alert(cbotitle);
                // var Codetemplate = $("#Codetemplate").val();
                var cboDeliverableProject = $("#cboDeliverableProject").val();
                var cboDeliverableType = $("#cboDeliverableType").val();
                var desc1 = $("#desc1").val();
                var StartDate = $("#datepicker").val();
                var checkvalue = 0

                var GridParameter = {};

                $("#divCustomFields .form-control").each(function (id, val) {
                    //if ($(this).val() == ""){
                    //    alertify.set('notifier', 'position', 'top-right');
                    //    alertify.notify('Please enter value', 'error', 25);
                    //    checkvalue = 1;
                    //}
                    //else
                    //{

                    obj = document.getElementById($(this).attr("id"));

                    if (obj.name == "txtDeliverableSize") {
                        if (disallowNonNumeric(obj, "")) {

                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Please enter a numeric value", 'error', 25);
                            checkvalue = 1
                        };
                        //Modified and added by GaneshD on 26 Aug 2009 for Whiziblesm IssueID-32678
                        //if(disallowNegativeNumeric(obj,'Please enter only positive numeric value ',true)==true)return false;
                        if (disallowNegativeInteger(GetObjectReference("", "txtDeliverableSize"), '', true)) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Please enter only positive Integer", 'error', 25);
                            checkvalue = 1;
                        }
                        // End of addition by GaneshD on 26 aug 2009
                    }


                    if (obj.name == "txtDocumentNo") {

                        var StrCodeTemplate ="<%=StrCodeTemplate%>";
                        if (disallowSpecialCharacters(obj, '')) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('- A Code Template cannot contain any of these /\\:*?<>|,"+- Characters ', 'error', 25);
                            checkvalue = 1
                        };
                        if (disallowMaxlengthViolation(obj, 100, '', true)) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('- Max Length of this field is 100 characters.', 'error', 25);
                            checkvalue = 1;
                        }
                        //if(StrCodeTemplate.substring(StrCodeTemplate.indexOf(','+ obj.value +',')) != "")
                        if (StrCodeTemplate.indexOf(',' + obj.value + ',') != -1) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('- Code Template Already Exists', 'error', 25);
                            checkvalue = 1;
                        }
                    }

                    if (obj.name == "txtEfforts") {
                        if (disallowNonNumeric(obj, "")) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('- Please enter a numeric value', 'error', 25);
                            checkvalue = 1
                        };
                        if (disallowNegativeNumeric(obj, '', true) == true) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('- Please enter only positive numeric value !', 'error', 25);
                            checkvalue = 1
                        };
                        var dblProjectEffort = document.getElementById("txtEstimatedEfforts").value
                        if (obj.value > dblProjectEffort) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('- The total Effort(hrs) of this Deliverable should not exceed the Project Effort(' + dblProjectEffort + ' hrs).', 'error', 25);
                            checkvalue = 1;
                        }
                    }
                    if (obj.name == "txtDeliverableSize") {
                        if (disallowNonNumeric(obj, "")) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('- Please enter a numeric value', 'error', 25);
                            checkvalue = 1
                        };
                        if (disallowNegativeNumeric(obj, '', true) == true) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('- Please enter only positive numeric value!', 'error', 25);
                            checkvalue = 1
                        };
                    }

                    if (obj.name == "txtScheduledStartDate") {
                        var objStartDt = GetObjectReference("", "txtScheduledStartDate");
                        var objProjectStartDt = GetObjectReference("", "txtProjectStartDate");
                        var objProjectEndDt = GetObjectReference("", "txtProjectEndDate");
                        if (new Date(objStartDt.value) < new Date(objProjectStartDt.value)) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Start Date should not be less than Project Start Date [" + objProjectStartDt.value + "].", 'error', 25);
                            checkvalue = 1;
                        }
                        if (new Date(objProjectEndDt.value) < new Date(objStartDt.value)) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Start Date should not be greater than Project End Date [" + objProjectEndDt.value + "].", 'error', 25);
                            checkvalue = 1;
                        }
                    }



                    if (obj.name == "txtEarliestCompletionDate") {
                        var objEarliestEndDt = GetObjectReference("", "txtEarliestCompletionDate");
                        var objLatestEndDt = GetObjectReference("", "txtLatestCompletionDate");
                        var objProjectEndDt = GetObjectReference("", "txtProjectEndDate");
                        var objStartDt = GetObjectReference("", "txtScheduledStartDate");
                        if (new Date(objProjectEndDt.value) < new Date(objEarliestEndDt.value)) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('- Completion Date should not be greater than Project End Date [' + objProjectEndDt.value + '].', 'error', 25);
                            checkvalue = 1;
                        }
                        if (new Date(objEarliestEndDt.value) < new Date(objStartDt.value)) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Start Date should not be greater than completion Date [" + objEarliestEndDt.value + "].", 'error', 25);
                            checkvalue = 1;
                        }

                    }

                    if (obj.name == "txtLatestCompletionDate") {
                        var objEarliestEndDt = GetObjectReference("", "txtEarliestCompletionDate");
                        var objLatestEndDt = GetObjectReference("", "txtLatestCompletionDate");
                        var objProjectEndDt = GetObjectReference("", "txtProjectEndDate");
                        var objStartDt = GetObjectReference("", "txtScheduledStartDate");
                        if (new Date(objProjectEndDt.value) < new Date(objLatestEndDt.value)) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Completion Date should not be greater than Project End Date [" + objProjectEndDt.value + "].", 'error', 25);

                            checkvalue = 1;
                        }
                        if (new Date(objLatestEndDt.value) < new Date(objStartDt.value))
                        //if(disallowDate1LessThanDate2(objLatestEndDt,objStartDt ,"Start Date should not be greater than completion Date [" + objLatestEndDt.value + "].",false))  
                        {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Start Date should not be greater than completion Date [" + objLatestEndDt.value + "].", 'error', 25);
                            checkvalue = 1;
                        }
                        if (new Date(objLatestEndDt.value) < new Date(objEarliestEndDt.value))
                        //if(disallowDate1LessThanDate2(objLatestEndDt ,objEarliestEndDt, "Earliest Completion Date should not be greater than Latest Completion Date [" + objLatestEndDt.value + "].",false))  
                        {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Earliest Completion Date should not be greater than Latest Completion Date [" + objLatestEndDt.value + "].", 'error', 25);
                            checkvalue = 1;
                        }


                    }
                    var objCustomNumeric = obj.name;
                    if (objCustomNumeric.substring(0, objCustomNumeric.length - 1) == "txtCustomFieldNumeric") {
                        //if (disallowNonNumeric(obj,"Please enter a numeric value")) checkvalue = 1;
                        if (disallowNonNumeric(obj)) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Please enter a numeric value", 'error', 25);
                            checkvalue = 1;
                        }
                    }

                    if (obj.name == "txtTitle") {
                        var StrTitleList ="<%=StrTitleList%>";
                        //var StrTitleList ='JSJDJ' ;

                        //if (disallowSpecialCharacters(obj,'A Title cannot contain any of these /\\:*?<>|,"+- Characters'))checkvalue =1;
                        if (disallowSpecialCharacters(obj)) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('- A Title cannot contain any of these /\\:*?<>|,"+- Characters', 'error', 25);
                            checkvalue = 1
                        };
                        //if (disallowMaxlengthViolation(obj,100,'Max Length of this field is 100 characters.',true))
                        if (disallowMaxlengthViolation(obj, 100)) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Max Length of this field is 100 characters.", 'error', 25);
                            checkvalue = 1;
                        }
                        // if(StrTitleList.substring(StrTitleList.indexOf(','+ obj.value +',')) != "")
                        if (StrTitleList.indexOf(',' + obj.value + ',') != -1) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Title Already Exists", 'error', 25);

                            checkvalue = 1;
                        }
                    }

                    if ((obj.value == "") || (obj.value == null)) {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify($(this).attr("Caption") + ' should not be left Blank', 'error', 25);
                        //alert(stringCaptions[intCtr] + ' should not be left Blank' );
                        setFocus(obj);
                        checkvalue = 1;
                    }

                    GridParameter[$(this).attr("id")] = $(this).val();
                    //}
                })
                if (checkvalue == 0) {
                    GridParameter["QueryID"] = '<%=m_lngQueryID%>';
                    data = JSON.stringify({ cbotitle: cbotitle, cboDeliverableProject: cboDeliverableProject, cboDeliverableType: cboDeliverableType, desc1: desc1, StartDate: StartDate, GridParameter: GridParameter });

                    strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/SaveDeliveriable", data, false);


                    if (strResult.d != '') {
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('- Deliverable Created successfully!!!!', 'success');
                        //RefreshIssueTab('Deliverable');
                        //Added By Bharat T on 21st-Nov-2017 for request list page state saving
                        var PageNumber = $("#hdnPageNumber").val();
                        var PageFlag = $("#hdnPageFlag").val();
                        var LoadFilterID = $("#hdnLoadFilterID").val();
                        var StatusFilterID = $("#hdnStatusFilterID").val();
                        var DateFilterID = $("#hdnDateFilterID").val();
                        //End of Added By Bharat T on 21st-Nov-2017 for request list page state saving

                        // debugger;
                        var objFormAttachmentDiv = document.getElementById("frmAttachmentDiv");
                        objFormAttachmentDiv.action = "CRM_RequestDetails_UnCategorised.aspx?FromWhere=SaveDeliverableRefresh&QueryID=" + RequestID + "";

                        objFormAttachmentDiv.action += "&PageNumber=" + PageNumber + "&PageFlag=" + PageFlag + "&LoadFilterID=" + LoadFilterID + "&StatusFilterID=" + StatusFilterID + "&DateFilterID=" + DateFilterID + "";
                        // alertify.set('notifier', 'position', 'top-right');
                        // alertify.notify('Discussion Deleted successfully!!!!', 'success')

                        objFormAttachmentDiv.submit();

                    }

                }


            }

        }




        function ValidateDeliverables() {

            var checkvalue = 0;
            var title = document.getElementById('title');
            var Codetemplate = document.getElementById('Codetemplate');
            var cboDeliverableProject = document.getElementById('cboDeliverableProject');
            var cboDeliverableType = document.getElementById('cboDeliverableType');
            var desc1 = document.getElementById('desc1');


            if ($("#title").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please Enter title', 'error');
                checkvalue = 1;
            }


            if ($("#title").val() != "") {

                if (checkSpecialCharacter($('#title').val()) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- A Title cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
                    checkvalue = 1;

                }

                var strTitlelength = 'Max Length of Title is 100 characters.';
                //if (disallowMaxlengthViolation(document.getElementById('title'), 100 , true)) 
                //{
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(strTitlelength, 'error');
                //    checkvalue = 1;

                //}
                var Strtitle = $('#title').val()
                if (Strtitle.length > 100) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify(strTitlelength, 'error');
                    checkvalue = 1;

                }


                var StrTitleList ="<%=StrTitleList%>";
                    if (StrTitleList.indexOf(',' + $('#title').val() + ',') != -1) {
                        // alert("Title Already Exists");
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.notify('- Title Already Exists', 'error');
                        checkvalue = 1;

                    }

                }

            //if ($("#Codetemplate").val() == "") {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('Please Enter Code template', 'error');
            //    checkvalue = 1;
            //}



            //if ($("#Codetemplate").val()!= "")
            //{

            //    if (checkSpecialCharacter($('#Codetemplate').val()) == true) 
            //    {
            //        alertify.set('notifier', 'position', 'top-right');
            //        alertify.notify('A Code template cannot contain any of these /\\:*?<>|,"+- Characters', 'error');
            //        checkvalue = 1;

            //    }

            //  var Codetemplate = 'Max Length of Codet emplate is 100 characters.';
            //if(Codetemplate.length > 100 )
            //{
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify(Codetemplate, 'error');
            //    checkvalue = 1;

            //}

            //var StrCodeTemplate ="<%=StrCodeTemplate%>" ;
            // if(StrTitleList.indexOf(','+ $('#Codetemplate').val() +',')!= -1)
            // {
            // alert("Title Already Exists");
            //  alertify.set('notifier', 'position', 'top-right');
            // alertify.notify('Code template Already Exists', 'error');
            // checkvalue = 1;

            //}

            //}


            if ($("#cboDeliverableProject").val() == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please Select Project', 'error');
                checkvalue = 1;
            }




            if (cboDeliverableType.value == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('- Please Select Deliverable Type', 'error');
                checkvalue = 1;
            }

            //if ($("#desc1").val() == "") {
            //    alertify.set('notifier', 'position', 'top-right');
            //    alertify.notify('Please Enter Description', 'error');
            //    checkvalue = 1;
            //}



            return checkvalue;
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

        function displayFeedback() {


            document.getElementById('Feedback').style.display = "block";

            data = JSON.stringify({});

            strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/Plotfeedback", data, false);

            //   alert(strResult.d);
            if (strResult.d != '') {
                $("#Feedbackdata").html(strResult.d);

            }

        }

        //SpnRatingMsg

        function Putrating(Rating) {
            //  alert(Rating);

            if (Rating == 1)//Satisfactory
            {
                if ($("#firstrating").hasClass('checked')) {
                    $("#firstrating").removeClass('checked')
                    $("#Secondrating").removeClass('checked')
                    $("#Foruthrating").removeClass('checked')
                    $("#Thirdrating").removeClass('checked')
                    $("#SpnRatingMsg").html("")
                    // $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                }
                else {
                    $("#firstrating").addClass('checked')
                    $("#SpnRatingMsg").html("Seems,you are not happy with our service,we will contact you.")
                    $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                }


                $("#SpnRatingMsg").css("color", "red");
                globalRating = $('#Ratingone').val();
            }
            else if (Rating == 5)//Fair
            {
                // $("#SpnRatingMsg").css("color","Green");

                if ($("#Secondrating").hasClass('checked')) {
                    $("#Secondrating").removeClass('checked')
                    $("#Foruthrating").removeClass('checked')
                    $("#Thirdrating").removeClass('checked')
                    $("#SpnRatingMsg").html("Seems,you are not happy with our service,we will contact you.")
                    $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                    $("#SpnRatingMsg").css("color", "red");
                }
                else {
                    $("#Secondrating").addClass('checked')
                    $("#firstrating").addClass('checked')
                    $("#SpnRatingMsg").html("Seems,you are not happy with our service,we will contact you.")
                    $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                    $("#SpnRatingMsg").css("color", "red");
                }


                globalRating = $('#Ratingtwo').val();
            }
            else if (Rating == 8)//Good
            {
                if ($("#Thirdrating").hasClass('checked')) {

                    //$("#firstrating").removeClass('checked')
                    $("#Foruthrating").removeClass('checked')
                    $("#Thirdrating").removeClass('checked')
                    $("#SpnRatingMsg").html("Seems,you are not happy with our service,we will contact you.")
                    $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-down' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                    $("#SpnRatingMsg").css("color", "red");

                }
                else {
                    $("#firstrating").addClass('checked')
                    $("#Secondrating").addClass('checked')
                    $("#Thirdrating").addClass('checked')
                    $("#SpnRatingMsg").html("Thank You ! looking to serve you better")
                    $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-up' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                    $("#SpnRatingMsg").css("color", "Green");
                }


                globalRating = $('#Ratingthree').val();
            }

            else if (Rating == 10)//Excellent
            {
                if ($("#Foruthrating").hasClass('checked')) {

                    //$("#firstrating").removeClass('checked')
                    //$("#Secondrating").removeClass('checked')
                    // $("#Thirdrating").removeClass('checked')
                    $("#Foruthrating").removeClass('checked')
                    $("#SpnRatingMsg").html("Thank You! looking to serve you better")
                    $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-up' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                    $("#SpnRatingMsg").css("color", "Green");
                }
                else {
                    $("#Foruthrating").addClass('checked')
                    $("#Thirdrating").addClass('checked')
                    $("#Secondrating").addClass('checked')
                    $("#firstrating").addClass('checked')
                    $("#SpnRatingMsg").html("Thank You! looking to serve you better")
                    $("#SpnRatingMsg").append("<i class='fa fa-thumbs-o-up' aria-hidden='true' style='margin-top:1%;margin-left:1%;color:black!important;font-size:15px!important'></i>")
                    $("#SpnRatingMsg").css("color", "Green");
                }


                globalRating = $('#RatingFour').val();
                //  alert(globalRating);
            }

        }



        function SaveFeedback() {
            FeedbackComment = $("#cbFeekback").val();

            //debugger;
            if ($("#firstrating").hasClass('checked') || $("#Secondrating").hasClass('checked') || $("#Thirdrating").hasClass('checked') || $("#Foruthrating").hasClass('checked')) {

                if ($("#cbFeekback").val() == "") {


                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('- Feedback Comment should not be blank', 'error');

                }
                else {
                    //alert(RequestID)
                    // alert(globalRating)
                    data = JSON.stringify({ globalFeedbackID: globalRating, RequestID: RequestID, FeedbackComment: FeedbackComment });
                    // alert(data);
                    strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/SaveFeedback", data, false);
                    // alert(strResult.d);

                    if (strResult.d != '') {


                        Isfeedbackcomment = 1;
                        //alertify.set('notifier', 'position', 'top-right');
                        // alertify.notify('Feedback Comment saved successfully!!!!', 'success');
                        // RefreshIssueTab('Deliverable');
                        document.getElementById('Feedback').style.display = "none";


                        if (ValidateRequestDetails() == 0) {

                            // debugger;

                            var Subject = $("#idSubject").html();
                            var Description = $("#spnDescription").html();
                            var Department = $("#CboDepartment").val();
                            var RequestType = $("#CboRequestType").val();
                            var SubRequestType = $("#CboSubRequestType").val();
                            var Priority = $("#CboPriority").val();
                            var Product = $("#cboProduct").val();
                            var ModuleComponent = $("#CboModuleComponent").val();
                            var Location = $("#CboLocation").val();
                            var TimeZone = $("#CboTimeZone").val();
                            var ExpResoulDate = $("#dtExpResdate").val();
                            var cboStatusOld = $("#cboStatusOld").val();
                            var Status = $("#CboStatus").val();
                            var AssignTo = $("#CboAssignTo").val();
                            var txtResolutionDateOld = $("#txtResolutionDateOld").val();
                            var hidtxtAssignTo = $("#hidtxtAssignTo").val();
                            var DeliverableID = $("#DeliverableID").val();
                            var StatusChangedate = $("#dtStatusChangedate").val();
                            var StatusChangeTime = $("#StatusChangeTime").val();
                            var Keywords = $("#txtKeyWords").val();
                            var CboSeverity = $("#CboSeverity").val();
                            var ExpResoulDate = $("#dtExpResdate").val();

                            if (StatusChangedate == "" || StatusChangedate == undefined) {
                                StatusChangedate = "";
                            }
                            if (StatusChangeTime == "" || StatusChangeTime == undefined) {
                                StatusChangeTime = "";
                            }
                            if (Keywords == "" || Keywords == undefined) {
                                Keywords = "";
                            }
                            var cboAssignToOld = $("#cboAssignToOld").val();

                            // alert(Keywords);
                            if (ExpResoulDate == "" || ExpResoulDate == undefined) {
                                ExpResoulDate = "";
                            }
                            if (TimeZone == "" || TimeZone == undefined) {
                                TimeZone = "";
                            }
                            var m_strCustomFieldList = $("#CustomFieldList").val();
                            var CC = $("#cc").val();

                            if (document.getElementById('CboModuleComponent') == null) {
                                ModuleComponent = "";

                            }
                            if (document.getElementById('cboProduct') == null) {
                                Product = "";

                            }

                            var strTypeInaccessibleCustomFieldList = $("#TypeInaccessibleCustomFieldList").val();

                            // alert(m_strCustomFieldList);

                            if (m_strCustomFieldList != null)
                                //   debugger;
                                var ArrCustomFieldList = m_strCustomFieldList.split(",");
                            var CustomFieldValue = "";
                            for (var i = 0; i < ArrCustomFieldList.length; i++) {
                                // debugger;
                                if (CustomFieldValue == "") { CustomFieldValue = $('#' + ArrCustomFieldList[i]).val(); }
                                else {
                                    CustomFieldValue += ',' + $('#' + ArrCustomFieldList[i]).val();
                                    if (CustomFieldValue.indexOf("undefined") != -1) {
                                        //alert(1);
                                        CustomFieldValue.replace('undefined', "");
                                    }
                                }

                            }

                            if (CustomFieldValue == "" || CustomFieldValue == undefined) {
                                CustomFieldValue = "";
                            }
                            if (m_strCustomFieldList == "") {
                                m_strCustomFieldList = "";
                            }

                            var CustomerID = 0;
                            var EmployeeID = 0;

                            if (Location == undefined || typeof Location == "undefined") {
                                Location = "";
                            }

                            if (AssignTo == undefined || typeof AssignTo == "undefined") {
                                AssignTo = "";
                            }

                            if (txtResolutionDateOld == undefined || typeof txtResolutionDateOld == "undefined") {
                                txtResolutionDateOld = "";
                            }

                            if (hidtxtAssignTo == undefined || typeof hidtxtAssignTo == "undefined") {
                                hidtxtAssignTo = "";
                            }

                            if (DeliverableID == undefined || typeof DeliverableID == "undefined") {
                                DeliverableID = "";
                            }

                            if (StatusChangedate == undefined || typeof StatusChangedate == "undefined") {
                                StatusChangedate = "";
                            }

                            if (StatusChangeTime == undefined || typeof StatusChangeTime == "undefined") {
                                StatusChangeTime = "";
                            }

                            if (Keywords == undefined || typeof Keywords == "undefined") {
                                Keywords = "";
                            }

                            if (CboSeverity == undefined || typeof CboSeverity == "undefined") {
                                CboSeverity = "";
                            }

                            if (cboAssignToOld == undefined || typeof cboAssignToOld == "undefined") {
                                cboAssignToOld = "";
                            }

                            // CustomerID = document.getElementById('hdnCustomerID').value;
                            //  EmployeeID = document.getElementById('hdnEmployeeID').value;
                            // debugger;

                            var SaveRequestDetialsData = [];
                            //
                            SaveRequestDetialsData.push({
                                RequestID: RequestID, Subject: Subject, Description: Description, Department: Department, RequestType: RequestType, SubRequestType: SubRequestType, Priority: Priority, Product: Product,
                                ModuleComponent: ModuleComponent, Location: Location, TimeZone: TimeZone, ExpResoulDate: ExpResoulDate, CustomerID: CustomerID, EmployeeID: EmployeeID, Status: Status, cboStatusOld: cboStatusOld, Project: "",
                                AssignTo: AssignTo, objCustomField: m_strCustomFieldList, CustomFieldValue: CustomFieldValue, cboAssignToOld: cboAssignToOld, txtResolutionDateOld: txtResolutionDateOld, hidtxtAssignTo: hidtxtAssignTo
                                , DeliverableID: DeliverableID, StatusChangedate: StatusChangedate, StatusChangeTime: StatusChangeTime, Keywords: Keywords, CboSeverity: CboSeverity, FeedbackComment: FeedbackComment, globalRating: globalRating
                            });

                            data = JSON.stringify({ SaveRequestDetialsData: SaveRequestDetialsData });


                            // data = JSON.stringify({ Subject: Subject, Description: Description, Department: Department, RequestType: RequestType, SubRequestType: SubRequestType, Priority: Priority, Product: Product, ModuleComponent: ModuleComponent, Location: Location, TimeZone: TimeZone, Status: "", Project: "", AssignTo: "", objCustomField: m_strCustomFieldList, CustomFieldValue: CustomFieldValue, ExpResoulDate: ExpResoulDate, CC: CC, CustomerID: CustomerID, EmployeeID: EmployeeID });
                            //  alert(data);
                            strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/SaveRequestDetails", data, false);
                            var Result = String(strResult.d).split("||");

                            var MsgFlags = [];
                            MsgFlags = (Result[1]).split(",");
                            var intCount = 0;
                            for (intCount = 0; intCount < MsgFlags.length; intCount++) {
                                {
                                    if (MsgFlags[intCount] == "44") {
                                        //window.open("../../Source/General/CRMSendEmail.aspx?MessageID=44&MultipleRequests=0&QueryID=" + RequestID + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 460) / 2 + ",width=600,height=460");
                                        window.open("../EmailSettings/CRMSendEmail.aspx?MessageID=44&QueryID=" + RequestID + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                                    }
                                    if (MsgFlags[intCount] == "544") {
                                        //window.open("../../Source/General/CRMSendEmail.aspx?MessageID=44&MultipleRequests=0&QueryID=" + RequestID + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 460) / 2 + ",width=600,height=460");
                                        window.open("../EmailSettings/CRMSendEmail.aspx?MessageID=544&QueryID=" + RequestID + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");

                                    }
                                    if (MsgFlags[intCount] == "45") {
                                        //window.open("../../Source/General/CRMSendEmail.aspx?MessageID=44&MultipleRequests=0&QueryID=" + RequestID + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 460) / 2 + ",width=600,height=460");
                                        window.open("../EmailSettings/CRMSendEmail.aspx?MessageID=45&QueryID=" + RequestID + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=600,height=500");
                                    }

                                }


                            }
                            // displayFeedback();

                            //Added By Bharat T on 21st-Nov-2017 for request list page state saving
                            var PageNumber = $("#hdnPageNumber").val();
                            var PageFlag = $("#hdnPageFlag").val();
                            var LoadFilterID = $("#hdnLoadFilterID").val();
                            var StatusFilterID = $("#hdnStatusFilterID").val();
                            var DateFilterID = $("#hdnDateFilterID").val();
                            //End of Added By Bharat T on 21st-Nov-2017 for request list page state saving

                            //   req-del-from
                            var objFormRequestdetails = document.getElementById("divrequestDetails");
                            objFormRequestdetails.action = "CRM_RequestDetails_UnCategorised.aspx?QueryID=" + RequestID + "";

                            objFormRequestdetails.action += "&PageNumber=" + PageNumber + "&PageFlag=" + PageFlag + "&LoadFilterID=" + LoadFilterID + "&StatusFilterID=" + StatusFilterID + "&DateFilterID=" + DateFilterID + "";

                            objFormRequestdetails.submit();

                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('- Request Details are saved successfully', 'success');

                            $("#firstrating").removeClass('checked');
                            $("#Secondrating").removeClass('checked');
                            $("#Thirdrating").removeClass('checked');
                            $("#Foruthrating").removeClass('checked');
                            $("#cbFeekback").val("");
                            $("#SpnRatingMsg").html("")


                        }
                    }

                }
            }
            else {

                $("#SpnRatingMsg").html("Please Rate Us!!!!");
                $("#SpnRatingMsg").css("color", "red");

            }
        }


        function CancelFeedback() {

            $("#firstrating").removeClass('checked');
            $("#Secondrating").removeClass('checked');
            $("#Thirdrating").removeClass('checked');
            $("#Foruthrating").removeClass('checked');
            $("#cbFeekback").val("");
            $("#SpnRatingMsg").html("")
            document.getElementById('Feedback').style.display = "none";

        }


        function close_feedback() {

            CancelFeedback();


        }
        function SelectDeleteAllAttachment(obj) {

            if ($(obj).is(':checked'))

                $("input[name=CheckAttachment]").prop('checked', true);
            else
                $("input[name=CheckAttachment]").prop('checked', false);

        }

        function Cancel_Note() {

            $("#txtNewDiscussion").val("");
            //$(".bottom-bar").css("display","none");
            $("#tblFiles").find("thead").find(".clsTREven").remove();
            $("#tblFiles").find("tbody").find(".clsTREven").remove();
            $("#tblFiles").hide();

            $(".clsFileControl").remove();

            $("#txtFileName0").remove();
            var FileControl;
            FileControl = document.createElement("INPUT");
            FileControl.type = "FILE";
            FileControl.id = "txtFileName0";
            FileControl.name = "txtFileName0";
            FileControl.className = 'clsTextBox clsFileControl';
            FileControl.size = 100;
            FileControl.style = "display:none;";


            FileControl.onkeydown = function () { return false; };
            FileControl.onbeforepaste = function () { return false; };
            FileControl.onpaste = function () { return false; };
            FileControl.onkeydown = function () { return false; };
            FileControl.onbeforepaste = function () { return false; };
            FileControl.onpaste = function () { return false; };
            FileControl.onchange = addFileinGrid;
            $("#btnSelectFile").attr("FileCount", 0);

            FileCount_toDisable = 0;
            FileCount = 0;
            $(".clsFileControl").hide();
            document.getElementById("FileControlUploadDiv").appendChild(FileControl);
        }
        function Close_AddNote() {
            document.getElementById('id07').style.display = 'none';
            $("#txtNewDiscussion").val("");
            $("#tblFiles").hide();
            //$(".bottom-bar").css("display","none")
            $("#tblFiles").find("thead").find(".clsTREven").remove();
            $("#tblFiles").find("tbody").find(".clsTREven").remove();
            $("#tblFiles").hide();

            $(".clsFileControl").remove();

            $("#txtFileName0").remove();

            var FileControl;
            FileControl = document.createElement("INPUT");
            FileControl.type = "FILE";
            FileControl.id = "txtFileName0";
            FileControl.name = "txtFileName0";
            FileControl.className = 'clsTextBox clsFileControl';
            FileControl.size = 100;
            FileControl.style = "display:none;";


            FileControl.onkeydown = function () { return false; };
            FileControl.onbeforepaste = function () { return false; };
            FileControl.onpaste = function () { return false; };
            FileControl.onkeydown = function () { return false; };
            FileControl.onbeforepaste = function () { return false; };
            FileControl.onpaste = function () { return false; };
            FileControl.onchange = addFileinGrid;

            $("#btnSelectFile").attr("FileCount", 0);

            FileCount_toDisable = 0;
            FileCount = 0;
            $(".clsFileControl").hide();
            document.getElementById("FileControlUploadDiv").appendChild(FileControl);
        }


        //function Document_OnClick_For_CRM(strSystemFileName, strOriginalFileName) {
        //    //Note : in Attachment.aspx which gets called while uploading a file from Helpdesk Page the FolderNames are hard coded in PerformAction method. Hence Fromwhere is Hard coded	        
        //    var strTemp = '../General/ViewAttachment.aspx?FromWhere=CRM&FileName=' + strOriginalFileName + '&SystemFileName=' + strSystemFileName;	        
        //    window.open(strTemp);
        //}

        function DownloadZip(object) {
            var strResult, data;
            var QueryID = $(object).attr('QueryID');
            var QueryDetailID = $(object).attr('QueryDetailID');
            //alert(QueryID);
            data = JSON.stringify({ QueryID: QueryID, QueryDetailID: QueryDetailID });
            strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/GenerateZipFile", data, false);

            if (strResult.d != '') {
                var strTemp = '../../General/ViewAttachment.aspx?FromWhere=CRM/ZIPFile&FileName=Request_' + QueryID + '.zip&SystemFileName=Request_' + QueryID + '.zip';
                window.open(strTemp);
            }
        }

        function DownloadZipFromAttachmentTab(QueryID) {
            var strResult, data;
            //alert(QueryID);
            data = JSON.stringify({ QueryID: QueryID, QueryDetailID: "" });
            strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/GenerateZipFile", data, false);

            if (strResult.d != '') {
                var strTemp = '../../General/ViewAttachment.aspx?FromWhere=CRM/ZIPFile&FileName=Request_' + QueryID + '.zip&SystemFileName=Request_' + QueryID + '.zip';
                window.open(strTemp);
            }
        }

        window.onclick = function (event) {
            if (event.target == modal) {
                $('[data-toggle="tooltip"]').tooltip("hide");
            }
        }


        //Commented By Dipali V On 25th Nov 2017 For Attachment Code Remove
        function SelectAddnewFile() {

            if (FileCount_toDisableNew == 5) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("User can attach maximum five files at a time.", 'error', 25);

            }

            var strFileCount = $("#btnNewAttachmentFile").attr("filecount");
            var objCurrentFileControl = $("#txtaddattachment" + strFileCount);


            objCurrentFileControl.click();



        }

        var FileCountNew = 0;
        var FileCount_toDisableNew = 0;
        var fileObject = [];
        function addFileinGridnew() {


            $("#dIvaddattachment").show();
            var objtxtFileName = document.getElementById('txtaddattachment' + FileCountNew);
            var objFileGrid = document.getElementById('tblFilesadd');
            objFileGrid.style.display = "";
            var newRow = objFileGrid.insertRow(objFileGrid.rows.length);
            objtxtFileName.style.display = "none";
            newRow.id = 'FILENAME' + FileCountNew;
            newRow.name = 'txtaddattachment0';
            newRow.className = "clsTREven";
            var newCell = newRow.insertCell(0);
            newCell.innerHTML = "<i class='fa fa-file-pdf-o' aria-hidden='true'></i>";

            newCell = newRow.insertCell(1);
            var fileName = objtxtFileName.value;
            var index = fileName.lastIndexOf("\\");
            if (index == -1)
                index = fileName.lastIndexOf("/");

            if (index != -1)
                fileName = fileName.substring(index + 1, fileName.length);

            newCell.innerHTML = fileName;

        <%If HttpContext.Current.Session("LoginType") = "C" Then%>
            newCell = newRow.insertCell(2);
            newCell.innerHTML = "<Textarea wrap='Hard'  name='addtxtComments' id='addtxtComments" + FileCountNew + "' class='form-control' style='width:250px  ; height:50px  ; text-align:Left'  ></Textarea>";

            //newCell = newRow.insertCell(3);
            //newCell.innerHTML = "Internal <Input type=checkbox name='chkIsShowToCustomer" + FileCountNew + "' id='chkIsShowToCustomer" + FileCountNew + "' class='clsCheckBox' style='width:auto;'>";

            newCell = newRow.insertCell(3);
            newCell.innerHTML = "<A class='Menu' style='' HREF='Javascript:RemoveAddnewAttachement(" + FileCountNew + ")' Title='Remove Attachment' >(Remove)</A>";
        <%Else%>
            newCell = newRow.insertCell(2);
            newCell.innerHTML = "<Textarea wrap='Hard'  name='addtxtComments' id='addtxtComments" + FileCountNew + "' class='form-control' style='width:250px  ; height:50px  ; text-align:Left'  ></Textarea>";

            newCell = newRow.insertCell(3);
            newCell.style.textAlign = 'center';
            newCell.innerHTML = "Internal <Input type=checkbox name='addchkIsShowToCustomer" + FileCountNew + "' id='addchkIsShowToCustomer" + FileCountNew + "' class='clsCheckBox' style='width:auto!important;margin-left:4%;vertical-align:bottom;margin-top:7%'>";
            newCell = newRow.insertCell(4);
            newCell.innerHTML = "<A class='Menu' style='' HREF='Javascript:RemoveAddnewAttachement(" + FileCountNew + ")' Title='Remove Attachment' >(Remove)</A>";
        <%End If%>

            parentTD = objtxtFileName.parentNode;
            objtxtFileName.style.display = "none";

            FileCountNew++;
            FileCount_toDisableNew++;

            var FileControl;
            FileControl = document.createElement("INPUT");
            FileControl.type = "FILE";
            FileControl.id = "txtaddattachment" + FileCountNew;
            FileControl.name = "txtaddattachment" + FileCountNew;
            FileControl.className = 'clsTextBox clsFileControl1';
            FileControl.size = 74;



            FileControl.onkeydown = function () { return false; };
            FileControl.onbeforepaste = function () { return false; };
            FileControl.onpaste = function () { return false; };
            FileControl.onkeydown = function () { return false; };
            FileControl.onbeforepaste = function () { return false; };
            FileControl.onpaste = function () { return false; };
            FileControl.onchange = addFileinGridnew;

            if (FileCount_toDisableNew == 5) {

                FileControl.disabled = true;
            }



            parentTD.appendChild(FileControl);

            var objtxtFileName = document.getElementById('txtaddattachment' + FileCountNew);
            objtxtFileName.style.display = "none";
            $("#btnNewAttachmentFile").attr("filecount", FileCountNew);




        }

        function RemoveAddnewAttachement(FileNO) {


            var objTR = document.getElementById('FILENAME' + FileNO);
            var toRemoveFileControl = document.getElementById('txtaddattachment' + FileNO);
            var objFileGrid = document.getElementById('tblFilesadd');

            objFileGrid.deleteRow(objTR.rowIndex);
            //if(FileNO > 0)
            //{
            toRemoveFileControl.parentNode.removeChild(toRemoveFileControl);
            //}
            document.getElementById("txtaddattachment" + FileCountNew).disabled = false;;

            if (objFileGrid.rows.length == 1) {
                //objFileGrid.style.display = 'none';
            }

            FileCount_toDisableNew--;
        }


        function SaveAttachmentDetails() {

            var strURL = "CRM_RequestDetails_UnCategorised.aspx";
            var formData = new FormData();
            var objFileGrid = document.getElementById('tblFilesadd');

            //Integrated by Yogesh Jalamkar on 29-Nov-2017 Purpose: for Mime type
            fileObject = [];
            $("#Addattachemt [type=file]").each(function (j, val) {
                if ($(this)[0].files.length != 0) {
                    fileObject[(j)] = $(this)[0].files;
                }
            })
            //for (var j = 0; j < tblFilesadd.rows.length - 1; j++) {
            //    if ($("#txtaddattachment" + j)[0] != undefined)
            //    fileObject[j] = $("#txtaddattachment" + j)[0].files;
            //}
            var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
            var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>'
            var validateExtensions = strFileExtension.split(",");

            for (var i = 0; i < fileObject.length; i++) {
                if (fileObject[i] != null || fileObject[i] != undefined) {
                    if (fileObject[i].length > 0) {
                        var allowSubmit = false;
                        var intActualFileSize = (fileObject[i][0].size);
                        //formData.append("TxtComment_" + [i], document.getElementById('txtComments' + [i]).value);
                        // formData.append("Internal_" + [i], 1);
                        if (intActualFileSize < intMinFileSize) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify('- File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'error', 25);
                            return;
                        }
                        var file = fileObject[i][0].name;
                        var extension = file.slice(file.lastIndexOf('.') + 1).toLowerCase();
                        for (var cnt = 0; cnt < validateExtensions.length; cnt++) {
                            var strExtn;
                            strExtn = validateExtensions[cnt];
                            if (strExtn.toLowerCase() == extension) { allowSubmit = true; }
                        }
                        if (allowSubmit == false) {
                            alertify.set('notifier', 'position', 'top-right');
                            alertify.notify("Only files with extensions " + (validateExtensions.join(", ", "").toUpperCase()) + " are  allowed!!!", 'error', 25);
                            return;
                        }
                    }
                }
            }
            //End by yogesh Jalamkar
            for (var i = 0; i < fileObject.length; i++) {
                if (fileObject[i] != null || fileObject[i] != undefined) {
                    formData.append(fileObject[i][0].name, fileObject[i][0]);
                }
            }

            for (var i = 0; i < fileObject.length; i++) {
                if (fileObject[i] != null || fileObject[i] != undefined) {
                    if (document.getElementById('addtxtComments' + i) != null) {
                        formData.append("TxtComment_" + i, document.getElementById('addtxtComments' + i).value);
                        if (document.getElementById("addchkIsShowToCustomer" + i) != null) {
                            if (document.getElementById("addchkIsShowToCustomer" + i).checked == true) {
                                formData.append("Internal_" + i, "I");
                            }
                            else {
                                formData.append("Internal_" + i, "");
                            }
                        }
                        else {
                            formData.append("Internal_" + i, "");
                        }
                    }
                }
            }



            formData.append('Mode', 'FileNewAttachments');
            formData.append('RequestID', RequestID);

            if (fileObject != undefined) {

                console.log(formData)

                $.ajax({
                    url: strURL,  //Server script to process data
                    type: 'POST',
                    data: formData,
                    async: false,
                    success: function (result) {
                        var strResult = String(result).split("||");
                        var strSystemFileName = strResult[0];
                        var strLatestFileName = strResult[1];
                    },
                    cache: false,
                    contentType: false,
                    processData: false
                });

            }

            RefreshGrid('Attachments');
            Close_NewAttachment();
        }
        function Close_NewAttachment() {
            document.getElementById('dIvaddattachment').style.display = 'none';

            $("#tblFilesadd").hide();
            //$(".bottom-bar").css("display","none")
            $("#tblFilesadd").find("thead").find(".clsTREven").remove();
            $("#tblFilesadd").find("tbody").find(".clsTREven").remove();
            $("#tblFilesadd").hide();

            $(".clsFileControl1").remove();

            $("#txtaddattachment0").remove();

            var FileControl;
            FileControl = document.createElement("INPUT");
            FileControl.type = "FILE";
            FileControl.id = "txtaddattachment0";
            FileControl.name = "txtaddattachment0";
            FileControl.className = 'clsTextBox clsFileControl1';
            FileControl.size = 100;
            FileControl.style = "display:none;";


            FileControl.onkeydown = function () { return false; };
            FileControl.onbeforepaste = function () { return false; };
            FileControl.onpaste = function () { return false; };
            FileControl.onkeydown = function () { return false; };
            FileControl.onbeforepaste = function () { return false; };
            FileControl.onpaste = function () { return false; };
            FileControl.onchange = addFileinGridnew;

            $("#btnNewAttachmentFile").attr("filecount", 0);

            FileCount_toDisableNew = 0;
            FileCountNew = 0;
            $(".clsFileControl1").hide();
            document.getElementById("Addattachemt").appendChild(FileControl);
        }
        //End of Commented By Dipali V On 25th Nov 2017 For Attachment Code Remove
        <%--End of Dipali V On 31st Oct 2017--%>
        //Added By Vidya Jadhav On 27 Nov 2017 For Status Change Time
        function cboStatus_OnChange() {
            // debugger;
            var objStatusTime = $('#StatusChangeTime');
            var objStatusDate = $('#dtStatusChangedate');
            var objCurrentDate = $('#CurrentDate');

            var objWhizStatusDate = $('#txtchangedDate');
            var objCurrentTime = $('#CurrentTime');

            var objNewStatus = $('#CboStatus');
            var objOldStatus = $('#cboStatusOld');
            var objReadOnlychangedDate = $('#txtReadOnlychangedDate');

            var objTimehr, objTimeMin;
            objTimeMin = Right(objCurrentTime.val(), 2);
            objTimehr = Left(objCurrentTime.val(), 2);

            var StatusDate;
            var WhizStatusDate;
            var StatusDate;
            var StatusTime;

            if (objOldStatus != null && objNewStatus != null && objStatusDate != null && objStatusTime != null) {

                if (objOldStatus.val() == objNewStatus.val()) {
                    //if (objOldStatusChangeDate.value!=objStatusDate.value || objOldStatusChangeTime.value !=objStatusTime.value )
                    //{

                    //    objStatusDate.value= objOldStatusChangeDate.value;
                    //    objWhizStatusDate.value=objOldStatusChangeDate_Control.value //objOldStatusChangeDate.value;
                    //    objStatusTime.value=objOldStatusChangeTime.value;
                    //    if(objReadOnlychangedDate!=null)
                    //        objReadOnlychangedDate.value=objOldStatusChangeDate.value;

                    //}

                }

                else {

                    StatusDate = objCurrentDate.val();
                    WhizStatusDate = objCurrentDate.val();
                    StatusDate = $('#CurrentDate').val();
                    //objStatusTime.value=objTimehr+':'+objTimeMin
                    StatusTime = $('#CurrentTime').val();

                    objStatusTime.val("");
                    objStatusTime.val(StatusTime);

                }

            }
        }


        function cbFlagTo_OnBlur() {


        }
        function ValidateResourceDate_XML(strUrl) {
            // TO SEE IF WE ARE RUNNING IN IE 
            var Browser = WhichBrowser(); // Added By Vaijat K ON 19/11/2015
            strNavigator = navigator.appName;
            strNavigator = strNavigator.toUpperCase();
            //if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
            if (Browser == 'IE') // Added By Vaijat K ON 19/11/2015
            {
                g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
                //hook the event handler
                g_objXHttp.onreadystatechange = TaskValidation_state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", strUrl, false);
                //finally send the call
                g_objXHttp.send();
            }
            else {
                // Mozilla - based browser , Netscape
                g_objXHttp = new XMLHttpRequest();
                //hook the event handler
                g_objXHttp.onreadystatechange = TaskValidation_state_change;
                //prepare the call, http method=GET, false=asynchronous call
                g_objXHttp.open("GET", strUrl, false);
                //finally send the call
                g_objXHttp.send(null);

                if (g_objXHttp.responseText != null) {
                    xmlDoc = document.implementation.createDocument("", "", null);
                    xmlDoc.async = false;
                    if (Browser == 'FF') // Added By Vaijat K ON 19/11/2015
                        xmlDoc.load(g_objXHttp.responseXML);
                    strResult = g_objXHttp.responseText;
                }
            }
            return strResult;
        }

        function TaskValidation_state_change() {
            var Browser = WhichBrowser(); // Added By Vaijat K ON 19/11/2015
            if (g_objXHttp.readyState == 4) {
                // Make sure request came back OK 
                if (g_objXHttp.status == 200) {
                    //if (window.ActiveXObject)
                    if (Browser == 'IE') // Added By Vaijat K ON 19/11/2015
                    {
                        xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
                        xmlDoc.async = false;
                        xmlDoc.loadXML(g_objXHttp.responseText);
                    }
                    // code for Mozilla, etc.
                    else if (document.implementation && document.implementation.createDocument) {
                        xmlDoc = document.implementation.createDocument("", "", null);
                        xmlDoc.async = false;
                        if (Browser == 'FF') // Added By Vaijat K ON 19/11/2015
                            xmlDoc.load(g_objXHttp.responseXML);
                    }
                    //Save the Result in a Global variable
                    strResult = g_objXHttp.responseText;
                }
            }
        }

        function IssueProduct_Onchange(obj) {

            var url = "CRM_RequestDetails_UnCategorised.aspx/GetModuleOrComponent"
            var ProductID = obj.value;
            data = JSON.stringify({ ProductID: ProductID });
            CustomAJAXCall(url, data, BindDropdownModule);
        }

        function BindDropdownModule(result) {

            var strArray = String(result.d).split("|")
            var objCbo = document.getElementById("CboIssueComponent");
            var i = 0;
            objCbo.innerHTML = "";

            if (objCbo.value != '') {
                insBlankOpt(objCbo);
            }
            $.each(JSON.parse(strArray[0]), function (id, obj) {

                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = obj.Component
                objOption.value = obj.ComponentID;;
            });
        }

        function PlotCustomField() {
            var ProjectID = $("#cboDeliverableProject").val();
            var ScheduleID = $("#cboDeliverableType").val();
            var url = "CRM_RequestDetails_UnCategorised.aspx/writeMandatoryFields"
            if (ScheduleID != null) {
                data = JSON.stringify({ strScheduleID: ScheduleID, strProjectID: ProjectID });
                CustomAJAXCall(url, data, WriteCustomFields);
            }
            else {
                document.getElementById("divCustomFields").innerHTML = "";
            }
        }

        function WriteCustomFields(result) {
            document.getElementById("divCustomFields").innerHTML = result.d;
            $(".dtPicker").each(function (id, val) {
                $(this).datepicker();
            })


        }
</script>

    <script id="scrValidations">

        function validateData() {
            return true;
        }

    </script>

    <script>
        function openCity(evt, cityName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
                //  $(".tab").css("border-bottom","1px solid #ddd")
            }
            document.getElementById(cityName).style.display = "block";


            if (cityName != "Discussion") {
                RefreshGrid(cityName);
            }

            if (evt != undefined) {
                if (!evt.currentTarget) {
                    evt.currentTarget.className += " active";
                }
            }

        }

        // Get the element with id="defaultOpen" and click on it
        //Added by yogesh Jalamkar on 06-DEC-2017 Purpose: After delete attachment in discussion  section it should not display
        if (getParameterByName("FromWhere") == "AttachmentDelete") {
            var i, tabcontent1, tablinks;
            var RequestID1 = document.getElementById('hdnRequestID').value;
            tabcontent1 = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent1.length; i++) {
                tabcontent1[i].style.display = "none";
            }
            document.getElementById("Attachments").style.display = "block";
            var strResult, data;
            var cityName = "Attachments";

            var FieldName = "null";
            var ModifiedBy = "null";
            var filterflag = "Load";
            var strPageName1 = "CRM_RequestDetails_UnCategorised.aspx";
            data = JSON.stringify({ RequestID: RequestID1, Flag: cityName, FieldName: FieldName, ModifiedBy: ModifiedBy, filterflag: filterflag });

            strResult = AJAXCallWithResult(strPageName1 + "/RequestDetailsTabs", data, false);
            //  alert(strResult.d);
            if (strResult.d != '') {
                document.getElementById(cityName).innerHTML = "";
                // alert(strResult.d);
                document.getElementById(cityName).innerHTML = strResult.d;
            }

        }
        else if (getParameterByName("FromWhere").toUpperCase() == "SAVEDELIVERABLEREFRESH") {
            var i, tabcontent1, tablinks;
            var RequestID1 = document.getElementById('hdnRequestID').value;
            tabcontent1 = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent1.length; i++) {
                tabcontent1[i].style.display = "none";
            }

            var strResult, data;
            var cityName = "Association";
            document.getElementById(cityName).style.display = "block";
            var FieldName = "null";
            var ModifiedBy = "null";
            var filterflag = "Load";
            var strPageName1 = "CRM_RequestDetails_UnCategorised.aspx";
            data = JSON.stringify({ RequestID: RequestID1, Flag: cityName, FieldName: FieldName, ModifiedBy: ModifiedBy, filterflag: filterflag });

            strResult = AJAXCallWithResult(strPageName1 + "/RequestDetailsTabs", data, false);
            //  alert(strResult.d);
            if (strResult.d != '') {
                document.getElementById(cityName).innerHTML = "";
                // alert(strResult.d);
                document.getElementById(cityName).innerHTML = strResult.d;
                setTimeout(function () {
                    document.getElementById("defaultOpenDeliverable").className += " active";
                    document.getElementById("defaultOpenDeliverable").onclick();
                }, 500);
            }
        }
        else {
            if (document.getElementById("defaultOpen") != null)
                document.getElementById("defaultOpen").click();
        }
        //End by yogesh Jalamkar


        function ApproveRequest(QueryID) {
            if (document.getElementById("txtAComments").value == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Please enter comment.", 'error', 25);
                document.getElementById("txtAComments").focus();
                return;
            }
            var strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/ApproveOrReject", JSON.stringify({ strAction: 'A', strComments: $("#txtAComments").val(), queryID: QueryID }));
            if (strResult.d == 1) {
                window.location.reload();
            }
        }
        function RejectRequest(QueryID) {
            if (document.getElementById("txtRComments").value == "") {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Please enter comment.", 'error', 25);
                document.getElementById("txtRComments").focus();
                return;
            }
            var strResult = AJAXCallWithResult("CRM_RequestDetails_UnCategorised.aspx/ApproveOrReject", JSON.stringify({ strAction: 'R', strComments: $("#txtRComments").val(), queryID: QueryID }))
            if (strResult.d == 1) {
                window.location.reload();
            }
        }

        function SaveCustomer() {

            var CustomerName = $("#CustomerName").val();
            var CustomerAbbrName = $("#CustomerAbbrName").val();
            var CustomerEmail = $("#CustomerEmail").val();
            var CboDepartmentCustomer = $("#CboDepartmentCustomer").val();
            var checkValue = 0;
            var strmsg = "";
            var errorMsg = "<ul>"
            if (CustomerName == "") {
                //alertify.set('notifier', 'position', 'top-right');
                //alertify.notify("Please enter Customer Name.", 'error', 25);
                strmsg = "- Please enter Customer Name.";
                errorMsg += "<li>" + strmsg + "</li>";
                document.getElementById("CustomerName").focus();
                checkValue = 1
            }
            if (CustomerAbbrName == "") {
                //alertify.set('notifier', 'position', 'top-right');
                //alertify.notify("Please enter Customer Abbreviated Name.", 'error', 25);

                strmsg = "- Please enter Customer Abbreviated Name.";
                errorMsg += "<li>" + strmsg + "</li>";
                if (checkValue != 1)
                    document.getElementById("CustomerAbbrName").focus();
                checkValue = 1;
            }
            if (CustomerEmail == "") {
                //alertify.set('notifier', 'position', 'top-right');
                //alertify.notify("Please enter Customer Email ID.", 'error', 25);
                strmsg = "- Please enter Customer Email ID.";
                errorMsg += "<li>" + strmsg + "</li>";
                if (checkValue != 1)
                    document.getElementById("CustomerEmail").focus();
                checkValue = 1;
            }

            if (validateEmailID(document.getElementById("CustomerEmail")) == false) {
                //alertify.set('notifier', 'position', 'top-right');
                //alertify.notify("Please enter valid Customer Email ID.", 'error', 25);
                strmsg = "- Please enter valid Customer Email ID.";
                errorMsg += "<li>" + strmsg + "</li>";
                if (checkValue != 1)
                    document.getElementById("CustomerEmail").focus();
                checkValue = 1;
            }
            if (CboDepartmentCustomer == "") {
                //alertify.set('notifier', 'position', 'top-right');
                //alertify.notify("Please Select Department.", 'error', 25);
                strmsg = "- Please Select Department.";
                errorMsg += "<li>" + strmsg + "</li>";
                if (checkValue != 1)
                    document.getElementById("CboDepartmentCustomer").focus();
                checkValue = 1;
            }

            var url = 'CRM_RequestDetails_UnCategorised.aspx/CheckCustomerAbbName';
            var data = JSON.stringify({ Flag: "Customer", AbbName: $('#CustomerAbbrName').val(), CustomerID: 'Null' });
            $.ajax({
                type: "POST",
                url: url,
                data: data,
                dataType: "json",
                contentType: "application/json",
                async: false,
                success: function (result) {
                    if (result.d == 1) {
                        //alertify.set('notifier', 'position', 'top-right');
                        //alertify.notify("Abbreviated name  Already Exists.", 'error', 25);
                        strmsg = "Abbreviated name  Already Exists.";
                        errorMsg += "<li>" + strmsg + "</li>";
                        if (checkValue != 1)
                            document.getElementById("CustomerAbbrName").focus();
                        checkValue = 1;
                    }
                },
            });
            if (checkValue == 0) {
                var url = "CRM_RequestDetails_UnCategorised.aspx/SaveCustomer"
                var data = JSON.stringify({ strCustomerName: CustomerName, strAbbrName: CustomerAbbrName, strEmail: CustomerEmail, strDeptID: CboDepartmentCustomer, RequestID: RequestID })
                var strCmbResult = AJAXCallWithResult(url, data, false);
                $("#divCustomerSelect").html(strCmbResult.d);
                $("#divCustomer").modal('hide');
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify("Customer saved successfully!!!", 'success', 10);
                Customer_New_Onchange(document.getElementById("CboCustomer"));
            }
            else {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify(errorMsg, 'error', 10);
            }
        }

        function Department_OnChange(obj) {

            // ClearSpan('DcboDepartmentSQL', 'spanDepartment')
            var url = "CRM_RequestDetails_UnCategorised.aspx/GetRequestType"
            DepartmentID = obj.value;

            var CustomerID = 0;
            var EmployeeID = 0;

            data = JSON.stringify({ TypeID: DepartmentID, WhichList: 'RequestType', RequestTypeID: '', CustomerID: $("#CboCustomer").val(), EmployeeID: '<%=Session("intUserID")%>', QueryID: document.getElementById('hdnRequestID').value });
            CustomAJAXCall(url, data, BindDropDownRequestType);
        }

        function BindDropDownRequestType(result) {

            var strArray = String(result.d).split("|")

            var objDepartmentID = document.getElementById('CboDepartment');
            var i = 0;

            // alert(objCbo.value);
            document.getElementById('Product').innerHTML = ""
            document.getElementById('Product').innerHTML = strArray[2];

            var objCbo = document.getElementById("CboRequestType");
            objCbo.innerHTML = "";
            document.getElementById("CboSubRequestType").innerHTML = "";
            insBlankOpt(objCbo);
            $.each(JSON.parse(strArray[0]), function (id, obj) {
                var objOption = document.createElement("OPTION");
                objCbo.options.add(objOption);
                objOption.text = obj.RequestType;
                objOption.value = obj.RequestTypeID;
            });

            //   alert(objCbo.options.length)

        }

        function Customer_New_Onchange(obj) {
            var url = "CRM_RequestDetails_UnCategorised.aspx/GetDepartmentCustomerWise"
            data = JSON.stringify({ CustomerID: obj.value });
            var strResultDept = AJAXCallWithResult(url, data, false);
            $("#divDepartmentSelect").html(strResultDept.d);
            if (document.getElementById("CboDepartment").value != 0)
                Department_OnChange(document.getElementById("CboDepartment"));
        }

        function CancelCustomer() {
            $("#CboDepartmentCustomer").val('');
            $("#CustomerName").val('');
            $("#CustomerEmail").val('');
            $("#CustomerAbbrName").val('');
        }
</script>
</html>

