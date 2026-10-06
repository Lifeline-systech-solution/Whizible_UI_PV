<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_IssueAssignmentWithActivity.aspx.vb" Inherits="PbNIT.IB_IssueAssignmentWithActivity"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmIB_IssueAssignmentWithActivity" method="post" runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
		var objtxt,intRowCount;
		var dblPrevTaskDuration;
		var objform=GetFormReference('frmIB_IssueAssignmentWithActivity');
		var objdivlist=GetObjectReference('frmIB_IssueAssignmentWithActivity','DivList');
		//Addedby HarshK for sp4 IssueID 120,121 on 11/10/2005
		var intResourceValidation = <%=m_bitResourceValidation%>;
		//alert(intResourceValidation);
		//End Addedby HarshK for sp4 IssueID 120,121 on 11/10/2005
		objtxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtRowCount');
		intRowCount=0;
		if(objtxt!=null){ intRowCount = objtxt.value; }
		
		'<%MyBase.InitializeResources("AppResources.IB_IssueAssignment", "AppResources")%>';
		    
		    <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		    
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168


			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}	
			window.resizeTo(950,500);
			window.moveTo((window.screen.width - 950)/2,(window.screen.height - 500)/2);
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}
		}
		
		function ShowSchedule_OnClick(RowNo,startDate,endDate)
		{
			var objTxt,flag,val,EmpID;
			var objSdt,objEdt;
			
			objTxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','cboEmployee' + RowNo);
			flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_RESOURCE_EMPTY")%>',true);
			if(flag==true)
				return;
				
			EmpID = objTxt.value;
			
			objTxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtDueDate');
			flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_DUE_DATE_EMPTY")%>',true);
			if(flag==true)
				return;
				
			if(endDate=='' || endDate==null)
				val = objTxt.value;
			else
				val = endDate;

            //Commented and Added by Dhanashri S on 1 Sept 2016 for PKTOKEn
			//window.open("../PM/PM_ResourceSchedule.aspx?EmployeeIDList=" + EmpID + "&FromDate=" + startDate + "&ToDate=" + val, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
			window.open("../PM/PM_ResourceSchedule.aspx?FromWhere=Issue&EmployeeIDList=" + EmpID + "&PKToken=<%=m_PKTokenEmployee%>&FromDate=" + startDate + "&ToDate=" + val, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");		
            //End of Comment and Addition by Dhanashri S on 1 Sept 2016
		}
		function ShowTimesheet_OnClick()
		{
		    
		    //PURPOSE: To open the daily activity details of the Issue.	
            //Commented and Added by Dhanashri S on 1 Sept 2016 for mastercard
		    //window.open("IB_IssueHistory.aspx?IssueID=<%=m_lngIssueID%>&Mode=TIMESHEET","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
		    window.open("IB_IssueHistory.aspx?IssueID=<%=m_lngIssueID%>&PKToken=<%=m_PKToken%>&Mode=TIMESHEET","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");					
		    //End of Comment and Addition by Dhanashri S on 1 Sept 2016
		}
				
		function ReOpenTask_OnClick(RowNo)
		{				
			var TID;
			var objTxt;
			objTxt =  GetObjectReference('frmIB_IssueAssignmentWithActivity','txtTaskID' + RowNo);
			TID = objTxt.value;
		    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
			setFrameLoader();
		    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
			objform.action = "IB_IssueAssignmentWithActivity.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_REOPEN%>&Alphabet=<%=m_strAlphabet%>&IssueID=<%=m_lngIssueID%>&TaskId=" + TID;
			objform.submit();		
		}				
		
		function Save_OnClick()
		{	
			var objTxt,i;
			var strIDList;
							
			for(i=1;i<=intRowCount;i++)
			{
				if(ValidateVisibleControls(i)==false)
					return;						
			}				
			
			//validation : if same resource and its activity is selected
			var i,j;
			var EmpID,strEmp,strActivityID,strActivity;
			
			for(i=1;i<=intRowCount;i++)
			{
				//get the employeeID and activity ID
				objTxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','cboEmployee' + i);
				EmpID = objTxt.value;
				objTxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','cboActivity' + i);	
				strActivityID = objTxt.value;
				
				for(j=i+1;j<=intRowCount;j++)
				{
					objTxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','cboEmployee' + j);	
					if(EmpID == objTxt.value)
					{
						if(objTxt.tagName=='SELECT')
							strEmp = objTxt.options[objTxt.selectedIndex].text; 
						else
						{
							objTxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','tdEmployee' + j);	
							strEmp = objTxt.innerHTML;
						}	
						
						objTxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','cboActivity' + j);							
						if(strActivityID==objTxt.value)
						{
							if(objTxt.tagName=='SELECT')
								strActivity= objTxt.options[objTxt.selectedIndex].text; 
							else
							{
								objTxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','tdActivity' + j);	
								strActivity = objTxt.innerHTML;
							}
							alert('<%=MyBase.GetResourceString("MSG_DUPLICATE_RESOURCE_ACTIVITY1")%>' + ' [' + strActivity + '] ' + '<%=MyBase.GetResourceString("MSG_DUPLICATE_RESOURCE_ACTIVITY2")%>' + ' [' + strEmp + ']');							
							return;
						}
					}
				}
			}
			
				<%' Added by NitinVS on 11 july 2007 for whizibleSEM 7 to validate for Project efforts%>

				var projectBalancehrs = <%=m_ProjectBalanceEfforts%>;
				var IssueExistingEfforts = <%=m_IssueEfforts%>;
				var issueNewEffort= 0;
				if(intRowCount >0 )
				{	
					try 
					{
						var intLen,EmpID;

							if(intRowCount > 0)
							{
								for(i=1;i<=intRowCount;i++)
								{
										objWHrs = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtWorkHrs' + i);
										issueNewEffort = issueNewEffort + parseFloat(objWHrs.value);
								}
							}
							
					}
					catch(e)
					{ return ; }
				}	
				if ( parseFloat(issueNewEffort - IssueExistingEfforts ) > parseFloat(projectBalancehrs) )			
				{
					alert("The total work (hours) of the tasks should not exceed the project work hours.Balance work hours are ("+ projectBalancehrs +") ");
					return ;
				}
				<%' End Addition by nitinvs on 11 july 2007 for whizibleSEM 7 to validate for Project efforts%>
				
				//Added By VarunA on 9-Sep-2008
	            //Purpose : To mark the task as void, which is created when the project is ON HOLD and the Assign Issue to Responsible Person is checked
	            var objProjectOnHold = GetObjectReference('frmIssueAssignment','txtProjectStatus');
	            if (objProjectOnHold != null )
	            {
	            if(objProjectOnHold.value=="1"){
	                alert("This project is 'On Hold', so you can't assign task against it.");
	            return;
	            }}
	            //End By VarunA on 9-Sep-2008
		    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
	            setFrameLoader();
		    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER							
			objform.action = "IB_IssueAssignmentWithActivity.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&Alphabet=<%=m_strAlphabet%>&IssueID=<%=m_lngIssueID%>";
			objform.submit();
		}		
				
		function WorkHrs_OnFocus(objSrc)
		{
			dblPrevTaskDuration =0;
			if(objSrc!=null)
			{
				dblPrevTaskDuration = Number(objSrc.value);
			}
		}
		function WorkHrs_OnBlur(objSrc,RowNo)
		{
			var objTxt;
			
			if(objSrc!=null)
			{	
			    UpdateIssueDurationField(objSrc);	
			    //Commented By Sagar N on 14-Mar-2019 Purpose :: Work Field Level changes
				if(IsValidTaskDuration(RowNo)==true)
				    return;			
			    //End of Commented By Sagar N on 14-Mar-2019 Purpose :: Work Field Level changes
			}
		}
		function AddNew_OnClick()
		{
			var i;
			
			for(i=1;i<=intRowCount;i++)
			{
				if(ValidateVisibleControls(i)==false)
					return;						
			}	
			
			  //Commented and Modified by SavitaS on 22 Sept 2006 for Security Issue 6197
			//objform.action = "IB_IssueAssignmentWithActivity.aspx?Mode=<%=m_strMode%>&IssueID=<%=m_lngIssueID%>&Action=<%=CONST_ACTION_ADDNEW%>";			
		    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
		    setFrameLoader();
		    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
		    objform.action = "IB_IssueAssignmentWithActivity.aspx?Mode=<%=m_strMode%>&IssueID=<%=m_lngIssueID%>&PKToken=<%=m_PKToken%>&Action=<%=CONST_ACTION_ADDNEW%>";			
			 //End of Commented and Modified by SavitaS on 22 Sept 2006 for Security Issue 6197
			objform.submit();
		}
		function Employee_OnChange(RowNo)
		{
		    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
		    setFrameLoader();
		    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
			objform.action = "IB_IssueAssignmentWithActivity.aspx?Mode=<%=m_strMode%>&IssueID=<%=m_lngIssueID%>";
			objform.submit();
		}
		function Cancel_OnClick()
		{
			var objChk,objTxt;
			var intRow,blnSelected,dblDuration,dblWork;
			blnSelected=false;
			dblDuration=0;
			dblWork=0;
			
			objTxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtDuration');
			dblDuration = objTxt.value;
			
			for(intRow=1;intRow<=intRowCount;intRow++)
			{
				objChk = GetObjectReference('frmIB_IssueAssignmentWithActivity','chkCancel' + intRow);
				if(objChk!=null)
					if(objChk.checked==true)
					{
						objTxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtWorkHrs' + intRow);
						dblWork = objTxt.value;
						dblDuration = dblDuration - dblWork;
						
						blnSelected=true;						
					}				
			}
			
			if(blnSelected==false)
			{
				alert('<%=MyBase.GetResourceString("MSG_NORECORD_SELECTED_FOR_CANCEL")%>');
				return;
			}
			else
			{
				objTxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtDuration');
				objTxt.value = dblDuration;
			}
		    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
		    setFrameLoader();
		    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
			objform.action = "IB_IssueAssignmentWithActivity.aspx?Mode=<%=m_strMode%>&IssueID=<%=m_lngIssueID%>&Action=<%=CONST_ACTION_CANCEL%>";
			objform.submit();
		}
		
		function Delete_OnClick()
		{
			var objChk,objTxt;
			var intRow,blnSelected;
			blnSelected=false;
			var dblDuration=0;
			var dblWork=0;
			
			objTxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtDuration');
			dblDuration = objTxt.value;
			
			for(intRow=1;intRow<=intRowCount;intRow++)
			{
				objChk = GetObjectReference('frmIB_IssueAssignmentWithActivity','chkDelete' + intRow);
				if(objChk!=null)
					if(objChk.checked==true)
					{
						objTxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtWorkHrs' + intRow);
						dblWork = objTxt.value;
						dblDuration = dblDuration - dblWork;
						
						blnSelected=true;						
					}				
			}
			
			if(blnSelected==false)
			{
				alert('<%=MyBase.GetResourceString("MSG_NORECORD_SELECTED_FOR_DELETE")%>');
				return;
			}
			else
			{
				objTxt = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtDuration');
				objTxt.value = dblDuration;
			}
		    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
		    setFrameLoader();
		    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
			objform.action = "IB_IssueAssignmentWithActivity.aspx?Mode=<%=m_strMode%>&IssueID=<%=m_lngIssueID%>&Action=<%=CONST_ACTION_DELETE%>";
			objform.submit();		
		}
		
		function ValidateVisibleControls(RowNo)
		{
			var objCbo;
			var objTxt;
			
			if(IsValidDueDate()==false)
				return false; 
			
			//validation for Employee: should not be empty
			objCbo = GetObjectReference('frmIB_IssueAssignmentWithActivity','cboEmployee' + RowNo);
			flag = disallowBlank(objCbo,'<%=MyBase.GetResourceString("MSG_RESOURCE_EMPTY")%>',true);
			if(flag==true)
				return false;
			
			//validation : Activity should not be empty
			objCbo = GetObjectReference('frmIB_IssueAssignmentWithActivity','cboActivity' + RowNo);
			if(objCbo.tagName=='SELECT')
			{
				flag = disallowBlank(objCbo,'<%=MyBase.GetResourceString("MSG_ACTIVITY_EMPTY")%>',true);
				if(flag==true)
					return false;
			}
			
			//validation for start date and end date
			//Validation : Reported Date <= Start Date <= End Date <= Due Date. 
			if(IsStartEndDateWithinRange(RowNo) == false)
				return false;
			
			//Validation : Not blank, Numeric, not more that 24 hours per day, multiple of 0.5 hours.
			if(IsValidTaskDuration(RowNo) == false)
				return false;
			
			//added by harshk for sp4 issueid 120,121
			if(intResourceValidation == 1)
			{
				if(ValidateResourceDates(RowNo)== false)
				{return false;}
			}
			//End added by harshk for sp4 issueid 120,121
		//Integrated By AmitJ on 03-May-2010 For WhizibleSEM9 SP1 
		//Integrated By ChaitraliH For FourSoft On 27 Jan 10
		//Commented By MonikaI For FourSoft ReqID 24076	
	        /*
		    // added By purvaj on 7 Nov 2008 for Whiziblesem8.0
		    // validation current work hours should not be less than actual work hours
		    objActualWork = GetObjectReference('frmIB_IssueAssignmentWithActivity','hid_txtActualHours'+RowNo);
		    objCurrentWork = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtWorkHrs'+RowNo);
		    if (objActualWork!=null && objCurrentWork!=null && parseFloat(objCurrentWork.value) < parseFloat(objActualWork.value))
		    {
		         alert('Planned Work hours should be greater than Actual work hours ('+objActualWork.value+').');
                 objCurrentWork.focus();
                 objCurrentWork.select();
                 return false;
		    }
    		
		    // end addition purvaj	  */	
		    //End of Commentation By MonikaI For FourSoft ReqID 24076
		    //End of Integration By ChaitraliH For FourSoft On 27 Jan 10
		    //End of Integration By AmitJ	
   //Added by TrupitK on 25 Mar 09
		      objActualStartDate=GetObjectReference('frmIB_IssueAssignmentWithActivity','hid_txtactualStartDate'+RowNo);
		      objstartDate=GetObjectReference('frmIB_IssueAssignmentWithActivity','txtStartDate'+RowNo);
		      var objcurrentenddate=GetObjectReference('frmIB_IssueAssignmentWithActivity','txtEndDate'+RowNo);
		      //Integrated By AmitJ on 03-May-2010 For WhizibleSEM9 SP1 
		      /* Commented by MonikaI for Foursoft
			   if (objActualStartDate != null)
			   {
		      if(objActualStartDate.value!='' && objstartDate.value>objActualStartDate.value)
		      {
				
				alert('Planned Start Date should not be greater than Actual Start Date('+objActualStartDate.value+')');
				return false;
		     }
		     if(objActualStartDate.value!='' && objcurrentenddate.value<objActualStartDate.value)
		      {
				
				alert('Planned End Date should not be less than Actual Start Date('+objActualStartDate.value+')');
				return false;
		     }
		     
		     }
		     End by MonikaI */
		    //End of Integration By AmitJ
		    //end if addition by TrupitK
			return true;		
		}
		
		function UpdateIssueDurationField(obj)
		{
			var dblTaskDuration;
			var dblChangeInTaskDuration;
			var flag;
			
			//Get the value in the Work (hrs) field at resource level.
			if(obj!=null)
			{
				if(obj.disabled==false)
					dblTaskDuration = new Number(obj.value);
				else
					dblTaskDuration=0.0;
					
				dblTaskDuration = dblTaskDuration.toFixed(2);
				 
				if(isNumeric(dblTaskDuration)==false)
					dblTaskDuration =0;
				
				if(isNumeric(dblPrevTaskDuration)==false)
					dblPrevTaskDuration=0;	
				
				var temp;
				//if(dblTaskDuration > 0)
					temp = dblTaskDuration - Number(dblPrevTaskDuration);
				/*else
					temp = dblPrevTaskDuration*(-1);
				*/
				dblChangeInTaskDuration = new Number(temp);											
				dblChangeInTaskDuration = Number(dblChangeInTaskDuration.toFixed(2));
				
				dblPrevTaskDuration = Number(obj.value);
				dblPrevTaskDuration = Number(dblPrevTaskDuration.toFixed(2));
			}
			
		    //Add the change value to the main Duration field.
		    /* Commented By Sagar N on  04-Mar-2019 Purpose :: Work Field level Changes
			var dblIssueDuration,objD; 
			objD = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtDuration');
			dblIssueDuration = Number(objD.value);
			
			if(isNumeric(dblIssueDuration)==false)
				dblIssueDuration =0;
			
			dblIssueDuration = dblIssueDuration + dblChangeInTaskDuration;
			objD.value = dblIssueDuration.toFixed(2);
			
			var objTD;
			objTD = GetObjectReference('frmIB_IssueAssignmentWithActivity','tdDuration');
			objTD.innerHTML = "<B>" + objD.value + "</B>";
			 * End of Commented By Sagar N on  04-Mar-2019 Purpose :: Work Field level Changes */
		}
		function IsValidDueDate()
		{
			var flag,objTxt1,objTxt2;
			var rdt;
							
			objTxt1 = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtDueDate');
			flag = disallowBlank(objTxt1,'<%=MyBase.GetResourceString("MSG_DUE_DATE_EMPTY")%>',true);
			if(flag==true)
				return false;
			
			objTxt2 = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtReportedDate');
			rdt = objTxt2.value;
			
			flag = disallowDate1LessThanDate2(objTxt1,objTxt2,'<%=MyBase.GetResourceString("MSG_DUE_DATE_LESSTHAN_RDT")%>' + rdt,true)
			if(flag==true)
				return false;
			
			return true;
		}
		
		function IsStartEndDateWithinRange(RowNo)
		{
			var objRdt,objEdt,objSdt,objDdt;
			var rdt;
			
			if(RowNo=='') return false;
			
			objSdt = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtStartDate' + RowNo);
			objEdt = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtEndDate' + RowNo);
			objDdt = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtDueDate');
			objRdt = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtReportedDate');
			rdt = objRdt.value;
			
			flag = disallowBlank(objSdt,'<%=MyBase.GetResourceString("MSG_START_DATE_EMPTY")%>',true);
			if(flag==true)
				return false;
			
			flag = disallowBlank(objEdt,'<%=MyBase.GetResourceString("MSG_END_DATE_EMPTY")%>',true);
			if(flag==true)
				return false;
			
			//Validation : Reported Date <= Start Date <= End Date <= Due Date.				
			//Validation : Reported Date <= Start Date.				
			flag = disallowDate1LessThanDate2(objSdt,objRdt,'<%=MyBase.GetResourceString("MSG_START_DATE_LESSTHAN_RDT")%>' + rdt,true);
			if(flag==true)
				return false;
			
			//Validation : Start Date <= End Date.	
			flag = disallowDate1GreaterThanDate2(objSdt,objEdt,'<%=MyBase.GetResourceString("MSG_START_DATE_GREATER_EDT")%>',true);
			if(flag==true)
				return false;
				
			//Validation : End Date <= Due Date.
			flag = disallowDate1GreaterThanDate2(objEdt,objDdt,'<%=MyBase.GetResourceString("MSG_END_DATE_GREATER_DDT")%>',true);
			if(flag==true)
				return false;
			
			return true;
		}
		function IsValidTaskDuration(RowNo)
		{	//PURPOSE: To validate the Task Duration / Work (hrs) field.
		
			var objSdt,objEdt,objWHrs;
			var sdt,edt,whrs,flag,val;
			
			objSdt = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtStartDate' + RowNo);
			objEdt = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtEndDate' + RowNo);
			objWHrs = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtWorkHrs' + RowNo);
							
			if(objSdt==null || objEdt==null || objWHrs==null) 
				return false;
			
			try
			{
				sdt = objSdt.value;
				edt = objEdt.value;
				
			    //Added by Sagar n on 14-March-2019 Purpose:: Work Field Level Changes
				whrs = objWHrs.value;
                var objVal = objWHrs.value;

                  // Commented & Added By Sagar Nipane on 01-Apr-2019 for Infinite alert loop
                // var blnResult = disallowBlank(objWHrs, "'Work (H:M)' should not be left blank.");

                //if (blnResult == true) {
                //    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
                //    //setFocus(objWHrs);
                //    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
                //    return false;
                //}

                 if (objWHrs.value == "") {
                    alert("'Work (H:M)' should not be left blank.")
                    return false
                }
                // End of Added By Sagar Nipane on 01-Apr-2019 for Infinite alert loop
                 objWHrs.value= objWHrs.value.replace(":",".");
                 var isdigit = isNumeric(objWHrs.value);
                 objWHrs.value= whrs;
                 var objVal = objWHrs.value;
                       
                 if(isdigit == false)
                 {
                     alert("Please Enter only positive numeric value For Work (hrs) in H:M format.");
                     //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
                     //setFocus(objWHrs);
                     //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
                     return false;
                 }

                  // Commented & Added By Sagar Nipane on 01-Apr-2019 for Infinite alert loop
				//if (whrs.indexOf(':') == -1) {
				//    objWHrs.value = whrs + ':00';
				//    whrs = objWHrs.value;
    //            }

                 if (whrs.indexOf('.') != -1 ) {
                        alert("Please enter Work (hrs) in H:M format.");
                        return false;
					}
					if (whrs.indexOf(':') == -1 && whrs.indexOf('.') == -1 ) {
					    objWHrs.value = whrs + ':00';
					    whrs = objWHrs.value;
                    }
                    // End of Added By Sagar Nipane on 01-Apr-2019 for Infinite alert loop

			  
				objWHrs.value = whrs.replace(":", ".");		
			    //End of Added by Sagar n on 14-March-2019 Purpose:: Work Field Level Changes

				flag = disallowBlank(objWHrs,'<%=MyBase.GetResourceString("MSG_WORKHRS_BLANK")%>',true);
				if(flag==true)
				{
				    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
				    //objWHrs.focus();
				    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
					return false;						
				}

			    //Added by Sagar n on 14-March-2019 Purpose:: Work Field Level Changes
				objWHrs.value = whrs.replace(".", ":");
			    //End of Added by Sagar n on 14-March-2019 Purpose:: Work Field Level Changes

				//Validation : Is Numeric Value. [Work (hrs)]
				
			   
			    //Commented By Sagar N. on 04-Mar-2019 Purpose :: Work Field Level Changes
			    //flag = disallowNonNumeric(objWHrs,'<%=MyBase.GetResourceString("MSG_WORKHRS_NONNUMERIC")%>',true);
			    //if(flag==true)
				//{
				//	objWHrs.focus();
				//	return false;						
				//}
				
				//whrs = Number(objWHrs.value);
			    // End of Commented By Sagar Nipane on 15-March-2019 for allowing to enter only hours 

				if(whrs<=0) 
				{
					alert('<%=MyBase.GetResourceString("MSG_WORKHRS_ZERO")%>');
				    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
				    //objWHrs.focus();
				    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
					return false;
				}
				
			    //Validation : Is Positive Numeric Value. [Work (hrs)]	

			    //Commented By Sagar N. on 04-Mar-2019 Purpose :: Work Field Level Changes
				//flag = disallowNegativeNumeric(objWHrs,'<%=MyBase.GetResourceString("MSG_WORKHRS_NONPOSITIVE")%>',true);
				//if(flag==true)
				//{
				//	objWHrs.focus();
				//	return false;						
				//}
			    // End of Commented By Sagar Nipane on 15-March-2019 for allowing to enter only hours 

			    //  Added By Sagar Nipane on 15-March-2019 for allowing to enter only hours 

			    objWHrs.value = whrs.replace(":", ".");

			    var blnResult = disallowSpecialCharacters(objWHrs, "Please enter Work (hrs) in H:M format.");

			    if (blnResult == true) {
			        objWHrs.value = objWHrs.value.replace('.', ':');
			        objWHrs.value = objVal;
			        //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
			        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
			        //setFocus(objWHrs);
			        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
			        //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
			        return false;
			    }

			    blnResult = disallowNonNumeric(objWHrs, "Please enter Work (hrs) in H:M format.");

			    if (blnResult == true) {
			        objWHrs.value = objVal;
			        //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
			        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
			        //setFocus(objWHrs);
			        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
			        //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
			        return false;
			    }
			    objWHrs.value = whrs.replace(".", ":");
			  
			    var mins = objWHrs.value.split(':')
			    if(mins[1] == "")
			    {
			        objWHrs.value=objVal;
			        alert("Please enter Work (hrs) in H:M format.");
			        //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
			        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
			        //setFocus(objWHrs);
			        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
			        //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
			        return false;
			    }
			    var hrs = objWHrs.value.split(":")[0];

                if(hrs.indexOf("-") != -1)
                            {
                            alert('Hours should not be less than or equal to zero (0).');
                             //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                             //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
                            //setFocus(objWHrs);
                            //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
                            //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                            return false;
                }

			    if(hrs <= 0 && mins[1]<=0)
			    {
			        objWHrs.value = objVal;
			        alert('Hours should not be less than or equal to zero (0).');
			        //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
			        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
			        //setFocus(objWHrs);
			        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
			        //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
			        return false;
			    }
			    if(mins[1].length == 1 && mins[1] > 5)
			    {
			        mins[1] = mins[1] + "0";
			    }			    
			    
			    // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
			    if (mins[1].length > 2) {
			        alert("Please enter minutes in two decimal and less than 60.");
			        return false;
			    }
			    // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015

                if (mins[1] >= 60) {
			        objWHrs.value = objVal;
			        alert("Please enter minutes between range (0-59)");
			        //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
			        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
			        //setFocus(objWHrs);
			        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
			        //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
			        return false;
                }

			    if (objWHrs.value.indexOf(":") == -1) {
			        //alert("Please enter efforts in valid format H:M!!");
			        //setFocus(objHMEffort);
			        //return false;
			        objWHrs.value = whrs + ':00';
			        whrs = objWHrs.value;
			    }
			    
			   
			    objWHrs.value = objWHrs.value.replace('.', ':');
			    // End of Added By Sagar Nipane on 15-March-2019 for allowing to enter only hours 

				

			    //  Added By Sagar Nipane on 15-March-2019 for allowing to enter only hours 
			    var MinDAENtryDisplay = "";
			    var MinDAEntry = "<%=CommonFunctions.Application.MinHoursForDAEntry%>";
                    
                 var RestrictByMinHours = '<%= m_RestrictByMinHours %>';
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

                    
			    if (MinDAEntry == 0.016) {
                        
			    }
			    else {
			        if (RestrictByMinHours == 'True') {

			            var minutes = objWHrs.value.split(':');
			            var p = minutes[0];
			            var dec = minutes[1];

			            if (dec == undefined) { dec = 0; }
			            d = (dec - 0) / 60 + (p - 0);

			            if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {

			                alert("Please enter the work hrs. in multiple of min. work hrs (" + MinDAENtryDisplay + ")");
			                //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
			                //setFocus(objWHrs);
			                //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop

			                return false;
			            }
			        }

			        var workHrs = objWHrs.value.replace(':', '.');

			        //if (workHrs >= 24 || workHrs < 0.15) {
			        //    alert('Please enter Work (hrs) between range (0:15-23:45)');
			        //    return false;
			        //}
			    }
			    //  End of Added By Sagar Nipane on 15-March-2019 for allowing to enter only hours 


			    //Validation : Is a multiple of 0.5 hours. [Work (hrs)]
			
			   
			    val = <%=CommonFunctions.Application.MinHoursForDAEntry%> * 1; 
			    if((whrs % val) > 0)
			    {
			    alert('<%=MyBase.GetResourceString("MSG_RANGE_WORKHRS1")%>'+ ' ' + val + ' ' + '<%=MyBase.GetResourceString("MSG_RANGE_WORKHRS2")%>' + '\r\n' + '<%=MyBase.GetResourceString("MSG_RANGE_WORKHRS3")%>' + ' ' + val + ' ' + '<%=MyBase.GetResourceString("MSG_RANGE_WORKHRS4")%>');
			        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
			        //objWHrs.focus();
			        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
			    return false;
			    }

			    

				var dsdt = getDate(sdt);
				var dedt = getDate(edt);
				var NoOfDays = DateDiff(dsdt,dedt,"D");	
				// Added by GaneshD on 21 Sep 2009 for WhizibleSem 9.0 IssueId-33258
				if (NoOfDays>0) {NoOfDays=NoOfDays+1;}
				//End of addition by GaneshD	
				if(NoOfDays==0) { NoOfDays=1; }				
				
			    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
				//var HrsPerDay = new Number(whrs / NoOfDays );
				var HrsPerDay = new Number((whrs.replace(':', '.')) / NoOfDays);
			    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop


				HrsPerDay = HrsPerDay.toFixed(2); 
				
				if(HrsPerDay > 24)
				{
				    alert('<%=MyBase.GetResourceString("MSG_HOURSPERDAY_EXCEEDS")%>');
				    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
				    //objWHrs.focus();
				    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
					return false;
				}
				
				return true;
			}
			catch(e)
			{ return false; }
		}
		
		function DateDiff( start, end, interval, rounding ) 
		{
			var iOut = 0;
								
			// Create 2 error messages, 1 for each argument.</KBD> 
			var startMsg = "Check the Start Date and End Date\n"
				startMsg += "must be a valid date format.\n\n"
				startMsg += "Please try again." ;
	
			var intervalMsg = "Sorry the dateAdd function only accepts\n"
				intervalMsg += "d, h, m OR s intervals.\n\n"
				intervalMsg += "Please try again." ;
			
			var bufferA = Date.parse( start ) ;
			var bufferB = Date.parse( end ) ;
    		
			// check that the start parameter is a valid Date. </KBD>
			if ( isNaN(bufferA) || isNaN(bufferB) )
			{
				alert( startMsg ) ;
				return null ;
			}

			// check that an interval parameter was not numeric.</KBD> 
			if ( interval.charAt == 'undefined' ) 
			{
				// the user specified an incorrect interval, handle the error.</KBD> 
				alert( intervalMsg ) ;
				return null ;
			}

			var number = bufferB-bufferA ;

			// what kind of add to do?</KBD> 
			switch(interval.charAt(0))
			{
				case 'd': case 'D': 
					iOut = parseInt(number / 86400000) ;
					if(rounding) iOut += parseInt((number % 86400000)/43200001) ;
						break ;
				case 'h': case 'H':
					iOut = parseInt(number / 3600000 ) ;
					if(rounding) iOut += parseInt((number % 3600000)/1800001) ;
					break ;
				case 'm': case 'M':
					iOut = parseInt(number / 60000 ) ;
					if(rounding) iOut += parseInt((number % 60000)/30001) ;
					break ;
				case 's': case 'S':
					iOut = parseInt(number / 1000 ) ;
					if(rounding) iOut += parseInt((number % 1000)/501) ;
					break ;
				default:
					// If we get to here then the interval parameter
					// didn't meet the d,h,m,s criteria.  Handle
					// the error.</KBD> 		
					alert(intervalMsg) ;
					return null ;
			}

			return iOut ;
		}			
		//Added by HarshK for sp4 issueid 120,121
			function GetResourceDate(intEmpID,strWhichDate)
			{
				var objSDateCbo = GetObjectReference('frmIB_IssueAssignmentWithActivity','cboResourceSDT');
				var objEDateCbo = GetObjectReference('frmIB_IssueAssignmentWithActivity','cboResourceEDT');
				var intIndex ;
				for(intIndex = 0; intIndex < objSDateCbo.length ; intIndex++)
				{	
					if(objSDateCbo[intIndex].value == intEmpID)
					{
						if(strWhichDate == 'START')
						{
							return objSDateCbo[intIndex].text;
						}
						else
						{
							return objEDateCbo[intIndex].text;
						}
					}
				}

			}
			
			function CheckResourceDates(strTaskSDt,strTaskEDt,objCboResource)
			{
				var strResourceSDt,strResourceEDt;
				var dtTaskSDt,dtTaskEDt,dtResourceSDt,dtResourceEDt;
				var intIndx;
				
				dtTaskSDt = getDate(strTaskSDt);
				dtTaskEDt = getDate(strTaskEDt);
				if(objCboResource != null)
				{
					if(objCboResource.type != 'hidden')
					{
						strResourceSDt = GetResourceDate(objCboResource[objCboResource.selectedIndex].value,'START');
						strResourceEDt = GetResourceDate(objCboResource[objCboResource.selectedIndex].value,'END');
					}
					else
					{
						strResourceSDt = GetResourceDate(objCboResource.value,'START');
						strResourceEDt = GetResourceDate(objCboResource.value,'END');	
					}
					if(strResourceSDt != null && strResourceEDt != null)
					{
						dtResourceSDt = getDate(strResourceSDt);
						dtResourceEDt = getDate(strResourceEDt);
						if(DateDiff(dtTaskSDt, dtResourceSDt, "d")>0)
						{
							strMsg = "<%=MyBase.GetResourceString("MSG_RESOURCE_SDT")%>";
							strMsg = replaceSubstring(strMsg, '<=>', strResourceSDt);
							strMsg = replaceSubstring(strMsg, '<==>', strResourceEDt);
							alert(strMsg);
							return false;
						}
						if(DateDiff(dtResourceEDt, dtTaskEDt, "d")>0)
						{
							strMsg = "<%=MyBase.GetResourceString("MSG_RESOURCE_SDT")%>";
							strMsg = replaceSubstring(strMsg, '<=>', strResourceSDt);
							strMsg = replaceSubstring(strMsg, '<==>', strResourceEDt);						
							alert(strMsg);
							return false;
						}
					}
				}
				return true;
			}
			function ValidateResourceDates(intRowNo)
			{
				try
				{	
					
					var objEmp = GetObjectReference('frmIB_IssueAssignmentWithActivity','cboEmployee' + intRowNo);
					var objTSDT = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtStartDate' + intRowNo);
					var objTEDT = GetObjectReference('frmIB_IssueAssignmentWithActivity','txtEndDate' + intRowNo);
					if(objTSDT != null && objTEDT != null)
					{
						if(CheckResourceDates(objTSDT.value,objTEDT.value,objEmp)== false)
						return false;
					}
							
				}
				catch(e)
				{ }
				
			}
			//End Added by HarshK for sp4 issueid 120,121
	</Script>
	</body>
</HTML>

<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>


<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function()
    {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0)
        {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if($('.clsgridtable').length > 0)
        {
            var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
            dataCollapse(divName);
        }
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth=$(window).width();
        if(windowWidth < 992 )
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass='responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass='gridTabsOuterTable';
        if(windowWidth < 992)
        {
            responsiveNavigationTabs(responsiveNavigationClass,responsiveNavigationParentTblClass);
        }
        else
        {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display','block');
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
        $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function(){
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:10/02/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-FooterMenuDropDown
        // Description:Creating DropDown for Sub Table Footer Menu on Window Resize
        // By Whom: Miiint
        // When:28/05/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-FooterMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth=$(window).width();
        if(windowWidth < 992)
        {

        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        responsiveNavigationTabsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-collapse & close for tablet view
        // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
        // By Whom: Miiint
        // When:17/02/2015
        /*---------------------------------------------------------*/
        collapseDivsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-collapse & close for tablet view
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->