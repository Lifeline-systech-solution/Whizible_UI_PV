<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DM_StageRuleEngine.aspx.vb" Inherits="PbNIT.DM_StageRuleEngine"%>
<html>
	<%CommonFunctions.General.PlotPageHeadTag(mybase.GetResourceString("WINDOW_TITLE"))%>
	
	<body MS_POSITIONING="GridLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">

		<form name = "frm_IM_RuleEngine" id="frm_IM_RuleEngine" method="post" runat="server">
			<%PageInit%>
		</form>
									
	
		<script language="javascript">
		objform=GetFormReference('frm_IM_RuleEngine');
		objDivMain=GetObjectReference('frm_IM_RuleEngine','PageDiv');
		objDivGrid=GetObjectReference('frm_IM_RuleEngine','DivListGrid');
    	function window_onload()		
		{
			var intDivHeight ;
			var intDivHeightRisk;
			var intScriptNo;
			document.body.style.visibility='visible';
			var objfocus = GetObjectReference('frm_IM_RuleEngine','cboFieldList');
			if (objfocus != null)
				objfocus.focus();
			if(objDivMain != null)
			{
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = window.innerHeight -  objDivMain.offsetTop - 55;
				}
				else
				{
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 65;
				}
				 
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivMain.style.height = intDivHeight;
			}
			
			if(objDivGrid != null)
			{
				if (navigator.appName=="Netscape") 
				{
					intDivHeight = window.innerHeight -  objDivGrid.offsetTop - 68;
				}
				else
				{
					intDivHeight = document.body.offsetHeight - objDivGrid.offsetTop - 35;
				}
				 
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivGrid.style.height = intDivHeight;
			}
			
		}

		function window_onresize()		
		{
			if(objDivMain != null)
			{
				var intDivHeight ;
				var intDivHeightRisk;
				if (navigator.appName=="Netscape") 
				{ intDivHeight = window.innerHeight -  objDivMain.offsetTop - 56; }
				else
				{ intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 65; }
				
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivMain.style.height = intDivHeight;
			}
			
			if(objDivGrid != null)
			{
				var intDivHeight ;
				var intDivHeightRisk;
				if (navigator.appName=="Netscape") 
				{ intDivHeight = window.innerHeight -  objDivGrid.offsetTop - 68; }
				else
				{	
					intDivHeight = document.body.offsetHeight - objDivGrid.offsetTop-35 ; 
				}
				
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivGrid.style.height = intDivHeight	;
			}
		}
		
		function Sort_OnClick(sortby, sortorder)
		{
			var strQueryString = "IM_RuleEngine.aspx?Mode=ApplyAll&NatureOfDemandID="+<%=intNatureOfDemandID%>+"&SortBy=" + sortby;
						
			objform.action = strQueryString;
			objform.submit();
		}
		
		function Close_OnClick()
		{
			window.close();
		}
		
		function Save_OnClick(strMode)
		{
			var objRule = GetObjectReference("frm_IM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_IM_RuleEngine","txtUserFriendlyRule");
			var strQueryString;
			
			objTxt = GetObjectReference('frm_IM_RuleEngine','txtRuleName');	
				flag = disallowBlank(objTxt,'Enater Rule Name to Save Rule.',true);
				if(flag==true)
					return;
					
			if (objRule.value == '')
			{
				alert('<%=mybase.getresourcestring("MSG_RULE_NOT_DEFINED")%>');
				return;
			}
			strQueryString = "IM_RuleEngine.aspx?Mode=Save&ForeignKeyValue="+<%=intNatureOfDemandID%>+"&NOIRuleID=<%=intRuleID%>" 
			
			objform.action = strQueryString ;
			objform.submit();
		}
		
		function ClearRule_OnClick()
		{
			var strQueryString = "IM_RuleEngine.aspx?Mode=Clear&NatureOfDemandID="+<%=intNatureOfDemandID%>+"&RequestStageID="+<%=intRequestStageID%>;
			
			
			if (confirm('This action will clear the rule defined.\n Click Ok to continue.'))
			{
				objform.action = strQueryString;
				objform.submit();
			}
		}
		
		function Field_OnChange()
		{
			var objFieldList = GetObjectReference("frm_IM_RuleEngine","cboFieldList");
			var objField = GetObjectReference("frm_IM_RuleEngine","cboField");
			
			for (var i = 1; i < objFieldList.length; i++)
			{
				if (objField[i].value != 3)
					var objControl = GetObjectReference("frm_IM_RuleEngine",objFieldList.options[i].value);
				else
					var objControl = GetObjectReference("frm_IM_RuleEngine","FFE29587WHIZ_"+objFieldList.options[i].value);
				if (navigator.appName=="Netscape") 
				{	var objControl = GetObjectReference("frm_IM_RuleEngine",objFieldList.options[i].value);	}
				var objCal = GetObjectReference("frm_IM_RuleEngine","imgCalendar");
				
				if ((objFieldList.value == objControl.name)||("FFE29587WHIZ_"+objFieldList.value == objControl.name))
				{	
				 	objControl.style.display = '';
					if (objField[i].value == 3)
						objCal.style.display = '';
					else
					{
						if (objCal!=null)
							objCal.style.display = 'none';
						
					}
				}
				else
				{
					objControl.style.display = 'none';
				}
			}
			
			window_onresize();
		}
		
		function FilterField_OnChange()
		{
		return;
		}
		function Calender_OnClick(strForm,strControl)
		{			
			var objFieldList = GetObjectReference("frm_IM_RuleEngine","cboFieldList");   
			//var intFilterFlag = objFieldList.value;
	
			var objField = GetObjectReference("frm_IM_RuleEngine","cboField");
			
			for (var i = 1; i < objFieldList.length; i++)
			{
				if (objField[i].value != 3)
					var objControl = GetObjectReference("frm_IM_RuleEngine",objFieldList.options[i].value);
				else
					var objControl = GetObjectReference("frm_IM_RuleEngine",objFieldList.options[i].value);
					
				if (objFieldList.value == objControl.name)
				{
							
					var strControlID;
					//var objSubmittedOnDate = GetObjectReference("frm_IM_RuleEngine","objControl")
					strControlID = new String(objControl.id);
					callcalendar("frm_IM_RuleEngine",strControlID);
				}
			}
				//alert(strControlID);
			
		}
		function Edit_OnClick(RuleID)
		{
			var strQueryString = "IM_RuleEngine.aspx?Mode=Edit&NatureOfDemandID="+<%=intNatureOfDemandID%>+"&RuleID="+RuleID
			objform.action = strQueryString;
			objform.submit();
		}
		function Back_OnClick()
		{
			var strQueryString = "IM_RuleEngine.aspx?Mode=List&NatureOfDemandID="+<%=intNatureOfDemandID%>+"&RequestStageID="+<%=intRequestStageID%>;
			objform.action = strQueryString;
			objform.submit();
		}
		
		function Append_OnClick()
		{
			var objFieldList = GetObjectReference("frm_IM_RuleEngine","cboFieldList");
			var objOperator = GetObjectReference("frm_IM_RuleEngine","cboOperator");
			var objRule = GetObjectReference("frm_IM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_IM_RuleEngine","txtUserFriendlyRule");
			var objField = GetObjectReference("frm_IM_RuleEngine","cboField");
			var objValidationRule = GetObjectReference("frm_IM_RuleEngine","cboValidationRule");
			if(objFieldList.value=='') 
			{
				alert('<%=mybase.getresourcestring("MSG_FIELD_NOT_SELECTED")%>');
				objFieldList.focus();
				return;
			}
			if(objOperator.value=='') 
			{
				alert('<%=mybase.getresourcestring("MSG_OPERATOR_NOT_SELECTED")%>');
				objOperator.focus();
				return;
			}
			for (var i = 1; i < objFieldList.length; i++)
			{
			
				var objControl = GetObjectReference("frm_IM_RuleEngine",objFieldList.options[i].value);
				if (objFieldList.value == objControl.name)
				{
					if(objControl.value=='') 
					{
						alert('<%=mybase.getresourcestring("MSG_VALUE_NOT_SELECTED")%>');
						objControl.focus();
						return;
					}
					else
					{
						// Combo 					
						if (objField[i].value == 1)
						{
							if ((objOperator.value != '=') && (objOperator.value != '<>'))
							{
								alert('<%=mybase.getresourcestring("MSG_INVALID_OPERATOR")%>');
								objOperator.focus();
								return;
							}
							
							objRule.value = objRule.value + ' ' + objFieldList.value + ' ' + objOperator.value + ' ' + objControl.value;
							objUserFriendlyRule.value = objUserFriendlyRule.value + ' ' + objFieldList.options[objFieldList.selectedIndex].text + ' ' + objOperator.value + ' ' + objControl.options[objControl.selectedIndex].text;			
						}
						// Text Box
						if (objField[i].value == 2)
						{
							if (isValid(objValidationRule[i],objControl)==false)
									return;
							objRule.value = objRule.value + ' ' + objFieldList.value + ' ' + objOperator.value + ' ' + objControl.value;
							objUserFriendlyRule.value = objUserFriendlyRule.value + ' ' + objFieldList.options[objFieldList.selectedIndex].text + ' ' + objOperator.value + ' ' + objControl.value;		
						}
						// Date Control
						if (objField[i].value == 3)
						{
							objRule.value = objRule.value + " " + objFieldList.value + " " + objOperator.value + " '" + objControl.value + "'";
							objUserFriendlyRule.value = objUserFriendlyRule.value + " " + objFieldList.options[objFieldList.selectedIndex].text + " " + objOperator.value + " '" + objControl.value + "'";		
						}
						// List
						if (objField[i].value == 4)
						{
							var chkFirstSelected = 1;
							if ((objOperator.value != '=') && (objOperator.value != '<>'))
							{
								alert('<%=mybase.getresourcestring("MSG_INVALID_OPERATOR")%>'.replace(/&#39;/g,"'"));
								objOperator.focus();
								return;			
							}
							for (var j=0;j<objControl.length;j++)
							{
								if (objControl.options[j].selected)
								{
								
									if (chkFirstSelected == 1)						
									{	
										objRule.value = objRule.value + ' ' + objFieldList.value + ' ' + objOperator.value + ' ' + objControl[j].value;
										objUserFriendlyRule.value = objUserFriendlyRule.value + ' ' + objFieldList.options[objFieldList.selectedIndex].text + ' ' + objOperator.value + ' ' + objControl.options[j].text;
										chkFirstSelected = 0;
									}
									else
									{
									     objRule.value = objRule.value + ' OR ' + objFieldList.value + ' ' + objOperator.value + ' ' + objControl[j].value;
									     objUserFriendlyRule.value = objUserFriendlyRule.value + ' OR ' + objFieldList.options[objFieldList.selectedIndex].text + ' ' + objOperator.value + ' ' + objControl.options[j].text;
									     
									}
								}
							}
						}//End of List Box Append
						
					}
				}
			}
				
		}
		function ClearAll_OnClick()
		{
			var objRule = GetObjectReference("frm_IM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_IM_RuleEngine","txtUserFriendlyRule");
			objRule.value = '';
			objUserFriendlyRule.value = '';
		}
		function OpeningBracket_OnClick()
		{
			var objRule = GetObjectReference("frm_IM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_IM_RuleEngine","txtUserFriendlyRule");
			objRule.value = objRule.value + ' ' + '(';
			objUserFriendlyRule.value = objUserFriendlyRule.value + ' ' + '(';
		}
		
		function ClosingBracket_OnClick()
		{
			var objRule = GetObjectReference("frm_IM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_IM_RuleEngine","txtUserFriendlyRule");
			objRule.value = objRule.value + ' ' + ')';
			objUserFriendlyRule.value = objUserFriendlyRule.value + ' ' + ')';
		}
		
		function And_OnClick()
		{
			var objRule = GetObjectReference("frm_IM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_IM_RuleEngine","txtUserFriendlyRule");
			objRule.value = objRule.value + ' ' + 'AND';
			objUserFriendlyRule.value = objUserFriendlyRule.value + ' ' + 'AND';
		}
		function Or_OnClick()
		{
			var objRule = GetObjectReference("frm_IM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_IM_RuleEngine","txtUserFriendlyRule");
			objRule.value = objRule.value + ' ' + 'OR';
			objUserFriendlyRule.value = objUserFriendlyRule.value + ' ' + 'OR';
		}
		
		function History_OnClick(FieldID)
		{
			var TagID = 2049;
			
			window.open ("../General/CommonList.aspx?ShowHistory=1&MasterTagID=1500&IsSubTagID=1&TagID=" + TagID + "&UniqueID=" + FieldID + "&ProjectID=0", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 700)/2) + ",top=" + ((window.screen.height - 600)/2) + ",width=700,height=600");
		}
		
		function cboStage_Change()
		{
			var objStage = GetObjectReference('frm_DM_InitiativeReallocation','cboStage');
			var strQueryString;
			
			strQueryString = "DM_RuleEngine.aspx?Mode=ApplyAll&NatureOfDemandID="+<%=intNatureOfDemandID%>;
			
			if (objStage.value != '')
				strQueryString = strQueryString + "&StageChange=Yes&StageID="+objStage.value;
			objStage.focus()			
			objform.action = strQueryString;
			objform.submit();
		}
		
		function isValid(objRule,objFieldValue)
		{
			var strRule=new String(objRule.value);
			var arrRule = new Array();
			
			arrRule  = strRule.split(',');
			for(var i=0;i<arrRule.length;i++)
			{
				switch(arrRule[i])
				{
					case '13': if (disallowNegativeNumeric(objFieldValue) == true)
								{	
									alert('<%=mybase.getresourcestring("MSG_POS_NUM")%>');
									return false;
								}
								break;
					
					case '20': if ((isInteger(objFieldValue.value) == false)||(parseInt(objFieldValue.value) < 0))
								{
									alert('<%=mybase.getresourcestring("MSG_POS_INT")%>');
									return false;
								}
				}
			}
			return true;
		}

	// Added By NitinVS on 21 FEb 2007 for WhiziblePPM 2.1 
	// To add functionality to allow all and Allow none
	function AllowAll_OnClick()
	{
			var objRule = GetObjectReference("frm_IM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_IM_RuleEngine","txtUserFriendlyRule");
			objRule.value = ' ' + "1 =1";
			objUserFriendlyRule.value = ' ' + "Allow All";	
	}
	
	function AllowNone_OnClick()
	{
			var objRule = GetObjectReference("frm_IM_RuleEngine","txtRule");
			var objUserFriendlyRule = GetObjectReference("frm_IM_RuleEngine","txtUserFriendlyRule");
			objRule.value = ' ' + "1 = 2";
			objUserFriendlyRule.value = ' ' + "Deny All";
	
	}
	// End Addition By NitinVS on 21 FEb 2007 for WhiziblePPM 2.1 
	
	function Add_OnClick()
	{
		var strQueryString = "IM_RuleEngine.aspx?Mode=Edit&NatureOfDemandID="+<%=intNatureOfDemandID%>;
			objform.action = strQueryString;
			objform.submit();
	}
	function ConfigureStages_OnClick(RuleID,NOIID)
	{
			var strQueryString = "IM_RuleEngine.aspx?Mode=Stage&NatureOfDemandID="+NOIID+"&RuleID="+RuleID;
			/*objform.action = strQueryString;
			objform.submit();*/
			window.open("IM_RuleEngine.aspx?Mode=Stage&NatureOfDemandID="+NOIID+"&RuleID="+RuleID, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 350)/2 + ",width=600,height=400");
	
	}
	function SaveStage_OnClick(RuleID,NOIID)
	{
		var strQueryString = "IM_RuleEngine.aspx?Mode=SaveStage&NatureOfDemandID="+NOIID+"&RuleID="+RuleID;
			objform.action = strQueryString;
			objform.submit();
			//window.close(); 
	}
		</script>
	</body>
</html>
