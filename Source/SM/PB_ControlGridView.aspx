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
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PB_ControlGridView.aspx.vb" Inherits="Whiz.PB_ControlGridView" %>

<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.PB_ControlGridView", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>	
	
	<body onunload ="CheckRefresh()" class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize()" onload="window_onload()">
		<form id="frmControlGridView" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
		var objdivlist;
	var objFromElement;
	var objTagSubTagID;
	var tagSubTagID;
	var fromElement;
	objdivlist=GetObjectReference('frmControlGridView','outerDiv');
	objFromElement = GetObjectReference('frmControlGridView','fromElement');
	objTagSubTagID = GetObjectReference('frmControlGridView','tagSubTagID');
	if (objFromElement != null)
		fromElement = getInputValue(objFromElement);
	if (objTagSubTagID != null)
		tagSubTagID = getInputValue(objTagSubTagID);
	//Added By Ninad to refresh both frame of parent 28 June 2007
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
    //End Addition By Ninad to refresh both frame of parent 28 June 2007
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
	function Save_OnClick(IsClose)
	{
		var objForm;
		var objCLOrderNumber;
		var objCLGridOrderNumber;
		var objCPGridOrderNumber;
		var objRowNumber;
		var objOrderNumber;
		var objRowCount;
		var objAction;
		var rowCount;
		var flag;
		var row;
		var check = false;
		var test;
		var objcboShowOnTabControl;	
		var blnIsTabControlMandatory = '<%=blnIsTabControlMandatory%>';
		objForm = GetObjectReference('frmControlGridView','frmControlGridView');
		objRowCount = GetObjectReference('frmControlGridView','rowCount');
		if(objRowCount != null)
			rowCount = getInputValue(objRowCount);
		
		<%MyBase.InitializeResources("Resources.PB_CommonValidations","Resources")%>
		
		for(row=0; row<=rowCount; row++)
		{	
			if (fromElement == 'Tag')
				objCLOrderNumber = GetObjectReference('frmControlGridView','txtCLOrderNumber'+row);
			else if (fromElement == 'SubTag')
			{
				objCLGridOrderNumber = GetObjectReference('frmControlGridView','txtCLGridOrderNumber'+row);
				objCPGridOrderNumber = GetObjectReference('frmControlGridView','txtCPGridOrderNumber'+row);
			}
			objRowNumber = GetObjectReference('frmControlGridView','txtRowNumber'+row);
			objOrderNumber = GetObjectReference('frmControlGridView','txtOrderNumber'+row);
			objcboShowOnTabControl = GetObjectReference('frmControlGridView','cboShowOnTabControl'+row);
			if (fromElement == 'Tag')
			{
				if (objCLOrderNumber != null )
				{ 
					if(objCLOrderNumber.disabled == false)
					{
						check = false;
						flag = disallowBlank(objCLOrderNumber, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>');
						if (flag == false)
						{
							flag = disallowNegativeInteger(objCLOrderNumber, '<%=MyBase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>');
							if (flag == false)
							{
								check = true;
							}
							else
								break;
						}
						else
							break;
					}
					else
						check = true;
				}
			}
			else if (fromElement = 'SubTag')
			{
				if(objCLGridOrderNumber != null)
				{
					if(objCLGridOrderNumber.disabled == false)
					{
						check = false;
						flag = disallowBlank(objCLGridOrderNumber, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>');
						if (flag == false)
						{
							flag = disallowNegativeInteger(objCLGridOrderNumber, '<%=MyBase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>');
							if (flag == false)
							{
								check = true;
							}
							else
								break;
						}
						else
							break;
					}
					else
						check = true;
				}
				if(objCPGridOrderNumber != null)
				{
					if(objCPGridOrderNumber.disabled == false)
					{
						check = false;
						flag = disallowBlank(objCPGridOrderNumber, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>');
						if (flag == false)
						{
							flag = disallowNegativeInteger(objCPGridOrderNumber, '<%=MyBase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>');
							if (flag == false)
							{
								check = true;
							}
							else
								break;
						}
						else
							break;
					}
					else
						check = true;
				}
			}
			if(objRowNumber != null)
			{
				if(objRowNumber.disabled == false && check == true)
				{
					check = false;
					flag = disallowBlank(objRowNumber, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>');
					if (flag == false)
					{
						flag = disallowNegativeInteger(objRowNumber, '<%=MyBase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>');
						if (flag == false)
						{
							check = true;
						}
						else
							break;
					}
					else
						break;
				}
				else
					check=true;
			}
			if(objOrderNumber != null)
			{ 	
				if(objOrderNumber.disabled == false && check == true)
				{
					check = false;
					flag = disallowBlank(objOrderNumber, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>');
					if (flag == false)
					{
						flag = disallowNegativeInteger(objOrderNumber, '<%=MyBase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>');
						if (flag == false)
						{
							check = true;
						}
						else
							break;
					}
					else
						break;
				}
				else
					check=true;
			}
			if( blnIsTabControlMandatory=='True' && objcboShowOnTabControl != null)
			{ 	
				if(objcboShowOnTabControl.disabled == false && check == true)
				{
					check = false;
					flag = disallowBlank(objcboShowOnTabControl, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>');
					if (flag == false)
					{
						check = true;
					}
					else
						break;
				}
				else
					check=true;
			}
		}
		if(check == true)
		{
			if (ValidateRowwiseCount() == true)
			{
				objAction = GetObjectReference('frmControlGridView', 'action');
				objAction.value = 'Save';	
				if (rowCount != -1)
				{
					for(var rowCounter=0; rowCounter<=rowCount; rowCounter++)
					{
						
						objCLOrderNumber = GetObjectReference('frmControlGridView','txtCLOrderNumber'+rowCounter);
						objCLGridOrderNumber = GetObjectReference('frmControlGridView','txtCLGridOrderNumber'+rowCounter);
						objCPGridOrderNumber = GetObjectReference('frmControlGridView','txtCPGridOrderNumber'+rowCounter);
						objRowNumber = GetObjectReference('frmControlGridView','txtRowNumber'+rowCounter);
						objOrderNumber = GetObjectReference('frmControlGridView','txtOrderNumber'+rowCounter);
						objcboShowOnTabControl = GetObjectReference('frmControlGridView','cboShowOnTabControl'+rowCounter);
						if(objCLOrderNumber != null && objCLOrderNumber.disabled == true)
							objCLOrderNumber.disabled = false;
						if(objCLGridOrderNumber != null && objCLGridOrderNumber.disabled == true)
							objCLGridOrderNumber.disabled = false;
						if(objCPGridOrderNumber != null && objCPGridOrderNumber.disabled == true)
							objCPGridOrderNumber.disabled = false;
						if(objRowNumber != null && objRowNumber.disabled == true)
							objRowNumber.disabled = false;
						if(objOrderNumber != null && objOrderNumber.disabled == true)
							objOrderNumber.disabled = false;
						if(objcboShowOnTabControl != null && objcboShowOnTabControl.disabled == true)
							objcboShowOnTabControl.disabled = false;
					}
				}			
				objForm.submit();
				IsRefreshParent=false;
				if (IsClose == 1)
				{
				    IsRefreshParent=true;
					Close_OnClick();
				}
			}
		}
	}
	
	function Delete_OnClick()
	{
		var objForm;
		var objAction;
		var objRowCount;
		var objDelete;
		var rowCount;
		var rowCounter;
		
		objForm = GetObjectReference('frmControlGridView','frmControlGridView');
		objAction = GetObjectReference('frmControlGridView', 'action');
		objRowCount = GetObjectReference('frmControlGridView', 'rowCount'); 
		objDelete = GetObjectReference('frmControlGridView', 'chkDelete',1);
				
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
						    IsRefreshParent=false;
							objAction.value = 'Delete';
							objForm.submit();
						}
					}
					break;
				}
			}
		}
	}
	
	function chkShowInGrid_OnClick(row)
	{
		var objShowInGrid;
		var objCLOrderNumber;
		var objCLGridOrderNumber;
		var objCPGridOrderNumber;
		objShowInGrid = GetObjectReference('frmControlGridView','chkShowInGrid'+row);
		if (fromElement == 'Tag')
			objCLOrderNumber  = GetObjectReference('frmControlGridView','txtCLOrderNumber'+row);
		else (fromElement == 'SubTag')
		{
			objCLGridOrderNumber  = GetObjectReference('frmControlGridView','txtCLGridOrderNumber'+row);
			objCPGridOrderNumber  = GetObjectReference('frmControlGridView','txtCPGridOrderNumber'+row);
		}
				
		if (objShowInGrid != null )
		{		
			if(objShowInGrid.checked == true)
			{
				if (fromElement == 'Tag')
				{
					if(objCLOrderNumber != null)
						objCLOrderNumber.disabled = false;
				}
				else if (fromElement == 'SubTag')
				{
					if(objCLGridOrderNumber != null)
						objCLGridOrderNumber.disabled = false;
					if(objCPGridOrderNumber != null)
						objCPGridOrderNumber.disabled = false;
				}
			}
			else
			{
				if (fromElement == 'Tag')
				{
					if(objCLOrderNumber != null)
						objCLOrderNumber.disabled = true;
				}
				else if (fromElement == 'SubTag')
				{
					if(objCLGridOrderNumber != null)
						objCLGridOrderNumber.disabled = true;
					if(objCPGridOrderNumber != null)
						objCPGridOrderNumber.disabled = true;
				}
			}
		}
	}
	
	function chkShowInForm_OnClick(row)
	{
		var objShowInForm;
		var objRowNumber;
		var objOrderNumber;
		var objcboShowOnTabControl;		
		var objhidIsControlInFooter;		
		objShowInForm = GetObjectReference('frmControlGridView','chkShowInForm'+row);
		objRowNumber  = GetObjectReference('frmControlGridView','txtRowNumber'+row);
		objOrderNumber = GetObjectReference('frmControlGridView','txtOrderNumber'+row);
		objcboShowOnTabControl = GetObjectReference('frmControlGridView','cboShowOnTabControl'+row);
		objhidIsControlInFooter = GetObjectReference('frmControlGridView','hidIsControlInFooter'+row);
		if(objShowInForm !=null)
		{		
			if(objShowInForm.checked == true)
			{
				objRowNumber.disabled = false;
				objOrderNumber.disabled = false;
				if(objhidIsControlInFooter != null && objhidIsControlInFooter.value=='False')
				    objcboShowOnTabControl.disabled = false;
			}
			else
			{
				objRowNumber.disabled = true;
				objOrderNumber.disabled = true;
				if(objcboShowOnTabControl != null)
				    objcboShowOnTabControl.disabled = true;
			}
		}
	}
	function Close_OnClick()
	{
		window.close();
	}
	function ValidateRowwiseCount()
	{
		var arrRowNumber = new Array();
		var arrControlCount = new Array();
		var arrValues = new Array();
		var objRowNumber;
		var objControlTypeID;
		var objSectionHeader;
		var valCount;
		var objRowNumberValue; 
		var index;
		
		objRowCount = GetObjectReference('frmControlGridView', 'rowCount'); 
		if (objRowCount != null)
			rowCount = getInputValue(objRowCount);
		else
			rowCount = -1;
		if (rowCount != -1)
		{
			for(var rowCounter=0; rowCounter<=rowCount; rowCounter++)
			{
				arrRowNumber[rowCounter] = -1;
			}
			for(var rowCounter=0; rowCounter<=rowCount; rowCounter++)
			{
				objRowNumber = GetObjectReference('frmControlGridView','txtRowNumber'+rowCounter);
				objControlTypeID = GetObjectReference('frmControlGridView','controlTypeID'+rowCounter);
				objSectionHeader = GetObjectReference('frmControlGridView','isSectionHeader'+rowCounter);
				if (objSectionHeader != null)
				{
					index = 0;
					for(valCount = 0; valCount<=rowCount; valCount++)
					{
						if(valCount != rowCounter)
						{	
							objRowNumberValue = GetObjectReference('frmControlGridView','txtRowNumber'+valCount);
							if (objRowNumberValue != null)
							{
								arrValues[index] = getInputValue(objRowNumberValue);
								index = index + 1;
							}
						}
					}
					if (disallowDuplicates(objRowNumber, arrValues, 'Section Header HTML Tag should be placed on a separate row',true) != false)
						return false;						
				}
				else
				{
					if(objRowNumber != null && objRowNumber.disabled == false)
					{
						if (Contains(arrRowNumber, objRowNumber.value, rowCount) == false)
							arrControlCount[objRowNumber.value] = 0; 
						arrRowNumber[rowCounter] = objRowNumber.value;
						arrControlCount[objRowNumber.value]++; 
						<% 'Modified By - PushkarK On - Friday, June 02, 2006 For Whizible Sem Issue ID. - 4115   %>
						if (arrControlCount[objRowNumber.value] > <%=m_intMaxControlsInARow%>)
						{
							setFocus(objRowNumber);
							alert('Maximum <%=m_intMaxControlsInARow%> controls allowed in a single row');
							return false;
						}
						<% 'Modification Ends By - PushkarK On - Friday, June 02, 2006 For Whizible Sem Issue ID. - 4115  %>
					}
				}
			}
		}
		return true;
	}
	function Contains(arrRowNumber, rowValue, count)
	{
		var counter;
		for(counter=0; counter<=count; counter++)
		{
			if (arrRowNumber[counter] == rowValue)
				return true;
		}
		return false;
	}
	
	function Sort_OnClick(SortBy, SortOrder)
			{
				var objForm = GetFormReference('frmControlGridView');
				var objFromElement = GetObjectReference('frmControlGridView', 'fromElement');
				var objTagSubTagID = GetObjectReference('frmControlGridView', 'tagSubTagID');
				var objControlNameSortOrder = GetObjectReference('frmControlGridView', 'controlNameSortOrder');
				//objForm.Action = "PB_ControlList.aspx?FromElement=" + objFromElement.value + "&TagID=" + objTagSubTagID.value + "&SubTagID=" + objTagSubTagID.value; 
				GetObjectReference('frmControlGridView', 'SortBy').value = SortBy;
				GetObjectReference('frmControlGridView', 'SortOrder').value = SortOrder;
				objForm.submit();
			}
		</script>
	</body>
</HTML>
