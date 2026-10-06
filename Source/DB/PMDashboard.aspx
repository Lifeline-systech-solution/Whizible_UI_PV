<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PMDashboard.aspx.vb" Inherits="PbNIT.PMDashboard" %>

<!DOCTYPE HTML>
<HTML>
	<%PlotHead()%>
    <%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
<!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
    <!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
    <script src="../../responsive/responsive.js"></script>
<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added by Yogesh J on 10/12/2015 issue id=2726*/
    #DivOtherInfo {
        height:260px !important;
    }
   
     /*End of addition  by Yogesh J on 10/12/2015 issue id=2726*/
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

	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="Graph" method="post" runat="server">
			<%DrawPage()%>
		</form>
		<script language="javascript">
		
	    <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
	function ShowBiggerView(intNumber)
	{
		var strGraph;
		if (intNumber == 2)  strGraph = "TaskDistribution";
		window.open ("DeveloperDB_Graphs.aspx?FromWhereDB=PMDB&Mode=" + strGraph,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=800,height=450");
	}

	//function BugDisplay(intProjectID,intBugID)			
	function BugDisplay(intProjectID,intBugID,strPKToken)			
	{      //Modified by SavitaS on 22 Sept 2006 for Security IssueID 6197			
			//window.open ("../../Source/IB/IB_IssueEntry.aspx?ProjectID=" + intProjectID + "&FromWhere=DB&IssueID=" + intBugID, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");			
			window.open ("../../Source/IB/IB_IssueEntry.aspx?ProjectID=" + intProjectID + "&FromWhere=DB&IssueID=" + intBugID + "&PKToken="+ strPKToken +"&OrderBy=IssueID", "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");			
		//End of Modified by SavitaS on 22 Sept 2006 for Security IssueID 6197			
	}
	
	function DisplayETCDetails(intProjectID)
	{
		//alert("This functionality is yet to be implemented!");
		window.open ("../PM/PM_ETCApproval.aspx?FromWhere=DB&MasterTagId=417&ProjectID=" + intProjectID ,"ETC","scrollbars=no,resizable=yes,width=750,height=525,left=10,top=10");
	}
	function DisplayProjectDetails(intProjectID)
	{
		window.open ("../DB/DB_ProjectDashboard.aspx?ProjectID=" + intProjectID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600" );
	}

	function ProgressReport_OnClick()
	{
		window.open ("../../Reports/ManagementReports.aspx?Type=U&MasterTagID=<%=m_intProgressRpt%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500"); 
	}
	
	function MilestoneReport_OnClick(intAnalysisID)
	{
		window.open ("../CRW/CRW_ReportUIBuilder.aspx?ReportID=<%=CommonFunctions.Application.MilestoneAnalysisReportID%>&UniqueID=" + intAnalysisID, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
	}
	
	function WeeklyView_OnClick()
	{
		window.open ("../PM/PM_DailyActivityMatrix.aspx?ShowClose=1","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=750,height=500");
	}
	
	function MyGoals()
	{
		window.open ("../../Source/HR/GoalSettings.asp?FromWhere=DB&MasterTagId=422",null,"resizable=yes,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=750,height=300");
	}

	function ToDoList_OnClick()
	{
		window.open ("../../Source/CRW/CRW_ReportUIBuilder.aspx?MasterTagID=570&ReportID=326","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
	}
	
	function SetProjectFilter(blnProjectFilter)			
	{	
		var strHREF;
		var objform = GetFormReference('Graph');
		var objSortVal = GetObjectReference('Graph','chkSort');

		//strHREF = "PMDashboard.aspx?ProjectFilter=" + blnProjectFilter;
		if (objSortVal.checked == true)
			{
				strHREF = "PMDashboard.aspx?ProjectFilter=" + blnProjectFilter + "&SortFlag=1";
			}
		else
			{
				strHREF = "PMDashboard.aspx?ProjectFilter=" + blnProjectFilter + "&SortFlag=0";
			}		
		window.location.href = strHREF+"&DashboardID=<%=m_strDashboardID%>";
		
	}
	function TaskTypeTimesheet_OnClick(intTaskID)			
	{
	    //Added By VarunA on 2-Sep-2008 
        //Purpose : To disable task for the project is on hold
	    var objProjectOnHold = GetObjectReference('Graph','txtProjectOnHold'+intTaskID);
	    // Added By MahendraV on 21-Nov-2008 for Whiziblesem8_whiz3
    // Purpose : IssueID(23679)   -Similarly on PM Dashboard/Developer Dashboard when Opened a Task Entry in edit mode the Wrong Task get displayed
    // Start_MV_21-Nov-2008
            var objProjectTimesheetBlocked = GetObjectReference('Graph','txtProjectTimesheetBlocked'+intTaskID);
	         if (objProjectTimesheetBlocked != null )
	        {
	                if(objProjectTimesheetBlocked.value=="True"){
	                alert("For this project ,timesheet is blocked so you can't fill Daily Activity against it.");
	                return;
	        }}
    // End_MV_21-Nov-2008
    
	    if (objProjectOnHold != null )
	    {
	    if(objProjectOnHold.value=="True"){
	    alert("This Project is 'On Hold' so you can't fill Daily Activity against it.");
	    return;
	    }}
	    //End By VarunA on 2-Sep-2008 
	    
	    
	    // added By purvaj on 18 Dec 2008 for whiziblesem 8.0regression issue fixes
        var objtxtOnHold = GetObjectReference('Graph','txtOnHold'+intTaskID);
		if (objtxtOnHold != null )
		{
		if(objtxtOnHold.value=="true"){
		alert("This Task is On Hold");
		return;
		}}
	//End addition purvaj
	
	
		window.open ("../PM/PM_TaskTypeTimesheet.aspx?FromWhere=PMDashboard&TaskID=" + intTaskID,"", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");		
	}
		
	function OpenPage()
	{
		window.open ("../General/Help.aspx?HelpID=PDB","","resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250");
	}
	
	function Project_OnClick(intProjectID)
	{
		window.open ("../general/CommonPage.aspx?ProjectID=" + intProjectID + "&FromWhere=DB&MasterTagID=<%=CommonFunctions.Constants.PM_PROJECT_LISTING%>&ShowClose=1","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
	}
	
	function ShowProjectReport_OnClick(intProjectID)
	{
		window.open ("../CRW/CRW_ReportUIBuilder.aspx?ReportID=746&UniqueID=" + intProjectID, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
	}
			
	
	function MissingTaskEntry_OnClick(strDate)
	{
		//window.open ("../PM/PM_DailyActivity.aspx?txtDate=" + strDate,null,"resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=800,height=400");
		window.open("../PM/PM_DailyActivity.aspx?txtDate=" + strDate, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=950,height=400");

	}

	function BTSBugList(iProjectId,intType)
	{
		//alert("This functionality is yet to be implemented!");
		window.open ("../IB/IB_IssueAgeingAnalysis.aspx?ProjectID=" + iProjectId + "&DaysDiff=" + intType,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 250)/2 + ",width=650,height=250");
	}
	
	function Sort_OnClick(strFieldName,strAscOrDesc)
	{
		var strHREF;
		var objform = GetFormReference('Graph');
		var objSortVal = GetObjectReference('Graph','chkSort');
		//---------------------------------------------------------------------------------------------------------------
		//Code Added by JyotiG. On 1st Aug 2006. 
		//Purpose : ----- WhizibleSEM SP7
		//Issue ID: 5342
		if (objSortVal.checked == true)
			{
				window.location.href = "PMDashboard.aspx?Field=" + strFieldName + "&Order=" + strAscOrDesc + "&List=<%=m_intListNumber%>&SortFlag=1&DashboardID=<%=m_strDashboardID%>";
			}
		else
			{
				window.location.href = "PMDashboard.aspx?Field=" + strFieldName + "&Order=" + strAscOrDesc + "&List=<%=m_intListNumber%>&SortFlag=0&DashboardID=<%=m_strDashboardID%>";
			}		
		//window.location.href = "PMDashboard.aspx?Field=" + strFieldName + "&Order=" + strAscOrDesc + "&List=<%=m_intListNumber%>";
	}
	//---------------------------------------------------------------------------------------------------------------
    //Code Added by JyotiG. On 1st Aug 2006. 
    //Purpose : ----- WhizibleSEM SP7
    //Issue ID: 5342
	function ApplySort()
	{	var strHREF;
		var objform = GetFormReference('Graph');
		var objSortVal = GetObjectReference('Graph','chkSort');
	
	
			if (objSortVal.checked == true)
			{
				strHREF = "PMDashboard.aspx?SortFlag=1&DashboardID=<%=m_strDashboardID%>";
				objSortVal.checked = true;
			}			
			else
			{		
				strHREF = "PMDashboard.aspx?SortFlag=0&DashboardID=<%=m_strDashboardID%>";
				objSortVal.checked = false;
			}
	    //Added by Tejal D date 12/10/2016 to set setFrameLoader
	    setFrameLoader();
	    //End of Addtion by tejal Deshmukh date 12/10/2016 to set setFrameLoader
			objform.action = strHREF;
			objform.submit();
	}		
	//   End of addition by JyotiG
   //---------------------------------------------------------------------------------------------

	
	function HideDiv(strDivName, strLabelName)
	{		
		var objDiv;
		var objLabel;
		objDiv = GetObjectReference('Graph',strDivName);
		objLabel = GetObjectReference('Graph',strLabelName);
		
		objDiv.style.visibility = "hidden";
		objDiv.style.display = "none";
		objLabel.style.color = "#000000";		
	}
	//integrated by harshada d on 21 DEC 2005 for issue id 898

<%		'Modified BY NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11864 %>
<%       'ContextName is not to be passed in query string, instead will be fetched from database %>
<%       ' to avoid javscript errors because of Special characters '"#$%<> 		%>
//---------------------------------------------------------------------------------------------------------------
//Code Added by MonikaI. On 1st Aug 2006. For WhizibleSEM SP7
//Issue ID: 5342
//Purpose : To open a popup window to maintain the tracking details.

	function Flag_OnClick(intProjectID,intTaskID)
	{
	    window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=" + intProjectID + "&ContextID=" + intTaskID + "&ContextType=Task&FromWhich=PMDashboard&ContextName="  ,"_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
	}

	function Flag_Issue_OnClick(intProjectID,intIssueID)
	{
			window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=" + intProjectID + "&ContextID=" + intIssueID + "&ContextType=Issue&FromWhich=PMDashboard&ContextName=" ,"_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
	}

	function Flag_Review_OnClick(intProjectID,intReviewStatisticsID)
	{
			window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=" + intProjectID + "&ContextID=" + intReviewStatisticsID + "&ContextType=Review&FromWhich=PMDashboard&ContextName=" ,"_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
	}
    //Commented And Added By Usha Pandit On 15.07.2020 for getting/setting Token
	//function Flag_MileStone_OnClick(intProjectID,intMileStoneID)
	//{
	//		window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=" + intProjectID + "&ContextID=" + intMileStoneID + "&ContextType=MileStone&FromWhich=PMDashboard&ContextName=","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
	//}
    function Flag_MileStone_OnClick(intProjectID,intMileStoneID, strPKToken)
	{
			window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=" + intProjectID + "&PKToken=" + strPKToken + "&ContextID=" + intMileStoneID + "&ContextType=MileStone&FromWhich=PMDashboard&ContextName=","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
            }
            //End Of Added By Usha Pandit On 15.07.2020 for getting/setting Token
	function Flag_Risk_OnClick(intProjectID,intRiskID)
	{
			window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=" + intProjectID + "&ContextID=" + intRiskID + "&ContextType=Risk&FromWhich=PMDashboard&ContextName=","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
	}

	function Flag_Deliverable_OnClick(intProjectID,intScheduleID)
	{
			window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=" + intProjectID + "&ContextID=" + intScheduleID + "&ContextType=Deliverable&FromWhich=PMDashboard&ContextName=" ,"_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
	}

//End of addition by MonikaI
//---------------------------------------------------------------------------------------------------------------

<%'End Modification BY NitinVS on 20 Mar 2007 for WhizibleSEM SP 8 Regression ISsue 11864		%>
		
		/*Added by ManishK on 15th Nov 2005 for Developer Dashboard Functionality*/
	function DocumentLink_OnClick(intProjectID,intUniqueID,intTaskID,btApplyEffortDistribution,btHaveSubTaskTypes)
	{
	    //COMMENTED AND ADDED BY nILESH G ON 2/2/2016 FOR url SECURITY iSSUE
			//if(btApplyEffortDistribution=='False' && btHaveSubTaskTypes=='False')
			//{
			//	window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&UniqueID=" + intTaskID + "&TagID=1038&DocumentType=Assign","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
			//}else
			//{
			//	window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&UniqueID=" + intUniqueID + "&TagID=1038&DocumentType=Assign","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	    //}
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'PMDashboard.aspx/GenrateURLToken',
	        data: JSON.stringify({ intProjectID: intProjectID,EmployeeID: "<%=Session("intUserID")%>" }),
	        success: function (Result) {
	           if(btApplyEffortDistribution=='False' && btHaveSubTaskTypes=='False')
	            {
	                window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&PKToken=" + Result.d +"&UniqueID=" + intTaskID + "&TagID=1038&DocumentType=Assign","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	            }else
	            {
	                window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID +"&PKToken=" + Result.d + "&UniqueID=" + intUniqueID + "&TagID=1038&DocumentType=Assign","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	            }
	        },
	        error: function () {
	            //  alert("Error")
	        }
         });	
	}
	
	
	function DocumentLink_Review_OnClick(intProjectID,intUniqueID,strIssueIds)
	{
		
			//if(strIssueIds != '')
			//{
			//		window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&UniqueID=" + intUniqueID + "&TagID=2191&DocumentType=Review","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
			//}else
			//{
			//		window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&UniqueID=" + intUniqueID + "&TagID=1026&DocumentType=Review","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	    //}	
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'PMDashboard.aspx/GenrateURLToken',
	        data: JSON.stringify({ intProjectID: intProjectID,EmployeeID: "<%=Session("intUserID")%>" }),
	        success: function (Result) {
	            if(strIssueIds != '')
	            {
			
	                window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID +"&PKToken=" + Result.d + "&UniqueID=" + intUniqueID + "&TagID=2191&DocumentType=Review","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	            }else
	            {
			
	                window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID +"&PKToken=" + Result.d + "&UniqueID=" + intUniqueID + "&TagID=1026&DocumentType=Review","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	            }	
	        },
	        error: function () {
	             alert("Error")
	        }
         });	
	}
	
	function DocumentLink_Milestone_OnClick(intProjectID,intUniqueID)
	{
			//window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&UniqueID=" + intUniqueID + "&TagID=34&DocumentType=","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'PMDashboard.aspx/GenrateURLToken',
	        data: JSON.stringify({ intProjectID: intProjectID,EmployeeID: "<%=Session("intUserID")%>" }),
	        success: function (Result) {
	            window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID +"&PKToken=" + Result.d +"&UniqueID=" + intUniqueID + "&TagID=34&DocumentType=","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	        },
	        error: function () {
	              alert("Error")
	        }
	     });	
	}

	
	function DocumentLink_Issue_OnClick(intProjectID,intIssueID)
	{
        //window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID + "&IssueID=" + intIssueID + "&TagID=0&DocumentType=Issue","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'PMDashboard.aspx/GenrateURLToken',
	        data: JSON.stringify({ intProjectID: intProjectID,EmployeeID: "<%=Session("intUserID")%>" }),
	        success: function (Result) {
	            window.open ("../DB/DocumentType.aspx?ProjectID=" + intProjectID +"&PKToken=" + Result.d + "&IssueID=" + intIssueID + "&TagID=0&DocumentType=Issue","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	        },
	        error: function () {
	              alert("Error")
	        }
	 });	
	}
	
	function DocumentLink_Deliverable_OnClick(intScheduleID)
	{
			
		window.open ("../DB/DocumentType.aspx?ScheduleID=" + intScheduleID + "&TagID=0&DocumentType=Deliverable","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	}

	/*End of addition by ManishK on 15th Nov 2005 for Developer Dashboard Functionality*/
	
	
		//integrated by harshada d on 21 DEC 2005 for issue id 898
	
	function ShowDiv(strDivName, strLabelName)
	{
	
		//Modified by MrugajaB for WhizibleSEM SP7 Issue ID.4245 on 13th June 2006
        //Changing color of tab links
		//var strSelectedColor = "#000000";
		var strSelectedColor = "#FFFFFF";
		//End Modification
		
		var objDiv;
		var objLabel;
		objDiv = GetObjectReference('Graph',strDivName);
		objLabel = GetObjectReference('Graph',strLabelName);
		
		if (objDiv.style.visibility == "hidden")
		{
			objDiv.style.visibility = "visible";
			objDiv.style.display = "block";			
			objLabel.style.color = strSelectedColor;
		}
		else
		{
			objDiv.style.visibility = "hidden";
			objDiv.style.display = "none";					
			//objLabel.style.color = "#FFFFFF";
		}				
	
	}

	function Assignments_clicked(intNumber)		
	{	
		var objSection = GetObjectReference('Graph','objTDCell');
		
		var strHREF;
		var objform = GetFormReference('Graph');
		var objSortVal = GetObjectReference('Graph','chkSort');

		if(intNumber != '<%=m_intListNumber%>')
		{
			//window.location.href = "PMDashboard.aspx?List=" + intNumber;
			if (objSortVal.checked == true)
			{
				window.location.href = "PMDashboard.aspx?List=" + intNumber + "&SortFlag=" + 1+"&DashboardID=<%=m_strDashboardID%>";
			}
			else
			{
				window.location.href = "PMDashboard.aspx?List=" + intNumber + "&SortFlag=" + 0+"&DashboardID=<%=m_strDashboardID%>";
			}
		}
		else 
		{
			if(intNumber == 1)
			{	
				ShowDiv("Task", "lblAssignedTasks");
				//objSection.innerHTML= "<%=MyBase.GetResourceString("TAB_TO_DO")%>";
			}		    		    
			else if(intNumber == 2)
			{			
				ShowDiv("Bug", "lblIssues");
				//objSection.innerHTML= "<%=m_strIssueName%>";
			}			    		    
	   		else if(intNumber == 3)
	   		{		   		
	   			ShowDiv("CRM", "lblCustomerQuery");
				//objSection.innerHTML= "<%=MyBase.GetResourceString("TAB_SUPPORT")%>";
			}	       	       
			else if(intNumber == 4)
	   		{				   		
	   			ShowDiv("MyProject", "lblMyProjects");
				//objSection.innerHTML= "<%=MyBase.GetResourceString("TAB_PROJECTS")%>";
			}										
			else if(intNumber == 5)
	   		{				   		
	   			ShowDiv("tblETC", "lblETC");
				//objSection.innerHTML= "<%=MyBase.GetResourceString("TAB_PROJECTS")%>";
			}				
			else if(intNumber == 6)
	   		{				   		
	   			ShowDiv("tblMilestones", "lblMilestones");
				//objSection.innerHTML= "<%=MyBase.GetResourceString("TAB_PROJECTS")%>";
			}				
			else if(intNumber == 7)
	   		{				   		
	   			ShowDiv("tblRisks", "lblRisks");
				//objSection.innerHTML= "<%=MyBase.GetResourceString("TAB_PROJECTS")%>";
			}				
			else if(intNumber == 8)
	   		{				   		
	   			ShowDiv("tblReview", "lblReview");		
				//objSection.innerHTML= "<%=MyBase.GetResourceString("TAB_REVIEWS")%>";
			}										
			/* WhizibleE SP2
			' Added By NitinVS on 5 March 2005 
			' To Add Deliverable Reporting on Dashboard.
			*/
			
			else if(intNumber == 9)
	   		{				   		
	   			ShowDiv("tblDeliverables", "lblDeliverables");		
				//objSection.innerHTML= "<%=MyBase.GetResourceString("TAB_REVIEWS")%>";
			}	
			/*' End Addition By NitinVS on 5 MArch 2005 
			' WhizibleE SP2 */									
		}
		
	}	
		
	var objdivlist = GetObjectReference('Graph','divList');
	var objdivContainer = GetObjectReference('Graph','divContainer');
	var objtblBottom = GetObjectReference('Graph','tblBottom');
	var intDivHeight
	function window_onload() 
	{	
	    /*Commented Added by Yogesh J on 10/12/2015 issue id=2726*/
	  
	    if(objdivContainer)
	    {
	        if(isIE()=="FF")
	        {
	            intDivHeight = window.innerHeight - objdivContainer.offsetTop - 30;
	        }
	        else{
	            intDivHeight = window.innerHeight - objdivContainer.offsetTop - 30;
	        }
	        if (intDivHeight < 100) 
	            intDivHeight = 100;	// Let the minimum height of the div tag be 100
	        objdivContainer.style.height = intDivHeight + "px";

	        Assignments_clicked(<%=m_intListNumber%>);
	    }
            /*End of addition by Yogesh J on 10/12/2015*/
	    else
	    {
	        var intDivHeight = document.body.offsetHeight - objdivContainer.offsetTop - 30;
	        if (intDivHeight < 100) 
	            intDivHeight = 100;	// Let the minimum height of the div tag be 100
	        objdivContainer.style.height = intDivHeight + "px";

	        Assignments_clicked(<%=m_intListNumber%>);
	    }
	
	}
	
	function window_onresize()		
	{
		//var intDivHeight; 
	    //intDivHeight = document.body.offsetHeight - objdivContainer.offsetTop - 30;
	    /*Commented Added by Yogesh J on 10/12/2015 issue id=2726*/
	    if(objdivContainer)
	    {
	        if(isIE()=="FF")
	        {
	            intDivHeight = window.innerHeight - objdivContainer.offsetTop - 30;
	        }
	        else{
	            intDivHeight = window.innerHeight - objdivContainer.offsetTop - 30;
	        }
	        if (intDivHeight < 100) intDivHeight = 100;	// Let the minimum height of the div tag be 100
	        objdivContainer.style.height = intDivHeight + "px"
	    }
	        /*End of addition by Yogesh J on 10/12/2015*/
	    else
	    {
	        intDivHeight = document.body.offsetHeight - objdivContainer.offsetTop - 30;
	        if (intDivHeight < 100) intDivHeight = 100;	// Let the minimum height of the div tag be 100
	        objdivContainer.style.height = intDivHeight + "px"
	    }
	}					
		</script>
		</TD></TR></TD></TR></TD></TR></TD></TR>
		<script language="javascript">

	var objcboDashboard;
	objcboDashboard = GetObjectReference('Graph','cboDashboard');
	
	function cboDashboard_OnChange()
	// For selecting the user's e-DB 
	{
		var strPageName;
		var arr;
		
		strPageName = objcboDashboard.value;
	
		if (trimString(strPageName + "") != "") 
		{
			arr = strPageName.split("|");
			/*
			Modified By		:	HiteshS on 27th Jan.2005
			IssueID			:	15626
			Description		:	After splitting for "|", before setting the href
								check for any existing querystring and if exists
								then append to that only.
			*/
			if (isSubstringExists(arr[0],'?'))
			{
				window.location.href = "" + arr[0] + "&DashboardID=" + arr[1];
			}
			else
			{
				window.location.href = "" + arr[0] + "?DashboardID=" + arr[1];
			}
			//window.location.href = arr[0] + "?DashboardID=" + arr[1];
			/*
			End of Modification by HiteshS on 27th Jan.2005
			*/
		}
		else
		{
			window.location.href = "../CDB/CDB_DashboardDetail.aspx?MODE=NEW&FromPage=<%=m_strDB_PageName%>&DashboardID=0"; 	
		}

	}
	
	function FilterTaskList(intTodoListFilter)			
	// 
	{		
			var strHREF = "PMDashboard.aspx?List=1&TodoListFilter=" + intTodoListFilter;
			var objoptDateRange = GetObjectReference('Graph','optDateRange');
			var objtxtFromDate = GetObjectReference('Graph','txtFromDate');
			var objtxtToDate = GetObjectReference('Graph','txtToDate');
			//---------------------------------------------------------------------------------------------------------------
			//Code Added by JyotiG. On 1st Aug 2006. 
			//Purpose : ----- WhizibleSEM SP7
			//Issue ID: 5342
			
			var strHREF;
			var objform = GetFormReference('Graph');
			var objSortVal = GetObjectReference('Graph','chkSort');

			// If the Date Range option is selected, then perform the required validations.
			if (objoptDateRange.checked)
			{
				// Pass the From Date in the QueryString.
				if (trimString(objtxtFromDate.value) != "") 
				{
					strHREF = strHREF + "&FromDate=" + objtxtFromDate.value;
				}
				
				// Pass the To Date in the QueryString.
				if (trimString(objtxtToDate.value) != "") 
				{
					strHREF = strHREF + "&ToDate=" + objtxtToDate.value;
				}

				// Check if at least one of the dates is selected for the Date Range.
				if ( (trimString(objtxtFromDate.value) == "") && (trimString(objtxtToDate.value) == "") ) 
				{
					alert("Please enter the date range !!");
					return;
				}
				
				// If both the dates are selected, then verify that the From Date is not greater than the To Date.
				
				if (disallowDate1GreaterThanDate2(objtxtFromDate,objtxtToDate)) 
				{	
					//Commented and modified by MonikaI on 4th Oct 2006 IssueID : 6563
					//alert("Please enter 'To Date' greater than 'From Date'");
					alert("<%=MyBase.GetResourceString("MSG_DATEGREATER")%>");
					//End by MonikaI
					return;
				
				}
				
			}
			//---------------------------------------------------------------------------------------------------------------
			//Code Added by JyotiG. On 1st Aug 2006. 
			//Purpose : ----- WhizibleSEM SP7
			//Issue ID: 5342
			if (objSortVal.checked == true)
			{
				strHREF = strHREF + "&SortFlag="+1;
			}
			else
			{
				strHREF = strHREF + "&SortFlag="+0;
			}
			//End of addition by JyotiG
			//---------------------------------------------------------------------------------------------------------------


			// Submit the form.			
			window.location.href = strHREF+"&DashboardID=<%=m_strDashboardID%>";
	}


	function optDateRange_OnClick()					
	{
		var objcellDateRange = GetObjectReference('Graph','cellDateRange');
		objcellDateRange.style.display = "";	
	}	
	
	 //Modified by MrugajaB on 19th Sept 2006 for Whiziblesem Issue ID.6197
     //Purpose:Added additional parameter 'Token'
	function TaskLink_OnClick(intProjectID,intTaskID,m_strToken)
	{
	//Added by VivekP On 6 May 2005 For issue ID 18389
	var objtxtOnHold = GetObjectReference('Graph','txtOnHold'+intTaskID);
	//Added By VarunA on 2-Sep-2008 
    //Purpose : To disable task for the project is on hold
	var objProjectOnHold = GetObjectReference('Graph','txtProjectOnHold'+intTaskID);
	//End By VarunA on 2-Sep-2008 

	var objProjectTimesheetBlocked = GetObjectReference('Graph','txtProjectTimesheetBlocked'+intTaskID);
		//alert(objProjectTimesheetBlocked);
	if (objtxtOnHold != null )
	{
	if(objtxtOnHold.value=="true"){
	alert("This Task is On Hold");
	return;
	}}
	//Added By VarunA on 2-Sep-2008 
    //Purpose : To disable task for the project is on hold
	if (objProjectOnHold != null )
	{
	if(objProjectOnHold.value=="True"){
	alert("This Project is 'On Hold' so you can't fill Daily Activity against it.");
	return;
	}}
	// Added By MahendraV on 21-Nov-2008 for Whiziblesem8_whiz3
    // Purpose : IssueID(23679)   -Similarly on PM Dashboard/Developer Dashboard when Opened a Task Entry in edit mode the Wrong Task get displayed
    // Start_MV_21-Nov-2008
    if (objProjectTimesheetBlocked != null )
	{
	        if(objProjectTimesheetBlocked.value=="True"){
	        alert("For this project ,timesheet is blocked so you can't fill Daily Activity against it.");
	        return;
	}}
    // End_MV_21-Nov-2008
            
	//End By VarunA on 2-Sep-2008 
	//End Of Adddition  by VivekP On 6 May 2005 For issue ID 18389
	
		/*Modified by PrachiK for issue id 17109 on 24 Mar 2005.
		var blnHold=<%=m_TaskOnHold%>;
		
		if (blnHold==true)
			{
			alert('This Task is On Hold');
			}
			Modification ended.*/
			
		
		//window.open ("../PM/PM_DailyActivity.aspx?WhatToShow=Entry&ShowClose=1&FromWhere=PMDashboard&ProjectID=" + intProjectID + "&TaskID=" + intTaskID,"", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 720)/2 & ",top=" + (window.screen.height - 420)/2 + ",width=720,height=420");
		window.open("../PM/PM_DailyActivity.aspx?WhatToShow=Entry&ShowClose=1&FromWhere=PMDashboard&ProjectID=" + intProjectID + "&TaskID=" + intTaskID + "&PkToken=" + m_strToken, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 750)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=750,height=400");
		
		//End Modification by MrugajaB
			
	}	
	
	function ExpandCollapse_OnClick(group,IsExpanded)
	{
		var ColumnType;
		
		var strHREF;
		var objform = GetFormReference('Graph');
		var objSortVal = GetObjectReference('Graph','chkSort');
		//---------------------------------------------------------------------------------------------------------------
		//Code Added by JyotiG. On 1st Aug 2006. 
		//Purpose : ----- WhizibleSEM SP7
		//Issue ID: 5342
		if (group == "Current") ColumnType = "C";
		if (group == "Actual") ColumnType = "A";
		if (group == "Baseline") ColumnType = "B";
		if (objSortVal.checked == true)
		{
			window.location.href = "PMDashboard.aspx?ColumnType=" + ColumnType + "&Show=" + IsExpanded + "&List=<%=m_intListNumber%>&SortFlag=1&DashboardID=<%=m_strDashboardID%>";
		}
		else
		{
			window.location.href = "PMDashboard.aspx?ColumnType=" + ColumnType + "&Show=" + IsExpanded + "&List=<%=m_intListNumber%>&SortFlag=0&DashboardID=<%=m_strDashboardID%>";
		}
		//window.location.href = "PMDashboard.aspx?ColumnType=" + ColumnType + "&Show=" + IsExpanded + "&List=<%=m_intListNumber%>";
	}

			/* WhizibleE SP2
			' Added By NitinVS on 5 March 2005 
			' To Add Deliverable Reporting on Dashboard.
			*/
	function DisplayDeliverableReport(DeliverableID)
	{
		window.open ("../CRW/CRW_ReportUIBuilder.aspx?ReportID=1895&UniqueID=" + DeliverableID, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");		
	}
			/*' End Addition By NitinVS on 5 MArch 2005 
			' WhizibleE SP2 */									

		</script>
	</body>
</HTML>
