<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ActiveUserSessionMaintenance.aspx.vb" Inherits="Whiz.ActiveUserSessionMaintenance" %>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body class="clsBody" onresize="window_onload(<%=m_intDivFillFactor%>)" onload="window_onresize(<%=m_intDivFillFactor%>)" MS_POSITIONING="GridLayout">
		<form id="frmActiveUserSessionMaintenance" name="frmActiveUserSessionMaintenance" method="post" runat="server">
			<%WritePage()%>
		</form>
		<script type="text/javascript" language="JavaScript">
			var g_objfrm=GetFormReference('frmActiveUserSessionMaintenance');
			var g_strURL="../General/ActiveUserSessionMaintenance.aspx";			
            objdivlist = GetObjectReference('frmActiveUserSessionMaintenance','DivList');
			function Delete_Click()
			{
				var strURL = g_strURL;
				var blnIsRecordSelected=false;
				blnIsRecordSelected=IsCheckboxSelected('frmActiveUserSessionMaintenance','chkDelete');
				if (blnIsRecordSelected == false) {return;}
				if(confirm("<%=m_strDeleteContirmation%>"))
				g_objfrm.action = strURL + "?Action=DELETE";
				g_objfrm.submit();
			}
			function SelectAll_Click(){ SelectAll_OnClick('frmActiveUserSessionMaintenance','chkDelete');}
			function ClearAll_Click(){ ClearAll_OnClick('frmActiveUserSessionMaintenance','chkDelete');}
			function Help_Click(){ Help_OnClick()('ActiveUserSessionMaintenance');}
		</script>
	</body>
</html>