<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_EB_Variable_Definition.aspx.vb" Inherits="Whiz.QRB_EB_Variable_Definition"%>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag(Mybase.GetResourceString("TITLE"), , , , "<script language=javascript src='../QRB/QueryBuilder.js'></script>")%> <% 'WAF3_PB_42 April 06, 2007 NinadP %>
	

    <body class="clsBody" MS_POSITIONING="GridLayout"  onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 NinadP %>
	<form id="frm" method="post" runat="server">
		<%WritePage()%>
	</form>
</body>
</HTML>
<script language="javascript">
	var objdivlist; <% 'WAF3_PB_42 April 06, 2007 NinadP %>
	var objfrm;
	var objtxtVariableName;
	var objtxtValue;
	
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
	objdivlist = GetObjectReference('frm','DivList'); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
	objtxtVariableName = GetObjectReference('frm','txtVariableName');
	objtxtValue = GetObjectReference('frm','txtValue');

	
	function Back_OnClick()
	{
		window.location.href = "QRB_EB_Variable_List.aspx?MasterTagID=1560&alphabet=<%=m_strAlphabet%>";//Modified By Vinay Issue :14864
	}		
	
	
	function Save_OnClick()
	{
		if (InputValidation()==true)
		{
		objtxtVariableName.disabled=false; 
		frm.action  = "QRB_EB_Variable_Definition.aspx?MasterTagID=1560&Mode=<%=m_strMode%>&VariableID=<%=m_lngVariableID%>&Action=SAVE";
		blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
		frm.submit();
		}
	}		
		
	function InputValidation()
	{
		if (isSubstringExists(",<%=m_strVariableNames%>", "," + objtxtVariableName.value.toUpperCase() + ","))
		{
			alert("The variable name " + objtxtVariableName.value + " already exists.\nPlease provide a different variable name");
			objtxtVariableName.focus();
			return false;
		}
		if (disallowBlank(objtxtVariableName ,"<%=MyBase.GetResourceString("MSG_BLANK_NAME")%>")) return false;
		if (disallowSpecialCharacters(objtxtVariableName,"<%=MyBase.GetResourceString("MSG_SPECIAL_CHARS")%>"))return false;
		if (disallowBlank(objtxtValue,"<%=MyBase.GetResourceString("MSG_BLANK_VALUE")%>")) return false;
		if (disallowNonNumeric(objtxtValue,"<%=MyBase.GetResourceString("MGS_NON_NUMERIC")%>")) return false;
		return true
	}
		
	<% 'WAF3_PB_42 April 10, 2007 START
	'Removed local functions for window onresize 
	'WAF3_PB_42 April 10, 2007 END%>


	function window_onload()		
	{
	    var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 12, 2007 NinadP 
		windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>		
		if (objtxtVariableName.disabled==false)
		{
			objtxtVariableName.focus(); 
		}
		else
		{
			objtxtValue.focus(); 
		}
	}
		
</script>

<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
<script src="../../responsive/responsive.js"></script>
<script type="text/javascript">
$(document).ready(function(){

     /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Top Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:17/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:17/02/2015
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
    // When:17/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenuResize();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/
    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
    // By Whom: Miiint
    // When:17/02/2015
    /*---------------------------------------------------------*/

    responsiveFooterMenuResize();

    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
    /*---------------------------------------------------------*/
});
</script>

