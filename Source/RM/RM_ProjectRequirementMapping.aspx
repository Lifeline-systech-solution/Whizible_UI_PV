<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%CommonFunctions.General.PlotPageHeadTag("")%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RM_ProjectRequirementMapping.aspx.vb" Inherits="PbNIT.RM_ProjectRequirementMapping"%>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<HTML>
	<%PlotHead()%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmMapping" method="post" runat="server">
						
									<%PageInit%>
								
					</form>
				
					<Script language="javascript">
					
		var objfrmRequirementMapping=GetFormReference('frmMapping');
		var objdivlist=GetObjectReference('frmMapping','PageDiv');
		
		<%' Added By SonalD on 13th Jan 2009 %>
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
        <%End If%>
        <%' Added By SonalD on 13th Jan 2009 %>
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;	}			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;	}
		}
		function Help_OnClick(HelpID) 
		{ 
			window.open("../General/Help.aspx?HelpID=" + HelpID ,"_help","resizable=yes,scrollbars=yes,left=0,top=0,width=250,height=250"); 
		}	
			
		
		function TSPM_DetailsOnclick(intTaskID) 
		{ 
		
		 window.open("../DB/TimesheetDetails_CommonList.aspx?FromWhere=DB&MasterTagId=3630&TaskID="+ intTaskID , "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
		}
		
		function TSDEL_DetailsOnclick(intDeliverableID) 
		{ 
		 window.open("../DB/TimesheetDetails_CommonList.aspx?FromWhere=DB&MasterTagId=3630&DeliverableID="+ intDeliverableID , "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
		}
		
		function TSTC_DetailsOnclick(intProjectTestCaseID) 
		{ 
		 window.open("../DB/TimesheetDetails_CommonList.aspx?FromWhere=DB&MasterTagId=3630&ProjectTestCaseID="+ intProjectTestCaseID , "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
		}
		
		function TSCR_DetailsOnclick(intChangeRequestID) 
		{ 
		 window.open("../DB/TimesheetDetails_CommonList.aspx?FromWhere=DB&MasterTagId=3630&ChangeRequestID="+ intChangeRequestID , "_blank", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
		}
	
		
		function AddTasks_OnClick()
		{	
		 window.open("../RM/TaskMapping_CommonList.aspx?FromWhere=RM&ProjectID=<%=m_lngProjectId%>&ProjectRequirementID=<%=m_strProjectRequirementID%>&MasterTagId=3735" ,"","resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-500)/2 + ",width=800,height=500");
		}
		
		function AddDeliverable_OnClick()
		{	
		 window.open("../RM/DeliverableMapping_CommonList.aspx?FromWhere=RM&ProjectID=<%=m_lngProjectId%>&ProjectRequirementID=<%=m_strProjectRequirementID%>&MasterTagId=3737" ,"","resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-500)/2 + ",width=800,height=500");
		}

		function AddTestCases_OnClick()
		{	
		 window.open("../RM/TestCaseSection_CommonList.aspx?FromWhere=RM&ProjectID=<%=m_lngProjectId%>&ProjectRequirementID=<%=m_strProjectRequirementID%>&MasterTagId=3736" ,"","resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-500)/2 + ",width=800,height=500");
		}
		
		function AddChangeRequest_OnClick()
		{	
		 window.open("../RM/ChangeRequestMapping_CommonList.aspx?FromWhere=RM&ProjectID=<%=m_lngProjectId%>&ProjectRequirementID=<%=m_strProjectRequirementID%>&MasterTagId=3738" ,"","resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width-800)/2 + ",top=" + (window.screen.height-800)/2 + ",width=800,height=500");
		}

		function txtPageNumber_KeyPress(e,fromwhere)
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
				var objtxtpageNumberPM =  GetObjectReference('objfrmRequirementMapping','txtPageNumberPM');
				var objtxtNoOfPagesPM = GetObjectReference('objfrmRequirementMapping','txtNoOfPagesPM');

				var objtxtpageNumberTC =  GetObjectReference('objfrmRequirementMapping','txtPageNumberTC');
				var objtxtNoOfPagesTC = GetObjectReference('objfrmRequirementMapping','txtNoOfPagesTC');
				
				var objtxtpageNumberDEL =  GetObjectReference('objfrmRequirementMapping','txtPageNumberDEL');
				var objtxtNoOfPagesDEL = GetObjectReference('objfrmRequirementMapping','txtNoOfPagesDEL');
				
				var objtxtpageNumberCR =  GetObjectReference('objfrmDB_WhizibleToday','txtPageNumberCR');
				var objtxtNoOfPagesCR = GetObjectReference('objfrmRequirementMapping','txtNoOfPagesCR');
												
				var strtxtpageNumber= 'txtPageNumber' + fromwhere ;  
				var objtxtpageNumber = document.getElementById(strtxtpageNumber); 
				
				
				if (!disallowBlank(objtxtpageNumber,"Enter Page no",true) && (!disallowNonNumeric(objtxtpageNumber,"Page No should be numeric",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"Page no should be positive",true)) & (!disallowNonInteger(objtxtpageNumber,"Page no should be an integer",true)))				
				{
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}

					if (objtxtpageNumberPM.value == '')
					{
						objtxtpageNumberPM.value = 0;
					}

					if (objtxtpageNumberTC.value == '')
					{
						objtxtpageNumberTC.value = 0;
					}

					if (objtxtpageNumberDEL.value == '')
					{
						objtxtpageNumberDEL.value = 0;
					}

					if (objtxtpageNumberCR.value == '')
					{
						objtxtpageNumberCR.value = 0;
					}

					if (disallowNonNumeric(objtxtpageNumberPM,"Page no should be numeric",true))
						return;
					if (disallowNonNumeric(objtxtpageNumberTC,"Page no should be numeric",true))
						return;
					if (disallowNonNumeric(objtxtpageNumberDEL,"Page no should be numeric",true))
						return;
					if (disallowNonNumeric(objtxtpageNumberCR,"Page no should be numeric",true))
						return;


					if(Number(objtxtpageNumberPM.value) > Number(objtxtNoOfPagesPM.value) )
					{
						alert("Invalid Page No");
						setFocus(objtxtpageNumberPM);
						return;
					}
					if(Number(objtxtpageNumberTC.value) > Number(objtxtNoOfPagesTC.value) )
					{
						alert("Invalid Page No");
						setFocus(objtxtpageNumberTC);
						return;
					}
					if(Number(objtxtpageNumberDEL.value) > Number(objtxtNoOfPagesDEL.value) )
					{
						alert("Invalid Page No");
						setFocus(objtxtpageNumberDEL);
						return;
					}
					if(Number(objtxtpageNumberCR.value) > Number(objtxtNoOfPagesCR.value) )
					{
						alert("Invalid Page No");
						setFocus(objtxtpageNumberCR);
						return;
					}
			
	
					var str =objtxtpageNumberPM.value+','+objtxtpageNumberTC.value+','+objtxtpageNumberDEL.value+','+objtxtpageNumberCR.value;
										Page_Onclick(str);
			}	
			}
		
		}


			function Page_Onclick(str)
		{
	
		var strPageNumber=str.split(",");
		
		if (strPageNumber.length-1 >1 )
		{
			PageNumberPM = strPageNumber[0];
			pageNumberTC = strPageNumber[1];
			PageNumberDEL = strPageNumber[2];
			pageNumberCR = strPageNumber[3];
		}		
			strLocation = "RM_ProjectRequirementMapping.aspx?&PageNumberPM=" + PageNumberPM + "&PageNumberTC=" + pageNumberTC + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberCR=" + pageNumberCR					
				
			strLocation = strLocation ;
			objfrmRequirementMapping.action = strLocation
			objfrmRequirementMapping.submit();
		}

		function PagePM_Onclick(str)
		{
		var strPageNumber=str.split(",");
		if (strPageNumber.length-1 >1 )
		{
			PageNumberPM = strPageNumber[0];
			pageNumberTC = strPageNumber[1];
			PageNumberDEL = strPageNumber[2];
			pageNumberCR = strPageNumber[3];
		}	
			strLocation = "RM_ProjectRequirementMapping.aspx?&PageNumberPM=" + PageNumberPM + "&PageNumberTC=" + pageNumberTC + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberCR=" + pageNumberCR					
								
			strLocation = strLocation ;
			objfrmRequirementMapping.action = strLocation
			objfrmRequirementMapping.submit();
		}
		function PageTC_Onclick(str)
		{
		var strPageNumber=str.split(",");
		if (strPageNumber.length-1 >1 )
		{
			PageNumberPM = strPageNumber[0];
			pageNumberTC = strPageNumber[1];
			PageNumberDEL = strPageNumber[2];
			pageNumberCR = strPageNumber[3];
		}		
				strLocation = "RM_ProjectRequirementMapping.aspx?&PageNumberPM=" + PageNumberPM + "&PageNumberTC=" + pageNumberTC + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberCR=" + pageNumberCR					
				
			strLocation = strLocation ;
			objfrmRequirementMapping.action = strLocation
			objfrmRequirementMapping.submit();
		}
		function PageDEL_Onclick(str)
		{
		var strPageNumber=str.split(",");
		if (strPageNumber.length-1 >1 )
		{
			PageNumberPM = strPageNumber[0];
			pageNumberTC = strPageNumber[1];
			PageNumberDEL = strPageNumber[2];
			pageNumberCR = strPageNumber[3];
		}	
				strLocation = "RM_ProjectRequirementMapping.aspx?&PageNumberPM=" + PageNumberPM + "&PageNumberTC=" + pageNumberTC + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberCR=" + pageNumberCR					
				
			strLocation = strLocation ;
			objfrmRequirementMapping.action = strLocation
			objfrmRequirementMapping.submit();
		}
		
		
		function PageCR_Onclick(str)
		{
		var strPageNumber=str.split(",");
		if (strPageNumber.length-1 >1 )
		{
			PageNumberPM = strPageNumber[0];
			pageNumberTC = strPageNumber[1];
			PageNumberDEL = strPageNumber[2];
			pageNumberCR = strPageNumber[3];
		}		
		
			strLocation = "RM_ProjectRequirementMapping.aspx?&PageNumberPM=" + PageNumberPM + "&PageNumberTC=" + pageNumberTC + "&PageNumberDEL=" + PageNumberDEL+ "&PageNumberCR=" + pageNumberCR					
				
			strLocation = strLocation ;
			objfrmRequirementMapping.action = strLocation
			objfrmRequirementMapping.submit();
		}
		

		</Script>
		
	</body>
</HTML>
