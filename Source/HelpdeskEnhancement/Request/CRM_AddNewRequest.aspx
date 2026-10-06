<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CRM_AddNewRequest.aspx.vb" Inherits="Whizible.CRM_AddNewRequest" %>

<!DOCTYPE html>
<html lang="en">
    <%CommonFunctions.General.PlotPageHeadTag("New Request Page")%>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>New Request Page</title>
    <%--<%Whizible.clsCommonFunctions.PlotPageHeadTag("New Request Page")%>--%>
    <%--<%CommonFunctions.General.PlotPageHeadTag("New Request Page")%>--%>
    <script id="MainScript" >
    </script>

    <!-- Bootstrap core CSS -->
     <!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
    <!-- <link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/jquery-ui-1.13.2.min.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/plugins/alertify/css/alertify.min.css" />-->
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/updated_versions.css" /> 
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/editor.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/newequest.css" />
    <link rel="stylesheet" href="../../../Whizible2.0-new/dist/css/sb-admin.css" />
    <!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

</head>

<style>

    /*Added By Yasmin on 16th July*/
 #DivCustomFieldsSection input, #DivCustomFieldsSection select, #DivCustomFieldsSection textarea {
        margin-bottom: 10px!important;
 }

  /*Commented by Usha Pandit on 03 Aug 2018 for custom field alignment issue*/
 /*#CustomFieldCombo9 {
 background:#fff!important;
 width:126px!important;
 border-radius:4px;
 }*/
   /*End of Commented by Usha Pandit on 03 Aug 2018 for custom field alignment issue*/

 /*Added By Yasmin on 12th July*/
    /*Commented and Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue*/
    /*.form-control {
    width:100%!important;
    }*/

    .form-control:not(.clsCustomField):not(.clsDateControl) {
    width:100%!important;
    }
    /*End of Added by Usha Pandit on 03 Aug 2018 for custom field alignment issue*/

        /*Commented by Usha Pandit on 03 Aug 2018 for custom field alignment issue*/
    /*#CustomFieldTextArea1 {
        padding: 12px;
        width: 100%!important;
    }*/

   /*End of Commented by Usha Pandit on 03 Aug 2018 for custom field alignment issue*/


 #DivCustomFieldsSection {
     margin-left: 12px
 }
 textarea {
   -moz-user-select: text;
   -webkit-user-select: text;
   -ms-user-select: text;
 }
 .affix {
     top: 50px;
     width: 100%;
 }

 #btnBacknew {
     text-align: center;
     padding-right: 10px;
     padding-top: 0%;
     color: white;
     float: right;
     /* margin-left: 0%; */
     /*Added by Dipali V on 11th Feb 2021 microlink issue fixing */
     background: #404f68!important;
    /*End of Added by Dipali V on 11th Feb 2021 microlink issue fixing */
     margin-right: 6%;
     margin-top: 2%;
     height: 21px;
     width: 17%;
 }

 .help-desk {
     float: left;
     width: 100%;
     z-index: 100;
 }

 #cc {
     width: 100%;
     box-shadow: none;
     margin: -6px 0 10px 0;
     height: 35px;
     font-size: 13px;
     font-weight: 100 !important;
     float: left;
 }

 ul.custom-ul {
     z-index: 99;
 }

 .file {
     visibility: hidden;
     position: absolute;
 }

 .attacment-file .form-control.input-lg {
     float: left;
     width: 210px;
     padding: 7px 5px 7px 10px;
     font-size: 13px;
     font-weight: 600;
     background-color: transparent;
     box-shadow: none;
 }

 .attacment-file .input-group-btn {
     float: left;
 }

 /*.attacment-file .input-group-btn button {
         padding: 6px 5px 7px!important;
         height: auto!important;
         font-weight: 600!important;
         font-size: 13px!important;
         background-color: #404f68!important;
         color: white!important;
     }*/

 .attacment-file .form-group {
     border: none !important;
     float: left;
     padding: 0 !important;
     margin: 0 !important;
 }

 .affix {
     top: 50px;
     width: 100%;
 }

 .help-desk {
     float: left;
     width: 100%;
     z-index: 100;
 }

 .content-wrapper {
     margin-left: auto !important;
 }

 #divCustomField {
     width: 100%;
     /*overflow: auto;*/
     margin-left: -1%;
     line-height: 0px !important;
 }

 .detail-inner .form-control {
     padding: 1px;
 }

 #idCalender {
     position: relative;
     top: -33px !important;
     /* right: -144px !important; */
     float: right;
     margin-right: -16% !important;
     cursor:pointer;
 }


 #divGuidelines {
     font-size: 11px !important;
 }

 #lblApprovalStatus {
     color: red;
 }


 .request-detail .form-control {
     font-size: 11px !important;
 }

 .content-wrapper {
     margin-left: 0px !important;
 }

 .bottom-bar {
     width: 100%;
     overflow: auto;
 }

 /*body {
     font-size: 12px!important;
     font-weight: 100!important;
 }

 .form-group label {
       font-size: 12px!important;
     font-weight: 100!important;
 }*/

 .detail-inner .form-group {
     padding: 0px 12px 6px 12px !important;
 }

 .alertify-notifier .ajs-message {
     width: 300px;
     word-break: break-word;
 }

 .cust-file h5 {
/*     Modified By Madhuri.K on 26-03-2026*/
     font-size: 11.5px;
     margin-left: 28px;
     margin-bottom: 0px !important;
     margin-left: 5%;
 }


 #frmRequest label {
     margin-left: 1% !important;
     font-size: 11px !important;
     font-weight: 600 !important;
 }

 #divCustomField label {
     /*margin-left: 2% !important;*/
     margin-bottom:10px!important;
     font-size: 10.5px !important;
     font-weight: 600 !important;
     /*margin-top: 3%;*/
 }

 #divCustomField .form-control {
     margin-bottom: 13px !important;
 }

 #lblnodata {
    /* Modified By Madhuri.K on 26-03-2026*/
     font-size: 11.5px;
     margin-left: 28px;
     font-weight: 100 !important;
 }

 #Attachments {
     margin-top: 2%;
 }


 #divAttachments #tblFiles tr td A.Menu {
     color: #337ab7 !important;
     background-color: white !important;
 }

     #divAttachments #tblFiles tr td A.Menu:hover {
         background-color: white !important;
         color: #337ab7 !important;
     }

      /*Added by Dipali V on 20th Dec 2017 For IE Browser*/
 .form-control:-ms-input-placeholder { /* IE 10+ */
   color: #bbb!important;
 }
 .fcalcustom {
     font-size: 14px;
     margin-right: -120px;
     float: right;
     margin-top: -33px;
     cursor: pointer;
     }

  @media (max-width:882px) {
     .fcalcustom {
         font-size: 14px;
         margin-right: -116px;
     }
 }
 @media (max-width:861px) {
  #divCustomField label {
    margin-top:10px!important;
 }
 }
 @media (max-width: 767px){
 .fcalcustom {
     margin-right: -104px!important;
 }
 }

 /*Added by Usha Pandit on 03 Aug 2018 for custom field alignment*/
 .clsCustomField {
     font-size: 11px!important;
 }
 ::-webkit-scrollbar {
     display: none;
 }

 #MainDiv {
     -ms-scrollbar-arrow-color: white !important;
     -ms-scrollbar-base-color: white !important;
     -ms-scrollbar-shadow-color: white !important;
 }
   /* End of Added by Usha Pandit on 03 Aug 2018 for custom field alignment*/
   .h1, .h2, .h3, h1, h2, h3 {margin-top: 20px;margin-bottom: 10px;}
   .btn-primary {color: #fff;background-color: #337ab7;border-color: #2e6da4;}
   .btn-primary:hover {color: #fff;background-color: #286090;border-color: #204d74;}
   select.form-control:not([size]):not([multiple]) {height: calc(1.50rem + 2px);}
   .request-detail .form-group{display:inline-flex}
   label {display: inline-block;max-width: 100%;margin-bottom: 5px;font-weight: 700;}
   .clsGridTable td{vertical-align: top;}
</style>

<%--<body class="fixed-nav sticky-footer bg-dark" id="page-top">--%>
<body class="" id="page-top" onload="window_onload()">
    <input type="hidden" id="hdnCustomerID" name="hdnCustomerID" value="" />
    <input type="hidden" id="hdnEmployeeID" name="hdnEmployeeID" value="" />
    <div id="MainDiv" style="overflow: auto;">
        
        <!-- Navigation -->
        <%--  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
              <a class="navbar-brand" href="#"><img src="img/logo.png"></a>      
              <div class="collapse navbar-collapse in shoW" id="navbarResponsive">
                <ul class="navbar-nav navbar-sidenav" id="exampleAccordion">
		
		          <li class="nav-item active" data-toggle="tooltip" data-placement="right" title="Dashboard">
                    <a class="nav-link" href="#">
                      <i class="fa fa-bars" aria-hidden="true"></i>              
                    </a>
                  </li>
                  <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Dashboard">
                    <a class="nav-link" href="#">
                      <i class="fa fa-search"></i>              
                    </a>
                  </li>
                  <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Charts">
                    <a class="nav-link" href="#">
                      <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                    </a>
                  </li>
                  <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Tables">
                    <a class="nav-link" href="#">
                      <i class="fa fa-home"></i>
                    </a>
                  </li>       
         
                  <li class="nav-item" data-toggle="tooltip" data-placement="right" title="Link">
                    <a class="nav-link" href="#">
                      <i class="fa fa-cogs" aria-hidden="true"></i>
                    </a>
                  </li>
                </ul>
        
                <ul class="navbar-nav ml-auto">          
                  <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle mr-lg-2" href="#" id="alertsDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fa fa-fw fa-bell"></i>             
                      <span class="new-indicator text-warning d-none d-lg-block">
                        <span class="number">3</span>
                      </span>
                    </a>
            
                  </li>
                  <li><i class="fa fa-question" aria-hidden="true"></i>	</li>
		          <li><img src="img/userimg.png"><span>UserName</span></li>
		          <li><i class="fa fa-sign-out" aria-hidden="true"></i></li>          
                </ul>
              </div>
            </nav>--%>

        <div class="content-wrapper">

            <div class="container-fluid">
                <!---- HelpDesk---------------------->
                <%--Commented By Vidya Jadhav ON 11 OCt 2017 For Helpdesk Version 02--%>
                <%--  <div class="help-desk" data-spy="affix" data-offset-top="100">
							<div class="row">						
									<div class="req-dsk-kn new-req-head">									
									<div class="col-md-12">
									<ul>
										<li style="margin-top: -11px;">
											<h4>New Request</h4>
										</li>
										<li><a href="#">Requests</a></li>
										<li><a href="#">Dashboard</a></li>
										<li><a href="#">Knowledge</a></li>
										<li class="new-r-btn"><button type="button" class="btn btn-default">New Request<i class="fa fa-plus" aria-hidden="true"></i></button></li>
									</ul>
									</div>
									</div>
									
							</div>
			</div>--%>
                <%--End Of Commented By Vidya Jadhav ON 11 OCt 2017 For Helpdesk Version 02--%>
                <div class="new-req-form">

                    <div class="row">
                        <div class="col-md-6">
                            <div class="reqeustor" style="font-size: 12px!important">
                                <h2 style="font-size: 12px!important">Requestor *</h2>

                                <div class="requestor-select">
                                    <input type="text" id="idRequestorName" disabled placeholder="Select Name" />
                                    <ul class="list-unstyled custom-ul">
                                        <div class="dropdown-icon"><i class="fa fa-chevron-down" aria-hidden="true"></i></div>
                                        <%-- <li class="init" id="idselect">Select</li>--%>
                                        <li data-value="value 1" class="init" id="idSelf" onclick="SelfSelection()">Self</li>
                                        <%If HttpContext.Current.Session("LoginType") <> "C" Then%>
                                        <li data-value="value 3" id="idSelf1">Self</li>
                                        <%End If%>

                                        <li data-value="value 2" id="idCustomer">Customer</li>



                                        <div class="popupnew">
                                            <div class="search-bar">
                                                <div id="imaginary_container">
                                                    <div class="input-group stylish-input-group">
                                                        <div style="display:inline-flex">
                                                        <span class="input-group-addon">
                                                            <button type="button"><i class="fa fa-search" aria-hidden="true"></i></button>
                                                        </span>
                                                        <input type="text" class="form-control" placeholder="Search" id="searchlist" onkeyup="mySearch('Customer')">
                                                            </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <ul class="list-unstyled custom-ul" id="ulCustomer">
                                                <%-- <li data-value="value 1">Customer Peter</li>
                                        <li data-value="value 2">Customer John</li>
                                        <li data-value="value 3">Customer joe</li>
	                                    <li data-value="value 1">Customer Peter</li>
                                        <li data-value="value 2">Customer John</li>
                                        <li data-value="value 3">Customer joe</li>
	                                    <li data-value="value 1">Customer Peter</li>
                                        <li data-value="value 2">Customer John</li>
                                        <li data-value="value 3">Customer joe</li>--%>
                                                <%GetCustomerList()%>
                                            </ul>
                                        </div>

                                        <li data-value="value 3" id="idEmployee">Employee</li>



                                        <div class="popupnew">

                                            <div class="search-bar">
                                                <div id="imaginary_containerEmployee">
                                                    <div class="input-group stylish-input-group">
                                                        <div style="display:inline-flex">
                                                        <span class="input-group-addon">
                                                            <button type="button"><i class="fa fa-search" aria-hidden="true"></i></button>
                                                        </span>
                                                        <input type="text" class="form-control" placeholder="Search" id="SearchEmployee" onkeyup="mySearch('Employee')">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <ul class="list-unstyled custom-ul" id="ulEmployee">
                                                <%--  <li data-value="value 1">Employee Jane</li>
                                                <li data-value="value 2">Employee Peggy</li>
                                                <li data-value="value 3">Employee Miya</li>--%>
                                                <%GetEmployeeList()%>
                                            </ul>
                                        </div>

                                    </ul>
                                </div>

                                <div class="editor">
                                    <form enctype="multipart/form-data" action="" method="post" accept-charset="utf-8">
                                        <%--Added By Vidya Jadhav ON 18 Oct 2017 To show Guidelines--%>
                                       
                                         <div id="divGuidelines">
                                        </div>
                                        
                                        <%--End Of Added By Vidya Jadhav ON 18 Oct 2017 To show Guidelines--%>
                                        <div class="form-group">
                                            <label for="subject">Subject *</label>
                                            <%=CommonFunctions.HTMLControls.DrawTextBox("txtsubject", "txtsubject", "form-control", , , , , , False, , , , "PlaceHolder='Enter Subject (Maxlength 100 Chars)'", True, , , , , , True)%>
                                        </div>
                                        <div class="form-group">
                                            <label for="subject">Description </label>
                                            <%=CommonFunctions.HTMLControls.DrawTextArea("txtEditor", "txtEditor", , "form-control", , , , , , , , , , , , , , , "PlaceHolder='Enter Description (Maxlength 1000 Chars)' maxlength=''", True, , , , , , , , , )%>
                                        </div>

                                        <%-- <div class="form-group" style="display: flex; margin-bottom: 0;">
                                            <label for="subject" style="float: left; padding-right: 10px;">Cc</label>
                                            <%=CommonFunctions.HTMLControls.DrawTextBox("cc", "cc", "form-control", , , , , , False, , , , "PlaceHolder='Enter Email ID' onblur=ValidateEmailID1()", True, , , , , , True)%>
                                        </div>--%>
                                        <!--	<button type="submit" class="btn btn-default attch"><i class="fa fa-paperclip" aria-hidden="true"></i>Attachment</button> -->

                                        <div class="attacment-file">
                                            <div class="form-group">
                                                <%--  <input type="file" id="file"  name="img[]" class="file">--%>
                                                <div id="FileControlUploadDiv">
                                                    <%=CommonFunctions.HTMLControls.DrawFileControl("txtFileName0", "txtFileName0", , 74, , , , , , "onkeydown='return false;' onbeforepaste='return false;' onpaste='return false;' onchange='addFileinGrid()' style='display:none !important;' class='clsFileControl'", False,True)%>
                                                </div>
                                                <div class="input-group col-sm-12 pl-0">
                                                    <%--      <input type="text" class="form-control input-lg" disabled placeholder="attacment files">--%>
                                                    <span class="input-group-btn">
                                                        <button class="browse btn btn-primary input-lg" id="btnSelectFile" filecount="0" onclick="SelectFile();" type="button" style="width: 106px!important; height: 33px!important" title="Add Attachments"><i class="fa fa-paperclip" aria-hidden="true" title="Add Attachments"></i>   Attachment</button>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <button type="button" class="btn btn-default save" onclick="clearControls()" title="Clear">Clear</button>
                                        <button type="button" id="btnSave" onclick="SaveRequest_OnClick()" class="btn btn-default save" title="Save">Save</button>

                                        <%-- End of Added By Vidya Jadhav on 27th-Oct-2017 for Attachment CHanges --%>
                                    </form>
                                    <div id="divAttachments" class="bottom-bar" style="">

                                        <table id="tblFiles" style="display: none; width: 100%; margin-top: 1%" class="clsGridTable table">
                                            <thead class="clsTRColumnHeader" align="left">
                                                <tr>
                                                    <th></th>
                                                    <th>Files</th>
                                                    <th>Comments</th>
                                                    <%If HttpContext.Current.Session("LoginType").ToString = "E" Then%>
                                                    <th>Document Status(Checked if internal)</th>
                                                    <%End If%>
                                                    <th>Remove</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="request-detail">
                                <div class="detail-inner">
                                    <h2>Request Details</h2>

                                    <div class='row'>
                                        <div class='form-group' style="display:block">
                                            <button type='button' class='btn updtae-btn' id='btnBacknew' onclick="BackNewRequest_OnClick()" data-toggle='tooltip' title='Back'>Back</button>

                                        </div>
                                    </div>
                                    <form action="/action_page.php" id="frmRequest" class="req-del-from">
                                        <%--<div class="row">
								<div class="form-group">
									<div class="col-sm-6">
									  <label for="sel1">Request Type</label>--%>
                                        <%-- <select class="form-control" id="sel1">
										<option>Request Type</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>--%>

                                        <%--<%=CommonFunctions.HTMLControls.DrawComboBox("CboRequestType", "Select 'Request Type'", , , "class='form-control' onchange=RequestType_OnChange(this)", False, True)%>--%>

                                        <%--		</div>
									  <div class="col-sm-6">
									  <label for="sel1">Request sub-Type</label>--%>
                                        <%-- <select class="form-control" id="Select1">
										<option>Request sub-Type</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>--%>
                                        <%--<%=CommonFunctions.HTMLControls.DrawComboBox("CboSubRequestType", "Select 'Sub Request Type'", , , "class='form-control' onchange=SubRequestType_OnChange(this)", False, True)%>--%>
                                        <%--</div>
								</div>
							</div>--%>

                                        <%PageInit("Load", "0", "0", "E")%>

                                        <%--<div class="row">
								<div class="form-group">
                                      <%If UCase(Trim(m_strMode & "")) = "EDIT" Then%>
									<div class="col-sm-6">
									  <label for="sel1">Status</label>--%>
                                        <%-- <select class="form-control" id="Select2">
										<option>Status</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>--%>


                                        <%--   <%If blnDisableStatusCombo Then%>
                                              <%=CommonFunctions.HTMLControls.DrawComboBox("CboStatus", "usp_CRM_Get_RequestStatus 0," & Session("intPostID") & "", , , "class='form-control'   disabled  ", False, True)%>
                                        <%Else%>
                                            <%=CommonFunctions.HTMLControls.DrawComboBox("CboStatus", "usp_CRM_Get_RequestStatus 0," & Session("intPostID") & "", , , "class='form-control'", False, True)%>
                                            <%m_StatusFlowCount = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatusFlowCount 0", True), "0"), Integer)%>

                       
                                        <%=CommonFunctions.HTMLControls.DrawTextBox("StatusFlowCount", "StatusFlowCount", , , , m_StatusFlowCount.ToString, IsHidden:=True, EnableHTMLEncode:=True)%>
                                        --%>
                                        <%--<%Dim strOldStatus As String = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatus " + CType(intStatusID, String), MyBase.UseSQL), "0"), String)%>--%>

                                        <%--<%=CommonFunctions.HTMLControls.DrawTextBox("txtOldStatus", "txtOldStatus", , , , strOldStatus, IsHidden:=True, EnableHTMLEncode:=True)%>--%>

                                        <%--  <%=CommonFunctions.HTMLControls.DrawComboBox("CmbStatus", "Exec usp_CRM_ValidateCRMStatus '" + m_lngSubRequestTypeID.ToString + "',2,'" + strOldStatus + "'", DisplayNone:=True)) '--, displaynone:=True)%>
                                        <%=CommonFunctions.HTMLControls.DrawComboBox("CmbPrevStatus", "Exec usp_CRM_ValidateCRMStatus '" + m_lngSubRequestTypeID.ToString + "'," + "1", DisplayNone:=True)) ', displaynone:=True%>--%>

                                        <%--                                        <%End If%>--%>

                                        <%--  </div>--%>
                                        <%--  
                                     <%End If%>
									  <div class="col-sm-6">
									  <label for="sel1">Assigned To</label>
									  <select class="form-control" id="Select3">
										<option>Assigned To</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>
									</div>
									<div class="col-sm-6">
									  <label for="sel1">Priority</label>--%>
                                        <%-- <select class="form-control" id="Select4">
										<option>Priority</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>--%>

                                        <%--    <%=CommonFunctions.HTMLControls.DrawComboBox("CboPriority", "usp_CRM_Get_RequestPriority", , , "class='form-control'", False, True)%>
                                        
									</div>
								</div>
							</div>
                                        --%>
                                        <%--	<div class="row">
								<div class="form-group">
									<div class="col-sm-6">
									  <label for="sel1">Project</label>
									  <select class="form-control" id="Select5">
										<option>Project</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>
									</div>--%>
                                        <%-- <% If ShowProductCombo = "1" Then %> 
							<div class="col-sm-6">
							<label for="sel1">Product</label>--%>
                                        <%--  <select class="form-control" id="Select6">
										<option>Product</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>--%>
                                        <%--                 
                            <%If (m_intCustomer = 0 And m_strLoginType = "E") Then %> 
                                <%=CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_sel_Tbl_PRD_ProductVersion_ProductVersionID_Product", , , "class='form-control' onchange=Product_OnChange(this) ", False, True)%>
                            <%ElseIf m_strLoginType = "C" Then %> 
                               <%=CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "',NULL" + ", NULL", , , "class='form-control' onchange=Product_OnChange(this) ", False, True)%>
                            <%ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then%> 
                               <%=CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "',NULL" + ",NULL", , , "class='form-control' onchange=Product_OnChange(this) ", False, True)%>
                            <%End If%>
                            </div>--%>

                                        <%--    <div class="col-sm-6">
							    <label for="sel1">Module/Component</label>--%>
                                        <%-- <select class="form-control" id="Select7">
							    <option>Module/Component</option>
							    <option>2</option>
							    <option>3</option>
							    <option>4</option>
							    </select>--%>

                                        <%--  <% If (m_intCustomer = 0 And m_strLoginType = "E") Then%> 
                                <%=CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Select 'Module/Component'", , , "class='form-control' ", False, True)%>
                        
                                <% ElseIf m_strLoginType = "C" Then%>
                                <%=CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Select 'Module/Component'", , , "class='form-control' ", False, True)%>
                                <% ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then%>
                                <%=CommonFunctions.HTMLControls.DrawComboBox("CboModuleComponent", "Select 'Module/Component'", , , "class='form-control' ", False, True)%>

                                <% End If%>--%>
                                        <%--  </div>--%>

                                        <%--  <%End If%>

									<div class="col-sm-6">
									  <label for="sel1">Department</label>--%>
                                        <%-- <select class="form-control" id="Select8">
										<option>Department</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>--%>
                                        <%--   <%=CommonFunctions.HTMLControls.DrawComboBox("CboDepartment", "usp_CRM_GetFunctions_ForRole " & Session("intPostID") & ", null ", , , "class='form-control' onchange=Department_OnChange(this)", False, True)%>--%>
                                        <%--</div>
									<div class="col-sm-6">
									  <label for="sel1">Organization Type</label>--%>
                                        <%-- <select class="form-control" id="Select9">
										<option>Organization Type</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>--%>
                                        <%--  <%=CommonFunctions.HTMLControls.DrawComboBox("CboLocation", "usp_sel_Active_Organisation_Units 0", , , "class='form-control' ", False, True)%>--%>
                                        <%--           
									</div>
								</div>
							</div>
                                        --%>
                                        <%--	<div class="row">
								<div class="form-group">
									<div class="col-sm-6">
									  <label for="sel1">Time Zone</label>
									  <select class="form-control" id="Select10">
										<option>Time Zone</option>
										<option>2</option>
										<option>3</option>
										<option>4</option>
									  </select>
									</div>
								</div>
							</div>--%>

                                        <%--	<div class="cust-file"><h5>Custom Field</h5></div>
                            <div class="cust-file" id="divCustomField">
						 						
							</div>--%>
                                        
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>

            <!-- /.container-fluid -->

        </div>
        <!-- /.content-wrapper -->
    </div>
    
