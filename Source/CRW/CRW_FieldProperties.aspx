<%@ Page Language="vb" AutoEventWireup="false" Codebehind="CRW_FieldProperties.aspx.vb" Inherits="Whiz.CRW_FieldProperties" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag(m_strWindowTitle)%>
	<body MS_POSITIONING="GridLayout" onload="window_onload()" onresize="window_onresize()" class="clsBody">
		<form id="frmFieldPropertyPage" name="frmFieldPropertyPage" method="post" runat="server">
			<%PageInit%>
		</form>
		<script language="javascript">
		
			function frmSubmit_OnChange()
            {
				var objform;
				var objControlID;
				var objMode; 
				var objSection;
				var objReportID;
				
				objform=GetFormReference('frmFieldPropertyPage');
				objControlID = GetObjectReference('frmFieldPropertyPage','hdControlID');
				objMode = GetObjectReference('frmFieldPropertyPage','hdMode');
				objSection = GetObjectReference('frmFieldPropertyPage','hdSection');
				objReportID = GetObjectReference('frmFieldPropertyPage','hdReportID');
				objform.action = "CRW_FieldProperties.aspx?ControlID=" + objControlID.value + "&Mode=" + objMode.value + "&Section=" + objSection.value + "&ReportID=" + objReportID.value; 
				objform.submit();
			}
			
			<%MyBase.InitializeResources("Resources.CRW_ControlProperties","Resources")%>
			
			function Save_OnClick()
			{
				var objform;
				var objRowNumber;
				var objLeftPosition;
				var objWidth;
				var objDatatype;
				var objCompareValue;
				var objCheckVal;
				var objField;
				var flag;
				
				objCheckVal = GetObjectReference('frmFieldPropertyPage','txtCheckVal');												
				objCheckVal.value="true";
																
				// call the function disallowBlank to check for the empty string.
				objRowNumber = GetObjectReference('frmFieldPropertyPage','txtRow');
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
									objLeftPosition = GetObjectReference('frmFieldPropertyPage','txtLeftPosition');
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
													objWidth=GetObjectReference('frmFieldPropertyPage','txtWidth');
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
																	objField = GetObjectReference('frmFieldPropertyPage','cboComparisonParam');
																	if(objField.value =='' || objField.value =='0')
																	{
																		frmSubmit_OnChange();
																	}
																	else
																	{
																			//if comparison parameter is specified then value is mandatory
																		objCompareValue = GetObjectReference('frmFieldPropertyPage','txtComparisonValue');
																		flag=disallowBlank(objCompareValue,'<%=MyBase.GetResourceString("CTRL_FIELD_VALIDATION_COMPARISONVALUE_BLANK")%>',true);
																		if(flag==false)
																		{
																			objDatatype = GetObjectReference('frmFieldPropertyPage','txtDatatype');
																			
																			if(objDatatype.value=='Integer' || objDatatype.value=='Real Number' || objDatatype.value=='Money')
																			{
																				objCompareValue = GetObjectReference('frmFieldPropertyPage','txtComparisonValue');
																				flag=disallowNonNumeric(objCompareValue,'<%=MyBase.GetResourceString("CTRL_FIELD_VALIDATION_COMPARISONVALUE_NUMBER")%>',true);
																				if(flag==false)
																				{
																					frmSubmit_OnChange();	
																				}
																			}
																			else
																			{
																				if(objDatatype.value=='Date')
																				{
																					objCompareValue = GetObjectReference('frmFieldPropertyPage','txtComparisonValue');
																					flag=isDate(objCompareValue);
																					if(flag==false)
																					{
																						alert('<%=MyBase.GetResourceString("CTRL_FIELD_VALIDATION_COMAPARISONVALUE_DATETIME")%>');
																					}
																					else
																					{
																						frmSubmit_OnChange();	
																					}
																				}
																				else
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
			
			function Delete_OnClick()
			{
				var intShowMessage;
				var ans;
				
				ans=window.confirm('<%=MyBase.GetResourceString("CTRL_DELETE_VALIDATION")%>');
				if(ans==true)
				{
				    document.forms[0].txtCheckVal.value="Delete";   // modified by Puneet M on 23-12-2015
					frmSubmit_OnChange();
				}
			}
			
			function ShowFooter_OnClick()
			{
				var objTableRef;
				var objchkGroupFooter;
				objTableRef = GetObjectReference('frmFieldPropertyPage','tblGroupFooter');
				objchkGroupFooter = GetObjectReference('frmFieldPropertyPage','chkGroupFooter');
				if(objchkGroupFooter.checked)
				{
					objTableRef.style.display="";
				}
				else
				{
					objTableRef.style.display="none";
				}
			}	
			
			function GroupHeader_OnClick()
			{
				var objchkGroupOn;
				var objchkShow;
				var objCboGHeader;
				
				objchkGroupOn = GetObjectReference('frmFieldPropertyPage','chkGroupOn');
				objchkShow = GetObjectReference('frmFieldPropertyPage','chkShowIn');
				objCboGHeader = GetObjectReference('frmFieldPropertyPage','cboGroupHeader');
				
				if(objchkGroupOn.checked==false || objchkShow.checked==false)
				{
					//objCboGHeader.disabled =true;
					//alert(objchkGroupOn.checked + ' and ' + objchkShow.checked);
				}
				else
				{
					//objCboGHeader.disabled=false ;
				}
			}	
			
			function Function_OnChange()
			{
				var objFunction;
				var objTblFooter;
				var objTableRef;
				var objchkPageFooter;
				var objchkReportFooter;
				
				objFunction = GetObjectReference('frmFieldPropertyPage','cboFunction');
				objTblFooter = GetObjectReference('frmFieldPropertyPage','tblFunction');
				objTableRef = GetObjectReference('frmFieldPropertyPage','tblFunction');
				objchkGroupFooter = GetObjectReference('frmFieldPropertyPage','chkGroupFooter');
				objchkPageFooter = GetObjectReference('frmFieldPropertyPage','chkPageFooter');
				objchkReportFooter = GetObjectReference('frmFieldPropertyPage','chkReportFooter');
				
				if(objFunction.value=='' || objFunction.value=='0')
				{
					objTblFooter.style.display="none";
					objTableRef.style.display="none";
					objchkGroupFooter.checked = false;  
					objchkPageFooter.checked = false;
					objchkReportFooter.checked = false;
				}
				else
				{
					objTblFooter.style.display="";
					objTableRef.style.display="";
				}
			}
			
			function Footers_OnClick()
			{
				var objchkPageFooter;
				var objchkReportFooter;
				var objchkGroupFooter;
				var objtblFunction;
								
				objchkGroupFooter = GetObjectReference('frmFieldPropertyPage','chkGroupFooter');
				objchkPageFooter = GetObjectReference('frmFieldPropertyPage','chkPageFooter');
				objchkReportFooter = GetObjectReference('frmFieldPropertyPage','chkReportFooter');
				objFunction = GetObjectReference('frmFieldPropertyPage','cboFunction');
				objtblFunction=GetObjectReference('frmFieldPropertyPage','tblFunction');
								
				if(objchkGroupFooter.checked==false && objchkPageFooter.checked==false && objchkReportFooter.checked==false)
				{
					objFunction.value = '0';
					objtblFunction.style.display="none";
					
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
	
		
			<%MyBase.InitializeResources("Resources.CRW_ControlProperties","Resources")%>
		
			var objdivlist;
			var objform;
			
			objform=GetFormReference('frmFieldPropertyPage');
			objdivlist=GetObjectReference('frmFieldPropertyPage','DivPropertyPage');
					
			function window_onload()
			{
				var intDivHeight;
				var intDivHeightRisk;
				var intShowMessage;
				var objRow;
				
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
					objdivlist.style.height = intDivHeight+'px';	//Added By Nilesh g on 11/12/2015	
					
					objRow = GetObjectReference('frmFieldPropertyPage','txtRow');
					objRow.focus();
				
					intShowMessage=<%=m_intShowMessage%>;
					if(intShowMessage==1)
					{
						alert('<%=MyBase.GetResourceString("CTRL_CONTROL_VALIDATION_PAGELIMITS")%>');
					}
					if(intShowMessage==2)
					{
						Overlap_Onclick();
						//alert("The new control is not saved as it overlaps the existing control.");
					}	
					if(intShowMessage==3)
					{
						alert('<%=MyBase.GetResourceString("CTRL_GROUPFOOTER_VALIDATION")%>');
					}	
					if(intShowMessage==4)
					{
						alert('<%=MyBase.GetResourceString("CTRL_FIELD_VALIDATION_COMPARISONPARAMETER")%>');
					}		
					if(intShowMessage==5)
					{	
						alert('<%=MyBase.GetResourceString("CTRL_FIELD_VALIDATION_COMPARISONVALUE")%>');
					}	
					if(intShowMessage==6)
					{
						alert('<%=MyBase.GetResourceString("CTRL_DATETIME_VALIDATION")%>');
					}
					if(intShowMessage==8)
					{
						alert('<%=MyBase.GetResourceString("CTRL_FIELD_VALIDATION_FOOTERS")%>');
					}
					if(intShowMessage==10)
					{
						alert('<%=MyBase.GetResourceString("CTRL_FIELD_VALIDATION_GROUPHEADER")%>');
					}
					if(intShowMessage==11)
					{
						alert('<%=MyBase.GetResourceString("CTRL_FIELD_VALIDATION_NOFIELD")%>');
						window.close();
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
			
				objdivlist.style.height = intDivHeight+'px'	;		//Added By Nilesh g on 11/12/2015
			}
		</script>
	</body>
</HTML>
