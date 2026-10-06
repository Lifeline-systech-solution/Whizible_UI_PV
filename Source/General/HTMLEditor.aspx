<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="HTMLEditor.aspx.vb" Inherits="Whiz.HTMLEditor" %>
<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.HTMLEditor", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	<BODY class="clsBody" onload="window_onload()">
		<form id="frmHTMLEditor" method="post" runat="server">
			<%=m_strmenu%>
			<FTB:FREETEXTBOX id="FreeTextBox" runat="server" ToolbarType="OfficeXP" ImageGalleryPath="images"
				Width="700px" Height="475px" StartMode="DesignMode" ButtonPath="../../images/ftb/OfficeXp/"></FTB:FREETEXTBOX><input id="txtHTML" type="hidden" name="txtHTML" runat="server">
			<TEXTAREA id="txtHidden" style="DISPLAY: none; Z-INDEX: 102; LEFT: 241px; POSITION: absolute; TOP: 335px"
				name="txtHidden" rows="2" cols="20" runat="server"></TEXTAREA>
		</form>
		<asp:literal id="Literal1" runat="server"></asp:literal>
		<%PageLoad()%>
		<script language="javascript">
<% 
    'Added by Ninad, WAF3_PB_64
    If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
        Response.Write("var blnShowNavigationAlert = true;")
        Response.Write("window.onbeforeunload = confirmExit;")
        Response.Write("var strContainerDivs = 'frmHTMLEditor';")
        Response.Write("blnNavigate = null;")
    End If
    'End Addition by Ninad, WAF3_PB_64
%>
		FreeTextBox_editor.document.body.focus();
		function Apply_OnClick()
		{//debugger;
		    //Modified By Ninad on 16 Jan 2008 IssueID-26590
		    var objHidden=document.getElementById('txtHidden');
		    objHidden.value=document.getElementById('FreeTextBox').value;
	   		if(disallowMaxlengthViolation(objHidden, <%=m_strMaxLength%>, "<%=m_strValidationMsg%>", true))
	   		{
	   		    FreeTextBox_editor.document.body.focus();
	    		return false;   
	    	}	
	        //End Modification By Ninad on 16 Jan 2008 IssueID-26590, Look for objHidden 		
    	    blnNavigate = false;    //Added By Ninad WAF3_PB_64
			//Modified By - Ninad : Req ID - WAF3_PB_55 : Dt 26 Nov 2007
			if('<%=m_strRowIndex%>'=='[0]')
			{
			    window.opener.document.getElementById('<%=m_strControlName%>').value =objHidden.value;//Modified By Ninad on 1 Sept 2009 IssueID-32775,32815
			    if(window.opener.document.getElementById('div<%=m_strControlName%>') !=null)
				    window.opener.document.getElementById('div<%=m_strControlName%>').innerHTML =objHidden.value;
			}
			else	    
			{
			    window.opener.document.getElementsByName('<%=m_strControlName%>')<%=m_strRowIndex%>.value =objHidden.value;
			    if(window.opener.document.getElementsByName('div<%=m_strControlName%>')<%=m_strRowIndex%> !=null)
				    window.opener.document.getElementsByName('div<%=m_strControlName%>')<%=m_strRowIndex%>.innerHTML =objHidden.value;
			}
			//End Modification By - Ninad : Req ID - WAF3_PB_55 : Dt 26 Nov 2007
			window.close();
		}
		function SelectAll_OnClick()
		{
			FreeTextBox_editor.document.execCommand("selectAll");
		}
		function Clear_OnClick()
		{
			document.getElementById('FreeTextBox').value='';
			FreeTextBox_editor.document.body.innerHTML='';
			FreeTextBox_editor.document.body.focus();
		}
		</script>
	</BODY>
</HTML>
