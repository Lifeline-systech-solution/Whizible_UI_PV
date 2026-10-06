<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ErrorPage.aspx.vb" Inherits="Whiz.ErrorPage" %>

<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.ErrorPage", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	
	<body class="clsBody" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
		<%WriteError()%>
			</form>
	</body>
</HTML>

