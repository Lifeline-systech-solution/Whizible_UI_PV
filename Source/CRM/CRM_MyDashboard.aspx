<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_MyDashboard.aspx.vb" Inherits="PbNIT.CRM_MyDashboard" %>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag("CRM Dashboard")%>
	<link rel='stylesheet' type='text/css' href='../Home/Home.css'/>
	<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>
    <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>

<!--Including files & Libraries by Miiint Solutions-->
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
     /*Cmmented added by Shamkant S on  23 Nov 2015*/
     #txtPageNumber 
    {
        height:20px;
    }
     /*Added by Dhanashri S on 2 Dec 2015 For IssueID:1943*/

    .clsTable td 
    {
        vertical-align: baseline !important;
    }
     
     INPUT.clsTextBox 
    {
        font-family: "Helvetica";
        font-size: 12px;
        border-width: 1px;
        border-style: solid;
        border-color: #CCC;
        background-color: #FFF;
        vertical-align: baseline !important;
    }
    /*End of Addition by Dhanashri S on 2 Dec 2015 For IssueID:1943*/
    #tblContextMenu {
        width:auto;
    }
    #Description td {
        white-space:nowrap; /*Added by Yogesh J on 15/01/2016*/
    }
    tr.clsTREven 
    {
        font-family: "Helvetica";
        font-size: 12px;
        padding-right: 2pt;
        padding-left: 2pt;
        padding-bottom: 2pt;
        margin: 2pt;
        color: #000000;
        padding-top: 2pt;
        background-repeat: repeat;
        height: 19px;
        background-color: #fff !important;
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
            //removeSectionHeader();            //Commented By Puneet M on 02-Nov-2015
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        //Commented By Puneet M on 02-Nov-2015
        //if($('.clsgridtable').length > 0)
        //{
        //    var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
        //    dataCollapse(divName);
        //}
        //Added By Puneet M on 02-Nov-2015
        if($('.clsPageBody').find("#frmMyDashboard").find("#divGrid").length > 0)
        {
            var divName=$('.clsPageBody').find("#frmMyDashboard").find("#divGrid").attr('id');
            divDatacollapse(divName);
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body class="clsPageBody" MS_POSITIONING="GridLayout" onresize="window_onresize()" onload="window_onload()" onmouseup="Doc_OnmouseUp()">
		<form id='frmMyDashboard' method='post' runat='server'>
		<div id="fillDiv" style="DISPLAY: none;Z-INDEX: 100;FILTER: alpha(opacity=60);LEFT: 0px;VISIBILITY: visible;WIDTH: 100%;POSITION: absolute;TOP: 0px;HEIGHT: 100%;BACKGROUND-COLOR: #d1d1d1"></div>			
		
		<%WritePage()%>
		<div id="divGraphs" style="DISPLAY:none;OVERFLOW:auto" runat="server">
			<Table id="tblGraphs" runat="server" cellpadding="0" cellspacing="0" align="middle">
			</Table>
		</div>
		</div>
		<%=m_strMenu%>
		
		<div id='divATT' class='cxtMenu' style='overflow:auto;display:none;z-index:99;background:white;position:absolute;margin:0px;' >
        </div>
         <div id='divActivityDtls' style='OVERFLOW:auto;DISPLAY:none;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;WIDTH:80%;POSITION: absolute; TOP: 165px;Z-INDEX:19000'>
          </div>
          
           <div id='divStatistics' style='OVERFLOW:auto;DISPLAY:none;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;WIDTH:80%;HEIGHT:200px;POSITION: absolute; TOP: 165px;Z-INDEX:19000;background-color: white; '>
          </div>
          
		</form>
		<DIV class="FadingTooltip" id="FADINGTOOLTIP" style="Z-INDEX: 999; VISIBILITY: hidden; POSITION: absolute"></DIV>				
		 
		<script language="javascript">
		var objform;
		var objdivlist;
		var objchkSelect;
		var currentRow = 0;
        var highlightedRow;
        var trs ;
        var FeedBackQueryID ; 
		/*
			//Added By KapilGK On 19 Oct 2006
			var objFilter = GetObjectReference('frmDashboard','cboFilter');
			var objStatus = GetObjectReference('frmDashboard','cboStatus');
			var objLocation = GetObjectReference('frmDashboard','cboLocation');
			// End of Addition By KapilGK
		*/
		    <%' Added By Shamkant S on 8 Dec Jan 2015 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
		    disableRightClick();
		    <%End If%>
		    <%' Ended By Shamkant S on 8 Dec Jan 2015 %>
		objform = GetFormReference('frmMyDashboard');
		<%'Modifed By NitinVS on 12 Mar 2007 for PMLifeLine SP 8 Regression IssueID 11491%>
		<%'Changed the div name from DivList to divGrid%>
		objdivlist = GetObjectReference('frmMyDashboard','divGrid');
		<%'End Modification By NitinVS on 12 Mar 2007 for PMLifeLine SP 8 Regression IssueID 11491%>
		objchkSelect = GetObjectReference('frmMyDashboard','chkSelect',true);

		<%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
		function SetFilters_OnClick()
		{
			window.open ("CRM_FilterList.aspx?FromWhere=MD","_Filters","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=700,height=400");
		}
	
		function ClearFilters_OnClick()
		{
		    //Modified by SuchitraP on 4-Sept-2008 for showing Publish toKM and WF approvals links	
			//objform.action = "CRM_MyDashboard.aspx?Action=CLEAR_FILTERS&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=1";		
			objform.action = "CRM_MyDashboard.aspx?Mode=<%=m_strMode%>&Action=CLEAR_FILTERS&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=1";		
			//End by SuchitraP
			objform.submit();
		}
		
		// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		function Reject_OnClick(QueryID,strToken)
		{
			//window.open("CRM_RequestRejection.aspx?QueryID=" + QueryID ,"_Rejection","resizable=no,toolbars=no,scrollbars=no,width=550,height=360" );
			window.open("CRM_RequestRejection.aspx?QueryID=" + QueryID + "&PKToken=" + strToken ,"_Rejection","resizable=no,toolbars=no,scrollbars=no,width=550,height=360" );
		}
		// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		
		// START : Commented and Modified By ParagD 28-Sept-2006
		// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		//function AssignTask_OnClick(QueryID,ShowAssignLink)
		// function AssignTask_OnClick(QueryID,ShowAssignLink,strToken)
		function AssignTask_OnClick(QueryID,ShowAssignLink,strToken,strTaskID)
		{
			if (strTaskID != null)
			// window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&QueryID=" + QueryID + "&ShowAssignLink=" + ShowAssignLink ,"_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
			// window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&QueryID=" + QueryID + "&ShowAssignLink=" + ShowAssignLink + "&PKToken=" + strToken ,"_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
				window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&Action=Edit&QueryID=" + QueryID + "&ShowAssignLink=" + ShowAssignLink + "&PKToken=" + strToken + "&TaskID=" + strTaskID,"_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
			else
				window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&QueryID=" + QueryID + "&ShowAssignLink=" + ShowAssignLink + "&PKToken=" + strToken ,"_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 	
		}
		// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197	
		// END : Commented and Modified By ParagD 28-Sept-2006
		
//integrated by harshada d on 19 DEC 2005 for issue id 989 
	//Added by ManishK On 21th Nov 2005 for No of attachments attached to the Issue 
	function Document_OnClick(intQueryID,strToken)
	{
	//window.open ("../DB/DocumentType.aspx?QueryID=" + intQueryID + "&TagID=0&DocumentType=CRM","","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	window.open ("../DB/DocumentType.aspx?QueryID=" + intQueryID + "&TagID=0&DocumentType=CRM&PKToken=" + strToken,"","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=800,height=500");
	}
	//End of addition by ManishK On 21th Nov 2005 for No of attachments attached to the Issue 
	//end integration by harshada d 19 dec 2005 for issue id 989 

	function Select_OnClick(QueryID)
	{
	
	}
	
	
	// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
	//function AssignIssue_OnClick(QueryID)
	function AssignIssue_OnClick(QueryID,strToken)
	{
		//window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&QueryID=" + QueryID ,"_Assignment","resizable=yes,scrollbars=no,width=550,height=500"); 
		window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&QueryID=" + QueryID + "&PKToken=" + strToken,"_Assignment","resizable=yes,scrollbars=no,width=550,height=500"); 
	}
	// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		
		function AssignMultipleTasks_OnClick()
		{
			var count;
			var index;
			var QueryID="";
		
			count=<%=m_intNoOfRows%>;

			for (index=0;index < count;index++)
			{
				if (objchkSelect[index].checked==true) 
				{
					QueryID = QueryID + "," + objchkSelect[index].value;
				}
			}
						
			if (trimString(QueryID) == "")
			{
				alert("Please select the requests.");
				return;
			}
			QueryID = Right(QueryID,Len(QueryID) -1);
			// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
			// window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_MULTIPLE_TASKS&QueryID=" + QueryID ,"_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
			window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_MULTIPLE_TASKS&QueryID=" + QueryID + "&PKToken=<%=m_PKToken_Go_Behalf_ADD%>"  ,"_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
			// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		}
		
		function AssignMultipleRequests_OnClick()
		{
			var count;
			var index;
			var QueryID="";
		
			count=<%=m_intNoOfRows%>;
			
			for (index=0;index < count;index++)
			{
				if (objchkSelect[index].checked==true) 
				{
					QueryID = QueryID + "," + objchkSelect[index].value;
				}
			}
			 
			if (trimString(QueryID) == "")
			{
				alert("Please select the requests.");
				return;
			}
			QueryID = Right(QueryID,Len(QueryID) -1);
			// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
			// window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_REQUESTS&QueryID=" + QueryID ,"_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
			window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_REQUESTS&QueryID=" + QueryID + "&PKToken=<%=m_PKToken_Go_Behalf_ADD%>","_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
			// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		}

		// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		// Modified By NitinVS on 10 Aug 2005 for PMLifeLine SP4 IssueID 2 		
		// Changed the height to 625 and Top to 75

		// function Discussion_OnClick(queryid)
		function Discussion_OnClick(queryid,Token)
		{
			//window.open("CRM_DiscussionThread.aspx?QueryID=" + queryid ,"_Discussions","resizable=yes,scrollbars=no,left=100,top=75,width=600,height=625");
			window.open("CRM_DiscussionThread.aspx?QueryID=" + queryid + "&PKToken=" + Token,"_Discussions","resizable=yes,scrollbars=no,left=100,top=75,width=600,height=625");
			// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		}
		// End Modification By NitinVS on 10 Aug 2005 for PMLifeLine SP4 IssueID 2 	

		function Page_OnClick(page)
		{
		    //Modified by SuchitraP on 4-Sept-2008 for showing Publish toKM and WF approvals links
			//objform.action = "CRM_MyDashboard.aspx?SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=" + page;
			objform.action = "CRM_MyDashboard.aspx?Mode=<%=m_strMode%>&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=" + page;
			//End by SuchitraP
			objform.submit();
		}
		// Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		// function Query_OnClick(queryid)
		function Query_OnClick(queryid,Token)
		{
			
			//window.open("CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=DB&QueryID=" + queryid ,"_requestdetail","resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700"); 
			
			//PageNumber added by ShraddhaM on 1,Aug 2007			
			window.open("CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=MD&PageNumber=<%=m_intPageNumber%>&QueryID=" + queryid + "&PKToken=" + Token ,"_requestdetail","resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700"); 
			
		}
		
		//Added by HarshadaD on Date 3rd July 2006 for PMLifeLine Issue ID.4168
		//xmlHttp functions
			var objXMLHTTP;
		var intAssignTo ;
function loadXMLDoc(url,reqQuery)
{
// code for Mozilla, etc.

if (window.XMLHttpRequest)
  {
  
		xmlhttp=new XMLHttpRequest()
		xmlhttp.onreadystatechange=state_Change;
		if (ns)
		{
			xmlhttp.open("GET",url+"&"+reqQuery,true)
			xmlhttp.send(false)
		}
		else
		{
			xmlhttp.open("POST",url,true)
			xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
			xmlhttp.send(reqQuery)
		}
  
  
  }
	// code for IE
		else if (window.ActiveXObject)
	{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP")
		if (xmlhttp)
		{
			xmlhttp.onreadystatechange=state_Change
			xmlhttp.open("POST",url,true)
			
			xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
 			xmlhttp.send(reqQuery)
		}
	}

}

function state_Change()
{
// if xmlhttp shows "loaded"
if (xmlhttp.readyState==4)
			{
				if (xmlhttp.status==200)
				{
					//Added by Manishk on 25th Feb 2006 for PMLifeLine  for helpdesk enhancements for issue id 1936
					if (xmlhttp.responseText == "0")
					//End of Added by Manishk on 25th Feb 2006 for PMLifeLine for helpdesk enhancements for issue id 1936
					alert('Either Tasks ,Issues ,Deliverables or Resources are already mapped to this request ! so cannot move this request to Other Department');
					else
					window.open("CRM_EscalateHelpDeskRequest.aspx?fromwhere=FromMD&PKToken=" + strTokenChangeDept + "&QueryID=" + xmlhttp.responseText,"","resizable=yes,scrollbars=no,left=100,top=100,height=310,width=760"); 	
				}
				else
				{
					alert("Please click on Change Department again!")
				}
			}
}


//end of addition by HarshadaD on Date 3rd July 2006 for PMLifeLine Issue ID.4168

		// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197		
		//Added by SavitaS on 18 Nov 2005 to show "Change Department" Link on HelpDesk Page for IssueID 1936
		var strTokenChangeDept;		
		//function ChangeDepartment_OnClick(queryid)
		function ChangeDepartment_OnClick(queryid,strToken)
		{		
			strTokenChangeDept = strToken;
			// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197	
			
			 //Added by SavitaS on 08 Jan 2006 to show alert if tasks or Issues are not created against request.
			// var url="CRM_EscalateHelpDeskRequest.aspx?IsXMLHTTP=1&fromwhere=FromDB&QueryID=" + queryid;
			var url="CRM_EscalateHelpDeskRequest.aspx?IsXMLHTTP=1&fromwhere=FromMD&QueryID=" + queryid + "&PKToken=" + strToken;
			/*
			//modification by HarshadaD on Date 3rd July 2006 for PMLifeLine Issue ID.4168
			objXMLHTTP=new ActiveXObject("Microsoft.XMLHTTP");
			 
			objXMLHTTP.onreadystatechange=xmlhttpChange;
			objXMLHTTP.open("POST",url,true);
			objXMLHTTP.send(null);*/
			//window.open("CRM_EscalateHelpDeskRequest.aspx?IsXMLHTTP=1&fromwhere=FromDB&QueryID=" + queryid,"","resizable=yes,scrollbars=no,left=100,top=100,height=310,width=760"); 
			loadXMLDoc(url,null);
			
		}/*
		function xmlhttpChange()
		{
			if (objXMLHTTP.readyState==4)
			{
				if (objXMLHTTP.status==200)
				{
					//Added by Manishk on 25th Feb 2006 for PMLifeLine for helpdesk enhancements for issue id 1936
					if (objXMLHTTP.responseText == "0")
					//End of Added by Manishk on 25th Feb 2006 for PMLifeLine for helpdesk enhancements for issue id 1936
					alert('Either Tasks ,Issues ,Deliverables or Resources are already mapped to this request ! so cannot move this request to Other Department');
					else
					window.open("CRM_EscalateHelpDeskRequest.aspx?fromwhere=FromDB&QueryID=" + objXMLHTTP.responseText,"","resizable=yes,scrollbars=no,left=100,top=100,height=310,width=760"); 	
				}
				else
				{
					alert("Please click on Change Department again!")
				}
			}
		}*/
		//end of modification by HarshadaD on Date 3rd July 2006 for PMLifeLine Issue ID.4168
		//End Addition by SavitaS on 08 Jan 2006 for IssueID 1936
		function cboLocation_OnChange()
		{
			//Modified by SuchitraP on 4-Sept-2008 for showing Publish toKM and WF approvals links
			//objform.action = "CRM_MyDashboard.aspx?Action=SET_DEFAULT_LOCATION&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			objform.action = "CRM_MyDashboard.aspx?Mode=<%=m_strMode%>&Action=SET_DEFAULT_LOCATION&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			//End by SuchitraP
			/*
			//Modified By KapilGK On 19 Oct 2006
			objform.action = "CRM_Dashboard.aspx?Action=SET_DEFAULT_LOCATION&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&FilterID="+objFilter.value+"&StatusID="+objStatus.value+"&LocationID="+objLocation.value;
			*/
			objform.submit();
		}
		function cboStatus_OnChange()
		{
		    //Modified by SuchitraP on 4-Sept-2008 for showing Publish toKM and WF approvals links
			//objform.action = "CRM_MyDashboard.aspx?Action=SET_DEFAULT_STATUS&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			objform.action = "CRM_MyDashboard.aspx?Mode=<%=m_strMode%>&Action=SET_DEFAULT_STATUS&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			//End by SuchitraP
			/*
			//Modified By KapilGK On 19 Oct 2006
			objform.action = "CRM_Dashboard.aspx?Action=SET_DEFAULT_STATUS&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&FilterID="+objFilter.value+"&StatusID="+objStatus.value+"&LocationID="+objLocation.value;
			*/
			objform.submit();
		}
	
		function cboFilter_OnChange()
		{
		    //Modified by SuchitraP on 4-Sept-2008 for showing Publish toKM and WF approvals links
			//objform.action = "CRM_MyDashboard.aspx?Action=SET_DEFAULT_FILTER&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			objform.action = "CRM_MyDashboard.aspx?Mode=<%=m_strMode%>&Action=SET_DEFAULT_FILTER&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			//End by SuchitraP
			/*
			//Modified By KapilGK On 19 Oct 2006
			objform.action = "CRM_Dashboard.aspx?Action=SET_DEFAULT_FILTER&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&FilterID="+objFilter.value+"&StatusID="+objStatus.value+"&LocationID="+objLocation.value;
			*/
			objform.submit();
		}
		
		function Refresh_OnClick()
		{
		    //Modified by SuchitraP on 4-Sept-2008 for showing Publish toKM and WF approvals links
			//objform.action = "CRM_MyDashboard.aspx?SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			objform.action = "CRM_MyDashboard.aspx?Mode=<%=m_strMode%>&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			//End by SuchitraP
			objform.submit();
		}
		function optRequest_OnClick(mode)
		{
			switch(true)
			{
			case (mode==0):
				objform.action = "CRM_MyDashboard.aspx?Mode=MD";
				objform.submit();
				break;
			case (mode==1):
				objform.action = "CRM_MyDashboard.aspx?Mode=DB";
				objform.submit();
				break;
			case (mode==2):
				window.location.href  = "CRM_RequestList.aspx?Mode=SR";
				break;
			case (mode==3):
				window.location.href  = "CRM_RequestList.aspx?Mode=AR";
				break;
			default:
				break;
			}
		}
	
		function Sort_OnClick(sortby,sortorder)
		{
		    //Modified by SuchitraP on 4-Sept-2008 for showing Publish toKM and WF approvals links
		    //objform.action = "CRM_MyDashboard.aspx?PageNumber=<%=m_intPageNumber%>&SortBy=" + sortby + "&SortOrder=" + sortorder;
		    objform.action = "CRM_MyDashboard.aspx?Mode=<%=m_strMode%>&PageNumber=<%=m_intPageNumber%>&SortBy=" + sortby + "&SortOrder=" + sortorder;
		    //End by SuchitraP
			objform.submit();  
		}
		
		function SetDefault_OnClick(value)
		{
			var action;
			if (value==0) 
			{
				action = "SET_DEFAULT_MODE" ;
			}
			else
			{
				action = "RESET_DEFAULT_MODE" ;
			}
			//Modified by SuchitraP on 4-Sept-2008 for showing Publish toKM and WF approvals links
			//objform.action = "CRM_MyDashboard.aspx?Action=" + action + "&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>"
			objform.action = "CRM_MyDashboard.aspx?Mode=<%=m_strMode%>&Action=" + action + "&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>"
			//End by SuchitraP
			objform.submit();
		}
	
		function DrillDown_OnClick(itemid,colname, colvalue)
		{
			window.open ("CRM_DrillDown_Detail.aspx?DashboardID=53&ItemID=" + itemid + "&colname=" + replaceSubstring(URLEncode(colname),"|||","'") + "&colvalue=" + replaceSubstring(URLEncode(colvalue),"|||","'") , "_drillDown","left=100,width=700,height=400,scrollbar=yes,resizable=yes,scrollbars=yes");
			window.status = "View drill downs";
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
		function window_onload()
		{
		   // debugger;
			var intDivHeight ;
			var intDivHeightRisk;
			
			WindowLoading();
			var browser = WhichBrowser();
		    //alert(browser);
            //commented by Shamkant S on Nov 2015
			//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60
			intDivHeight = (window.innerHeight - objdivlist.offsetTop - 60)+10;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	
			
			//harshada d for PMLifeLine for helpdesk enhancements 1936

			objform.action = "CRM_MyDashboard.aspx?Action=SET_DEFAULT_FILTER&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			//end of addition harshada d for PMLifeLine for helpdesk enhancements 1936

		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			
			UpdateWindowSize();
						
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px';		
		}
		
		// Added By NitinVS on 22 July 2005 for PMLifeLine SP4 IssueID 2
		function GO_OnClick(FromWhere)
		{
			var objtxtRequestId;
			objtxtRequestId = GetObjectReference('frmMyDashboard','txtRequestId');
			
			if (!disallowBlank(objtxtRequestId,"<%=mybase.GetResourceString("ENTERREQUESTID")%>",true) && (!disallowNonNumeric(objtxtRequestId,"<%=mybase.GetResourceString("NUMERIC")%>",true)) && (!disallowNegativeNumeric(objtxtRequestId,"<%=mybase.GetResourceString("POSITIVE")%>",true)) & (!disallowNonInteger(objtxtRequestId,"<%=mybase.GetResourceString("INTEGER_REQUESTID")%>",true)) )
			{
					if (Number(objtxtRequestId.value) ==0)
					{
						alert("Request ID should be greater than zero!");
						return;
					}
		    //Modified by SuchitraP on 4-Sept-2008 for showing Publish toKM and WF approvals links	
			//objform.action = "CRM_MyDashboard.aspx?&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&Search=1&QueryID=" + objtxtRequestId.value;
			objform.action = "CRM_MyDashboard.aspx?Mode=<%=m_strMode%>&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&Search=1&QueryID=" + objtxtRequestId.value;
			//End by SuchitraP
			objform.submit();  
			}

		}
		
		function txtRequestID_OnKeyPress(e)		
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
				GO_OnClick('MD');
			}
		}
		
		function txtPageNumber_KeyPress(e)
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
				var objtxtpageNumber =  GetObjectReference('frmMyDashboard','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmMyDashboard','txtNoOfPages');
				if (!disallowBlank(objtxtpageNumber,"<%=mybase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
				{	
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
						alert("<%=Mybase.getResourceString("INVALID_PAGENO")%>");
						return;
					}
					Page_OnClick(objtxtpageNumber.value);
				}	
			}
		
		}
		// End Addition By NitinVS on 22 July 2005 for PMLifeLine SP4 IssueID 2
		// Integrated by ArchanaN on 26 Apr 2007
		//Added by SrikanthY on 05 Jan 2007 To Open Flag Page from MY e-Dahboard List page
			function Flag_OnClick(QueryID,PKToken)
			{
			    window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=0&ContextID=" + QueryID + "&PKToken=" + PKToken +"&ContextType=HelpDeskRequest&FromWhere=DB&FromWhich=HelpDesk","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
			}
	        //End of Addition by SrikanthY
	        //Added by SrikanthY on 05 Mar 2007 To provide New feature Show Report
	        function ShowReport_OnClick()
			{
				window.open ("CRM_ShowReport.aspx?MyeDB=1","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=300");
			}
			//End of Addition by SrikanthY on 05 03 2007
			 
		 // Integration Ends

//Added by PrashantD on 23 May 2007 for CleanUp Activity
var noOfPages = GetObjectReference('frmDashboard','hidNoOfPages').value;
var objtxtpageNumber =  GetObjectReference('frmDashboard','txtPageNumber');
function validateNumPaging()
{

	if(isNaN(objtxtpageNumber.value))
	{
		alert("Please enter numeric value");
		return false;
	}
	if(noOfPages<objtxtpageNumber.value)
	{
		alert("Please enter value within range of 1 to "+noOfPages);
		return false;
	}
	return true;
}
function ShowPreviousPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
			objtxtpageNumber.value=objtxtpageNumber.value -1;
		Page_OnClick(objtxtpageNumber.value);
	}
		
}
function ShowFirstPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==1){alert("This is the first page");return;}
		objtxtpageNumber.value=1;
		Page_OnClick(objtxtpageNumber.value);
	}
}
function ShowNextPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(1);
	else
	{
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
			objtxtpageNumber.value=parseInt(objtxtpageNumber.value)+1;
		Page_OnClick(objtxtpageNumber.value);
	}
}
function ShowLastPage()
{
	if (isBlank(objtxtpageNumber.value))
		Page_OnClick(noOfPages);
	else
	{	
		if(!validateNumPaging())
		return;
		if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
		objtxtpageNumber.value=noOfPages;
		Page_OnClick(objtxtpageNumber.value);
	}
}
//End of addition by PrashantD on 23 May 2007

