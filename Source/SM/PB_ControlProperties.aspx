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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PB_ControlProperties.aspx.vb" Inherits="Whiz.PB_ControlProperties" %>
<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.PB_ControlProperties", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		<form id="frmControlProperties" name="frmControlProperties" method="post" runat="server">
			<%PageInit%>
		</form>
		<script language="javascript">
	
	var objdivlist;
	var objForm;
	var objFromElement;
	var objTagSubTagID;
	var fromElement;
	var tagSubTagID;
	var beforeSaveRowNumber;
	objFromElement = GetObjectReference('frmControlProperties','fromElement');
	objTagSubTagID = GetObjectReference('frmControlProperties','tagSubTagID');
	if (objFromElement != null)
		fromElement = getInputValue(objFromElement);
	if (objTagSubTagID != null)
		tagSubTagID = getInputValue(objTagSubTagID);
	var sessionComboExpanded = false;
	var queryComboExpanded = false;
	var defaultTextExpanded = true;
	objForm=GetFormReference('frmControlProperties');
	objdivlist=GetObjectReference('frmControlProperties','outerDiv');
	var objNumberValidDate = GetObjectReference('frmControlProperties', 'validationNumber'+2);
	var objNumberOnlyAlphabets = GetObjectReference('frmControlProperties', 'validationNumber'+9);
	var objNumberNumericData = GetObjectReference('frmControlProperties', 'validationNumber'+3);
	var objNumberPositiveNumericData = GetObjectReference('frmControlProperties', 'validationNumber'+13);
	var objNumberOnlyIntegers = GetObjectReference('frmControlProperties', 'validationNumber'+19);
	var objNumberPositiveIntegers = GetObjectReference('frmControlProperties', 'validationNumber'+20);
	var objNumberSpecialCharacters = GetObjectReference('frmControlProperties', 'validationNumber'+15);
	//Added By Ninad WAF3_PB_68
	
	var objCheckDuplicate = GetObjectReference('frmControlProperties', 'validationNumber'+14);
	var objCheckDuplicateMatchCase = GetObjectReference('frmControlProperties', 'validationNumber'+28);
	var objValidateEmail = GetObjectReference('frmControlProperties', 'validationNumber'+29);
	var objValidateTime = GetObjectReference('frmControlProperties', 'validationNumber'+30);
	var beforeSaveCheckDuplicate;
	var beforeSaveCheckDuplicateMatchCase;
	try{
	beforeSaveCheckDuplicate=GetObjectReference('frmControlProperties','chkValidation', 1)[objCheckDuplicate.value].checked;
	beforeSaveCheckDuplicateMatchCase=GetObjectReference('frmControlProperties','chkValidation', 1)[objCheckDuplicateMatchCase.value].checked;	
	}catch(e){}
	var beforeSaveEmail;
	var beforeSaveTime;	
    //End Addition By Ninad WAF3_PB_68
	var beforeSaveValidDate;
	var beforeSaveOnlyAlphabets;
	var beforeSaveNumericData;
	var beforeSavePositiveNumericData;
	var beforeSaveOnlyIntegers;
	var beforeSavePositiveIntegers;
	var beforeSaveSpecialCharacters;
	var objControlTagID = GetObjectReference('frmControlProperties','controlTagID');
	var g_objXHttp;
	var g_strDependentCtrl;
	var g_strFrm;
	
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
		        if (objdivlist==null) return; // Added By Ninad Req ID - WAF3_PB_48
				var intDivHeight ;
				var intDivHeightRisk;
				var objDefaultValueType;
				var defaultValueType;
				var objDefaultValue;
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
				if (intDivHeight < 100)
					intDivHeight = 100;

	    //Comment added on 11 Dec 2015 by Viraj P
	    //objdivlist.style.height = intDivHeight;	
				objdivlist.style.height = intDivHeight + 'px';

				expandcollapse('trSessionVariable');
				expandcollapse('trQueryString');
				objDefaultValueType = GetObjectReference('frmControlProperties','defaultValueType');
				objDefaultValue = GetObjectReference('frmControlProperties','rdoDefaultValue',1);
				if (objDefaultValueType != null)
				{
					defaultValueType = getInputValue(objDefaultValueType);
					if (defaultValueType == '3')
					{
						showHideSessionCombo('trSessionVariable');
						objDefaultValue[2].checked = true;
					}
					else if (defaultValueType == '4')
					{
						showHideSessionCombo('trQueryString');
						objDefaultValue[3].checked = true;
					}
					else if (defaultValueType == '2')
						objDefaultValue[1].checked = true;
					else if (defaultValueType == '1')
						objDefaultValue[0].checked = true; 
						
				}
				if (GetObjectReference('frmControlProperties','chkMandatory') != null && GetObjectReference('frmControlProperties', 'chkValidation') != null)
				{
					chkMandatory_OnClick();
					chkValidation_OnClick();
		            //Added By Ninad WAF3_PB_68			
		            if(!beforeSaveCheckDuplicate) 
                		GetObjectReference('frmControlProperties','chkValidation', 1)[1].disabled=true;
	                if(!beforeSaveCheckDuplicateMatchCase) 
		                GetObjectReference('frmControlProperties','chkValidation', 1)[3].disabled=true;	
                    //End Addition By Ninad WAF3_PB_68

				}
				//alert(GetObjectReference('frmControlProperties','hrefParameters').value);
				if (GetObjectReference('frmControlProperties','RowNumber') != null)
					beforeSaveRowNumber = GetObjectReference('frmControlProperties','RowNumber').value;
				if (GetObjectReference('frmControlProperties', 'chkValidation') != null)
					GetBeforeSaveValidationStatus();	
				if(window.location.search.indexOf('&FocusOn=') != -1) //Added By - Ninad : Req ID - WAF3_PB_48 : Dt 1 June 2007
				{
				    if(window.location.search.indexOf('&FocusOn=FilterControlCaption') != -1)
				    {
				       <%'Add try_catch Block By ShrikantB On 28 Jan For Issue Id 26937  %>
				       try
				       {
				         document.getElementById('FilterControlCaption').scrollIntoView();
				         document.getElementById('FilterControlCaption').focus();
				        } catch (err){}
				    }
				}
	}
	function Save_OnClick(Operation)
	{
	//alert(parent.window.opener.location.href);
	//return;
		var objAction;
		var dynamicValidationFlag =false;
		var staticValidationFlag = false;
		Expand_All_Sections();				
		var objValidation = GetObjectReference('frmControlProperties','chkValidation', 1);
		var objValidationCount = GetObjectReference('frmControlProperties','validationCount');
		var objIsStaticColumn = GetObjectReference('frmControlProperties','IsStaticColumn');
		var validationCount;
		if(objValidationCount != null)
			validationCount = getInputValue(objValidationCount);
		var validationCounter;
		if (objIsStaticColumn != null) {
		if (objIsStaticColumn.checked == true)
		{
			if (CheckOrder() == false)
			{
			alert('Please insure that all the previous columns are made as static');
			objIsStaticColumn.checked = false;
			return;
			}
		} }
		for (validationCounter=0; validationCounter<validationCount; validationCounter++)
		{
			if (GetObjectReference('frmControlProperties','chkValidation') != null && objValidation[validationCounter].disabled == true)
				objValidation[validationCounter].disabled = false;
		}
		if (ValidateStaticGroups() == true && ValidateDynamicGroups() == true)
		{
			if (ValidateRowwiseCount() == true)
			{
				objAction = GetObjectReference('frmControlProperties','action');
				objAction.value = Operation; //Added By - Ninad : Req ID - WAF3_PB_48
				EnableDisabledControls();
				objForm.submit();
				if(Operation=='SAVE') //Added By - Ninad : Req ID - WAF3_PB_48
				    parent.frVerticalLeft.location.href='PB_ControlList.aspx?FromElement=' + fromElement + '&TagID=' + tagSubTagID + '&SubTagID=' + tagSubTagID ; //Added By - Ninad : Req ID - WAF3_PB_48 : Dt 29 May 2007
			}
			else
				alert('Maximum ' + g_intMaxControlsInARow + ' controls allowed in a single row');
				<% 'Modified By - PushkarK On - Friday, June 02, 2006 For Whizible Sem Issue ID. - 4115 used g_intMaxControlsInARow instead of value "3" %>
		}
	}
	function ValidateStaticGroups()
	{
		var objSection = GetObjectReference('frmControlProperties','cboSection');
		var objHTMLTag = GetObjectReference('frmControlProperties','txtHTMLTag'); //added by Ninad to validate txtHTMLTag for mandatory dt:20 Nov 2006
		var objControlCaption = GetObjectReference('frmControlProperties','txtControlCaption');
		var objMaxLength = GetObjectReference('frmControlProperties','txtMaxLength');
		var objMinLength = GetObjectReference('frmControlProperties','txtMinLength');
		var objMinValue = GetObjectReference('frmControlProperties','txtMinValue');
		var objMaxValue = GetObjectReference('frmControlProperties','txtMaxValue');
		var objHREF_URL = GetObjectReference('frmControlProperties','txtHREF_URL');
		var objImageURL = GetObjectReference('frmControlProperties','txtImageURL');
		var objAdditionalInformation = GetObjectReference('frmControlProperties','txtAdditionalInformation');
		var objControlType = GetObjectReference('frmControlProperties', 'controlTypeID');
		var objHrefParameters = GetObjectReference('frmControlProperties', 'hrefParameters');
		var objIsNonDatabaseControl = GetObjectReference('frmControlProperties', 'IsNonDatabaseControl');
		
        var objEnableSorting = GetObjectReference('frmControlProperties','EnableSorting');
        var objcontrolDataType = GetObjectReference('frmControlProperties','controlDataType');
		
		<%MyBase.InitializeResources("Resources.PB_CommonValidations","Resources")%>
		if (objControlType.value == 9 || objControlType.value == 7 || objControlType.value == 10 || objIsNonDatabaseControl.value == "True")
		{
			if (objControlCaption != null && disallowBlank(objControlCaption,  '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
				return false;
		}
		if (objSection != null && disallowBlank(objSection, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
			return false;
		//added by Ninad to validate txtHTMLTag for mandatory dt:20 Nov 2006
		if (objHTMLTag != null && disallowBlank(objHTMLTag, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
			return false;
			
		if (objMaxLength != null && disallowBlank(objMaxLength,  '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
			return false;
		if (objMaxLength != null && disallowNegativeInteger(objMaxLength,  '<%=MyBase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>') == true)
			return false;
		if (objAdditionalInformation != null && disallowBlank(objAdditionalInformation,  '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
			return false;
		if ((objControlType.value == 9 || (objHrefParameters != null && objHrefParameters.value != '')) && objHREF_URL != null && disallowBlank(objHREF_URL,  '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
			return false;
		if (objImageURL != null && disallowBlank(objImageURL,  '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
			return false;
		if (objMinLength != null && disallowNegativeInteger(objMinLength,  '<%=MyBase.GetResourceString("DISALLOW_NEGATIVE_INTEGER")%>') == true)
			return false;
		if (objMinLength != null && objMaxLength != null && disallowValue1GreaterThanValue2(objMinLength, objMaxLength, '<%=MyBase.GetResourceString("DISALLOW_VALUE1_GREATER_THAN_VALUE2")%>') == true)
			return false;
		if (objMinValue != null && disallowNonNumeric(objMinValue,  '<%=MyBase.GetResourceString("DISALLOW_NON_NUMERIC")%>') == true)
			return false;
		if (objMaxValue != null && disallowNonNumeric(objMaxValue,  '<%=MyBase.GetResourceString("DISALLOW_NON_NUMERIC")%>') == true)
			return false;
		if (objMinValue != null && objMaxValue != null && disallowValue1GreaterThanValue2(objMinValue, objMaxValue, '<%=MyBase.GetResourceString("DISALLOW_VALUE1_GREATER_THAN_VALUE2")%>') == true)
			return false;
		if (objEnableSorting != null && objcontrolDataType != null)
		{ if (objEnableSorting.checked == true && (objcontrolDataType.value == 'ntext' || objcontrolDataType.value == 'text' ||objcontrolDataType.value == 'image'))
		  {alert('The text and ntext data types cannot be used for sorting.');objEnableSorting.checked=false;return false;} }
		
		//Added By NileshD on 20 Sept. 2004
		if (objHREF_URL != null && trimString(objHREF_URL.value) !="")
			{
			//Modified by Ninad 24 April 2007 HotfixID - 2.0.10-SP7-WAF 
			  if(objHREF_URL.value.charAt(objHREF_URL.value.length -1) == ",")
			  {
				 alert('Invalid \'Hyperlink Virtual Path\'. Please see the \'Tips\' to enter valid \'Hyperlink Virtual Path\'.');
				 objHREF_URL.focus();
				 return false;	
			  }	
			  if(objHREF_URL.value.indexOf(",")!= -1)
				{
				  var objURL ;
				  objURL = objHREF_URL.value.substr(0,objHREF_URL.value.indexOf(","));
				   if (objURL.indexOf("<PARAMETERS>")!= -1)
					 {
					   objURL = objHREF_URL.value.charAt(objHREF_URL.value.indexOf(",")-1);
					   if (objURL == "\"")
						{
                          alert('Invalid \'Hyperlink Virtual Path\'. Please see the \'Tips\' to enter valid \'Hyperlink Virtual Path\'.');
				          objHREF_URL.focus();
				          return false;	
						}
					 }
				   else
				   {
				       objURL = objHREF_URL.value.charAt(objHREF_URL.value.indexOf(",")-1);
					   if (objURL != "\"")
						{
						  alert('Invalid \'Hyperlink Virtual Path\'. Please see the \'Tips\' to enter valid \'Hyperlink Virtual Path\'.');
				          objHREF_URL.focus();
				          return false;	
						}
				   }
				}
				else
				{
					if(objHREF_URL.value.charAt(objHREF_URL.value.length -1) != "\"")
					{
						alert('Invalid \'Hyperlink Virtual Path\'. Please see the \'Tips\' to enter valid \'Hyperlink Virtual Path\'.');
				        objHREF_URL.focus();
				        return false;	
					}
				}
			}
		//End Modification by Ninad 24 April 2007 HotfixID - 2.0.10-SP7-WAF
		// End Of Addition
		return true;
		
	}
	function ValidateDynamicGroups()
	{
		var objPropertyGroupBitmap;
		var propertyGroupBitmap;
		var objAllowFiltering;
		objAllowFiltering = GetObjectReference('frmControlProperties','AllowFilteringOnField');
		objPropertyGroupBitmap = GetObjectReference('frmControlProperties','propertyGroupBitmap');
		propertyGroupBitmap = getInputValue(objPropertyGroupBitmap);
		if (((propertyGroupBitmap & 1) != 0) && (Validate_OnClick_Grid_Properties() == false))
		{
			return false;
		}
		if (((propertyGroupBitmap & 2 )!= 0) && (Validate_OnClick_Form_Properties() == false))
		{
			return false;
		}	
		if (((propertyGroupBitmap & 4) != 0) && (objAllowFiltering != null) && (objAllowFiltering.checked == true) && (Validate_OnClick_Filters() == false))
		{
			return false;
		}
		//UmeshJ WAF3_PB_38 31-Jan-2007
		var objcontrolDataType = GetObjectReference('frmControlProperties','controlDataType');
        if (objcontrolDataType != null) {
        if (objcontrolDataType.value == "float" || objcontrolDataType.value == "int" || objcontrolDataType.value == "decimal" || objcontrolDataType.value == "numeric" || objcontrolDataType.value == "real" || objcontrolDataType.value == "bigint" || objcontrolDataType.value == "tinyint" || objcontrolDataType.value == "smallint" || objcontrolDataType.value == "money" || objcontrolDataType.value == "smallmoney")
        {
            var objSearchUsing = GetObjectReference('frmControlProperties','SearchUsing');
            if (objSearchUsing != null)
            {
                if (objSearchUsing.disabled == false && objSearchUsing.value != 3) 
                {
                    alert("For the numeric fields, use 'Exact Word' for searching.");
                    objSearchUsing.value=3;
                    setFocus(objSearchUsing);
                    return false;
                 }
            }
        }
        }
        //End of addition

		//Added By NileshD on 31 August 2004
		if (((propertyGroupBitmap & 1) != 0) && (Validate_SummaryFunctions() == false))
		{
			return false;
		}
		if (((propertyGroupBitmap & 1) != 0) && (Validate_ListCondition() == false))
		{
			return false;
		}
		//End Of Addition
		//Added By NileshD on 1 September 2004
		if (((propertyGroupBitmap & 1) != 0) && (Validate_UICondition() == false))
		{
			return false;
		}
		//End Of Addition
		return true;
	}
	/*Added By NileshD on 31 August 2004*/
	function Validate_SummaryFunctions()
	{
		var objSummaryFunction;
		var objSummaryFunctionLevel;
		var objcontrolDataType;	
		var objIsGroupHeader;
		
		objSummaryFunction = GetObjectReference('frmControlProperties','SummaryFunction');
		objSummaryFunctionLevel = GetObjectReference('frmControlProperties','SummaryFunctionLevel');
		objcontrolDataType = GetObjectReference('frmControlProperties','controlDataType');
		objIsGroupHeader = GetObjectReference('frmControlProperties','IsGroupHeader');
		if (objSummaryFunction != null)
		{
			if (objSummaryFunction.selectedIndex > 0)
			{
				if (objcontrolDataType.value != "float" && objcontrolDataType.value != "int" && objcontrolDataType.value != "decimal" && objcontrolDataType.value != "numeric" && objcontrolDataType.value != "real" && objcontrolDataType.value != "bigint" && objcontrolDataType.value != "tinyint" && objcontrolDataType.value != "smallint" && objcontrolDataType.value != "money" && objcontrolDataType.value != "smallmoney")
				{
					alert('Summary Function is not applicable to \'' + objcontrolDataType.value + '\' datatype');
					return false;
				}		
				if (objIsGroupHeader != null)
				{
					alert('Summary Function is not applicable to Group Header.');
					return false;
				}
				if (objSummaryFunctionLevel.selectedIndex == 0)
				{
					alert('Summary Function Level should be selected.');
					objSummaryFunctionLevel.focus();
					return false;
				}
			}
			
			if (objSummaryFunctionLevel.selectedIndex > 0)
			{
				if (objSummaryFunction.selectedIndex == 0)
				{
					alert('Summary Function should be selected.');
					objSummaryFunction.focus();
					return false;
				}
			}
		}
		
	return true;
	}
	
	function Validate_ListCondition()
	{
		objListConditionClause = GetObjectReference('frmControlProperties','ListConditionClause');
		objListActionForControl = GetObjectReference('frmControlProperties','ListActionForControl');
		objListConditionalControlValue = GetObjectReference('frmControlProperties','ListConditionalControlValue');
		
		if (objListConditionClause != null)
		{
				if (objListConditionClause.value != "")
				{
					if (objListActionForControl.selectedIndex == 0)
					{
					alert('Select the List Action For Control');
					objListActionForControl.focus();
					return false;	
					}
				}
				if (objListActionForControl.selectedIndex > 0)
				{
					if (objListConditionClause.value == "")
					{
					alert('Enter the List Condition Clause');
					objListConditionClause.focus();
					return false;	
					}
					
					if (objListActionForControl[objListActionForControl.selectedIndex].value != "2" && objListActionForControl[objListActionForControl.selectedIndex].value != "5" )
					{
						if (objListConditionalControlValue.value == "")
						{
						alert('Enter the List Conditional Control Value');
						objListConditionalControlValue.focus();
						return false;
						}
					}
				}
		}
		return true;
	}
	/*End Of Addition*/
	//Added By NileshD on 1 September 2004
	function Validate_UICondition()
	{
		objConditionClause = GetObjectReference('frmControlProperties','ConditionClause');
		objActionForControl = GetObjectReference('frmControlProperties','ActionForControl');
		objConditionalControlValue = GetObjectReference('frmControlProperties','ConditionalControlValue');
		objControlToolTip = GetObjectReference('frmControlProperties','ControlToolTip');
		
		if (objConditionClause != null)
		{
				if (objConditionClause.value != "")
				{
					if (objActionForControl.selectedIndex == 0)
					{
					alert('Select the Action For Control');
					objActionForControl.focus();
					return false;	
					}
				}
				if (objConditionalControlValue.value !="")
				{
					if (objActionForControl.selectedIndex == 0)
					{
					alert('Select the Action For Control');
					objActionForControl.focus();
					return false;	
					}
					if (objConditionClause.value == "" )
					{
					alert('Enter the Condiiton Clause For Control');
					objConditionClause.focus();
					return false;	
					}
				}
				if (objActionForControl.selectedIndex > 0)
				{
					if (objConditionClause.value == "")
					{
					alert('Enter the Condition Clause');
					objConditionClause.focus();
					return false;	
					}
					
					if (objActionForControl[objActionForControl.selectedIndex].value != "0" && objActionForControl[objActionForControl.selectedIndex].value != "1" && objActionForControl[objActionForControl.selectedIndex].value != "6" && objActionForControl[objActionForControl.selectedIndex].value != "7")
					{
						if (objConditionalControlValue.value == "")
						{
						alert('Enter the Conditional Control Value');
						objConditionalControlValue.focus();
						return false;
						}
					}
				}
		}
		// Adde By NileshD on 17 Sept. 2004
		if (objControlToolTip != null)
		{
		     if (objControlToolTip.value.indexOf("\"") != -1)
		     {
		       alert(" Double quote (\") not allowed in the \'Control Tool Tip\' ");
		       objControlToolTip.focus();
		       return false;
		     }
		}
		// End Of Addition
		
		return true;
	}
	/*End Of Addition*/
	
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
	function Close_OnClick()
	{
		parent.window.close();
	}
	function chkMandatory_OnClick()
	{
		var objMandatory;
		var objNotBlank;
		var objValidationNotBlankID;
		var validationNotBlankID;
		var objShowAsLink;
		var objPrimaryKey;
		objMandatory = GetObjectReference('frmControlProperties','chkMandatory');
		objNotBlank = GetObjectReference('frmControlProperties','chkValidation', 1);
		objShowAsLink = GetObjectReference('frmControlProperties','ShowAsLink');
		objPrimaryKey = GetObjectReference('frmControlProperties','chkPrimaryKey');
		objValidationNotBlankID = GetObjectReference('frmControlProperties','validationNotBlankID');
		if (objValidationNotBlankID != null)
		{
			validationNotBlankID = getInputValue(objValidationNotBlankID);
			if (objMandatory.checked == true)
			{
				if (objNotBlank != null)
					objNotBlank[validationNotBlankID].checked = true;
				if (objShowAsLink != null && objShowAsLink.checked == true)
				{
					if (objNotBlank != null)
						objNotBlank[validationNotBlankID].disabled = true;
				}
				if (objPrimaryKey != null && objPrimaryKey.checked == true)
				{
					if (objNotBlank != null)
						objNotBlank[validationNotBlankID].disabled = true;
				}
			}
			else
			{
				if (objNotBlank != null)
					objNotBlank[validationNotBlankID].checked = false;
			}
		}
	}
	function chkValidation_OnClick()
	{
		var objValidation;
		var objMandatory;
		var objValidationNotBlankID;
		var validationNotBlankID;
		objMandatory = GetObjectReference('frmControlProperties','chkMandatory');
		objValidation = GetObjectReference('frmControlProperties','chkValidation', 1);
		objValidationNotBlankID = GetObjectReference('frmControlProperties','validationNotBlankID');
		objValidationNumber = GetObjectReference('frmControlProperties','validationNumber');
		if (objValidation != null)
		{
			if (objValidationNotBlankID != null)
			{
				validationNotBlankID = getInputValue(objValidationNotBlankID);
				if (objMandatory != null && objValidation[validationNotBlankID].checked == true)
					objMandatory.checked =  true;
				else
					objMandatory.checked = false;
			}
			if (objValidation[objNumberNumericData.value].checked != beforeSaveNumericData || objValidation[objNumberOnlyAlphabets.value].checked != beforeSaveOnlyAlphabets || objValidation[objNumberOnlyIntegers.value].checked != beforeSaveOnlyIntegers || objValidation[objNumberPositiveIntegers.value].checked != beforeSavePositiveIntegers  || objValidation[objNumberPositiveNumericData.value].checked != beforeSavePositiveNumericData || objValidation[objNumberSpecialCharacters.value].checked != beforeSaveSpecialCharacters || objValidation[objNumberValidDate.value].checked != beforeSaveValidDate || objValidation[objValidateEmail.value].checked != beforeSaveEmail || objValidation[objValidateTime.value].checked != beforeSaveTime || objValidation[objCheckDuplicate.value].checked != beforeSaveCheckDuplicate || objValidation[objCheckDuplicateMatchCase.value].checked != beforeSaveCheckDuplicateMatchCase)//Modified By Ninad WAF3_PB_68
				UncheckCheckedValidations();
			if (objValidation[objNumberOnlyAlphabets.value].checked == true)
			{
				if (GetObjectReference('frmControlProperties', 'txtMinValue') != null)
					GetObjectReference('frmControlProperties', 'txtMinValue').disabled = true;
				if (GetObjectReference('frmControlProperties', 'txtMaxValue') != null)
					GetObjectReference('frmControlProperties', 'txtMaxValue').disabled = true;
			}
			else
			{
				if (GetObjectReference('frmControlProperties', 'txtMinValue') != null)
					GetObjectReference('frmControlProperties', 'txtMinValue').disabled = false;
				if (GetObjectReference('frmControlProperties', 'txtMaxValue') != null)
					GetObjectReference('frmControlProperties', 'txtMaxValue').disabled = false;
			}
			GetBeforeSaveValidationStatus();
    	}
	}
	function chkAllowFilteringOnField_OnClick()
	{
		var objAllowFiltering;
		var objFilterControlCaption;
		var objFilterOrderNumber;
		var objFilterControlWidth;
		var objStoredProcedureName;
		var objFilterDefaultValue;
		var objControlCaption;
		var objAdditionalInformation;
		var objDefaultValue;
		var objControlWidth;
		var objSearchUsing;	//Added By NileshD on 6 Oct. 2004
		var objDropdownGroupingColumnForFilter; //Added By NileshD on 15 Feb. 2006
		var objDropdownGroupingDisableColumnForFilter; //Added By NileshD on 15 Feb. 2006
					
		objAllowFiltering = GetObjectReference('frmControlProperties','AllowFilteringOnField');
		objFilterControlCaption = GetObjectReference('frmControlProperties','FilterControlCaption');
		objFilterOrderNumber = GetObjectReference('frmControlProperties','FilterOrderNumber');
		objFilterControlWidth = GetObjectReference('frmControlProperties','FilterControlWidth');
		objStoredProcedureName = GetObjectReference('frmControlProperties','StoredProcedureName');
		objFilterDefaultValue = GetObjectReference('frmControlProperties','FilterDefaultValue');
		objSearchUsing = GetObjectReference('frmControlProperties','SearchUsing');
		
		objControlCaption = GetObjectReference('frmControlProperties','txtControlCaption');
		objAdditionalInformation = GetObjectReference('frmControlProperties','txtAdditionalInformation');
		objDefaultValue = GetObjectReference('frmControlProperties','txtDefaultValue');
		objControlWidth = GetObjectReference('frmControlProperties','ControlWidth');
		
		//Added By NileshD on 15 Feb. 2006
		objDropdownGroupingColumnForFilter = GetObjectReference('frmControlProperties','DropdownGroupingColumnForFilter');
		objDropdownGroupingDisableColumnForFilter = GetObjectReference('frmControlProperties','Filter_DropdownGroupingDisableColumnForFilter');
		//End of Addition By NileshD on 15 Feb. 2006
		
		if (objAllowFiltering.checked == true)
		{
			if (objFilterControlCaption != null)
				objFilterControlCaption.disabled =  false;
			if (objFilterOrderNumber != null)
				objFilterOrderNumber.disabled = false;
			if (objFilterControlWidth != null)
				objFilterControlWidth.disabled = false;
			if (objStoredProcedureName != null)
				objStoredProcedureName.disabled = false;
			if (objFilterDefaultValue != null)
				objFilterDefaultValue.disabled = false;
			//UmeshJ WAF3_PB_38 31-Jan-2007
			if (objSearchUsing != null)
			{
				objSearchUsing.disabled = false;
				var objcontrolDataType = GetObjectReference('frmControlProperties','controlDataType');
                if (objcontrolDataType != null) {
                if (objcontrolDataType.value == "float" || objcontrolDataType.value == "int" || objcontrolDataType.value == "decimal" || objcontrolDataType.value == "numeric" || objcontrolDataType.value == "real" || objcontrolDataType.value == "bigint" || objcontrolDataType.value == "tinyint" || objcontrolDataType.value == "smallint" || objcontrolDataType.value == "money" || objcontrolDataType.value == "smallmoney")
                {objSearchUsing.value=3;}
                }
			}
			//End Of Addition
			
			//Added By NileshD on 15 Feb. 2006
			if (objDropdownGroupingColumnForFilter != null)
				objDropdownGroupingColumnForFilter.disabled = false;
			if (objDropdownGroupingDisableColumnForFilter != null)
				objDropdownGroupingDisableColumnForFilter.disabled = false;
			//End of Addition By NileshD on 15 Feb. 2006
			
			if (objControlCaption != null && objFilterControlCaption != null && objFilterControlCaption.value == '')
				objFilterControlCaption.value = objControlCaption.value;
			if (objDefaultValue != null && objFilterDefaultValue != null && objFilterDefaultValue.value == '')
				objFilterDefaultValue.value = objDefaultValue.value; 
			if (objControlWidth != null && objFilterControlWidth != null && objFilterControlWidth.value == '')
				objFilterControlWidth.value = objControlWidth.value;
			if (objAdditionalInformation != null && objStoredProcedureName != null && objStoredProcedureName.value == '')
				objStoredProcedureName.value = objAdditionalInformation.value;
		}	
		else
		{
			if (objFilterControlCaption != null)
				objFilterControlCaption.disabled =  true;
			if (objFilterOrderNumber != null)
				objFilterOrderNumber.disabled = true;
			if (objFilterControlWidth != null)
				objFilterControlWidth.disabled = true;
			if (objStoredProcedureName != null)
				objStoredProcedureName.disabled = true;
			if (objFilterDefaultValue != null)
				objFilterDefaultValue.disabled = true;	
			//Added By NileshD on 6 Oct. 2004
			if (objSearchUsing != null)
				objSearchUsing.disabled = true;
			//End Of Addition
		} 
	}
	function Advanced_OnClick()
	{
		
		var controlTagID;
		
		controlTagID = getInputValue(objControlTagID);
		window.open("PB_HyperlinkParameters.aspx?FromElement=" + fromElement + "&ControlTagID=" + controlTagID + "&SubControlTagID=" + controlTagID,"HyperlinkParameters","left=100,top=200,height=400,width=800,resizable=yes,scrollbar=yes,toolbar=no,location=no,directories=no,status=no,menubar=no");
	}
	function chkPrimaryKey_OnClick()
	{
		var objPrimaryKey;
		var objEditable;
		var objDataType;
		var dataType
		var objIsPrimaryKeySet;
		var isPrimaryKeySet;
		var objMandatory;
		var objValidation = GetObjectReference('frmControlProperties','chkValidation', 1);
		var objValidationNotBlankID = GetObjectReference('frmControlProperties','validationNotBlankID');
		objPrimaryKey = GetObjectReference('frmControlProperties','chkPrimaryKey');
		objEditable = GetObjectReference('frmControlProperties','chkEditable');
		objMandatory = GetObjectReference('frmControlProperties','chkMandatory');
		objDataType = GetObjectReference('frmControlProperties','controlDataType');
		dataType = getInputValue(objDataType);
		objIsPrimaryKeySet = GetObjectReference('frmControlProperties','isPrimaryKeySet');
		if (objIsPrimaryKeySet != null)
			isPrimaryKeySet = getInputValue(objIsPrimaryKeySet);
		if (objPrimaryKey.checked == true)
		{
			if (dataType == 'int' || dataType == 'bigint'|| dataType == 'decimal'|| dataType == 'numeric'|| dataType == 'varchar'|| dataType == 'nvarchar'|| dataType == 'uniqueidentifier' || dataType == 'tinyint'|| dataType == 'smallint') //Modified by Ninad on 11 Dec 2007 Issue ID : 17227
			{	
				if (isPrimaryKeySet == 'True')
				{
					if(window.confirm("This will remove the earlier Primary Key setting"))
					{
						if (objMandatory != null)
						{
							objEditable.checked = false;
							objMandatory.checked = true;
							objMandatory.disabled = true;
							if (GetObjectReference('frmControlProperties','chkValidation') != null)
							{	
								objValidation[objValidationNotBlankID.value].checked = true;
								objValidation[objValidationNotBlankID.value].disabled = true;
							}
						}
					}
					else
						objPrimaryKey.checked = false;
				}
				else
				{
					if (objMandatory != null)
					{
						objEditable.checked = false;
						objMandatory.checked = true;
						objMandatory.disabled = true;
						if (GetObjectReference('frmControlProperties','chkValidation') != null)
						{
							objValidation[objValidationNotBlankID.value].checked = true;
							objValidation[objValidationNotBlankID.value].disabled = true;
						}
					}
				}
			}
			else
			{
				alert('The data type of this control is not supported for Primary Key');
				objPrimaryKey.checked = false;
			}
		}
		else
		{
			if (objMandatory != null)
			{
				if (objMandatory.disabled == true)
				{
					objMandatory.disabled = false;
				}
			}
			if (GetObjectReference('frmControlProperties','chkValidation') != null)
			{
				objValidation[objValidationNotBlankID.value].disabled = false;
			}
		}
	}
	function ConfigureOptionItems_OnClick(TagID, ControlTagID, MasterTagID, ParentTag)
	{
		var url;
		var style;
		url = "../General/CommonList.aspx?TagID=" + TagID + "&ControlTagID=" + ControlTagID + "&MasterTagID=" + MasterTagID+ "&ParentTag=" + ParentTag;
		style = "height=300,width=550,left=250,top=150,scrollbars=0,resizable=1"; <%'Modification by VinayB on 8-APR-2009 3.0.06.P.Y-SP12-WAF IssueID-27184,29987 %>
		window.open(url,"OptionDetails", style);
	}
	function ConfigureComparisonValidations_OnClick(TagID, ControlTagID, MasterTagID, ParentTag)
	{
		var url;
		var style;
		url = "../General/CommonList.aspx?TagID=" + TagID + "&ControlTagID=" + ControlTagID + "&MasterTagID=" + MasterTagID + "&ParentTag=" + ParentTag;
		style = "height=300,width=500,left=250,top=150,scrollbars=1,resizable=1";
		window.open(url,"ComparisonValidations", style);
	}
	function ShowAsLink_OnClick()
	{
		var objShowAsLink;
		var objMandatory;
		var objNotBlank;
		var objValidationNotBlankID;
		objShowAsLink = GetObjectReference('frmControlProperties','ShowAsLink');
		objMandatory = GetObjectReference('frmControlProperties','chkMandatory');
		objNotBlank = GetObjectReference('frmControlProperties','chkValidation', 1);
		objValidationNotBlankID = GetObjectReference('frmControlProperties','validationNotBlankID');
		if (objShowAsLink.checked == true)
		{
			if (objMandatory != null)
			{
				objMandatory.checked = true;
				objMandatory.disabled = true;
			}
			if (GetObjectReference('frmControlProperties','chkValidation') != null && objValidationNotBlankID != null)
			{
				objNotBlank[objValidationNotBlankID.value].checked = true;
				objNotBlank[objValidationNotBlankID.value].disabled = true;
			}
		}
		else
		{
			if (GetObjectReference('frmControlProperties','chkValidation') != null && objValidationNotBlankID != null)
				objNotBlank[objValidationNotBlankID.value].disabled = false;
			if (objMandatory != null)
				objMandatory.disabled = false;
		}
	}
	function ValidateRowwiseCount()
	{
		var objRowNumber;
		objRowNumber = GetObjectReference('frmControlProperties','RowNumber');
		if (objRowNumber != null && objRowNumber.value != beforeSaveRowNumber)
		{
			if ((arrControlCount[objRowNumber.value] + 1) > g_intMaxControlsInARow)
			{
				setFocus(objRowNumber);
				return false; 
			}
		}
		return true;
	}
	function EnableDisabledControls()
	{
		var objMandatory = GetObjectReference('frmControlProperties','chkMandatory');
		if (objMandatory != null && objMandatory.disabled == true)
			objMandatory.disabled = false;
	}
	function GetBeforeSaveValidationStatus()
	{
		var objValidation = GetObjectReference('frmControlProperties','chkValidation',1);
		if (objNumberValidDate != null)
			beforeSaveValidDate = objValidation[objNumberValidDate.value].checked;
		if (objNumberOnlyAlphabets != null)
			beforeSaveOnlyAlphabets = objValidation[objNumberOnlyAlphabets.value].checked;
		if (objNumberNumericData != null)
			beforeSaveNumericData = objValidation[objNumberNumericData.value].checked;
		if (objNumberPositiveNumericData != null)
			beforeSavePositiveNumericData = objValidation[objNumberPositiveNumericData.value].checked;
		if (objNumberOnlyIntegers != null)
			beforeSaveOnlyIntegers = objValidation[objNumberOnlyIntegers.value].checked;
		if (objNumberPositiveIntegers != null)
			beforeSavePositiveIntegers = objValidation[objNumberPositiveIntegers.value].checked;
		if (objNumberSpecialCharacters != null)
			beforeSaveSpecialCharacters = objValidation[objNumberSpecialCharacters.value].checked;
		//Added By Ninad WAF3_PB_68
		if (objValidateEmail != null)
			beforeSaveEmail = objValidation[objValidateEmail.value].checked;
		if (objValidateTime != null)
			beforeSaveTime = objValidation[objValidateTime.value].checked;
		if (objCheckDuplicate != null)
			beforeSaveCheckDuplicate = objValidation[objCheckDuplicate.value].checked;
		if (objCheckDuplicateMatchCase != null)
			beforeSaveCheckDuplicateMatchCase = objValidation[objCheckDuplicateMatchCase.value].checked;
			
        //End Addition By Ninad WAF3_PB_68			
	}
	function UncheckCheckedValidations()
	{
		var objValidation = GetObjectReference('frmControlProperties','chkValidation',1);
		//Added By Ninad WAF3_PB_68
		if ((objValidation[objCheckDuplicate.value].checked != beforeSaveCheckDuplicate ) || (objValidation[objCheckDuplicateMatchCase.value].checked != beforeSaveCheckDuplicateMatchCase))
		{	
		if (objValidation[objCheckDuplicate.value].checked != beforeSaveCheckDuplicate )
		{	
		    if (beforeSaveCheckDuplicate)
	        { 
		        objValidation[1].disabled=true;
		        objValidation[1].checked=false;
	        }
	        else
	        {
		        objValidation[1].disabled=false;
		        objValidation[3].disabled=true;
		        objValidation[3].checked=false;
		        objValidation[2].checked=false;
		    }
		}   
		if (objValidation[objCheckDuplicateMatchCase.value].checked != beforeSaveCheckDuplicateMatchCase)
		{	 
		    if (beforeSaveCheckDuplicateMatchCase)
	        { 
		        objValidation[3].disabled=true;
		        objValidation[3].checked=false;
	        }
	        else
            {
		        objValidation[1].disabled=true;
		        objValidation[3].disabled=false;
		        objValidation[1].checked=false;
		        objValidation[0].checked=false;
            }
		}	
		return;
		}
        //End Addition By Ninad WAF3_PB_68	
		
		if (objNumberValidDate !=null && beforeSaveValidDate == true)
			objValidation[objNumberValidDate.value].checked = false;
		if (objNumberOnlyAlphabets !=null && beforeSaveOnlyAlphabets == true)
			objValidation[objNumberOnlyAlphabets.value].checked = false;
		if (objNumberNumericData !=null && beforeSaveNumericData == true)
			objValidation[objNumberNumericData.value].checked = false;
		if (objNumberPositiveNumericData !=null && beforeSavePositiveNumericData == true)
			objValidation[objNumberPositiveNumericData.value].checked = false;
		if (objNumberOnlyIntegers !=null && beforeSaveOnlyIntegers == true)
			objValidation[objNumberOnlyIntegers.value].checked = false;
		if (objNumberPositiveIntegers !=null && beforeSavePositiveIntegers == true)
			objValidation[objNumberPositiveIntegers.value].checked = false;
		if (objNumberSpecialCharacters !=null && beforeSaveSpecialCharacters == true)
			objValidation[objNumberSpecialCharacters.value].checked = false;
        //Added By Ninad WAF3_PB_68
		if (objValidateEmail !=null && beforeSaveEmail == true)
			objValidation[objValidateEmail.value].checked = false;
		if (objValidateTime !=null && beforeSaveTime == true)
			objValidation[objValidateTime.value].checked = false;
        //End Addition By Ninad WAF3_PB_68			
	}


var g_strText = new String();
function CheckOrder()
	{
		var objCLOrderNumber;
		var strUrl;
		var strNavigator;
		if (fromElement == 'Tag')
			objCLOrderNumber = GetObjectReference('frmControlProperties','CLOrderNumber')	
		else
			objCLOrderNumber = GetObjectReference('frmControlProperties','CPGridOrderNumber')
		
		if (objCLOrderNumber != null)
		{
			//strUrl = new String();
			strUrl = "../SM/PB_CheckValues.aspx?ControlID=" + objControlTagID.value  + "&OrderInGrid=" + objCLOrderNumber.value + "&TagID=" + tagSubTagID +"&from=" + fromElement;
		}
		
		strNavigator = navigator.appName;
		strNavigator = strNavigator.toUpperCase();
		if(strNavigator == 'MICROSOFT INTERNET EXPLORER')
		{ 
			g_objXHttp = new ActiveXObject("Msxml2.XMLHTTP"); 
			//hook the event handler
			g_objXHttp.onreadystatechange = HandlerOnReadyStateChange;
			//prepare the call, http method=GET, false=asynchronous call
			g_objXHttp.open("GET",strUrl, false);
			//finally send the call
			g_objXHttp.send();
		}
		else
		{
			// Mozilla - based browser , Netscape
			g_objXHttp = new XMLHttpRequest();
			//hook the event handler
			g_objXHttp.onreadystatechange = HandlerOnReadyStateChange();
			//prepare the call, http method=GET, false=asynchronous call
			g_objXHttp.open("GET",strUrl, false);
			//finally send the call
			g_objXHttp.send(null);
		}
		if (g_strText == 'TRUE')
		   return true;
		else
		   return false;
	}
	

function HandlerOnReadyStateChange()
	{
		var objCbo = GetObjectReference(g_strFrm,g_strDependentCtrl);
		if (g_objXHttp.readyState==4)
		{
			
			if (g_objXHttp.responseText != null)
			{
				g_strText = g_objXHttp.responseText;				
				
			}
		}
	}		
//Added by Ninad 24 April 2007 HotfixID - 2.0.10-SP7-WAF 
function ShowTips()
{
    window.open('../General/Help.aspx?HelpID=HyperlinksVirtualPathTips', 'HyperlinksVirtualPathTips', 'width=750,height=300, location=no, menubar=no, status=no, toolbar=no, scrollbars=no, resizable=yes,left=' + (window.screen.width - 750)/2 + ',top=' + (window.screen.height - 300)/2);
}
//End Addition by Ninad 24 April 2007 HotfixID - 2.0.10-SP7-WAF		
		</script>
	</body>
</HTML>
