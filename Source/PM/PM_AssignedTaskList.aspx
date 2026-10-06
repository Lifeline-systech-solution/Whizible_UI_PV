<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_AssignedTaskList.aspx.vb" Inherits="PbNIT.PM_AssignedTaskList"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_TITLE"))%>
    <head>
		<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
		<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
		<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<script src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }
      .clsGridTable tr td a
    {
        text-decoration:underline !important; /* ADDED BY Vaijat K ON 18/12/2015 ANCHOR UNDERLINE IN GRID */
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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>

    </head>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmPM_AssignedTaskList" method="post" runat="server">
				<%PageInit%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmPM_AssignedTaskList');
		var objdivlist=GetObjectReference('frmPM_AssignedTaskList','PageDiv');
		
		<%' Added By SonalD on 13th Jan 2009 %>
	    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		    <%End If%>

		    <%' Added By SonalD on 13th Jan 2009 %>
		    //Added BY Bharat T on 26th-Nov-2015
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
		    //End of added  BY Bharat T on 26th-Nov-2015
		//The div tag has id as PageDiv 
		function window_onload()
		{
		//Modified By VidyaJ - Browser Issue - IssueID - 809 
		//if condition is added by RajashriK for netscape implementation on 21.3.2005
		//Divlist is modified for netscape on 11.4.2005
		if (objdivlist != null) 
		{ 
             <%'Commented And Edited by KIRAN K K  For footer line alignment 16-11-15%>
		    //	if(navigator.appName == 'Netscape')
		//    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop+120;
		//else
		//		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		//    if (intDivHeight < 100)	
		//    {intDivHeight = 100};
			
		    //    objdivlist.style.height = intDivHeight;
		    var browser = WhichBrowser();		
		    if (browser == 'IE') { 
		        intDivHeight = window.innerHeight - objdivlist.offsetTop - 35;
		    }
		    else if(browser == 'FF')
		    {
		        intDivHeight = window.innerHeight - objdivlist.offsetTop - 38; 
		    }
		    else{ 
		        intDivHeight = window.innerHeight - objdivlist.offsetTop - 35; 
		    }
                 <%'Commented And Edited by KIRAN K K  For footer line alignment 16-11-15%>
		    if (intDivHeight < 100)
		        intDivHeight = 100; 
		    <%'Commented And Edited  by KIRAN K K  For footer line alignment 16-11-15%> 
		    objdivlist.style.height = intDivHeight+"px";	
                <%'Commented And Edited End by KIRAN K K  For footer line alignment 16-11-15%>  
		}
		}
		
		function window_onresize()		
		{
		    //Modified By VidyaJ - Browser Issue - IssueID - 809 
            //Modified BY Bharat T on 26th-Nov-2015
		    var browser = WhichBrowser();		
		if (objdivlist !=null) 
		{
			var intDivHeight;
			//if condition is added by RajashriK for netscape implementation on 21.3.2005
			//Divlist is modified for netscape on 11.4.2005
			if(browser == 'IE')
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop ;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 35;
			else if(browser == 'FF')	
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 38; 
			else
			    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 35; 

			if (intDivHeight < 100)	intDivHeight = 100;
		    //Commented and added by Yogesh J on 11/12/2015
		    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
		}		
		    //End of Modified BY Bharat T on 26th-Nov-2015
		}	
		
		function Sort_OnClick(strFieldName, strAscOrDesc)
		{
			var objSortBy, objSortOrder;
			objSortBy = GetObjectReference('frmPM_AssignedTaskList','txthidSortBy');
			objSortOrder = GetObjectReference('frmPM_AssignedTaskList','txthidSortOrder');
			objSortBy.value = strFieldName;
			objSortOrder.value = strAscOrDesc;
			objform.submit();
		}
		
		function Page_Onclick(strPageNo)
		{
			objform.action = "PM_AssignedTaskList.aspx?MasterTagId=<%=m_lngTagId%>&PageNumber=" + strPageNo;
			objform.submit();
		}
		
		//Function for grouping
		function ExpandCollapse_OnClick(group, IsExpanded)
		{//debugger;
			var strGroup;
			if(IsExpanded == "1")
				IsExpanded = "0";
			else
				IsExpanded = "1";
			if(group == "Current")
				strGroup = "<%=GROUP_CURRENT%>";
			else if(group == "Baseline")
				strGroup = "<%=GROUP_BASELINE%>";
			else if(group == "Actual")
				strGroup = "<%=GROUP_ACTUAL%>";
			objform.action = "PM_AssignedTaskList.aspx?MasterTagId=<%=m_lngTagId%>&Operation=<%=OPERATION_SHOW_HIDE%>&Group=" + strGroup + "&Show=" + IsExpanded + "&PageNumber=<%=Server.URLEncode(m_strPageNumber)%>" ;
			objform.submit();
		}
		
		function FilterTasks()
		{
	
			objform.action = "PM_AssignedTaskList.aspx?MasterTagId=<%=m_lngTagId%>&PageNumber=<%=Server.URLEncode(m_strPageNumber)%>" ;
			objform.submit();			
		}
		
		function AssignNewTask_OnClick()
		{
			var strFilter;
			//Added By VidyaJ on Jan 12, 2005
			 if ("<%=m_blnIsProjectCreationWorkflowReqd%>"== "True")
			 {
			      if ("<%=m_intBaselineNumber%>"== 0)
			      {
			      
						alert("<%=m_strBaselineMessage%>" );
                        return;
                  }
             }           
             //End of addition - 
			
//			Now don't want the check of Project Baselined or not. Modified by JayavantK - Date: 4-Jun-04	- Start	
/*			if(parseInt("<%=m_intRevisionNo%>") > 0)
			{
				strFilter = GetFilterQueryString();
				window.location.href = "PM_TaskAssignment.aspx?Mode=New&MasterTagID=<%=m_lngTagId%>&PageNumber=<%=m_strPageNumber%>" + strFilter;
			}
			else
				alert("<%=MyBase.GetResourceString("NOT_BASELINED_PROJECT")%>");*/
			//Added by Priyanka, 6th Sep 2004
			//Check if the Project Status (should not be OnHold) before allowing to create new tasks for the Project
			if ("<%=m_blnProjectOnHold%>" == "True")
			{
				alert("<%=m_strProjectOnHoldMsg%>")
			}
			else
			{
				window.location.href = "PM_TaskAssignment.aspx?Mode=New&MasterTagID=<%=m_lngTagId%>&PageNumber=<%=Server.URLEncode(m_strPageNumber)%>" + strFilter;
			}
//			Now don't want the check of Project Baselined or not. Modified by JayavantK - Date: 4-Jun-04	- End		
	    }
	    
	    function AddDeferredTask_OnClick()
	    {
	        objform.action = "PM_TaskAssignment.aspx?Mode=New&Type=Deferred&MasterTagID=<%=m_lngTagId%>&PageNumber=<%=Server.URLEncode(m_strPageNumber)%>";
			objform.submit();
	    }
	    
	    function VoidTasks_OnClick()
	    {
			var objChkVoid, i, blnSelected;
			
			objChkVoid = GetObjectReference('frmPM_AssignedTaskList','chkVoid',true);
			if(objChkVoid == null)
				return;
			blnSelected = false;
			for(i=0; i < objChkVoid.length; i++)
			{
				if(objChkVoid[i].checked == true)
				{
					blnSelected = true;
					break;
				}
			}
			if(blnSelected == false)
			{
				alert("<%=MyBase.GetResourceString("SELECT_TASKS_TO_VOID")%>");
				return;
			}
			//Modified by Harshk for sp4 issueid 136		
			if(confirm(replaceSubstring("<%=MyBase.GetResourceString("CONFIRM_VOID")%>","&#39;","'")) == true)
			{ 
			//End Modified by Harshk for sp4 issueid 136		
				objform.action ="PM_AssignedTaskList.aspx?Operation=<%=OPERATION_VOID%>&MasterTagID=<%=m_lngTagId%>&PageNumber=<%=Server.URLEncode(m_strPageNumber)%>";
				objform.submit();
			}
		}
		
		
        //Modified by MrugajaB on 18th Sept 2006 for Whiziblesem Issue ID.6197
        //Purpose:Added additional parameter 'Token'
		function ShowAssignedTask(intTaskId,m_strToken)
		{
			var strFilter;
			
			strFilter = GetFilterQueryString();
			window.location.href = "PM_TaskAssignment.aspx?TaskId=" + intTaskId + "&Mode=Edit&MasterTagID=<%=m_lngTagId%>&PageNumber=<%=Server.URLEncode(m_strPageNumber)%>" + strFilter + "&PkToken=" + m_strToken;
		}
		//End Modification
		
		function ShowBaseline(intTaskID)
		{
		    //Commented and added by Yogesh J on 02-Feb-2016 to generate Token
		//    window.open ("../PM/PM_ShowBaseline.aspx?TaskId=" + intTaskID + "&FromWhere=AssignedTask", "_ShowBaseline", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=700,height=450");

		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'PM_AssignedTaskList.aspx/GenrateURLToken_ShowBaseline_OnClick',
		        data: JSON.stringify({ TaskID: intTaskID, EmployeeID: "<%=Session("intUserID")%>" }),
		        success: function (Result) {   
		            window.open ("../PM/PM_ShowBaseline.aspx?TaskId=" + intTaskID + "&EmployeeID=<%=Session("intUserID")%>&PKToken="+ Result.d +"&FromWhere=AssignedTask", "_ShowBaseline", "resizable=no,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 450)/2 + ",width=700,height=450");

			        },
			        error: function () {
			            //      alert("Error")
			        }
			    });
		    //End of addition by Yogesh J on 02-Feb-2016 to generate Token
		}
		
		function GetFilterQueryString()
		{
			var objEmployeeID, objDeparmentID, objTasks, objStatus, objIsTaskCompleted;  
//			var objDeliverableID, objGroupID; 
			var objSortBy, objSortOrder; 
			var strFilterQueryString = "", intCtr;

			objTasks = GetObjectReference('frmPM_AssignedTaskList','optTasks', true);
			if(objTasks != null) 
			{
				for(intCtr=0; intCtr < objTasks.length; intCtr++)			
				{
					if(objTasks[intCtr].checked == true)
					{
						strFilterQueryString = strFilterQueryString + "&optTasks=" + objTasks[intCtr].value;
						break;
					}
				}
			}				

			objStatus = GetObjectReference('frmPM_AssignedTaskList','optStatus', true);
			if(objStatus != null) 
			{
				for(intCtr=0; intCtr < objStatus.length; intCtr++)			
				{
					if(objStatus[intCtr].checked == true)
					{
						strFilterQueryString = strFilterQueryString + "&optStatus=" + objStatus[intCtr].value;
						break;
					}
				}
			}				

			objEmployeeID = GetObjectReference('frmPM_AssignedTaskList','cboFilter_EmployeeID');
			if((objEmployeeID != null) && (objEmployeeID.selectedIndex > 0))
				strFilterQueryString = strFilterQueryString + "&cboFilter_EmployeeID=" + objEmployeeID[objEmployeeID.selectedIndex].value;

			objDeparmentID = GetObjectReference('frmPM_AssignedTaskList','cboFilter_DepartmentID');
			if((objDeparmentID != null) && (objDeparmentID.selectedIndex > 0))
				strFilterQueryString = strFilterQueryString + "&cboFilter_DepartmentID=" + objDeparmentID[objDeparmentID.selectedIndex].value;
/*
			objDeliverableID = GetObjectReference('frmPM_AssignedTaskList','cboFilter_DeliverableID');
			if((objDeliverableID != null) && (objDeliverableID.selectedIndex > 0))
				strFilterQueryString = strFilterQueryString + "&cboFilter_DeliverableID=" + objDeliverableID[objDeliverableID.selectedIndex].value;
				
			objGroupID = GetObjectReference('frmPM_AssignedTaskList','cboFilter_GroupID');
			if((objGroupID != null) && (objGroupID.selectedIndex > 0))
				strFilterQueryString = strFilterQueryString + "&cboFilter_GroupID=" + objGroupID[objGroupID.selectedIndex].value;
*/
			objIsTaskCompleted = GetObjectReference('frmPM_AssignedTaskList','cboFilter_IsTaskCompleted');
			if((objIsTaskCompleted != null) && (objIsTaskCompleted.selectedIndex > 0))
				strFilterQueryString = strFilterQueryString + "&cboFilter_IsTaskCompleted=" + objIsTaskCompleted[objIsTaskCompleted.selectedIndex].value;

			objSortBy = GetObjectReference('frmPM_AssignedTaskList','txthidSortBy');
			strFilterQueryString = strFilterQueryString + "&txthidSortBy=" + objSortBy.value;

			objSortOrder = GetObjectReference('frmPM_AssignedTaskList','txthidSortOrder');
			strFilterQueryString = strFilterQueryString + "&txthidSortOrder=" + objSortOrder.value;

			return strFilterQueryString;
		}
		
		//Added by DipaliS 5 Nov 2004
		//To view the voided tasks
		function ShowVoidedTasks()
		{
			window.open("../General/CommonList.aspx?FromWhere=PM&MasterTagID=2260","","resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500"); 
		}
		//End addition by DipaliS
		
		// Code added by SwapnilR on 7th Nov 2006
		// Purpose : Javascript function for task copy code is same as that of new task addition
		//			 only change is task id is passed as CopyTask Querystring parameter
		function Copy_Task(TaskID)
		{
			var strFilter;
			//Added By VidyaJ on Jan 12, 2005
			 if ("<%=m_blnIsProjectCreationWorkflowReqd%>"== "True")
			 {
			      if ("<%=m_intBaselineNumber%>"== 0)
			      {			      
						alert("<%=m_strBaselineMessage%>" );
                        return;
                  }
             }           
             //End of addition - 			

			//Added by Priyanka, 6th Sep 2004
			//Check if the Project Status (should not be OnHold) before allowing to create new tasks for the Project
			if ("<%=m_blnProjectOnHold%>" == "True")
			{
				alert("<%=m_strProjectOnHoldMsg%>")
			}
			else
			{
				window.location.href = "PM_TaskAssignment.aspx?Mode=New&CopyTask="+TaskID+"&MasterTagID=<%=m_lngTagId%>&PageNumber=<%=Server.URLEncode(m_strPageNumber)%>" + strFilter;
			}
			// Now don't want the check of Project Baselined or not. Modified by JayavantK - Date: 4-Jun-04	- End		
	    }
	    // End of code addition by SwapnilR on 7th Nov 2006
	    //''Added by PrashantSJ on 24th July 2009 Purpose: To have Ganttchart view SEM 9.0
	    function GraphicalView_OnClick()
	    {
	        window.location.href="../Home/GanttChartView.aspx?From_Where=HRHome&MasterTagID=1038&GanttChartType=1";
	    }
	    
	    // ''End of addition by PrashantSJ on 24th July 2009
	    
	    //Commented and added by NitinC on 26 August 2011 For WhizibleSEM v10.0 (Agile Methodology)
	    function ShowEntityPage(ID,Flag)
		{
		    //debugger;
		    if (Flag == "RELEASE")
		    {
		        window.open("../PM/Releases_CommonPage.aspx?ReleaseID_PK=" + ID +"&MasterTagID=8083&FromWhere=PM" ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",width=800,height=550");
		        
		        //../General/CommonPage.aspx?MastertagID=20121&<PARAMETERS>,"MyPage","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=600,height=400"
		        //http://localhost/WhizibleSEM10.0/Source/General/CommonPage.aspx?ReleaseID_PK=18&PKToken=CtkJ4r9WgFYvvlNmMoZ0/w&MasterTagID=8083&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1
		    }
		    if (Flag == "ITERATION")
		    {
		        window.open("../PM/Iterations_CommonPage.aspx?IterationID_PK=" + ID +"&MasterTagID=8084&FromWhere=PM" ,"","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-500)/2 + ",width=800,height=550");
		    } 
		}
		//End 
		</Script>
	</body>
</HTML>
