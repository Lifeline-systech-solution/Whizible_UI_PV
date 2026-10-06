<%@ Page Language='vb' AutoEventWireup='false' Codebehind='CustomerDashBoard.aspx.vb' Inherits='PbNIT.CustomerDashBoard'%>
<HTML>
     <head>
        <link href="../General/StyleSheetChanakyaDash.css" rel="stylesheet" />

    </head>
<%-- DELETED BY AMIT MAHADIK ON 10 MAY 2011 WHIZIBLESEM 10.0 TO ADD THEMES--%>
<%--<% CommonFunctions.General.PlotPageHeadTag("Customer DashBoard", "../General/StyleSheetChanakyaDash.css")%>--%>
<%-- END DELETED BY AMIT MAHADIK ON 10 MAY 2011 WHIZIBLESEM 10.0 TO ADD THEMES--%>

<%-- ADDED BY AMIT MAHADIK ON 10 MAY 2011 WHIZIBLESEM 10.0 TO ADD THEMES--%>
<% CommonFunctions.General.PlotPageHeadTag("Customer DashBoard")%>
<%-- END ADDED BY AMIT MAHADIK ON 10 MAY 2011 WHIZIBLESEM 10.0 TO ADD THEMES--%>
    <%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
    <!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
   /*Added by Dhanashri S on 9 Dec 2015 for IssueID:2437*/
    .clsGridTable td 
    {
        font-family: "Helvetica" !important;
        padding: 5px !important;
        border-right: 0px solid #d6d5d7;
    }
    /*End of Addition by Dhanashri S on 9 Dec 2015*/
    /*Added By Vidya J ON 18-12-2015*/
    #rapper
    {
        width:auto !important;
    }
      /*End Of Added By Vidya J ON 18-12-2015*/
</style>

