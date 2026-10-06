<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_LayoutMaintenance.aspx.vb" Inherits="PbNIT.IB_LayoutMaintenance" ValidateRequest="False"%>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%WritePageHead%>
	<%CommonFunctions.General.PlotPageHeadTag("")%>

	<style>
        #divList th{
            position:relative;
        }
    </style>

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		
					<form id="frmLayoutMaintenance" method="post" runat="server">
									<%WritePage%>
					</form>
		
					<script language="javascript">
						document.getElementById("divList").onscroll=function(){
					        $("#divList th").css("top",document.getElementById("divList").scrollTop - 1);
					        $("#divList th").css("background-color",$("#divList .clsTRColumnHeader").css("background-color"))
					    }
// =============================== Common To all Mode=====================//
	var objdivlist;
	objdivlist = GetObjectReference('frmLayoutMaintenance','divList');
	//'Modified by ShraddhaM on Date 05 Jully,2006 for PMLifeLine Issue ID.4168
	var str1="<%=str%>";
		//alert(str1);
	var str101='';
	
	        <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
	
	function window_onload()
	{
		 
		
		  
		var intDivHeight ;
		//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
		if (intDivHeight < 100)	intDivHeight = 100;
		objdivlist.style.height = intDivHeight +'px';	
	}
	
	function window_onresize()		
	{
		var intDivHeight;
		//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		//'Modified by ShraddhaM on Date 12 July,2006 for PMLifeLine Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
				intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 ;
		    }
		    else
		    {
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		    }
		if (intDivHeight < 100)	intDivHeight = 100;
		objdivlist.style.height = intDivHeight +'px';		
	}
// =============================== Common To all Mode =====================//

// =============================== Common To Layout and Field Details Mode =====================//
<%If m_strPageMode = MODE_FIELDDETAILS Or m_strPageMode = MODE_LAYOUTDETAILS Then%>
	function Back_OnClick(strMode)
	{
		if(strMode == "<%=MODE_LAYOUTDETAILS%>")
		{
			window.location.href ="../General/CommonList.aspx?MasterTagID=1028&FromWhere=SM";
		}
		else if(strMode == "<%=MODE_FIELDDETAILS%>")
		{
			window.location.href = "IB_LayoutMaintenance.aspx?LayoutID=<%=m_lngLayoutId%>&PageNumber=<%=Server.URLEncode(m_strPageNumber)%>&MasterTagId=<%=m_intTagId%>";
		}
	}	
<%End If%>
// =============================== Common To Layout and Field Details Mode =====================//	