/*//Addition by SuchitraP on 2 Sept 2008
function PublishKM_OnClick()
{
      window.open("../General/CommonList.aspx?MasterTagID=8034", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
}*/

function WorkflowApprovals_OnClick()
{
     window.open("../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=8035", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 700)/2 + ",width=950,height=700");
}
//End by SuchitraP
//Added by ShraddhaM on 9,Sept 2008
//Purpose : For Line Manager Approval Functionality
function RequestApprovals_onClick()
{
    window.open("../CRM/CRM_LineManagerApprovals.aspx", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 700)/2 + ",width=950,height=700");
}
//End of addition bby ShraddhaM on 9,Sept 2008

// 'Added by ShraddhaM on 6,Apr 2009 for PMLifeLine
// 'Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page

function ShowDescription_onClick(QueryID)
{
     
    var i=1;
    var objTD = GetObjectReference('',QueryID);
    var objDiv = GetObjectReference('','Summary'+QueryID);
    var objImg = GetObjectReference('','imgSummaryShowHide'+QueryID);
              
     
    var IsCollapse = objImg.getAttribute("Collapse");
    
  if(navigator.appName != 'Netscape')
  { 
        if(IsCollapse=="Y")
        {
            //alert('Y');
                objTD.style.borderBottom = '1px solid gray';
                while(i<objTD.parentNode.children.length)
                {
                    objTD.nextSibling.style.borderBottom = '1px solid gray';    
                    //objTD.style.borderBottom = '0px solid gray';    
                    objTD = objTD.nextSibling;
                    i=i+1;
                }
                //objImg.setAttribute("Collapse","N");
                 
               
        }
        else
        { 
            objTD.style.borderBottom = '0px solid gray';         
            
            while(i<objTD.parentNode.children.length)
            {  
                objTD.nextSibling.style.borderBottom = '0px solid gray';    
                //objTD.style.borderBottom = '0px solid gray';    
                objTD = objTD.nextSibling;
                i=i+1;
            }
            
        }
    }
    //objTD.parentNode.style.borderBottom = '';
    
    
        var objTR = GetObjectReference('frmMyDashboard','Description'+QueryID);
        
        if(IsCollapse=="Y")
        {   
            objImg.src='../../Images/plus.gif';
            objTR.style.display='none';
            objDiv.style.display='none';
            objImg.setAttribute("Collapse","N");
        }
        else if(IsCollapse=="N")
        {   
            objImg.src='../../Images/minus.gif';
            objTR.style.display=''; 
            objDiv.style.display='';            
            objImg.setAttribute("Collapse","Y");
        }
        
}
function AssignToMe_onClick(QueryID)
{
    
    var url="CRM_XMLHttp.aspx?FromXML=1&Action=Assign&QueryID=" + QueryID;
			
	loadXMLDoc(url,'')	
	
    
}
var objdiv = GetObjectReference('','divATT');
var displayDiv; 
displayDiv=false;
function AddActivity_onClick(QueryID)
{
    var url="CRM_MyDashboard.aspx?FromXML=1&Action=AddActivity&QueryID=" + QueryID;
     
	loadXMLDoc(url,'')	
      
}

