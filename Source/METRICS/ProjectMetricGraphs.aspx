<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectMetricGraphs.aspx.vb" Inherits="PbNIT.ProjectMetricGraphs"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
		<title>Project Metric Graphs</title>
		<script language='javascript' src='../General/CommonFunctions.js'></script>
		<script language='javascript' src='../General/CommonValidations.js'></script>
		<%CommonFunctions.General.PlotPageHeadTag(PAGE_HEADER)%>

<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
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
	</HEAD>
	<%MyBase.InitializeResources("AppResourcePPM.MB_Plot_MetricGraphs_For_Projects", "AppResourcePPM")%>
	<body MS_POSITIONING="GridLayout" class="clsBody"  onload='CL_window_onload()'>
		
		<form id="frmPrjMetricGraphs" method="post" runat="server">
			
						<%DrawPage()%>
					
		</form>
				
<script>
					
 objdivlist=GetObjectReference('frmPrjMetricGraphs','divPage')

function CL_window_onresize()
 {
   
var intDivHeight ;
var intDivHeightRisk;
    //added by Shamkant S on 12 Dec 2015
intDivHeight = window.innerHeight - objdivlist.offsetTop - 30;
if (intDivHeight < 100)
intDivHeight = 100;
    //Commented and added by Yogesh J on 11/12/2015
    //objdivlist.style.height = intDivHeight	;
objdivlist.style.height = intDivHeight + 'px';
    //Ended by Shamkant s on 12 DEC 2015
}
//window onload for Common list
function CL_window_onload()
{
   // alert("");
var intDivHeight ;
var intDivHeightRisk;
var lc;
intDivHeight = window.innerHeight - objdivlist.offsetTop - 30;
if (intDivHeight < 100)
    intDivHeight = 100;
    //Commented and added by Yogesh J on 11/12/2015
    //objdivlist.style.height = intDivHeight	;
objdivlist.style.height = intDivHeight + 'px';

}
			function Close_OnClick()
			{
			    window.close();
			    
			}
			function ModulesMenu_OnClick(strProjectID)
			{
				var ObjForm = GetFormReference('frmPrjMetricGraphs');
				ObjForm.action = "ProjectMetricGraphs.aspx?ProjectID=" + strProjectID + "&For=PRMO";
				ObjForm.submit()
			}
			
			function PhasesMenu_OnClick(strProjectID)
			{
				var ObjForm = GetFormReference('frmPrjMetricGraphs');
				ObjForm.action = "ProjectMetricGraphs.aspx?ProjectID=" + strProjectID + "&For=PRPH";
				ObjForm.submit()
			}
			
			function PhaseGrid_OnClick(strPhaseID, strMetricID)
			{
				window.open("MetricSpecificGraphs.aspx?PhaseID=" + strPhaseID + "&MetricID=" + strMetricID,"","resizable=yes,,toolbar=no,statusbar=no,left=0,top=0,width=" + window.screen.width - 200 + ",height=" + (window.screen.height/2 + 5));
			}
			
			//Added by GokulP on 21 Jan 2010 for Deliverable Graph
			function DeliverableGrid_OnClick(strDeliverableID, strMetricID)
			{
				window.open("MetricSpecificGraphs.aspx?DeliverableID=" + strDeliverableID + "&MetricID=" + strMetricID,"","resizable=yes,,toolbar=no,statusbar=no,left=0,top=0,width=" + window.screen.width - 200 + ",height=" + (window.screen.height/2 + 5));
			}
			//End of Addition by GokulP on 21 Jan 2010 for Deliverable Graph
			function ModuleGrid_OnClick(strModuleID, strMetricID)
			{
				window.open("MetricSpecificGraphs.aspx?ModuleID=" + strModuleID + "&MetricID=" + strMetricID,"","resizable=yes,,toolbar=no,statusbar=no,left=0,top=0,width=" + window.screen.width - 200 + ",height=" + (window.screen.height/2 + 5));
			}
			//SrikanthY on 08 Aug 2007, modified Below code to show Datapoint graphs at Below project level , for whizible metrics 3.0
			function MetricGraph_OnClick(strMode, strImageName, strMasterRecID, strMetricID)
			{
				//alert(strImageName);
				//window.open("MetricSpecificGraphs.aspx?MasterRecID=" + strMasterRecID + "&MetricID=" + strMetricID + "&For=" + strMode + "&Graph=" + strImageName,"","resizable=no,,toolbar=no,statusbar=no,left=0,top=0,width=" + window.screen.width - 200 + ",height=" + (window.screen.height-190));
				//window.open("MetricSpecificGraphs.aspx?MasterRecID=" + strMasterRecID + "&MetricID=" + strMetricID + "&For=" + strMode + "&Graph=" + strImageName,"","resizable=no,scrollbar=yes,toolbar=no,statusbar=no,left=0,top=50,width=" + (window.screen.width-20) + ",height=" + (window.screen.height-150));
				window.open("MetricSpecificGraphs.aspx?MasterRecID=" + strMasterRecID + "&MetricID=" + strMetricID + "&For=" + strMode + "&Graph=" + strImageName,"","resizable=no,scrollbars=yes,toolbar=no,statusbar=no,height=600,width=800,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 550)/2));
			}
			function Back_OnClick(strMode)
			{
			       if(strMode=="PH" || strMode=="PHDP")
			       {
			       	    window.location.href = "../Metrics/ProjectBreakUp_MasterSelection.aspx?MasterTagID=2519&FromWhere=PM&Show=Phase";
   				   }
   				   else if(strMode=="MLDP" || strMode=="ML")
   				   {
   				   window.location.href = "../Metrics/ProjectBreakUp_MasterSelection.aspx?MasterTagID=2519&FromWhere=PM&Show=Milestone";
   				   }
   				    else if(strMode=="DL" || strMode=="DLDP")
   				   {
   				    window.location.href = "../Metrics/ProjectBreakUp_MasterSelection.aspx?MasterTagID=2519&FromWhere=PM&Show=Deliverable";
   				   }
   				   
			}
			
					</script>
				
	</body>
</HTML>
