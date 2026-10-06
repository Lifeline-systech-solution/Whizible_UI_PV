<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%  CommonFunctions.General.PlotPageHeadTag("")%> --%>
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
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PB_PageProperties.aspx.vb" Inherits="Whiz.PB_PageProperties" %>

<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.PB_PageProperties", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	<body class="clsBody" onunload ="CheckRefresh()" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
	<form id="frmPageProperties" name="frmPageProperties" method="post" runat="server">
	<script language=javascript>
	var IsRefreshParent = true;
	function CheckRefresh(){
	        if (IsRefreshParent==true){RefreshWebFormDesigner(1);}	
    }
	</script>  
	<%PageInit%>
	</form>
<% if MyBase.GetFormValue("action")<>"SAVEANDCLOSE" Then 'DO NOT PLOT SCRIPT FUNCTIONS FOR SAVE and CLOSE %>

<script language="javascript">
	var objAuditTrail;  // ReqID - WAF3_PB_46 NinadP
	var objTDAuditTrailLinks; // ReqID - WAF3_PB_46 NinadP
	var objdivlist;
	var objFrm;
	var sessionComboExpanded = false;
	var queryComboExpanded = false;
	var defaultTextExpanded = true;
	var objConcurrency;	
	var objTransHistory;
	var objTDTransHistoryLinks ;
	
	objFrm=GetFormReference('frmPageProperties')
	objdivlist=GetObjectReference('frmPageProperties','myDiv')

	function window_onresize()		
	{
		var x,b;
		var intDivHeight ;
		var intDivHeightRisk;
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		if (intDivHeight < 100)
		intDivHeight = 100;
	    //Comment added on 11 Dec 2015 by Viraj P
	    //objdivlist.style.height = intDivHeight;	
		objdivlist.style.height = intDivHeight + 'px';
	}
			
	function window_onload()
	{

			var intDivHeight ;
			var intDivHeightRisk;
			var objDataHeader;
			var objDataHeaderAlignment;
			//Added By ShrikantB For Transaction History
			var valTagID =<%=CStr(m_paramStrTagID) %>;
			var valIsSubtag =<%=m_ISSubTag %>;
			//Addition End By ShrikantB For Transaction History
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)
			intDivHeight = 100;
	    //Comment added on 11 Dec 2015 by Viraj P
	    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';
			//Addition ReqID - WAF3_PB_46 NinadP
			objAuditTrail = GetObjectReference('frmPageProperties','chkAuditTrail'); 
			if (objAuditTrail!=null)
			{
			    objTDAuditTrailLinks = GetObjectReference('frmPageProperties','tdAuditTrailLinks'); 
		        if (objAuditTrail.checked == false)
    			    objTDAuditTrailLinks.style.display="none";
    	    }
			// End Addition ReqID - WAF3_PB_46 NinadP
			//Added By ShrikantB For Transaction History
			objTransHistory = GetObjectReference('frmPageProperties','chkTransHistory'); 
			if (objTransHistory !=null)
			{
			    objTDTransHistoryLinks = GetObjectReference('frmPageProperties','tdTransHistoryLinks'); 
		        if (objTransHistory.checked == false)
    			    objTDTransHistoryLinks.style.display="none";
			}
			//Addition End By ShrikantB For Transaction History
			
			var framesetQuery = "";
			objConcurrency =GetObjectReference('frmPageProperties','chkConcurrency'); //Added By ShrikantB On 19-JUL-2010 For Concurrency Control
			if(window.location.search != 0)
			{
				framesetQuery=window.location.search;
			} 
			else
			{
				framesetQuery = "?OpenFrameset";
			}
			var paramFromElement=getParameter(framesetQuery,'FromElement');
			var paramDisplaySection=getParameter(framesetQuery,'DisplaySection');
			if(paramFromElement=='Tag')
			{
				if(paramDisplaySection=='LE')
				{
					SECTION_AuditTrail_OnClick();
					SECTION_SecuritySettings_OnClick();
					objLegend = GetObjectReference('frmPageProperties', 'CPPageLegend');
					objLegend.focus();
				}
				if (paramDisplaySection=='HT')
				{
					SECTION_AuditTrail_OnClick();
					SECTION_SecuritySettings_OnClick();
					objHeader = GetObjectReference('frmPageProperties', 'PageHeader');
					objHeader.focus();
				}
				
				//Added By NileshD on 06/09/2004
				expandcollapse('trSessionVariable');
				expandcollapse('trQueryString');
				objDefaultValueType = GetObjectReference('frmPageProperties','defaultValueType');
				objDefaultValue = GetObjectReference('frmPageProperties','rdoDefaultValue',1);
				if (objDefaultValueType != null)
				{
					defaultValueType = getInputValue(objDefaultValueType);
					if (defaultValueType == '2')
					{
						showHideSessionCombo('trSessionVariable');
						objDefaultValue[2].checked = true;
					}
					else if (defaultValueType == '3')
					{
						showHideSessionCombo('trQueryString');
						objDefaultValue[3].checked = true;
					}
					else if (defaultValueType == '1')
						objDefaultValue[1].checked = true;
					else if (defaultValueType == '0')
						objDefaultValue[0].checked = true; 
						
				}
				//End Of Addition
				//Added By Ninad on 8 June 2009 - WAF3_PB_73
				var oApplyFiltersOnDB=document.getElementById('ApplyFiltersOnDB');
		        if (oApplyFiltersOnDB!=null && oApplyFiltersOnDB.checked==false)
                {
                    document.getElementById('ShowRecordsForDBFilters').checked=false;
                    document.getElementById('ShowRecordsForDBFilters').disabled=true;
                }
               //End Addition By Ninad on 8 June 2009 - WAF3_PB_73
			}
			else if(paramFromElement=='SubTag')
			{
				if(paramDisplaySection=='LE')
				{
					SECTION_AuditTrail_OnClick();
					SECTION_SecuritySettings_OnClick();
					objLegend = GetObjectReference('frmPageProperties', 'SCPLegend');
					objLegend.focus();
				}
				if (paramDisplaySection=='HT')
				{
					SECTION_AuditTrail_OnClick();
					SECTION_SecuritySettings_OnClick();
					objHeader = GetObjectReference('frmPageProperties', 'UIPageHeader');
					objHeader.focus();
				}
			}
			//Addition ReqID - WAF3_PB_46 NinadP
			if (objAuditTrail!=null)
					chkAuditTrail_OnClick();
			//Added By ShrikantB ON 19-JUL-2010 For Concurrency Control		
    		if (objConcurrency!=null)
                   chkConcurrency_OnClick();
             if (objTransHistory!=null)
              {
                 chkTransHistory_OnClick(valTagID,valIsSubtag);              
              }
                  
            //Addition End By ShrikantB ON 19-JUL-2010 For Concurrency Control
			if(GetObjectReference('frmPageProperties', 'SmartNavigation_IsEnabled')!=null)
			    SmartNavigation_Enabled();
			if(window.location.search.indexOf('&FocusOn=') != -1)
				{
				    if(window.location.search.indexOf('&FocusOn=txtTitle') != -1)
				    {
				        if(document.getElementById('txtTitle')==null) return;
				        document.getElementById('txtTitle').scrollIntoView();
				        document.getElementById('txtTitle').focus();
				    }
				}
	}
	
	//Req ID    :   WAF3_PB_34
	function DMScript_OnClick(IsSubTag,TagID)
	{
			window.open ("../SM/PB_DataManagementScripts.aspx?IsSubTag=" + IsSubTag + "&TagID=" + TagID, "", "resizable=no,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 350)/2) + ",width=600,height=350");//Modified By - Ninad : Issue ID - 14876 : Dt 6 Sept 2007
	}	
	//Req ID    :   WAF3_PB_42 
	function ActionLinksSchema_OnClick(IsSubTag,TagID)
	{
			window.open ("../SM/PB_DropdownMenu.aspx?IsSubTag=" + IsSubTag + "&TagID=" + TagID, "", "resizable=no,scrollbars=no,left=" + ((window.screen.width - 630)/2) + ",top=" + ((window.screen.height - 300)/2) + ",width=630,height=300");	 <% 'Modified by VinayB IssueID->26835 %>
	}	
	function Close_Onclick()
	{
		window.close();
	}	
	function Save_OnClick(Operation)
	{
		var validateflag;
		var arrValues = new Array();
		var objCreatedBy;
		var objCreatedDate;
		var objUpdatedBy;
		var objUpdatedDate;
		var objAuditTrail;
		var objOrderNumber;

		objCreatedBy = GetObjectReference('frmPageProperties','cboAuditTrail_CreatedBy');
		objCreatedDate = GetObjectReference('frmPageProperties','cboAuditTrail_CreatedDate');
		objUpdatedBy = GetObjectReference('frmPageProperties','cboAuditTrail_UpdatedBy');
		objUpdatedDate = GetObjectReference('frmPageProperties','cboAuditTrail_UpdatedDate');
		objAuditTrail = GetObjectReference('frmPageProperties','chkAuditTrail');
		objOrderNumber = GetObjectReference('frmPageProperties','txtOrderNumber');
		objIsOrderNumberMandatory = GetObjectReference('frmPageProperties','isOrderNumberMandatory');
				
		<%MyBase.InitializeResources("Resources.PB_CommonValidations", "Resources")%>
		validateflag=Validate_OnClick();
		if (ValidateStaticGroups() == true && validateflag==true)
		{
		    IsRefreshParent = false;
		    objcboAuthorID = GetObjectReference('frmPageProperties','cboAuthorID');
		    if (objcboAuthorID!=null) {objcboAuthorID.disabled=false;}
			var objform;
			var objPageID;
			var objAction = GetObjectReference('frmPageProperties', 'action');
			objAction.value = Operation; 	//Addition ReqID - WAF3_PB_48 NinadP
			objPageID=GetObjectReference('frmPageProperties','hdPageID');
			objSubmit=GetObjectReference('frmPageProperties','txtSubmit');
			objSubmit.value="True";
			objform=GetFormReference('frmPageProperties');
			objform.submit();
		}
	}
	function ValidateStaticGroups()
	{
		var objIsOrderNumberMandatory = GetObjectReference('frmPageProperties','isOrderNumberMandatory');
		var orderNumber = GetObjectReference('frmPageProperties', 'txtOrderNumber').value;
		var objOrderNumber = GetObjectReference('frmPageProperties','txtOrderNumber');
		var objSubTagDisplayType = GetObjectReference('frmPageProperties','cboSubTagDisplayType');
		var objTitle = GetObjectReference('frmPageProperties','txtTitle');
		var objFromElement = GetObjectReference('frmPageProperties', 'fromElement');
		var objWindowWidth = GetObjectReference('frmPageProperties', 'txtWindowWidth');
		var objWindowHeight = GetObjectReference('frmPageProperties', 'txtWindowHeight');
		var objDivHeight = GetObjectReference('frmPageProperties', 'txtDivHeight');
		
		//var objRegExp=/^([0-9]+\.[0-9])+$/;
		//alert(objRegExp.test('11.11.1'));
		
		/*var objRegExp= /^[0-9]\.[0-9]$/;
		alert(objRegExp.test('1.1'));*/
		<% 'Modification by VinayB on 22-APR-2009 3.0.06.P.Y-SP12-WAF IssueID-17325%>
		if (objTitle != null && disallowBlank(objTitle, "<%=MyBase.GetResourceString("DISALLOW_BLANK_TITLE")%>") == true)
			return false;
		// Req ID  :   2.0.42-SP4-WAF
		if (objTitle != null && disallowSpecialCharacters(objTitle, '<%=MyBase.GetResourceString("DISALLOW_SPECIAL_CHARACTERS")%>',true,'[:*?+\"><|,\\\\]')== true)
			return false;
		/*if (objTitle != null && objFromElement.value == 'Tag' && disallowDuplicates(objTitle, arrTagDescription, '<%=MyBase.GetResourceString("DISALLOW_DUPLICATES")%>', true)== true)
			return false;*/
		if (objOrderNumber != null && disallowSpecialCharacters(objOrderNumber, '<%=MyBase.GetResourceString("DISALLOW_SPECIAL_CHARACTERS")%>',true,'[/:*?+\"><|,\\\\]+')== true)
			return false;
		/*if (orderNumber.indexOf('-') != -1)
		{
			alert(replaceSubstring('<%=MyBase.GetResourceString("DISALLOW_HYPHEN")%>', "&#39;", "'"));
			setFocus(GetObjectReference('frmPageProperties', 'txtOrderNumber'));
			return false;
		}*/
		if (ValidateOrderNumber(objOrderNumber) == false)
		{
			alert('Order Number is not valid');
			setFocus(objOrderNumber);
			return false;
		}
		if (objIsOrderNumberMandatory != null && objIsOrderNumberMandatory.value == 'True')
		{
		    <% 'Modification by VinayB on 22-APR-2009 3.0.06.P.Y-SP12-WAF IssueID-17325%>
			if (objOrderNumber != null && disallowBlank(objOrderNumber, "<%=MyBase.GetResourceString("DISALLOW_BLANK_ORDER")%>") == true)
				return false
		}
		//Added by Ninad 23 April 2007 HotfixID - 2.0.10-SP7-WAF 
		if (objIsOrderNumberMandatory==null)
		 {
		 	if (disallowBlank(objOrderNumber, "<%=MyBase.GetResourceString("DISALLOW_BLANK_ORDER")%>") == true)
				return false;
			if (disallowNegativeInteger(objOrderNumber, '<%=Mybase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>') == true)
			    return false;
		 }		
		 //End Addition by Ninad 23 April 2007 HotfixID - 2.0.10-SP7-WAF 
		if (objWindowWidth != null && disallowNegativeInteger(objWindowWidth, '<%=Mybase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>') == true)
			return false;
		if (objWindowHeight != null && disallowNegativeInteger(objWindowHeight, '<%=Mybase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>') == true)
			return false;
		if (objDivHeight != null && disallowNegativeInteger(objDivHeight, '<%=Mybase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>') == true)
			return false;
        <% 'Modification by VinayB on 22-APR-2009 3.0.06.P.Y-SP12-WAF IssueID-17325%>			
		if (objSubTagDisplayType != null && disallowBlank(objSubTagDisplayType, "<%=MyBase.GetResourceString("DISALLOW_BLANK_TAB_DISPLAY")%>") == true)
			return false
		//Added by Ninad Req ID   :   WAF3_PB_42
		if(objFromElement.value=='SubTag')
		    {
		        if (disallowBlank(GetObjectReference('frmPageProperties', 'DynamicAction_NavigationSchema'), "<%=MyBase.GetResourceString("DISALLOW_BLANK")%>") == true)
			    return false;
		    }
		if (ValidateAuditTrail() == false)
			return false;
			//Added By ShrikantB On 19-JUL-2010 For Concurrency Control
		if (ValidateConcurrency() == false)
			return false;
		if (ValidateTransHistory()== false)
			return false;
			//Addition End By ShrikantB On 19-JUL-2010 For Concurrency Control
		if (ValidateSectionPositioning() == false)
			return false;
		//Added by Ninad Req ID   :   WAF3_PB_41
		if(GetObjectReference('frmPageProperties', 'SmartNavigation_IsEnabled')!=null)
		{
		if (GetObjectReference('frmPageProperties', 'SmartNavigation_IsEnabled').checked)
		{ 
		    <% 'Modification by VinayB on 22-APR-2009 3.0.06.P.Y-SP12-WAF IssueID-17325%>
		   if (disallowBlank(GetObjectReference('frmPageProperties', 'SmartNavigation_Schema'), "<%=MyBase.GetResourceString("DISALLOW_BLANK_SMART_NAVIGATION_SCHEMA")%>") == true)
		   return false;
		   <% 'Modification by VinayB on 22-APR-2009 3.0.06.P.Y-SP12-WAF IssueID-17325%>
		    if (disallowBlank(GetObjectReference('frmPageProperties', 'SmartNavigation_ListFrameSize'), "<%=MyBase.GetResourceString("DISALLOW_BLANK_SMART_NAVIGATION_FRAMESIZE")%>") == true)
		   return false;
		}
		}	
		//Added By NileshD on 23 Sep 2005 REQID-WAF3_PB_10
		if (ValidateNumericPaging() == false)
			return false;
		//End Of Addition By NileshD on 23 Sep 2005 REQID-WAF3_PB_10
		return true;
	}
	//Added By NileshD on 23 Sep 2005 REQID-WAF3_PB_10
	function ValidateNumericPaging ()
	{
		var objAllowNumericPaging = GetObjectReference('frmPageProperties','AllowNumericPaging');
		var objPageSize = GetObjectReference('frmPageProperties','PageSize');
		var objNumericPagingAlignment = GetObjectReference('frmPageProperties','NumericPagingAlignment');
		var objNumericPagingDisplayPosition = GetObjectReference('frmPageProperties','NumericPagingDisplayPosition');
		
		if (objAllowNumericPaging != null)
			{
				if (objAllowNumericPaging.checked == true)
				{
					if (objPageSize.value == "")
						{
							alert('Please enter the page size');
							objPageSize.focus();
							return false;
						}
					if (objNumericPagingAlignment.value == "")
						{
							alert('Please select the Numeric Paging Alignment');
							objNumericPagingAlignment.focus();
							return false;
						}
					if (objNumericPagingDisplayPosition.value == "")
						{
							alert('Please select the Numeric Paging Display Position');
							objNumericPagingDisplayPosition.focus();
							return false;
						}
					return true;
				}
			}
		else
			{
			 return true;
			}
		
	}
	//End Of Addition By NileshD on 23 Sep 2005 REQID-WAF3_PB_10
	function ValidateAuditTrail()
	{
		var objCreatedBy;
		var objCreatedDate;
		var objUpdatedBy;
		var objUpdatedDate;
		var objAuditTrail;
		var arrValues = new Array();
    	objCreatedBy = GetObjectReference('frmPageProperties','cboAuditTrail_CreatedBy');
		objCreatedDate = GetObjectReference('frmPageProperties','cboAuditTrail_CreatedDate');
		objUpdatedBy = GetObjectReference('frmPageProperties','cboAuditTrail_UpdatedBy');
		objUpdatedDate = GetObjectReference('frmPageProperties','cboAuditTrail_UpdatedDate');
		objAuditTrail = GetObjectReference('frmPageProperties','chkAuditTrail');<% 'Modification by VinayB on 22-APR-2009 3.0.06.P.Y-SP12-WAF IssueID-17325%>
		
		if (objAuditTrail != null && objAuditTrail.checked == true)
		{
		    
		    //Addition By : Ninad : Requirement Tag - WAF3_PB_46 
		    <% 'Modification by VinayB on 22-APR-2009 3.0.06.P.Y-SP12-WAF IssueID-17325%>
		    if (disallowBlank(objCreatedBy, "<%=MyBase.GetResourceString("DISALLOW_BLANK_CREATEDBY")%>") == true)
			    return false;
			    <% 'Modification by VinayB on 22-APR-2009 3.0.06.P.Y-SP12-WAF IssueID-17325%>
			if (disallowBlank(objCreatedDate, "<%=MyBase.GetResourceString("DISALLOW_BLANK_CREATEDDATE")%>") == true)
			    return false;
			//Addition End By : Ninad   Req Id : WAF3_PB_46 
			var selIndexUpdatedBy = objUpdatedBy.selectedIndex;
			var selIndexUpdatedDate = objUpdatedDate.selectedIndex;
			var selIndexCreatedBy = objCreatedBy.selectedIndex;
			var selIndexCreatedDate = objCreatedDate.selectedIndex;
			arrValues[0] = objUpdatedBy[selIndexUpdatedBy].value; 
			arrValues[1] = objUpdatedDate[selIndexUpdatedDate].value;
			arrValues[2] = objCreatedDate[selIndexCreatedDate].value; 
			if (disallowDuplicates(objCreatedBy, arrValues, '<%=MyBase.GetResourceString("DISALLOW_DUPLICATES")%>',true) == true)
				return false;
			arrValues[0] = objUpdatedBy[selIndexUpdatedBy].value; 
			arrValues[1] = objUpdatedDate[selIndexUpdatedDate].value;
			arrValues[2] = objCreatedBy[selIndexCreatedBy].value; 
			if (disallowDuplicates(objCreatedDate, arrValues, '<%=MyBase.GetResourceString("DISALLOW_DUPLICATES")%>',true) == true)
				return false;
			arrValues[0] = objCreatedBy[selIndexCreatedBy].value; 
			arrValues[1] = objCreatedDate[selIndexCreatedDate].value; 
			arrValues[2] = objUpdatedDate[selIndexUpdatedDate].value;
			if (disallowDuplicates(objUpdatedBy, arrValues, '<%=MyBase.GetResourceString("DISALLOW_DUPLICATES")%>',true) == true)
				return false;
			arrValues[0] = objCreatedDate[selIndexCreatedDate].value; 
			arrValues[1] = objCreatedBy[selIndexCreatedBy].value; 
			arrValues[2] = objUpdatedBy[selIndexUpdatedBy].value;
			if (disallowDuplicates(objUpdatedDate, arrValues, '<%=MyBase.GetResourceString("DISALLOW_DUPLICATES")%>',true) == true)
				return false;
		}
		return true;
	}
	function ValidateSectionPositioning()
	{
		var objRowCount = GetObjectReference('frmPageProperties', 'rowCount');
		if (objRowCount != null)
		{
			for(var rowCounter=1; rowCounter<objRowCount.value; rowCounter++)
			{
				if (disallowNegativeInteger(GetObjectReference('frmPageProperties','txtSectionOrderNumber'+rowCounter), '<%=Mybase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>') == true)
					return false;
				if (disallowNegativeInteger(GetObjectReference('frmPageProperties','txtHeight'+rowCounter), '<%=Mybase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>') == true)
					return false;
				//Added by Ninad 23 April 2007 HotfixID - 2.0.10-SP7-WAF 
				if (disallowNegativeInteger(GetObjectReference('frmPageProperties','txtSectionOrderNumberCL'+rowCounter), '<%=Mybase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>') == true)
					return false;
				if (disallowNegativeInteger(GetObjectReference('frmPageProperties','txtHeightCL'+rowCounter), '<%=Mybase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>') == true)
					return false;
				//End Addition by Ninad 23 April 2007 HotfixID - 2.0.10-SP7-WAF 
			}	
		}
		return true;
	}
	
	function Module_OnChange()
	{
		objChange = GetObjectReference('frmPageProperties','txtChange');
		objChange.value='True';
		objForm=GetFormReference('frmPageProperties');
		objForm.submit();
		objChange.value = 'False';
	}
	
	function Parent_OnChange()
	{
		objChange = GetObjectReference('frmPageProperties','txtChange');
		objChange.value='True';
		objForm=GetFormReference('frmPageProperties');
		objForm.submit();
		objChange.value = 'False';
	}
	 //Added by Ninad on 10 Aug 2007 IssueID - 14684
	<% MyBase.InitializeResources("Resources.PB_PageProperties", "Resources")%>
	var blnShowAuditTrailMsg=false;
	var blnShowConcurrencyMsg=false;
	var blnShowTransHistoryMsg=false;
	function chkAuditTrail_OnClick()
	{
	
	    var objCreatedBy;
		var objCreatedDate;
		var objUpdatedBy;
		var objUpdatedDate;
		objCreatedBy = GetObjectReference('frmPageProperties','cboAuditTrail_CreatedBy');
		objCreatedDate = GetObjectReference('frmPageProperties','cboAuditTrail_CreatedDate');
		objUpdatedBy = GetObjectReference('frmPageProperties','cboAuditTrail_UpdatedBy');
		objUpdatedDate = GetObjectReference('frmPageProperties','cboAuditTrail_UpdatedDate');
		
		if (objAuditTrail != null)
		{
			if (objAuditTrail.checked == true)
			{
			    //Added by Ninad on 10 Aug 2007 IssueID - 14684
			    if (blnShowAuditTrailMsg) alert("<%=Server.HtmlDecode(MyBase.GetResourceString("MSG_CREATE_TRIGGER_CHECKED"))%>"); 
			     objTDAuditTrailLinks.style.display="";
				objCreatedBy.disabled = false;
				objCreatedDate.disabled = false;
				objUpdatedBy.disabled = false;
				objUpdatedDate.disabled = false 
			}
			else
			{
			    //Added by Ninad on 10 Aug 2007 IssueID - 14684
			    if (blnShowAuditTrailMsg) alert("<%=Server.HtmlDecode(MyBase.GetResourceString("MSG_CREATE_TRIGGER_UNCHECKED"))%>"); 
			    objTDAuditTrailLinks.style.display="none";
			    objCreatedBy.disabled = true;
				objCreatedDate.disabled = true;
				objUpdatedBy.disabled = true;
				objUpdatedDate.disabled = true; 
			}
		}
		blnShowAuditTrailMsg=true;
	}
	function getParameter(queryString,parameterName)
	{
		// Add "=" to the parameter name (i.e. parameterName=value)
		var parameterName = parameterName + "=";
		if ( queryString.length > 0 )
		{
					// Find the beginning of the string
					begin = queryString.indexOf ( parameterName );
					// If the parameter name is not found, skip it, otherwise return the value
					if ( begin != -1 )
					{
						// Add the length (integer) to the beginning
						begin += parameterName.length;
						// Multiple parameters are separated by the "&" sign
						end = queryString.indexOf ( "&" , begin );
						if ( end == -1 )
						{
							end = queryString.length
						}
						// Return the string
						return unescape ( queryString.substring ( begin, end ) );
					}
						// Return "null" if no parameter has been found
						return "null";
		}
	}
	function ValidateOrderNumber(obj)
	{
		var i,j;
		var valid=true;
		var found=false;
		var orderNumber = obj.value;
		var str = "0123456789.";
		if(orderNumber.charAt(0) == '.' || orderNumber.charAt(orderNumber.length-1) == '.')
			return false;
		if(isSubstringExists(orderNumber,'..')==true)
			return false;
		for(i=0;i < orderNumber.length;i++)
		{
			for(j=0;j<str.length;j++)
			{
				if(orderNumber.charAt(i) == str.charAt(j))	
				{
					found=true;
					break;
				}
			}		
			if(found==true)
				found=false;
			else
				return false;
			return true;
		}
	}

	//Added By NilehsD on 06/09/2004
		function expandcollapse(trchildid)
	{
		var coll=document.getElementsByName(trchildid);
		
		for(i=0;i<coll.length;i++)
		{
			var elementstyle=coll(i).style.display;
			if(elementstyle!='none')
			{	
				coll(i).style.display = 'none';
			}
			else
			{
				coll(i).style.display = 'block';
			}
		}
	}
	
		function showHideSessionCombo(trID)
	{
		if (trID == 'trSessionVariable')
		{
			if (sessionComboExpanded == false)
			{
				expandcollapse(trID);
				if (defaultTextExpanded == true)
					expandcollapse('trDefaultValue');
				if (queryComboExpanded == true)
					expandcollapse('trQueryString');
				sessionComboExpanded = true;
				queryComboExpanded = false;
				defaultTextExpanded = false
			}
		}
		else if (trID == 'trDefaultValue')
		{
			if (defaultTextExpanded == false)
			{
				expandcollapse(trID);
				if (sessionComboExpanded == true)
					expandcollapse('trSessionVariable');
				if (queryComboExpanded == true)
					expandcollapse('trQueryString');
				sessionComboExpanded = false;
				queryComboExpanded = false;
				defaultTextExpanded = true;
			}
		}
		else if (trID == 'trQueryString')
		{
			if (queryComboExpanded == false)
			{
				expandcollapse(trID);
				if (sessionComboExpanded == true)
					expandcollapse('trSessionVariable');
				if (defaultTextExpanded == true)
					expandcollapse('trDefaultValue');
				sessionComboExpanded = false;
				queryComboExpanded = true;
				defaultTextExpanded = false
			}
		}
	}  
	
	//End Of Addition
	
	//Function Added By Ninad Req ID   :   WAF3_PB_41
	function SmartNavigation_Enabled()
	{
	    var objSN_Enb = GetObjectReference('frmPageProperties', 'SmartNavigation_IsEnabled');
	    var LeftFrameWidth = 40;
	    var objEditMode_UIPageOpenInWindow = GetObjectReference('frmPageProperties', 'EditMode_UIPageOpenInWindow');
	    var objAddNewMode_UIPageOpenInWindow = GetObjectReference('frmPageProperties', 'AddNewMode_UIPageOpenInWindow');
	    if (objSN_Enb.checked==true)
	    {
	        if(GetObjectReference('frmPageProperties', 'EditMode_UIPageOpenInWindow').checked || GetObjectReference('frmPageProperties', 'AddNewMode_UIPageOpenInWindow').checked ) 	
	        {
	            alert("<%=Server.HtmlDecode(m_str_MSG_SMART_NAVIGATION_OPEN_IN_NEW_WINDOW)%>");
	            objSN_Enb.checked=false;
	        }
	        else
	        {
	            var objListFrameSize =GetObjectReference('frmPageProperties', 'SmartNavigation_ListFrameSize');
	            if (objListFrameSize.value=='') {objListFrameSize.value=LeftFrameWidth;}
	            if (GetObjectReference('frmPageProperties', 'SmartNavigation_Schema').selectedIndex==0)
	            GetObjectReference('frmPageProperties', 'SmartNavigation_Schema').selectedIndex=2;
	            if (objEditMode_UIPageOpenInWindow!=null)
					objEditMode_UIPageOpenInWindow.disabled=true;
				if (objAddNewMode_UIPageOpenInWindow!=null)
					objAddNewMode_UIPageOpenInWindow.disabled=true;
	        }
	    }
	   else
	    {
			if (objEditMode_UIPageOpenInWindow!=null)
				objEditMode_UIPageOpenInWindow.disabled=false;
			if (objAddNewMode_UIPageOpenInWindow!=null)
				objAddNewMode_UIPageOpenInWindow.disabled=false;
	    }
	}
	//Function Added By Ninad ReqID - WAF3_PB_48
	function NumericPaging_Enabled()
	{
	    if (GetObjectReference('frmPageProperties', 'AllowNumericPaging').checked==true)
	    {
	            var objPageSize =GetObjectReference('frmPageProperties', 'PageSize');
	            if (objPageSize.value=='') {objPageSize.value=20;}
	            if (GetObjectReference('frmPageProperties', 'NumericPagingAlignment').selectedIndex==0)
	                GetObjectReference('frmPageProperties', 'NumericPagingAlignment').selectedIndex=2;
	            if (GetObjectReference('frmPageProperties', 'NumericPagingDisplayPosition').selectedIndex==0)
	                GetObjectReference('frmPageProperties', 'NumericPagingDisplayPosition').selectedIndex=3;
        }
	}
	//End Addition By Ninad ReqID - WAF3_PB_48
    
    //Function Added By Ninad Req ID   :   WAF3_PB_46
	function AuditTrailScript_Click(TagID,IsSubTag,Operation)
	{
	    if (Operation=='AUDIT_TRAIL_GENERATE_SCRIPT')
	    {
	        if(confirm("<%=m_str_CONFIRMATION_MSG_CREATE_TRIGGER%>")==false) 
	            return ;
		}   
	    window.open ("../SM/PB_DataManagementScripts.aspx?Operation=" + Operation + "&IsSubTag=" + IsSubTag + "&TagID=" + TagID, "", "scrollbars=1,resizable=1,menubar=yes,left=" + ((window.screen.width - 900)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=900,height=500");	 
    }
    //Function Added By PushkarK Req ID   :   WAF3_WF_2
	function IsWorkFlowEnable_Click()
	{
	    var objWorkFlowEnable = GetObjectReference('frmPageProperties', 'IsWorkFlowEnable');
	    if (objWorkFlowEnable)
	    {
            var objPageName = GetObjectReference('frmPageProperties', 'PageName');
            var objAddNewMode_UIPage = GetObjectReference('frmPageProperties', 'AddNewMode_UIPage');
            var objEditMode_UIPage = GetObjectReference('frmPageProperties', 'EditMode_UIPage');
	        if (objWorkFlowEnable.checked==true)
	        {
	            if (objPageName) {objPageName.value = '../Source/Workflow/InheritedWorkFlowCommonList.aspx';}
	            if (objAddNewMode_UIPage) {objAddNewMode_UIPage.value = '../Workflow/InheritedWorkFlowCommonPage.aspx';}
	            if (objEditMode_UIPage) {objEditMode_UIPage.value = '../Workflow/InheritedWorkFlowCommonPage.aspx';}
                alert("<%=m_str_MSG_DISABLE_WORKFLOW%>");
	        }
	       else
	        {
                if (objPageName) {objPageName.value = '../Source/General/CommonList.aspx';}
                if (objAddNewMode_UIPage) {objAddNewMode_UIPage.value = '';}
                if (objEditMode_UIPage) {objEditMode_UIPage.value = '';}
                alert("<%=m_str_MSG_DISABLE_WORKFLOW%>");
	        }
        }
    }    
    //Added By Ninad on 20 Mar 2008, WAF3_PB_62 - UI Design Template
    var objXHttp;
    // Modified By Shrikant B On 22 May 2008 
    //Purpose :Pass The New Parameter  SectionId To Function GenerateUIDesignTemplate
     function GenerateUIDesignTemplate(TagID,IsSubTag,SectionId)
	{
	    //try catch block is required bcoz ActiveX scripting may be disabled on client, in that case UI Design temlate will not be generated
	
	    try
        {
        
            var strUrl="../SM/PB_XMLHttpRequestHandler.aspx?operation=GENERATEUIDESIGNTEMPLATE&IsSubTag=" + IsSubTag + "&TagID=" + TagID + "&SECTIONID=" + SectionId ;
	        //objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
            if (document.all){
                objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
            }
            else{
                objXHttp = new XMLHttpRequest();
            }
	        objXHttp.onreadystatechange = function()// Modified By Shrikant B On 22 May 2008
	          {
                    
               if (objXHttp.readyState==4)
                   {
                        if (objXHttp.responseText != null)
                        {
                            if(objXHttp.responseText.substring(0,8)=="INFOMSG:")
                                alert(objXHttp.responseText.substring(8));
                            else
                             {
                              if (SectionId==1)
                                document.getElementById('UIDesignTemplate').value=objXHttp.responseText;
                              else
                                document.getElementById('UIDesignFooterTemplate').value=objXHttp.responseText;
                             }
                        }
                 }
              }
	                              
            objXHttp.open("GET",strUrl, false); 
            objXHttp.send();
	    }
	    catch(e){}
	}
    //End Addition By Ninad on 20 Mar 2008, WAF3_PB_62 - UI Design Template
    //Added By Ninad on 8 June 2009 - WAF3_PB_73
    function ApplyFiltersOnDB_OnClick()
    {
        if (document.getElementById('ApplyFiltersOnDB').checked)
        {
            document.getElementById('ShowRecordsForDBFilters').disabled=false;
        }
        else
        {
            document.getElementById('ShowRecordsForDBFilters').checked=false;
            document.getElementById('ShowRecordsForDBFilters').disabled=true;
        }
    }
    // End Addition By Ninad on 8 June 2009 - WAF3_PB_73
    // Added By ShrikantB On 21-JUL-2010 For Concurrency Control
    function chkConcurrency_OnClick()
	{
	    var objTimeStamp;
		var objConUpdatedBy;
		var objConcurrency;
		objConcurrency =GetObjectReference('frmPageProperties','chkConcurrency'); 
		objTimeStamp = GetObjectReference('frmPageProperties','cboTimestamp');
		objconUpdatedBy = GetObjectReference('frmPageProperties','cboConcurrency_UpdatedBy');		
		
		if (objConcurrency != null)
		{
			if (objConcurrency.checked == true)
			{
			  
			    if (blnShowConcurrencyMsg) alert("<%=Server.HtmlDecode(MyBase.GetResourceString("MSG_CONCURRENCY_CHECKED"))%>"); 
			    objTimeStamp.disabled = false;
				objconUpdatedBy.disabled = false;
				
			}
			else
			{
			    if (blnShowConcurrencyMsg) alert("<%=Server.HtmlDecode(MyBase.GetResourceString("MSG_CONCURRENCY_UNCHECKED"))%>"); 
			    objTimeStamp.disabled = true;
				objconUpdatedBy.disabled = true;
				
			}
		}
		blnShowConcurrencyMsg=true;
	}
	
	function ValidateConcurrency()
	{
	     var objTimeStamp;
		var objConUpdatedBy;
		var objConcurrency;
		var arrValues = new Array();
    	objConcurrency =GetObjectReference('frmPageProperties','chkConcurrency'); 
		objTimeStamp = GetObjectReference('frmPageProperties','cboTimestamp');
		objconUpdatedBy = GetObjectReference('frmPageProperties','cboConcurrency_UpdatedBy');	
		
		if (objConcurrency != null && objConcurrency.checked == true)
		{
		    	<%MyBase.InitializeResources("Resources.PB_CommonValidations", "Resources")%>   
		    if (disallowBlank(objTimeStamp, "<%=MyBase.GetResourceString("DISALLOW_BLANK_TIMESTAMP")%>") == true)
			    return false;
			   
			if (disallowBlank(objconUpdatedBy, "<%=MyBase.GetResourceString("DISALLOW_BLANK_UPDATEDBY")%>") == true)
			    return false;			
		}
		return true;
	}
	
	 function chkIsMultiInsertSubTag_OnClick()
	{
	
	    var objMultiInsertSubTag;
		var objConUpdatedBy;
		var objConcurrency;
		objMultiInsertSubTag = GetObjectReference('frmPageProperties','chkIsMultiInsertSubTag'); 
		objConcurrency =GetObjectReference('frmPageProperties','chkConcurrency'); 
		objTimeStamp = GetObjectReference('frmPageProperties','cboTimestamp');
		objconUpdatedBy = GetObjectReference('frmPageProperties','cboConcurrency_UpdatedBy');		
		if (objMultiInsertSubTag != null)
		{
			if (objMultiInsertSubTag.checked == true)
			{
			   if (objConcurrency!= null )
			    {
			      objConcurrency.checked =false;
			      objConcurrency.disabled = true;
		          objTimeStamp.disabled = true;
			      objconUpdatedBy.disabled = true;
			    } 
	       }
	       else
	        {
	           objConcurrency.disabled = false;
	        }
	    }
	}
	 <% MyBase.InitializeResources("Resources.PB_PageProperties", "Resources")%>
	 function chkTransHistory_OnClick(TagID,IsSubTag)
	 {
 
	   var objUpdatedBy;		
	    objTransHistory =GetObjectReference('frmPageProperties','chkTransHistory'); 
		objUpdatedBy = GetObjectReference('frmPageProperties','cboAuditTrail_UpdatedBy');
		
		if (objTransHistory != null)
		{
			if (objTransHistory.checked == true)
			{
			    if (ValidateLinkColumn(TagID,IsSubTag))
			     {
			        if (blnShowTransHistoryMsg) alert("<%=Server.HtmlDecode(MyBase.GetResourceString("MSG_TRANSHISTORY_CHECKED"))%>"); 
			        objTDTransHistoryLinks.style.display="";
				    objUpdatedBy.disabled = false;
				 } 
				 else
				   {
				     alert("<%=Server.HtmlDecode(MyBase.GetResourceString("MSG_TRANSHISTORY_LINKPRESENT"))%>")
				     objTransHistory.checked =false;
				   }
		    }
			else
			{
			    if (blnShowTransHistoryMsg) alert("<%=Server.HtmlDecode(MyBase.GetResourceString("MSG_TRANSHISTORY_UNCHECKED"))%>"); 
			    objTDTransHistoryLinks.style.display="none";
			    if (objAuditTrail !=null)
			       {
			          if (objAuditTrail.checked ==true)
			             objUpdatedBy.disabled = false;
			          else
			            objUpdatedBy.disabled = true;			          
			       }	    
			   
			}
		}
		blnShowTransHistoryMsg=true;
	 }

	function TransHistoryScript_Click(TagID,IsSubTag,Operation)
	{
	
	    if (Operation=='TRANSACTION_HISTORY_GENERATE_SCRIPT')
	    {
	        if(confirm("<%=m_str_CONFIRMATION_MSG_CREATE_TRIGGER_TRANSHISTORY%>")==false) 
	            return ;
		}   
	    window.open ("../SM/PB_DataManagementScripts.aspx?Operation=" + Operation + "&IsSubTag=" + IsSubTag + "&TagID=" + TagID, "", "scrollbars=1,resizable=1,menubar=yes,left=" + ((window.screen.width - 900)/2) + ",top=" + ((window.screen.height - 500)/2) + ",width=900,height=500");	 
    }
 
    function ValidateTransHistory()
	{
	    var objUpdatedBy;
		var objConcurrency;
   	    objTransHistory =GetObjectReference('frmPageProperties','chkTransHistory'); 
		objUpdatedBy = GetObjectReference('frmPageProperties','cboAuditTrail_UpdatedBy');
		
		if (objTransHistory != null && objTransHistory.checked == true)
		{
		    <%MyBase.InitializeResources("Resources.PB_CommonValidations", "Resources")%>   
		      
		   if (disallowBlank(objUpdatedBy, "<%=MyBase.GetResourceString("DISALLOW_BLANK_UPDATEDBY")%>") == true)
		    return false;			
		}
		return true;
	}
	  function ValidateLinkColumn(TagID,IsSubTag)
	{
	  var IsLinkColumn =false;
	    try
        {
        
            var strUrl="../SM/PB_XMLHttpRequestHandler.aspx?operation=GENERATETRANSHISTORY&IsSubTag=" + IsSubTag + "&TagID=" + TagID;
	        //objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
            if (document.all){
                objXHttp = new ActiveXObject("Msxml2.XMLHTTP");
            }
            else{
                objXHttp = new XMLHttpRequest();
            }
	        objXHttp.onreadystatechange = function()
	          {
                    
               if (objXHttp.readyState==4)
                   {
                        if (objXHttp.responseText != null)
                        {
                            if(objXHttp.responseText.substring(0,8)=="INFOMSG:")
                                alert(objXHttp.responseText.substring(8));
                            else
                             {
                                IsLinkColumn = objXHttp.responseText;
                                if (IsLinkColumn==1 )
                                 IsLinkColumn =true;                                 
                                 else 
                                   IsLinkColumn =false;       
                             }
                        }
                 }
              }
	                              
            objXHttp.open("GET",strUrl, false); 
            objXHttp.send();
	    }
	    catch(e){ }
	    return IsLinkColumn; 
	    
	}
	
	// Addition End By ShrikantB On 21-JUL-2010 For Concurrency Control
	</script>
    <% End If 'DO NOT PLOT SCRIPT FUNCTIONS FOR SAVE and CLOSE %>
	</body>
</HTML>

