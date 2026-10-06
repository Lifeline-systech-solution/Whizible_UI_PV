<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRM_FilterDetail.aspx.vb" Inherits="PbNIT.CRM_FilterDetail" %>
<!DOCTYPE HTML>
<html>
 	<%CommonFunctions.General.PlotPageHeadTag("Filter Details")%>
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
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id='frmFilterDetails' method='post' runat='server'>
		<%WritePage()%>
		</form>
		<script language="javascript">
		var objform;
		var objdivlist;
		var objcboField;
		var objcboOperator;
		var objtxtDate;
		var objcboAssignTo;
		var objcboFeedback;
		//Added by Santoshk on 2nd Dec 2004
		var objcboRequestType;
		//Addition Ends
		var objcboSubRequestType;
		var objcboSubmittedBy;
		var objcboStatus;
		var objcboPriority;
		var objcboTargetLocation;
		var objcboFeedbackRating;
		var objcboLoginType;
		var objtxtFilter;
		var objtxtFilterName;
		var objtxtValue;
		// Integrated by ArchanaN on 26 Apr 2007
		//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
		var objProduct;
		var objComponent; 
		var objSeverity;
		var objDepartment;
		var objclient;
		//End Addition By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
		var FromWhichClick;	 
		 // Integration Ends

		
		objform = GetFormReference('frmFilterDetails');
		objdivlist = GetObjectReference('frmFilterDetails','divList');
		objcboField = GetObjectReference('frmFilterDetails','cboField');
		objcboOperator = GetObjectReference('frmFilterDetails','cboOperator');
		objtxtDate =  GetObjectReference('frmFilterDetails','txtDate');
		//Commented By ShraddhaM on 23,July 2007 
		//AssignTo COmbo changed to Text Box
		//objcboAssignTo =  GetObjectReference('frmFilterDetails','cboAssignTo');
		//End of Comment By ShraddhaM on 23,July 2007 
		objcboFeedback =  GetObjectReference('frmFilterDetails','cboFeedback');
		//Added by Santoshk on 2nd Dec 2004
		objcboRequestType = GetObjectReference('frmFilterDetails','cboRequestType');
		//Addition Ends
		objcboSubRequestType = GetObjectReference('frmFilterDetails','cboSubRequestType');
		objcboSubmittedBy = GetObjectReference('frmFilterDetails','cboSubmittedBy');
		objcboStatus = GetObjectReference('frmFilterDetails','cboStatus');
		objcboPriority= GetObjectReference('frmFilterDetails','cboPriority');
		objcboTargetLocation = GetObjectReference('frmFilterDetails','cboTargetLocation');
		objcboFeedbackRating = GetObjectReference('frmFilterDetails','cboFeedbackRating');
		objcboLoginType = GetObjectReference('frmFilterDetails','cboLoginType');
		objtxtFilter = GetObjectReference('frmFilterDetails','txtFilter');
		objtxtFilterName = GetObjectReference('frmFilterDetails','txtFilterName');
		objtxtValue = GetObjectReference('frmFilterDetails','txtValue');
		// Integrated by ArchanaN on 26 Apr 2007
		//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
		objProduct = GetObjectReference('frmFilterDetails','cboProduct');
		objComponent=GetObjectReference('frmFilterDetails','cboComponent'); 
		objSeverity=GetObjectReference('frmFilterDetails','cboSeverity'); 
		objDepartment=GetObjectReference('frmFilterDetails','cboDepartment'); 
		//End Addition By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
		//Added by SrikanthY on 26 Mar 2007 to display Client Name field in filter
		objclient=GetObjectReference('frmFilterDetails','cboClient'); 
		//end of addition by SrikanthY on 26 Mar 2007		
			 
		 // Integration Ends

		
		function Back_OnClick()
		{
			window.location.href = "CRM_FilterList.aspx?FromWhere=<%=m_strFromWhere%>&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>&PageNumber=<%=m_strAlphabet%>" ;
		}	
		
			
		
		function ApplyWithoutSaving_OnClick()
		{
			var filter;
			var checkfilter;
			var pos;
			var ret;

			if (disallowBlank(objtxtFilter,"Filters cannot be blank",true)) return ;
			filter = trimString(objtxtFilter.value);
			while (filter.indexOf('--') != -1)
				{
				pos = filter.indexOf('--');
				checkfilter = Mid(filter,1,pos + 1);
				filter = Mid(filter,pos + 2,Len(filter) - pos+2);
				ret = CheckComment(checkfilter);
				if (ret==1 || ret==0) 
					{
					alert("Comments (--) are not allowed.");
					objtxtFilter.focus(); 
					return;
					}
				else if (ret==2)
					{
					pos = filter.indexOf("'");
					filter = Mid(filter,pos + 1,Len(filter) - pos+1);
					}
				else
					return;
				}
		
			objform.action = "CRM_FilterDetail.aspx?Action=APPLY_WITHOUT_SAVING&Mode=<%=m_strMode%>&FromWhere=<%=m_strFromWhere%>&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>&PageNumber=<%=m_strAlphabet%>&FilterID=<%=m_lngFilterID%>" ;
			objform.submit();
		}
		
		
		function Save_OnClick()
		{
			var filter;
			var checkfilter;
			var pos;
			var ret;
			if (disallowBlank(objtxtFilterName,"Filter name cannot be blank",true)) return ;
			if (disallowSpecialCharacters(objtxtFilterName,"Special characters " + '/:*?+\"><|#&%[,_'  + " are not allowed",true,'[/:*?+\"><|#&%[_,\\\\]')) return;
			if (disallowBlank(objtxtFilter,"Filters cannot be blank",true)) return ;
			
			filter = trimString(objtxtFilter.value);
			while (filter.indexOf('--') != -1)
				{
				pos = filter.indexOf('--');
				checkfilter = Mid(filter,1,pos + 1);
				filter = Mid(filter,pos + 2,Len(filter) - pos+2);
				ret = CheckComment(checkfilter);
				if (ret==1 || ret==0) 
					{
					alert("Comments (--) are not allowed.");
					objtxtFilter.focus();
					return;
					}
				else if (ret==2)
					{
					pos = filter.indexOf("'");
					filter = Mid(filter,pos + 1,Len(filter) - pos+1);
					}
				else
					return;
				}
			objform.action = "CRM_FilterDetail.aspx?Action=SAVE&Mode=<%=m_strMode%>&FromWhere=<%=m_strFromWhere%>&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>&PageNumber=<%=m_strAlphabet%>&FilterID=<%=m_lngFilterID%>" ;
			objform.submit();
		}
		//Added by ShraddhaM  for WhizibleSem8 to plot Save and Apply link
		function SaveAndApply_OnClick()
		{
		    var filter;
			var checkfilter;
			var pos;
			var ret;
			if (disallowBlank(objtxtFilterName,"Filter name cannot be blank",true)) return ;
			if (disallowSpecialCharacters(objtxtFilterName,"Special characters " + '/:*?+\"><|#&%[,_'  + " are not allowed",true,'[/:*?+\"><|#&%[_,\\\\]')) return;
			if (disallowBlank(objtxtFilter,"Filters cannot be blank",true)) return ;
			
			filter = trimString(objtxtFilter.value);
			while (filter.indexOf('--') != -1)
				{
				pos = filter.indexOf('--');
				checkfilter = Mid(filter,1,pos + 1);
				filter = Mid(filter,pos + 2,Len(filter) - pos+2);
				ret = CheckComment(checkfilter);
				if (ret==1 || ret==0) 
					{
					alert("Comments (--) are not allowed.");
					objtxtFilter.focus();
					return;
					}
				else if (ret==2)
					{
					pos = filter.indexOf("'");
					filter = Mid(filter,pos + 1,Len(filter) - pos+1);
					}
				else
					return;
				}
				
				 
			FromWhichClick = 'SaveAndApply';
				
			objform.action = "CRM_FilterDetail.aspx?Action=SAVEANDAPPLY&Mode=<%=m_strMode%>&FromWhere=<%=m_strFromWhere%>&SortBy=<%=m_strSortBy%>&SortOrder=<%=m_strSortOrder%>&PageNumber=<%=m_strAlphabet%>&FilterID=<%=m_lngFilterID%>" ;			 
			objform.submit();
			
			
		}
		//Ended by ShraddhaM
		function cboField_OnChange()
		{
			
			switch(true)
			{
			case (trimString(objcboField.value.toUpperCase()) == "CLOSEDDATE" || trimString(objcboField.value.toUpperCase()) == "CREATEDDATE" || trimString(objcboField.value.toUpperCase()) == "CRMEXPECTEDRESOLVEDDATE" || trimString(objcboField.value.toUpperCase()) == "EXPECTEDRESOLVEDDATE" || trimString(objcboField.value.toUpperCase()) == "SUBMITTEDDATE" || trimString(objcboField.value.toUpperCase()) == "LASTUPDATEDDATE" ):
				TDDate.style.display = "block";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDTargetLocation.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none";
				TDLoginType.style.display = "none";	
				TDRequestType.style.display = "none";
			// Integrated by ArchanaN on 26 Apr 2007
				//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";
				TDClient.style.display = "none";				
				//end Addion By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
		 
			 // Integration Ends
                ShowHideCustomFieldTDs(objcboField.value);
				break;
			case (trimString(objcboField.value.toUpperCase()) == "ASSIGNTO"):
			//Added By ShraddhaM on 23,July 2007 to change Assignto combo to Text box
				var objtxtValue = GetObjectReference('frmFilterDetails','txtValue');				 
				objtxtValue.disabled=true;
			//End of added By ShraddhaM on 23,July 2007 to change Assignto combo to Text box	
				TDAssignTo.style.display = "block";				
				TDDate.style.display = "none";
				TDValue.style.display = "block";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDTargetLocation.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none";
				TDLoginType.style.display = "none";
				TDRequestType.style.display = "none";
			// Integrated by ArchanaN on 26 Apr 2007
				//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";			
				TDClient.style.display = "none";				
				//end Addion By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293				
		 
			 // Integration Ends
			
			
                ShowHideCustomFieldTDs(objcboField.value);			
				break;
			case (trimString(objcboField.value.toUpperCase()) == "PARAMETERNAME"):
				TDFeedback.style.display = "block";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDTargetLocation.style.display = "none";
				TDFeedbackRating.style.display = "none"	;
				TDLoginType.style.display = "none";
				TDRequestType.style.display = "none";
			// Integrated by ArchanaN on 26 Apr 2007
				//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";
				TDClient.style.display = "none";								
				//end Addion By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293				
		 
			 // Integration Ends
                ShowHideCustomFieldTDs(objcboField.value);
				break;		
			/*Added By SantoshK on 2nd Dec 2004 Added Filter for Request Type*/
			case (trimString(objcboField.value.toUpperCase()) =="REQUESTTYPE"):
				TDRequestType.style.display = "block";
				TDSubRequestType.style.display = "none";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDTargetLocation.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none";
				TDLoginType.style.display = "none";	
			// Integrated by ArchanaN on 26 Apr 2007
		 		//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";
				TDClient.style.display = "none";								
				//end Addion By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293				
			
			 // Integration Ends
                ShowHideCustomFieldTDs(objcboField.value);
				break;			
				
			case (trimString(objcboField.value.toUpperCase()) =="SUBREQUESTTYPE"):

				TDSubRequestType.style.display = "block";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDTargetLocation.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none";
				TDLoginType.style.display = "none";	
				TDRequestType.style.display = "none";
				// Integrated by ArchanaN on 26 Apr 2007
				//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";	
				TDClient.style.display = "none";							
				//end Addion By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293				
		 
				 // Integration Ends
                ShowHideCustomFieldTDs(objcboField.value);
				break;			
			case (trimString(objcboField.value.toUpperCase()) =="CUSTOMERID"):

				TDSubmittedBy.style.display = "block";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDTargetLocation.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none";
				TDLoginType.style.display = "none";	
				TDRequestType.style.display = "none";
				// Integrated by ArchanaN on 26 Apr 2007
				//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";
				TDClient.style.display = "none";								
				//end Addion By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293				
				 
				 // Integration Ends
                ShowHideCustomFieldTDs(objcboField.value);
				break;			
			case (trimString(objcboField.value.toUpperCase()) =="STATUS"):	

				TDStatus.style.display = "block";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDPriority.style.display = "none";
				TDTargetLocation.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none";
				TDLoginType.style.display = "none";
				TDRequestType.style.display = "none";
				// Integrated by ArchanaN on 26 Apr 2007
				//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";	
				TDClient.style.display = "none";							
				//end Addion By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293				
				 
				 // Integration Ends
                ShowHideCustomFieldTDs(objcboField.value);
				break;			
			case (trimString(objcboField.value.toUpperCase()) =="PRIORITY"):

				TDPriority.style.display = "block";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDTargetLocation.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none";
				TDLoginType.style.display = "none";
				TDRequestType.style.display = "none";
				// Integrated by ArchanaN on 26 Apr 2007
				//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";	
				TDClient.style.display = "none";							
				//end Addion By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293				
				 
				 // Integration Ends
		
                ShowHideCustomFieldTDs(objcboField.value);
				break;			
			case (trimString(objcboField.value.toUpperCase()) =="TARGETLOCATION"):

				TDTargetLocation.style.display = "block";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none";
				TDLoginType.style.display = "none";	
				TDRequestType.style.display = "none";
				// Integrated by ArchanaN on 26 Apr 2007
				//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";	
				TDClient.style.display = "none";							
				//end Addion By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293				
				 
				 // Integration Ends
		
                ShowHideCustomFieldTDs(objcboField.value);
				break;			
			case (trimString(objcboField.value.toUpperCase()) =="RATING"):

				TDTargetLocation.style.display = "none";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "block";	
				TDLoginType.style.display = "none";	
				TDRequestType.style.display = "none";
				// Integrated by ArchanaN on 26 Apr 2007
				//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";	
				TDClient.style.display = "none";							
				//end Addion By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293				
				 
				 // Integration Ends
		
                ShowHideCustomFieldTDs(objcboField.value);
				break;				
			case (trimString(objcboField.value.toUpperCase()) =="LOGINTYPE"):
				TDTargetLocation.style.display = "none";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none"	;
				TDLoginType.style.display = "block";
				TDRequestType.style.display = "none";	
		// Integrated by ArchanaN on 26 Apr 2007
				//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";
				TDClient.style.display = "none";								
				//end Addion By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293	
                ShowHideCustomFieldTDs(objcboField.value);			
				break;	
				//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293				
			case (trimString(objcboField.value.toUpperCase()) =="PRODUCT"):
				TDTargetLocation.style.display = "none";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none"	;
				TDLoginType.style.display = "none";
				TDRequestType.style.display = "none";	
				TDProduct.style.display = "block";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";	
				TDClient.style.display = "none";		
                ShowHideCustomFieldTDs(objcboField.value);					
				break;						
			case (trimString(objcboField.value.toUpperCase()) =="COMPONENT"):
				TDTargetLocation.style.display = "none";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none"	;
				TDLoginType.style.display = "none";
				TDRequestType.style.display = "none";	
				TDProduct.style.display = "none";
				TDComponent.style.display = "block";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";	
				TDClient.style.display = "none";	
                ShowHideCustomFieldTDs(objcboField.value);						
				break;			
			case (trimString(objcboField.value.toUpperCase()) =="DEPARTMENT"):
				TDTargetLocation.style.display = "none";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none"	;
				TDLoginType.style.display = "none";
				TDRequestType.style.display = "none";	
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "block";	
				TDClient.style.display = "none";	
                ShowHideCustomFieldTDs(objcboField.value);						
				break;	
			case (trimString(objcboField.value.toUpperCase()) =="SEVERITY"):
				TDTargetLocation.style.display = "none";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none"	;
				TDLoginType.style.display = "none";
				TDRequestType.style.display = "none";	
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "block";
				TDDepartment.style.display = "none";	
				TDClient.style.display = "none";							
				 
		 // Integration Ends
                ShowHideCustomFieldTDs(objcboField.value);
				break;	
//Added by SrikanthY on 26 Mar 2007 to display Client Name field in filter
				case (trimString(objcboField.value.toUpperCase()) =="CUSTOMERNAME"):
				TDTargetLocation.style.display = "none";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none"	;
				TDLoginType.style.display = "none";
				TDRequestType.style.display = "none";	
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";				
				TDClient.style.display = "block";
                ShowHideCustomFieldTDs(objcboField.value);
				break;		
				//end of addition by SrikanthY on 26 Mar 2007
				
				//Added By Amol Changle On: 24 Jul 2009
				//To handle custom fields
			case (trimString(objcboField.value.toLowerCase()).indexOf("customfielddate") !=-1):
                TDTargetLocation.style.display = "none";
				TDDate.style.display = "";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none"	;
				TDLoginType.style.display = "none";
				TDRequestType.style.display = "none";	
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";				
				TDClient.style.display = "none";
				ShowHideCustomFieldTDs(objcboField.value);
				break;
				
        case (trimString(objcboField.value.toLowerCase()).indexOf("customfieldcombo") !=-1):
                TDTargetLocation.style.display = "none";
				TDDate.style.display = "none";
				TDValue.style.display = "none";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none"	;
				TDLoginType.style.display = "none";
				TDRequestType.style.display = "none";	
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";				
				TDClient.style.display = "none";
				ShowHideCustomFieldTDs(objcboField.value);
				break;
				//End Addition
											
			default:
				TDDate.style.display = "none";
				TDValue.style.display = "block";
				TDAssignTo.style.display = "none";
				TDSubRequestType.style.display = "none";
				TDSubmittedBy.style.display = "none";
				TDStatus.style.display = "none";
				TDPriority.style.display = "none";
				TDTargetLocation.style.display = "none";
				TDFeedback.style.display = "none";
				TDFeedbackRating.style.display = "none"	;
				TDLoginType.style.display = "none";
				TDRequestType.style.display = "none";
				// Integrated by ArchanaN on 26 Apr 2007
				//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
				TDProduct.style.display = "none";
				TDComponent.style.display = "none";
				TDSeverity.style.display = "none";
				TDDepartment.style.display = "none";	
				TDClient.style.display = "none";							
				//end Addion By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293				
				 
				 // Integration Ends
                ShowHideCustomFieldTDs(objcboField.value);
				break;
			}
		}
			
		function Append_OnClick()
		{	 
			if (disallowBlank(objcboField,"Please select the field",true))
			{
				objcboField.selectedIndex=0; 
				return ;
			}
			if (disallowBlank(objcboOperator,"Please select the operator",true)) 
			{
				objcboOperator.selectedIndex=0; 
				return ;
			}
					
			switch(true)
			{  
			case (trimString(objcboField.value.toUpperCase()) == "CLOSEDDATE" || trimString(objcboField.value.toUpperCase()) == "CREATEDDATE" || trimString(objcboField.value.toUpperCase()) == "CRMEXPECTEDRESOLVEDDATE" || trimString(objcboField.value.toUpperCase()) == "EXPECTEDRESOLVEDDATE" || trimString(objcboField.value.toUpperCase()) == "SUBMITTEDDATE" || trimString(objcboField.value.toUpperCase()) == "LASTUPDATEDDATE"):
				if (disallowBlank(objtxtDate,"Please select the date",true)) return ;
				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objtxtDate.value,"'","''") + "'";
				break;
			case (trimString(objcboField.value.toUpperCase()) == "ASSIGNTO"):
			//Commented and Added By ShraddhaM on 23,July 2007 for AssignTo combo Changes
				/*if (disallowBlank(objcboAssignTo,"Please select the resource",true)) return ;
				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objcboAssignTo.value,"'","''") + "'";
				*/				
				if (disallowBlank(objtxtValue,"Please select the resource",true)) return ;
				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objtxtValue.value,"'","''") + "'";
			//End of Comment and Addition By ShraddhaM on 23,July 2007
				
				break;
			case (trimString(objcboField.value.toUpperCase()) == "PARAMETERNAME"):
				if (disallowBlank(objcboFeedback,"Please select the feedback parameter",true)) return ;
				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objcboFeedback.value,"'","''") + "'";
				break;
			
			/*Added by SantoshK on 2nd Dec 2004*/
			case (trimString(objcboField.value.toUpperCase()) =="REQUESTTYPE"):
				if (disallowBlank(objcboRequestType,"Please select the request type",true)) return ;
				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objcboRequestType.value,"'","''") + "'";
				break;
			/*Addition Ends*/				
				
			case (trimString(objcboField.value.toUpperCase()) =="SUBREQUESTTYPE"):
				if (disallowBlank(objcboSubRequestType,"Please select the sub request type",true)) return ;
				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objcboSubRequestType.value,"'","''") + "'";
				break;

			case (trimString(objcboField.value.toUpperCase()) =="CUSTOMERID"):
				if (disallowBlank(objcboSubmittedBy,"Please select the requestor",true)) return ;
				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objcboSubmittedBy.value,"'","''") + "'";
				break;
				
			case (trimString(objcboField.value.toUpperCase()) =="STATUS"):	
				if (disallowBlank(objcboStatus,"Please select the status",true)) return ;
				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objcboStatus.value,"'","''") + "'";
				break;
				
			case (trimString(objcboField.value.toUpperCase()) =="PRIORITY"):
				if (disallowBlank(objcboPriority,"Please select the priority",true)) return ;
				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objcboPriority.value,"'","''") + "'";
				break;
				
			case (trimString(objcboField.value.toUpperCase()) =="TARGETLOCATION"):
				if (disallowBlank(objcboTargetLocation,"Please select the target location",true)) return ;
				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objcboTargetLocation.value,"'","''") + "'";
				break;
				
			case (trimString(objcboField.value.toUpperCase()) =="RATING"):
				if (disallowBlank(objcboFeedbackRating ,"Please select the rating",true)) return ;
				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objcboFeedbackRating.value,"'","''") + "'";
				break;
					
			case (trimString(objcboField.value.toUpperCase()) =="LOGINTYPE"):
				if (disallowBlank(objcboLoginType,"Please select the login type",true)) return ;
				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objcboLoginType.value,"'","''") + "'";
				break;				
		// Integrated by ArchanaN on 26 Apr 2007
		//Added By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293
				case (trimString(objcboField.value.toUpperCase()) =="PRODUCT"):
					if (disallowBlank(objProduct,"Please select the product",true)) return ;
					objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objProduct.value,"'","''") + "'";
					break;				
				case (trimString(objcboField.value.toUpperCase()) =="COMPONENT"):
					if (disallowBlank(objComponent,"Please select the component",true)) return ;
					objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objComponent.value,"'","''") + "'";
					break;		
				case (trimString(objcboField.value.toUpperCase()) =="DEPARTMENT"):
					if (disallowBlank(objDepartment,"Please select the department",true)) return ;
					objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objDepartment.value,"'","''") + "'";
					break;														
				case (trimString(objcboField.value.toUpperCase()) =="SEVERITY"):
					if (disallowBlank(objSeverity,"Please select the severity",true)) return ;
					objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objSeverity.value,"'","''") + "'";
					break;				
		//end Addition By nitinVS on 15 Feb 2007 for WhizibleSEM SP9 IssueID 10293				
		//Added by SrikanthY on 26 Mar 2007 to display Client Name field in filter			
				case (trimString(objcboField.value.toUpperCase()) =="CUSTOMERNAME"):
					if (disallowBlank(objclient,"Please select the Requestor Name",true)) return ;
					objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objclient.value,"'","''") + "'";
					break;
		//end addition by SrikanthY on 26 Mar 2007 	
		 
		 // Integration Ends

