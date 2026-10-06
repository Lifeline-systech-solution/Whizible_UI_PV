<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Help.aspx.vb" Inherits="Whiz.Help" %>
<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.Help", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	<%-- commenteted and added by nilesh g on 28/12/2015 for add overflow to body --%>
	<%--<body class="clsHelpBody" MS_POSITIONING="GridLayout" onload="window_onload()" onresize="window_onresize()">--%>
    <body class="clsHelpBody" MS_POSITIONING="GridLayout" onload="window_onload()" onresize="window_onresize()" style="overflow:auto;">
        <%-- end of commenteted and added by nilesh g on 28/12/2015 for add overflow to body --%>
		<form id="frmHelp" method="post" runat="server">
			<%DrawPage%>
		</form>
		<SCRIPT Language="JavaScript">
		
		<%' Added By SonalD on 22nd Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 22nd Jan 2009 %>
		
		<% 
    'Added by Shrikant , WAF3_PB_64
    If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        Response.Write("var blnShowNavigationAlert = true;")
        Response.Write("window.onbeforeunload = confirmExit;")
        Response.Write("var strContainerDivs = 'DivList';")
        Response.Write("blnNavigate = null;")
    End If
    'End Addition by Shrikant, WAF3_PB_64
%>
<!--
				
		function edit_onclick()
		{
			window.open("Help.aspx?<%=Request.QueryString%>&Mode=Edit","","resizable=yes,scrollbars=no,toolbar=no,left=100,top=100,height=300,width=500");
		}
		function save_onclick()
		{
				document.forms[0].action = "Help.aspx?<%=Request.QueryString%>&Action=Save" // Modified by puneet m on 23-12-2015
				blnNavigate = false;    //Added By Shrikant WAF3_PB_64	
				frmHelp.submit()
		}
		
		</SCRIPT></body>
</HTML>

