<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_AssignedResources.aspx.vb" Inherits="PbNIT.PM_AssignedResources"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<%CommonFunctions.General.PlotPageHeadTag("PM_AssignedResources")%>
	

  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmPM_AssignedResources"  method="post" runat="server">
			<%PageInit%>
    </form>
	<Script language="javascript">
		var objform=GetFormReference('frmPM_AssignedResources');
		var objdivlist=GetObjectReference('frmPM_AssignedResources','PageDiv');
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;	}			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;	}
		}	
	</Script>
  </body>
</html>
