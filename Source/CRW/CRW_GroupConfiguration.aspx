<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_GroupConfiguration.aspx.vb" Inherits="Whiz.CRW_GroupConfiguration" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
		<body class="clsBody" onload="window_onload(<%=m_intDivFillFactor %>)" onresize="window_onresize(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmGroupConfigure" name="frmGroupConfigure" method="post" runat="server">
			<%PageInit%>
		</form>
		<SCRIPT language="javascript">
			var objdivlist;
			var objfrm;
			objfrm=	GetFormReference('frmGroupConfigure');
			objdivlist=GetObjectReference('frmGroupConfigure','divBody');
				
			<%MyBase.InitializeResources("Resources.CRW_ReportDesigner", "Resources")%>
	function window_onload()
		{
			var intmsg;
			var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 12, 2007 NinadP 
		    windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
			
			intmsg = <%=m_intMsg%>
			if(intmsg!=0)
			{
				ShowAlert(intmsg);
			}
		}
		
		//function to display message
                
    function ShowAlert(ShowMessage)
        {
			if(ShowMessage==1)
			{
                alert('<%=MyBase.GetResourceString("GROUPCONFIG_ERR_EXCEEDAPP")%>');  
            }
            else if(ShowMessage==2)
            {
                alert('<%=MyBase.GetResourceString("GROUPCONFIG_ERR_EXCEEDTEMPLATE")%>'); 
            }
            else if(ShowMessage==3)
            {
                alert('<%=MyBase.GetResourceString("GROUPCONFIG_ERR_NOFIELD")%>'); 
                 
             }
             window.close();
        }
                        
<% 'WAF3_PB_42 April 13, 2007 START
	'Removed local functions for window onresize 
	'WAF3_PB_42 April 13, 2007 END%>
		
		function Save_OnClick(intReportID,intGroupingOrder,strMode)
		{
			var objtxt = GetObjectReference('frmGroupConfigure','txtSaveClicked');
			frmGroupConfigure.action ='CRW_GroupConfiguration.aspx?ReportID=' + intReportID +'&GroupingOrder=' + intGroupingOrder + '&Mode=' + strMode;
			frmGroupConfigure.submit(); 
		}
		/*function Close_OnClick()
		{
			window.close();
		}
		function Help_OnClick('CRW_GROUP_CONFIGURE')
		{
			alert('Help');
		}*/
		
		</SCRIPT>
	</body>
</HTML>
