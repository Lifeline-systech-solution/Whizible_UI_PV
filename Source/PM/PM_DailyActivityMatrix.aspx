<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_DailyActivityMatrix.aspx.vb" Inherits="PbNIT.PM_DailyActivityMatrix"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	
<script src="../../responsive/responsive.js"></script>
 <link href="../General/loaderStylesheet.css" rel="stylesheet" />

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


	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()" style="visibility:hidden">
		<script language="Javascript">
			var actionOnDuration = false;
			var intMaxEntry = 24;
				
			function initArray()
			{
				controlArray = new Array(3);
				controlArray[0] = new Array(6);
				controlArray[1] = new Array(5);
				controlArray[2] = new Array(5);
				controlArray[0][0] = "0";
				controlArray[0][1] = "0";
				controlArray[0][2] = "0";
				controlArray[0][3] = "0";
				controlArray[0][4] = "0";
				controlArray[0][5] = "0";
				controlArray[1][0] = "0";
				controlArray[1][1] = "0";
				controlArray[1][2] = "0";
				controlArray[2][0] = "0";
				controlArray[2][1] = "0";
				controlArray[2][2] = "0";
			}
		
		</script>
		<form id="frmDailyActivityMatrix" name="frmDailyActivityMatrix" method="post" runat="server" >
			<%PageInit()%>
			
	
	
			
		<% MyBase.InitializeResources("AppResources.PM_DailyActivityMatrix", "AppResources") %>
			</form>		
	
		<script language="Javascript">
			var flagSubmit = true;
			var controlArray;
			
			
			objform=GetFormReference('frmDailyActivityMatrix');
			objDivMain=GetObjectReference('frmDailyActivityMatrix','DivMain');
				// integrated by harshada d on 20092005 for ISSUE ID 346
			// Modified By NitinVS on 3 Aug 2005 for PMLifeLine SP4 
			var blnisSaved = 0; 
			// End Modification By NitinVS on 3 Aug 2005 for PMLifeLine SP4 
			// integrated by harshada d on 21092005 for issue id 346
			 //Modified by JyotiG on Date 11 July,2006 for PMLifeLine Issue ID.4168
			 
			 
			  <%' Added By SonalD on 13th Jan 2009 %>
	          <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                    disableRightClick();
              <%End If%>
              <%' Added By SonalD on 13th Jan 2009 %>
			 
			 
			function window_onload()		
			{
			    
			    document.body.style.height = window.innerHeight - 4 + 'px'; //Added By Yogesh J ON 15/12/2015 for pop up bottom issue
				var intDivHeight ;
				var intDivHeightRisk;
				var intScriptNo;
		
				document.body.style.visibility='visible';
				 
				//document.body.style.height = window.innerHeight - 4 + 'px'; //Added By Yogesh J ON 15/12/2015 for pop up bottom issue
				
					//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168
				if(objDivMain != null)
				{

				    if(navigator.appName == 'Netscape')
				    {	
				        // Commented and added by Yogesh J on 23/12/2015 for footer issue
				        // intDivHeight = window.innerHeight  - objDivMain.offsetTop - 40 ;
				        intDivHeight = window.innerHeight  - objDivMain.offsetTop - 58 ;
				        //End of Comment by Yogesh J 
				    }
				    else
				    {
				        // Commented and added by Yogesh J on 23/12/2015 for footer issue
				        //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				        intDivHeight = window.innerHeight  - objDivMain.offsetTop - 56 ;
				        //End of Comment by Yogesh J 
				    }
				   
				    if (intDivHeight < 100)
				        intDivHeight = 100;
				    //objDivMain.style.height = intDivHeight;
				    objDivMain.style.height = intDivHeight + 'px'	;
				}
				if (GetObjectReference('frmDailyActivityMatrix','txtTaskNotes') != null)
				{
					GetObjectReference('frmDailyActivityMatrix','txtTaskNotes').focus();
				}
				intMaxEntry = 24;
				
			
			}
			
			function window_onresize()		
			{
			  
				var intDivHeight ;
				var intDivHeightRisk;
					//intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
					//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168
				document.body.style.height = window.innerHeight - 4 + 'px'; //Added By Yogesh J ON 15/12/2015 for pop up bottom issue
				if(objDivMain != null)
				{

				    if(navigator.appName == 'Netscape')
				    {	
				        // Commented and added by Yogesh J on 23/12/2015 for footer issue
				        // intDivHeight = window.innerHeight  - objDivMain.offsetTop - 40 ;
				        intDivHeight = window.innerHeight  - objDivMain.offsetTop - 58 ;
				        //End of Comment by Yogesh J 
				    }
				    else
				    {
				        // Commented and added by Yogesh J on 23/12/2015 for footer issue
				        //intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 40;
				        intDivHeight = window.innerHeight  - objDivMain.offsetTop - 56 ;
				        //End of Comment by Yogesh J 
				    }
				   
				    if (intDivHeight < 100)
				        intDivHeight = 100;
				    //objDivMain.style.height = intDivHeight;
				    objDivMain.style.height = intDivHeight + 'px'	;
				}	
			}
			
			<% If Request.QueryString("ShowDetails") = 1 Then %>

			var dblPreviousValue;
			dblPreviousValue = 0
				
			function SaveClick()
			{
			    
			    //Added by Priyanka, 9th Sep 2004
			    //Not allowing the user to fill DA against OnHold Projects
			    //Trupti
				 //end
			    //Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
			    var Mode = (arguments.length > 0) ? arguments[0] : "0";
			    if (Mode == "0") {
			        document.body.readonly = true;
			        window.setTimeout('SaveClick("1")', 1);
			        setFrameLoader();
			    }
			   
			    if (Mode == "1") {
			        setFrameLoader();//Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
			        var strProjectsOnHold, intProject;
				
			        strProjectsOnHold = "<%=m_strProjectsOnHold%>";
			        intProject = "<%=Trim(Request.QueryString("ProjectID"))%>";
												
			        if ((strProjectsOnHold != "") && (intProject != ""))
			        {
			            if (strProjectsOnHold.indexOf(',' + intProject + ',') != -1)
			            {
			                alert("<%=m_strProjectsOnHoldMsg%>");
			                RemoveFrameLoader();//Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
			                //Added By VidyaJ - issueID - 11766
			                return;
			            }				
			        }
			        //End of Addition
			        /*<Summary>
                                  Added By: PrashantSJ
                                  Date: 27th May 2008
                                  Purpose: DA blocked for particular project from project workflow.
                      </Summary>*/
			        strDABlockedProjects="<%=m_strProjectsDABlocked%>";
			        if (strDABlockedProjects != "")
			        {
			            if (strDABlockedProjects.indexOf(',' + intProject + ',') != -1)
			            {
			                alert("<%=m_strProjectsDABlockedMsg%>");
			                RemoveFrameLoader();//Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
						
			                return;
			            }			
			        }	
			        //End of addition by PrashantSJ on 27th May 2008
			        if (actionOnDuration == false)
			        {
			            flagSubmit = true;
			        }
			        else
			        {
			            flagSubmit = setSubmitFlag();
			        }
					
			        if (flagSubmit == true)
			        {
			            var strQueryString;
			            var falseValidate = false;
					
			            objtxtDescriptionCounter = GetObjectReference('frmDailyActivityMatrix', 'txtDescriptionCounter');
					
			            for( i=1; i<=objtxtDescriptionCounter.value; i++)
			            {
			                objtxtDescription = GetObjectReference('frmDailyActivityMatrix', 'txtDescription' + (i + ''));
			                objtxtHours = GetObjectReference('frmDailyActivityMatrix', 'txtDuration' + (i + ''));
						
			                //if (disallowBlank(objtxtDescription, '<%=MyBase.GetResourceString("EMPTY_DESCRIPTION")%>') == true)
			                //{
			                //	falseValidate=true;
			                //	break;
			                //}
						
			                if (disallowMaxlengthViolation(objtxtDescription, 2000, replaceSubstring('<%=Mybase.GetResourceString("VALIDATE_RANGE_DESCRIPTION")%>','<=>',objtxtDescription.value.length+""), 1) == true)
			                {
			                    falseValidate=true;
			                    break;
			                }
			                if (disallowBlank(objtxtHours, '<%=MyBase.GetResourceString("EMPTY_ACTUAL_WORK_HRS")%>') == true)
			                {
			                    falseValidate=true;
			                    break;
			                }
			            }
			            if ( falseValidate==true)
			            {
			                return;
			            }
					
			            objfrmDailyActivity = GetFormReference('frmDailyActivityMatrix');
					
			            strQueryString = "PM_DailyActivityMatrix.aspx?ShowDetails=1&Mode=Save";
					
			            <% If Trim(Request.QueryString("ProjectID")) <> "" Then %>
			            strQueryString = strQueryString + "&ProjectID=<%=Trim(Request.QueryString("ProjectID")) & "" %>";
			            <% End If %>
					
			            <% If Trim(Request.QueryString("TaskType")) <> "" Then %>
			            strQueryString = strQueryString + "&TaskType=<%=Trim(Request.QueryString("TaskType")) & "" %>";
			            <% End If %>

			            <% If Trim(Request.QueryString("TaskID")) <> "" Then %> 
			            strQueryString = strQueryString + "&TaskID=<%=Trim(Request.QueryString("TaskID")) & "" %>";
			            <% End If %>
					
			            <% If Trim(Request.QueryString("FromDate")) <> "" Then %>
			            strQueryString = strQueryString + "&FromDate=<%=Trim(Request.QueryString("FromDate")) & "" %>";
			            <% End If %>
					
			            <% If Trim(Request.QueryString("ToDate")) <> "" %>
			            strQueryString = strQueryString + "&ToDate=<%=Trim(Request.QueryString("ToDate")) & "" %>";
			            <% End If %>
			            objfrmDailyActivity.action = strQueryString;
					
			            objfrmDailyActivity.submit();
			            RemoveFrameLoader();//Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
			        }
			    }
			}
			function txtDuration_OnFocus(objTextBox)
			{
				actionOnDuration = true;			
				if (objTextBox.value != "" && !isNaN((objTextBox.value - 0)))
				{
					//##Modified
					if (disallowValueRangeViolation1(objTextBox, 0, intMaxEntry, '', "frmDailyActivityMatrix", false) == false)
					{
						dblPreviousValue = (objTextBox.value - 0);
						initArray();
						SaveValues(objTextBox,'dummy',true);
					}
				}
				else
				{
					//dblPreviousValue = 0;
				}
				
			}
			
			//Integrated by MrugajaB for PMLifeLine SP7 Issue ID.4192
			//Added by SujataK on 23 May 2006
			function txtDescription_OnFocus(objTextBox)
			{
				if(objTextBox.value !="")
				{
					strValue = objTextBox.value;
					
				}
			}
			function txtDescription_OnChange(objDescription,intCtr)
			{intBackDating = "<%=m_strBackdatingExpiry%>"
				intFwdDating = "<%=m_strFwddatingExpiry%>"
				strProjectBackdateEntry = "<%=m_blnProjectBackdateEntry%>"
				strProjectFwddateEntry = "<%=m_blnProjectFwddateEntry%>"
				objEntryDate = GetObjectReference('frmDailyActivityMatrix', 'txtEntryDate' + intCtr) 
				//objDescription = GetObjectReference('frmDailyActivityMatrix',objectName); 
				
				  				
				if(intBackDating.length != 0)
				{
					if (strProjectBackdateEntry != "True")
					{
						if (DateDiff(DateAdd(new Date(GetDateInFormat(objEntryDate.value, '', "rev")), intBackDating, 0, 0), new Date('<%=Date.Now().toString()%>'), "d") > 0 )
						{
						  
							alert("Timesheet entry had been blocked. You cannot enter Description for this date!");
							objDescription.value = strValue;
							return;
						}
					}
				}
				
				
				if(intFwdDating.length != 0)
				{
					if (strProjectFwddateEntry != "True")
					{
						if (DateDiff(DateAdd(new Date(GetDateInFormat(objEntryDate.value, '', "rev")), -(intFwdDating-0), 0, 0), new Date('<%=Date.Now().toString("dd MMM yyyy")%>'), "d") < 0 )
						{
							alert("Timesheet entry had been blocked. You cannot enter Description for this date!");
							objDescription.value = dblPreviousValue.toFixed(2);
							return;
						}
					}
				}
			}
			// End of addition by SujataK
			//End Integration
			var dblTotalHoursForDay;
			var dblTotalHoursForTask;
			function txtDuration_OnChange(objTextBox, intCtr, strWhichTask, intRowForDate, intRowForTask)
			{

				var dblCurrentValue;			
				var intPrevTotalHours;
				
				objHoursComplete = GetObjectReference('frmDailyActivityMatrix', objTextBox.id);
				<% If m_blnActualWorkHrs = False Then %>
					if (objHoursComplete.value.replace(/(^\s+|\s+$)/g, "") != "" && disallowNonNumeric(objHoursComplete, '', 0) == false)
					{
						objHoursComplete.value = (objHoursComplete.value-0).toFixed(2);
					}
					
					if (disallowBlank1(objHoursComplete , '<%=MyBase.GetResourceString("EMPTY_ACTUAL_WORK_HRS")%>', "frmDailyActivityMatrix") == true)
					{
						objHoursComplete.value = (dblPreviousValue-0).toFixed(2);
						return;
					}
					
					if (disallowNonNumeric1(objHoursComplete , '<%=MyBase.GetResourceString("VALIDATE_NONNUMERIC_HOURS")%>', "frmDailyActivityMatrix") == true)
					{
						return;
					}
					
					//##Modified
					if (disallowValueRangeViolation1(objHoursComplete,0,intMaxEntry ,'<%=MyBase.GetResourceString("VALIDATE_RANGE_HOURS")%>' + intMaxEntry.toFixed(2) + ']',"frmDailyActivityMatrix") == true)
					{
						objHoursComplete.value = (dblPreviousValue-0).toFixed(2);
						return;
					}
					if ( (((objHoursComplete.value-0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)-0).toFixed(0) != ((objTextBox.value-0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) )
					{
						alert('<%=MyBase.GetResourceString("VALIDATE_MULTIPLE_HOURS")%>' + <%=CommonFunctions.Application.MinHoursForDAEntry%>);
						objTextBox.value = (dblPreviousValue-0).toFixed(2);
						objTextBox.focus();
						return;
					}
				<% Else %>
					//If the value of the combobox is blank, then restore the previous value, and exit the subroutine. (i.e. Cancel the update.)
					if (objTextBox.value == "")
					{
						alert("<%=MyBase.GetResourceString("EMPTY_ACTUAL_WORK_HRS")%>");
						//objTextBox.value = FormatHours(dblPreviousValue)
						objTextBox.value = (dblPreviousValue-0).toFixed(2);
						return;
					}
				<% End If %>

				intBackDating = "<%=m_strBackdatingExpiry%>"
				intFwdDating = "<%=m_strFwddatingExpiry%>"
				strProjectBackdateEntry = "<%=m_blnProjectBackdateEntry%>"
				strProjectFwddateEntry = "<%=m_blnProjectFwddateEntry%>"
				objEntryDate = GetObjectReference('frmDailyActivityMatrix', 'txtEntryDate' + intCtr) 
				
				//##Added
	//trupti
				var strjoinigdate=GetObjectReference('frmWeeklyTimesheet','hdnJoiningdate');
				if(strjoinigdate != '')
								{
									var dtjoinigdate=getDate(strjoinigdate.value);
									//Commented and modified by purvaj on 4 Jul 2009 8.1 Issue Fixes
									//strjoinigdate.value > objEntryDate.value replaced with disallowDate1GreaterThanDate2 function
									//strjoinigdate.value > objEntryDate.value was not working properly in some cases.
							        //if(strjoinigdate.value > objEntryDate.value)
							        if (disallowDate1GreaterThanDate2(strjoinigdate, objEntryDate )==true)
									{
									//end modification purvaj
										alert('Joining Date should not be greater than DA entry date.');
										objTextBox.focus();
										return true;
									}
								
								}				
				//end
				
				if(intBackDating.length != 0)
				{
					if (strProjectBackdateEntry != "True")
					{
						if (DateDiff(DateAdd(new Date(GetDateInFormat(objEntryDate.value, '', "rev")), intBackDating, 0, 0), new Date('<%=Date.Now().toString()%>'), "d") > 0 )
						{
							alert("Timesheet entry had been blocked. You cannot enter timesheet for this date!");
							objHoursComplete.value = dblPreviousValue.toFixed(2);
							return;
						}
					}
				}
				
				if(intFwdDating.length != 0)
				{
					if (strProjectFwddateEntry != "True")
					{
						if (DateDiff(DateAdd(new Date(GetDateInFormat(objEntryDate.value, '', "rev")), -(intFwdDating-0), 0, 0), new Date('<%=Date.Now().toString("dd MMM yyyy")%>'), "d") < 0 )
						{
							alert("Timesheet entry had been blocked. You cannot enter timesheet for this date!");
							objHoursComplete.value = dblPreviousValue.toFixed(2);
							return;
						}
					}
				}
				
				//##Ends Addition
				
				//Get the current value.
				dblCurrentValue = (objTextBox.value - 0)
				
				//Get the Previous total hours. i.e. The total of the hours saved into the database.
				
				intPrevTotalHours = dblInitialHours[intRowForDate];
				
				//Get current Total hours for the day.
				dblTotalHoursForDay = dblDateWiseHours[intRowForDate] + (dblCurrentValue - dblPreviousValue);
				
				//alert(' DateWiseHours : Row : ' + intRowForDate + ' Value : ' + dblDateWiseHours[intRowForDate]);
				//alert(' CurrentHours : ' + dblCurrentValue + ' dblPreviousHours : ' + dblPreviousValue);
				//alert(' Calculation : ' + (dblDateWiseHours[intRowForDate] + (dblCurrentValue - dblPreviousValue)));
				
				//Get current Total hours for the task.
				dblTotalHoursForTask = dblTaskWiseHours[intRowForTask-1][1] + (dblCurrentValue - dblPreviousValue);
			
				//Now check if the total hours for the day is greater that 24 hours. If yes, then...
				
				//##Modified
				if (dblTotalHoursForDay > intMaxEntry)
				{
					//alert('<%=MyBase.GetResourceString("MAX_BOOKING1")%>' + intPrevTotalHours + '<%=MyBase.GetResourceString("MAX_BOOKING2")%>' + (dblTotalHoursForDay - intPrevTotalHours) +  '<%=MyBase.GetResourceString("MAX_BOOKING3")%>');
					//alert("You can book only 24 hours in a day. [You have already booked " + intPrevTotalHours + " hours. You are about to book additional " + (dblTotalHoursForDay - intPrevTotalHours) + " hours.] Your current selection exceeds 24 hours. Your current entry will be adjusted to bring the total to 24 hours.");
					alert("You can book only " + intMaxEntry + " hours in a day. [You have already booked " + intPrevTotalHours + " hours. You are about to book additional " + (dblTotalHoursForDay - intPrevTotalHours) + " hours.] Your current selection exceeds " + intMaxEntry + " hours. Your current entry will be adjusted to bring the total to " + intMaxEntry + " hours.");
					//Get the excess hours entered.
					
					dblExcessHours = dblTotalHoursForDay - intMaxEntry;
					
					//Subtract the excess hours from the combobox value, Total hours for that day, and Total hours for the Task.					
					if (((dblCurrentValue-0) - (dblExcessHours-0)) < 0)
					{
						objTextBox.value = '0.00';
					}
					else
					{
						objTextBox.value = ((dblCurrentValue-0) - (dblExcessHours-0)).toFixed(2);
					}
					dblTotalHoursForDay = dblTotalHoursForDay - dblExcessHours;
					dblTotalHoursForTask = dblTotalHoursForTask - dblExcessHours;
				}
				


				if (strWhichTask == "M" || strWhichTask == "O"|| strWhichTask == "B")
				{
					CheckForDurationChange(objTextBox, intCtr, strWhichTask, intRowForDate, intRowForTask);
				}
				
								//Update the Totals in the main array.
				dblDateWiseHours[intRowForDate] = dblTotalHoursForDay;
				dblTaskWiseHours[intRowForTask-1][1] = dblTotalHoursForTask;
				
				//Update the previous value variable.
				if(objHoursComplete.value.replace(/(^\s+|\s+$)/g, "") != "" && disallowNonNumeric(objHoursComplete, '', 0) == false)
				{
					dblPreviousValue = (objTextBox.value - 0);
				}
				else
				{
					dblPreviousValue = 0;
				}

				
			}
			
			function CheckForDurationChange(objTextBox, intCtr, strWhichTask, intRowForDate, intRowForTask)
			{
				var blnDateViolation, blnHoursViolation;
				var strMessage = "";
				var strResponse = true;
				var blnPromptOnDurationChange, blnRestrictDurationChange;
				
				var dblCurrentValue;
				//var dblTotalHoursForDay, dblTotalHoursForTask, 
				var dblAllocatedHoursForTask;
				var dtmEntryDate, dtmStartDate, dtmEndDate;
				
				//Get the corporate settings for MPP Tasks, and Assigned Tasks.
				blnPromptOnDurationChange = false;
				blnRestrictDurationChange = false;						
				
				if (strWhichTask == "M")
				{
					blnPromptOnDurationChange = true;
					<% If m_blnStatus_MPPTasks = True Then %> 
						blnRestrictDurationChange = true;
					<% End If %>
				}
				else if( strWhichTask == "O")
				{
					blnPromptOnDurationChange = true;
					<% If m_blnStatus_AssignedTasks = True %>
						blnRestrictDurationChange = true;
					<% End If %>
				}
				else if( strWhichTask == "B")
				{
					blnPromptOnDurationChange = true;
					<% If m_blnStatus_AssignedTasks = True %>
						blnRestrictDurationChange = true;
					<% End If %>
				}				
				blnDateViolation = false;
				blnHoursViolation = false;												
				
				// NOTE : The values of the arrays have already been updated in the calling function. 
				// So on entering this function, the hours have already been added to the Date array, and Task array.
				
				// Get the current value.
				dblCurrentValue = (objTextBox.value - 0);
				
				//Get the hours allocated for the Task.
				dblAllocatedHoursForTask = dblTaskWiseHours[intRowForTask-1][2];
				
				//Get current Total hours for the day.
				dblTotalHoursForDay = dblDateWiseHours[intRowForDate];
	
			//Get current Total hours for the task.
				//dblTotalHoursForTask = dblTaskWiseHours[intRowForTask-1][1];
				dblTotalHoursForTask=dblTaskWiseHours[intRowForTask-1][1] + (dblCurrentValue - dblPreviousValue);
				
				objtxtEntryDate = GetObjectReference('frmDailyActivityMatrix', 'txtEntryDate' + intCtr);
				dtmEntryDate = objtxtEntryDate.value;
				dtmStartDate = dblTaskWiseHours[intRowForTask-1][3];
				dtmEndDate = dblTaskWiseHours[intRowForTask-1][4];
	//trupti
				var strjoinigdate=GetObjectReference('frmWeeklyTimesheet','hdnJoiningdate');
				if(strjoinigdate != '')
								{
									var dtjoinigdate=getDate(strjoinigdate.value);
						
									if(dtjoinigdate > dtmEntryDate)
									{
										alert('Joining Date should not be greater than DA entry date.');
										return true;
									}
								
								}				
				//end
				if (blnRestrictDurationChange == true)
				{
					//If the entry had been made out of schedule, then...
					if( compareDates(dtmEntryDate, dtmStartDate) < 0 || compareDates(dtmEntryDate, dtmEndDate) > 0)
					{
						blnDateViolation = true;
					    strMessage = '<%=MyBase.GetResourceString("OVERSHOOT1")%>' +  dtmStartDate + '<%=MyBase.GetResourceString("OVERSHOOT2")%>' + dtmEndDate + '].';
						
					}
				}
				
				// Check if the Total Hours exceed the allocated hours. If yes, then set the hours violation.
				if (dblCurrentValue > dblPreviousValue)
				{
				
				
					//if((((dblTotalHoursForTask)-(dblPreviousValue))+((dblCurrentValue)-(dblPreviousValue))) > dblAllocatedHoursForTask)
					if((dblTotalHoursForTask) > dblAllocatedHoursForTask)
					{
					
						blnHoursViolation = true;
					
						    strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT3")%>' + dblAllocatedHoursForTask + '<%=MyBase.GetResourceString("OVERSHOOT4")%>' + (dblTotalHoursForTask ) + '<%=MyBase.GetResourceString("OVERSHOOT5")%>';
					
					}
				}
				
				//If the entry date is not within the specified date range, or the actual work hours is exceeding the estimated hours, then pop up the message.				
				if(blnDateViolation==true || blnHoursViolation==true)
				{
					if(blnPromptOnDurationChange==true)
					{
						if(blnRestrictDurationChange==true)
						{
							strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT6")%>'
							strResponse = alert(strMessage);
							objTextBox.value = (dblPreviousValue-0).toFixed(2);
							strResponse = false;
								dblTotalHoursForDay = dblTotalHoursForDay -  (dblCurrentValue - dblPreviousValue);
						dblTotalHoursForTask = dblTotalHoursForTask -  (dblCurrentValue - dblPreviousValue);
						
						}
						else
						{
							strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT7")%>';
							strResponse = window.confirm(strMessage);
						}
					}
					else
					{
						strResponse = true;
					}
								
					if (strResponse == true)
					{
						GetObjectReference('frmDailyActivity', 'txtIsDurationChange' + intCtr).value = "1";
					}
					else if(blnRestrictDurationChange==false)
					{
						//Restore the previous hours in the combobox value, Total hours for that day, and Total hours for the Task.
						//objTextBox.value = FormatHours(dblPreviousValue);
						dblTotalHoursForDay = dblTotalHoursForDay -  (dblCurrentValue - dblPreviousValue);
						dblTotalHoursForTask = dblTotalHoursForTask -  (dblCurrentValue - dblPreviousValue);
					}
				}

				if (strResponse == false)
				{
					if (!isNaN((dblPreviousValue-0)))
					{
						objTextBox.value = (dblPreviousValue-0).toFixed(2);
					}
				}
				// Update the Totals in the main array.
				//dblDateWiseHours[intRowForDate] = dblTotalHoursForDay;
				//dblTaskWiseHours[intRowForTask-1][1] = dblTotalHoursForTask;
				
			}
				
			
			
			
			/*
				This script is used while validating the Actual Timesheet Matrix
				The main list uses following validations.
				=====================================================================
				WEEKLY VIEW DAILY ACTIVITY IS REQUESTED.
				=====================================================================
			*/
			<% ElseIf Request.QueryString("TaskNotes") <> "1" Then %>
			
		    function SaveClick()
		    {
		        //Added by Priyanka, 9th Sep 2004
		        //Not allowing the user to fill DA against OnHold Projects
		  
		        //Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
		        var Mode = (arguments.length > 0) ? arguments[0] : "0";
		        if (Mode == "0") {
		            document.body.readonly = true;
		            window.setTimeout('SaveClick("1")', 1);
		            setFrameLoader();
		        }
		        if (Mode == "1") {
		            setFrameLoader();//Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
		            var strProjectsOnHold, objProject;
				
		            strProjectsOnHold = '<%=m_strProjectsOnHold%>';
		            objProject = GetObjectReference('DA',"cboProject");
				
		            if (strProjectsOnHold != "")
		            {
		                if (strProjectsOnHold.indexOf(',' + objProject.value + ',') != -1)
		                {


		                    alert("<%=m_strProjectsOnHoldMsg%>");
		                    RemoveFrameLoader();//Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
		                    if ("<%=m_strFirstNotOnHoldProject%>" != "0")
		                    {
		                        objProject.value = "<%=m_strFirstNotOnHoldProject%>";
		                        <% ' Added by NitinVS on 3 Apr 2007 for PMLifeLine SP 8 Regression Issue 11766 %>
		                        cboProject_OnChange();
		                        <% ' End Addition by NitinVS on 3 Apr 2007 for PMLifeLine SP 8 Regression Issue 11766 %>							
		                    }
		                    return;
		                }			
		            }
		            //End of Addition
		            /*<Summary>
                                    Added By: PrashantSJ
                                    Date: 27th May 2008
                                    Purpose: DA blocked for particular project from project workflow.
                        </Summary>*/
		            strDABlockedProjects="<%=m_strProjectsDABlocked%>";
		            if (strDABlockedProjects != "")
		            {
		                if (strDABlockedProjects.indexOf(',' + objProject.value + ',') != -1)
		                {
		                    alert("<%=m_strProjectsDABlockedMsg%>");
		                    RemoveFrameLoader();//Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
		                    if ("<%=m_strFirstNotOnHoldProject%>" != "0")
		                    {
					
		                        objProject.value = "<%=m_strFirstNotOnHoldProject%>";
		                        /*<% ' Added by NitinVS on 3 Apr 2007 for PMLifeLine SP 8 Regression Issue 11766 %>
		                        cboProject_OnChange();
		                        <% ' End Addition by NitinVS on 3 Apr 2007 for PMLifeLine SP 8 Regression Issue 11766 %>							*/
		                    }
		                    return;
		                }			
		            }	
		            //End of addition by PrashantSJ on 27th May 2008
		            flagSubmit = setSubmitFlag();
		            //Added By VidyaJ - issue ID - 11773
		            //Modified By VarunA on 12-Dec-2008 RequestID-17191
		            //Purpose : Not to hide the save link
		            if (navigator.appName == 'Microsoft Internet Explorer')
		            {
		                //End By VarunA on 12-Dec-2008 RequestID-17191
		                var objMenuTop = GetObjectReference('frmDailyActivityMatrix', 'tblMenuTop');
		                var objMenuBottom = GetObjectReference('frmDailyActivityMatrix', 'tblMenuBottom'); 
		                objMenuTop.style.display = 'none';
		                objMenuBottom.style.display = 'none';
		                //Modified By VarunA on 12-Dec-2008 RequestID-17191
		                //Purpose : Not to hide the save link
		            }
		            //End By VarunA on 12-Dec-2008 RequestID-17191
					
		            if (flagSubmit == true)
		            {
		                // integrated by harshada d on 20092005 for ISSUE ID 346
		                // Modified By NitinVS on 3 Aug 2005 for PMLifeLine SP4 
				
		                if (blnisSaved  != 1 )
		                {
		                    blnisSaved = 1; 
		                    setFrameLoader();
		                    //objform.action = "PM_DailyActivityMatrix.aspx?FromDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(dtmFromDate))%>&ToDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(dtmToDate))%>&Mode=Save<%If Request.QueryString("ShowClose") = "1" Then Response.Write("&ShowClose=1")%>";
		                    objform.action = "PM_DailyActivityMatrix.aspx?FromDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(dtmFromDate))%>&ToDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(dtmToDate))%>&ShowDetails=0&Mode=Save<%If Request.QueryString("ShowClose") = "1" Then Response.Write("&ShowClose=1")%>";
		                    objform.submit();
		                    RemoveFrameLoader();//Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
		                }
		                else
					
		                {
		                    setFrameLoader();
		                    //objform.action = "PM_DailyActivityMatrix.aspx?FromDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(dtmFromDate))%>&ToDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(dtmToDate))%>&Mode=Save<%If Request.QueryString("ShowClose") = "1" Then Response.Write("&ShowClose=1")%>";
		                    objform.action = "PM_DailyActivityMatrix.aspx?FromDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(dtmFromDate))%>&ToDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(dtmToDate))%>&ShowDetails=0&Mode=Save<%If Request.QueryString("ShowClose") = "1" Then Response.Write("&ShowClose=1")%>";
		                    objform.submit();
		                    RemoveFrameLoader();//Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
		                    // End Modification By NitinVS on 3 Aug 2005 for PMLifeLine SP4 		
		                    // End integration by harshada d on 20092005 for ISSUE ID 346	
		                }
		
		            }
		        }
		    }
			function ShowDetails(intProjectID, strTaskType, intTaskID, dtmFromDate, dtmToDate)
			{
			// Purpose				:	To call the details window depending on the selections.
				if (setSubmitFlag() == true)
				{
					var strQueryString			
					strQueryString = "PM_DailyActivityMatrix.aspx?ShowDetails=1";
					
					if (intProjectID != 0)
					{
						strQueryString = strQueryString + "&ProjectID=" + intProjectID;
					}

					if (strTaskType != "")
					{
							strQueryString = strQueryString + "&TaskType=" + strTaskType;
					}		
					
					if (intTaskID != 0) 
					{
						strQueryString = strQueryString + "&TaskID=" + intTaskID;
					}
							
					if (dtmFromDate != "")
					{
						strQueryString = strQueryString + "&FromDate=" + dtmFromDate;
					}
					
					if (dtmToDate != "")
					{
						strQueryString = strQueryString + "&ToDate=" + dtmToDate;
					}
                    //dhn
					strQueryString = strQueryString + "&EmployeeID=" + '<%=Session("intUserID")%>';
				    
                    //dhn
                    //Added by Dhanashri S on 28 Jan 2016 for PkToken Validation
					$.ajax({
					    type: 'POST',
					    dataType: 'json',
					    contentType: 'application/json',
					    url: 'PM_DailyActivityMatrix.aspx/GenrateURLToken_ShowDetails_OnClick',
					    data: JSON.stringify({ ProjectID: intProjectID, EmployeeID: '<%=Session("intUserID")%>', TaskID: intTaskID }),
		                success: function (Result) {
		                    
		                    
		                    strQueryString = strQueryString + "&PkToken=" + Result.d;
		                    window.open(strQueryString,"","resizable=yes,scrollbars=no,width=700,height=350,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 350)/2 + ",status =no,titlebar=no,location=no ");

		                },
		                error: function () {
		                    //    alert("Error")
		                }
                    });
					//Commented by Dhanashri S on 28 Jan 2016
					//window.open(strQueryString,"","resizable=yes,scrollbars=no,width=700,height=350,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 350)/2 + ",status =no,titlebar=no,location=no ");
				    //End of Comment by Dhanashri S
                    //End of Addition by Dhanashri S on 28 Jan 2016
				}	
                
			}			
					
			var intSaveAgainstProjectID;
			
			function cboProject_OnFocus()
			{
				//PURPOSE: To capture the previous Project ID.			
				objcboProject = GetObjectReference('frmDailyActivityMatrix', 'cboProject');
				intSaveAgainstProjectID = objcboProject.value;
			}
			
			
			function cboProject_OnChange()
			{
				//Added by Priyanka, 9th Sep 2004
				//Not allowing the user to fill DA against OnHold Projects
				var strProjectsOnHold, objProject;
				var lngOnholdcount=0
				strProjectsOnHold = "<%=m_strProjectsOnHold%>"
				objProject = GetObjectReference('DA',"cboProject");
				var arr = strProjectsOnHold.split(',');
				
				if(arr.length > 0)
				    lngOnholdcount=arr.length-2
			
			//if(arr.length > 3)//if combo contains only one project do not execute this block. added By purvaj on 12 Aug 2009
			if(objProject.length > 1 && lngOnholdcount!= objProject.length )//if combo contains only one project do not execute this block. added By purvaj on 12 Aug 2009
			{
				if (strProjectsOnHold != "")
				{
					if (strProjectsOnHold.indexOf(',' + objProject.value + ',') != -1)
					{
						alert("<%=m_strProjectsOnHoldMsg%>");
					
						if ("<%=m_strFirstNotOnHoldProject%>" != "0")
						{
							objProject.value = "<%=m_strFirstNotOnHoldProject%>";
							<% ' Added by NitinVS on 3 Apr 2007 for PMLifeLine SP 8 Regression Issue 11766 %>
							cboProject_OnChange();
							<% ' End Addition by NitinVS on 3 Apr 2007 for PMLifeLine SP 8 Regression Issue 11766 %>														
						}
						optTasks_OnClick();
						return;
					}				
				}
				//End of Addition
/*<Summary>
							Added By: PrashantSJ
							Date: 27th May 2008
							Purpose: DA blocked for particular project from project workflow.
				</Summary>*/
				strDABlockedProjects="<%=m_strProjectsDABlocked%>";
				if (strDABlockedProjects != "")
				{
					if (strDABlockedProjects.indexOf(',' + objProject.value + ',') != -1)
					{
						alert("<%=m_strProjectsDABlockedMsg%>");
						if ("<%=m_strFirstNotOnHoldProject%>" != "0")
						{
							
								objProject.value = "<%=m_strFirstNotOnHoldProject%>";
						/*	<% ' Added by NitinVS on 3 Apr 2007 for PMLifeLine SP 8 Regression Issue 11766 %>
							cboProject_OnChange();
							<% ' End Addition by NitinVS on 3 Apr 2007 for PMLifeLine SP 8 Regression Issue 11766 %>							*/
						}
						optTasks_OnClick();
						return;
					}			
				}	
	        }/// end if added By purvaj on 12 Aug 2009
	        else
	        {
	              return;
	        }
				//End of addition by PrashantSJ on 27th May 2008
				// Purpose	:	To change the task list according to the selected project.
				flagSubmit = setSubmitFlag();
				if (flagSubmit == true)
				{
					var strResponse, strHREF;
					
					strHREF = "PM_DailyActivityMatrix.aspx?&PkToken=<%=m_PKToken_TaskDetails%>&ShowDetails=0&FromDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(dtmFromDate))%>&ToDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(dtmToDate))%><%If Request.QueryString("ShowClose") = "1" Then Response.Write("&ShowClose=1")%>"
					if(DAFilledButNotSaved('PCC') == true)
					{
						strResponse = window.confirm('<%=MyBase.GetResourceString("CONFIRM_SAVE")%>');
						if(strResponse == true)
						{
							strHREF = strHREF + "&Mode=Save&PrevProjectID=" + intSaveAgainstProjectID;
						}
					}
					objfrmDailyActivity = GetFormReference('frmDailyActivityMatrix');
					objfrmDailyActivity.action = strHREF;
					objfrmDailyActivity.submit();			
				}
				
			} 
			
			function optTasks_OnClick()
			{
				// Purpose	:	To change the task list according to the Task Type selected.
				flagSubmit = setSubmitFlag();
				if (flagSubmit == true)
				{
					var strResponse, strHREF;
					strHREF = "PM_DailyActivityMatrix.aspx?FromDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(dtmFromDate))%>&ToDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(dtmToDate))%><%If Request.QueryString("ShowClose") = "1" Then Response.Write("&ShowClose=1")%>&PkToken=<%=m_PKToken_TaskDetails%>&ShowDetails=0";
					if (DAFilledButNotSaved() == true) 
					{	
						strResponse = window.confirm('<%=MyBase.GetResourceString("CONFIRM_SAVE")%>');
						if (strResponse == true)
						{
							strHREF = strHREF + "&Mode=Save";
						}
					}
					objfrmDailyActivity = GetFormReference('frmDailyActivityMatrix');
					objfrmDailyActivity.action = strHREF;
					objfrmDailyActivity.submit();				
				}
			}
			
			function PreviousWeek()
			{
				//Purpose				:	To show details of previous week.
			
				flagSubmit = setSubmitFlag();
				if (flagSubmit == true)
				{
				     
				        
					var strResponse, strHREF;
					objfrmDailyActivityMatrix = GetFormReference('frmDailyActivityMatrix');
				    //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
					//strHREF = "PM_DailyActivityMatrix.aspx?FromDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(DateAdd("d",-7,dtmFromDate)))%>&ToDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(DateAdd("d",-7,dtmToDate)))%><%If Request.QueryString("ShowClose") = "1" Then Response.Write("&ShowClose=1")%>";
				    strHREF = "PM_DailyActivityMatrix.aspx?ShowDetails=0&FromDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(DateAdd("d",-7,dtmFromDate)))%>&ToDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(DateAdd("d",-7,dtmToDate)))%><%If Request.QueryString("ShowClose") = "1" Then Response.Write("&ShowClose=1")%>";
				    //End of Addition by Dhanashri S on 11 Aug 2016
				    //alert(dblHours);
					if (DAFilledButNotSaved() == true)
					{
						strResponse = window.confirm('<%=MyBase.GetResourceString("CONFIRM_SAVE")%>');
						if (strResponse == true) 
						{
							strHREF = strHREF + "&Mode=Save";
						}
					}
					//Added By VidyaJ - issue ID - 11773
					var objMenuTop = GetObjectReference('frmDailyActivityMatrix', 'tblMenuTop');
					var objMenuBottom = GetObjectReference('frmDailyActivityMatrix', 'tblMenuBottom');
						<%'Commented and added by MahendraV On 6:20 PM 5/31/2007 for top menu consistency'%>
						<%'Start_MV_5/31/2007 '%>
						//objMenuTop.style.display = 'none';
				    //objMenuBottom.style.display = 'none';

				    //Commented By Vaijat K ON 19/11/2015 - Issue ID-1974
						//objMenuTop.style.visibility = 'hidden';
						//objMenuBottom.style.visibility = 'hidden';
						<%'End_MV_5/31/2007 '%> 
						
				
					objfrmDailyActivityMatrix.action = strHREF;
					objfrmDailyActivityMatrix.submit();
				}
			}						
				
			
			function NextWeek()
			{
				//Purpose :	To show details of next week.
				flagSubmit = setSubmitFlag();
				if (flagSubmit == true)
				{
					var strResponse, strHREF;
					objfrmDailyActivityMatrix = GetFormReference('frmDailyActivityMatrix');
				    //Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
					//strHREF = "PM_DailyActivityMatrix.aspx?FromDate=<%=CommonFunctions.Dates.GetDate(DateAdd("d",7,Date.Parse(dtmFromDate)))%>&ToDate=<%=CommonFunctions.Dates.GetDate(DateAdd("d",7,Date.Parse(dtmToDate)))%><%If Request.QueryString("ShowClose") = "1" Then Response.Write("&ShowClose=1")%>";
				    strHREF = "PM_DailyActivityMatrix.aspx?ShowDetails=0&FromDate=<%=CommonFunctions.Dates.GetDate(DateAdd("d",7,Date.Parse(dtmFromDate)))%>&ToDate=<%=CommonFunctions.Dates.GetDate(DateAdd("d",7,Date.Parse(dtmToDate)))%><%If Request.QueryString("ShowClose") = "1" Then Response.Write("&ShowClose=1")%>";
				    //End of Addition by Dhanashri S on 11 Aug 2016
					if (DAFilledButNotSaved() ==true)
					{
						strResponse = window.confirm('<%=MyBase.GetResourceString("CONFIRM_SAVE")%>');
						if(strResponse == true)
						{
							strHREF = strHREF + "&Mode=Save";
						}
					}
					
					//Added By VidyaJ - issue ID - 11773
					var objMenuTop = GetObjectReference('frmDailyActivityMatrix', 'tblMenuTop');
					var objMenuBottom = GetObjectReference('frmDailyActivityMatrix', 'tblMenuBottom'); 
					<%'Commented and added by MahendraV On 6:20 PM 5/31/2007 for top menu consistency'%>
					<%'Start_MV_5/31/2007 '%>
					//objMenuTop.style.display = 'none';
				    //objMenuBottom.style.display = 'none';

				    //Commented By Vaijat K ON 19/11/2015 - Issue ID-1974
					//objMenuTop.style.visibility = 'hidden';
					//objMenuBottom.style.visibility = 'hidden';
					<%'End_MV_5/31/2007 '%> 
									
					objfrmDailyActivityMatrix.action = strHREF;
					objfrmDailyActivityMatrix.submit();
				}
			}
			
			function Back_OnClick()
			{
				//Purpose				:	To go back to the main daily activity screen.
						
				var strResponse, strHREF;
				objfrmDailyActivityMatrix = GetFormReference('frmDailyActivityMatrix');
				
				if(DAFilledButNotSaved() == true)
				{
					flagSubmit = setSubmitFlag();
					if (flagSubmit == true)
					{
						strResponse = window.confirm('<%=MyBase.GetResourceString("CONFIRM_SAVE")%>');
						if (strResponse == true)
						{
							strHREF = "PM_DailyActivityMatrix.aspx?FromDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(DateAdd("d",7,dtmFromDate)))%>&ToDate=<%=CommonFunctions.Dates.GetDate(Date.Parse(DateAdd("d",7,dtmToDate)))%><%If Request.QueryString("ShowClose") = "1" Then Response.Write("&ShowClose=1")%>";
							strHREF = strHREF + "&Mode=Save&ReturnToDA=1";
							objfrmDailyActivityMatrix.action = strHREF;
							objfrmDailyActivityMatrix.submit();
						}
						else
						{
						    //window.location.href = "PM_DailyActivity.aspx";
						    window.location.href = "PM_DailyActivity.aspx?FromWhere=DA";
						}
					}

				}
				else
				{
				    //window.location.href = "PM_DailyActivity.aspx";
				    window.location.href = "PM_DailyActivity.aspx?FromWhere=DA";
				}
			}
			
			
			function ShowWorkDone(dblHours)
			{
				alert(dblHours + " hours have been uploaded from the MPP !!");
			}
			
			function isArray1(obj)
			{
				if (typeof(obj) != "object") return(false);
				var s = new String();
				s = obj.constructor.toString();
				if( s.indexOf("Array") == -1 )
					return false;
				else
					return true;
			}
			
			function CheckOnHoldBlockProject()
			{
			    var strProjectsOnHold, objProject;
			
				var strProjectsOnHold = "<%=m_strProjectsOnHold%>"
				var objProject = GetObjectReference('DA',"cboProject");
					
										
			if(objProject.length == 1 )
			{
				if (strProjectsOnHold != "")
				{
					if (strProjectsOnHold.indexOf(',' + objProject.value + ',') != -1)
					{
						alert("<%=m_strProjectsOnHoldMsg%>");
					
						return false;
					}				
				}

				strDABlockedProjects="<%=m_strProjectsDABlocked%>";
				if (strDABlockedProjects != "")
				{
					if (strDABlockedProjects.indexOf(',' + objProject.value + ',') != -1)
					{
						alert("<%=m_strProjectsDABlockedMsg%>");
											
						return false;
					}			
				}	
	        }
	            return true;
	     }   
			function DAFilledButNotSaved(From)
			{
				// Purpose	:	To check if any entry has been made, and the value has not been saved.
				
				if(From!='PCC')
				{
				if(!CheckOnHoldBlockProject())
				    return false;
				}
				
				var intRow, intCol;
				try 
				{
					if (isArray1(dblHours) == false)
					{
						return(false);
					}
					
					for (intRow = 1; intRow<dblHours.length - 1; intRow++)
					{
						for(intCol = 1; intCol<dblHours[intRow].length ; intCol++)
						{
							//alert('Row: ' + intRow + ' Col: ' + intCol + ' Value : ' + dblHours[intRow][intCol]);
							if(dblHours[intRow][intCol] != -1)
							{
								return(true);
							}					
						}
					}
				}
				catch(e)
				{
					//alert(dblHours);
				}

			}
			
			function TaskLinkClick(TaskID)
			{
				if (setSubmitFlag() == true)
				{
					objfrmDailyActivity = GetFormReference('frmDailyActivityMatrix');
					objcboProject = GetObjectReference('frmDailyActivityMatrix', 'cboProject');

				    //dhn

					$.ajax({
					    type: 'POST',
					    dataType: 'json',
					    contentType: 'application/json',
					    url: 'PM_DailyActivityMatrix.aspx/GenrateURLToken_TaskLink_OnClick',
					    //data: JSON.stringify({ ProjectID: objcboProject.value,TaskID: TaskID}),
					    data: JSON.stringify({ TaskID: TaskID,EmployeeID: "<%=Session("intUserID")%>" ,ProjectID: objcboProject.value, ShowClose: 1}),
					    success: function (Result) {
					        window.open("PM_DailyActivity.aspx?FromWhere=SimpleDA&WhatToShow=Entry&ShowClose=1&PkToken=" + Result.d + "&ProjectID=" + objcboProject.value + "&TaskID=" + TaskID + "&EmployeeID=<%=Session("intUserID")%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=740,height=420");
					    },
					    error: function () {
					      //  alert("Error")
					    }
					});

                    //dhn


					//alert(window.screen.width);
				   //Commented and added by Nilesh g on 22/1/2016 for increase width
				    //window.open("PM_DailyActivity.aspx?FromWhere=SimpleDA&WhatToShow=Entry&ShowClose=1&ProjectID=" + objcboProject.value + "&TaskID=" + TaskID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=420");
					
                    //Commented by Dhanashri S on 28 Jan 2016
				    //window.open("PM_DailyActivity.aspx?FromWhere=SimpleDA&WhatToShow=Entry&ShowClose=1&ProjectID=" + objcboProject.value + "&TaskID=" + TaskID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=740,height=420");
				    //End of Comment by Dhanashri S

				    //end of Commented and added by Nilesh g on 22/1/2016 for increase width
				}
			}

			function Hours_OnChange(objTextBox, intRow, intCol, intTaskID)
			{
				//Purpose	:	To perform the client side calculations and validationsto be done, 
				//				when the hours have been changed.
				var dblColSum;
				dblColSum = 0;
				if (objTextBox.value != "")
				{
					
					<% If m_blnActualWorkHrs = False Then %>
						objHoursComplete = GetObjectReference('frmDailyActivityMatrix', objTextBox.name);
								
						if (disallowNonNumeric1(objHoursComplete , '<%=MyBase.GetResourceString("VALIDATE_NONNUMERIC_HOURS")%>', "frmDailyActivityMatrix") == true)
						{
							//window.setTimeout('document.forms["frmDailyActivityMatrix"].elements[objHoursComplete.id].focus()', 1);
							return;
						}
						//##Modified
						
						/*if (disallowValueRangeViolation1(objHoursComplete,0,intMaxEntry,'The Range of Actual Working Hours is [0.00 to ' + intMaxEntry.toFixed(2) + ']', "frmDailyActivityMatrix") == true)
						{
						    
							//window.setTimeout('document.forms["frmDailyActivityMatrix"].elements[objHoursComplete.id].focus()', 1);
							return;
						}*/
						
						if (disallowValueRangeViolation1(objHoursComplete,0,intMaxEntry,'The Range of Actual Working Hours is [0.00 to ' + intMaxEntry.toFixed(2) + ']', "frmDailyActivityMatrix") == true)
						{
						    
							//window.setTimeout('document.forms["frmDailyActivityMatrix"].elements[objHoursComplete.id].focus()', 1);
							return;
						}
						
						objHoursComplete.value = (objHoursComplete.value-0).toFixed(2);
						
						if ( (((objTextBox.value-0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)-0).toFixed(0) != ((objTextBox.value-0) / <%=CommonFunctions.Application.MinHoursForDAEntry%>) )
						{
							alert('<%=MyBase.GetResourceString("VALIDATE_MULTIPLE_HOURS")%>' + <%=CommonFunctions.Application.MinHoursForDAEntry%>);
							objTextBox.value="";
							objTextBox.focus();
							return;
						}
						
					<% End If %>
					
					
					dblHours[intRow][intCol] = (objTextBox.value - 0);
					for(intCtr = 0;  intCtr<dblHours.length - 1; intCtr++)
					{
						if (dblHours[intCtr][intCol] != -1)
						{
							dblColSum = dblColSum + dblHours[intCtr][intCol];
							
						}
					}
					
									
							
					//##Added
					intBackDating = "<%=m_strBackdatingExpiry%>"
					intFwdDating = "<%=m_strFwddatingExpiry%>"
					strProjectBackdateEntry = "<%=m_blnProjectBackdateEntry%>"
					strProjectFwddateEntry = "<%=m_blnProjectFwddateEntry%>"
					objEntryDate = GetObjectReference('frmDailyActivityMatrix', 'txtEntryDate', 1)
					objEntryDate=objEntryDate[intCol - 1].value;
		//trupti
				var strjoinigdate=GetObjectReference('frmWeeklyTimesheet','hdnJoiningdate');
				if(strjoinigdate != '')
								{
									var dtjoinigdate=getDate(strjoinigdate.value);
									var dtcurrentdate=getDate(objEntryDate);
						
									if(dtjoinigdate > dtcurrentdate)
									{
										alert('You can not logged efforts before joining date ('+ strjoinigdate.value+ ')');
										objTextBox.value="";
										objTextBox.focus();
										return true;
									}
								
								}				
				//end
					if(intBackDating.length != 0)
					{
						if (strProjectBackdateEntry != "True")
						{
							if (DateDiff(DateAdd(new Date(GetDateInFormat(objEntryDate, '', "rev")), intBackDating, 0, 0), new Date('<%=Date.Now().toString()%>'), "d") > 0 )
							{
								alert("Timesheet entry had been blocked. You cannot enter timesheet for this date!");
								objTextBox.value = "";
								dblHours[intRow][intCol] = -1;
								return;
							}
						}
					}
					
					if(intFwdDating.length != 0)
					{
						if (strProjectFwddateEntry != "True")
						{
							if (DateDiff(DateAdd(new Date(GetDateInFormat(objEntryDate, '', "rev")), -(intFwdDating-0), 0, 0), new Date('<%=Date.Now().toString("dd MMM yyyy")%>'), "d") < 0 )
							{
								alert("Timesheet entry had been blocked. You cannot enter timesheet for this date!");
								objTextBox.value = "";
								dblHours[intRow][intCol] = -1;
								return;
							}
						}
					}
					//##Ends Addition
					
					
					
					//##Modified
							//alert(dblColSum + ' And ' + intMaxEntry);
			
							
							
					if ((dblColSum - 0) > intMaxEntry )
					{
							dblOldValue = (objTextBox.value - 0);
						
					    //Commented and Added By PrashantD on 12 jan 2006
						//alert(replaceSubstring('<%=MyBase.GetResourceString("MAX_BOOKING1")%>', "<=>", (intMaxEntry + "")) + '<%=MyBase.GetResourceString("MAX_BOOKING2")%> ' + dblHours[0][intCol] + replaceSubstring('<%=MyBase.GetResourceString("MAX_BOOKING3")%>', "<=>", (intMaxEntry + "")));
						alert(replaceSubstring('<%=MyBase.GetResourceString("MAX_BOOKING1")%>', "<=>", (intMaxEntry + "")) + '<%=MyBase.GetResourceString("MAX_BOOKING2")%> ' + ((dblColSum - 0)	- dblOldValue) + replaceSubstring('<%=MyBase.GetResourceString("MAX_BOOKING3")%>', "<=>", (intMaxEntry + "")));
						
			
						
						//##Modified
						dblExcess = (dblColSum - intMaxEntry);

						objTextBox.value = ((dblOldValue -0) - (dblExcess - 0)).toFixed(2);
						if (((dblOldValue -0) - (dblExcess - 0)) < 0)
							objTextBox.value = '0.00'
							
						if ( objTextBox.value != "" )
						{
							dblHours[intRow][intCol] = (objTextBox.value - 0);
						}
						else
						{
							dblHours[intRow][intCol] = -1;
							return;
						}
					}
				}
				else
				{					
					if (dblHours[intRow][intCol] != -1)
					{
						if (GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID) != null)
							GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID).checked = false;
					}
					dblHours[intRow][intCol] = -1;
					
					return;
				}
				
				strWhichTask = dblTaskDetails[intRow][3];																
				if ( strWhichTask == "M" || strWhichTask == "O" || strWhichTask == "B" )
				{
					if (CheckForDurationChange(objTextBox, intRow, intCol, intTaskID) == false)
					{
						objTextBox.focus();
						return;
					}
				}
			}
			
			function CheckForDurationChange(objTextBox, intRow, intCol, intTaskID)
			{
			// Purpose	:	To check if the hours entered is out of date range, or has exceeded the allocated hours.
			// Returns				:	True  :- if DA entries made.
			//							False :- if no DA entry has been made.
				var blnDateViolation, blnHoursViolation;
				var strMessage = "";
				var strResponse = "";
				var blnPromptOnDurationChange, blnRestrictDurationChange;
				var objEntryDate, objDurationChange;
				
				//var showAlert=(arguments.length>3)?arguments[3]:false;
				
				objfrmMatrix = GetFormReference('frmDailyActivityMatrix');
				objtxtEntryDate = GetObjectReference('frmDailyActivityMatrix', 'txtEntryDate', 1);
				objEntryDate = objtxtEntryDate[intCol - 1];
				objDurationChange = GetObjectReference('frmDailyActivityMatrix', 'txtDuChRow' + intRow + 'Col' + intCol);
				
				dtmStartDate = dblTaskDetails[intRow][0];
				dtmEndDate = dblTaskDetails[intRow][1];
				dblAllocatedWork = dblTaskDetails[intRow][2];
				strWhichTask = dblTaskDetails[intRow][3];
				if (ConstraintViolated(objTextBox, intRow, intCol, intTaskID) == false)
				{
					blnPromptOnDurationChange = false;
					blnRestrictDurationChange = false;						
					
					if(strWhichTask == "M")
					{
						blnPromptOnDurationChange = true;
						
						<% If m_blnStatus_MPPTasks = True  Then %>
							blnRestrictDurationChange = true;
						<% End If %>
					}
					else if(strWhichTask == "O")
					{
						blnPromptOnDurationChange = true;
						<% If m_blnStatus_AssignedTasks = True Then%>
							blnRestrictDurationChange = true;
						<% End If %>
					}
				    else if( strWhichTask == "B")
				    {
					    blnPromptOnDurationChange = true;
					    <% If m_blnStatus_AssignedTasks = True %>
						    blnRestrictDurationChange = true;
					    <% End If %>
				    }		
				
					blnDateViolation = false;
					blnHoursViolation = false;

					//if (blnRestrictDurationChange == true)
					//{
						//If the entry had been made out of schedule, then...
						if( (compareDates(objEntryDate.value, dtmStartDate) < 0) || (compareDates(objEntryDate.value, dtmEndDate) > 0))
						{
							blnDateViolation = true;
							//Modified By RajaniR on 30th April 2002.
							//Changed the Date format.
							strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT1")%>' + dtmStartDate + '<%=MyBase.GetResourceString("OVERSHOOT2")%>' + dtmEndDate + '].';
							//End Modification.
						}
					//}
					
					// Get the Total Hours entered so far.
					dblRowSum = 0;
					for( intCtr = 0; intCtr<dblHours[intRow].length; intCtr++)
					{
						if (!isNaN(dblHours[intRow][intCtr]) && dblHours[intRow][intCtr] != -1 )
						{
							dblRowSum = dblRowSum + ( dblHours[intRow][intCtr] - 0 );
						}
					}
					//Check if the Total Hours exceed the allocated hours. If yes, then...
					if(dblRowSum > (dblAllocatedWork-0) )
					{
						blnHoursViolation = true;
						
						    strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT3")%>' + dblAllocatedWork + '<%=MyBase.GetResourceString("OVERSHOOT4")%>' + (dblRowSum - 0) + '<%=MyBase.GetResourceString("OVERSHOOT5")%>';
						
					}
					
					//If the entry date is not within the specified date range, or the actual work hours is exceeding the estimated hours, then pop up the message.				
					if(blnDateViolation==true ||  blnHoursViolation==true)
					{
						if(blnPromptOnDurationChange==true)
						{
							if( blnRestrictDurationChange == true)
							{
								strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT6")%>';
								//if (showAlert != false)
								//{
									strResponse = alert(strMessage);
								//}
								strResponse = false;
							}
							else
							{
								strMessage = strMessage + '<%=MyBase.GetResourceString("OVERSHOOT7")%>';
								//if (showAlert != false)
								//{
									strResponse = window.confirm(strMessage);
								//}
							}
						}
						else
						{
							strResponse = true;
						}
						if ( strResponse == true)
						{
							objDurationChange.value = "1";
						}
						else
						{
							objTextBox.value = "";
							dblHours[intRow][intCol] = -1;
							//controlArray[0][5] = true;
							return false;
						}
					}
					//controlArray[0][5] = true;
					return true;
				}
			}		
			
			//TODO convert it to proper validations.			
			function txtActualPercentComplete_onblur(objTextbox, intRow)
			{
				
				//Purpose	:	To perform the validations for the 'Actual % Complete' textbox.
				//Returns				:	True  :- if DA entries made.
				//							False :- if no DA entry has been made.
				objtxtActualComplete = GetObjectReference('frmDailyActivityMatrix', objTextbox.id);
				if (disallowBlank1(objtxtActualComplete, '<%=MyBase.GetResourceString("EMPTY_PERCENT_COMPLETE")%>', "frmDailyActivityMatrix") == true)
				{
					//window.setTimeout('document.forms["frmDailyActivityMatrix"].elements[objtxtActualComplete.id].focus()', 1);
					return;
				}
				if (disallowNonNumeric1(objtxtActualComplete, '<%=MyBase.GetResourceString("EMPTY_PERCENT_COMPLETE")%>', "frmDailyActivityMatrix") == true)
				{
					//window.setTimeout('document.forms["frmDailyActivityMatrix"].elements[objtxtActualComplete.id].focus()', 1);
					return;
				}
				if (disallowValueRangeViolation1(objtxtActualComplete, 0, 100, '<%=MyBase.GetResourceString("VALIDATE_RANGE_PERCENT_COMPLETE")%>', "frmDailyActivityMatrix") == true)
				{
					return;
				}
			}
			
			<% End If %>

			function disallowBlank1(obj,msg,frm) {
				if ( disallowBlank(obj,msg) == true )
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
			//Modified by TruptiK on 3-Dec-08 RequestID-17191
		    //Purpose:-Firefox Issue
		    //if ( disallowValueRangeViolation(obj,minVal,maxVal,msg) == true )
		 	if (disallowValueRangeViolationDummy(obj,minVal,maxVal,msg) == true )
			//end of modification by TruptiK on 3-Dec-08 RequestID-17191
				{
					if((arguments.length>5)?arguments[5]:true)
					{
						window.setTimeout('document.forms["' + frm + '"].elements["' + obj.id + '"].focus()', 1);
					}
					flagSubmit = false;
					return(true);	
				}
				flagSubmit = true;
				return false;
			}
		//Addition by TruptiK on 3-Dec-08
		//Purpose:-Firefox Issue
	function disallowValueRangeViolationDummy(obj,minVal,maxVal){
	if (obj == null) {return false;} 
	if (isBlank(getInputValue(obj))) {return false;}
	var msg=(arguments.length>3)?arguments[3]:"";
	msg=replaceSubstring(msg,"&#39;","'");
		var dofocus=(arguments.length>4)?arguments[4]:true;
	var minInclusive=(arguments.length>5)?arguments[5]:true;
	var maxInclusive=(arguments.length>6)?arguments[6]:true;
	if (disallowNonNumeric(obj,msg,dofocus)) {return true;}
	else if (disallowMinValueViolation(obj,minVal,"",false,minInclusive)) 
	{
				if(!isBlank(msg)){alert(msg);}
		if(dofocus){
		            
			//setFocus(obj);
			  
			}
		return true;
	}	
	else if (disallowMaxValueViolation(obj,maxVal,"",false,maxInclusive))
	{
				if(!isBlank(msg)){alert(msg);}
		if(dofocus){
			//setFocus(obj);
			}
		return true;
	}	
	return false;
	}

	//end of addition by TruptiK on 3-Dec-08				
			function SaveValues(obj,controlType)
			{
				controlArray[0][0] = GetObjectReference('frmDailyActivityMatrix', obj.id);
				controlArray[0][1] = obj.value;
				controlArray[0][2] = controlType;
				if ( GetObjectReference('frmDailyActivityMatrix','optGeneralTasks') != null)
				{
					if (GetObjectReference('frmDailyActivityMatrix','optGeneralTasks').checked == true)
					{
						controlArray[1][0] = GetObjectReference('frmDailyActivityMatrix','optGeneralTasks');
						controlArray[1][1] = GetObjectReference('frmDailyActivityMatrix','optGeneralTasks').checked;
						controlArray[1][2] = GetObjectReference('frmDailyActivityMatrix','optGeneralTasks').value;
					}
					if (GetObjectReference('frmDailyActivityMatrix','optMPPTasks').checked == true)
					{
						controlArray[1][0] = GetObjectReference('frmDailyActivityMatrix','optMPPTasks');
						controlArray[1][1] = GetObjectReference('frmDailyActivityMatrix','optMPPTasks').checked;
						controlArray[1][2] = GetObjectReference('frmDailyActivityMatrix','optMPPTasks').value;
					}
					if (GetObjectReference('frmDailyActivityMatrix','optAssignedTasks').checked == true)
					{
						controlArray[1][0] = GetObjectReference('frmDailyActivityMatrix','optAssignedTasks');
						controlArray[1][1] = GetObjectReference('frmDailyActivityMatrix','optAssignedTasks').checked;
						controlArray[1][2] = GetObjectReference('frmDailyActivityMatrix','optAssignedTasks').value;
					}
					if (GetObjectReference('frmDailyActivityMatrix','optDefectTasks').checked == true)
					{
						controlArray[1][0] = GetObjectReference('frmDailyActivityMatrix','optDefectTasks');
						controlArray[1][1] = GetObjectReference('frmDailyActivityMatrix','optDefectTasks').checked;
						controlArray[1][2] = GetObjectReference('frmDailyActivityMatrix','optAssignedTasks').value;
					}
					if (GetObjectReference('frmDailyActivityMatrix','optAllTasks').checked == true)
					{
						controlArray[2][0] = GetObjectReference('frmDailyActivityMatrix','optAllTasks');
						controlArray[2][1] = GetObjectReference('frmDailyActivityMatrix','optAllTasks').checked;
						controlArray[2][2] = GetObjectReference('frmDailyActivityMatrix','optAllTasks').value;
					}
					if (GetObjectReference('frmDailyActivityMatrix','optTasksForTheWeek').checked == true)
					{
						controlArray[2][0] = GetObjectReference('frmDailyActivityMatrix','optTasksForTheWeek');
						controlArray[2][1] = GetObjectReference('frmDailyActivityMatrix','optTasksForTheWeek').checked;
						controlArray[2][2] = GetObjectReference('frmDailyActivityMatrix','optTasksForTheWeek').value;
					}
				}
			}
			
			function setSubmitFlag()
			{
			   
				<% If Not (m_blnDisableWVForTaskTypeProjects = True And m_blnIsTaskTypeProject = True) Then %>
				if( controlArray != null)
				{
					objControl = controlArray[0][0];
					objRadio = controlArray[1][0];
					flagSubmit = false;
					if (objControl != 0 )
					{
						if (controlArray[0][2] == "ActualComplete")
						{
							maxRange = 100;
							if (disallowBlank1(objControl, '', "frmDailyActivityMatrix") == true)
							{
								objRadio = controlArray[1][0];
								objRadio.checked = true;
								objRadio = controlArray[2][0];
								objRadio.checked = true;
								return false;
							}
						}
						else
						{
							//##Modified
							maxRange = intMaxEntry;
						}
						
						if (disallowNonNumeric1(objControl, '', "frmDailyActivityMatrix") == true)
						{
							objRadio = controlArray[1][0];
							objRadio.checked = true;
							objRadio = controlArray[2][0];
							objRadio.checked = true;
							return false;
						}
						if (disallowValueRangeViolation1(objControl, 0, maxRange, '', "frmDailyActivityMatrix") == true)
						{
						    
							objRadio = controlArray[2][0];
							objRadio.checked = true;
							objRadio = controlArray[1][0];
							objRadio.checked = true;
							return false;
						}
					}
					<% End If %>
					flagSubmit = true;
				}
					return true;
			}
			
			function ConstraintViolated(objTextBox, intRow, intCol, intTaskID)
			{
				var intConstraintType, dtmConstraintDate, blnMSPIntegration, blnEnforceConstraints;
				var blnTimeBookedAgainstTask, blnProceed, blnTaskMarkedAsComplete, objEntryDate;
				var blnConstraintViolated = false;
				var fmt = "dummy";
				arrobjEntryDate = GetObjectReference('frmDailyActivityMatrix', 'txtEntryDate', 1);
				objEntryDate = arrobjEntryDate[intCol - 1];
				<% If m_blnEnforceConstraints = False %>
					return false;
				<% End If %>
								
				intConstraintType = dblTaskDetails[intRow][5];
				dtmConstraintDate = dblTaskDetails[intRow][6];
				if (dblTaskDetails[intRow][7] == "False")
				{
					blnTimeBookedAgainstTask = false;
				} else {
					blnTimeBookedAgainstTask = true;
				}
		
				if (GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID) != null)
				{
					if (GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID).checked == true)
					{
						blnTaskMarkedAsComplete = true;
					}
					else
					{
						blnTaskMarkedAsComplete = false;
					}
				}
				<% MyBase.InitializeResources("AppResources.PM_DailyActivity", "AppResources") %>
				//Added by PrajaktaR on 19th May 2005 for PCFC IssueID 19233
				dtmConstraintDate = GetDateInFormat(dtmConstraintDate, fmt, "rev");
				//End of Addition by PrajaktaR on 19th May 2005 for PCFC IssueID 19233
				
				switch(intConstraintType)
				{
					case '0':
						//as soon as possible
						break;
					case '1':
						//as late as possible
						break;
					case '2':
						//Must Start on
						if ((DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") != 0 && blnTimeBookedAgainstTask == false) || (DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") > 0))
						{
							blnConstraintViolated = true;
							alert(replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("MUST_START_ON"))%>", '<=>', dtmConstraintDate) + ' ' + dtmConstraintDate);
						}
						break;
					case '3':
						//Must Finish on
						if ((DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") > 0 && blnTaskMarkedAsComplete) || (DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") < 0))
						{
							blnConstraintViolated = true;
							alert(replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("MUST_FINISH_ON"))%>", '<=>', dtmConstraintDate) + ' ' + dtmConstraintDate);
						}
						break;
					case '4':
						//start no earlier than
						if ((DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") > 0 && blnTimeBookedAgainstTask == false) || DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") > 0)
						{
							blnConstraintViolated = true;
							alert(replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("START_NO_EARLIER_THAN"))%>", '<=>', dtmConstraintDate) + ' ' + dtmConstraintDate);
						}
						break;
					case '5':
						//Start no later than 
						if (DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") < 0 && blnTimeBookedAgainstTask == false)
						{
							blnConstraintViolated = true;
							alert(replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("START_NO_LATER_THAN"))%>", '<=>', dtmConstraintDate) + ' ' + dtmConstraintDate);
						}
						break;
					case '6':
						//Finish no eariler than
						if (DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") > 0 && blnTaskMarkedAsComplete)
						{
							blnConstraintViolated = true;
							alert(replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("FINISH_NO_EARLIER_THAN"))%>", '<=>', dtmConstraintDate) + ' ' + dtmConstraintDate);
						}
						break;
					case '7':
						//finish no later than
						if (DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") < 0)
						{
							blnConstraintViolated = true;
							alert(replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("FINISH_NO_LATER_THAN"))%>", '<=>', dtmConstraintDate) + ' ' + dtmConstraintDate);
						}
						break;
				}
				
				if (blnConstraintViolated == true)
				{
					objTextBox.value = "";
					dblHours[intRow][intCol] = -1;
					if(intConstraintType == 3 || intConstraintType == 6 || intConstraintType == 7 )
					{
						if (GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID) != null)
							GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID).checked = false;
					}
				}
				<% MyBase.InitializeResources("AppResources.PM_DailyActivityMatrix", "AppResources") %>
				return(blnConstraintViolated);
				
			}
			
			function chkTaskCompleted_OnClick(objCheckBox)
			{
				var blnDisplayMessage;
				var intRow, intCol, intTaskID, objTR, i, objTable, objEntryDate, blnTaskMarkedAsComplete;
				var intConstraintType, dtmConstraintDate, blnTimeBookedAgainstTask;
				var strMessage = "";
				var fmt = "dummy";
				blnTaskMarkedAsComplete = objCheckBox.checked;
				
				<% If m_blnEnforceConstraints = False %>
					return;
				<% End If %>
				var objCheckBoxComplete = GetObjectReference('frmDailyActivityMatrix', objCheckBox.id);
				intTaskID = replaceSubstring(objCheckBoxComplete.name,"chkTaskCompleted","")
				//var objTR = document.getElementById("TR" + intTaskID);
				
				var objTR = GetObjectReference('frmDailyActivityMatrix', "TR" + intTaskID);
				intRow = replaceSubstring(getNameFromID(objTR),"TR","")
				intConstraintType = dblTaskDetails[intRow][5];
				dtmConstraintDate = dblTaskDetails[intRow][6];
				blnTimeBookedAgainstTask = dblTaskDetails[intRow][7];
				
				blnDisplayMessage = true
				<% MyBase.InitializeResources("AppResources.PM_DailyActivity", "AppResources") %>
				
				for(intCol=1; intCol<8; intCol++)
				{
					objEntryDate = GetObjectReference('frmDailyActivityMatrix', 'txtEntryDate', 1)[intCol - 1];
						
					if (GetObjectReference('frmDailyActivityMatrix', "txtRow" + intRow + "Col" + intCol) != null)
					if (GetObjectReference('frmDailyActivityMatrix', "txtRow" + intRow + "Col" + intCol).value != "")
					{
						fmt = "dummy1";
						switch(intConstraintType)
						{
						case '0':
							//as soon as possible
							break;
						case '1':
							//as late as possible
							break;
						
						case '2':
							//Must Start on
							if ((DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") != 0 && blnTimeBookedAgainstTask == false) || (DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") > 0))
							{
								strMessage =  replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("MUST_START_ON"))%>", '<=>', dtmConstraintDate) + ' ' + dtmConstraintDate;
							}
							break;
						case '3':
							//Must Finish on
							if ((DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") > 0 && blnTaskMarkedAsComplete) || (DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") < 0))
							{
								strMessage = replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("MUST_FINISH_ON"))%>", '<=>', dtmConstraintDate) + ' ' + dtmConstraintDate;
							}
							break;
						case '4':
							//start no earlier than
							if ((DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") > 0 && blnTimeBookedAgainstTask == false) || DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") > 0)
							{
								strMessage = replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("START_NO_EARLIER_THAN"))%>", '<=>', dtmConstraintDate) + ' ' + dtmConstraintDate;
							}
							break;
						case '5':
							//Start no later than 
							if (DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") < 0 && blnTimeBookedAgainstTask == false)
							{
								strMessage = replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("START_NO_LATER_THAN"))%>", '<=>', dtmConstraintDate) + ' ' + dtmConstraintDate;
							}
							break;
						case '6':
							//Finish no eariler than
							if (DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") > 0 && blnTaskMarkedAsComplete)
							{
								strMessage = replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("FINISH_NO_EARLIER_THAN"))%>", '<=>', dtmConstraintDate) + ' ' + dtmConstraintDate;
							}
							break;
						case '7':
							//finish no later than
							if (DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") < 0)
							{
								strMessage = replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("FINISH_NO_LATER_THAN"))%>", '<=>', dtmConstraintDate) + ' ' + dtmConstraintDate;
							}
							break;
						}
						
						if (strMessage != "")
						{
							if (blnDisplayMessage == true)
							{
								alert(strMessage);
							}
							switch(intConstraintType)
							{
								case '3':
									if ((DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") > 0 && blnTaskMarkedAsComplete) || (DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") < 0))
									{
										if (GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID) != null)
											GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID).checked = false;
										GetObjectReference('frmDailyActivityMatrix', 'txtRow' + intRow + 'Col' + intCol).value = "";
										fmt = "dummy1";
										dblHours[intRow][intCol] = -1;
									}
									break;
								
								case '7':
									if (DateDiff(GetDateInFormat(objEntryDate.value, fmt, "rev"), dtmConstraintDate, "d") < 0)
									{
										if (GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID) != null)
											GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID).checked = false;
										GetObjectReference('frmDailyActivityMatrix', 'txtRow' + intRow + 'Col' + intCol).value = "";
										dblHours[intRow][intCol] = -1;
									}
									break;
								case '6':
									if (GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID) != null)
										GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID).checked = false;
									break;
							}
							
							blnDisplayMessage = false;
						}
					}
				}			
				
				if (intConstraintType == '6' && fmt == "dummy")
				{
					if (arguments.length > 1 && DateDiff(arguments[1], dtmConstraintDate, "d") > 0 ) 
					{
						blnDisplayMessage = false;
					}
					else if (arguments.length == 1)
					{
						blnDisplayMessage = false;
					}
					if (blnDisplayMessage == false)
					{
						if (GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID) != null)
							GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID).checked = false;
						alert(replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("FINISH_NO_EARLIER_THAN"))%>", '<=>', dtmConstraintDate) + ' ' + dtmConstraintDate);
					}
				}

				if (intConstraintType == '3' && fmt == "dummy")
				{
					if (arguments.length > 1 && DateDiff(arguments[1], dtmConstraintDate, "d") != 0 ) 
					{
						blnDisplayMessage = false;
					}
					else if (arguments.length == 1)
					{
						blnDisplayMessage = false;
					}
					if (blnDisplayMessage == false)
					{
						if (GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID) != null)
							GetObjectReference('frmDailyActivityMatrix', 'chkTaskCompleted' + intTaskID).checked = false;
						alert(replaceSubstring("<%=Server.HTMLDecode(MyBase.GetResourceString("MUST_FINISH_ON"))%>", '<=>', dtmConstraintDate) + ' ' + dtmConstraintDate);
					}
				}
				
				<% MyBase.InitializeResources("AppResources.PM_DailyActivityMatrix", "AppResources") %>		
			}

        function SelectProject(obj)
        {
            var objCP=GetObjectReference('','cboProject');
            var cboProjectID;
            if(objCP.selectedIndex > -1)
            {
                 cboProjectID=objCP.options[objCP.selectedIndex].value;
                window.open("TimesheetProjectList_CommonList.aspx?MasterTagID=3990&cboProjectID="+cboProjectID,"","resizable=yes,scrollbars=no,width=700,height=400,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 400)/2 + ",status =no,titlebar=no,location=no");    
            }
            else
                alert('No active projects accessible !'); 
        }
		</script>
	</body>
</HTML>
