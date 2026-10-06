<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_ImageProperties.aspx.vb" Inherits="Whiz.CRW_ImageProperties" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<form id="frmImagePropertyPage" name="frmImagePropertyPage" method="post" runat="server">
			<%PageInit%>
		</form>
		<script language="javascript">
		
			var objdivlist;
			var objfrm;
			objfrm=	GetFormReference('frmImagePropertyPage')
			objdivlist=GetObjectReference('frmImagePropertyPage','DivImagePropertyPage')
			
			function frmSubmit_OnChange()
            {
				var objform;
				var objControlID;
				var objMode; 
				var objSection;
				
				objform=GetFormReference('frmImagePropertyPage');
				objControlID = GetObjectReference('frmImagePropertyPage','hdControlID');
				objMode = GetObjectReference('frmImagePropertyPage','hdMode');
				objSection = GetObjectReference('frmImagePropertyPage','hdSection');
				objReportID = GetObjectReference('frmImagePropertyPage','hdReportID');
				
				objform.action = "CRW_ImageProperties.aspx?ControlID=" + objControlID.value + "&Mode=" + objMode.value + "&Section=" + objSection.value + "&ReportID=" + objReportID.value; 
				objform.submit();
			}
			
			<%MyBase.InitializeResources("Resources.CRW_ControlProperties","Resources")%>
			
			function Save_OnClick()		
			{
				var objform;
				var objRowNumber;
				var objLeftPosition;
				var objImageName;
				var flag;
				var objLength;
				var objCheckVal;
							
				objRowNumber = GetObjectReference('frmImagePropertyPage','txtRow');
				flag=disallowBlank(objRowNumber,'Row should not be left blank.',true);
				if(flag==false)
				{
					flag=disallowBlank(objRowNumber,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_BLANK")%>',true);
					if (flag==false)
					{
						flag=disallowNonNumeric(objRowNumber,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_NUMERIC")%>',true);
						if(flag==false) 
						{
							flag=disallowMinValueViolation(objRowNumber,1,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_ZERO")%>',true);
							if(flag==false)
							{
								flag=disallowNegativeNumeric(objRowNumber,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_NEGATIVE")%>',true);
								if(flag==false)
								{
								// check for non integer value
									flag=disallowNonInteger(objRowNumber,'<%=MyBase.GetResourceString("CTRL_ROW_VALIDATION_INTEGER")%>',true);
									if(flag==false)
									{
										objLeftPosition = GetObjectReference('frmImagePropertyPage','txtLeftPosition');
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
														objLength=GetObjectReference('frmImagePropertyPage','txtWidth');
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
																		objImageName=GetObjectReference('frmImagePropertyPage','txtImageName');
																		flag=disallowBlank(objImageName,'<%=MyBase.GetResourceString("CTRL_IMAGE_VALIDATION")%>',true);
																		if(flag==false)
																		{
																			objCheckVal = GetObjectReference('frmImagePropertyPage','txtCheckVal');
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
				}
			}
			
			function Delete_OnClick()
			{
				var ans;
				var objCheckVal;
				
				ans=window.confirm('<%=MyBase.GetResourceString("CTRL_DELETE_VALIDATION")%>');
				if(ans==true)
				{
					objCheckVal = GetObjectReference('frmImagePropertyPage','txtCheckVal');
					objCheckVal.value="Delete";
					frmSubmit_OnChange();
				}
			}	
			
			function Overlap_Onclick()
			{
				var ans;
				var objCheckVal;
				
				objCheckVal = GetObjectReference('frmImagePropertyPage','txtCheckVal');
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
	
			var objdivlist;
			var objfrm;
			objfrm=	GetFormReference('frmImagePropertyPage')
			objdivlist=GetObjectReference('frmImagePropertyPage','DivImagePropertyPage')
		
			<%MyBase.InitializeResources("Resources.CRW_ControlProperties","Resources")%>
		
			function window_onload()
			{
				var intDivHeight;
				var intDivHeightRisk;
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
					intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
					if (intDivHeight < 100)
						intDivHeight = 100;
					objdivlist.style.height = intDivHeight+'px'	;	//Added By Nilesh g on 11/12/2015		
			
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
				}
			}
			
			function window_onresize()		
			{
				var intDivHeight ;
				var intDivHeightRisk;
			
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
				if (intDivHeight < 100)
					intDivHeight = 100;
			
				objdivlist.style.height = intDivHeight+'px'		;	//Added By Nilesh g on 11/12/2015	
			}
		</script>
	</body>
</HTML>
