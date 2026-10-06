<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ReleaseResource.aspx.vb" Inherits="PbNIT.PM_ReleaseResource" %>
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
		<form id="frmPM_ReleaseResource" method="post" runat="server">
			<%PageInit%>
		</form>
		<SCRIPT language="javascript">
		var objform=GetFormReference('frmPM_ReleaseResource');
		var objdivlist=GetObjectReference('frmPM_ReleaseResource','PageDiv');
		var objdivlist1=GetObjectReference('frmPM_ReleaseResource','DivList');
		var strTaskIDs='';
		var dtStartDate, dtEndDate , dtMozillaStartDate; 
		// Task Completion Grid	
		
			//var IRApprover;
			//var InvoiceGenerator;
		
		var TaskCompletionFlag=<%=m_FilterTaskcompletionDivStatus.toString.toLower%>;
		var objFilterTaskCompletionDivStatus= GetObjectReference('frmPM_TaskUpdation','hidTaskCompletionFilterDivStatus');
		//var FlagForRetainingValue;
		var objTaskCompletionDIV= GetObjectReference('frmPM_TaskStatusManagement','TaskCompletion');
		var objTaskCompletionimg= GetObjectReference('frmPM_TaskStatusManagement','imgTaskCompletionShowHide');
		
        <%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>

		function TaskCompletion_div()
		{//debugger;
		   
		   if (TaskCompletionFlag==true)
		   {
				objTaskCompletionDIV.style.display='none';
				objTaskCompletionimg.src='../../Images/plus.gif';
				TaskCompletionFlag=false;
				objFilterTaskCompletionDivStatus.value = "Close";
				return;
			}
			if(TaskCompletionFlag==false)
			{
				objTaskCompletionDIV.style.display='';
				objTaskCompletionimg.src='../../Images/minus.gif';
				TaskCompletionFlag=true;
				objFilterTaskCompletionDivStatus.value = "Open";
				return;
			}
		}
			
		// Task Void Grid
		var TaskVoidFlag=<%=m_FilterTaskVoidDivStatus.toString.toLower%>;
		var objFilterTaskVoidDivStatus= GetObjectReference('frmPM_TaskUpdation','m_FilterTaskVoidDivStatus');
		//var FlagForRetainingValue;
		var objTaskVoidDIV= GetObjectReference('frmPM_TaskStatusManagement','TaskVoid');
		var objTaskVoidimg= GetObjectReference('frmPM_TaskStatusManagement','imgTaskVoidShowHide');
		function TaskVoid_div()
		{//debugger;
		   
		   if (TaskVoidFlag==true)
		   {
				objTaskVoidDIV.style.display='none';
				objTaskVoidimg.src='../../Images/plus.gif';
				TaskVoidFlag=false;
				objFilterTaskVoidDivStatus.value = "Close";
				return;
			}
			if(TaskVoidFlag==false)
			{
				objTaskVoidDIV.style.display='';
				objTaskVoidimg.src='../../Images/minus.gif';
				TaskVoidFlag=true;
				objFilterTaskVoidDivStatus.value = "Open";
				return;
			}
		}
		
		//Added by Bharat Tekade
			// Task MPP Task Grid
		var MPPTaskFlag=<%=m_MPPTaskDivStatus.toString.toLower%>;
		var objFilterMPPTaskDivStatus= GetObjectReference('frmPM_TaskUpdation','hidMPPTaaskDivStatus');
		//var FlagForRetainingValue;
		var objMPPTaskDIV= GetObjectReference('frmPM_TaskStatusManagement','MPPTask');
		var objMPPTaskimg= GetObjectReference('frmPM_TaskStatusManagement','imgMPPTaskShowHide');
		function MPPTaskDetails_div()
		{//debugger;
		   
		   if (MPPTaskFlag==true)
		   {
				objMPPTaskDIV.style.display='none';
				objMPPTaskimg.src='../../Images/plus.gif';
				MPPTaskFlag=false;
				objFilterMPPTaskDivStatus.value = "Close";
				return;
			}
			if(MPPTaskFlag==false)
			{
				objMPPTaskDIV.style.display='';
				objMPPTaskimg.src='../../Images/minus.gif';
				MPPTaskFlag=true;
				objFilterMPPTaskDivStatus.value = "Open";
				return;
			}
		}
		
		//Ended by Bharat Tekade
		
		
		
		
		// Approver Grid
		
		// Task Void Grid
		var ApproverFlag=<%=m_FilterApproverDivStatus.toString.toLower%>;
		var objFilterApproverDivStatus= GetObjectReference('frmPM_TaskUpdation','hidApproverFilterDivStatus');
		//var FlagForRetainingValue;
		var objApproverDIV= GetObjectReference('frmPM_TaskStatusManagement','Approver');
		var objApproverimg= GetObjectReference('frmPM_TaskStatusManagement','imgApproverShowHide');
		function Approver_div()
		{//debugger;
		   
		   if (ApproverFlag==true)
		   {
				objApproverDIV.style.display='none';
				objApproverimg.src='../../Images/plus.gif';
				ApproverFlag=false;
		       //objFilterApproverDivStatus.value = "Close";
               //Commented added By Shamkant S on 5 Jan 2016
				if(objFilterApproverDivStatus !=null)
				{
				    objFilterApproverDivStatus.value = "Close";
				}
		       //Commented ended  By Shamkant S on 5 Jan 2016
				return;
			}
			if(ApproverFlag==false)
			{
				objApproverDIV.style.display='';
				objApproverimg.src='../../Images/minus.gif';
				ApproverFlag=true;
			    //objFilterApproverDivStatus.value = "Open";
			    //Commented added By Shamkant S on 5 Jan 2016
				if(objFilterApproverDivStatus !=null)
				{
				    objFilterApproverDivStatus.value = "Open";
				}
			    //Commented ended  By Shamkant S on 5 Jan 2016
				return;
			}
		}
	 //Added by TruptiK 
          //Purpose:-to reject pending extend request before releasing resource
		var RequestFlag=<%=m_filterrequestDivStatus.toString.toLower%>;
		var objFilterRequestDivStatus= GetObjectReference('frmPM_ReleaseResource','hidRequestFilterDivStatus');
		//var FlagForRetainingValue;
		var objRequestDIV= GetObjectReference('frmPM_ReleaseResource','Request');
		var objRequestimg= GetObjectReference('frmPM_ReleaseResource','imgRequestShowHide');
		
		function Request_div()
		{
		   
		   if (RequestFlag==true)
		   {
				objRequestDIV.style.display='none';
				objRequestimg.src='../../Images/plus.gif';
				RequestFlag=false;
				if(objFilterRequestDivStatus !=null)
				{
				    objFilterRequestDivStatus.value = "Close";
				
				}
				return;
			}
			if(RequestFlag==false)
			{
				objRequestDIV.style.display='';
				objRequestimg.src='../../Images/minus.gif';
				RequestFlag=true;
				if(objFilterRequestDivStatus !=null)
				{
				    objFilterRequestDivStatus.value = "Open";
				}
				return;
			}
		}
		//END by TruptiK
		
			// Skills Grid
		var SkillsFlag=<%=m_FilterSkillsDivStatus.toString.toLower%>;
		var objFilterSkillsDivStatus= GetObjectReference('frmPM_TaskUpdation','hidSkillsFilterDivStatus');
		//var FlagForRetainingValue;
		var objSkillsDIV= GetObjectReference('frmPM_TaskStatusManagement','Skills');
		var objSkillsimg= GetObjectReference('frmPM_TaskStatusManagement','imgSkillsShowHide');
		function Skills_div()
		{//debugger;
		   
		   if (SkillsFlag==true)
		   {
				objSkillsDIV.style.display='none';
				objSkillsimg.src='../../Images/plus.gif';
				SkillsFlag=false;
				objFilterSkillsDivStatus.value = "Close";
				return;
			}
			if(SkillsFlag==false)
			{
				objSkillsDIV.style.display='';
				objSkillsimg.src='../../Images/minus.gif';
				SkillsFlag=true;
				objFilterSkillsDivStatus.value = "Open";
				return;
			}
		}
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			
			var intDivHeight ;
			var intDivListPageHeight ;
			var intDivHeightRisk;
			var lc;
			if (objdivlist != null) {
		if(navigator.appName == 'Netscape')
		    {
		  
				intDivHeight = window.innerHeight  - objdivlist.offsetTop - 37 ;
		    }
		    else
		    {
		    intDivHeight = window.innerHeight - objdivlist.offsetTop - 37;
		    }
			if (intDivHeight < 100)
			    intDivHeight = 100;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';}
			if (objdivlist != null) {
			intDivListPageHeight = intDivHeight + 'px' ;
			}
			strTaskIDs = '';
			
		}
		
		function window_onresize()		
		{
			
			var intDivHeight ;
			var intDivHeightRisk;
			var intDivListPageHeight ;
			if (objdivlist != null) {
			
		if(navigator.appName == 'Netscape')
		    {
		  
				intDivHeight = window.innerHeight  - objdivlist.offsetTop - 37 ;
		    }
		    else
		    {
		      intDivHeight = window.innerHeight - objdivlist.offsetTop - 37;
		    }
			if (intDivHeight < 100)
				intDivHeight = 100;
					
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';}
			if (objdivlist != null) {
			intDivListPageHeight = intDivHeight - 5 + 'px' ;
			}
		}
		
		function Save_OnClick()
		{
		    var objEmployeeforworkflow = GetObjectReference('frmPM_ReleaseResource','cboEmployeeforworkflow');
		
		    if (objEmployeeforworkflow!=null && objEmployeeforworkflow.value =='')
		    {
		        alert('Please select the approver to transter workflow approval responsibilities.');
		        return;
		    } 

			objform.action = "PM_ReleaseResource.aspx?FromWhere=PM&MasterTagId=<%=m_lngTagId%>&Mode=Save&UniqueID=<%=m_lngUniqueID%>"
			objform.submit()
		}	
		
	 function SelectAll_OnClick()
		{		  	  	
		objTaskComplete = GetObjectReference('frmPM_ReleaseResource', 'chkTaskcomplete', 1);
		for(intCnt = 0;intCnt<objTaskComplete.length;intCnt++)
		{
			
			objTaskComplete[intCnt].checked = true 
		}
		objTaskComplete = GetObjectReference('frmPM_ReleaseResource', 'chkTaskvoid', 1);
		for(intCnt = 0;intCnt<objTaskComplete.length;intCnt++)
		{
			
			objTaskComplete[intCnt].checked = true 
		}
	//Added by TruptiK on 17-Apr-09
		 objRequest = GetObjectReference('frmPM_ReleaseResource', 'chkRequest', 1);
		for(intCnt = 0;intCnt<objRequest.length;intCnt++)
		{
			
			objRequest[intCnt].checked = true 
		}
		//end of addition by TruptiK on 17-Apr-09
	     } 
		function ClearAll_OnClick()
		{		  	  	
   		 objTaskComplete = GetObjectReference('frmPM_ReleaseResource', 'chkTaskcomplete', 1);
		for(intCnt = 0;intCnt<objTaskComplete.length;intCnt++)
		{
			
			objTaskComplete[intCnt].checked = false 
		}
		 objTaskComplete = GetObjectReference('frmPM_ReleaseResource', 'chkTaskvoid', 1);
		for(intCnt = 0;intCnt<objTaskComplete.length;intCnt++)
		{
			
			objTaskComplete[intCnt].checked = false 
		}
	//Added by TruptiK on 17-Apr-09
		 objRequest = GetObjectReference('frmPM_ReleaseResource', 'chkRequest', 1);
		for(intCnt = 0;intCnt<objRequest.length;intCnt++)
		{
			
			objRequest[intCnt].checked = false 
		}
		//end of addition by TruptiK on 17-Apr-09
	    } 
	     function Close_OnClick()
	     {
	     //window.opener.location=window.opener.location;
	     window.close();
	     }
					
		</SCRIPT>
	</body>
</HTML>
