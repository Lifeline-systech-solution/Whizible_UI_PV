<%@ Page Language="vb" AutoEventWireup="false" Codebehind="MB_MetricCommonList.aspx.vb" Inherits="PbNIT.MB_MetricCommonList" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("WINDOW_TITLE"), "Update Metric Data"))%>

<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
    <script type="text/javascript" src="../../responsive/responsive.js"></script>

<style type="text/css">
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 40%;*/
        font-size: 12px;
    }
    .clsTable .clsTRMenu td:nth-child(2)
    {
        /*width: 60%;*/
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {
        CL_window_onload();
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
        // Description:Remove plus(+)in Tablet and Mobile view
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        /*Generating 'id' for table row if it has no 'id'*/
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').find('tbody').find('tr').each(function () {

            var rowIndex = $(this).index();
            var attr = $(this).attr('id');
            // For some browsers, `attr` is undefined;
            // for others, `attr` is false. Check for both.
            if (typeof attr !== typeof undefined && attr !== false) {
            }

            else {
                $(this).attr('id', 'rowId' + rowIndex);
            }
        });

        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('large_visible');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').after('<div id="reviewTypeContent"></div>');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').clone().appendTo($('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent'));
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').find('tr').find('td:first').each(function () {
            /*$(this).find('a').css({'display':'none'});*/
            $(this).remove();

        });
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('large_visible').addClass('small_visible');

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Congiguration->Project Management->Review->Type
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Apply Footable For Grids
        // Description:Footable is used for responsive grids that will collapse the data into the first two columns for smaller resolutions (tablets).
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        if ($('.clsGridTable').length > 0) {
            var divName = $('#divListPageTag').find('div:first').attr('id');
            dataCollapse(divName);
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Apply FooTable
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/

        responsiveTopMenu();

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Congiguration->Project Management->Review->Type
        // Description:Apply FooTable
        // By Whom: Miiint
        // When:17/01/2015
        /*---------------------------------------------------------*/

        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#tblGrid01034').addClass('hidden-sm hidden-xs');
        $('.clsBody').find('#frmCommonList').find('#divListPageTag').find('#reviewTypeContent').find('table').removeClass('hidden-sm hidden-xs').addClass('reviewTypeContent hidden-lg hidden-md');

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Apply FooTable
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
            $('.clsTable:last').css({ 'display': 'none' });
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:19/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/


        /* Add class to Total Record Table*/
        $('.clsBody').find('table:last').prev().prev().addClass('recordTable');


    });// Ready Function Ends

    $(window).resize(function () {
        /*window_resize_hideshowtree();*/
        CL_window_onresize();

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
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();

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
            $('.clsTable:last').css({ 'display': 'none' });
        }
        else {
            $('.clsTable:last').css({ 'display': 'block' });
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/


        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:21/01/2015
        /*---------------------------------------------------------*/

        responsiveFooterMenuResize();

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

    });
</script>

