<%@ Page EnableViewState="false" Language="vb" AutoEventWireup="false" Codebehind="CRW_TemplatePreview.aspx.vb" Inherits="Whiz.CRW_TemplatePreview" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<BODY class="clsBody" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frmTemplatePreview" method="post" runat="server">
				<%GenerateTemplatePreview%>
		</form>
			<script language="javascript">
				var objdivlist;
		
				var objfrm;
				objfrm=	GetFormReference('frmTemplatePreview')
				objdivlist=GetObjectReference('frmTemplatePreview','divBody')
                <% 'WAF3_PB_42 April 10, 2007 removed window_onload and window_onresize functions  %>
			</script>
		
	</BODY>
</HTML>
