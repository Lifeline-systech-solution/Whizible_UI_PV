<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Introduction.aspx.vb" Inherits="Whiz.Introduction" %>
<!DOCTYPE html>
<HTML>
	<% MyBase.InitializeResources("Resources.Introduction", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>

	<head>
	<meta charset="UTF-8">


	</head>
	<body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize()" onload="window_onload()" >
		<form id="frmIntroduction" method="post" runat="server">
		<div id=Introduction style="height:540px;overflow:auto;">
			<%GetModuleIntroduction()%>
		</div>
		</form>
		<script language="javascript">
			var objdivlist;
			objdivlist=GetObjectReference('frmIntroduction','Introduction');
		function window_onresize()		
			{
				var intDivHeight;
				var intDivHeightRisk;
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 35;
				if (intDivHeight < 100)
				intDivHeight = 100;				
				objdivlist.style.height = intDivHeight;
			}			
			function window_onload()
			{
				var intDivHeight ;
				var intDivHeightRisk;
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 35;
				if (intDivHeight < 100)
					intDivHeight = 100;
				objdivlist.style.height = intDivHeight;	
		}
		</script>
	</body>
</HTML>