// =============================== Specific To Field Details Mode =====================//
<%If m_strPageMode = MODE_FIELDDETAILS Then%>
	var objForFocus;
	objForFocus = GetObjectReference('frmLayoutMaintenance','txtFieldName');
	setFocus(objForFocus);

    //When the field is compulsory then the show and editable checkbox in add mode must be checked and disabled.
	var objMandatory, objAddNewShow, objAddNewEditable;
	
	objMandatory = GetObjectReference('frmLayoutMaintenance','chkMandatory');
	objAddNewShow = GetObjectReference('frmLayoutMaintenance','chkShowInAddMode');
	objAddNewEditable = GetObjectReference('frmLayoutMaintenance','chkReadOnlyInAddMode');
	if((objMandatory) && (objMandatory.checked==true))
	{
		objAddNewShow.checked = true;
		objAddNewEditable.checked = true;
		objAddNewShow.disabled = true;
		objAddNewEditable.disabled = true;		
	}
	function chkMandatory_OnClick()
	{
		var objMandatory, objAddNewShow, objAddNewEditable, objIsCompulsoryField;
		
		objMandatory = GetObjectReference('frmLayoutMaintenance','chkMandatory');
		objAddNewShow = GetObjectReference('frmLayoutMaintenance','chkShowInAddMode');
		objAddNewEditable = GetObjectReference('frmLayoutMaintenance','chkReadOnlyInAddMode');
		objIsCompulsoryField = GetObjectReference('frmLayoutMaintenance','txthidIsCompulsoryField');
		if(objMandatory.checked == true)
		{
			objAddNewShow.checked = true;
			objAddNewEditable.checked = true;
			objAddNewShow.disabled = true;
			objAddNewEditable.disabled = true;		
		}
		else
		{
			if(objIsCompulsoryField.value.toUpperCase() == "FALSE")
			{
				objAddNewShow.disabled = false;
			}
			objAddNewEditable.disabled = false;
		}
	}
    function chkMandatoryAdd_OnClick() {
            var objMandatory, objAddNewShow, objAddNewEditable, objIsCompulsoryField;
		
        objMandatory = GetObjectReference('frmLayoutMaintenance','chkMandatoryAdd');
        objAddNewShow = GetObjectReference('frmLayoutMaintenance','chkShowInAddMode');
        objAddNewEditable = GetObjectReference('frmLayoutMaintenance','chkReadOnlyInAddMode');
        objIsCompulsoryField = GetObjectReference('frmLayoutMaintenance','txthidIsCompulsoryField');
        if(objMandatory.checked == true)
        {
            objAddNewShow.checked = true;
            objAddNewEditable.checked = true;
            objAddNewShow.disabled = false;
            objAddNewEditable.disabled = false;		
        }
        

    }
    function chkMandatoryEdit_OnClick() {
        var objMandatory, objAddNewShow, objAddNewEditable, objIsCompulsoryField;
		
        objMandatory = GetObjectReference('frmLayoutMaintenance','chkMandatoryEdit');
        objEditShow = GetObjectReference('frmLayoutMaintenance','chkShowInEditMode');
        objEditEditable = GetObjectReference('frmLayoutMaintenance','chkReadOnlyInEditMode');
        objIsCompulsoryField = GetObjectReference('frmLayoutMaintenance','txthidIsCompulsoryField');
        if(objMandatory.checked == true)
        {
            objEditShow.checked = true;
            objEditEditable.checked = true;
            objEditShow.disabled = false;
            objEditEditable.disabled = false;
            		
        }
        

    }
	function chkShowInAddMode_onclick()
	{
		var objchkShowInAddMode, objchkReadOnlyInAddMode;
		objchkShowInAddMode = GetObjectReference('frmLayoutMaintenance', 'chkShowInAddMode');
		objchkReadOnlyInAddMode = GetObjectReference('frmLayoutMaintenance', 'chkReadOnlyInAddMode');
		
		if(objchkShowInAddMode.checked == true)
		{
			objchkReadOnlyInAddMode.disabled = false;
		}
		else
		{
			objchkReadOnlyInAddMode.disabled = true;
		}
	}
	
	function chkShowInEditMode_onclick()
	{
		var objchkShowInEditMode, objchkReadOnlyInEditMode;
		objchkShowInEditMode = GetObjectReference('frmLayoutMaintenance', 'chkShowInEditMode');
		objchkReadOnlyInEditMode = GetObjectReference('frmLayoutMaintenance', 'chkReadOnlyInEditMode');
		
		if(objchkShowInEditMode.checked == true)
		{
			objchkReadOnlyInEditMode.disabled = false;
		}
		else
		{
			objchkReadOnlyInEditMode.disabled = true;
		}
	}
	
	function Save_OnClick()
	{
		 //alert('hi');
		var MAXROWS=<%=MAXROW%>, MAXCOLUMNS=<%=MAXCOLUMN%>;
		var objForm, objAction, objRowNumbers, objColumnNumbers, objFieldCaptions;
		var strLayoutField;
		var objchkMandatory, objchkShowInAddMode, objchkShowInEditMode, objchkReadOnlyInAddMode, objchkReadOnlyInEditMode;
        var objtxtMandatory, objtxtShowInAddMode, objtxtShowInEditMode, objtxtReadOnlyInAddMode, objtxtReadOnlyInEditMode;
        var objchkMandatoryEdit, objchkMandatoryAdd, objtxthidMandatoryInEditMode, objtxthidMandatoryInAddMode;
		<%=GenerateLayoutArray()%>
		
		objForm = GetFormReference('frmLayoutMaintenance');
		objAction = GetObjectReference('frmLayoutMaintenance', 'txthidAction_LayoutMaintenance');
		
		objFieldCaptions = GetObjectReference('frmLayoutMaintenance','txtFieldName');
		objRowNumbers = GetObjectReference('frmLayoutMaintenance','txtRowNumber');
		objColumnNumbers = GetObjectReference('frmLayoutMaintenance','txtColumnNumber');
		if((objRowNumbers != null) && (objColumnNumbers != null))
		{
			if(disallowBlank(objRowNumbers,"<%=MyBase.GetResourceString("ENTERROWNO")%> !!", true))
				return;
			if(disallowNonInteger(objRowNumbers,"<%=MyBase.GetResourceString("ENTERROWASINTEGER")%>", true))
				return;
			if(disallowValueRangeViolation(objRowNumbers, 1, MAXROWS, "<%=MyBase.GetResourceString("ROWNOINRANGE")%> [1-" + MAXROWS + "]!!", true))
				return;
			if(disallowBlank(objColumnNumbers,"<%=MyBase.GetResourceString("ENTERCOLUMNNO")%> !!", true))
				return;
			if(disallowNonInteger(objColumnNumbers,"<%=MyBase.GetResourceString("ENTERCOLUMNNOASINTEGER")%>", true))
				return;
			if(disallowValueRangeViolation(objColumnNumbers, 1, MAXCOLUMNS, "<%=MyBase.GetResourceString("COLUMNNOINRANGE")%> [1-" + MAXCOLUMNS + "]!!", true))
				return;
				
			strLayoutField = arrLayout[objRowNumbers.value][objColumnNumbers.value];
			
			if((strLayoutField != null) && (strLayoutField != ""))
			{
				if (strLayoutField != objFieldCaptions.value)
				{
					alert("<%=MyBase.GetResourceString("THEFIELD")%> '" + strLayoutField + "' <%=MyBase.GetResourceString("ALREADYEXIST")%>");
					objColumnNumbers.focus();
					return;
				}
			}
		}		
		objchkMandatory = GetObjectReference('frmLayoutMaintenance','chkMandatory');
		objchkShowInAddMode = GetObjectReference('frmLayoutMaintenance','chkShowInAddMode');
		objchkShowInEditMode = GetObjectReference('frmLayoutMaintenance','chkShowInEditMode');
		objchkReadOnlyInAddMode = GetObjectReference('frmLayoutMaintenance','chkReadOnlyInAddMode');
        objchkReadOnlyInEditMode = GetObjectReference('frmLayoutMaintenance', 'chkReadOnlyInEditMode');
        objchkMandatoryEdit= GetObjectReference('frmLayoutMaintenance', 'chkMandatoryEdit');
        objchkMandatoryAdd= GetObjectReference('frmLayoutMaintenance', 'chkMandatoryAdd');
		
		objtxtMandatory = GetObjectReference('frmLayoutMaintenance','txthidMandatory');
		objtxtShowInAddMode = GetObjectReference('frmLayoutMaintenance','txthidShowInAddMode');
		objtxtShowInEditMode = GetObjectReference('frmLayoutMaintenance','txthidShowInEditMode');
		objtxtReadOnlyInAddMode = GetObjectReference('frmLayoutMaintenance','txthidReadOnlyInAddMode');
        objtxtReadOnlyInEditMode = GetObjectReference('frmLayoutMaintenance', 'txthidReadOnlyInEditMode');

        objtxthidMandatoryInEditMode = GetObjectReference('frmLayoutMaintenance','txthidMandatoryInEditMode');
        objtxthidMandatoryInAddMode = GetObjectReference('frmLayoutMaintenance','txthidMandatoryInAddMode');
		//if(objchkMandatory.checked == true){
		//	objtxtMandatory.value = "1";
		//}
		//else{
		//	objtxtMandatory.value = "0";
		//}
        //objtxtMandatory.value = "0";
		if(objchkShowInAddMode.checked == true){
			objtxtShowInAddMode.value = "1";
		}
		else{
			objtxtShowInAddMode.value = "0";
		}

		if(objchkShowInEditMode.checked == true){
			objtxtShowInEditMode.value = "1";
		}
		else{
			objtxtShowInEditMode.value = "0";
		}

		if(objchkReadOnlyInAddMode.checked == true){
			objtxtReadOnlyInAddMode.value = "0";
		}
		else{
			objtxtReadOnlyInAddMode.value = "1";
		}

		if(objchkReadOnlyInEditMode.checked == true){
			objtxtReadOnlyInEditMode.value = "0";
		}
		else{
			objtxtReadOnlyInEditMode.value = "1";
        }


        if(objchkMandatoryAdd.checked == true){
			objtxthidMandatoryInAddMode.value = "1";
		}
		else{
			objtxthidMandatoryInAddMode.value = "0";
        }
        if(objchkMandatoryEdit.checked == true){
			objtxthidMandatoryInEditMode.value = "1";
		}
		else{
			objtxthidMandatoryInEditMode.value = "0";
		}



		objAction.value = "<%=ACTION_SAVE%>";
		objForm.action = "IB_LayoutMaintenance.aspx?LayoutID=<%=m_lngLayoutId%>&FieldID=<%=m_lngFieldId%>&PageNumber=<%=Server.URLEncode(m_strPageNumber)%>&MasterTagId=<%=m_intTagId%>";
		objForm.submit();
	}