<script type="text/javascript">
    $(document).ready(function () {
        //$('.clsGridTable td').css('padding', '0px !important');

        //$('.clsGridTable td').removeClass('clsGridTable');

    });
    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Web Form Extension Type
    //    // Description:Remove section header row in Tablet and Mobile view
    //    // By Whom: Miiint
    //    // When:23/01/2015
    //    /*---------------------------------------------------------*/
    //    if ($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
    //        removeSectionHeader();
    //    }
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
    //    /*---------------------------------------------------------*/
    //    if ($('.clsgridtable').length > 0) {
    //        var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
    //        dataCollapse(divName);
    //    }
    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Top Table Inner Menu on document Ready
    //    // By Whom: Miiint
    //    // When:14/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveTopMenu();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    //    // By Whom: Miiint
    //    // When:14/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveFooterMenu();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Sub Table Inner Menu on document Ready
    //    // By Whom: Miiint
    //    // When:14/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveSubTableTopMenu();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Sub Table Inner Menu on document Ready
    //    // By Whom: Miiint
    //    // When:14/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveSubTableFooterMenu();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Remove footer
    //    // Description:Display none footer in Tablet and Mobile view
    //    // By Whom: Miiint
    //    // When:16/01/2015
    //    /*---------------------------------------------------------*/
    //    /* Display none footer in Tablet and Mobile view*/

    //    var windowWidth = $(window).width();
    //    if (windowWidth < 992) {

    //    }
    //    else {

    //    }
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Remove footer
    //    /*---------------------------------------------------------*/

    //    $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Responsive Navigation Tabs
    //    // Description:Display navigation tabs in dropdown
    //    // By Whom: Miiint
    //    // When:07/02/2015
    //    /*---------------------------------------------------------*/
    //    $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
    //    $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
    //    var responsiveNavigationClass = 'responsiveNavigationTabsClass';
    //    var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
    //    if (windowWidth < 992) {
    //        responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
    //    }
    //    else {
    //        $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
    //    }

    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Responsive Navigation Tabs
    //    /*---------------------------------------------------------*/

    //    $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
    //    $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
    //    // Description:removing plus sign with footable functionality for 'Total' column
    //    // By Whom: Miiint
    //    // When:27/04/2015
    //    /*---------------------------------------------------------*/

    //    if (windowWidth < 1040) {
    //        var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
    //        if (text == "Total") {
    //            $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
    //            $('#tblGrid1053121').find('tr:last').css('display', 'none');
    //        }
    //    }

    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
    //    /*---------------------------------------------------------*/
    //});

    //$(window).resize(function () {
    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Top Table Inner Menu on Window Resize
    //    // By Whom: Miiint
    //    // When:14/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveTopMenuResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    //    // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
    //    // By Whom: Miiint
    //    // When:10/02/2015
    //    /*---------------------------------------------------------*/
    //    responsiveFooterMenuResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-InnerMenuDropDown
    //    // Description:Creating DropDown for Sub Table Inner Menu on Window Resize
    //    // By Whom: Miiint
    //    // When:14/01/2015
    //    /*---------------------------------------------------------*/
    //    responsiveSubTableTopMenuResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-InnerMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-FooterMenuDropDown
    //    // Description:Creating DropDown for Sub Table Footer Menu on Window Resize
    //    // By Whom: Miiint
    //    // When:28/05/2015
    //    /*---------------------------------------------------------*/
    //    responsiveSubTableFooterMenuResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-FooterMenuDropDown
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Remove footer
    //    // Description:Display none footer in Tablet and Mobile view
    //    // By Whom: Miiint
    //    // When:16/01/2015
    //    /*---------------------------------------------------------*/
    //    /* Display none footer in Tablet and Mobile view*/

    //    var windowWidth = $(window).width();
    //    if (windowWidth < 992) {

    //    }
    //    else {

    //    }
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Remove footer
    //    /*---------------------------------------------------------*/
    //    $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-Responsive Navigation Tabs
    //    // Description:Display navigation tabs in dropdown
    //    // By Whom: Miiint
    //    // When:07/02/2015
    //    /*---------------------------------------------------------*/
    //    responsiveNavigationTabsResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-Responsive Navigation Tabs
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-collapse & close for tablet view
    //    // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
    //    // By Whom: Miiint
    //    // When:17/02/2015
    //    /*---------------------------------------------------------*/
    //    collapseDivsResize();
    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-collapse & close for tablet view
    //    /*---------------------------------------------------------*/

    //    /*----------------------------------------------------------*/
    //    // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
    //    // Description:removing plus sign with footable functionality for 'Total' column
    //    // By Whom: Miiint
    //    // When:27/04/2015
    //    /*---------------------------------------------------------*/

    //    if (windowWidth < 1040) {
    //        var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
    //        if (text == "Total") {
    //            $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
    //            $('#tblGrid1053121').find('tr:last').css('display', 'none');
    //        }
    //    }

    //    /*---------------------------------------------------------*/
    //    // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
    //    /*---------------------------------------------------------*/

    //});