function SaveActivity_OnClick(QueryID)
{  
    FeedBackQueryID = QueryID;
     //Added by VijayD on 11 Jun 2009 for StatusFlow configuration
    var StatusID = GetObjectReference('frmRequestList','hidStatus'+QueryID);
    var OldStatusID = GetObjectReference('frmRequestList','hidoldStatusID');
     // Commented by GaneshD on 06 Oct 2009 as the status dropdown shows only those statuses which are configured
            /*
    if (ValidateStatusFlow(QueryID)==false)
     {  return false; }
     */
     // End of modification  by GaneshD on 06 Oct 2009
   // Addition end by ViajyD on 11 Jun 2009 
   
    var ActivityID = GetObjectReference('frmMyDashboard','hidActivityID'+QueryID).value;
    var Time= GetObjectReference('frmMyDashboard','txtTime'+QueryID).value;    
    var TotalTodaysTime = GetObjectReference('frmMyDashboard','TimeSpent'+QueryID).getAttribute('TodaysTotalTimeSpent');
     
    var StatusID = GetObjectReference('frmMyDashboard','hidStatus'+QueryID);
    
    var objTime;
    
     if(parseFloat(Time) < 0 && Time != '')
     {
        alert('Please enter positive number');
        setFocus(GetObjectReference('frmMyDashboard','txtTime'+QueryID));
        return;
     }
    if(isNumeric(Time)==false && Time != '')
    {
        alert('Please enter numeric value');
        setFocus(GetObjectReference('frmMyDashboard','txtTime'+QueryID));
        return;
    }
    if(Time != '' && ActivityID=='')
    {
        alert('Please select the Activity');
        setFocus(GetObjectReference('frmMyDashboard','hidActivityID'+QueryID));
        return;
    }
    if(Time == '' && ActivityID!='')
    {
        alert('Please enter Time');
        setFocus(GetObjectReference('frmMyDashboard','txtTime'+QueryID));
        return;
    }     
    //alert(parseFloat(TotalTodaysTime));
    if(parseFloat(TotalTodaysTime) + parseFloat(Time) > 24*60)
    {
        //alert('Time should be less than total minutes in one day i.e. 1440 minutes \n You can add more '+(1440 - Number(TotalTodaysTime)) +' minutes for today.');
        alert('Total minutes in one day should be less than equal to 1440 minutes. \n You can add more '+(1440 - parseFloat(TotalTodaysTime)) +' minutes for today.');
        
        setFocus(GetObjectReference('frmMyDashboard','txtTime'+QueryID));
        return;
    }   
    //Added by ShraddhaM for feedback comments for close status
     /*if(OldStatusID.value != StatusID.value)
        {
            if(StatusID.value == '2')
            {
                showCommentDiv(event) 
            }
            else
            {        
                SaveData(QueryID)
            }
        }
         else
            {        
                SaveData(QueryID)
            }*/
    //Ended by ShraddhaM for feedback comments for close status  
    SaveData(QueryID)
    //var url="CRM_MyDashboard.aspx?FromXML=1&Action=SaveActivity&Time="+Time+"&ActivityID="+ActivityID+"&QueryID=" + QueryID;

}

