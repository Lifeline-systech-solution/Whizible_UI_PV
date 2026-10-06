<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TestCase_History.aspx.vb" Inherits="PbNIT.TestCase_History"%>
<!DOCTYPE HTML>
<html>
  <% CommonFunctions.General.PlotPageHeadTag("Test Case History") %>
  <body MS_POSITIONING="GridLayout">

    <form id="frmTestCaseHistory" method="post" runat="server">
							<%PageInit%>
    </form>
   <script language ="javascript">
		function Close_Click()
		{
			window.close(); 
		}
   </script>
  </body>
</html>
