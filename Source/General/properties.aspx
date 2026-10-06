<%@ Page Language="C#" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>
<%@ Register TagPrefix="Prop" namespace="PropEdControls" Assembly="PropEdControls" %>

<script runat="server">

protected void Page_Load(Object Src, EventArgs E) {
	FreeTextBox1.Text = "<p><b><font face=\"arial\" size=3><font color=\"green\">Free</font>TextBox</font></b></p><p>type here...</p>";
	
	
   Button1.Click += new System.EventHandler(Submit_Click);
   if (!this.IsPostBack) {
      PropertiesEditor1.DataBind();
   }
	
}
protected void Submit_Click(object sender, System.EventArgs e) {
   PropertiesEditor1.UpdateInstance();
}  
</script>
<html>
	<head>
		<title>FreeTextBox</title>
	</head>
	<body>
		<form id="Form1" runat="server">
			<FTB:FreeTextBox id="FreeTextBox1" ImageGalleryPath="images2" runat="server" Width="600px" Height="400px" />			
				
			<br><br>
				
			<Prop:PropertiesEditor id="PropertiesEditor1" runat="server" 
		      xControlToView=FreeTextBox1 />
			<asp:button id="Button1" runat="server" CausesValidation="False" Text="Submit" />

			<br><br>
		</form>
	</body>
</html>