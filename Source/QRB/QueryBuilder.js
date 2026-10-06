/* 
===================================================================
Author: Rajanikant Khethawatt
Description:This file is needed by QRB_QueryBuilder.aspx and must be
			present in the Source/QRB/ folder!
			***IMP: variables are being set on the QRB_QueryBuilder.aspx page
Modified:	May 23 2005 For browser support of netscape
			Issue ID#18878
===================================================================
*/
var objform;
var objdivlist;
var objchkField;
var objtxtValue;
var objcboFields;
var objcboFields2;
var objlinkValidInputs;
var objtxtWhereClause;
var objtxtHiddenWhereClause;
var objtxtUndo;
var objtxtUndo2;
var objtxtRedo;
var objtxtRedo2;
var objcboOperators;
var objcboHiddenFields;

var objtxtQueryName;

var objlstView_FieldList;
var objlstView_SelectedFields;

var objlstSort_FieldList;
var objlstSort_SelectedFields;

var objlstGroupBy_FieldList;
var objlstGroupBy_SelectedFields;

var objcboFunction;
var objchkDynamicField;

var intTotalCount;
var intPlaceHolderCount;

var arrInputs;
var arrDataTypes;
var arrValues;
var arrUFValues;
var arrAttributeID;

var arrPlaceHolders;
var arrPlaceHolderDataTypes;

var blnIsOracleDB;

var DraftQueryMsg;

//-------------------------------------------------------------------
// InsertBeforeItem(objListBox,currentindex,wheretoinsertIndex)
//   inserts the item to the position
//-------------------------------------------------------------------
function InsertBeforeItem(objListBox,intItemIndex,intWhereIndex)
{
	var objNode;
				
	if (intItemIndex < 0 || intItemIndex >= objListBox.length) return;
						
	if (intWhereIndex < 0 || intWhereIndex > objListBox.length) return;
				
	objNode = objListBox.options[intItemIndex];
	if (intWhereIndex != objListBox.length)
	{
		//modified May 23,05 RajK #BI_60
		objListBox.insertBefore(objNode, objListBox.options[intWhereIndex]);
		//end modification May 23,05 RajK #BI_60
	}
	else
	{
		//modified May 23,05 RajK #BI_60
		//objListBox.insertBefore(objNode);
		objListBox.insertBefore(objNode, objListBox.options[objListBox.length]);
		//end modification May 23,05 RajK #BI_60
	}
}
//-------------------------------------------------------------------
// MoveToTop(objListBox)
//   moves the selected items to top most position of the list box
//-------------------------------------------------------------------
function MoveToTop(objListBox)
{
	var intCtr;
	var intIndex;
			
	intIndex = 0;
	if (objListBox.selectedIndex == -1) return;
					
	for (intCtr = objListBox.selectedIndex; intCtr < objListBox.length;intCtr++)
	{
		if (objListBox.options[intCtr].selected == true)
		{
			InsertBeforeItem(objListBox, intCtr, intIndex);
			intIndex = intIndex + 1;
		}
	}
}

//-------------------------------------------------------------------
// MoveUpBy1(objListBox)
//   moves the selected item up 1 position
//-------------------------------------------------------------------
function MoveUpBy1(objListBox)
{
	var intCtr;
	if (objListBox.selectedIndex == -1) return; 
	if (objListBox.selectedIndex == 0) return; 

	for (intCtr=objListBox.selectedIndex;intCtr<objListBox.length;intCtr++)
	{
		if (objListBox.options[intCtr].selected == true)
		{
			InsertBeforeItem(objListBox, intCtr, intCtr - 1);
		}
	}
}

//-------------------------------------------------------------------
// MoveDownBy1(objListBox)
//   moves the selected items to one position down
//-------------------------------------------------------------------
function MoveDownBy1(objListBox)
{
	var intCtr;
	if (objListBox.selectedIndex == -1) return;
	if (objListBox.options[objListBox.length - 1].selected == true) return;
			
	for (intCtr=objListBox.length - 1;intCtr>=objListBox.selectedIndex;intCtr--) 
	{
		if (objListBox.options[intCtr].selected == true)
		{
			InsertBeforeItem(objListBox, intCtr, intCtr + 2);
		}
	}
}	

//-------------------------------------------------------------------
// MoveToBottom(objListBox)
//   moves the selected items to bottom most position of the list box
//-------------------------------------------------------------------
function MoveToBottom(objListBox)
{
	var intCtr;
	intCtr = 0;
		
	while (objListBox.selectedIndex != -1 && objListBox.selectedIndex < (objListBox.length - intCtr)) 
	{
		InsertBeforeItem(objListBox, objListBox.selectedIndex, objListBox.length);
		intCtr = intCtr + 1;
	}
}

function lstView_FieldList_onfocus()
{
	objlstView_SelectedFields.selectedIndex = -1;
}		
			
function lstView_FieldList_OnDblClick() 								
{
	MoveSelectedTo(objlstView_FieldList, objlstView_SelectedFields);
}
			
function lstView_SelectedFields_onfocus()
{
	objlstView_FieldList.selectedIndex = -1;
}

function lstView_SelectedFields_OnDblClick() 						
{
	MoveSelectedTo(objlstView_SelectedFields, objlstView_FieldList);
}
					
function btnView_AddSelected_OnClick()
{
	MoveSelectedTo(objlstView_FieldList, objlstView_SelectedFields);
}
			
function btnView_RemoveSelected_OnClick()
{
	MoveSelectedTo(objlstView_SelectedFields, objlstView_FieldList);
}
			
function btnView_AddAll_OnClick() 
{
	MoveAllTo(objlstView_FieldList, objlstView_SelectedFields );							
}
			
function btnView_RemoveAll_OnClick() 
{
	MoveAllTo(objlstView_SelectedFields, objlstView_FieldList);
}
			
function btnView_MoveToTop_OnClick()	
{		
	MoveToTop(objlstView_SelectedFields);
}
			
function btnView_MoveUpBy1_OnClick()		
{
	MoveUpBy1(objlstView_SelectedFields);
}
			
function btnView_MoveDownBy1_OnClick()			
{
	MoveDownBy1(objlstView_SelectedFields);
}
			
function btnView_MoveToBottom_OnClick()
{
	MoveToBottom(objlstView_SelectedFields);
}

//sort listboxes
function lstSort_FieldList_onfocus()
{
	objlstSort_SelectedFields.selectedIndex = -1;
}		
			
function lstSort_FieldList_OnDblClick() 								
{
	MoveSelectedTo(objlstSort_FieldList, objlstSort_SelectedFields);
}
			
function lstSort_SelectedFields_onfocus()
{
	objlstSort_FieldList.selectedIndex = -1;
}

//-------------------------------------------------------------------
// lstSort_SelectedFields_OnDblClick()
//   on double click the order is changed ASC to DESC & vice-versa
//-------------------------------------------------------------------
function lstSort_SelectedFields_OnDblClick() 						
{

	var objListBox;
	var objListBox1;
	var strInnerText;
	var strValue;
				
	objListBox = objlstSort_SelectedFields;
	
	if (objListBox.selectedIndex == -1)
	{
		return;
	}

	//modified May 23,05 RajK #BI_60
	if(navigator.appName != 'Microsoft Internet Explorer')
		strInnerText = objListBox.options[objListBox.selectedIndex].innerHTML;
	else
		strInnerText = objListBox.options(objListBox.selectedIndex).innerText;
	//strInnerText = objListBox.options(objListBox.selectedIndex).innerText;
	//end modification May 23,05 RajK #BI_60
	
	strValue = objListBox.options[objListBox.selectedIndex].value;
	if (isSubstringExists(strInnerText," ASC"))
	{
		strInnerText = Left(strInnerText, strInnerText.length - 4) + " DESC";
		strValue = Left(strValue, strValue.length-4 ) + " DESC";									
	}		
	else
	{
		strInnerText = Left(strInnerText, strInnerText.length - 5) + " ASC";
		strValue = Left(strValue, strValue.length-5 ) + " ASC";						
	}
	//modified May 23,05 RajK #BI_60
	//objListBox.options(objListBox.selectedIndex).innerText = strInnerText
	if(navigator.appName != 'Microsoft Internet Explorer')
		objListBox.options[objListBox.selectedIndex].innerHTML = strInnerText;
	else
		objListBox.options(objListBox.selectedIndex).innerText = strInnerText;
		
	objListBox.options[objListBox.selectedIndex].value = strValue;
	//end modification May 23,05 RajK #BI_60
}
				
function btnSort_AddSelected_OnClick()
{
	MoveSelectedTo(objlstSort_FieldList, objlstSort_SelectedFields);
}
			
function btnSort_RemoveSelected_OnClick()
{
	MoveSelectedTo(objlstSort_SelectedFields, objlstSort_FieldList);
}
			
