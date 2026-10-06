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
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PB_GraphGridView.aspx.vb" Inherits="Whiz.PB_GraphGridView" %>

<!DOCTYPE HTML>
<HTML>
		<% MyBase.InitializeResources("Resources.PB_GraphGridView", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	
	<body onunload ="CheckRefresh()"class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		<form id="frmGraphGridView" method="post" runat="server">
			<%PageInit%>
		</form>
		<script language="javascript">
	var objdivlist;
	objdivlist=GetObjectReference('frmGraphGridView','outerDiv');
	//Added By Vinay to refresh both frame of parent 18 Aug 2008
	var IsRefreshParent=true;
	function CheckRefresh()
	{
	        if (IsRefreshParent==true)
	        {
	            try{
					window.opener.parent.location.href=window.opener.parent.location.href;
	             }catch(e){}
	        }	
    }
	
	function window_onresize()		
	{
		
		var intDivHeight ;
		
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
			
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		if (intDivHeight < 100)
			intDivHeight = 100;
		

	    //Comment added on 11 Dec 2015 by Viraj P
	    //objdivlist.style.height = intDivHeight;	
		objdivlist.style.height = intDivHeight + 'px';

			
	}
	function Save_OnClick()
	{
		var objForm;
		var objAction;
		objForm = GetObjectReference('frmGraphGridView','frmGraphGridView');
		if(Validate() == true)
		{
			objAction = GetObjectReference('frmGraphGridView', 'action');
			objAction.value = 'Save';	
			objForm.submit();
			IsRefreshParent=true;
			//Commented by Vinay on 18 Aug Issue id->21868
		    //opener.location.reload();
	
		}
	}
	function Validate()
	{
		var objHeight;
		var	objWidth; 
		var	objOrderNumber; 
		var arrValues = new Array();
		var objRowCount = GetObjectReference('frmGraphGridView','rowCount');
		if(objRowCount != null)
			rowCount = getInputValue(objRowCount);
		<%MyBase.InitializeResources("Resources.PB_CommonValidations","Resources")%>
		for(var row=0; row<=rowCount; row++)
		{	
			objHeight = GetObjectReference('frmGraphGridView','txtHeight'+row);
			objWidth = GetObjectReference('frmGraphGridView','txtWidth'+row);
			objOrderNumber = GetObjectReference('frmGraphGridView','txtOrderNumber'+row);
			if (objHeight !=null && disallowBlank(objHeight, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
				return false;
			if (objHeight !=null && disallowNegativeInteger(objHeight, '<%=MyBase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>') == true)
				return false;
			if (objHeight !=null && disallowMinValueViolation(objHeight,10, '<%=MyBase.GetResourceString("DISALLOW_MIN_VALUE_VIOLATION")%>', true) == true)
				return false;
			if (objHeight !=null && disallowMaxValueViolation(objHeight,1024, '<%=MyBase.GetResourceString("DISALLOW_MAX_VALUE_VIOLATION")%>', true) == true)
				return false;
			if (objHeight !=null && disallowBlank(objWidth, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
				return false;
			if (objWidth !=null && disallowNegativeInteger(objWidth, '<%=MyBase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>') == true)
				return false;
			if (objWidth !=null  && disallowMinValueViolation(objWidth,10, '<%=MyBase.GetResourceString("DISALLOW_MIN_VALUE_VIOLATION")%>', true) == true)
				return false;
			if (objWidth !=null && disallowMaxValueViolation(objWidth,1024, '<%=MyBase.GetResourceString("DISALLOW_MAX_VALUE_VIOLATION")%>', true) == true)
				return false;
			if (objOrderNumber != null &&  disallowBlank(objOrderNumber, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
				return false;
			if (objOrderNumber != null && disallowNegativeInteger(objOrderNumber, '<%=MyBase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>') == true)
				return false;
			var index = 0;
			for(var valCount = 0; valCount<=rowCount; valCount++)
			{
				if(valCount != row)
				{	
					var objOrderNumberValue = GetObjectReference('frmGraphGridView','txtOrderNumber'+valCount);
					arrValues[index] = getInputValue(objOrderNumberValue);
					index = index + 1;
				}
			}
			if(disallowDuplicates(objOrderNumber, arrValues, '<%=MyBase.GetResourceString("DISALLOW_DUPLICATES")%>',true) == true)
				return false;
		}
		return true;
	}
	function Delete_OnClick()
	{
		var objForm;
		var objAction;
		var objRowCount;
		var rowCount;
		var objDelete;
		var rowCounter;
		objForm = GetObjectReference('frmGraphGridView','frmGraphGridView');
		objAction = GetObjectReference('frmGraphGridView', 'action');
		objDelete = GetObjectReference('frmGraphGridView', 'chkDelete',1);
		objRowCount = GetObjectReference('frmGraphGridView', 'rowCount');
		if (objRowCount != null)
			rowCount = getInputValue(objRowCount);
		else
			rowCount = -1;
		if (rowCount != -1)
		{
			for(rowCounter=0; rowCounter<=rowCount; rowCounter++)
			{
				if (objDelete[rowCounter].checked == true)
				{
					if(objAction != null)
					{
						if(window.confirm("You are about to delete selected records. Click OK to delete the records."))
						{
						   IsRefreshParent=true;
							objAction.value = 'Delete';
							objForm.submit();
							//Commented by Vinay on 18 Aug issue id->21924
					       // opener.location.reload();
						}
					}
					break;
				}
			}
		}
	}
	
	function Close_OnClick()
	{
		
		window.close();
	}
		</script>
	</body>
</HTML>
