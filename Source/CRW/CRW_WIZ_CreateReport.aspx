<%@ Page EnableViewState="false" Language="vb" AutoEventWireup="false" Codebehind="CRW_WIZ_CreateReport.aspx.vb" Inherits="Whiz.CRW_WIZ_CreateReport" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<BODY class="clsBody" onresize="window_onresize(<%=m_intDivFillFactor %>)" onload="window_onload(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 06, 2007 UmeshJ %>
		<form id="frmCreateReport" name="frmCreateReport" method="post" runat="server">
			<%GenerateCreateReportUI%>
		</form>
			<script language="javascript"> 
		function SubmitForm(strAction) 
		{ 
			var objform; 
			objform = GetFormReference('frmCreateReport'); 
			objform.action = strAction; 
			objform.submit();
		}
		
		function StepInAdd_OnClick(strSubmitToPage,intTemplateID,intReportType, intLayout,strMode,strLinkName,intShowGroupLink) 
		{ 
			var blnIsblank; 
			var objText=GetObjectReference('frmCreateReport','txtReportTitle'); 
			blnIsblank= disallowBlank(objText,'Report Title cannot be Blank'); 
			if (blnIsblank==false) 
			{ 
				var objText=GetObjectReference('frmCreateReport','txtSPName'); 
				blnIsblank=disallowBlank(objText,'Datasource cannot be Blank'); 
				if(blnIsblank==false) 
				{ 
					var strAction=strSubmitToPage + "?MasterTagID=<%=m_strMasterTagID%>&TemplateID=" + intTemplateID + "&ReportType=" + intReportType + "&Layout=" + intLayout + "&Mode=" + strMode + "&LinkName=" + strLinkName + "&ShowGroupLink="+intShowGroupLink ; 
					SubmitForm(strAction); 
				}
			}
		} 
		
		function StepInEdit_OnClick(lngReportId, strSubmitToPage,intLayout,strMode,strLinkName,intShowGroupLink) 
		{ 
			var strAction=strSubmitToPage + "?MasterTagID=<%=m_strMasterTagID%>&ReportID=" + lngReportId + "&Layout=" + intLayout + "&Mode=" + strMode + "&LinkName=" + strLinkName + "&ShowGroupLink="+ intShowGroupLink; 
			SubmitForm(strAction); 
		} 
		
		function Next_OnClick(intReportID,intTemplateID,intReportType,intReportLayout,strMode,strLinkName, intShowGroupLink) 
		{ 
			var blnIsblank; 
			var objText=GetObjectReference('frmCreateReport','txtReportTitle'); 
			blnIsblank= disallowBlank(objText,'Report Title cannot be Blank'); 
			if (blnIsblank==false) 
			{ 
				var objText=GetObjectReference('frmCreateReport','txtSPName'); 
				blnIsblank=disallowBlank(objText,'Datasource cannot be Blank'); 
				if(blnIsblank==false) 
				{ 
					var strAction="CRW_WIZ_CreateReport.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&QueryID=<%=m_lngQueryID%>&ReportID=" + intReportID  +"&TemplateID="+ intTemplateID + "&ReportType=" + intReportType + "&Layout=" + intReportLayout + "&Mode=" + strMode + "&LinkName=" + strLinkName + "&ShowGroupLink=" + intShowGroupLink ; 
					SubmitForm(strAction);
				} 
			} 
		} 
		
		function Finish_OnClick(intReportID, intTemplateID,intReportType,intReportLayout,strMode) 
		{ 
			var blnIsblank; 
			var objText=GetObjectReference('frmCreateReport','txtReportTitle'); 
			blnIsblank= disallowBlank(objText,'Report Title cannot be Blank'); 
			if (blnIsblank==false) 
			{ 
				var objText=GetObjectReference('frmCreateReport','txtSPName'); 
				blnIsblank=disallowBlank(objText,'Datasource cannot be Blank'); 
				if(blnIsblank==false) 
				{ 
				
					var strAction="CRW_WIZ_CreateReport.aspx?MasterTagID=<%=m_strMasterTagID%>&FromWhere=<%=m_strFromWhere%>&QueryID=<%=m_lngQueryID%>&ReportID="+ intReportID  +"&TemplateID="+ intTemplateID + "&ReportType=" + intReportType + "&Layout=" + intReportLayout + "&Mode=" + strMode + "&LinkName=Finish" ; 
					SubmitForm(strAction); 
					
				} 
			} 
		} 
		
		function Search_OnClick() 
		{ 
			var objSPName;
			
			objSPName = GetObjectReference('frmCreateReport','txtSPName');
			window.open('CRW_Search.aspx?MasterTagID=<%=m_strMasterTagID%>&strToBeSearched=' + objSPName.value,'','height=500,width=800,resizable=yes,left=100,top=100') ;<% 'WAF3_PB_42 April 10, 2007 Change Top to 100  %>
		} 
				
			
			var objdivlist;
			 var objfrm; var objtxtReportTitle; 
			objfrm= GetFormReference('frmCreateReport'); 
			objdivlist=GetObjectReference('frmCreateReport','divBody'); 
			objtxtReportTitle=GetObjectReference('frmCreateReport','txtReportTitle'); 
			objtxtSPName=GetObjectReference('frmCreateReport','txtSPName'); 
			<% 'WAF3_PB_42 April 10, 2007 modified window_onload and removed local window_onresize function  %>
			function window_onload() 
			{ 
				var intFillFactor=(arguments.length>0)?arguments[0]:50;
                windowSize_common(intFillFactor);
					
				if (objtxtReportTitle.disabled==false)
					objtxtReportTitle.focus(); 
				
				showMessage=<%=m_intErrorNo%>
				ReportCreated=<%=m_intReportCreatedFlag%>
												
				if(showMessage > 0)
				{
					ShowAlert(showMessage);
									
					
					if(showMessage==1)
						objtxtReportTitle.focus();
					if(showMessage==2 || showMessage==3)
						objtxtSPName.focus();
						 
				}
				if(ReportCreated==1)
				{
					ShowReportDesigner();
				}
			} 			
			</script>
	</BODY>
</HTML>
