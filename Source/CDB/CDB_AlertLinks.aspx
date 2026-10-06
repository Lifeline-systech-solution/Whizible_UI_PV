<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CDB_AlertLinks.aspx.vb" Inherits="Whiz.CDB_AlertLinks" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Alert Links")%>
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
		<form id='frmAlertLinks' method='post' runat='server'>
			<%WritePage()%>
		</form>
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
	var objtxtLinkName;
	var objtxtURL;
	var objcboQuery;
	var objtxtWindowHeight;
	var objtxtWindowWidth;
	var objoptType;
		
	objform = GetFormReference('frmAlertLinks');
	objdivlist = GetObjectReference('frmAlertLinks','divList');
	objtxtLinkName = GetObjectReference('frmAlertLinks','txtLinkName');
	objtxtURL = GetObjectReference('frmAlertLinks','txtURL');
	objcboQuery = GetObjectReference('frmAlertLinks','cboQuery');
	objtxtWindowHeight =GetObjectReference('frmAlertLinks','txtWindowHeight');
	objtxtWindowWidth = GetObjectReference('frmAlertLinks','txtWindowWidth');
	objoptType =  GetObjectReference('frmAlertLinks','optType',true);
		
	function validate()
	{
		var type;
		if (objoptType[0].checked)
		{
			type=1;
		}
		else
		{
			type=2;
		}
				
		if (disallowBlank(objtxtLinkName,"Please provide the link name")) return false;
		if (disallowMaxlengthViolation(objtxtLinkName,200,"Please provide the link name within 200 characters")) return false;
		if (type==1)
		{
			if (disallowBlank(objtxtURL,"Please provide the link URL")) return false;
			if (disallowMaxlengthViolation(objtxtURL,4000,"Please provide the link URL within 4000 characters")) return false;
		}
		else
		{
			if (disallowBlank(objcboQuery,"Please provide the Query")) return false;
		}
		if (disallowBlank(objtxtWindowHeight,"Please provide the window height")) return false;
		if (disallowBlank(objtxtWindowWidth,"Please provide the window width")) return false;
		
		if (disallowNonNumeric(objtxtWindowHeight,"Please enter a numeric value")) return false;
		if (disallowNonNumeric(objtxtWindowWidth,"Please enter a numeric value")) return false;
		return true;
	}
	
	function BuildQueryString_OnClick(DBID,alertid)
    {
        //Commented And Added By Usha Pandit On 03.06.2020 to allow maximize popup
		<%--window.open("CDB_AlertLinkDetail.aspx?FromWhere=<%=m_strFromWhere%>&AlertID=" + alertid + "&DashboardID=" + DBID,"_ALertLinkDetail","resizable=no,scrollbars=no,left=" + ((window.screen.width - 500)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=500,height=500") ; //WAF3_PB_42 April 17, 2007 NinadP--%>
        window.open("CDB_AlertLinkDetail.aspx?FromWhere=<%=m_strFromWhere%>&AlertID=" + alertid + "&DashboardID=" + DBID, "_ALertLinkDetail", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 500) / 2) + ",top=" + ((window.screen.height - 500) / 2) + ",width=500,height=500"); //WAF3_PB_42 April 17, 2007 NinadP
        //End Of Added By Usha Pandit On 03.06.2020 to allow maximize popup
	}
	
	function cboQuery_OnChange()
	{
	    blnNavigate = false;    //Added By Ninad WAF3_PB_64			
		objform.action = "CDB_AlertLinks.aspx?FromWhere=<%=m_strFromWhere%>&Action=REFRESH&Mode=<%=m_strMode%>&AlertID=<%=m_lngAlertID%>&AlertLinkID=<%=m_lngAlertLinkID%>&DashboardID=<%=m_lngDashboardID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortorder%>";
		objform.submit();
	}
	
	function optType_OnClick(type)
	{
		if (type==1)
		{
			trURL.style.display = "block";
			trQuery.style.display = "none";
			trPrimaryKey.style.display = "none";
		}
		else
		{
			trURL.style.display = "none";
			trQuery.style.display = "block";
			trPrimaryKey.style.display = "block";
		}
		objtxtLinkName.focus(); 
	}

	
	function Save_OnClick(DBID,alertid)
	{
		if (validate()==true)
		{
			objform.action = "CDB_AlertLinks.aspx?FromWhere=<%=m_strFromWhere%>&Action=SAVE&Mode=<%=m_strMode%>&AlertLinkID=<%=m_lngAlertLinkID%>&AlertID=" + alertid + "&DashboardID=" + DBID;
			blnNavigate = false;    //Added By Ninad WAF3_PB_64
			objform.submit();
		}
	}
	<% 'WAF3_PB_42 April 17, 2007 START
	'Removed local functions for window onresize and onload
	'WAF3_PB_42 April 17, 2007 END%>

		</script>
	</body>
</HTML>
