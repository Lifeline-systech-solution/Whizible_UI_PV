<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PRO_ProjectType_TaskTypes.aspx.vb" Inherits="Whiz.PRO_ProjectType_TaskTypes" %>
<!DOCTYPE HTML>
<html>
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<%CommonFunctions.General.PlotPageHeadTag("Project Type Task Types")%>
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id='frmProjectTypeTaskTypes' method='post' runat='server'>
		<%WritePage()%>
		</form>
		
		<script language="javascript">
		var objform;
		var objdivlist;
				
		objform = GetFormReference('frmProjectTypeTaskTypes');
		objdivlist = GetObjectReference('frmProjectTypeTaskTypes','divList');
		
		
		function Save_OnClick(ProjectTypeID)
		{
			objform.action = "PRO_ProjectType_TaskTypes.aspx?Action=SAVE&TypeID=" + ProjectTypeID;
			objform.submit(); 
		}
		
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
				
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;	
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
						
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;		
		}
		</script>
	</body>
</HTML>

