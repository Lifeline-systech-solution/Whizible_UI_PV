<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_SQERTDemo.aspx.vb" Inherits="PbNIT.PM_SQERTDemo" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%
	MyBase.InitializeResources("AppResources.PM_SQERT", "AppResources")
	CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("CAPTION_PROJECTSHEET"))%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<TABLE height="55" cellSpacing="0" cellPadding="0" width="52" border="0" ms_2d_layout="TRUE">
			<TR>
				<TD width="0" height="0"></TD>
				<TD width="10" height="0"></TD>
				<TD width="42" height="0"></TD>
			</TR>
			<TR vAlign="top">
				<TD width="0" height="15"></TD>
				<TD colSpan="2" rowSpan="2">
					<form id="frmPM_SQERT" method="post" runat="server">
						<TABLE height="35" cellSpacing="0" cellPadding="0" width="11" border="0" ms_2d_layout="TRUE">
							<TR vAlign="top">
								<TD width="10" height="15"></TD>
								<TD width="1"></TD>
							</TR>
							<TR vAlign="top">
								<TD height="20"></TD>
								<TD>
									<%BuildPage()%>
								</TD>
							</TR>
						</TABLE>
					</form>
				</TD>
			</TR>
			<TR vAlign="top">
				<TD width="0" height="40"></TD>
				<TD>
					<Script language="javascript">
		var objform=GetFormReference('frmPM_SQERT');
		var objdivlist=GetObjectReference('frmPM_SQERT','PageDiv');
		
		var objcboCategoryId = GetObjectReference('objform','cboCategoryID');
		var objcboBUId = GetObjectReference('objform','cboBUID');
		var objcboOUId = GetObjectReference('objform','cboOUID');
		var objcboProgramId = GetObjectReference('objform','cboProgramID');
		var objcboProjectId = GetObjectReference('objform','cboProjectID');
		var objtxtReportingDate = GetObjectReference('objform','txtReportingDate');
		var objoptReportingPeriod = GetObjectReference('objform','optReportingPeriod');
		//var objtxtLastLockedDate = GetObjectReference('objform','txtLastLockedDate');
		//Modified By ShraddhaM on 26,Sept 2006 for FireFox
		var objtxtLastLockedDate = window.document.forms['frmPM_SQERT'].elements['txtLastLockedDate'];
		
		var intVal;
		
		function cboProject_change()
		{
				objform.action="PM_SQERTDemo.aspx?Mode=Change"
				objform.submit();
		}
		
		function cboCategory_change()
		{
				objform.action="PM_SQERTDemo.aspx?Mode=Change"
				objform.submit();
		}
		
		function cboBU_change()
		{
				objform.action="PM_SQERTDemo.aspx?Mode=Change"
				objform.submit();
		}
		function cboOU_change()
		{
				objform.action="PM_SQERTDemo.aspx?Mode=Change"
				objform.submit();
		}
		function cboProgram_change()
		{
				objform.action="PM_SQERTDemo.aspx?Mode=Change"
				objform.submit();
		}
		function ShowGraphLink_onClick()
		{
			window.open("PM_SQERTDemo.aspx?Mode=TrendGraph&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",height=430,width=605");
		}
		function UpdateSQERTValues_Click()
		{
			//	alert(objtxtReportingDate.value + objcboProjectId.value );
			//	window.open("PM_SQERTDemo.aspx?Mode=SQERTVALUES&txtReportingDate='<%=m_dtmReportingEndDate%>'&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				 

				if (objcboProjectId.value == '' ||  objtxtReportingDate.value == '')
				{
					alert("Please select Project and the Reporting Date.");
					objcboProjectId.focus();
				}	
				else
				{
				 
					if(objtxtLastLockedDate.value != '')
					{
						var intDateDiff;
						intDateDiff = DateDiff(getDate(objtxtReportingDate.value),getDate(objtxtLastLockedDate.value),"D");


						if("<%=m_intSessionPostId%>" != "7")
						{
							if (objcboProjectId.value == <%=m_intSessionProjectId%> && intDateDiff >= 0)
							{
								//open window with disabled mode
								window.open("PM_SQERTDemo.aspx?Action=Disabled&Mode=SQERTVALUES&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=525,width=750");
							//	return;
							//	alert ("open window with disabled mode 1");
							}	
							else
							{
								window.open("PM_SQERTDemo.aspx?Mode=SQERTVALUES&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=525,width=750");
							//	return;
							//	alert ("open window with enabled mode 2 ");
							}
						}	
						else
						{
							if (intDateDiff >= 0)
							{
								window.open("PM_SQERTDemo.aspx?Action=Disabled&Mode=SQERTVALUES&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=525,width=750");
								//return;
								//alert ("open window with disabled mode 3");
							}
							else
							{
								window.open("PM_SQERTDemo.aspx?Mode=SQERTVALUES&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=525,width=750");
								//return;
								//alert ("open window with enabled mode 4");
							}
						}	
					}
					else
					{
						//alert("got no locked value!");					
						if("<%=m_intSessionPostId%>" != "7")
						{
						//	alert("user other than 7");					
							if (objcboProjectId.value == <%=m_intSessionProjectId%>)
							{
							//	open window with disabled mode
								window.open ("PM_SQERTDemo.aspx?Action=Disabled&Mode=SQERTValues&cboProject=" & objcboProjectId.value & "&txtReportingDate=" & objtxtReportingDate.value  & "&chkDateCriteria=" & intVal , "" ,"resizable=yes,scrollbars=yes,Left=0,Top=0,height=525,width=750");
								//return;
							//	alert ("open window with disabled mode");
							}	
							else
							{
								window.open ("PM_SQERTDemo.aspx?Mode=SQERTValues&cboProject=" & objcboProjectId.value & "&txtReportingDate=" & objtxtReportingDate.value  & "&chkDateCriteria=" & intVal , "" ,"resizable=yes,scrollbars=yes,Left=0,Top=0,height=525,width=750");
								//return;
							//	alert ("open window with enabled mode");
							}
						}	
						else
						{
								window.open ("PM_SQERTDemo.aspx?Mode=SQERTValues&cboProject=" & objcboProjectId.value & "&txtReportingDate=" & objtxtReportingDate.value  & "&chkDateCriteria=" & intVal , "" ,"resizable=yes,scrollbars=yes,Left=0,Top=0,height=525,width=750");
								//return;
							//alert ("open window with enabled mode");
						}
					}
				}
		}
		
		
	function SaveSQERT_OnClick()
	{
	
		var objDesc = GetObjectReference('objform','txtScopeDesc');
		
		//ADDED BY VIVEKP ON 26 SEP 2005
		
		   if (isNumeric(GetObjectReference('objform','txtScope').value)!=true)
					{
						alert('\'Scope\' should be  numeic or float only.');
						setFocus(GetObjectReference('objform','txtScope'));
						return;
					}
			 if (isNumeric(GetObjectReference('objform','txtQuality').value)!=true)
					{
						alert('\'Quality\' should be  numeic or float only.');
						setFocus(GetObjectReference('objform','txtQuality'));
						return;
					}
		//END OF ADDITION BY VIVEKP 

			 if (Trim(document.forms[0].txtScope.value) == ""  || Trim(document.forms[0].txtQuality.value) == "" || Trim(document.forms[0].txtScopeDesc.value) == "" || Trim(document.forms[0].txtQualityDesc.value) == "" || Trim(document.forms[0].txtEffortDesc.value) == "" || Trim(document.forms[0].txtRiskDesc.value) == "" || Trim(document.forms[0].txtTimeDesc.value) == "" ) 
		{
			alert("Please enter all mandatory 'Description' fields.");
			return;
		}

			 if (parseInt(Trim(document.forms[0].txtScope.value)) < parseInt(Trim(document.forms[0].txtscopelow.value)) || parseInt(Trim(document.forms[0].txtScope.value)) > parseInt(Trim(document.forms[0].txtscopehigh.value))) 
		{
			     alert("Please enter scope in range " + Trim(document.forms[0].txtscopelow.value) + " to " + Trim(document.forms[0].txtscopehigh.value));
			frmPM_SQERT.txtScope.focus();
			return;
		}
	
			 if (parseInt(Trim(frmPM_SQERT.txtQuality.value)) < parseInt(Trim(document.forms[0].txtqualitylow.value)) || parseInt(Trim(frmPM_SQERT.txtQuality.value)) > parseInt(Trim(document.forms[0].txtqualityhigh.value))) 
		{
			     alert("Please enter quality in range " + Trim(document.forms[0].txtqualitylow.value) + " to " + Trim(document.forms[0].txtqualityhigh.value));
			frmPM_SQERT.txtQuality.focus();
			return;
		}	

		if (disallowMaxlengthViolation(GetObjectReference('objform','txtScopeDesc'),500,'Max Length of this field is 500 characters.',true))
		{
			frmPM_SQERT.txtScopeDesc.focus();
			return;
		}
		
		if (disallowMaxlengthViolation(GetObjectReference('objform','txtQualityDesc'),500,'Max Length of this field is 500 characters.',true))
		{
			frmPM_SQERT.txtQualityDesc.focus();
			return;
		}

		if (disallowMaxlengthViolation(GetObjectReference('objform','txtRiskDesc'),500,'Max Length of this field is 500 characters.',true))
		{
			frmPM_SQERT.txtRiskDesc.focus();
			return;
		}
		
		if (disallowMaxlengthViolation(GetObjectReference('objform','txtEffortDesc'),500,'Max Length of this field is 500 characters.',true))
		{
			frmPM_SQERT.txtEffortDesc.focus();
			return;
		}

		if (disallowMaxlengthViolation(GetObjectReference('objform','txtTimeDesc'),500,'Max Length of this field is 500 characters.',true))
		{
			frmPM_SQERT.txtTimeDesc.focus();
			return;
		}

		EnableControls(); 
		
		document.forms[0].action="PM_SQERTDemo.aspx?Mode=SaveSQERTValues&ProjectID=<%=m_strProjectID%>&Action=Update"
	    document.forms[0].submit()
	}
	
	function AddNew_OnClick()
	{
	    document.forms[0].action="PM_SQERTDemo.aspx?Mode=SaveSQERTValues&Action=Add&ProjectID=<%=m_strProjectID%>"
	    document.forms[0].submit()
	}
	
	function ShowHistory_OnClick()
	{
		window.open("PM_SQERTDemo.aspx?Mode=ShowHistory&ProjectID=<%=m_strProjectID%>", "" ,"resizable=yes,scrollbars=yes,Left=0,Top=0,height=500,width=850");
	}
	
	function ViewReport_Click()
	{
		//CODE COMMENTED BY VIVEKP ON 20 SEP 2005
		/*	if (objcboCategoryId.value == '' && objcboBUId.value == '' && objcboProgramId.value == '' && objcboProjectId.value == '')
			{
				alert("Atleast one value out of the given four combo boxes must be selected.");
				objcboCategoryId.focus();
				return;
			}
		*/	
		//END OF CODE COMMENTING BY VIVEKP ON 20 SEP 2005
		
			if (objtxtReportingDate.value == '')
			{
				alert("Reporting date should not be left blank.");
				objform.focus();
				return;
			}
			
			/*	Commented By NitinVS on 14 Oct 2005 Resource Timesheet Frequency is to be shown 
			for(var i=0;i < 3;i++)
			{
				if(document.all("optReportingPeriod")[i].checked)
					intVal = document.all("optReportingPeriod")[i].value;
			} */
			 var intVal = GetObjectReference('objform','txtReportingFrequency').value;

			//window.open("PM_SQERTDemo.aspx?Mode=ViewReport&cboCategoryID=" + objcboCategoryId.value + "&cboProgramID=" + objcboProgramId.value + "&cboProjectID=" + objcboProjectId.value + "&cboBUID=" + objcboBUId.value + "&txtReportingDate='" + objtxtReportingDate.value + "'&optReportingPeriod=" + intVal , "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 650)/2 + ",height=650,width=900");
			window.open("PM_SQERTDemo.aspx?Mode=ViewReport&cboCategoryID=" + objcboCategoryId.value + "&cboProgramID=" + objcboProgramId.value + "&cboProjectID=" + objcboProjectId.value + "&cboBUID=" + objcboBUId.value + "&cboOUID=" + objcboOUId.value + "&txtReportingDate=" + objtxtReportingDate.value + "&optReportingPeriod=" + intVal , "" ,"resizable=yes,scrollbars=no,Left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 650)/2 + ",height=650,width=900");
	}
	
	function DetailsLink_onClick(strFlag)
	{
	
		switch(strFlag)
		{
			case "SQERT" :
				window.open("PM_SQERTDemo.aspx?Mode=SQERTDetails&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "Risk" :
				window.open("PM_SQERTDemo.aspx?Mode=RISK&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>", "" ,"resizable=yes,scrollbars=yes,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "TotalIssues" :
				window.open("PM_SQERTDemo.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=1", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "OpenIssues" :
				window.open("PM_SQERTDemo.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=2", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
				<% 'Added By Padmnabh to Display Issues Reported by Customer %>
			case "CustReportedIssues" :
				window.open("PM_SQERTDemo.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=5", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
				<% 'Addition By Padmnabh Ends %>
			case "ClosedIssues" :
				window.open("PM_SQERTDemo.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=3", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "OverDueIssues" :
				window.open("PM_SQERTDemo.aspx?Mode=ISSUEDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=4", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "CompletedTasks" :
				window.open("PM_SQERTDemo.aspx?Mode=TASKDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=2", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "TobeCompletedTasks" :
				window.open("PM_SQERTDemo.aspx?Mode=TASKDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=3", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break; 
			case "SLIPPINGTASKS" :
				window.open("PM_SQERTDemo.aspx?Mode=TASKDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=6", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break; 
			case "CompletedDeliverables" :
				window.open("PM_SQERTDemo.aspx?Mode=DELIVERABLESDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=8", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "SlippingDeliverables":
				window.open("PM_SQERTDemo.aspx?Mode=DELIVERABLESDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=10", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
			case "TobeCompletedDeliverables":
				window.open("PM_SQERTDemo.aspx?Mode=DELIVERABLESDETAILS&txtReportingDate=<%=m_dtmReportingEndDate%>&optReportingPeriod=<%=m_intReportingPeriod%>&cboCategoryID=<%=m_strCategoryID%>&cboBUID=<%=m_strBUID%>&cboOUID=<%=m_strOUID%>&cboProgramID=<%=m_strProgramID%>&cboProjectID=<%=m_strProjectId%>&blnFlag=12", "" ,"resizable=no,scrollbars=no,Left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=700");
				break;
		}
	
	}
		
		function Close_Click()
		{
			window.close();
		}
		
		//The div tag has id as PageDiv 
		 //Modified by JyotiG on Date 11 July,2006 for WhizibleSEM Issue ID.4168
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			if(navigator.appName == 'Netscape')
			{
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 2210;
			
			}
			objdivlist.style.height = intDivHeight +'px';	}			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}
		}	
		
		function OnlyNumeric(intAllowDecimal)
		{
			var KeyAscii = window.event.keyCode;
			
			if (intAllowDecimal==1 && KeyAscii == 46 && KeyAscii == 45)
			{
			return;
			}
			
			else
			{
			if ( KeyAscii < 45 || KeyAscii > 57 ) 
				{ window.event.keyCode = 0; } 
			}	
		}
	
		function EnableControls()
		{
			GetObjectReference('objform','txtEffort').disabled=false;
			GetObjectReference('objform','txtRisk').disabled=false;
			GetObjectReference('objform','txtTime').disabled=false;
		}
		
		function SQERTProjectLink_onClick(intProjectID, intReportingPeriod, strReportedDate)
		{
			//alert ("PM_SQERTDemo.aspx?Mode=ViewReport&cboProjectID=" + intProjectID + "&txtReportingDate='" + strReportedDate + "'&optReportingPeriod=" + intReportingPeriod , "" ,"resizable=yes,scrollbars=no,Left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 650)/2 + ",height=650,width=900")
			window.open("PM_SQERTDemo.aspx?Mode=ViewReport&cboProjectID=" + intProjectID + "&txtReportingDate=" + strReportedDate + "&optReportingPeriod=" + intReportingPeriod , "" ,"resizable=yes,scrollbars=no,Left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 650)/2 + ",height=650,width=900");
		}
		function SQERTEVOnclick(intProjectID,StartDate,EndDate)
		{
		
		window.open("../PM/PM_EarnedValueReport.aspx?MasterTagId=2047&strID=0&strType=1&Mode=Generate&FromDate=" + StartDate + "&ToDate=" + EndDate + "&ProjectID=" + intProjectID, "" ,"resizable=yes,scrollbars=no,Left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 650)/2 + ",height=650,width=900");
		
		}
					</Script>
				</TD>
			</TR>
		</TABLE>
	</body>
</HTML>