function btnSort_AddAll_OnClick() 
{
	MoveAllTo(objlstSort_FieldList, objlstSort_SelectedFields );							
}
			
function btnSort_RemoveAll_OnClick() 
{
	MoveAllTo(objlstSort_SelectedFields, objlstSort_FieldList);
}
			
function btnSort_MoveToTop_OnClick()	
{		
	MoveToTop(objlstSort_SelectedFields);
}
			
function btnSort_MoveUpBy1_OnClick()		
{
	MoveUpBy1(objlstSort_SelectedFields);
}
			
function btnSort_MoveDownBy1_OnClick()			
{
	MoveDownBy1(objlstSort_SelectedFields);
}
			
function btnSort_MoveToBottom_OnClick()
{
	MoveToBottom(objlstSort_SelectedFields);
}

//group
function lstGroupBy_FieldList_onfocus()
{
	objlstGroupBy_SelectedFields.selectedIndex = -1;
}		
			
function lstGroupBy_FieldList_OnDblClick() 								
{
	MoveSelectedTo(objlstGroupBy_FieldList, objlstGroupBy_SelectedFields);
}
			
function lstGroupBy_SelectedFields_onfocus()
{
	objlstGroupBy_FieldList.selectedIndex = -1;
}

function lstGroupBy_SelectedFields_OnDblClick() 						
{
	MoveSelectedTo(objlstGroupBy_SelectedFields, objlstGroupBy_FieldList);
}
					
function btnGroupBy_AddSelected_OnClick()
{
	MoveSelectedTo(objlstGroupBy_FieldList, objlstGroupBy_SelectedFields);
}
			
function btnGroupBy_RemoveSelected_OnClick()
{
	MoveSelectedTo(objlstGroupBy_SelectedFields, objlstGroupBy_FieldList);
}
			
function btnGroupBy_AddAll_OnClick() 
{
	MoveAllTo(objlstGroupBy_FieldList, objlstGroupBy_SelectedFields );							
}
			
function btnGroupBy_RemoveAll_OnClick() 
{
	MoveAllTo(objlstGroupBy_SelectedFields, objlstGroupBy_FieldList);
}
			
function btnGroupBy_MoveToTop_OnClick()	
{		
	MoveToTop(objlstGroupBy_SelectedFields);
}
			
function btnGroupBy_MoveUpBy1_OnClick()		
{
	MoveUpBy1(objlstGroupBy_SelectedFields);
}
			
function btnGroupBy_MoveDownBy1_OnClick()			
{
	MoveDownBy1(objlstGroupBy_SelectedFields);
}
			
function btnGroupBy_MoveToBottom_OnClick()
{
	MoveToBottom(objlstGroupBy_SelectedFields);
}



