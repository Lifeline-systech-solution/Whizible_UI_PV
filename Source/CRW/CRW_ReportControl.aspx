<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_ReportControl.aspx.vb" Inherits="Whiz.CRW_ReportControl"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body class="clsBody" onload="window_onload(<%=m_intDivFillFactor %>)" onresize="window_onresize(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmCRW_ReportControl" method="post" runat="server">
			<%PageInit%>
		</form>
		<SCRIPT language="javascript">
			var objform=GetFormReference('frmCRW_ReportControl');
			var objdivlist=GetObjectReference('frmCRW_ReportControl','PageDiv');
			//The div tag has id as PageDiv 
			
			<%MyBase.InitializeResources("Resources.CRW_ControlProperties", "Resources")%>
			                
	<% 'WAF3_PB_42 April 13, 2007 START
	'Removed local functions for window onresize and onload
	'WAF3_PB_42 April 13, 2007 END%>
			
			//script to display msg for overlapping and post back page if confirmed
			if('<%=m_blnIsOverlapping%>'=='True')
			{
				if(window.confirm('<%=MyBase.GetResourceString("CTRL_OVERLAP_VALIDATION")%>'))
				{
					objform.action="CRW_ReportControl.aspx?Overlap=Yes&Mode=<%=m_strMode%>&Action=<%=ACTION_SAVE%>&MasterTagID=<%=m_strMasterTagID%>";
					objform.submit();
				}
			}	
			
			//var objTbl=GetObjectReference('frmCRW_ReportControl','ControlTable');
			//window.resizeTo(objTbl.style.height,objTbl.style.width);	
			//window.moveTo((window.screen.width - objTbl.clientWidth)/2,(window.screen.height - objTbl.clientHeight)/2);
		
			function Control_OnChange(objCbo)
			{
				var objTxt=GetObjectReference('frmCRW_ReportControl','ControlID');
				objTxt.value=objCbo.value;
				
				if(objCbo.value!='')
				{
					objform.action="CRW_ReportControl.aspx?Mode=<%=MODE_ADDEDIT%>&MasterTagID=<%=m_strMasterTagID%>";
					objform.submit();
				}
				else
				{
					objform.action="CRW_ReportControl.aspx?Mode=<%=MODE_ADD%>&MasterTagID=<%=m_strMasterTagID%>";
					objform.submit();
				}
			}
			
			function Save_OnClick()
			{
				if(ValidateControls()==true)
				{
					objform.action="CRW_ReportControl.aspx?Mode=<%=m_strMode%>&Action=<%=ACTION_SAVE%>&MasterTagID=<%=m_strMasterTagID%>";
					objform.submit();
				}
			}
			function Hide_OnClick()
			{
				objform.action="CRW_ReportControl.aspx?Mode=<%=m_strMode%>&Action=<%=ACTION_HIDE%>&MasterTagID=<%=m_strMasterTagID%>";
				objform.submit();
			}
			function Delete_OnClick()
			{
				if(window.confirm('<%=MyBase.GetResourceString("CTRL_DELETE_VALIDATION")%>'))
				{ 
					objform.action="CRW_ReportControl.aspx?Mode=<%=m_strMode%>&Action=<%=ACTION_DELETE%>&MasterTagID=<%=m_strMasterTagID%>";
					objform.submit();
				}
			}
	
		</SCRIPT>
	</body>
</HTML>