</body>


    <script id="CustomValidation" type="text/javascript"></script>
<!-- Bootstrap core JavaScript -->
    <!-- <script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
    <script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/jQueryUI/jquery-ui-1.13.2.min.js"></script>
    <script src="../../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script> -->
    <script src="../../../Whizible2.0-new/dist/js/editor.js"></script>
    <!-- <script src="../../General/CommonFunctions.js"></script>
    <script src="../../General/CommonValidations.js"></script> -->

<script>
   
    
    
    //Added By Rehan C To add Validator for Special characters on 27th Dec 2022
    var WebConfigSpecialCharacters = '<%=System.Configuration.ConfigurationManager.AppSettings("SpecialCharactersList").ToString%>'
    //End Of Comment By Rehan C
    var ShowProductCombo;
    document.getElementById('hdnCustomerID').value = "0";
    document.getElementById('hdnEmployeeID').value = "0"
    $(document).ready(function () {
        //  debugger;
        
      
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
        //if (document.getElementById('idselect').innerHTML == "Select")
        //{
        //     alertify.set('notifier', 'position', 'top-right');
        //     alertify.notify('Please select Requestor', 'error');
        //     return;
        //}
        //$("#dtExpResdate").datepicker();
        
    });


  
    function window_onload() {
        setTimeout(function () { document.getElementById('CboDepartment').onchange(); }, 1000);

        //     document.getElementById('CboDepartment').onchange();
        //   document.getElementById('hdnUserName').value = '<%=m_strUserName%>';
        //  document.getElementById('hdnLoginType').value = '<%=m_strLoginType%>';
        //  document.getElementById('hdnCEmployeeID').value = '<%=m_lngEmployeeID%>';
        strLoginType = '<%=m_strLoginType%>';
        //  strUserName = document.getElementById('hdnUserName').value;
        //   alert(strLoginType);
        if (strLoginType == "C") {
            document.getElementById('idEmployee').style.display = "none";
            // document.getElementById('idSelf').style.display = "none";
            document.getElementById('idSelf').style.display = "block";
            $("#idCustomer").addClass("init");
            //$("#idCustomer").val("Self");
            $('#ulCustomer  li#' + '<%=m_lngEmployeeID%>').click();
            $('#ulEmployee  li#' + '<%=m_lngEmployeeID%>').click();
            $("#idEmployee").css("display", "none");
            document.getElementById('idSelf').innerHTML = "";
            document.getElementById('idSelf').innerHTML = "Self";
            document.getElementById('idCustomer').style.display = "none";
            document.getElementById('idSelf').disabled == "true";
            $("#idSelf").css('cursor', 'not-allowed');

            //document.getElementById('idRequestorName').value = document.getElementById('idCustomer').innerHTML;
            document.getElementById('idRequestorName').value = document.getElementById('idCustomer').innerHTML;
            // alert(document.getElementById('idCustomer').innerHTML);
        }
        else {
            // document.getElementById('idRequestorName').value = "Self";
            document.getElementById('idRequestorName').value = '<%=Session("strUserName")%>'
            // debugger;

            if ('<%=blnIsHRM%>' == '0') {
                // $("#idSelf").unbind("click");
                //$('#idSelf').off('click');
                $('#idSelf').prop('onclick', null).off('click');
                document.getElementById('idEmployee').style.display = "none";

                document.getElementById('idSelf').style.display = "block";
                $("#idCustomer").addClass("init");
                $("#idCustomer").val("Self");

                $("#idSelf1").css("display", "none");
                // document.getElementById('idSelf').innerHTML = "";
                // document.getElementById('idSelf').innerHTML = "Self";
                document.getElementById('idCustomer').style.display = "none";
                document.getElementById('idEmployee').style.display = "none";
                document.getElementById('idSelf').disabled == "true";
                $("#idSelf").css('cursor', 'not-allowed');


            }
        }
    }

    function Department_OnChange(obj) {
        // ClearSpan('DcboDepartmentSQL', 'spanDepartment')
        var url = "CRM_AddNewRequest.aspx/GetRequestType"

        //Commented And Added By Usha Pandit On 15.10.2020 For Clear button functionality issue
        //DepartmentID = obj.value;
        if (obj != null) {
            DepartmentID = obj.value;
        }
        else {
            DepartmentID = 0;
        }
        //End Of Added By Usha Pandit On 15.10.2020 For Clear button functionality issue

        var CustomerID = 0;
        var EmployeeID = 0;
        CustomerID = document.getElementById('hdnCustomerID').value;
        EmployeeID = document.getElementById('hdnEmployeeID').value;

        data = JSON.stringify({ TypeID: DepartmentID, WhichList: 'RequestType', RequestTypeID: '', CustomerID: CustomerID, EmployeeID: EmployeeID });

        CustomAJAXCall(url, data, BindDropDownRequestType);
    }

    function BindDropDownRequestType(result) {

        var strArray = String(result.d).split("|")

        var objDepartmentID = document.getElementById('CboDepartment');
        var i = 0;

        document.getElementById('frmRequest').innerHTML = ""
        document.getElementById('frmRequest').innerHTML = strArray[2];


        // alert(objCbo.value);

        var objCbo = document.getElementById("CboRequestType");
        objCbo.innerHTML = "";
        insBlankOpt(objCbo);
        $.each(JSON.parse(strArray[0]), function (id, obj) {
            var objOption = document.createElement("OPTION");
            objCbo.options.add(objOption);
            objOption.text = obj.RequestType;
            objOption.value = obj.RequestTypeID;
        });

        //   alert(objCbo.options.length)

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

    function RequestType_OnChange(obj) {

        var url = "CRM_AddNewRequest.aspx/GetRequestType"
        RequestTypeID = obj.value;
        //     alert(RequestTypeID);
        var CustomerID = 0;
        var EmployeeID = 0;
        CustomerID = document.getElementById('hdnCustomerID').value;
        EmployeeID = document.getElementById('hdnEmployeeID').value;
        data = JSON.stringify({ TypeID: DepartmentID, WhichList: 'SubRequestType', RequestTypeID: RequestTypeID, CustomerID: CustomerID, EmployeeID: EmployeeID });
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

        var url = "CRM_AddNewRequest.aspx/GetModuleOrComponent"
        var ProductID = obj.value;
        data = JSON.stringify({ ProductID: ProductID });
        CustomAJAXCall(url, data, BindDropdownModule);
    }

    function BindDropdownModule(result) {

        var strArray = String(result.d).split("|")
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

    function NewAJAXCall(url, data, method) {
        $.ajax({
            type: "GET",
            url: url,
            async: false,
            success: function (result) {
                console.log(result);
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

    function SubRequestType_OnChange(obj)
    {
        //var url = "CRM_AddNewRequest.aspx/PlotCustomFields"
        //var DepartmentID = document.getElementById('CboDepartment').value;
        //var RequestTypeID = document.getElementById('CboRequestType').value;
        //var CustomerID = 0;
        //var EmployeeID = 0;
        //CustomerID = document.getElementById('hdnCustomerID').value;
        //EmployeeID = document.getElementById('hdnEmployeeID').value;
        //SubRequestTypeID = obj.value;
        //data = JSON.stringify({ DepartmentID: DepartmentID, RequestTypeID: RequestTypeID, SubRequestTypeID: SubRequestTypeID, CustomerID: CustomerID });
        //CustomAJAXCall(url, data, PlotCustomFieldSuccess);


        
        var DepartmentID = document.getElementById('CboDepartment').value;
        var RequestTypeID = document.getElementById('CboRequestType').value;
        var CustomerID = 0;
        var EmployeeID = 0;
        CustomerID = document.getElementById('hdnCustomerID').value;
        EmployeeID = document.getElementById('hdnEmployeeID').value;
        SubRequestTypeID = obj.value;
        var url = "CRM_AddNewRequest.aspx?Mode=CustomField&SubRequestTypeID=" + SubRequestTypeID + "&RequestTypeID=" + RequestTypeID + "&DepartmentID=" + DepartmentID + "&CustomerID=" + CustomerID + ""
        data = JSON.stringify({ DepartmentID: DepartmentID, RequestTypeID: RequestTypeID, SubRequestTypeID: SubRequestTypeID, CustomerID: CustomerID });
        NewAJAXCall(url, data, PlotCustomFieldSuccess);


        // /*Added by Yasmin on 12th July for Custome field change*/
        $("#CustomFieldTextArea1").removeClass("clsTextArea");
        $("#CustomFieldTextArea1").addClass("form-control");
        $("#CustomFieldCombo10").removeClass("clsComboBox");
        $("#CustomFieldCombo10").addClass("form-control");
        
        // /*Added By Yasmin on 16th July*/
        $("#CustomFieldText1").removeClass("clsTextBox ");
        $("#CustomFieldText1").addClass("form-control");
        $("#CustomFieldCombo3").removeClass("clsTextBox ");
        $("#CustomFieldCombo3").addClass("form-control");
        $("#CustomFieldNumeric1").removeClass("clsTextBox ");
        $("#CustomFieldNumeric1").addClass("form-control");
        $("#CustomFieldCombo9").removeClass("clsTextBox ");
        $("#CustomFieldCombo9").removeClass("clsComboBox ");
        $("#CustomFieldCombo1").removeClass("clsTextBox ");
        $("#CustomFieldCombo1").addClass("form-control");
        $("#CustomFieldCombo2").removeClass("clsTextBox ");
        $("#CustomFieldCombo2").addClass("form-control");
        $("#CustomFieldCombo4").removeClass("clsTextBox ");
        $("#CustomFieldCombo4").addClass("form-control");
        $("#CustomFieldCombo5").removeClass("clsTextBox ");
        $("#CustomFieldCombo5").addClass("form-control");
        $("#CustomFieldCombo6").removeClass("clsTextBox ");
        $("#CustomFieldCombo6").addClass("form-control");
        $("#CustomFieldCombo7").removeClass("clsTextBox ");
        $("#CustomFieldCombo7").addClass("form-control");
        $("#CustomFieldCombo8").removeClass("clsTextBox ");
        $("#CustomFieldCombo8").addClass("form-control");
        $("#CustomFieldDate2").removeClass("clsTextBox ");
        $("#CustomFieldDate2").addClass("form-control");
        $("#CustomFieldDate3").removeClass("clsTextBox ");
        $("#CustomFieldDate3").addClass("form-control");
        $("#CustomFieldDate4").removeClass("clsTextBox ");
        $("#CustomFieldDate4").addClass("form-control");
        $("#CustomFieldDate5").removeClass("clsTextBox ");
        $("#CustomFieldDate5").addClass("form-control");
        $("#CustomFieldNumeric2").removeClass("clsTextBox ");
        $("#CustomFieldNumeric2").addClass("form-control");
        $("#CustomFieldNumeric3").removeClass("clsTextBox ");
        $("#CustomFieldNumeric3").removeClass("clsTextBox ");
        $("#CustomFieldNumeric4").addClass("form-control");
        $("#CustomFieldNumeric4").removeClass("clsTextBox ");
        $("#CustomFieldNumeric5").addClass("form-control");
        $("#CustomFieldNumeric5").removeClass("clsTextBox ");
        $("#CustomFieldText10").addClass("form-control");
        $("#CustomFieldText10").addClass("form-control");
        $("#CustomFieldText2").removeClass("clsTextBox ");
        $("#CustomFieldText2").addClass("form-control");
        $("#CustomFieldText3").removeClass("clsTextBox ");
        $("#CustomFieldText3").addClass("form-control");
        $("#CustomFieldText4").removeClass("clsTextBox ");
        $("#CustomFieldText4").addClass("form-control");
        $("#CustomFieldText5").removeClass("clsTextBox ");
        $("#CustomFieldText5").addClass("form-control");
        $("#CustomFieldText6").removeClass("clsTextBox ");
        $("#CustomFieldText6").addClass("form-control");
        $("#CustomFieldText7").removeClass("clsTextBox ");
        $("#CustomFieldText7").addClass("form-control");
        $("#CustomFieldText8").removeClass("clsTextBox ");
        $("#CustomFieldText8").addClass("form-control");
        $("#CustomFieldText9").removeClass("clsTextBox ");
        $("#CustomFieldText9").addClass("form-control");
        $("#CustomFieldTextArea2").removeClass("clsTextBox ");
        $("#CustomFieldTextArea2").addClass("form-control");
        $("#CustomFieldTextArea3").removeClass("clsTextBox ");
        $("#CustomFieldTextArea3").addClass("form-control");

        //Added by Usha Pandit on 27 July 2018 for Custom field date calender selection on date field click
        $(".clsDateControl").each(function (id, val) {
            $(this).datepicker().on('show', function (e) {               
                if ($(this).val().length > 0) {
                    $(this).datepicker('update', new Date($(this).val()));
                }
            });
        })

        //$(".clsCustomField").removeClass("form-control");
        $('*[id*=CustomFieldCombo]').addClass("clsCustomField");
        //$('*[id*=CustomFieldDate]').removeClass("form-control");
        //End of Added by Usha Pandit on 27 July 2018 for Custom field date calender selection on date field click

       
    }

    //Added by Usha Pandit on 02 Aug 2018 for Custom field date calender selection on date field click

    function disallowValueRangeViolation(obj, minVal, maxVal) {
        if (obj == null) { return false; }
        if (isBlank(getInputValue(obj))) { return false; }
        var msg = (arguments.length > 3) ? arguments[3] : "";
        msg = replaceSubstring(msg, "&#39;", "'");
        var dofocus = (arguments.length > 4) ? arguments[4] : true;
        var minInclusive = (arguments.length > 5) ? arguments[5] : true;
        var maxInclusive = (arguments.length > 6) ? arguments[6] : true;
        if (disallowNonNumeric(obj, msg, dofocus)) { return true; }
        else if (disallowMinValueViolation(obj, minVal, "", dofocus, minInclusive) || disallowMaxValueViolation(obj, maxVal, "", dofocus, maxInclusive)) {
            //if (!isBlank(msg)) { alert(msg); }
            if (dofocus) {
                setFocus(obj);
            }
            return true;
        }
        return false;
    }

    function disallowNonNumeric(obj) {
        if (obj == null) { return false; }
        if (isBlank(getInputValue(obj))) { return false; }
        var msg = (arguments.length > 1) ? arguments[1] : "";
        msg = replaceSubstring(msg, "&#39;", "'");
        var dofocus = (arguments.length > 2) ? arguments[2] : true;
        if (!isNumeric(getInputValue(obj))) {
            //if (!isBlank(msg)) { alert(msg); }
            if (dofocus) {
                setFocus(obj);
            }
            return true;
        }
        return false;
    }

    function disallowMinValueViolation(obj, minVal) {
        if (obj == null) { return false; }
        if (isBlank(getInputValue(obj))) { return false; }
        var msg = (arguments.length > 2) ? arguments[2] : "";
        msg = replaceSubstring(msg, "&#39;", "'");
        var dofocus = (arguments.length > 3) ? arguments[3] : true;
        var inclusive = (arguments.length > 4) ? arguments[4] : true;
        if (disallowNonNumeric(obj, msg, dofocus)) { return true; }
        else if (((inclusive == true) && (parseFloat(getInputValue(obj)) < parseFloat(minVal))) || ((inclusive == false) && (parseFloat(getInputValue(obj)) <= parseFloat(minVal)))) {
            //if (!isBlank(msg)) { alert(msg); }
            if (dofocus) {
                setFocus(obj);
            }
            return true;
        }
        return false;
    }

    function disallowMaxValueViolation(obj, maxVal) {
        if (obj == null) { return false; }
        if (isBlank(getInputValue(obj))) { return false; }
        var msg = (arguments.length > 2) ? arguments[2] : "";
        msg = replaceSubstring(msg, "&#39;", "'");
        var dofocus = (arguments.length > 3) ? arguments[3] : true;
        var inclusive = (arguments.length > 4) ? arguments[4] : true;
        if (disallowNonNumeric(obj, msg, dofocus)) { return true; }
        else if (((inclusive == true) && (parseFloat(getInputValue(obj)) > parseFloat(maxVal))) || ((inclusive == false) && (parseFloat(getInputValue(obj)) >= parseFloat(maxVal)))) {
            //if (!isBlank(msg)) { alert(msg); }
            if (dofocus) {
                setFocus(obj);
            }
            return true;
        }
        return false;
    }

    //End of Added by Usha Pandit on 02 Aug 2018 for Custom field date calender selection on date field click

    var resultArr,Results;
    function PlotCustomFieldSuccess(result)
    {
         
        //document.getElementById('divCustomField').innerHTML = "";
        //document.getElementById('divCustomField').innerHTML = result;
        //alert(result);
        
        resultArr = result.split("####");
        document.getElementById('divCustomField').innerHTML = "";
        document.getElementById('divCustomField').innerHTML = resultArr[0];//Plotting

        document.getElementById('divGuidelines').innerHTML = "";
        document.getElementById('divGuidelines').innerHTML = resultArr[1];//Guidlines

        //Added by Usha Pandit on 31 July 2018 for plotting custom field validation function dynamically
        $("#divGuidelines").html(resultArr[1]);       
        //End of Added by Usha Pandit on 31 July 2018 for plotting custom field validation function dynamically

        var WholeScript = '';
     
       
       
       
      
        //var e = document.getElementById('MainScript');
        //WholeScript += resultArr[2];
        //if (e != null)
        //    e.innerHTML = '';
     
        //var script = "document.getElementById('btnSave').onclick = " + WholeScript + ""
       
        ////var script = "$('#btnSave').click(function (){  " + WholeScript + " SaveRequest_OnClick();  });"
        // var newsc = script;
        ////  alert(newsc);
        //if (e != null)
        //    e.innerHTML = newsc;
        ////  alert(e.innerHTML);
        //if (e != null)
        //    $.globalEval(e.innerHTML);

    }
 
   
    // var fileObject = ""
    //  var fileObjects=""
    //$(document).on('click', '.browse', function () {
    // //   debugger;
    //    var file = $(this).parent().parent().parent().find('.file');

    //    file.trigger('click');
    //});

    //    $(document).on('change', '.file', function () {
    ////   debugger;
    //        $(this).parent().find('.form-control').val($(this).val().replace(/C:\\fakepath\\/i, ''));
    //       // fileObjects = fileObject[0];

    //          fileObject = $("#file")[0].files;

    //    });

//document.getElementById('btnSave').onclick = 

      

//function ValidateCustomFields(){


//    if(objCustomFieldCombo1 != null) 
//    { 
//        if(objCustomFieldCombo1.disabled == false) 
//        { 
//            if(disallowBlank(objCustomFieldCombo1)== true){
//                alertify.set('notifier', 'position', 'top-right');
//                alertify.notify('Combo box should not be left blank.', 'error');
//                return;
//                setFocus(objCustomFieldCombo1);
//                return false;
//            }
//        } 
//    } 
//    if(objCustomFieldCombo1 != null) 
//    { 
//        if(objCustomFieldCombo1.disabled == false) 
//        { 
//            if(disallowMaxlengthViolation(objCustomFieldCombo1)==true){
//                alertify.set('notifier', 'position', 'top-right');
//                alertify.notify('Max Length of Combo box is <LENGTH> characters.\r\nYou have entered <L> characters.', 'error');
//                return;
//                objCustomFieldCombo1.value = Left(Trim(objCustomFieldCombo1.value), 100);
//                setFocus(objCustomFieldCombo1);
//                return false;
//            }
//        } 
//    } 
//    if(objCustomFieldCombo1 != null) 
//    { 
//        if(objCustomFieldCombo1.disabled == false) 
//        { 
//            if(disallowBlank(objCustomFieldCombo1)== true){
//                alertify.set('notifier', 'position', 'top-right');
//                alertify.notify('Combo box should not be left blank.', 'error');
//                return;
//                setFocus(objCustomFieldCombo1);
//                return false;
//            }
//        } 
//    } 
//    if(objCustomFieldCombo1 != null) 
//    { 
//        if(objCustomFieldCombo1.disabled == false) 
//        { 
//            if(disallowMaxlengthViolation(objCustomFieldCombo1)==true){
//                alertify.set('notifier', 'position', 'top-right');
//                alertify.notify('Max Length of Combo box is <LENGTH> characters.\r\nYou have entered <L> characters.', 'error');
//                return;
//                objCustomFieldCombo1.value = Left(Trim(objCustomFieldCombo1.value), 100);
//                setFocus(objCustomFieldCombo1);
//                return false;
//            }
//        } 
//    } 



//    return true;
//}



   


    
    function ValidateRequestDetails(){
        var checkvalue = 0;
        var Flag = 0;
        var strmsg = "";
        var errorMsg = "<ul>"
        var DepartmentID = document.getElementById('CboDepartment');
        var RequestType = document.getElementById('CboRequestType');
        var SubRequestType = document.getElementById('CboSubRequestType');
        var expdateresol = document.getElementById('dtExpResdate');
        //Added by Rehan C
        var Subject = $("#txtsubject").val();
        var Description = $("#txtEditor").val();
        //Added by Usha Pandit on 14.03.2019 for exp. date of resolution validation
        var dtExpResdatevalidformat = '';
        var dtcurrentdatevalidformat = '';
        if ($("#dtExpResdate") != undefined) {
            if ($("#dtExpResdate") != null) {
                if ($("#dtExpResdate").val() != undefined) {
                   // alert($("#dtExpResdate").val());
                   // alert($("#CurrentDate1").val());
                    dtExpResdatevalidformat = $("#dtExpResdate").val().toString().replace(/\./g, '/');
                    if ($("#CurrentDate1").val() != undefined) {
                        dtcurrentdatevalidformat = $("#CurrentDate1").val().toString().replace(/\./g, '/');
                    }
                }
            }
        }
      
        //var d = new Date();

        //var month = d.getMonth() + 1;
        //var day = d.getDate();

        //var output = d.getFullYear() + '/' +
        //    (month < 10 ? '0' : '') + month + '/' +
        //    (day < 10 ? '0' : '') + day;      

        var Browser = WhichBrowser();
        if ($("#dtExpResdate") != undefined) {
            if ($("#dtExpResdate") != null) {
                if ($("#dtExpResdate").val() != undefined) {
                    if (Browser == "FF" || Browser == "IE" || Browser == "CR") {

                        //if (Date.parse(dtExpResdatevalidformat.replace(/-/g, ' ')) < Date.parse(output.replace(/-/g, ' '))) {

                        //    strmsg = '- Please enter exp. date of resolution greater than or equal to current date';
                        //    errorMsg += "<li>" + strmsg + "</li>";
                        //    checkvalue = 1;
                        //}
                        if (Date.parse(dtExpResdatevalidformat.replace(/-/g, ' ')) < Date.parse(dtcurrentdatevalidformat.replace(/-/g, ' '))) {
                            strmsg = '- Please enter exp. date of resolution greater than or equal to current date';
                            errorMsg += "<li>" + strmsg + "</li>";
                            checkvalue = 1;
                        }
                    }
                }
            }
        }

        //End of Added by Usha Pandit on 14.03.2019 for exp. date of resolution validation

        //Commented And Added By Usha Pandit On 23.04.2021 For blank subject save issue
        //if ($("#txtsubject").val() == "") {
        if ($("#txtsubject").val().trim() == "") {
            //End Of Added By Usha Pandit On 23.04.2021 For blank subject save issue
            //alertify.set('notifier', 'position', 'top-right');
            //alertify.notify('Please enter subject', 'error');
            strmsg = '- Subject should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            //   alertify.notify('Employee Code Already Exists', 'error');
            checkvalue = 1;

        }
        //Added By Rehan C To add Validator for Special characters validation on 27th Dec 2022
        if (checkSpecialCharacter(Subject, WebConfigSpecialCharacters) == true) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('Subject should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            $("#txtsubject").focus();
            checkvalue = 1;
        }
        //End of the Comment by Rehan C


        if ($("#txtsubject").val() != "") {

            if ($("#txtsubject").val().length > 100) {
                //Commented & Added By Dipali V On 4th Dec 2020 For lenght issue
               // if ($("#txtsubject").val().length > 1000) {
                //strmsg = '- Subject length should not be greater than 1000 characters ';
                 strmsg = '- Subject length should not be greater than 100 characters ';
                errorMsg += "<li>" + strmsg + "</li>";
                //   alertify.notify('Employee Code Already Exists', 'error');
                checkvalue = 1;

            }

        }

        if ($("#txtEditor").val() != "") {

            if ($("#txtEditor").val().length > 1000) {
                strmsg = '- Description length should not be greater than 1000 characters';
                errorMsg += "<li>" + strmsg + "</li>";
                //   alertify.notify('Employee Code Already Exists', 'error');
                checkvalue = 1;

            }


        }
        //Added By Rehan C To add Validator for Special characters validation on 27th Dec 2022
        if (checkSpecialCharacter(Description, WebConfigSpecialCharacters) == true) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('Description should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            $("#txtEditor").focus();
            checkvalue = 1;
        }
        //End of the Comment by Rehan C

        if ($("#CboDepartment").val() == "") {
            strmsg = '- Department should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            //   alertify.notify('Employee Code Already Exists', 'error');
            checkvalue = 1;
        }
        if ($("#CboRequestType").val() == "") {
            strmsg = '- Request Type should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            //   alertify.notify('Employee Code Already Exists', 'error');
            checkvalue = 1;
        }
        if ($("#CboSubRequestType").val() == "") {
            strmsg = '- Sub Request Type should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            //   alertify.notify('Employee Code Already Exists', 'error');
            checkvalue = 1;
        }
        if ($("#CboPriority").val() == "") {
            //Commented and Added by Usha Pandit on 04.04.2019 for Priority/Severity display issue
            strmsg = '- Priority should not be left blank';
            //strmsg = '- Severity should not be left blank';
              //End of Added by Usha Pandit on 04.04.2019 for Priority/Severity display issue
            errorMsg += "<li>" + strmsg + "</li>";
            //   alertify.notify('Employee Code Already Exists', 'error');
            checkvalue = 1;
        }
        if ($("#CboLocation").val() == "") {
            strmsg = '- Organization Unit should not be left blank';
            errorMsg += "<li>" + strmsg + "</li>";
            //   alertify.notify('Employee Code Already Exists', 'error');
            checkvalue = 1;
        }

        if ($("#dtExpResdate") != undefined) {
            if ($("#dtExpResdate").val() == "") {
                strmsg = '- Exp. Date of Resolution should not be left blank';
                errorMsg += "<li>" + strmsg + "</li>";
                //   alertify.notify('Employee Code Already Exists', 'error');
                checkvalue = 1;
            }
        }

        if (strmsg != "") {           
            alertify.set('notifier', 'position', 'top-right');
            alertify.notify(errorMsg, 'error', 5);
            checkvalue = 1;
        }
        $("#FileControlUploadDiv [type=file]").each(function (j, val) {
            if ($(this)[0].files.length != 0) {
                fileObject[(j)] = $(this)[0].files;
            }
        })
        //for (var j = 0; j < tblFiles.rows.length - 1; j++) {
        //    if ($("#txtFileName" + j)[0] != undefined)
        //        fileObject[j] = $("#txtFileName" + j)[0].files;
        //}
        var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
        var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>'
        var validateExtensions = strFileExtension.split(",");

        for (var i = 0; i < fileObject.length; i++) {
            if (fileObject[i].length > 0) {
                var allowSubmit = false;
                var intActualFileSize = (fileObject[i][0].size);
                //formData.append("TxtComment_" + [i], document.getElementById('txtComments' + [i]).value);
                // formData.append("Internal_" + [i], 1);
                if (intActualFileSize < intMinFileSize) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify('File size should be greater than or equal to ' + intMinFileSize + ' bytes !', 'error', 25);
                    checkvalue = 1;
                }
                var file = fileObject[i][0].name;
                var extension = file.slice(file.lastIndexOf('.') + 1).toLowerCase();
                for (var cnt = 0; cnt < validateExtensions.length ; cnt++) {
                    var strExtn;
                    strExtn = validateExtensions[cnt];
                    if (strExtn.toLowerCase() == extension)
                    { allowSubmit = true; }
                }
                if (allowSubmit == false) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.notify("Only files with extensions " + (validateExtensions.join(", ", "").toUpperCase()) + " are  allowed!!!", 'error', 25);
                    checkvalue = 1;
                }
            }
        }


        return checkvalue;

    }

   //Added By Reshma Chavan on 24 Feb 2021 For alert issue date comparision
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

    //End of Commented And Added By Reshma Chavan on 24 Feb 2021 For alert issue date 




    //Added by Usha Pandit on 31 July 2018 for plotting custom field validation function dynamically
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



    //End of Added by Usha Pandit on 31 July 2018 for plotting custom field validation function dynamically
    function SaveRequest_OnClick()
    {
        var tcount = 0;
        //Added by imran on 19-01-2023
        $('input[type=text]').each(function ()
        {
            var id = this.id; 
            /* if (this.value == "") { }*/ 
            //Commented and Added by Riddhesh Patil on 2 Oct 2024 for the issue of getting an wrong alert on custom date field.
          //  if (id.indexOf('dt') > -1) {}
            if (id.indexOf('dt') > -1 || id.indexOf('CustomFieldDate') > -1) { }
            //End of Commented and Added by Riddhesh Patil on 2 Oct Sep 2024 for the issue of getting an wrong alert on custom date field.
            else
            {
                if (checkSpecialCharacter(this.value, WebConfigSpecialCharacters) == true)
                {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Some of the fields should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    this.focus();
                    tcount++;
                    return;
                }
            } 
        });

        if (tcount == 0)
        { 
            $('input[type=Textbox]').each(function () {
                if (checkSpecialCharacter(this.value, WebConfigSpecialCharacters) == true) {
                    alertify.set('notifier', 'position', 'top-right');
                    alertify.error('Some of the fields should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
                    this.focus();
                    tcount++;
                    return;
                }
            });
        }

        if (checkSpecialCharacter($("#txtEditor").val(), WebConfigSpecialCharacters) == true) {
            alertify.set('notifier', 'position', 'top-right');
            alertify.error('Some of the fields should not contain any of these ' + WebConfigSpecialCharacters + ' characters');
            $("#txtEditor").val().focus();
            tcount++;
            return;
        }
        //End of comment by imran on 19-01-2023  

        if (ValidateRequestDetails() == 0 && checkvalueEmail == 0 && tcount==0) {            //Added by Usha Pandit on 31 July 2018 for plotting custom field validation function dynamically       
            try {
                //if (ValidateCustomFields != undefined)
                //{

                //var strmsg = "";
                //var errorMsg = "<ul>";
                //var resultdata = 0;
                //$('*[id*=CustomFieldNumeric]').each(function () {
                //    var customFieldNumericid = $(this).attr('id');
                //    var isDisabled = $('#' + customFieldNumericid).prop('disabled');
                //    if (isDisabled == false) {

                //        if ((RestrictNonNumeric(document.getElementById(customFieldNumericid)) == true)) {
                //            strmsg = ' - Please enter only numeric values !!!';
                //            errorMsg += "<li>" + strmsg + "</li>";
                //        }
                //    }
                //});

                //if (strmsg != "") {
                //    alertify.dismissAll();
                //    alertify.set('notifier', 'position', 'top-right');
                //    alertify.notify(errorMsg, 'error', 15);
                //    resultdata = 1;
                //}
                //else {
                //    resultdata = 0;
                //}
                //if (!ValidateCustomFields() || resultdata == 1) {
                //    return false;
                //}

                if (!ValidateCustomFields()) {
                    return false;
                }
              //}
            }
            catch (ex) {
                //alert(ex.message);
            }

            //End of Added by Usha Pandit on 31 July 2018 for plotting custom field validation function dynamically       

            var Subject = $("#txtsubject").val();
            var Description = $("#txtEditor").val();
            var Department = $("#CboDepartment").val();
            var RequestType = $("#CboRequestType").val();
            var SubRequestType = $("#CboSubRequestType").val();
            var Priority = $("#CboPriority").val();
            var Product = $("#cboProduct").val();
            var ModuleComponent = $("#CboModuleComponent").val();
            var Location = $("#CboLocation").val();
            var TimeZone = $("#CboTimeZone").val();
            var ExpResoulDate = $("#dtExpResdate").val();
            var Severity = $("#CboSeverity").val();
            // alert(TimeZone);
            if (ExpResoulDate == "" || ExpResoulDate == undefined) {
                ExpResoulDate = "";
            }
            if (Location == "" || Location == undefined) {
                Location = "";
            }

            if (TimeZone == "" || TimeZone == undefined) {
                TimeZone = "";
            }
            var m_strCustomFieldList = $("#CustomFieldList").val();
            //Added by Usha Pandit on 27 July 2018 for custom field save issue 
            if (m_strCustomFieldList == undefined)
                //End of Added by Usha Pandit on 27 July 2018 for custom field save issue 
                m_strCustomFieldList = "";
            var CC = $("#cc").val();
            if (CC == "" || CC == undefined) {
                CC = "";
            }
            if (document.getElementById('CboModuleComponent') == null) {
                ModuleComponent = "";

            }
            if (document.getElementById('cboProduct') == null) {
                Product = "";

            }
            if (Severity == "" || Severity == undefined) {
                Severity = "";
            }

            if (Description == "" || Description == undefined) {
                Description = "";
            }

            //var strTypeInaccessibleCustomFieldList = $("#TypeInaccessibleCustomFieldList").val();

            //// alert(m_strCustomFieldList);

            //if (m_strCustomFieldList != null)
            //debugger;
            //var ArrCustomFieldList = m_strCustomFieldList.split(",");
            //alert(ArrCustomFieldList);
            //var CustomFieldValue = "";

            //for (var i = 0; i < ArrCustomFieldList.length; i++) {
            //    CustomFieldValue = $('#' + ArrCustomFieldList[i]).val();
            //    // debugger;
            //    if (CustomFieldValue == "")
            //    {
            //        CustomFieldValue = $('#' + ArrCustomFieldList[i]).val();
            //    }
            //    else
            //    {
            //        CustomFieldValue =  $('#' + ArrCustomFieldList[i]).val() ;

            //        if (CustomFieldValue.indexOf("undefined") != -1)
            //        {
            //            //alert(1);
            //            CustomFieldValue.replace('undefined', "");
            //        }
            //    }

            //} 

            ////if (CustomFieldValue.substring(CustomFieldValue.length, 1) == ",")
            ////{
            ////    CustomFieldValue = CustomFieldValue.substring(0, CustomFieldValue.length - 1);
            ////}

            //if (CustomFieldValue == "" || CustomFieldValue == undefined) {
            //    CustomFieldValue = "";
            //}
            //if (m_strCustomFieldList == "") {
            //    m_strCustomFieldList = "";
            //}
            if (m_strCustomFieldList != null)
                var ArrCustomFieldList = m_strCustomFieldList.split(",");
            var CustomFieldValue = ""
            //Commented And Added By Usha Pandit On 07.01.2020 For saving custom field value
               //if (ArrCustomFieldList.length > 1) {
                    if (ArrCustomFieldList.length >= 1 && m_strCustomFieldList != "") {
                    //End Of Added By Usha Pandit On 07.01.2020 For saving custom field value
                for (var i = 0; i < ArrCustomFieldList.length; i++) {
                    for (var i = 0; i < ArrCustomFieldList.length; i++) {


                        if (i == 0) {
                            CustomFieldValue = $('#' + ArrCustomFieldList[i]).val();
                        }
                        else {
                            CustomFieldValue += ',' + $('#' + ArrCustomFieldList[i]).val();
                            if (CustomFieldValue.indexOf("undefined") != -1) {
                                //alert(1);
                                //Commented and Added by Usha Pandit on 29 JAN 2018 for page crash due to input string format
                                //CustomFieldValue.replace('undefined', "");
                                CustomFieldValue = CustomFieldValue.replace('undefined', "");
                                //End of Added by Usha Pandit on 29 JAN 2018 for page crash due to input string format
                            }
                        }

                        //End of Added by Usha Pandit on 06 Aug 2018 for custom field

                    }
                }


            }
            if (CustomFieldValue == "" || CustomFieldValue == undefined) {
                CustomFieldValue = "";
            }
            if (m_strCustomFieldList == "") {
                m_strCustomFieldList = "";
            }


            // alert(strTypeInaccessibleCustomFieldList);
            //var objCustomFieldCombo1 = GetObjectReference('frmAddNewRequest', 'CustomFieldCombo1');
            //alert(objCustomFieldCombo1.value);
            var CustomerID = 0;
            var EmployeeID = 0;

            CustomerID = document.getElementById('hdnCustomerID').value;
            EmployeeID = document.getElementById('hdnEmployeeID').value;

            data = JSON.stringify({ Subject: Subject, Description: Description, Department: Department, RequestType: RequestType, SubRequestType: SubRequestType, Priority: Priority, Product: Product, ModuleComponent: ModuleComponent, Location: Location, TimeZone: TimeZone, Status: "", Project: "", AssignTo: "", objCustomField: m_strCustomFieldList, CustomFieldValue: CustomFieldValue, ExpResoulDate: ExpResoulDate, CC: CC, CustomerID: CustomerID, EmployeeID: EmployeeID, Severity: Severity });
            // alert(data);
            strResult = AJAXCallWithResult("CRM_AddNewRequest.aspx/SaveRequestDetails", data, false);
            var Result = String(strResult.d).split("||");
            if (Result[0] != "") {
                RequestID = Result[0];
                if ('<%=blnSendMail%>' == "True") {
                    if ('<%=blnShowPopup%>' == "True") {

                        //alert(RequestID);
                        //window.open("../../Source/General/SendEmail.aspx?MessageID=1003&QueryID=82571&IsShowToCustomer=" + strTempIsShowToCustomer + "&MultipleRequests=0&EmployeeIDList=" + '<%=Session("intUserID")%>', "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 460) / 2 + ",width=600,height=460");
                        window.open("../../HelpdeskEnhancement/EmailSettings/CRMSendEmail.aspx?MessageID=46&MultipleRequests=0&QueryID=" + RequestID + "&EmployeeIDList=" + '<%=Session("intUserID")%>' + "", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600) / 2 + ",top=" + (window.screen.height - 460) / 2 + ",width=600,height=460");

                    }
                }

                var strURL = "CRM_AddNewRequest.aspx";
                var formData = new FormData();
                var objFileGrid = document.getElementById('tblFiles');

                //Looping through uploaded files collection in case there is a Multi File Upload. This also works for single i.e simply remove MULTIPLE attribute from file control in HTML.  
                //for (var i = 0; i < tblFiles.rows.length - 1; i++) {
                //    var objFileObject =document.getElementById("txtFileName" + i);
                //    if (objFileObject != null) {
                //        formData.append(objFileObject.name, objFileObject);
                //       // formData.append("TxtComment_"+[i], document.getElementById('txtComments'+[i]).value);
                //      //  formData.append("Internal_"+[i], document.getElementById('chkIsShowToCustomer'+[i]).value);
                //    }                     
                //}
                for (var i = 0; i < fileObject.length; i++) {
                    formData.append(fileObject[i].name, fileObject[i][0]);

                    //formData.append("TxtComment_" + [i], document.getElementById('txtComments' + [i]).value);
                    // formData.append("Internal_" + [i], 1);

                    console.log(fileObject[i][0]);
                }

                for (var i = 0; i < fileObject.length; i++) {

                    if (document.getElementById('txtComments' + i) != null) {
                        formData.append("TxtComment_" + i, document.getElementById('txtComments' + i).value);
                        if (document.getElementById("chkIsShowToCustomer" + i) != null) {
                            if (document.getElementById("chkIsShowToCustomer" + i).checked == true) {
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

                //console.log(fileObject[i][0]);

                formData.append('Mode', 'FileAttachment');
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

                // setTimeout(function () {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('Request is submitted successfully', 'success', 5);
                //Added By Aniruddh Gujar on 21-Dec-2017 Purpose::To notify the user
                var url = 'CRM_AddNewRequest.aspx/ValidateRequestAttachment';
                var data = JSON.stringify({ RequestID: RequestID });
                var CheckValue = 0;
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
                    alertify.notify('For the current request attachment is mandatory.\nPlease attach the required files once the request is saved.', 'success', 20);
                }
                //End of Added By Aniruddh Gujar on 21-Dec-2017 Purpose::To notify the user
                //  }, 50);
                clearControls();
                setTimeout(function () {
                    window.location.href = "../../../Source/HelpdeskEnhancement/RequestList/CRM_RequestListNew.aspx";
                }, 1000);

                // var delay = alertify.get('notifier', 'delay');
                // alertify.set('notifier', 'delay', 20);
                // alertify.success('Current delay : ' + alertify.get('notifier', 'delay') + ' seconds');
                // alertify.set('notifier', 'delay', delay);
                // clearControls();
                // debugger;


            }

            // $.when(alert()).done(clearControls()).done(BackTolist());


        }
    }
    
    //function alert() {
    //    alertify.set('notifier', 'position', 'top-right');
    //    alertify.notify('Request is submmitted successfully', 'success', 5);
    //}

    function BackTolist() {
        window.location.href = "../../../Source/HelpdeskEnhancement/RequestList/CRM_RequestListNew.aspx";
    }


    function clearControls() {
        $("#txtsubject").val("");
        $("#txtEditor").html("");
        $("#txtEditor").val("");
        $("#CboDepartment").val("");
        //Commented And Added By Usha Pandit On 15.10.2020 For Clear button functionality issue
        Department_OnChange(null);
        //End Of Added By Usha Pandit On 15.10.2020 For Clear button functionality issue
        $("#CboRequestType").val("");
        $("#CboSubRequestType").val("");
        $("#CboPriority").val("");
        $("#cboProduct").val("");
        $("#CboModuleComponent").val("");
        $("#CboLocation").val("");
        $("#CboTimeZone").val("");
        $("#dtExpResdate").val("");
        $("#divGuidelines").html("");
        $("#divCustomField").html("");
        $("#txtEditor").val("");
        $("#CboSeverity").val("");
        $("#divAttachments").html("");
        $("#cc").val("");
        //Added by Chetan M on 12 Feb 2021 for fields are getting updated if customer is selected         
        if (gblCustomerID != 0) {
            //CustomerSelection(gblCustomerID);
        }
        //End of Added by Chetan M on 12 Feb 2021 for fields are getting updated if customer is selected 
    }

    //Commented & Added By Dipali V On 16th Nov 2017
    // var validEmailIDConfig = 0;
    //function ValidateEmailId(obj) {
    //  //  alert(obj.id);
    //        var textboxvalue = [];
    //        textboxvalue = $('#cc').val().split(',');

    //        for (var j = 0; j < textboxvalue.length; j++) {

    //            if (ValidateEmail(textboxvalue[j]) == true) {

    //                validEmailIDConfig = 1;
    //            }
    //        }

    //}


    //function ValidateEmail(email) {
    //    var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    //    return expr.test(email);
    //};
    var checkvalueEmail = 0
    function ValidateEmailID1() {

        if ($("#cc").val() != "") {
            var objTxt1 = $("#cc").val();
            flag = ValidateEmailID(objTxt1);
            if (flag == false) {
                alertify.set('notifier', 'position', 'top-right');
                alertify.notify('CC Email ID Should be Valid', 'error', 15);
                checkvalueEmail = 1;

            }


        }
    }
    function ValidateEmailID(strEmailList) {
        var strEmailArray;
        var intCtr
        var strNewEmailList
        if (strEmailList == "") {
            return false;
        }

        if (strEmailList.charAt(strEmailList.trim().length - 1) == ";") {
            strNewEmailList = strEmailList.substr(0, strEmailList.trim().length - 1);
        }

        else {
            strNewEmailList = strEmailList;
        }
        strNewEmailList = strNewEmailList.replace(/ /g, '');

        objRegularExp = new RegExp("[\\,,\\ ,\\;]")
        strEmailArray = strNewEmailList.split(objRegularExp);

        if (strEmailArray.length == 0)
            return false;

        for (intCtr = 0; intCtr < strEmailArray.length; intCtr++) {
            if (isEmail(strEmailArray[intCtr]) == false) {

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
        ' Author                :   Dipali V
        ' Created               :   16th Nov 2017
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
    //end of Commented & Added By Dipali V On 16th Nov 2017

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

    var strPageName = "CRM_AddNewRequest.aspx";
    var strResult, data, EmployeeID = "", EmployeeName = "";
    var LoginCreatedFlag = 1;//Added by Chetan M on 17 Feb 2021 for fields are getting updated if customer is selected 

    function CustomerSelection(CustomerID) {
        //    alert();
        var strResult, data;
        //Added by Chetan M on 12 Feb 2021 for fields are getting updated if customer is selected 
        gblCustomerID = CustomerID;
        //End of Added by Chetan M on 12 Feb 2021 for fields are getting updated if customer is selected 
        //var Flag;
        var EmployeeID = 0;
        document.getElementById('hdnCustomerID').value = CustomerID;
        document.getElementById('hdnEmployeeID').value = 0;
        EmployeeID = document.getElementById('hdnEmployeeID').value;
        data = JSON.stringify({ Flag: "CustomerDetails", CustomerID: document.getElementById('hdnCustomerID').value, EmployeeID: "0" });
        //alert(data);
        strResult = AJAXCallWithResult(strPageName + "/PlotRequestDetails", data, false);

        //alert(strResult.d);
        var Result = String(strResult.d).split("|");

        if (Result[1] == 0) {


            alertify.set('notifier', 'position', 'top-right');
            alertify.notify('You can not post request as login is not created for customer', 'error');
            //Added by Chetan M on 17 Feb 2021 for fields are getting updated if customer is selected 
            gblCustomerID = 0;
           LoginCreatedFlag = Result[1];
            //End of Added by Chetan M on 17 Feb 2021 for fields are getting updated if customer is selected 
            return;
        }
        //Added by Chetan M on 17 Feb 2021 for fields are getting updated if customer is selected 
        else {
            LoginCreatedFlag = 1;
        }
        //End of Added by Chetan M on 17 Feb 2021 for fields are getting updated if customer is selected 
        document.getElementById('frmRequest').innerHTML = ""
        document.getElementById('frmRequest').innerHTML = Result[0];
        document.getElementById('CboDepartment').onchange();


        EmployeeName = $("#ulCustomer li" + '#' + CustomerID).text();
        // alert(EmployeeName);
        //$('#idRequestorName').val("");
        //$('#idRequestorName').html(EmployeeName);
        document.getElementById('idRequestorName').value = "";
        document.getElementById('idRequestorName').innerHTML = "";
        document.getElementById('idRequestorName').value = EmployeeName;
    }
    $(document).click(function (e) {
        console.log(e.target.id);
        if (e.target.id != "idSelf" && e.target.id != "idCustomer" && e.target.id != "idEmployee" && e.target.id != "searchlist" && e.target.className != "popupnew" && e.target.id != "SearchEmployee")
        {          
             //Commented and Added by Chetan M on 17 Feb 2021 for fields are getting updated if customer is selected 
            //$("#idSelf1").css("display", "none");
            //$("#idCustomer").css("display", "none");
            //$("#idCustomer").removeClass("selected");
            //$("#idEmployee").css("display", "none");
            //$("#idEmployee").removeClass("selected");
             if (LoginCreatedFlag != 0) {
            $("#idSelf1").css("display", "none");
            $("#idCustomer").css("display", "none");
            $("#idCustomer").removeClass("selected");
            $("#idEmployee").css("display", "none");
            $("#idEmployee").removeClass("selected"); 
            }
             else {
                 $("#idCustomer").trigger("click");
            }
             //End of Added by Chetan M on 17 Feb 2021 for fields are getting updated if customer is selected 
        }

    })
    //Added by Chetan M on 12 Feb 2021 for fields are getting updated if customer is selected 
    var gblCustomerID = 0;
    $("#idSelf1").click(function () {
        //Added By Usha Pandit On 12.04.2021 for correct Requestor name and Self/Customer/Employee Selection
        EmployeeName = "";
        //End Of Added By Usha Pandit On 12.04.2021 for correct Requestor name and Self/Customer/Employee Selection
        gblCustomerID = 0;
        SelfSelection();
        //Added By Usha Pandit On 12.04.2021 for correct Requestor name and Self/Customer/Employee Selection
        document.getElementById('idSelf').innerHTML = "";
        document.getElementById('idSelf').innerHTML = "Self";
        //End Of Added By Usha Pandit On 12.04.2021 for correct Requestor name and Self/Customer/Employee Selection
    });
    //End of Added by Chetan M on 12 Feb 2021 for fields are getting updated if customer is selected 
        function SelfSelection() {
            if (strLoginType != "C") {

                var strResult, data;
                //var Flag;
                document.getElementById('hdnCustomerID').value = 0;
                data = JSON.stringify({ Flag: "CustomerDetails", CustomerID: "0", EmployeeID: "0" });
                //alert(data);
                strResult = AJAXCallWithResult(strPageName + "/PlotRequestDetails", data, false);

                //alert(strResult.d);
                var Result = String(strResult.d).split("|");

                document.getElementById('frmRequest').innerHTML = ""
                document.getElementById('frmRequest').innerHTML = Result[0];
                document.getElementById('CboDepartment').onchange();
                //document.getElementById('idRequestorName').value = document.getElementById('idSelf').innerHTML;
                // debugger;
                // document.getElementById('idRequestorName').value = "";
                if (strLoginType == "C") {
                    document.getElementById('idEmployee').style.display = "none";
                    //document.getElementById('idRequestorName').value = "Self";

                }
                else {

                    if ('<%=blnIsHRM%>' == '1') {
                        if (EmployeeName != "") {

                            document.getElementById('idRequestorName').value = "";
                            document.getElementById('idRequestorName').innerHTML = "";
                            document.getElementById('idRequestorName').value = EmployeeName;

                        }
                        //Added By Usha Pandit On 12.04.2021 for correct Requestor name and Self/Customer/Employee Selection
                        else {
                            $('#idSelf').prop('onclick', null).off('click');
                            document.getElementById('idRequestorName').value = "";
                            document.getElementById('idRequestorName').innerHTML = "";
                            document.getElementById('idRequestorName').value = '<%=Session("strUserName")%>'
                        }
                        //End Of Added By Usha Pandit On 12.04.2021 for correct Requestor name and Self/Customer/Employee Selection
                    }
                    else {

                        // $("#idSelf1").css('display', 'none');
                        // $("#idSelf").unbind("click", handler);
                        // $("#idCustomer").css('display', 'none');
                        $('#idSelf').prop('onclick', null).off('click');
                        document.getElementById('idRequestorName').value = "";
                        document.getElementById('idRequestorName').innerHTML = "";
                        document.getElementById('idRequestorName').value = '<%=Session("strUserName")%>'
                        // document.getElementById('idRequestorName').value = EmployeeName;
                    }

                    // document.getElementById('idRequestorName').value = document.getElementById('idCustomer').innerHTML;

                }

            }
            //Added by Chetan M on 12 Feb 2021 for fields are getting updated if customer is selected 
            if (gblCustomerID != 0) {
                CustomerSelection(gblCustomerID);
            }
            //End of Added by Chetan M on 12 Feb 2021 for fields are getting updated if customer is selected 
           

        }

        function EmployeeSelection(CustomerID) {
            //Added by Chetan M on 12 Feb 2021 for fields are getting updated if customer is selected 
            gblCustomerID = 0;
            //End of Added by Chetan M on 12 Feb 2021 for fields are getting updated if customer is selected 

            var Flag;
            EmployeeID = CustomerID;
             gblCustomerID = CustomerID;
            document.getElementById('hdnCustomerID').value = "0";
            document.getElementById('hdnEmployeeID').value = CustomerID;
            var CustomerID = document.getElementById('hdnEmployeeID').value;
            data = JSON.stringify({ Flag: "EmployeeDetails", CustomerID: "0", EmployeeID: document.getElementById('hdnEmployeeID').value });
            strResult = AJAXCallWithResult(strPageName + "/PlotRequestDetails", data, false);

            var Result = String(strResult.d).split("|");
            // alert(Result);
            document.getElementById('frmRequest').innerHTML = ""
            document.getElementById('frmRequest').innerHTML = Result[0];
            //debugger;
            document.getElementById('CboDepartment').onchange();
            //debugger;
            document.getElementById('idRequestorName').innerHTML = ""
            EmployeeName = $("#ulEmployee li" + '#' + EmployeeID).text();

            if (EmployeeName == "") {
                document.getElementById('idRequestorName').value = '<%=Session("strUserName")%>'
            }

            // $('#idRequestorName').val("");
            //$('#idRequestorName').html(EmployeeName);      
            document.getElementById('idRequestorName').value = "";
            document.getElementById('idRequestorName').innerHTML = "";
            document.getElementById('idRequestorName').value = EmployeeName;
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
        async function addFileinGrid() {
          
            var objtxtFileName = document.getElementById('txtFileName' + FileCount);
            var file = objtxtFileName.files[0];

            // Added by Ajit L on 13/11/2024 for Validate the file
            try {
                 await ValidateForexeinFile(objtxtFileName);
                if (!isValidTypeExeCheck) {
                    $(objtxtFileName).val("");
                    
                    return; // Stop if the file is not valid
                }
                    
            } catch (error) {
                console.error(error);
                //alert("#${objtxtFileName}")
                alertify.set('notifier', 'position', 'top-right');
                alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                
                //$("#${objtxtFileName}").empty();
                return;
            }
            // End of Added by Ajit L on 13/11/2024 for Validate the file

            var objFileGrid = document.getElementById('tblFiles');
            objFileGrid.style.display = "";
            var newRow = objFileGrid.insertRow(objFileGrid.rows.length);
            objtxtFileName.style.display = "none";
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

            newCell = newRow.insertCell(2);
            newCell.innerHTML = "<Textarea wrap='Hard'  name='txtComments' id='txtComments" + FileCount + "' class='form-control' style='width:250px  ; height:50px  ; text-align:Left'  ></Textarea>";
            if ('<%=m_strLoginType%>' != "C") {
                newCell = newRow.insertCell(3);
                newCell.innerHTML = "Internal <Input type=checkbox name='chkIsShowToCustomer" + FileCount + "' id='chkIsShowToCustomer" + FileCount + "' class='clsCheckBox' style='width:auto;'>";
            }
            if ('<%=m_strLoginType%>' != "C") {
                newCell = newRow.insertCell(4);
            }
            else {

                newCell = newRow.insertCell(3);
            }

            newCell.innerHTML = "<A class='Menu' style='' HREF='Javascript:RemoveAttachement(" + FileCount + ")' Title='Remove Attachment' >(Remove)</A>";

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
            FileControl.size = 74;



            FileControl.onkeydown = function () { return false; };
            FileControl.onbeforepaste = function () { return false; };
            FileControl.onpaste = function () { return false; };
            FileControl.onkeydown = function () { return false; };
            FileControl.onbeforepaste = function () { return false; };
            FileControl.onpaste = function () { return false; };
            FileControl.onchange = addFileinGrid;

            if (FileCount_toDisable == 5)
                FileControl.disabled = true;


            parentTD.appendChild(FileControl);

            var objtxtFileName = document.getElementById('txtFileName' + FileCount);
            objtxtFileName.style.display = "none";
            $("#btnSelectFile").attr("FileCount", FileCount);

            //for (var j = 0; j < tblFiles.rows.length; j++) {
            //    if ($("#txtFileName" + j)[0] != undefined)
            //        fileObject[j] = $("#txtFileName" + j)[0].files;
            //}


        }

        function RemoveAttachement(FileNO) {

            var objTR = document.getElementById('FILENAME' + FileNO);
            var toRemoveFileControl = document.getElementById('txtFileName' + FileNO);
            var objFileGrid = document.getElementById('tblFiles');

            objFileGrid.deleteRow(objTR.rowIndex);

            toRemoveFileControl.parentNode.removeChild(toRemoveFileControl);
            document.getElementById("txtFileName" + FileCount).disabled = false;;

            if (objFileGrid.rows.length == 1) {
                objFileGrid.style.display = 'none';
            }
            fileObject = [];
            FileCount_toDisable--;
        }

        //Added by Ajit L on 13/12/2024 for restricting file which contain exe file embeded in it
    var ValidateFileExtension = '<%=ConfigurationManager.AppSettings("ValidateFileExtension").ToString%>'
        var isValidTypeExeCheck = ''
       async function ValidateForexeinFile(file) {
           
            var objFile = file;
            var fileName = objFile.files[0].name;
            var extension = fileName.slice(fileName.lastIndexOf('.') + 1).toLowerCase();

            isValidTypeExeCheck = false;
         //  const ValidExtsExe = ["docx", "doc", "pptx", "xlsx"];
           const ValidExtsExe = ValidateFileExtension.split(",");

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
                        console.log(error);
                        alertify.set('notifier', 'position', 'top-right');
                        alertify.error("Upload restricted: This file contains an embedded executable (EXE) file.");
                        isValidTypeExeCheck = false;
                        $(objFile).val("");

                        return;
                    });

                if (!isValidTypeExeCheck) {
                    return;
                }
            }
        }
         //End of Added by Ajit L on 13/12/2024 for restricting file which contain exe file embeded in it

   


</script>

<!-- Custom Scripts -->
<script>
    $("ul.custom-ul").on("click", ".init", function () {
        $(this).closest("ul.custom-ul").children('li:not(.init)').toggle();
        if (strLoginType == "C") {
            document.getElementById('idEmployee').style.display = "none";
            document.getElementById('idRequestorName').value = document.getElementById('idCustomer').innerHTML;
            //document.getElementById('idRequestorName').value = "Self";
        }
        else {
            if ('<%=blnIsHRM%>' == '0') {

                document.getElementById('idEmployee').style.display = "none";
                document.getElementById('idSelf1').style.display = "none";
            }
            //  document.getElementById('idRequestorName').value = '<%=Session("strUserName")%>'
        }


    });

        var allOptions = $("ul.custom-ul").children('li:not(.init)');
        //debugger
        $("ul.custom-ul").on("click", "li:not(.init)", function () {
        //debugger
        allOptions.removeClass('selected');
            $(this).addClass('selected');
            var abcd = $(this).html()
            $("ul.custom-ul").children('.init').html($(this).html());
        //  $("ul.custom-ul").append("li").html("Self");
            //Commented By Dipali V On 30th Dec 2020 For Filtering Issue
            //allOptions.toggle();
            //End of Commented By Dipali V On 30th Dec 2020 For Filtering Issue
            $("ul.custom-ul").children('li:not(.init)').show();
        // debugger;

        if (strLoginType == "C") {
            document.getElementById('idEmployee').style.display = "none";
            document.getElementById('idRequestorName').value = document.getElementById('idCustomer').innerHTML;
            //document.getElementById('idRequestorName').value = "Self"
        }
        else {
            //debugger;
            //  alert(EmployeeName);
            if ('<%=blnIsHRM%>' == '0') {

                document.getElementById('idEmployee').style.display = "none";
                document.getElementById('idSelf1').style.display = "none";


                if (EmployeeName != "") {
                    //alert(EmployeeName);
                    document.getElementById('idRequestorName').value = "";

                    //document.getElementById('idRequestorName').innerHTML = "<%=Session("strUserName")%>";
                    document.getElementById('idRequestorName').value = EmployeeName;

                }
                else {
                    //alert(EmployeeName);
                    document.getElementById('idRequestorName').value = "";
                    document.getElementById('idRequestorName').innerHTML = "";
                    document.getElementById('idRequestorName').value = '<%=Session("strUserName")%>'
                    // document.getElementById('idRequestorName').value = EmployeeName;
                }

                // document.getElementById('idRequestorName').value = document.getElementById('idCustomer').innerHTML;
            }
        }
        //document.getElementById('idRequestorName').value = document.getElementById('idCustomer').innerHTML;

    });
</script>
<!-- End Custm Scripts -->
<!-- select popup -->
<script>
    // When the user clicks on div, open the popup
    <%--function myFunction() {
        var popup = document.getElementById("myPopup");
        popup.classList.toggle("show");
    }--%>
</script>
<!-- end select popup -->
<script>










    //Added by Dipali V On 1st Nov 2017 For Searching Employee & Customer
    function mySearch(FlagFilter) {
        // debugger;
        Flag = FlagFilter
        var input, filter, ul, li, i, Flag;
        if (Flag == "Employee") {

            input = document.getElementById("SearchEmployee");
            filter = input.value.toUpperCase();
            table = document.getElementById("ulEmployee");
        }
        else {
            input = document.getElementById("searchlist");
            filter = input.value.toUpperCase();
            table = document.getElementById("ulCustomer");

        }

        tr = table.getElementsByTagName("li");
        for (i = 0; i < tr.length; i++) {
            td = tr[i];
            if (td) {
                if (td.innerHTML.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.setProperty("display", "block", "important");
                }
                else {
                    tr[i].style.setProperty("display", "none", "important");
                }

            }
        }

    }


    function BackNewRequest_OnClick() {

        window.location.href = "../../../Source/HelpdeskEnhancement/RequestList/CRM_RequestListNew.aspx";

    }
    //Added By Rehan C To add Validator for Special characters on 18th Nov 2022
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
    //End of Comment By Rehan C

    //$("#idSelf").mousedown(function () {

    //    $('ul.custom-ul li:not.init').hide();
    //});

    //End Added by Dipali V On 1st Nov 2017 For Searching Employee & Customer


</script>
</html>

