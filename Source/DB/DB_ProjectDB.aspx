<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DB_ProjectDB.aspx.vb" Inherits="PbNIT.DB_ProjectDB"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_TITLE"))%>
 <!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
  
<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if ($('.clsgridtable').length > 0) {
            var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
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

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass = 'responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
        if (windowWidth < 992) {
            responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
        }
        else {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
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

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
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

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

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

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
									<%PageInit%>
								
					<Script language="javascript">
		var objform=GetFormReference('frmProjectDB');
		var objdivlist=GetObjectReference('frmProjectDB','PageDiv');
		
		<%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;//Added by Shamkant s on 22 Dec 2015
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015;	
        }
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 45;//Added by Shamkant s on 22 Dec 2015
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015;	
        }
		}
		
		function ShowRelease_OnClick(intReleaseID)
		{
			window.open("../PM/PM_ReleaseNote.aspx?FromWhere=DB&ReleaseID=" + intReleaseID.toString(),"A","resizable=yes,scrollbars=no,width=650,height=450");
		}
				
		function WSR_OnClick(intTimesheetNo)
		{
			window.open("../PM/PM_WeeklyStatusReport.aspx?TimeSheetNo=" + intTimesheetNo.toString(),null,"resizable=no,scrollbars=yes,menubar=yes,toolbar=yes,width=750,height=500,Left=10,top=10");
		}


		//Modified By VivekP On 11 August 2005 For PMLifeline IssueID-87
		function ShowTimesheet_OnClick(intTimesheetNo, strFromDate, strToDate,strTimesheetStatus ,strToken)
		{
			var strQueryString="";
			
			strQueryString = strQueryString  + "Mode=Details";
			strQueryString = strQueryString  + "&TimeSheetNo=" + intTimesheetNo.toString();
			<%' Modified bY NitinVS on 28 Apr 2007 for PMLifeline Regression Fixes added server.urlEncodefor ProjectName %>			
			strQueryString = strQueryString  + "&ProjectName=<%=server.URLEncode(m_strProjectName)%>";
			<% ' End Modification bY NitinVS on 28 Apr 2007 for PMLifeline Regression Fixes %>
			strQueryString = strQueryString  + "&FromDate=" + strFromDate;
			strQueryString = strQueryString  + "&ToDate=" + strToDate;
			strQueryString = strQueryString  + "&TimesheetStatus=" + strTimesheetStatus;
			
			// START : Commented and Modified By ParagD On 25-Sept-2006 : Security Issue 6197
			// window.open("../FA/FA_TimesheetListing.aspx?" + strQueryString ,null,"resizable=no,scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=800");
			window.open("../FA/FA_TimesheetListing.aspx?" + strQueryString + "&PKToken=" + strToken,null,"resizable=no,scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=800");
			// END : Commented and Modified By ParagD On 25-Sept-2006 : Security Issue 6197
		}
		//End OF Modification By VivekP On 11 August 2005 For PMLifeline IssueID-87
		
		
		function ShowInvoice_OnClick(intInvoiceNo)
		{
			alert("Functionality to be implemented.");
			//window.open("../../Reports/Invoice.aspx?InvoiceNo=" + intInvoiceNo,null,"resizable=no,scrollbars=no,width=750,height=500,Left=10,top=10");
		}
		
		function ShowTimesheetToAuthenticate_OnClick(intTimesheetNo)
		{
			var strQueryString="";
			
			strQueryString = strQueryString  + "Mode=Details";
			strQueryString = strQueryString  + "&TimeSheetNo=" + intTimesheetNo.toString();
			strQueryString = strQueryString  + "&FromCustomer=1";
			//Modified by VivekP For PMLifeline IssueID-87
			window.open("../FA/FA_TimesheetListing.aspx?" + strQueryString ,null,"resizable=no,scrollbars=no,menubar=no,toolbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",height=500,width=650");
			//End Of Modifiction by VivekP For PMLifeline IssueID-87
			}
					</Script>
				
	</body>
</HTML>