//-------------------------------------------------------------------
// Append_OnClick()
//   Appends the filter condition to where clause text areas
//-------------------------------------------------------------------
function Append_OnClick()
{
	var iCountI;
	var iCountJ;
	var arrTemp;
	var bValid;
	var sValue;
	var sTemp;
	var sFieldValue;
	var sFieldValue2;
	var sDataType_First;
	var sDataType_Second;
	var intTotalCount;
	var temp;
	var sPlaceHolder_DataType;
	
	//Modified by Vinay on 30 Sept. 2008, Should support for Mozilla Firefox
    var strInnerTextcboField="";
    if ( navigator.appName !='Microsoft Internet Explorer') 
    {
     strInnerTextcboField =objcboHiddenFields[objcboFields.selectedIndex].innerHTML; 
    }
    else 
    {
    strInnerTextcboField =objcboHiddenFields(objcboFields.selectedIndex).innerText;
    }
    //Modification End by Vinay on 30 Sept. 2008, Should support for Mozilla Firefox
	sDataType_First= "";
	sDataType_Second ="";
	sPlaceHolder_DataType = "";
	
	//attribute must be selected
	if (trimString(objcboFields.value) =="" ) 
	{
		alert("Please select an attribute");
		objcboFields.focus(); 
		return;
	}			
	
	// operator must be selected
	if (trimString(objcboOperators.value) =="" ) 
	{
		alert("Please select an operator");
		objcboFields.focus(); 
		return;
	}	
			
	if (objchkField.checked == false)
	{
		//check for value
		if (trimString(objtxtValue.value) == "")
		{
			alert("Please enter the value");
			objtxtValue.focus(); 
			return;
		}
		// get the data type for the place holder(if place holder is being used)
		intTotalCount = arrPlaceHolders.length;//UJ_31052007
		for (iCountJ=0;iCountJ<intTotalCount;iCountJ++)
		{
			if (isSubstringExists(objtxtValue.value,arrPlaceHolders[iCountJ]))
			{
				sPlaceHolder_DataType = arrPlaceHolderDataTypes[iCountJ];
				break;
			}
		}
	}
	else
	{	
		//comparison with another attrib is beign done
		if (trimString(objcboFields2.value) == "")
		{
			alert("Please select the value attribute.");
			objcboFields2.focus; 
			return;
		}
		
		//get the first attrib data type
		intTotalCount = arrUFValues.length;//UJ_31052007
		for (iCountI = 0;iCountI<intTotalCount;iCountI++)
		{
			if (trimString(arrUFValues[iCountI]) == trimString(objcboFields.value)) 
			{
				sDataType_First = arrDataTypes[iCountI];
				break;
			}
		}
		
		//get the second attrib data type
		for (iCountI = 0;iCountI<intTotalCount;iCountI++)
		{
			if (trimString(arrUFValues[iCountI]) == trimString(objcboFields2.value)) 
			{
				sDataType_Second = arrDataTypes[iCountI];
				break;
			}
		}
		
		//check for data type compatibility of two attribs compared 
		switch(true)
		{
		case ((trimString(sDataType_First)==3) || (trimString(sDataType_First)==4) ||(trimString(sDataType_First)==5)||(trimString(sDataType_First)==6)||(trimString(sDataType_First)==11)):
				switch(true)
				{
				case ((trimString(sDataType_Second)==3) || (trimString(sDataType_Second)==4) ||(trimString(sDataType_Second)==5)||(trimString(sDataType_Second)==6)||(trimString(sDataType_Second)==11)):
					break;
				default:
					alert("Invalid comparison! The attributes are of different data types!");
					return;
					break;
				}
				break;
		case (trimString(sDataType_First)==135):
				switch(true)
				{
				case (trimString(sDataType_Second)==135):
					break;
				default:
					alert("Invalid comparison! The attributes are of different data types!");
					return;
					break;
				}
				break;
		default:
				switch(true)
				{
				case ((trimString(sDataType_Second)==3) || (trimString(sDataType_Second)==4) ||(trimString(sDataType_Second)==5)||(trimString(sDataType_Second)==6)||(trimString(sDataType_Second)==11)||(trimString(sDataType_Second)==135)):
					alert("Invalid comparison! The attributes are of different data types!");
					return;
					break;
				}
				break;
		}
	
	}	
	
	//check if AND , OR is used for next filter
	if (trimString(objtxtWhereClause.value) != "")
	{
		temp = trimString(objtxtWhereClause.value);
		arrTemp = temp.split(" ");
		intTotalCount = arrTemp.length - 1;
		// May 21,2004 Rajanikant Modified	
		if (trimString(arrTemp[intTotalCount])!= "AND" && trimString(arrTemp[intTotalCount])!= "OR" && trimString(arrTemp[intTotalCount]) != "(" && trimString(arrTemp[intTotalCount]) != ")" )
		{
			alert("Please select a join condition (AND,OR)");
			return;
		}
		//end modification May 21,2004
	}
	bValid = false;

	// get the actual value of the first field
	intTotalCount = arrUFValues.length - 1;
	for (iCountJ=0;iCountJ<=intTotalCount;iCountJ++)
	{ 
		if (trimString(arrUFValues[iCountJ]) == trimString(objcboFields.value))
		{
			sFieldValue = trimString(arrValues[iCountJ]);
			break;
		}
	}
	
	//get the actual value of second attrib (text or combo value)
	if (trimString(arrValues[iCountJ])== trimString(sFieldValue))
	{
		//check if the attrib is bound by valid inputs
		if (trimString(arrInputs[iCountJ]) != "" )
		{
			temp = arrInputs[iCountJ];
			arrTemp = temp.split(",");
						// May 21,2004 Rajanikant Modified
			intTotalCount = arrTemp.length;
			for (iCountI=0;iCountI<intTotalCount;iCountI++)
			{ 
				if (trimString(objtxtValue.value).toUpperCase() == trimString(arrTemp[iCountI]).toUpperCase())
				{
					bValid = true;
					if (objchkField.checked == true)
					{
						if (arrDataTypes[iCountJ]==3 || arrDataTypes[iCountJ]==4 || arrDataTypes[iCountJ]==5 || arrDataTypes[iCountJ]==11 || arrDataTypes[iCountJ]==6)
						{
						sValue = replaceSubstring(trimString(objcboFields2.value ),"'","''");
						}
						else
						{
						// modified July 11 2005 issue# 19929, Rajk
						// append N for DBCS support
						sValue = "N'" + replaceSubstring(trimString(objcboFields2.value ),"'","''") + "'"; 
						// end modification July 11 2005 issue# 19929, Rajk
						}
					}
					else
					{
						if (arrDataTypes[iCountJ]==3 || arrDataTypes[iCountJ]==4 || arrDataTypes[iCountJ]==5 || arrDataTypes[iCountJ]==11 || arrDataTypes[iCountJ]==6)
						{
						sValue = replaceSubstring(trimString(objtxtValue.value ),"'","''");
						}
						else
						{
						// modified July 11 2005 issue# 19929, Rajk
						// append N for DBCS support
						sValue = "N'" + replaceSubstring(trimString(objtxtValue.value ),"'","''") + "'"; 
						// end modification July 11 2005 issue# 19929, Rajk
						}
					}
					break;
				}
			}
			// End Modification May 21,2004 Rajanikant

			
			// no valid inputs were found return
			if (bValid == false)
			{
				alert("The value entered for the attribute is invalid!!\r\nThe valid inputs are " + arrInputs[iCountJ]);
				return;
			}
		}
	}
	
	
	// lets validate the value enetered in txtValue for the attrib 1
	if (bValid == false)
	{
		if (objchkField.checked == false)
		{
			intTotalCount = arrValues.length;
			for (iCountI=0;iCountI<intTotalCount;iCountI++)
			{		
				
				intTotalCount = arrUFValues.length;
				for (iCountJ=0;iCountJ<intTotalCount;iCountJ++)
				{
					if (trimString(arrUFValues[iCountJ]) == trimString(objcboFields.value))
					{
						sFieldValue = trimString(arrValues[iCountJ]);
						break;
					}
				}
				if (trimString(arrValues[iCountI])== trimString(sFieldValue))
				{
					switch(true)
					{
					case ((trimString(arrDataTypes[iCountI])==4) || (trimString(arrDataTypes[iCountI])==3)|| (trimString(arrDataTypes[iCountI])==5)):
						switch(true)
						{
						case (trimString(objtxtValue.value)== "NULL"):
							sValue = replaceSubstring(trimString(objtxtValue.value) ,"'","''");
							break;
						default:
							// check if placeholder data type is compatible
							if (sPlaceHolder_DataType!=3 && sPlaceHolder_DataType!=4  && sPlaceHolder_DataType!=5) 
							{
								if (disallowNonNumeric(objtxtValue,"Please enter a numeric value")) return;
							}
							sValue = replaceSubstring(trimString(objtxtValue.value ),"'","''");
							break;
						}
						break;
					case ((trimString(arrDataTypes[iCountI])==135)):
						switch(true)
						{
						case ((trimString(objtxtValue.value)== "NULL") || (isSubstringExists(trimString(objtxtValue.value),"GETDATE()"))):
							sValue = replaceSubstring(trimString(objtxtValue.value ),"'","''");
							break;
						default:
							sValue = "'" + replaceSubstring(trimString(objtxtValue.value ),"'","''") + "'";
							break;
						}
						break;
					case ((trimString(arrDataTypes[iCountI])==11)):
						switch(true)
						{
						case (trimString(objtxtValue.value)== "NULL"):
							sValue = replaceSubstring(trimString(objtxtValue.value ),"'","''");
							break;
						default:
							if (trimString(objtxtValue.value)!= "0" && trimString(objtxtValue.value)!= "1")
							{
									alert("The value expected is a bit value.Valid inputs are '1','0'");
									return;
								
							}
							
							sValue = "'" + replaceSubstring(trimString(objtxtValue.value ),"'","''") + "'";
							
							break;
						}
						break;
					default:
						switch(true)
						{
						case ((trimString(objtxtValue.value)== "NULL") || (isSubstringExists(trimString(objtxtValue.value),"GETDATE()")) || (isSubstringExists(trimString(objtxtValue.value),"DATEDIFF("))|| (isSubstringExists(trimString(objtxtValue.value),"DATENAME("))):
							sValue = replaceSubstring(trimString(objtxtValue.value ),"'","''");
							break;
						default:
							// modified July 11 2005 issue# 19929, Rajk
							// append N for DBCS support
							sValue = "N'" + replaceSubstring(trimString(objtxtValue.value ),"'","''") + "'";
							// end modification July 11 2005 issue# 19929, Rajk
							break;
						}
						break;
					}
				}
			}
		}
		else
		{
			intTotalCount = arrUFValues.length - 1;
			for (iCountJ=0;iCountJ<=intTotalCount;iCountJ++)
			{ 
				if (trimString(arrUFValues[iCountJ]) == trimString(objcboFields.value))
				{
					sFieldValue = trimString(arrValues[iCountJ]);
					break;
				}
			}
			
			for (iCountJ=0;iCountJ<=intTotalCount;iCountJ++)
			{ 
				if (trimString(arrUFValues[iCountJ]) == trimString(objcboFields2.value))
				{
					sValue = trimString(arrValues[iCountJ]);
					break;
				}
			}

		}
	
	}
	
	//finally append the values to the where clause text boxes
	if (objchkDynamicField.checked==true)
	{
		//dynamic field entry
		if (objchkField.checked ==false)
		{
			objtxtWhereClause.value = objtxtWhereClause.value + "   @" +  objcboFields.value + "  @" + objcboOperators.value + " @" + sValue;
			sTemp = objtxtUndo.value;
			sTemp = sTemp + "&&" + "  @"  + objcboFields.value + " @" + objcboOperators.value + "  @" + sValue;
			objtxtUndo.value = sTemp;
		}
		else
		{
			objtxtWhereClause.value = objtxtWhereClause.value + "   @" +  objcboFields.value + "  @" + objcboOperators.value + " @" + objcboFields2.value;
			sTemp = objtxtUndo.value;
			sTemp = sTemp + "&&" + "  @"  + objcboFields.value + " @" + objcboOperators.value + "  @" + objcboFields2.value;
			objtxtUndo.value = sTemp;
		}
		objtxtHiddenWhereClause.value = objtxtHiddenWhereClause.value + "   @" +  strInnerTextcboField + "  @" + objcboOperators.value + " @" + sValue  + "  /*" +  strInnerTextcboField + "   " +  objcboOperators.value + "  " + "#*/  ";
		
		sTemp = objtxtUndo2.value;
		sTemp = sTemp + "&&" + "   @" +  strInnerTextcboField + "  @" + objcboOperators.value + " @" + sValue  + "  /*" +  strInnerTextcboField + "  " + objcboOperators.value + "  " + "#*/  ";
		objtxtUndo2.value = sTemp;
	
		objchkDynamicField.checked = false;
	}
	else
	{		
		//normal entry
		if (objchkField.checked == false)
		{				
			objtxtWhereClause.value = objtxtWhereClause.value + " " +  objcboFields.value + " " + objcboOperators.value + " " + sValue;
			sTemp = objtxtUndo.value;
			sTemp = sTemp + "&&" +  objcboFields.value + " " + objcboOperators.value + "  " + sValue;
			objtxtUndo.value = sTemp;
			sTemp = objtxtUndo2.value;
			sTemp = sTemp + "&&" +  strInnerTextcboField + " " + objcboOperators.value + " " + sValue;
			objtxtUndo2.value = sTemp;
			objtxtHiddenWhereClause.value = objtxtHiddenWhereClause.value + " " +  strInnerTextcboField + " " + objcboOperators.value + " " + sValue;
		}	
		else
		{				
			objtxtWhereClause.value = objtxtWhereClause.value + " " +  objcboFields.value + " " + objcboOperators.value + " " + objcboFields2.value ; 
			sTemp = objtxtUndo.value;
			sTemp = sTemp + "&&" +  objcboFields.value + " " + objcboOperators.value + " " + objcboFields2.value; 
			objtxtUndo.value = sTemp;
			sTemp = objtxtUndo2.value;
			sTemp = sTemp + "&&" +  strInnerTextcboField + " " + objcboOperators.value + " " + sValue;
			objtxtUndo2.value = sTemp;
			objtxtHiddenWhereClause.value = objtxtHiddenWhereClause.value + " " +  strInnerTextcboField + " " + objcboOperators.value + " " +  sValue;
		}
	}	
}