//Added By Amol Changle On: 24 Jul 2009
//Purpose: To select Custom fields value
			    case (trimString(objcboField.value.toUpperCase()).indexOf("CUSTOMFIELD") !=-1):
			        //debugger;
				    switch(true)
				    {
				        case (trimString(objcboField.value.toUpperCase()).indexOf("CUSTOMFIELDDATE") !=-1):
                            if (disallowBlank(objtxtDate,"Please select the date",true)) return ;
            				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objtxtDate.value,"'","''") + "'";
				            break;
				        case (trimString(objcboField.value.toUpperCase()).indexOf("CUSTOMFIELDCOMBO") !=-1):
                            if (disallowBlank(GetObjectReference('',objcboField.value),"Please select the "+objcboField.options[objcboField.selectedIndex].text,true)) return ;
            				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(GetObjectReference('',objcboField.value).value,"'","''") + "'";
				            break;    
				        default:
				            if (disallowBlank(objtxtValue,"Please provide the value for "+objcboField.options[objcboField.selectedIndex].text,true)) return ;
            				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objtxtValue.value,"'","''") + "'";
				            break; 
				    }
					break;
//End Addition

			default:
				if (disallowBlank(objtxtValue,"Please provide the value",true)) return ;
				objtxtFilter.value = objtxtFilter.value + " " +  objcboField.value + " " + objcboOperator.value + " '" + replaceSubstring(objtxtValue.value,"'","''") + "'";
				break;			
			}
		}
		
		function Insert_OnClick(str)
		{
			objtxtFilter.value = objtxtFilter.value + " " + str;
		}
		
		function ClearAll_OnClick()
		{
			objtxtFilter.value = "";
			objtxtValue.value = "";
			objcboField.selectedIndex = -1;
			objcboOperator.selectedIndex = -1;
		}
			
		
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight+'px';	
			objtxtFilterName.focus(); 
			if (<%=m_intValidFilter%> == 0)
			{
				alert("The filter conditions are invalid");
				objtxtFilter.focus();
			}
			if (<%=m_intRefresh%> == 1)
			{		
			
				//Added By KapilGK On 16-10-2006
				var url;
				var frmName;
				var pageName;
				
				url=replaceSubstring(window.opener.location.href,'Action=','Action1=');
				url=replaceSubstring(url,'PageNumber=','PageNumber1=');
								            				
				if (<%=m_ApplyFilter%>==1)
				{  			    				    
				   //url= url+"&PageNumber=1";   
				   //Added by ShraddhaM  for WhizibleSem8 to plot Save and Apply link                
				   url= url+"&SavedFilterID=<%=m_lngFilterID%>&Action=SET_DEFAULT_FILTER";
				   
				   //window.opener.location.href=url+"&PageNumber=1";			   
				   
				   
				   if("<%=m_strFromWhere%>" == 'MD')
				   {
				        frmName = 'frmMyDashboard';
				        pageName = 'CRM_MyDashboard.aspx';
				   }
				   else if("<%=m_strFromWhere%>" == 'DB')
				   {
				        frmName = 'frmDashboard';
				        pageName = 'CRM_Dashboard.aspx';
				   }
				   else if("<%=m_strFromWhere%>" == 'SR')
				   {
				        frmName = 'frmRequestList';
				        pageName = 'CRM_RequestList.aspx';
				   }
				   else if("<%=m_strFromWhere%>" == 'AR')
				   {
				        frmName = 'frmRequestList';
				        pageName = 'CRM_RequestList.aspx';
				   }
				   
				   var hidSaveAddFilterID = window.opener.document.forms[frmName].elements['hidSaveAddFilterID'];
					 
				   var objcboFilter = window.opener.document.forms[frmName].elements['cboFilter'];
                    
                   objcboFilter.selectedIndex= objcboFilter.length-1; 
                   
                   objcboFilter.options[objcboFilter.length-1].value= "<%=m_lngFilterID%>";
                                
                   objcboFilter.value = "<%=m_lngFilterID%>";
                   
                   
                   
                   window.opener.cboFilter_OnChange();
                    
					 
				  //Ended by ShraddhaM  for WhizibleSem8 to plot Save and Apply link
                     		
				}
				else
				{
				//End of Addition By KapilGK				    
					window.opener.location.href=replaceSubstring(window.opener.location.href,'Action=','Action1=');
					
			    }
			       
			       	
			
			} 
			
		
			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeightt+'px';		
		}
		//Added By ShraddhaM on 23,July 2007 for DataCleanUp Activity(AssignTo Combo Changed to TextBox)
			function AssignTo_OnClick()
			{
				window.open ("../HR/ResourceSelection_CommonList.aspx?MasterTagID=3633&PTagID=0&FromWhere=CRMFilters", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 1000)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=1000,height=400");
			}
			
		//End of addition By ShraddhaM on 23,July 2007 for DataCleanUp Activity
		
		
		function ShowHideCustomFieldTDs(CustomFieldComboName)
		{
		    var i;
            var objTDCustomFieldCombo;		    
		    for(i=1;i<=10;i++)
		    {
		        objTDCustomFieldCombo=GetObjectReference('','TDCustomFieldCombo'+i);
		        if(objTDCustomFieldCombo!=null)
		        {
		            if('CustomFieldCombo'+i==CustomFieldComboName)
		                objTDCustomFieldCombo.style.display="";
		            else     
		                objTDCustomFieldCombo.style.display="none";
		        }   
		    }
		}
		
		</script>
	</body>
</HTML>
