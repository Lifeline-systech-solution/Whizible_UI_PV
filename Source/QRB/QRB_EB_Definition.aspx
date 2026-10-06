<%@ Page Language="vb" AutoEventWireup="false" Codebehind="QRB_EB_Definition.aspx.vb" Inherits="Whiz.QRB_EB_Defintion"%>
<!DOCTYPE HTML>
<HTML>
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
	var objtxtExpressionName;
	var objtxtDescription;
	var objtxtExpression;
	var objcboParameter;
	
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
	objtxtDescription = GetObjectReference('frm','txtDescription');
	objtxtExpression = GetObjectReference('frm','txtExpression');
	objtxtExpressionName = GetObjectReference('frm','txtExpressionName');
	objcboParameter = GetObjectReference('frm','cboParameter')
	
	function Back_OnClick()
	{
		window.location.href = "QRB_EB_List.aspx?MasterTagID=1558&alphabet=<%=m_strAlphabet%>";//Modified By Vinay Issue :14864
	}		
	
	function Execute_OnClick()
	{
		window.open("QRB_EB_Output.aspx?MasterTagID=1558&ExpressionID=<%=m_lngExpressionID%>","EB_Execute","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-450)/2 + ",top=" + (window.screen.height-300)/2 + ",width=450,height=300"); <% 'WAF3_PB_42 April 27, 2007 NinadP %>
	}	
	
	function Validate_OnClick()
	{
		if (isSubstringExists(replaceSubstring(objtxtExpression.value.toUpperCase()," ",""),"<E-" + replaceSubstring(trimString(objtxtExpressionName.value.toUpperCase())," ","") + ">" ))
		{
			alert("Recursive expressions are not supported.\nPlease do not use the same expression within the expression definition");
			return;
		}
	
		if (disallowBlank(objtxtExpression,"<%=MyBase.GetResourceString("MSG_BLANK_EXPRESSION")%>")==false) 
		{
		objtxtExpressionName.disabled=false; 
		frm.action  = "QRB_EB_Definition.aspx?MasterTagID=1558&Mode=<%=m_strMode%>&ExpressionID=<%=m_lngExpressionID%>&Action=VALIDATE";
		blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
		frm.submit();
		}
	}		
	
	function Save_OnClick()
	{
		if (InputValidation()==true)
		{
		objtxtExpressionName.disabled=false; 
		frm.action  = "QRB_EB_Definition.aspx?MasterTagID=1558&Mode=<%=m_strMode%>&ExpressionID=<%=m_lngExpressionID%>&Action=SAVE";
		blnNavigate=false;//Added By Shrikant B ,WAF3_PB_64
		frm.submit();
		}
	}		
		
	function InputValidation()
	{
		if (isSubstringExists(",<%=m_strExpressionNames%>", "," + objtxtExpressionName.value.toUpperCase() + ","  ))
		{
			alert("The expression name " + objtxtExpressionName.value + " already exists.\nPlease provide a different expression name");
			objtxtExpressionName.focus();
			return false;
		}
		if (disallowBlank(objtxtExpressionName ,"<%=MyBase.GetResourceString("MSG_BLANK_NAME")%>")) return false;
		if (disallowSpecialCharacters(objtxtExpressionName,"<%=MyBase.GetResourceString("MSG_SPECIAL_CHARS")%>"))return false;
		if (disallowMaxlengthViolation(objtxtDescription,500,"<%=MyBase.GetResourceString("MSG_MAXLENGTH")%>")) return false;
		if (disallowBlank(objtxtExpression,"<%=MyBase.GetResourceString("MSG_BLANK_EXPRESSION")%>")) return false;
		if (isSubstringExists(replaceSubstring(objtxtExpression.value.toUpperCase()," ",""),"<E-" + replaceSubstring(trimString(objtxtExpressionName.value.toUpperCase())," ","") + ">" ))
		{
			alert("Recursive expressions are not supported.\nPlease do not use the same expression within the expression definition");
			return false;
		}
		return true
	}
	
	function Append_OnClick()
	{
		if (disallowBlank(objcboParameter ,"Please select a parameter")) return ;
		objtxtExpression.value =  objtxtExpression.value + " " + objcboParameter.value;
	}
	
	function Operator_OnClick(param)
	{
		objtxtExpression.value =  objtxtExpression.value + " " + param;
	}
	
	function Clear_OnClick()
	{
		objtxtExpression.value = "";
	}
	
		<% 'WAF3_PB_42 April 10, 2007 START
	'Removed local functions for window onresize 
	'WAF3_PB_42 April 10, 2007 END%>

	function window_onload()		
	{
	    var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 12, 2007 NinadP 
		windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
		if (objtxtExpressionName.disabled == false)
		{
			objtxtExpressionName.focus();
		}
		else
		{
			objtxtExpression.focus();
		}
		if (trimString("<%=m_strDraftQueryMessage%>") != "")
		{
			alert("<%=m_strDraftQueryMessage%>");
		}
	}

	</script>


<!-- Commented by Madhuri.K On 28-Aug-2024 for JQuery and Bootstrap version upgrade -->
<%-- <%CommonFunctions.General.PlotPageHeadTag("")%>--%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>--%>
.<script src="../../responsive/responsive.js"></script>


<script type="text/javascript">
$(document).ready(function(){


    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-InnerMenuDropDown
    // Description:Creating DropDown for Top Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:12/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenu();
    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
    // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
    // Description:Creating DropDown for Footer Table Inner Menu on document Ready
    // By Whom: Miiint
    // When:19/01/2015
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
    // When:12/02/2015
    /*---------------------------------------------------------*/
    responsiveTopMenuResize();

    /*---------------------------------------------------------*/
    // Ends Feature Tag:whiz41-InnerMenuDropDown
    /*---------------------------------------------------------*/

    /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:12/02/2015
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