</script>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout"  onload="window_onload()" >
		<form id="frmBrickRedCustomerDB" method="post" runat="server" title="Dashboard">
			<% DrawPage()%>
     	</form>
     </body>

    <script language="JavaScript">
    
  
        <%' Added By Shamkant S on 8 Dec Jan 2015 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
        <%End If%>
		    <%' Ended By Shamkant S on 8 Dec Jan 2015 %>
    function Dashboards_OnClick(intDashboardID)
	{
			window.open ("../CDB/CDB_Dashboard_CommonList.aspx?MasterTagID=1871&ParentTagID=0&DashboardID=" + intDashboardID + "&FromLink=", "_Dashboards","resizable=no,scrollbars=no,left=" + ((window.screen.width - 800)/2) + ",top=" + ((window.screen.height - 622)/2) + ",width=800,height=622"); //WAF3_PB_42 April 17, 2007 NinadP
	}
	
		function ShowSummary_ProjectSTab(TabName,intProjectID,intTabNo)//BringData
	{
	    //Added by Amit Mahadik on 11 May 2011, WHIZIBLE SEM 10.0
	    if (TabName=="Summary")
	    {   
	        document.getElementById("cboProjectList").selectedIndex = 0
	    }
	    var x_selectedIndex=document.getElementById("cboProjectList").selectedIndex;
        var y_options=document.getElementById("cboProjectList").options;  
	    intProjectID=y_options[x_selectedIndex].value;

	    var strProjectName=y_options[x_selectedIndex].text;
	    	    if(intProjectID==-1)
	        {
	            strProjectName = "Summary";
	        }
	       //Added by NitinC on 26 April for WhizibleSEM 11.0 [Issue Fix : 61578]
	       if(x_selectedIndex==0)
	       {
	            TabName = "Summary"
	       }
	       //End of Added by NitinC on 26 April for WhizibleSEM 11.0 [Issue Fix : 61578]
	    //Added by Amit Mahadik on 11 May 2011, WHIZIBLE SEM 10.0
		window.location.href = "../CustomerDashBoard/CustomerDashBoard.aspx?DashboardID=15001&DashboardID=15001&TabName="+TabName+"&ProjectID="+intProjectID+"&intTabNo="+intTabNo+"&strProjectName="+strProjectName;
	}
	
		function ShowHide_SubTabs(idtoshow,idtoHide)//Deliverables_MileStones
	{
 	    document.getElementById(idtoHide).style.display = 'none';
		document.getElementById(idtoshow).style.display = 'block';
	}
	
 
	function cboDashboard_OnChange()
	{
	var PageName;
	var arr = new Array();
    var _objcboDashboard;
	 _objcboDashboard = GetObjectReference('frmCDBMain','cboDashboard');
	 PageName = _objcboDashboard.value;
  	 if (trimString(_objcboDashboard.value) != "") 
	  {
		arr = PageName.split("|");
		if (isSubstringExists(arr[0],'?'))
		{
	  	  window.location.href = "" + arr[0] + "&DashboardID=" + arr[1];
		}
		else
		 {
		  window.location.href = "" + arr[0] + "?DashboardID=" + arr[1];
		 }
		}
		else
		{
	      window.location.href = "../CDB/CDB_DashboardDetail.aspx?FromWhere=BrickRed&MODE=NEW&FromPage=../CustomerDashBoard/CustomerDashBoard.aspx?DashboardID=15001"; 	
	      // window.location.href = "../CDB/CDB_DashboardDetail.aspx?FromWhere=&MODE=NEW&FromPage=../CDB/CDB_Main.aspx?DashboardID=101&DashboardID=101&sortby=&sortorder=&ShowNeedleGraphs=" + ShowNeedleGraphs + "&ShowOtherGraphs=" + ShowOtherGraphs + "&ShowMyQueries=" + ShowMyQueries + "&ShowDescriptiveAlert=" + ShowDescriptiveAlert; 	
		}
	}
	

 	</script>
 	
 	<Script Language=javascript>
	   //Added By VijayD oN 28 July 2008
	 	function OnClickDeliverables(TabName,intProjectID,strCriteria,strMilestoneCriteria)
		{
		   //var objSummaryTaskStatus = GetObjectReference('frmBrickRedCustomerDB','cboSummaryTaskStatus');	
		   window.location.href = "../CustomerDashBoard/CustomerDashBoard.aspx?DashboardID=15001&div_Deliverables=block&div_Milestones=none&TabName="+TabName+"&ProjectID="+intProjectID+"&SummaryDeliverables="+ strCriteria +"&SummaryMilestones="+strMilestoneCriteria;  //SummaryTaskStatus="+ objSummaryTaskStatus.value+"&
		} 
		
		function OnClickMilestones(TabName,intProjectID,strCriteria,strDeliverablesCriteria)
		{
		  //var objSummaryTaskStatus = GetObjectReference('frmBrickRedCustomerDB','cboSummaryTaskStatus');	
		  window.location.href = "../CustomerDashBoard/CustomerDashBoard.aspx?DashboardID=15001&div_Milestones=block&div_Deliverables=none&TabName="+TabName+"&ProjectID="+intProjectID+"&SummaryMilestones="+ strCriteria +"&SummaryDeliverables="+strDeliverablesCriteria; //SummaryTaskStatus="+ objSummaryTaskStatus.value+"&
		} 
		//End Addition By VijayD oN 28 July 2008
		
		
		function OnSummaryTaskStatusChange(TabName,intProjectID,strCriteria,strIssueNextLastToday)
		{
		
			var objSummaryTaskStatus = GetObjectReference('frmBrickRedCustomerDB','cboSummaryTaskStatus');	
			var objWeekDate = GetObjectReference('frmBrickRedCustomerDB','txthidWeekDateTask');			
			
			window.location.href = "../CustomerDashBoard/CustomerDashBoard.aspx?DashboardID=15001&SummaryTaskStatus="+ objSummaryTaskStatus.value+"&TabName="+TabName+"&ProjectID="+intProjectID+"&WeekDateTask="+objWeekDate.value +"&SummaryTaskCriteria="+strCriteria+"&TaskNextLastToday="+strIssueNextLastToday;
		} 
	
		function OnSummaryIssueStatusTypeChange(TabName,intProjectID,strCriteria,strIssueNextLastToday)
		{
		    //debugger;
     		var objSummaryIssueType = GetObjectReference('frmBrickRedCustomerDB','cboSummaryIssueType');
			var objSummaryIssueStatus = GetObjectReference('frmBrickRedCustomerDB','cboSummaryIssueStatus');
			var objWeekDate = GetObjectReference('frmBrickRedCustomerDB','txthidWeekDate');	
			
			//var objtxthidIssueDate = GetObjectReference('frmBrickRedCustomerDB','txthidIssueDate');
			window.location.href = "../CustomerDashBoard/CustomerDashBoard.aspx?DashboardID=15001&SummaryIssueStatus="+ objSummaryIssueStatus.value+"&SummaryIssueType="+objSummaryIssueType.value+" &TabName="+TabName+"&ProjectID="+intProjectID+"&WeekDate="+objWeekDate.value +"&SummaryIssueCriteria="+strCriteria+"&IssueNextLastToday="+strIssueNextLastToday;
		} 

		function OnProjectTaskStatusChange(TabName,intProjectID,objDivName)
		{
		
			var objdiv_ProjectTask,objdiv_ProjectIssues;
			var objSummaryIssueType = GetObjectReference('frmBrickRedCustomerDB','cboSummaryIssueType');
			var objSummaryIssueStatus = GetObjectReference('frmBrickRedCustomerDB','cboSummaryIssueStatus');		
			var objProjectTaskStatus = GetObjectReference('frmBrickRedCustomerDB','cboProjectTaskStatus');	
		   if(objDivName=='div_ProjectTask')
			{
				objdiv_ProjectTask='block';
				objdiv_ProjectIssues='none';
			}
			else
			{
				objdiv_ProjectTask='none';
				objdiv_ProjectIssues='block';
			}
			window.location.href = "../CustomerDashBoard/CustomerDashBoard.aspx?DashboardID=15001&ProjectTaskStatus="+ objProjectTaskStatus.value+"&TabName="+TabName+"&ProjectID="+intProjectID+"&div_ProjectIssues="+objdiv_ProjectIssues+"&div_ProjectTask="+objdiv_ProjectTask+"&intTabNo=<%=m_strTabCount%>";
		} 
		function OnProjectIsssueStatusChange(TabName,intProjectID,objDivName)
		{
			var objdiv_ProjectTask,objdiv_ProjectIssues;
			var objSummaryIssueType = GetObjectReference('frmBrickRedCustomerDB','cboSummaryIssueType');
			var objSummaryIssueStatus = GetObjectReference('frmBrickRedCustomerDB','cboSummaryIssueStatus');	
			var objProjectIssueStatus = GetObjectReference('frmBrickRedCustomerDB','cboProjectIssueStatus');	
			if(objDivName=='div_ProjectTask')
			{
				objdiv_ProjectTask='block';
				objdiv_ProjectIssues='none';
			}
			else
			{
				objdiv_ProjectTask='none';
				objdiv_ProjectIssues='block';
			}
			window.location.href = "../CustomerDashBoard/CustomerDashBoard.aspx?DashboardID=15001&ProjectIssueStatus="+ objProjectIssueStatus.value+"&TabName="+TabName+"&ProjectID="+intProjectID+"&div_ProjectIssues="+objdiv_ProjectIssues+"&div_ProjectTask="+objdiv_ProjectTask+"&intTabNo=<%=m_strTabCount%>";
		} 
		
		function OnTimeSheetStatusChange(TabName,intProjectID,objDivName)
		{
			var objTimeSheetResult = GetObjectReference('frmBrickRedCustomerDB','cboTimeSheetResult');
			var objTimeSheetStatus = GetObjectReference('frmBrickRedCustomerDB','cboTimeSheetStatus');	
 			var objWeeklyStatus = GetObjectReference('frmBrickRedCustomerDB','cboWeeklyStatus');
 			window.location.href = "../CustomerDashBoard/CustomerDashBoard.aspx?DashboardID=15001&TimeSheet_Status="+objTimeSheetStatus.value+"&TimeSheet_Result="+objTimeSheetResult.value+"&TabName="+TabName+"&ProjectID="+intProjectID+"&WeeklyStatus="+objWeeklyStatus.value+"&intTabNo=<%=m_strTabCount%>";
		}
		
		function OnDrawNotificationCount_Click()
		{
		  window.open("../CustomerDashBoard/CustomerDashBoard.aspx?Mode_Notification=True","", "resizable=no,scrollbars=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=600,height=300");
		}

		function OnSummaryTimesheetNo_Click(strTimeSheetNo,strTimesheetStatus)
		{
		 window.open("../CustomerDashBoard/CustomerDashBoard.aspx?Mode_TimeSheetDetail=True&TimeSheetNo="+strTimeSheetNo+"&TimesheetStatus="+strTimesheetStatus,"", "scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=750,height=500");//resizable=no,
		}

		function OnWSRTimesheetNo_Click(TimeSheetNo)
		{
		 window.open("../CustomerDashBoard/CustomerDashBoard.aspx?Mode_WSRTimeSheetDetail=True&TimeSheetNo="+TimeSheetNo,"", "scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=750,height=520");//resizable=no,
		}				
	   function OnProjectTeamDetailChange(TabName,intProjectID)  
		{
			var objProjectTeamDetail = GetObjectReference('frmBrickRedCustomerDB','cboProjectTeamDetail');	
			window.location.href = "../CustomerDashBoard/CustomerDashBoard.aspx?DashboardID=15001&ProjectTeamDetail="+ objProjectTeamDetail.value+"&TabName="+TabName+"&ProjectID="+intProjectID+"&intTabNo=<%=m_strTabCount%>";
		}
		