<%End If%>
// =============================== Specific To Field Details Mode =====================//	

// =============================== Specific To Layout Details Mode =====================//
<%If m_strPageMode = MODE_LAYOUTDETAILS Then%>
	var objForFocus;
	objForFocus = GetObjectReference('frmLayoutMaintenance','txtLayoutName');
	setFocus(objForFocus);

	function LinkName_OnClick(intFieldId)
	{
		var objForm;
		objForm = GetFormReference('frmLayoutMaintenance');
		objForm.action = "IB_LayoutMaintenance.aspx?LayoutID=<%=m_lngLayoutId%>&FieldID=" + intFieldId + "&PageNumber=<%=Server.URLEncode(m_strPageNumber)%>&MasterTagId=<%=m_intTagId%>";
		objForm.submit();
	}
	
	function SetDefault_OnClick(intLayoutId)
	{
		var objForm, objAction;
		objForm = GetFormReference('frmLayoutMaintenance');
		objAction = GetObjectReference('frmLayoutMaintenance', 'txthidAction_LayoutMaintenance');
		objAction.value = "<%=ACTION_SETASDEFAULT%>";
		objForm.action = "IB_LayoutMaintenance.aspx?DefaultLayoutId=" + intLayoutId	+ "&LayoutID=<%=m_lngLayoutId%>&PageNumber=<%=Server.URLEncode(m_strPageNumber)%>&MasterTagId=<%=m_intTagId%>";
		objForm.submit();
	}
				
	function Save_OnClick()
	{
       

	   
		//'Modified by ShraddhaM on Date 05 Jully,2006 for PMLifeLine Issue ID.4168
		//shraddha
		//var i;
		//alert('hi');
		//var mycars = new Array();
		//mycars = "<%=arrActualColumns%>";
		//var mycars = new Array("<%=arrActualColumns%>");
		
		
		//alert(mycars.length);
		
		//for(i=0;i<=mycars.length;i++)
		//{
			//alert(mycars[i]);
		//}
		var i;
		var j;
		var str101;
		//var str1="<%=str%>";
		//str101='';
		//alert(str1);
		/*for(i=0;i<str1.length;i++)
		{   
			str101='';
			for(j=i;str1[j]!=',';j++)
			{			
				str101=str101+str1[j];				
			}			
			i=j;
			
		alert(str101);
		
		}*/
		//var checkBoxName=new Array("<%=str%>");
		//alert(checkBoxName.length);
		var MAXROWS=<%=MAXROW%>, MAXCOLUMNS=<%=MAXCOLUMN%>;
		var objForm, objAction, objLayoutName, objRowNumbers, objColumnNumbers, objFieldCaptions;
		var objLayoutArray = new Array(MAXROWS);
		var iCnt, strLayoutField;
		var objCheckBox, objCheckBoxCount,objOrderNoList;

        //debugger;
		//Modified and commented by SuchitraP on 20 Nov 2007 for IssueID=15219
		//Purpose:When Row number was entered as 30,JS error was displayed
		//for(iCnt=0; iCnt<MAXROWS;iCnt++)
		for(iCnt=1; iCnt<=MAXROWS;iCnt++)
		//End of Modification and comment by SuchitraP on 20 Nov 2007 for IssueID=15219
		{
			objLayoutArray[iCnt]= new Array(MAXCOLUMNS);
		}
		
		objForm = GetFormReference('frmLayoutMaintenance');
		objAction = GetObjectReference('frmLayoutMaintenance', 'txthidAction_LayoutMaintenance');
		
		objLayoutName = GetObjectReference('frmLayoutMaintenance','txtLayoutName');
		//alert(objLayoutName);
		if (disallowBlank(objLayoutName,"<%=MyBase.GetResourceString("ENTERLAYOUTNAME")%>"))
			return;

        //Commented & Added By Dipali V On 20th July 2022
	    // var txthidlngUniqueID = GetObjectReference('frmLayoutMaintenance','txthidlngUniqueID',true); 
	    var txthidlngUniqueID = GetObjectReference('frmLayoutMaintenance','txthidFieldId',true); 
		//End of Commented & Added By Dipali V On 20th July 2022
		// alert(objColumnNumbers);
		 //alert(objColumnNumbers);
	    objFieldCaptions = GetObjectReference('frmLayoutMaintenance','txthidFieldCaption',true);
        if (objFieldCaptions.length != 0) {
            for (iCnt = 0; iCnt < txthidlngUniqueID.length; iCnt++) {

                objRowNumbers = GetObjectReference('frmLayoutMaintenance', 'txtRowNumber_' + txthidlngUniqueID[iCnt].value, true);
                objColumnNumbers = GetObjectReference('frmLayoutMaintenance', 'txtColumnNumber_' + txthidlngUniqueID[iCnt].value, true);

                if (disallowBlank(objRowNumbers[0], "<%=MyBase.GetResourceString("ENTERROWNO")%> '" + objFieldCaptions[0].value + "' !!", true))
                    return;

                if (disallowNonInteger(objRowNumbers[0], "<%=MyBase.GetResourceString("ENTERROWASINTEGER")%>", true))
                    return;
                if (disallowValueRangeViolation(objRowNumbers[0], 1, MAXROWS, "<%=MyBase.GetResourceString("ROWNOINRANGE")%> [1-" + MAXROWS + "]!!", true))
                    return;
                if (disallowBlank(objColumnNumbers[0], "<%=MyBase.GetResourceString("ENTERCOLUMNNO")%> '" + objFieldCaptions[0].value + "' !!", true))
                    return;
                if (disallowNonInteger(objColumnNumbers[0], "<%=MyBase.GetResourceString("ENTERCOLUMNNOASINTEGER")%>", true))
                    return;
                if (disallowValueRangeViolation(objColumnNumbers[0], 1, MAXCOLUMNS, "<%=MyBase.GetResourceString("COLUMNNOINRANGE")%> [1-" + MAXCOLUMNS + "]!!", true))
                    return;

                //---------------------------
          <%--  if (objRowNumbers[0] != undefined) {
                strLayoutField = objLayoutArray[objRowNumbers[0].value][objColumnNumbers[0].value];
                if (strLayoutField != undefined) {
                    if ((strLayoutField != null) && (strLayoutField != "")) {
                        if (strLayoutField != objFieldCaptions[iCnt].value) {
                            alert("<%=MyBase.GetResourceString("ROWNOANDCOLNO",False)%> '" + objFieldCaptions[iCnt].value + "'.\n <%=MyBase.GetResourceString("THEFIELD")%> '" + strLayoutField + "' <%=MyBase.GetResourceString("ALREADYEXIST")%>");
                            objColumnNumbers[0].focus();
                            return;
                        }
                    }
                }
                //Commented and added by Yogesh Jalamkar on 12-MAr-2018 Purpose: Suntech upgrade issue fixing Issue id = 11354
                //objLayoutArray[objRowNumbers[0].value][objColumnNumbers[0].value] = objFieldCaptions[0].value;
                objLayoutArray[objRowNumbers[0].value][objColumnNumbers[0].value] = objFieldCaptions[iCnt].value;
            }--%>
                //End by Yogesh Jalamkar


            }
        }
	   
	    //debugger;
	    //objOrderNoList = GetObjectReference('frmLayoutMaintenance','txthidOrderNoList');
	    //if(isSubstringExists("," + objOrderNoList.value + "," , "," + objRowNumbers.value + objColumnNumbers.value + ","))
	    //{
	    //    alert("Row & Column Number Already Exists");
	    //    setFocus(objRowNumber);
	    //    return;
	    //}
		objCheckBoxCount = GetObjectReference('frmLayoutMaintenance','txthidCheckBoxCount');
		//alert('v:'+objCheckBoxCount.value);
		if(objCheckBoxCount.value == 1)
		{
			objCheckBox = GetObjectReference('frmLayoutMaintenance','chkLayoutSrNo');
			objCheckBox.disabled =  false;
		}
		else if(objCheckBoxCount.value > 0)
		{
		//alert('v:'+objCheckBoxCount.value);
		//shraddha
		if(navigator.appName == 'Netscape')
		{
			for(i=0;i<str1.length;i++)
			{   
				str101='';
				for(j=i;str1[j]!=',';j++)
				{			
					str101=str101+str1[j];				
				}			
				i=j;
			
				//alert(str101);
		
				var chkLayoutSrNo="chkLayoutSrNo" + "_" + str101;
				//alert(chkLayoutSrNo);
				objCheckBox = GetObjectReference('frmLayoutMaintenance','chkLayoutSrNo', true);
				//alert(objCheckBox);
				//alert('v:1'+objCheckBox.length);
				//alert(iCnt);
				//alert('obj: '+objCheckBoxCount.value);
				//for (iCnt=0; iCnt < objCheckBoxCount.value; iCnt++)
				//{
					//alert('save');
				objCheckBox.disabled = false;
				objCheckBox.checked  = true;
				//}
				chkLayoutSrNo="chkLayoutSrNo";
			}//end of for
			}//mozilla
			else
			{
				objCheckBox = GetObjectReference('frmLayoutMaintenance','chkLayoutSrNo', true);
				for (iCnt=0; iCnt < objCheckBoxCount.value; iCnt++)
				{
					//alert('save');
				    objCheckBox(iCnt).disabled = false;
				    objCheckBox.checked  = true;
				}
			}
			
		}
		
		objAction.value = "<%=ACTION_SAVE%>";
	    //Added By NILESH G on 13-April-2015 Purpose::HIDE SAVE LINK AND APPLY LOADER 
	    var MenuTags = document.getElementsByTagName('A');
	    for (i = 0; i < MenuTags.length; i++) {
	        if (MenuTags[i].className == "Menu") {
	            //MenuTags[i].style.display= "none";
	            MenuTags[i].parentNode.style.display = "none";
	        }
	    }
	    setFrameLoader();
	    // End of Added By NILESH G on 13-April-2015 Purpose::HIDE SAVE LINK AND APPLY LOADER
		objForm.action = "IB_LayoutMaintenance.aspx?LayoutID=<%=m_lngLayoutId%>&PageNumber=<%=Server.URLEncode(m_strPageNumber)%>&MasterTagId=<%=m_intTagId%>";
		objForm.submit();
	}
	
	//shraddha
	
	function SelectAll_OnClick(strFormName, strCheckbox)
	//Pass FormName and the Checkbox's ID
	{
	 
	    //Commented and Added by Dhanashri S on 9 Dec 2015 for IssueID:2646

	//alert(str1.length);
	//if(navigator.appName == 'Netscape')
	//	{
	//	var strCheckbox1=strCheckbox;
	//		for(i=0;i<str1.length;i++)
	//		{   
	//			str101='';
	//			for(j=i;str1[j]!=',';j++)
	//			{			
	//				str101=str101+str1[j];				
	//			}			
	//			i=j;
	//			var strCheckbox=strCheckbox + "_" + str101;
	//			//alert(strCheckbox);
				
	//			var objCheckbox = GetObjectReference(strFormName,strCheckbox,true);
	//			var intItems;
	//			var intCtr;
	//			//alert(objCheckbox);
	//			if (objCheckbox != null)
	//			{
	//				intItems = objCheckbox.length;
	//				//alert('cnt: '+intItems);
	//				/*if(intItems > 1) 
	//				{
	//					for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
	//					{
	//						if (objCheckbox[intCtr].disabled == false)
	//						objCheckbox[intCtr].checked = true;							
	//					}
	//				}
	//				// Else, if single element exists, then...
	//				else */if(intItems == 1)
	//				{
	//					//alert('else');
	//				if (objCheckbox[0].disabled == false) 
	//				{
	//					//alert('else');
	//					objCheckbox[0].checked = true;		
	//				}
					
	//				//if (objCheckbox[0].disabled == false) 
	//				//objCheckbox[0].checked = true;				
	//				}
	//			}
	//			strCheckbox=strCheckbox1;
	//		}//end of for.................
	//	}
		//for IE
		//else
	    //{

    //End of Comment by Dhanashri S on 9 Dec 2015
		var objCheckbox = GetObjectReference(strFormName,strCheckbox,true);
		var intItems;
		var intCtr;
		
		if (objCheckbox != null)
		{
			intItems = objCheckbox.length;
			if(intItems > 1) 
			{
				for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
				{
					if (objCheckbox[intCtr].disabled == false)
					{
						objCheckbox[intCtr].checked = true;							
						//Code added by PrashantD on 23 April 2007
						//Purpose: newly Selected records does not get saved
						
					    //Commented and Added by Dhanashri S on 9 Dec 2015 IssueID:2646
						//CheckField(objCheckbox[intCtr],objCheckbox[intCtr].name.substring(objCheckbox[intCtr].name.indexOf("_")+1,objCheckbox[intCtr].length));
						CheckField(objCheckbox[intCtr],objCheckbox[intCtr].id.substring(objCheckbox[intCtr].id.indexOf("_")+1,objCheckbox[intCtr].length));
						//End of Comment and Addition by Dhanashri S on 9 Dec 2015

					    //End of addition by PrashantD on 23 April 2007
					}
						
				}
			}
			// Else, if single element exists, then...
			else if(intItems == 1)
			{
				if (objCheckbox[0].disabled == false) 
					objCheckbox[0].checked = true;						
			}
		}
		}
	
	//}

    //Added by Dhanashri S on 9 Dec 2015 for IssueID:2646
	function ClearAll_OnClick(strFormName, strCheckbox)
	    //Pass FormName and the Checkbox's ID
	{
	    var objCheckbox = GetObjectReference(strFormName,strCheckbox,true);
	    var intItems;
	    var intCtr;
		
	    if (objCheckbox != null)
	    {
	        intItems = objCheckbox.length;
	        if(intItems > 1) 
	        {
	            for (intCtr = 0;intCtr <= intItems - 1; intCtr++)
	            {
	                if (objCheckbox[intCtr].disabled == false)
	                {
	                    objCheckbox[intCtr].checked = false;							
	                    //Code added by PrashantD on 23 April 2007
	                    //Purpose: newly Selected records does not get saved
						
	                    //Commented and Added by Dhanashri S on 9 Dec 2015 IssueID:2646
	                    //CheckField(objCheckbox[intCtr],objCheckbox[intCtr].name.substring(objCheckbox[intCtr].name.indexOf("_")+1,objCheckbox[intCtr].length));
	                    CheckField(objCheckbox[intCtr],objCheckbox[intCtr].id.substring(objCheckbox[intCtr].id.indexOf("_")+1,objCheckbox[intCtr].length));
	                    //End of Comment and Addition by Dhanashri S on 9 Dec 2015

	                    //End of addition by PrashantD on 23 April 2007
	                }
						
	            }
	        }
	            // Else, if single element exists, then...
	        else if(intItems == 1)
	        {
	            if (objCheckbox[0].disabled == false) 
	                objCheckbox[0].checked = false;						
	        }
	    }
	}
	//End of Addition by Dhanashri S on 9 Dec 2015

	function CheckField(objCheckBox, intFieldID)
	{
		var objtxtActive;
		var strId;
		//Modified By ShraddhaM on 31 Aug 2006 For SP 7
		strId='txthidActive_' + intFieldID;
		objtxtActive = GetObjectReference('frmLayoutMaintenance',strId);

        //Commented by Dhanashri S on 9 Dec 2015 for IssueID:2646
	    //objtxtActive=window.document.forms['frmLayoutMaintenance'].elements[strId];
	    //End of Comment and Addition by Dhanashri S on 9 Dec 2015

		//Endded By ShraddhaM on 31 Aug 2006 For SP 7
		if(objCheckBox.checked == true)
			objtxtActive.value="1";
		else
			objtxtActive.value="0";
			
			 
	}
<%End If%>
// =============================== Specific To Layout Details Mode =====================//
					</script>
	</body>
</HTML>
<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->

<%--/*End of Commented & Added By Dipali V On 14th Dec 2020 For JQuery Version*/--%>
<script type="text/javascript" src="../../responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        width: 35%;
        vertical-align: middle;
    }
    .clsTROdd a {
    font-family: Verdana !important;
    font-size: 12px !important;
    text-decoration: underline !important;
    color: #000 !important;
}
    input:not([type=button])
    {
        margin-bottom:0px !important; /*Added By Vaijat K ON 01/12/2015*/
    }

    #divList table thead {

        position: relative!important;
        display: inline-table!important;
        width: 1118px!important;
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