function SaveData(QueryID,SaveFeedBack)
{

    var ActivityID = GetObjectReference('frmMyDashboard','hidActivityID'+QueryID).value;
    var Time= GetObjectReference('frmMyDashboard','txtTime'+QueryID).value;    
    var TotalTodaysTime = GetObjectReference('frmMyDashboard','TimeSpent'+QueryID).getAttribute('TodaysTotalTimeSpent');
     
    var StatusID = GetObjectReference('frmMyDashboard','hidStatus'+QueryID);
    
    var objTime;
    
     if(SaveFeedBack == 1)
     {  
        var objFeedBackDiv = GetObjectReference('frmMyDashboard','cboFeedbackDiv');
        var objFeedBackCommentsDiv = GetObjectReference('frmMyDashboard','txtSubmitCommentsDiv');
     }
     
    if(SaveFeedBack == 1)
    {
        var url="CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&FeedBackID="+objFeedBackDiv.value+"&FeedBackComment="+objFeedBackCommentsDiv.value+"&statusID="+StatusID.value+"&Time="+Time+"&ActivityID="+ActivityID+"&QueryID=" + QueryID;
	}
	else
	{
	  var url="CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&statusID="+StatusID.value+"&Time="+Time+"&ActivityID="+ActivityID+"&QueryID=" + QueryID;
	}	
		
	loadXMLDoc(url,'')
	if(Time == '')
	    objTime = 0;
    else
        objTime = Time;	
	GetObjectReference('frmMyDashboard','TimeSpent'+QueryID).setAttribute('TodaysTotalTimeSpent',parseFloat(TotalTodaysTime) + parseFloat(objTime));

}
function SearchActivity(QueryID,evt)
{   
    var Activity = GetObjectReference('frmMyDashboard','txtActivity'+QueryID);
    
    var url="CRM_XMLHttp.aspx?FromXML=1&Action=SearchActivity&Activity="+Activity.value+"&QueryID=" + QueryID;
			
    loadXMLDoc(url,'')	
    displayDiv = true; //Added By Yogesh J ON 15/01/2016
	showmenuie(Activity,evt,displayDiv,QueryID,200)
}
function ShowStatus(QueryID,evt)
{   
    var Status = GetObjectReference('frmMyDashboard','txtStatus'+QueryID);
   
    var url="CRM_XMLHttp.aspx?FromXML=1&Action=ShowStatus&QueryID=" + QueryID;
			
    loadXMLDoc(url,'')	
    displayDiv = true; // Added By Vaijat K ON 28/12/2015
	showmenuie(Status,evt,displayDiv,QueryID,100)
	
	
	
}
function ShowDetailActivity(evt,QueryID)
{
    var url="CRM_XMLHttp.aspx?FromXML=1&Action=ShowDetailActivity&QueryID=" + QueryID;
	var objdivActivityDtls = document.getElementById('divActivityDtls')    
    objdivActivityDtls.style.display=""; 			
	loadXMLDoc(url,'')	


	//var mousePosition = getMousePosition(evt,objdivActivityDtls);	  
		           
            
    //objdivActivityDtls.style.left = 0;//mousePosition.x;objdivActivityDtls.style.top = mousePosition.y;  
    /*objdivActivityDtls.style.width=700;
    //objdivActivityDtls.style.height=300;
     objdivActivityDtls.style.left = (window.screen.width - 700)/2 ;
     objdivActivityDtls.style.width=700;
     objdivActivityDtls.style.top = (window.screen.height - 500)/2;     
    //    objdivActivityDtls.style.display=""; */
        //showmenuieDA(objdivActivityDtls,evt);
	
	showRequester('divActivityDtls',evt);
	
}
  
