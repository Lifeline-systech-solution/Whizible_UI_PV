<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CDB_CT_Graph.aspx.vb" Inherits="Whiz.CDB_CT_Graph" %>
<!DOCTYPE HTML>
<html>

<%  CommonFunctions.General.PlotPageHeadTag(m_strTitle, , , , "<script language=javascript src='../QRB/QueryBuilder.js'></script>")%>
<body class="clsBody" MS_POSITIONING="GridLayout" onresize="window_onresize(<%=m_intDivFillFactor%>)" onload="window_onload(<%=m_intDivFillFactor%>)"> 
<form id="frmCDBCTGraph" method="post" runat="server">
<% WriteMenu()%>
<br />
<div id="divList" style="overflow:auto;width:100%;height:500">
	<table class="clsTable" id="tblGraph" width='100%' runat="server"></table>
</div>
</form>

<script language="javascript">
    var objfrm=GetFormReference('frmCDBCTGraph');
	var objdivlist = GetObjectReference('frmCDBCTGraph','divList');
</script>

</body>
</html>