//TimeSheet Listing Accept and Reject TimeSheet		
		var objform=GetFormReference('frmBrickRedCustomerDB');
		
		function AuthenticateDetailPage_OnClick(strTimeSheetNo)
		{
		  window.open("../CustomerDashBoard/CustomerDashBoard.aspx?FromDetail=FromDetail&Mode=ApproveOrReject&ToApprove=ToApprove&MasterTagId=0&TimesheetNo_PK="+strTimeSheetNo+"&PKToken=<%=m_PKToken_Edit%>","","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 350)/2 + ",height=300,width=850");
		}
		
		function Reject_OnClick(strTimeSheetNo)
		{
		window.open("../CustomerDashBoard/CustomerDashBoard.aspx?FromDetail=FromDetail&Mode=ApproveOrReject&ToReject=ToReject&MasterTagId=0&TimesheetNo_PK="+strTimeSheetNo+"&PKToken=<%=m_PKToken_Edit%>","","scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 350)/2 + ",height=300,width=850");
		}
		function View_Comment_OnClick(strTimeSheetNo)
		{
		window.open ("../General/CommonPage.aspx?ViewComment=ViewComment&TimesheetNo_PK="+strTimeSheetNo+"&TimesheetNo="+strTimeSheetNo+"&MasterTagID=3061&FromWhere=FA&FromCL=1", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,resizable=no,scrollbars=no,left=320,top=250,height=250,width=430");
		}

		function FinalReject_OnClick(strTimeSheetNo)
		{
			objComment = GetObjectReference('frmBrickRedCustomerDB','Comment'+strTimeSheetNo);
			if(objComment.value=="")
			{
			alert('Please add comment for rejection.');
			setFocus(objComment);
			return;
			}
			<%' Modified by NitinVS on 28 Apr 2007 for WhizibleSEM SP 8 Regression Fixes Added validation for maxlength %>
			if(disallowMaxlengthViolation(objComment,475,"The maximum length of the 'Comments' field is 475 characters",true))	return ;
			<%' End Modified by NitinVS on 28 Apr 2007 for WhizibleSEM SP 8 Regression Fixes Added validation for maxlength %>

			objform.action="../CustomerDashBoard/CustomerDashBoard.aspx?Action=RejectTimesheet&TimesheetNo_PK="+strTimeSheetNo+"&Mode_ApproveReject=Reject&MasterTagId=15001";//&TimesheetList="+strTimeSheetList+"
			objform.submit();
		}
		
		function FinalAuthenticate_OnClick(strTimeSheetNo)
		{
			objComment = GetObjectReference('frmBrickRedCustomerDB','Comment'+strTimeSheetNo);
			if(objComment.value=="")
			{
			alert('Comment can\'t be left blank.');
			setFocus(objComment);
			return;
			}
			<%' Modified by NitinVS on 28 Apr 2007 for WhizibleSEM SP 8 Regression Fixes Added validation for maxlength %>
			if(disallowMaxlengthViolation(objComment,500,"The maximum length of the 'Comments' field is 500 characters",true))	return ;
			<%' End Modified by NitinVS on 28 Apr 2007 for WhizibleSEM SP 8 Regression Fixes Added validation for maxlength %>
		
			objform.action="../CustomerDashBoard/CustomerDashBoard.aspx?FinalApproved=FinalApproved&TimesheetNo_PK="+strTimeSheetNo+"&Mode_ApproveReject=Approve&MasterTagId=15001&Action=FinalAuthenticate";//&TimesheetList="+strTimeSheetList+"
			objform.submit();
		}


//TimeSheet Listing Accept and Reject TimeSheet		
	
 		function window_onload()		
		{  
			var objDiv_111 = GetObjectReference('frmBrickRedCustomerDB','tab_111');
			var objDiv_CompletionStatus = GetObjectReference('frmBrickRedCustomerDB','tab_CompletionStatus');
			var objDiv_ScheduleVariance = GetObjectReference('frmBrickRedCustomerDB','tab_ScheduleVariance');
			
			var objdiv_ProjectTask = GetObjectReference('frmBrickRedCustomerDB','div_ProjectTask');
			var objdiv_ProjectIssues = GetObjectReference('frmBrickRedCustomerDB','div_ProjectIssues');
		
			var objdiv_Deliverables = GetObjectReference('frmBrickRedCustomerDB','div_Deliverables');
			var objdiv_MileStones = GetObjectReference('frmBrickRedCustomerDB','div_MileStones'); 
			
			var objDiv_TimeSheetDetails = GetObjectReference('frmBrickRedCustomerDB','Div_TimeSheetDetails');
			var objDiv_WeeklyStatusDetails = GetObjectReference('frmBrickRedCustomerDB','Div_WeeklyStatusDetails'); 
			var objDiv_TeamDetailPage = GetObjectReference('frmBrickRedCustomerDB','Div_TeamDetailPage'); 
			
			var objDiv_DIVLIST = GetObjectReference('frmBrickRedCustomerDB','DIVLIST');
			
			//Added by NitinC
			//debugger;
			var objDivMain = GetObjectReference('frmBrickRedCustomerDB','rapper');
					
		    var intDivHeight ;
			var intDivHeightRisk;
			var intScriptNo;
	
			document.body.style.visibility='visible';
	        //Added by NitinC on 10 April 2012 For WhizibleSEM 11.0 [Issue Fix : 61578]
	        if(objDivMain != null)
	        {
			    intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 20;
			    if (intDivHeight < 100)
			    intDivHeight = 100;
			
		        if(navigator.appName == 'Netscape')
	            {		  
			        intDivHeight =window.innerHeight  - objDivMain.offsetTop - 40 ;
	            }
	            else
	            {
			        intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 20;
	            }

			    objDivMain.style.height = intDivHeight+'px'	;
    			
			    intMaxEntry = 24;
			}
            //End of Added by NitinC on 10 April 2012 For WhizibleSEM 11.0 [Issue Fix : 61578]
			//End Addition
			
//////////DELETED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0, and added in CSS

////			if (objDiv_DIVLIST!=null )//For Accept or Reject Timesheet
////			{
////				objDiv_DIVLIST.style.scrollbarBaseColor="#c1d3fb";
////				objDiv_DIVLIST.style.scrollbarDarkShadowColor="#c1d3fb";
////				objDiv_DIVLIST.style.scrollbarDarkShadowColor="#c1d3fb";
////				objDiv_DIVLIST.style.scrollbarShadowColor="#c1d3fb";
////				objDiv_DIVLIST.style.scrollbarFaceColor="#c1d3fb";
////	     	}
////	     				
////			if (objDiv_TimeSheetDetails!=null )
////			{
////				objDiv_TimeSheetDetails.style.scrollbarBaseColor="#c1d3fb";
////				objDiv_TimeSheetDetails.style.scrollbarDarkShadowColor="#c1d3fb";
////				objDiv_TimeSheetDetails.style.scrollbarDarkShadowColor="#c1d3fb";
////				objDiv_TimeSheetDetails.style.scrollbarShadowColor="#c1d3fb";
////				objDiv_TimeSheetDetails.style.scrollbarFaceColor="#c1d3fb";
////	     	}
////			if (objDiv_WeeklyStatusDetails!=null )
////			{
////				objDiv_WeeklyStatusDetails.style.scrollbarBaseColor="#c1d3fb";
////				objDiv_WeeklyStatusDetails.style.scrollbarDarkShadowColor="#c1d3fb";
////				objDiv_WeeklyStatusDetails.style.scrollbarDarkShadowColor="#c1d3fb";
////				objDiv_WeeklyStatusDetails.style.scrollbarShadowColor="#c1d3fb";
////				objDiv_WeeklyStatusDetails.style.scrollbarFaceColor="#c1d3fb";
////	     	}
////			if (objDiv_TeamDetailPage!=null )
////			{
////				objDiv_TeamDetailPage.style.scrollbarBaseColor="#c1d3fb";
////				objDiv_TeamDetailPage.style.scrollbarDarkShadowColor="#c1d3fb";
////				objDiv_TeamDetailPage.style.scrollbarDarkShadowColor="#c1d3fb";
////				objDiv_TeamDetailPage.style.scrollbarShadowColor="#c1d3fb";
////				objDiv_TeamDetailPage.style.scrollbarFaceColor="#c1d3fb";
////	     	}	     		     		
////	 
////			if (objdiv_Deliverables!=null )
////			{
////				objdiv_Deliverables.style.scrollbarBaseColor="#c1d3fb";
////				objdiv_Deliverables.style.scrollbarDarkShadowColor="#c1d3fb";
////				objdiv_Deliverables.style.scrollbarDarkShadowColor="#c1d3fb";
////				objdiv_Deliverables.style.scrollbarShadowColor="#c1d3fb";
////				objdiv_Deliverables.style.scrollbarFaceColor="#c1d3fb";
////	     	}

////			if (objdiv_MileStones!=null )
////			{
////				objdiv_MileStones.style.scrollbarBaseColor="#c1d3fb";
////				objdiv_MileStones.style.scrollbarDarkShadowColor="#c1d3fb";
////				objdiv_MileStones.style.scrollbarDarkShadowColor="#c1d3fb";
////				objdiv_MileStones.style.scrollbarShadowColor="#c1d3fb";
////				objdiv_MileStones.style.scrollbarFaceColor="#c1d3fb";
////	     	}
////	     			
////			if (objdiv_ProjectTask!=null )
////			{
////				objdiv_ProjectTask.style.scrollbarBaseColor="#c1d3fb";
////				objdiv_ProjectTask.style.scrollbarDarkShadowColor="#c1d3fb";
////				objdiv_ProjectTask.style.scrollbarDarkShadowColor="#c1d3fb";
////				objdiv_ProjectTask.style.scrollbarShadowColor="#c1d3fb";
////				objdiv_ProjectTask.style.scrollbarFaceColor="#c1d3fb";
////	     	}
////			
////			if (objdiv_ProjectIssues!=null )
////			{
////				objdiv_ProjectIssues.style.scrollbarBaseColor="#d7daf4";
////				objdiv_ProjectIssues.style.scrollbarDarkShadowColor="#d7daf4";
////				objdiv_ProjectIssues.style.scrollbarDarkShadowColor="#d7daf4";
////				objdiv_ProjectIssues.style.scrollbarShadowColor="#d7daf4";
////				objdiv_ProjectIssues.style.scrollbarFaceColor="#d7daf4";
////	     	}
////						
////			if (objDiv_111!=null )
////			{
////				objDiv_111.style.scrollbarBaseColor="White";
////				objDiv_111.style.scrollbarDarkShadowColor="white";//#e7f1fe
////				objDiv_111.style.scrollbarDarkShadowColor="white";
////				objDiv_111.style.scrollbarShadowColor="White"; 
////				objDiv_111.style.scrollbarFaceColor="White";
////     			objDiv_111.scrollLeft = 110*(<%=m_strTabCount%>-5); 
////	     	}
////	     	if( objDiv_CompletionStatus!=null && objDiv_ScheduleVariance!=null)
////	     	 {	
////				objDiv_CompletionStatus.style.scrollbarBaseColor="#c1d3fb";
////				objDiv_CompletionStatus.style.scrollbarDarkShadowColor="#c1d3fb";
////				objDiv_CompletionStatus.style.scrollbarDarkShadowColor="#c1d3fb";
////				objDiv_CompletionStatus.style.scrollbarShadowColor="#c1d3fb"; 
////				objDiv_CompletionStatus.style.scrollbarFaceColor="#c1d3fb";
////				
////				objDiv_ScheduleVariance.style.scrollbarBaseColor="#c1d3fb";
////				objDiv_ScheduleVariance.style.scrollbarDarkShadowColor="#c1d3fb";
////				objDiv_ScheduleVariance.style.scrollbarDarkShadowColor="#c1d3fb";
////				objDiv_ScheduleVariance.style.scrollbarShadowColor="#c1d3fb"; 
////				objDiv_ScheduleVariance.style.scrollbarFaceColor="#c1d3fb";			     		
////			}

//////////END DELETED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0, and added in CSS

		}
		
		
</Script>


</HTML>



