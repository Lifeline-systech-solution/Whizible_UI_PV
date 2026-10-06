<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_PlannedCost.aspx.vb" Inherits="PbNIT.PM_PlannedCost"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
		<%CommonFunctions.General.PlotPageHeadTag("Project DOH")%>
		
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1">
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">

		
		<script LANGUAGE="javascript">
		<!--
		function CalculateCostToCompany()
		{
			var intCTC;
			var intTotal;
			
			intTotal = 0 ;
			
			for (intCTC = 1 ;intCTC < frmWorkOrderCosts.txtCostToCompany.length; intCTC +=1 )
			{
			
				if (frmWorkOrderCosts.txtCostToCompany(intCTC - 1).value != "" )
				{
					intTotal += parseFloat(frmWorkOrderCosts.txtCostToCompany(intCTC - 1).value);
				}
			}
			frmWorkOrderCosts.txtTotalCostToCompany.value = intTotal ;
		}
		
		function CalculateReimersable()
		{
			var intReimersable;
			var intTotal;
			
			intTotal = 0 ;
			
			for (intReimersable = 1 ;intReimersable < frmWorkOrderCosts.txtReimbursable.length; intReimersable +=1 )
			{
				if (frmWorkOrderCosts.txtReimbursable(intReimersable - 1).value != "" )
				{
					intTotal += parseFloat(frmWorkOrderCosts.txtReimbursable(intReimersable - 1).value);
				}
			}
			frmWorkOrderCosts.txtTotalReimbursable.value = intTotal ;
		
		}
		
		function OnlyNumeric(intAllowDecimal)
		{
		var KeyAscii = window.event.keyCode;

		if (intAllowDecimal==1 && KeyAscii == 46)
		{
		return;
		}

		else
		{
		if ( KeyAscii < 48 || KeyAscii > 57 ) 
			{ window.event.keyCode = 0; } 
		}	
		}
		//-->
		</script>
	</HEAD>
	
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
		<form id="frmWorkOrderCosts" name="frmWorkOrderCosts" method="post" runat="server">
			<DIV id='divList' style='overflow:auto;height:350px'>
				<%PageInit()%>
			</DIV>
		</form>
		
		<Script language=javascript>
			var objdivlist;
			objdivlist=GetObjectReference('frmWorkOrderCosts','divList');
			
			function window_onload()
			{
				var intDivHeight ;
				
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
			function Save_OnClick(){
				if(frmWorkOrderCosts.txtProjectLCV.value != "")
				{
					if(parseFloat(frmWorkOrderCosts.txtProjectLCV.value) < parseFloat(frmWorkOrderCosts.txtTotalCostToCompany.value))
					{
						alert("Total of Project DOH exceeds Project Value !");
						return;
					}
				}
				frmWorkOrderCosts.action="PM_PlannedCost.aspx?Mode=UPDATE";
				document.frmWorkOrderCosts.submit();
				}
		</Script>
	</body>
</HTML>
