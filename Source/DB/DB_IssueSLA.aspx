<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DB_IssueSLA.aspx.vb" Inherits="PbNIT.DB_IssueSLA" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
<!-- Commented by Gauri for JQuery and Bootstrap version upgrade -->
		<%CommonFunctions.General.PlotPageHeadTag("SLA Report")%>

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

	<body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize()" onload="window_onload()">
		<form id="frmSLAReport" method="post" runat="server">
			<!--<br> -->
			<% BuildPage()%>
		</form>
		<script language="javascript">
					var objfrm = GetFormReference('frmResourceUtilization');
			// var Mode = <%=m_strMode%>;
			//ADded by purvaj on 13 july 2006
			var objdivlist=GetObjectReference('frmResourceUtilization','PageDiv');
			//The div tag has id as PageDiv 
			
			<%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
			
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px' ;//Added By Nilesh g on 11/12/2015
        }			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015	
        }
		}	
		// end addition purvaj	
		function MeetSLA()
			{
				var objProject = GetObjectReference('objfrm','cboView');
				var EmployeeID=GetObjectReference('objfrm','cboEmployee');
				var ProjectID=GetObjectReference('objfrm','cboProject');
				var CustomerID=GetObjectReference('objfrm','cboCustomer');
				if (objProject.value=='')
				{
					window.open("DB_IssueSLA.aspx?Mode=MeetSLA","","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=630,height=630");  
				}
				if (objProject.value=='Customer')
				{
					window.open("DB_IssueSLA.aspx?Mode=MeetSLA&View=C&ID=" + CustomerID.value,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=600,height=630");  
				}			
				if(objProject.value=='AssignTo')
				{
					window.open("DB_IssueSLA.aspx?Mode=MeetSLA&View=A&ID="+ EmployeeID.value,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=600,height=630");  
				}
				if (objProject.value=='ProjectWise')
				{
					window.open("DB_IssueSLA.aspx?Mode=MeetSLA&View=P&ID="+ ProjectID.value,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=600,height=630");  
				}		
				
				//window.open("DB_IssueSLA.aspx?Mode=MeetSLA,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=850,height=680");  
				//window.open("DB_IssueSLA.aspx?Mode=MeetSLA","","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=600,height=630");  
					
			}	
			
		function AlertSLA()		
		{
			
				var objProject = GetObjectReference('objfrm','cboView');
				var EmployeeID=GetObjectReference('objfrm','cboEmployee');
				var ProjectID=GetObjectReference('objfrm','cboProject');
				var CustomerID=GetObjectReference('objfrm','cboCustomer');
			
				if (objProject.value=='')
				{
					window.open("DB_IssueSLA.aspx?Mode=AlertSLA","","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=600,height=630");  
				}
				if (objProject.value=='Customer')
				{
					window.open("DB_IssueSLA.aspx?Mode=AlertSLA&View=C&ID=" + CustomerID.value,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=600,height=630");  
				 }
				if(objProject.value=='AssignTo')
				{
					window.open("DB_IssueSLA.aspx?Mode=AlertSLA&View=A&ID="+ EmployeeID.value,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=600,height=630");  
				}
				if (objProject.value=='ProjectWise')
				{
					window.open("DB_IssueSLA.aspx?Mode=AlertSLA&View=P&ID="+ ProjectID.value,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=600,height=630");  
				}			
		   //window.open("DB_IssueSLA.aspx?Mode=AlertSLA","","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=850,height=680");  
				
		}			  
		
	function EscSLA()			
			{
			
			var objProject = GetObjectReference('objfrm','cboView');
			var EmployeeID=GetObjectReference('objfrm','cboEmployee');
			var ProjectID=GetObjectReference('objfrm','cboProject');
			var CustomerID=GetObjectReference('objfrm','cboCustomer');
			
			if (objProject.value=='')
				 {
					window.open("DB_IssueSLA.aspx?Mode=EscSLA","","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=600,height=630");  
				 }
			if (objProject.value=='Customer')
				 {
					window.open("DB_IssueSLA.aspx?Mode=EscSLA&View=C&ID=" + CustomerID.value,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=600,height=630");  
				 }
			if(objProject.value=='AssignTo')
				{
					window.open("DB_IssueSLA.aspx?Mode=EscSLA&View=A&ID="+ EmployeeID.value,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=600,height=630");  
				}
			if (objProject.value=='ProjectWise')
				{
					window.open("DB_IssueSLA.aspx?Mode=EscSLA&View=P&ID="+ ProjectID.value,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=600,height=630");  
				}	
			//window.open("DB_IssueSLA.aspx?Mode=EscSLA","","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=850,height=680");  
				
			}			  
		//function Help_OnClink()
		//{
		//window.open("DB_IssueSLA.aspx?Mode=Help","","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=850,height=680");  
		//}
			 
			 function Close_OnClink()
			 {
				window.close();
			 }
			 
			 
			 	function FromDate_onKeyPress(e){
	
	<%if m_UseEditableDateControl = true then%>
	
		var keynum
		var objFromDate = GetObjectReference('frmSLAReport','FromDate');
		if(window.event) // IE
		{ keynum = e.keyCode }
		else if(e.which) // Netscape/Firefox/Opera</DIV>
		{ keynum = e.which }
		if (keynum==13) 
		{
		
		str = DateControl_StandardOnblur('frmSLAReport','FromDate','<%=strInputdateFormat%>','')
		
		if (str==false)
		{
		 return;
		} 
		
		//frmSLAReport.action = "DailyActivityWeeklyView.aspx?SelectedDate="+val;
		
		//frmSLAReport.action = "DailyActivityWeeklyView.aspx?SelectedDate="+ objFromDate.value ;
		//frmSLAReport.submit();
		}
		
		
			<%end if%>
		
		}
		
		// End Modification By NitinVS on 7 Dec 2005 for PMLifeline IssueID 672
		
		
	
	
			 function DisplayDetails_MeetSLA()
				{	
				//window.open("DB_IssueSLA.aspx?Mode="+Mode+"&DisplayDetails=True&FromDate=<%=m_dtStartDateOfWeek%>&ToDate=<%=m_dtEndDateOfWeek%>","","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=1000,height=680");  
				//window.open("DB_IssueSLA.aspx?Mode=<%=m_strMode%>&DisplayDetails=True&FromDate=<%=m_dtStartDateOfWeek%>&ToDate=<%=m_dtEndDateOfWeek%>&View=<%=m_strView%>&ID=<%=m_strID%>&From=<%=m_strFrom%>","","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=1000,height=680");  
				
				window.open("DB_IssueSLA.aspx?Mode=<%=m_strMode%>&DisplayDetails=True&SelectedDate=<%=dtmSelectedDate%>&View=<%=m_strView%>&ID=<%=m_strID%>&From=<%=m_strFrom%>","","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 1000)/2 + ",top=" + (window.screen.height - 680)/2 + ",width=1000,height=680");  
				}
		function PreviousWeek_OnClick()
			{
				var ObjForm = GetFormReference('frmSLAReport');
				ObjForm.action="DB_IssueSLA.aspx?Mode=<%=m_strMode%>&Move=PREV&SelectedDate=<%=dtmSelectedDate%>&FromDate=<%=m_dtStartDateOfWeek%>&ToDate=<%=m_dtEndDateOfWeek%>&View=<%=m_strView%>&ID=<%=m_strID%>&From=<%=m_strFrom%>" // ,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=600,height=500");  
				SubmitForm(ObjForm);
			}	
		function NextWeek_OnClick()
			{	
				var ObjForm = GetFormReference('frmSLAReport');
				ObjForm.action="DB_IssueSLA.aspx?Mode=<%=m_strMode%>&Move=NEXT&SelectedDate=<%=dtmSelectedDate%>&FromDate=<%=m_dtStartDateOfWeek%>&ToDate=<%=m_dtEndDateOfWeek%>&View=<%=m_strView%>&ID=<%=m_strID%>&From=<%=m_strFrom%>" // ,"","resizable=yes,scrollbars=no,statusbar=no,left=,menubar=yes" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 1060)/2 + ",width=600,height=500");  
				SubmitForm(ObjForm);		
			}			 

		function SubmitForm(ObjF)
			{
				objDivHeight = GetObjectReference('frmWeeklyTimesheet','hdnDivHeight');//div scroll height
				objDiv3 = GetObjectReference('frmWeeklyTimesheet','divList');
				if (objDivHeight != null && objDiv3 != null)
				objDivHeight.value = objDiv3.scrollTop;
				if (ObjF != null) ObjF.submit();
			}
		
		function callcalendar(formname,datefield)
	{
		var objdateObject=GetObjectReference(formname,datefield)
		var dtval;
		
		
		if(objdateObject.value =='')
			dtval='None';
		else
			dtval=objdateObject.value;
		calendar_window=window.open('../General/Calendar.aspx?datefield=' + datefield +'&formname=' + formname + '&dateval=' + dtval+'&FromWhere=DB&Mode=<%=m_strMode%>&View=<%=m_strView%>&ID=<%=m_strID%>&From=<%=m_strFrom%>','calendar_window','top=0,left=0,width=348,height=260');
		calendar_window.focus();
	}
		
		</script>
	</body>
</HTML>
