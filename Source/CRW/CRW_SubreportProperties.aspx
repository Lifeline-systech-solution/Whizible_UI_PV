<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_SubreportProperties.aspx.vb" Inherits="Whiz.CRW_SubreportProperties" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
    	<body class="clsBody" onload="window_onload(<%=m_intDivFillFactor %>)" onresize="window_onresize(<%=m_intDivFillFactor %>)"> <% 'WAF3_PB_42 April 13, 2007 NinadP %>
		<form name="frmSubReportPropertyPage" id="frmSubReportPropertyPage" method="post" runat="server">
			<%PageInit%>
		</form>
		<script language="javascript">
			var objdivlist;
			var objfrm;
			objfrm=	GetFormReference('frmSubReportPropertyPage')
			objdivlist=GetObjectReference('frmSubReportPropertyPage','DivSubreportPropertyPage')
			
			function frmSubmit_OnChange()
            {
				var objform;
				var objControlID;
				var objMode; 
				var objSection;
				
				objform=GetFormReference('frmSubReportPropertyPage');
				objControlID = GetObjectReference('frmSubReportPropertyPage','hdControlID');
				objMode = GetObjectReference('frmSubReportPropertyPage','hdMode');
				objSection = GetObjectReference('frmSubReportPropertyPage','hdSection');
				objReportID = GetObjectReference('frmSubReportPropertyPage','hdReportID');
				
				objform.action = "CRW_SubreportProperties.aspx?MasterTagID=<%=m_strMasterTagID%>&ControlID=" + objControlID.value + "&Mode=" + objMode.value + "&Section=" + objSection.value + "&ReportID=" + objReportID.value; 
				objform.submit();
			}
			
			<%MyBase.InitializeResources("Resources.CRW_ControlProperties","Resources")%>
			
			function Save_OnClick()		
			{
				var objform;
				var objRowNumber;
				var objLeftPosition;
				var flag;
				var objLength;
				var objCheckVal;
				var flag;
				
				
				objRowNumber = GetObjectReference('frmSubReportPropertyPage','txtRow');
				flag=disallowBlank(objRowNumber,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_BLANK")%>',true);
				if(flag==false)
				{
					flag=disallowNonNumeric(objRowNumber,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_NUMERIC")%>',true);
					if (flag==false)
					{
						flag=disallowNegativeNumeric(objRowNumber,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_NEGATIVE")%>',true);
						if(flag==false) 
						{
							flag=disallowMinValueViolation(objRowNumber,1,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_ZERO")%>',true);
							if(flag==false)
							{
								flag=disallowNonInteger(objRowNumber,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_INTEGER")%>',true);
								if(flag==false)
								{
									objLeftPosition = GetObjectReference('frmSubReportPropertyPage','txtLeftPosition');
									flag=disallowBlank(objLeftPosition,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_BLANK")%>',true);
									if(flag==false)
									{
										flag=disallowNonNumeric(objLeftPosition,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_NUMERIC")%>',true)
										if(flag==false)
										{
											flag=disallowNegativeNumeric(objLeftPosition,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_NEGATIVE")%>',true);
											if(flag==false) 
											{
												flag=disallowMinValueViolation(objLeftPosition,0,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_ZERO")%>',true);
												if(flag==false)
												{
													objLength=GetObjectReference('frmSubReportPropertyPage','txtWidth');
													flag=disallowBlank(objLength,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_BLANK")%>',true);
													if(flag==false)
													{
														flag=disallowNonNumeric(objLength,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_NUMERIC")%>',true);
														if(flag==false)
												        {
															flag=disallowNegativeNumeric(objLength,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_NEGATIVE")%>',true);
															if(flag==false)
													        {
																flag=disallowMinValueViolation(objLength,0.1,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_ZERO")%>',true);
																if(flag==false)
																{
																	objCheckVal = GetObjectReference('frmSubReportPropertyPage','txtCheckVal');
																	objCheckVal.value="true";
																	frmSubmit_OnChange();
																}
															}
														}
													}
          										}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			
			function Delete_OnClick()
			{
				var ans;
				var objCheckVal;
				ans=window.confirm('<%=MyBase.GetResourceString("CTRL_DELETE_VALIDATION")%>');
				if(ans==true)
				{
					objCheckVal = GetObjectReference('frmSubReportPropertyPage','txtCheckVal');
					objCheckVal.value="Delete";
					frmSubmit_OnChange();
				}
			}	
			
			function Overlap_Onclick()
			{
				var ans;
				var objCheckVal;
				
				objCheckVal = GetObjectReference('frmSubReportPropertyPage','txtCheckVal');
				ans = window.confirm('<%=MyBase.GetResourceString("CTRL_OVERLAP_VALIDATION")%>');
				if(ans==true)
				{
					objCheckVal.value = "Overlap";
					frmSubmit_OnChange();
				}
				else
				{
					objCheckVal.value = "NoOverlap";
				}				
			}
	
			var objdivlist;
			var objfrm;
			objfrm=	GetFormReference('frmSubReportPropertyPage')
			objdivlist=GetObjectReference('frmSubReportPropertyPage','DivSubreportPropertyPage')
		
			<%MyBase.InitializeResources("Resources.CRW_ControlProperties","Resources")%>
			
			function window_onload()
			{
				var intShowMessage;
				var objRowNumber;
								
				intShowMessage=<%=m_intShowMessage%>;
				if(intShowMessage==9)
				{
					alert('<%=MyBase.GetResourceString("CTRL_CONTROL_VALIDATION_NOGROUP")%>');
					window.close();
				}
				
				else
				{
					var intFillFactor=(arguments.length>0)?arguments[0]:40; //'WAF3_PB_42 April 12, 2007 NinadP 
        		    windowSize_common(intFillFactor); <% 'WAF3_PB_42 April 06, 2007 NinadP %>
				
					objRowNumber = GetObjectReference('frmSubReportPropertyPage','txtRow');
					objRowNumber.focus();
			
					intShowMessage=<%=m_intShowMessage%>;
					if(intShowMessage==1)
					{
						alert('<%=MyBase.GetResourceString("CTRL_CONTROL_VALIDATION_PAGELIMITS")%>');
					}
					if(intShowMessage==2)
					{
						Overlap_Onclick();
						//alert("The new control cannot be saved as it overlaps an existing control.");
					}
					if(intShowMessage==3)
					{
						alert('<%=MyBase.GetResourceString("CTRL_GROUPFOOTER_VALIDATION")%>');
					}
					if(intShowMessage==4)
					{
						alert('<%=MyBase.GetResourceString("CTRL_SUBREPORT_VALIDATION_PARAMETERS")%>');
					}
					if(intShowMessage==5)
					{	
						alert('<%=MyBase.GetResourceString("CTRL_SUBREPORT_VALIDATION_ALTEASTONEPARAMETER")%>');
					}
					if(intShowMessage==6)
					{
						alert('<%=MyBase.GetResourceString("CTRL_SUBREPORT_VALIDATION_MAXLIMITS")%>');					
					}
				}
			}		
		
			function Hide_OnClick()
			{
				var objTxt=GetObjectReference('frmGraphPropertyPage','hdMode');
				objTxt.value='<%=MODE_HIDE%>';
				
				frmSubmit_OnChange();
			}
		</script>
	</body>
</HTML>
