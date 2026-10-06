<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_DrillDown_Detail.aspx.vb" Inherits="PbNIT.CRM_DrillDown_Detail"%>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag("Drill Down Details")%>
    <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>


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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<%If m_intShowCT = 0 Then %>
		<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
	<%Else%>
		<body MS_POSITIONING="GridLayout" class="clsCDBBody">			 
	<%End If%>
		<form name="frmDrillDown" runat="server">
			<DIV class="FadingTooltip" id="FADINGTOOLTIP" style="Z-INDEX: 999; VISIBILITY: hidden; POSITION: absolute"></DIV>
			<%WriteMenu(true)%>
			<TABLE class="clsTable" width='100%' cellpadding="0" cellspacing="0">
				<TR class="clsTrEven">
					<td>
						<%WriteDrillDownAttributesCombo()%>
					</td>
	<td align="right"><a href="javascript:ZoomOut_OnClick(<%=m_intGraphHeight%>,<%=m_intGraphWidth%>)"><img src='../../Images/zoomin.gif' border="0" title='zoom out'></a>
						<a href="javascript:ZoomIn_OnClick(<%=m_intGraphHeight%>,<%=m_intGraphWidth%>)" title='zoom in'>
							<img src='../../Images/zoomout.gif' border="0"></a></td>
				</TR>
			</TABLE>
			<%If m_intShowCT = 0 Then %>
				<DIV id="divList" style='overflow:auto;height=100%'>
			<%Else%>
				<DIV id="divList" style='overflow:auto;width=797;height=275;'>
			<%End If%>	
				<TABLE class="clsTable" id="tblMain" width='100%' cellpadding="0" cellspacing="0">
					<TR class="clsTrOdd">
						<TD width='50%'>
							<%BuildGrid()%>
						</TD>
						<TD width='50%'>
							<TABLE class="clsTable" id="tblGraph" width='100%' runat="server">
							</TABLE>
						</TD>
					</TR>
				</TABLE>
			</DIV>
		<%If m_intShowCT = 0 Then WriteMenu(false) 'Modified By PushkarK On Thursday, February 23, 2006 %>
		</form>
	</body>
	<script language="javascript">
		var objform;
		var objdivlist;
			
		objform = GetFormReference('frmDrillDown');
		objdivlist = GetObjectReference('frmDrillDown','divList');
	
	    <%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
		function ZoomOut_OnClick(height,width)
		{
		    window.location.href = "CRM_DrillDown_Detail.aspx?DashboardID=<%=m_lngDashboardID%>&CURR=<%=m_intCurrDrillDown - 1%>&PKToken=<%=m_PKToken_Query_DT%>&ItemID=<%=m_lngItemID%>&colname=" + replaceChar(replaceChar("<%=m_strPrevAttribute%>", '&', '38'), '+', '43') + "&colvalue=" + replaceChar(replaceChar("<%=m_strPrevAttributeValue%>", '&', '38'), '+', '43') + "&CURRWHERE=<%=Server.URLEncode(m_strCurrWHERE)%>&height=" + (height + 50) + "&width=" + (width + 50);
		}
		
		function ZoomIn_OnClick(height,width)
		{
			if ((height>100) && (width>100))
			{
			    window.location.href = "CRM_DrillDown_Detail.aspx?DashboardID=<%=m_lngDashboardID%>&CURR=<%=m_intCurrDrillDown - 1%>&PKToken=<%=m_PKToken_Query_DT%>&ItemID=<%=m_lngItemID%>&colname=" + replaceChar(replaceChar("<%=m_strPrevAttribute%>", '&', '38'), '+', '43') + "&colvalue=" + replaceChar(replaceChar("<%=m_strPrevAttributeValue%>", '&', '38'), '+', '43') + "&CURRWHERE=<%=Server.URLEncode(m_strCurrWHERE)%>&height=" + (height - 50) + "&width=" + (width - 50);
			}
		}
		
		function DrillDown_OnClick(itemid,colname, colvalue)
		{
			colname = replaceSubstring(colname,"|||","'");
			colvalue = replaceSubstring(colvalue,"|||","'");
			window.open("CRM_DrillDown_Detail.aspx?DashboardID=<%=m_lngDashboardID%>&CURR=<%=m_intCurrDrillDown%>&PKToken=<%=m_PKToken_Query_DT%>&ItemID=" + itemid + "&colname=" + URLEncode(colname) + "&colvalue=" + URLEncode(colvalue) + "&CURRWHERE=<%=Server.URLEncode(m_strCurrWHERE)%>", "_drillDown<%=m_intCurrDrillDown%>", "resizable=yes,left=100,width=700,height=400,scrollbars=yes");
		}

		function Detail_OnClick(queryid,colname, colvalue)
		{
			var strWhereClause;
			colname = replaceSubstring(colname,"|||","'");
			colvalue = replaceSubstring(colvalue, "|||", "'");
         //Commented and added by Yogesh J on 20-Jan-2016 for to pass token
		//	window.open("CRM_QueryOutput.aspx?CURRWHERE=<%=Server.URLEncode(m_strCurrWHERE)%>&QueryID=" + queryid + "&PKToken=<%=m_PKToken_Query_DT%>&colname=" + URLEncode(colname) + "&colvalue=" + URLEncode(colvalue), "_queryoutput<%=m_intCurrDrillDown%>", "resizable=yes,left=100,width=700,height=500,scrollbars=yes");
		    window.open("CRM_QueryOutput.aspx?CURRWHERE=<%=Server.URLEncode(m_strCurrWHERE)%>&QueryID=" + queryid + "&PKToken=<%=m_PKToken_Query_ID%>&colname=" + URLEncode(colname) + "&colvalue=" + URLEncode(colvalue), "_queryoutput<%=m_intCurrDrillDown%>", "resizable=yes,left=100,width=700,height=500,scrollbars=yes");
        //End of addition by Yogesh J on 20-Jan-2016
		}
		
		function NextLevel_OnClick()
		{
		    //Commented and added by Yogesh J on 20-Jan-2016 for to pass token
		  //  window.open("CRM_DrillDown_Detail.aspx?ItemID=<%=m_lngItemId%>&CURR=<%=m_intCurrDrillDown%>&PKToken=<%=m_PKToken_Query_DT%>&colname=&colvalue=&CURRWHERE=<%=Server.URLEncode(m_strCurrWHERE)%>", "_nextlevel<%=m_intCurrDrillDown%>", "resizable=yes,left=100,width=700,height=400,scrollbars=yes");
		    window.open("CRM_DrillDown_Detail.aspx?ItemID=<%=m_lngItemId%>&CURR=<%=m_intCurrDrillDown%>&PKToken=<%=m_PKToken_Query_DT%>&colname=&colvalue=&CURRWHERE=<%=Server.URLEncode(m_strCurrWHERE)%>", "_nextlevel<%=m_intCurrDrillDown%>", "resizable=yes,left=100,width=700,height=400,scrollbars=yes");
		    //End of addition by Yogesh J on 20-Jan-2016
		}
	function cboDrillDownAttribut_OnChange()
		{
			<%'Function Added On 10-Feb-2006 By PushkarK For Req.ID. - WAF3_CDB_20%>
	    var cboDrillDownAttributes = GetObjectReference('frmDrillDown', 'cboDrillDownAttributes'); 
	    var cboDrillDownVal = cboDrillDownAttributes[cboDrillDownAttributes.selectedIndex].value;
        //Commented and added by Yogesh J on 20-Jan-2016 to pass Token
			//window.location.href = "CRM_DrillDown_Detail.aspx?DashboardID=<%=m_lngDashboardID%>&CURR=<%=m_intCurrDrillDown - 1%>&ItemID=<%=m_lngItemID%>&colname=&colvalue=&CURRWHERE=<%=Server.URLEncode(m_strCurrWHERE)%>&CURRENTDRILLDOWNPATH=<%=Server.URLEncode(m_strCurrentDrillDownPath)%>&cboVal=" + cboDrillDownVal + "&ShowCT=<%=m_intShowCT%>";
	    window.location.href = "CRM_DrillDown_Detail.aspx?DashboardID=<%=m_lngDashboardID%>&PKToken=<%=m_PKToken_Query_DT%>&CURR=<%=m_intCurrDrillDown - 1%>&ItemID=<%=m_lngItemID%>&colname=&colvalue=&CURRWHERE=<%=Server.URLEncode(m_strCurrWHERE)%>&CURRENTDRILLDOWNPATH=<%=Server.URLEncode(m_strCurrentDrillDownPath)%>&cboVal=" + cboDrillDownVal + "&ShowCT=<%=m_intShowCT%>";
	    //End of Comment and addition by Yogesh J on 20-Jan-2016 to pass Token
	}
		function window_onload()
		{
			var intDivHeight;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px';	
			WindowLoading();
		}
		function window_onresize()
		{
			var intDivHeight;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';
			UpdateWindowSize();
			
		}
	</script>
</HTML>

