<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_GraphControl.aspx.vb" Inherits="Whiz.CRW_GraphControl"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body class="clsBody" onload="window_onload(<%=m_intDivFillFactor %>)" onresize="window_onresize(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmCRW_GraphControl" method="post" runat="server">
			<%PageInit%>
		</form>
		<Script language="javascript">
		var objform=GetFormReference('frmCRW_GraphControl');
		var objdivlist=GetObjectReference('frmCRW_GraphControl','PageDiv');
		//The div tag has id as PageDiv 
		<% 'WAF3_PB_42 April 13, 2007 START
	'Removed local functions for window onresize and onload
	'WAF3_PB_42 April 13, 2007 END%>

		
		var objCbo=GetObjectReference('frmCRW_GraphControl','ControlList');
		if(objCbo!=null){ objCbo.focus(); }
		else
		{			
			objCbo=GetObjectReference('frmCRW_GraphControl','GraphSQL');
			if(objCbo!=null){ objCbo.focus(); }
		}
			
		//script to display msg for overlapping and post back page if confirmed
		if('<%=m_blnIsOverlapping%>'=='True')
		{
			if(window.confirm('<%=MyBase.GetResourceString("CTRL_OVERLAP_VALIDATION")%>'))
			{
				objform.action="CRW_GraphControl.aspx?Overlap=Yes&Mode=<%=m_strMode%>&Action=<%=ACTION_SAVE%>&MasterTagID=<%=m_strMasterTagID%>";
				objform.submit();
			}
		}	
		
		//script to display msg for datatype mismatch of parameter and field mapped
		if('<%=m_blnParameterMappingOK%>'=='False')
		{	
			window.alert('<%=MyBase.GetResourceString("CTRL_GRAPH_VALIDATION_DATATYPEMISMATCH")%>');
			var objCbo=GetObjectReference('frmCRW_GraphControl','FieldName' + '<%=m_intParam%>');
			if(objCbo!=null) objCbo.focus();			
		}
		
		function GraphSQL_OnChange(objCbo)
		{
			objform.action='CRW_GraphControl.aspx?MasterTagID=<%=m_strMasterTagID%>&Mode=<%=m_strMode%>&SQLChange=Yes';
			objform.submit();
		}
		
		function Control_OnChange(objCbo)
		{
			var objTxt=GetObjectReference('frmCRW_ReportControl','ControlID');
			objTxt.value=objCbo.value;
			
			if(objCbo.value!='' && objCbo.value!='0')
			{
				objform.action="CRW_GraphControl.aspx?Mode=<%=MODE_ADDEDIT%>&MasterTagID=<%=m_strMasterTagID%>";
				objform.submit();
			}
			else
			{
				objform.action="CRW_GraphControl.aspx?Mode=<%=MODE_ADD%>&MasterTagID=<%=m_strMasterTagID%>";
				objform.submit();
			}
		}
		
		function Save_OnClick()
		{
			if(ValidateControls()==true)
			{
				objform.action="CRW_GraphControl.aspx?Mode=<%=m_strMode%>&Action=<%=ACTION_SAVE%>&MasterTagID=<%=m_strMasterTagID%>";
				objform.submit();
			}
		}
		
		function Hide_OnClick()
		{
			objform.action="CRW_GraphControl.aspx?Mode=<%=m_strMode%>&Action=<%=ACTION_HIDE%>&MasterTagID=<%=m_strMasterTagID%>";
			objform.submit();
		}
		function Delete_OnClick()
		{
			if(window.confirm('<%=MyBase.GetResourceString("CTRL_DELETE_VALIDATION")%>'))
			{ 
				objform.action="CRW_GraphControl.aspx?Mode=<%=m_strMode%>&Action=<%=ACTION_DELETE%>&MasterTagID=<%=m_strMasterTagID%>";
				objform.submit();
			}
		}
	</Script>
	</body>
</HTML>
