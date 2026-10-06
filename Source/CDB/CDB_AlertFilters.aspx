<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CDB_AlertFilters.aspx.vb" Inherits="Whiz.CDB_AlertFilters"%>
<!DOCTYPE HTML>
<html>
		<%CommonFunctions.General.PlotPageHeadTag("Alert Filters")%>

    <!-- Commented by Madhuri.K On 12-Aug-2024 for JQuery and Bootstrap version upgrade -->
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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


<body style="overflow:auto" class="clsBody" MS_POSITIONING="GridLayout" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id='frmAlertFilters' method='post' runat='server'>
			<%WritePage()%>
		</form>
	</body>
</html>
<script language="javascript">
	<%=m_strResreshScript%>
</script>
<script language="javascript">
<% 
    'Added by Ninad, WAF3_PB_64
    If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        Response.Write("var blnShowNavigationAlert = true;")
        Response.Write("window.onbeforeunload = confirmExit;")
        Response.Write("var strContainerDivs = 'DivList';")
        Response.Write("blnNavigate = null;")
    End If
    'End Addition by Ninad, WAF3_PB_64
%>

	var objform;
	var objdivlist;
	var objchkField;
	var objtxtValue;
	var objcboFields;
	var objcboFields2;
	var objlinkValidInputs;
	var objtblWhereClause;
	var objtxtWhereClause;
	var objtxtHiddenWhereClause;
	var objtxtUndo;
	var objtxtUndo2;
	var objtxtRedo;
	var objtxtRedo2;
	var objcboOperators;
	var objcboHiddenFields;
	
	objform = GetFormReference('frmAlertFilters');
	objdivlist = GetObjectReference('frmAlertFilters','divList');
	objchkField = GetObjectReference('frmAlertFilters','chkField');
	objtxtValue = GetObjectReference('frmAlertFilters','txtValue');
	objcboFields = GetObjectReference('frmAlertFilters','cboFields');
	objcboFields2 = GetObjectReference('frmAlertFilters','cboFields2');
	objlinkValidInputs = GetObjectReference('frmAlertFilters','linkValidInputs');
	objtblWhereClause= GetObjectReference('frmAlertFilters','tblWhereClause');
	objtxtWhereClause = GetObjectReference('frmAlertFilters','txtWhereClause');
	objtxtHiddenWhereClause = GetObjectReference('frmAlertFilters','txtHiddenWhereClause');
	objtxtUndo = GetObjectReference('frmAlertFilters','txtUndo');
	objtxtUndo2 = GetObjectReference('frmAlertFilters','txtUndo2');
	objtxtRedo = GetObjectReference('frmAlertFilters','txtRedo');
	objtxtRedo2 = GetObjectReference('frmAlertFilters','txtRedo2');
	objcboOperators = GetObjectReference('frmAlertFilters','cboOperators');
	objcboHiddenFields = GetObjectReference('frmAlertFilters','cboHiddenFields'); 
		
	var intTotalCount;
	intTotalCount = <%=UBound(m_arrValue)%>;
	var arrInputs=new Array(intTotalCount);
	var arrDataTypes=new Array(intTotalCount);
	var arrValues=new Array(intTotalCount);
	var arrUFValues=new Array(intTotalCount);

	<%For m_intCounterI = 0 to UBound(m_arrValue)%>
		arrInputs[<%=m_intCounterI%>] = "<%=m_arrValidInputs(m_intCounterI)%>";
		arrDataTypes[<%=m_intCounterI%>] = "<%=m_arrDataType(m_intCounterI)%>";
		arrValues[<%=m_intCounterI%>]= "<%=m_arrValue(m_intCounterI)%>";
		arrUFValues[<%=m_intCounterI%>]="<%=m_arrText(m_intCounterI)%>";
	<%Next%>
	function AppendPlaceHolder_OnClick()  //Added By PushkarK On 15-Jul-2008 For WAF3_CDB_27 : Place holder support in Alert Filters
	{		
		if (trimString(objcboFields.value) =="" ) 
		{
			alert("Please select an attribute");
			objcboFields.focus(); 
			return;
		}			
		if (trimString(objcboOperators.value) =="" ) 
		{
			alert("Please select an operator");
			objcboOperators.focus(); 
			return;
		}	
		window.open("../QRB/QRB_Placeholders.aspx?FromWhere=ALERTFILTER","_Placeholders","resizable=yes,scrollbars=no,left=" + ((window.screen.width - 600)/2) + ",top=" + ((window.screen.height - 600)/2) + ",height=600,width=600");
	}
	function Append_OnClick()
	{
		var iCountI;
		var iCountJ;
		var arrTemp;
		var bValid;
		var sValue;
		var sTemp;
		var sFieldValue;
		var sFieldValue2;
		var sDataType_First;
		var sDataType_Second;
		var intTotalCount;
		var temp;
		
		sDataType_First= "";
		sDataType_Second ="";
		
		if (trimString(objcboFields.value) =="" ) 
		{
			alert("Please select an attribute");
			objcboFields.focus(); 
			return;
		}			
		if (trimString(objcboOperators.value) =="" ) 
		{
			alert("Please select an operator");
			objcboFields.focus(); 
			return;
		}	
				
		if (objchkField.checked == false)
		{
			if (trimString(objtxtValue.value) == "")
			{
				alert("Please enter the value");
				objtxtValue.focus(); 
				return;
			}
		}
		else
		{	
			if (trimString(objcboFields2.value) == "")
			{
				alert("Please select the value attribute.");
				objcboFields2.focus; 
				return;
			}
			
			intTotalCount = arrUFValues.length - 1;
			for (iCountI = 0;iCountI<intTotalCount;iCountI++)
			{
				if (trimString(arrUFValues[iCountI]) == trimString(objcboFields.value)) 
				{
					sDataType_First = arrDataTypes[iCountI];
					break;
				}
			}
			for (iCountI = 0;iCountI<intTotalCount;iCountI++)
			{
				if (trimString(arrUFValues[iCountI]) == trimString(objcboFields2.value)) 
				{
					sDataType_Second = arrDataTypes[iCountI];
					break;
				}
			}
			
			switch(true)
			{
			case ((trimString(sDataType_First)==3) || (trimString(sDataType_First)==4) ||(trimString(sDataType_First)==5)||(trimString(sDataType_First)==6)||(trimString(sDataType_First)==11)):
					switch(true)
					{
					case ((trimString(sDataType_Second)==3) || (trimString(sDataType_Second)==4) ||(trimString(sDataType_Second)==5)||(trimString(sDataType_Second)==6)||(trimString(sDataType_Second)==11)):
						break;
					default:
						alert("Invalid comparison! The attributes are of different data types!");
						return;
						break;
					}
					break;
			case (trimString(sDataType_First)==135):
					switch(true)
					{
					case (trimString(sDataType_Second)==135):
						break;
					default:
						alert("Invalid comparison! The attributes are of different data types!");
						return;
						break;
					}
					break;
			default:
					switch(true)
					{
					case ((trimString(sDataType_Second)==3) || (trimString(sDataType_Second)==4) ||(trimString(sDataType_Second)==5)||(trimString(sDataType_Second)==6)||(trimString(sDataType_Second)==11)||(trimString(sDataType_Second)==135)):
						alert("Invalid comparison! The attributes are of different data types!");
						return;
						break;
					}
					break;
			}
		
		}	
				
		if (trimString(objtxtWhereClause.value) != "")
		{
			temp = trimString(objtxtWhereClause.value);
			arrTemp = temp.split(" ");
			intTotalCount = arrTemp.length - 1;
			if (trimString(arrTemp[intTotalCount])!= "AND" || trimString(arrTemp[intTotalCount])!= "OR" || trimString(arrTemp[intTotalCount]) != "(" || trimString(arrTemp[intTotalCount]) != ")" )
			{
			}
			else
			{
				alert("Please select a join condition (AND,OR)");
				return;
			}
		}
		bValid = false;
	
		
		intTotalCount = arrUFValues.length - 1;
		for (iCountJ=0;iCountJ<=intTotalCount;iCountJ++)
		{ 
			if (trimString(arrUFValues[iCountJ]) == trimString(objcboFields.value))
			{
				sFieldValue = trimString(arrValues[iCountJ]);
				break;
			}
		}
		
				
		if (trimString(arrValues[iCountJ])== trimString(sFieldValue))
		{
			if (trimString(arrInputs[iCountJ]) != "" )
			{
				temp = arrInputs[iCountJ];
				arrTemp = temp.split(",");
				intTotalCount = arrTemp.length - 1;
				for (iCountI=0;iCountI<=intTotalCount;iCountI++)
				{ 
					if (trimString(objtxtValue.value) == trimString(arrTemp[iCountI]))
					{
						bValid = true;
						if (objchkField.checked == true)
						{
							sValue = replaceSubstring(trimString(objcboFields2.value ),"'","''");
						}
						else
						{
							sValue = replaceSubstring(trimString(objtxtValue.value ),"'","''");
						}
						break;
					}
				}
					
				if (bValid == false)
				{
					alert("The value entered for the attribute is invalid!!\r\nThe valid inputs are " + arrInputs[iCountJ]);
					return;
				}
			}
		}
		
		
		
		if (bValid == false)
		{
			if (objchkField.checked == false)
			{
				intTotalCount = arrValues.length - 1;
				for (iCountI=0;iCountI<intTotalCount;iCountI++)
				{		
					
					intTotalCount = arrUFValues.length - 1;
					for (iCountJ=0;iCountJ<intTotalCount;iCountJ++)
					{
						if (trimString(arrUFValues[iCountJ]) == trimString(objcboFields.value))
						{
							sFieldValue = trimString(arrValues[iCountJ]);
							break;
						}
					}
					
					if (trimString(arrValues[iCountI])== trimString(sFieldValue))
					{
						switch(true)
						{
						case ((trimString(arrDataTypes[iCountI])==4) || (trimString(arrDataTypes[iCountI])==3)):
							switch(true)
							{
							case (trimString(objtxtValue.value)== "NULL"):
								sValue = replaceSubstring(trimString(objtxtValue.value) ,"'","''");
								break;
							default:
								if (disallowNonNumeric(objtxtValue,"Please enter a numeric value")) return;
								sValue = replaceSubstring(trimString(objtxtValue.value ),"'","''");
								break;
							}
							break;
						case ((trimString(arrDataTypes[iCountI])==135)):
							switch(true)
							{
							case ((trimString(objtxtValue.value)== "NULL") || (isSubstringExists(trimString(objtxtValue.value),"GETDATE()"))):
								sValue = replaceSubstring(trimString(objtxtValue.value ),"'","''");
								break;
							default:
								sValue = "'" + replaceSubstring(trimString(objtxtValue.value ),"'","''") + "'";
								break;
							}
							break;
						case ((trimString(arrDataTypes[iCountI])==11)):
							
							switch(true)
							{
							case (trimString(objtxtValue.value)== "NULL"):
								sValue = replaceSubstring(trimString(objtxtValue.value ),"'","''");
								break;
							default:
								if (trimString(objtxtValue.value)!= "0" || trimString(objtxtValue.value)!= "1")
								{
									alert("The value expected is a bit value.Valid inputs are '1','0'");
									return;
								}
								sValue = "'" + replaceSubstring(trimString(objtxtValue.value ),"'","''") + "'";
								break;
							}
							break;
						default:
							switch(true)
							{
							case ((trimString(objtxtValue.value)== "NULL") || (isSubstringExists(trimString(objtxtValue.value),"GETDATE()"))):
								sValue = replaceSubstring(trimString(objtxtValue.value ),"'","''");
								break;
							default:
								//modified issue#20286 RajK DBCS support, 28-jul-2005
								sValue = "N'" + replaceSubstring(trimString(objtxtValue.value ),"'","''") + "'";
								//end modification RajK, 28-jul-2005
								break;
							}
							break;
						}
					}
				}
			}
			else
			{
				intTotalCount = arrUFValues.length - 1;
				for (iCountJ=0;iCountJ<=intTotalCount;iCountJ++)
				{ 
					if (trimString(arrUFValues[iCountJ]) == trimString(objcboFields.value))
					{
						sFieldValue = trimString(arrValues[iCountJ]);
						break;
					}
				}
				
				for (iCountJ=0;iCountJ<=intTotalCount;iCountJ++)
				{ 
					if (trimString(arrUFValues[iCountJ]) == trimString(objcboFields2.value))
					{
						sValue = trimString(arrValues[iCountJ]);
						break;
					}
				}
			}
		
		}
		
		
		
		if (objchkField.checked == false)
		{				
			objtxtWhereClause.value = objtxtWhereClause.value + " " +  objcboFields.value + " " + objcboOperators.value + " " + sValue;
			sTemp = objtxtUndo.value;
			sTemp = sTemp + "&&" +  objcboFields.value + " " + objcboOperators.value + "  " + sValue;
			objtxtUndo.value = sTemp;
			sTemp = objtxtUndo2.value;
			sTemp = sTemp + "&&" +  objcboHiddenFields(objcboFields.selectedIndex).value + " " + objcboOperators.value + " " + sValue;
			objtxtUndo2.value = sTemp;
			objtxtHiddenWhereClause.value = objtxtHiddenWhereClause.value + " " +  objcboHiddenFields(objcboFields.selectedIndex).value + " " + objcboOperators.value + " " + sValue;
		}	
		else
		{				
			objtxtWhereClause.value = objtxtWhereClause.value + " " +  objcboFields.value + " " + objcboOperators.value + " " + objcboFields2.value ; 
			sTemp = objtxtUndo.value;
			sTemp = sTemp + "&&" +  objcboFields.value + " " + objcboOperators.value + " " + objcboFields2.value; 
			objtxtUndo.value = sTemp;
			sTemp = objtxtUndo2.value;
			sTemp = sTemp + "&&" +  objcboHiddenFields(objcboFields.selectedIndex).value + " " + objcboOperators.value + " " + sValue;
			objtxtUndo2.value = sTemp;
			objtxtHiddenWhereClause.value = objtxtHiddenWhereClause.value + " " +  objcboHiddenFields(objcboFields.selectedIndex).value + " " + objcboOperators.value + " " +  sValue;
		}
			
	}
	
	
	function Insert_OnClick(sChar)
	{
		var arrTemp = new Array();
		var intTotalCount;
		var WhereClause;
		
		if ((trimString(sChar) != ")") && (trimString(sChar) != "("))
		{
			if (trimString(objtxtWhereClause.value) != "") 
			{
				WhereClause = trimString(objtxtWhereClause.value);
				arrTemp = WhereClause.split(" ");
				intTotalCount = arrTemp.length - 1;
				if ((trimString(arrTemp[intTotalCount]) == "OR") || (trimString(arrTemp[intTotalCount]) == "AND" ))
				{
				alert("Please enter a filter condition!");
					return;
				}
			}
			else
			{
				alert("Please enter a filter condition!");
				return;
			}
		}
		objtxtWhereClause.value = objtxtWhereClause.value + " " + sChar + " ";
		objtxtHiddenWhereClause.value = objtxtHiddenWhereClause.value + " " + sChar + " ";
				
		objtxtUndo.value  = objtxtUndo.value  + "&&" +  sChar;
		objtxtUndo2.value  = objtxtUndo2.value + "&&" +  sChar;		
	}
	
	function ReDo_OnClick()
	{
		var sTemp;
		var sTemp2;
		var sUndoTemp;
		var iCount;
		var arrTemp;
		var temp;
		
		sTemp= "";
		sTemp2= "";
		if (trimString(objtxtRedo.value) == "") 
		{
			return;
		}
		else
		{
			temp = trimString(objtxtRedo.value);
			temp = temp.substring(2,temp.length);
			arrTemp = temp.split("&&");
				
			sTemp = trimString(objtxtWhereClause.value);
			intTotalCount = arrTemp.length - 1;
			sTemp = sTemp + " " + arrTemp[intTotalCount];
			objtxtWhereClause.value = trimString(sTemp);
							
			for (iCount = 0; iCount<intTotalCount;iCount++)
			{
				if (trimString(arrTemp[iCount])!="")
				{
					sTemp2 = sTemp2 +  "&&" + arrTemp[iCount];
				}
			}
			objtxtRedo.value = trimString(sTemp2);
			sUndoTemp = objtxtUndo.value;
			sUndoTemp = sUndoTemp + "&&" + arrTemp[intTotalCount];
			objtxtUndo.value = sUndoTemp;
		}
		sTemp = "";
		sTemp2 = "";
		
		if (trimString(objtxtRedo2.value) == "") 
		{
			return;
		}
		else
		{
			temp = trimString(objtxtRedo2.value);
			temp = temp.substring(2,temp.length);
			arrTemp = temp.split("&&");
	
			sTemp = trimString(objtxtHiddenWhereClause.value);
			intTotalCount = arrTemp.length - 1;
			sTemp = sTemp + " " + arrTemp[intTotalCount];
			objtxtHiddenWhereClause.value = trimString(sTemp);
							
			for (iCount = 0; iCount<intTotalCount;iCount++)
			{
				if (trimString(arrTemp[iCount])!="")
				{
					sTemp2 = sTemp2 +  "&&" + arrTemp[iCount];
				}
			}
			objtxtRedo2.value = trimString(sTemp2);
			sUndoTemp = objtxtUndo2.value;
			sUndoTemp = sUndoTemp + "&&" + arrTemp[intTotalCount];
			objtxtUndo2.value = sUndoTemp;
		}
	}
	
	function Undo_OnClick()
	{
		var sUndo;
		var arrTemp;
		var sTemp;
		var sTemp2;
		var sRedoTemp;
		var iCount;
		var sCurrentMode;
		var intTotalCount;		
		var temp;
				
		sTemp = "";
		sTemp2 = "";
		if (trimString(objtxtUndo.value) == "" || trimString(objtxtUndo.value) == "&&")
		{
			return;
		}
		else
		{
			temp = trimString(objtxtUndo.value);
			temp = temp.substring(2,temp.length);
			arrTemp = temp.split("&&");
				
			objtxtWhereClause.value = "";
			objtxtUndo.value = "";
			
			intTotalCount = arrTemp.length - 1;
			for (iCount = 0; iCount < intTotalCount;iCount++)
			{
				if (trimString(arrTemp[iCount]) != "")
				{
					sTemp = sTemp + " " + arrTemp[iCount];
					sTemp2 = sTemp2 + "&&" + arrTemp[iCount];
				}
			}
			objtxtWhereClause.value = trimString(sTemp);
			objtxtUndo.value = trimString(sTemp2);
			sRedoTemp = objtxtRedo.value ;
			sRedoTemp = sRedoTemp + "&&" + arrTemp[intTotalCount];
			objtxtRedo.value = sRedoTemp;
		}
		sTemp = "";
		sTemp2 = "";
		if (trimString(objtxtUndo2.value) == "" || trimString(objtxtUndo2.value) == "&&")
		{
			return;
		}
		else
		{
			temp = trimString(objtxtUndo2.value);
			temp.substring(2,temp.length);
			arrTemp = temp.split("&&");
				
			objtxtHiddenWhereClause.value = "";
			objtxtUndo2.value = "";
			
			intTotalCount = arrTemp.length - 1;
			for (iCount = 0; iCount < intTotalCount;iCount++)
			{
				if (trimString(arrTemp[iCount]) != "")
				{
					sTemp = sTemp + " " + arrTemp[iCount];
					sTemp2 = sTemp2 + "&&" + arrTemp[iCount];
				}
			}
			objtxtHiddenWhereClause.value = trimString(sTemp);
			objtxtUndo2.value = trimString(sTemp2);
			sRedoTemp = objtxtRedo2.value ;
			sRedoTemp = sRedoTemp + "&&" + arrTemp[intTotalCount];
			objtxtRedo2.value = sRedoTemp;
		}
	}
	
	function Clear_OnClick()
	{											
		objtxtWhereClause.value = ""
		objtxtHiddenWhereClause.value = ""
		objtxtUndo.value =""
		objtxtUndo2.value = ""
		objtxtRedo.value = ""
		objtxtRedo2.value = ""   
		/*objcboFields.selectedIndex = -1
		objcboOperators.selectedIndex = -1*/
		if (objchkField.checked == false)
		{
			objtxtValue.value = ""   
		}
		else
		{
			objcboFields2.selectedIndex = -1 
		}
	}

	function FieldValue_OnClick()
	{
		if  (objchkField.checked == true)
		{
			objtxtValue.style.display = "none";   
			objcboFields2.style.display  = "block";
			objcboFields2.selectedIndex = -1 ;
			objlinkValidInputs.style.display = "none";
		}
		else
		{
			objtxtValue.style.display = "block";   
			objcboFields2.style.display  = "none";
		}	
	}
	

	function Back_OnClick(DBID,alertid)
	{
	    if(ShowNavigationAlert()==false) return; //Added By Ninad WAF3_PB_64		
		window.location.href = "CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=2&Mode=EDIT&DashboardID=" + DBID + "&AlertID=" + alertid; 
	}
	
	function Save_OnClick(DBID,alertid)
	{
		objform.action = "CDB_AlertFilters.aspx?FromWhere=<%=m_strFromWhere%>&Action=SAVE&DashboardID=" + DBID + "&AlertID=" + alertid;
		blnNavigate = false;    //Added By Ninad WAF3_PB_64		
		objform.submit(); 
	}
	
	function Next_OnClick(DBID,alertid)
	{
		objform.action = "CDB_AlertFilters.aspx?FromWhere=<%=m_strFromWhere%>&Action=NEXT&DashboardID=" + DBID + "&AlertID=" + alertid;
		objform.submit(); 
	}

	function ChainLink_OnClick(pos)
	{
		switch(true)
		{
		case (pos==1):
			window.location.href =  "CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=1&Action=&Mode=EDIT&AlertID=<%=m_lngAlertID%>&DashboardID=<%=m_lngDashboardID%>";
			break;
		case (pos==2):
			window.location.href =  "CDB_AlertDescription.aspx?FromWhere=<%=m_strFromWhere%>&Step=2&Action=&Mode=EDIT&AlertID=<%=m_lngAlertID%>&DashboardID=<%=m_lngDashboardID%>";
			break;
		case (pos==3):
			window.location.href =  "CDB_AlertFilters.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&AlertID=<%=m_lngAlertID%>&DashboardID=<%=m_lngDashboardID%>";
			break;
		case (pos==4):
			window.location.href =  "CDB_AlertMails.aspx?FromWhere=<%=m_strFromWhere%>&Action=&Mode=EDIT&AlertID=<%=m_lngAlertID%>&DashboardID=<%=m_lngDashboardID%>";
			break;
		default:
			break;
		}
	}
	
	function window_onload()
	{
		var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 17, 2007 NinadP 
		windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 17, 2007 NinadP %>
		var intShowMsg;
		intShowMsg = <%=m_intShowInvalidFilterMsg%>;
		if (intShowMsg == 1)
		{
			alert("The filter conditions are invalid");
		}
	}
	
	<% 'WAF3_PB_42 April 17, 2007 START
		'Removed local functions for window onresize 
		'WAF3_PB_42 April 17, 2007 END%>

</script>
