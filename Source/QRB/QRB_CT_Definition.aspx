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
    TEXTAREA.clsTextArea {
    font-family: "Helvetica";
    font-size: 12px;
    border-width: 1px;
    border-style: solid;
    border-color: #CCC;
    background-color: #FBFBFB;
    width: 100% !important;
}
#DivList .clsTable:first-child td {
    vertical-align: baseline;
    text-align: left;
}
    /*Added By Vaijat K ON 07/12/2015*/
    #DivList .clsTable:nth-child(2) table {
   float:right;
    height:15px;
    width:auto;
}
/*Added By Vaijat K ON 26/11/2015 Issue ID-1987*/
  /*Commented by Nilesh G on 5/12/2016 Purposse : Ovelapped Issue */
  /*#DivList table:nth-child(2) td
    {
        float:right;
    }*/
  /*end of Commented by Nilesh G on 5/12/2016 Purposse : Ovelapped Issue */
    .footerMenuTable td
    {
        float:right;
    }
    .topInnerMenu td
    {
        float:right;
    }
/*Added by Nilesh G on 5/12/2016 Purposse : Ovelapped Issue */
    #TD0
    {
        float:right !IMPORTANT;
    }
    #TD1
    {
        float:right !IMPORTANT;
    }
    /*end of Added by Nilesh G on 5/12/2016 Purposse : Ovelapped Issue */
    /*End Addition By Vaijat K ON 26/11/2015 Issue ID-1987*/
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
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_CT_Definition.aspx.vb" Inherits="Whiz.QRB_CT_Definition"%>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"),,,,"<script language=javascript src='../QRB/QueryBuilder.js'></script>" )%>

	<body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frm" method="post" runat="server">
			<%WritePage()%>
		</form>
	</body>
	<%MyBase.InitializeResources("Resources.QRB_CT_Definition", "Resources")%>
<script language="javascript">
	var objcboEntity ;
	var objcboXAxis;
	var objcboYAxis;
	var objcboDetailQuery;
	var objtxtQueryName;
	
//	 Added By Shrikant B For WAF3_PB_64
<% 

If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then

Response.Write("var blnShowNavigationAlert = true;")

Response.Write("window.onbeforeunload = confirmExit;")

Response.Write("var strContainerDivs = 'DivList';")

Response.Write("blnNavigate = null;")

End If

