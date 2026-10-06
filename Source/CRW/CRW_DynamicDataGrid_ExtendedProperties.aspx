<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_DynamicDataGrid_ExtendedProperties.aspx.vb" Inherits="Whiz.CRW_DynamicDataGrid_ExtendedProperties"%>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body class="clsBody" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frm" name="frm" method="post" runat="server">
			<%PageInit%>
		</form>
		<SCRIPT language="javascript">

			var objdivlist; <% 'WAF3_PB_42 April 10, 2007 Change variable name from g_objdivlist to objdivlist %>
			var g_objfrm;
			var g_objMode;
			var g_strURL;
			
			objdivlist = GetObjectReference('frm','DivExtendedPropertiesPage');<% 'WAF3_PB_42 April 10, 2007 Change variable name from g_objdivlist to objdivlist %>
			g_objfrm = GetFormReference('frm');
			g_strURL = "CRW_DynamicDataGrid_ExtendedProperties.aspx?MasterTagID=545&ReportID=<%=m_lngReportID%>&ControlID=<%=m_lngControlID%>";
			
			'<%MyBase.InitializeResources("Resources.CRW_ReportDesigner", "Resources")%>';
	<% 'WAF3_PB_42 April 10, 2007 Replace window_onload and window_onresize functions  %>
			function ApplyDefaults_OnClick()
			{
				g_objfrm.action = g_strURL + "&Action=<%=ACTION_APPLY_DEFAULTS%>";
				g_objfrm.submit();
			}

			function Save_OnClick()
			{
				if(IsDataValid()==true)
				{
					g_objfrm.action = g_strURL + "&Action=<%=ACTION_SAVE%>";
					g_objfrm.submit();
				}			
			}

			
				function IsDataValid()
			{
				var objCtrl;
				objCtrl = GetObjectReference('frm','txtWidthDate');		
				if(disallowBlank(objCtrl,'\'Date Type\' should not be left blank.',true)==true)
					return false;				
				if (disallowNonNumeric(objCtrl,'Please enter only numeric data in the \'Date Type\'.',true)==true)
					return false;
				if(disallowNegativeNumeric(objCtrl,'Please enter only positive numeric value for \'Date Type\'.',true)==true) 
					return false;
					
				objCtrl = GetObjectReference('frm','txtWidthInt');
				if(disallowBlank(objCtrl,'\'Integer Type\' should not be left blank.',true)==true)
					return false;
				if (disallowNonNumeric(objCtrl,'Please enter only numeric data in the \'Integer Type\'.',true)==true)
					return false;
				if(disallowNegativeNumeric(objCtrl,'Please enter only positive value for \'Integer Type\'.',true)==true) 
					return false;


				objCtrl = GetObjectReference('frm','txtWidthDecimal');
				if(disallowBlank(objCtrl,'\'Decimal Type\' should not be left blank.',true)==true)
					return false;
				if (disallowNonNumeric(objCtrl,'Please enter only numeric data in the \'Decimal Type\'.',true)==true)
					return false;
				if(disallowNegativeNumeric(objCtrl,'Please enter only positive value for \'Decimal Type\'.',true)==true) 
					return false;


				objCtrl = GetObjectReference('frm','txtWidthString');
				if(disallowBlank(objCtrl,'\'String Type\' should not be left blank.',true)==true)
					return false;
				if (disallowNonNumeric(objCtrl,'Please enter only numeric data in the \'String Type\'.',true)==true)
					return false;
				if(disallowNegativeNumeric(objCtrl,'Please enter only positive value for \'String Type\'.',true)==true) 
					return false;


				objCtrl = GetObjectReference('frm','txtWidthLString');
				if(disallowBlank(objCtrl,'\'Long String Type\' should not be left blank.',true)==true)
					return false;
				if (disallowNonNumeric(objCtrl,'Please enter only numeric data in the \'Long String Type\'.',true)==true)
					return false;
				if(disallowNegativeNumeric(objCtrl,'Please enter only positive value for \'Long String Type\'.',true)==true) 
					return false;	

				return true;	
			}

		</SCRIPT>
	</body>
</HTML>
