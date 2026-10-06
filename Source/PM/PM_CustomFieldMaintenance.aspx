<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_CustomFieldMaintenance.aspx.vb" Inherits="PbNIT.PM_CustomFieldMaintenance" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<%WritePageHead%>
	<%CommonFunctions.General.PlotPageHeadTag("")%>

	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script> -->
	<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	
<script src="../../responsive/responsive.js"></script>

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
            $('.clsTable:last').css({ 'visibility': 'none' });
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
<%--End of Commented and Added By  Ankit P on 18th-September-2015 for Responsive Page--%>


	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
					<form id="frmTaskCustomFields" method="post" runat="server">
									<%WritePage%>
					</form>
					<script language="javascript">
// =============================== Common To all Mode=====================//
	var objForm, objdivlist;
	
	objForm = GetFormReference('frmTaskCustomFields');
	objdivlist = GetObjectReference('frmTaskCustomFields','divList');
	
	
	<%' Added By SonalD on 13th Jan 2009 %>
	<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
        disableRightClick();
    <%End If%>
    <%' Added By SonalD on 13th Jan 2009 %>
		//Modified(29) by Bharat T on 25th-Nov-2015 for Sem issue
	function window_onload()
	{
		var intDivHeight ;
		
		if (intDivHeight < 100)	intDivHeight = 100;
		
		//Modified by MonikaI on Date 11 July,2006 for WhizibleSEM_Whiz2 Issue ID.4168
			if(navigator.appName == 'Netscape')
			{
				//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop + 125;
			    intDivHeight = window.innerHeight - objdivlist.offsetTop - 29;
			
			}
			else
			    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 29;
	    //End of modification by MonikaI
	   
	    //Commented and added by Yogesh J on 11/12/2015
        objdivlist.style.height = intDivHeight + 'px';	
	}
	
	function window_onresize()		
	{
		var intDivHeight;
		//intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
		    {		  
			    intDivHeight =window.innerHeight  - objdivlist.offsetTop - 32 ;
		    }
		    else
		    {
			    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 32;
		    }
			if (intDivHeight < 100)	intDivHeight = 100;
	    //Commented and added by Yogesh J on 11/12/2015
		objdivlist.style.height = intDivHeight + 'px';		
	}
					    //End of Modified by Bharat T on 25th-Nov-2015 for Sem issue
	
	// =============================== for Detail Page of selected Custom field =====================//
	// ========================================================================================================//
	<%If m_strMode = MODE_DETAILS%>
	var bitQuery = <%=m_bitIsQueryValue%>, objOnLoadFocus;
	
	objOnLoadFocus = GetObjectReference('frmTaskCustomFields','txtUserGivenCaption');
	setFocus(objOnLoadFocus);
	function Back_OnClick()
	{
		window.location.href = "PM_CustomFieldMaintenance.aspx?Mode=<%=MODE_LIST%>&MasterTagID=<%=m_lngTagId%>&CORP=<%=m_strPageCalledFrom%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&EntityName=<%=m_strEntityName%>";
	}
	// =============================== For selection of validation rules for Custom field =====================//
	   	function SelectValidation(strDatabaseFieldName,intProjectID)
	{
			
		//alert('Functionality to be implemented.');
		var strValidationRules, objValidationRules;
		objValidationRules = GetObjectReference('frmTaskCustomFields','txtValidationRules');

		if (window.showModalDialog)
		{
            //COMMENTED AND ADDED BY nILESH g ON 2/12/2015
		    //strValidationRules = window.showModalDialog("../IB/IB_ValidationRules.aspx?Rules=" + objValidationRules.value ,"_SelectValidation","dialogwidth:13cm;dialogheight:12cm");
		    strValidationRules = window.showModalDialog("../IB/IB_ValidationRules.aspx?Rules=" + objValidationRules.value ,"_SelectValidation","dialogwidth:300px;dialogheight:400px");
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
		    txtValidationRules_OnPropertyChange();
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
		var objMinValue, objMaxValue, objValidationRules;
		var strValidation;
		
		objValidationRules = GetObjectReference('frmTaskCustomFields','txtValidationRules');
		objMinValue = GetObjectReference('frmTaskCustomFields','txtMinValue');
		objMaxValue = GetObjectReference('frmTaskCustomFields','txtMaxValue');
		//Added by ShraddhaM To disable MaxLength textbox if validation is applied.
		objtxtMaxLength = GetObjectReference('frmTaskCustomFields','txtMaxLength'); 
		//Ended by ShraddhaM
		objMinValue.disabled = true;		
		objMaxValue.disabled = true;
		objtxtMaxLength.disabled = true;
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
			
			//Added by ShraddhaM To disable MaxLength textbox if validation is applied.		        
		        if(isSubstringExists(strValidation, ",12,"))
				    objtxtMaxLength.disabled = false;
			    else
				    objtxtMaxLength.value = "";
		    //Ended by ShraddhaM
		
		}
		else	//Mimimum and Maximum value textboxes must be empty
		{
			objMinValue.value = "";
			objMaxValue.value = "";
			objtxtMaxLength.value = "";
		}
	}