function ShowRequestorDetails(evt,QueryID,RequestorType)
{  
     
    var url="CRM_XMLHttp.aspx?FromXML=1&Action=ShowRequestorDetails&RequestorType="+RequestorType+"&QueryID=" + QueryID;
			
	loadXMLDoc(url,'')	
	var objdivActivityDtls = document.getElementById('divActivityDtls');
	var mousePosition = getMousePosition(evt,objdivActivityDtls);	  
		           
            
    //objdivActivityDtls.style.left = 200//mousePosition.x;objdivActivityDtls.style.top = mousePosition.y;  
  /*  objdivActivityDtls.style.width=700;
    //objdivActivityDtls.style.height=300;
     objdivActivityDtls.style.left = (window.screen.width - 700)/2 ;
     objdivActivityDtls.style.width=700;
     objdivActivityDtls.style.top = (window.screen.height - 500)/2;     
    objdivActivityDtls.style.display=""; */
    //showmenuieDA(objdivActivityDtls,evt);
	    showRequester('divActivityDtls',evt)
}

function ShowStatistics(evt,QueryID,RequestorType)
{
     var url="CRM_XMLHttp.aspx?FromXML=1&Action=ShowStatistics&RequestorType="+RequestorType+"&QueryID=" + QueryID;
	 var objdivActivityDtls = document.getElementById('divStatistics');
		    
     objdivActivityDtls.style.innerHTML ="";
    // objdivActivityDtls.style.height=0;
     
    objdivActivityDtls.style.display="";
    			
	loadXMLDoc(url,'')	

	var mousePosition = getMousePosition(evt,objdivActivityDtls);		 
                
//    objdivActivityDtls.style.left = 200//mousePosition.x;objdivActivityDtls.style.top = mousePosition.y;  
//    objdivActivityDtls.style.width=700;
    //objdivActivityDtls.style.height=400;
 /*    objdivActivityDtls.style.left = (window.screen.width - 700)/2 ;
     objdivActivityDtls.style.width=700;
     objdivActivityDtls.style.top = (window.screen.height - 500)/2; 

    if( objdivActivityDtls.offsetHeight > 400)
    {
        
        objdivActivityDtls.style.height = 400;     
    }
    else
    {
        objdivActivityDtls.style.height = ( objdivActivityDtls.offsetHeight  ) +"px";         
    }
    
    objdivActivityDtls.style.display=""; */
    
    showRequester('divStatistics',evt)
    
}
    function showRequester(divCM,objevent){

var objdiv = GetObjectReference('',divCM);

   objdiv.style.display='';
   objdiv.style.position = 'absolute'; 
   
    //Find out how close the mouse is to the corner of the window
    var rightedge=ie5? document.body.clientWidth-event.clientX : 
        window.innerWidth-objevent.clientX
    var bottomedge=ie5? document.body.clientHeight-event.clientY : 
        window.innerHeight-objevent.clientY

    //if the horizontal distance isn't enough to accomodate the width of 
    //the context menu
    var objDivH =objdiv.offsetWidth;

    /*if (objDivH > 200)
        objDivH=200;*/
       objdiv.style.left=0;  
    /* if (objDivH >600)
        objDivH=600;
                 
    if (rightedge<objDivH)
    //move the horizontal position of the menu to the left by it's width
    objdiv.style.left=ie5? 
        document.body.scrollLeft+event.clientX-objDivH : 
        window.pageXOffset+objevent.clientX-objDivH
     
    else
    //position the horizontal position of the menu where the mouse was clicked
    objdiv.style.left=ie5? document.body.scrollLeft+event.clientX : 
        window.pageXOffset+objevent.clientX*/

    //same concept with the vertical position
    if (bottomedge<objdiv.offsetHeight)
        objdiv.style.top=(ie5? 
        document.body.scrollTop+event.clientY-objdiv.offsetHeight : 
        window.pageYOffset+objevent.clientY-objdiv.offsetHeight) +10
    else
    objdiv.style.top=(ie5? document.body.scrollTop+event.clientY: 
        window.pageYOffset+objevent.clientY) + 10
        
        //(document.body.scrollTop==0 ? 100 : 0)
        
        //objdiv.style.top=objdiv.style.top-100;
    if(ie5)
        window.event.cancelBubble = true;
    else if(ns6)
        //Commented And Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
        //e.stopPropagation();
        objevent.stopPropagation();
        //End Of Commented And Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
   
  
   return false;
  
   }
   

function showmenuieDA(objdiv,objevent){

//var objdiv = GetObjectReference('',divCM);

   objdiv.style.display='';
   objdiv.style.position = 'absolute'; 
   
    //Find out how close the mouse is to the corner of the window
    var rightedge=ie5? document.body.clientWidth-event.clientX : 
        window.innerWidth-objevent.clientX
    var bottomedge=ie5? document.body.clientHeight-event.clientY : 
        window.innerHeight-objevent.clientY

    //if the horizontal distance isn't enough to accomodate the width of 
    //the context menu
    var objDivH =objdiv.offsetWidth;

  if (objDivH > 500)
        objDivH=500;
              
    if (rightedge<objDivH)
    //move the horizontal position of the menu to the left by it's width
    objdiv.style.left=ie5? 
        document.body.scrollLeft+event.clientX-objDivH : 
        window.pageXOffset+objevent.clientX-objDivH
     
    else
    //position the horizontal position of the menu where the mouse was clicked
    objdiv.style.left=ie5? document.body.scrollLeft+event.clientX : 
        window.pageXOffset+objevent.clientX

    //same concept with the vertical position
    if (bottomedge<objdiv.offsetHeight)
        objdiv.style.top=(ie5? 
        document.body.scrollTop+event.clientY-objdiv.offsetHeight : 
        window.pageYOffset+objevent.clientY-objdiv.offsetHeight) +10
    else
    objdiv.style.top=(ie5? document.body.scrollTop+event.clientY: 
        window.pageYOffset+objevent.clientY) + 10
        
        //(document.body.scrollTop==0 ? 100 : 0)
        
        //objdiv.style.top=objdiv.style.top-100;
  if(ie5)
        window.event.cancelBubble = true;
    else if(ns6)
        //Commented And Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
        //e.stopPropagation();
        objevent.stopPropagation();
        //End Of Commented And Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
   
  
  return false;
  
   }