//-------------------------------------------------------------------
// Insert_OnClick(char)
//   Appends the character to the where clause text areas
//-------------------------------------------------------------------
function Insert_OnClick(sChar)
{
	var arrTemp = new Array();
	var intTotalCount;
	var WhereClause;
	
	if ((trimString(sChar) != ")") && (trimString(sChar) != "("))
	{
		if (trimString(objtxtWhereClause.value) != "") 
		{
			WhereClause = trimString(objtxtWhereClause.value);
			arrTemp = WhereClause.split(" ");
			intTotalCount = arrTemp.length - 1;
			if ((trimString(arrTemp[intTotalCount]) == "OR") || (trimString(arrTemp[intTotalCount]) == "AND" ))
			{
			alert("Please enter a filter condition!");
				return;
			}
		}
		else
		{
			alert("Please enter a filter condition!");
			return;
		}
	}
	objtxtWhereClause.value = objtxtWhereClause.value + " " + sChar + " ";
	objtxtHiddenWhereClause.value = objtxtHiddenWhereClause.value + " " + sChar + " ";
			
	objtxtUndo.value  = objtxtUndo.value  + "&&" +  sChar;
	objtxtUndo2.value  = objtxtUndo2.value + "&&" +  sChar;		
}

//-------------------------------------------------------------------
// Redo_OnClick()
//   The last UNDONE action is redone
//Modified By Ninad on 16 Feb IssueID 27367
//-------------------------------------------------------------------
function ReDo_OnClick()
{

	var sTemp;
	var sTemp2;
	var sUndoTemp;
	var iCount;
	var arrTemp;
	var temp;
	
	sTemp= "";
	sTemp2= "";
	if (trimString(objtxtRedo.value) == "") 
	{
		return;
	}
	else
	{
		temp = trimString(objtxtRedo.value);
		temp = temp.substring(2,temp.length);
		arrTemp = temp.split("&&");
			
		sTemp = trimString(objtxtWhereClause.value);
		intTotalCount = arrTemp.length;//UJ_31052007
		sTemp = sTemp + " " + arrTemp[intTotalCount-1];
		objtxtWhereClause.value = trimString(sTemp);
						
		for (iCount = 0; iCount<intTotalCount-1;iCount++)
		{
			if (trimString(arrTemp[iCount])!="")
			{
				sTemp2 = sTemp2 +  "&&" + arrTemp[iCount];
			}
		}
		objtxtRedo.value = trimString(sTemp2);
		sUndoTemp = objtxtUndo.value;
		sUndoTemp = sUndoTemp + "&&" + arrTemp[intTotalCount-1];
		objtxtUndo.value = sUndoTemp;
	}
	sTemp = "";
	sTemp2 = "";
	
	if (trimString(objtxtRedo2.value) == "") 
	{
		return;
	}
	else
	{
		temp = trimString(objtxtRedo2.value);
		temp = temp.substring(2,temp.length);
		arrTemp = temp.split("&&");

		sTemp = trimString(objtxtHiddenWhereClause.value);
		intTotalCount = arrTemp.length;//UJ_31052007
		sTemp = sTemp + " " + arrTemp[intTotalCount-1];
		objtxtHiddenWhereClause.value = trimString(sTemp);
						
		for (iCount = 0; iCount<intTotalCount-1;iCount++)
		{
			if (trimString(arrTemp[iCount])!="")
			{
				sTemp2 = sTemp2 +  "&&" + arrTemp[iCount];
			}
		}
		objtxtRedo2.value = trimString(sTemp2);
		sUndoTemp = objtxtUndo2.value;
		sUndoTemp = sUndoTemp + "&&" + arrTemp[intTotalCount-1];
		objtxtUndo2.value = sUndoTemp;
	}
}


//-------------------------------------------------------------------
// Undo_OnClick()
//   The last appended value is removed
//Modified By Ninad on 16 Feb IssueID 27367
//-------------------------------------------------------------------
function Undo_OnClick()
{

	var sUndo;
	var arrTemp;
	var sTemp;
	var sTemp2;
	var sRedoTemp;
	var iCount;
	var sCurrentMode;
	var intTotalCount;		
	var temp;
			
	sTemp = "";
	sTemp2 = "";
	if (trimString(objtxtUndo.value) == "" || trimString(objtxtUndo.value) == "&&")
	{
		return;
	}
	else
	{
		temp = trimString(objtxtUndo.value);
		temp = temp.substring(2,temp.length);
		arrTemp = temp.split("&&");
			
		objtxtWhereClause.value = "";
		objtxtUndo.value = "";
		
		intTotalCount = arrTemp.length;//UJ_31052007
		for (iCount = 0; iCount < intTotalCount-1;iCount++)
		{
			if (trimString(arrTemp[iCount]) != "")
			{
				sTemp = sTemp + " " + arrTemp[iCount];
				sTemp2 = sTemp2 + "&&" + arrTemp[iCount];
			}
		}
		objtxtWhereClause.value = trimString(sTemp);
		objtxtUndo.value = trimString(sTemp2);
		sRedoTemp = objtxtRedo.value ;
		sRedoTemp = sRedoTemp + "&&" + arrTemp[intTotalCount-1];
		objtxtRedo.value = sRedoTemp;
	}
	sTemp = "";
	sTemp2 = "";
	if (trimString(objtxtUndo2.value) == "" || trimString(objtxtUndo2.value) == "&&")
	{
		return;
	}
	else
	{
		temp = trimString(objtxtUndo2.value);
		temp.substring(2,temp.length);
		arrTemp = temp.split("&&");
			
		objtxtHiddenWhereClause.value = "";
		objtxtUndo2.value = "";
		
		intTotalCount = arrTemp.length;//UJ_31052007
		for (iCount = 0; iCount < intTotalCount-1;iCount++)
		{
			if (trimString(arrTemp[iCount]) != "")
			{
				sTemp = sTemp + " " + arrTemp[iCount];
				sTemp2 = sTemp2 + "&&" + arrTemp[iCount];
			}
		}
		objtxtHiddenWhereClause.value = trimString(sTemp);
		objtxtUndo2.value = trimString(sTemp2);
		sRedoTemp = objtxtRedo2.value ;
		sRedoTemp = sRedoTemp + "&&" + arrTemp[intTotalCount-1];
		objtxtRedo2.value = sRedoTemp;
	}
}

//-------------------------------------------------------------------
// Clear_OnClick()
//   All filter values are cleared
//-------------------------------------------------------------------
function Clear_OnClick()
{											
	objtxtWhereClause.value = "";
	objtxtHiddenWhereClause.value = "";
	objtxtUndo.value ="";
	objtxtUndo2.value = "";
	objtxtRedo.value = "";
	objtxtRedo2.value = ""; 
	/*
	objcboFields.selectedIndex = -1
	objcboOperators.selectedIndex = -1
	*/
	if (objchkField.checked == false)
	{
		objtxtValue.value = "";   
	}
	else
	{
		objcboFields2.selectedIndex = -1;
	}
}

//-------------------------------------------------------------------
// FieldValue_OnClick()
//   for comparion of attrib with an existing attrib
//-------------------------------------------------------------------
function FieldValue_OnClick()
{
	if  (objchkField.checked == true)
	{
		objtxtValue.style.display = "none";   
		objcboFields2.style.display  = ""; //Modified By Ninad Issue ID 20587
		objcboFields2.selectedIndex = -1 ;
		objlinkValidInputs.style.display = "none";
	}
	else
	{
		objtxtValue.style.display = ""; //Modified By Ninad Issue ID 20587
		objcboFields2.style.display  = "none";
	}	
}



