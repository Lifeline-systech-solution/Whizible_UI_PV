<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_ExtendedCustomFields.aspx.vb" Inherits="PbNIT.IB_ExtendedCustomFields" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%WritePageHead%>
	<%CommonFunctions.General.PlotPageHeadTag("")%>
   
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmIssueExtendedCustomFields" method="post" runat="server">				
						<%BuildPage%>								
					</form>
				
	<script language="javascript">
		
	var objForm, objdivlist;
	
	objForm = GetFormReference('frmIssueExtendedCustomFields');
	objdivlist = GetObjectReference('frmIssueExtendedCustomFields','divList');
	
	<%=declarevariables%>
	
	function window_onload()
	{
		var intDivHeight ;
		
		if (intDivHeight < 100)	intDivHeight = 100;

			if(navigator.appName == 'Netscape')
			{
				intDivHeight = window.innerHeight - objdivlist.offsetTop - 40;			
			}
			else
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		
		objdivlist.style.height = intDivHeight +'px';	
	}
	
	function window_onresize()		
	{
			var intDivHeight;

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
		if (intDivHeight < 100)	intDivHeight = 100;
		objdivlist.style.height = intDivHeight + 'px';		
	}
	
	function Close_OnClick()
	{
		window.close();
	}
	
	function Save_OnClick()
	{			
		if(ValidateControls() == false) return;
				
	    EnableControls();	   
	    
        objForm.action = "IB_ExtendedCustomFields.aspx?Action=Save&IssueID=<%=m_lngIssueID%>&ProjectID=<%=m_ProjectId%>&PkToken=<%=m_strToken%>";
	    objForm.submit();	
	}
	
	function ValidateControls()
	{		
		<%If strClientSideScript <> "" then %>
		<%=strClientSideScript%>
		<%End If%>
	}
	
	function EnableControls()
	{
		<%If strEnableControlsScript <>"" then%>
		<%=strEnableControlsScript%>
		<%End If%>
	}
	
		</script>				
	</body>
</HTML>
