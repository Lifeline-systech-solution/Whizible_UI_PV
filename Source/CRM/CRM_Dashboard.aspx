<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_Dashboard.aspx.vb" Inherits="PbNIT.CRM_Dashboard"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("CRM Dashboard")%>
	<link rel='stylesheet' type='text/css' href='../Home/Home.css'/>
	<link rel='stylesheet' type='text/css' href='../AdvancedTimesheet/timesheet.css'/>
    <%--Commented and Added By Vidya J on 18th-September-2015 for Responsive Page--%>


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
     #txtPageNumber 
    {
        height:20px;
    }
     #tblRequestorDtls
     {
            background-color: #f6eee4; /*Added By Vaijat K ON 22/12/2015*/
    }
    #tblActivityDtls
    {
         background-color: #f6eee4; /*Added By Vaijat K ON 28/12/2015*/
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
            //removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        //Commented And Added By Vaijat K ON 03/11/2015
        //if($('.clsgridtable').length > 0)
        //{
        //    var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
        //    dataCollapse(divName);
        //}
        if($('.clsPageBody').find('#frmDashboard').find('#divList').find('#divGrid').length > 0)
        {
            var divName=$('.clsPageBody').find('#frmDashboard').find('#divList').find('#divGrid').attr('id');
            divDatacollapse(divName);
        }
        //End Added By Vaijat K ON 03/11/2015
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

	<body class="clsPageBody" onresize="window_onresize()" onload="window_onload()" onmouseup="Doc_OnmouseUp()">   <!--ondragstart="return false;"> --> 
	
	<div id='DateTitle' style=' BORDER-RIGHT:blue 1px groove; BORDER-TOP:blue 1px groove; DISPLAY:none; FONT-SIZE:10px; LEFT:1px; BORDER-LEFT:blue 1px groove; WIDTH:60px; BORDER-BOTTOM:blue 1px groove; POSITION:absolute; TOP:1px; BACKGROUND-COLOR:yellow'>&nbsp;12 
			Dec 2007</div>
		
		<div id="divLTooltip" style='BORDER-RIGHT:blue 1px groove; BORDER-TOP:blue 1px groove; DISPLAY:none; FONT-SIZE:10px; Z-INDEX:190001; LEFT:1px; BORDER-LEFT:blue 1px groove; WIDTH:80px; BORDER-BOTTOM:blue 1px groove; POSITION:absolute; TOP:1px; BACKGROUND-COLOR:yellow'>&nbsp; 
			12 Left 2007</div>
		<div id="divRTooltip" style='BORDER-RIGHT:blue 1px groove; BORDER-TOP:blue 1px groove; DISPLAY:none; FONT-SIZE:10px; Z-INDEX:190001; LEFT:1px; BORDER-LEFT:blue 1px groove; WIDTH:80px; BORDER-BOTTOM:blue 1px groove; POSITION:absolute; TOP:1px; BACKGROUND-COLOR:yellow'>&nbsp;12 
			Right 2007</div>
			
		<form id='frmDashboard' method='post' runat='server'>
		
		 
		
			<div id="fillDiv" style="DISPLAY: block;Z-INDEX: 100;FILTER: alpha(opacity=60);LEFT: 0px;VISIBILITY: visible;WIDTH: 100%;POSITION: absolute;TOP: 0px;HEIGHT: 100%;BACKGROUND-COLOR: #d1d1d1"></div>
			<%WritePage()%>
			<div id="divGraphs" style="DISPLAY:none;OVERFLOW:auto" runat="server">
				<Table id="tblGraphs" runat="server" cellpadding="0" cellspacing="0" align="middle">
				</Table>
			</div>
			<DIV></DIV>
			<!--<%=m_strMenu%>-->
			
		   
		<div id='divATT' class='cxtMenu' style='overflow:auto;display:none;z-index:99;background:white;position:absolute;margin:0;' >
        </div>
        
          <div id='divActivityDtls' style='OVERFLOW:auto;DISPLAY:none;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;WIDTH:80%;height:200px;POSITION: absolute; TOP: 165px;Z-INDEX:19000'>
          </div>
          <div id='divStatistics' style='OVERFLOW:auto;DISPLAY:none;BORDER-COLOR:#35afe8;BORDER-STYLE:groove;WIDTH:80%;height:200px;POSITION: absolute; TOP: 165px;Z-INDEX:19000;background-color: white; '>
          </div>
            <%--Commented by Shamkant On 6 Nov 2015--%>
       <%-- <div id='div1' style='display:none;overflow:auto;position:absolute;border-right: black 1px outset;border-top: black 1px outset;border-left: black 1px outset;border-bottom: black 1px outset;height:300px;width:200px;' >
       </div> --%> 
       <div id='divTblX' style='display:none;background-color:#f6eee4;overflow:auto;position:absolute;border-right: black 1px outset;border-top: black 1px outset;border-left: black 1px outset;border-bottom: black 1px outset;height:300px;width:200px;' >
       </div>      
               
                 
       
		</form>
		<DIV class="FadingTooltip" id="FADINGTOOLTIP" style="Z-INDEX: 999; VISIBILITY: hidden; POSITION: absolute"></DIV>
		<div id="fillDivDB" style="DISPLAY: none;Z-INDEX: 100;FILTER: alpha(opacity=60);LEFT: 0px;VISIBILITY: visible;WIDTH: 100%;POSITION: absolute;TOP: 0px;HEIGHT: 100%;BACKGROUND-COLOR: #d1d1d1"></div>
		
		<script language="javascript">
		
		var objform;
		var objdivlist;
		var objchkSelect;
		//--Added by ShraddhaM on 6,Apr 2009 for PMLifeLine
        //--Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
		var currentRow = 0;
        var highlightedRow;
        var trs ;
        var arrVertLeftTopPos = new Array();
        var arrVertRightTopPos = new Array();
        var vertTopBondary,vertBottomBondary;
	    var curMoveVert;
	    var vertPosTD;
	    var StartX;
	    var vert;
	    var lastTD;
	    var pix = "px";
	    var i;
	    var DT;
	    var isLorR,DT_TD_width;
	    var LB,RB,LBid,RBid;
	    var objfrm;
	    var LToolTip,RToolTip;
	    var divForeCast,objdivFilter;
    	var objdivASTA=GetObjectReference('','divSTA');
        //Ende by ShraddhaM
		    <%' Added By Shamkant S on 8 Dec Jan 2015 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
		    disableRightClick();
		    <%End If%>
		    <%' Ended By Shamkant S on 8 Dec Jan 2015 %>

		/*
			//Added By KapilGK On 19 Oct 2006
			var objFilter = GetObjectReference('frmDashboard','cboFilter');
			var objStatus = GetObjectReference('frmDashboard','cboStatus');
			var objLocation = GetObjectReference('frmDashboard','cboLocation');
			// End of Addition By KapilGK
		*/
		objform = GetFormReference('frmDashboard');
		objdivlist = GetObjectReference('frmDashboard','divList');
		objchkSelect = GetObjectReference('frmDashboard','chkSelect',true);
		
		<%' Added By NitinVS on 9 May 2007 for PMLifeLine %>
		objdivGrid = GetObjectReference('frmDashboard','divGrid');
		<%' End Added By NitinVS on 9 May 2007 for PMLifeLine%>
		
		<%' Added By SonalD on 12th Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 12th Jan 2009 %>
		
		 
		
		function SetFilters_OnClick()
		{	window.open ("CRM_FilterList.aspx?FromWhere=DB","_Filters","resizable=yes,scrollbars=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=850,height=400");
		}
	
		function ClearFilters_OnClick()
		{
			//Modified by SuchitraP on 4-Sept-2008 for showing Publish toKM and WF approvals links
			//objform.action = "CRM_Dashboard.aspx?Action=CLEAR_FILTERS&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=1";		
             
            
			objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&Action=CLEAR_FILTERS&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=1";		
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
			// Integrated by ArchanaN on 26 Apr 2007
			/*	window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&Action=Edit&QueryID=" + QueryID + "&ShowAssignLink=" + ShowAssignLink + "&PKToken=" + strToken + "&TaskID=" + strTaskID,"_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
			else
				window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&QueryID=" + QueryID + "&ShowAssignLink=" + ShowAssignLink + "&PKToken=" + strToken ,"_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 	*/
				//window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&Action=Edit&QueryID=" + QueryID + "&ShowAssignLink=" + ShowAssignLink + "&PKToken=" + strToken + "&TaskID=" + strTaskID,"_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
				window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&Action=Edit&QueryID=" + QueryID + "&ShowAssignLink=" + ShowAssignLink + "&PKToken=" + strToken + "&TaskID=" + strTaskID,"_Assignment","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=400"); 
			else
				//window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&QueryID=" + QueryID + "&ShowAssignLink=" + ShowAssignLink + "&PKToken=" + strToken ,"_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 	
				window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_TASK&QueryID=" + QueryID + "&ShowAssignLink=" + ShowAssignLink + "&PKToken=" + strToken ,"_Assignment","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=400");	
	 
		 // Integration Ends

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
		// Integrated by ArchanaN on 26 Apr 2007
		//window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&QueryID=" + QueryID + "&PKToken=" + strToken,"_Assignment","resizable=yes,scrollbars=no,width=550,height=500"); 
		//window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&QueryID=" + QueryID + "&PKToken=" + strToken,"_Assignment","resizable=yes,scrollbars=no,width=550,height=500"); 
	    window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_ISSUE&QueryID=" + QueryID + "&PKToken=" + strToken,"_Assignment","resizable=yes,scrollbars=yes,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600"); 

		 // Integration Ends

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
			GenrateToken(QueryID);
		    // START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
			// window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_MULTIPLE_TASKS&QueryID=" + QueryID ,"_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
			//Commented by Nilesh g on 19/1/2015
		    //window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_MULTIPLE_TASKS&QueryID=" + QueryID + "&PKToken=<%=m_PKToken_Go_Behalf_ADD%>"  ,"_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
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
			GenrateToken(QueryID);
		    //Commented by Nilesh g on 19/1/2015 for URL security 
		    //window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_REQUESTS&QueryID=" + QueryID + "&PKToken=<%=m_PKToken_Go_Behalf_ADD%>","_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
			// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		}
		    function GenrateToken(QueryID)
		    {
		        //Added by Nilesh Gundecha on 19/1/2015 for URL blocking issue
		        $.ajax({
		            type: 'POST',
		            dataType: 'json',
		            contentType: 'application/json',
		            url: 'CRM_Dashboard.aspx/GenrateURLToken',
		            data: JSON.stringify({Queryid:QueryID, EmployeeID: "<%=Session("intUserID")%>"}),
		            success: function (Result) {
		                OpenPage1(Result.d,QueryID);
			        
			       
		            },
		            error: function () {
		             //   alert("Error")
		            }
		        });
                 //endded by Nilesh Gundecha on 19/1/2015 for URL blocking issue
            }
            //Added by Nilesh Gundecha on 19/1/2015 for URL blocking issue
            function OpenPage1(Result,QueryID)
            {
                window.open ("CRM_RequestAssignment.aspx?Mode=ASSIGN_REQUESTS&QueryID=" + QueryID + "&PKToken="+ Result,"_Assignment","resizable=yes,scrollbars=no,width=550,height=300"); 
            }
            //endded by Nilesh Gundecha on 19/1/2015 for URL blocking issue

		// START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		// Modified By NitinVS on 10 Aug 2005 for PMLifeLine SP4 IssueID 2 		
		// Changed the height to 625 and Top to 75

		// function Discussion_OnClick(queryid)
		function Discussion_OnClick(queryid,Token)
		{
			//window.open("CRM_DiscussionThread.aspx?QueryID=" + queryid ,"_Discussions","resizable=yes,scrollbars=no,left=100,top=75,width=600,height=625");
		//Addition of 'Fromwhere' on 8-May-2009,To show Save link on Discussion page on e-dashboard when logged in user is HRM
			window.open("CRM_DiscussionThread.aspx?FromWhere=<%=m_strMode%>&QueryID=" + queryid + "&PKToken=" + Token,"_Discussions","resizable=yes,scrollbars=no,left=100,top=75,width=600,height=625");
			//End of addition by SuchitraP on 8-May-2009
			
			// END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		}
		// End Modification By NitinVS on 10 Aug 2005 for PMLifeLine SP4 IssueID 2 	

		function Page_OnClick(page)
		{
		    //Modified by SuchitraP on 4-Sept-2008 for showing Publish toKM and WF approvals links
			//objform.action = "CRM_Dashboard.aspx?SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=" + page;
			objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=" + page;
			//End by SuchitraP
			objform.submit();
		}
		// Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
		// function Query_OnClick(queryid)
		function Query_OnClick(queryid,Token)
		{
			
			//window.open("CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=DB&QueryID=" + queryid ,"_requestdetail","resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700"); 
			//Commented and added by ShraddhaM on 1,Aug 2007			 
			//To persists Paging number after saving reuest from edit mode
			//window.open("CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=DB&QueryID=" + queryid + "&PKToken=" + Token ,"_requestdetail","resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700"); 					 
						
			window.open("CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=DB&PageNumber=<%=m_intPageNumber%>&QueryID=" + queryid + "&PKToken=" + Token ,"_requestdetail","resizable=yes,scrollbars=no,left=100,top=100,height=600,width=700"); 
			//End of Comment and addition by ShraddhaM on 1,Aug 2007	
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
					//Added by Manishk on 25th Feb 2006 for PMLifeLine for helpdesk enhancements for issue id 1936
					if (xmlhttp.responseText == "0")
					//End of Added by Manishk on 25th Feb 2006 for PMLifeLine for helpdesk enhancements for issue id 1936
					alert('Either Tasks ,Issues ,Deliverables or Resources are already mapped to this request ! so cannot move this request to Other Department');
					else
					window.open("CRM_EscalateHelpDeskRequest.aspx?fromwhere=FromDB&PKToken=" + strTokenChangeDept + "&QueryID=" + xmlhttp.responseText,"","resizable=yes,scrollbars=no,left=100,top=100,height=310,width=760"); 	
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
			var url="CRM_EscalateHelpDeskRequest.aspx?IsXMLHTTP=1&fromwhere=FromDB&QueryID=" + queryid + "&PKToken=" + strToken;
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
			//objform.action = "CRM_Dashboard.aspx?Action=SET_DEFAULT_LOCATION&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&Action=SET_DEFAULT_LOCATION&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
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
			//objform.action = "CRM_Dashboard.aspx?Action=SET_DEFAULT_STATUS&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&Action=SET_DEFAULT_STATUS&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			//End by SuchitraP
			/*
			//Modified By KapilGK On 19 Oct 2006
			objform.action = "CRM_Dashboard.aspx?Action=SET_DEFAULT_STATUS&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&FilterID="+objFilter.value+"&StatusID="+objStatus.value+"&LocationID="+objLocation.value;
			*/
			objform.submit();
		}
		
		//Added By Bharat
			function cboDepartment_OnChange()
		{
		    //Modified by SuchitraP on 4-Sept-2008 for showing Publish toKM and WF approvals links
			//objform.action = "CRM_Dashboard.aspx?Action=SET_DEFAULT_STATUS&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&Action=SET_DEFAULT_DEPARTMENT&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			//End by SuchitraP
			/*
			//Modified By KapilGK On 19 Oct 2006
			objform.action = "CRM_Dashboard.aspx?Action=SET_DEFAULT_STATUS&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&FilterID="+objFilter.value+"&StatusID="+objStatus.value+"&LocationID="+objLocation.value;
			*/
			objform.submit();
		}
		//Ended By Bharat
	
        function cboDateFilter_OnChange()	
        {
			objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&Action=SET_DEFAULT_DATEFILTER&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			objform.submit();
        
        }
		function cboFilter_OnChange()
		{
		    
		    //Modified by SuchitraP on 4-Sept-2008 for showing Publish toKM and WF approvals links
			//objform.action = "CRM_Dashboard.aspx?Action=SET_DEFAULT_FILTER&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&Action=SET_DEFAULT_FILTER&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
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
			//objform.action = "CRM_Dashboard.aspx?SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			//End by SuchitraP
			objform.submit();
		}
		function optRequest_OnClick(mode)
		{
			switch(true)
			{
			case (mode==0):
				objform.action = "CRM_Dashboard.aspx?Mode=MD";
				objform.submit();
				break;
			case (mode==1):
				objform.action = "CRM_Dashboard.aspx?Mode=DB";
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
			//objform.action = "CRM_Dashboard.aspx?PageNumber=<%=m_intPageNumber%>&SortBy=" + sortby + "&SortOrder=" + sortorder;
			objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&PageNumber=<%=m_intPageNumber%>&SortBy=" + sortby + "&SortOrder=" + sortorder;
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
			//objform.action = "CRM_Dashboard.aspx?Action=" + action + "&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>"
			objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&Action=" + action + "&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>"
			//End by SuchitraP
			objform.submit();
		}
	
		function DrillDown_OnClick(itemid,colname, colvalue)
		{
			window.open ("CRM_DrillDown_Detail.aspx?DashboardID=53&ItemID=" + itemid + "&colname=" + replaceSubstring(URLEncode(colname),"|||","'") + "&colvalue=" + replaceSubstring(URLEncode(colvalue),"|||","'") , "_drillDown","left=100,width=700,height=400,scrollbar=yes,resizable=yes,scrollbars=yes");
			window.status = "View drill downs";
		}

		<%' Modified By NitinVS on 9 May 2007 for PMLifeLine %>
	
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			//debugger
			//WindowLoading();
//			 
//			 DT = document.getElementById("DateTitle"); //Date Title

//     
//        LToolTip = document.getElementById('divLTooltip');
//        RToolTip = document.getElementById('divRTooltip');


			
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 2;

			//if (intDivHeight < 700)	intDivHeight = 430;
			if (intDivHeight < 100)	intDivHeight = 100;
			
			if(navigator.appName == 'Netscape')
			{
			    // intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 80
                //commented by Shamkant S on 6 Nov 2015
			    intDivHeight = (window.innerHeight - objdivlist.offsetTop) - 6;
			}
            else
			intDivHeight = (window.innerHeight - objdivlist.offsetTop) - 6; // Added By Vaijat K ON 07/12/2015
			objdivlist.style.height = intDivHeight + 'px' ;	
			
            
            //objdivlist.style.height = intDivHeight
             
		
			if(objdivGrid != null)
			{
			     
                
			    //objdivGrid.style.height = intDivHeight-140;
                //commented by Shamkant S 0n 6 Nov 2015
			    objdivGrid.style.height = (intDivHeight - 102)  + 'px';
			   
			}
			//harshada d for PMLifeLine for helpdesk enhancements 1936

			objform.action = "CRM_Dashboard.aspx?Action=SET_DEFAULT_FILTER&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
			//end of addition harshada d for PMLifeLine for helpdesk enhancements 1936
			document.getElementById('fillDiv').style.display="none";
			
//			isLorR = "R";		
//	
//			// var objtblGanttView = GetObjectReference('CRM_Dashboard','tblGanttView');			
//			//debugger;
//			
//			 
//	        for(i=0;i<arrVertRight.length;i++)
//	        {   
//		        vert = document.getElementById('verR'+i);
//		        
//		        lastTD = document.getElementById(arrVertRight[i]);
//		      		        
//		        if(vert && lastTD)		        
//		        {  
//			        if(!DT_TD_width)
//			        DT_TD_width = lastTD.offsetWidth;	
//			        initVert(vert,lastTD);
//			        vert.setAttribute("RB_TDID",arrVertRightRB[i]);
//			        vert.setAttribute("Index",i); 
//			         
//			        arrVertRightTopPos[i] =  getPosition(vert).y - 45 ;
//        			
//		        }        		
//        		
//	        }
//	        isLorR = "L";		
//	        for(i=0;i<arrVertLeft.length;i++)
//	        {   
//		        vert = document.getElementById('verL'+i);
//		        lastTD = document.getElementById(arrVertLeft[i]);
//		        if(vert && lastTD)		       
//		        {   
//			        if(!DT_TD_width)
//			        DT_TD_width = lastTD.offsetWidth;	
//			        initVert(vert,lastTD);  
//			        vert.setAttribute("LB_TDID",arrVertLeftLB[i]);
//			        vert.setAttribute("Index",i);
//			        
//			         
//			        arrVertLeftTopPos[i] =  getPosition(vert).y - 45 ;
//		        }
//        		
//	        }				 


//            if(document.getElementById('Task'))
//	        {
//                vertTopBondary = getPosition(document.getElementById('Task')).y - 2 ; // - document.getElementById('Role').offsetHeight;
//	            vertBottomBondary = getPosition(document.getElementById('Task')).y + objdivlist.offsetHeight - (document.getElementById('Task').offsetHeight/2);
//            }  
//              objdivlist.onscroll=Scroll;	
//		        Scroll();        		
        		
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			
			UpdateWindowSize();
						
		    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop ;
			intDivHeight = (window.innerHeight - objdivlist.offsetTop) - 6;
			//if (intDivHeight < 700)	intDivHeight = 430;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';		
			if(objdivGrid != null)
			{ 
				objdivGrid.style.height = intDivHeight-102 + 'px';
			}			
		}
		
		<%' End Modified By NitinVS on 9 May 2007 for PMLifeLine %>
				
		// Added By NitinVS on 22 July 2005 for PMLifeLine SP4 IssueID 2
		function GO_OnClick(FromWhere)
		{
			var objtxtRequestId;
			objtxtRequestId = GetObjectReference('frmDashboard','txtRequestId');
			
		   //Added by KanchanH on 4-Dec-2008 for RequestID-17029(Disallow quote).
		    var spChars=(arguments.length>3)?arguments[3]:"'";
        	if (hasSpecialCharacters(getInputValue(objtxtRequestId),spChars)) 
        	{
			alert("Single quote is not allowed in Request ID!");
			objtxtRequestId.focus();
			return 
			}
			//End of addition by KanchanH on 4-Dec-2008 for RequestID-17029.

			
			if (!disallowBlank(objtxtRequestId,"<%=mybase.GetResourceString("ENTERREQUESTID")%>",true) && (!disallowNonNumeric(objtxtRequestId,"<%=mybase.GetResourceString("NUMERIC")%>",true)) && (!disallowNegativeNumeric(objtxtRequestId,"<%=mybase.GetResourceString("POSITIVE")%>",true)) & (!disallowNonInteger(objtxtRequestId,"<%=mybase.GetResourceString("INTEGER_REQUESTID")%>",true)) )
			{
					if (Number(objtxtRequestId.value) ==0)
					{
						alert("Request ID should be greater than zero!");
						return;
					}
			//Modified by SuchitraP on 4-Sept-2008 for showing Publish toKM and WF approvals links		
			//objform.action = "CRM_Dashboard.aspx?&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&Search=1&QueryID=" + objtxtRequestId.value;
			objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>&Search=1&QueryID=" + objtxtRequestId.value;
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
				GO_OnClick('DB');
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
				var objtxtpageNumber =  GetObjectReference('frmDashboard','txtPageNumber');
				var objtxtNoOfPages = GetObjectReference('frmDashboard','txtNoOfPages');
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
		
		function SupportDashboard_OnClick()
		{
			window.open ("../CDB/CDB_Main.aspx?DashboardID=10206","_SupportDashboard","resizable=yes,scrollbars=no,left=" + (window.screen.width - 700)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=700,height=400");
		}
		// Integrated by ArchanaN on 26 Apr 2007
		    //Added by SrikanthY on 05 Jan 2007 To Open Flag Page from e-Dahboard List page
		function Flag_OnClick(QueryID,PKToken)
		{
		    window.open ("../DB/DB_TrackingDetails.aspx?ProjectID=0&ContextID=" + QueryID + "&PKToken=" + PKToken +"&ContextType=HelpDeskRequest&FromWhere=DB&FromWhich=HelpDesk","_blank","resizable=yes,scrollbars=no,left=" + (window.screen.width - 540)/2 + ",top=" + (window.screen.height - 430)/2 + ",width=420,height=300" );
		}
        //End of Addition by SrikanthY
        //Added by SrikanthY on 02 Mar 2007 To provide New feature Show Report
        function ShowReport_OnClick()
		{
			window.open ("CRM_ShowReport.aspx?eDB=1","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=300");
		}
		//End of Addition by SrikanthY on 02 03 2007

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
	
	if(parseInt(noOfPages)<parseInt(objtxtpageNumber.value))
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
<%'Added by SandipL%>
function ShowSLA_Onclick()
{

var objFilter = GetObjectReference('frmDashboard','cboFilter');
    //window.open ("CRM_SLA.aspx?Mode=DB&FilterID=" + objFilter.value,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");
    //Added by Chakshuta H on 1st-Aug-2016 Purpose: To generate and validate Token
$.ajax({
    type: 'POST',
    dataType: 'json',
    contentType: 'application/json',
    url: 'CRM_Dashboard.aspx/GenrateShowSLAToken',
    data: JSON.stringify({ FilterID: objFilter.value}),
			        success: function (Result) {
			            //window.open("../DM/DM_CheckListResponse.aspx?Mode=SHOW&view=1&ShowPreview=1&RevisionID=1&cboApproverID=0&CheckListID=" + QuestionnaireID + "&PKCheckListToken=" + Result.d, "", "resizable=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 900) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=900,height=500");                         		            
			            window.open ("CRM_SLA.aspx?Mode=DB&FilterID=" + objFilter.value+"&PkShowSLAToken="+Result.d,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");

                     },
                     error: function () {
                         //alert("Error")
                     }
			    });

    //End Of Added by Chakshuta H on 1st-Aug-2016 Purpose: To generate and validate Token
}

//Added by RuchiraC for Helpdesk Dashboard Graph on 17 Sep//
function ShowHelpDeskGraph_Onclick()
{

window.open ("../Home/DetailView.aspx?MenuGroupID=16","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");
 
//end by RuchiraC
}

function ShowCounter_Onclick()
{

var objFilter = GetObjectReference('frmDashboard','cboFilter');
    //window.open ("CRM_CounterGraphs.aspx?Mode=DB&FilterID=" + objFilter.value,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");
    //Added by Chakshuta H on 1st-Aug-2016 Purpose: To generate and validate Token
    $.ajax({
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        url: 'CRM_Dashboard.aspx/GenrateShowCounterToken',
        data: JSON.stringify({ FilterID: objFilter.value}),
        success: function (Result) {
            //window.open("../DM/DM_CheckListResponse.aspx?Mode=SHOW&view=1&ShowPreview=1&RevisionID=1&cboApproverID=0&CheckListID=" + QuestionnaireID + "&PKCheckListToken=" + Result.d, "", "resizable=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 900) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=900,height=500");                         		            
            //window.open ("CRM_SLA.aspx?Mode=DB&FilterID=" + objFilter.value+"&PkShowSLAToken="+Result.d,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");
            window.open ("CRM_CounterGraphs.aspx?Mode=DB&FilterID=" + objFilter.value +"&PkShowCounterToken="+Result.d,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");

        },
        error: function () {
            //alert("Error")
        }
    });

    //End Of Added by Chakshuta H on 1st-Aug-2016 Purpose: To generate and validate Token
}
function RequestSLA_OnClick(QueryID)
{
    //Commented and added by Nilesh g on 22/1/2016 for Security URL Issue
	//window.open ("CRM_SLADetails.aspx?Mode=DB&RequestSLA=1&QueryID="+QueryID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
    GenerateURL_RequestSLA(QueryID);
}

function GenerateURL_RequestSLA(QueryID)
{
    //Commented and added by Nilesh g on 22/1/2016 for Security URL Issue
       $.ajax({
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json',
        url: 'CRM_Dashboard.aspx/GenrateURLToken_RequestSLA',
        data: JSON.stringify({ Queryid: QueryID }),
        success: function (Result) {
            window.open ("CRM_SLADetails.aspx?Mode=DB&RequestSLA=1&PKToken=" + Result.d +"&QueryID="+QueryID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
      //      window.open("../DM/DM_InitiativeDetails.aspx?WFInstanceID=" + strWFPrimaryKey + "&PKToken=" + Result.d + "&ForWorkflowFrom=WF", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 910) / 2 + ",top=" + (window.screen.height - 600) / 2 + ",width=910,height=600");
        },
        error: function () {
         //   alert("Error")
        }
    });
    //end of Commented and added by Nilesh g on 22/1/2016 for Security URL Issue
}
//Added by RuchiraC for Microlink-RequestID-15,843 on 1-Oct-08
function CSF_OnClick(QueryID)
{
 //window.open ("../Customization/CM_CSFReport.aspx?Mode=EXPORT&QueryID="+QueryID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=300");
 window.open ("../Customization/CM_CSFReport.aspx?QueryID="+QueryID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=300");
}
//End Of Addition by RuchiraC
<%'End addition by SandipL%>

/*//Addition by SuchitraP on 03 July 2008
function PublishKM_OnClick()
{
      //window.open("../General/CommonList.aspx?MasterTagID=20020", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 800)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=800,height=600");
      window.open("../General/CommonList.aspx?MasterTagID=8034", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 1150)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=1150,height=600");
}*/

function WorkflowApprovals_OnClick()
{
     //window.open("../DM/DM_WorkFlowApprovals.aspx?MasterTagID=3936&FromWhere=CRM&EntityID=20023", "", "resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 950)/2 + ",top=" + (window.screen.height - 700)/2 + ",width=950,height=700");
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

//--Added by ShraddhaM on 6,Apr 2009 for PMLifeLine
//--Purpose : To display Description and add activity - TimeSpent against HelpRequest from Helpdesk List page
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
                //while(i<objTD.parentNode.childNodes.length)
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
            //while(i<21) //objTD.parentNode.childNodes.length)
            {  
                objTD.nextSibling.style.borderBottom = '0px solid gray';    
                //objTD.style.borderBottom = '0px solid gray';               
                
                objTD = objTD.nextSibling;
                
                i=i+1;
                 
            }
             
        }
   }    
        var objTR = GetObjectReference('frmDashboard','Description'+QueryID);
        
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
var mousePosition ;
function AddActivity_onClick(QueryID)
{
    var url="CRM_Dashboard.aspx?FromXML=1&Action=AddActivity&QueryID=" + QueryID;
			
	loadXMLDoc(url,'')	
      
}

function SaveActivity_OnClick(QueryID)
{  
     //Added by VijayD on 11 Jun 2009 for StatusFlow configuration
      // Commented by GaneshD on 06 Oct 2009 as the status dropdown shows only those statuses which are configured
            /*
   if (ValidateStatusFlow(QueryID)==false)
   {  return false; }
   */
   //End of modification by GaneshD on 06 Oct 2009
   // Addition end by ViajyD on 11 Jun 2009 
    var ActivityID = GetObjectReference('frmDashboard','hidActivityID'+QueryID).value;
    var Time= GetObjectReference('frmDashboard','txtTime'+QueryID).value;
    var TotalTodaysTime = GetObjectReference('frmDashboard','TimeSpent'+QueryID).getAttribute('TodaysTotalTimeSpent');
     
    var StatusID = GetObjectReference('frmDashboard','hidStatus'+QueryID); 
	var objtxtStatus = GetObjectReference('frmDashboard','txtStatus'+QueryID);   
	 
	   
        
	var objTime;        
	       
    
     if(parseFloat(Time) < 0 && Time != '')
     {
        alert('Please enter positive number');
        setFocus(GetObjectReference('frmDashboard','txtTime'+QueryID));
        return;
     }
    if(isNumeric(Time)==false && Time != '')
    {
        alert('Please enter numeric value');
        setFocus(GetObjectReference('frmDashboard','txtTime'+QueryID));
        return;
    }
    if(Time != '' && ActivityID=='')
    {
        alert('Please select the Activity');
        setFocus(GetObjectReference('frmDashboard','hidActivityID'+QueryID));
        return;
    }
    if(Time == '' && ActivityID!='')
    {
        alert('Please enter Time');
        setFocus(GetObjectReference('frmDashboard','txtTime'+QueryID));
        return;
    }
    //alert(parseFloat(TotalTodaysTime));
    if(parseFloat(TotalTodaysTime) + parseFloat(Time) > 24*60)
    {
        //alert('Time should be less than total minutes in one day i.e. 1440 minutes \n You can add more '+(1440 - Number(TotalTodaysTime)) +' minutes for today.');
        alert('Total minutes in one day should be less than equal to 1440 minutes. \n You can add more '+(1440 - parseFloat(TotalTodaysTime)) +' minutes for today.');
        
        setFocus(GetObjectReference('frmDashboard','txtTime'+QueryID));
        return;
    }  
    
 
    
    var url="CRM_XMLHttp.aspx?FromXML=1&Action=SaveActivity&statusID="+StatusID.value+"&Time="+Time+"&ActivityID="+ActivityID+"&QueryID=" + QueryID;
		        
	loadXMLDoc(url,'')	
	if(Time == '')
	    objTime = 0;
    else
        objTime = Time;
    GetObjectReference('frmDashboard','TimeSpent'+QueryID).setAttribute('TodaysTotalTimeSpent',parseFloat(TotalTodaysTime) + parseFloat(objTime));
	

}

function SearchActivity(QueryID,evt)
{    
     var Activity = GetObjectReference('frmDashboard','txtActivity'+QueryID);
    
    var url="CRM_XMLHttp.aspx?FromXML=1&Action=SearchActivity&Activity="+Activity.value+"&QueryID=" + QueryID;
			
    loadXMLDoc(url,'')	
    displayDiv = true
	showmenuie(Activity,evt,displayDiv,QueryID,200)
}
function ShowStatus(QueryID,evt)
{   
     var Status = GetObjectReference('frmDashboard','txtStatus'+QueryID);
   
    var url="CRM_XMLHttp.aspx?FromXML=1&Action=ShowStatus&QueryID=" + QueryID;
			
    loadXMLDoc(url,'')	
    displayDiv = true;
	showmenuie(Status,evt,displayDiv,QueryID,100)	
	
}
function ShowDetailActivity(evt,QueryID)
{  
    var url="CRM_XMLHttp.aspx?FromXML=1&Action=ShowDetailActivity&QueryID=" + QueryID;
	var objdivActivityDtls = document.getElementById('divActivityDtls');
	    
     objdivActivityDtls.style.innerHTML ="";
     objdivActivityDtls.style.height=0;
     
    objdivActivityDtls.style.display=""; 			
	loadXMLDoc(url,'')	

	var mousePosition = getMousePosition(evt,objdivActivityDtls);	  
		           
   /* objdivActivityDtls.style.left = (window.screen.width - 700)/2 ;
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
	showRequester('divActivityDtls',evt);
}

function ShowRequestorDetails(evt,QueryID,RequestorType)
{   
     
    var url="CRM_XMLHttp.aspx?FromXML=1&Action=ShowRequestorDetails&RequestorType="+RequestorType+"&QueryID=" + QueryID;
	var objdivActivityDtls = document.getElementById('divActivityDtls');
	    
	objdivActivityDtls.style.innerHTML ="";
    
     objdivActivityDtls.style.height=0;
    
    objdivActivityDtls.style.display="";
    				
	loadXMLDoc(url,'')	
	var objdivActivityDtls = document.getElementById('divActivityDtls');
	var mousePosition = getMousePosition(evt,objdivActivityDtls);	  
    
    /*objdivActivityDtls.style.left = (window.screen.width - 700)/2 ;
    objdivActivityDtls.style.width=700;
    objdivActivityDtls.style.top = (window.screen.height - 500)/2;  		           
            
//    objdivActivityDtls.style.left = 200//mousePosition.x;objdivActivityDtls.style.top = mousePosition.y;  
//    objdivActivityDtls.style.width=700;
    //objdivActivityDtls.style.height=200;
    objdivActivityDtls.style.display=""; */
    //showmenuieDA(objdivActivityDtls,evt);
    
      showRequester('divActivityDtls',evt);
    
    /*Commented And Edited by KIRAN K K 30-11-15 For 2434*/
    //objdivActivityDtls.style.height=135+"px"; Commented By Vaijat K ON 22/12/2015
      objdivActivityDtls.style.height="auto";
    /*Commented And Edited End by KIRAN K K 30-11-15 For 2434*/
}

function showRequester(divCM,objevent){
   
//var objdiv = GetObjectReference('',divCM);
var objdiv = document.getElementById(''+divCM);
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
                 
    /*if (rightedge<objDivH)
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
    objdiv.style.position = 'absolute'
    if (WhichBrowser() != 'FF'){
      
        objdiv.style.right = event.pageX + 200 + 'px';
        objdiv.style.left = 0 + 'px';
        if (event.pageY > 700){
            objdiv.style.top= event.pageY - 100 + 'px';
        }
        else{
            objdiv.style.top= event.pageY + 'px';
        }
    }
    else
    {
        objdiv.style.right = objevent.pageX + 200 + 'px';
        objdiv.style.left = 0 + 'px';
        if (objevent.pageY > 700){
            objdiv.style.top= objevent.pageY - 100 + 'px';
        }
        else{
            objdiv.style.top= objevent.pageY + 'px';
        }
    }
    objdiv.style.height = "auto";
   return false;
  
   }
   
function ShowStatistics(evt,QueryID,RequestorType)
{
     var url="CRM_XMLHttp.aspx?FromXML=1&Action=ShowStatistics&RequestorType="+RequestorType+"&QueryID=" + QueryID;
     var objdivActivityDtls = document.getElementById('divStatistics');
     objdivActivityDtls.style.innerHTML ="";
    /* objdivActivityDtls.style.height=0;*/
     
     objdivActivityDtls.style.display="";     			
	 loadXMLDoc(url,'')	
	 //var mousePosition = getMousePosition(evt,objdivActivityDtls);

  /*  objdivActivityDtls.style.left = (window.screen.width - 700)/2 ;
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
    
     showRequester('divStatistics',evt);

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
   GetObjectReference('frmDashboard','txtActivity'+QueryID).value = Activity;
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
		        var objtxtSavingLable = GetObjectReference('frmDashboard','txtSavingLable'+QueryID);
		        
		        objtxtSavingLable.style.display = '';
		        
		        var objTotalTime = GetObjectReference('frmDashboard','TotalTime'+QueryID);		        
		        
		        var TotalTime = GetObjectReference('frmDashboard','TotalTime'+QueryID).getAttribute('TotalTime');		        
		        
		        var objActivity = GetObjectReference('frmDashboard','txtActivity'+QueryID);		        
		        
		        var objActivityID = GetObjectReference('frmDashboard','hidActivityID'+QueryID);		        
		        
		        var objTime=GetObjectReference('frmDashboard','txtTime'+QueryID);		       
		        
		        var objStatus = GetObjectReference('frmDashboard','Status'+QueryID);
		        var objNewStatus = GetObjectReference('frmDashboard','txtStatus'+QueryID); 			        	       
		        
		       
		        //To Change status in Grid column 
		        if(objStatus)     
		        objStatus.innerHTML = objNewStatus.value
		        
		        var objtxtTime = GetObjectReference('frmDashboard','txtTime'+QueryID) ;
                var objtxtActivity = GetObjectReference('frmDashboard','txtActivity'+QueryID) ; 
                var objimgActivity = GetObjectReference('frmDashboard','imgActivity'+QueryID) ; 
                var objbtnSave = GetObjectReference('frmDashboard','btnSave'+QueryID) ;  
        
                var  objtxtStatus = GetObjectReference('frmDashboard','txtStatus'+QueryID) ;  
                var  objhidtxtStatus = GetObjectReference('frmDashboard','hidStatus'+QueryID) ;
        		        
		            
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
		         
		        var NewTotalTime = TotalTime //TotalTime.substring(start+1,stop);
		        
		        if(objTime.value != '')
		        {		        
		            var ConvertedTime = parseFloat(NewTotalTime) + parseFloat((parseFloat(objTime.value)/60).toFixed(2));
    		             		           		        
		            objTotalTime.innerHTML = '<U><B><A onClick=ShowDetailActivity(event,' + QueryID + ') >Total Time Spent </A></U>&nbsp;:&nbsp;' + ConvertedTime + '&nbsp;Hrs</B>&nbsp;&nbsp;'
		            GetObjectReference('frmDashboard','TotalTime'+QueryID).setAttribute('TotalTime',ConvertedTime);
		            
		        }				        
		        		        
		        objActivity.value = '';
		        objActivityID.value = '';
		        objTime.value = '';
		        
		        var code ;
		        code = "var objtxtSavingLable = GetObjectReference('frmDashboard','txtSavingLable"+QueryID+"'); objtxtSavingLable.style.display = 'none';"
		        setTimeout(code,400);
		        
		        
		        setFocus(objTime);
		        
		        if(objdiv)
		        {
		            objdiv.style.display='none';
		        }
		    }
		    /*else if(result[0] == 'ShowActivity')
		    {		         
	            var objdivActivityDtls = document.getElementById('divActivityDtls')
	            objdivActivityDtls.style.display="";
            			
			    objdivActivityDtls.style.left = (document.body.offsetWidth-document.getElementById('tblActivityDtls').offsetWidth)/2 + 40;
			    objdivActivityDtls.style.top= vertTopBondary; 
            			
			    document.getElementById('fillDivDB').style.display="block";
		    }*/
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
		            if(result[1] == 'ShowView')
		            {		                      
		                        var objdivTblX = GetObjectReference('frmDashboard','divTblX');
	                            objdivTblX.innerHTML = result[0];	
                                objdivTblX.style.left = mousePosition.x    ;
                                objdivTblX.style.top = mousePosition.y  ;  
                                //objdivTblX.style.width=200;     
                                objdivTblX.style.display="";
                                var objdivTblXX = GetObjectReference('frmDashboard','divTblXX');
                                var objTblXX = GetObjectReference('frmDashboard','TblXX');
		                       
		                       var objchkAll = GetObjectReference('frmDashboard','chkAll');
		                       var objchkField = GetObjectReference('frmDashboard','chkField',true);
		                     		                      
		                      var Ischeck;
		                      
		                      for(i=0;i<objchkField.length;i++)
		                      {
		                        if(objchkField[i].checked==true)
		                        {
		                              Ischeck = true;
		                        }
		                        else
		                        {
		                             Ischeck = false;
		                             break;
		                        }
		                      }
		                      if(Ischeck==true)
		                      {
		                        objchkAll.checked=true
		                      }
		            }
		            else if(result[1] == 'ShowStatistic')
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
        
        /*Commented And Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing*/
        /*objContextMenu.style.left = intX;
        objContextMenu.style.top = intY;*/
        objContextMenu.style.left = intX  + "px";
        objContextMenu.style.top = intY  + "px";
        /*End Of Commented And Added By Chakshuta H on 13th-Oct-2015 Purpose::Issue Fixing*/
       
    }  
      
      return {x:objContextMenu.style.left,y:objContextMenu.style.top};
	
}

function showmenuie(element,objevent,displayDiv,QueryID,width)
{       
    //objdiv.style.position = 'absolute';
    var ret = new Point();
    if(displayDiv == true)
    {
         
       objdiv.style.display='';
       objdiv.style.position = 'absolute'; 
       objdiv.style.height='75px';
       
       
            for(; 
                element && element != document.body;
                ret.translate(element.offsetLeft, element.offsetTop), element = element.offsetParent
                );                  

        intBottom = document.body.offsetTop + document.body.offsetHeight;
        
         
            if (intBottom - ret.y < objdiv.offsetHeight)
            {ret.y = ret.y - objdiv.offsetHeight;}
         
        
        if(navigator.appName != 'Netscape')
        { 
            //Commented And Added by Chakshuta H on 14th-Oct-2015 Purpose::issue fixing
            //objdiv.style.left = ret.x + 4;
            objdiv.style.left = ret.x + 4 + "px";
            //End Commented And Added by Chakshuta H on 14th-Oct-2015 Purpose::issue fixing
        }  
        else
        {
            //Commented And Added by Chakshuta H on 14th-Oct-2015 Purpose::issue fixing
            //objdiv.style.left = ret.x + 6;
            objdiv.style.left = ret.x + 6 + "px";
            //End Of Commented And Added by Chakshuta H on 14th-Oct-2015 Purpose::issue fixing
        }          
         
        if(navigator.appName != 'Netscape')
        {
            //Commented And Added by Chakshuta H on 14th-Oct-2015 Purpose::issue fixing
            //objdiv.style.top=ret.y - 5 - objdivGrid.scrollTop ; //- objdiv.style.height ;
            objdiv.style.top=ret.y - 5 + "px"; - objdivGrid.scrollTop ; //- objdiv.style.height ;
            //End Of Commented And Added by Chakshuta H on 14th-Oct-2015 Purpose::issue fixing
        }
        else
        { 
            //Commented And Added by Chakshuta H on 14th-Oct-2015 Purpose::issue fixing
            //objdiv.style.top=ret.y + 15 - objdivGrid.scrollTop ; //- objdiv.style.height ;
            objdiv.style.top=ret.y + 15 + "px"; - objdivGrid.scrollTop ; //- objdiv.style.height ;
            //End Of Commented And Added by Chakshuta H on 14th-Oct-2015 Purpose::issue fixing
        } 
        
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
        objdiv.style.left = ret.x + 'px';
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
 //alert('1');   
  
 //if(keyID == 13 || keyID ==0)
 //{    
      //var objSTatusID = GetObjectReference('frmDashboard','txtStatus'+QueryID) ; 
      var StatusID = GetObjectReference('frmDashboard','hidStatus'+QueryID); 
       
      if( Control == 'txtStatus')
      {       
        
        var objOldStatusDate = GetObjectReference('frmDashboard','hidStatusChangeDate');
        var objOldStatusTime = GetObjectReference('frmDashboard','hidStatusChangeTime');
        var objCurrentDate = GetObjectReference('frmDashboard','hidCurrentDate');
        var objCurrentTime = GetObjectReference('frmDashboard','hidCurrentTime');
        
        var objtxtTime = GetObjectReference('frmDashboard','txtTime'+QueryID) ;
        var objtxtActivity = GetObjectReference('frmDashboard','txtActivity'+QueryID) ; 
        var objhidtxtActivity = GetObjectReference('frmDashboard','hidActivityID'+QueryID) ; 
        
        var objimgActivity = GetObjectReference('frmDashboard','imgActivity'+QueryID) ; 
        var objbtnSave = GetObjectReference('frmDashboard','btnSave'+QueryID) ;  
        
        var  objtxtStatus = GetObjectReference('frmDashboard','txtStatus'+QueryID) ;  
        var  objhidtxtStatus = GetObjectReference('frmDashboard','hidStatus'+QueryID) ;

         if(objOldStatusDate.value==objCurrentDate.value && objOldStatusTime.value==objCurrentTime.value) 
	    {												  
	    	    alert("Status Change date & time should be greater than previous status Change date '"+objOldStatusDate.value+"' and time '"+objOldStatusTime.value+"'.");		
			    return;
	    }       
	    
       if(ID!=2)
       {
             
            objtxtTime.disabled = false;  
            //objtxtActivity.onClick = " SearchActivity(" + QueryID + ",event)";    
            objtxtActivity.disabled = false;      
            objimgActivity.onClick = " SearchActivity(" + QueryID + ",event)";            
            objimgActivity.disabled = false;
            objbtnSave.disabled = false;   
            
       }
       else
       {
            objtxtTime.disabled = true;      
            objtxtActivity.disabled = true;  
            objtxtTime.value = '';      
            objtxtActivity.value = '';    
            objhidtxtActivity.value = '';  
            //objimgActivity.onClick = "";
            objimgActivity.disabled=true;
            
       } 
        
     
        
        GetObjectReference('frmDashboard','hidStatus'+QueryID).value =  ID;
//        var StatusID = GetObjectReference('frmDashboard','hidStatus'+QueryID);
//	    var url="CRM_Dashboard.aspx?FromXML=1&Action=SaveStatus&statusID="+StatusID.value+"&QueryID=" + QueryID;
//    			
//	    loadXMLDoc(url,'')	
      }
      else if(Control == 'txtActivity')
      {
        GetObjectReference('frmDashboard','hidActivityID'+QueryID).value = ID;
      }
      GetObjectReference('frmDashboard',Control+QueryID).value = Text;
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
                        
     
        
var SelectClearAllX=0;

function View_onClick(evt)
{ 

    var objdivTblX = GetObjectReference('frmDashboard','divTblX');
    var url="CRM_XMLHttp.aspx?Page=Dashboard&FromXML=1&Action=ShowView&From=DB&SelectClearAllX=" + SelectClearAllX;
 		 mousePosition = getMousePosition(evt,objdivTblX);		  
	 loadXMLDoc(url,'')       	
                                
                               
}
 function CloseFilter()
 {
    var objdivTblX = GetObjectReference('frmDashboard','divTblX');
    if(objdivTblX);
    objdivTblX.style.display='none';
    
 }
 function applyFilter()
 { 
    
    objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&Apply=APPLYVIEW";		    
    objform.submit();
     
 
 }
  
 function SelectAndClearAll_OnClick()
 {
    var obSCFilterX = GetObjectReference('frmDashboard','chkAll');
                 
                if(obSCFilterX!=null){
                    if(obSCFilterX.checked==true)
                        SelectClearAllX = 0;
                    else
                        SelectClearAllX = 1;
                }
                if(SelectClearAllX==0){
                
                    SelectAllCheckboxs('frmDashboard','chkField');
                    SelectClearAllX = 1;
                }
                else
                {
                    ClearAll_OnClick('frmDashboard','chkField');
                   //  obhdnXAxisFilterString.value = "";
                    SelectClearAllX=0;
                }
 }
 
 function Requestor_keypress(e)
 {
     
    if(e.keyCode == 13)
    {      
        objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&RequestorAction=SET_DEFAULT_REQUESTOR";		    
        objform.submit();
    }
    
 }
  
  function cboSearch_OnChange()
  {
    var ojbSearchFieldvalue =  GetObjectReference('frmDashboard','cboSelectSearch').value;
    var cboPriority = GetObjectReference('frmDashboard','cboPriority');
    var cboAssignedTo = GetObjectReference('frmDashboard','cboAssignedTo');
    var cboCustomer = GetObjectReference('frmDashboard','cboCustomer');
    var cboEmployee = GetObjectReference('frmDashboard','cboEmployee');
    var cboLocation = GetObjectReference('frmDashboard','cboLocation');
    var cboRequestType = GetObjectReference('frmDashboard','cboRequestType');
    var cboSubRequestType = GetObjectReference('frmDashboard','cboSubRequestType');
    var txtSubject = GetObjectReference('frmDashboard','txtSubject');
    var cboSeverity = GetObjectReference('frmDashboard','cboSeverity');
    var searchfor = GetObjectReference('frmDashboard','searchfor');
    cboPriority.style.display="none";
    cboAssignedTo.style.display="none";
    cboCustomer.style.display="none";
    cboEmployee.style.display="none";
    cboLocation.style.display="none";
    cboRequestType.style.display="none";
    cboSubRequestType.style.display="none";
    txtSubject.style.display="none";
    cboSeverity.style.display="none";    
    
    switch (ojbSearchFieldvalue)
    {
        case "Priority":
            searchfor.style.display="";  
            cboPriority.style.display="";
        break;

        case "Assigned To":
            searchfor.style.display="";          
            cboAssignedTo.style.display="";
        break;

        case "Customer":
            searchfor.style.display="";          
            cboCustomer.style.display="";
        break;

        case "Employee":
            searchfor.style.display="";          
            cboEmployee.style.display="";
        break;
        
        case "Location":
            searchfor.style.display="";          
            cboLocation.style.display="";
        break;

        case "Request Type":
            searchfor.style.display="";          
            cboRequestType.style.display="";
        break;

        case "Sub Request Type":
            searchfor.style.display="";          
            cboSubRequestType.style.display="";
        break;

        case "Subject":
            searchfor.style.display="";          
            txtSubject.style.display="";
        break;
        case "Severity":
            searchfor.style.display="";          
            cboSeverity.style.display="";
        break;    
        default:
            
            cboPriority.style.display="none";
            cboAssignedTo.style.display="none";
            cboCustomer.style.display="none";
            cboEmployee.style.display="none";
            cboLocation.style.display="none";
            cboRequestType.style.display="none";
            cboSubRequestType.style.display="none";
            txtSubject.style.display="none";
            cboSeverity.style.display="none";    
            searchfor.style.display="none";     
    }
    
     
//			objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
//			objform.submit();
 
  }
  

function ApplyAdvancedFilter()
{
		objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&Action=SET_DEFAULT_SEARCH_FILTER&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
		//objform.action = "CRM_Dashboard.aspx?Mode=<%=m_strMode%>&SortOrder=<%=m_strSortOrder%>&SortBy=<%=m_strSortBy%>&PageNumber=<%=m_intPageNumber%>";
		objform.submit();
    
}
//Ended by ShraddhaM on 7,Apr 2009 for PMLifeLine
 
//Added by VijayD on 11 Jun 2009 for StatusFlow configuration
function ValidateStatusFlow(QueryID)
{
    var validStatusNew;
    var validStatusExist;

    var objOldStatus = GetObjectReference('frmDashboard','txtOldStatus'+QueryID);
    var objNewStatus = GetObjectReference('frmDashboard','txtStatus'+QueryID);

    var objCompareStatus = GetObjectReference('frmDashboard','CmbStatus'+QueryID);
    var objPrevStatus = GetObjectReference('frmDashboard','CmbPrevStatus'+QueryID);
    var objStatusFlowCount = GetObjectReference('frmDashboard','StatusFlowCount'+QueryID);
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

//Added by Amit Mahadik on 19 August 2011 PMLifeLine (FAQ)
function Faq_OnClick(DeptMode,UserID,DepartmentName)
{
    window.open("../CRM/FrequentlyAskQuestions_CommonList.aspx?MasterTagId=9017&Mode=RO&QueryID=NULL&DeptFlag=" + DeptMode + "&eid="+ UserID +"&DepartmentName="+ DepartmentName +"  ","FAQ","resizable=yes,scrollbars=no,left=" + (window.screen.width - 920)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=920,height=600");
}
//End Added by Amit Mahadik on 19 August 2011 PMLifeLine (FAQ)

// Addition end by ViajyD on 11 Jun 2009    
        </script>
	</body>
</HTML>