//-------------------------------------------------------------------
// MoveSelectedTo(listbox1,listbox2)
//   Select items are moved from first list box to second
//-------------------------------------------------------------------
function MoveSelectedTo(objListBox1,objListBox2)	
{
	var optTag2;
	var optTag;

	var strValue="";
	var index;
	var counter;
	var blnApplyDistinct = false;
	
	var intDataType;
	var strFormulaName;
	var blnFormula=false;
	
	var blnIsOracleDB =false;
	var arrTemp;
	var strTemp;

	if (objListBox1.selectedIndex == -1)
	{
		return;
	}
	objListBox2.SelectedIndex = -1;
	while (objListBox1.selectedIndex != -1)
	{
		optTag = document.createElement("OPTION");
		
		switch (true)
		{
		case (objListBox2.id == "lstSort_SelectedFields"):
			//modified May 23,05 RajK #BI_60
			//optTag.innerText = trimString(objListBox1.options(objListBox1.selectedIndex).innerText) + " ASC";
			if(navigator.appName != 'Microsoft Internet Explorer')
				optTag.innerHTML = trimString(objListBox1.options[objListBox1.selectedIndex].innerHTML) + " ASC";
			else
				optTag.innerText = trimString(objListBox1.options(objListBox1.selectedIndex).innerText) + " ASC";
				
			optTag.value = trimString(objListBox1.options[objListBox1.selectedIndex].value) + " ASC";
			//end modification May 23,05 RajK #BI_60
			break;
			
		case (objListBox2.id == "lstSort_FieldList"):
			//modified May 23,05 RajK #BI_60
			//optTag.innerText = replaceSubstring(objListBox1.options(objListBox1.selectedIndex).innerText," ASC","");
			//optTag.innerText = replaceSubstring(optTag.innerText," DESC","");
			if(navigator.appName != 'Microsoft Internet Explorer')
			{
				optTag.innerHTML = replaceSubstring(objListBox1.options[objListBox1.selectedIndex].innerHTML," ASC","");
				optTag.innerHTML = replaceSubstring(optTag.innerHTML," DESC","");
			}
			else
			{
				optTag.innerText = replaceSubstring(objListBox1.options(objListBox1.selectedIndex).innerText," ASC","");
				optTag.innerText = replaceSubstring(optTag.innerText," DESC","");
			}		
			optTag.value = replaceSubstring(objListBox1.options[objListBox1.selectedIndex].value," ASC","");
			//end modification May 23,05 RajK #BI_60	
			
			optTag.value= replaceSubstring(optTag.value," DESC","");
			break;
			
		case (objListBox2.id == "lstView_SelectedFields"):
		
			objlstGroupBy_FieldList.selectedIndex = - 1;
			strValue = "";
			blnFormula =false;
			strFormulaName = "";
			
			if (trimString(objcboFunction.value)!= "")
			{
				for (index=0;index<arrValues.length;index++)	
				{
					if (arrValues[index] == objListBox1.options[objListBox1.selectedIndex].value) 
					{
						switch (true)
						{
						case (arrDataTypes[index] == "3" || arrDataTypes[index] == "4" || arrDataTypes[index] == "5" || arrDataTypes[index] == "6"):
							strValue = objcboFunction.value;
						case (arrDataTypes[index] == "135"):
							if (objcboFunction.value != "AVG" && objcboFunction.value != "SUM")
							{
								strValue = objcboFunction.value;
							}
						default:
							
							if (objcboFunction.value == "COUNT")
							{
								strValue = objcboFunction.value;
								break;
							}

							if (objcboFunction.value == "DISTINCT")
							{
								blnApplyDistinct = true;
								for (counter=0;counter<objlstView_SelectedFields.length;counter++)
								{
									if (trimString(Left(objlstView_SelectedFields.options[counter].value,9)) == "DISTINCT(" )
									{
										blnApplyDistinct = false;
										break;
									}
								}
								if (blnApplyDistinct == true)
								{
									strValue = "DISTINCT";
								}
								else
								{
									strValue = "";
								}
							}
							break;
						}
					}
				}
			}
			//modified May 23,05 RajK #BI_60
			//optTag.innerText = trimString(objListBox1.options(objListBox1.selectedIndex).innerText);
			if(navigator.appName != 'Microsoft Internet Explorer')
				optTag.innerHTML = trimString(objListBox1.options[objListBox1.selectedIndex].innerHTML);
			else
				optTag.innerText = trimString(objListBox1.options(objListBox1.selectedIndex).innerText);
				
			optTag.value = trimString(objListBox1.options[objListBox1.selectedIndex].value);	
			//end modification May 23,05 RajK #BI_60
				
			// formula??	
			for (index=0;index<arrValues.length;index++)
			{
				if (arrValues[index] == objListBox1.options[objListBox1.selectedIndex].value)
				{
					intDataType = arrDataTypes[index];
					if (arrAttributeID[index] == "0")
					{
						blnFormula = true;
						strFormulaName = arrUFValues[index];
					}
				}
			}
			
			// add the field to group list
			if (intDataType != "201" &&  intDataType != "203")
			{
				optTag2 = document.createElement("OPTION");
				//modified May 23,05 RajK #BI_60
				//optTag2.innerText = optTag.innerText;
				if(navigator.appName != 'Microsoft Internet Explorer')
					optTag2.innerHTML = optTag.innerHTML;
				else
					optTag2.innerText = optTag.innerText;
				//end modification May 23,05 RajK #BI_60

				
				optTag2.value = optTag.value;
				//if (blnFormula == false)
				//{ 
					objlstGroupBy_FieldList.appendChild(optTag2);
				//}
			}
						
			if (blnFormula == true)
			{
				if (trimString(strValue)!= "")
				{
					
					//modified May 23,05 RajK #BI_60
					//optTag.innerText = strValue + "(" + objListBox1.options(objListBox1.selectedIndex).innerText + ")";
					if(navigator.appName != 'Microsoft Internet Explorer')
						optTag.innerHTML = strValue + "(" + objListBox1.options[objListBox1.selectedIndex].innerHTML + ")";					
					else
						optTag.innerText = strValue + "(" + objListBox1.options(objListBox1.selectedIndex).innerText + ")";

					if (blnIsOracleDB == false)
					{
						optTag.value = strValue + "(" + objListBox1.options[objListBox1.selectedIndex].value + ") As [" + strFormulaName + "]" ;
					}
					else
					{
						optTag.value = strValue + "(" + objListBox1.options[objListBox1.selectedIndex].value + ") As " + replaceSubstring(strFormulaName," ",""); 
					}
					//end modification May 23,05 RajK #BI_60				
					
					
				}
				else
				{
					//modified May 23,05 RajK #BI_60
					//optTag.innerText = objListBox1.options(objListBox1.selectedIndex).innerText;
					if(navigator.appName != 'Microsoft Internet Explorer')
						optTag.innerHTML = objListBox1.options[objListBox1.selectedIndex].innerHTML;
					else
						optTag.innerText = objListBox1.options(objListBox1.selectedIndex).innerText;
					
					
					if (blnIsOracleDB == false)
					{
						optTag.value = objListBox1.options[objListBox1.selectedIndex].value + " As [" + strFormulaName + "]" ;
					}
					else
					{
						optTag.value = objListBox1.options[objListBox1.selectedIndex].value + " As [" + replaceSubstring(strFormulaName," ","") + "]"; 
					}
					//end modification May 23,05 RajK #BI_60	
				}
			}
			else
			{
				if (trimString(strValue)!= "")
				{
					//modified May 23,05 RajK #BI_60
					//optTag.innerText = strValue + "(" + objListBox1.options(objListBox1.selectedIndex).innerText + ")";
					if(navigator.appName != 'Microsoft Internet Explorer')
						optTag.innerHTML = strValue + "(" + objListBox1.options[objListBox1.selectedIndex].innerHTML + ")";					
					else
						optTag.innerText = strValue + "(" + objListBox1.options(objListBox1.selectedIndex).innerText + ")";
						
					if (blnIsOracleDB == false)
					{
						optTag.value = strValue + "(" + objListBox1.options[objListBox1.selectedIndex].value + ") As [" + objListBox1.options[objListBox1.selectedIndex].value + "]" ;
					}
					else
					{
						optTag.value = strValue + "(" + objListBox1.options[objListBox1.selectedIndex].value + ") As " + replaceSubstring(objListBox1.options[objListBox1.selectedIndex].value," ",""); 
					}
					//end modification May 23,05 RajK #BI_60	
				}
			}
			
			/*else
			{
				optTag.innerText = trimString(objListBox1.options(objListBox1.selectedIndex).innerText);
				optTag.value = trimString(objListBox1.options(objListBox1.selectedIndex).value);	
			}*/
			break;
						
		case (objListBox2.id == "lstView_FieldList"):
			
			objlstGroupBy_FieldList.selectedIndex = -1;
			objlstGroupBy_SelectedFields.selectedIndex = -1;
			
			//modified May 23,05 RajK #BI_60
			//optTag.innerText = objListBox1.options(objListBox1.selectedIndex).innerText;
			if(navigator.appName != 'Microsoft Internet Explorer')
				optTag.innerHTML = objListBox1.options[objListBox1.selectedIndex].innerHTML;
			else
				optTag.innerText = objListBox1.options(objListBox1.selectedIndex).innerText;
			
			optTag.value = objListBox1.options[objListBox1.selectedIndex].value;
			//end modification May 23,05 RajK #BI_60	
			switch (true)
			{
			case (Left(trimString(objListBox1.options[objListBox1.selectedIndex].value),4) == "SUM(" || Left(trimString(objListBox1.options[objListBox1.selectedIndex].value),4) == "MIN(" || Left(trimString(objListBox1.options[objListBox1.selectedIndex].value),4) == "MAX(" || Left(trimString(objListBox1.options[objListBox1.selectedIndex].value),4) == "AVG("):
				//removing SUM(, AVG(, MIN(, MAX( if appended to the attrib.
				
				//modified May 23,05 RajK #BI_60
				//optTag.innerText = replaceSubstring(objListBox1.options(objListBox1.selectedIndex).innerText,Left(trimString(objListBox1.options(objListBox1.selectedIndex).value),4),"");
				if(navigator.appName != 'Microsoft Internet Explorer')
					optTag.innerHTML = replaceSubstring(objListBox1.options[objListBox1.selectedIndex].innerHTML,Left(trimString(objListBox1.options[objListBox1.selectedIndex].value),4),"");
				else
					optTag.innerText = replaceSubstring(objListBox1.options(objListBox1.selectedIndex).innerText,Left(trimString(objListBox1.options[objListBox1.selectedIndex].value),4),"");				
					
				optTag.value = replaceSubstring(objListBox1.options[objListBox1.selectedIndex].value,Left(trimString(objListBox1.options[objListBox1.selectedIndex].value),4),"");
				//end modification May 23,05 RajK #BI_60	
				break;
			
			default:
				if (Left(trimString(objListBox1.options[objListBox1.selectedIndex].value),6) == "COUNT(" )
				{
				
					//modified May 23,05 RajK #BI_60
					//optTag.innerText = replaceSubstring(objListBox1.options(objListBox1.selectedIndex).innerText,"COUNT(","");
					if(navigator.appName != 'Microsoft Internet Explorer')
						optTag.innerHTML = replaceSubstring(objListBox1.options[objListBox1.selectedIndex].innerHTML,"COUNT(","");
					else
						optTag.innerText = replaceSubstring(objListBox1.options(objListBox1.selectedIndex).innerText,"COUNT(","");
					
					optTag.value = replaceSubstring(objListBox1.options[objListBox1.selectedIndex].value,"COUNT(","");
					//end modification May 23,05 RajK #BI_60	
					break;
				}
				if (Left(trimString(objListBox1.options[objListBox1.selectedIndex].value),9) == "DISTINCT(" )
				{
					//modified May 23,05 RajK #BI_60
					//optTag.innerText = replaceSubstring(objListBox1.options(objListBox1.selectedIndex).innerText,"DISTINCT(","");
					if(navigator.appName != 'Microsoft Internet Explorer')
						optTag.innerHTML = replaceSubstring(objListBox1.options[objListBox1.selectedIndex].innerHTML,"DISTINCT(","");
					else
						optTag.innerText = replaceSubstring(objListBox1.options(objListBox1.selectedIndex).innerText,"DISTINCT(","");

					optTag.value = replaceSubstring(objListBox1.options[objListBox1.selectedIndex].value,"DISTINCT(","");
					//end modification May 23,05 RajK #BI_60	
					break;
				}
				break;	
			}
										
			optTag.value = replaceSubstring(optTag.value,"[[","[");
			optTag.value = replaceSubstring(optTag.value,"]]","]");
		
						
			if (isSubstringExists(optTag.value ," As ")== true)
			{
			
				//modified May 23,05 RajK #BI_60
				//optTag.innerText = Left(trimString(optTag.innerText),Len(trimString(optTag.innerText))- 1);
				if(navigator.appName != 'Microsoft Internet Explorer')
					optTag.innerHTML = Left(trimString(optTag.innerHTML),Len(trimString(optTag.innerHTML))- 1);
				else
					optTag.innerText = Left(trimString(optTag.innerText),Len(trimString(optTag.innerText))- 1);
				//end modification May 23,05 RajK #BI_60	
				
				arrTemp = optTag.value.split(" As ");
				strTemp = Left(trimString(arrTemp[0]),Len(trimString(arrTemp[0]))- 1);
				if (blnIsOracleDB == false)
				{
					optTag.value = strTemp ;//+ " As [" + arrTemp[(arrTemp.length-1)] + "]";
				}	
				else
				{
					optTag.value = strTemp ;//+ " As [" + replaceSubstring(arrTemp[(arrTemp.length-1)]," ","") + "]";
				}
			}										
			else
			{
				//optTag.value = Left(trimString(optTag.value),Len(trimString(optTag.value))- 1);
				arrTemp = trimString(optTag.value).split(" ");
				if (blnIsOracleDB == false)
				{
					//optTag.value = replaceSubstring(optTag.value , " As [" + objListBox1.options(objListBox1.selectedIndex).value + "]" ,"") 
				}
				else
				{
					//optTag.value = replaceSubstring(optTag.value , " As " + replaceSubstring(objListBox1.options(objListBox1.selectedIndex).value," ","") ,"") 
				}
			}
			
			
			// just in case
			if (isSubstringExists(optTag.value, " As ") ==true)
			{
				arrTemp = optTag.value.split(" As ");
				optTag.value = arrTemp[0];
			}				
				
			
			//modified May 23,05 RajK #BI_60
			//arrTemp = optTag.innerText.split(" As ");
			//optTag.innerText = arrTemp[0];
			if(navigator.appName != 'Microsoft Internet Explorer')
				{				
					if (isSubstringExists(optTag.innerHTML, " As ")==true)
					{
						arrTemp = optTag.innerHTML.split(" As ");
						optTag.innerHTML = arrTemp[0];
					}					
				}
			else
				{
					if (isSubstringExists(optTag.innerText, " As ")==true)
					{
						arrTemp = optTag.innerText.split(" As ");
						optTag.innerText = arrTemp[0];
					}	
				}
			//end modification May 23,05 RajK #BI_60	
								
			
			// remove from group lists
			for (index=0;index<objlstGroupBy_SelectedFields.length;index++)
			{
				if (trimString(objlstGroupBy_SelectedFields.options[index].value) == trimString(optTag.value))
				{
				objlstGroupBy_SelectedFields.remove(index) ;
				break;
				}
			}
			for (index=0;index<objlstGroupBy_FieldList.length;index++)
			{
				if (trimString(objlstGroupBy_FieldList.options[index].value) == trimString(optTag.value))
				{
				objlstGroupBy_FieldList.remove(index) ;
				break;
				}
			}
			
			break;	
			
		default:
			//modified May 23,05 RajK #BI_60
			//optTag.innerText = trimString(objListBox1.options(objListBox1.selectedIndex).innerText);
			if(navigator.appName != 'Microsoft Internet Explorer')
				optTag.innerHTML = trimString(objListBox1.options[objListBox1.selectedIndex].innerHTML);
			else
				optTag.innerText = trimString(objListBox1.options(objListBox1.selectedIndex).innerText);
			optTag.value = trimString(objListBox1.options[objListBox1.selectedIndex].value);
			//end modification May 23,05 RajK #BI_60	
			break;	
		}
			
			
		//append the tag						
		objListBox2.appendChild(optTag);						
		if (objListBox1.length > 0)
		{
			if (objListBox1.selectedIndex != -1)
			{
				objListBox1.remove(objListBox1.selectedIndex);						
			}
		}
	}
}