function CloseDiv()
{
   var objdivActivityDtls = document.getElementById('divActivityDtls')
    
	if(objdivActivityDtls)
	objdivActivityDtls.style.display="none";
	
	var objdivStatistics = document.getElementById('divStatistics');
	
	if(objdivStatistics)
	objdivStatistics.style.display="none";
	 
}

function Attribute_OnClick(Activity,QueryID)
{ 
   GetObjectReference('frmMyDashboard','txtActivity'+QueryID).value = Activity;
   objdiv.style.display='none';
}
function loadXMLDoc(url,reqQuery)	
{
if (window.XMLHttpRequest) {
xmlhttp=new XMLHttpRequest();
xmlhttp.onreadystatechange= state_Change;
if (ns) {xmlhttp.open('GET',url,true);
          xmlhttp.send(null);
}
else {xmlhttp.open('POST',url,false);
xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlhttp.send(reqQuery);}
}else if (window.ActiveXObject){
xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
if (xmlhttp) {xmlhttp.onreadystatechange=state_Change;
xmlhttp.open('POST',url,false);
xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
xmlhttp.send(reqQuery);}}
}

function state_Change() 
{
	var FromWhere;
	var QueryID;
	if (parseInt(xmlhttp.readyState)==4) 
	{ 
		if (xmlhttp.status==200)
		{
		    
		    var result = xmlhttp.responseText.split("$_$");
		    QueryID = result[1]; 
		    if(result[0] == 'SaveActivity')
		    {
		        var objtxtSavingLable = GetObjectReference('frmMyDashboard','txtSavingLable'+QueryID);
		        
		        objtxtSavingLable.style.display = '';
		        
		        var objTotalTime = GetObjectReference('frmMyDashboard','TotalTime'+QueryID);
		        //var TotalTime = GetObjectReference('frmMyDashboard','TotalTime'+QueryID).innerText;
		        var TotalTime = GetObjectReference('frmMyDashboard','TotalTime'+QueryID).getAttribute('TotalTime');
		        var objActivity = GetObjectReference('frmMyDashboard','txtActivity'+QueryID);
		        var objActivityID = GetObjectReference('frmMyDashboard','hidActivityID'+QueryID);
		        var objTime=GetObjectReference('frmMyDashboard','txtTime'+QueryID);
 
		         
		        var NewTotalTime = TotalTime //TotalTime.substring(start+1,stop);	              
		        
		         
		           var objtxtTime = GetObjectReference('frmMyDashboard','txtTime'+QueryID) ;
                var objtxtActivity = GetObjectReference('frmMyDashboard','txtActivity'+QueryID) ; 
                var objimgActivity = GetObjectReference('frmMyDashboard','imgActivity'+QueryID) ; 
                var objbtnSave = GetObjectReference('frmMyDashboard','btnSave'+QueryID) ;  
        
                var  objtxtStatus = GetObjectReference('frmMyDashboard','txtStatus'+QueryID) ;  
                var  objhidtxtStatus = GetObjectReference('frmMyDashboard','hidStatus'+QueryID) ;
        		        
		            
                        if(objhidtxtStatus.value != 2)
                                { 
                                    objtxtTime.disabled = false;      
                                    objtxtActivity.disabled = false;      
                                    objimgActivity.onClick = "SearchActivity(" + QueryID + ",event)";
                                    objbtnSave.disabled = false;   
                                }   
                                else     
                                { 
                                    objtxtTime.disabled = true;      
                                    objtxtActivity.disabled = true;      
                                    objimgActivity.onClick = "";
                                    objbtnSave.disabled = true;   
                                }



		        
		        if(objTime.value != '')
		        {
		            var ConvertedTime = parseFloat(NewTotalTime) + parseFloat((parseFloat(objTime.value)/60).toFixed(2));
    		        
		            objTotalTime.innerHTML = '<U><B><A onClick=ShowDetailActivity(event,' + QueryID + ') >Total Time Spent </A></U>&nbsp;:&nbsp;' + ConvertedTime + '&nbsp;Hrs</B>&nbsp;&nbsp;'
		            GetObjectReference('frmMyDashboard','TotalTime'+QueryID).setAttribute('TotalTime',ConvertedTime);
    		    }
    		        		        
		        var StatusID = GetObjectReference('frmMyDashboard','hidStatus'+QueryID);
		         
		        if(StatusID.value==2)
		        {
		        var objtxtStatus = GetObjectReference('','txtStatus' +QueryID);
		        var objimgStatus = GetObjectReference('','imgStatus' +QueryID);		        
		        objtxtStatus.disabled=true;
		        objtxtStatus.onclick='';
		        objimgStatus.onclick='';
		        }
		        		        
		        		  
		        objActivity.value = '';
		        objActivityID.value = '';
		        objTime.value = '';
		        setFocus(objTime);
		        
		        var code ;
		        code = "var objtxtSavingLable = GetObjectReference('frmDashboard','txtSavingLable"+QueryID+"'); objtxtSavingLable.style.display = 'none';"
		        setTimeout(code,400);
		        
		        
		        if(objdiv)
		        {
		            objdiv.style.display='none';
		        }
		    }
//		    else if(result[0] =='SaveStatus')
//		    {
//		        var StatusID = GetObjectReference('frmMyDashboard','hidStatus'+QueryID);
//		        //alert(StatusID);
//		        if(StatusID.value==2)
//		        {
//		        var objtxtStatus = GetObjectReference('','txtStatus' +QueryID);
//		        var objimgStatus = GetObjectReference('','imgStatus' +QueryID);		        
//		        objtxtStatus.disabled=true;
//		        objtxtStatus.onclick='';
//		        objimgStatus.onclick='';
//		        }
//		    }
		    else if(result[0] == 'Assign') 	
		    {
		        var objAssignTo = GetObjectReference('','AssignTo' +QueryID);
		   
                objAssignTo.innerHTML = '<B><FONT color=red>Assigned To me</FONT></B>';
		    }
		    else if(result[0] == '')
		    { 		         
		        document.getElementById('divATT').innerHTML = '';		        
		        document.getElementById('divATT').style.display='none';
		        displayDiv = false;
		        
		    }
		    //Added by GaneshD on 31 Aug 2009 for PMLifeLine IssueID-32677
		     else if(result[0] == 'NotValidStatus') 	
		    {
		       displayDiv = false;
		        alert(result[2]);
		        return;
		    }
		    // End of addition by GaneshD
		    else
		     {   	    
		        if(result[1] != '') 	         
		        {   
		            if(result[1] == 'ShowStatistic')
		            {     
		                 var objdivActivityDtls = document.getElementById('divStatistics')
		                 objdivActivityDtls.innerHTML = result[0];
		            }
		            else
		            {
		            document.getElementById('divATT').innerHTML = result[0];	    
                    document.getElementById('divATT').style.display="";
			        displayDiv = true;
			        }
		        }		      
		        else
		        {   //alert(result[0]);
		        
		            var objdivActivityDtls = document.getElementById('divActivityDtls')
		            objdivActivityDtls.innerHTML = result[0];
		            			         
		        }
		        
		     }
		     		
		    
			
		}
	}
	
}
 var ie5=document.all&&document.getElementById
 var ns6=document.getElementById&&!document.all
 
 
 function pos(ctrl,arg)
 {    
  
    var a=ctrl,b=arg;        
    var d=0;        
    while(a)        
    {        
    d+=a[b];
           
     a=a.offsetParent
            
    }        
    return d
}


