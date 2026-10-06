<%@ Page Language="vb" AutoEventWireup="false" Codebehind="ProjectDataPoint_EntrySheet.aspx.vb" Inherits="PbNIT.ProjectDataPoint_EntrySheet"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Project DataPoint EntrySheet")%>
	<%MyBase.InitializeResources("AppResourcePPM.MB_ProjectMeasurementsHistory", "AppResourcePPM")%>
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
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmProjectDataPointEntrySheet" method="post" runat="server">
						
									<%PageInit%>
								
					</form>
				
					<Script language="javascript">
			var objForm=GetFormReference('frmProjectDataPointEntrySheet');
			var objdivlist=GetObjectReference('frmProjectDataPointEntrySheet','PageDiv');
			//The div tag has id as PageDiv 
			function window_onload()
			{
				var intDivHeight ;
				var intDivHeightRisk;
				if (objdivlist !=null) {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100) intDivHeight = 100;

				    //Commented and added by Yogesh J on 11/12/2015
				    //objdivlist.style.height = intDivHeight;
				     objdivlist.style.height = intDivHeight + 'px';
				}
				
			}
			
			function window_onresize()		
			{
				var intDivHeight;
				var intDivHeightRisk;
				if (objdivlist !=null) {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)	intDivHeight = 100;
				    //Commented and added by Yogesh J on 11/12/2015
				    //objdivlist.style.height = intDivHeight;
				objdivlist.style.height = intDivHeight + 'px';
            }
			}	
			function Back_OnClick()
			{
				window.location.href="../METRICS/MB_ProjectMeasurementsHistory.aspx?MasterTagID=2513&FromWhere=PM";
			}
			function BackFrmGenerate_OnClick()
			{
				window.location.href="../METRICS/MB_MetricCommonList.aspx?CMode=PND&Mode=ADD_NEW&MasterTagID=2504&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1";
			}
			
			function Generate()
	        {
	        var objForm=GetFormReference('frmProjectDataPointEntrySheet');
	         objForm.action ="../Metrics/ProjectDataPoint_EntrySheet.aspx?Mode=GenerateData";
	         objForm.submit();
	        }
			
			function Project_OnChange()
			{
				var objForm=GetFormReference('frmProjectDataPointEntrySheet');
				//var objProject = GetObjectReference('frmProjectDataPointEntrySheet', 'cboProjects');
				//var strProjectID = objProject.value;
				objForm.action = "ProjectDataPoint_EntrySheet.aspx?ProjectID=" + <%=m_strProjectID%> + "&DateMode=Current";
				objForm.submit()
			}
			
			function PreviousMonth_OnClick()
			{
				//alert('Previous');
				var objForm=GetFormReference('frmProjectDataPointEntrySheet');
				//var objProject = GetObjectReference('frmProjectDataPointEntrySheet', 'cboProjects');
				//var strProjectID = objProject.value;
				objForm.action = "ProjectDataPoint_EntrySheet.aspx?ProjectID=" + <%=m_strProjectID%> + "&DateMode=PreviousMonth";
				objForm.submit()
			}
			
			function NextMonth_OnClick()
			{
				//alert('Next');
				var objForm=GetFormReference('frmProjectDataPointEntrySheet');
				//var objProject = GetObjectReference('frmProjectDataPointEntrySheet', 'cboProjects');
				//var strProjectID = objProject.value;
				objForm.action = "ProjectDataPoint_EntrySheet.aspx?ProjectID=" + <%=m_strProjectID%> + "&DateMode=NextMonth";
				objForm.submit()
			}
			//Added By RathinP
			function PreviousWeek_OnClick()
			{
				//alert('Previous');
				var objForm=GetFormReference('frmProjectDataPointEntrySheet');
				//var objProject = GetObjectReference('frmProjectDataPointEntrySheet', 'cboProjects');
				//var strProjectID = objProject.value;
				objForm.action = "ProjectDataPoint_EntrySheet.aspx?ProjectID=" + <%=m_strProjectID%> + "&DateMode=PreviousWeek";
				objForm.submit()
			}
			
			function NextWeek_OnClick()
			{
				//alert('Next');
				var objForm=GetFormReference('frmProjectDataPointEntrySheet');
				//var objProject = GetObjectReference('frmProjectDataPointEntrySheet', 'cboProjects');
				//var strProjectID = objProject.value;
				objForm.action = "ProjectDataPoint_EntrySheet.aspx?ProjectID=" + <%=m_strProjectID%> + "&DateMode=NextWeek";
				objForm.submit()
			}
			///End by RathinP
			function MilestoneSave_OnClick(strProjectID)
			{
				var objForm=GetFormReference('frmProjectDataPointEntrySheet');
				<%if m_blnMilestoneBreakUpData = False Then %>
					alert('There is no Data for Milestones to be saved.');
				<%Else%>
					//Added by GokulP on 02 Feb 2010 for move to list page 
		             <%if m_strFromPage = "GENERATEDATAPAGE" Then %>			            
			            objForm.action = "ProjectDataPoint_EntrySheet.aspx?DateMode=CurrentMonth&Mode=SaveMilestoneData&FromPage=GenerateDataPage&ProjectID=" + strProjectID;
		            <%Else%>
			            objForm.action = "ProjectDataPoint_EntrySheet.aspx?FromTab=2&DateMode=CurrentMonth&Mode=SaveMilestoneData&ProjectID=" + strProjectID;
					<% End if %>
		            //End of Addition by GokulP on 02 Feb 2010 for move to list page	
					objForm.submit()
				<% End if %>
			}
			
			function PhaseSave_OnClick(strProjectID, strRecordExists)
			{
				var objForm=GetFormReference('frmProjectDataPointEntrySheet');
				<%if m_blnPhaseBreakUpData = False Then %>
					alert('There is no Data for Phases to be saved.');
				<%Else%>					
					//Added by GokulP on 02 Feb 2010 for move to list page 
		             <%if m_strFromPage = "GENERATEDATAPAGE" Then %>			            			            
			            objForm.action = "ProjectDataPoint_EntrySheet.aspx?DateMode=CurrentMonth&Mode=SavePhaseData&FromPage=GenerateDataPage&ProjectID=" + strProjectID;
		            <%Else%>
			            objForm.action = "ProjectDataPoint_EntrySheet.aspx?FromTab=1&DateMode=CurrentMonth&Mode=SavePhaseData&ProjectID=" + strProjectID;
					<% End if %>
		            //End of Addition by GokulP on 02 Feb 2010 for move to list page	
					objForm.submit()
				<% End if %>
			}
			
			//Added by GokulP on 20 Jan 2010 for Deliverable Tab
			function DeliverableSave_OnClick(strProjectID)
			{
				var objForm=GetFormReference('frmProjectDataPointEntrySheet');
				<%if m_blnDeliverableBreakUpData = False Then %>
					alert('There is no Data for Deliverable to be saved.');
				<%Else%>					
					//Added by GokulP on 02 Feb 2010 for move to list page 
		             <%if m_strFromPage = "GENERATEDATAPAGE" Then %>			            			            			            
			            objForm.action = "ProjectDataPoint_EntrySheet.aspx?DateMode=CurrentMonth&Mode=SaveDeliverableData&FromPage=GenerateDataPage&ProjectID=" + strProjectID;
		            <%Else%>
			            objForm.action = "ProjectDataPoint_EntrySheet.aspx?FromTab=3&DateMode=CurrentMonth&Mode=SaveDeliverableData&ProjectID=" + strProjectID;
					<% End if %>
		            //End of Addition by GokulP on 02 Feb 2010 for move to list page	
					objForm.submit()
				<% End if %>
			}
			//End of addition by GokulP on 20 Jan 2010 for Deliverable Tab
			function PhaseGenerateReport_OnClick(strProjectID, strFromDate, strToDate)
			{
				var objForm=GetFormReference('frmProjectDataPointEntrySheet');
				<%if m_blnPhaseBreakUpData = False Then %>
					alert('There is no Data for Phases for the Generation of the Report.');
				<%Else%>
					window.open("MilestoneClosureReport_Data.aspx?FromDate=" + strFromDate + "&ToDate=" + strToDate + "&Mode=Phase" + "&ProjectID=" + strProjectID, "","resizable=yes,,toolbar=no,statusbar=no,left=0,top=0,width=" + window.screen.width + ",height=" + window.screen.height);
				<% End if %>
			}
			
			function MilestoneGenerateReport_OnClick(strProjectID, strFromDate, strToDate)
			{
				var objForm=GetFormReference('frmProjectDataPointEntrySheet');
				<%if m_blnMilestoneBreakUpData = False Then %>
					alert('There is no Data for Milestones for the Generation of the Report.');
				<%Else%>
					window.open("MilestoneClosureReport_Data.aspx?FromDate=" + strFromDate + "&ToDate=" + strToDate + "&Mode=Milestone" + "&ProjectID=" + strProjectID,"","resizable=yes,,toolbar=no,statusbar=no,left=0,top=0,width=" + window.screen.width + ",height=" + window.screen.height);
				<% End if %>
			}
			
			function MeasurmentValue_OnChange(objTextBoxID)
			{
				if (disallowBlank(objTextBoxID, 'Value cannot be Blank.',true))
				{
					objTextBoxID.focus();
					objTextBoxID.value='0';
				}
				else if(disallowNonNumeric(objTextBoxID,"Value cannot be Non Numeric.",true))
				{
			
					//alert('Value cannot be Non Numeric.');
					objTextBoxID.focus();
					objTextBoxID.value='0';
				}
			}
		//Added by SrikanthY on 12 Jul 2007 for Whizible Metrics 3.0	
		function ProjectSave_OnClick(Project)
		{
		
		 var txtTextControls=GetObjectReference('frmProjectDataPointEntrySheet','txtTextControls');
		 var strArray=new Array();
		 var length;
		 var blnResult;
		 var Counter;
		 var ObjTextControl;
	     
	       
	     // TextBox Validations on CommonPage.	
		 strArray=txtTextControls.value.split(",");
      	 length=strArray.length; 
		 
		for(Counter=0;Counter<length-1;Counter++)
		{
		      	
		        ObjTextControl=GetObjectReference('frmProjectDataPointEntrySheet','txtProjectDP'+strArray[Counter]);
		        
		              
		       	blnResult=disallowNonNumeric(ObjTextControl,'Only numeric values are allowed !',true);
				if(blnResult==true)
				   return;
		}
		
		for(Counter=1;Counter<length-1;Counter++)
		{
		        ObjTextControl=GetObjectReference('frmProjectDataPointEntrySheet','txtProjectDP'+strArray[Counter]);
		        ObjTextControl.disabled=false;
		}
		//Added by GokulP on 02 Feb 2010 for move to list page 
		 <%if m_strFromPage = "GENERATEDATAPAGE" Then %>
			frmProjectDataPointEntrySheet.action ="../Metrics/ProjectDataPoint_EntrySheet.aspx?Mode=ProjectSave&FromPage=GenerateDataPage";
		<%Else%>
			frmProjectDataPointEntrySheet.action ="../Metrics/ProjectDataPoint_EntrySheet.aspx?FromTab=0&Mode=ProjectSave";
		<% End if %>
		//End of Addition by GokulP on 02 Feb 2010 for move to list page		
		 
		 frmProjectDataPointEntrySheet.submit();
		}
			
		function ReGenerate()
		{
		 frmProjectDataPointEntrySheet.action ="../Metrics/ProjectDataPoint_EntrySheet.aspx?Mode=ReGenerate";
		 frmProjectDataPointEntrySheet.submit();
		}
		function Show_divSection(index)
		{
		if (index=='1')
		{
		frmProjectDataPointEntrySheet.action ="../Metrics/ProjectDataPoint_EntrySheet.aspx?ShowProjectDiv=1";
		frmProjectDataPointEntrySheet.submit();
		}
		else if (index=='2')
		{
		frmProjectDataPointEntrySheet.action ="../Metrics/ProjectDataPoint_EntrySheet.aspx?ShowPhaseDiv=1";
		frmProjectDataPointEntrySheet.submit();
		}
		else if (index=='3')
		{
		frmProjectDataPointEntrySheet.action ="../Metrics/ProjectDataPoint_EntrySheet.aspx?ShowMilestoneDiv=1";
		frmProjectDataPointEntrySheet.submit();
		}
		//Added by GokulP on 20 Jan 2010 for Deliverable Tab
		else if (index=='4')
		{
		frmProjectDataPointEntrySheet.action ="../Metrics/ProjectDataPoint_EntrySheet.aspx?ShowDeliverableDiv=1";
		frmProjectDataPointEntrySheet.submit();
		}
		//End of Addition by GokulP on 20 Jan 2010 for Deliverable Tab 
		}
		function Hide_divSection(index)
		{
		if (index=='1')
		{
		frmProjectDataPointEntrySheet.action ="../Metrics/ProjectDataPoint_EntrySheet.aspx?ShowProjectDiv=0";
		frmProjectDataPointEntrySheet.submit();
		}
		else if (index=='2')
		{
		frmProjectDataPointEntrySheet.action ="../Metrics/ProjectDataPoint_EntrySheet.aspx?ShowPhaseDiv=0";
		frmProjectDataPointEntrySheet.submit();
		}
		else if (index=='3')
		{
		frmProjectDataPointEntrySheet.action ="../Metrics/ProjectDataPoint_EntrySheet.aspx?ShowMilestoneDiv=0";
		frmProjectDataPointEntrySheet.submit();
		}
		//Added by GokulP on 20 Jan 2010 for Deliverable Tab 
		else if (index=='4')
		{
		frmProjectDataPointEntrySheet.action ="../Metrics/ProjectDataPoint_EntrySheet.aspx?ShowDeliverableDiv=0";
		frmProjectDataPointEntrySheet.submit();
		}
		//End of Addition by GokulP on 20 Jan 2010 for Deliverable Tab 
		}
		function Close_OnClick()
		{
			window.close();
		}
		
		
		
		function Tab_OnClick(TabID)
		{
		  	frmProjectDataPointEntrySheet.action = "../Metrics/ProjectDataPoint_EntrySheet.aspx?FromTab=" + TabID + "&MasterTagID=2518&FromWhere=PM&SnapShotDate=<%=m_strSnapShotdate%>";
			frmProjectDataPointEntrySheet.submit()
		}
		
		</Script>
				
	</body>
</HTML>
