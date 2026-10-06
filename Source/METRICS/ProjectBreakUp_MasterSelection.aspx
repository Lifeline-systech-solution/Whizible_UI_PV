<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectBreakUp_MasterSelection.aspx.vb" Inherits="PbNIT.ProjectBreakUp_MasterSelection"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<HEAD>
		<title>Project BreakUp Metric Details</title>
		<style> TR.clsTR { border-right: thin; padding-right: 1pt; border-top: thin; padding-left: 1pt; padding-bottom: 1pt; border-left: thin; padding-top: 1pt; border-bottom: thin; font-weight: normal; font-size: 11px; color: black; font-family: Verdana, Arial; height: 22px; BACKGROUND-COLOR: #f5deb3; }
	TR.clsLinkPageHeaderInnerTR { font-weight: bolder; font-size: 10px; margin-bottom: 2px; padding-bottom: 2px; color: white; font-family: Verdana, Arial; background-color: #4E7DD1; }
	TD.clsTRSectionHeaderTD { BORDER-RIGHT: thin; PADDING-RIGHT: 2pt; BORDER-TOP: thin; PADDING-LEFT: 2pt; FONT-WEIGHT: bolder; FONT-SIZE: 8pt; PADDING-BOTTOM: 2pt; MARGIN: 2pt; BORDER-LEFT: thin; COLOR: black; PADDING-TOP: 2pt; BORDER-BOTTOM: thin; FONT-FAMILY: Verdana, Arial; BACKGROUND-COLOR: #dcc1be }
	</style>
		<script language='javascript' src='../General/CommonFunctions.js'></script>
		<script language='javascript' src='../General/CommonValidations.js'></script>
		<%CommonFunctions.General.PlotPageHeadTag(PAGE_CAPTION)%>
<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
		<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
    /*Added By Bharat T  on 14th-Oct-2015*/
    td:first-child.clsLinkPageHeaderInner a:first-child {
    float: none;
    }
    /*Ended By Bharat T  on 14th-Oct-2015*/
</style>

<script type="text/javascript">
    $(document).ready(function () {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        /*-Commented by KIRAN K K FOR RESPONSIVE GRID 2/11/15------*/
        //if ($('.clsgridtable').length > 0) {
        //    var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
        //    dataCollapse(divName);
        //} 
        if ($('.clsBody').find('#frmPrjBrkpList').find("#divPage").find('#DivDetails').length > 0) {
            var divName = $('.clsBody').find('#frmPrjBrkpList').find("#divPage").find('#DivDetails').attr('id');
            dataCollapse(divName);
        }
        /*--Commented by KIRAN K K FOR RESPONSIVE GRID 2/11/15----*/
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
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize='window_onresize()' onload='window_onload()'>
		
					<form id="frmPrjBrkpList" name="frmPrjBrkpList" method="post" runat="server">
						
									<%BuildPage()%>
								
					</form>
				
					<script>
			var ObjForm=GetFormReference('frmPrjBrkpList');
			var objDivMain=GetObjectReference('frmPrjBrkpList','DivPage');

			function window_onload()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
				var intScriptNo;
				document.body.style.visibility='visible';
				if(objDivMain != null)
				{
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 10;
					if (intDivHeight < 100)
					    intDivHeight = 100;

				    //Commented and added by Yogesh J on 11/12/2015
				    //objDivMain.style.height = intDivHeight	;
					objDivMain.style.height = intDivHeight + 'px';
				}
				//setting scroll height----------------
				var ObjTblList1 = GetObjectReference('frmPrjBrkpList','DivList');
				var ObjhdnDivScrollHeight = GetObjectReference('frmPrjBrkpList','hdnDivScrollHeight');
				if(ObjTblList1 != null && ObjhdnDivScrollHeight != null)
				{
					ObjTblList1.scrollTop = ObjhdnDivScrollHeight.value;
				}
				
				CallOnLoad('tblList','tblH1',0);
				<% If m_strConsiderPrjForPhases = "True" Or m_strConsiderPrjForMilestones = "True" Or m_strConsiderPrjForDeliverables = "True" Then %>
				//CallOnLoad('tblDetails','tblH2',0);
				<%	End If %>
			}

			function window_onresize()		
			{
				if(objDivMain != null)
				{
					var intDivHeight ;
					var intDivHeightRisk;
						intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 10;
					if (intDivHeight < 100)
					    intDivHeight = 100;
				    //Commented and added by Yogesh J on 11/12/2015
				    //objDivMain.style.height = intDivHeight	;
					objDivMain.style.height = intDivHeight + 'px';
				}
				CallOnLoad('tblList','tblH1',0);
				//CallOnLoad('tblDetails','tblH2',0);
				
				<% If m_strConsiderPrjForPhases = "True" Or m_strConsiderPrjForMilestones = "True" Or m_strConsiderPrjForDeliverables = "True" Then %>
				//CallOnLoad('tblDetails','tblH2',0);
				<%	End If %>
			}

			function TD_OnClick(strProjectID,strCellID,intRowNo)
			{	//saving scroll height----------------
				var ObjTblList1 = GetObjectReference('frmPrjBrkpList','DivList');
				var ObjhdnDivScrollHeight = GetObjectReference('frmPrjBrkpList','hdnDivScrollHeight');
				//alert(ObjhdnDivScrollHeight.value)
				var ObjForm = GetFormReference('frmPrjBrkpList');
				var ProjectType= GetObjectReference('frmPrjBrkpList','cboPT');
				if(ObjTblList1 != null && ObjhdnDivScrollHeight != null)
				{
					ObjhdnDivScrollHeight.value = ObjTblList1.scrollTop;
				}
				//--------------------------------------
				//var ObjForm = GetFormReference('frmPrjBrkpList');
				
				ObjForm.action = "ProjectBreakUp_MasterSelection.aspx?ProjectID=" + strProjectID + "&PType="+ProjectType.value;
				ObjForm.submit();
			}
			function Project_MetricLink_OnClick(strProjectID)
			{
			   // window.open("MB_Plot_MetricGraphs_For_Projects.aspx?","","resizable=no,,toolbar=no,statusbar=no,left=" + ((window.screen.width - 1000)/2) + ",top=" + ((window.screen.height - 450)/2) + ",width=1000,height=550");
			   window.location.href = "../METRICS/MB_Plot_MetricGraphs_For_Projects.aspx?";
			}
			function Project_DPLink_OnClick(strProjectID)
			{
			 //  window.open("MB_Plot_MeasurementGraphs_For_Projects.aspx?","","resizable=no,,toolbar=no,statusbar=no,left=" + ((window.screen.width - 1000)/2) + ",top=" + ((window.screen.height - 450)/2) + ",width=1000,height=550"); 
			   window.location.href = "../METRICS/MB_Plot_MeasurementGraphs_For_Projects.aspx?";
			}
			
			function CallOnLoad(Source,Dest,RowNo)
			{	
				var tblSource = GetObjectReference('frmPrjBrkpList',Source);
				var tblHDF = GetObjectReference('frmPrjBrkpList',Dest);
				
				tblHDF.width=tblSource.offsetWidth;
							
				var xl = tblSource.offsetLeft;
				var yt = tblSource.offsetTop;
				var tl = tblSource;
				while (tl.tagName != "BODY") 
				{
					tl = tl.offsetParent;
					xl = xl + tl.offsetLeft;
					yt = yt + tl.offsetTop;
				}
				var headerTableRow = tblHDF.rows[RowNo];
				var originalTableRow = tblSource.rows[RowNo];
				headerTableRow.height =originalTableRow.offsetHeight;
				for (var i = 0; i < headerTableRow.cells.length; i++) {
					headerTableRow.cells[i].width = originalTableRow.cells[i].offsetWidth;
					headerTableRow.cells[i].height = originalTableRow.cells[i].offsetHeight;
					headerTableRow.cells[i].innerHTML = originalTableRow.cells[i].innerHTML;
					headerTableRow.cells[i].align = originalTableRow.cells[i].align;
				}
				tblHDF.style.left =xl; 
				tblHDF.style.top = yt ; 
				tblHDF.style.position = 'absolute';
				tblHDF.style.display="";
			}
			
			function PhaseTab_OnClick(strProjectID)
			{
				//saving scroll height----------------
				var ObjTblList1 = GetObjectReference('frmPrjBrkpList','DivList');
				var ObjhdnDivScrollHeight = GetObjectReference('frmPrjBrkpList','hdnDivScrollHeight');
				//alert(ObjhdnDivScrollHeight.value)
				
				if(ObjTblList1 != null && ObjhdnDivScrollHeight != null)
				{
					ObjhdnDivScrollHeight.value = ObjTblList1.scrollTop;
				}
				//--------------------------------------
				var ObjForm = GetFormReference('frmPrjBrkpList');
				//var ProjectType= GetObjectReference('frmPrjBrkpList','cboPT');
				//ObjForm.action = "ProjectBreakUp_MasterSelection.aspx?ProjectID=" + strProjectID + "&Show=Phase&PType="+ProjectType.value;
				ObjForm.action = "ProjectBreakUp_MasterSelection.aspx?ProjectID=" + strProjectID + "&Show=Phase&PType=";
				ObjForm.submit()
			}
						
			function MilestoneTab_OnClick(strProjectID)
			{
			   
				//saving scroll height----------------
				var ObjTblList1 = GetObjectReference('frmPrjBrkpList','DivList');
				var ObjhdnDivScrollHeight = GetObjectReference('frmPrjBrkpList','hdnDivScrollHeight');
				//alert(ObjhdnDivScrollHeight.value)
				if(ObjTblList1 != null && ObjhdnDivScrollHeight != null)
				{
					ObjhdnDivScrollHeight.value = ObjTblList1.scrollTop;
				}
				//--------------------------------------
				var ObjForm = GetFormReference('frmPrjBrkpList');
				//var ProjectType= GetObjectReference('frmPrjBrkpList','cboPT');
				//ObjForm.action = "ProjectBreakUp_MasterSelection.aspx?ProjectID=" + strProjectID + "&Show=Milestone&PType="+ProjectType.value;
				ObjForm.action = "ProjectBreakUp_MasterSelection.aspx?ProjectID=" + strProjectID + "&Show=Milestone&PType=";
				ObjForm.submit()
			}
			
			//Added by GokulP on 20 Jan 2010 for Deliverable Tab
			function DeliverableTab_OnClick(strProjectID)
			{
				//saving scroll height----------------
				var ObjTblList1 = GetObjectReference('frmPrjBrkpList','DivList');
				var ObjhdnDivScrollHeight = GetObjectReference('frmPrjBrkpList','hdnDivScrollHeight');
				//alert(ObjhdnDivScrollHeight.value)
				if(ObjTblList1 != null && ObjhdnDivScrollHeight != null)
				{
					ObjhdnDivScrollHeight.value = ObjTblList1.scrollTop;
				}
				//--------------------------------------
				var ObjForm = GetFormReference('frmPrjBrkpList');
				//var ProjectType= GetObjectReference('frmPrjBrkpList','cboPT');
//				ObjForm.action = "ProjectBreakUp_MasterSelection.aspx?ProjectID=" + strProjectID + "&Show=Deliverable&PType="+ProjectType.value;
            	ObjForm.action = "ProjectBreakUp_MasterSelection.aspx?ProjectID=" + strProjectID + "&Show=Deliverable&PType=";
				ObjForm.submit()
			}
			//End of Addition by GokulP on 20 Jan 2010 for Deliverable Tab
			
			function ProjectLink_OnClick(strProjectID)
			{
				window.open("ProjectMetricGraphs.aspx?ProjectID=" + strProjectID + "&For=PRPH","","resizable=yes,,toolbar=no,statusbar=no,left=0,top=0,width=" + window.screen.width + ",height=" + window.screen.height);
			}
			 //SrikanthY on 07 Aug 2007, Added Below code to show Datapoint graphs at Below project level , for PMLifeLine metrics
			function PhaseMetricLink_OnClick(strPhaseID)
			{
				//window.open("ProjectMetricGraphs.aspx?PhaseID=" + strPhaseID + "&For=PH","","resizable=yes,,toolbar=no,statusbar=no,left=0,top=0,width=" + window.screen.width + ",height=" + window.screen.height);
					//window.open("ProjectMetricGraphs.aspx?PhaseID=" + strPhaseID + "&For=PH","","resizable=no,,toolbar=no,statusbar=no,left=" + ((window.screen.width - 1000)/2) + ",top=" + ((window.screen.height - 450)/2) + ",width=1000,height=550");
					window.location.href = "../METRICS/ProjectMetricGraphs.aspx?PhaseID="+ strPhaseID + "&For=PH";
			}
			function PhaseDPLink_OnClick(strPhaseID)
			{
				//window.open("ProjectMetricGraphs.aspx?PhaseID=" + strPhaseID + "&For=PHDP","","resizable=yes,,toolbar=no,statusbar=no,left=0,top=0,width=" + window.screen.width + ",height=" + window.screen.height);
				//window.open("ProjectMetricGraphs.aspx?PhaseID=" + strPhaseID + "&For=PHDP","","resizable=no,,toolbar=no,statusbar=no,left=" + ((window.screen.width - 1000)/2) + ",top=" + ((window.screen.height - 450)/2) + ",width=1000,height=550");
				window.location.href = "../METRICS/ProjectMetricGraphs.aspx?PhaseID=" + strPhaseID + "&For=PHDP";
			}
			function MileStoneMetricLink_OnClick(strMilestoneID)
			{
				//window.open("ProjectMetricGraphs.aspx?MilestoneID=" + strMilestoneID + "&For=ML","","resizable=yes,,toolbar=no,statusbar=no,left=0,top=0,width=" + window.screen.width + ",height=" + window.screen.height);
				//window.open("ProjectMetricGraphs.aspx?MilestoneID=" + strMilestoneID + "&For=ML","","resizable=no,,toolbar=no,statusbar=no,left=" + ((window.screen.width - 1000)/2) + ",top=" + ((window.screen.height - 450)/2) + ",width=1000,height=550");
				window.location.href = "../METRICS/ProjectMetricGraphs.aspx?MilestoneID=" + strMilestoneID + "&For=ML";
			}
			function MileStoneDPLink_OnClick(strMilestoneID)
			{
				//window.open("ProjectMetricGraphs.aspx?MilestoneID=" + strMilestoneID + "&For=MLDP","","resizable=yes,,toolbar=no,statusbar=no,left=0,top=0,width=" + window.screen.width + ",height=" + window.screen.height);
				//window.open("ProjectMetricGraphs.aspx?MilestoneID=" + strMilestoneID + "&For=MLDP","","resizable=no,,toolbar=no,statusbar=no,left=" + ((window.screen.width - 1000)/2) + ",top=" + ((window.screen.height - 450)/2) + ",width=1000,height=550");
				window.location.href = "../METRICS/ProjectMetricGraphs.aspx?MilestoneID=" + strMilestoneID + "&For=MLDP";
			}
			//Added by GokulP on 20 Jan 2010 for Deliverable Tab
			function DeliverableMetricLink_OnClick(strDeliverableID)
			{
				//window.open("ProjectMetricGraphs.aspx?MilestoneID=" + strMilestoneID + "&For=ML","","resizable=yes,,toolbar=no,statusbar=no,left=0,top=0,width=" + window.screen.width + ",height=" + window.screen.height);
				//window.open("ProjectMetricGraphs.aspx?DeliverableID=" + strDeliverableID + "&For=DL","","resizable=no,,toolbar=no,statusbar=no,left=" + ((window.screen.width - 1000)/2) + ",top=" + ((window.screen.height - 450)/2) + ",width=1000,height=550");
				window.location.href = "../METRICS/ProjectMetricGraphs.aspx?DeliverableID=" + strDeliverableID + "&For=DL";
			}
			function DeliverableDPLink_OnClick(strDeliverableID)
			{
				//window.open("ProjectMetricGraphs.aspx?MilestoneID=" + strMilestoneID + "&For=MLDP","","resizable=yes,,toolbar=no,statusbar=no,left=0,top=0,width=" + window.screen.width + ",height=" + window.screen.height);
				//window.open("ProjectMetricGraphs.aspx?DeliverableID=" + strDeliverableID + "&For=DLDP","","resizable=no,,toolbar=no,statusbar=no,left=" + ((window.screen.width - 1000)/2) + ",top=" + ((window.screen.height - 450)/2) + ",width=1000,height=550");
				window.location.href = "../METRICS/ProjectMetricGraphs.aspx?DeliverableID=" + strDeliverableID + "&For=DLDP";
			}
			//End of addition by GokulP on 20 Jan 2010 for Deliverable Tab
			
//			function PT_Onchange()
//			{
//			var ObjForm = GetFormReference('frmPrjBrkpList');
//			var ProjectType= GetObjectReference('frmPrjBrkpList','cboPT');
//				ObjForm.action = "ProjectBreakUp_MasterSelection.aspx?PType="+ProjectType.value;
//				ObjForm.submit()
//			}
			//End of addition by SrikanthY on 07 Aug 2007
					</script>
				
	</body>
</HTML>
