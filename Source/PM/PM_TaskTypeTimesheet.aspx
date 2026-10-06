<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_TaskTypeTimesheet.aspx.vb" Inherits="PbNIT.PM_TaskTypeTimesheet"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<script src="../../responsive/responsive.js"></script>

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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		
					<form id="TTTimesheet" method="post" runat="server">
									<% PageInit() %>
					</form>
				<script language="javascript">
			
			objform=GetFormReference('TTTimesheet');
			objDivMain=GetObjectReference('TTTimesheet','DivMain');
			var strFilterTaskList = false;
			var dblActualHours = 0;
			var dblActualHours = 0;
			var dblAllocatedHours = 0;
			var dblCurrentTotalHours = 0;
			var blnSaveClicked = false;
			var strWhichTask="";
			// Added By NitinVS on 25 April 2005 for WhizibleSEM SP3
			
			var blnAllowResourceToCompleteTask = '<%= m_blnResourceLevelTaskCompletion%>'
			
			var blnHaveSubTasktypes = '<%= m_HaveSubTasktypes%>'
			
			<%' Added By SonalD on 13th Jan 2009 %>
	        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
			
			// End Addition By NitinVS on 25 April 2005 for WhizibleSEM SP3
			 //Modified by JyotiG on Date 11 July,2006 for WhizibleSEM Issue ID.4168
			function window_onload()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				var intScriptNo;
				
				intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				if (intDivHeight < 100)
				intDivHeight = 100;
				if(navigator.appName == 'Netscape')
				{
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop -90;
			
				}

			    //objDivMain.style.height = intDivHeight	;
				objDivMain.style.height = intDivHeight + 'px'	;
				<% If dblTotalHoursForTheDay > m_dblWorkingHours Then %>
				alert("<%=strMessage%>");
				<% End If %>
				
				if (isProjectOnHold(0) == true || isTimesheetBlockedProject(0)==true )
				{ 
				/*<Summary>
							Added By: PrashantSJ
							Date: 27th May 2008
							Purpose: DA blocked for particular project from project workflow.
				</Summary>
					if(isTimesheetBlockedProject(0)==true)
					{*/
						objForm = GetFormReference('TTTimesheet');
						objForm.submit();
					//}	
					//End of addition by PrashantSJ on 27th May 2008
				}
			}
			
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				if (intDivHeight < 100)
					intDivHeight = 100;
			    //objDivMain.style.height = intDivHeight	;
				objDivMain.style.height = intDivHeight + 'px'	;
			}
			function FilterTaskList(strControlID)
			{
			
				//PURPOSE: To filter the review list on the selected criteria.
				
				//Refresh the page in the following scenarios...
				//If Project is changed.
				//If Task Type is changed.
				//If Task category is changed.
				//When task is changed...
				//If the Task Type is currently blank, then refresh
					
				strFilterTaskList = false;
				
				objElement = GetObjectReference('TTTimesheet', strControlID);
				
				if (objElement != null )
				{
					
					/*if ( objElement.id == "cboTaskID") 
					{
						//There is no need to refresh the page if the Task Type is already selected.
						
						if ( GetObjectReference('TTTimesheet', 'cboTaskTypeID').value != "" && GetObjectReference('TTTimesheet', 'cboTaskID').value != "" && GetObjectReference('TTTimesheet', 'txtPrevTaskID').value != "0" ) 
						{
							//return(strFilterTaskList);
							return;
						}
					}*/
					objtxtChangeElement = GetObjectReference('TTTimesheet', 'txtChangeElement');
					objtxtChangeElement.value = objElement.id;
					
					//Added by PrashantD on 28 March 2007 for IssueID 11767
					//Purpose: If Project is onhold, dont allow user to enter DA.
					if (strControlID == 'cboProject')
					{
							 isProjectOnHold(1) 
							  /*<Summary>
							Added By: PrashantSJ
							Date: 27th May 2008
							Purpose: DA blocked for particular project from project workflow.
						</Summary>*/
							 isTimesheetBlockedProject(1);
							 //End of addition by PrashantSJ on 27th May 2008
					}		 
					 
					//End of addition by PrashantD on 28 March 2007
					
					objForm = GetFormReference('TTTimesheet');
					objForm.submit();
					//Added by PrashantD on 26 March 2007 
					strFilterTaskList = true;
					return;
					//End of addition by PrashantD on 26 March 2007
				}
				
				
				strFilterTaskList = true;
				objForm = GetFormReference('TTTimesheet');
				//Refresh the page.
				//Modified By VidyaJ - IssueID - 346 - SP4
				objForm.action = "PM_TaskTypeTimesheet.aspx?FromWhere=<%=Request.Querystring("FromWhere")%>";
				objForm.submit();
				
			}
			
			function TaskClick()
			{
			/* Comment<%
			'Added by PrashantD on 28 March 2007
			'Purpose: From Developer DB Project combo is disbled when page is postback throgh 'Select Task' combo
			' So enabling controls at the time of post back. Not check FromWhere because nothing imapct.
			 %>
			 End of comment*/
			EnableControls();
			
				// PURPOSE: To filter the list if required, and to display the task attributes if the page is not being refreshed.
				FilterTaskList("cboTaskID");
				//alert(strFilterTaskList);
				if (strFilterTaskList == false)
				{
					DisplayTaskAttributes();
				}
			}
			
			function opentextdialog1(frmName,txtObject,title,IsDisable,path)
			{	
				var	objText=GetObjectReference(frmName,txtObject);
				var strDescription;
				if(title==null)
					title=""
				if(path==null)
					strDescription=window.showModalDialog("../General/TextDialogBox.aspx?Title=" + title +"&Disable=" + IsDisable, objText ,"dialogWidth:545px;dialogHeight:530px");	
				else
					strDescription=window.showModalDialog(path + '?Title=' + title +"&Disable=" + IsDisable, objText,"dialogWidth:545px;dialogHeight:530px");

				if (IsDisable=="False") {	
				objText.value=strDescription }
			}	

			function DisplayTaskAttributes()
			{							
				// PURPOSE: To display the selected task's details.
				
				var dblPrevActualHours = 0;
				//Get the previous task's actual hours.
				
				dblPrevActualHours = (dblActualHours - 0);
				
				objcboTaskID = GetObjectReference('TTTimesheet', 'cboTaskID');
				//alert(objcboTaskID.value);
				
				// If a task is selected, then...
				if(objcboTaskID.value != "")
				{
					//rowTaskDetails.style.display = "block";
					
					// Retrieve the Task Details from the selected item's value property.			
					// The details are separated by a pipe (|) character. 
					strTaskInfo			= objcboTaskID.value.split("|");
					strWhichTask		= strTaskInfo[0];
					intTaskID			= strTaskInfo[1];
					dblAllocatedHours	= strTaskInfo[2];
					dblActualHours		= strTaskInfo[3];			
					blnIsTaskComplete	= strTaskInfo[5];
					dtmStartDate		= GetDateInFormat(strTaskInfo[6], "MMM, dd yyyy");
					dtmEndDate			= GetDateInFormat(strTaskInfo[7], "MMM, dd yyyy");
					dblActualPercentComplete = strTaskInfo[8];
					
					// The current total hours will change if the Task changes. [This is because the actual hours of the new task will be different from the current task's actual hours.]	
					dblCurrentTotalHours = (dblCurrentTotalHours - 0) + ( (dblActualHours - 0 ) - (dblPrevActualHours - 0) );

					//Display the Selected Task on the label below the Task combobox.
					objlblTaskName = GetObjectReference('TTTimesheet', 'lblTaskName');
					objlblTaskName.innerHTML = '<%=MyBase.GetResourceString("SELECTED_TASK")%>' + objcboTaskID.item(objcboTaskID.selectedIndex).innerHTML;
					
					//Display the allocated work, and actual work for the task.
					//This is applicable only for the MPP tasks, and the Assigned Tasks.
					
					// if Allow Resource to complete task =true then show chekcbox 
					
					if( blnHaveSubTasktypes == 'False' )
					{
						strHTML = '<%=MyBase.GetResourceString("ACTUAL_PERCENT_COMPLETE")%>' + "&nbsp;<Input Type=text class=clsTextBox style='width:45;text-align:Right' maxlength=7 id=txtActualPercentComplete name=txtActualPercentComplete> <img Border=0 src='../../images/star.gif' WIDTH=5 HEIGHT=5>";
						
						if(blnAllowResourceToCompleteTask == 'True')
						{
						strHTML = strHTML + "&nbsp;&nbsp;&nbsp;" + "<%=MyBase.GetResourceString("IS_COMPLETE")%>" + " &nbsp;<input type=checkBox id=chkIsTaskComplete name=chkIsTaskComplete value='1'> <input type=hidden name=hidIsChkIsTaskCompletePlotted value=1>";
						}
					}
					else 
					{
					strHTML = '';
					}
						
					if( strWhichTask == "M" || strWhichTask == "O")
					{
						//Commented by MrugajaB on 31st May 2005
						//strHTML = strHTML + "<br>" + "<%=MyBase.GetResourceString("ETC_MESSAGE1")%>" + "<B>" + ( dblAllocatedHours-0 ).toFixed(2) + "</B>&nbsp;&nbsp;" + /*"<%=MyBase.GetResourceString("ETC_MESSAGE2")%>" + "<B>" + (dblActualHours-0).toFixed(2) + "</B>*/ "&nbsp;<BR>" + "<%=MyBase.GetResourceString("ETC_MESSAGE3")%>";
						//Modified by MrugajaB for displaying Actual work hrs for selected task
						strHTML = strHTML + "<br>" + "<%=MyBase.GetResourceString("ETC_MESSAGE1")%>" + "<B>" + ( dblAllocatedHours-0 ).toFixed(2) + "</B>&nbsp;&nbsp;" + "<%=MyBase.GetResourceString("ETC_MESSAGE2")%>" + "<B>" + (dblActualHours-0).toFixed(2) + "</B>&nbsp;<BR>" + "<%=MyBase.GetResourceString("ETC_MESSAGE3")%>";
						strHTML = strHTML + "<%=MyBase.GetResourceString("ETC_MESSAGE4")%>" + "&nbsp;<Input Type=Text maxlength=5 class=clsTextBox id=txtETC name=txtETC value='' style='width:45;text-align:Right'>";
						//Added by MrugajaB for displaying expected start and end date of selected task
						strHTML = strHTML + "<BR> <%=MyBase.GetResourceString("START_DATE")%> <I>" + dtmStartDate + "</I> &nbsp;&nbsp; <%=MyBase.GetResourceString("END_DATE")%> <I>" +  dtmEndDate + "</I>&nbsp;";
						//End Addition
						GetObjectReference('TTTimesheet', 'divCode').innerHTML = strHTML;
					}
					else
					{
						if (GetObjectReference('TTTimesheet', 'divCode') != null) 
						{
							GetObjectReference('TTTimesheet', 'divCode').style.display = "none";
						}
					}
					
					//For all the task categories, except the general tasks...
					if( strWhichTask != "D" )
					{
						
						// Display the Task Notes link.
						GetObjectReference('TTTimesheet', 'lblTaskName').innerHTML = GetObjectReference('TTTimesheet', 'lblTaskName').innerHTML + "&nbsp;[<a style='TEXT-DECORATION: none' HREF='javascript:ShowTaskNotes(" + intTaskID + ")'><font Size=1 Face=verdana color=black><b>Show Task Notes</b></font></a>]";
						GetObjectReference('TTTimesheet', 'divCode').innerHTML = strHTML;
						GetObjectReference('TTTimesheet', 'divCode').style.display = "block";
						
						objtxtActualPercentComplete = GetObjectReference('TTTimesheet', 'txtActualPercentComplete');
						
						if(objtxtActualPercentComplete!=null)
							objtxtActualPercentComplete.value = (dblActualPercentComplete-0).toFixed(2);
						
						// If the task is marked as complete, then the Actual % Complete textbox and the IsTaskComplete checkbox will be DISABLED.
						if( blnIsTaskComplete == "1" ) 
						{
							if(objtxtActualPercentComplete!=null)
								objtxtActualPercentComplete.disabled	= true;
							//##Commented for Enterprise
							//GetObjectReference('TTTimesheet', 'chkIsTaskComplete').checked	= true;
							//GetObjectReference('TTTimesheet', 'chkIsTaskComplete').disabled	= true;
						// If the task is marked as complete, then the Actual % Complete textbox and the IsTaskComplete checkbox will be ENABLED.
						}
						else
						{	if(objtxtActualPercentComplete!=null)
								objtxtActualPercentComplete.disabled	= false;
							//GetObjectReference('TTTimesheet', 'chkIsTaskComplete').checked	= false;
							//GetObjectReference('TTTimesheet', 'chkIsTaskComplete').disabled	= false;
						}
						
					}
					
					// If no Task is selected, then reinitialize all the global variables used.
					else
					{
						strWhichTask		= "";
						intTaskID			= "";
						blnIsTaskComplete	= "";			
						dblActualHours		= 0;
						dblAllocatedHours	= 0;
						dtmStartDate		= "";
						dtmEndDate		= "";
						// The current total hours will change if the Task changes. [This is because the actual hours of the new task will be different from the current task's actual hours.]	
						dblCurrentTotalHours = (dblCurrentTotalHours - 0) + ( dblActualHours - dblPrevActualHours );
					}
				}
			}

			DisplayTaskAttributes();
			<% If blnPersistValues = True Then %>
				if ( GetObjectReference('TTTimesheet', 'txtETC') != null ) 
				{
					GetObjectReference('TTTimesheet', 'txtETC').value = "<%=MyBase.GetFormValue("txtETC")%>";
				}	
				if (GetObjectReference('TTTimesheet', 'txtActualPercentComplete')!=null )
				{
				GetObjectReference('TTTimesheet', 'txtActualPercentComplete').value = "<%=MyBase.GetFormValue("txtActualPercentComplete")%>";
				}
				
				//##Commented for Enterprise
				//GetObjectReference('TTTimesheet', 'chkIsTaskComplete').checked = If MyBase.GetFormValue("chkIsTaskComplete") <> "" Then Response.Write("true;") Else Response.Write("false;") 
				
				//dblCurrentTotalHours = dblCurrentTotalHours + <% Response.Write ( CStr((CDbl(dblTotalHoursForTheDay) - CDbl(dblEnteredHoursForTheDay))) ) %>
			<% End If %>
						
			function txtHours_OnBlur(objHours,intActualWork,intWork)
			{
			    /* Added By NitinVS on 20 Apr 2005 PBNITE SP3
				' IssueID 17905 Task Type Timesheet Should be available for CASE 1 and 2 Projects Also */
				var haveSubTaskTypes = '<%= m_HaveSubTasktypes%>'
				 
				/* End Addition By NitinVS on 20 Apr 2005 PBNITE SP3 */
			    
				// PURPOSE: To capture the value of hours after it is changed. The difference in previous hours and current hours is added to the Total hours.
				oHours = GetObjectReference('TTTimesheet', objHours.id);
				<% If m_blnActualWorkHrs = False %>
					objHoursComplete = GetObjectReference('TTTimesheet', objHours.id);
					if (objHoursComplete.value.replace(/(^\s+|\s+$)/g, "") != "" && disallowNonNumeric(objHoursComplete, '', 0) == false)
					{
						objHoursComplete.value = (objHoursComplete.value-0).toFixed(2);
					}
					
					if (disallowNonNumeric1(objHoursComplete , '<%=MyBase.GetResourceString("VALIDATE_NONNUMERIC_HOURS")%>', "TTTimesheet") == true)
					{
						return;
					}
					var intMaxHours = <%=m_dblWorkingHours%>;
					
					if (disallowValueRangeViolation1(objHoursComplete,0,(intMaxHours - 0),'<%=MyBase.GetResourceString("VALIDATE_RANGE_HOURS")%> [0.00 to ' + intMaxHours.toFixed(2) + ']',"TTTimesheet", false) == true)
					{
						//objHoursComplete.value = (dblPreviousHours-0).toFixed(2);
						//window.setTimeout('document.forms["TTTimesheet"].elements["' + objHoursComplete.id + '"].focus()', 1);
						return;
					}
					if ( (((objHoursComplete.value-0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)-0).toFixed(0) != ((objHoursComplete.value-0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) )
					{
						alert('<%=MyBase.GetResourceString("VALIDATE_MULTIPLE_HOURS")%>' + <%=CommonFunctions.Application.MinHoursForDAEntry%>);
						window.setTimeout('document.forms["TTTimesheet"].elements["' + objHoursComplete.id + '"].focus()', 1);
						return;
					}
				<% End If %>
				
				if (disallowNonNumeric1(GetObjectReference('TTTimesheet', objHours.id), '', 0) == false)
				{
					dblCurrentHours = GetObjectReference('TTTimesheet', objHours.id).value;
				}
				// Update the total hours.
				dblCurrentTotalHours = ( dblCurrentTotalHours - 0 ) + ( (dblCurrentHours - 0 ) - (dblPreviousHours - 0) );
				
				if (disallowBlank(oHours, "", 0) == false)
				{	
					if (haveSubTaskTypes == 'True')
					{
						if ( strWhichTask == "M" || strWhichTask == "O" ) 
						{
							if (CheckForDuration1( (oHours.value - 0) + (intActualWork - 0), (intWork - 0)) == false)
							{
								oHours.value = "";
								return;
							}
						}
					}	
				}
				//##-------------------------------
				/* Added By NitinVS on 20 Apr 2005 PBNITE SP3
				' IssueID 17905 Task Type Timesheet Should be available for CASE 1 and 2 Projects Also 
				}
				else
				{
				if (disallowNonNumeric1(GetObjectReference('TTTimesheet', objHours.id), '', 0) == false)
				{
					dblCurrentHours = GetObjectReference('TTTimesheet', objHours.id).value;
				}
				// Update the total hours.
				dblCurrentTotalHours = ( dblCurrentTotalHours - 0 ) + ( (dblCurrentHours - 0 ) - (dblPreviousHours - 0) );
				}
				
				/* End Addition By NitinVS on 20 Apr 2005 PBNITE SP3 */
			}
			
			function txtHours_OnFocus(objHours)
			{
			
				if (disallowNonNumeric(GetObjectReference('TTTimesheet', objHours.id), '', 0) == false)
				{
					if (disallowValueRangeViolation(GetObjectReference('TTTimesheet', objHours.id),0,24,'',0) == false)
					{
						dblPreviousHours = GetObjectReference('TTTimesheet', objHours.id).value;
					}
				}
			}
			
			
			function Save_OnClick()
			{
				/* Added By NitinVS on 20 Apr 2005 PBNITE SP3
				' IssueID 17905 Task Type Timesheet Should be available for CASE 1 and 2 Projects Also */
				<% If m_HaveSubTasktypes = True %>
				/* End Addition By NitinVS on 20 Apr 2005 PBNITE SP3 */
				
				//PURPOSE: To validate the controls and then save the Timesheet entry.
	
				var objActualPercentComplete;
				var objETCControl;
				var intItems;
				var objHours;
				var objDescription;
				var intCtr;
				
				// Validation - Not Blank [Project].
				if(disallowBlank(GetObjectReference('TTTimesheet','cboProject'), '<%=MyBase.GetResourceString("VALIDATE_PROJECT")%>') == true)
				{
					return;
				}
				
				// Validation - Not Blank [Entry Date].
				if(disallowBlank(GetObjectReference('TTTimesheet', 'txtEntryDate'), '<%=MyBase.GetResourceString("VALIDATE_ENTRY_DATE")%>') == true)
				{
					return;
				}
				
				<% If blnTaskTypeMandatoryInDA = True Then %>					
					// Validation - Not Blank [Task Type].
					if(disallowBlank(GetObjectReference('TTTimesheet','cboTaskTypeID'), '<%=MyBase.GetResourceString("VALIDATE_TASK_TYPE")%>') == true)
					{
						return;
					}
				<% End If %>				
				
				//Validation - Not Blank [Task].
				if(disallowBlank(GetObjectReference('TTTimesheet','cboTaskID'), '<%=MyBase.GetResourceString("VALIDATE_TASK")%>') == true)
				{
					return;
				}
				
				intBackDating = "<%=EXPIRY_OF_TASK%>";
				
				//Added By PrasannaP on 15th May 2004
				var strProjectBackdateEntry = '<%=m_blnProjectBackdateEntry%>';
				if (intBackDating.length != 0)
				{
					if (strProjectBackdateEntry != "True" )
					{
						objDateBox = GetObjectReference('DA', 'txtEntryDate');
						splitArr = objDateBox.value.split("-");
						cmpDate = DateAdd(new Date(splitArr[0] + " " + splitArr[1] + " " + splitArr[2]), ( intBackDating - 0 ), 0, 0);
						
						if ( DateDiff(cmpDate, new Date('<%=Date.Now.ToString()%>'), "d") > 0 )
						{
							alert("Timesheet entry had been blocked. You cannot enter timesheet for this date!");
							return;
						}
					}
				}

				intForwardDating = "<%=EXPIRY_OF_TASK_FORWARD%>";
				
				//Added By PrasannaP on 15th May 2004
				strProjectBackdateEntry = '<%=m_blnProjectFwddateEntry%>';
				if (intForwardDating.length != 0)
				{
					if (strProjectBackdateEntry != "True" )
					{
						objDateBox = GetObjectReference('DA', 'txtEntryDate');
						splitArr = objDateBox.value.split("-");
						cmpDate = DateAdd(new Date(splitArr[0] + " " + splitArr[1] + " " + splitArr[2]), ( -intForwardDating - 0 ), 0, 0);
						if ( DateDiff(cmpDate, new Date('<%=Date.Now.ToString("dd MMM yyyy")%>'), "d") < 0 )
						{
							alert("Timesheet entry had been blocked. You cannot enter timesheet for this date!");
							return;
						}
					}
				}
				
				
				// Actual % Complete.
				objActualPercentComplete = GetObjectReference('TTTimesheet', 'txtActualPercentComplete');
				if (objActualPercentComplete != null)
				{
					objActualPercentComplete.value = objActualPercentComplete.value.replace(/(^\s+|\s+$)/g, "")
					
					//Validation - Not Blank.
					if(disallowBlank(GetObjectReference('TTTimesheet','cboTaskID'), '<%=MyBase.GetResourceString("VALIDATE_TASK")%>') == true)
					{
						return;
					}	
					if(disallowBlank(objActualPercentComplete, '<%=MyBase.GetResourceString("VALIDATE_ACTUAL_COMPLETE")%>') == true)
					{
						return;
					}

					if ( disallowNegativeNumeric(objActualPercentComplete, '<%=MyBase.GetResourceString("VALIDATE_NEGATIVE_ACTUAL_COMPLETE")%>') == true)
					{
						return;
					}

					
					if(disallowNonNumeric(objActualPercentComplete, '<%=MyBase.GetResourceString("VALIDATE_NUMERIC_ACTUAL_COMPLETE")%>') == true)
					{
						return;
					}
					//Validation - Is within range.
					if (disallowValueRangeViolation(objActualPercentComplete, 0, 100, '<%=MyBase.GetResourceString("VALIDATE_RANGE_ACTUAL_COMPLETE")%>', 1) == true)
					{
						return;
					}
					
					
				}
				
				// Validation for ETC.		
				//Set objETCControl = frmTimesheet.all.item("txtETC")
				
			   
				objETCControl = GetObjectReference('TTTimesheet', 'txtETC');
				if ( objETCControl != null)
				{
				
					objETCControl.value = objETCControl.value.replace(/(^\s+|\s+$)/g, "")
										
					if (disallowBlank(objETCControl, '', 0) == false)
					{
						//Get the lower limit of the allowable ETC range.
						if((dblAllocatedHours-0) > (dblCurrentTotalHours-0))
						{
							dblETCLowerLimit = (dblCurrentTotalHours -0)- (dblAllocatedHours -0);
						}
						else
						{
							dblETCLowerLimit = 0;
						}
						
						if ( disallowNegativeNumeric(objETCControl, '<%=MyBase.GetResourceString("VALIDATE_NUMERIC_ETC")%>') == true)
						{
							return;
						}

						//Validation - Is Numeric.
						if ( disallowNonNumeric(objETCControl, '<%=MyBase.GetResourceString("VALIDATE_NUMERIC_ETC")%>') == true)
						{
							return;
						}
						
						// Validation - ZERO not allowed.
						if (objETCControl.value == 0)
						{
							alert('<%=MyBase.GetResourceString("VALIDATE_ZERO_ETC")%>');
							objETCControl.focus();
							return;
						}
						
						//Validation - Check if the ETC (hrs) specified for each resource is a multiple of 0.5 hours.
						if(((objETCControl.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>).toFixed(2) != ((objETCControl.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>))
						{
							alert('<%=MyBase.GetResourceString("VALIDATE_MULTIPLES_ETC")%> <%=CommonFunctions.Application.MinHoursForDAEntry%>');
							objETCControl.focus();
							return;
						}	
						
						// Validation - Value below lower limit not allowed.
						if ((objETCControl.value - 0).toFixed(2) < (dblETCLowerLimit - 0 ) )
						{
							alert("<%=MyBase.GetResourceString("VALIDATE_MIN_ETC")%> " + dblETCLowerLimit + " !!");
							objETCControl.focus();
							return;
						}
					}
				}
				
				// Validation - [Work (hrs) and Description fields.]				
				// Get the Hours element.
				/*
				objHours = GetObjectReference('TTTimesheet', 'txtHours', 1);
				
				// Get the Description element.
				objDescription = GetObjectReference('TTTimesheet', 'txtDescription', 1);
				for (i=0; i<objDescription.length; i++)
				{
					objHours[i].value = objHours[i].value.replace(/(^\s+|\s+$)/g, "");
					objDescription[i].value = objDescription[i].value.replace(/(^\s+|\s+$)/g, "");
				}
				// Check if the combobox-textarea pair exists.
				objHoursValidation = GetObjectReference('TTTimesheet', 'txtHoursValidation', 1);
				
				if (objDescription != null)
				{				
					// Get the number of combobox-textarea pairs (it could be a collection, or a single element).
					for (i=0; i<objDescription.length; i++)
					{
						if (disallowBlank(objHours[i], "", 0) == false)
						{
							//if ((objHours[i] - 0) > (txtHoursValidation[i] - 0))
							//{
								if ( strWhichTask == "M" || strWhichTask == "O" ) 
								{
									if (CheckForDuration1((objHours[i].value - 0), (objHoursValidation[i].value - 0)) == false)
									{
										return;
									}
								}
							//}
							if (disallowBlank(objDescription[i], '<%=MyBase.GetResourceString("VALIDATE_DESCRIPTION")%>') == true)
							{
								return;
							}
						}
					}
				}*/
				/*
				if ( strWhichTask == "M" || strWhichTask == "O" ) 
				{
					// The dblCurrentTotalHours value will be different from the dblActualHours value if some entry has been filled.
					if( (dblCurrentTotalHours - 0) != (dblActualHours - 0) )
					{
						if( CheckForDurationChange() == false) 
							return;
					}
				}
				*/
				

				// If the task is marked as complete, then set the value of 'Actual % Complete' to 100.
				
				// Modified by NitinVS on 26 Apr 2005 for WhizibleSEM SP3 
				// Added percentageComplete and is Task Complete in Task grid with validation done on save.
				
				
				var objSubtasktypeID = GetObjectReference('TTTimesheet', 'txtSubTaskTypeID' ,1 ) 
				
				for (i=0 ;i< objSubtasktypeID.length ; i++)
				{
					var subtaskTypeId = objSubtasktypeID[i].value;
					var objActualPercentcomplete = GetObjectReference('TTTimesheet', 'txtActualPercentcomplete' + subtaskTypeId )
					var objchkIsTaskComplete = GetObjectReference('TTTimesheet', 'chkIsTaskComplete' + subtaskTypeId  ) 
					
					//var objtxtHours = GetObjectReference('TTTimesheet', 'txtHours',1  ) 
					var objtxtHours = GetObjectReference('TTTimesheet', 'txtHours' + subtaskTypeId  ) 
					
					// Validate ActualPercentcomplete 
					
					if (objActualPercentcomplete != null && objActualPercentcomplete.value !="" )
					{
						objActualPercentcomplete.value = objActualPercentcomplete.value.replace(/(^\s+|\s+$)/g, "")
						//alert(objActualPercentcomplete.value );
						
						/*if(disallowBlank(objActualPercentcomplete, '<%=MyBase.GetResourceString("VALIDATE_ACTUAL_COMPLETE")%>') == true)
						{
							return;
						}*/

						if ( disallowNegativeNumeric(objActualPercentcomplete, '<%=MyBase.GetResourceString("VALIDATE_NEGATIVE_ACTUAL_COMPLETE")%>') == true)
						{
							return;
						}

						
						if(disallowNonNumeric(objActualPercentcomplete, '<%=MyBase.GetResourceString("VALIDATE_NUMERIC_ACTUAL_COMPLETE")%>') == true)
						{
							return;
						}
						//Validation - Is within range.
						if (disallowValueRangeViolation(objActualPercentcomplete, 0, 100, '<%=MyBase.GetResourceString("VALIDATE_RANGE_ACTUAL_COMPLETE")%>', 1) == true)
						{
							return;
						}
						
					}	
					// if chkIsTaskComplete is Checked then make Percentagecomplete as 100 			
					//if (GetObjectReference('TTTimesheet', 'chkIsTaskComplete') != null)

					if (objchkIsTaskComplete != null)
					{
						
						//if (GetObjectReference('TTTimesheet', 'chkIsTaskComplete').checked == true)
						if (objchkIsTaskComplete.checked == true)
						{
							//if (objtxtHours[i].value=="")
							if (objtxtHours.value=="")
							{
								alert("Please enter the Actual Work (hrs) while marking task complete!!");
							
								//objtxtHours[i].focus();
								objtxtHours.focus();
							return;
							}	
							
							objActualPercentcomplete.value = 100;
							objActualPercentcomplete.style.visiblity ="hidden";
						}
						else
						{
							objchkIsTaskComplete.value='' 
						}
					}
					
				}
				
				if (blnSaveClicked == false)	
				{
				
					EnableControls();
					objForm  =  GetFormReference('TTTimesheet');
					//Modified By VidyaJ - IssueID - 346 - SP4
					objForm.action = 'PM_TaskTypeTimesheet.aspx?FromWhere=<%=Request.Querystring("FromWhere")%>&Action=Save<% 
						If Trim(Request.QueryString("TaskID")) <> "" Then 
							Response.Write("&TaskID=" & intTaskID)
						End If
					%>';
					blnSaveClicked = true;
									
					objForm.submit();
				}
			/* Added By NitinVS on 20 Apr 2005 PBNITE SP3
				' IssueID 17905 Task Type Timesheet Should be available for CASE 1 and 2 Projects Also */
				<% Else %>
				ValidateEffortofAllSubTasks()
				<% End If %>
				/* End Addition By NitinVS on 20 Apr 2005 PBNITE SP3 */	
			}
					
			
			function EnableControls()
			{
				var objCombobox;
				GetObjectReference('TTTimesheet', 'cboProject').disabled = false;
				if (GetObjectReference('TTTimesheet', 'chkIsTaskComplete') != null)
				{
					GetObjectReference('TTTimesheet', 'chkIsTaskComplete').disabled = false;
					GetObjectReference('TTTimesheet', 'txtActualPercentComplete').disabled = false;
					GetObjectReference('TTTimesheet', 'txtActualPercentComplete').value = (GetObjectReference('TTTimesheet', 'txtActualPercentComplete').value - 0).toFixed(2);
				}
				GetObjectReference('TTTimesheet', 'cboTaskTypeID').disabled = false;
				GetObjectReference('TTTimesheet', 'cboTaskID').disabled = false;
				GetObjectReference('TTTimesheet', 'optGeneralTasks').disabled = false;
				GetObjectReference('TTTimesheet', 'optProjectTasks').disabled = false;
				GetObjectReference('TTTimesheet', 'optAssignedTasks').disabled = false;
				GetObjectReference('TTTimesheet', 'optDefectTasks').disabled = false;
			}
			
			function CheckForDuration1(intCurrentTotalHours, intAllocatedHours)
			{
				var blnDateViolation;
				var blnHoursViolation;
				var strMessage = "";
				var strResponse;
				
				//Initialize the status of the flags.
				//CheckForDurationChange = True			
				
				//Depending on the Task category, get the status of the flag that will decide whether the "Duration Change" must be restricted.
				<% If ( strWhichTask = "M" And blnRestrictDurationChange_MPPTasks = True ) Or ( strWhichTask = "O" And blnRestrictDurationChange_AssignedTasks = True )Then %>
					blnRestrictDurationChange = true;
				<% Else %>
					blnRestrictDurationChange = false;
				<% End If %>			
				
				blnDateViolation = false;
				blnHoursViolation = false;
				
				// If the entry date is not within the date range, then...

				var diff1 = DateDiff(GetDateInFormat(GetObjectReference('TTTimesheet', 'txtEntryDate').value, '', "rev"), GetDateInFormat(dtmStartDate, '', 'rev'), "d");
				
				var diff2 = DateDiff(GetDateInFormat(GetObjectReference('TTTimesheet', 'txtEntryDate').value, '', "rev"), GetDateInFormat(dtmEndDate, '', 'rev'), "d");
				
				if (diff1 > 0 || diff2 < 0 )
				{					
					blnDateViolation = true;
					strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT1")%>' + dtmStartDate + '<%=MyBase.GetResourceString("OVERSHOOT2")%>' + dtmEndDate + '].';
				}
				//If the actual hours has crossed the allocated hours, then...
				//if((dblCurrentTotalHours-0) > (dblAllocatedHours-0))
				if((intCurrentTotalHours-0) > (intAllocatedHours-0))
				{
					blnHoursViolation = true;
					if(blnRestrictDurationChange == true)
					{
						strMessage = strMessage + replaceSubstring('<%=Mybase.GetResourceString("OVERSHOOT3")%>','<=>',(intAllocatedHours-0).toFixed(2))
						strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT4")%>';
					}
					else
					{
						strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT5")%>' + intAllocatedHours + '<%=MyBase.GetResourceString("OVERSHOOT6")%>' + (intCurrentTotalHours-0).toFixed(2) + '<%=MyBase.GetResourceString("OVERSHOOT7")%>';
					}
				}
				
				//If there is a duration change due to any of the reasons stated above, prompt the user accordingly...
				if( blnDateViolation == true || blnHoursViolation == true)
				{
					if ( blnRestrictDurationChange == true) 
					{
						strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT8")%>';
						alert(strMessage);
						strResponse = false;
					}
					else
					{
						strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT9")%>';
						strResponse = window.confirm(strMessage);
					}
					
					if (strResponse == true)
					{
						// Set the flag indicating that the duration has changed.
						GetObjectReference('TTTimesheet', 'txtIsDurationChange').value = "1";
					}
					else
					{
						return(false);
					}
				}
				return(true);

			}
			
			function CheckForDurationChange()
			{
				//PURPOSE: To check for duration change.
				// A change in duration occurs in the following scenarios...
				//		1. The entry date of the Timesheet entry being made does not fall in the estimated date range.
				//		2. The actual hours worked exceeds the allocated work.			
		
				var blnDateViolation;
				var blnHoursViolation;
				var strMessage = "";
				var strResponse;
				
				//Initialize the status of the flags.
				//CheckForDurationChange = True			
				
				//Depending on the Task category, get the status of the flag that will decide whether the "Duration Change" must be restricted.
				<% If ( strWhichTask = "M" And blnRestrictDurationChange_MPPTasks = True ) Or ( strWhichTask = "O" And blnRestrictDurationChange_AssignedTasks = True )Then %>
					blnRestrictDurationChange = true;
				<% Else %>
					blnRestrictDurationChange = false;
				<% End If %>			
				
				blnDateViolation = false;
				blnHoursViolation = false;
				/* Added By NitinVS on 20 Apr 2005 PBNITE SP3
				' IssueID 17905 Task Type Timesheet Should be available for CASE 1 and 2 Projects Also */
				
				var objtxtHoursValidation = GetObjectReference('TTTimesheet', 'txtHoursValidation');
				dblAllocatedHours = objtxtHoursValidation.value;
				
				var diff1 = DateDiff(GetDateInFormat(GetObjectReference('TTTimesheet', 'txtEntryDate').value, '', "rev"), GetDateInFormat(dtmStartDate, '', 'rev'), "d");
				
				var diff2 = DateDiff(GetDateInFormat(GetObjectReference('TTTimesheet', 'txtEntryDate').value, '', "rev"), GetDateInFormat(dtmEndDate, '', 'rev'), "d");
				
				// If the entry date is not within the date range, then...
				if (diff1 > 0 || diff2 < 0 )
				{					
					blnDateViolation = true;
					strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT1")%>' + dtmStartDate + '<%=MyBase.GetResourceString("OVERSHOOT2")%>' + dtmEndDate + '].';
				}
				/* End Addition by NitinVS on 20 Apr 2005 PBNITE SP3 */
				
				//If the actual hours has crossed the allocated hours, then...
				if((dblCurrentTotalHours-0) > (dblAllocatedHours-0))
				{
					blnHoursViolation = true;
					if(blnRestrictDurationChange == true)
					{
						strMessage = strMessage + replaceSubstring('<%=Mybase.GetResourceString("OVERSHOOT3")%>','<=>',(dblAllocatedHours-0).toFixed(2))
						strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT4")%>';
					}
					else
					{
						strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT5")%>' + dblAllocatedHours + '<%=MyBase.GetResourceString("OVERSHOOT6")%>' + (dblCurrentTotalHours-0).toFixed(2) + '<%=MyBase.GetResourceString("OVERSHOOT7")%>';
					}
				}
				
				//If there is a duration change due to any of the reasons stated above, prompt the user accordingly...
				if( blnDateViolation == true || blnHoursViolation == true)
				{
					if ( blnRestrictDurationChange == true) 
					{
						strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT8")%>';
						alert(strMessage);
						strResponse = false;
					}
					else
					{
						strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT9")%>';
						strResponse = window.confirm(strMessage);
					}
					
					if (strResponse == true)
					{
						// Set the flag indicating that the duration has changed.
						GetObjectReference('TTTimesheet', 'txtIsDurationChange').value = "1";
					}
					else
					{
						return(false);
					}
				}
				return(true);
			}

			function IncludeCompletedTasks()
			{
				// PURPOSE: To toggle between "Show All Tasks" and "Show Incomplete Tasks".
				blnFlag = 1;
				objForm = GetFormReference('TTTimesheet');
				GetObjectReference('TTTimesheet', 'txtIncludeCompletedTasks').value = blnFlag;
				//Modified By VidyaJ - IssueID - 346 - SP4
				objForm.action = "PM_TaskTypeTimesheet.aspx?FromWhere=<%=Request.Querystring("FromWhere")%>";
				GetObjectReference('TTTimesheet', 'txtChangeElement').value = "txtIncludeCompletedTasks";
				objForm.submit();
			}

			function IncludeInCompletedTasks()
			{
				// PURPOSE: To toggle between "Show All Tasks" and "Show Incomplete Tasks".
				blnFlag = -1;
				objForm = GetFormReference('TTTimesheet');
				GetObjectReference('TTTimesheet', 'txtIncludeCompletedTasks').value = blnFlag;
				//Modified By VidyaJ - IssueID - 346 - SP4
				objForm.action = "PM_TaskTypeTimesheet.aspx?FromWhere=<%=Request.Querystring("FromWhere")%>";
				GetObjectReference('TTTimesheet', 'txtChangeElement').value = "txtIncludeCompletedTasks";
				objForm.submit();
			}
			function SelectTask()
			{
			
				//PURPOSE: To open the Task Selection Dialog.								

				var strQueryString, objCombobox
				objcboProjectID = GetObjectReference('TTTimesheet','cboProject');
				objcboTaskTypeID = GetObjectReference('TTTimesheet', 'cboTaskTypeID');
				strQueryString = "PM_TaskSelection.aspx?FromWhere=TaskTypeTimesheet&ProjectID=" + objcboProjectID.value;
				strQueryString = strQueryString + "&TaskTypeID=" + objcboTaskTypeID.value;
				strQueryString = strQueryString + "&TaskType=<%=strWhichTask%>" 
				strQueryString = strQueryString + "&IncludeCompletedTasks=<% If blnIncludeCompletedTasks = True Then Response.Write("1") Else Response.Write("0") %>"
			
				window.open(strQueryString, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=750,height=400");
		
			}

			function ShowTaskNotes(intTaskID)
			{
				//PURPOSE: To open the Task Notes dialog.
				window.open("PM_DailyActivityMatrix.aspx?TaskNotes=1&TaskID=" + intTaskID,"","resizable=yes,scrollbars=no,width=500,height=250,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 250)/2 + ",status =no,titlebar=no,location=no");
			}
			
			function disallowNonNumeric1(obj,msg,frm){
				if ( disallowNonNumeric(obj,msg) == true )
				{
					if ((arguments.length>3)?arguments[3]:true)
					{
						window.setTimeout('document.forms["' + frm + '"].elements["' + obj.id + '"].focus()', 1);
					}
					flagSubmit = false;
					return true;	
				}
				flagSubmit = true;
				return false;
			}
			
			function disallowValueRangeViolation1(obj,minVal,maxVal,msg,frm) {
				if ( disallowValueRangeViolation(obj,minVal,maxVal,msg) == true )
				{
					if((arguments.length>5)?arguments[5]:true)
					{
						window.setTimeout('document.forms["' + frm + '"].elements["' + obj.id + '"].focus()', 1);
					}
					flagSubmit = false;
					return(true);	
				}
				flagSubmit = true;
				return(false);
			}

    /* Added By NitinVS on 20 Apr 2005 PBNITE SP3
    ' IssueID 17905 Task Type Timesheet Should be available for CASE 1 and 2 Projects Also */

    function ValidateEffortofAllSubTasks()
		{
			//PURPOSE: To validate the controls and then save the Timesheet entry.

			var objActualPercentComplete;
			var objETCControl;
			var intItems;
			var objHours;
			var objDescription;
			var intCtr;
			
	
				// Validation - Not Blank [Project].
				if(disallowBlank(GetObjectReference('TTTimesheet','cboProject'), '<%=MyBase.GetResourceString("VALIDATE_PROJECT")%>') == true)
				{
					return;
				}
				
				// Validation - Not Blank [Entry Date].
				if(disallowBlank(GetObjectReference('TTTimesheet', 'txtEntryDate'), '<%=MyBase.GetResourceString("VALIDATE_ENTRY_DATE")%>') == true)
				{
					return;
				}
				
				<% If blnTaskTypeMandatoryInDA = True Then %>					
					// Validation - Not Blank [Task Type].
					if(disallowBlank(GetObjectReference('TTTimesheet','cboTaskTypeID'), '<%=MyBase.GetResourceString("VALIDATE_TASK_TYPE")%>') == true)
					{
						return;
					}
				<% End If %>				
				
				//Validation - Not Blank [Task].
				if(disallowBlank(GetObjectReference('TTTimesheet','cboTaskID'), '<%=MyBase.GetResourceString("VALIDATE_TASK")%>') == true)
				{
					return;
				}
				
				
						intBackDating = "<%=EXPIRY_OF_TASK%>";
				
				//Added By PrasannaP on 15th May 2004
				var strProjectBackdateEntry = '<%=m_blnProjectBackdateEntry%>';
				if (intBackDating.length != 0)
				{
					if (strProjectBackdateEntry != "True" )
					{
						objDateBox = GetObjectReference('DA', 'txtEntryDate');
						splitArr = objDateBox.value.split("-");
						cmpDate = DateAdd(new Date(splitArr[0] + " " + splitArr[1] + " " + splitArr[2]), ( intBackDating - 0 ), 0, 0);
						
						if ( DateDiff(cmpDate, new Date('<%=Date.Now.ToString()%>'), "d") > 0 )
						{
							alert("Timesheet entry had been blocked. You cannot enter timesheet for this date!");
							return;
						}
					}
				}

				intForwardDating = "<%=EXPIRY_OF_TASK_FORWARD%>";
				
				//Added By PrasannaP on 15th May 2004
				strProjectBackdateEntry = '<%=m_blnProjectFwddateEntry%>';
				if (intForwardDating.length != 0)
				{
					if (strProjectBackdateEntry != "True" )
					{
						objDateBox = GetObjectReference('DA', 'txtEntryDate');
						splitArr = objDateBox.value.split("-");
						cmpDate = DateAdd(new Date(splitArr[0] + " " + splitArr[1] + " " + splitArr[2]), ( -intForwardDating - 0 ), 0, 0);
						if ( DateDiff(cmpDate, new Date('<%=Date.Now.ToString("dd MMM yyyy")%>'), "d") < 0 )
						{
							alert("Timesheet entry had been blocked. You cannot enter timesheet for this date!");
							return;
						}
					}
				}
				
				
				//Added By VivekP
				objETCControl = GetObjectReference('TTTimesheet', 'txtETC');
				if ( objETCControl != null)
				{
				
					objETCControl.value = objETCControl.value.replace(/(^\s+|\s+$)/g, "")
					
						
					if (disallowBlank(objETCControl, '', 0) == false)
					{
					
						//Get the lower limit of the allowable ETC range.
						if((dblAllocatedHours-0) > (dblCurrentTotalHours-0))
						{
							dblETCLowerLimit = (dblCurrentTotalHours -0)- (dblAllocatedHours -0);
						}
						else
						{
							dblETCLowerLimit = 0;
						}
						
						if ( disallowNegativeNumeric(objETCControl, '<%=MyBase.GetResourceString("VALIDATE_NUMERIC_ETC")%>') == true)
						{
							return;
						}

						//Validation - Is Numeric.
						if ( disallowNonNumeric(objETCControl, '<%=MyBase.GetResourceString("VALIDATE_NUMERIC_ETC")%>') == true)
						{
							return;
						}
						
						// Validation - ZERO not allowed.
						
						if (objETCControl.value == 0)
						{
						//alert(objETCControl.value);
							alert('<%=MyBase.GetResourceString("VALIDATE_ZERO_ETC")%>');
							objETCControl.focus();
							return;
						}
						
						//Validation - Check if the ETC (hrs) specified for each resource is a multiple of 0.5 hours.
						if(((objETCControl.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>).toFixed(2) != ((objETCControl.value - 0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>))
						{
							alert('<%=MyBase.GetResourceString("VALIDATE_MULTIPLES_ETC")%> <%=CommonFunctions.Application.MinHoursForDAEntry%>');
							objETCControl.focus();
							return;
						}	
						
						// Validation - Value below lower limit not allowed.
						if ((objETCControl.value - 0).toFixed(2) < (dblETCLowerLimit - 0 ) )
						{
							alert("<%=MyBase.GetResourceString("VALIDATE_MIN_ETC")%> " + dblETCLowerLimit + " !!");
							objETCControl.focus();
							return;
						}
					}
				}
				
				
				//End Of Addition By vivekP
				// Actual % Complete.
				objActualPercentComplete = GetObjectReference('TTTimesheet', 'txtActualPercentComplete');
				if (objActualPercentComplete != null)
				{
					objActualPercentComplete.value = objActualPercentComplete.value.replace(/(^\s+|\s+$)/g, "")
					
					//Validation - Not Blank.
					if(disallowBlank(GetObjectReference('TTTimesheet','cboTaskID'), '<%=MyBase.GetResourceString("VALIDATE_TASK")%>') == true)
					{
						return;
					}	
					if(disallowBlank(objActualPercentComplete, '<%=MyBase.GetResourceString("VALIDATE_ACTUAL_COMPLETE")%>') == true)
					{
						return;
					}

					if ( disallowNegativeNumeric(objActualPercentComplete, '<%=MyBase.GetResourceString("VALIDATE_NEGATIVE_ACTUAL_COMPLETE")%>') == true)
					{
						return;
					}

					
					if(disallowNonNumeric(objActualPercentComplete, '<%=MyBase.GetResourceString("VALIDATE_NUMERIC_ACTUAL_COMPLETE")%>') == true)
					{
						return;
					}
					//Validation - Is within range.
					if (disallowValueRangeViolation(objActualPercentComplete, 0, 100, '<%=MyBase.GetResourceString("VALIDATE_RANGE_ACTUAL_COMPLETE")%>', 1) == true)
					{
						return;
					}
					
				}
				
				// Validation - [Work (hrs) and Description fields.]				
				// Get the Hours element.
				
				objHours = GetObjectReference('TTTimesheet', 'txtHours', 1);
				
				// Get the Description element.
				objDescription = GetObjectReference('TTTimesheet', 'txtDescription', 1);
				for (i=0; i<objDescription.length; i++)
				{
					objHours[i].value = objHours[i].value.replace(/(^\s+|\s+$)/g, "");
					objDescription[i].value = objDescription[i].value.replace(/(^\s+|\s+$)/g, "");
				}
				// Check if the combobox-textarea pair exists.
				objHoursValidation = GetObjectReference('TTTimesheet', 'txtHoursValidation', 1);
				/*
				if (objDescription != null)
				{				
					// Get the number of combobox-textarea pairs (it could be a collection, or a single element).
					for (i=0; i<objDescription.length; i++)
					{ 
						if (disallowBlank(objHours[i], "", 0) == false)
						{   
								
						}
					}
				}*/				
				if ( strWhichTask == "M" || strWhichTask == "O" ) 
				{
					// The dblCurrentTotalHours value will be different from the dblActualHours value if some entry has been filled.
					if( (dblCurrentTotalHours - 0) != (dblActualHours - 0) )
					{
						if( CheckForDurationChange() == false) 
							return;
					}
				}
				
		

				// If the task is marked as complete, then set the value of 'Actual % Complete' to 100.
				if (GetObjectReference('TTTimesheet', 'chkIsTaskComplete') != null)
				{
					if (GetObjectReference('TTTimesheet', 'chkIsTaskComplete').checked == true)
					{
						objActualPercentComplete.value = 100.00;
					}
				}
				if (blnSaveClicked == false)	
				{
				
					EnableControls();
					objForm  =  GetFormReference('TTTimesheet');
					//Modified By VidyaJ - IssueID - 346 - SP4
					objForm.action = 'PM_TaskTypeTimesheet.aspx?FromWhere=<%=Request.Querystring("FromWhere")%>&Action=Save<% 
						If Trim(Request.QueryString("TaskID")) <> "" Then 
							Response.Write("&TaskID=" & intTaskID)
						End If
					%>';
					blnSaveClicked = true;
					objForm.submit();
				}
	}
	/* End Addition By NitinVS on 20 Apr 2005 PBNITE SP3 */	
	
		//Added by PrashantD on 28 March 2007 for IssueID 11767
		//Purpose: If Project is onhold, dont allow user to enter DA.
		function isProjectOnHold(showAlert)
		{
			var strProjectsOnHold = "<%=m_strProjectsOnHold%>";
			var objProject = GetObjectReference('TTTimesheet','cboProject')
			if (strProjectsOnHold != "")
				{
					if (strProjectsOnHold.indexOf(',' + objProject.value + ',') != -1)
					{
						if(showAlert)
						alert("<%=m_strProjectsOnHoldMsg%>");
						if ("<%=m_strFirstNotOnHoldProject%>" != "0")
						{
							objProject.value = "<%=m_strFirstNotOnHoldProject%>";
							
						}
						return true;
					}			
				}	
		}
		/*<Summary>
							Added By: PrashantSJ
							Date: 27th May 2008
							Purpose: DA blocked for particular project from project workflow.
				</Summary>*/
		function isTimesheetBlockedProject(showAlert)
		{
			var strDABlockedProjects = "<%=m_strProjectsDABlocked%>";
			var objProject = GetObjectReference('TTTimesheet','cboProject')
			if (strDABlockedProjects != "")
				{
					if (strDABlockedProjects.indexOf(',' + objProject.value + ',') != -1)
					{
						if(showAlert)
						alert("<%=m_strProjectsDABlockedMsg%>");
						if ("<%=m_strFirstNotOnHoldProject%>" != "0")
						{
							objProject.value = "<%=m_strFirstNotOnHoldProject%>";
							
						}
						return true;
					}			
				}	
		}
		//End of addition by PrashantSJ on 27th May 2008
					</script>
	</body>
</HTML>