//-------------------------------------------------------------------
// MoveSelectedTo(listbox1,listbox2)
//   All items are moved from first list box to second
//-------------------------------------------------------------------
function MoveAllTo(objListBox1,objListBox2)	
{
	var optTag2;
	var optTag;

	var strValue="";
	var index;
	var counter;
	var blnApplyDistinct = false;
	
	var intDataType;
	var strFormulaName;
	var blnFormula=false;
	
	var blnIsOracleDB =false;
	var arrTemp;
	var strTemp;
		
	if (objListBox1.length == 0)
	{
		return;
	}
	objListBox2.SelectedIndex = -1;
	while (objListBox1.length >0)
	{
		optTag = document.createElement("OPTION");
		
		switch (true)
		{
		case (objListBox2.id == "lstSort_SelectedFields"):
			//modified May 23,05 RajK #BI_60
			//optTag.innerText = trimString(objListBox1.options(0).innerText) + " ASC";
			if(navigator.appName != 'Microsoft Internet Explorer')
				optTag.innerHTML = trimString(objListBox1.options[0].innerHTML) + " ASC";
			else
				optTag.innerText = trimString(objListBox1.options(0).innerText) + " ASC";
			
			optTag.value = trimString(objListBox1.options[0].value) + " ASC";
			//end modification May 23,05 RajK #BI_60
			break;
			
		case (objListBox2.id == "lstSort_FieldList"):
			
			//modified May 23,05 RajK #BI_60
			//optTag.innerText = replaceSubstring(objListBox1.options(0).innerText," ASC","");
			//optTag.innerText = replaceSubstring(optTag.innerText," DESC","");
			if(navigator.appName != 'Microsoft Internet Explorer')
				{
				optTag.innerHTML = replaceSubstring(objListBox1.options[0].innerHTML," ASC","");
				optTag.innerHTML = replaceSubstring(optTag.innerHTML," DESC","");
				}
			else
				{
				optTag.innerText = replaceSubstring(objListBox1.options(0).innerText," ASC","");
				optTag.innerText = replaceSubstring(optTag.innerText," DESC","");
				}
			
			optTag.value = replaceSubstring(objListBox1.options[0].value," ASC","");
			//end modification May 23,05 RajK #BI_60
			
			optTag.value= replaceSubstring(optTag.value," DESC","");
			break;
			
		case (objListBox2.id == "lstView_SelectedFields"):
		
			objlstGroupBy_FieldList.selectedIndex = - 1;
			strValue = "";
			strFormulaName = "";
			blnFormula=false;
			if (trimString(objcboFunction.value)!= "")
			{
				for (index=0;index<arrValues.length;index++)	
				{
					if (arrValues[index] == objListBox1.options[0].value) 
					{
						switch (true)
						{
						case (arrDataTypes[index] == "3" || arrDataTypes[index] == "4" || arrDataTypes[index] == "5" || arrDataTypes[index] == "6"):
							strValue = objcboFunction.value;
						case (arrDataTypes[index] == "135"):
							if (objcboFunction.value != "AVG" && objcboFunction.value != "SUM")
							{
								strValue = objcboFunction.value;
							}
						default:
							
							if (objcboFunction.value == "COUNT")
							{
								strValue = objcboFunction.value;
								break;
							}

							if (objcboFunction.value == "DISTINCT")
							{
								blnApplyDistinct = true;
								for (counter=0;counter<objlstView_SelectedFields.length;counter++)
								{
									if (trimString(Left(objlstView_SelectedFields.options[counter].value,9)) == "DISTINCT(" )
									{
										blnApplyDistinct = false;
										break;
									}
								}
								if (blnApplyDistinct == true)
								{
									strValue = "DISTINCT";
								}
								else
								{
									strValue = "";
								}
							}
							break;
						}
					}
				}
			}
			//modified May 23,05 RajK #BI_60
			//optTag.innerText = trimString(objListBox1.options(0).innerText);
			if(navigator.appName != 'Microsoft Internet Explorer')
				optTag.innerHTML = trimString(objListBox1.options[0].innerHTML);
			else
				optTag.innerText = trimString(objListBox1.options(0).innerText);
			optTag.value = trimString(objListBox1.options[0].value);	
			//end modification May 23,05 RajK #BI_60
				
			// formula??	
			for (index=0;index<arrValues.length;index++)
			{
				if (arrValues[index] == objListBox1.options[0].value)
				{
					intDataType = arrDataTypes[index];
					if (arrAttributeID[index] == "0")
					{
						blnFormula = true;
						strFormulaName = arrUFValues[index];
					}
				}
			}
				
			// add the field to group list
			if (intDataType != "201" &&  intDataType != "203")
			{
				optTag2 = document.createElement("OPTION");
				//modified May 23,05 RajK #BI_60
				//optTag2.innerText = optTag.innerText;
				if(navigator.appName != 'Microsoft Internet Explorer')
					optTag2.innerHTML = optTag.innerHTML;
				else
					optTag2.innerText = optTag.innerText;
				//end modification May 23,05 RajK #BI_60
				optTag2.value = optTag.value;
				
				//if (blnFormula == false)
				//{ 
					objlstGroupBy_FieldList.appendChild(optTag2);
				//}
			}
				
			if (blnFormula == true)
			{
				if (trimString(strValue)!= "")
				{
					//modified May 23,05 RajK #BI_60
					//optTag.innerText = strValue + "(" + objListBox1.options(0).innerText + ")";
					if(navigator.appName != 'Microsoft Internet Explorer')
						optTag.innerHTML = strValue + "(" + objListBox1.options[0].innerHTML + ")";
					else
						optTag.innerText = strValue + "(" + objListBox1.options(0).innerText + ")";
					if (blnIsOracleDB == false)
					{
						optTag.value = strValue + "(" + objListBox1.options[0].value + ") As [" + strFormulaName + "]" ;
					}
					else
					{
						optTag.value = strValue + "(" + objListBox1.options[0].value + ") As " + replaceSubstring(strFormulaName," ",""); 
					}
					//end modification May 23,05 RajK #BI_60
				}
				else
				{
					//modified May 23,05 RajK #BI_60
					//optTag.innerText = objListBox1.options(0).innerText;
					if(navigator.appName != 'Microsoft Internet Explorer')
						optTag.innerHTML = objListBox1.options[0].innerHTML;
					else
						optTag.innerText = objListBox1.options(0).innerText;					
					
					if (blnIsOracleDB == false)
					{
						optTag.value = objListBox1.options[0].value + " As [" + strFormulaName + "]" ;
					}
					else
					{
						optTag.value = objListBox1.options[0].value + " As " + replaceSubstring(strFormulaName," ",""); 
					}
					//end modification May 23,05 RajK #BI_60
				}
			}
			else
			{
				if (trimString(strValue)!= "")
				{
					//modified May 23,05 RajK #BI_60
					//optTag.innerText = strValue + "(" + objListBox1.options(0).innerText + ")";
					if(navigator.appName != 'Microsoft Internet Explorer')
						optTag.innerHTML = strValue + "(" + objListBox1.options[0].innerHTML + ")";				
					else
						optTag.innerText = strValue + "(" + objListBox1.options(0).innerText + ")";
											
					if (blnIsOracleDB == false)
					{
						optTag.value = strValue + "(" + objListBox1.options[0].value + ") As [" + objListBox1.options[0].value + "]" ;
					}
					else
					{
						optTag.value = strValue + "(" + objListBox1.options[0].value + ") As " + replaceSubstring(objListBox1.options[0].value," ",""); 
					}
					//end modification May 23,05 RajK #BI_60
				}
		
			}
			/*else
			{
				optTag.innerText = trimString(objListBox1.options(0).innerText);
				optTag.value = trimString(objListBox1.options(0).value);	
			}*/
			break;
			
		
		case (objListBox2.id == "lstView_FieldList"):
			objlstGroupBy_FieldList.selectedIndex = -1;
			objlstGroupBy_SelectedFields.selectedIndex = -1  ;
			//modified May 23,05 RajK #BI_60
			//optTag.innerText = objListBox1.options(0).innerText;
			if(navigator.appName != 'Microsoft Internet Explorer')
				optTag.innerHTML = objListBox1.options[0].innerHTML;
			else
				optTag.innerText = objListBox1.options(0).innerText;
							
			optTag.value = objListBox1.options[0].value;
			//end modification May 23,05 RajK #BI_60
						
			switch (true)
			{
			case (Left(trimString(objListBox1.options[0].value),4) == "SUM(" || Left(trimString(objListBox1.options[0].value),4) == "MIN(" || Left(trimString(objListBox1.options[0].value),4) == "MAX(" || Left(trimString(objListBox1.options[0].value),4) == "AVG("):
				//removing SUM(, AVG(, MIN(, MAX( if appended to the attrib.
				//modified May 23,05 RajK #BI_60
				//optTag.innerText = replaceSubstring(objListBox1.options(0).innerText,Left(trimString(objListBox1.options(0).value),4),"");
				if(navigator.appName != 'Microsoft Internet Explorer')
					optTag.innerHTML = replaceSubstring(objListBox1.options[0].innerHTML,Left(trimString(objListBox1.options[0].value),4),"");
				else
					optTag.innerText = replaceSubstring(objListBox1.options(0).innerText,Left(trimString(objListBox1.options[0].value),4),"");				
					
				optTag.value = replaceSubstring(objListBox1.options[0].value,Left(trimString(objListBox1.options[0].value),4),"");
				//end modification May 23,05 RajK #BI_60
				break;
			
			default:
							
				if (Left(trimString(objListBox1.options[0].value),6) == "COUNT(" )
				{
					//modified May 23,05 RajK #BI_60
					//optTag.innerText = replaceSubstring(objListBox1.options(0).innerText,"COUNT(","");
					if(navigator.appName != 'Microsoft Internet Explorer')
						optTag.innerHTML = replaceSubstring(objListBox1.options[0].innerHTML,"COUNT(","");
					else
						optTag.innerText = replaceSubstring(objListBox1.options(0).innerText,"COUNT(","");					
					optTag.value = replaceSubstring(objListBox1.options[0].value,"COUNT(","");
					//end modification May 23,05 RajK #BI_60
					break;
				}
				
				if (Left(trimString(objListBox1.options[0].value),9) == "DISTINCT(" )
				{
					//modified May 23,05 RajK #BI_60
					//optTag.innerText = replaceSubstring(objListBox1.options(0).innerText,"DISTINCT(","");
					if(navigator.appName != 'Microsoft Internet Explorer')
						optTag.innerHTML = replaceSubstring(objListBox1.options[0].innerHTML,"DISTINCT(","");
					else
						optTag.innerText = replaceSubstring(objListBox1.options(0).innerText,"DISTINCT(","");
					
					optTag.value = replaceSubstring(objListBox1.options[0].value,"DISTINCT(","");
					//end modification May 23,05 RajK #BI_60
					break;
				}
				
				break;	
			}
								
			optTag.value = replaceSubstring(optTag.value,"[[","[");
			optTag.value = replaceSubstring(optTag.value,"]]","]");
			
			if (isSubstringExists(optTag.value ," As ")== true)
			{
				//modified May 23,05 RajK #BI_60
				//optTag.innerText = Left(trimString(optTag.innerText),Len(trimString(optTag.innerText))- 1);
				if(navigator.appName != 'Microsoft Internet Explorer')
					optTag.innerHTML = Left(trimString(optTag.innerHTML),Len(trimString(optTag.innerHTML))- 1);
				else
					optTag.innerText = Left(trimString(optTag.innerText),Len(trimString(optTag.innerText))- 1);
				//end modification May 23,05 RajK #BI_60
				arrTemp = optTag.value.split(" As ");
				strTemp = Left(trimString(arrTemp[0]),Len(trimString(arrTemp[0]))- 1);
				if (blnIsOracleDB == false)
				{
					optTag.value = strTemp ;
				}	
				else
				{
					optTag.value = strTemp ;
				}
			}										
			else
			{
				//optTag.value = Left(trimString(optTag.value),Len(trimString(optTag.value))- 1);
				//arrTemp = trimString(optTag.value).split(" ");
				//if (blnIsOracleDB == false)
				//{
					//optTag.value = replaceSubstring(optTag.value , " As [" + objListBox1.options(objListBox1.selectedIndex).value + "]" ,"") 
				//}
				//else
				//{
					//optTag.value = replaceSubstring(optTag.value , " As " + replaceSubstring(objListBox1.options(objListBox1.selectedIndex).value," ","") ,"") 
				//}
			}
			
			
			if (isSubstringExists(optTag.value, " As ") ==true)
			{
				arrTemp = optTag.value.split(" As ");
				optTag.value = arrTemp[0];
			}			
			//modified May 23,05 RajK #BI_60
			if(navigator.appName != 'Microsoft Internet Explorer')		
			{
				if (isSubstringExists(optTag.innerHTML, " As ")==true)
				{
					arrTemp = optTag.innerHTML.split(" As ");
					optTag.innerHTML = arrTemp[0];
				}
			}
			else
			{					
				if (isSubstringExists(optTag.innerText, " As ")==true)
				{
					arrTemp = optTag.innerText.split(" As ");
					optTag.innerText = arrTemp[0];
				}					
			}				
			//end modification May 23,05 RajK #BI_60
			
			// remove from group lists
			for (index=0;index<objlstGroupBy_SelectedFields.length;index++)
			{
				if (trimString(objlstGroupBy_SelectedFields.options[index].value) == trimString(optTag.value))
				{
				objlstGroupBy_SelectedFields.remove(index) ;
				break;
				}
			}
			for (index=0;index<objlstGroupBy_FieldList.length;index++)
			{
				if (trimString(objlstGroupBy_FieldList.options[index].value) == trimString(optTag.value))
				{
				objlstGroupBy_FieldList.remove(index) ;
				break;
				}
			}
			break;	
			
		default:
			//modified May 23,05 RajK #BI_60
			if(navigator.appName != 'Microsoft Internet Explorer')		
			//optTag.innerText = trimString(objListBox1.options(0).innerText);
				optTag.innerHTML = trimString(objListBox1.options[0].innerHTML);
			else
				optTag.innerText = trimString(objListBox1.options(0).innerText);
			
			optTag.value = trimString(objListBox1.options[0].value);
			//end modification May 23,05 RajK #BI_60
			break;	
		}
				
		//append the tag						
		objListBox2.appendChild(optTag);						
		objListBox1.remove(0);						
	}
}



