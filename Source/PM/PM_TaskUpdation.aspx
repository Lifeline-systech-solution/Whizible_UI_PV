<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_TaskUpdation.aspx.vb" Inherits="PbNIT.PM_TaskUpdation"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<HEAD>
		
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
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


	</HEAD>
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		<form id="frmPM_TaskUpdation" method="post" runat="server">
			<%PageInit%>
		</form>
		<SCRIPT language="javascript">
		var objform=GetFormReference('frmPM_TaskUpdation');
		var objdivlist=GetObjectReference('frmPM_TaskUpdation','PageDiv');
		var objdivlist1=GetObjectReference('frmPM_TaskUpdation','DivList');
		var strTaskIDs='';
		var dtStartDate, dtEndDate , dtMozillaStartDate; 
				
		// Added by ShubhadaL on 1 Feb,2006 
		//Purpose: Function to show/hide the div section of the Filters.
		var Flag=<%=m_FilterDivStatus.toString.toLower%>;
		var objDIV= GetObjectReference('frmPM_TaskUpdation','Show');
		var objimg= GetObjectReference('frmPM_TaskUpdation','imgShowHide');
		var objFilterDivStatus= GetObjectReference('frmPM_TaskUpdation','hidFilterDivStatus');
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		function showHide_div()
		{

		   if (Flag==true)
		   {
		        objDIV.style.display='none';
				objimg.src='../../Images/plus.gif';
				Flag=false;
				objFilterDivStatus.value="Close";
			
				return;
			}
			if(Flag==false)
			{ 
			    objDIV.style.display='';
			    objimg.src='../../Images/minus.gif';
				Flag=true;
				objFilterDivStatus.value="Open";
				
				return;
			}
		}
		//End of addition by Shubhadal on 1 Feb,2006
		
		
		//The div tag has id as PageDiv 
		/*function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;	}			
			strTaskIDs = '';
			//Added by ShubhadaL on 1 Feb 2006 
			//Purpose : to disable date controls if Show All Tasks is clicked.
			
			 
			 var objoptAllTasks= GetObjectReference('frmPM_TaskUpdation','optAllTasks');
			 
			 if (objoptAllTasks.checked == true)
			  optTasks_OnClick('ShowALL');
			 else
			 optTasks_OnClick('ShowWeekly');
			 
			 //End addition by ShubhadaL on 1 Feb 2006
		}*/
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			
			var intDivHeight ;
			var intDivListPageHeight ;
			var intDivHeightRisk;
			var lc;
			if (objdivlist != null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

		if(navigator.appName == 'Netscape')
		    {
		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 65 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
		    }
			if (intDivHeight < 100)
				intDivHeight = 100;
			objdivlist.style.height = intDivHeight;}
			if (objdivlist != null) {
			    intDivListPageHeight = intDivHeight;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist1.style.height = intDivListPageHeight;
			    objdivlist1.style.height = intDivListPageHeight + 'px';
            }
			strTaskIDs = '';
				//Added by ShubhadaL on 1 Feb 2006 
				//Purpose : to disable date controls if Show All Tasks is clicked.
				
				 
				var objoptAllTasks= GetObjectReference('frmPM_TaskUpdation','optAllTasks');
				 
				if (objoptAllTasks.checked == true)
				optTasks_OnClick('ShowALL');
				else
				optTasks_OnClick('ShowWeekly');
				 
				//End addition by ShubhadaL on 1 Feb 2006
		}
		
		/*function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;	}
		}*/	
		
		function window_onresize()		
		{
			
			var intDivHeight ;
			var intDivHeightRisk;
			var intDivListPageHeight ;
			if (objdivlist != null) {
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

		if(navigator.appName == 'Netscape')
		    {
		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 65 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
		    }
			if (intDivHeight < 100)
				intDivHeight = 100;
					
			objdivlist.style.height = intDivHeight	;}
			if (objdivlist != null) {
			    intDivListPageHeight = intDivHeight - 5 ;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist1.style.height = intDivListPageHeight;
			    objdivlist1.style.height = intDivListPageHeight + 'px';
			}
		}
		
		function Show_OnClick()
		{
			var objFromDate, objToDate, intProjectID, strTaskType, objTaskType, intCnt;
			
			objFromDate = GetObjectReference('frmPM_TaskUpdation','txtFromDate').value;
			objToDate = GetObjectReference('frmPM_TaskUpdation','txtToDate').value;
			intProjectID = GetObjectReference('frmPM_TaskUpdation','cboProject').value;
			
			
			
			objTaskType = GetObjectReference('frmPM_TaskUpdation','optTaskType',true);
			for(intCnt=0; intCnt < objTaskType.length; intCnt++)
			{
				if(objTaskType[intCnt].checked)
					strTaskType = objTaskType[intCnt].value;
			}
			//intigrated by harshk for sp4 isueid 190
			// Purpose-To pass EmployeeID into Querystring 
			var intEmployeeID ;
			intEmployeeID = GetObjectReference('frmPM_TaskUpdation','cboEmployee').value;
			
			var objAllTasks;
			objTaskType = GetObjectReference('frmPM_TaskUpdation','optTaskType');
			objEmployee = GetObjectReference('frmPM_TaskUpdation','cboEmployee');
			
			if ((strTaskType=='A') && (intEmployeeID==''))
			{
				alert("Resource Selection is mandatory if 'Show All Tasks Assigned' is selected")
				return;
			}
			
			if (IsValidInput() == true)
			{
				
				objform.action = "PM_TaskUpdation.aspx?FromWhere=PM&MasterTagId=<%=m_lngTagId%>&Mode=List&FromDate=" + objFromDate + "&ToDate=" + objToDate + "&ProjectID=" + intProjectID + "&TaskType=" + strTaskType + "&EmployeeID=" + intEmployeeID;
				objform.submit();
			}
			//End intigrated by harshk for sp4 issueid 190
		}
		
		function IsValidInput()
		{
			//Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4192	
			// Modified by SandipL on 16 May 2006 For WhizEnggSP6 IssueID 3748
			// Whiz Date Control will be plot conditionally 
			var objFromDate, objToDate,objPrevFromDate,objPrevToDate;
			//Added by MrugajaB on 5th April 2006 for WhizibleSEM 6.0 Issue ID.684
			//Purpose:For displaying all tasks irrispective of their tasktype
			var objEmployee;
			//End Addition
			
			
			var isDateEditable = '<%=CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled")%>';
			//End Integration
			
			objPrevFromDate = GetObjectReference('frmPM_TaskUpdation','txtFromDate');
			objPrevToDate = GetObjectReference('frmPM_TaskUpdation','txtToDate');
			
			//objFromDate = GetObjectReference('frmPM_TaskUpdation','txtFromDate');
			//objToDate = GetObjectReference('frmPM_TaskUpdation','txtToDate');
			
			//Modified by MrugajaB on 4th July 2006 for WhizibleSEM SP7 Issue ID.4168
		   if(navigator.appName != 'Netscape')
   			{
				objFromDate = GetObjectReference('frmPM_TaskUpdation','FFE29587WHIZ_txtFromDate');
		   		objToDate = GetObjectReference('frmPM_TaskUpdation','FFE29587WHIZ_txtToDate');
						
				if (isDateEditable == 'False')
				{
					objFromDate = objPrevFromDate;
					objToDate = objPrevToDate;
				}
			}
			//End Modification by SandipL  on 16 May 2006
			//End Integration
			
			//End Modification by MrugajaB
				
			//Added by ManishK on 23th Feb 06 For IssueID 2445
			var objAllTasks;
			objAllTasks = GetObjectReference('frmPM_TaskUpdation','optAllTasks');
			if (objAllTasks.checked==false)
			{
			//End of Added by ManishK on 23th Feb 06 For IssueID 2445
			
				if(navigator.appName == 'Netscape')
   				{
					if(objPrevFromDate.value=='' )
					{
					alert("From Date Should not be Blank");
					return false;
					}	
				}
				else
				{
					if(objFromDate.value=='' )
					{
					alert("From Date Should not be Blank");
					objFromDate.focus();
						return false;
					}	
				}
				
			}
			
			//Added by ManishK on 23th Feb 06 For IssueID 2445
			if (objAllTasks.checked==false)
			{
			//End of Added by ManishK on 23th Feb 06 For IssueID 2445
				if(navigator.appName == 'Netscape')
   				{
   					if(objPrevToDate.value=='') 
					{
					alert("To Date Should not be Blank");
						return false;
					}
   				}
   				else
   				{
					if(objToDate.value=='') 
					{
					alert("To Date Should not be Blank");
					objToDate.focus();
						return false;
					}
				}
			}
			
			//Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4192
			//Modified by SandipL on 16 May 2006 For WhizEnggSP6 IssueID 3748
			//if(disallowDate1GreaterThanDate2(objFromDate, objToDate, "<%=MyBase.GetResourceString("FROMDATE_LESSTHAN_TODATE")%>", true))
			//Commented and Modified by JyotiG
			//Start_JG_11499_14-Mar-2007
			//added by ArchanaN on 9 Feb 2007 for Hexaware SP8 Upgrade Issue ID 11275
			//if(disallowDate1GreaterThanDate2(objPrevFromDate, objPrevToDate, "<%=MyBase.GetResourceString("FROMDATE_LESSTHAN_TODATE")%>", true))
			//return false;
				var objAllTasks;
				var objFromDate, objToDate, objPrevFromDate,objPrevToDate;
				if (objAllTasks.checked==false)
				{
					if(disallowDate1GreaterThanDate2(objPrevFromDate, objPrevToDate, "<%=MyBase.GetResourceString("FROMDATE_LESSTHAN_TODATE")%>", true))
					{
						var dtFromfocus = GetObjectReference('frmPM_TaskUpdation','FFE29587WHIZ_txtFromDate');
						dtFromfocus.focus();
						GetObjectReference('frmPM_TaskUpdation','FFE29587WHIZ_txtFromDate').value='<%=CType(m_dtFromDate,Date).ToString("dd/MM/yyyy")%>';		
						return false;
					}
				}
			
			//End_JG_11499_14-Mar-2007
			//End Modification by SandipL  on 16 May 2006	
			//End Integration
			return true;
		}

		function PreviousWeek_OnClick()
		{
			var intProjectID, strTaskType, intCnt, objTaskType;
			//Integrated in Whiz2 by MrugajaB on 15th Dec 2005
			//Added by SandeepA on 18 Nov,2005 for IssueID-684
			var objTaskFilter=GetObjectReference('frmPM_TaskUpdation','optMainTaskFilter',true);
			//Replace the character '&#39' with the single quotes " ' "
			var msg=replaceSubstring("<%=Mybase.GetResourceString("PERVIOUS_WEEK_ALERT")%>","&#39;","'");
			 
			 if((objTaskFilter[1].checked)==false)
			 {
			 	alert(msg);
				return ;			 
			 }
			//End of addition by SandeepA on 18 Nov,2005 for IssueID-684
			//End Integration
			
			intProjectID = GetObjectReference('frmPM_TaskUpdation','cboProject').value;
			objTaskType = GetObjectReference('frmPM_TaskUpdation','optTaskType',true);
			for(intCnt=0; intCnt < objTaskType.length; intCnt++)
			{
				if(objTaskType[intCnt].checked)
					strTaskType = objTaskType[intCnt].value;
			}
			//intigrated by harshk for issueid 190
			//  Purpose-To pass EmployeeID into Querystring 
			var intEmployeeID ;
			intEmployeeID = GetObjectReference('frmPM_TaskUpdation','cboEmployee').value;
			
			if (IsValidInput() == true)
			{
			objform.action = "PM_TaskUpdation.aspx?FromWhere=PM&MasterTagId=<%=m_lngTagId%>&Mode=List&Weekly=True&ProjectID=" + intProjectID + "&EmployeeID=" + intEmployeeID + "&TaskType=" + strTaskType + "&FromDate=<%=Date.Parse(DateAdd("d",-6,m_dtFromDate))%>&ToDate=<%=Date.Parse(DateAdd("d",-6,m_dtToDate))%>";
			objform.submit();
			}			
			//End intigrated by harshk for issueid 190
		}
		
		function NextWeek_OnClick()
		{
			var intProjectID, strTaskType, objTaskType, intCnt;
			//Integrated in Whiz2 by MrugajaB on 15th Dec 2005
			//Added by SandeepA on 18 Nov,2005 for IssueID-684
			var objTaskFilter=GetObjectReference('frmPM_TaskUpdation','optMainTaskFilter',true);
			//Replace the character '&#39' with the single quotes " ' "
			var msg=replaceSubstring("<%=Mybase.GetResourceString("NEXT_WEEK_ALERT")%>","&#39;","'");
			 if((objTaskFilter[1].checked)==false)
			 {
				alert(msg);
				return ;			 
			 }
			//End of addition by SandeepA on 18 Nov,2005 for IssueID-684
			//End Integration
			
			intProjectID = GetObjectReference('frmPM_TaskUpdation','cboProject').value;

			objTaskType = GetObjectReference('frmPM_TaskUpdation','optTaskType',true);
			for(intCnt=0; intCnt < objTaskType.length; intCnt++)
			{
				if(objTaskType[intCnt].checked)
					strTaskType = objTaskType[intCnt].value;
			}
			//intigrated by harshk for issueid 190
			//  Purpose-To pass EmployeeID into Querystring 
			var intEmployeeID;
			intEmployeeID = GetObjectReference('frmPM_TaskUpdation','cboEmployee').value;
			if (IsValidInput() == true)
			{
			objform.action = "PM_TaskUpdation.aspx?FromWhere=PM&MasterTagId=<%=m_lngTagId%>&Mode=List&Weekly=True&ProjectID=" + intProjectID + "&EmployeeID=" + intEmployeeID + "&TaskType=" + strTaskType + "&FromDate=<%=Date.Parse(DateAdd("d",7,m_dtFromDate))%>&ToDate=<%=Date.Parse(DateAdd("d",6,m_dtToDate))%>";
			objform.submit();
			}
			//End intigrated by harshk for issueid 190
		}

		function Save_OnClick()
		{
			var objFromDate, objToDate, intProjectID, strTaskType, objTaskIDs, objTaskType,intEmployeeID;
			var strCheckboxIDs,objCheckbox,intItems,intCtr,blnSelected; 
						
			//Intigrated by harshk for sp4 issueid 190
			if('<%=m_CheckboxIDs%>' != "")   
			{		  
			    // Purpose - To search that any task is checked 					 
				strCheckboxIDs = '<%=m_CheckboxIDs%>'.split(",");
				intItems = strCheckboxIDs.length;
				blnSelected = false;
			   	for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{		          
					objCheckbox = GetObjectReference(objform,strCheckboxIDs[intCtr]);
					if(objCheckbox.disabled == false)
					{
						if(objCheckbox.checked == true)
						{
						blnSelected = true;
						break;
						}
					}	
				}
				
				if(blnSelected == false)
				{
					alert("Select at least one Task.");
					return;
				}	
									
				objFromDate = GetObjectReference('frmPM_TaskUpdation','txtFromDate').value;
				objToDate = GetObjectReference('frmPM_TaskUpdation','txtToDate').value;
				intProjectID = GetObjectReference('frmPM_TaskUpdation','cboProject').value;
				intEmployeeID = GetObjectReference('frmPM_TaskUpdation','cboEmployee').value;
										
				objTaskType = GetObjectReference('frmPM_TaskUpdation','optTaskType',true);
				for(intCnt=0; intCnt < objTaskType.length; intCnt++)
				{
					if(objTaskType[intCnt].checked)
						strTaskType = objTaskType[intCnt].value;
				}
				if (IsValidInput() == true)
				{
				
				//Addition and comment By PrashantD on 14 Sept 2005
				//Purpose: variable strTaskIDs in queryString may be too longer
				// than capacity of objform.action. That time error occurs 'Invalid pointer '
				
				//objform.action = "PM_TaskUpdation.aspx?FromWhere=PM&MasterTagId=<%=m_lngTagId%>&Mode=Save&ProjectID=" + intProjectID + "&TaskType=" + strTaskType + "&FromDate=" + objFromDate + "&ToDate=" + objToDate + "&TaskIDs=" + strTaskIDs +"&EmployeeID=" +  intEmployeeID
					var arrCount=Math.ceil(strTaskIDs.length/4000);
					var arr_strTaskIDs=new Array(arrCount);
					var TaskIDBreaks=strTaskIDs.length/4000;	
					var count=0;
					//Added by ManishK on 16th Feb 2006 For WhizibleSem SP6 IssueID 2176
					var strTaskID;
					var arr_TaskList=strTaskIDs;
					arr_TaskList=arr_TaskList.split(",");
					strTaskID=arr_TaskList[0];
			//End of Added by ManishK on 16th Feb 2006 For WhizibleSem SP6 IssueID 2176
					while(count<TaskIDBreaks)
					{
				
						arr_strTaskIDs[count]=strTaskIDs.substring(0,4000);		
						strTaskIDs=strTaskIDs.substring(4000,strTaskIDs.length);
						var selectedTasks_hiddenCont=document.createElement("input");
						selectedTasks_hiddenCont.id="strTaskIDs"+count;
						selectedTasks_hiddenCont.name="strTaskIDs"+count;
						selectedTasks_hiddenCont.type="hidden";
						selectedTasks_hiddenCont.value=arr_strTaskIDs[count]
						document.forms[0].appendChild(selectedTasks_hiddenCont);    // Modified by puneet m on 23-12-2015
						count++;

					}
					//Modification by ManishK on 16th Feb 2006 For WhizibleSem SP6 IssueID 2176					
					//objform.action = "PM_TaskUpdation.aspx?FromWhere=PM&MasterTagId=<%=m_lngTagId%>&Mode=Save&ProjectID=" + intProjectID + "&TaskType=" + strTaskType + "&FromDate=" + objFromDate + "&ToDate=" + objToDate + "&EmployeeID=" +  intEmployeeID
					objform.action = "PM_TaskUpdation.aspx?TaskID="+ strTaskID +"&FromWhere=PM&MasterTagId=<%=m_lngTagId%>&Mode=Save&ProjectID=" + intProjectID + "&TaskType=" + strTaskType + "&FromDate=" + objFromDate + "&ToDate=" + objToDate + "&EmployeeID=" +  intEmployeeID
					//End of Modification by ManishK on 16th Feb 2006 For WhizibleSem SP6 IssueID 2176					
					//End of Addition and comment By PrashantD on 14 Sept 2005
					
					objform.submit()
				}
	    	}
	    	else
	    	{
	    	   return;
	    	}		
		}	
		
		function CheckChildTasks(intTaskID,intChildCount)
		{
			
			var strCheckBox, objCheckbox, intIndex, blnChecked, objTaskType, strTaskType, i;
			var strTextBox, objTextBox;
			
			objTaskType = GetObjectReference('frmPM_TaskUpdation','optTaskType',true);
			for(intCnt=0; intCnt < objTaskType.length; intCnt++)
			{
				if(objTaskType[intCnt].checked)
					strTaskType = objTaskType[intCnt].value;
			}
			
			strCheckBox = 'chk' + intTaskID + '_0';
			objCheckbox = GetObjectReference('frmPM_TaskUpdation',strCheckBox);
			
			if (strTaskType == 'O' || strTaskType == 'R')
			{
				if (objCheckbox.checked == true)
				{
					blnChecked = true;
					if (strTaskIDs.indexOf(intTaskID + ',') == -1)
					{
						strTaskIDs = strTaskIDs + intTaskID + ',';
					}
				}
				else
				{
					blnChecked = false;
					if (strTaskIDs.indexOf(intTaskID + ',') != -1)
					{
						strTaskIDs = strTaskIDs.replace(intTaskID + ',','');
					}
				}
			
				for (i = 1; i <= intChildCount; i++)
				{
	
					strCheckBox = 'chk' + intTaskID + '_' + i;
					objCheckbox = GetObjectReference('frmPM_TaskUpdation',strCheckBox);
					
					strTextBox = 'txt' + intTaskID + '_' + i;
					objTextbox = GetObjectReference('frmPM_TaskUpdation',strTextBox);
				
					if (blnChecked == true) 
					{
						objCheckbox.checked=true;
						objCheckbox.disabled=true;
						if (strTaskIDs.indexOf(objCheckbox.value + ',')== -1)
						{
							strTaskIDs = strTaskIDs + objCheckbox.value + ',';
						}

					}
					else
					{
			
						if (strTaskIDs.indexOf(objCheckbox.value + ',') != -1)
						{
							strTaskIDs = strTaskIDs.replace(objCheckbox.value + ',','');
						}
						if (objTextbox.value == 'False')
						{
							objCheckbox.checked=false;
							objCheckbox.disabled=false;
						}
					}
					
				}			
			}
			
			if (strTaskType == 'M' || strTaskType == 'B')
			{
				if (objCheckbox.checked == true)
				{
					blnChecked = true;
					if (strTaskIDs.indexOf(intTaskID + ',') == -1)
					{
						strTaskIDs = strTaskIDs + intTaskID + ',';
					}
				}
				else
				{
					blnChecked = true;
					if (strTaskIDs.indexOf(intTaskID + ',') > -1)
					{
						strTaskIDs = strTaskIDs.replace(intTaskID + ',','');
					}
				}
			}
		}
		
		function CheckTask(intTaskID,intCount)
		{
			var strCheckBox, objCheckbox, intIndex, blnChecked;
			
			strCheckBox = "chk" + intTaskID + "_"  + intCount;
			objCheckbox = GetObjectReference('frmPM_TaskUpdation',strCheckBox);
			if (objCheckbox.checked == true)
			{
				blnChecked = true;
				if (strTaskIDs.indexOf(objCheckbox.value + ',') == -1)
				{
					strTaskIDs = strTaskIDs + objCheckbox.value + ',';
				}
			}
			else
			{
				blnChecked = false;
				if (strTaskIDs.indexOf(objCheckbox.value + ',') > -1)
				{
					strTaskIDs = strTaskIDs.replace(objCheckbox.value + ',','');
				}
			}
		}
		//intigrated by harshk for sp4 issueid 190	
	 function SelectAll_OnClick()
		{		  	  	
		  var strCheckboxIDs,objCheckbox,intItems,intCtr;
		 		  		  	   		  
			if('<%=m_CheckboxIDs%>' != "")
			{		  
			 strCheckboxIDs = '<%=m_CheckboxIDs%>'.split(",");
			 intItems = strCheckboxIDs.length;
			  
		    		if(intItems > 1) 
					{
						for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
						{		          
							objCheckbox = GetObjectReference(objform,strCheckboxIDs[intCtr]);
							if (objCheckbox.disabled == false)
							{
							  objCheckbox.checked = true;	
							  if (strTaskIDs.indexOf(objCheckbox.value + ',') == -1)
							  {
								strTaskIDs = strTaskIDs + objCheckbox.value + ',';
							  }
							} 	        		
						}
						
					}
					// Else, if single element exists, then...
					else if(intItems == 1)
							{
								objCheckbox = GetObjectReference(objform,strCheckboxIDs[0]);
								if (objCheckbox.disabled == false)
							    {
									objCheckbox.checked = true;		        		
									if (strTaskIDs.indexOf(objCheckbox.value + ',') == -1)
									{
										strTaskIDs = strTaskIDs + objCheckbox.value + ',';
									}	
								}	
							}					
			}
	     } 
		function ClearAll_OnClick()
		{		  	  	
   		  var strCheckboxIDs,objCheckbox,intItems,intCtr; 
		 		  
			if('<%=m_CheckboxIDs%>' != "")
			{		  
				strCheckboxIDs = '<%=m_CheckboxIDs%>'.split(",");		  
				intItems = strCheckboxIDs.length;
		  
				if(intItems > 1) 
					{
						for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
						{		          
							objCheckbox = GetObjectReference(objform,strCheckboxIDs[intCtr]);
							if (objCheckbox.disabled == false)
							{
								objCheckbox.checked = false;		        		
								if (strTaskIDs.indexOf(objCheckbox.value + ',') > -1)
								{
									strTaskIDs = strTaskIDs.replace(objCheckbox.value + ',','');
								}
							}	
						}
					}
					// Else, if single element exists, then...
					else if(intItems == 1)
							{
								objCheckbox = GetObjectReference(objform,strCheckboxIDs[0]);
								if (objCheckbox.disabled == false)
								{
									objCheckbox.checked = false;		        		
									if (strTaskIDs.indexOf(objCheckbox.value + ',') > -1)
									{
										strTaskIDs = strTaskIDs.replace(objCheckbox.value + ',','');
									}
								}	
							}					
			}		
	    } 
	     
		//End intigrated by harshk for sp4 issueid 190
		
		//Integrated in Whiz2 by MrugajaB on 15th Dec 2005
		//Added by SandeepA on 17 Nov,2005 for IssueID-684 (Task Filters)
		//Purpose : function for 'ShowAll Tasks' and 'Show Tasks For Period' option buttons 
		function optTasks_OnClick(Show)
		{
			var strFromDateVal, strToDateVal, objFromDate, objToDate;
		//GetObject Reference for Date Controls
		  var txtToDate=GetObjectReference('frmPM_TaskUpdation','txtToDate');
		  var txtFromDate=GetObjectReference('frmPM_TaskUpdation','txtFromDate');
		  
		   //Get ObjectReference for SPAN tag
		  var objSpanFromDt=GetObjectReference('frmPM_TaskUpdation','FromDate');
		  var objSpanToDt=GetObjectReference('frmPM_TaskUpdation','ToDate');
		  
		  //Added by ManishK on 16th Feb 2006 For WhizibleSem Sp6 IssueID 2172	  
		 	
		   
		  //dtStartDate=txtFromDate.value;
   		  //dtEndDate=txtToDate.value;
		 //End OF Added by ManishK on 16th Feb 2006 For WhizibleSem Sp6 IssueID 2172 	  
		
		  
		  //Added by ShubhadaL on 1 Feb 2006
		  //Purpose : To show date controls if Show All Tasks is clicked.
		   var objFromDateDisable = GetObjectReference('frmPM_TaskUpdation','FFE29587WHIZ_txtFromDate');
		   var objToDateDisable = GetObjectReference('frmPM_TaskUpdation','FFE29587WHIZ_txtToDate');
		   	
			objFromDate = GetObjectReference('frmPM_TaskUpdation','txtFromDate').value;
			objToDate = GetObjectReference('frmPM_TaskUpdation','txtToDate').value;
			
			//Modified by MrugajaB on 4th July 2006 for WhizibleSEM SP7 Issue ID.4168
			if(navigator.appName != 'Netscape')
   		   {
				if (objFromDateDisable.value != '')
				{
					dtStartDate=objFromDateDisable.value;
				}
		   
				if (objToDateDisable.value != '')
				{
   					dtEndDate=objToDateDisable.value;
   				}
			}
		   else
		   {
   				dtStartDate=txtFromDate.value;
   				dtEndDate=txtToDate.value;
   		   }
			//End Modification
		  //End addition by ShubhadaL on 1 Feb 2006
		  //Added by ShubhadaL on 7 Feb 2006 to Hide * mark if ShowAll is clicked else show it.
		  	objStarID = GetObjectReference('frmPM_TaskUpdation','StarID');
			objStarIDTo = GetObjectReference('frmPM_TaskUpdation','StarIDTo');
			//End addition by ShubhadaL on 7 Feb 2006
		  //If 'Show All Tasks' is clicked then hide the Date controls
		 //debugger;
			
		  if(Show=="ShowALL")
		  {
			
			 //Commented by ShubhadaL on 1 Feb 2006
		     //Purpose : To show date controls if Show All Tasks is clicked.
   		     //objSpanFromDt.style.visibility="hidden";
   		     //objSpanToDt.style.visibility="hidden";
   		     
   		     //Added by ManishK on 16th Feb 2006 for WhizibleSem sp6 issues 2172
   		      // dtStartDate=objFromDateDisable.value;
   		     //dtEndDate=objToDateDisable.value;
   		     
   		   //Modified by MrugajaB on 4th July 2006 for WhizibleSEM SP7 Issue ID.4168  				
		   if(navigator.appName != 'Netscape')
   		   {
   		     objFromDateDisable.value="";
   		     objToDateDisable.value="";
   		   }
   		   //End Modification
   		    		    
   		    //End Of Added by ManishK on 16th Feb 2006 for WhizibleSem sp6 issues 2172
   		     
   		  //Added by ShubhadaL on 7 Feb 2006 to Hide * mark if ShowAll is clicked else show it.
   		  objStarID.style.display='none';
   		  objStarIDTo.style.display='none';
   		  //End addition by ShubhadaL on 7 Feb 2006
   		  //Added by ShubhadaL on 1 Feb 2006
   		  //Purpose : To disable date controls if Show All Tasks is clicked.
   		  
   		    txtToDate.disabled = true;
   		    txtFromDate.disabled = true;
   		    
   		   //Modified by MrugajaB on 4th July 2006 for WhizibleSEM SP7 Issue ID.4168
   		   if(navigator.appName != 'Netscape')
   		   {
   				objFromDateDisable.disabled = true;
   				objToDateDisable.disabled = true;
   		   }
   		   //End Modification
   		   
   		    //objToDateDisable.value = "";
   		    objSpanFromDt.style.visibility="visible";
   		    objSpanToDt.style.visibility="visible";
   		    
   		     //End addition by ShubhadaL on 1 Feb 2006
		  }
		  //If 'Show Task For Period' is clicked then show the Date Controls
		  if(Show=="ShowWeekly")
		  {
		   
		   //Added by ManishK on 16th Feb 2006 For WhizibleSem Sp6 IssueID 2172
		   //txtFromDate.value=dtStartDate;
		   //txtToDate.value=dtEndDate;
		   
		   //Modified by MrugajaB on 4th July 2006 for WhizibleSEM SP7 Issue ID.4168
		   if(navigator.appName != 'Netscape')
   		   {
				objFromDateDisable.value=dtStartDate;
		  		objToDateDisable.value=dtEndDate;
			}	
		  //End of Added by ManishK on 16th Feb 2006 For WhizibleSem Sp6 IssueID 2172 
		  
		  //Added by ShubhadaL on 7 Feb 2006 to Hide * mark if ShowAll is clicked else show it.
		  objStarID.style.display='';
		  objStarIDTo.style.display='';
		  //End addition by ShubhadaL on 7 Feb 2006 
		    objSpanFromDt.style.visibility="visible";
		    objSpanToDt.style.visibility="visible";
		     //Added by ShubhadaL on 1 Feb 2006
   		     //Purpose : To disable date controls if Show All Tasks is clicked.
		    txtToDate.disabled = false;
   		    txtFromDate.disabled = false ;
   		     
   		    //Modified by MrugajaB on 4th July 2006 for WhizibleSEM SP7 Issue ID.4168
   		   if(navigator.appName != 'Netscape')
   		   {
   		    objFromDateDisable.disabled = false;
   		    objToDateDisable.disabled = false;
   		   }
   		   //End Modification
   		  
		  }
		}
		//End of Addition by SandeepA on 17 Nov,2005 for IssueID-684
		//End Integration
		
		</SCRIPT>
	</body>
</HTML>