// =============================== In Case of CustomCombo For inserting Static Values=====================//
	function InsertValue_OnClick()
	{
		var objNewElement, objTextBox, objListBox, objLabel, objValidationRules;
		var intCtr, msg, strObjectCaption;
		var objDataType;	
		objDataType = GetObjectReference('frmTaskCustomFields','cboDataType');
		objValidationRules = GetObjectReference('frmTaskCustomFields','txtValidationRules');
		objTextBox = GetObjectReference('frmTaskCustomFields','txtValue');
		objListBox = GetObjectReference('frmTaskCustomFields','lstValue');
		objLabel = GetObjectReference('frmTaskCustomFields','lblSelectedValue');
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
		objTextBox = GetObjectReference('frmTaskCustomFields','txtValue');
		objListBox = GetObjectReference('frmTaskCustomFields','lstValue');
		objLabel = GetObjectReference('frmTaskCustomFields','lblSelectedValue');
		objDataType = GetObjectReference('frmTaskCustomFields','cboDataType');
		objValidationRules = GetObjectReference('frmTaskCustomFields','txtValidationRules');
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
			objTextBox.value = "";
			}
		else
			{
			objListBox.options[intSelectedIndex].innerHTML = objTextBox.value;
			objListBox.options[intSelectedIndex].value = objTextBox.value;		
			objTextBox.value = "";
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
		
		objTextBox = GetObjectReference('frmTaskCustomFields','txtValue');
		objListBox = GetObjectReference('frmTaskCustomFields','lstValue');
		objLabel = GetObjectReference('frmTaskCustomFields','lblSelectedValue');
		strObjectCaption = "value";
		objLabel.innerHTML = "";
		objDefaultValue = GetObjectReference('frmTaskCustomFields','txtDefaultValue');
				
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

		objTextBox = GetObjectReference('frmTaskCustomFields','txtValue');
		 
		if(strValueType == 'C')
		{
			objListBox = GetObjectReference('frmTaskCustomFields','lstValue');
			objLabel = GetObjectReference('frmTaskCustomFields','lblSelectedValue');
		}
		else
			objListBox = GetObjectReference('frmTaskCustomFields','lstValueQ');
		strObjectCaption = "value";
		intSelectedValue = objListBox.selectedIndex;
		if(intSelectedValue < 0)
			return;
		objTextBox.value = objListBox.options[objListBox.selectedIndex].innerHTML;
		if(strValueType == 'Q')
		{
			objDefaultValue = GetObjectReference('frmTaskCustomFields','txtDefaultValue');
			
			
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
		objListBox = GetObjectReference('frmTaskCustomFields','lstValue');
		objDefaultValue = GetObjectReference('frmTaskCustomFields','txtDefaultValue');
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
		
		objoptComboValue = GetObjectReference('frmTaskCustomFields','optComboValue',true);
		objDefaultValue = GetObjectReference('frmTaskCustomFields','txtDefaultValue');
		
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
				objValue = GetObjectReference('frmTaskCustomFields','txtValue');
				if(objValue != null)
					objValue.value="";
			}
			bitQuery=0;
		}
	}
	
	function optDefaultValue_Onclick()
	{
		var objDefaultValue;
		
		objDefaultValue = GetObjectReference('frmTaskCustomFields','optDefaultValue',true);
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
		window.open("PM_CustomFieldMaintenance.aspx?Mode=<%=MODE_ASSIGN_TYPES%>&MasterTagId=<%=m_lngTagId%>&CORP=<%=m_strPageCalledFrom%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&DatabaseFieldName=<%=m_strDBFieldName%>&EntityName=<%=m_strEntityName%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
	}

	// =============================== Save the Custom Field Details after validations=====================//
	function Save_OnClick()
    {    
        try {
            var i, objAction;
            var objUserGivenCaption, objCFList, objFieldList, objRowNumber, objColumnNumber, objDataType;
            var objControlHeight, objControlWidth, objMaxLength, objMaxValue, objMinValue;
            var objOrderNoList, objDBFieldName, objlstValue, objoptComboValue, objDefaultValue;
            var objValidationRules, strValidation = '', objQuery;
            objUserGivenCaption = GetObjectReference('frmTaskCustomFields', 'txtUserGivenCaption');
            if (disallowBlank(objUserGivenCaption, "<%=MyBase.GetResourceString("ENTERCONTROLCAPTION")%>"))
                return;
            if (isSubstringExists(objUserGivenCaption.value, ",")) {
                alert("<%=Mybase.GetResourceString("COMMADISALLOWED")%>");
                setFocus(objUserGivenCaption);
                return;
            }

            if (isSubstringExists(Trim(objUserGivenCaption.value.toUpperCase()), 'ORDER BY')) {
                alert("<%=Mybase.GetResourceString("CUSTOMFIELD_CAPTION_NOT_ORDERBY", False)%>");
                setFocus(objUserGivenCaption);
                return;
            }
            
            objCFList = GetObjectReference('frmTaskCustomFields', 'txthidCFList');
            if (isSubstringExists("," + objCFList.value + ",", "," + objUserGivenCaption.value + ",")) {
                //Commented And Added By Usha Pandit On 25.06.2020 For javascript error on save Combo field
                <%--alert(replaceSubstring("<%=Mybase.GetResourceString("CONTROLCAPTIONEXISTS")%>", "<=>", objUserCaption.value));--%>
                //Commented and added by Chetan M on 04 Jan 2021 for wrong alert issue
                <%--alert(replaceSubstring("<%=Mybase.GetResourceString("CONTROLCAPTIONEXISTS")%>", "<=>", objUserGivenCaption.value));--%>
                //End Of Added By Usha Pandit On 25.06.2020 For javascript error on save Combo field
                alert("Control caption '" + objUserGivenCaption.value + "' already exists.");
                //End of Commented and added by Chetan M on 04 Jan 2021 for wrong alert issue
                setFocus(objUserGivenCaption);
                return;
            }
            objFieldList = GetObjectReference('frmTaskCustomFields', 'txthidFieldList');
            if (isSubstringExists(objFieldList.value, "," + objUserGivenCaption.value + ",")) {
                alert("'" + objUserGivenCaption.value + "' <%=Mybase.GetResourceString("STANDARDATTRIBUTE")%>");
                setFocus(objUserGivenCaption);
                return;
            }
            objDataType = GetObjectReference('frmTaskCustomFields', 'cboDataType');
            if (disallowBlank(objDataType, "<%=MyBase.GetResourceString("SELECTDATATYPE")%>"))
                return;

            objRowNumber = GetObjectReference('frmTaskCustomFields', 'txtRowNumber');
            if (disallowBlank(objRowNumber, "<%=MyBase.GetResourceString("ENTERROWNO")%>"))
                return;
            if (disallowNegativeInteger(objRowNumber, "<%=MyBase.GetResourceString("ENTERAPPROPRIATEVALUE")%>"))
                return;
            if (objRowNumber.value == 0) {
                alert("<%=MyBase.GetResourceString("ENTERAPPROPRIATEVALUE")%>");
                setFocus(objRowNumber);
                return;
            }
            objColumnNumber = GetObjectReference('frmTaskCustomFields', 'txtColumnNumber');
            if (disallowBlank(objColumnNumber, "<%=MyBase.GetResourceString("ENTERCOLUMNNO")%>"))
                return;
            if (disallowNegativeInteger(objColumnNumber, "<%=MyBase.GetResourceString("ENTERAPPROPRIATEVALUE")%>"))
                return;

            if ((objColumnNumber.value > 2) || (objColumnNumber.value <= 0)) {
                alert("<%=Mybase.GetResourceString("COLUMNNUMBERRANGE")%>");
                setFocus(objColumnNumber);
                return;
            }
            objControlHeight = GetObjectReference('frmTaskCustomFields', 'txtControlHeight');
            if (disallowNegativeInteger(objControlHeight, "<%=MyBase.GetResourceString("ENTERAPPROPRIATEVALUE")%>"))
                return;

            objControlWidth = GetObjectReference('frmTaskCustomFields', 'txtControlWidth');
            if (disallowNegativeInteger(objControlWidth, "<%=MyBase.GetResourceString("ENTERAPPROPRIATEVALUE")%>"))
                return;

            objMaxLength = GetObjectReference('frmTaskCustomFields', 'txtMaxLength');
            if ((objMaxLength != null) && (disallowNegativeInteger(objMaxLength, "<%=MyBase.GetResourceString("ENTERAPPROPRIATEVALUE")%>")))
                return;

            objMinValue = GetObjectReference('frmTaskCustomFields', 'txtMinValue');
            if ((objMinValue != null) && (disallowNegativeInteger(objMinValue, "<%=MyBase.GetResourceString("VALID_MINIMUM_VALUE")%>")))
                return;

            objMaxValue = GetObjectReference('frmTaskCustomFields', 'txtMaxValue');
            if ((objMaxValue != null) && (disallowNegativeInteger(objMaxValue, "<%=MyBase.GetResourceString("VALID_MAXIMUM_VALUE")%>")))
                return;

            objOrderNoList = GetObjectReference('frmTaskCustomFields', 'txthidOrderNoList');
            if (isSubstringExists("," + objOrderNoList.value + ",", "," + objRowNumber.value + objColumnNumber.value + ",")) {
                alert("<%=Mybase.GetResourceString("ROWCOLUMNEXISTS")%>");
                setFocus(objRowNumber);
                return;
            }
            objlstValue = GetObjectReference('frmTaskCustomFields', 'lstValue');
            objoptComboValue = GetObjectReference('frmTaskCustomFields', 'optComboValue', true);
            objDBFieldName = GetObjectReference('frmTaskCustomFields', 'txtDatabaseFieldName');
            if (isSubstringExists(objDBFieldName.value, "CustomFieldCombo")) {

                //Replace () with [] 
                if ((objlstValue.length == 0) && (objoptComboValue[0].checked == true)) {
                    alert("<%=Mybase.GetResourceString("ADDATLEASTONEVALUE")%>");
                    setFocus(objlstValue);
                    return;
                }
            }
            objValidationRules = GetObjectReference('frmTaskCustomFields', 'txtValidationRules');
            objDefaultValue = GetObjectReference('frmTaskCustomFields', 'txtDefaultValue');
            if (objDataType.value == 1)
                if (disallowNonNumeric(objDefaultValue, "<%=Mybase.GetResourceString("DEFAULTVALUENUMERIC")%>"))
                    return;
            if (isSubstringExists(objDBFieldName.value, "CustomFieldCombo")) {

                //Replace () with [] 
                if (objoptComboValue[0].checked == true) {

                    for (i = 0; i < objlstValue.length; i++) {
                        if (isSubstringExists("," + objValidationRules.value + ",", ",3,") || objDataType.value == 1)

                            if (!isNumeric(objlstValue[i].value)) { alert("<%=Mybase.GetResourceString("LISTVALUENUMERIC")%>"); return; }


                    }

                    if (objDefaultValue.value != "") {
                        for (i = 0; i < objlstValue.length; i++) {

                            //Replace () with [] 
                            if (objlstValue[i].value == objDefaultValue.value)
                                break;
                        }
                        if (i == objlstValue.length) {
                            objDefaultValue.value = "";
                            alert("<%=MyBase.GetResourceString("PROPERDEFAULTVALUE")%>");
                            setFocus(objDefaultValue);
                            return;
                        }
                    }
                }
            }

            if (objValidationRules)
                strValidation = "," + objValidationRules.value + ",";
            else
                strValidation = "";
            if ((isSubstringExists(strValidation, ",18,")) || (isSubstringExists(strValidation, ",16,")) || (isSubstringExists(strValidation, ",17,"))) {
                if (objDataType.value != 1) {
                    alert("<%=MyBase.GetResourceString("DATATYPENUMERIC")%>");
                    setFocus(objDataType);
                    return;
                }
                if (isSubstringExists(strValidation, ",18,") == true) {
                    if ((objMinValue != null) && (disallowBlank(objMinValue, "<%=MyBase.GetResourceString("VALID_MINIMUM_VALUE")%>")))
                        return;
                    if ((objMaxValue != null) && (disallowBlank(objMaxValue, "<%=MyBase.GetResourceString("VALID_MAXIMUM_VALUE")%>")))
                        return;
                }
                else if (isSubstringExists(strValidation, ",16,") == true) {
                    if ((objMinValue != null) && (disallowBlank(objMinValue, "<%=MyBase.GetResourceString("VALID_MINIMUM_VALUE")%>")))
                        return;
                }
                else if (isSubstringExists(strValidation, ",17,") == true) {
                    if ((objMaxValue != null) && (disallowBlank(objMaxValue, "<%=MyBase.GetResourceString("VALID_MAXIMUM_VALUE")%>")))
                        return;
                }
            }

            if ((objMaxLength != null) && (objMaxLength.value != "")) {
                if (isSubstringExists(objDBFieldName.value.toUpperCase(), "CUSTOMFIELDTEXTAREA") == true) {
                    if (disallowValueRangeViolation(objMaxLength, 1, 3800, replaceSubstring("<%=Mybase.GetResourceString("MAXLENGTHRANGE")%>", "<=MAX>", "3800")))
                        return;
                }
			/*else if((objDBFieldName.value.toUpperCase() != "CUSTOMFIELDTEXTAREA1") && (objDBFieldName.value.toUpperCase() != "CUSTOMFIELDTEXTAREA2"))
			{
				//if(disallowValueRangeViolation(objMaxLength, 1, 100, replaceSubstring("<%=Mybase.GetResourceString("MAXLENGTHRANGE")%>"," <= MAX > ", "100")))
                //return;
                //} */

            }
            if ((objMinValue != null) && (objMaxValue != null) && (disallowValue1LessThanValue2(objMaxValue, objMinValue, "<%=Mybase.GetResourceString("MAXVALUEGREATERTHANMINVALUE")%>")))
                return;

            if ((isSubstringExists(strValidation, ",12,")) && (isSubstringExists(objDBFieldName.value, "CustomFieldCombo") == false)) {
                if ((objMaxLength != null) && (disallowBlank(objMaxLength, "<%=MyBase.GetResourceString("ENTERMAXLENGTH")%>")))
                    return;
            }

            if (isSubstringExists(objDBFieldName.value, "CustomFieldDate")) {
                if (isDate(objDefaultValue, "<%=MyBase.GetResourceString("DEFAULTVALUEASDATE")%>") == false)
                    return;
            }

            objQuery = GetObjectReference('frmTaskCustomFields', 'txtQueryText');
            if (isSubstringExists(objDBFieldName.value, "CustomFieldCombo")) {

                //Replace () with [] 
                if (objoptComboValue[1].checked == true) {
                    if (disallowBlank(objQuery, "<%=MyBase.GetResourceString("ENTERQUERYORSP")%>"))
                        return;
                    if (disallowMaxlengthViolation(objQuery, 1000, "<%=MyBase.GetResourceString("QUERYMAXSIZE")%>"))
                        return;
                    if (isSubstringExists(objQuery.value, "\"")) {
                        alert("<%=MyBase.GetResourceString("DOUBLEQUOTEDISALLOED")%>");
                        setFocus(objQuery);
                        return;
                    }
                }
            }
            objUserGivenCaption.disabled = false;
            if (objMaxValue != null)
                objMaxValue.disabled = false;
            if (objMinValue != null)
                objMinValue.disabled = false;
            objDataType.disabled = false;
            objDBFieldName.disabled = false;
            objDefaultValue.disabled = false;
            for (i = 0; i < objlstValue.length; i++)

                //Replace () with [] 
                objlstValue.options[i].selected = true;

            objAction = GetObjectReference('frmTaskCustomFields', 'txthidAction_CustomField');
            objAction.value = "<%=ACTION_SAVE%>";
            //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
            var MenuTags = document.getElementsByTagName('A');
            for (i = 0; i < MenuTags.length; i++) {
                if (MenuTags[i].className == "Menu") {
                    //MenuTags[i].style.display= "none";
                    MenuTags[i].parentNode.style.display = "none";
                }
            }
            //End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 
            objForm.action = "PM_CustomFieldMaintenance.aspx?Mode=<%=MODE_DETAILS%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&DatabaseFieldName=<%=m_strDBFieldName%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&EntityName=<%=m_strEntityName%>";
            objForm.submit();
        }
        catch (ex) {
            //alert(ex.message);
        }
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
	    
	    objForm.action = "PM_CustomFieldMaintenance.aspx?Mode=<%=MODE_ASSIGN_TYPES%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&DatabaseFieldName=<%=m_strDBFieldName%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&EntityName=<%=m_strEntityName%>";
	    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
	    var MenuTags = document.getElementsByTagName('A');
	    for (i = 0; i < MenuTags.length; i++) {
	        if (MenuTags[i].className == "Menu") {
	            //MenuTags[i].style.display= "none";
	            MenuTags[i].parentNode.style.display = "none";
	        }
	    }
	    setFrameLoader();
	    //End of Addition by Dhanashri S on 12 Oct 2016
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
	    //Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing
	    var MenuTags = document.getElementsByTagName('A');
	    for(i = 0; i < MenuTags.length; i++)
	    {
	        if (MenuTags[i].className == "Menu")
	        {
	            //MenuTags[i].style.display= "none";
	            MenuTags[i].parentNode.style.display= "none";
	        }
	    }
	    //End of Added By Aniruddh Gujar on 13-April-2015 Purpose::Hexaware Upgrade Issue fixing 
	    objForm.action = "PM_CustomFieldMaintenance.aspx?Mode=<%=MODE_LIST%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&DatabaseFieldName=<%=m_strDBFieldName%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&EntityName=<%=m_strEntityName%>";
	    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
	    var MenuTags = document.getElementsByTagName('A');
	    for (i = 0; i < MenuTags.length; i++) {
	        if (MenuTags[i].className == "Menu") {
	            //MenuTags[i].style.display= "none";
	            MenuTags[i].parentNode.style.display = "none";
	        }
	    }
	    setFrameLoader();
	    //End of Addition by Dhanashri S on 12 Oct 2016
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
		    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
		    setFrameLoader();
		    //End of Addition by Dhanashri S on 12 Oct 2016
			objForm.action = "PM_CustomFieldMaintenance.aspx?Mode=<%=MODE_LIST%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&DatabaseFieldName=<%=m_strDBFieldName%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&EntityName=<%=m_strEntityName%>";
			objForm.submit();
		}
	}
	function Entity_Onchange(strValue)
	{
	    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
	    setFrameLoader();
	    //End of Addition by Dhanashri S on 12 Oct 2016
		objForm.action = "PM_CustomFieldMaintenance.aspx?Mode=<%=MODE_LIST%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&DatabaseFieldName=<%=m_strDBFieldName%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&EntityName=" + strValue ;
		objForm.submit();		
	
	}
	function Sort_OnClick(strFieldName, strAscOrDesc)
	{
	    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
	    setFrameLoader();
	    //End of Addition by Dhanashri S on 12 Oct 2016
		objForm.action = "PM_CustomFieldMaintenance.aspx?Mode=<%=MODE_LIST%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&DatabaseFieldName=<%=m_strDBFieldName%>&txthidSortBy=" + strFieldName + "&txthidSortOrder=" + strAscOrDesc + "&EntityName=<%=m_strEntityName%>" ;
		objForm.submit();		
	}
	
	function CustomField_OnClick(strFieldName,UID)
	{
	    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
	    setFrameLoader();
	    //End of Addition by Dhanashri S on 12 Oct 2016
		objForm.action = "PM_CustomFieldMaintenance.aspx?Mode=<%=MODE_DETAILS%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&DatabaseFieldName=" + strFieldName + "&UniqueID=" + UID + "&EntityName=<%=m_strEntityName%>";
		objForm.submit();
	}
	
	function Add_To_Project_OnClick(strFieldName)
	{   
		var objAction;
		objAction = GetObjectReference('frmTaskCustomeFields','txthidAction_CustomField');
		objAction.value = "<%=ACTION_ADD_CORPORATE_CUSTOMFIELD_TO_PROJECT%>";
	    //Added by Dhanashri S on 12 Oct 2016 For Page Loader
	    setFrameLoader();
	    //End of Addition by Dhanashri S on 12 Oct 2016
		objForm.action = "PM_CustomFieldMaintenance.aspx?Mode=<%=MODE_LIST%>&CORP=<%=m_strPageCalledFrom%>&MasterTagId=<%=m_lngTagId%>&txthidSortBy=<%=m_strSortBy%>&txthidSortOrder=<%=m_strSortOrder%>&DatabaseFieldName=" + strFieldName + "&EntityName=<%=m_strEntityName%>";
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
		 //|| '<%=m_strEntityName%>'.toLowerCase()=='sub projects' || '<%=m_strEntityName%>'.toLowerCase()=='projects' || '<%=m_strEntityName%>'.toLowerCase()=='resource master'
		if('<%=m_strEntityName%>'.toLowerCase()=='help-desk' || '<%=m_strEntityName%>'.toLowerCase()=='global project' || '<%=m_strEntityName%>'.toLowerCase()=='projects') //Added by NitinC on 13 April 2011 for WhizibleSEM 10.0 and sub projects FOR CUSTOM FIELDS
		    window.open("../CRM/CRM_ConfigureAccess_CommonList.aspx?CustomFieldID=" + strUID + "&MasterTagId=3981&EntityName=<%=m_strEntityName%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
		else
		    window.open("../General/CommonList.aspx?CustomFieldID=" + strUID + "&MasterTagId=3562&EntityName=<%=m_strEntityName%>","","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
	}
	
	function ApplicableAttributes_OnClick(UID)
	{
		window.open("../DM/ApplicableAttributes_CommonList.aspx?MasterTagID=3935&NatureOfDemandID=1" ,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
	}


					</script>
