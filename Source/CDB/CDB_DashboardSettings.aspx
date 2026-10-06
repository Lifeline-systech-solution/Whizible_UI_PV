<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CDB_DashboardSettings.aspx.vb" Inherits="Whiz.CDB_DashboardSettings" %>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag("Dashboard Settings")%>
<%--Commented and Added By Ankit P on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->

    <!-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


    <body style="overflow:auto" class="clsBody" MS_POSITIONING="GridLayout" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmDashboardSettings" method="post" runat="server">
			<%WritePage()%>
		</form>
	</body>
</html>


<script language="javascript">
<% 
    'Added by Ninad, WAF3_PB_64
    If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        Response.Write("var blnShowNavigationAlert = true;")
        Response.Write("window.onbeforeunload = confirmExit;")
        Response.Write("var strContainerDivs = 'DivList';")
        Response.Write("blnNavigate = null;")
    End If
    'End Addition by Ninad, WAF3_PB_64
%>
	var objform;
	var objdivlist;
	var objcboPalleteStyle;
	var objtxtGraphHeight;
	var objtxtGraphWidth;
	var objtxtDashboardName;
             <%' Added By Shamkant S on 8 Dec Jan 2015 %>
		     <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
             disableRightClick();
             <%End If%>
		     <%' Ended By Shamkant S on 8 Dec Jan 2015 %>
	
	objform = GetFormReference('frmDashboardSettings');
	objdivlist = GetObjectReference('frmDashboardSettings','divList');
	objcboPalleteStyle = GetObjectReference('frmDashboardSettings','cboPalleteStyle');
	objtxtGraphHeight = GetObjectReference('frmDashboardSettings','txtGraphHeight');
	objtxtGraphWidth = GetObjectReference('frmDashboardSettings','txtGraphWidth');
	objtxtDashboardName = GetObjectReference('frmDashboardSettings','txtDashboardName'); 	
		
	function validate()
	{
		if (disallowBlank(objtxtDashboardName,"Please provide the dashboard name")) return false;
		if (disallowSpecialCharacters(objtxtDashboardName,"Characters '[/:*?+\"><,\\\\]' are not allowed")) return false;
		if (disallowBlank(objcboPalleteStyle,"Please select the color scheme")) return false;
		if (disallowBlank(objtxtGraphHeight,"Please provide the graph height")) return false;
		if (disallowBlank(objtxtGraphWidth,"Please provide the graph width")) return false;
		if (disallowNonInteger(objtxtGraphHeight,"Please provide an integer value")) return false;
		if (disallowNonInteger(objtxtGraphWidth,"Please provide an integer value")) return false;
		if (disallowMinValueViolation(objtxtGraphHeight,100,"Please provide the height greater than 100" )) return false;
		if (disallowMinValueViolation(objtxtGraphWidth,100,"Please provide the width greater than 100" )) return false;
		return true;
	}
	
	function Save_OnClick(DBID)
	{
		if (validate()== true)
		{
			objform.action = "CDB_DashboardSettings.aspx?Action=SAVE&DashboardID=" + DBID + "&ShowMyQueries=<%=m_intShowMyQueries%>&ShowDescriptiveAlert=<%=m_intShowDescriptiveAlert%>&ShowNeedleGraphs=<%=m_intShowNeedleGraphs%>&ShowOtherGraphs=<%=m_intShowOtherGraphs%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&DisplayAlertID=<%=m_lngDisplayAlertID%>";
			blnNavigate = false;    //Added By Ninad WAF3_PB_64
			objform.submit();
		}
	}
		
	function window_onload()
	{
        var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 16, 2007 NinadP 
		    windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
		if (objtxtDashboardName.visible == true)
		{
			objtxtDashboardName.focus(); 
        }
        //Added by Chetan M on 23 Nov 2020 for Saving issue
        $("#cboNoOfGraphsPerRow").width('40px');
        //End of Added by Chetan M on 23 Nov 2020 for Saving issue
	}
	
<% 'WAF3_PB_42 April 16, 2007 START
	'Removed local functions for window onresize 
	'WAF3_PB_42 April 16, 2007 END%>

</script>