<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">

		<form id="Form1" method="post" runat="server" onresize = "windowOnresize">
			<% Init_Page()%>
		</form>
		<script>
			var objform;
			var objdivlist;
			objform = GetFormReference('frmFormulaBuilder');
			objdivlist = GetObjectReference('frmFormulaBuilder','DivList');
			
			function Back_OnClick()
			{
				window.location.href="../General/CommonList.aspx?Mode=ADD_NEW&MasterTagID=2504&FromWhere=MB&PagingAlphabet=-1&AccessFirstTime=0&ParentTagID=0";
			}
			function GenerateAll_OnClick()
			{
			
				var strQueryString;
				strQueryString = "MB_MetricCommonList.aspx?Mode=ADD_NEW&MasterTagID=2504&FromWhere=MB&PagingAlphabet=-1&AccessFirstTime=0&ParentTagID=0";
				strQueryString = strQueryString + "&CAction=GALL";
				window.location.href = strQueryString ;
		
           }
			function Status_OnClick(SnapShotDate,FromDate,ToDate,Pendingmeasurements)
			{
			    
//				var strQueryString;
//				strQueryString = "MB_MetricCommonList.aspx?Mode=ADD_NEW&MasterTagID=2504&FromWhere=MB&PagingAlphabet=-1&AccessFirstTime=0&ParentTagID=0";
//				strQueryString = strQueryString + "&SnapShotDate=" + encodeURIComponent(SnapShotDate);
//				strQueryString = strQueryString + "&FromDate=" + encodeURIComponent(FromDate);
//				strQueryString = strQueryString + "&ToDate=" + encodeURIComponent(ToDate);
//				strQueryString = strQueryString + "&CAction=MGRT";
//				strQueryString = strQueryString + "&CMode=PND";
//				strQueryString = strQueryString + "&Pendingmeasurements=" + Pendingmeasurements ;
				if (Pendingmeasurements!='0')
				    {
				        
				        strQueryString = "ProjectDataPoint_EntrySheet.aspx?MasterTagID=2518&FromWhere=PM";
				        strQueryString = strQueryString + "&SnapShotDate=" + encodeURIComponent(SnapShotDate);
				        strQueryString = strQueryString + "&FromPage=GenerateDataPage";
				        strQueryString = strQueryString +"&Mode=Generate"
				    }
				else if(Pendingmeasurements=='0')
				    {
				        strQueryString = "MB_MetricCommonList.aspx?Mode=ADD_NEW&MasterTagID=2523&FromWhere=MB&PagingAlphabet=-1&AccessFirstTime=0&ParentTagID=0";
				strQueryString = strQueryString + "&SnapShotDate=" + encodeURIComponent(SnapShotDate);
				strQueryString = strQueryString + "&FromDate=" + encodeURIComponent(FromDate);
				strQueryString = strQueryString + "&ToDate=" + encodeURIComponent(ToDate);
				strQueryString = strQueryString + "&CAction=MGRT";
				strQueryString = strQueryString + "&CMode=PND";
				strQueryString = strQueryString + "&Pendingmeasurements=" + Pendingmeasurements ; 
				    
				    }
				window.location.href = strQueryString 
			}
			function window_onresize()		
			{
				var intDivHeight;
				var intDivHeightRisk;
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
				if (intDivHeight < 100)	intDivHeight = 100;
				objdivlist.style.height = intDivHeight;		
			}
			function window_onload()
			{
				var intDivHeight ;
				var intDivHeightRisk;
				var msg;
				
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
				if (intDivHeight < 100)	intDivHeight = 100;
				objdivlist.style.height = intDivHeight;	
				
			}
			
			function Generate_OnClick(SnapShotDate,FromDate,ToDate,Pendingmeasurements)
			{
			    
				var strQueryString;
				strQueryString = "MB_MetricCommonList.aspx?Mode=ADD_NEW&MasterTagID=2504&FromWhere=MB&PagingAlphabet=-1&AccessFirstTime=0&ParentTagID=0";
				strQueryString = strQueryString + "&SnapShotDate=" + encodeURIComponent(SnapShotDate);
				strQueryString = strQueryString + "&FromDate=" + encodeURIComponent(FromDate);
				strQueryString = strQueryString + "&ToDate=" + encodeURIComponent(ToDate);
				strQueryString = strQueryString + "&CAction=MGRT";
				strQueryString = strQueryString + "&CMode=PND";
				strQueryString = strQueryString + "&Pendingmeasurements=" + Pendingmeasurements ;
				
				window.location.href = strQueryString   
			}
			function Update_Measurement(ProjectId)
			{
			//../MB_ProjectMeasurementsHistory.aspx?Action=ADD&UniqueID=&CboChange=TRUE&Mode=ADD_NEW
			    
				var strQueryString;
				strQueryString = "../Metrics/MB_ProjectMeasurementsHistory.aspx?Action=ADD&UniqueID="+ ProjectId + "&CboChange=TRUE&Mode=ADD_NEW&FromWhere=UPDATEMETRIC";
				window.open(strQueryString ,"_popup", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 450)/2) + ",width=800,height=550")

			}

		</script>
	</body>
</HTML>
