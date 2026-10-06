<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_GraphProperties.aspx.vb" Inherits="Whiz.CRW_GraphProperties" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		<form id="frmGraphPropertyPage" name="frmGraphPropertyPage" method="post" runat="server">
			<%PageInit%>
		</form>
		<script language="javascript">
		
			var objfrm;	
			objfrm=	GetFormReference('frmGraphPropertyPage')
			
			function frmSubmit_OnChange()
            {
				var objform;
				var objControlID;
				var objMode; 
				var objSection;
				
				objform=GetFormReference('frmGraphPropertyPage');
				objControlID = GetObjectReference('frmGraphPropertyPage','hdControlID');
				objMode = GetObjectReference('frmGraphPropertyPage','hdMode');
				objSection = GetObjectReference('frmGraphPropertyPage','hdSection');
				objReportID = GetObjectReference('frmGraphPropertyPage','hdReportID');
				
				objform.action = "CRW_GraphProperties.aspx?MasterTagID=<%=m_strMasterTagID%>&ControlID=" + objControlID.value + "&Mode=" + objMode.value + "&Section=" + objSection.value + "&ReportID=" + objReportID.value; 
				objform.submit();
			}
			
			<%MyBase.InitializeResources("Resources.CRW_ControlProperties","Resources")%>
		
			function Save_OnClick()		
			{
				var objform;
				var objRowNumber;
				var objLeftPosition;
				var objText;
				var objDataSource;
				var objCheckVal;
				var flag;
							
				objform=GetFormReference('frmGraphPropertyPage');
				
				objCheckVal = GetObjectReference('frmGraphPropertyPage','txtCheckVal');
				objCheckVal.value="true";
								
				// call the function disallowBlank to check for the empty string.
				objRowNumber = GetObjectReference('frmGraphPropertyPage','txtRowNumber');
				// check for Row Number
				flag=disallowBlank(objRowNumber,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_BLANK")%>',true);
				if(flag==false)
				{
				// call the function disallowNonNumeric to check if only numeric values are entered.
					flag=disallowNonNumeric(objRowNumber,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_NUMERIC")%>',true);
					if (flag==false)
					{
					// check for negative values
						flag=disallowNegativeNumeric(objRowNumber,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_NEGATIVE")%>',true);
						if(flag==false) 
						{
						// check for value as '0'
							flag=disallowMinValueViolation(objRowNumber,1,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_ZERO")%>',true);
							if(flag==false)
							{
							// check for non integer value
								flag=disallowNonInteger(objRowNumber,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_INTEGER")%>',true);
								if(flag==false)
								{
								// check for Left position
									objLeftPosition = GetObjectReference('frmGraphPropertyPage','txtLeftPosition');
									flag=disallowBlank(objLeftPosition,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_BLANK")%>',true);
									if(flag==false)
									{
									// call the function disallowNonNumeric to check if only numeric values are entered.
										flag=disallowNonNumeric(objLeftPosition,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_NUMERIC")%>',true);
										if(flag==false)
										{
										// check for negative values
											flag=disallowNegativeNumeric(objLeftPosition,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_NEGATIVE")%>',true);
											if(flag==false) 
											{
											// check for value as '0'
												flag=disallowMinValueViolation(objLeftPosition,0,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_ZERO")%>',true);
												if(flag==false)
												{
													//validations for Width
													objText = GetObjectReference('frmGraphPropertyPage','txtWidth');
													flag=disallowBlank(objText,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_BLANK")%>',true);
													if(flag==false)
													{
														// call the function disallowNonNumeric to check if only numeric values are entered.
														flag=disallowNonNumeric(objText,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_NUMERIC")%>',true);
														if(flag==false)
														{
															// check for negative values
															flag=disallowNegativeNumeric(objText,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_NEGATIVE")%>',true);
															if(flag==false) 
															{
																// check for value as '0'
																flag=disallowMinValueViolation(objText,0,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_ZERO")%>',true);
																if(flag==false)
																{	
																	//check for max value
																	flag=disallowMaxValueViolation(objText,1000,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_MAXVALUE")%>' + ' 1000 ' + '<%=MyBase.GetResourceString("PIXCEL")%>',true)
																	if(flag==false)
																	{	
																		//validations for Height 
																		objText = GetObjectReference('frmGraphPropertyPage','txtHeight');
																		flag=disallowBlank(objText,'<%=MyBase.GetResourceString("CTRL_HEIGHT_VALIDATION_BLANK")%>',true);
																		if(flag==false)
																		{
																			// call the function disallowNonNumeric to check if only numeric values are entered.
																			flag=disallowNonNumeric(objText,'<%=MyBase.GetResourceString("CTRL_HEIGHT_VALIDATION_NUMERIC")%>',true);
																			if(flag==false)
																			{
																				// check for negative values
																				flag=disallowNegativeNumeric(objText,'<%=MyBase.GetResourceString("CTRL_HEIGHT_VALIDATION_NEGATIVE")%>',true);
																				if(flag==false) 
																				{
																					// check for value as '0'
																					flag=disallowMinValueViolation(objText,0,'<%=MyBase.GetResourceString("CTRL_HEIGHT_VALIDATION_ZERO")%>',true);
																					if(flag==false)
																					{	
																						//check for max value
																						flag=disallowMaxValueViolation(objText,1000,'<%=MyBase.GetResourceString("CTRL_HEIGHT_VALIDATION_MAXVALUE")%>' + ' 1000 ' + '<%=MyBase.GetResourceString("PIXCEL")%>',true)
																						if(flag==false)
																						{	
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
								}
							}
						}
					}
				}
			}
			
			function Delete_OnClick()
			{
				var intShowMessage;
				var objCheckVal;
				var ans;
				
				ans=window.confirm('<%=MyBase.GetResourceString("CTRL_DELETE_VALIDATION")%>');
				if(ans==true)
				{
					objCheckVal = GetObjectReference('frmGraphPropertyPage','txtCheckVal');
					objCheckVal.value="Delete";
					frmSubmit_OnChange();
				}
			}
			
			function Overlap_Onclick()
			{
				var ans;
				var objCheckVal;
				
				objCheckVal = GetObjectReference('frmPropertyPage','txtCheckVal');
				ans = window.confirm('<%=MyBase.GetResourceString("CTRL_OVERLAP_VALIDATION")%>');
				if(ans==true)
				{
					objCheckVal.value = "Overlap";
				}
				else
				{
					objCheckVal.value = "NoOverlap";
				}
				frmSubmit_OnChange();
			}
			
			function Display_OnChange()
			{
				var objFieldName;
				var objcboFieldName;
				
				objFieldName = GetObjectReference('frmGraphPropertyPage','hdFieldName');
				objcboFieldName = GetObjectReference('frmGraphPropertyPage','cboFieldName');
				objFieldName.value = objcboFieldName[objcboFieldName.selectedIndex].text;
			}
	
			var objdivlist;
			var objfrm;
			objfrm=	GetFormReference('frmGraphPropertyPage')
			objdivlist=GetObjectReference('frmGraphPropertyPage','DivPropertyPage')
			
			<%MyBase.InitializeResources("Resources.CRW_ControlProperties","Resources")%>
			
			function window_onload()
			{
				var intDivHeight;
				var intDivHeightRisk;
				var intShowMessage;
				var objStoredProcedure;
			
				intShowMessage=<%=m_intShowMessage%>;
				if(intShowMessage==9)
				{
					alert('<%=MyBase.GetResourceString("CTRL_CONTROL_VALIDATION_NOGROUP")%>');
					window.close();
				}					
				
				else
				{
					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
					if (intDivHeight < 100)
						intDivHeight = 100;
					objdivlist.style.height = intDivHeight+'px'	;	//Added By Nilesh g on 11/12/2015		
				
					objStoredProcedure = GetObjectReference('frmGraphPropertyPage','cboStoredProcedure');
					objStoredProcedure.focus();
				
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
						alert('<%=MyBase.GetResourceString("CTRL_SUBREPORT_VALIDATION_FIELDNAME")%>');
					}
					if(intShowMessage==5)
					{
						alert('<%=MyBase.GetResourceString("CTRL_GRAPH_VALIDATION_DATATYPEMISMATCH")%>');
					}
					if(intShowMessage==6)
					{
						alert('<%=MyBase.GetResourceString("CTRL_GRAPH_VALIDATION_NOPARAMETER")%>');
					}
					if(intShowMessage==7)
					{	
						alert('<%=MyBase.GetResourceString("CTRL_SUBREPORT_VALIDATION_SELECTSP")%>');
					}
					if(intShowMessage==8)
					{
						alert('<%=MyBase.GetResourceString("CTRL_GRAPH_VALIDATION_SPNOTEXISTS")%>');
					}
				}
			}
			
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
			
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
				if (intDivHeight < 100)
					intDivHeight = 100;
			
				objdivlist.style.height = intDivHeight+'px'	;	//Added By Nilesh g on 11/12/2015	
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
