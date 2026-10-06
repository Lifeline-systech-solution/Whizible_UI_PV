<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_SubreportField.aspx.vb" Inherits="Whiz.CRW_SubreportField" %>
<!DOCTYPE HTML>
<html>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body class="clsBody" MS_POSITIONING="GridLayout" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmSubreportField" name="frmSubreportField" method="post" runat="server">
			<%PageInit()%>
		</form>
	</body>
	<script language="javascript">
		var objdivlist;
		var objform;
		
		objform = GetFormReference('frmSubreportField');
		objdivlist = GetObjectReference('frmSubreportField','PageDiv');
		
		'<%MyBase.InitializeResources("Resources.CRW_ControlProperties", "Resources")%>';
		
		function window_onload()		
		{
            var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 17, 2007 NinadP 
	    	windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 17, 2007 NinadP %>
			if('<%=m_blnIsError%>'=='True')
			{
				var intMsgNo = '<%=m_strErrorNo%>';
				displayMessage(intMsgNo);
			}			
		}
		<% 'WAF3_PB_42 April 17, 2007 START
		'Removed local functions for window onresize 
		'WAF3_PB_42 April 17, 2007 END%>
		function Subreport_OnChange()
		{
			objform.action = "CRW_SubreportField.aspx?Mode=<%=m_strMode%>&MasterTagID=<%=m_strMasterTagID%>";
			objform.submit();
		}
		function Save_OnClick()
		{
			var obj;
			if(IsDataValid()==true)
			{
				objform.action = "CRW_SubreportField.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_SAVE%>&MasterTagID=<%=m_strMasterTagID%>";
				objform.submit();
			}			
		}
		function Delete_OnClick()
		{
			if(window.confirm('<%=MyBase.GetResourceString("CTRL_DELETE_VALIDATION")%>')==true)
			{
				objform.action = "CRW_SubreportField.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_DELETE%>&MasterTagID=<%=m_strMasterTagID%>";
				objform.submit();
			}	
		}
		function IsDataValid()
		{
			var obj;
			var flag;
			
			obj = GetObjectReference('frmSubreportField','cboSubreport');
			if(obj!=null)
			{	
				flag=disallowBlank(obj,'<%=MyBase.GetResourceString("CTRL_SUBREPORT_BLANK")%>',true);
				if(flag==true)
					return false;
			}	
			
			obj = GetObjectReference('frmSubreportField','txtRowNumber');
			flag=disallowBlank(obj,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_BLANK")%>',true);
			if(flag==true)
				return false;
				
			flag=disallowNonNumeric(obj,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_NUMERIC")%>',true);
			if (flag==true)
				return false;				
			flag=disallowNegativeNumeric(obj,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_NEGATIVE")%>',true);
			if(flag==true) 
				return false;				
			flag=disallowNonInteger(obj,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_NEGATIVE")%>',true);
			if(flag==true)
				return false;

			flag=disallowMinValueViolation(obj,1,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_ZERO")%>',true);
			if(flag==true)
				return false;
				
			obj = GetObjectReference('frmSubreportField','txtLeftPosition');
			flag=disallowBlank(obj,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_BLANK")%>',true);
			if(flag==true)
				return false;
			flag=disallowNonNumeric(obj,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_NUMERIC")%>',true)
			if(flag==true)
				return false;
			flag=disallowNegativeNumeric(obj,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_NEGATIVE")%>',true);
			if(flag==true) 
				return false;
			flag=disallowMinValueViolation(obj,0,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_ZERO")%>',true);
			if(flag==true)
				return false;								

			obj = GetObjectReference('frmSubreportField','txtWidth');
			flag=disallowBlank(obj,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_BLANK")%>',true);
			if(flag==true)
				return false;
			flag=disallowNonNumeric(obj,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_NUMERIC")%>',true);
			if(flag==true)
				return false;
			flag=disallowNegativeNumeric(obj,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_NEGATIVE")%>',true);
			if(flag==true)
				return false;
			flag=disallowMinValueViolation(obj,0.1,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_ZERO")%>',true);
			if(flag==true)
				return false;

			obj = GetObjectReference('frmSubreportField','cboGroupHeader');
			if(obj!=null)
			{
				flag=disallowBlank(obj,'<%=MyBase.GetResourceString("MSG_NO_GROUP_SELECTED")%>',true);
				if(flag==true)
					return false;
			}
			
			obj = GetObjectReference('frmSubreportField','lstFunctionGroup');
			if(obj!=null)
			{
				flag=disallowBlank(obj,'<%=MyBase.GetResourceString("CTRL_GROUPFOOTER_VALIDATION")%>',true);
				if(flag==true)
					return false;
			}
			
			return true;
		}		
		
		function displayMessage(msgNo)
		{
						
			if(msgNo=='1')
				alert('<%=MyBase.GetResourceString("CTRL_CONTROL_VALIDATION_PAGELIMITS")%>');
			else if(msgNo=='2')
			{
				if(window.confirm('<%=MyBase.GetResourceString("CTRL_OVERLAP_VALIDATION")%>')==true)
				{
					var obj = GetObjectReference('frmSubreportField','txtOverlapConfirm');
					obj.value="1";
					Save_OnClick();
				}
			}
			else if(msgNo=='3')
				alert('<%=MyBase.GetResourceString("MSG_NO_GROUP_SELECTED")%>');
			else if(msgNo=='4')
				alert('<%=MyBase.GetResourceString("CTRL_GROUPFOOTER_VALIDATION")%>');
			else if(msgNo=='5')
				alert('<%=MyBase.GetResourceString("CTRL_SUBREPORT_VALIDATION_PARAMETERS")%>');					
		}
		
		function Hide_OnClick()
		{
			objform.action = "CRW_SubreportField.aspx?Mode=<%=m_strMode%>&Action=<%=CONST_ACTION_HIDE%>&MasterTagID=<%=m_strMasterTagID%>";
			objform.submit();
		}
	</Script>	
</html>
