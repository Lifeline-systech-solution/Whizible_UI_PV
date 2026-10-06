<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_TaskStatusManagement.aspx.vb" Inherits="PbNIT.PM_TaskStatusManagement"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("PM_TaskStatusManagement")%>
	<HEAD>
		
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
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
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmPM_TaskStatusManagement" method="post" runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmPM_TaskStatusManagement');
		var objdivlist=GetObjectReference('frmPM_TaskStatusManagement','PageDiv');
		var objdivlist1=GetObjectReference('frmPM_TaskUpdation','DivList');
		//var objDivShow = GetObjectReference('frmPM_TaskStatusManagement','Show');
		var strTaskIDs=',';
		 var dtStartDate, dtEndDate; 
		
		// Added by ShubhadaL on 2 Feb,2006 
		//Purpose: Function to show/hide the div section of the Filters.
		//var Flag=true;
		var Flag=<%=m_FilterDivStatus.toString.toLower%>;
		var objFilterDivStatus= GetObjectReference('frmPM_TaskUpdation','hidFilterDivStatus');
		//var FlagForRetainingValue;
		var objDIV= GetObjectReference('frmPM_TaskStatusManagement','Show');
		var objimg= GetObjectReference('frmPM_TaskStatusManagement','imgShowHide');
		
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>

			 
			 
		<%'Modified By NitinVs on 22 Mar 2007 for PMLifeLine SP 8 Regression Isseue %>	
		function showHide_div()
		{
		   var intDivHeight;
			if(navigator.appName == 'Netscape')
		    {
		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 260 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 260;
		    }
		   
		   if (Flag==true)
		   {
				objDIV.style.display='none';
				objimg.src='../../Images/plus.gif';
				Flag=false;
				objFilterDivStatus.value = "Close";
				if(objdivlist1 != null)
				{
					objdivlist1.style.height = intDivHeight + 145;
				}
				return;
			}
			if(Flag==false)
			{
			   objDIV.style.display='';
			   objimg.src='../../Images/minus.gif';
				Flag=true;
				objFilterDivStatus.value = "Open";
				if(objdivlist1 != null)
				{
					objdivlist1.style.height = intDivHeight;
				}
				
				return;
			}
		}
		//End of addition by Shubhadal on 2 Feb,2006
		
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
		   
		var intDivHeight ;
		var intDivListPageHeight ;
		var intDivHeightRisk;
		var lc;
		
		//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
		//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168
		
		    
		    // Commented  by Viraj P on 17 Nov 2015
		//if(navigator.appName == 'Netscape')
		//    {
		  
		//		intDivHeight =window.innerHeight  - objdivlist.offsetTop - 65 ;
		//    }
		//    else
		//    {
		//		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		//    }
		//if (intDivHeight < 100)
		//	intDivHeight = 100;
		//objdivlist.style.height = intDivHeight;}
		//if (objdivlist1 != null) {
		//intDivListPageHeight = intDivHeight;
		    //objdivlist1.style.height = intDivListPageHeight-200;}
            //Commented and Added By Bharat T on 30th-Nov-2015
            //commented added by Shamkant S on 18 Nov 2015
		    if (objdivlist !=null) {
	       
	      
		        if(WhichBrowser() == 'IE')
		        { 
		            //Commented and Added By Bharat T on 30th-Nov-2015
		            //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 245 ;
		            intDivHeight = window.innerHeight - objdivlist.offsetTop - 37 ;
		            //End of Commented and Added By Bharat T on 30th-Nov-2015
		           
		        }
		        else if(WhichBrowser() == 'CR')
		        {
		            //Commented and Added By Bharat T on 30th-Nov-2015
		            //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 240;
		            intDivHeight = window.innerHeight  - objdivlist.offsetTop - 37;
		            //End of Commented and Added By Bharat T on 30th-Nov-2015
		           
		        }
		        else if(WhichBrowser() == 'FF')
		        {
		            //Commented and Added By Bharat T on 30th-Nov-2015
		            //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 235 ;
		            intDivHeight = window.innerHeight  - objdivlist.offsetTop - 37 ;
		            //End of Commented and Added By Bharat T on 30th-Nov-2015
		                
		        }
		        else
		        {
		            intDivHeight =  window.innerHeight  - objdivlist.offsetTop - 24 ;
		        }
		        if (intDivHeight < 100)	intDivHeight = 100;
		        objdivlist.style.height = intDivHeight + 'px';	}


		//Added by ShubhadaL on 1 Feb 2006 
			//Purpose : to disable date controls if Show All Tasks is clicked.
			
			var objoptAllTasks= GetObjectReference('frmPM_TaskUpdation','optAllTasks');
			 
			 if (objoptAllTasks.checked == true)
			  optTasks_OnClick('ShowALL');
			 else
			 optTasks_OnClick('ShowWeekly');
			//End addition by ShubhadaL on 1 Feb 2006
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
		//End of Comment  by Viraj P on 17 Nov 2015
		function window_onresize()		
		{
		var intDivHeight ;
		var intDivHeightRisk;
		var intDivListPageHeight ;
		//if (objdivlist != null) {
		////intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
		////'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

		//if(navigator.appName == 'Netscape')
		//    {
		  
		//		intDivHeight =window.innerHeight  - objdivlist.offsetTop - 65 ;
		//    }
		//    else
		//    {
		//		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 65;
		//    }
		//if (intDivHeight < 100)
		//	intDivHeight = 100;
				
		    //objdivlist.style.height = intDivHeight	;}
		if (objdivlist !=null) {
	       
	      
		    if(WhichBrowser() == 'IE')
		    { 
		        //Commented and Added By Bharat T on 30th-Nov-2015		        
		        intDivHeight = window.innerHeight - objdivlist.offsetTop - 37 ;
		        //End of Commented and Added By Bharat T on 30th-Nov-2015
		    }
		    else if(WhichBrowser() == 'CR')
		    {
		        //Commented and Added By Bharat T on 30th-Nov-2015		       
		        intDivHeight = window.innerHeight  - objdivlist.offsetTop - 37;
		        //End of Commented and Added By Bharat T on 30th-Nov-2015		           
		    }
		    else if(WhichBrowser() == 'FF')
		    {
		        //Commented and Added By Bharat T on 30th-Nov-2015		       
		        intDivHeight = window.innerHeight  - objdivlist.offsetTop - 37 ;
		        //End of Commented and Added By Bharat T on 30th-Nov-2015		                
		    }
		    else
		    {
		        intDivHeight =  window.innerHeight  - objdivlist.offsetTop - 24 ;
		    }
		    if (intDivHeight < 100)	intDivHeight = 100;
		    objdivlist.style.height = intDivHeight + 'px';	}
		if (objdivlist1 != null) {
		intDivListPageHeight = intDivHeight - 200 ;
		objdivlist1.style.height = intDivListPageHeight;}
		}
		
		function Show_OnClick()
		{
			var objFromDate, objToDate, intProjectID, strTaskType, objTaskType, intCnt,intOperation, intEmployeeID;;
			
			objFromDate = GetObjectReference('frmPM_TaskStatusManagement','txtFromDate').value;
			objToDate = GetObjectReference('frmPM_TaskStatusManagement','txtToDate').value;
			intProjectID = GetObjectReference('frmPM_TaskStatusManagement','cboProject').value;
			intOperation = GetObjectReference('frmPM_TaskStatusManagement','cboOperation').value;
			objTaskType = GetObjectReference('frmPM_TaskStatusManagement','optTaskType',true);
			var objAllTasks;
			objAllTasks = GetObjectReference('frmPM_TaskStatusManagement','optAllTasks');
		
				
			for(intCnt=0; intCnt < objTaskType.length; intCnt++)
			{
				if(objTaskType[intCnt].checked)
					strTaskType = objTaskType[intCnt].value;
			}
			//Intigrated by harshk for sp4 issueid 190
			intEmployeeID = GetObjectReference('frmPM_TaskStatusManagement','cboEmployee').value;
			
			if (IsValidInput() == true)
			{

			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016                
				objform.action = "PM_TaskStatusManagement.aspx?FromWhere=PM&MasterTagId=<%=m_lngTagId%>&ProjectID=" + intProjectID + "&TaskType=" + strTaskType + "&Operation=" + intOperation + "&EmployeeID=" + intEmployeeID + "&Mode=List&FromDate=" + objFromDate + "&ToDate=" + objToDate;
				objform.submit();
			}
			//end Intigrated by harshk for sp4 issueid 190
		}
		
		function IsValidInput()
		{
			//debugger;
			//Integrated by MrugajaB for PMLifeLine SP7 Issue ID.4192
			// Modified by SandipL on 16 May 2006 For WhizEnggSP6 IssueID 3748
			// Whiz Date Control will be plot conditionally 
		
			//var objFromDate, objToDate, objOperation, objTaskType;
			var objFromDate, objToDate, objOperation, objTaskType, objPrevFromDate,objPrevToDate;
			
			var isDateEditable = '<%=CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled")%>';
			
			objPrevFromDate = GetObjectReference('frmPM_TaskStatusManagement','txtFromDate');
			objPrevToDate = GetObjectReference('frmPM_TaskStatusManagement','txtToDate');
			
			//objFromDate = GetObjectReference('frmPM_TaskStatusManagement','txtFromDate');
			//objToDate = GetObjectReference('frmPM_TaskStatusManagement','txtToDate');

			
			var objAllTasks;
			objAllTasks = GetObjectReference('frmPM_TaskStatusManagement','optAllTasks');
					
			//Added By MrugajaB on 24th May 2005 for PMLifeLine Issue ID.18507
		//Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
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
			//End Addition
			
			objOperation = GetObjectReference('frmPM_TaskStatusManagement','cboOperation');
			//Added By MrugajaB on 24th May 2005 for PMLifeLine Issue ID.18507
			objTaskType = GetObjectReference('frmPM_TaskStatusManagement','optTaskType',true);
			
			for(intCnt=0; intCnt < objTaskType.length; intCnt++)
			{
				if(objTaskType[intCnt].checked)
					strTaskType = objTaskType[intCnt].value;
			}
			
			if((strTaskType=='M' ) && (objOperation.value==1))
			{
			alert("MPP Tasks cannot be marked as 'Void (Inactive)'")
				return false;
			}	
			
//integrated by harshada d for PMLifeLine sp 7.2 issue ID 4518
	// Added By ParagD On 9-Aug-2006
			// Purpose : Nucleus 23153 - 
			// MPP task are not getting completed even if marking task complete from task 
			// completion option
			// Solution :	Sine we cannot 'Re-open' tasks in MPP after daemon runs ,we have restricted User 
			//				here by disallowing him to 'Re-open' MPP Tasks in PMLifeLine Only.			
			if((strTaskType=='M' ) && (objOperation.value==7))
			{
			alert("MPP Tasks cannot be marked as 'Re-opened' from PMLifeLine ,please go to MSP to 'Re-open' MPP Tasks")
			return false;
			}
			// End : Added By ParagD On 9-Aug-2006
			
		//end of integration by harshada d
			if((strTaskType=='M' ) && (objOperation.value==2))
			{
			alert("MPP Tasks cannot be marked as 'Valid (Active)'")
				return false;
			}	
			//End Addition
			//Mpp Task baseline [Code added by KapilK on 08-09-08 ]
			if((strTaskType=='M' ) && (objOperation.value==11))
			{
				alert("You cannot set baseline for MPP Tasks.")
				return false;
			}
			if((strTaskType=='M' ) && (objOperation.value==12))
			{
				alert("You cannot clear baseline for MPP Tasks.")
				return false;
			}
			if(((strTaskType=='B') || (strTaskType=='H') || (strTaskType=='R') ) && (objOperation.value==13))
			{
				alert("You can save Actual Percent Complete for MPP and Assign Tasks only.");
				return false;
			}
			//End;Mpp Task baseline [Code added by KapilK on 08-09-08 ]

		
			//Added by ManishK on 23th Feb 06 For IssueID 2445
			if (objAllTasks.checked==false)
			{
			//End of Added by ManishK on 23th Feb 06 For IssueID 2445
			
			//Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
		  
				if(navigator.appName == 'Netscape')
   				{
					if(objPrevFromDate.value=='' )
					{
					alert("From Date Should not be Blank")
						return false;
					}	
				}
				else
				{
					if(objFromDate.value=='' )
					{
					alert("From Date Should not be Blank")
					objFromDate.focus();
						return false;
					}	
				}
			}
			
			//Added by ManishK on 23th Feb 06 For IssueID 2445
			if (objAllTasks.checked==false)
			{
			//End of Added by ManishK on 23th Feb 06 For IssueID 2445
			
			//Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
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
			//Added By MrugajaB on 24th May 2005 for PMLifeLine Issue ID.18507
			if(objOperation.value=='')
			{
				var objOperation = GetObjectReference('frmPM_TaskStatusManagement','cboOperation');
				objOperation.focus()
				alert("'Action' should not be blank")
				return false;
			}
			//End Addition
			//Integrated by MrugajaB for PMLifeLine SP7 Issue ID.4192
			//Modified by SandipL on 16 May 2006 For WhizEnggSP6 IssueID 3748
			//if(disallowDate1GreaterThanDate2(objFromDate, objToDate, "<%=MyBase.GetResourceString("FROMDATE_LESSTHAN_TODATE")%>", true))
			
			//if(disallowDate1GreaterThanDate2(objPrevFromDate, objPrevToDate, "<%=MyBase.GetResourceString("FROMDATE_LESSTHAN_TODATE")%>", true))
			//	return false;
			//Added by JyotiG
			//Start_JG_11499_15-Mar-2007
			//added by ArchanaN on 9 Feb 2007 for Hexaware SP8 Upgrade Issue ID 11275
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
			
				//End by ArchanaN on 9 Feb 2007
				//End Modification by SandipL  on 16 May 2006
				//End Integration
				//End Modification by SandipL  on 16 May 2006
				//End Integration
				//End_JG_11499_15-Mar-2007

			if (<%=m_intMSPIntegrationMethod%> == 2)
			{
				if (!ValidateMppTask())
				{
				return false;
				}
            }
           
		return true;
	}



				function PreviousWeek_OnClick()
				{

				var intProjectID, strTaskType, intCnt, objTaskType,intOperation, intEmployeeID;
				//Integrated in Whiz2 by MrugajaB on 15th Dec 2005
				//Added by SandeepA on 18 Nov,2005 for IssueID-684
				var objTaskFilter=GetObjectReference('frmPM_TaskStatusManagement','optMainTaskFilter',true);
				//Replace the character '&#39' with the single quotes " ' "
			var msg=replaceSubstring("<%=Mybase.GetResourceString("PERVIOUS_WEEK_ALERT")%>","&#39;","'");
			 
			 var objFromDate = GetObjectReference('frmPM_TaskStatusManagement','txtFromDate')
			 var objToDate = GetObjectReference('frmPM_TaskStatusManagement','txtToDate')

			 //Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
			 if(navigator.appName != 'Netscape')
   			 {
				objFromDate.style.display='none';
				objToDate.style.display='none';
			}
			 
		
			 if((objTaskFilter[1].checked)==false)
			 {
			 	alert(msg);
				return ;			 
			 }
			//End of addition by SandeepA on 18 Nov,2005 for IssueID-684
			//End Addition
			
			intProjectID = GetObjectReference('frmPM_TaskStatusManagement','cboProject').value;
			intOperation = GetObjectReference('frmPM_TaskStatusManagement','cboOperation').value;
			objTaskType = GetObjectReference('frmPM_TaskStatusManagement','optTaskType',true);
			
			for(intCnt=0; intCnt < objTaskType.length; intCnt++)
			{
				if(objTaskType[intCnt].checked)
					strTaskType = objTaskType[intCnt].value;
			}
			// Intigrated by harshk for sp4 issueid 190: Purpose-To pass EmployeeID into Querystring 
			intEmployeeID = GetObjectReference('frmPM_TaskStatusManagement','cboEmployee').value;
			if (IsValidInput() == true)
			{//debugger;
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016                
			objform.action = "PM_TaskStatusManagement.aspx?FromWhere=PM&MasterTagId=<%=m_lngTagId%>&Mode=List&Weekly=True&ProjectID=" + intProjectID + "&EmployeeID=" + intEmployeeID  + "&TaskType=" + strTaskType + "&FromDate=<%=Date.Parse(DateAdd("d",-6,m_dtFromDate))%>&ToDate=<%=Date.Parse(DateAdd("d",-6,m_dtToDate))%>" + "&Operation=" + intOperation ;
			objform.submit();
			}			
			//End Intigrated by harshk for sp4 issueid 190: Purpose-To pass EmployeeID into Querystring 
		}
		
		function NextWeek_OnClick()
		{
			var intProjectID, strTaskType, objTaskType, intCnt,intOperation, intEmployeeID;
			//Integrated in Whiz2 by MrugajaB on 15th Dec 2005
			//Added by SandeepA on 18 Nov,2005 for IssueID-684
			var objTaskFilter=GetObjectReference('frmPM_TaskStatusManagement','optMainTaskFilter',true);
			//Replace the character '&#39' with the single quotes " ' "
			var msg=replaceSubstring("<%=Mybase.GetResourceString("NEXT_WEEK_ALERT")%>","&#39;","'");
			 if((objTaskFilter[1].checked)==false)
			 {
				alert(msg);
				return ;			 
			 }
			//End of addition by SandeepA on 18 Nov,2005 for IssueID-684
			//End Addition
			
			intProjectID = GetObjectReference('frmPM_TaskStatusManagement','cboProject').value;
			intOperation = GetObjectReference('frmPM_TaskStatusManagement','cboOperation').value;
			objTaskType = GetObjectReference('frmPM_TaskStatusManagement','optTaskType',true);
			for(intCnt=0; intCnt < objTaskType.length; intCnt++)
			{
				if(objTaskType[intCnt].checked)
					strTaskType = objTaskType[intCnt].value;
			}
			// Intigrated by harshk for sp4 issueid 190: Purpose-To pass EmployeeID into Querystring 
			intEmployeeID = GetObjectReference('frmPM_TaskStatusManagement','cboEmployee').value;
			
			if (IsValidInput() == true)
			{
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016                
			objform.action = "PM_TaskStatusManagement.aspx?FromWhere=PM&MasterTagId=<%=m_lngTagId%>&Mode=List&Weekly=True&ProjectID=" + intProjectID + "&EmployeeID=" + intEmployeeID + "&TaskType=" + strTaskType + "&FromDate=<%=Date.Parse(DateAdd("d",7,m_dtFromDate))%>&ToDate=<%=Date.Parse(DateAdd("d",6,m_dtToDate))%>" + "&Operation=" + intOperation  ;
			objform.submit();
			}
			//End Intigrated by harshk for sp4 issueid 190
		}
		
		    function Save_OnClick()
            
		    {
		       

			var objFromDate, objToDate, intProjectID, strTaskType, objTaskIDs, objTaskType,intOperation, intEmployeeID;
			var strCheckboxIDs,objCheckbox,intItems,intCtr,blnSelected; 
			var objActualPercent;
			
			// Intigrated by harshk for sp4 issueid 190
			if('<%=m_CheckboxIDs%>' != "")   
			{		  
			    // Purpose - To search that any task is checked 					 
				strCheckboxIDs = '<%=m_CheckboxIDs%>'.split(",");
				intItems = strCheckboxIDs.length;
				blnSelected = false;
			   	for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{		          
					objCheckbox = GetObjectReference(objform,strCheckboxIDs[intCtr]);
					//MODIFIED BY VIVEKP ON 28 SEP 2005 FOR ISSUEID-421 
					if (objCheckbox!=null)
					{
						if(objCheckbox.disabled == false)
						{
							if(objCheckbox.checked == true)
							{
							blnSelected = true;
							break;
							}
						}	
					}
					//END OF MODIFICATION BY VIVEKP ON 28 SEP 2005 FOR ISSUEID-421 
				}
				if(blnSelected == false)
				{
					alert("Select at least one Task.");
					return;
				}	
            //added By PurvaJ on 8 OCt 2008
            // validation for special characters.				
		    var arrstrTaskIDs=new Array(Math.ceil(strTaskIDs.length/4000));
			var arrstrTaskIDs=strTaskIDs;
			var blnInvalidData=false;
			arrstrTaskIDs=arrstrTaskIDs.split(",");
			for (intCtr = 0;intCtr <= arrstrTaskIDs.length - 1; intCtr++)
				{		          
					objActualPercent = GetObjectReference(objform,'txtActPer_'+arrstrTaskIDs[intCtr]);
				    if (disallowValueRangeViolation(objActualPercent, 0, 100, "Please enter a numeric value for the &#39;actual % complete&#39; !!\nThe value of &#39;actual % complete&#39; must be in the range [0-100]", true))
				    {
				        blnInvalidData=true;
				        break;
				    }
			            
				}
				
			if(blnInvalidData == true)
				{
					return;
                }
                
			// End addition  By Purvaj
	//Added by TruptiK on 30-Mar-09
			//Purpose:-validation for work hours and task start date and end date.
			var arrstrTaskIDs1=new Array(Math.ceil(strTaskIDs.length/4000));
			var arrstrTaskIDs1=strTaskIDs;
			var ParentTask, ParentTaskTotal; 
			ParentTask = 0; ParentTaskTotal = 0 ; 
			arrstrTaskIDs1=arrstrTaskIDs1.split(",");
			for (intCtr = 0;intCtr <= arrstrTaskIDs.length - 1; intCtr++)
			{
				
				var objTotalWorkhours=GetObjectReference(objform,'hid_txttotalworkhrs _'+arrstrTaskIDs[intCtr]);
				var objchildwork=GetObjectReference(objform,'hid_txtchildworkhrs _'+arrstrTaskIDs[intCtr]);
				var objparenttaskid=GetObjectReference(objform,'hid_txtParenttaskID _'+arrstrTaskIDs[intCtr]);
				var objchildworkhrs=GetObjectReference(objform,'hid_txtchildwork _'+arrstrTaskIDs[intCtr]); 
				
				var objStartDate=GetObjectReference(objform,'hid_txtTaskStartDate_'+arrstrTaskIDs[intCtr]);
				var objEndDate=GetObjectReference(objform,'hid_txtTaskEndDate_'+arrstrTaskIDs[intCtr]);
				var objPStartDate=GetObjectReference(objform,'hid_txtPTaskStartDate_'+arrstrTaskIDs[intCtr]);
				var objPEndDate=GetObjectReference(objform,'hid_txtPTaskEndDate_'+arrstrTaskIDs[intCtr]);
				
				
						
										
				if (objparenttaskid != null)
				{
					if (ParentTask != objparenttaskid.value)
					{
						
						ParentTask = objparenttaskid.value;
						ParentTaskTotal = 0;
					}
					
						if (objchildwork!=null)
							
							
							ParentTaskTotal = parseFloat(ParentTaskTotal) + parseFloat(objchildwork.value);
													
					
					
					if(objTotalWorkhours!=null)
					{
						var ParentTaskTotal1=parseFloat(ParentTaskTotal)+ parseFloat(objchildworkhrs.value);
						
						if(parseFloat(objTotalWorkhours.value) < parseFloat(ParentTaskTotal1))
						{
								blnInvalidData=true;
								alert('You can not mark this task as active, as the child task work hours are exceeding the parent task work hours('+objTotalWorkhours.value+')');
								break;
						}
					
					}
					
						//if (objPStartDate.value!='' && objStartDate.value < objPStartDate.value)
						if (objPStartDate.value!='')
						{
							if (disallowDate1GreaterThanDate2(objPStartDate,objStartDate)) 
							{
							    blnInvalidData=true;
								alert('You can not mark as active this task as start Date of child task is less than ('+objPStartDate.value+')');
								break;
							}
								
						}
						
					    //if (objPEndDate.value!='' && objEndDate.value > objPEndDate.value)
					    if (objPEndDate.value!='')
						{
							if (disallowDate1GreaterThanDate2(objEndDate,objPEndDate)) 
							{
							    blnInvalidData=true;
								alert('You can not mark this task as active as End Date of child task is greater than ('+objPEndDate.value+')');
								break;
							}
							
							
						}
					
				}	
			}
			

			
			if(blnInvalidData == true)
				{
					return;
				}
			//End of Addition by TruptiK on 30-Mar-09
			objFromDate = GetObjectReference('frmPM_TaskStatusManagement','txtFromDate').value;
			objToDate = GetObjectReference('frmPM_TaskStatusManagement','txtToDate').value;
			intProjectID = GetObjectReference('frmPM_TaskStatusManagement','cboProject').value;
			intOperation = GetObjectReference('frmPM_TaskStatusManagement','cboOperation').value;
			intEmployeeID = GetObjectReference('frmPM_TaskStatusManagement','cboEmployee').value;
									
			objTaskType = GetObjectReference('frmPM_TaskStatusManagement','optTaskType',true);
			for(intCnt=0; intCnt < objTaskType.length; intCnt++)
			{
				if(objTaskType[intCnt].checked)
					strTaskType = objTaskType[intCnt].value;
			}
				
			if (IsValidInput() == true)
			{
			
			//Addition and comment By PrashantD on 16 Sept 2005
			//objform.action = "PM_TaskStatusManagement.aspx?FromWhere=PM&MasterTagId=<%=m_lngTagId%>&Mode=Save&ProjectID=" + intProjectID + "&TaskType=" + strTaskType + "&FromDate=" + objFromDate + "&ToDate=" + objToDate + "&TaskIDs=" + strTaskIDs + "&Operation=" + intOperation ;
			
			var arrCount=Math.ceil(strTaskIDs.length/4000);
			
			var arr_strTaskIDs=new Array(arrCount);
			//Added by ManishK on 16th Feb 2006 For PMLifeLine SP6 IssueID 2176
			var strTaskID;
			var arr_TaskList=strTaskIDs;
			arr_TaskList=arr_TaskList.split(",");
			strTaskID=arr_TaskList[0];
			//End of Added by ManishK on 16th Feb 2006 For PMLifeLine SP6 IssueID 2176
			strTaskIDs = strTaskIDs.substring(1,strTaskIDs.length);
			var TaskIDBreaks=strTaskIDs.length/4000;
			var count=0;
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
			//debugger;
			    //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
			var MenuTags = document.getElementsByTagName('A');
			for(i = 0; i < MenuTags.length; i++)
			{
			    if (MenuTags[i].className == "Menu")
			    {
			        //MenuTags[i].style.display= "none";
			        MenuTags[i].parentNode.parentNode.style.display= "none";
			    }
			}
			    //End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 
			
					//debugger;
		 
			//modifiedby harshK for sp4 issueid 190
			//Modified by ManishK on 16th Feb 2006 For PMLifeLine SP6 IssueID 2176
			//objform.action = "PM_TaskStatusManagement.aspx?FromWhere=PM&MasterTagId=<%=m_lngTagId%>&Mode=Save&ProjectID=" + intProjectID + "&TaskType=" + strTaskType + "&FromDate=" + objFromDate + "&ToDate=" + objToDate +  "&Operation=" + intOperation + "&EmployeeID=" + GetObjectReference('frmPM_TaskStatusManagement','cboEmployee').value ;                
                objform.action = "PM_TaskStatusManagement.aspx?TaskID=" + strTaskID + "&FromWhere=PM&MasterTagId=<%=m_lngTagId%>&Mode=Save&ProjectID=" + intProjectID + "&TaskType=" + strTaskType + "&FromDate=" + objFromDate + "&ToDate=" + objToDate + "&Operation=" + intOperation + "&EmployeeID=" + GetObjectReference('frmPM_TaskStatusManagement', 'cboEmployee').value;
			//End of Modified by ManishK on 16th Feb 2006 For PMLifeLine SP6 IssueID 2176
			//End Of Adddtion By PrashantD on 14 Sept 2005
			//End modifiedby harshK for sp4 issueid 190
			
			
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
			// added By Purvaj on 10 OCt 2008 checkbox for child task is always disabled in case of set baseline and clear baseline
			var objOperation;
			objOperation = GetObjectReference('frmPM_TaskStatusManagement','cboOperation');
			// End addition purvaj
			
			objTaskType = GetObjectReference('frmPM_TaskStatusManagement','optTaskType',true);
			for(intCnt=0; intCnt < objTaskType.length; intCnt++)
			{
				if(objTaskType[intCnt].checked)
					strTaskType = objTaskType[intCnt].value;
			}
			
			strCheckBox = 'chk' + intTaskID + '_0';
			objCheckbox = GetObjectReference('frmPM_TaskStatusManagement',strCheckBox);
			<%' Modified by nitinvs on 19 July 2007 for PMLifeLine to validate for existance of objCheckbox %>
			if (objCheckbox != null )
			{
				if (strTaskType == 'O' || strTaskType == 'R')
				{
					if (objCheckbox.checked == true)
					{
						blnChecked = true;
						if (strTaskIDs.indexOf(',' + intTaskID + ',') == -1)
						{
							strTaskIDs = strTaskIDs + intTaskID + ',';
						}
					}
					else
					{
						blnChecked = false;
						if (strTaskIDs.indexOf(',' + intTaskID + ',') != -1)
						{
							strTaskIDs = strTaskIDs.replace(intTaskID + ',','');
						}
					}
				
					for (i = 1; i <= intChildCount; i++)
					{
		
						strCheckBox = 'chk' + intTaskID + '_' + i;
						objCheckbox = GetObjectReference('frmPM_TaskStatusManagement',strCheckBox);
						
						strTextBox = 'txt' + intTaskID + '_' + i;
						objTextbox = GetObjectReference('frmPM_TaskStatusManagement',strTextBox);
					
						if(objCheckbox != null)
						{
							if (blnChecked == true) 
							{
							    // Added By purvaj on 25 Nov 2008 For PMLifeLine
							    // Do not select child tasks if the child tasks are displayed as disabled
							    if(objOperation.value == 2)
							    {
							        if(objCheckbox.disabled == false)
							            objCheckbox.checked=true;
							    }
							    else
							    {
							        //End additition purvaj
								    objCheckbox.checked=true;
							        objCheckbox.disabled=true;
							     }
								
								if (strTaskIDs.indexOf(',' + objCheckbox.value + ',')== -1)
								{
								// Added By purvaj on 25 Nov 2008 For PMLifeLine
							    // Do not select child tasks if the child tasks are displayed as disabled
								    if(objOperation.value == 2)
							        {
							            if(objCheckbox.disabled == false)
            				                strTaskIDs = strTaskIDs + objCheckbox.value + ',';
							        }
							        else
							        {   
							            //End additition purvaj
									    strTaskIDs = strTaskIDs + objCheckbox.value + ',';
									}
								}

							}
							else
							{
					
								if (strTaskIDs.indexOf(',' + objCheckbox.value + ',') != -1)
								{
									strTaskIDs = strTaskIDs.replace(objCheckbox.value + ',','');
								}
                                //Added by Dhanashri S on 1 Sept 2016
								if(objTextbox != null)
								{
                                    //End of Addition by Dhanashri S on 1 Sept 2016
								    if (objTextbox.value == 'False')
								    {
								        objCheckbox.checked=false;
								        // added By purvaj on 10 Oct 2008 checkbox for child task is always disabled in case of set baseline and clear baseline 
								        if (objOperation.value == 11 || objOperation.value == 12)
								            objCheckbox.disabled=true;
								        else
								            objCheckbox.disabled=false;
								    }
								}
							}
						}
					<%'End Modification By NitinVS on 19 July2007 for PMLifeLine to validate for objCheckbox is not null %>						
					}			
				}
				
				if (strTaskType == 'M' || strTaskType == 'B')
				{
					if (objCheckbox.checked == true)
					{
						blnChecked = true;
						if (strTaskIDs.indexOf(',' + intTaskID + ',') == -1)
						{
							strTaskIDs = strTaskIDs + intTaskID + ',';
						}
					}
					else
					{
						blnChecked = true;
						if (strTaskIDs.indexOf(',' + intTaskID + ',') > -1)
						{
							strTaskIDs = strTaskIDs.replace(intTaskID + ',','');
						}
					}
				}
			}	
		}
		
		function CheckTask(intTaskID,intCount)
		{
			var strCheckBox, objCheckbox, intIndex, blnChecked;
			//objtxtActPer = GetObjectReference('frmPM_TaskStatusManagement','txt'+ intTaskID + "_"  + intCount);
    		strCheckBox = "chk" + intTaskID + "_"  + intCount;
			objCheckbox = GetObjectReference('frmPM_TaskStatusManagement',strCheckBox);
			if (objCheckbox.checked == true)
			{   
    		 /*   if (objtxtActPer!=null)
			        objtxtActPer.readOnly=false;
			 */
				blnChecked = true;
				<%'Modified By NitinVS on 25 Apr 2007 for PMLifeLine SP 8 Regression Fixes  Added "," + before objCheckbox.value %>				
				if (strTaskIDs.indexOf(',' + objCheckbox.value + ',') == -1)
				{
					strTaskIDs = strTaskIDs + objCheckbox.value + ',';
				}
			}
			else
			{
				blnChecked = false;
				//if (objtxtActPer!=null)
				//    objtxtActPer.readOnly=true;
				if (strTaskIDs.indexOf(',' + objCheckbox.value + ',') > -1)
				{
					strTaskIDs = strTaskIDs.replace(objCheckbox.value + ',','');
				}
			}
			

		}
		//Intigrated by harshk for sp4 issueid 190
	 function SelectAll_OnClick()
		{
		//debugger;
		  	
		  var strCheckboxIDs,objCheckbox,intItems,intCtr=0;
		 		  		  	   		  
			if('<%=m_CheckboxIDs%>' != "")
			{		  
			 strCheckboxIDs = '<%=m_CheckboxIDs%>'.split(",");
			 intItems = strCheckboxIDs.length;
		    		if(intItems > 1) 
					{
						
						for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
						{		       
								//alert(intCtr);		  
								   
							objCheckbox = GetObjectReference(objform,strCheckboxIDs[intCtr]);
							//MODIFIED BY VIVEKP ON 28 SEP 2005 FOR ISSUEID-421
							if (objCheckbox!=null)
							{
							    // commented by purvaj on 10 OCt 2008 for Set Baseline clease baseline
							    // if condition removed.
								//if (objCheckbox.disabled == false)
								//{
								objCheckbox.checked = true;	
								<%'Modified By NitinVS on 25 Apr 2007 for PMLifeLine SP 8 Regression Fixes  Added "," + before objCheckbox.value %>
								if ( strTaskIDs.indexOf( ',' + objCheckbox.value + ',') == -1) 
								{
								<%' End Modification By NitinVS on 25 Apr 2007 for PMLifeLine SP 8 Regression Fixes %>
									strTaskIDs = strTaskIDs + objCheckbox.value + ',';
								}
								//} 
							}	
							//END OF MODIFICATION BY VIVEKP  ON 28 SEP 2005 FOR ISSUEID-421
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
//------------------------------------------------------------------------------
//Purpose : Clear all check boxes
//------------------------------------------------------------------------------
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
								//MODIFIED BY VIVEKP ON 28 SEP 2005 FOR ISSUEID-421
							if (objCheckbox!=null)
							{
							    // commented by purvaj on 10 OCt 2008 for Set Baseline clease baseline
							    // if condition removed.
								//if (objCheckbox.disabled == false)
								//{
									objCheckbox.checked = false;		        		
									if (strTaskIDs.indexOf(objCheckbox.value + ',') > -1)
							        {
							        strTaskIDs = strTaskIDs.replace(objCheckbox.value + ',','');
							        }
    							//}
							}
							//END OF MODIFICATION BY VIVEKP  ON 28 SEP 2005 FOR ISSUEID-421
							}
							}
							// Else, if single element exists, then...
							else if(intItems == 1)
							{
							objCheckbox = GetObjectReference(objform,strCheckboxIDs[0]);
							// commented by purvaj on 10 OCt 2008 for Set Baseline clease baseline
							// if condition removed.
							//if (objCheckbox.disabled == false)
							//{
							objCheckbox.checked = false;
							if (strTaskIDs.indexOf(objCheckbox.value + ',') > -1)
							{
							strTaskIDs = strTaskIDs.replace(objCheckbox.value + ',','');
							}
							//}
							}
							}
							}
							//End Intigrated by harshk for sp4 issueid 190
							//Integrated in Whiz2 by MrugajaB on 15th Dec 2005
							//Added by SandeepA on 17 Nov,2005 for IssueID-684 (Task Filters)
							//Purpose : function for 'ShowAll Tasks' and 'Show Tasks For Period' option buttons
							function optTasks_OnClick(Show)
							{//debugger;
							//GetObject Reference for Date Controls
							var txtToDate=GetObjectReference('frmPM_TaskStatusManagement','txtToDate');
							var txtFromDate=GetObjectReference('frmPM_TaskStatusManagement','txtFromDate');
							//Get ObjectReference for SPAN tag
							var objSpanFromDt=GetObjectReference('frmPM_TaskStatusManagement','FromDate');
							var objSpanToDt=GetObjectReference('frmPM_TaskStatusManagement','ToDate');

							//Added by ManishK on 16th Feb 2006 For PMLifeLine Sp6 IssueID 2172


							//End OF Added by ManishK on 16th Feb 2006 For PMLifeLine Sp6 IssueID 2172

							//Added by ShubhadaL on 2 Feb 2006
							//Purpose : To show date controls if Show All Tasks is clicked.

							var objFromDateDisable = GetObjectReference('frmPM_TaskStatusManagement','FFE29587WHIZ_txtFromDate');
							var objToDateDisable = GetObjectReference('frmPM_TaskStatusManagement','FFE29587WHIZ_txtToDate');
							//Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
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

							var objFromDate, objToDate;
							objFromDate = GetObjectReference('frmPM_TaskStatusManagement','txtFromDate').value;
							objToDate = GetObjectReference('frmPM_TaskStatusManagement','txtToDate').value;
							//End addition by ShubhadaL on 2 Feb 2006

							//Added by ShubhadaL on 7 Feb 2006 to Hide * mark if ShowAll is clicked else show it.
							objStarID = GetObjectReference('frmPM_TaskStatusManagement','StarID');
							objStarIDTo = GetObjectReference('frmPM_TaskStatusManagement','StarIDTo');
							//End addition by ShubhadaL on 7 Feb 2006

							//If 'Show All Tasks' is clicked then hide the Date controls
							if(Show=="ShowALL")
							{
							//Commented by ShubhadaL on 2 Feb 2006
							//Purpose : To show date controls if Show All Tasks is clicked.
							// objSpanFromDt.style.visibility="hidden";
							// objSpanToDt.style.visibility="hidden";

							//Added by ManishK on 16th Feb 2006 for PMLifeLine sp6 issues 2172
							// dtStartDate=objFromDateDisable.value;
							//dtEndDate=objToDateDisable.value;

							//Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
							    //if(navigator.appName != 'Netscape')Modified by VirajP on 09 Dec 2015  Issue ID.2705
							//{
							objFromDateDisable.value="";
							objToDateDisable.value="";
							//}
							//End Of Added by ManishK on 16th Feb 2006 for PMLifeLine sp6 issues 2172

							//Added by ShubhadaL on 7 Feb 2006 to Hide * mark if ShowAll is clicked else show it.
							objStarID.style.display='none';
							objStarIDTo.style.display='none';
							//End addition by ShubhadaL on 7 Feb 2006
							//Added by ShubhadaL on 2 Feb 2006
							//Purpose : To disable date controls if Show All Tasks is clicked.

							txtToDate.disabled = true;
							txtFromDate.disabled = true;

							//Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
							    //if(navigator.appName != 'Netscape')Modified by VirajP on 09 Dec 2015  Issue ID.2705
							//{
							objFromDateDisable.disabled = true;
							objToDateDisable.disabled = true;
							//}
							//objToDateDisable.value = "";
							objSpanFromDt.style.visibility="visible";
							objSpanToDt.style.visibility="visible";

							//End addition by ShubhadaL on 2 Feb 2006
							}
							//If 'Show Task For Period' is clicked then show the Date Controls
							if(Show=="ShowWeekly")
							{
							//Added by ManishK on 16th Feb 2006 For PMLifeLine Sp6 IssueID 2172
							//txtFromDate.value=dtStartDate;
							//txtToDate.value=dtEndDate;

							//Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
							    //if(navigator.appName != 'Netscape')Modified by VirajP on 09 Dec 2015  Issue ID.2705
							//{
                                //Commented By Usha Pandit On 07.05.2020 For setting correct Date format
							//objFromDateDisable.value=dtStartDate;
							//objToDateDisable.value=dtEndDate;
                                //End Of Commented By Usha Pandit On 07.05.2020 For setting correct Date format
							//}
							//End of Added by ManishK on 16th Feb 2006 For PMLifeLine Sp6 IssueID 2172

							//Added by ShubhadaL on 7 Feb 2006 to Hide * mark if ShowAll is clicked else show it.
							objStarID.style.display='';
							objStarIDTo.style.display='';
							//End addition by ShubhadaL on 7 Feb 2006
							objSpanFromDt.style.visibility="visible";
							objSpanToDt.style.visibility="visible";

							//Added by ShubhadaL on 2 Feb 2006
							//Purpose : To disable date controls if Show All Tasks is clicked.
							txtToDate.disabled = false;
							txtFromDate.disabled = false ;

							//Modified by MrugajaB on 4th July 2006 for PMLifeLine SP7 Issue ID.4168
							    //if(navigator.appName != 'Netscape')Modified by VirajP on 09 Dec 2015  Issue ID.2705
							//{
							objFromDateDisable.disabled = false;
							//  objFromDateDisable.value = objFromDate;
							objToDateDisable.disabled = false;
							//  objToDateDisable.value = objToDate;
							//End addition by ShubhadaL on 2 Feb 2006
							//}
							}
							}
							//End of Addition by SandeepA on 17 Nov,2005 for IssueID-684
							//End Integration

function ActualPercentChange(TaskID)
{
	//debugger;
	objActualPercent = GetObjectReference('frmPM_TaskStatusManagement','txtActPer_' + TaskID );
	objActualStartDate = GetObjectReference('frmPM_TaskStatusManagement','FFE29587WHIZ_ActStartDate_' + TaskID );
	objActualEndDate = GetObjectReference('frmPM_TaskStatusManagement','FFE29587WHIZ_ActEndDate_' + TaskID );

	objTaskType = GetObjectReference('frmPM_TaskStatusManagement','optTaskType',true);

	
	if(<%=m_intMSPIntegrationMethod%> ==1)
	{
		if (disallowBlank(objActualPercent, "Please enter the &#39;actual % complete&#39; !!"))
			return;
		if (disallowValueRangeViolation(objActualPercent, 0, 100, "Please enter a numeric value for the &#39;actual % complete&#39; !!\nThe value of &#39;actual % complete&#39; must be in the range [0-100]", true))
			return;

		return;
	}
	// Commented by Purvaj on 8 Oct 2008 
	//validation done only on saveclick
	/*if (strTaskIDs.indexOf(',' + TaskID + ',') == -1 || strTaskIDs ==',')
	{
		alert("Please select checkbox if you want to save the changes");
	}
	else*/
	{
		if (disallowBlank(objActualPercent, "Please enter the &#39;actual % complete&#39; !!"))
			return;
		if (disallowValueRangeViolation(objActualPercent, 0, 100, "Please enter a numeric value for the &#39;actual % complete&#39; !!\nThe value of &#39;actual % complete&#39; must be in the range [0-100]", true))
		return;

		if (objActualPercent != null && '<%=m_strTaskType%>'=='M' )
		{
			if (objActualPercent.value == 100.00 )
			{
				if ( objActualStartDate.value =='' && objActualEndDate.value =='')
				{
					alert("Please enter task's 'Actual Start Date' & 'Actual End Date'.");
					setFocus(objActualEndDate);
				}
				if ( objActualStartDate.value !='' && objActualEndDate.value =='')
				{
					alert("Please enter task's 'Actual End Date'.");
					setFocus(objActualEndDate);
				}
				if ( objActualStartDate.value =='' && objActualEndDate.value !='')
				{
					alert("Please enter task's 'Actual Start Date'.");
					setFocus(objActualEndDate);
				}
			}
			else
			{
				if (objActualStartDate.value =='')
				{
					if (objActualPercent.value > 0 )
					{
						alert("Please enter Task's 'Actual Start Date'.");
						setFocus(objActualStartDate);
					}
				}
			}
		}
	}
}//End of function ActualPercentChange

		function ValidateMppTask()
		{ //debugger;
		strCheckboxIDs = strTaskIDs.split(",");
		intItems = strCheckboxIDs.length;

		var strProjctStartDate,strProjectEndDate;
		objtxtProjectStartDate = GetObjectReference('frmPM_TaskStatusManagement','txtProjectStartDate');
		objtxtProjectEndDate = GetObjectReference('frmPM_TaskStatusManagement','txtProjectEndDate');

		if(intItems > 1)
		{
		if(<%=m_intMSPIntegrationMethod%> != 2)
			{
				for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{
					TaskID = strCheckboxIDs[intCtr];
					objActualPercent = GetObjectReference('frmPM_TaskStatusManagement','txtActPer_' + TaskID );

					if (disallowBlank(objActualPercent, "Please enter the &#39;actual % complete&#39; !!"))
					{
						return false;
						break;
					}
					if (disallowValueRangeViolation(objActualPercent, 0, 100, "Please enter a numeric value for the &#39;actual % complete&#39; !!\nThe value of &#39;actual % complete&#39; must be in the range [0-100]", true))
					{
						return false; 
						break;
					}
				}
			}
			else
			{		
				for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{
				TaskID = strCheckboxIDs[intCtr];
								
				objActualPercent = GetObjectReference('frmPM_TaskStatusManagement','txtActPer_' + TaskID );
				objActualStartDate = GetObjectReference('frmPM_TaskStatusManagement','FFE29587WHIZ_ActStartDate_' + TaskID );
				objActualEndDate = GetObjectReference('frmPM_TaskStatusManagement','FFE29587WHIZ_ActEndDate_' + TaskID );
				objPreActualStartDate = GetObjectReference('frmPM_TaskStatusManagement','ActStartDate_' + TaskID );
				objPreActualEndDate = GetObjectReference('frmPM_TaskStatusManagement','ActEndDate_' + TaskID );
				
				if (objActualPercent != null )
				{
					if (disallowBlank(objActualPercent, "Please enter the &#39;actual % complete&#39; !!"))
					{					
						return false;
						break;
					}
					if (disallowValueRangeViolation(objActualPercent, 0, 100, "Please enter a numeric value for the &#39;actual % complete&#39; !!\nThe value of &#39;actual % complete&#39; must be in the range [0-100]", true))
					{
						return false;
						break;
					}
					if('<%=m_strTaskType%>' == 'M')
					{
						if (objPreActualStartDate.value =='' && objPreActualEndDate.value == '' && objActualPercent.value == 100.00)
							{if(disallowDate1GreaterThanDate2(objPreActualStartDate,objPreActualEndDate,"Task's 'Actual Start Date' should be less than  or equal to 'Actual End Date'",true))
								{
									setFocus(objActualStartDate);
									return false;
								}
							}
						
						if (objActualPercent.value == 100.00 )
						{
							if (objActualStartDate.value == '' &&  objActualEndDate.value =='')
							{
								alert("Please enter task's 'Actual Start Date' & 'Actual End Date'");
								setFocus(objActualStartDate);
								return false;
								break;
							}
							if (objActualStartDate.value != '' &&  objActualEndDate.value =='')
							{
								alert("Please enter task's 'Actual End Date'");
								setFocus(objActualEndDate);
								return false;
								break;
							}
							if (objActualStartDate.value == '' &&  objActualEndDate.value !='')
							{
								alert("Please enter task's 'Actual Start Date'");
								setFocus(objActualStartDate);
								return false;
								break;
							}
							if('<%=m_btRestrictDurationChange_M%>' == 'True')
							{
								objtxtTaskStartDate = GetObjectReference('frmPM_TaskStatusManagement','txtTaskStartDate_' + TaskID );
								objtxtTaskEndDate = GetObjectReference('frmPM_TaskStatusManagement','txtTaskEndDate_' + TaskID );

								if( disallowDate1GreaterThanDate2(objtxtTaskStartDate,objPreActualStartDate,"Task's 'Actual Start Date' should be greater than or equal to Task's 'Start Date'.",true))
								{
									setFocus(objActualStartDate);
									return false;
								}
								if( disallowDate1GreaterThanDate2(objPreActualEndDate,objtxtTaskEndDate,"Task's 'Actual End Date' should be less than or equal to Task's 'End Date'.",true))
								{
									setFocus(objActualEndDate);
									return false;
								}
							}
							if( disallowDate1GreaterThanDate2(objtxtProjectStartDate,objPreActualStartDate,"Task's 'Actual Start Date' should be greater than or equal to Project's 'Start Date'.",true))
							{
								setFocus(objActualStartDate);
								return false;
							}
							if( disallowDate1GreaterThanDate2(objPreActualEndDate,objtxtProjectEndDate,"Task's 'Actual End Date' should be less than or equal to Project's 'End Date'.",true))
							{
								setFocus(objActualEndDate);
								return false;
							}
						}
						else if (objActualPercent.value < 100.00 && objActualPercent.value > 0)
						{
							if (objActualStartDate.value == '' )
							{
								alert("Please enter task's 'Actual Start Date'");
								setFocus(objActualStartDate);
								return false;
								break;
							}
							if (objActualEndDate.value != '' )
							{
								alert("Please do not enter task's 'Actual End Date'");
								setFocus(objActualEndDate);
								return false;
								break;
							}
							if('<%=m_btRestrictDurationChange_M%>' == 'True')
							{
								objtxtTaskStartDate = GetObjectReference('frmPM_TaskStatusManagement','txtTaskStartDate_' + TaskID );
								objtxtTaskEndDate = GetObjectReference('frmPM_TaskStatusManagement','txtTaskEndDate_' + TaskID );

								if( disallowDate1GreaterThanDate2(objtxtTaskStartDate,objPreActualStartDate,"Task's 'Actual Start Date' should be greater than or equal to Task's 'Start Date'.",true))
								{
									setFocus(objActualStartDate);
									return false;
								}
							}
							if( disallowDate1GreaterThanDate2(objtxtProjectStartDate,objPreActualStartDate,"Task's 'Actual Start Date' should be greater than or equal to Project's 'Start Date'.",true))
							{
								setFocus(objActualEndDate);
								return false;
							}
						}//End of if (objActualPercent.value == 100.00 )
					}//End of if ('M'=='M')	
				} //End of if (objActualPercent != null )
			}//End of for
		}//End of if MSPIntegration != 2	
	} //End of intItems > 1

return true;
}//End of function 'ValidateMppTask()'
					</Script>
	</body>
</HTML>
