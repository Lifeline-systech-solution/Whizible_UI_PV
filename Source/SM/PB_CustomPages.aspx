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
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PB_CustomPages.aspx.vb" Inherits="Whiz.PB_CustomPages" %>

<!DOCTYPE HTML>
<HTML>
	<% CommonFunctions.General.PlotPageHeadTag("PB_CustomPages")%> 
	<body class="clsBody" MS_POSITIONING="GridLayout"  onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmPB_CustomPages" method="post" runat="server">
			<%PageInit%>
			<SCRIPT language="javascript">
		var objform=GetFormReference('frmPB_CustomPages');
		var objdivlist=GetObjectReference('frmPB_CustomPages','PageDiv');
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 12, 2007 NinadP 
			windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
			GetObjectReference('frmPB_CustomPages', 'txtCustomPageTitle').focus();
		}
		
		<% 'WAF3_PB_42 April 13, 2007 START
	'Removed local functions for window onresize 
	'WAF3_PB_42 April 13, 2007 END%>

		function Module_OnChange(intTagID, intMasterTagID, strFromWhere, strFromCL, strSortBy, strSortOrder,  strParentTagID, strFilter, strMode)
		{
			if (strMode == "ADD_NEW")
			{
				objform.action = "PB_CustomPages.aspx?TagID=" + intTagID + "&MasterTagID=" + intMasterTagID + "&FromWhere=" + strFromWhere + "&FromCL=" + strFromCL + "&SortBy=" + strSortBy + "&SortOrder=" + strSortOrder + "&ParentTagID" + strParentTagID + "&SetFilter=" + strFilter + "&Mode=" + strMode;
			}
			else
			{
				objform.action = "PB_CustomPages.aspx?TagID=" + intTagID + "&MasterTagID=" + intMasterTagID + "&FromWhere=" + strFromWhere + "&FromCL=" + strFromCL + "&SortBy=" + strSortBy + "&SortOrder=" + strSortOrder + "&ParentTagID" + strParentTagID + "&SetFilter=" + strFilter + "&Mode=ModuleChange";
			}
			objform.submit();
		}
		
		function Back_OnClick(intTagID, intMasterTagID, strFromWhere, strFromCL, strSortBy, strSortOrder,  strParentTagID, strFilter)
		{
			window.location.href = "../SM/WAF_CommonList.aspx?&MasterTagID=" + intMasterTagID + "&FromWhere=" + strFromWhere + "&SortBy=" + strSortBy + "&SortOrder=" + strSortOrder + "&SetFilter=" + strFilter;
		}
		
		function Add_OnClick(intTagID, intMasterTagID, strFromWhere, strFromCL, strSortBy, strSortOrder, strParentTagID, strFilter)
		{
			objform.action = "PB_CustomPages.aspx?&MasterTagID=" + intMasterTagID + "&FromWhere=" + strFromWhere + "&FromCL=" + strFromCL + "&SortBy=" + strSortBy + "&SortOrder=" + strSortOrder + "&ParentTagID" + strParentTagID + "&SetFilter=" + strFilter + "&Mode=ADD_NEW";
			objform.submit();
		}
		
		function OnChange_ParentTag(intTagID, intMasterTagID, strFromWhere, strFromCL, strSortBy, strSortOrder, strParentTagID, strFilter, strMode)
		{
			if (strMode == "ADD_NEW")
			{
				objform.action = "PB_CustomPages.aspx?TagID=" + intTagID + "&MasterTagID=" + intMasterTagID + "&FromWhere=" + strFromWhere + "&FromCL=" + strFromCL + "&SortBy=" + strSortBy + "&SortOrder=" + strSortOrder + "&ParentTagID" + strParentTagID + "&SetFilter=" + strFilter + "&Mode=" + strMode;
			}
			else
			{
				objform.action = "PB_CustomPages.aspx?TagID=" + intTagID + "&MasterTagID=" + intMasterTagID + "&FromWhere=" + strFromWhere + "&FromCL=" + strFromCL + "&SortBy=" + strSortBy + "&SortOrder=" + strSortOrder + "&ParentTagID" + strParentTagID + "&SetFilter=" + strFilter + "&Mode=ParentChange";
			}
			objform.submit();
		}
		
		function Save_OnClick(intTagID, intMasterTagID, strFromWhere, strFromCL, strSortBy, strSortOrder, strParentTagID, strFilter)
		{
			var arrFields = ["txtCustomPageTitle", "cboModuleName", "cboParentNode", "txtOrderNo", "txtPageName"]
			//Requirement ID   :   WAF3_PB_IssueFixes 2
			<% MyBase.InitializeResources("Resources.PB_CustomPages", "Resources")%>
			var arrMessages = ['<%=MyBase.GetResourceString("VALIDATION_MSG_BLANK_PAGE_TITLE")%>', '<%=MyBase.GetResourceString("VALIDATION_MSG_BLANK_MODULE_NAME")%>', '<%=MyBase.GetResourceString("VALIDATION_MSG_BLANK_PARENT_NODE")%>', '<%=MyBase.GetResourceString("VALIDATION_MSG_BLANK_ORDER_NO")%>','<%=MyBase.GetResourceString("VALIDATION_MSG_BLANK_PAGE_NAME")%>'];
			for (var i=0; i<arrFields.length; i++)
			{
				if ( disallowBlank(GetObjectReference('frmPB_CustomPages', arrFields[i]), arrMessages[i]) == true)
				{
					return;
				}
			}
			objOrder = GetObjectReference('frmPB_CustomPages', arrFields[3]);
			if (ValidateOrderNumber(objOrder) == false)
			{
				//Requirement ID   :   WAF3_PB_IssueFixes 2
				alert('<%=MyBase.GetResourceString("VALIDATION_MSG_INVALID_ORDER_NO")%>');
				objOrder.focus();
				return;
			}
			
			objPageName = GetObjectReference('frmPB_CustomPages', 'txtPageName');
			//Requirement ID   :   WAF3_PB_IssueFixes 2
			if (disallowSpecialCharacters(objPageName, '<%=MyBase.GetResourceString("VALIDATION_MSG_INVALID_PAGE_NAME")%>', 1, "[:*+\"|,\\\\]" ) == true)
			{
				return;
			}
			GetObjectReference('frmPB_CustomPages', 'txtPageName').disabled = false;
			objform.action = "PB_CustomPages.aspx?TagID=" + intTagID + "&MasterTagID=" + intMasterTagID + "&FromWhere=" + strFromWhere + "&FromCL=" + strFromCL + "&SortBy=" + strSortBy + "&SortOrder=" + strSortOrder +  "&ParentTagID" + strParentTagID + "&SetFilter=" + strFilter + "&Mode=Save";
			objform.submit();
		}

		function ValidateOrderNumber(obj)
		{
			var i,j;
			var valid=true;
			var found=false;
			var orderNumber = obj.value;
			var str = "0123456789.";
			
			if(orderNumber.charAt(0) == '.' || orderNumber.charAt(orderNumber.length-1) == '.')
				valid=false;
			if(valid==true && isSubstringExists(orderNumber,'..')==true)
				valid=false;
			if(valid==true)
			{
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
					{
						valid=false;
						break;
					}
				}
			}				
			return valid;
		}
		
		function Valid_PlaceHolders()
		{
			var style = CentralizeWindow(900,600)+ ",scrollbars=1,resizable=1";
			var url;
			url = "../General/CommonList.aspx?FromWhere=SM&MasterTagID=1547" ;
			window.document.open(url,"",style);
		}
		
		function CentralizeWindow(width, height)
			{
				var styleHeightWidth;
				var left;
				var top;
				left = 512-(width/2);
				top = 350-(height/2);
				styleHeightWidth = "height=" + height + ",width=" + width + ",left=" + left + ",top=" + top;
				return styleHeightWidth;
			}

			</SCRIPT>
		</form>
	</body>
</HTML>
