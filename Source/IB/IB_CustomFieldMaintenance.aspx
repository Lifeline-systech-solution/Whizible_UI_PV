<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_CustomFieldMaintenance.aspx.vb" Inherits="PbNIT.IB_CustomFieldMaintenance" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%WritePageHead%>
	<%CommonFunctions.General.PlotPageHeadTag("")%>
    

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
	<form id="frmIssueCustomFields" method="post" runat="server">
					<%WritePage%>
	</form>
	<script language="javascript">
	// =============================== Common To all Mode=====================//
	var objForm, objdivlist;
	
	objForm = GetFormReference('frmIssueCustomFields');
	objdivlist = GetObjectReference('frmIssueCustomFields','divList');
	    //Modified(29) by Bharat T on 25th-Nov-2015 for Sem issue
	function window_onload()
	{
		var intDivHeight ;
		if (objdivlist==null)
		    objdivlist = GetObjectReference('frmIssueCustomFields','DivList');

		if (intDivHeight < 100)	intDivHeight = 100;
		
			if(navigator.appName == 'Netscape')
			{
				intDivHeight = window.innerHeight - objdivlist.offsetTop - 29;			
			}
			else
			    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 29;
		
		objdivlist.style.height = intDivHeight +'px';	
	}
	
	function window_onresize()		
	{
			var intDivHeight;

			if(navigator.appName == 'Netscape')
		    {		  
			    intDivHeight =window.innerHeight  - objdivlist.offsetTop - 32 ;
		    }
		    else
		    {
			    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 32;
		    }
		if (intDivHeight < 100)	intDivHeight = 100;
		objdivlist.style.height = intDivHeight +'px';		
	}
	    //End of Modified(29) by Bharat T on 25th-Nov-2015 for Sem issue
