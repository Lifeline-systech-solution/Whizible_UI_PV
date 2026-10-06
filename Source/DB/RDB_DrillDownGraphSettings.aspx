<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RDB_DrillDownGraphSettings.aspx.vb" Inherits="PbNIT.RDB_DrillDownGraphSettings" %>
<!DOCTYPE HTML>
<HTML>
	<%Mybase.InitializeResources("AppResources.RDB_DrillDownGraphSettings","AppResources")%>
	<%CommonFunctions.General.PlotPageHeadTag(Mybase.GetResourceString("CAP_DRILLDOWN_GRAPH_SETTINGS"))%>
 
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

	<body MS_POSITIONING="GridLayout" class=clsBody onload="window_onload()" onresize="window_onresize()">
	<form name=frmDrillDownGraphSettings id=frmDrillDownGraphSettings runat=server >
		<%WritePage%>
	</form>
	</body>
</HTML>
<script language="javascript">
	var frm = GetFormReference('frmDrillDownGraphSettings');
	var objdivlist =  GetObjectReference('frmDrillDownGraphSettings','divList')
	var objcboGraph = GetObjectReference('frmDrillDownGraphSettings','cboGraphType');
	var objcboPalleteStyle = GetObjectReference('frmDrillDownGraphSettings','cboPalleteStyle');
	var objcboBorderStyle = GetObjectReference('frmDrillDownGraphSettings','cboBorderStyle');
	var objcboBorderColor = GetObjectReference('frmDrillDownGraphSettings','cboBorderColor');
	var objcboChartBackColor = GetObjectReference('frmDrillDownGraphSettings','cboChartBackColor');
	var objcboChartAreaColor = GetObjectReference('frmDrillDownGraphSettings','cboChartAreaColor');
	var objcboCaptionColor = GetObjectReference('frmDrillDownGraphSettings','cboCaptionColor');
	var objcboTitleColor = GetObjectReference('frmDrillDownGraphSettings','cboTitleColor');
	var objtxtGraphHeight = GetObjectReference('frmDashboardSettings','txtGraphHeight');
	var objtxtGraphWidth = GetObjectReference('frmDashboardSettings','txtGraphWidth');
	
    	<%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
	
	function validate()
	{
		if (disallowBlank(objcboGraph,"<%=Mybase.GetResourceString("MSG_SELECT_GRAPH")%>")) return false;
		if (disallowBlank(objcboPalleteStyle,"<%=Mybase.GetResourceString("MSG_SELECT_SCHEME")%>")) return false;
		if (disallowBlank(objcboBorderStyle,"<%=Mybase.GetResourceString("MSG_SELECT_BORDERSTYLE")%>")) return false;
		if (disallowBlank(objcboBorderColor,"<%=Mybase.GetResourceString("MSG_SELECT_BORDERCOLOR")%>")) return false;
		if (disallowBlank(objcboTitleColor,"<%=Mybase.GetResourceString("MSG_SELECT_TITLE_COLOR")%>")) return false;
		if (disallowBlank(objcboChartBackColor,"<%=Mybase.GetResourceString("MSG_SELECT_BKCOLOR")%>")) return false;
		if (disallowBlank(objcboChartAreaColor,"<%=Mybase.GetResourceString("MSG_SELECT_AREACOLOR")%>")) return false;
		if (disallowBlank(objcboCaptionColor,"<%=Mybase.GetResourceString("MSG_SELECT_CAPTION_COLOR")%>")) return false;	
		if (disallowBlank(objtxtGraphHeight,"<%=Mybase.GetResourceString("MSG_SELECT_HEIGHT")%>")) return false;
		if (disallowBlank(objtxtGraphWidth,"<%=Mybase.GetResourceString("MSG_SELECT_WIDTH")%>")) return false;
		if (disallowNonInteger(objtxtGraphHeight,"<%=Mybase.GetResourceString("MSG_INTEGER")%>")) return false;
		if (disallowNonInteger(objtxtGraphWidth,"<%=Mybase.GetResourceString("MSG_INTEGER")%>")) return false;
		if (disallowMinValueViolation(objtxtGraphHeight,100,"<%=Mybase.GetResourceString("MSG_HEIGHT_LESSTHAN100")%>" )) return false;
		if (disallowMinValueViolation(objtxtGraphWidth,100,"<%=Mybase.GetResourceString("MSG_WIDTH_LESSTHAN100")%>" )) return false;
		return true;
	}
	
	function Save_OnClick()
	{
		if (validate())
		{
			frm.action = "RDB_DrillDownGraphSettings.aspx?type=<%=m_strType%>&DrillDownType=<%=m_strSystemDrillDownType%>&Action=SAVE&ParameterID=<%=m_lngParameterID%>";
			frm.submit();
		}
	}
	
	function window_onload()
	{
		var intDivHeight ;
		var intDivHeightRisk;
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		if (intDivHeight < 100)	intDivHeight = 100;
		objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015;	
	}

	function window_onresize()		
	{
		var intDivHeight ;
		var intDivHeightRisk;
		
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		if (intDivHeight < 100)	intDivHeight = 100;
		objdivlist.style.height = intDivHeight + 'px';//Added By Nilesh g on 11/12/2015;				
	}
</script>