//-------------------------------------------------------------------
// cboFields_OnChange()
//   The attribute combo on change is used to show any valid inputs
//-------------------------------------------------------------------

function cboFields_OnChange()
{
	var index;
    var strInnerTextcboField="";
     //Modified by Vinay on 30 Sept. 2008, Should support for Mozilla Firefox
    if ( navigator.appName !='Microsoft Internet Explorer') 
    {
     strInnerTextcboField =objcboHiddenFields[objcboFields.selectedIndex].innerHTML; 
    }
    else 
    {
    strInnerTextcboField =objcboHiddenFields(objcboFields.selectedIndex).innerText;
    }
    //Modification End by Vinay on 30 Sept. 2008, Should support for Mozilla Firefox
	switch(true)
	{
	case (strInnerTextcboField.toUpperCase()=="PROJECTNAME" || strInnerTextcboField.toUpperCase()=="USERNAME" || strInnerTextcboField.toUpperCase()=="CUSTOMERNAME" || strInnerTextcboField.toUpperCase()=="CUSTOMER" || strInnerTextcboField.toUpperCase()=="PROJECTCODE" ):
		objlinkValidInputs.style.display = "block";
		break;
	default:
		if (isSubstringExists(strInnerTextcboField.toUpperCase(),"LOCATION")||isSubstringExists(strInnerTextcboField.toUpperCase(),"DEPARTMENT"))
		{
			objlinkValidInputs.style.display = "block";
			return;
		}
		else
		{
			for (index=0;index<arrValues.length;index++)
			{
				if (arrValues[index].toUpperCase() == strInnerTextcboField.toUpperCase())
				{
					if (trimString(arrInputs[index])!= "")
					{
						objlinkValidInputs.style.display = "block";
						return;
					}
					else
					{
						objlinkValidInputs.style.display = "none";
						return;
					}
				}
			}
		}
		objlinkValidInputs.style.display = "none";
		break;
	}
}

