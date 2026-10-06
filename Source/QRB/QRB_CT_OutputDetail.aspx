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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_CT_OutputDetail.aspx.vb" Inherits="Whiz.QRB_CT_OutputDetail"%>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag("Cross Tab Output Detail", , , , "<script language=javascript src='../QRB/QueryBuilder.js'></script>")%> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
	

    <body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frm" method="post" runat="server">
			<%WritePage()%>
		</form>
	</body>
</html>
<script language="javascript">
	var objdiv;
	var objfrm;
	objfrm = GetFormReference('frm');
	objdivlist = GetObjectReference('frm','DivList');<% 'WAF3_PB_42 April 11, 2007 UmeshJ Change name to objdivlist %>

	var strCurrentWhere = '<%=m_strCurrentWhere%>';
	strCurrentWhere = URLEncode(strCurrentWhere);

			
	function PageNumber_OnClick(currentpage)
	{
		var action;
		var querystring;
		action ="<%=m_strAction%>";			
		if (action=="PRINTER_FRIENDLY_VERSION")
		{
			querystring = "Action=PRINTER_FRIENDLY_VERSION";
		}
		else
		{
			querystring = "";
		}		
	
		window.location.href = "QRB_CT_OutputDetail.aspx?CTQueryID=<%=m_lngCTQueryID%>&x=<%=m_strX%>&y=<%=m_strY%>&currentpage=" + currentpage + "&QueryID=<%=m_lngQueryID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>&" + querystring + "&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemId%>&XAxisAttribute=<%=m_strXAxisAttribute%>&YAxisAttribute=<%=m_strYAxisAttribute%>&CURRWHERE=" + strCurrentWhere; 
	}
	
	function Sort_OnClick(sortby, sortorder)
	{
		var action;
		var querystring;
		action ="<%=m_strAction%>";			
		if (action=="PRINTER_FRIENDLY_VERSION")
		{
			querystring = "Action=PRINTER_FRIENDLY_VERSION";
		}
		else
		{
			querystring = "";
		}		
	
		window.location.href = "QRB_CT_OutputDetail.aspx?CTQueryID=<%=m_lngCTQueryID%>&x=<%=m_strX%>&y=<%=m_strY%>&CurrentPage=<%=m_lngCurrentPage%>&QueryID=<%=m_lngQueryID%>&sortby=" + sortby + "&sortorder=" + sortorder + "&" + querystring + "&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemId%>&XAxisAttribute=<%=m_strXAxisAttribute%>&YAxisAttribute=<%=m_strYAxisAttribute%>&CURRWHERE=" + strCurrentWhere; 
	}

	function PrinterFriendlyVersion_OnClick()
	{
		window.open("QRB_CT_OutputDetail.aspx?CTQueryID=<%=m_lngCTQueryID%>&x=<%=m_strX%>&y=<%=m_strY%>&CurrentPage=<%=m_lngCurrentPage%>&Action=PRINTER_FRIENDLY_VERSION&QueryID=<%=m_lngQueryID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>" + "&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemId%>&XAxisAttribute=<%=m_strXAxisAttribute%>&YAxisAttribute=<%=m_strYAxisAttribute%>&CURRWHERE=" + strCurrentWhere,"_PrinterFriendlyOutput","resizable=yes,menubar=yes,scrollbars=yes,top=100,left=100,height=600,width=700"); 
	}
	
	function Export_OnClick(format)
	{
		window.location.href = "QRB_CT_OutputDetail.aspx?CTQueryID=<%=m_lngCTQueryID%>&x=<%=m_strX%>&y=<%=m_strY%>&CurrentPage=<%=m_lngCurrentPage%>&Action=EXPORT&Format=" + format + "&QueryID=<%=m_lngQueryID%>&sortby=<%=m_strSortBy%>&sortorder=<%=m_strSortOrder%>" + "&DashboardID=<%=m_lngDashboardID%>&ItemID=<%=m_lngItemId%>&XAxisAttribute=<%=m_strXAxisAttribute%>&YAxisAttribute=<%=m_strYAxisAttribute%>&CURRWHERE=" + strCurrentWhere; 
	}

<% 'WAF3_PB_42 April 11, 2007 UmeshJ START%>
	function window_onload()
	{
		var action = "<%=m_strAction%>";
		if (action=="PRINTER_FRIENDLY_VERSION")return;			
	    var intFillFactor=(arguments.length>0)?arguments[0]:80;
	    windowSize_common(intFillFactor);
	    var filename="<%=m_strReportFileName%>";		
	    if (trimString(filename).length > 0 )
	    {window.open ("../CRW/CRW_ReportOutput.aspx?filename=" + filename, "_report","");}		    
	}		
	function window_onresize()		
	{
	    var action = "<%=m_strAction%>";
		if (action=="PRINTER_FRIENDLY_VERSION")return;			
	    var intFillFactor=(arguments.length>0)?arguments[0]:80;
	    windowSize_common(intFillFactor);
	}
<% 'WAF3_PB_42 April 11, 2007 UmeshJ END%>

	function OpenTransactionPage(strPKVal, strPKToken)
	{
	    var sUrl='<%=m_strTransactionPageURL%>' + strPKToken + '&<%=m_strTransactionPagePKName%>=' + strPKVal;
	    var sSpecs = <%=m_strTransactionPageSpecs%>;
		window.open(sUrl,'_CDBDetail_TP',sSpecs);
	}		
</script>
