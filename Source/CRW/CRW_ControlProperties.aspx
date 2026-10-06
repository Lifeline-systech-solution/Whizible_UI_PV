<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_ControlProperties.aspx.vb" Inherits="Whiz.CRW_ControlProperties" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" >
		<form id="frmPropertyPage" name="frmPropertyPage" method="post" runat="server">
			<%PageInit%>
		</form>
		<script language="javascript">
			
		// THIS FUNCTION IS USED TO GET THE OBJECT OF THE FORM AND SUBMIT THE FORM SO AS TO GET THE VALUE
        // SELECTED IN THE COMBO BOX.
        	var objdivlist;
			var objform;
			objform=GetFormReference('frmPropertyPage');
			objdivlist=GetObjectReference('frmPropertyPage','DivPropertyPage');

			<%MyBase.InitializeResources("Resources.CRW_ControlProperties","Resources")%>

			function frmSubmit_OnChange()
            {
				var objform;
				var objControlID;
				var objMode; 
				var objSection;
				var objReportID;
				
				objform=GetFormReference('frmPropertyPage');
				objControlID = GetObjectReference('frmPropertyPage','hdControlID');
				objMode = GetObjectReference('frmPropertyPage','hdMode');
				objSection = GetObjectReference('frmPropertyPage','hdSection');
				objReportID = GetObjectReference('frmPropertyPage','hdReportID');
				
				objform.action = "CRW_ControlProperties.aspx?ControlID=" + objControlID.value + "&Mode=" + objMode.value + "&Section=" + objSection.value + "&ReportID=" + objReportID.value; 
				objform.submit();
			}

			function Save_OnClick()		
			{
				var objform;
				var objRowNumber;
				var objLeftPosition;
				var flag;
				var objWidth;
				var objCheckVal;
				var flag;
				
					
				// call the function disallowBlank to check for the empty string.
				objRowNumber = GetObjectReference('frmPropertyPage','txtRow');
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
									objLeftPosition = GetObjectReference('frmPropertyPage','txtLeftPosition');
									flag=disallowBlank(objLeftPosition,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_BLANK")%>',true);
									if(flag==false)
									{
									// call the function disallowNonNumeric to check if only numeric values are entered.
										flag=disallowNonNumeric(objLeftPosition,'<%=MyBase.GetResourceString("CTRL_LEFTPOSITION_VALIDATION_NUMERIC")%>',true)
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
													objWidth=GetObjectReference('frmPropertyPage','txtWidth');
													flag=disallowBlank(objWidth,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_BLANK")%>',true);
													if(flag==false)
												    //2. check for non numeric value
													{
														flag=disallowNonNumeric(objWidth,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_NUMERIC")%>',true);
														if(flag==false)
												        {
															flag=disallowNegativeNumeric(objWidth,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_NEGATIVE")%>',true);
															if(flag==false)
													        {
																flag=disallowMinValueViolation(objWidth,0.1,'<%=MyBase.GetResourceString("CTRL_WIDTH_VALIDATION_ZERO")%>',true);
																if(flag==false)
																{
																	objCheckVal = GetObjectReference('frmPropertyPage','txtCheckVal');
																	objCheckVal.value = "true";
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
				var intShowMessage;
				var objCheckVal;
				var ans;
				
				ans=window.confirm('<%=MyBase.GetResourceString("CTRL_DELETE_VALIDATION")%>');
				if(ans==true)
				{
					objCheckVal = GetObjectReference('frmPropertyPage','txtCheckVal');
					objCheckVal.value = "Delete";
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
					
			var objdivlist;
			var objfrm;
			objfrm=	GetFormReference('frmPropertyPage')
			objdivlist=GetObjectReference('frmPropertyPage','DivPropertyPage')
			
			function window_onload()
			{
				var intDivHeight;
				var intDivHeightRisk;
				var intShowMessage;
				var objCaption;
								
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
					objdivlist.style.height = intDivHeight	;			
					
					objCaption = GetObjectReference('frmPropertyPage','txtCaption');
					objCaption.focus();
				
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
			
				objdivlist.style.height = intDivHeight	;		
			}
		</script>
	</body>
</HTML>
