<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_DynamicDataGridProperties.aspx.vb" Inherits="Whiz.CRW_DynamicDataGridProperties" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    	<body class="clsBody" onload="window_onload(<%=m_intDivFillFactor %>)" onresize="window_onresize(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form id="frmDynamicDataGrid" name="frmDynamicDataGrid" method="post" runat="server">
			<%PageInit%>
		</form>
		<SCRIPT language="javascript">
			var objdivlist;
			var m_objfrm;
			var m_objMode;
			var m_objSection;
			var m_objReportID;
			var m_objSPorDDG;

						
			objdivlist = GetObjectReference('frmDynamicDataGrid','DivDynamicDataGridPropertyPage');
			m_objfrm = GetFormReference('frmDynamicDataGrid');
			m_objMode = GetObjectReference('frmDynamicDataGrid','hdMode');
			m_objSection = GetObjectReference('frmDynamicDataGrid','hdSection');
			m_objReportID = GetObjectReference('frmDynamicDataGrid','hdReportID');
			m_objSPorDDG = GetObjectReference('frmDynamicDataGrid', 'hdSPorDDG');
			
			'<%MyBase.InitializeResources("Resources.CRW_ReportDesigner", "Resources")%>';
			
			function window_onload()
			{
        	var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 12, 2007 NinadP 
		    windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>

				if('<%=m_blnIsError%>'=='True')
				{
					displayMessage('<%=m_strErrorNo%>');
				}
			}

		<% 'WAF3_PB_42 April 13, 2007 START
	'Removed local functions for window onresize 
	'WAF3_PB_42 April 13, 2007 END%>

			function frmSubmitSP_OnChange()
            {
				var objControlID;
				var objAvailableUSPs;
				var objDyanmicDataGridName;
				
				objAvailableUSPs = GetObjectReference('frmDynamicDataGrid','cboAvailableUSPs');
				m_objSPorDDG.value = 0;
				objControlID = GetObjectReference('frmDynamicDataGrid','hdSPID');
				objControlID.value = objAvailableUSPs(objAvailableUSPs.selectedIndex).value;
				if(objControlID.value==0)
				{
					objDyanmicDataGridName = GetObjectReference('frmDynamicDataGrid','txtDynamicDataGridName');
					objDyanmicDataGridName.value="";				
					m_objfrm.action = "CRW_DynamicDataGridProperties.aspx?MODE=<%=ADD%>&ReportID=" + m_objReportID.value + "&Section=" + m_objSection.value + "&MasterTagID=<%=m_strMasterTagID%>"; 
				}
				else
					m_objfrm.action = "CRW_DynamicDataGridProperties.aspx?ControlID=" + objControlID.value + "&Mode=" + m_objMode.value + "&Section=" + m_objSection.value + "&ReportID=" + m_objReportID.value + "&SPorDDG=" + m_objSPorDDG.value + "&MasterTagID=<%=m_strMasterTagID%>"; 
				m_objfrm.submit();
			}
				function frmSubmitDDG_OnChange()
            {				
				var objControlID;
				var objAvailableDDGs;				
				var objDyanmicDataGridName;
				
				objAvailableDDGs = GetObjectReference('frmDynamicDataGrid','cboAvailableDDGs');
								
								
				m_objSPorDDG.value = 1;
				objControlID = GetObjectReference('frmDynamicDataGrid','hdDynamicDataGridID');
				objControlID.value = objAvailableDDGs(objAvailableDDGs.selectedIndex).value;
				if(objControlID.value==0)
				{
					objDyanmicDataGridName = GetObjectReference('frmDynamicDataGrid','txtDynamicDataGridName');
					objDyanmicDataGridName.value="";
					m_objfrm.action = "CRW_DynamicDataGridProperties.aspx?MODE=<%=ADD%>&ReportID=" + m_objReportID.value + "&Section=" + m_objSection.value + "&MasterTagID=<%=m_strMasterTagID%>"; 
				}
				else
					m_objfrm.action = "CRW_DynamicDataGridProperties.aspx?ControlID=" + objControlID.value + "&Mode=<%=EDIT%>&Section=" + m_objSection.value + "&ReportID=" + m_objReportID.value + "&SPorDDG=" + m_objSPorDDG.value + "&MasterTagID=<%=m_strMasterTagID%>";
				m_objfrm.submit();
			}
				function IsDataValid()
			{
				var obj;
				var objRowCount;
				var intCount = 0;
				var flag;
				var strControlName;
				var strDynamicDataGridNames;
				var strSearch = new String();
				var objDynamicDataGridName;
				var objFontSize;
				var objGridType;
				
				'<%MyBase.InitializeResources("Resources.CRW_ControlProperties", "Resources")%>'
				
				obj = GetObjectReference('frmDynamicDataGrid','cboAvailableDDGs');
				if(obj!=null)
					if(obj(obj.selectedIndex).value==0)
					{
						obj = GetObjectReference('frmDynamicDataGrid','cboAvailableUSPs');
						if(obj!=null)
							if(obj(obj.selectedIndex).value==0)
							{
								alert('<%=MyBase.GetResourceString("CTRL_DYNAMICDATAGRID_SELECTFROMCOMBO")%>');
								return false;
							}
					}
			
				obj = GetObjectReference('frmDynamicDataGrid','txtDynamicDataGridName');
				flag=disallowBlank(obj,'<%=MyBase.GetResourceString("CTRL_DYNAMICDATAGRID_NAME_BLANK")%>',true);
				if(flag==true)
					return false;
					
				strDynamicDataGridNames = '<%=m_strDynamicDataGridList%>';
				strSearch = obj.value;
				strSearch = strSearch.toUpperCase() + ",";
				if (strDynamicDataGridNames.search(strSearch)>-1)
				{	
					alert('<%=MyBase.GetResourceString("CTRL_DYNAMICDATAGRID_DUPLICATION")%>');
					objDynamicDataGridName = GetObjectReference('frmDynamicDataGrid','txtDynamicDataGridName');
					objDynamicDataGridName.focus();
					return false;
				}				
				<% 'Added by VinayB on 8-APR-2009 IssueID29971%>						
				obj = GetObjectReference('frmDynamicDataGrid','cboAvailableUSPs');
						if(obj!=null)
							if(obj(obj.selectedIndex).value==0)
							{
								alert('<%=MyBase.GetResourceString("CTRL_REPORT_VALIDATION_SELECTSP")%>');
								return false;
							}
				obj = GetObjectReference('frmDynamicDataGrid','txtRow');
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

				obj = GetObjectReference('frmDynamicDataGrid','txtLeftPosition');
				flag=disallowBlank(obj,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_BLANK")%>',true);
				if(flag==true)
					return false;
				flag=disallowNonNumeric(obj,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_NUMERIC")%>',true)
				if(flag==true)
					return false;
				flag=disallowNegativeNumeric(obj,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_NEGATIVE")%>',true);
				if(flag==true) 
					return false;				
				
				objRowCount = GetObjectReference('frmDynamicDataGrid','txtRowCount');
				if (objRowCount != null)
					if (objRowCount.value != 0)
						for (intCount = 1; intCount<=objRowCount.value; intCount++)
						{
							strControlName = 'cboReportFieldsParams' + intCount;
							obj = GetObjectReference('frmDynamicDataGrid', strControlName);
							if(obj.value == 0)
							{
								alert('<%=MyBase.GetResourceString("CTRL_DYNAMICDATAGRID_MANDATE_PARAMETERMAPPING")%>');
								return false;
							}
						}
				objFontSize = GetObjectReference('frmDynamicDataGrid','cboFontSize');
				if(objFontSize != null)
				{
					if(objFontSize(objFontSize.selectedIndex).value > 10)
					{
						objGridType = GetObjectReference('frmDynamicDataGrid','cboGridType');
						if(objGridType != null)
						{
							if(objGridType(objGridType.selectedIndex).value >0)
							{
								alert('<%=MyBase.GetResourceString("CTRL_DYNAMICDATAGRID_GRIDTYPE_FOR_FONTSIZE")%>');
								objGridType.focus();
								return false;					
							}
						}
					}
				}				
				'<%MyBase.InitializeResources("Resources.CRW_ReportDesigner", "Resources")%>';
				
				return true;
			}					
				function Save_OnClick()
			{
				var objControlID;
				var objAvailableDDGs;				
				
				objAvailableDDGs = GetObjectReference('frmDynamicDataGrid','cboAvailableDDGs');
				
				if (m_objSPorDDG.value == 0)
				{
					objControlID = GetObjectReference('frmDynamicDataGrid','hdSPID');
				}
				else
				{
					objControlID = GetObjectReference('frmDynamicDataGrid','hdDynamicDataGridID');
				}
				
				if(IsDataValid()==true)
				{
					m_objfrm.action = "CRW_DynamicDataGridProperties.aspx?ControlID=" + objControlID.value + "&Mode=" + m_objMode.value + "&Action=<%=ACTION_SAVE%>" + "&Section=" + m_objSection.value + "&ReportID=" + m_objReportID.value + "&SPorDDG=" + m_objSPorDDG.value + "&MasterTagID=<%=m_strMasterTagID%>";
					m_objfrm.submit();
				}			
			}
			function Delete_OnClick()
			{
				var ans;
				var objControlID;
				
				objControlID = GetObjectReference('frmDynamicDataGrid','hdDynamicDataGridID');
				'<%MyBase.InitializeResources("Resources.CRW_ControlProperties", "Resources")%>';
				ans=window.confirm('<%=MyBase.GetResourceString("CTRL_DELETE_VALIDATION")%>');
				if(ans==true)
				{
					m_objMode.value='<%=DELETE%>';
					m_objfrm.action = "CRW_DynamicDataGridProperties.aspx?ControlID=" + objControlID.value + "&Mode=" + m_objMode.value + "&ReportID=" + m_objReportID.value + "&MasterTagID=<%=m_strMasterTagID%>";
					m_objfrm.submit();	
				}					
			}
			function Hide_OnClick()
			{
				var objControlID;
				
				objControlID = GetObjectReference('frmDynamicDataGrid','hdDynamicDataGridID');
				m_objMode.value='<%=HIDE%>';
				m_objfrm.action = "CRW_DynamicDataGridProperties.aspx?ControlID=" + objControlID.value + "&Mode=" + m_objMode.value + "&ReportID=" + m_objReportID.value + "&MasterTagID=<%=m_strMasterTagID%>";
				m_objfrm.submit();	
			}
			function displayMessage(msgNo)
			{					
				if(msgNo=='1')
				{
					alert('<%=MyBase.GetResourceString("CTRL_SUBREPORT_VALIDATION_PARAMETERS")%>');
				}
			}	
			
			function ExtendedProperties_OnClick()
            {				
				var objControlID;
				var strUrl;

				objControlID = GetObjectReference('frmDynamicDataGrid','hdDynamicDataGridID');
				if (objControlID != null)
				{
					if(objControlID.value!=0)
					{
						strUrl = "CRW_DynamicDataGrid_ExtendedProperties.aspx?MasterTagID=545&ControlID=" + objControlID.value + "&ReportID=" + m_objReportID.value;
						window.open(strUrl,"","left=" + (window.screen.width-450)/2 + ",top=" + (window.screen.height-200)/2 + ",height=235,width=450,resizable=no,scrollbar=no");
					}
				}
			}
		</SCRIPT>
	</body>
</HTML>
