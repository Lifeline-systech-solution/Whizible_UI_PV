<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_RequestDetail.aspx.vb" Inherits="PbNIT.CRM_RequestDetail"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Request Details")%>
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		
					<form id="frmRequestDetails" name="frmRequestDetails" method="post">
									<%WritePage()%>
					
					<script language="javascript">
					
					
		var objform;
		var objdivlist;
		var objcboFunction;
		var objcboSubRequestType;
		var objcboRequestType;
		var objtxtSubject;
		var objcboPriority;
		var objtxtResolutionDate;
		var objtxtCRMResolutionDate;
		var objcboStatus;
		var objcboTargetLocation;
		var objcboFeedback;
		var objtxtFeedbackComments;
		var objcboAssignTo;
		var objtxtHiddenServerDate;
		var objtxtHiddenPrevResolutionDate;
		var objtxtHiddenCRMPrevResolutionDate;
		//Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4262
		// Code Added By PradipK for Help Desk SLA 
		var objtxtStatusChangeDate;
		var objtxtStatusChangeTIme;
		var objStatusTime
		var objStatusDate
		var objCurrentDate
		var objOldStatus
		var objOldStatusChangeDate
		var objOldStatusChangeTime
		var objNewStatus
		var objDate
		var  objResolutionDate
		var objTime
		// End Addition By PradipK for Help Desk SLA 
		//End Integration
		
		//Modified by ShraddhaM on Date 15 June,2006 for WhizibleSEM Issue ID.4168
			var LoginType="<%=m_strLoginType%>";
		 	var Db_FilterID ;
			var Sr_FilterID ;
			var Ar_FilterID ;
			var DepartmentID;
			var StatusID ;
			var win=window.open('','RequestList');
			 
		//Ended by ShraddhaM on Date 15 June,2006 for WhizibleSEM Issue ID.4168
		
		var showSubRequest = "<%=m_strShowSubRequest%>";
			var blnViewAccessOrHRM = <%=blnViewAccessOrHRM%> ;
			
		
		objform = GetFormReference('frmRequestDetails');
		objdivlist = GetObjectReference('frmRequestDetails','divList');
		objcboFunction = GetObjectReference('frmRequestDetails','cboFunction');
		
		//To Solve Page Crash Issue for Validation
		//Code Chaged By SantoshK on 29th Jan 2004
		//Issue 15404 - While adding an New helpDesk Request the page crashes. 
		if (showSubRequest == "True" )
		{			
			objcboRequestType= GetObjectReference('frmRequestDetails','cboRequestType');
			objcboSubRequestType= GetObjectReference('frmRequestDetails','cboSubRequestType');
		}
		else
		{
			objcboSubRequestType= GetObjectReference('frmRequestDetails','cboSubRequestType');
		}
		//Addition Ends
		
		objtxtSubject = GetObjectReference('frmRequestDetails','txtSubject');
		objcboPriority = GetObjectReference('frmRequestDetails','cboPriority');
		objtxtResolutionDate = GetObjectReference('frmRequestDetails','txtResolutionDate');
		objtxtCRMResolutionDate= GetObjectReference('frmRequestDetails','txtCRMResolutionDate');
		objcboStatus = GetObjectReference('frmRequestDetails','cboStatus');
		objcboTargetLocation = GetObjectReference('frmRequestDetails','cboTargetLocation');
		objcboFeedback = GetObjectReference('frmRequestDetails','cboFeedback');
		objtxtFeedbackComments = GetObjectReference('frmRequestDetails','txtFeedbackComments');
		objcboAssignTo = GetObjectReference('frmRequestDetails','cboAssignTo');
		objtxtHiddenServerDate = GetObjectReference('frmRequestDetails','txtHiddenServerDate');
		objtxtHiddenPrevResolutionDate = GetObjectReference('frmRequestDetails','txtHiddenPrevResolutionDate');
		objtxtHiddenCRMPrevResolutionDate = GetObjectReference('frmRequestDetails','txtHiddenCRMPrevResolutionDate');
		objtxtHiddenSubmittedDate = GetObjectReference('frmRequestDetails','txtHiddenSubmittedDate');
		objtxtCRMResolutionDate = GetObjectReference('frmRequestDetails','txtCRMResolutionDate');
		
		function validate()
		{
			var mode = "<%=m_strMode%>";
			var fromwhere = "<%=m_strFromWhere%>";
			if (disallowBlank(objcboFunction,"<%=m_strFunction_Caption%> cannot be blank",true)) return false;

			//Solve Page crash Issue
			//Code Chaged By SantoshK on 29th Jan 2004
			////Issue 15404 - While adding an New helpDesk Request the page crashes. 
			if (showSubRequest == "True")
			{
				if (disallowBlank(objcboRequestType,"Request Type cannot be blank",true)) return false;
				if (disallowBlank(objcboSubRequestType,"<%=m_strSubRequestType_Caption%> cannot be blank",true)) return false;
			}
			else
			{
				if (disallowBlank(objcboSubRequestType,"Request Type cannot be blank",true)) return false;
			}
			//Addition Ends
		
			//if (disallowBlank(objcboSubRequestType,"<%=m_strSubRequestType_Caption%> cannot be blank",true)) return false;
			if (disallowBlank(objtxtSubject,"<%=m_strSubject_Caption%> cannot be blank",true)) return false;
			if (disallowBlank(objcboPriority,"<%=m_strPriority_Caption%> cannot be blank",true)) return false;
			//Integrated by SavitaS on 22 Dec 2005 to check whether ResolutionDate is null
			if(objtxtResolutionDate != null){
			if (disallowBlank(objtxtResolutionDate,"<%=m_strExpectedResolvedDate_Caption%> cannot be blank",true)) return false;
			if (mode != "EDIT" && fromwhere == "SR")
			{
				if (disallowDate1LessThanDate2(objtxtResolutionDate,objtxtHiddenServerDate,"Please enter a date not less than the current date"))return false;
			}
			}//End Integration by SavitaS
			if (mode == "EDIT")
			{
						
				// code commented by harshada d on 18 Nov for removing the expected ResolutionDate validation in edit mode
				/*if (compareDates(objtxtHiddenPrevResolutionDate.value,objtxtResolutionDate.value) !=0)
				{
					if (disallowDate1LessThanDate2(objtxtResolutionDate,objtxtHiddenServerDate,"Please enter a date not less than the current date"))return false;
				}
				if (compareDates(objtxtHiddenCRMPrevResolutionDate.value,objtxtCRMResolutionDate.value) !=0)
				{
					if (disallowDate1LessThanDate2(objtxtCRMResolutionDate,objtxtHiddenServerDate,"Please enter a date not less than the current date"))return false;
				}*/
						// end of  code commentation by harshada d on 18 Nov for removing the expected ResolutionDate validation in edit mode
					if((objtxtResolutionDate != null)&& (objtxtHiddenSubmittedDate != null))
					{
						if (compareDates(objtxtResolutionDate.value,objtxtHiddenSubmittedDate.value)!=0)
						{
						if (disallowDate1LessThanDate2(objtxtResolutionDate,objtxtHiddenSubmittedDate,"<%=m_strExpectedResolvedDate_Caption%> cannot be less than the Request Submission date - " + objtxtHiddenSubmittedDate.value))
						{
						return false;
					
						}
						}
					}	
					if((objtxtCRMResolutionDate != null)&& (objtxtHiddenSubmittedDate != null))
					{
					if (compareDates(objtxtCRMResolutionDate.value,objtxtHiddenSubmittedDate.value) !=0)
					{
					if (disallowDate1LessThanDate2(objtxtCRMResolutionDate,objtxtHiddenSubmittedDate,"<%=m_strCRMExpectedResolvedDate_Caption%> cannot be less than the Request Submission date - " + objtxtHiddenSubmittedDate.value))
						{
						return false;
						
						}
					}
					}			
				
			if (disallowBlank(objcboStatus,"<%=m_strStatus_Caption%> cannot be blank",true)) return false;
			}
			//Integrated by SavitaS on 22 Dec 2005 to check whether ResolutionDate is null
			if(objcboTargetLocation != null)
			{
			if (disallowBlank(objcboTargetLocation,"<%=m_strTargetLocation_Caption%> cannot be blank",true)) return false;
			}//End Integration 
			
					
			if (fromwhere == "SR" && mode == "EDIT")
			{
				if (objcboStatus.value == "2" )
				{
					if (disallowBlank(objcboFeedback,"Please give your feedback",true)) return false;
					if (disallowBlank(objcboStatus,"",false)==false) 
					{
						if (disallowMaxlengthViolation(objtxtFeedbackComments,1000,"Please enter your comments within 1000 characters")) return false;
					}
				}
			}
			return true;
		}
		//Integrated by SavitaS on 02 Jan 2005 for whiz2
		//added by harshada d on 28 Nov 2005 for Show History option in CRM
		function ShowHistory_OnClick()
		{
		window.open ("../General/CommonList.aspx?&MasterTagID=3100&QueryID=<%=m_lngQueryID%>", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=600");
		}
		//end of addition by harshada d on 28 Nov 2005 for Show History option in CRM
		//End Integration by SavitaS
		function Save_OnClick()
		{		  
		//added by harshada d on 31 may 2006 for issue : filters not getting set on refreshing the page		
			var fromwhere = "<%=m_strFromWhere%>";
			
		//end of addition by harshada d for whiziblesem 6 on 31 st may 2006
			var mode = "<%=m_strMode%>";
			
			//Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4262
			// Code Added By PradipK for Help Desk SLA 
				if(mode == "EDIT")
				{		
						
					//objOldStatusChangeDate = GetObjectReference('frmRequestDetails','txtchangedDatehidden1');
					objOldStatusChangeDate=window.document.forms['frmRequestDetails'].elements['txtchangedDatehidden1'];
					 
					//objOldStatusChangeTime = GetObjectReference('frmRequestDetails','txtarea1');
					objOldStatusChangeTime=window.document.forms['frmRequestDetails'].elements['txtchangedTimehidden1'];
					 
					objCurrentChangeDate = GetObjectReference('frmRequestDetails','txtchangedDate');
					 
					objCurrentChangeTime = GetObjectReference('frmRequestDetails','txtchangedTime');
					 
					objOldStatus = GetObjectReference('frmRequestDetails','cboStatusOld');
					  
					objNewStatus=GetObjectReference('frmRequestDetails','cboStatus');
					 
				 	objTime=GetObjectReference('frmRequestDetails','CurrentTime');
				 	 
					objDate=GetObjectReference('frmRequestDetails','CurrentDate');
					 
					objResolutionDate=GetObjectReference('frmRequestDetails','txtResolutionDate');
				 
				 
				  
					if(LoginType=='E')
					{			
						if(objCurrentChangeDate!=null)
						{
							if(objCurrentChangeDate.value=="")
							{
								alert('Status Change Date should not be left blank');
								return;
							}
						}
 

						if (objCurrentChangeTime!=null)
						 {
				   
							 if (disallowBlank(objCurrentChangeTime,"<%=MyBase.GetResourceString("BLANKREPORTEDTIME")%>",true))
								return;
							
							 if(isTime(objCurrentChangeTime,"<%=mybase.GetResourceString("INVALIDTIME",false)%>")==false)
							 {
								return ;
							 }
						}	
					
						//Modified by ShraddhaM on Date 15 June,2006 for WhizibleSEM Issue ID.4168
 
 
					// Validation: If Status is not changed,Then Disallow to Change Status Change Date & Status Change Time 
					
				
						if(objOldStatusChangeDate.value!="" && objOldStatus!=null && objNewStatus!=null && objOldStatusChangeDate  !=null && objOldStatusChangeTime !=null && objCurrentChangeDate!=null && objCurrentChangeTime!=null ) 
							{ 
								if (objOldStatus.value==objNewStatus.value)
								{ 
									if (objOldStatusChangeDate.value!=objCurrentChangeDate.value || objOldStatusChangeTime.value !=objCurrentChangeTime.value )
										{ 
											alert('Status date/time change can be done only when Status is changed !');
											if(objOldStatusChangeDate.value!=objCurrentChangeDate.value)
											//setFocus(objCurrentChangeDate);
											if(objOldStatusChangeTime.value!=objCurrentChangeTime.value)
											setFocus(objCurrentChangeTime);
											return;
										}
								}
							}
							
						//Ended by ShraddhaM on Date 15 June,2006 for WhizibleSEM Issue ID.4168
  
		
						if (objOldStatus!=null && objNewStatus!=null )
						{	  
						if (objOldStatus.value!=objNewStatus.value )
						{
						
							if(objCurrentChangeDate!=null && objCurrentChangeTime!=null && objOldStatusChangeDate!=null && objOldStatusChangeTime!=null )
							{
								
								 if(objOldStatusChangeDate.value!="" && objOldStatusChangeTime.value!="" && objCurrentChangeDate.value!="" && objCurrentChangeTime.value!="" )
									{
										
										if(objOldStatusChangeDate.value==objCurrentChangeDate.value && objOldStatusChangeTime.value==objCurrentChangeTime.value) 
											{
												 
												alert("Status Change date & time should be greater than previous status Change date and time.");
												//setFocus(objCurrentChangeTime);
												return;
											}
										//else
									//if(disAllowDateTime1GreaterThanDateTime2(objOldStatusChangeDate , objOldStatusChangeTime,objCurrentChangeDate,objCurrentChangeTime,'Status Change date & time should be greater than previous status Change date and time.'))
									if(disAllowDateTime1LessThanDateTime2(objCurrentChangeDate,objCurrentChangeTime,objOldStatusChangeDate,objOldStatusChangeTime,'Status Change date & time should be greater than previous status Change date and time.'))
									return ;
									}
								}
						}
				}	 
				  }
				//Validation :Status Change Status Date & Time Can not Be Greater than Current SERVER Date & time.
				
				//integrated by harshada d for whiziblesemSP7
				//Added By AmitJ For PSPL IssueId = 22880
				//Get TimeSpan  = CurrentTime(Save OnClick) - RenderedTime(Windows_OnLoad)
			   
			   
			var dat=new Date(); 
			var hrs=dat.getHours();
			var mins=dat.getMinutes();
			var CurrentTime	;
			var TimeSpanMin;
			var TimeSpanHr;
			var TimeSpan;
			
			if (hrs < 10)
				hrs= '0'+hrs;
			if(mins < 10)
				mins='0'+mins;
				
		CurrentTime = hrs+':'+mins;	


		TimeSpanMin = mins - RenderedMin;
		TimeSpanHr = hrs - RenderedHr;
		
			if (TimeSpanMin < 0)
			{
				TimeSpanHr = TimeSpanHr - 1;
				if (TimeSpanHr < 10)
						{
						TimeSpanHr = '0'+TimeSpanHr ;
						}
						
				TimeSpanMin = 60+(TimeSpanMin) ;
							
				if (TimeSpanMin  < 10)
					{
					TimeSpanMin  = '0'+TimeSpanMin;
					}
			}
		else
			if (TimeSpanHr < 10)
						{
							TimeSpanHr = '0'+TimeSpanHr ;
						}
						
			if (TimeSpanMin  < 10)
					{
						TimeSpanMin  = '0'+TimeSpanMin;
					}
					
		TimeSpan = TimeSpanHr+':'+TimeSpanMin;	
		
		var TempObjTime ;	
		//End Of Addition  By AmitJ
					
					
				if(objCurrentChangeDate!=null && objCurrentChangeTime!=null && objDate!=null && objTime!=null )
				{
					//if(objCurrentDate.value==objOldStatusChangeDate.value
					//Added by AmitJ for PSPL ISSue 22880
					// Add TimeSpan in ObjTime.value (ServerTime @(Windows_OnLoad)) which will give ServerTime @(Save_OnClick)		
						
						TempObjTime = objTime.value;		
						
						var objTimehr,objTimeMin;
						objTimeMin = Right(objTime.value,2);
						objTimehr = Left(objTime.value,2);															
						
						if (objTimeMin < 10)
							{
								objTimeMin = Right(objTimeMin,1);
							}
						if (TimeSpanMin < 10)
							{
								TimeSpanMin = Right(TimeSpanMin,1);							
							}
							
						
						
						if (objTimehr < 10)
							{
								objTimehr = Right(objTimehr,1);
							}
							
						if(TimeSpanHr < 10)	
							{
								TimeSpanHr = Right(TimeSpanHr,1);
							}
							
						objTimeMin = parseInt(objTimeMin) + parseInt(TimeSpanMin); 
						objTimehr = parseInt(objTimehr) + parseInt(TimeSpanHr);																																									
						
						if (objTimeMin >= 60 )
							{
								objTimeMin =  objTimeMin - 60;
								objTimehr =  objTimehr + 1;	
							}
						if (objTimeMin < 10 )
							{
									objTimeMin = '0' + objTimeMin ;
							}
							
						
						if (objTimehr >= 24)	
							{
								objTimehr = parseInt(objTimehr) - 24;	
								objDate = GetObjectReference('frmRequestDetails','CurrentDate1');
								
								var TempObjDate  = objDate.value;
								 var StatusDate = new Date(objDate.value);									
									StatusDate = DateAdd(StatusDate,1,0,0);										
									var strMonths = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");																											 									
									StatusDate = StatusDate.getDate() + ', ' + Left(strMonths[StatusDate.getMonth()],3) + ' ' + StatusDate.getFullYear();  																																											
									StatusDate = GetDateInFormat(StatusDate,'dd, MMM yyyy');									
									objDate.value = StatusDate 																		
								
							}
						if (objTimehr < 10 )	
							{
								objTimehr = '0' + objTimehr;
							}					
						
						
						
					objTime.value = objTimehr +':'+objTimeMin;			
						
			// End Of Addition by AmitJ					
												
			
					if(disAllowDateTime1GreaterThanDateTime2(objCurrentChangeDate,objCurrentChangeTime,objDate,objTime,'Status Change Date & Time should not be greater than Current Server Date' + objDate.value + ' & Time.' + objTime.value))
						{
						//Added by AmitJ for PSPL ISSue 22880							
							objTime.value = TempObjTime ;
							if (TempObjDate != null)
							{
								objDate.value = TempObjDate;
							}
							
						//End of Addition by AmitJ
							return ;
						}
						
				}	
				//end of integration by harshada d
				
				if(objCurrentChangeDate!=null && objCurrentChangeTime!=null && objDate!=null && objTime!=null )
				{
					//if(disAllowDateTime1GreaterThanDateTime2(objCurrentChangeDate,objCurrentChangeTime,objDate,objTime,'Status Change Date & Time should not be greater than Current Date & Time.'))
					if(disAllowDateTime1GreaterThanDateTime2(objCurrentChangeDate,objCurrentChangeTime,objDate,objTime,'Status Change Date & Time should not be greater than Current Date & Time.'))
							return ;
				}	
				  
		}
	    // End of EDIT Mode
	
		// End Addition By PradipK for Help Desk SLA 
			//End Integration
			
					  
			if (validate()==true)
			{
			 

				objtxtSubject.disabled = false;
				objcboFunction.disabled = false;
				
				if (showSubRequest == "True")
				{
					objcboRequestType.disabled = false;
				}

				objcboSubRequestType.disabled = false;
				
				if(objcboTargetLocation != null)	
				objcboTargetLocation.disabled = false;
				/*  Modified By NitinVS on 30 Sep 2005 for WhizibleSEM SP4 IssueID 2 
					to Save the value of objtxtCRMResolutionDate need to Enable It before Save */
				if (objtxtCRMResolutionDate != null) 
					objtxtCRMResolutionDate.disabled = false;
				/* End Modification By NitinVS on 30 Sep 2005 for WhizibleSEM SP4 IssueID 2 */
									
				if (mode == "EDIT")
				{
					objcboAssignTo.disabled = false;
					objcboStatus.disabled = false;
				}	
				//added by harshada d on 31 st 2006 for issue : filters not getting set on refresh page
				if(fromwhere == "DB")
				{
				 Db_FilterID =window.opener.document.forms['frmDashboard'].elements['cboFilter'].value	;
				 //Db_FilterID =win.document.forms['frmDashboard'].elements['cboFilter'].value	;
				
				}
				//Modified by ShraddhaM on Date 15 June,2006 for WhizibleSEM Issue ID.4168
				if(fromwhere == "SR")
				{
				  if(mode=="NEW")
				  {
				  //alert(window.opener.document.forms['frmRequestList'].elements['cboFilter'].value);
						if(blnViewAccessOrHRM==0)
						{
							Sr_FilterID = window.opener.document.forms['frmRequestList'].elements['cboFilter'].value;
							DepartmentID = window.opener.document.forms['frmRequestList'].elements['cboDepartment'].value;
							StatusID = window.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
						}
						else
						{
							Sr_FilterID = window.opener.opener.document.forms['frmRequestList'].elements['cboFilter'].value;
							DepartmentID = window.opener.opener.document.forms['frmRequestList'].elements['cboDepartment'].value;
							StatusID = window.opener.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
						}
				  }
							
				  if(mode=="EDIT")
				  {			 
				  				  
						//Sr_FilterID = window.opener.document.forms['frmRequestList'].elements['cboFilter'].value;
						//DepartmentID = window.opener.document.forms['frmRequestList'].elements['cboDepartment'].value;
						//StatusID = window.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
						Sr_FilterID=win.document.forms['frmRequestList'].elements['cboFilter'].value;
						DepartmentID=win.document.forms['frmRequestList'].elements['cboDepartment'].value;
						StatusID=win.document.forms['frmRequestList'].elements['cboStatus'].value;
						//alert(Sr_FilterID);
						//alert(DepartmentID);
						//alert(StatusID);
					 
						
				  }
				}
				 
				//Ended by ShraddhaM on Date 15 June,2006 for WhizibleSEM Issue ID.4168
				if(fromwhere == "AR")
				{
			
				 //Ar_FilterID =window.opener.document.forms['frmRequestList'].elements['cboFilter'].value	;
				 //StatusID =window.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
				 Ar_FilterID =win.document.forms['frmRequestList'].elements['cboFilter'].value	;
				 StatusID =win.document.forms['frmRequestList'].elements['cboStatus'].value;
				
				}
			 
				
				objform.action = "CRM_RequestDetail.aspx?Customer=<%=m_intCustomer%>&Action=SAVE&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>";
				
				objform.submit();
				
				win.location.href=win.location.href;
				
				if(fromwhere == "DB")
				{
				window.opener.location.href="CRM_Dashboard.aspx?Action=SET_DEFAULT_FILTER&FilterID=" +Db_FilterID ;
				//win.location.href="CRM_Dashboard.aspx?Action=SET_DEFAULT_FILTER&FilterID=" +Db_FilterID ;
				}
				else if(fromwhere == "SR")
				{
							
				//window.opener.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID;
					
						if(mode == "NEW")
						{				
							if(blnViewAccessOrHRM==0)
						{
							//window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID;
							win.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID;
						}
						else
						{
							//window.opener.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID;
							win.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID;
							}
						}
						if(mode == "EDIT")
						{
							//window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID;
							win.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" +Sr_FilterID +"&DepartmentID="+DepartmentID +"&StatusID="+StatusID;
						}
					
				}
				if(fromwhere == "AR")
				{
				//window.opener.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=AR&FilterID=" +Ar_FilterID+"&StatusID="+StatusID;
				win.location.href="CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=AR&FilterID=" +Ar_FilterID+"&StatusID="+StatusID;
				}
								
			 
			//Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

				//end of addition by harshada d on 31 st of may 2006 
				
				
		/*	if(parent!=null)
               {
					window.opener.opener.location.href=window.opener.opener.location.href;
					window.opener.location.href=window.opener.location.href;
					window.opener.close();
					window.close();
				}
			  else
				 {
					window.opener.location.href=window.opener.location.href;
					window.close();
				 }*/
				 
				 
				
			}
			//harshadad for helpdesk on 07 feb 2006
			//Commented by SavitaS 
			//Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
			if(LoginType=='E')
			{
				if(mode == "NEW")
				{
				window.opener.close();
				}
			}
			 
			//Ended by ShraddhaM on Date 16 June,2006 for WhizibleSEM Issue ID.4168

			//end :harshadad for helpdesk on 07 feb 2006
			//window.opener.opener.location.href=window.opener.opener.location.href;
			
		         	
		}
		
		
		
		function AddAttachment_OnClick()
		{
			window.open ("../General/Attachment.aspx?FromWhere=CRM&ID=<%=m_lngQueryID%>&Page=../CRM/CRM_RequestDetail.aspx&QueryString=<%=Server.URLEncode("Mode=" & m_strMode & "&QueryID=" & m_lngQueryID & "&FromWhere=" & m_strFromWhere )%>","" ,"resizable=yes,scrollbars=no,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=550,height=240");
		}
		
		function DeleteAttachment_OnClick()
		{
		//Added by ManishK on 21 Feb 06 for WhizibleSem IssueID 2356 
				var objchkDelete;
				var intIndex;
				var flag;
				flag=0;
				//debugger;
				objchkDelete = GetObjectReference('objfrmRequestDetails','chkDelete',true);
				
				for(intIndex=0 ;intIndex < objchkDelete.length ;intIndex++)
				{
					if (objchkDelete[intIndex].checked==true)
					{
						flag=1;	
					}
				}
				
				if (flag==1)
				{
		//End of Added by ManishK on 21 Feb 06 for WhizibleSem IssueID 2356 	
					if (confirm("Are you sure, you want to delete the selected attachments?")==true)
						{
							objform.action = "CRM_RequestDetail.aspx?Action=DELETE_ATTACHMENTS&QueryID=<%=m_lngQueryID%>&FromWhere=<%=m_strFromWhere%>&Mode=<%=m_strMode%>";
							objform.submit();
						}
					
				}

	   }
		
		function AssignTask_OnClick()
		{
			window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&QueryID=<%=m_lngQueryID%>","_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
		}
		
		function AssignIssue_OnClick()
		{
			window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&QueryID=<%=m_lngQueryID%>","_Assignment","resizable=yes,scrollbars=no,width=550,height=500"); 
		}
		// Modified By NitinVS on 10 Aug 2005 for WhizibleSEM SP4 IssueID 2 		
		// Changed the height to 625 and Top to 75
		function Discussion_OnClick()
		{
			window.open("CRM_DiscussionThread.aspx?QueryID=<%=m_lngQueryID%>","_Discussions","resizable=yes,scrollbars=no,left=100,top=75,width=600,height=625");
		}
		// End Modification By NitinVS on 10 Aug 2005 for WhizibleSEM SP4 IssueID 2 	
		function cboFunction_OnChange()
		{
			objform.action = "CRM_RequestDetail.aspx?Customer=<%=m_intCustomer%>&RequestID=<%=m_lngQueryID%>&Status=FUNCTION_CHANGE&Mode=<%=m_strMode%>&FromWhere=<%=m_strFromWhere%>";
			if (showSubRequest =="True")
						{
							objcboRequestType.value = "";
						}
							objcboSubRequestType.value = "";
			objform.submit();
														
		}
		
		function cboStatus_OnChange()
		{
			if ("<%=m_strFromWhere%>" == "SR")
			{
				if (trimString(objcboStatus.value)== "2")
				{
					TRFeedback.style.display = "block";
					TRFeedbackComments.style.display = "block";
				}
				else
				{
					TRFeedback.style.display = "none";
					TRFeedbackComments.style.display = "none";
				}
			}
			
			//Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4262
			// Code Added By PradipK for Help Desk SLA 
				var objStatusTime= GetObjectReference('frmRequestDetails','txtchangedTime');
	var objStatusDate=GetObjectReference('frmRequestDetails','txtchangedDate');
	var objCurrentDate = GetObjectReference('frmRequestDetails','FFE29587WHIZ_CurrentDate');
	var objWhizStatusDate = GetObjectReference('frmRequestDetails','FFE29587WHIZ_txtchangedDate');
	
	//shraddha
	
	var objOldStatusChangeDate=window.document.forms['frmRequestDetails'].elements['FFE29587WHIZ_txtchangedDatehidden1'];
					 
					//objOldStatusChangeTime = GetObjectReference('frmRequestDetails','txtarea1');
	var objOldStatusChangeTime=window.document.forms['frmRequestDetails'].elements['txtchangedTimehidden1'];
					 
	
	
	//var objOldStatusChangeDate = GetObjectReference('frmRequestDetails','FFE29587WHIZ_txtchangedDatehidden1');
	
	//var objOldStatusChangeDate = GetObjectReference('frmRequestDetails','FFE29587WHIZ_txtchangedDatehidden1');
	
	//var objOldStatusChangeTime = GetObjectReference('frmRequestDetails','txtchangedTimehidden1');
	
	//var objOldStatusChangeTime = GetObjectReference('frmRequestDetails','txtchangedTimehidden1');
	
	
	var objNewStatus = GetObjectReference('frmRequestDetails','cboStatus');
	var objOldStatus = GetObjectReference('frmRequestDetails','cboStatusOld');
	var objReadOnlychangedDate = GetObjectReference('frmRequestDetails','txtReadOnlychangedDate');
		var d=new Date(); 
	var h=d.getHours();
	var m=d.getMinutes();
	//integrated by harshada d for whiziblesem sp7
	//Added By Amit J for PSPL IssueId  22880
	// Get StatusChangeTimeSpan = CurrentTime(clientTime)@(cboStatus_OnChange) - RenderedTime@(Windows_OnLoad)
	
	var StatusChangeTimeSpanHr;
	var StatusChangeTimeSpanMin;
	var StatusChangeTimeSpan;
	
	
	StatusChangeTimeSpanHr = h - RenderedHr;	
	StatusChangeTimeSpanMin = m - RenderedMin;
	//StatusChangeTimeSpanHr = h - RenderedHr;
		
		if (StatusChangeTimeSpanMin < 0)
			{
				StatusChangeTimeSpanHr = StatusChangeTimeSpanHr - 1;
				if (StatusChangeTimeSpanHr < 10)
						{
						StatusChangeTimeSpanHr = '0'+ StatusChangeTimeSpanHr ;
						}
						
				StatusChangeTimeSpanMin = 60+(StatusChangeTimeSpanMin) ;
							
				if (StatusChangeTimeSpanMin  < 10)
					{
					StatusChangeTimeSpanMin  = '0'+ StatusChangeTimeSpanMin;
					}
			}
		else
			if (StatusChangeTimeSpanHr < 10)
						{
							StatusChangeTimeSpanHr = '0'+ StatusChangeTimeSpanHr ;
						}
						
			if (StatusChangeTimeSpanMin  < 10)
					{
						StatusChangeTimeSpanMin  = '0'+ StatusChangeTimeSpanMin;
					}
					
		StatusChangeTimeSpan = StatusChangeTimeSpanHr +':'+ StatusChangeTimeSpanMin;			
	
	//End of Addition  BY AmitJ.
	//end of integration by harshada d	

	if (h<10)
		h='0'+h;
	if(m<10)
		m='0'+m;
		
    if(objOldStatus!=null && objNewStatus!=null && objOldStatusChangeDate!=null && objOldStatusChangeTime !=null && objStatusDate!=null && objStatusTime!=null ) 
		{
		
			if (objOldStatus.value==objNewStatus.value )
			{
				if (objOldStatusChangeDate.value!=objStatusDate.value || objOldStatusChangeTime.value !=objStatusTime.value )
				{
				 
					objStatusDate.value=objOldStatusChangeDate.value;
					objWhizStatusDate.value=objOldStatusChangeDate.value;
					objStatusTime.value=objOldStatusChangeTime.value;
					if(objReadOnlychangedDate!=null)
					objReadOnlychangedDate.value=objOldStatusChangeDate.value;
					
					
					
				}
				
			}
			else
			{
			
					objStatusDate.value=objCurrentDate.value;
					objWhizStatusDate.value=objCurrentDate.value;
					objStatusTime.value=h+':'+m
					if(objReadOnlychangedDate!=null)
					objReadOnlychangedDate.value=objCurrentDate.value;
					
			}
		}    	  
		
		//Added by PrashantD on 14 April 2006 for SLA
		if ((objStatusDate!= null) && (objStatusTime!= null))
		{
				if (objOldStatus.value==objNewStatus.value )
				{
				objStatusDate.value =GetObjectReference('frmRequestDetails','txtchangedDatehidden1').value;
				objStatusTime.value = GetObjectReference('frmRequestDetails','txtchangedTimehidden1').value;
				}
				else
				{
	//integrated by harshada d for whiziblesem sp7
	//Added by AmitJ For PSPL IssuId - 22880									
				// CurrentTime(servertime)@(cboStatus_OnChange)= StatusChangeTimeSpan + CurrentTime(ServerTime)@(Window_Onload)			
				objStatusTime.value = GetObjectReference('frmRequestDetails','CurrentTime').value;				
				
				var StatusHr;
				var StatusMin;					
				var StatusTime;		
					
					StatusHr = 	Left(objStatusTime.value,2);
					StatusMin = Right(objStatusTime.value,2);					
					
					if (StatusHr < 10)
						{
							StatusHr = Right(StatusHr,1);
						}
					if(StatusMin < 10)
						{
							StatusMin = Right(StatusMin,1);
						}
						
					StatusHr = parseInt(StatusHr)+ parseInt(StatusChangeTimeSpanHr);
					StatusMin = parseInt(StatusMin)	 + parseInt(StatusChangeTimeSpanMin);					
					
					
					if (StatusMin >= 60)
						{
							StatusMin = parseInt(StatusMin) - 60 ; 							
							StatusHr = parseInt(StatusHr) + 1 ;
						
						}	
							if (StatusMin < 10)
								{
									StatusMin = '0' + StatusMin;								
								}	
								
							if (StatusHr < 10)		
								{
									StatusHr = '0' + StatusHr;
								}
							
							if (StatusHr >= 24)
								{
									StatusHr = parseInt(StatusHr) - 24;	
									if (StatusHr < 10)		
										{
											StatusHr = '0' + StatusHr;
										}									
									objStatusDate.value = GetObjectReference('frmRequestDetails','CurrentDate1').value;
									var StatusDate = new Date(objStatusDate.value);									
									StatusDate = DateAdd(StatusDate,1,0,0);																												
									var strMonths = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");																											 																		
									StatusDate = StatusDate.getDate() + ', ' + Left(strMonths[StatusDate.getMonth()],3) + ' ' + StatusDate.getFullYear();  																																		
									//alert('afterconvert'+StatusDate);
									StatusDate = GetDateInFormat(StatusDate,'dd, MMM yyyy');									
									objStatusDate.value = StatusDate 
								}										
						 		objStatusTime.value = StatusHr+':'+StatusMin;  
					
				//End of Addition AmitJ
			//end of integration by harshada d	
				objStatusDate.value = GetObjectReference('frmRequestDetails','CurrentDate').value;
				objStatusTime.value=h+':'+m;
				}
			}
				
		 //End Addition By PradipK for Help Desk SLA 	
		//End Integration		
		}
		
		function cboSubRequestType_OnChange()
		{	
			objcboFunction.disabled = false;
			objform.action = "CRM_RequestDetail.aspx?Customer=<%=m_intCustomer%>&QueryID=<%=m_lngQueryID%>&Status=SUBREQUESTTYPE_CHANGE&Mode=<%=m_strMode%>&FromWhere=<%=m_strFromWhere%>";
			objform.submit();
		}
		
				
		function ViewTemplates_OnClick(SubRequestTypeID)
		{
			window.open ("CRM_OtherDetails.aspx?Mode=TEMPLATE_LIST&SubRequestTypeID=" + SubRequestTypeID ,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 350)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=350,height=300" );	
		}
				
		function window_onload()
		{ 
		
			window.moveTo(80,80);		 	
			window.resizeTo(700,500);
		 
			 
		//alert(win.document.forms['frmRequestList'].name);	 			 
		//added by PrashantD on 25 Feb for IssueID 2480
		var objcboFunction = GetObjectReference('frmRequestDetails','cboFunction');
		if (objcboFunction && objcboFunction.isDisabled == false)
		{
			objcboFunction.focus();
		}
		//End Of Addition by PrashantD
			var intDivHeight ;
			var intDivHeightRisk;
			var mode = "<%=m_strMode%>";
			var blnViewAccessOrHRM = <%=blnViewAccessOrHRM%> ;
			objcboRequestType= GetObjectReference('frmRequestDetails','cboRequestType');
			objcboSubRequestType= GetObjectReference('frmRequestDetails','cboSubRequestType');
			//objform.style.height = 1200 ;
			//integrated by harshada d for whiziblesem sp7
			//Added by AmitJ for PSPL ISSue 22880	
			//Get Current Time at the time of Onload 
			var dt=new Date(); 
			var hr=dt.getHours();
			var min=dt.getMinutes();

			if (hr<10)
				hr='0'+hr;
			if(min<10)
				min='0'+min;
		
			RenderedTime = hr+':'+min;
			RenderedMin = min;
			RenderedHr = hr;
			//End of Addition
			//end of integration by harshada d

			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 26 June,2006 for WhizibleSEM Issue ID.4168
			if(navigator.appName == 'Netscape')
			{   
					if(mode=="NEW")
					{  
					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 170;
					}
					else if(mode=="EDIT")
					{
						 
						if ("<%=m_strFromWhere%>" == "SR")						 					
						intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 180 ;
						else if ("<%=m_strFromWhere%>" == "DB")
						intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 290 ;
						else if ("<%=m_strFromWhere%>" == "AR")
						intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 290 ;
						
					}
			}

			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;	
			objcboFunction.isDisabled == false
			
			if ("<%=m_strLoginType%>" =="C")
					{
					if (objcboFunction.length==2)
						{
							objcboFunction.selectedIndex=1 ;
							objcboFunction.disabled = true;
						}
						if (showSubRequest =="True")
						{
							if (objcboRequestType.length==2)
							{
								objcboRequestType.disabled = true;
							}
						}
						
						//objcboSubRequestType.selectedIndex=1 ;
						if (objcboSubRequestType.length==2)
						{
							objcboSubRequestType.disabled = true;
						}
						
					}
			//objcboSubRequestType.selectedIndex=1 ;
			// for whiziblsem 6.0 issue id 1936 for helpdesk enhancements
			
			
			
				
			if ("<%=m_strFromWhere%>" == "DB")
				{
				if( blnViewAccessOrHRM == 0 )
				{
					objcboFunction.disabled= true ;
					objcboSubRequestType.disabled = true ;
					if (showSubRequest == "True" )
					{
					
					objcboRequestType.disabled = true ;
					}
					objcboAssignTo.disabled = true ;
				}
				else
				{					
					objcboFunction.disabled= true ;
					objcboSubRequestType.disabled = false ;
					if (showSubRequest == "True" )
					{
					
					objcboRequestType.disabled = false ;
					}
					objcboAssignTo.disabled = false ;
				}			
					
				}
			
			
			
			//Modified by ShraddhaM on Date 15 June,2006 for WhizibleSEM Issue ID.4168
			
			
			/*	if(mode == "NEW")
				{
				 alert('new');
						Sr_FilterID = window.opener.opener.document.forms['frmRequestList'].elements['cboFilter'].value;
						 
						DepartmentID = window.opener.opener.document.forms['frmRequestList'].elements['cboDepartment'].value;
						StatusID = window.opener.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
											
				}	
				if(mode == "EDIT")
				{				
				alert('Edit');
				 
						Sr_FilterID = window.opener.document.forms['frmRequestList'].elements['cboFilter'].value;
						 
						DepartmentID = window.opener.document.forms['frmRequestList'].elements['cboDepartment'].value;
						StatusID = window.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
						
						 
				}	*/
				
				//Ended by ShraddhaM on Date 15 June,2006 for WhizibleSEM Issue ID.4168
				
				
			// for whiziblsem 6.0 issue id 1936 for helpdesk enhancements
			if (<%=m_intShowMandatoryAttachmentMsg%> ==1)
			{
				alert("For the current request attachment is mandatory.\nPlease attach the required files once the request is saved.");
			}
			/*if (mode == "EDIT")
				{
					if (showSubRequest == "True" )
					{
						if (objcboRequestType.value =="")
						{
							alert("Your Role Does not have access to Request Type of this Request !" );
						}
					}
				}*/
				/*alert(window.opener.closed);
				if(window.opener.closed==false)
				{
				//alert('h');
				Sr_FilterID = window.opener.opener.document.forms['frmRequestList'].elements['cboFilter'].value;
							DepartmentID = window.opener.opener.document.forms['frmRequestList'].elements['cboDepartment'].value;
							StatusID = window.opener.opener.document.forms['frmRequestList'].elements['cboStatus'].value;
				}	*/
				
				
				//alert(window.name);	
				
		}
		
		function window_onresize()		
		{
			var mode = "<%=m_strMode%>";
			var intDivHeight;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			
			/*if(navigator.appName == 'Netscape')
			{
			 
					if(mode=="NEW")
					{    
					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 270;
					}
					else if(mode=="EDIT")
					{
						 alert('hi');
						if ("<%=m_strFromWhere%>" == "SR")						 					
						intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 400 ;
						else if ("<%=m_strFromWhere%>" == "DB")
						intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 680 ;
						else if ("<%=m_strFromWhere%>" == "AR")
						intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 680 ;
						
					}
			}*/
			objdivlist.style.height = intDivHeight;		
		}
		
		// Modified By NitinVS on 9 Aug 2005 for WhizibelSEM SP4 
		 //Added by VidyaJ for IssueID - 16585
		// Refresh and close the window
		function CloseOnClick()
		{/*
			var parent=window.opener.opener;
             if(parent!=null)
               {
					window.opener.opener.location.href=window.opener.opener.location.href;
					window.opener.location.href=window.opener.location.href;
					window.close();
				}
			  else
				 {
					window.opener.location.href=window.opener.location.href;
					window.close();
				 }
				 var parent=window.opener.opener ;
				 if(parent!=null)
               {
               window.opener.close();
                window.close();
               else
               {	*/			 
				 window.close();
				// }
	//End
	}
		// Added by NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 
		
		function Reject_Onclick()
		{ 
			//var objtxtQueryID = GetObjectReference('frmRequestDetails','txtRequestID');
			var objtxtQueryID = <%=m_lngQueryID%>
			//window.open("CRM_RequestRejection.aspx?QueryID=" + objtxtQueryID.value ,"_Rejection","resizable=no,toolbars=no,scrollbars=no,width=550,height=360" );
			window.open("CRM_RequestRejection.aspx?QueryID=" + objtxtQueryID ,"_Rejection","resizable=no,toolbars=no,scrollbars=no,width=550,height=360" );
			
		}
		// End Addition By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 
		//Integrated by SavitaS on 24 Nov 2005 for IssueID 1936
		//Added By SavitaS on 24 Nov 2005 for WhiziblesemSP4 enhancement 
		//Purpose:To allow resources to change the Department of HelpDesk Request
		
		function MoveToDept_OnClick()
		{	//debugger;	
		var intIsTaskOrIssuesCreated = <%=intIsTask_IssueCreated%>;
			 //added by harshada d on 03 Feb 2006 for helpdesk enhancements 
		 if ( intIsTaskOrIssuesCreated == 1)
			 {
		 	alert('Either Tasks ,Issues ,Deliverables or Resources are already mapped to this request ! so cannot move this request to Other Department');
			}
		 else
			 // end of addition by harshada d on 03 Feb 2006		 
			window.open("CRM_EscalateHelpDeskRequest.aspx?fromwhere=FromRD&QueryID=<%=m_lngQueryID%>","","resizable=yes,scrollbars=no,left=100,top=100,height=310,width=760"); 
		}
		//End Addition by SavitaS
		//End Integration by SavitaS
		
		//added by harshada d on 28 Nov 2005 for Show History option in CRM
		function ShowHistory_OnClick()
		{
		window.open ("../General/CommonList.aspx?&MasterTagID=3100&QueryID=<%=m_lngQueryID%>", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=600");
		}
		//end of addition by harshada d on 28 Nov 2005 for Show History option in CRM
		
		//code commentated by harshada d 30 th jan 2006 for helpdesk patch
		
		//Added by ManishK on 11th Jan 06 to add Deliverable textbox on Helpdesk page
		function AddDeliverable_OnClick()
		{
			objDeliverableID = GetObjectReference('frmRequestDetails','DeliverableID');
			if(objDeliverableID.value == ''|| objDeliverableID.value == 0)
			{
				window.open ("../PM/Create_Deliverables.aspx?FromWhere=CRM&FunctionID=<%=lngFunctionID%>&QueryID=<%=m_lngQueryID%>", "_new", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=300");
			}
			else
			{
				alert("Deliverable is already mapped to this request! ");
			}
			
	
		}
		
		//Code commented by SavitaS on 19 Jan 2006 to remove button next to deliverable text box 
		
		function SelectDeliverable()
		{
			objDeliverableID = GetObjectReference('frmRequestDetails','DeliverableID');
			window.open('../General/CommonList.aspx?MasterTagID=2176&FromWhere=CRM&DeliverableID=' + objDeliverableID.value,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=800,height=500');
	    }
		//End of Added by ManishK on 11th Jan 06 to add Deliverable textbox on Helpdesk page
		
		function ViewRejectionComments_OnClick()
		{
		window.open ("../CRM/CRM_RequestRejection.aspx?QueryID=<%=m_lngQueryID%>&FromWhere=CRM&Mode=VIEW", "", "resizable=yes,scrollbars=yes,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=300");
		}
		
		function SelectAll_OnClick()
			{
				var objchkDelete;
				var intIndex;
				objfrmRequestDetails= GetFormReference('frmRequestDetails');
				
				objchkDelete = GetObjectReference('objfrmRequestDetails','chkDelete',true);
				for(intIndex=0 ;intIndex < objchkDelete.length ;intIndex++)
				{
					if (objchkDelete[intIndex].disabled == false )
					objchkDelete[intIndex].checked=true;
				}

			}
			//added by harshada d on 05 April 2006 for Helpdesk Enhancements for whiziblesem 6
	
			function ShowSchedule_OnClick()
			{
				var objEmployee, AssignTo;
				objEmployee = GetObjectReference('frmRequestDetails','cboAssignTo');
				if(disallowBlank(objEmployee, "Please Select The Resource !", true))
				return;				
				AssignTo = objEmployee.value ;
				var startDate = objtxtHiddenServerDate.value ;
				var val = objtxtCRMResolutionDate.value ;
				//window.open("../PM/PM_ResourceSchedule.aspx?fromwhere=FromRD&QueryID=<%=m_lngQueryID%>&EmployeeID=" + AssignTo ,"","resizable=yes,scrollbars=no,left=100,top=100,height=500,width=800"); 
				window.open("../PM/PM_ResourceSchedule.aspx?QueryID=<%=m_lngQueryID%>&EmployeeIDList=" + AssignTo + "&FromDate=" + startDate + "&ToDate=" + val, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");		
			}
			//end of addition by harshada d on 05 April 2006 for Helpdesk Enhancements for whiziblesem 6
					</script>
		</form>		
	</body>
</HTML>
