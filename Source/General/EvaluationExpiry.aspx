<%@ Page Language="vb" AutoEventWireup="false" Codebehind="EvaluationExpiry.aspx.vb" Inherits="PbNIT.EvaluationExpiry" %>
<!DOCTYPE HTML>
<html>
 	<%CommonFunctions.General.PlotPageHeadTag("EvaluationExpiry")%>
  <body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
    <form id="frmEvaluationExpiry"  method="post" runat="server">
			<%PageInit%>
    </form>
	<Script language="javascript">
		var objform=GetFormReference('frmEvaluationExpiry');
		var objdivlist=GetObjectReference('frmEvaluationExpiry','PageDiv');
		
		<%' Added By SonalD on 22nd Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 22nd Jan 2009 %>
		
		function Save_OnClick()
		{
			objform.action = "EvaluationExpiry.aspx?MODE=SAVE";
			objform.submit()
		}
		
		//The div tag has id as PageDiv 
		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	}
		}	
	</Script>
  </body>
</html>
