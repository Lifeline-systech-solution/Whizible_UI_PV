<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_IssueAssignment.aspx.vb" Inherits="PbNIT.IB_IssueAssignment"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
 

	<body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize()" onload="window_onload()">
	
					<form id="frmIssueAssignment" name="frmIssueAssignment" method="post" runat="server">
						
									<%PageInit()%>
							
					</form>
				
					<script language="javascript">
			var objdivlist;
			var objform;
			var objtxt,intRowCount;
			var dblPrevTaskDuration;
			//Addedby HarshK for sp4 IssueID 120,121 on 11/10/2005
			var intResourceValidation = <%=m_bitResourceValidation%>;
			//End Addedby HarshK for sp4 IssueID 120,121 on 11/10/2005
			 //***** added by SandipL on 6 Dec 2005 -- To handle Conditional Editable Date Control
			 var blnDateEditable  = '<%=m_blnDateEditable%>'
			 //***** End addition by SandipL on 6 Dec
			objform = GetFormReference('frmIssueAssignment');
			objdivlist = GetObjectReference('frmIssueAssignment','DivList');
			objtxt = GetObjectReference('frmIssueAssignment','txtRowCount');
			intRowCount=0;
			if(objtxt!=null){ intRowCount = objtxt.value; }
			
			'<%MyBase.InitializeResources("AppResources.IB_IssueAssignment", "AppResources")%>';
			
			<%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
			
			 //Modified by JyotiG on Date 11 July,2006 for WhizibleSEM Issue ID.4168
			function window_onload()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				var mode = "<%=m_strMode%>" ;
			
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)
				intDivHeight = 100;
				if(navigator.appName == 'Netscape')
				{
					intDivHeight = window.innerHeight  - objdivlist.offsetTop -40;
				}

				objdivlist.style.height = intDivHeight	+'px';			
			}
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
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
				if (intDivHeight < 100)
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight	 +'px';	
			}
			function ShowSchedule_OnClick(EmpID,startDate,endDate,PKtOKEN)
			{
			   
				var objTxt,flag,val;
				var objSdt,objEdt;
				
				objTxt = GetObjectReference('frmIssueAssignment','txtDueDate');
				flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_DUE_DATE_EMPTY")%>',true);
				if(flag==true)
					return;
					
			/*	var objSdt = GetObjectReference('frmIssueAssignment','txtStartDate' + EmpID);
				var objEdt = GetObjectReference('frmIssueAssignment','txtEndDate' + EmpID);
				
				if(objSdt!=null && objEdt!=null)
				{					
					if(objSdt.value != '' && objEdt.value !='')
					{
						startDate = objSdt.value;
						val = objEdt.value;
					}
					else
					{	val = objTxt.value;	 }
				}
				else
				{
					if(endDate=='' || endDate==null)
						val = objTxt.value;				
				}*/
				if(endDate=='' || endDate==null)
					val = objTxt.value;
				else
					val = endDate;

				window.open("../PM/PM_ResourceSchedule.aspx?EmployeeIDList=" + EmpID + "&PKToken="+PKtOKEN+"&FromDate=" + startDate + "&ToDate=" + val, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 540)/2 + ",width=800,height=540");		
			}
					    
			function ShowTimesheet_OnClick()
			{
			       
			  //Commented and Modified by SavitaS on 22 Sept 2006 for Security Issue 6197
				//PURPOSE: To open the daily activity details of the Issue.	
				//window.open("IB_IssueHistory.aspx?IssueID=<%=m_lngIssueID%>&Mode=TIMESHEET","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");		
				window.open("IB_IssueHistory.aspx?IssueID=<%=m_lngIssueID%>&PKToken=<%=m_PKToken%>&Mode=TIMESHEET","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");		
		      //End of Commented and Modified by SavitaS on 22 Sept 2006 for Security Issue 6197
			}
			function ShowAll_OnClick()
			{
				if(ValidateVisibleControls()==false)
					return;
				//Modified by SavitaS on 22 Sept 2006 for Whiziblesem Security IssueID 6197	
				//objform.action = "IB_IssueAssignment.aspx?Mode=<%=CONST_SHOW_ALL%>&Alphabet=<%=m_strAlphabet%>&IssueID=<%=m_lngIssueID%>" ;
			    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
			    setFrameLoader();
			    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
			    objform.action = "IB_IssueAssignment.aspx?Mode=<%=CONST_SHOW_ALL%>&Alphabet=<%=m_strAlphabet%>&IssueID=<%=m_lngIssueID%>&PKToken=<%=m_PKToken%>" ;
				//End of Modified by SavitaS on 22 Sept 2006 for Whiziblesem Security IssueID 6197
				objform.submit();		
			}
			function ShowAssignedTo_OnClick()
			{
			  		if(ValidateVisibleControls()==false)
			  		    return;
                //Commented and added by Nilesh g on 29/3/2016 for PKtoken
			  		//objform.action = "IB_IssueAssignment.aspx?Mode=<%=CONST_SHOW_ASSIGNED%>&Alphabet=<%=m_strAlphabet%>&IssueID=<%=m_lngIssueID%>";
			    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
			    setFrameLoader();
			    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
			    objform.action = "IB_IssueAssignment.aspx?Mode=<%=CONST_SHOW_ASSIGNED%>&PKtokenShowAssignResource=<%=PKtokenShowAssignResource%>&Alphabet=<%=m_strAlphabet%>&IssueID=<%=m_lngIssueID%>";
			    //End of Commented and added by Nilesh g on 29/3/2016 for PKtoken
			    objform.submit();		
			}
			function ReOpenTask_OnClick(TID)
			{				
			    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
			    setFrameLoader();
			    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
			    objform.action = "IB_IssueAssignment.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_REOPEN%>&Alphabet=<%=m_strAlphabet%>&IssueID=<%=m_lngIssueID%>&TaskId=" + TID;
				objform.submit();		
			}
			function Show_OnClick()
			{
			    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
			    setFrameLoader();
			    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
			    objform.action = "IB_IssueAssignment.aspx?Mode=<%=m_strMode%>&IssueID=<%=m_lngIssueID%>";
				objform.submit();		
			}
			function Paging_OnClick(str)
			{
				var objFlt;
				objFlt = GetObjectReference('frmIssueAssignment','txtFilter');
				objFlt.value='';
				
			    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
				setFrameLoader();
			    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
				objform.action = "IB_IssueAssignment.aspx?Mode=<%=m_strMode%>&IssueID=<%=m_lngIssueID%>&Alphabet=" + str;
				objform.submit();	
			}
			// fn.. to display the calendar control
			//function callcalendar(formname,datefield)
			function callcalendarLocal(formname,datefield)
			{
				var objdateObject=GetObjectReference(formname,datefield)
				var dtval,objChk,strID,EmpID;
				if(objdateObject!=null)
				{
					strID = new String(objdateObject.id);
					var intLen = strID.length;
					var strTmp;
					
					if(strID != 'txtDueDate')
					{
						if(strID.indexOf('txtEndDate',0)== -1) 
							strTmp = new String('txtStartDate');
						else
							strTmp = new String('txtEndDate');
												
						EmpID = strID.substring(strTmp.length,intLen);
										
						objChk = getCheckboxRef(EmpID);
						if(objChk!=null)
						{						
							if(objChk.checked==true)
							{
								if(objdateObject.value =='')
									dtval='None';	
								else
									dtval=objdateObject.value;
								 
								 callcalendar(formname,datefield);	
								//calendar_window=window.open('../General/Calendar.aspx?datefield=' + datefield +'&formname=' + formname + '&dateval=' + dtval,'calendar_window','top=0,left=0,width=230,height=188');calendar_window.focus()
							}
							else
								alert('<%=MyBase.GetResourceString("MSG_RESOURCE_NOT_SELECTED")%>');						
						}
					}
					else
					{
						dtval=objdateObject.value; 
						//calendar_window=window.open('../General/Calendar.aspx?datefield=' + datefield +'&formname=' + formname + '&dateval=' + dtval,'calendar_window','top=0,left=0,width=230,height=188');calendar_window.focus()									
						callcalendar(formname,datefield);
					}
				}				
			}
			function getCheckboxRef(EmpID)
			{
				var intLen,objChk;
				if(EmpID!=null)
				{
					objChk = GetObjectReference('frmIssueAssignment','chkAssignTo',true);
					if(objChk!=null)
					{	
						if(objChk.length > 1)
						{
							var i;
							intLen = objChk.length;
							for(i=0;i<intLen;i++)
								if(objChk[i].value==EmpID)
									return objChk[i];
							
							return null;
						}
						else if(objChk.length<=1)
						{	
							if(objChk[0].value==EmpID)
								return objChk[0];
							else
								return null;
						}
					}
					else
						return null;
				}
				else
					return null;
			}
			function Save_OnClick()
			{	
				var objTxt;
				var strIDList;
				
				//Check if at least one resource has been selected for issue assignement.
				objTxt = GetObjectReference('frmIssueAssignment','txtCurrentIDList');
				strIDList = objTxt.value;
				//Added and modified by Shraddha M on 9,Oct 2009 wrong alert comes while deselecting resource..
				var objOldIDs = GetObjectReference('frmIssueAssignment','txtOldAssignedToIDList');
				var OldIDs = '';
				if(objOldIDs)
				OldIDs = objOldIDs.value;
				
				//if(strIDList == '' || strIDList == ',')
				if((strIDList == '' || strIDList == ',') && (OldIDs == '' || OldIDs == ',') )
				{
					alert('<%=MyBase.GetResourceString("MSG_NO_RESOURCE_SELECTED")%>');
					return;
				}
				//Ended addition and modification by Shraddha M
				
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
				
				if(ValidateVisibleControls()==false)
					return;
			    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
				setFrameLoader();
			    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
				objform.action = "IB_IssueAssignment.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&Alphabet=<%=m_strAlphabet%>&IssueID=<%=m_lngIssueID%>";
				objform.submit();
				
				//Added by NitinC on 27 September 2011 for WhizibleSEM v10.0 [Agile Prioritization]
				refreshParent('frmCommonList','EditEfforts_CommonList.aspx','../PM/EditEfforts_CommonList.aspx?Flag=IBReturn&MasterTagID=9001&FromWhere=PM&IssueID=<%=m_lngIssueID%>');
				//End of Added by NitinC on 27 September 2011 for WhizibleSEM v10.0 [Agile Prioritization]
              
			}		
			function Clear_OnClick()
			{
				var objFlt;
				objFlt = GetObjectReference('frmIssueAssignment','txtFilter');
				objFlt.value='';
			    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
				setFrameLoader();
			    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
				objform.action = "IB_IssueAssignment.aspx?Mode=<%=m_strMode%>&Alphabet=<%=m_strAlphabet%>&IssueID=<%=m_lngIssueID%>";
				objform.submit();		
			}
			function chkAssignTo_OnClick(objChk)
			{ 
				var EmpID = objChk.value;
				var edt,sdt,ddt,rdt;
				var strIDList;
				
				var objSdt = GetObjectReference('frmIssueAssignment','txtStartDate' + EmpID);
				var objEdt = GetObjectReference('frmIssueAssignment','txtEndDate' + EmpID);
				var objWHrs = GetObjectReference('frmIssueAssignment','txtWorkHrs' + EmpID);
				var objDdt = GetObjectReference('frmIssueAssignment','txtDueDate');
				//***** Code added by SandipL on 3 Dec 2005 -- Editable Date Control Issue 
				//Modified and Added By VarunA on 3-Oct-2008 IssueID-22525
				//Purpose : To have default StartDate and EndDate in Mozilla
				if(document.all)
				{
				//End By VarunA on 3-Oct-2008 IssueID-22525
				    var objFFE29587WHIZ_Sdt = GetObjectReference('frmIssueAssignment','FFE29587WHIZ_txtStartDate' + EmpID);
				    var objFFE29587WHIZ_Edt = GetObjectReference('frmIssueAssignment','FFE29587WHIZ_txtEndDate' + EmpID);
				    var objFFE29587WHIZ_Ddt = GetObjectReference('frmIssueAssignment','FFE29587WHIZ_txtDueDate');
				//Modified and Added By VarunA on 3-Oct-2008 IssueID-22525
				//Purpose : To have default StartDate and EndDate in Mozilla
				    var objFFE29587WHIZ_Rdt = GetObjectReference('frmIssueAssignment','FFE29587WHIZ_txtReportedDate');	
				}
				else
				{
                    //Commented and Added by Dhanashri S on 30 Nov 2015
				    //var objFFE29587WHIZ_Sdt = GetObjectReference('frmIssueAssignment','FFE29587WHIZ_txtStartDate' + EmpID,true);
			        //var objFFE29587WHIZ_Edt = GetObjectReference('frmIssueAssignment','FFE29587WHIZ_txtEndDate' + EmpID,true);
			        //var objFFE29587WHIZ_Ddt = GetObjectReference('frmIssueAssignment','FFE29587WHIZ_txtDueDate',true);
			        //var objFFE29587WHIZ_Rdt = GetObjectReference('frmIssueAssignment','FFE29587WHIZ_txtReportedDate',true);	

				    var objFFE29587WHIZ_Sdt = document.getElementById('FFE29587WHIZ_txtStartDate' + EmpID);
				    var objFFE29587WHIZ_Edt = document.getElementById('FFE29587WHIZ_txtEndDate' + EmpID);
				    var objFFE29587WHIZ_Ddt = document.getElementById('FFE29587WHIZ_txtDueDate');
				    var objFFE29587WHIZ_Rdt = document.getElementById('FFE29587WHIZ_txtReportedDate');	
                    //End of Comment and Addition by Dhanashri S on 30 Nov 2015
				}
				//End By VarunA on 3-Oct-2008 IssueID-22525
				//***** End addition  by SandipL on 3 Dec 2005
				//Added by PrashantD on 15 March 2007 for IssueID 11586
				if(objWHrs!=null)			
				{
				    objWHrs.disabled=false;
				    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
				    //objWHrs.focus();
				    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
				}
				//End of addition by PrashantD on 15 March 2007	
				
				//If the resource has been added to the list, then...
				if(objChk.checked==true)
				{  	var objTxt = GetObjectReference('frmIssueAssignment','txtDueDate');
					
				   	flag = disallowBlank(objTxt,'<%=MyBase.GetResourceString("MSG_DUE_DATE_EMPTY")%>',true);
					if(flag==true)
						return;

					//WHEN THE ISSUE IS ASSIGNED TO THE RESOURCE...
					//----------------------------------------------
						
					//Step 1.	Add the Employee ID in the comma separated list of Employee IDs.
					//If the Employee ID is NOT found in the comma separated list, then...	
					var objIDList = GetObjectReference('frmIssueAssignment','txtCurrentIDList');
					strIDList = new String(objIDList.value);
					if(strIDList.indexOf("," + EmpID + ",",0)==-1)
					{
						strIDList = strIDList + EmpID + ",";
						objIDList.value = strIDList; 
					}    
					
					//***** Code modified by SandipL on 6 Dec 2005 - Conditional Editable Date Control
					objRdt = GetObjectReference('frmIssueAssignment','txtReportedDate');
					//Commented By VarunA on 3-Oct-2008 IssueID-22525
					//objFFE29587WHIZ_Rdt = GetObjectReference('frmIssueAssignment','FFE29587WHIZ_txtReportedDate');	
					//End By VarunA on 3-Oct-2008 IssueID-22525						
					
					//Added by MrugajaB on 30th June 2006 for WhizibleSEM Issue ID.4168
					//Commented By VarunA on 3-Oct-2008 IssueID-22525
				    //Purpose : To have default StartDate and EndDate in Mozilla and unnecessary popup of start date was coming
					//if(navigator.appName != 'Netscape')
					//{
					//End By VarunA on 3-Oct-2008 IssueID-22525
						if(blnDateEditable == 'True')
						objFFE29587WHIZ_Sdt.disabled=false;
						else  
							objSdt.disabled=false;
					  
					
					 //***** End modification by SandipL on 6 Dec 2005
					if(objSdt.value!='')
					{
						if(objRdt.value !='' && objDdt.value!='')
						{
							sdt = new Date(objSdt.value);
							rdt = new Date(objRdt.value);
							ddt = new Date(objDdt.value);
							if(rdt <= sdt <= ddt)									
							{	/*keep previous date*/	}
							else
							{	
							    objSdt.value =  objRdt.value; 
							    //***** Code added by SandipL on 3 dec 2005 --Editable Date Control Issue
							    if(blnDateEditable == 'True')
							    objFFE29587WHIZ_Sdt.value = objFFE29587WHIZ_Rdt.value;
							    						    
							    //***** End addition by SandipL  on 3 dec 2005
							 }
						}
					}	
					else
					{	objSdt.value = objRdt.value;
					      //***** Code added by SandipL on 3 dec 2005 --Editable Date Control Issue
					     if(blnDateEditable == 'True')
					    objFFE29587WHIZ_Sdt.value = objFFE29587WHIZ_Rdt.value;
					      //***** End addition by SandipL on 3 dec 2005
					 }
						
					sdt = new Date(objSdt.value);
					
					//***** Code modified by SandipL on 6 dec 2005 --For Conditional editable DateControl
					if(blnDateEditable == 'True')
					objFFE29587WHIZ_Edt.disabled=false;
					else
					objEdt.disabled=false;
					//***** End Modification by SandipL on 6 dec 2005
					
					var prevEdt = objEdt.value;
									
					//***** Code added by SandipL on 6 dec 2005 --To handle Conditional Editable Date Control
					var prevWhiz_Edt ;
					if(blnDateEditable == 'True')
					prevWhiz_Edt = objFFE29587WHIZ_Edt.value;
					 //***** End addition by SandipL on 6 Dec 2005
					 
					if(objEdt.value!='')
					{
						edt = new Date(objEdt.value);
						if(sdt > edt)
							{
							objEdt.value = objSdt.value;
							  //***** Code added by SandipL on 3 dec 2005 --Editable Date Control Issue
							if(blnDateEditable == 'True')
							objFFE29587WHIZ_Edt.value = objFFE29587WHIZ_Sdt.value;
							 //***** End addition by SandipL on 3 dec 2005 
							}
							
						if(objRdt.value!='' && objDdt.value !='')
						{
							rdt = new Date(objRdt.value);
							ddt = new Date(objDdt.value);

							if(rdt <= edt <= ddt)
							{	/*keep previous date*/ }
							else
							{	objEdt.value = prevEdt; 
							 //***** Code added by SandipL on 3 dec 2005 --IssueID 672
							    if(blnDateEditable == 'True')
							    objFFE29587WHIZ_Edt.value = prevWhiz_Edt ;
							     //***** End addition by SandipL on 3 dec 2005 
							}
						}
					}
					else
					{	objEdt.value = objDdt.value;
					    //***** Code added by SandipL on 3 dec 2005 --IssueID 672
					     if(blnDateEditable == 'True')
					     objFFE29587WHIZ_Edt.value = objFFE29587WHIZ_Ddt.value;
					     //***** End addition by SandipL on 3 dec 2005
					 }
					//Commented By VarunA on 3-Oct-2008 IssueID-22525
				    //Purpose : To have default StartDate and EndDate in Mozilla and unnecessary popup of start date was coming
					//}
					//End By VarunA on 3-Oct-2008 IssueID-22525
					//End Addition by MrugajaB
					//The Issue Duration value must be updated.												
					//Update the main Issue Work (hrs) field.
					dblPrevTaskDuration=0;
		
					objWHrs.disabled=false;
					UpdateIssueDurationField(objWHrs);
									
				}
				else	//Else, if the resource has been removed from the list, then
				{

					//Remove the Employee ID in the comma separated list of Employee IDs.
					//If the Employee ID is found in the comma separated list, then...
					var objIDList = GetObjectReference('frmIssueAssignment','txtCurrentIDList');
					strIDList = new String(objIDList.value);
					 
					if(strIDList.indexOf("," + EmpID +",",0) != -1)
					{
						//Remove the Employee ID from the comma separated list.
						strIDList = replaceSubstring(strIDList,"," + EmpID + ",","," );
						objIDList.value = strIDList; 
					}    
					
					//The Issue Duration value must be updated.												
					//Add the difference between the old and new values to the main Issue Duration field.														
					dblPrevTaskDuration = objWHrs.value;
					//***** Code modified by SandipL on 6 Dec 2005 --To Handle Conditional Date Control
					if(blnDateEditable == 'True')
					{
					objFFE29587WHIZ_Sdt.disabled=true;
					objFFE29587WHIZ_Edt.disabled=true;
					objWHrs.disabled=true;
					}
					else
					{
					objSdt.disabled=true;
					objEdt.disabled=true;
					objWHrs.disabled=true;
					}
					//***** End Modification by SandipL on 6 Dec 2005
					UpdateIssueDurationField(objWHrs);					
				}
				objSdt=null;
				objEdt=null;
				//***** Code added by SandipL on 6 Dec 2005 --Editable Date Control Issue
				objFFE29587WHIZ_Sdt=null;
				objFFE29587WHIZ_Edt=null;
				//***** End addition by SandipL on 6 Dec 2005
				objWHrs=null;
			}
			function WorkHrs_OnFocus(objSrc)
			{
				dblPrevTaskDuration =0;
				if(objSrc!=null)
				{
					dblPrevTaskDuration = Number(objSrc.value);
				}
			}
			function WorkHrs_OnBlur(objSrc,EmpID)
			{
				if(objSrc!=null)
				{
				//Added by PrashantD on 3 April 2007 for IssueID 11586
				objSdt = GetObjectReference('frmIssueAssignment','txtStartDate' + EmpID);
				objEdt = GetObjectReference('frmIssueAssignment','txtEndDate' + EmpID);
				objChk = GetObjectReference('frmIssueAssignment','chkAssignTo',true);
				var c=0;
				while(c<objChk.length)
				{
					if (objChk[c].value == EmpID)
					break;
					c++;
				}
				if(c > objChk.length || objChk[c].checked == false)
				return;
				
			    if (isBlank(objSdt.value))
			    {
				    alert("Please enter 'start date'");
				    return;
			    }
			    else if (isBlank(objSdt.value))
			    {
				    alert("Please enter 'end date'");
				    return;
			    }			
				//End of addition by PrashantD
					UpdateIssueDurationField(objSrc);
					 //Commented by Sagar N on 04-Mar-2019 Purpose :: Work Field level Changes
					if(IsValidTaskDuration(EmpID)==true)
						return false;
                    //End of Commented by Sagar N on 04-Mar-2019 Purpose :: Work Field level Changes
				}
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
						dblTaskDuration=0;
						
					if(isNumeric(dblTaskDuration)==false)
						dblTaskDuration =0;
					
					if(isNumeric(dblPrevTaskDuration)==false)
						dblPrevTaskDuration=0;	
					
					var temp;
					temp = dblTaskDuration - Number(dblPrevTaskDuration);
					
					dblChangeInTaskDuration = new Number(temp);											
					dblChangeInTaskDuration = Number(dblChangeInTaskDuration.toFixed(2));
					
					dblPrevTaskDuration = Number(obj.value);
					
				}
				//Add the change value to the main Duration field.
				var dblIssueDuration,objD; 
				objD = GetObjectReference('frmIssueAssignment','txtDuration');
				dblIssueDuration = Number(objD.value);
				
				if(isNumeric(dblIssueDuration)==false)
				    dblIssueDuration =0;

			    /* Commented By Sagar N on  04-Mar-2019 Purpose :: Work Field level Changes
				//objD.value = dblIssueDuration  + dblChangeInTaskDuration;
				 * End of Commented By Sagar N on  04-Mar-2019 Purpose :: Work Field level Changes */
				//var objTD;
				//objTD = GetObjectReference('frmIssueAssignment','tdDuration');
				//objTD.innerHTML = "<B>" + objD.value + "</B>";
				
			}
			function IsValidDueDate()
			{
				var flag,objTxt1,objTxt2;
				var rdt;
								
				objTxt1 = GetObjectReference('frmIssueAssignment','txtDueDate');
				flag = disallowBlank(objTxt1,'<%=MyBase.GetResourceString("MSG_DUE_DATE_EMPTY")%>',true);
				if(flag==true)
					return false;
				
				objTxt2 = GetObjectReference('frmIssueAssignment','txtReportedDate');
				rdt = objTxt2.value;
				
				flag = disallowDate1LessThanDate2(objTxt1,objTxt2,'<%=MyBase.GetResourceString("MSG_DUE_DATE_LESSTHAN_RDT")%>' + rdt,true)
				if(flag==true)
					return false;
				
				return true;
			}
			function ValidateVisibleControls()
			{
				if(IsValidDueDate()==false)
					return false;
					
				if(intRowCount >0)
				{	
					try 
					{
						var intLen,EmpID;
						var intAlertFlag;
						
						var objChk = GetObjectReference('frmIssueAssignment','chkAssignTo',true);
						var objActualWork;
						var objCurrentWork;
						if(objChk != null)
						{
							intLen = objChk.length;	
							//***** Code Commented and modified by SandipL on 6 Dec 2005 -- To solve Last resource Validation problem
							if(intLen > 0)
							{
								for(i=0;i<intLen;i++)
								{
							    // added By purvaj on 7 Nov 2008 for Whiziblesem8.0
							    // validation current work hours should not be less than actual work hours
								    intAlertFlag = 0;
								// End addition purvaJ
									if(objChk[i].checked==true)
									{
										EmpID = objChk[i].value;

										//Validation : Reported Date <= Start Date <= End Date <= Due Date. 
										if(IsStartEndDateWithinRange(EmpID) == false)
											return false;
												
										//Validation : Not blank, Numeric, not more that 24 hours per day, multiple of 0.5 hours.
                                        if (IsValidTaskDuration(EmpID) == false) {
                                            return false;
                                             //Added By Sagar N. on 04-Mar-2019 Purpose :: Work Field Level Changes
                                            break;
                                            //End of Added By Sagar N. on 04-Mar-2019 Purpose :: Work Field Level Changes
                                        }
											
										// added By purvaj on 7 Nov 2008 for Whiziblesem8.0
										// validation current work hours should not be less than actual work hours
										objActualWork = GetObjectReference('frmIssueAssignment','hid_txtActualHours'+EmpID);
										objCurrentWork = GetObjectReference('frmIssueAssignment','txtWorkHrs'+EmpID);
									    //Modified by vidyak on 09 Sep 2010 for Planned Effort related Alert Disaply on Restrict Duration/Work Change for Assigned tasks flag.
		                                //Added if(TaskRistValidation == "True")
		                                 var TaskRistValidation = "<%=CommonFunctions.Application.RestrictDurationChange_O%>";
		                                 if(TaskRistValidation == "True")
		                                 {
										    if (objActualWork!=null && objCurrentWork!=null && parseFloat(objCurrentWork.value) < parseFloat(objActualWork.value))
										    {
										         alert('Planned Work hours should be greater than Actual work hours ('+objActualWork.value+').');
										        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
										         //objCurrentWork.focus();
										        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
		                                         objCurrentWork.select();
		                                         intAlertFlag = 1;
		                                         return false;
										    }
										}//end if(TaskRistValidation == "True")
//Added by TruptiK on 25 Mar 09
										var objactualstartdate=GetObjectReference('frmIssueAssignment','hid_txtActualstartDate'+EmpID);
										var objstartDate=GetObjectReference('frmIssueAssignment','txtStartDate'+EmpID);
										var objcurrentenddate=GetObjectReference('frmIssueAssignment','txtEndDate'+ EmpID);
										dtcurrentenddate=getDate(objcurrentenddate.value); 
										
										var dtactualstartdate=getDate(objactualstartdate.value);
										var dtstartDate=getDate(objstartDate.value);
										
										if(objactualstartdate.value !='' && dtstartDate>dtactualstartdate)
										{
											
											alert('Planned Start Date should not be greater than Actual Start Date('+objactualstartdate.value+')');
											 intAlertFlag = 1;
		                                     return false;
										}
										
										if (objcurrentenddate!=null && objactualstartdate.value!='' && dtcurrentenddate < dtactualstartdate)
										{
											alert('Current End Date should not be less than Actual Start Date ('+objactualstartdate.value +').');
											intAlertFlag = 1;
											return false;
										}
		
										//End of addition by TruptiK on 25 Mar 09
										
										// end addition purvaj
									}									
								}
								// added By purvaj on 7 Nov 2008 for Whiziblesem8.0
							    // validation current work hours should not be less than actual work hours
								if (intAlertFlag == 1)
								    return false;
								// end addition purvaj
							}
						/*	else //Else, if single element exists, then...
							{
								if(objChk.checked==true)
								{
									EmpID = objChk.value;
									//Validation : Reported Date <= Start Date <= End Date <= Due Date. 
									if(IsStartEndDateWithinRange(EmpID) == false)
										return false;
									//Validation : Not blank, Numeric, not more that 24 hours per day, multiple of 0.5 hours.
									if(IsValidTaskDuration(EmpID) == false)
										return false;
								}
							} */
							
						//***** End Comment and Modification by SandipL on 6 Dec 2005	
						}
					//modified by harshK for sp4 issueid 120,121
						//return true;
					}
					catch(e)
					{ return false; }
				}
				if(intResourceValidation == 1)
				{
					if(ValidateResourceDates() == false)
					{
						return false; 
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
						var objChk = GetObjectReference('frmIssueAssignment','chkAssignTo',true);
						if(objChk != null)
						{
							intLen = objChk.length;	
							if(intLen > 0)
							{
								for(i=0;i<intLen;i++)
								{
									if(objChk[i].checked==true)
									{
										EmpID = objChk[i].value;
										objWHrs = GetObjectReference('frmIssueAssignment','txtWorkHrs' + EmpID);
										issueNewEffort = issueNewEffort + parseFloat(objWHrs.value);
									
									}									
								}
							}
							
						}
					}
					catch(e)
					{ return false; }
				}	
				if ( parseFloat(issueNewEffort - IssueExistingEfforts ) > parseFloat(projectBalancehrs) )			
				{
					alert("The total work (hours) of the tasks should not exceed the project work hours.Balance work hours are ("+ projectBalancehrs +") ");
					return false;
				}
				<%' End Addition by nitinvs on 11 july 2007 for whizibleSEM 7 to validate for Project efforts%>
				
				//End modified by harshK for sp4 issueid 120,121
				return true;
				
			}
			/*added by harshk on 22/08/2005 sp4 issueID 120,121 */
			function IsStartEndDateWithinProjectDateRange(objSdt,objEdt)
			{
				
				var objcboPDt,dtPS,dtPE,dtTempSdt,dtTempEdt,strMessage;
				objcboPDt=GetObjectReference('frmIssueAssignment','cboProjectDates');
				dtPS= getDate(objcboPDt[1].text);dtPE= getDate(objcboPDt[2].text);
				dtTempSdt=getDate(objSdt.value);
				dtTempEdt= getDate(objEdt.value);
				if(DateDiff(dtTempSdt,dtPS,"d")>0)
				{
					strMessage='<%=MyBase.GetResourceString("MSG_START_DATE_GREATER_PROJECT_SDT")%>';
					strMessage = replaceSubstring(strMessage, '<=>', objcboPDt[1].text);
					alert(strMessage);
					return true;
				}
				if(DateDiff(dtPE,dtTempEdt,"d")>0)
				{
					strMessage='<%=MyBase.GetResourceString("MSG_START_DATE_GREATER_PROJECT_EDT")%>';
					strMessage = replaceSubstring(strMessage, '<=>', objcboPDt[2].text);
					alert(strMessage);
					return true;
				}
				return false;
			}
			/*End harshk on 22/08/2005 sp4 issueID 120,121 */
			function IsStartEndDateWithinRange(EmpID)
			{
				var objRdt,objEdt,objSdt,objDdt;
				var rdt;
				
				if(EmpID=='') return false;
				
				objSdt = GetObjectReference('frmIssueAssignment','txtStartDate' + EmpID);
				objEdt = GetObjectReference('frmIssueAssignment','txtEndDate' + EmpID);
				objDdt = GetObjectReference('frmIssueAssignment','txtDueDate');
				objRdt = GetObjectReference('frmIssueAssignment','txtReportedDate');
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
				//added by harshk sp4 issueID 120,121 */
				//Validation : start date and end date between project start and end date.
				flag = IsStartEndDateWithinProjectDateRange(objSdt,objEdt);
				if(flag==true)
					return false;
					
				//End added by harshk sp4 issueID 120,121 */
				return true;
			}

			function IsValidTaskDuration(EmpID)
			{	//PURPOSE: To validate the Task Duration / Work (hrs) field.
			
				var objSdt,objEdt,objWHrs;
				var sdt,edt,whrs,flag,val;
				
				objSdt = GetObjectReference('frmIssueAssignment','txtStartDate' + EmpID);
				objEdt = GetObjectReference('frmIssueAssignment','txtEndDate' + EmpID);
				objWHrs = GetObjectReference('frmIssueAssignment','txtWorkHrs' + EmpID);
								
				if(objSdt==null || objEdt==null || objWHrs==null) 
					return false;
				
				try
				{
					sdt = objSdt.value;
					edt = objEdt.value;
					whrs = objWHrs.value
					
				    
                       // Added By Sagar Nipane on 15-March-2019 for allowing to enter only hours 
                    // Commented & Added By Sagar Nipane on 01-Apr-2019 for Infinite alert loop
     //               flag = disallowBlank(objWHrs,"'Work (H:M)' should not be left blank.",true);
					//if(flag==true)
					//{
					//    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
					//    //objWHrs.focus();
					//    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
					//	return false;						
     //               }		
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
     //               }

                     if (whrs.indexOf('.') != -1 ) {
                        alert("Please enter Work (hrs) in H:M format.");
                        return false;
					}
					if (whrs.indexOf(':') == -1 && whrs.indexOf('.') == -1 ) {
					    objWHrs.value = whrs + ':00';
					    whrs = objWHrs.value;
                    }
                    // End of Added By Sagar Nipane on 01-Apr-2019 for Infinite alert loop

				    // End of Added By Sagar Nipane on 15-March-2019 for allowing to enter only hours 
					
					objWHrs.value = whrs.replace(":", ".");
		
				    // Added By Sagar Nipane on 15-March-2019 for allowing to enter only hours 
					objWHrs.value = whrs.replace(".", ":");
                   
				    // End of Added By Sagar Nipane on 15-March-2019 for allowing to enter only hours 

                    //Commented & Added By Sagar N. on 04-Mar-2019 Purpose :: Work Field Level Changes
					//Validation : Is Numeric Value. [Work (hrs)]
					//flag = disallowNonNumeric(objWHrs,'<%=MyBase.GetResourceString("MSG_WORKHRS_NONNUMERIC")%>',true);
					//if(flag==true)
					//{
					//	objWHrs.focus();
					//	return false;						
					//}
					
					<%' Modified By NitinVS on 23 July 2007 for WhizbleSEM 7 work hrs are float%>
                    //whrs = Number(objWHrs.value);
                    
				   
					if(whrs <= 0 ) 
					{
					<%' End Modification By NitinVS on 23 July 2007 for WhizbleSEM 7 work hrs are float%>
					
						alert('<%=MyBase.GetResourceString("MSG_WORKHRS_ZERO")%>');
					    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
					    //objWHrs.focus();
					    //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
						return false;
					}
					
					//Validation : Is Positive Numeric Value. [Work (hrs)]	
					//flag = disallowNegativeNumeric(objWHrs,'<%=MyBase.GetResourceString("MSG_WORKHRS_NONPOSITIVE")%>',true);
					//if(flag==true)
					//{
					//	objWHrs.focus();
					//	return false;						
					//}
				    objWHrs.value = whrs.replace(":", ".");
		
				  
				  
				    var blnResult = disallowSpecialCharacters(objWHrs, "Please enter Work (hrs) in H:M format.");
                   
				    if (blnResult == true) {                       
				        objWHrs.value=objVal;
				        //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
				        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
				        //setFocus(objWHrs);
				        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
				        //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
				        return false;
				    }

				    //Commented and Added by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
				    //blnResult = disallowNonNumeric(objWHrs, "Please enter Work (hrs) in H:M format.");

				    //if (blnResult == true) {                       
				    //    objWHrs.value = objVal;
				    //    //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
				    //    setFocus(objWHrs);
				    //    //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
				    //    return false;
				    //}
                    
				    blnResult = isNaN('' + objWHrs.value + '');

				    if (blnResult == true) {                       
				        objWHrs.value = objVal;
				        alert("Please enter Work (hrs) in H:M format.")
				        return false;
				    }
				    //Commented and Added by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop

				    objWHrs.value = whrs.replace(".", ":");
				    var hrs = objWHrs.value.split(":")[0];

                    var mins = objWHrs.value.split(':')

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
				        objWHrs.value=objVal;
				        alert("Please enter minutes between range (0-59)");
				        //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
				        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
				        //setFocus(objWHrs);
				        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
				        //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
				        return false;
                    }

				    if (objWHrs.value.indexOf(":") == -1) { 				       
				        objWHrs.value=objVal;
                        alert("Please enter Work (hrs) in H:M format.");
				        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
                        //setFocus(objWHrs);
				        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
                        return false;
                    }
                   
                    if (objWHrs.value.indexOf(":") != -1) {
                        objWHrs.value = objWHrs.value.replace(':', '.');
                    }
                    
                   
                    objWHrs.value = objWHrs.value.replace('.', ':');
                    //alert(objWHrs.value);
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
                    
                    if (RestrictByMinHours == 'True') {
                        if (MinDAEntry == 0.016) {
                        }
                        else
                        {
                            var minutes = objWHrs.value.split(':');
                            var p = minutes[0];
                            var dec = minutes[1];

                            if (dec == undefined) { dec = 0; }
                            d = (dec - 0) / 60 + (p - 0);
                        
                            if ((d / MinDAEntry) != parseInt(d / MinDAEntry)) {
                            
                                //alert("Please enter the work hrs. in multiple of min. work hrs (" + MinDAENtryDisplay + ")");
                                alert("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min");
                                //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
                                //setFocus(objWHrs);
                                //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
                                return false;
                            }
                        }
                    }
                   
                    var workHrs = objWHrs.value.replace(':', '.');
                    
                    //if (workHrs >= 24 || workHrs < 0.15) {
                    //    alert('Please enter Work (hrs) between range (0:15-23:45)');
                    //    return false;
                    //}
                   
                    //Validation : Is a multiple of 0.5 hours. [Work (hrs)]
                    val = <%=CommonFunctions.Application.MinHoursForDAEntry%> * 1; 
                    
                    if ((whrs % MinDAENtryDisplay) > 0)
                    {
						alert('<%=MyBase.GetResourceString("MSG_RANGE_WORKHRS1")%>'+ ' ' + val + ' ' + '<%=MyBase.GetResourceString("MSG_RANGE_WORKHRS2")%>' + '\r\n' + '<%=MyBase.GetResourceString("MSG_RANGE_WORKHRS3")%>' + val + '<%=MyBase.GetResourceString("MSG_RANGE_WORKHRS4")%>');
                        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
                        //objWHrs.focus();
                        //Commented by Sagar N on 28-Mar-2019 purpose:: Infinite alert loop
						return false;
					}
					//End of Commented & Added By Sagar N. on 04-Mar-2019 Purpose :: Work Field Level Changes

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
				var objSDateCbo = GetObjectReference('frmIssueAssignment','cboResourceSDT');
				var objEDateCbo = GetObjectReference('frmIssueAssignment','cboResourceEDT');
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
			
			function CheckResourceDates(strTaskSDt,strTaskEDt,intEID)
			{
				var strResourceSDt,strResourceEDt;
				var dtTaskSDt,dtTaskEDt,dtResourceSDt,dtResourceEDt;
				var intIndx;
				
				dtTaskSDt = getDate(strTaskSDt);
				dtTaskEDt = getDate(strTaskEDt);
				
				strResourceSDt = GetResourceDate(intEID,'START');
				strResourceEDt = GetResourceDate(intEID,'END');
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
						strMsg = "<%=MyBase.GetResourceString("MSG_RESOURCE_EDT")%>";
						strMsg = replaceSubstring(strMsg, '<=>', strResourceSDt);
						strMsg = replaceSubstring(strMsg, '<==>', strResourceEDt);
						alert(strMsg);
						return false;
					}
				}
				
				return true;
			}
			function ValidateResourceDates()
			{
				try
				{	
					var objchkAssignTo = GetObjectReference('frmIssueAssignment','chkAssignTo',true);
					var intIndex, intEID;
					if(objchkAssignTo != null)
					{
						for(intIndex=0;intIndex < objchkAssignTo.length;intIndex++)
						{
							if(objchkAssignTo[intIndex].checked == true)
							{
								intEID = objchkAssignTo[intIndex].value;
								var objTSDT = GetObjectReference('frmIssueAssignment','txtStartDate' + intEID);
								var objTEDT = GetObjectReference('frmIssueAssignment','txtEndDate' + intEID);
								if(objTSDT != null && objTEDT != null)
								{
									if(CheckResourceDates(objTSDT.value,objTEDT.value,intEID)== false)
									return false;
								}
							}
						}
					}
				}
				catch(e)
				{ }
				
			}
			//End Added by HarshK for sp4 issueid 120,121
					</script>
			
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