function getMousePosition(ev,objContextMenu)
{
	
	var intX,intY,intBottom;	  
    if (objContextMenu)
    {
   
        objContextMenu.style.display='';
        intX = ev.clientX;
        intY = ev.clientY;
        
        intBottom = document.body.offsetTop + document.body.offsetHeight;
        
        if (intBottom - intY < objContextMenu.offsetHeight)
        {intY = intY - objContextMenu.offsetHeight;}
        
        //Commented And Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
        /*objContextMenu.style.left = intX;
        objContextMenu.style.top = intY;*/
        objContextMenu.style.left = intX + "px";
        objContextMenu.style.top = intY + "px";
        //End Of Commented And Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
    }  
      
      return {x:objContextMenu.style.left,y:objContextMenu.style.top};
	
}

function showmenuie(element,objevent,displayDiv,QueryID,width)
{     
  
    //objdiv.style.position = 'absolute';
    var ret = new Point();
    objdiv.style.width='100px';  
    if(displayDiv == true)
    {
         
       objdiv.style.display='';
       objdiv.style.position = 'absolute';  
       objdiv.style.height='200px';       
       
      
            for(; 
                element && element != document.body;
                ret.translate(element.offsetLeft, element.offsetTop), element = element.offsetParent
                );                  

        intBottom = document.body.offsetTop + document.body.offsetHeight;
        
        if (intBottom - ret.y < objdiv.offsetHeight)
        {ret.y = ret.y - objdiv.offsetHeight;}
        
        //Commented And Added By Chakshuta H on 14th-Oct-2015 Purpose::Dropdown alignment issue
         //objdiv.style.left = ret.x + 4;
          
         ////alert(objdivGrid.scrollTop);
         
         //objdiv.style.top=ret.y + 15 - objdivlist.scrollTop ; //- objdiv.style.height ;

         objdiv.style.left = ret.x + 4 + "px";
                  
         objdiv.style.top=ret.y + 15 + "px"; - objdivlist.scrollTop ; //- objdiv.style.height ;
        //End Of Commented And Added By Chakshuta H on 14th-Oct-2015 Purpose::Dropdown alignment issue
         
         objdiv.style.width = width;
         objdiv.style.display=''; 
    
            var table = document.getElementById('tblContextMenu');
            if(table != null){
                trs = table.getElementsByTagName('tr');
             
                highlightRow( trs[currentRow] );
            }          
    }
    //Added By Vaijat K ON 28/12/2015
    if (WhichBrowser() != 'FF'){
        objdiv.style.left = ret.x + 'px';
        if (event.pageY > 700){
            objdiv.style.bottom= event.pageY + 'px';
            objdiv.style.top= event.pageY - 50 + 'px';
        }
        else{
            objdiv.style.top= event.pageY + 'px';
        }
    }
    else
    {
        objdiv.style.left =  ret.x + 'px';
        if (objevent.pageY > 700){
            objdiv.style.bottom= objevent.pageY + 'px';
            objdiv.style.top= objevent.pageY - 50 + 'px';
        }
        else{
            objdiv.style.top= objevent.pageY + 'px';
        }
    }
    //Ended
  }
  
  
  

  function Doc_OnmouseUp()
  {
  if(document.getElementById('divATT'))
    document.getElementById('divATT').style.display="none";
  }

function SelectStaus(QueryID,evt)    
{
    alert('SelectStaus');
} 

function Point(x,y)
{    
        this.x = x || 0;
        this.y = y || 0;
        this.toString = function(){ 
            return this.x+', '+this.y;
        };
        this.translate = function(dx, dy){ 
            this.x += dx || 0;
            this.y += dy || 0;
        };
        
        this.getX = function(){   return this.x; }
        this.getY = function(){   return this.y; }
        this.equals = function(anotherpoint){  
            return anotherpoint.x == this.x && anotherpoint.y == this.y;

        };
} 

function DisplayColor(tr,curRow)
{
  tr.style.backgroundColor = '3366FF' ; 
 highlightedRow = tr;
}

function RemoveColor(tr,curRow)
{
  tr.style.backgroundColor  = '#ffffff';

}
 
function copytext(evt,Control,Text,QueryID,ID)
{   
     
 //var keyID = (window.event) ? event.keyCode : e.keyCode;
  
 //if(keyID == 13 || keyID ==0)
 //{    
  
  if( Control == 'txtStatus')
  {
    var objOldStatusDate = GetObjectReference('frmMyDashboard','hidStatusChangeDate')
    var objOldStatusTime = GetObjectReference('frmMyDashboard','hidStatusChangeTime')
    var objCurrentDate = GetObjectReference('frmMyDashboard','hidCurrentDate')
    var objCurrentTime = GetObjectReference('frmMyDashboard','hidCurrentTime')
    
      var objtxtTime = GetObjectReference('frmMyDashboard','txtTime'+QueryID) ;
                var objtxtActivity = GetObjectReference('frmMyDashboard','txtActivity'+QueryID) ; 
                var objimgActivity = GetObjectReference('frmMyDashboard','imgActivity'+QueryID) ; 
                 var objhidtxtActivity = GetObjectReference('frmMyDashboard','hidActivityID'+QueryID) ; 
                 
                var objbtnSave = GetObjectReference('frmMyDashboard','btnSave'+QueryID) ;  
        
                var  objtxtStatus = GetObjectReference('frmMyDashboard','txtStatus'+QueryID) ;  
                var  objhidtxtStatus = GetObjectReference('frmMyDashboard','hidStatus'+QueryID) ;
        		        
	
                                  /*  objtxtTime.disabled = false;      
                                    objtxtActivity.disabled = false;      
                                    objimgActivity.onClick = "SearchActivity(" + QueryID + ",event)";
                                    objbtnSave.disabled = false;   */
                                

    if(ID!=2)
       {
            objtxtTime.disabled = false;      
            objtxtActivity.disabled = false;      
            objimgActivity.onClick = "SearchActivity(" + QueryID + ",event)";
            objimgActivity.disabled=false;
            objbtnSave.disabled = false;   
       }
       else
       {
            objtxtTime.disabled = true;      
            objtxtActivity.disabled = true;   
            objtxtTime.value = '';      
            objtxtActivity.value = '';   
            objhidtxtActivity.value='';   
            //objimgActivity.onClick = "";
            objimgActivity.disabled=true;
            
       } 

    if(objOldStatusDate.value==objCurrentDate.value && objOldStatusTime.value==objCurrentTime.value) 
	{												  
	    	alert("Status Change date & time should be greater than previous status Change date '"+objOldStatusDate.value+"' and time '"+objOldStatusTime.value+"'.");		
			return;
	}
	
    GetObjectReference('frmMyDashboard','hidStatus'+QueryID).value =  ID;
//    var StatusID = GetObjectReference('frmMyDashboard','hidStatus'+QueryID);
//	var url="CRM_MyDashboard.aspx?FromXML=1&Action=SaveStatus&statusID="+StatusID.value+"&QueryID=" + QueryID;
//			
//	loadXMLDoc(url,'')	
	
	
  }
  else if(Control == 'txtActivity')
  {
    GetObjectReference('frmMyDashboard','hidActivityID'+QueryID).value = ID;
  }
  GetObjectReference('frmMyDashboard',Control+QueryID).value = Text;
  objdiv.style.display='none';
 //}   
}

 function highlightRow(tr) {  
                            tr.style.backgroundColor = '3366FF' ; 
                            highlightedRow = tr;

 
                        }


function dehighlightRow(tr) {
                            tr.style.backgroundColor = '#ffffff';
                                table = null;
                                trs = null;
                        }

 