%>
//End Addition by Shrikant B For WAF3_PB_64


	objfrm = GetFormReference('frm');
	objdivlist = GetObjectReference('frm','DivList'); <% 'WAF3_PB_42 renamed objDiv to objDivList (used in QueryBuilder.js onload function)%>
	
	objcboEntity = GetObjectReference('frm','cboEntity'); 
	objcboXAxis = GetObjectReference('frm','cboXAxis'); 
	objcboYAxis = GetObjectReference('frm','cboYAxis'); 
	objcboDetailQuery = GetObjectReference('frm','cboDetailQuery'); 
	objtxtQueryName = GetObjectReference('frm','txtQueryName'); 
	
	objchkField = GetObjectReference('frm','chkField');
	objtxtValue = GetObjectReference('frm','txtValue');
	objcboFields = GetObjectReference('frm','cboFields');
	objcboFields2 = GetObjectReference('frm','cboFields2');
	objlinkValidInputs = GetObjectReference('frm','linkValidInputs');
	objtxtWhereClause = GetObjectReference('frm','txtWhereClause');
	objtxtHiddenWhereClause = GetObjectReference('frm','txtHiddenWhereClause');
	objtxtUndo = GetObjectReference('frm','txtUndo');
	objtxtUndo2 = GetObjectReference('frm','txtUndo2');
	objtxtRedo = GetObjectReference('frm','txtRedo');
	objtxtRedo2 = GetObjectReference('frm','txtRedo2');
	objcboOperators = GetObjectReference('frm','cboOperators');
	objcboHiddenFields = GetObjectReference('frm','cboHiddenFields'); 
	objchkDynamicField = GetObjectReference('frm','chkDynamicField');
	
	intTotalCount = <%=UBound(m_arrValue)%>;
	intPlaceHolderCount = <%=UBound(m_arrPlaceHolders)%>;
	
	arrInputs=new Array(intTotalCount);
	arrDataTypes=new Array(intTotalCount);
	arrValues=new Array(intTotalCount);
	arrUFValues=new Array(intTotalCount);
	arrAttributeID=new Array(intTotalCount);
	
	arrPlaceHolders = new Array(intPlaceHolderCount);
	arrPlaceHolderDataTypes = new Array(intPlaceHolderCount);
	
	<%For m_intCounterI = 0 to UBound(m_arrValue)%>
		arrInputs[<%=m_intCounterI%>] = "<%=m_arrValidInputs(m_intCounterI)%>";
		arrDataTypes[<%=m_intCounterI%>] = "<%=m_arrDataType(m_intCounterI)%>";
		arrValues[<%=m_intCounterI%>]= "<%=m_arrValue(m_intCounterI)%>";
		arrUFValues[<%=m_intCounterI%>]="<%=m_arrText(m_intCounterI)%>";
		arrAttributeID[<%=m_intCounterI%>]="<%=m_arrAttributeID(m_intCounterI)%>";
	<%Next%>
	
	<%For m_intCounterI = 0 to UBound(m_arrPlaceHolders)%>
		arrPlaceHolders[<%=m_intCounterI%>] = "<%=m_arrPlaceHolders(m_intCounterI)%>";
		arrPlaceHolderDataTypes[<%=m_intCounterI%>] = "<%=m_arrPlaceHolderDataTypes(m_intCounterI)%>";
	<%Next%>
		
    //Added by Dipali V On 14th July 2017 For NextGen Upgrade
    <%' Added By SonalD on 13th Jan 2009 %>
        <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
    disableRightClick();
    <%End If%>
    <%' Added By SonalD on 13th Jan 2009 %>
    //End of Added by Dipali V On 14th July 2017 For NextGen Upgrade



	function Back_OnClick()
	{
		if ("<%=m_strMode%>" == "NEW")
		{
		window.location.href = "QRB_GroupNEntitySelection.aspx?" + replaceSubstring("<%=Request.QueryString%>","Mode=NEW","Mode=ENTITYLIST");
		}
		else
		{
		window.location.href = "QRB_CT_QueryList.aspx?MasterTagID=1562&alphabet=<%=m_strAlphabet%>";//Modified By Vinay Issue :14864
		}
	}
	
	function Validate_OnClick()
	{
		// added mar 23 2005 waf_ctq_1
		var objcboFunctionName;
		var objcboFunctionAttribute;
		var index;
		var datatype;
		objcboFunctionName = GetObjectReference('frm','cboFunctionName'); 
		objcboFunctionAttribute = GetObjectReference('frm','cboFunctionAttribute'); 
		
		// end addition mar 23 2005 waf_ctq_1
		
		if (disallowBlank(objcboXAxis,"<%=MyBase.GetResourceString("MSG_BLANK_XAXIS")%>")) return;
		if (disallowBlank(objcboYAxis,"<%=MyBase.GetResourceString("MSG_BLANK_YAXIS")%>")) return;
		if (objcboXAxis.value ==objcboYAxis.value)
		{
			alert("<%=MyBase.GetResourceString("MSG_SAME_ATTRIBUTES")%>");
			return;
		}
		
		// added mar 23 2005 waf_ctq_1
		if (disallowBlank(objcboFunctionName,"",false)==true)
		{
			if (disallowBlank(objcboFunctionAttribute,"",false)==false)
			{
			alert("<%=MyBase.GetResourceString("MSG_BLANK_FUNCTION_ATTRIBUTE")%>");
			objcboFunctionName.focus(); 
			return;
			}
		}
		else
		{
			if (disallowBlank(objcboFunctionAttribute,"",false)==true)
			{
			alert("<%=MyBase.GetResourceString("MSG_BLANK_FUNCTION")%>");
			objcboFunctionAttribute.focus(); 
			return ;
			}
		}
		if ((disallowBlank(objcboFunctionName,"",false)==false) && (disallowBlank(objcboFunctionAttribute,"",false)==false))
		{
			for (index=0;index<arrValues.length;index++)
			{
				if (arrValues[index].toUpperCase() ==  objcboFunctionAttribute.value.toUpperCase())
				{
					datatype = arrDataTypes[index];
					break;
				}
			}
			
			if (trimString(datatype) == "135")
			{
				if ((objcboFunctionName.value.toUpperCase()=="SUM") || (objcboFunctionName.value.toUpperCase()=="AVG"))
				{
					alert("<%=MyBase.GetResourceString("MSG_DATETIME_FUNCTIONS")%>");
					return;
				}	
			}
		}
		
		// end addition mar 23 2005 waf_ctq_1
		
		objfrm.action = "QRB_CT_Definition.aspx?MasterTagID=1562&EntityID=<%=m_lngEntityID%>&CTQueryID=<%=m_lngCTQueryID%>&Mode=<%=m_strMode%>&Action=Validate";
		blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
		objfrm.submit();	
		
	}
	
	function Execute_OnClick()
	{
		window.open("QRB_CT_Output.aspx?MasterTagID=1562&EntityID=<%=m_lngEntityID%>&CTQueryID=<%=m_lngCTQueryID%>","CT_Execute","resizable=yes,menubar=yes,scrollbars=no,left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-500)/2 + ",width=600,height=500"); <% 'WAF3_PB_42 April 27, 2007 NinadP %>
	}
	
	function ShowGraph_OnClick()
	{
		window.open("QRB_CT_Graph.aspx?MasterTagID=1562&CTQueryID=<%=m_lngCTQueryID%>" ,"CT_Graph","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-700)/2 + ",top=" + (window.screen.height-550)/2 + ",width=700,height=550"); <% 'WAF3_PB_42 April 27, 2007 NinadP %>
	}
	
	function Save_OnClick()
	{
		if (InputValidation()==true)
		{
		objfrm.action = "QRB_CT_Definition.aspx?MasterTagID=1562&EntityID=<%=m_lngEntityID%>&CTQueryID=<%=m_lngCTQueryID%>&Mode=<%=m_strMode%>&Action=Save";
		blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
		objfrm.submit();
		}
	}
	
	function PlaceHolders_OnClick()
	{
		window.open("QRB_Placeholders.aspx?MasterTagID=1562&FromWhere=QRB_CT","_Placeholders","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-600)/2 + ",top=" + (window.screen.height-600)/2 + ",width=600,height=600"); <% 'WAF3_PB_42 April 27, 2007 NinadP %>
	}
	

	function InputValidation()
	{
		// added mar 23 2005 waf_ctq_1
		var objcboFunctionName;
		var objcboFunctionAttribute;
		var index;
		var datatype;
		objcboFunctionName = GetObjectReference('frm','cboFunctionName'); 
		objcboFunctionAttribute = GetObjectReference('frm','cboFunctionAttribute'); 
		
		// end addition mar 23 2005 waf_ctq_1
		
		if (isSubstringExists(",<%=m_strQueryNames%>", "," + objtxtQueryName.value.toUpperCase() + ","  ))
		{
			alert("The query name " + objtxtQueryName.value + " already exists.\nPlease provide a different query name");
			objtxtQueryName.focus();
			return false;
		}
		if (disallowBlank(objtxtQueryName,"<%=MyBase.GetResourceString("MSG_BLANK_QUERYNAME")%>")) return false;
		if (disallowSpecialCharacters(objtxtQueryName,"<%=MyBase.GetResourceString("MSG_SPECIAL_CHARS")%>"))return false;
		if (disallowBlank(objcboXAxis,"<%=MyBase.GetResourceString("MSG_BLANK_XAXIS")%>")) return false;
		if (disallowBlank(objcboYAxis,"<%=MyBase.GetResourceString("MSG_BLANK_YAXIS")%>")) return false;
		if (objcboXAxis.value ==objcboYAxis.value)
		{
			alert("<%=MyBase.GetResourceString("MSG_SAME_ATTRIBUTES")%>");
			return false;
		}

		// added mar 23 2005 waf_ctq_1
		if (disallowBlank(objcboFunctionName,"",false)==true)
		{
			if (disallowBlank(objcboFunctionAttribute,"",false)==false)
			{
			alert("<%=MyBase.GetResourceString("MSG_BLANK_FUNCTION_ATTRIBUTE")%>");
			objcboFunctionName.focus(); 
			return false;
			}
		}
		else
		{
			if (disallowBlank(objcboFunctionAttribute,"",false)==true)
			{
			alert("<%=MyBase.GetResourceString("MSG_BLANK_FUNCTION")%>");
			objcboFunctionAttribute.focus(); 
			return false;
			}
		}
		if ((disallowBlank(objcboFunctionName,"",false)==false) && (disallowBlank(objcboFunctionAttribute,"",false)==false))
		{
			for (index=0;index<arrValues.length;index++)
			{
				if (arrValues[index].toUpperCase() ==  objcboFunctionAttribute.value.toUpperCase())
				{
					datatype = arrDataTypes[index];
					break;
				}
			}
			
			if (trimString(datatype) == "135")
			{
				if ((objcboFunctionName.value.toUpperCase()=="SUM") || (objcboFunctionName.value.toUpperCase()=="AVG"))
				{
					alert("<%=MyBase.GetResourceString("MSG_DATETIME_FUNCTIONS")%>");
					return;
				}	
			}
		}
		
		// end addition mar 23 2005 waf_ctq_1

		return true
	}
	<% 'WAF3_PB_42 April 10, 2007 START %>
	DraftQueryMsg = "<%=m_strDraftQueryMessage%>";
	<% 'Removed local functions for window onload and resize 
	'WAF3_PB_42 April 10, 2007 END%>
	function ValidInputs_OnClick()
	{
		var index;
		var querystring;
		
		if (objcboFields.selectedIndex==-1) return;
		
		switch(true)
		{
		case (objcboHiddenFields(objcboFields.selectedIndex).value.toUpperCase()=="PROJECTNAME" || objcboHiddenFields(objcboFields.selectedIndex).value.toUpperCase()=="USERNAME" || objcboHiddenFields(objcboFields.selectedIndex).value.toUpperCase()=="CUSTOMERNAME" || objcboHiddenFields(objcboFields.selectedIndex).value.toUpperCase()=="CUSTOMER" || objcboHiddenFields(objcboFields.selectedIndex).value.toUpperCase()=="PROJECTCODE" ):
			querystring = "Attribute=" + trimString(objcboFields.value);
			querystring += "&INPUT=" + objcboHiddenFields(objcboFields.selectedIndex).value;
			break;
		default:
			if (isSubstringExists(objcboHiddenFields(objcboFields.selectedIndex).value.toUpperCase(),"LOCATION")||isSubstringExists(objcboHiddenFields(objcboFields.selectedIndex).value.toUpperCase(),"DEPARTMENT"))
			{
				querystring = "Attribute=" + trimString(objcboFields.value);
				querystring += "&INPUT=" + objcboHiddenFields(objcboFields.selectedIndex).value;	
				break;
			}
			else
			{
				for (index=0;index<arrValues.length;index++)
				{
					if (arrValues[index].toUpperCase() == objcboHiddenFields(objcboFields.selectedIndex).value.toUpperCase())
					{
						if (trimString(arrInputs[index])!= "")
						{
							querystring = "Attribute=" + trimString(objcboFields.value);
							querystring += "&INPUT=" + arrInputs[index];
							break;
						}
						else
						{
							querystring = "Attribute=&INPUT="
							break;
						}
					}
				}
			}
			break;
		}
		window.open("QRB_ValidInputs.aspx?FromWhere=QRB_CT&" + querystring,"_ValidInputs","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-500)/2 + ",width=500,height=500"); <% 'WAF3_PB_42 April 27, 2007 NinadP %>

	}			
</script>
</html>

<!--Including files & Libraries by Miiint Solutions-->

<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<%--End Of Added By Usha Pandit On 14 Dec 2020 For Jquery Change Version 3.5.1--%>
<script type="text/javascript" src="../General/responsive/responsive.js"></script>


<script type="text/javascript">
$(document).ready(function(){
    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Top Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:10/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:10/02/2015
    /*---------------------------------------------------------*/
    responsiveFooterMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    /*---------------------------------------------------------*/
});

$(window).resize(function(){

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Table Inner Menu on Window Resize
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
        // Starts Feature Tag:whiz41-collapse & close for tablet view
        // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
        // By Whom: Miiint
        // When:17/02/2015
        /*---------------------------------------------------------*/
        collapseDivsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-collapse & close for tablet view
        /*---------------------------------------------------------*/
});
</script>