// =============================== for Detail Page of selected Custom field =====================//
// ========================================================================================================//
<%If m_strMode = MODE_DETAILS%>
	var bitQuery = <%=m_bitIsQueryValue%>, objOnLoadFocus;
	
	objOnLoadFocus = GetObjectReference('frmIssueCustomFields','txtUserGivenCaption');
	setFocus(objOnLoadFocus);
	function Back_OnClick()
	{
		window.location.href = "IB_CustomFieldMaintenance.aspx?Mode=<%=MODE_LIST%>&MasterTagID=<%=m_lngTagId%>&CORP=<%=m_strPageCalledFrom%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>";
	}
	// =============================== For selection of validation rules for Custom field =====================//

   	function SelectValidation(strDatabaseFieldName,intProjectID)
	{
		var strValidationRules, objValidationRules;
		objValidationRules = GetObjectReference('frmIssueCustomFields','txtValidationRules');

		if (window.showModalDialog)
		{
			strValidationRules = window.showModalDialog("../IB/IB_ValidationRules.aspx?Rules=" + objValidationRules.value ,"_SelectValidation","dialogwidth:13cm;dialogheight:12cm");
		}
		else
		{
			var strAddress;
			strAddress="../IB/IB_ValidationRules.aspx?Rules=" + objValidationRules.value;
			ShowWindow(strAddress)
		}		
		if((strValidationRules) != "Close" && (window.showModalDialog))
		{
		    objValidationRules.value = strValidationRules;
		    //Added By Vidya J ON 16 Aug-2016 
		       txtValidationRules_OnPropertyChange();
		    //End Of Added By Vidya J ON 16 Aug-2016 
		}	
	}
	
	//showModalDialog does not work for Netscape. So work aroud is found out
	var winModalWindow
	 
	function IgnoreEvents(e)
	{
		return false
	}
 
	function ShowWindow(strAddress)
	{
		window.top.captureEvents (Event.CLICK|Event.FOCUS)
		window.top.onclick=IgnoreEvents
		window.top.onfocus=HandleFocus 
		winModalWindow = window.open (strAddress,"ModalChild","dependent=yes,width=400,height=400");
		winModalWindow.focus()
	}
 
	function HandleFocus()
	{
		if (winModalWindow)
		{
			if (!winModalWindow.closed)
			{
				winModalWindow.focus()
			}
			else
			{
				window.top.releaseEvents (Event.CLICK|Event.FOCUS)
				window.top.onclick = ""
			}
		}
		return false
	}

	// =============================== After selection of validation rules enabling range texts if reqd =====================//
	function txtValidationRules_OnPropertyChange()
	{
	    var objMinValue, objMaxValue, objValidationRules,objMaxLength;
		var strValidation;
		
		objValidationRules = GetObjectReference('frmIssueCustomFields','txtValidationRules');
		objMinValue = GetObjectReference('frmIssueCustomFields','txtMinValue');
		objMaxValue = GetObjectReference('frmIssueCustomFields','txtMaxValue');
	    //Added By Viday Jadhav on 16-Aug-2016 Purpose:Qa issue fixing
		objMaxLength = GetObjectReference('frmCustomeFields','txtMaxLength');
	    //End Of Added By Vidya Jadhav on 16th-Aug-2016 Purpose:Qa issue fixing
		objMinValue.disabled = true;
		objMaxValue.disabled = true;
		objMaxLength.disabled = true;
		if(Trim(objValidationRules.value) != "")
		{
			strValidation = "," + objValidationRules.value;
			//Rule 18 : Specified Range Check (Both the minimum value and maximun value required )
			if(isSubstringExists(strValidation, ",18,"))
			{
				objMinValue.disabled = false;
				objMaxValue.disabled = false;
				return;
			}
			//Rule 16 : Minimum Value Check(Only minimum value required.)
			if(isSubstringExists(strValidation, ",16,"))
				objMinValue.disabled = false;
			else
				objMinValue.value = "";
				
			//Rule 17 : Maximum Value Check(Only maximum value required.)
			if(isSubstringExists(strValidation, ",17,"))
				objMaxValue.disabled = false;
			else
			    objMaxValue.value = "";
		    //Added By Chakshuta H on 12th-Aug-2016 Purpose:Qa issue fixing
		    //Rule 12 : Max Length
			if(isSubstringExists(strValidation, ",12,"))
			    objMaxLength.disabled = false;
			else
			    objMaxLength.value = "";
		    //End Of Added By Chakshuta H on 12th-Aug-2016 Purpose:Qa issue fixing
		}
		else	//Mimimum and Maximum value textboxes must be empty
		{
			objMinValue.value = "";
			objMaxValue.value = "";
		    //Added By Chakshuta H on 12th-Aug-2016 Purpose:Qa issue fixing
			objMaxLength.value = "";
		    //End Of Added By Chakshuta H on 12th-Aug-2016 Purpose:Qa issue fixing
		}
	}

	// =============================== In Case of CustomCombo For inserting Static Values=====================//
	function InsertValue_OnClick()
	{
		var objNewElement, objTextBox, objListBox, objLabel, objValidationRules;
		var intCtr, msg, strObjectCaption;
		var objDataType;	
		objDataType = GetObjectReference('frmIssueCustomFields','cboDataType');
		objValidationRules = GetObjectReference('frmIssueCustomFields','txtValidationRules');
		objTextBox = GetObjectReference('frmIssueCustomFields','txtValue');
		objListBox = GetObjectReference('frmIssueCustomFields','lstValue');
		objLabel = GetObjectReference('frmIssueCustomFields','lblSelectedValue');
		strObjectCaption = "value";
		
		// Check whether the value to be inserted is blank.
		if(disallowBlank(objTextBox, replaceSubstring("<%=Mybase.GetResourceString("ENTERINSERTVALUE")%>","<=>", strObjectCaption)))
			return;
		if(isSubstringExists(objTextBox.value,","))
		{
			alert("<%=Mybase.GetResourceString("COMMADISALLOWED")%>");
			setFocus(objTextBox);
			return;
		}
		if(isSubstringExists("," + objValidationRules.value + "," ,",3,") || objDataType.value==1)
		{
			if(disallowNonNumeric(objTextBox, "<%=Mybase.GetResourceString("LISTVALUENUMERIC")%>"))
				return;
		}
		
		//Check whether the value to be inserted already exists in the list.
		for(intCtr=0 ; intCtr < objListBox.length ; intCtr++)
		{			
			//Replace () with [] and innerHTML with innerHTML
			if(Trim(objListBox.options[intCtr].innerHTML.toUpperCase()) == Trim(objTextBox.value.toUpperCase()))
			{
				msg = replaceSubstring("<%=Mybase.GetResourceString("VALUEALREADYEXISTS")%>","<=>", strObjectCaption);
				msg = replaceSubstring(msg, "<==>",objTextBox.value);
				msg = replaceSubstring(msg, "&#39;","'");
				alert(msg);
				setFocus(objTextBox);
				return;
			}
			
		}
		objNewElement = document.createElement("OPTION");
				
		if(navigator.appName == 'Netscape')
				objNewElement.innerHTML = objTextBox.value;
		else
				objNewElement.innerHTML = objTextBox.value;
				
		objNewElement.value = objTextBox.value;
		objListBox.appendChild(objNewElement);
		
		objTextBox.value = "";
		setFocus(objTextBox);
	}
	// =============================== In Case of CustomCombo For Updating Static Values=====================//
	function UpdateValue_OnClick()
	{
		var objTextBox, objListBox, objLabel,objDataType,objValidationRules;
		var intCtr, msg, strObjectCaption, intSelectedIndex;
		objTextBox = GetObjectReference('frmIssueCustomFields','txtValue');
		objListBox = GetObjectReference('frmIssueCustomFields','lstValue');
		objLabel = GetObjectReference('frmIssueCustomFields','lblSelectedValue');
		objDataType = GetObjectReference('frmIssueCustomFields','cboDataType');
		objValidationRules = GetObjectReference('frmIssueCustomFields','txtValidationRules');
		strObjectCaption = "value";
		intSelectedIndex = objListBox.selectedIndex;

		if(intSelectedIndex == -1)
		{
			msg = replaceSubstring("<%=Mybase.GetResourceString("SELECTTOUPDATE")%>","<=>", strObjectCaption);
			alert(replaceSubstring(msg, "&#39;","'"));
			setFocus(objListBox);
			return;
		}
		if(disallowBlank(objTextBox, replaceSubstring("<%=Mybase.GetResourceString("NEWVALUEFORUPDATION")%>","<=>", strObjectCaption)))
			return;
		if(isSubstringExists(objTextBox.value, ","))
		{
			alert("<%=Mybase.GetResourceString("COMMADISALLOWED")%>");
			setFocus(objListBox);
			return;
		}
		
		if(isSubstringExists("," + objValidationRules.value + "," ,",3,") || objDataType.value==1)
		{
			if(disallowNonNumeric(objTextBox, "<%=Mybase.GetResourceString("LISTVALUENUMERIC")%>"))
				return;
		}
		
		for(intCtr=0 ; intCtr < objListBox.length ; intCtr++)
		{
			//Replace () with [] and innerHTML with innerHTML
			if(Trim(objListBox.options[intCtr].innerHTML.toUpperCase()) == Trim(objTextBox.value.toUpperCase()))
			{
				if((intCtr != intSelectedIndex) && (intCtr != objListBox.length))
				{
					msg = replaceSubstring("<%=Mybase.GetResourceString("VALUEALREADYEXISTS")%>","<=>", strObjectCaption);
					msg = replaceSubstring(msg, "<==>", objTextBox.value);
					alert(replaceSubstring(msg, "&#39;","'"));
					setFocus(objTextBox);
					return;
				}
			}
		}
					
		if(navigator.appName == 'Netscape')
		{
			objListBox.options[intSelectedIndex].innerHTML = objTextBox.value;
			objListBox.options[intSelectedIndex].value = objTextBox.value;		
			objTextBox.innerHTML = "";
		}
		else
		{
			objListBox.options[intSelectedIndex].innerHTML = objTextBox.value;
			objListBox.options[intSelectedIndex].value = objTextBox.value;		
			objTextBox.innerHTML = "";
		}
		
		
		objLabel.innerHTML = "<%=Mybase.GetResourceString("SELECTED")%> " + strObjectCaption;
		objLabel.innerHTML = objLabel.innerHTML + " : <B>" + objListBox.options[objListBox.selectedIndex].innerHTML 
		objLabel.innerHTML = objLabel.innerHTML + "</B>&nbsp;&nbsp;&nbsp;|";
		objLabel.innerHTML = objLabel.innerHTML + "<A style='TEXT-DECORATION: none' HREF='javascript:SetAsDefault_OnClick()'>";
		objLabel.innerHTML = objLabel.innerHTML + "<FONT size=1 face=verdana color=black>";
		objLabel.innerHTML = objLabel.innerHTML + "<B><%=Mybase.GetResourceString("SETASDEFAULT")%></B>";
		objLabel.innerHTML = objLabel.innerHTML + "</FONT>";
		objLabel.innerHTML = objLabel.innerHTML + "</A>|";
	}
	
	// =============================== In Case of CustomCombo For deleting Static Values=====================//
	function DeleteValue_OnClick()
	{
		var objElement, objTextBox, objListBox, objLabel, objDefaultValue;
		var intCtr, msg, strObjectCaption, intSelectedIndex;
		
		objTextBox = GetObjectReference('frmIssueCustomFields','txtValue');
		objListBox = GetObjectReference('frmIssueCustomFields','lstValue');
		objLabel = GetObjectReference('frmIssueCustomFields','lblSelectedValue');
		strObjectCaption = "value";
		objLabel.innerHTML = "";
		objDefaultValue = GetObjectReference('frmIssueCustomFields','txtDefaultValue');
				
		if(objListBox.selectedIndex == -1)
		{
			msg="<%=Mybase.GetResourceString("SELECTTODELETE")%>";
			alert(replaceSubstring(msg, "&#39;","'"));
			setFocus(objListBox);
			return;
		}
		if(!confirm("<%=Mybase.GetResourceString("CONFIRMDELETE")%>"))
			return;
			
		intSelectedIndex = -1;
		while (objListBox.selectedIndex != -1)
		{
			
			if(navigator.appName == 'Netscape')
			{
				if(objListBox.options[objListBox.selectedIndex].innerHTML == objDefaultValue.value)
				{
					objDefaultValue.value = "";
				
				}
				objListBox.remove(objListBox.selectedIndex);	
			}
			else
			{
				if(objListBox.options[objListBox.selectedIndex].innerHTML == objDefaultValue.value)
				{
					objDefaultValue.value = "";
				
				}
				objListBox.remove(objListBox.selectedIndex);						
		
			}
			
		}
	}
	
	function SelectElement_OnClick(strValueType)
	{ 
	 //'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168
		var objTextBox, objListBox, objLabel, objDefaultValue;
		var strObjectCaption, intSelectedValue, strTemp;

		objTextBox = GetObjectReference('frmIssueCustomFields','txtValue');
		 
		if(strValueType == 'C')
		{
			objListBox = GetObjectReference('frmIssueCustomFields','lstValue');
			objLabel = GetObjectReference('frmIssueCustomFields','lblSelectedValue');
		}
		else
			objListBox = GetObjectReference('frmIssueCustomFields','lstValueQ');
		strObjectCaption = "value";
		intSelectedValue = objListBox.selectedIndex;
		if(intSelectedValue < 0)
			return;
		objTextBox.value = objListBox.options[objListBox.selectedIndex].innerHTML;
		if(strValueType == 'Q')
		{
			objDefaultValue = GetObjectReference('frmIssueCustomFields','txtDefaultValue');
			
			
			if(navigator.appName == 'Netscape')
				objDefaultValue.value = objListBox.options[objListBox.selectedIndex].innerHTML;
			else
				objDefaultValue.value = objListBox.options[objListBox.selectedIndex].innerHTML;
			
		}
		else
		{
			strTemp = "";
			strTemp = "<%=Mybase.GetResourceString("SELECTED")%> " + strObjectCaption;
			strTemp = strTemp + " : <B>" + objListBox.options[objListBox.selectedIndex].innerHTML;
			strTemp = strTemp + "</B>&nbsp;&nbsp;&nbsp;|";
			strTemp = strTemp + "<A style='TEXT-DECORATION: none' HREF='javascript:SetAsDefault_OnClick()'>";
			strTemp = strTemp + "<FONT size=1 face=verdana color=black>";
			strTemp = strTemp + "<B><%=Mybase.GetResourceString("SETASDEFAULT")%></B>";
			strTemp = strTemp + "</FONT>";
			objLabel.innerHTML = strTemp + "</A>|";
			setFocus(objTextBox);
		}
	}
	
	// =============================== In Case of CustomCombo For setting Default Value For combo=====================//
	function SetAsDefault_OnClick()
	{
		var objListBox, objDefaultValue;
		objListBox = GetObjectReference('frmIssueCustomFields','lstValue');
		objDefaultValue = GetObjectReference('frmIssueCustomFields','txtDefaultValue');
		//For the combo box set the default value
		//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168
		objDefaultValue.value = objListBox.options[objListBox.selectedIndex].innerHTML;
	}
	
	function ShowHistory_OnClick(intTagID,intUniqueID,intProjectID)
	{
		 
		//'Modified By ShraddhaM on 12 Sep 2006 for SP7 Issue Id : 6208
		window.open("../General/CommonList.aspx?ShowHistory=1&MasterTagID=1500&IsSubTagID=0&TagID=" +intTagID+ "&UniqueID=" +intUniqueID+ "&ProjectID="+ intProjectID , "","resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");
	}
	
	// =============================== In Case of CustomCombo Depending on static values or Query Values enable/disable coresponding List and QueryText=====================//
	function optComboValue_Onclick()
	{
		var objoptComboValue, objDefaultValue, objValue;
		
		objoptComboValue = GetObjectReference('frmIssueCustomFields','optComboValue',true);
		objDefaultValue = GetObjectReference('frmIssueCustomFields','txtDefaultValue');
		
		if(objoptComboValue[1].checked == true)
        {
            //Commented And Added By Usha Pandit On 21.04.2020 For changing input control on option change
            //TRQueryText.style.display = "block";
            TRQueryText.style.display = "table-row";
            //End Of Added By Usha Pandit On 21.04.2020 For changing input control on option change
			divComboboxValues.style.display = "none";
			divQueryValues.style.display = "block"; 
			if(bitQuery == 0)
				objDefaultValue.value="";
			bitQuery=1;
		}
		else if(objoptComboValue[0].checked == true)
		{
			TRQueryText.style.display = "none" ;
			divComboboxValues.style.display = "block";
			divQueryValues.style.display = "none";
			if(bitQuery == 1)
			{
				objDefaultValue.value="";
				objValue = GetObjectReference('frmIssueCustomFields','txtValue');
				if(objValue != null)
					objValue.value="";
			}
			bitQuery=0;
		}
	}
	
	function optDefaultValue_Onclick()
	{
		var objDefaultValue;
		
		objDefaultValue = GetObjectReference('frmIssueCustomFields','optDefaultValue',true);
		if(objDefaultValue[0].checked == true)
		{
			TDCommonFieldDefaultValue.style.display = "none";
			TDStaticDefaultValue.style.display = "block";
		}
		else
		{
			TDCommonFieldDefaultValue.style.display = "block";
			TDStaticDefaultValue.style.display = "none";
		}
	}
	
	function AssignType_OnClick(strCustomFieldName)
	{
		window.open("IB_CustomFieldMaintenance.aspx?Mode=<%=MODE_ASSIGN_TYPES%>&MasterTagId=<%=m_lngTagId%>&CORP=<%=m_strPageCalledFrom%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&DatabaseFieldName=<%=m_strDBFieldName%>&EntityName=<%=m_strEntityName%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
	}

	// =============================== Save the Custom Field Details after validations=====================//
	function Save_OnClick()
	{
		var i, objAction;
		var objUserGivenCaption, objCFList, objFieldList, objRowNumber, objColumnNumber, objDataType;
		var objControlHeight, objControlWidth, objMaxLength, objMaxValue, objMinValue;
		var objOrderNoList, objDBFieldName, objlstValue, objoptComboValue, objDefaultValue;
		var objValidationRules, strValidation='', objQuery;
		objUserGivenCaption = GetObjectReference('frmIssueCustomFields','txtUserGivenCaption');
		if(disallowBlank(objUserGivenCaption, "<%=MyBase.GetResourceString("ENTERCONTROLCAPTION")%>"))
			return;
		if(isSubstringExists(objUserGivenCaption.value, ","))
		{
			alert("<%=Mybase.GetResourceString("COMMADISALLOWED")%>");
			setFocus(objUserGivenCaption);
			return;
		}

		if(isSubstringExists(Trim(objUserGivenCaption.value.toUpperCase()),'ORDER BY'))
		{
			alert("<%=Mybase.GetResourceString("CUSTOMFIELD_CAPTION_NOT_ORDERBY", False)%>");
			setFocus(objUserGivenCaption);
			return;
		}	

		objCFList = GetObjectReference('frmIssueCustomFields','txthidCFList');
		if(isSubstringExists("," + objCFList.value + "," , "," + objUserGivenCaption.value + ","))
		{
			alert(replaceSubstring("<%=Mybase.GetResourceString("CONTROLCAPTIONEXISTS")%>","<=>", objUserCaption.value));
			setFocus(objUserGivenCaption);
			return;
		}
		objFieldList = GetObjectReference('frmIssueCustomFields','txthidFieldList');
		if(isSubstringExists(objFieldList.value , "," + objUserGivenCaption.value + ","))
		{
			alert("'" + objUserGivenCaption.value + "' <%=Mybase.GetResourceString("STANDARDATTRIBUTE")%>");
			setFocus(objUserGivenCaption);
			return;
		}
		objDataType = GetObjectReference('frmIssueCustomFields','cboDataType');
		if(disallowBlank(objDataType, "<%=MyBase.GetResourceString("SELECTDATATYPE")%>"))
			return;
			
		objRowNumber = GetObjectReference('frmIssueCustomFields','txtRowNumber');
		if(disallowBlank(objRowNumber, "<%=MyBase.GetResourceString("ENTERROWNO")%>"))
			return;
		if(disallowNegativeInteger(objRowNumber, "<%=MyBase.GetResourceString("ENTERAPPROPRIATEVALUE")%>"))
			return;
		if(objRowNumber.value == 0)
		{
			alert("<%=MyBase.GetResourceString("ENTERAPPROPRIATEVALUE")%>");
			setFocus(objRowNumber);
			return;
		}			
		objColumnNumber = GetObjectReference('frmIssueCustomFields','txtColumnNumber');
		if(disallowBlank(objColumnNumber, "<%=MyBase.GetResourceString("ENTERCOLUMNNO")%>"))
			return;
		if(disallowNegativeInteger(objColumnNumber, "<%=MyBase.GetResourceString("ENTERAPPROPRIATEVALUE")%>"))
			return;
		
		if((objColumnNumber.value > 2)||(objColumnNumber.value <= 0))
		{
			alert("<%=Mybase.GetResourceString("COLUMNNUMBERRANGE")%>");
			setFocus(objColumnNumber);
			return;
		}
		objControlHeight = GetObjectReference('frmIssueCustomFields','txtControlHeight');
		if(disallowNegativeInteger(objControlHeight, "<%=MyBase.GetResourceString("ENTERAPPROPRIATEVALUE")%>"))
			return;

		objControlWidth = GetObjectReference('frmIssueCustomFields','txtControlWidth');
		if(disallowNegativeInteger(objControlWidth, "<%=MyBase.GetResourceString("ENTERAPPROPRIATEVALUE")%>"))
			return;

		objMaxLength = GetObjectReference('frmIssueCustomFields','txtMaxLength');
		if((objMaxLength != null) && (disallowNegativeInteger(objMaxLength, "<%=MyBase.GetResourceString("ENTERAPPROPRIATEVALUE")%>")))
			return;

		objMinValue = GetObjectReference('frmIssueCustomFields','txtMinValue');
		if((objMinValue != null) && (disallowNegativeInteger(objMinValue, "<%=MyBase.GetResourceString("VALID_MINIMUM_VALUE")%>")))
			return;

		objMaxValue = GetObjectReference('frmIssueCustomFields','txtMaxValue');
		if((objMaxValue != null) && (disallowNegativeInteger(objMaxValue, "<%=MyBase.GetResourceString("VALID_MAXIMUM_VALUE")%>")))
			return;
		
		objOrderNoList = GetObjectReference('frmIssueCustomFields','txthidOrderNoList');
		/*alert("objOrderNoList = " + objOrderNoList.value);
		alert("objRowNumber.value = " + objRowNumber.value);
		alert("objColumnNumber.value = " + objColumnNumber.value);
		alert(objRowNumber.value + objColumnNumber.value);*/
		
		if(isSubstringExists("," + objOrderNoList.value + "," , "," + objRowNumber.value + objColumnNumber.value + ","))
		{
			alert("<%=Mybase.GetResourceString("ROWCOLUMNEXISTS")%>");
			setFocus(objRowNumber);
			return;
		}
		objlstValue = GetObjectReference('frmIssueCustomFields','lstValue');
		objoptComboValue = GetObjectReference('frmIssueCustomFields','optComboValue',true);
		objDBFieldName = GetObjectReference('frmIssueCustomFields','txtDatabaseFieldName');
		if(isSubstringExists(objDBFieldName.value, "CustomFieldCombo"))
		{
			
			//Replace () with [] 
			if((objlstValue.length == 0) && (objoptComboValue[0].checked == true))
			{
				alert("<%=Mybase.GetResourceString("ADDATLEASTONEVALUE")%>");
				setFocus(objlstValue);
				return;
			}
		}
		objValidationRules = GetObjectReference('frmIssueCustomFields','txtValidationRules');
		objDefaultValue = GetObjectReference('frmIssueCustomFields','txtDefaultValue');
		if(objDataType.value == 1)
		if(disallowNonNumeric(objDefaultValue, "<%=Mybase.GetResourceString("DEFAULTVALUENUMERIC")%>"))
		return;
		if(isSubstringExists(objDBFieldName.value, "CustomFieldCombo"))
		{
			
			//Replace () with [] 
			if(objoptComboValue[0].checked == true)
			{
				
					for(i=0; i < objlstValue.length; i++)
				{
					if(isSubstringExists("," + objValidationRules.value + "," ,",3,")|| objDataType.value == 1)
					
					if (!isNumeric(objlstValue[i].value))
						{alert("<%=Mybase.GetResourceString("LISTVALUENUMERIC")%>"); return;}
							
				
				}	
			
			if(objDefaultValue.value != "")
			{
				for(i=0; i < objlstValue.length; i++)
				{
					
					//Replace () with [] 
					if(objlstValue[i].value == objDefaultValue.value)
						break;
				}
				if(i == objlstValue.length)
				{
					objDefaultValue.value = "";
					alert("<%=MyBase.GetResourceString("PROPERDEFAULTVALUE")%>");
					setFocus(objDefaultValue);
					return;
				}
			}
		  }	
		}
		
		if(objValidationRules)
			strValidation = "," + objValidationRules.value + ",";
		else
			strValidation = "";
		if((isSubstringExists(strValidation, ",18,")) || (isSubstringExists(strValidation, ",16,")) || (isSubstringExists(strValidation, ",17,")))
		{
			if(objDataType.value != 1)
			{
				alert("<%=MyBase.GetResourceString("DATATYPENUMERIC")%>");
				setFocus(objDataType);
				return;
			}
			if(isSubstringExists(strValidation, ",18,")==true)
			{
				if((objMinValue != null) && (disallowBlank(objMinValue, "<%=MyBase.GetResourceString("VALID_MINIMUM_VALUE")%>")))
					return;
				if((objMaxValue != null) && (disallowBlank(objMaxValue, "<%=MyBase.GetResourceString("VALID_MAXIMUM_VALUE")%>")))
					return;
			}
			else if(isSubstringExists(strValidation, ",16,")==true)
			{
				if((objMinValue != null) && (disallowBlank(objMinValue, "<%=MyBase.GetResourceString("VALID_MINIMUM_VALUE")%>")))
					return;
			}
			else if(isSubstringExists(strValidation, ",17,")==true)
			{
				if((objMaxValue != null) && (disallowBlank(objMaxValue, "<%=MyBase.GetResourceString("VALID_MAXIMUM_VALUE")%>")))
					return;
			}
		}
		
		if((objMaxLength != null) && (objMaxLength.value != ""))
		{
			if(isSubstringExists(objDBFieldName.value.toUpperCase(),"CUSTOMFIELDTEXTAREA") == true)
			{
				if(disallowValueRangeViolation(objMaxLength,1,3800, replaceSubstring("<%=Mybase.GetResourceString("MAXLENGTHRANGE")%>","<=MAX>", "3800")))
					return;
			}
			else if((objDBFieldName.value.toUpperCase() != "CUSTOMFIELDTEXTAREA1") && (objDBFieldName.value.toUpperCase() != "CUSTOMFIELDTEXTAREA2"))
			{
				if(disallowValueRangeViolation(objMaxLength, 1, 100, replaceSubstring("<%=Mybase.GetResourceString("MAXLENGTHRANGE")%>","<=MAX>", "100")))
					return;
			}
			
		}		
		if((objMinValue != null) && (objMaxValue != null) && (disallowValue1LessThanValue2(objMaxValue, objMinValue, "<%=Mybase.GetResourceString("MAXVALUEGREATERTHANMINVALUE")%>")))
			return;
		
		if((isSubstringExists(strValidation, ",12,")) && (isSubstringExists(objDBFieldName.value, "CustomFieldCombo")==false))
		{
			if((objMaxLength != null) && (disallowBlank(objMaxLength, "<%=MyBase.GetResourceString("ENTERMAXLENGTH")%>")))
				return;
		}
		
		if(isSubstringExists(objDBFieldName.value, "CustomFieldDate"))
		{
			if(isDate(objDefaultValue, "<%=MyBase.GetResourceString("DEFAULTVALUEASDATE")%>")==false)
				return;
		}
		
		objQuery = GetObjectReference('frmIssueCustomFields', 'txtQueryText');
		if(isSubstringExists(objDBFieldName.value, "CustomFieldCombo"))
		{
			
			//Replace () with [] 
			if(objoptComboValue[1].checked == true)
			{
				if(disallowBlank(objQuery, "<%=MyBase.GetResourceString("ENTERQUERYORSP")%>"))
					return;
				if(disallowMaxlengthViolation(objQuery, 1000, "<%=MyBase.GetResourceString("QUERYMAXSIZE")%>"))
					return;
				if(isSubstringExists(objQuery.value, "\""))
				{
					alert("<%=MyBase.GetResourceString("DOUBLEQUOTEDISALLOED")%>");
					setFocus(objQuery);
					return;
				}
			}
		}
		objUserGivenCaption.disabled = false;
		if(objMaxValue != null)
			objMaxValue.disabled = false;
		if(objMinValue != null)
			objMinValue.disabled = false;
		objDataType.disabled = false;
		objDBFieldName.disabled = false;
		objDefaultValue.disabled = false;
		for(i=0; i<objlstValue.length; i++)
			
			//Replace () with [] 
			objlstValue.options[i].selected = true;
		
		objAction = GetObjectReference('frmIssueCustomFields','txthidAction_CustomField');
		objAction.value = "<%=ACTION_SAVE%>";
		objForm.action = "IB_CustomFieldMaintenance.aspx?Mode=<%=MODE_DETAILS%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&DatabaseFieldName=<%=m_strDBFieldName%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&EntityName=<%=m_strEntityName%>";
		objForm.submit();
	}
<%End If%>
// ****=============================================================================================================//
// ****=============================================================================================================//

// =============================== Specific To Assign Type Mode =====================//
// =============================================================================================================//
<%If m_strMode = MODE_ASSIGN_TYPES%>
	<%If m_strAction = ACTION_SUCCESSFULLY_COMPLETED Then%>
		window.close();
	<%End If%>
	
	function Save_OnClick()
	{
		var objAction;
		objAction = GetObjectReference('frmTaskCustomeFields','txthidAction_CustomField');
		objAction.value = "<%=ACTION_SAVE%>";
		objForm.action = "IB_CustomFieldMaintenance.aspx?Mode=<%=MODE_ASSIGN_TYPES%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&DatabaseFieldName=<%=m_strDBFieldName%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&EntityName=<%=m_strEntityName%>";
		objForm.submit();
	}
<%End If%>
// ****=============================================================================================================//
// ****=============================================================================================================//

// =============================== Specific To Custom Field List Mode =====================//
// =============================================================================================================//
<%If m_strMode = MODE_LIST%>
	<%=m_strClientSideScript%>
	function Save_OnClick()
	{
		var objAction;
		objAction = GetObjectReference('frmTaskCustomeFields','txthidAction_CustomField');
		objAction.value = "<%=ACTION_SAVE%>";
		objForm.action = "IB_CustomFieldMaintenance.aspx?Mode=<%=MODE_LIST%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&DatabaseFieldName=<%=m_strDBFieldName%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&EntityName=<%=m_strEntityName%>";
		objForm.submit();
	}
	
	function Delete_OnClick()
	{
		var objchkDelete, blnSelected, intCnt, objAction;
		
		objchkDelete = GetObjectReference('frmTaskCustomeFields', 'chkDelete', true);
		if(objchkDelete == null)
		{
			alert("<%=MyBase.GetResourceString("SELECT_RECORDS_FOR_DELETION")%>");
			return;
		}
		blnSelected = false;
		if(objchkDelete.length == 1)
		{
			objchkDelete = GetObjectReference('frmTaskCustomeFields', 'chkDelete');
			if(objchkDelete.checked == true)
				blnSelected = true;
		}
		else if(objchkDelete.length > 1)
		{
			for(intCnt=0; ((intCnt < objchkDelete.length) && (blnSelected == false)); intCnt++)
			{
				
				if(objchkDelete[intCnt].checked == true)
					blnSelected = true;
			}
		}
		if(blnSelected == false)
		{
			alert("<%=MyBase.GetResourceString("SELECT_RECORDS_FOR_DELETION")%>");
				return;
		}
		if(confirm("<%=MyBase.GetResourceString("CONFIRMDELETE")%>"))
		{
			objAction = GetObjectReference('frmTaskCustomeFields','txthidAction_CustomField');
			objAction.value = "<%=ACTION_DELETE%>";
			objForm.action = "IB_CustomFieldMaintenance.aspx?Mode=<%=MODE_LIST%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&DatabaseFieldName=<%=m_strDBFieldName%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&EntityName=<%=m_strEntityName%>";
			objForm.submit();
		}
	}
	function Entity_Onchange(strValue)
	{
		objForm.action = "IB_CustomFieldMaintenance.aspx?Mode=<%=MODE_LIST%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&DatabaseFieldName=<%=m_strDBFieldName%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&EntityName=" + strValue ;
		objForm.submit();		
	
	}
	function Sort_OnClick(strFieldName, strAscOrDesc)
	{
		objForm.action = "IB_CustomFieldMaintenance.aspx?Mode=<%=MODE_LIST%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&DatabaseFieldName=<%=m_strDBFieldName%>&txthidSortBy=" + strFieldName + "&txthidSortOrder=" + strAscOrDesc + "&EntityName=<%=m_strEntityName%>" ;
		objForm.submit();		
	}
	
	function CustomField_OnClick(strFieldName,UID)
	{
        //Commented and added by Nilesh g on 8/8/2016 Purpose: Pktoken Generartion
		//objForm.action = "IB_CustomFieldMaintenance.aspx?Mode=<%=MODE_DETAILS%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&DatabaseFieldName=" + strFieldName + "&UniqueID=" + UID + "&EntityName=<%=m_strEntityName%>";
	    //objForm.submit();
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'IB_CustomFieldMaintenance.aspx/GenrateURLToken',
	        data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>", strFieldName: strFieldName, UID:UID,MasterTagId:"<%=m_lngTagId%>"}),
	        success: function (Result) {
	            objForm.action = "IB_CustomFieldMaintenance.aspx?Pktoken="+Result.d+"&Mode=<%=MODE_DETAILS%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&DatabaseFieldName=" + strFieldName + "&UniqueID=" + UID + "&EntityName=<%=m_strEntityName%>&FromWhere=ProjectSetting";
	            objForm.submit();
                },
			        error: function () {
			            // alert("Error")
			        }
          });
	    //end of Commented and added by Nilesh g on 8/8/2016 Purpose: Pktoken Generartion
	}
	
	function Add_To_Project_OnClick(strFieldName)
	{
		var objAction;
		objAction = GetObjectReference('frmTaskCustomeFields','txthidAction_CustomField');
		objAction.value = "<%=ACTION_ADD_CORPORATE_CUSTOMFIELD_TO_PROJECT%>";
		objForm.action = "IB_CustomFieldMaintenance.aspx?Mode=<%=MODE_LIST%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&DatabaseFieldName=" + strFieldName + "&EntityName=<%=m_strEntityName%>";
		objForm.submit();
	}	
