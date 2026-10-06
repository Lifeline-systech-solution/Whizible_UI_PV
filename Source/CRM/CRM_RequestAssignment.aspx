<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_RequestAssignment.aspx.vb" Inherits="PbNIT.CRM_RequestAssignment"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Assignment")%>
    <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>


<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    .clsTable td
    {
        vertical-align: top !important;
    }
</style>

<script type="text/javascript">
    
   
    $(document).ready(function()
    {
        setFrameLoader(); //Added By Nilesh g on 22/1/2016 for loader

        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 15/12/2015
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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 15/12/2015
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="FlowLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
				<form id='frmRequestAssignment' method='post' runat='server'>
						
									<%WritePage()%>
								
					</form>
				<link href="../General/loaderStylesheet.css" rel="stylesheet" />
					<script language="javascript">
		var objform;
		var objdivlist;
		var objtxtSummary;
		var objtxtDescription;
		var objcboProject;
		var objcboAssignTo;
		var objcboStatus;
		var objcboType;

		window.onload = function () {
		    RemoveFrameLoader(); //Added By Nilesh g on 22/1/2016 for loader
		}
		
		objform = GetFormReference('frmRequestAssignment');
		//Modified By VarunA on 24-Sep-2008 IssueID-22520
        //Purpose : To have proper alignment in Mozilla
		//objdivlist = GetObjectReference('frmRequestAssignment','DivList');
		objdivlist = GetObjectReference('frmRequestAssignment','DivMain');
		//End By VarunA on 24-Sep-2008 IssueID-22520
		objtxtSummary= GetObjectReference('frmRequestAssignment','txtSummary');;
		objtxtDescription=GetObjectReference('frmRequestAssignment','txtDescription');
		objcboProject =GetObjectReference('frmRequestAssignment','cboProject');
		objcboAssignTo =GetObjectReference('frmRequestAssignment','cboAssignTo');
		objcboStatus =GetObjectReference('frmRequestAssignment','cboStatus');
		objcboType =GetObjectReference('frmRequestAssignment','cboType');
		<%'Added By nitinVS on 13 Mar 2007 for WhizibleSEM SP 8 IssueID11674 %>
		intCompanyHrsPerDay = <%=m_dblHoursPerDay%>;
		intCompanyWeekDays = <%=m_lngWeekDays%>;
		<%'End Addition By nitinVS on 13 Mar 2007 for WhizibleSEM SP 8 IssueID11674 %>		
		
		<%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
		function TimesheetDetails_OnClick()
		{
			window.open ("CRM_OtherDetails.aspx?Mode=TIMESHEET_DETAIL&QueryID=<%=m_strQueryID%>" ,"_TimesheetDetails","resizable=yes,scrollbars=no,width=600,height=500"); 
		}
		
		function PreviousIssues_OnClick()
		{
            //Added and commented by Yogesh J on 28-Jan-2016 to pass token
			//window.open ("CRM_OtherDetails.aspx?Mode=PREVIOUS_ISSUES_LIST&QueryID=<%=m_strQueryID%>" ,"_PreviousIssueList","resizable=yes,scrollbars=no,width=600,height=500"); 
		    window.open ("CRM_OtherDetails.aspx?Mode=PREVIOUS_ISSUES_LIST&QueryID=<%=m_strQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail_Multiple%>" ,"_PreviousIssueList","resizable=yes,scrollbars=no,width=600,height=500"); 
		    //End of addition by Yogesh J on 28-Jan-2016  to pass token
		}
		
		function cboProject_OnChange()
		{
		
			//Not allowing the user to Create Tasks against OnHold Projects
				var strProjectsOnHold, objProject, strMode;
				
				strProjectsOnHold = "<%=m_strProjectsOnHold%>"
				objProject = GetObjectReference('DA',"cboProject");
				strMode = "<%=m_strAction%>"
				///alert('yes');
				//alert(strProjectsOnHold);
				//alert('<%=m_strMode%>');
				
				if (strProjectsOnHold != "" && objProject.value!="" )
				{
					if (strProjectsOnHold.indexOf(',' + objProject.value + ',') != -1)
					{
						alert("You are not allowed to create task/issue against selected project as Project is On Hold");
						
							if (strMode != "Edit")
							{
								objProject.value = "";
								
							}
							else
							{
								objProject.value = "'<%=lngProjectID%>'";
							}
							
						return;
					}			
				}	
				//End of Addition
				
			objform.action = "CRM_RequestAssignment.aspx?functionID=<%=lngFunctionID%>&ProjectChanged=1&Mode=<%=m_strMode%>&QueryID=<%=m_strQueryID%>&ProjectID="+objcboProject.value;
			objform.submit();
		}
		
		function cboType_OnChange()
		{
			objform.action = "CRM_RequestAssignment.aspx?functionID=<%=lngFunctionID%>&TypeChanged=1&Mode=<%=m_strMode%>&QueryID=<%=m_strQueryID%>";
			objform.submit();
		}
		
		function Assign_OnClick()
		{	
			var mode;
			var objTaskType,objWorkHrs,objStartDate,objEndDate;
			var dblTotalWork;
			
			objTaskType=GetObjectReference('frmRequestAssignment','cboTaskType');
			objWorkHrs=GetObjectReference('frmRequestAssignment','txtWork');
			objStartDate=GetObjectReference('frmRequestAssignment','txtStartDate');
			objEndDate=GetObjectReference('frmRequestAssignment','txtEndDate');
			objSubmittedDate=GetObjectReference('frmRequestAssignment','txtHiddenSubmittedDate');
			mode = "<%=m_strMode%>";
			var strAction="<%=m_strAction%>" ;
			var strEmployeeList ="<%=m_strPrevAssignTo%>"
			var strQueryList = "<%=m_strQueryID%>"
			var hidProjectStartDate,hidProjectEndDate;
			hidProjectStartDate =GetObjectReference('frmRequestAssignment','hidProjectStartDate');
			hidProjectEndDate=GetObjectReference('frmRequestAssignment','hidProjectEndDate');
			
			// added By purvaj on 7 Nov 2008 for Whiziblesem 8.0
		    // validation currentwork should be greater than actual work hours filled
		    objActualWork = GetObjectReference('frmTaskAssignment','hid_txtActualWork');
		    if (objWorkHrs!=null && objActualWork!=null && parseFloat(objWorkHrs.value) < parseFloat(objActualWork.value))
		    {
		        alert('Current Work hours should be greater than Actual work hours ('+objActualWork.value +').');
		        objWorkHrs.focus();
		        objWorkHrs.select();
		        return;
		    }
		    // End addition purvaj
			
		    //Added by SavitaS on 18 Jan 2006
		    //Commented and Added by Dhanashri S on 22 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
		    //if (mode == "ASSIGN_TASK" || mode == "ASSIGN_TASK,ADD_NEW" || mode == "ASSIGN_MULTIPLE_TASKS")
		    if (mode == "ASSIGN_TASK" || mode == "ASSIGN_TASK,ADD_NEW" || mode == "ASSIGN_MULTIPLE_TASKS" || mode == "ASSIGN_ISSUE")
		        //End of comment and addition by Dhanashri S on 22 Aug 2016 
			{		
				<%' Added BY NitinVS on 12 Mar 2007 for WhizibleSEM SP 8 IssueID 11530%>
				<%' if Project is not baselined or project is onhold donot allow to create task %>
				<%If  m_blnProjectOnHold = True%>
				alert("<%=m_strProjectOnHoldMessage%>");
				return;
				<%End If %>

				<%If m_blnIsProjectCreationWorkflowReqd = True AND  m_intBaselineNumber = 0%>
				alert("<%=m_strBaselineMessage%>");
				return;
				<%End If %>
				
				<%' End Addition BY NitinVS on 12 Mar 2007 for WhizibleSEM SP 8 IssueID 11530%>
				var lngProjectAllocatedHours = '<%=lngAllocatedHours%>' ;
				var lngProjectHours  = '<%=lngProjectHours%>' ;
				var lngBalanceHours ;
				if (disallowBlank(objcboProject,"Project cannot be blank !",true)) return;
				if (disallowBlank(objTaskType,"Task Type cannot be blank !",true)) return;
				if (disallowBlank(objWorkHrs,"Work Hrs cannot be blank !",true)) return ;
				if (disallowBlank(objStartDate,"Start Date cannot be blank !",true)) return ;
				if (disallowBlank(objEndDate,"End Date cannot be blank !",true)) return;
				if (disallowNonNumeric(objWorkHrs,"Please enter numeric value for Work Hrs !",1) == true) return;
			    //Added by Chakshuta H on 22nd-Aug-2016 Purpose::Qa issue fixing
				if(objStartDate!=null && objSubmittedDate!=null)
				    //End Of Added by Chakshuta H on 22nd-Aug-2016 Purpose::Qa issue fixing
				{
				if (disallowDate1LessThanDate2(objStartDate,objSubmittedDate,"'Start Date' cannot be less than 'Request Submission Date' -" + objSubmittedDate.value)== true)
					{
						return ;
					}			
					
				if (disallowDate1GreaterThanDate2(objStartDate,objEndDate,"Please enter End Date greater than Start Date")== true)
					{
						return ;
					}				
				}
			    //Added by Chakshuta H on 22nd-Aug-2016 Purpose::Qa issue fixing
				if(objWorkHrs!=null)
				{
				    //End Of Added by Chakshuta H on 22nd-Aug-2016 Purpose::Qa issue fixing
				    if ( (parseFloat(lngProjectAllocatedHours) + parseFloat(objWorkHrs.value)) > parseFloat(lngProjectHours))
				    {
				        lngBalanceHours = (parseFloat(lngProjectHours)- parseFloat(lngProjectAllocatedHours))		;
				        alert("Total work(hours) of tasks should not exceed the Project Work Hours ("+parseFloat(lngProjectHours).toFixed(2)+")\n Balanced work hours are "+ parseFloat(lngBalanceHours).toFixed(2));
				        return;
				    }				
				    dblTotalWork=objWorkHrs.value;
				    if((dblTotalWork / <%=CommonFunctions.Application.MinHoursForDAEntry%>) != parseInt(dblTotalWork / <%=CommonFunctions.Application.MinHoursForDAEntry%>))
				    {		
				        strMsg = "Please specify the work (hours) <=> in multiples of <==> hours.\nThis is necessary because the user can only fill a minimum of <==> hours in the timesheet.";
				        strMsg = replaceSubstring(strMsg, "<=>", "");
				        strMsg = replaceSubstring(strMsg, "<==>", "<%=CommonFunctions.Application.MinHoursForDAEntry%>");
				        alert(strMsg);
				        setFocus(objWorkHrs);
				        return ;
				    }
				}
					<%'//Added By NitinVS on 13 Mar 2007 for WhizibleSEM SP 8 IssueId 11674	%>
			    <%' Added validation for 24 hrs per day %>
			    if(objStartDate!=null && objEndDate!=null)
			    {
					dtstart = getDate(objStartDate.value);
					dtEnd = getDate(objEndDate.value);
					dblTotalDuration = DateDiff(dtstart,dtEnd, "d") + 1;
					dblAvgHoursPerDay = dblTotalWork/dblTotalDuration;		
					if(dblAvgHoursPerDay > 24)
					{
						alert("You cannot assign more than 24 hours work per day");
						setFocus(objWorkHrs);
						return ;
					}
					
					if(  dblTotalWork <= 0 )
					{
							alert("Please enter only numeric value greater than 0 for Work Hrs !");
							setFocus(objWorkHrs);
							return;
					}
			    }
					<%'//Added By NitinVS on 13 Mar 2007 for WhizibleSEM SP 8 IssueId 11674	%>
					<%' Added validation for 24 hrs per day %>
					
	/*		if ((mode == "ASSIGN_TASK" || mode == "ASSIGN_TASK,ADD_NEW")||mode =="ASSIGN_MULTIPLE_TASKS" ) //&& "<%=m_intPrevAssignTo%>//" != "0" 
			{//*/
				if (('<%=m_lngOldAssignTo%>' != '0' )||('<%=m_lngOldTaskTypeID%>' !='0' )||('<%=m_lngOldProjectID%>' !='0'))
				{
				if ("<%=m_blnHasTimesheetDetails%>" == "True")
					{
					if ((objcboAssignTo.value != <%=m_lngOldAssignTo%>)|| (objTaskType.value != <%=m_lngOldTaskTypeID%>) ||( objcboProject.value != <%=m_lngOldProjectID%>))
					{				
						alert ("Timesheet has been filled by the resources ,so cannot assign !");
						objcboAssignTo.value = <%=m_lngOldAssignTo%> ;
						objTaskType.value = <%=m_lngOldTaskTypeID%> ;
						objcboProject.value = <%=m_lngOldProjectID%> ;
						return;
					}
					}	
				}
				//Added by PrashantD on 25 Feb 2006 for IssueID 1936
									
				if (hidProjectStartDate && hidProjectStartDate.value != "0")
				{
						if (disallowDate1GreaterThanDate2(hidProjectStartDate,objStartDate,"Please enter Start Date not less than Project Start Date " + hidProjectStartDate.value)== true)
							{
								return ;
							}			
				}
				if (hidProjectEndDate && hidProjectEndDate.value != "0")
					{
						if (disallowDate1GreaterThanDate2(objEndDate,hidProjectEndDate,"Please enter End Date not greater than Project End Date " + hidProjectEndDate.value)== true)
							{
								return ;
							}		
					}				
				
				//end of addition by PrashantD on 25 Feb 2006 for whiziblesem 6 IssueID 1936
			
			//Added By Vijayd On 19 August 2009 to check Resource Level VALIDATION wHILE Assigning the Task
			    if(<%=m_bitResourceValidation%>==1)
			    {       
                    if(ValidateResourceDate(objStartDate,objEndDate)==false)
                    return false;
			    }
			    
			    //End Addition  By Vijayd On 19 August 2009
			    //Added by Chakshuta H on 22nd-Aug-2016 Purpose::Qa issue fixing
			    if(objcboAssignTo!=null)
			    {
			        //End Of Added by Chakshuta H on 22nd-Aug-2016 Purpose::Qa issue fixing
			        if (strAction!="EDIT")
			        {
			            if (strEmployeeList.indexOf(','+ objcboAssignTo.value +',')!= -1)
			            {
			                alert("Task has been already assigned to this resource against request ID - " +strQueryList);
			                return ;					
			            }
			        }
			    }
			    
					if (strAction=="EDIT")
					{
					    if (<%=m_lngOldAssignTo%> != 0 )
					    {
					        if(objcboAssignTo!=null)
					        {
					            if (objcboAssignTo.value != <%=m_lngOldAssignTo%>)
					            {
										if (strEmployeeList.indexOf(','+ objcboAssignTo.value +',')!= -1)
					            {
					                alert("Task has been already assigned to this resource against request ID - " +strQueryList);
					                return ;					
					            }							
					        }
					    }
							}
					}
			   //}
		}
			// end of modification by harshada d for helpdesk enhancements on 11 feb 2006 for whiziblesem 6 issue id 1936
			
			if (mode != "ASSIGN")
					{
						var objProductVersionID = GetObjectReference('frmRequestAssignment','ProductVersionID');
						var objCustomerID = GetObjectReference('frmRequestAssignment','CustomerID');
						if (disallowBlank(objcboProject,"Please select the project")) return;
					    if (disallowBlank(objCustomerID,"Please select the Customer")) return;
					    if (disallowBlank(objProductVersionID,"Please select the Product")) return;
					    
						
					}
			
			if (mode == "ASSIGN_ISSUE")
					{
						if (disallowBlank(objtxtSummary,"Please enter the summary")) return;
						if (disallowMaxlengthViolation(objtxtSummary,512,"Please enter the summary within 512 characters")) return;
						if (disallowBlank(objtxtDescription,"Please enter the description")) return;
					}
			
			if (disallowBlank(objcboAssignTo,"Please select the resource")) return;	
			if (mode == "ASSIGN_ISSUE")
				{
					if (disallowBlank(objcboStatus,"Please select the issue status")) return;		
					if (disallowBlank(objcboType,"Please select the issue type")) return;		
				}				
				// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
				// objform.action = "CRM_RequestAssignment.aspx?Action=SAVE&Mode=<%=m_strMode%>&QueryID=<%=m_strQueryID%>"		
		    //Added By NILESH G on 7/11/2016 Purpose::APPLY LOADER 
		    var MenuTags = document.getElementsByTagName('A');
		    for (i = 0; i < MenuTags.length; i++) {
		        if (MenuTags[i].className == "Menu") {
		            //MenuTags[i].style.display= "none";
		            MenuTags[i].parentNode.style.display = "none";
		        }
		    }
		    setFrameLoader();
		    // End of Added By NILESH G on 7/11/2016 Purpose::APPLY LOADER
		    objform.action = "CRM_RequestAssignment.aspx?Action=SAVE&Mode=<%=m_strMode%>&QueryID=<%=m_strQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail_Multiple%>" 		
				objform.submit()

				//var strQueryID = "<%=m_strQueryID%>";
				//var strMode = "<%=m_strMode%>";
				//var strToken = "<%=m_PKToken_FromRequestDetail_Multiple%>";
				//alert(strToken);
				//refreshParent('frmRequestDetails','CRM_RequestDetail.aspx','CRM_RequestDetail.aspx?QueryID=' + strQueryID + '&Mode=' + strMode + '&PKToken=' + strToken)

				// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197				 
		}
				
		function window_onload()
		{
		 
			var intDivHeight ;
			var intDivHeightRisk;
			var mode;
			 if(navigator.appName == 'Netscape')
			 { 
			     /*COMMENTED AND EDITTED BY  KIRAN K K FOR ISSUE ID:2438 28-11-15*/
			     // intDivHeight =window.innerHeight - objdivlist.offsetTop - 40;  
			     intDivHeight = window.innerHeight - objdivlist.offsetTop-24;
			     /*COMMENTED AND EDITTED BY  KIRAN K K FOR ISSUE ID:2438 28-11-15*/
			}
			else
			 {
			     /*COMMENTED AND EDITTED BY  KIRAN K K FOR ISSUE ID:2438 28-11-15*/
			     // intDivHeight =window.innerHeight - objdivlist.offsetTop - 40;  
			     intDivHeight = window.innerHeight - objdivlist.offsetTop-24;
			     /*COMMENTED AND EDITTED BY  KIRAN K K FOR ISSUE ID:2438 28-11-15*/
			}
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+"px";	 					 								 
			
			 
			mode = "<%=m_strMode%>";

			if (mode == "ASSIGN_ISSUE")
			{
				objtxtSummary.focus();
			}
			if ((mode == "ASSIGN_TASK" || mode == "ASSIGN_TASK,ADD_NEW")||mode =="ASSIGN_MULTIPLE_TASKS" )
			{
				if ("<%=m_strAction%>"!="SAVE")
				{
				objcboProject.focus();
				}
			}
			//Commented by ShraddhaM on 27, July 2007
			/*if (mode == "ASSIGN_REQUESTS")
			{
			objcboAssignTo.focus();
			}*/
			
			//if((mode == "ASSIGN_MULTIPLE_TASKS")|| ( mode== "ASSIGN_REQUESTS"))
			//End of Comment by ShraddhaM on 27, July 2007			 
			if((mode == "ASSIGN_MULTIPLE_TASKS"))			 
			if ("<%=intCntDepts%>">1 )
			{
				alert('<%=MyBase.GetResourceString("VALIDATION_MULTIPLEDEPTS")%>');
				window.close();
				return false ;
			}
			
			if ("<%=m_strAction%>" == "SAVE")
			{
			    var ReplacedURL;
			     
			    ReplacedURL = replaceSubstring(window.opener.location.href,'Action=','Action1=');
			    ReplacedURL = replaceSubstring(ReplacedURL,'Apply=','Apply1=');			    
			    
			    window.opener.location.href=ReplacedURL;				 
				window.close();
			} 
			var strProjectsOnHold, objProject, strMode;
			strProjectsOnHold = "<%=m_strProjectsOnHold%>"
			objProject = GetObjectReference('DA',"cboProject");
			mode = "<%=m_strMode%>";
			if (mode !="ASSIGN_REQUESTS")
			{
				if ("<%=m_strAction%>" != "SAVE")
				{
				if (strProjectsOnHold != "" && objProject.value!="" )
					{
					if (strProjectsOnHold.indexOf(',' + objProject.value + ',') != -1)
						{
							if (strMode != "Edit")
							{
								objProject.value = "";
							}
							else
							{
								objProject.value = "'<%=lngProjectID%>'";
							}
						return;
						}		
					}
				}
			}	
			}
		
		//added by harshada d on 07 feb 2006 for helpdesk enhancements
		function Back_OnClick()
	{
		window.location.href = "../General/CommonList.aspx?functionID=<%=lngFunctionID%>&FromWhere=CRM&MasterTagID=3567&CRMQueryID=<%=m_strQueryID%>","resizable=yes,scrollbars=no,width=600,height=500";
	}
		function Close_OnClick()
	{
		window.close();
	}
	//end of addition by harshada d on 07 feb 2006 for helpdesk enhancements
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
		    /*COMMENTED AND EDITTED BY  KIRAN K K 28-11-15*/
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40; 
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop-24;
		    /*COMMENTED AND EDITTED END BY  KIRAN K K 28-11-15*/
			if (intDivHeight < 100)	intDivHeight = 100;
			{ /*COMMENTED AND EDITTED BY  KIRAN K K 28-11-15*/
			   // objdivlist.style.height = intDivHeight;
			    objdivlist.style.height = intDivHeight+"px";
			    /*COMMENTED AND EDITTED END BY  KIRAN K K 28-11-15*/
			}
		}
		// Integrated by ArchanaN on 26 Apr 2006
		//Added by SrikanthY on 20 Dec 2006 For Linking To Issue , Discussion pages
		//SrikanthY on 17 Jan 2007 modifed javascript function for issue 9517	
				function IssueDetails(IssueId,ProjectID,PKToken)
				{	
				
		        window.open("../IB/IB_IssueEntry.aspx?IssueID=" + IssueId + "&PKToken=" + PKToken + "&ProjectID=" + ProjectID + "&Fromwhere=HDB&OrderBy=IssueID&QueryToken=<%=m_PKToken_FromRequestDetail_Multiple%>&Queryid=<%=m_strQueryID%>","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
				}
		//End of modification by SrikanthY on 17 Jan 2007		
				function Discussion_Onclick(IssueId,PKToken)
				{
				 window.open ("../IB/IB_Discussion.aspx?IssueID="+ IssueId +"&PKToken="+PKToken+"&Fromwhere=HDASH&PageNumber=1&QueryToken=<%=m_PKToken_FromRequestDetail_Multiple%>&Queryid=<%=m_strQueryID%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=525");							  
				}	
				//End of Addition by SrikanthY
				//SrikanthY on 17 Jan 2007 Added below code,for providing sorting option in Prev Issues section
				function Sort_OnClick(sortby,sortorder)
				{
					objform.action = "CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&QueryID=<%=m_strQueryID%>&PKToken=<%=m_PKToken_FromRequestDetail_Multiple%>&SortBy=" + sortby + "&SortOrder=" + sortorder + "&SortChange="+1;
					objform.submit();  
				}
				//End of Addition by SrikanthY on 17 Jan 2007
//Added by PrashantD on 21 March 2007 for Product Association
		function ProductVersion_OnChange()
		{ 
			getCustomerComboValue('frmRequestAssignment' ,'CustomerID') ;
			var objProductVersionID = GetObjectReference('frmRequestAssignment','ProductVersionID');
			var objComponentID = GetObjectReference('frmRequestAssignment','ComponentID');
			if (objProductVersionID != null && objProductVersionID.selectedIndex==0)
			{	
				objComponentID.length=0;
				return;
			}
			
			//onSelection('frmCommonPage' ,'MainControl','DependentControl' ,'TagID','PrimaryKeyOfCLCP','Mode');
			onSelection('frmRequestAssignment','ProductVersionID','ComponentID','2133','QueryID','EDIT',GetObjectReference('frmRequestAssignment','cboProject').value);
		}
		function Customer_OnChange()
		{	
			var objCustomer = GetObjectReference('frmRequestAssignment','CustomerID');
			var objProductVersionID = GetObjectReference('frmRequestAssignment','ProductVersionID');
			var objComponentID = GetObjectReference('frmRequestAssignment','ComponentID');
			if (objCustomer.selectedIndex==0)
				{	
					objProductVersionID.length=0;
					objComponentID.length=0;
					
					return;
				}
				
			getCustomerComboValue('frmRequestAssignment' ,'CustomerID') ;
		
			onSelection('frmRequestAssignment','CustomerID','ProductVersionID','2133','QueryID','EDIT',GetObjectReference('frmRequestAssignment','cboProject').value);
			objComponentID.length=0;
		}	
		//End of addition by PrashantD on 21 March 2007			 
		 // Integration Ends
			//'Added by ShraddhaM on 27, July 2007
            //'Purpose : Change AssignTo Combo in TextBox on HelpDesk --> Assign Multiple Request Page
             //added by Nilesh g on 15/1/2016 for add function     
		    function getCustomerComboValue(strForm ,strCustomerCombo) 
		    {
		        objCustomerCBO = GetObjectReference(strForm,strCustomerCombo);
		    }
	        //endded by Nilesh g on 15/1/2016 for add function     
			    function AssignTo_OnClick()
			{
				window.open ("../HR/ResourceSelection_CommonList.aspx?MasterTagID=3633&PTagID=0&FromWhere=CRMEDashboard", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 1000)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=1000,height=400");
			}
			//'End of Additon by ShraddhaM on 27, July 2007
			
			//Added By VijayD On 20 August 2009
			//Purpose : To Provide  the Resource level  Validatation 
			var strResult
	        function ValidateResourceDate(objSDt,objEDt)
	        {
	            
		        var objResourceStartDate,objResourceEndDate,objEmp;
		        var strUrl;
		        objEmp = GetObjectReference('frmRequestAssignment','cboAssignTo');
		        var objcboProject =GetObjectReference('frmRequestAssignment','cboProject');
		        if(objSDt!=null)
		        {
		            strUrl = "../General/XMLHttp.aspx?TagID=0&Mode=CRM_RequestAssignment&CurrentStartDate=" + encodeURIComponent(objSDt.value) + "&CurrentEndDate=" + encodeURIComponent(objEDt.value)+ "&EmployeeID="+objEmp.value+"&ProjectID="+objcboProject.value;
		            ValidateResourceDate_XML(strUrl);
		            if(strResult!=null && strResult!="")
		            {
		                alert(strResult);
		                return false;		    
		            }
		        }
		        return true;
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
			function ValidateResourceDate_XML(strUrl) 
			{ 		
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
							    g_objXHttp.open("GET",strUrl, false);
							    //finally send the call
							    g_objXHttp.send();
							}
							else
							{
							    // Mozilla - based browser , Netscape
							    g_objXHttp = new XMLHttpRequest();
							    //hook the event handler
							    g_objXHttp.onreadystatechange = TaskValidation_state_change;
							    //prepare the call, http method=GET, false=asynchronous call
							    g_objXHttp.open("GET",strUrl, false);
							    //finally send the call
							    g_objXHttp.send(null);
								
							    if ( g_objXHttp.responseText != null)
							    {
							        xmlDoc= document.implementation.createDocument("","",null);
							        xmlDoc.async=false;
							        if (Browser == 'FF') // Added By Vaijat K ON 19/11/2015
							        xmlDoc.load(g_objXHttp.responseXML);
							        strResult=g_objXHttp.responseText;
							    }								
							}
						return 	strResult;			
			} 
			
			function TaskValidation_state_change() 
			{			
			    var Browser = WhichBrowser(); // Added By Vaijat K ON 19/11/2015
				if (g_objXHttp.readyState == 4) 
				{				
			   		// Make sure request came back OK 
					if (g_objXHttp.status == 200) 
					{
					    //if (window.ActiveXObject)
					    if (Browser == 'IE') // Added By Vaijat K ON 19/11/2015
						{
							xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
							xmlDoc.async=false;
							xmlDoc.loadXML(g_objXHttp.responseText);
						}
						// code for Mozilla, etc.
						else if (document.implementation &&	document.implementation.createDocument)
						{
							xmlDoc= document.implementation.createDocument("","",null);
							xmlDoc.async=false;
							if (Browser == 'FF') // Added By Vaijat K ON 19/11/2015
							xmlDoc.load(g_objXHttp.responseXML);
						}
						//Save the Result in a Global variable
						strResult=g_objXHttp.responseText;		
					}
				}
			}			
//End Addition By Vijayd On19 August 2009			
</script>
				
	</body>
</HTML>
