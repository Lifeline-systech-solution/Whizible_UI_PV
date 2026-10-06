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
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PB_GridFormattingRules.aspx.vb" Inherits="Whiz.PB_GridFormattingRules" %>

<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Grid Formatting Rules")%>	
	<body class="clsBody" MS_POSITIONING="GridLayout" onload="window_onload()" onresize="window_onresize()">
		<form id="frmGridFormattingRules" method="post" runat="server">
			<%PageInit()%>
		</form>
		<script language="javascript">
		var objOuterDiv;
		var comboExpanded; 
		var booleanExpanded;
		var expandedType;
		var prevExpandedType;
		var fontColorExpanded;
		if (GetObjectReference('frmGridFormattingRules','comboExpanded') != null)
			comboExpanded = GetObjectReference('frmGridFormattingRules','comboExpanded').value;
		objOuterDiv = GetObjectReference('frmControlGridView','outerDiv');
		var objHdFieldName = GetObjectReference('frmGridFormattingRules', 'cboHdFieldName');
		var objHdComparisonValue = GetObjectReference('frmGridFormattingRules', 'cboHdComparisonValue');
		objHdFieldName.style.display = 'none';	
		objHdComparisonValue.style.display = 'none';	
		function window_onresize()		
		{
		
			var intDivHeight ;
			
			intDivHeight = document.body.offsetHeight - objOuterDiv.offsetTop - 40;
			if (intDivHeight < 100)
				intDivHeight = 100;

		    //Comment added on 11 Dec 2015 by Viraj P
		    //objOuterDiv.style.height = intDivHeight	;	
			objOuterDiv.style.height = intDivHeight + 'px';
		}
		function window_onload()
		{
			var intDivHeight ;
			var objRuleName;
			var blnIsStatic;
				
			intDivHeight = document.body.offsetHeight - objOuterDiv.offsetTop - 40;
			if (intDivHeight < 100)
			    intDivHeight = 100;
		    //Comment added on 11 Dec 2015 by Viraj P
		    //objOuterDiv.style.height = intDivHeight	;	
			objOuterDiv.style.height = intDivHeight + 'px';
			if (comboExpanded == 'True')	
			{
				expandcollapse('trStaticValue');
				expandcollapse('trBooleanValue');
				blnIsStatic = false;
				booleanExpanded = false;
				expandedType = 'Dynamic';
			}
			else
			{
				expandcollapse('trDynamicValue');
				expandcollapse('trBooleanValue');
				blnIsStatic = true;
				booleanExpanded = false;
				expandedType = 'Static';
			}
			var objHdFieldName = GetObjectReference('frmGridFormattingRules', 'cboHdFieldName');
			if (objHdFieldName[GetObjectReference('frmGridFormattingRules', 'cboFieldName').selectedIndex].value == 'BOOLEAN')
			{
				expandcollapse('trBooleanValue');
				booleanExpanded = false;
				if (blnIsStatic == true)
					expandcollapse('trStaticValue');
				else
					expandcollapse('trDynamicValue');
				expandedType = 'Boolean';
			}
			objRuleName = GetObjectReference('frmGridFormattingRules', 'txtRuleName');
			setFocus(objRuleName);	
			if (GetObjectReference('frmGridFormattingRules', 'fontColorStatus').value == 'false')
			{
				expandcollapse('trFontColor');
				fontColorExpanded = false;
			}
			else
				fontColorExpanded = true;
		}
		function expandcollapse(trchildid)
		{
			showRow = (navigator.appName.indexOf("Internet Explorer") != -1) ? "block":"table-row";
			var coll = GetObjectReference('frmGridFormattingRules', trchildid);
			var elementstyle=coll.style.display;
			if(elementstyle!='none')
			{	
				coll.style.display = 'none';
			}
			else
			{
				coll.style.display = showRow;
			}
		}
		function showHideCombo(trID)
		{
			var objHdFieldName = GetObjectReference('frmGridFormattingRules', 'cboHdFieldName');
			if (trID == 'trStaticValue')
			{
				if (expandedType == 'Boolean')
				{
					expandcollapse('trBooleanValue');
					expandcollapse('trStaticValue');
				}
				else if (expandedType == 'Dynamic')
				{
					if (objHdFieldName[GetObjectReference('frmGridFormattingRules', 'cboFieldName').selectedIndex].value == 'BOOLEAN')
					{
						expandcollapse('trBooleanValue');
						expandedType = 'Boolean'
					}
					else
					{
						expandcollapse('trStaticValue');
						expandedType = 'Static'
					}
					expandcollapse('trDynamicValue');
				}
			}
			else if (trID == 'trDynamicValue')
			{
				if (expandedType == 'Boolean')
				{
					expandcollapse('trBooleanValue');
					expandcollapse('trDynamicValue');
				}
				else if (expandedType == 'Static')
				{
					expandcollapse('trStaticValue');
					expandcollapse('trDynamicValue');
				}
				expandedType = 'Dynamic'
			}
		}
		function Save_OnClick()
		{
			var objRuleName;
			var objFieldName;
			var objOperator;
			var objComparisonValue;
			var objOnAction;
			var objForm;
			var objAction;
			var objMode;
			var objExpandedType;
			
			objFromElement = GetObjectReference('frmGridFormattingRules','fromElement');
			objTagSubTagID = GetObjectReference('frmGridFormattingRules','tagSubTagID');
			if (Validate() == true && Validate_FieldName() == true)
			{
				objForm = GetFormReference('frmGridFormattingRules');
				objAction = GetObjectReference('frmGridFormattingRules', 'action');
				objMode = GetObjectReference('frmGridFormattingRules', 'mode');
				objExpandedType = GetObjectReference('frmGridFormattingRules', 'expandedType');
				objExpandedType.value = expandedType;
				objAction.value = 'Save';
				objForm.submit();
			}
		}
		function Validate()
		{
			var objRuleName;
			var objFieldName;
			var objOperator;
			var objComparisonValue;
			var objOnAction;
			
			objRuleName = GetObjectReference('frmGridFormattingRules','txtRuleName');
			objFieldName = GetObjectReference('frmGridFormattingRules','cboFieldName');
			objOperator = GetObjectReference('frmGridFormattingRules','cboComparisonOperator');
			if (expandedType == 'Static')
				objComparisonValue = GetObjectReference('frmGridFormattingRules','txtComparisonValue');
			else if (expandedType == 'Dynamic')
				objComparisonValue = GetObjectReference('frmGridFormattingRules','cboComparisonValue');
			else if (expandedType == 'Boolean')
				objComparisonValue = GetObjectReference('frmGridFormattingRules','cboBooleanValue');
			objOnAction =GetObjectReference('frmGridFormattingRules','cboOnAction');
			<%MyBase.InitializeResources("Resources.PB_CommonValidations","Resources")%>
			if (disallowBlank(objRuleName, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
				return false;
			if (disallowBlank(objFieldName, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
				return false;
			if (disallowBlank(objOperator, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
				return false;
			if (disallowBlank(objComparisonValue, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
				return false;
			if (disallowBlank(objOnAction, '<%=MyBase.GetResourceString("DISALLOW_BLANK")%>') == true)
				return false;
			return true;
		}
		function RefreshParent()
		{
			var paramFromWhere=GetObjectReference('frmGridFormattingRules','fromWhere');
			var paramTagSubTagID = GetObjectReference('frmGridFormattingRules', 'tagSubTagID');
			var paramFromElement = GetObjectReference('frmGridFormattingRules','fromElement');
			var strParentPage ;
			//Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
			try{ 
			strParentPage= window.opener.location.href; 
			if (strParentPage.toUpperCase().indexOf('COMMONLIST.ASPX') != -1 && strParentPage.toUpperCase().indexOf('MASTERTAGID=1033') != -1 )
			{
			if (paramFromElement.value == 'Tag')
				window.opener.location.href  = "../General/CommonList.aspx?FromElement=" + paramFromElement.value + "&MasterTagID=1031&TagID=" + paramTagSubTagID.value;
			else
				window.opener.location.href  = "../General/CommonList.aspx?FromElement=" + paramFromElement.value + "&MasterTagID=1033&TagID=" + paramTagSubTagID.value;
			}
			}catch(e) { } //Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
		}
		function Back_OnClick(MasterTagID)
		{
			var paramFromWhere=GetObjectReference('frmGridFormattingRules','fromWhere');
			var paramTagSubTagID = GetObjectReference('frmGridFormattingRules', 'tagSubTagID');
			var paramFromElement = GetObjectReference('frmGridFormattingRules','fromElement');
			var strParentPage ;
			//Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
			try {
			strParentPage= window.opener.location.href; 
			window.location.href  = "../General/CommonList.aspx?FromElement=" + paramFromElement.value + "&MasterTagID=" + MasterTagID + "&TagID=" + paramTagSubTagID.value;
			} catch(e) { }//Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
		}
		function Validate_FieldName()
		{
			var objComparisonValue;
			var objFieldName = GetObjectReference('frmGridFormattingRules', 'cboFieldName');
			var fieldNameIndex;
			var comparisonValueIndex;
			fieldNameIndex = objFieldName.selectedIndex;
			fieldDataType = objHdFieldName[fieldNameIndex].value;
			<%MyBase.InitializeResources("Resources.PB_CommonValidations","Resources")%>
			if (expandedType == 'Static')
			{
				objComparisonValue = GetObjectReference('frmGridFormattingRules', 'txtComparisonValue');
				if (objHdFieldName[fieldNameIndex].value == 'NUMERIC')
				{
					if (disallowNonNumeric(objComparisonValue, '<%=MyBase.GetResourceString("DISALLOW_NON_NUMERIC")%>') == true)
						return false;
				}
			}
			else if (expandedType == 'Dynamic')
			{
				objComparisonValue = GetObjectReference('frmGridFormattingRules', 'cboComparisonValue');
				comparisonValueIndex = objComparisonValue.selectedIndex;
				if (fieldDataType != objHdComparisonValue[comparisonValueIndex].value)
				{
					alert('<%=MyBase.GetResourceString("DISALLOW_DATATYPE_MISMATCH")%>');					
					setFocus(objComparisonValue);
					return false;
				}
			}
			return true;
		}
		function cboFieldName_OnChange()
		{
			var objHdFieldName = GetObjectReference('frmGridFormattingRules', 'cboHdFieldName');
			if (objHdFieldName[GetObjectReference('frmGridFormattingRules', 'cboFieldName').selectedIndex].value == 'BOOLEAN')
			{
				if (expandedType == 'Static')
				{
					expandcollapse('trBooleanValue');
					expandcollapse('trStaticValue');
				}
				else if (expandedType == 'Dynamic')
				{
					expandcollapse('trBooleanValue');
					expandcollapse('trDynamicValue');
				}
				var objComparisonValue = GetObjectReference('frmGridFormattingRules', 'rdoComparisonValue', 1);
				objComparisonValue[0].checked = true;
				expandedType = 'Boolean'
			}
			else
			{
				if (expandedType == 'Boolean')
				{
					expandcollapse('trBooleanValue');
					expandcollapse('trStaticValue');
					expandedType = 'Static'
				}
			}
		}
		function cboOnAction_Change()
		{
			var objOnAction = GetObjectReference('frmGridFormattingRules', 'cboOnAction');
			var objFontColor = GetObjectReference('frmGridFormattingRules', 'cboFontColor');
			if (objOnAction.value == 'TDFONT' || objOnAction.value == 'TRFONT')
			{
				if (fontColorExpanded == false)
				{
					expandcollapse('trFontColor');
					fontColorExpanded = true;
				}
			}
			else
			{
				if (fontColorExpanded == true)
				{
					expandcollapse('trFontColor');
					fontColorExpanded = false;
				}
			}
		}
		</script>
	</body>
</HTML>