<%End If%>
// ****=============================================================================================================//
// ****=============================================================================================================//
function ConfigureAccess_OnClick(UID)
{
	var objTxt;
	var strUID;
	objTxt = GetObjectReference('frmTaskCustomeFields','txthidUniqueID');
	if(objTxt!=null)
		strUID=objTxt.value;
	else
		strUID=UID;
			
	if(strUID <= 0 || strUID=='')
	{
		alert("<%=MyBase.GetResourceString("MSG_FIELD_NOT_SELECTED")%>");
		return;
	}
	   //Modified by vidyak on 30 Aug 2010 --TAGID 20011 Changed to 2626
	window.open("../IB/IB_CustomField_RoleAccess_CommonList.aspx?CustomFieldID=" + strUID + "&MasterTagId=2626&EntityName=<%=m_strEntityName%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
}

</script>
        <!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

		<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
		<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
		<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function()
    {
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0)
        {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if($('.clsgridtable').length > 0)
        {
            var divName=$('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
            dataCollapse(divName);
        }
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on document Ready
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenu();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth=$(window).width();
        if(windowWidth < 992 )
        {
            //added by Bharat T on 25th-Nov-2015 for Sem issue
            $('.clsTable:last').css({ 'display': 'none' });
            //End of added by Bharat T on 25th-Nov-2015 for Sem issue
        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass='responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass='gridTabsOuterTable';
        if(windowWidth < 992)
        {
            responsiveNavigationTabs(responsiveNavigationClass,responsiveNavigationParentTblClass);
        }
        else
        {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display','block');
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        $('#divPage').find('#divSection1').find('table:first').addClass('detailInfo');
        $('#divPage').find('#divSection1').find('#tblInnerDiv').removeClass('detailInfo');

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function(){
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Top Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Footer InnerMenuDropDown
        // Description:Creating DropDown for Footer Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:10/02/2015
        /*---------------------------------------------------------*/
        responsiveFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Footer InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-InnerMenuDropDown
        // Description:Creating DropDown for Sub Table Inner Menu on Window Resize
        // By Whom: Miiint
        // When:14/01/2015
        /*---------------------------------------------------------*/
        responsiveSubTableTopMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-InnerMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-FooterMenuDropDown
        // Description:Creating DropDown for Sub Table Footer Menu on Window Resize
        // By Whom: Miiint
        // When:28/05/2015
        /*---------------------------------------------------------*/
        responsiveSubTableFooterMenuResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-FooterMenuDropDown
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Remove footer
        // Description:Display none footer in Tablet and Mobile view
        // By Whom: Miiint
        // When:16/01/2015
        /*---------------------------------------------------------*/
        /* Display none footer in Tablet and Mobile view*/

        var windowWidth=$(window).width();
        if(windowWidth < 992)
        {
            $('.clsTable:last').css({ 'display': 'none' });
        }
        else
        {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({'float':'none','margin-bottom':'0px'});

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        responsiveNavigationTabsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Responsive Navigation Tabs
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-collapse & close for tablet view
        // Description:to solve select all issue, expanding first time & then again closing div for tablet view on Window Resize
        // By Whom: Miiint
        // When:17/02/2015
        /*---------------------------------------------------------*/
        collapseDivsResize();
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-collapse & close for tablet view
        /*---------------------------------------------------------*/

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        // Description:removing plus sign with footable functionality for 'Total' column
        // By Whom: Miiint
        // When:27/04/2015
        /*---------------------------------------------------------*/

        if(windowWidth < 1040)
        {
            var text=$('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if(text=="Total")
            {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display','none');
                $('#tblGrid1053121').find('tr:last').css('display','none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->
