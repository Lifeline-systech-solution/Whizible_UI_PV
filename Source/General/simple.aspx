<%@ Page Language="C#" Trace="false" TraceMode="SortByCategory" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>
<script runat="server">
protected void Page_Load(Object Src, EventArgs E) {
}
void Output_OnClick(Object sender, EventArgs e) {
	HtmlOutput.Text = "<hr><font face=arial size=4>Output:</font><br>" + FreeTextBox1.Text + "<hr>";
}
</script>
<html>
	<head>
		<title>FreeTextBox</title>
	</head>
	<body>
		<form id="Form1" runat="server">		
			<FTB:FreeTextBox id="FreeTextBox1" runat="server" />
			<br>
			<asp:button id="Output" onclick="Output_OnClick" Text="View HTML Output" runat="server" />
			<br>
			<asp:literal id="HtmlOutput" runat="server" />
		</form>
	</body>
</html>