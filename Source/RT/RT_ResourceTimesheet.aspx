<%-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%CommonFunctions.General.PlotPageHeadTag("")%>--%>
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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="RT_ResourceTimesheet.aspx.vb" Inherits="PbNIT.RT_ResourceTimesheet" %>

<!--Added and commented by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common list Page-->
<HTML>
	<HEAD>
		<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="frmRT_ResourceTimesheet" method="post" runat="server">
			<%PageInit%>
		</form>
        <style>
            /*Added By Nikhil A on 25-nov-2015 for plot the task name in one TD*/
            .clsGridTable .clsTRColumnHeader td:first-child
            {
                width:1% !important;
            }
            /*End of Added By Nikhil A on 25-nov-2015 for plot the task name in one TD*/
        </style>
		<Script language="javascript">
		
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>

		var objform=GetFormReference('frmRT_ResourceTimesheet');
		var objdivlist=GetObjectReference('frmRT_ResourceTimesheet','PageDiv');
		// Added By PradeepD on 28-Nov-2005 to resolve Tavant Issue 21436 Duplicated Resource Timesheets
		var blnIsSaveClicked =0;
		// END: Added By PradeepD on 28-Nov-2005 to resolve Tavant Issue 21436 Duplicated Resource Timesheets

		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    //if (browser == 'FF')
			        //Commented and Added by Dhanashri S on 7 Dec 2015 For IssueID:2030
			        //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 198;
			        intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
                //End of Comment and Addition by Dhanashri S on 7 Dec 2015
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';
			//alert(objdivlist.style.height)
            }
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			    //Commented and Added by Dhanashri S on 7 Dec 2015 For IssueID:2030
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 198;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;
			    //End of Comment and Addition by Dhanashri S on 7 Dec 2015
			    if (intDivHeight < 100) intDivHeight = 100;
			    //Comment added on 11 Dec 2015 by Viraj P
			    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';
			}
		}
		function WhichBrowser() {

		    var brwser = '';
		    var ua = navigator.userAgent, tem,
            M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
		    if (/trident/i.test(M[1])) {
		        tem = /\brv[ :]+(\d+)/g.exec(ua) || [];
		        //return 'IE '+(tem[1] || '');
		        return 'IE';
		    }
		    if (M[1] === 'Chrome') {
		        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
		        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
		        brwser = 'CR';
		    }
		    else if (M[1] === 'Firefox') {
		        tem = ua.match(/\b(OPR|Edge)\/(\d+)/);
		        if (tem != null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
		        brwser = 'FF';
		    }
		    M = M[2] ? [M[1], M[2]] : [navigator.appName, navigator.appVersion, '-?'];
		    if ((tem = ua.match(/version\/(\d+)/i)) != null) M.splice(1, 1, tem[1]);
		    //return M.join(' ');
		    return brwser;
		}
		function ViewTimesheet(dtFromDate,dtToDate,strAction)
		{
		
			objform.action = "RT_ResourceTimesheet.aspx?FromDate=" + dtFromDate + "&ToDate=" + dtToDate + "&Action=" + strAction
			objform.submit();
		}
		
		function ExpandCollapse_Onclick(group,IsExpanded)
		{
				var strGroup1IsExpanded;
				var strGroup2IsExpanded;
				
				var strQueryString = GetObjectReference('frmRT_ResourceTimesheet','txtQuerystring').value;
				var strGroup1IsExpanded = GetObjectReference('frmRT_ResourceTimesheet','txtGroup1IsExpanded').value;
				var strGroup2IsExpanded = GetObjectReference('frmRT_ResourceTimesheet','txtGroup2IsExpanded').value;
				
				if (group == "Fortnight - 1")
				{
					if (IsExpanded == "0")
					{
						strGroup1IsExpanded = "1"
					}
					else
					{
						strGroup1IsExpanded = "0"
					}
				}
				
				if (group == "Fortnight - 2")
				{
					if (IsExpanded == "0")
					{
						strGroup2IsExpanded = "1"
					}
					else
					{
						strGroup2IsExpanded = "0"
					}
			
				}
				
				window.location.href = "RT_ResourceTimesheet.aspx?Group=" + group + "&Group1IsExpanded=" + strGroup1IsExpanded + "&Group2IsExpanded=" + strGroup2IsExpanded + strQueryString ;

		}
		
		function GenerateTimesheetFromList_OnClick()
		{
			var dtFromDate = GetObjectReference('frmRT_ResourceTimesheet','txtFromDate').value;
			var dtToDate = GetObjectReference('frmRT_ResourceTimesheet','txtToDate').value;
			var strMessage = GetObjectReference('frmRT_ResourceTimesheet','txtMessage').value;
		
			var intExpectedHrs = parseFloat(GetObjectReference('frmRT_ResourceTimesheet','txtExpectedHrs').value);
			var intActualHrs = parseFloat(GetObjectReference('frmRT_ResourceTimesheet','txtActualHrs').value);
			var strResponse;
			
			if (intActualHrs < intExpectedHrs)
			{

				strResponse = window.confirm(strMessage)
				if (strResponse==true)
				{
					objform.action = "RT_ResourceTimesheet.aspx?FromDate=" + dtFromDate + "&ToDate=" + dtToDate + "&Action=Edit&Mode=Generate&FromWhere=List"
					objform.submit();
				}
			}
			else
			{
				objform.action = "RT_ResourceTimesheet.aspx?FromDate=" + dtFromDate + "&ToDate=" + dtToDate + "&Action=Edit&Mode=Generate&FromWhere=List" + "&PKToken=<%=m_strTokenViewTimesheet%>"
				objform.submit();
			}
		}
		
		function GenerateTimesheet_OnClick()
		{

			var dtFromDate = GetObjectReference('frmRT_ResourceTimesheet','txtFromDate').value;
			var dtToDate = GetObjectReference('frmRT_ResourceTimesheet','txtToDate').value;
			var strMessage = GetObjectReference('frmRT_ResourceTimesheet','txtMessage').value;
		
			var intExpectedHrs = parseFloat(GetObjectReference('frmRT_ResourceTimesheet','txtExpectedHrs').value);
			var intActualHrs = parseFloat(GetObjectReference('frmRT_ResourceTimesheet','txtActualHrs').value);
			var strResponse;	
			// Added By PradeepD on 28-Nov-2005 to resolve Tavant  Issue  21436 Duplicate Timesheets 
			if (blnIsSaveClicked == 1) return; 
			//Modified For IssueID - Whiz6.0 - 2407
				//	blnIsSaveClicked =1;
				
			// Added By PradeepD on 28-Nov-2005 to resolve Tavant  Issue  21436 Duplicate Timesheets  			
			
			
			if (intActualHrs < intExpectedHrs)
			{
				strResponse = window.confirm(strMessage)
				if (strResponse==true)
				{
					//Modified For IssueID - Whiz6.0 - 2407
					blnIsSaveClicked =1;
					//objform.action = "RT_ResourceTimesheet.aspx?FromDate=" + dtFromDate + "&ToDate=" + dtToDate + "&Action=Edit&Mode=Generate&FromWhere=List"
					//objform.submit();
					
					objform.action = "RT_ResourceTimesheet.aspx?FromDate=" + dtFromDate + "&ToDate=" + dtToDate + "&Action=Edit&Mode=Generate&FromWhere=View"
					objform.submit();
				}
				
			}
			else
			{
					objform.action = "RT_ResourceTimesheet.aspx?FromDate=" + dtFromDate + "&ToDate=" + dtToDate + "&Action=Edit&Mode=Generate&FromWhere=View" + "&PKToken=<%=m_strTokenViewTimesheet%>"
					objform.submit();
			}
			
			//var dtFromDate = GetObjectReference('frmRT_ResourceTimesheet','txtFromDate').value;
			//var dtToDate = GetObjectReference('frmRT_ResourceTimesheet','txtToDate').value;
	
			//objform.action = "RT_ResourceTimesheet.aspx?FromDate=" + dtFromDate + "&ToDate=" + dtToDate + "&Action=Edit&Mode=Generate&FromWhere=View"
			//objform.submit();

		}

		function RegenerateTimesheet_OnClick(intTimesheetID)
		{
				var dtFromDate = GetObjectReference('frmRT_ResourceTimesheet','txtFromDate').value;
				var dtToDate = GetObjectReference('frmRT_ResourceTimesheet','txtToDate').value;
				//Condition Added by Noble K 13th Jan 2005
				if (parseInt("<%=m_intDACountForTimesheetPeriod%>") > 0)
							
				{
					objform.action = "RT_ResourceTimesheet.aspx?FromDate=" + dtFromDate + "&ToDate=" + dtToDate + "&Action=Edit&Mode=Regenerate&TimesheetID=" + intTimesheetID
					objform.submit();
				}
				else
				{
					alert("No DA Present for the period between '" + dtFromDate + "' and '" + dtToDate + "'.");
					//return false;
				}
				//End of Addition by Noble K 13th Jan 2005
		}
		
		function ReadyForVerification_OnClick(intTimesheetID)
		{
		   
				var dtFromDate = GetObjectReference('frmRT_ResourceTimesheet','txtFromDate').value;
				var dtToDate = GetObjectReference('frmRT_ResourceTimesheet','txtToDate').value;
					//ADded by VidyaJ For IssueID - RT Performance Issue - 86 (SP4)
				var strMsg
				var strProject
				

				strProject='<%=Replace(m_strProjectList,"'","\'")%>';
				if (strProject!='')
				{
				
					strMsg='<%=mybase.GetResourceString("APPROVERNOTSET")%>'
					strMsg=replaceSubstring(strMsg,"<PROJECTLIST>",strProject)
					alert(strMsg);
					return;
				}
				//End Of Addition
				
				
				//Get the Project Total Hrs and the hours from the DA
				var intTotalHrs = parseFloat(GetObjectReference('frmRT_ResourceTimesheet','txtTotalHrs').value);
				var intProjectTotalHrs = parseFloat(GetObjectReference('frmRT_ResourceTimesheet','txtProjectTotalHrs').value);
				var strMsg = GetObjectReference('frmRT_ResourceTimesheet','txtMsg').value;
				
				if (intTotalHrs > intProjectTotalHrs )
				{
					alert(strMsg);
				}
				else
				{

				<% '//Modified By VidyaJ - IssueID - 11778 %>
				
					if('<%=mblnZeroHrsDA%>'=='True')
					{
						alert('Timesheet cannot be sent for approval as Total Daily activity filled for timesheet period is Zero');
						return;
					} 				
					<%
						IF Ctype(Request.QueryString("Mode"),string) = "Regenerate" Then 
					%>				
						objform.action = "RT_ResourceTimesheet.aspx?FromDate=" + dtFromDate + "&ToDate=" + dtToDate + "&Action=Edit&Mode=ReadyForVerification&TimesheetID=" + intTimesheetID + "&EmailMode=" + "Regenerate"
					<%Else%>
						objform.action = "RT_ResourceTimesheet.aspx?FromDate=" + dtFromDate + "&ToDate=" + dtToDate + "&Action=Edit&Mode=ReadyForVerification&TimesheetID=" + intTimesheetID + "&EmailMode=" + "Generate"
					<%End If%>
					objform.submit();
				}

		}
		
		function Report_OnClick(intTimesheetID,intVal)
		{
		//Modified and Commented By VarunA on 30-Sep-2008 
		//Purpose : To have older report
		//Commented by ShraddhaM on 10,Sep 2007 for Timesheet report changes
			//Added By DiptiK on 13 oct 2k4
			
			// Weekly Resource Timesheet
			if(intVal<= 7)
			{
				window.open("../CRW/CRW_ReportUIBuilder.aspx?ReportID=1860&UniqueID=" + intTimesheetID, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=550,height=500")
			}
			else
			{
				// Fortnightly Resource Timesheet
				if (intVal<=15)
				{
				   window.open("../CRW/CRW_ReportUIBuilder.aspx?ReportID=1862&UniqueID=" + intTimesheetID, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=550,height=350")
				}
				else
				//Monthly Resource Timesheet
				{
				 window.open("../CRW/CRW_ReportUIBuilder.aspx?ReportID=1863&UniqueID=" + intTimesheetID, "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=550,height=350")
				}
			}
			//Addition Ends
			//End of comment by ShraddhaM
			//Added by ShraddhaM  on 10,Sep 2007 for Timesheet report changes
			//window.open("../TimesheetReport/TimesheetReport.aspx?TimesheetID="+ intTimesheetID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=650,height=450");
			//End of additon by ShraddhaM  on 10,Sep 2007 for Timesheet report changes
		//End By VarunA on 30-Sep-2008 
		}
		
		function Back_OnClick(strMode,strAction)
		{
			//Modified By VidyaJ on March 1st 2004 For IssueID :16580
			
			//Modified by MrugajaB on 02-Apr-2005
			//Purpose: When there are no pending timesheets txtFromDate and txtTodate are not created
			var dtFromDate;
			var dtToDate;
			<%If m_strAction <> "NoPending" Then%>
			{
			if(GetObjectReference('frmRT_ResourceTimesheet','txtFromDate')!=null)
			    dtFromDate = GetObjectReference('frmRT_ResourceTimesheet','txtFromDate').value;
			
			if(GetObjectReference('frmRT_ResourceTimesheet','txtToDate')!=null)    
			    dtToDate = GetObjectReference('frmRT_ResourceTimesheet','txtToDate').value;
			}
			<%End If%> 
			//End Modification
			if(strMode == '') 
			{	
				//Modified by MrugajaB on 02-Apr-2005
				//Purpose: When there are no pending timesheets txtFromDate and txtTodate are not created
				<%If m_strAction <> "NoPending" Then%>
					window.location.href = "../General/CommonList.aspx?MasterTagID=<%=m_TagMyTimesheets%>&Action=" + strAction + "&FromDate=" + dtFromDate + "&ToDate=" + dtToDate ;
				<%Else%>
					window.location.href = "../General/CommonList.aspx?MasterTagID=<%=m_TagMyTimesheets%>&Action=" + strAction ;
				<%End If%>
				//End Modification
			}	
			else
			{
				window.location.href = "RT_ResourceTimesheet.aspx?Mode=" + strMode + "&Action=" + strAction+ "&FromDate=" + dtFromDate + "&ToDate=" + dtToDate ;
			}
			//Modifications Ends
		}

		function Task_OnClick(dtEntryDate, intTaskID)
		{
			window.open("../General/CommonList.aspx?FromWhere=PM&MasterTagId=<%=m_TagTaskDetails%>&TaskID=" + intTaskID + "&EntryDate=" + dtEntryDate,null,"Left=150,Top=150,height=450,width=550,status=no,toolbar=no,menubar=no,location=no,resizable=yes")
		}
		
		function ShowRemarks_OnClick(intTimesheetID)
		{
			window.open("../General/CommonList.aspx?FromWhere=PM&MasterTagId=<%=m_TagShowRemarks%>&ResourceTimesheetID=" + intTimesheetID,null,"Left=150,Top=150,height=450,width=700,status=no,toolbar=no,menubar=no,location=no,resizable=yes")
		}
		
		//Added For History functionality
		function ShowHistory_OnClick(intTimesheetID)
		{
			window.open("../General/CommonList.aspx?FromWhere=PM&MasterTagId=<%=m_TagTimesheetHisotryForEmployee%>&ResourceTimesheetID=" + intTimesheetID,null,"Left=150,Top=150,height=450,width=860,status=no,toolbar=no,menubar=no,location=no,resizable=yes")
		}
		//End Addition
		
		</Script>
	</body>
</HTML>
