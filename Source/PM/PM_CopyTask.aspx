<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_CopyTask.aspx.vb" Inherits="PbNIT.PM_CopyTask" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
<%'Added By MahendraV On 7:47 PM 5/8/2007'%>
<%'Start_MV_5/8/2007'%>
<%Call Draw_Page_Header()%>
<%'End_MV_5/8/2007'%>

<%CommonFunctions.General.PlotPageHeadTag("")%>

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<script src="../../responsive/responsive.js"></script>
<script src="../../General/CommonValidations.js?date=<%=DateTime.Now %>"></script> 

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


	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">

		<form id="frmPM_CopyTask" method="post" runat="server">
			<%PageInit%>
		</form>
  
		<Script language="javascript">
		var objform=GetFormReference('frmPM_CopyTask');
		var objdivlist=GetObjectReference('frmPM_CopyTask','PageDiv');
		
		var strHolidays = "<%=m_strHolidays%>";
		var strStartingDay="<%=m_strStartingDayOfWeek%>";  
		var strSelectedTasks = "";
		
		var m_teammember= "<%=m_teammember%>";
		var strEmployee="<%=strEmployee%>";
		var strLeaveFromDate="<%=strLeaveFromDate%>";
		var strLeaveToDate="<%=strLeaveToDate%>";
		var strEmployeeID="<%=strEmployeeID%>";
		//Addedby HarshK for sp4 IssueID 120,121 on 06/10/2005
		var intResourceValidation = <%=m_bitResourceValidation%>;
		//End Addedby HarshK for sp4 IssueID 120,121 on 06/10/2005
		//The div tag has id as PageDiv 
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			//Modified by JyotiG on Date 11 July,2006 for WhizibleSEM Issue ID.4168
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			}
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
        }			
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
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
        }
		}	
		
		function Next_OnClick()
		{
		
 
			if (ValidateControls()== false)
				return;
			var objcboFilter = GetObjectReference('frmPM_CopyTask','cboFilter');
		    //alert(objcboFilter.value);
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
			objform.action= "PM_CopyTask.aspx?Combo="+objcboFilter.value+"&COPYDATA=1&MODE_LIST_GRID=BACKLIST&MODE=<%=MODE_LIST_TASK%>&PARENT_TAGID=<%=m_ParentTagID%>&UNIQUEID=<%=m_UNIQUEID%>&UNIQUEID_NEW=<%=m_UniqueID_New%>&SELECTEDTASK="+ strSelectedTasks + "&FROMDATE=<%=m_FromDate%>&TODATE=<%=m_ToDate%>&ATTRIBUTE_STATUS_BACK1=<%=strAttributeStatusback%>";
			objform.submit();
		}
		
		
		function Back_OnClick()
		{
			//objform.action= "PM_CopyTask.aspx<%=m_QueryString%>"
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
			objform.action= "PM_CopyTask.aspx?COPYDATA=1&MODE=EDIT&PARENT_TAGID=<%=m_ParentTagID%>&UNIQUEID=&UNIQUEID_NEW=<%=m_UniqueID_New%>&SELECTEDTASK="+ strSelectedTasks + "&FROMDATE=<%=m_FromDate%>&TODATE=<%=m_ToDate%>";
			objform.submit();
		
		}
		function Back_OnClickGRID()
		{
			if ("<%=Session("MODE_SESSION")%>"=="MODE_EDIT")
			objform.action= "PM_CopyTask.aspx?COPYDATA=1&MODE_GRID=BACKGRID&MODE=<%=MODE_GET_TASK%>&PARENT_TAGID=<%=m_ParentTagID%>&UNIQUEID=<%=m_UNIQUEID%>&UNIQUEID_NEW=<%=m_UniqueID_New%>" + "&FROMDATE=<%=m_FromDate%>&TODATE=<%=m_ToDate%>&ATTRIBUTE_STATUS_BACK1=<%=strAttributeStatusback%>";
			else			
			objform.action= "PM_CopyTask.aspx?COPYDATA=1&MODE_GRID=BACKGRID&MODE=<%=MODE_ADD_NEW%>&PARENT_TAGID=<%=m_ParentTagID%>&UNIQUEID=<%=m_UNIQUEID%>&UNIQUEID_NEW=<%=m_UniqueID_New%>" + "&FROMDATE=<%=m_FromDate%>&TODATE=<%=m_ToDate%>&ATTRIBUTE_STATUS_BACK1=<%=strAttributeStatusback%>";
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
		    objform.submit();
		}
		
		function Back_OnClickLIST()
		{
			var	objchkModule = GetObjectReference('frmPM_CopyTask','chkModule');
			var	objchkMileStone = GetObjectReference('frmPM_CopyTask','chkMileStone');
			var	objchkSubProject = GetObjectReference('frmPM_CopyTask','chkSubProject');
			var	objchkDeliverable = GetObjectReference('frmPM_CopyTask','chkDeliverable');
			
			//integration done by SuchitraP on 25-Jun-2007
			//added by ChristinaT on 22/04/2007 for RequestID:7548
			var	objchkPhase = GetObjectReference('frmPM_CopyTask','chkPhase');
			//end of addition by ChristinaT
			//end of integration done by SuchitraP on 25-Jun-2007
			var strAttributeStatus =""
			
			if (objchkModule.checked)
				strAttributeStatus= strAttributeStatus + "1," ;
			else
				strAttributeStatus= strAttributeStatus + "0," ;
			
			if (objchkMileStone.checked)
				strAttributeStatus= strAttributeStatus + "1," ;
			else
				strAttributeStatus= strAttributeStatus + "0," ;

			
			if(objchkSubProject.checked)
				strAttributeStatus= strAttributeStatus + "1," ;
			else
				strAttributeStatus= strAttributeStatus + "0," ;
				
			if(objchkDeliverable.checked)	
				strAttributeStatus= strAttributeStatus + "1," ;
			else
				strAttributeStatus= strAttributeStatus + "0," ;
			//integration done by SuchitraP on 25-Jun-2007
			//added by ChristinaT on 22/04/2007 for RequestID:7548				
			if(objchkPhase.checked)	
				strAttributeStatus= strAttributeStatus + "1" ;
			else
				strAttributeStatus= strAttributeStatus + "0" ;
		//end of addition by CHristinaT
		    //end of integration done by SuchitraP on 25-Jun-2007

		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016

		objform.action= "PM_CopyTask.aspx?Combo=<%=strModuleNmae%>&COPYDATA=1&MODE_LIST=BACKLIST&MODE=<%=MODE_LIST_TASK%>&PARENT_TAGID=<%=m_ParentTagID%>&UNIQUEID=<%=m_UNIQUEID%>&UNIQUEID_NEW=<%=m_UniqueID_New%>&SELECTEDTASK="+ strSelectedTasks + "&FROMDATE=<%=m_FromDate%>&TODATE=<%=m_ToDate%>&ATTRIBUTE_STATUS_BACK="+strAttributeStatus;
		objform.submit();
		}
		
		function Create_Task( )
		{
	       var baseline=0;
	/************************ Added By VijayD 25 May 2009********************************
            Purpose: To validate Task assignment for baseline
     ************************ ***********************************************************/
		    var objModuleID= GetObjectReference('frmPM_CopyTask','txtModuleID');     
		    var objSubProjectID = GetObjectReference('frmPM_CopyTask','txtSubProjectID');
		    var objMilestoneID= GetObjectReference('frmPM_CopyTask','txtMileStoneID');  
		    var objCurrentWork = GetObjectReference('frmPM_CopyTask','txtEffort');
		    var objTaskStartDate = GetObjectReference('frmPM_CopyTask','txtFromDate');
		    var objTaskEndDate = GetObjectReference('frmPM_CopyTask','txtToDate');
		    var objTaskIDs = GetObjectReference('frmPM_CopyTask','txtTaskID');    
		    var objDeliverableIDs = GetObjectReference('frmPM_CopyTask','txtDeliverableIDs');
		    
		    var strModuleID=objModuleID.value;
            var arrModuleID = strModuleID.split(',');
		    
		    var strSubProjectID=objSubProjectID.value;
            var arrSubProjectID = strSubProjectID.split(',');
            
            var strMilestoneID=objMilestoneID.value;
            var arrMilestoneID = strMilestoneID.split(',');    
		    
		    var strCurrentWork=objCurrentWork.value;
            var arrCurrentWork = strCurrentWork.split(',');
            
            var strTaskStartDate=objTaskStartDate.value;
            var arrTaskStartDate = strTaskStartDate.split(',');
            
            var strTaskEndDate=objTaskEndDate.value;
            var arrTaskEndDate = strTaskEndDate.split(',');

            var strDeliverableIDs=objDeliverableIDs.value;
            var arrDeliverableIDs = strDeliverableIDs.split(',');
          
            var strTaskIDs=objTaskIDs.value;
            var arrTaskIDs = strTaskIDs.split(',');
            
		    var strURL;
		    var fmt = 'MMM dd,yyyy';
 		        
		    if (arrTaskIDs != null)
			{
				for (i=0;i<arrTaskIDs.length-1;i++)
				{
					// if the Task is Selected then only Validate the data 
					
					var objchkModule        = GetObjectReference('frmTaskAssignment','chkModule');
					var objchkMileStone        = GetObjectReference('frmTaskAssignment','chkMileStone');
					var objchkSubProject    = GetObjectReference('frmTaskAssignment','chkSubProject');
					var objchkDeliverable   = GetObjectReference('frmTaskAssignment','chkDeliverable');
					
					
					strModuleID         =   arrModuleID[i];
					strSubProjectID     =   arrSubProjectID[i];
					strMilestoneID      =   arrMilestoneID[i];
					strCurrentWork      =   arrCurrentWork[i];
					strTaskStartDate    =   arrTaskStartDate[i];
					strTaskEndDate      =   arrTaskEndDate[i];
					strDeliverableIDs   =   arrDeliverableIDs[i];
					strTaskIDs          =   arrTaskIDs[i];
				//Added By Vaijat K ON 22/12/2015 IssueID-2798,2791,2788,2769
					var TagID = "<%=m_ParentTagId%>";
				    
				    if(TagID == "2133"){
					    objchkDeliverable.checked = true;}
				    else if(TagID == "454"){
					    objchkModule.checked = true;}
				    else if(TagID == "661"){
					    objchkSubProject.checked = true;}
				    else if(TagID == "34"){
				        objchkMileStone.checked = true;}
					//Ended
				    
					if (!objchkModule.checked)      {   strModuleID="NULL";         }
					if (!objchkMileStone.checked)   {   strMilestoneID="NULL";      }
					if (!objchkSubProject.checked)  {   strSubProjectID="NULL";     }
					if (!objchkDeliverable.checked) {   strDeliverableIDs="NULL";   }
					
					strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&TaskId="+strTaskIDs+"&StartDate=" + encodeURIComponent(strTaskStartDate) + "&EndDate=" + encodeURIComponent(strTaskEndDate)+ "&DeliverableID="+strDeliverableIDs+"&ModuleID="+strModuleID+"&SubProjectID="+strSubProjectID+"&MilestoneID="+strMilestoneID+"&Work="+strCurrentWork;
				
 						//Commeted by GokulP on 21 Sept 2009 to Remove Task Validation as per discuss with PrashantSJ
		                //ValidateTask_Baseline(strUrl);
    		            
		               //if(strResult!=null && strResult!="")
		               // {
		               //     alert(strResult);
		               //     return ;		    
		               // }
		                //End of Commet by GokulP on 21 Sept 2009 to Remove Task Validation as per discuss with PrashantSJ
 				   }	
		      } 

    //************************End Addition By VijayD 25 May 2009**************************//
	    
		    if(confirm("If you want to save the task with baseline then press OK.\nIf you want to save the task without baseline then press Cancel."))
		    {
		    baseline=1;
		    }
 		
		
			var	objchkModule = GetObjectReference('frmPM_CopyTask','chkModule');
			var	objchkMileStone = GetObjectReference('frmPM_CopyTask','chkMileStone');
			var	objchkSubProject = GetObjectReference('frmPM_CopyTask','chkSubProject');
			var	objchkDeliverable = GetObjectReference('frmPM_CopyTask','chkDeliverable');
			var	objchkPhase = GetObjectReference('frmPM_CopyTask','chkPhase');
			
			var strAttributeStatus =""
	
			if (objchkModule.checked)
				strAttributeStatus= strAttributeStatus + "1," ;
			else
				strAttributeStatus= strAttributeStatus + "0," ;
			
			if (objchkMileStone.checked)
				strAttributeStatus= strAttributeStatus + "1," ;
			else
				strAttributeStatus= strAttributeStatus + "0," ;

			
			if(objchkSubProject.checked)
				strAttributeStatus= strAttributeStatus + "1," ;
			else
				strAttributeStatus= strAttributeStatus + "0," ;
				
			if(objchkDeliverable.checked)	
				strAttributeStatus= strAttributeStatus + "1," ;
			else
				strAttributeStatus= strAttributeStatus + "0," ;
				//integration done by SuchitraP on 25-Jun-2007
				//added by Christinat on 19/06/2007 for RequestId : 7548
			if(objchkPhase.checked)	
				strAttributeStatus= strAttributeStatus + "1" ;
			else
				strAttributeStatus= strAttributeStatus + "0" ;
				//end of addition by ChristinaT
				//end of integration done by SuchitraP on 25-Jun-2007
				
			if (baseline == 0)	
				objform.action="PM_CopyTask.aspx?COPYDATA=1&MODE=<%=MODE_CREATE_TASK%>&PARENT_TAGID=<%=m_ParentTagID%>&UNIQUEID=<%=m_UNIQUEID%>&UNIQUEID_NEW=<%=m_UniqueID_New%>&SELECTEDTASK="+ strSelectedTasks + "&FROMDATE=<%=m_FromDate%>&TODATE=<%=m_ToDate%>&ATTRIBUTE_STATUS="+ strAttributeStatus ;
			else
				objform.action="PM_CopyTask.aspx?COPYDATA=1&MODE=<%=MODE_CREAT_TASK_WITH_BASELINE%>&PARENT_TAGID=<%=m_ParentTagID%>&UNIQUEID=<%=m_UNIQUEID%>&UNIQUEID_NEW=<%=m_UniqueID_New%>&SELECTEDTASK="+ strSelectedTasks + "&FROMDATE=<%=m_FromDate%>&TODATE=<%=m_ToDate%>&ATTRIBUTE_STATUS="+ strAttributeStatus ;	
		    
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    var MenuTags = document.getElementsByTagName('A');
		    for (i = 0; i < MenuTags.length; i++) {
		        if (MenuTags[i].className == "Menu") {
		            //MenuTags[i].style.display= "none";
		            MenuTags[i].parentNode.style.display = "none";
		        }
		    }
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
		    objform.submit();
		}
		
		function GetTaskDetails_OnClick(val)
		{ 
			var objcboFilter = GetObjectReference('frmPM_CopyTask','cboFilter');
			//var objtxtFromDate = GetObjectReference('frmPM_CopyTask','txtFromDateFilter');
			//var objtxtToDate = GetObjectReference('frmPM_CopyTask','txtToDateFilter');
			var UniqueID;
			var strComboName = '<%=strComboName%>';
			if (objcboFilter != null)
			{
				
				//if (disallowBlank(objcboFilter, strComboName + ' can not be Blank!' , true)== false)			
				//{
					//UniqueID = objcboFilter.value; 
					UniqueID=val
			    //objform.action= "PM_CopyTask.aspx?COPYDATA=1&MODE=<%=MODE_GET_TASK%>&PARENT_TAGID=<%=m_ParentTagID%>&UNIQUEID=" + UniqueID + "&UNIQUEID_NEW=<%=m_UniqueID_New%>" + "&FROMDATE=<%=m_FromDate%>&TODATE=<%=m_ToDate%>" ;
			    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
			    setFrameLoader();
			    //End of Addition by Dhanashri S on 12 Oct 2016
					objform.action= "PM_CopyTask.aspx?COPYDATA=1&MODE=<%=MODE_GET_TASK%>&PARENT_TAGID=<%=m_ParentTagID%>&UNIQUEID=" + UniqueID + "&UNIQUEID_NEW=<%=m_UniqueID_New%>"; //+ "&FROMDATE="+objtxtFromDate.value+"&TODATE="+objtxtToDate.value;
					objform.submit();
				//}		
			}	
		}
		
		
		function configure_Attribte()
		{
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
			objform.action= "PM_CopyTask.aspx?Combo=<%=strModuleNmae%>&COPYDATA=1&MODE=<%=MODE_CONFIGURE_ATTRIBUTES%>&PARENT_TAGID=<%=m_ParentTagID%>&UNIQUEID=<%=m_UNIQUEID%>&UNIQUEID_NEW=<%=m_UniqueID_New%>&SELECTEDTASK=<%=strSelectedTask%>&FROMDATE=<%=m_FromDate%>&TODATE=<%=m_ToDate%>&ATTRIBUTE_STATUS_BACK1=<%=strAttributeStatusback%>";
			objform.submit();
		}
		//addedby HarshK on 08/09/2005 for sp4 issueid 120,121
		function GetResourceDate(intEmpID,strWhichDate)
		{
			var objSDateCbo = GetObjectReference('frmPM_CopyTask','cboResourceStartDates');
			var objEDateCbo = GetObjectReference('frmPM_CopyTask','cboResourceEndDates');
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
		function CheckResourceDates(dtTaskSDt,dtTaskEDt,objResourceCbo)
		{
			var strResourceSDt,strResourceEDt;
			var dtResourceSDt,dtResourceEDt;
			if(objResourceCbo != null)
			{
				strResourceSDt = GetResourceDate(objResourceCbo[objResourceCbo.selectedIndex].value,'START');
				strResourceEDt = GetResourceDate(objResourceCbo[objResourceCbo.selectedIndex].value,'END');
				
				dtResourceSDt = getDate(strResourceSDt);
				dtResourceEDt = getDate(strResourceEDt);
				if(DateDiff(dtTaskSDt, dtResourceSDt, "d")>0)
				{
					strMsg = '<%=MyBase.GetResourceString("MSG_RESOURCE_START_DATE_VALIDATION")%>';
					strMsg = replaceSubstring(strMsg, '<=>', objResourceCbo[objResourceCbo.selectedIndex].text);
					strMsg = replaceSubstring(strMsg, '<==>', strResourceSDt);
					strMsg = replaceSubstring(strMsg, '<===>', strResourceEDt);
					alert(strMsg);
					return false;
				}
				if(DateDiff(dtResourceEDt, dtTaskEDt, "d")>0)
				{
					strMsg = '<%=MyBase.GetResourceString("MSG_RESOURCE_END_DATE_VALIDATION")%>';
					strMsg = replaceSubstring(strMsg, '<=>', objResourceCbo[objResourceCbo.selectedIndex].text);
					strMsg = replaceSubstring(strMsg, '<==>', strResourceSDt);
					strMsg = replaceSubstring(strMsg, '<===>', strResourceEDt);
					alert(strMsg)
					return false;
				}
			}return true;
		}
		//end by HarshK on 08/09/2005 for sp4 issueid 120,121
		var strResult='';
		function ValidateControls()
		{
		//Added By vivekP On 21 May 2005 for resource leave validation
		 
			var m_teammemberList,strEmployeeList,strLeaveFromDateList,strLeaveToDateList,strEmployeeIDList;
			var intCount1,intCnt1;
			var tempName;
	
	        /************************ Added By VijayD 25 May 2009********************************
                    Purpose: To validate Task assignment for baseline
             ************************ ***********************************************************/
		    var objDeliverableID = GetObjectReference('frmPM_CopyTask','txtDeliverableID',1);
		    var objModuleID= GetObjectReference('frmPM_CopyTask','txtModuleID',1);     
		    var objSubProjectID = GetObjectReference('frmPM_CopyTask','txtSubProjectID',1);
		    var objMilestoneID= GetObjectReference('frmPM_CopyTask','txtMileStoneID',1);  
            var objCurrentWork = GetObjectReference('frmPM_CopyTask', 'txtEffort', 1);
              //Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
		    var objhidCurrentWork=GetObjectReference( 'frmPM_CopyTask','txthidEffort',1);

		    //End of Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change

		    var objTaskStartDate = GetObjectReference('frmPM_CopyTask','txtFromDate',1);
		    var objTaskEndDate = GetObjectReference('frmPM_CopyTask','txtToDate',1);
		    
		    var objTaskIDs = GetObjectReference('frmPM_CopyTask','txtTaskID',1);    
		    var objEmployee = GetObjectReference('frmPM_CopyTask','cboResource',1);
		    var strURL;
		    var fmt = 'MMM dd,yyyy';
            var IntParentTagID='<%=m_ParentTagId%>';
            var IntUniqueID='<%=m_UniqueID_New %>'; 
		    if (objTaskIDs != null)
			{
				for (i=0;i<objTaskIDs.length;i++)
				{
					// if the Task is Selected then only Validate the data 
					var objchkSelect = GetObjectReference('frmTaskAssignment','chkSelect'+ i );
					 //Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change

				    //dblLCEHrs = parseFloat(objCurrentWork[i].value);

				    dblLCEHrs =parseFloat(objhidCurrentWork[i].value);
				    //End of Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
		            var strTaskStartDate =GetDateInFormat(objTaskStartDate[i].value, fmt);		       
		            var strTaskEndDate  =GetDateInFormat(objTaskEndDate[i].value, fmt);					
					if (objchkSelect.checked)
 					{ 						
 						strUrl = "../General/XMLHttp.aspx?TagID=1038&UniqueID="+IntUniqueID+"&ParentTagID="+IntParentTagID+"&Mode=TaskValidation&TaskId="+objTaskIDs[i].value+"&StartDate=" + encodeURIComponent(strTaskStartDate) + "&EndDate=" + encodeURIComponent(strTaskEndDate)+ "&DeliverableID="+objDeliverableID[i].value+"&ModuleID=&SubProjectID="+objSubProjectID[i].value+"&MilestoneID="+objMilestoneID[i].value+"&Work="+String(dblLCEHrs);
 						//strUrl = "../General/XMLHttp.aspx?TagID=1038&Mode=TaskValidation&TaskId="+objTaskIDs[i].value+"&StartDate=" + encodeURIComponent(strTaskStartDate) + "&EndDate=" + encodeURIComponent(strTaskEndDate)+ "&DeliverableID="+objDeliverableID[i].value+"&ModuleID=NULL&SubProjectID=NULL&MilestoneID=NULL&Work="+String(dblLCEHrs);
 						//Commeted by GokulP on 21 Sept 2009 to Remove Task Validation as per discuss with PrashantSJ
		                //ValidateTask_Baseline(strUrl);
    		               		           
		               //if(strResult!=null && strResult!="")
		               // {
		               //     alert(strResult);
		               //     objTaskStartDate[i].select();		                    
		               //     objTaskStartDate[i].focus();
		               //     return false;		    
		               // }
		               //End of Commet by GokulP on 21 Sept 2009 to Remove Task Validation as per discuss with PrashantSJ
 					}
 				}	
		      }		     
	       	       
	    //************************End Addition By VijayD 25 May 2009**************************//
	
			//alert("m_teammember"+m_teammember);
			//alert("strEmployee"+strEmployee);
			//alert("strLeaveFromDate"+strLeaveFromDate);
			//alert("strLeaveToDate"+strLeaveToDate);
			//alert("strEmployeeID"+strEmployeeID);
			
		/*	if(strEmployeeID!="")
				{
				alert("abcd");
				m_teammemberList = m_teammember.split(',');
				strEmployeeList=strEmployee.split(',');
				strLeaveFromDateList=strLeaveFromDate.split(',');
				strLeaveToDateList=strLeaveToDate.split(',');
				strEmployeeIDList=strEmployeeID.split(',');
				alert(m_teammemberList.length-1);
				alert(strEmployeeIDList.length-1);
				
				for(intCount1=0; intCount1 <= m_teammemberList.length-1; intCount1++){
						for(intCnt1=0; intCnt1 <= strEmployeeIDList.length-1; intCnt1++){
						alert("intCount "+intCount1+" intCnt "+intCnt1);
						}
						}
						*/
						
			//End of addition By ViveP On 21 May 2005
		 
			var objTaskID = GetObjectReference('frmPM_CopyTask','txtTaskID',1);
			var objTaskName = GetObjectReference('frmPM_CopyTask','txtTaskName',1);
			var objcboResource = GetObjectReference('frmTaskAssignment','cboResource',1);
			//alert(objcboResource[0].value);
			
            var objEffort = GetObjectReference('frmTaskAssignment', 'txtEffort', 1);
             //Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
			var objhidEffort=GetObjectReference( 'frmPM_CopyTask','txthidEffort',1);
            
		    //End of Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
			var objFromDate = GetObjectReference('frmTaskAssignment','txtFromDate',1);
			var objToDate = GetObjectReference('frmTaskAssignment','txtToDate',1);
			
			var intCompanyHrsPerDay, intCompanyWeekDays, intHolidays, intCount, intCnt, intDays;
			var strMsg, bitHoliday, dtHoliday;
			var dblAvgHoursPerDay, intResourceCount, dblTotalWork, dblTotalDuration, strHolidayList;
			var dblLCEHrs, dtmActStartDate;
			var dtProjectStartDate,  dtProjectEndDate;

			dblLCEHrs = 0 
			
			var cnttaskselected = 0 
			strSelectedTasks = ""
			if (objTaskID != null)
			{
				for (i=0;i<objTaskID.length;i++)
				{
					// if the Task is Selected then only Validate the data 
					var objchkSelect = GetObjectReference('frmTaskAssignment','chkSelect'+ i );
					
					if (objchkSelect.checked )
					{
						cnttaskselected  = 1 
						strSelectedTasks = strSelectedTasks + "," + objchkSelect.value;
						
						// Validate Task Name 
						if (disallowBlank(objTaskName[i],"<%=MyBase.GetResourceString("ENTER_TASKNAME")%>",1) == true)
								return false;
								
						// Validate Resource 
						if((objcboResource[i] != null)  )
						{
							if(disallowBlank(objcboResource[i], "<%=MyBase.GetResourceString("SELECT_RESOURCES")%>", true))
								return false;
						}
						// Validate From Date , To Date
						dtCurrentStartDate = StringToDate(objFromDate[i].value, "<%=m_strDateFormat%>");
						
						if(CheckDateFieldValidity((objFromDate[i].value),"<%=m_strDateFormat%>") == false)
						{
							objFromDate[i].focus();
							return false;
						}

						if(CheckDateFieldValidity((objToDate[i].value),"<%=m_strDateFormat%>") == false)
						{
							objToDate[i].focus();
							return false;
						}
						
						if(disallowBlank(objFromDate[i], "<%=MyBase.GetResourceString("ENTER_STARTDATE")%>", true))
							return false;
						dtCurrentEndDate = StringToDate(objToDate[i].value, "<%=m_strDateFormat%>"); 
						
						if(disallowBlank(objToDate[i], "<%=Server.HTMLDecode(MyBase.GetResourceString("ENTER_ENDDATE"))%>", true))
							return false;


						if( dtCurrentEndDate < dtCurrentStartDate )
						{alert( "<%=Server.HTMLDecode(MyBase.GetResourceString("ENDDATE_LESSTHAN_STARTDATE"))%>")
							return false;
						}
						//Dates not in between the Projects start and End dates.
						dtProjectStartDate = getDate('<%=m_strProjectStartDate%>');
						dtProjectEndDate = getDate('<%=m_strProjectEndDate%>');
						if((dtProjectStartDate != null) && (dtProjectEndDate != null) && (dtCurrentStartDate != null) && (dtCurrentEndDate != null))
						{
							//if((dtCurrentStartDate < dtProjectStartDate) || (dtCurrentEndDate > dtProjectEndDate))
							if(DateDiff(dtCurrentStartDate, dtProjectStartDate, "d")>0 || (dtCurrentEndDate > dtProjectEndDate))
							{	
							
							//alert(DateDiff(dtCurrentEndDate, dtProjectEndDate, "d"));
							//alert("abcd")
								strMsg="<%=MyBase.GetResourceString("TASKDATES_BETWEEN_PROJECTDATES")%>";
								strMsg = replaceSubstring(strMsg, "<=>", "<%=m_strProjectStartDate%>");
								strMsg = replaceSubstring(strMsg, "<==>", "<%=m_strProjectEndDate%>");
								alert(strMsg);	
								
								if (dtCurrentEndDate > dtProjectEndDate)
								objToDate[i].focus();
								if (DateDiff(dtCurrentStartDate, dtProjectStartDate, "d")>0)
								objFromDate[i].focus();
								return false;
							}
						}
						//Added by HarshK for sp4 issueid 120,121
						if(intResourceValidation == 1)
						{
							if(CheckResourceDates(dtCurrentStartDate,dtCurrentEndDate,objcboResource[i])==false)
								return false;
						}
						//End by HarshK for sp4 issueid 120,121			
						// Validate Efforts 
						//alert(Math.abs(objEffort[i]));
						 // Commented and Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change

						//if(disallowBlank(objEffort[i], "<%=MyBase.GetResourceString("PROPER_WORK_HRS")%>", true))
					    if(disallowBlank(objhidEffort[i], "<%=MyBase.GetResourceString("PROPER_WORK_HRS")%>", true))					        
							return false;
					    // End Commented and Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
							
							
					// Commented and Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
							
					    //if(disallowMinValueViolation(objEffort[i], 0.00001, "<%=MyBase.GetResourceString("PROPER_WORK_HRS")%>",true))
					    if(disallowMinValueViolation(objhidEffort[i], 0.00001, "<%=MyBase.GetResourceString("PROPER_WORK_HRS")%>",true))
							return false;
					    //End Commented and Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
				
						 // Commented and Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
				
                        if ('<%=CommonFunctions.Application.MinHoursForDAEntry%>' == 0.016) {
                        }
                        else {
                            //if((objEffort[i].value / <%=CommonFunctions.Application.MinHoursForDAEntry%>) != parseInt(objEffort[i].value / <%=CommonFunctions.Application.MinHoursForDAEntry%>))
                            if ((objhidEffort[i].value / <%=CommonFunctions.Application.MinHoursForDAEntry%>) != parseInt(objhidEffort[i].value / <%=CommonFunctions.Application.MinHoursForDAEntry%>))
                            // End Commented and Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
                            {
                                strMsg = "<%=MyBase.GetResourceString("VALID_WORK")%>";
								<%'If CommonFunctions.Application.DistributeWorkInAT = True Then%>
                                //strMsg = replaceSubstring(strMsg, "<=>", "<%'=MyBase.GetResourceString("FOR_EACH_RESOURCE")%>");
								<%'Else%>
                                strMsg = replaceSubstring(strMsg, "<=>", "");
								<%'End If%>
                                strMsg = replaceSubstring(strMsg, "<==>", "<%=CommonFunctions.Application.MinHoursForDAEntry%>");
                                alert(strMsg);
                                // Commented and Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
					            //setFocus(objEffort[i]);
					            setFocus(objhidEffort[i]);
					            // End Commented and Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
                                return false;
                            }
                        }
							
						/// Validate effort for Max 24 Hrs Per Day
						
						dateDiff = (Math.abs(dtCurrentEndDate-dtCurrentStartDate) /(1000 * 60 * 60 * 24) ) + 1 ;
						
                        //debugger;
						if(dateDiff > 0)
						{
							//Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change

                            intHoursPerDay = objEffort[i].value.split(":")[0] / dateDiff;
                            var intMins = objEffort[i].value.split(":")[1] / dateDiff;
						    //intHoursPerDay = objhidEffort[i].value / dateDiff;
						    //Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
								if (intHoursPerDay == 24 && intMins > 0) {
                                        alert("The work hours per day cannot exceed 24 hours. Please enter valid work hours.");
                                        objEffort[i].focus();
                                        return false;
                                    }
                                   
								if (intHoursPerDay > 24)
                                {
                                   
                                        alert("The work hours per day cannot exceed 24 hours. Please enter valid work hours.");
                                        objEffort[i].focus();
                                        return false;
                                    
                                   
								}
							
						}

						// Commented and Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change

						//dblLCEHrs += parseFloat(objEffort[i].value) ;
						dblLCEHrs += parseFloat(objhidEffort[i].value) ;
					    // End of Commented and Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
		
						
					}
					
				}
				// if no Task Is Selected 
				if (cnttaskselected == 0)
				{
					alert("<%=MyBase.GetResourceString("SELECT_TASK")%>");
					return false ;
				}
				//Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
			    else
			    {

			        if (objEffort != null)
			        {
			            for (i=0;i<objEffort.length;i++)
			            {
			                //debugger;
			                var objEffortvalue=objEffort[i];
			                objOldVal = objEffortvalue.value;
			                // alert(objEffortvalue.value);
                            var objEffortVal = objEffortvalue.value;
                            //Added By Ankush T on 18-March-2019 for allowing to enter only hours 
                            //if (objEffortVal.indexOf(":") == -1) {
                            //     objEffortvalue.value =objEffortVal + ":00";
                            //     objVal = objEffortvalue.value;
                            //}
			                //End of Added By Ankush T  on 18-March-2019 for allowing to enter only hours 
                            //if(objEffortvalue.value == "")
                            //{
                            //    alert("'Work (H:M)' should not be left blank.");
                            //    setFocus(objEffortvalue);
                            //    return false;
                            //}
                           
                             var blnResult = disallowBlank(objEffortvalue, "'Work (H:M)' should not be left blank.");

                                if(blnResult == true)
                                {
                                    setFocus(objEffortvalue);
                                            return false;
                                }

                                objEffortvalue.value= objEffortvalue.value.replace(":",".");
                                var isdigit = isNumeric(objEffortvalue.value);
                                objEffortvalue.value= objOldVal;

                                if(isdigit == false)
                                 {
                                alert("Please Enter only positive numeric value For Work (hrs) in H:M format.");
                                setFocus(objEffortvalue);
                                        return false;
                                 }
			                if(objEffortvalue.value.indexOf(':')==-1){
			                    //alert("Please enter Work (hrs) in hh:mm format.");
			                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			                    //setFocus(objEffortvalue);
			                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			                    //return false;
			                    objEffortvalue.value =objEffortVal + ":00";
			                    objVal = objEffortvalue.value;
			                }
			                //objEffort.value = objEffort.value.replace(/:/g, ".");
			                var precision = objEffortvalue.value.split(":")[1];
			                var hrs = objEffortvalue.value.split(":")[0];

                             if(hrs.indexOf("-") != -1)
                            {
                            alert('Hours should not be less than or equal to zero (0).');
                             //Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                            setFocus(objEffortvalue);
                            //End of Added by Usha Pandit on 14.03.2019 for set focus on H:M validation alert
                            return false;
                            }

			                if(hrs <= 0 && precision<= 0)
			                {
			                    alert('Hours should not be less than or equal to zero (0).');
			                    objEffortvalue.value = objOldVal;
			                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			                    setFocus(objEffortvalue);
			                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			                    return false;
			                }
			                if(precision == "")
			                {
			                    alert("Please enter Work (hrs) in H:M format.");
			                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			                    setFocus(objEffortvalue);
			                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			                    return false;
			                }
			                
			                        // Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015   
                              if (precision.length > 2) {
                              alert("Please enter minutes in two decimal and less than 60.");
                              setFocus(objEffortvalue);
                               return false;
                              }
                    // End of Added By Sagar Nipane on 28-March-2019 For dis-allow invalid minutes format e.g. 12:001,12:0015

                            if (precision > 59 || precision < 0) {
			                    alert('Please enter minutes between (0-59) range');	
			                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			                    objEffortvalue.value = objOldVal;
			                    setFocus(objEffortvalue);
			                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			                    return false;
                            }

			                if(objEffortvalue.value.indexOf(":") != -1)
			                {
			                    //debugger;
			                    objEffortvalue.value= objEffortvalue.value.replace(":",".");
			                }
			             
			                var blnResult = disallowSpecialCharacters(objEffortvalue, "Please enter Work (hrs) in H:M format.");

			                if(blnResult == true)
			                {
			                    //objEffortvalue.value= objEffortvalue.value.replace(".",":");
			                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			                    objEffortvalue.value=  objOldVal;
			                    setFocus(objEffortvalue);
			                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			                    return false;
			                }

			                blnResult = disallowNonNumeric(objEffortvalue, "Please enter Work (hrs) in H:M format.");
			              
			                if(blnResult == true)
			                {
			                    //objEffortvalue.value= objEffortVal;
			                    //Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			                    //objEffortvalue.value= objEffortvalue.value.replace(".",":");
			                    objEffortvalue.value=  objOldVal;
			                    setFocus(objEffortvalue);
			                    //End of Added by Usha Pandit on 14.03.2019 for set focus on HH:MM validation alert
			                    return false;
			                }

			                var MinDAENtryDisplay = "";
			                var MinDAEntry = "<%=CommonFunctions.Application.MinHoursForDAEntry%>";
			        //alert("MinHoursDAEntry:<%=CommonFunctions.Application.MinHoursForDAEntry%>");
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
        
			        if ("<%=m_RestrictByMinHours%>" == 'True') {
			            if (MinDAEntry == 0.016) {
                           
			            }
			            else
			            {    
			                var minutes = objEffortvalue.value.split('.');
			                var p = minutes[0];
			                var dec = minutes[1];
			                if (dec == undefined) { dec = 0; }
			                d = (dec - 0) / 60 + (p - 0);

			                if((d / MinDAEntry) != parseInt(d / MinDAEntry))
			                {
			                    //alert("Please enter the work hrs. in multiple of min.work hrs (" + MinDAENtryDisplay + ")" );
			                    alert("Please enter the work Hours in multiple of (" + MinDAENtryDisplay + ") min" );
			                    setFocus(objEffortvalue);
			                    objEffortvalue.value = objEffortvalue.value.split('.').join(':');
			                    return false;
			                }
			            }
			        }
        
                }
            }

			    }
			    //End of Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change

				// Check whether the Total work hours assigned to the Tasks are more then the work hours for Project
				//alert("dblLCEHrs "+dblLCEHrs);
				//alert("PROJECT Hours "+"<%=m_dblTotalLCE%>")
				//alert("m_dblTotalAllocatedTaskLCE "+<%=m_dblTotalAllocatedTaskLCE%>)
				//alert(dblLCEHrs + parseFloat("<%=m_dblTotalAllocatedTaskLCE%>")+" > "+ parseFloat("<%=m_dblTotalLCE%>"))
				if(dblLCEHrs + parseFloat("<%=m_dblTotalAllocatedTaskLCE%>") > parseFloat("<%=m_dblTotalLCE%>"))
				{
					var dblBalancedHrs;
					dblBalancedHrs = <%=m_dblTotalLCE%> - <%=m_dblTotalAllocatedTaskLCE%>;
					//strMsg = "<%=MyBase.GetResourceString("MSG_EFFORT_GREATER_THAN_PROJECT_EFFORT")%>";
					//strMsg = replaceSubstring(strMsg, "<=>", parseFloat("<%=m_dblTotalLCE%>").toFixed(2));
					//strMsg = replaceSubstring(strMsg, "<==>", dblBalancedHrs.toFixed(2));
					//strMsg="The Total Work(hrs) for the tasks to be created is "
					strMsg="The total work (hrs) of the assigned tasks should not exceed the Project work ("
					strMsg=strMsg+"<%=m_dblTotalLCE%>"+"hrs), Balanced work hrs are "
					strMsg=strMsg+dblBalancedHrs+"!"
					alert(strMsg);
					return false;
				}

				
			}
			else
			{
			alert("<%=MyBase.GetResourceString("SELECT_TASK")%>");
			return false ;  
			}
			//Added By VivekP On 19 May 2005
			// alert(strHolidays);
			// alert(dtCurrentEndDate);
			// alert(intCompanyWeekDays);
			 intCompanyHrsPerDay = <%=m_dblHoursPerDay%>;
		intCompanyWeekDays = <%=m_lngWeekDays%>;
		// alert(intCompanyWeekDays);
			 intHolidays=0;
		bitHoliday = false;
		
		
		if (objTaskID != null)
			{
				//alert("objTaskID.length"+objTaskID.length)
				for (i=0;i<objTaskID.length;i++)
				{
					//alert("chkSelect "+ i)
					
					dtCurrentStartDate = StringToDate(objFromDate[i].value, "<%=m_strDateFormat%>");
					//alert("dtCurrentStartDate "+dtCurrentStartDate);
					
					dtCurrentEndDate = StringToDate(objToDate[i].value, "<%=m_strDateFormat%>"); 
					//alert("dtCurrentEndDate"+dtCurrentEndDate);
					// if the Task is Selected then only Validate the data 
					var objchkSelect = GetObjectReference('frmTaskAssignment','chkSelect'+ i );
					
					if (objchkSelect.checked )
					{
						
				       if(strHolidays != "")
					      {		
		
							strMsg="<%=MyBase.GetResourceString("THEDATES")%>\n";
							strHolidayList = strHolidays.split(',');
							for(intCount=0; intCount < strHolidayList.length-1 ; intCount++)
							{
							intDays = DateDiff(dtCurrentStartDate, dtCurrentEndDate, "d");
								
								for(intCnt=0; intCnt <= intDays; intCnt++)
								{
				
									dtCurrentDate = DayAdd(dtCurrentStartDate, intCnt);
									// If the holiday does not fall in the week end, then...
									if(DatePart("w", dtCurrentDate, 2) <= intCompanyWeekDays)		//Need to do
									{
									dtHoliday = getDate(strHolidayList[intCount]);	
										//if((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()))
						
									//Integrated by MrugajaB on 30th APr 2005 for Whiziblesem SP3
									/*Added Year Checking by Prajakta on 8th Feb 2005 (Issue ID 7090 of Jopasna Hot Fix 4.0.107-BF-UR)*/					
									if((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()) && (dtCurrentDate.getYear() == dtHoliday.getYear()))
								//if((dtCurrentDate.getMonth() == dtHoliday.getMonth()) && (dtCurrentDate.getDate() == dtHoliday.getDate()))
								/*End of Addition Year Checking by Prajakta on 8th Feb 2005 (Issue ID 7090 of Jopasna Hot Fix 4.0.107-BF-UR)*/					
										{
								bitHoliday=true;
								//Need the month string
									strMsg = strMsg + dtHoliday.getDate() + "-" + MonthName(dtHoliday.getMonth().toString());
									strMsg = strMsg + "-" + dtCurrentDate.getYear() + "\n";
									intHolidays = intHolidays + 1;
										}
									}
								}
							}
						}
				if(bitHoliday == true)			//Remove Comments after added the function DatePart
					{   
					if(! confirm(strMsg + "<%=MyBase.GetResourceString("DATE_HOLIDAY_MSG")%>"))
						{
						setFocus(objFromDate[i]);
						return false;
					}
				}		
		
				//alert(strStartingDay);
		
			for(intCnt=0; intCnt <= DateDiff(dtCurrentStartDate,dtCurrentEndDate, "d"); intCnt++)
				{
				dtCurrentDate = DayAdd(dtCurrentStartDate, intCnt); 
				//Modified by SiddharthS on 17 Feb 2005 for Issue Id 16002
				//Purpose:To give alert for weekend based on Staring day of week set at carporate level. 
			switch(strStartingDay) 
			{
			case "1" :
				if(DatePart("w", dtCurrentDate, 2) > intCompanyWeekDays)		// Need to do
				intHolidays = intHolidays + 1;
				break
			case "2" :
				if(DatePart("w", dtCurrentDate, 3) > intCompanyWeekDays)		
				intHolidays = intHolidays + 1;
				break
			case "3" :
				if(DatePart("w", dtCurrentDate, 4) > intCompanyWeekDays)		
				intHolidays = intHolidays + 1;
				break
			case "4" :
				if(DatePart("w", dtCurrentDate, 5) > intCompanyWeekDays)		
				intHolidays = intHolidays + 1;
				break
			case "5" :
				if(DatePart("w", dtCurrentDate, 6) > intCompanyWeekDays)		
				intHolidays = intHolidays + 1;
				break
			case "6" :
				if(DatePart("w", dtCurrentDate, 7) > intCompanyWeekDays)		
				intHolidays = intHolidays + 1;
				break
			case "7" :
				if(DatePart("w", dtCurrentDate, 1) > intCompanyWeekDays)		
				intHolidays = intHolidays + 1;
				break
				}
			}
				
			dblAvgHoursPerDay = 0;
			  // Commented and Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
			//dblTotalWork = objEffort.value;
			dblTotalWork = objhidEffort.value;
			  //End of Commented and Added By Ankush Toraskar on 01-Mar-2019 Purpose::Whizible 2 Work field change
			
		
			//alert("dblTotalWork "+dblTotalWork);
		
		
			dblTotalDuration = DateDiff(dtCurrentStartDate,dtCurrentEndDate, "d") + 1;
		
			//Modified By VidyaJ on 3rd Feb 2004
			//For IssueID -15739
			//dblTotalDuration = dblTotalDuration - intHolidays;
			if(dblTotalDuration - intHolidays != 0)
			//{
			//confirm("<%=MyBase.GetResourceString("DAYS_ARE_HOLIDAYS")%>") //siddharths
			//return false;
			//}
			dblAvgHoursPerDay = dblTotalWork/dblTotalDuration; 
			else
				{
			//Remove the Comments after inserting the DatePart function.
			if(!confirm("<%=MyBase.GetResourceString("DAYS_ARE_HOLIDAYS")%>"))
				return false;			
			dblTotalDuration = DateDiff(dtCurrentStartDate,dtCurrentEndDate, "d") + 1;
			dblAvgHoursPerDay = dblTotalWork/dblTotalDuration;
				}
				
				if(strEmployeeID!="")
				{
				m_teammemberList = m_teammember.split(',');
				strEmployeeList=strEmployee.split(',');
				strLeaveFromDateList=strLeaveFromDate.split(',');
				strLeaveToDateList=strLeaveToDate.split(',');
				strEmployeeIDList=strEmployeeID.split(',');
				//alert(m_teammemberList.length-1);
				//alert(strEmployeeIDList.length-1);
				//alert(strLeaveFromDateList[0]);
				//for(intCount1=0; intCount1 < m_teammemberList.length-1; intCount1++){
						for(intCnt1=0; intCnt1 < strEmployeeIDList.length-1; intCnt1++){
						//alert("intCount "+intCount1+" intCnt "+intCnt1);
						//alert(m_teammemberList[intCount1]==strEmployeeIDList[intCnt1]);
						if(objcboResource[i].value==strEmployeeIDList[intCnt1]){
								//alert(strEmployeeList[intCnt1]+" "+intCnt1);
								//dtLeaveFromDateList = StringToDate(strLeaveFromDateList[intCnt1-1], "<%=m_strDateFormat%>");
								//dtLeaveToDateList = StringToDate(strLeaveToDateList[intCnt1-1], "<%=m_strDateFormat%>");
								//alert("strLeaveFromDateList "+strLeaveFromDateList[intCnt1]+" dtCurrentStartDate "+dtCurrentStartDate);
								//alert("strLeaveToDateList "+getDate(strLeaveToDateList[intCnt1]));
								//alert(" dtCurrentStartDate "+dtCurrentStartDate);
								//alert(DateDiff(dtCurrentStartDate, strLeaveFromDateList[intCnt1], "d"));
								//alert(DateDiff(dtCurrentStartDate, strLeaveToDateList[intCnt1], "d"));
								//alert(DateDiff(strLeaveToDateList[intCnt1],dtCurrentStartDate, "d"));
								//alert(strLeaveFromDateList[intCnt1]==dtCurrentStartDate);
								//return false;
								if(tempName!=strEmployeeList[intCnt1]){
								if((DateDiff(dtCurrentStartDate, strLeaveFromDateList[intCnt1], "d")>=0 && (DateDiff(strLeaveFromDateList[intCnt1],dtCurrentEndDate, "d")>=0))||(DateDiff(dtCurrentStartDate, strLeaveToDateList[intCnt1], "d")>=0 && (DateDiff(strLeaveToDateList[intCnt1],dtCurrentEndDate, "d")>=0))){
								tempName=strEmployeeList[intCnt1];
								if(!confirm("Resource '"+ strEmployeeList[intCnt1]+ "' have Leave between the Start Date and End Date.  ")){
								setFocus(objFromDate[i]);
								return false;
								}
								
								}
							}
						}
					}
				
				
			}
				
				
		}}}
			 //End Of Addition On 19 May 2005
			 
			return true;
		}
		
		
					function CheckDateFieldValidity(strDateString,m_strDateFormat)
			{
				var strDD, strMM, strYY;
				var intDD, intMM, intYY;

				var datePat = /^(\d{1,2})(\/|-)(\d{1,2})\2(\d{4})$/;
				
				var matchArray = strDateString.match(datePat); // is the format ok?

				if (matchArray == null) 
				{	
					alert("The Date entered is not in a valid format.");
					return false;
				}


				if (m_strDateFormat == "dd-mm-yyyy" )
				{
					intDD = matchArray[1];
					intMM = matchArray[3]; 
					intYY = matchArray[4];
				}
				else if (m_strDateFormat == "mm-dd-yyyy")
				{
					intMM = matchArray[1];
					intDD = matchArray[3]; 
					intYY = matchArray[4];
				}

				
				if (isNaN(intDD) || isNaN(intMM) || isNaN(intYY))
				{
					alert("Please enter number values for Day, Month and Year!!");
					isOK = false;
					return false;
				}

				if ( intDD < 1 || intMM < 1 || intYY < 1 )
				{
					alert("Month, Date and Year values should be positive and greater than 0!");
					isOK = false;
					return false;
				}

				if (intYY < 1753) 
				{
					alert("The year entered is out of range.");
					return false;
				}
				
				if (intMM < 1 || intMM > 12) 
				{ // check month range
					alert("Month must be between 1 and 12.");
					return false;
				}

				if (intDD < 1 || intDD > 31) 
				{
					alert("Day must be between 1 and 31.");
					return false;
				}
				
				if ((intMM==4 || intMM==6 || intMM==9 || intMM==11) && intDD==31) 
				{
				var MName;
				   if(intMM==4)
				     MName="April";
				     if(intMM==6)
				     MName="June";
				     if(intMM==9)
				     MName="September";
				     if(intMM==11)
				     MName="November";
					alert("Month "+MName+" doesn't have 31 days!");
					return false;
				}
				
				if (intMM == 2) 
				{ // check for february 29th
					var isleap = (intYY % 4 == 0 && (intYY % 100 != 0 || intYY % 400 == 0));
					
					if (intDD>29 || (intDD>28 && !isleap)) 
					{
						alert("February " + intYY + " doesn't have " + intDD + " days!");
						return false;
					}
				}
				return true;
			}	

			function StringToDate(strInDate, strDateFormat)
			{ 
				var dtRetDate;
				var strRepStr = /-/g;             //Create regular expression pattern for replacing "-" with "/"
				var strMonthname = new Array("January","February","March","April","May","June","July","August","September","October","November","December");
				var strDay = "";
				var strMonth = "";
				var strYear = "";
				var strLongDate = "";
				var intPosSep = 0;		// Position of separator i.e. "/"

				if (strInDate.indexOf("-") > 0)
					strInDate = strInDate.replace(strRepStr, "/");

				intPosSep = strInDate.indexOf("/");

				if (strDateFormat == "dd-mm-yyyy")
				{
					strDay = strInDate.substr(0, intPosSep);
					strInDate = strInDate.substr(intPosSep + 1, (strInDate.length - (intPosSep + 1)));

					intPosSep = strInDate.indexOf("/");
					strMonth = strInDate.substr(0, intPosSep);
					strInDate = strInDate.substr(intPosSep + 1, (strInDate.length - (intPosSep + 1)));
				}

				if (strDateFormat == "mm-dd-yyyy")
				{
					strMonth = strInDate.substr(0, intPosSep);
					strInDate = strInDate.substr(intPosSep + 1, (strInDate.length - (intPosSep + 1)));

					intPosSep = strInDate.indexOf("/");
					strDay = strInDate.substr(0, intPosSep);
					strInDate = strInDate.substr(intPosSep + 1, (strInDate.length - (intPosSep + 1)));
				}
				strYear = strInDate;

				strLongDate = strMonthname[parseFloat(strMonth) - 1] + " " + strDay + ", " + strYear;

				dtRetDate = new Date(strLongDate);
				return (dtRetDate);
			}


			function Mod(divisee, base)
			{
				return (divisee - (Math.floor(divisee/base)*base));
			}
			
			function Close_OnClick(){
			<%Session.Remove("strModuleNmaeNew")%>;
			window.close();
			}
			
	/************************ Added By VijayD 25 May 2009********************************
            Purpose: To validate Task assignment for baseline
     ************************ ***********************************************************/
		    var brw=isIE(); 
		    function ValidateTask_Baseline(url) 
			{ 		
			// TO SEE IF WE ARE RUNNING IN IE 
						strNavigator = navigator.appName;
						strNavigator = strNavigator.toUpperCase();
		        //if(strNavigator == 'MICROSOFT INTERNET EXPLORER')  Commented and added by Nilesh g on 10/12/2015
						if(brw=="IE")
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
								if(brw=="FF")//added by Nilesh g on 10/12/2015
								xmlDoc.load(g_objXHttp.responseXML);
								strResult=g_objXHttp.responseText;
						     }
							
						}
					return 	strResult;			
			} 
			
			function TaskValidation_state_change() 
			{			
				if (g_objXHttp.readyState == 4) 
				{
					
			   		// Make sure request came back OK 
					if (g_objXHttp.status == 200) 
					{
				 
					    //if (window.ActiveXObject)Commented and added by Nilesh g on 10/12/2015
					    if(brw=="IE")
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
							if(brw=="FF")//added by Nilesh g on 10/12/2015
							xmlDoc.load(g_objXHttp.responseXML);
						}
										
						//Save the Result in a Global variable
							strResult=g_objXHttp.responseText;		
							
				    }
				}
			}
		//************************End Addition By VijayD 25 May 2009**************************//	
		
		</SCRIPT>
    
   
    
    
		 </body>
</HTML>
