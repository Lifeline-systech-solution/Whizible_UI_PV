<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_IssueEntryForReview.aspx.vb" Inherits="PbNIT.IB_IssueEntryForReview" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%PlotPageHeadTag()%>
    <%CommonFunctions.General.PlotPageHeadTag("")%>
   
	<body class="clsBody" MS_POSITIONING="GridLayout" onload="Window_OnLoad()">
		
					<form id="frmIssueEntryForReview" method="post" runat="server">
						
									<%BuildPage()%>
							
					</form>
		
					<script language="javascript">

	<%MyBase.InitializeResources("AppResources.IB_IssueEntryForReview", "AppResources")%>

	var objfrmIssueEntryForReview = GetFormReference('frmIssueEntryForReview')
	
	var objOldAssignTo = GetObjectReference('frmIssueEntryForReview','OldAssignTo')
	var objReportedBy = GetObjectReference('frmIssueEntryForReview','ReportedBy')
	var objReportedDate = GetObjectReference('frmIssueEntryForReview','ReportedDate')
	var objDueDate = GetObjectReference('frmIssueEntryForReview','DueDate')
	var objAssignTo = GetObjectReference('frmIssueEntryForReview','AssignTo')
	var objPriority = GetObjectReference('frmIssueEntryForReview','Priority')
	var objSeverity = GetObjectReference('frmIssueEntryForReview','Severity')
	var objDuration = GetObjectReference('frmIssueEntryForReview','Duration')
	var objType = GetObjectReference('frmIssueEntryForReview','Type')
	var objStatus = GetObjectReference('frmIssueEntryForReview','Status')
	var objPriorityFixInDays = GetObjectReference('frmIssueEntryForReview','PriorityFixInDays')
	var objFoundInPhase = GetObjectReference('frmIssueEntryForReview','FoundInPhase');//Added By PadmnabhA IssueID 15368
	var objSummary = GetObjectReference('frmIssueEntryForReview','Summary')
	var objDescription = GetObjectReference('frmIssueEntryForReview','Description')
	
	 /*'****Code Added*******
        'By     :   DipaliS
        'Reason :   Reported Time Feature
        'Date   :   1 July 2004
        'Requirement Number :   IB_PBN_ENT_04
        'Addition Made  :   Declare the object of Reported Time For Validation
        */
	
	var objReportedTime=GetObjectReference('frmIssueEntryForReview','ReportedTime')
	/*************End Addition**********/

            <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
    
	function Save_OnClick()
	{
		var ProjectId = <%=m_ProjectID%>;
	
		if(!ValidateControls()) 
			return;
		
		EnableControls();
		
		<%If Trim(Request.QueryString("ProjectId"))<>"" Then %>  
			ProjectId=<%=m_ProjectID%>;
		<%End If%>
		
		objfrmIssueEntryForReview.action = "IB_IssueEntryFOrReview.aspx?Mode=<%=strMode%>&Action=Save&ProjectID=" + ProjectId + "&ReviewStatisticsID=<%=intReviewStatisticsID%>&ReviewActionID=<%=intReviewActionID%>&ReviewCategory=<%=strReviewCategory%>"; 
		objfrmIssueEntryForReview.submit();	
	}
	
	function ValidateControls()
	{
		PopulateDefaultValues();
		
		//Blank Summary
		if (disallowBlank(objSummary,"<%=mybase.GetResourceString("BLANKSUMMARY")%>",true))
			return false;
		
		//Blank Description
		if (disallowBlank(objDescription,"<%=mybase.GetResourceString("BLANKDESCRIPTION")%>",true))
			return false;
		
		//blank Reported by
		if (disallowBlank(objReportedBy,"<%=mybase.GetResourceString("BLANKREPORTEDBY")%>",true))
			return false;
		
		//Valid reported date
		if(objReportedDate.value=="")
		{
			//Modified by harshk for sp4 IssueID 136 
			alert(replaceSubstring("<%=mybase.GetResourceString("INVALIDREPORTEDDATE")%>","&#39;","'"));
			//End Modified by harshk for sp4 IssueID 136 
			return false;
		}

		//Future reported date
		if(compareDates(getDate1(), Trim(objReportedDate.value))==-1)
		{			
			//MODIFIED BY VIVEKP ON 27 SEP 2005 FOR ISSUEID-358
			//Modified by harshk for sp4 IssueID 136 single quote replace by double quote
			alert(replaceSubstring("<%=mybase.GetResourceString("FUTUREREPORTED")%>","&#39;","'")); 
			//End modification by harshk for sp4 IssueID 136
			//MODIFIED BY VIVEKP ON 27 SEP 2005 FOR ISSUEID-358
			setFocus(objReportedDate);
			return false;
		}
		
		//blank Assign to 
		if (disallowBlank(objAssignTo,"<%=mybase.GetResourceString("BLANKASSIGNTO")%>",true))
			return false;
			
		//valid due date
		if(objDueDate.value=="")
		{
			//Modified by harshk for sp4 IssueID 136 
			alert(replaceSubstring("<%=mybase.GetResourceString("INVALIDDUEDATE")%>","&#39;","'"));
			//End Modified by harshk for sp4 IssueID 136 
			return false;
		}
		
		//due date < reported date
		if((objDueDate!=null)&&(objReportedDate!=null))
		{
			if(compareDates(objDueDate.value,objReportedDate.value)==-1)
			{
				//MODIFIED BY VIVEKP ON 27 SEP 2005 FOR ISSUEID-358
				//Modified by harshk for sp4 IssueID 136 single quote replace by double quote
				alert(replaceSubstring("<%=mybase.GetResourceString("DUEDATE>REPORTEDDATE")%>","&#39;","'"));
				//End IssueID 136
				//END OF MODIFICATION ON 27 SEP 2005 FOR ISSUEID-358
				setFocus(objDueDate);
				return false;
			}
		}
		
		if(compareDates(getDate1() , Trim(objDueDate.value))==-1)
		{
			//MODIFIED BY VIVEKP ON 27 SEP 2005 FOR ISSUEID-358
			//Modified by harshk for sp4 IssueID 136 single quote replace by double quote
			alert(replaceSubstring("<%=mybase.GetResourceString("FUTUREDUEDATE")%>","&#39;","'"));
			//End IssueID 136 
			//END OF MODIFICATION ON 27 SEP 2005 FOR ISSUEID-358
			setFocus(objDueDate);
			return false;
		}
		
		//blank Priority 
		if (disallowBlank(objPriority,"<%=mybase.GetResourceString("BLANKPRIORITY")%>",true))
			return false;
			
		//blank duration
		if (disallowBlank(objDuration,"<%=mybase.GetResourceString("BLANKDURATION")%>",true))
			return false;
			
		//Numeric duration
		if(disallowNonNumeric(objDuration,"<%=MYBASE.GETRESOURCESTRING("NUMERICDURATION")%>",true))			
			return false;
			
		//Positive values for duration
		if(disallowNegativeNumeric(objDuration,"<%=MYBASE.GETRESOURCESTRING("POSITIVEDURATION")%>",true))
			return false;

		//Work Hours - in multiples of min da entry
		if((parseFloat(objDuration.value) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)!= parseInt(parseFloat(objDuration.value) / <%=CommonFunctions.Application.MinHoursForDAEntry%>))
		{
			alert("<%=mybase.GetResourceString("MULTIPLES")%>(" + <%=CommonFunctions.Application.MinHoursForDAEntry%> + ")");
			return false;
		}

		//blank type
		
		if (disallowBlank(objType,"<%=MyBase.GetResourceString("BLANKTYPE")%>",true))
			return false;
		
		//blank status
		if (disallowBlank(objStatus,"<%=MyBase.GetResourceString("BLANKSTATUS")%>",true))
			return false;
		/*	Code Added
		By		PadmnabhA
		Reason	blank FoundInPhase
		IssueID	15368
		*/
		if (disallowBlank(objFoundInPhase,"<%=MyBase.GetResourceString("BLANKFOUNDINPHASE")%>",true))
			return false;
		/* Code addition By PadmnabhA Ends*/	
		
		 /*'****Code Added*******
        'By     :   DipaliS
        'Reason :   Reported Time Feature
        'Date   :   1 July 2004
        'Requirement Number :   IB_PBN_ENT_04
        'Addition Made  :   Reported Time Should not be left blank
        */
        if (disallowBlank(objReportedTime,"<%=MyBase.GetResourceString("BLANKREPORTEDTIME")%>",true))
			return false;
			
		if(isTime(objReportedTime,"<%=mybase.GetResourceString("INVALIDTIME",false)%>")==false)
		{
			return false;
		}
		objReportedTime.disabled = false;
        /*********End Addition*********/
		
			
		return true;
	}
	
	function PopulateDefaultValues()
	{
		<%'If strDefaultScript <>"" then%>
		<%'=strDefaultScript%>
		<%'End If%>
	}

	function InsertTimeStamp()
	{
		var objDescription = GetObjectReference('frmIssueEntryForReview','Description')
		var strValue = objDescription.value;
		strValue = strValue + "\n" + "[" + Now(1) + " - <%=m_UserName%>]";
		objDescription.value = strValue;
		setFocus(objDescription);
	}

	function EnableControls()
	{
		<%'If strEnableControlsScript <>"" then%>
		<%'=strEnableControlsScript%>
		<%'End If%>
	}

	function Type_OnChange()
	{
	
		var ProjectId = <%=m_ProjectID%>, FromWhere;
	
		<%If Trim(Request.QueryString("ProjectId"))<>"" Then %>  
			ProjectId=<%=m_ProjectID%>;
		<%End If%>
		
		//EnableControls();
		objfrmIssueEntryForReview.action = "IB_IssueEntryFOrReview.aspx?Mode=<%=strMode%>&Action=TypeChange&ProjectID=" + ProjectId + "&ReviewStatisticsID=<%=intReviewStatisticsID%>&ReviewActionID=<%=intReviewActionID%>&ReviewCategory=<%=strReviewCategory%>"
		objfrmIssueEntryForReview.submit();
	}
	
	function Priority_OnChange()
	{
		objPriorityFixInDays.selectedIndex = objPriority.selectedIndex-1;
		if(objPriorityFixInDays.selectedIndex==-1)
		{
			var duedate = new Date();
			objDueDate.value = duedate.getDate() + "-" + Left(MonthName(duedate.getMonth()),3) + "-" + duedate.getFullYear();
			return;
		 }
		else
		{
			var duedate = new Date(DateAdd(new Date(),objPriorityFixInDays.options[objPriorityFixInDays.selectedIndex].value,0,0));
			objDueDate.value = duedate.getDate() + "-" + Left(MonthName(duedate.getMonth()),3) + "-" + duedate.getFullYear();
		}
	}
	
	function MonthName(intMonth)
	{
		var strMonths = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
		
		if((intMonth < 0) || (intMonth > 11))
			return "";
			
		return strMonths[intMonth];
	}
	
	function Window_OnLoad()
	{
		Priority_OnChange();
		<%if strOnloadClientScript<>"" then%>
		<%=strOnloadClientScript%>
		<%end if%>
		
		setFocus(objSummary);
	}
	/* 
	Procedure	SelectDeliverable()
	Added By	PadmnabhA
	IssueID		15368
	Description	To add Delieverables from page - MasterTagID=2191
	*/
	function SelectDeliverable()
    {	
		objDeliverableID = GetObjectReference('frmCommonPage','DeliverableID');
		window.open('../General/CommonList.aspx?MasterTagID=2176&FromWhere=ReviewAction&DeliverableID=' + objDeliverableID.value,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=800,height=500');
    }
					</script>
	</body>
</HTML>

<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>

<script type="text/javascript" src="../../responsive/responsive.js"></script>

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
