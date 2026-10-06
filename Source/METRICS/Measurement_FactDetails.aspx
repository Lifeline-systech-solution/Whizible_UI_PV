<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Measurement_FactDetails.aspx.vb" Inherits="PbNIT.Measurement_FactDetails"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Project Data Points")%>
	<%MyBase.InitializeResources("AppResourcePPM.MB_Plot_MeasurementGraphs_For_Projects", "AppResourcePPM")%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout" class='clsbody' onresize="window_onresize()" onload="window_onload()">
	
					<form id="frmProjectMeasurements" method="post" runat="server">
						
									<%PageInit%>
								
					</form>
				
					<script>
			var strMode = '<%=m_strMode%>';
			if (strMode!='PRINT') 
			objdivlist = GetObjectReference('frmProjectMeasurements','DivList');
	
	function window_onload()
	{
			var intDivHeight ;
			var intDivHeightRisk;
			var msg;
			if (strMode!='PRINT') 
			{
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			if (intDivHeight < 100) intDivHeight = 70;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;
			     objdivlist.style.height = intDivHeight + 'px';
			}
		
	}
		
	function window_onresize()		
	{
			var intDivHeight;
			var intDivHeightRisk;
			if (strMode!='PRINT') 
			{
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			if (intDivHeight < 100) intDivHeight = 70;
			    //Commented and added by Yogesh J on 11/12/2015
			    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';
			}
	}
	
	function Back_OnClick()
	{
				frmProjectMetrics.document.location.href ="../General/CommonList.aspx?FromWhere=SM&MasterTagID=2143"
	}
		
	function Help()
	{
			OpenHelpPage(2141);
	}
	
	function ZoomClick(strUrl)
	{
			window.open(strUrl,"" ,"resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,height=600,width=800,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 650)/2))
	}
	
	function PrintPreview_OnClick()
	{
			var strUrl = "";
			var strProjectID = '<%=m_lngProjectID.ToString%>';
			var showGraph= '<%=m_GraphDisplay%>';
			var fromwhere ='<%=m_strFromWhere%>';
			strUrl = "../METRICS/MB_Plot_MeasurementGraphs_For_Projects.aspx?mode=PRINT&FromWhere=" + fromwhere + "&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&ProjectID_PK=" + strProjectID + "&ProjectID=" + strProjectID+ "&ShowGraph=" + showGraph;
			window.open(strUrl,"" ,"resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,width=1000,height=500,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 650)/2))
	}
	function Value_onclick(ProjectId,MeasurementID,Date,FromDate,Todate)
	{
		strUrl = "../METRICS/Measurement_FactDetails.aspx?ProjectID=" + ProjectId + "&FromDate=" + FromDate + "&Todate=" + Todate + "&MeasurementID=" + MeasurementID;
		window.open(strUrl,"" ,"resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,width=1000,height=500,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 650)/2))
	  //  alert(ProjectId);
	}
	function Print_OnClick()
	{
			window.print('tblPrint');
	}
	function Project_Measurement_Report(ProjectID)
	{
		var mode="<%=strMetricView%>";
				if(mode=='Weekly')
		{
		w = window.open("../CRW/CRW_ReportUIBuilder.aspx?ReportID=2127&FromWhere=MB&UNIQUEID=" + ProjectID ,"","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 650)/2) + ",width=600,height=450")
		}
		else
		{
		w = window.open("../CRW/CRW_ReportUIBuilder.aspx?ReportID=1100&FromWhere=MB&UNIQUEID=" + ProjectID ,"","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 650)/2) + ",width=600,height=450")
		}
	}
					</script>
				
	</body>
</HTML>