function processKeys( e )
                        { 
                                if(document.getElementById('tblContextMenu' ))
                                {
                                var table = document.getElementById('tblContextMenu' );
                                var numRows = table.rows.length;
                                var keyID = (window.event) ? event.keyCode : e.keyCode;
                                
     

                                switch (keyID)
                                {
                                        // Key up.
                                        case 38:
                                        if (parseInt(currentRow) == parseInt(0))
                                        {
// reached the top of the table; do nothing. 
                                                return true;
                                        } else
                                        {
                                                // move one row up.
                                                scrollRow( "up" );
                                                //setCurrentRow( currentRow );
      //currentRow = currentRow - 1;
                                                return false;
                                        }
                                        break;

                                        // Key down.
                                        case 40: 
     
     //alert(numRows);
                                        if (currentRow == (numRows - 1))
                                        {
// reached the end of the table; do nothing 
                                                return true;
                                        } else
                                        {
                                                scrollRow( "down" );
                                                //setCurrentRow( currentRow );
    
      //currentRow = currentRow  + 1;

                                                 
                                        }
                                        break;
                                      }
                                }


function scrollRow ( dir )
                                {  
                                        var trs =
document.getElementById('tblContextMenu').getElementsByTagName('tr');
                                        if (dir == "up")
                                        {
dehighlightRow ( trs[ currentRow ] ); 
                                                currentRow--;
highlightRow( trs[ currentRow ] ); 
                                        } else if (dir == "down")
                                    {
                                        dehighlightRow( trs[ currentRow ] );
                                        currentRow++;
                                        highlightRow( trs[ currentRow ] );
                                    }
                                }
                        }


function Requestor_keypress(e)
 {
     
    if(e.keyCode == 13)
    { 
        objform.action = "CRM_MyDashboard.aspx?Mode=<%=m_strMode%>&Action=SET_DEFAULT_REQUESTORFILTER";		    
        objform.submit();
    }
    
 }
 
 
//Ended by ShraddhaM on 7,Apr 2009 for PMLifeLine


//Added by VijayD on 11 Jun 2009 for StatusFlow configuration
function ValidateStatusFlow(QueryID)
{
    var validStatusNew;
    var validStatusExist;

    var objOldStatus = GetObjectReference('frmMyDashboard','txtOldStatus'+QueryID);
    var objNewStatus = GetObjectReference('frmMyDashboard','txtStatus'+QueryID);

    var objCompareStatus = GetObjectReference('frmMyDashboard','CmbStatus'+QueryID);
    var objPrevStatus = GetObjectReference('frmMyDashboard','CmbPrevStatus'+QueryID);
    var objStatusFlowCount = GetObjectReference('frmMyDashboard','StatusFlowCount'+QueryID);
    var intStatusFlowCount = objStatusFlowCount.value;
    var statusFlag=0;

    validStatusNew = ""
    validStatusExist = "\n\n";

        if(intStatusFlowCount > 0)
        {
    		
            for(i=0;i<=objCompareStatus.length-1;i++)
            {
                validStatusExist = validStatusExist + (i + 1)+ ". " +objCompareStatus[i].value + "\n"
            }
    		
            for(i=0;i<=objCompareStatus.length-1;i++)
            {
                if(objCompareStatus[i].value == objNewStatus.value)
                {
                    validStatusNew = objNewStatus.value;
                    break;
                }
            }
            if (objNewStatus.value==objOldStatus.value)
            {
                validStatusNew=objNewStatus.value;           
            }
            if(validStatusNew == "")
            {
                if(validStatusExist =="\n\n")
                {
                    alert("'"+objOldStatus.value +"' is the last status configured in the status flow.");
                }
                else
                {
                    alert('Invalid Status, Status can be change to one of the following ' + validStatusExist);
                }               
                return false;
            }
         }		
         return true;
}

// Addition end by ViajyD on 11 Jun 2009    



function showCommentDiv(ev)
{                
                //objcboRequestType.style.visibility = 'hidden';

                //objcboSubRequestType.style.visibility = 'hidden';
                
                objFeedBackDiv = GetObjectReference('frmMyDashboard','DivFeedBack');
                var mousePosition = getMousePosition(ev,objFeedBackDiv);
			    objFeedBackDiv.style.width  = '405px';
			    objFeedBackDiv.style.height  = '150px';
			    objFeedBackDiv.style.left =  mousePosition.x ;
			    objFeedBackDiv.style.top =  mousePosition.y ;		     
		        objFeedBackDiv.style.position ='absolute';
			    objFeedBackDiv.style.display  = '';
			    document.getElementById('fillDiv').style.display="";
}
   function getMousePosition(ev,objContextMenu)
{
	
	var intX,intY,intBottom;	  
    if (objContextMenu)
    {
   
        objContextMenu.style.display='';
        intX = ev.clientX;
        intY = ev.clientY;
        
        intBottom = document.body.offsetTop + document.body.offsetHeight;
        
        if (intBottom - intY < objContextMenu.offsetHeight)
        {intY = intY - objContextMenu.offsetHeight;}
        
        //Commented And Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
        //objContextMenu.style.left = intX - 500 ;
        //objContextMenu.style.top = intY  ; //+ "px";
        objContextMenu.style.left = intX + "px"; ;
        objContextMenu.style.top = intY + "px"; ; 
        //End Of Commented And Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing
    }  
      
      return {x:objContextMenu.style.left,y:objContextMenu.style.top};
	
}
function SubmitOK_Onclick()
{
    var objFeedBack = GetObjectReference('frmMyDashboard','cboFeedback');
    var objFeedBackComments = GetObjectReference('frmMyDashboard','txtFeedbackComments');    
    var objFeedBackDiv = GetObjectReference('frmMyDashboard','cboFeedbackDiv');
    var objFeedBackCommentsDiv = GetObjectReference('frmMyDashboard','txtSubmitCommentsDiv');
    var objDiv = GetObjectReference('frmMyDashboard','DivFeedBack');
    
     if(Trim(objFeedBackCommentsDiv.value) == '')
     {
        alert('Please Enter Feedback comments');
        return;
     } 
     
    //objFeedBack.value = objFeedBackDiv.value;
    //objFeedBackComments.value = objFeedBackCommentsDiv.value;
        
     
    objDiv.style.display  = 'none';
    document.getElementById('fillDiv').style.display="none";
       
    
     SaveData(FeedBackQueryID,'1')
     
     //objcboRequestType.style.visibility = '';
     //objcboSubRequestType.style.visibility = '';
}
function Cancel_OnClick()
{    
   /*  var objOldStatus = GetObjectReference('frmRequestList','hidoldStatusID');
     var objNewStatus = GetObjectReference('frmRequestList','cboStatus');
     // GetObjectReference('frmRequestList','hidStatus'+QueryID).value =  ID;
    var objOldStatusChangeDate=window.document.forms['frmRequestList'].elements['txtchangedDatehidden1'];
    var objOldStatusChangeTime=window.document.forms['frmRequestList'].elements['txtchangedTimehidden1'];
	var objWhizStatusDate = GetObjectReference('frmRequestList','FFE29587WHIZ_txtchangedDate');				 					 
	var objOldStatusChangeDate_Control=window.document.forms['frmRequestList'].elements['FFE29587WHIZ_txtchangedDatehidden1'];
	
	var objCurrentChangeDate = GetObjectReference('frmRequestList','txtchangedDate');
	var objCurrentChangeTime = GetObjectReference('frmRequestList','txtchangedTime');
		*/			 
    
    //objcboRequestType.style.visibility = '';
    //objcboSubRequestType.style.visibility = '';
    //objCurrentChangeDate.value = objOldStatusChangeDate.value;
    //objCurrentChangeTime.value = objOldStatusChangeTime.value;
    //objNewStatus.value = objOldStatus.value;
    //objWhizStatusDate.value=objOldStatusChangeDate_Control.value 
    objFeedBackDiv = GetObjectReference('frmMyDashboard','DivFeedBack');
    objFeedBackDiv.style.display  = 'none';
    document.getElementById('fillDiv').style.display="none";
    
    
}


//Added by Amit Mahadik on 19 August 2011 PMLifeLine (FAQ)
function Faq_OnClick(DeptMode,UserID,DepartmentName)
{
    window.open("../CRM/FrequentlyAskQuestions_CommonList.aspx?MasterTagId=9017&Mode=RO&QueryID=NULL&DeptFlag=" + DeptMode + "&eid="+ UserID +"&DepartmentName="+ DepartmentName +"  ","FAQ","resizable=yes,scrollbars=no,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");
}
//End Added by Amit Mahadik on 19 August 2011 PMLifeLine (FAQ)


		</script>
	</body>
</HTML>