//-------------------------------------------------------------------
// ValidInputs_OnClick()
//   The function calls a page which displays the valid inputs
//	The actual fiels for which inputs are required is passed to the page
//-------------------------------------------------------------------
function ValidInputs_OnClick()
{
	var index;
	var querystring;
    //Modified by Vinay on 30 Sept. 2008, Should support for Mozilla Firefox	
     var strInnerTextcboField="";
    if ( navigator.appName !='Microsoft Internet Explorer') 
    {
     strInnerTextcboField =objcboHiddenFields[objcboFields.selectedIndex].innerHTML; 
    }
    else 
    {
    strInnerTextcboField =objcboHiddenFields(objcboFields.selectedIndex).innerText;
    }
    //Modification End by Vinay on 30 Sept. 2008, Should support for Mozilla Firefox
	if (objcboFields.selectedIndex==-1) return;
	
	switch(true)
	{
	case (strInnerTextcboField.toUpperCase()=="PROJECTNAME" || strInnerTextcboField.toUpperCase()=="USERNAME" || strInnerTextcboField.toUpperCase()=="CUSTOMERNAME" || strInnerTextcboField.toUpperCase()=="CUSTOMER" || strInnerTextcboField.toUpperCase()=="PROJECTCODE" ):
			querystring = "Attribute=" + trimString(objcboFields.value);
			if (strInnerTextcboField.toUpperCase() == "CUSTOMERNAME" || strInnerTextcboField.toUpperCase() == "CUSTOMER") {
				querystring += "&INPUT=CUSTOMERNAME"
			}
			else {
				querystring += "&INPUT=" + strInnerTextcboField;
            }
		//querystring += "&INPUT=" + strInnerTextcboField;
		break;
	default:
		if (isSubstringExists(strInnerTextcboField.toUpperCase(),"LOCATION")||isSubstringExists(strInnerTextcboField.toUpperCase(),"DEPARTMENT"))
		{
			querystring = "Attribute=" + trimString(objcboFields.value);
			querystring += "&INPUT=" + strInnerTextcboField;	
			break;
		}
		else
		{
			for (index=0;index<arrValues.length;index++)
			{
				if (arrValues[index].toUpperCase() == strInnerTextcboField.toUpperCase())
				{
					if (trimString(arrInputs[index])!= "")
					{
						querystring = "Attribute=" + trimString(objcboFields.value);
						querystring += "&INPUT=" + arrInputs[index];
						break;
					}
					else
					{
						querystring = "Attribute=&INPUT="
						break;
					}
				}
			}
		}
		break;
	}
	window.open("QRB_ValidInputs.aspx?" + querystring,"_ValidInputs","resizable=yes,menubar=no,scrollbars=no,left=0,top=0,width=500,height=500");
}

//validates and selects all selected item to submit
//called before submitting the QRB_QueryBuilder.aspx? page
function ValidateAndSelectListItem()
{
	var intCtr;
	var objListBox;
	
	if (objlstView_SelectedFields.length ==0)
	{
		alert("Please select the attributes to be displayed !");
		return false;
	}
		
	for (intCtr=0;intCtr<objlstView_SelectedFields.length;intCtr++)
	{
		if (Left(trimString(objlstView_SelectedFields.options[intCtr].value),9)== "DISTINCT(")
		{
			if (intCtr > 0)
			{
				alert("The DISTINCT attribute should be the first attribute in the select list!");
				return false;
			}
		}
	}
	
	objListBox = objlstGroupBy_SelectedFields;
	for (intCtr = 0;intCtr < objListBox.length; intCtr++)
	{
		objListBox.options[intCtr].selected = true;
	}
							
	objListBox = objlstSort_SelectedFields;
	for (intCtr = 0;intCtr < objListBox.length; intCtr++)
	{
		objListBox.options[intCtr].selected = true;
	}
			
	objListBox = objlstView_SelectedFields;
	for (intCtr = 0;intCtr < objListBox.length; intCtr++)
	{
		objListBox.options[intCtr].selected = true;
	}
	
	return true;
}