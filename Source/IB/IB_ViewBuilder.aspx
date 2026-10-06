<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IB_ViewBuilder.aspx.vb" Inherits="PbNIT.IB_ViewBuilder" validateRequest="false" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<HTML>
	<%WritePageHead%>
	<%CommonFunctions.General.PlotPageHeadTag("")%>

<link href="../General/loaderStylesheet.css" rel="stylesheet" />

	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
		<form id="frmViewBuilder" method="post" runat="server">
			<%WritePage%>
		</form>
	</body>
</HTML>


<script language="javascript">

        <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>

// =============================== Common To all Mode=====================//
<%If m_strMode = MODE_LIST And m_strAction = ACTION_APPLY Then%>
	var strParentPage
	try
	{	
		strParentPage = new String();
		strParentPage = opener.location.href;
		// If the document loaded in the parent window is the IBIssueList.asp, then refresh the page.						
		if (strParentPage.toUpperCase().indexOf("IBISSUELIST.ASPX") != -1)
		{				
			//Code commented and added by PrashantD on 13 March 2007 for IssueID 11573
			var openerHref = opener.location.href;
					openerHref = replaceSubstring(openerHref,"Mode=Default","");
					if (openerHref.indexOf("cboQuery") == -1)
					openerHref=openerHref +'&cboQuery=<%=Session("intQueryID")%>';
					else
					{
						
						var strcboQuery = openerHref.substring(openerHref.indexOf('cboQuery'),openerHref.length);
						
						if(strcboQuery.indexOf('&')==-1) 
						{
							openerHref = replaceSubstring(openerHref,'cboQuery='+strcboQuery.substring(9,strcboQuery.length),'cboQuery=<%=Session("intQueryID")%>');
						}
						else
						
						openerHref = replaceSubstring(openerHref,'cboQuery='+strcboQuery.substring(9,strcboQuery.indexOf('&')),'cboQuery=<%=Session("intQueryID")%>');
				
					}
					
					opener.location.href = openerHref;
					
					
			
			//opener.location.href = 'IBIssueList.aspx?cboQuery=<%=Session("intQueryID")%>';//opener.location.href													
			//opener.location.href  = opener.location.href ;
			//End of addition by PrashantD on 13 March 2007
		}						
	}
	catch(e)
	{
		// This condition will come if the parentpage has been closed, of changed.
		// Do nothing.						
	}
<%End If%>
	
	var objPageNo, objViewName, objdivlist;
	objdivlist = GetObjectReference('frmViewBuilder','divList');
	
	objViewName = GetObjectReference('frmViewBuilder','txtViewName');
	objPageNo = GetObjectReference('frmViewBuilder','txthidPageNo_ViewBuilder');
	
	//Code commented and Added by SuchitraP on 7-JUN-2007 for JavaScript error
	//setFocus(objViewName);
	if(objViewName)
	{
		setFocus(objViewName);
	}
	//End of addition by SuchitraP on 7-JUN-2007 for JavaScript error
	
	function window_onload()
	{

		var intDivHeight ;
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
	
//==========================Speific to List Mode - Start - =================================//
	function Sort_OnClick(strFieldName, strAscOrDesc)
	{
		var objForm, objSortBy, objSortOrder;
		objForm = GetFormReference('frmViewBuilder');
		objSortBy = GetObjectReference('frmViewBuilder','txthidSortBy');
		objSortOrder = GetObjectReference('frmViewBuilder','txthidSortOrder');
		objSortBy.value = strFieldName;
		objSortOrder.value = strAscOrDesc;
		objForm.submit();		
	}
	
	function AddNew_OnClick()
	{
		window.location.href = "IB_ViewBuilder.aspx?Mode=<%=MODE_ADD%>";
	}
	
	function Apply_OnClick(intProjectViewId)
	{
	    //Commented and added by Yogesh J on 02-Feb-2016 to generate Token
		//var objForm, objAction;
	    //objForm = GetFormReference('frmViewBuilder');
		//objAction = GetObjectReference('frmViewBuilder','txthidAction_ViewBuilder');
	    //objAction.value="<%=ACTION_APPLY%>";
		//objForm.action = "IB_ViewBuilder.aspx?Mode=<%=MODE_LIST%>&ProjectViewID=" + intProjectViewId;
	    //	objForm.submit();
	  
	
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'IB_ViewBuilder.aspx/GenrateURLToken_ViewName_OnClick',
	        data: JSON.stringify({ ProjectViewID: intProjectViewId, EmployeeID: "<%=Session("intUserID")%>" }),
	        success: function (Result) {
	            objForm = GetFormReference('frmViewBuilder');
	            objAction = GetObjectReference('frmViewBuilder','txthidAction_ViewBuilder');
	            objAction.value="<%=ACTION_APPLY%>";
	            objForm.action = "IB_ViewBuilder.aspx?Mode=<%=MODE_LIST%>&ProjectViewID=" + intProjectViewId +"&PKToken="+Result.d;
	            objForm.submit();
			        },
			        error: function () {
			        //    alert("Error")
			        }
	    });
	    //End of addition by Yogesh J on 02-Feb-2016 to generate Token
	}

	function ViewName_OnClick(intProjectViewId)
	{
	    //Commented and added by Yogesh J on 02-Feb-2016 to generate Token
       //	window.location.href = "IB_ViewBuilder.aspx?Mode=<%=MODE_EDIT%>&ProjectViewID=" + intProjectViewId;
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'IB_ViewBuilder.aspx/GenrateURLToken_ViewName_OnClick',
	        data: JSON.stringify({ ProjectViewID: intProjectViewId, EmployeeID: "<%=Session("intUserID")%>" }),
			        success: function (Result) {
			          window.location.href = "IB_ViewBuilder.aspx?Mode=<%=MODE_EDIT%>&PKToken="+ Result.d +"&ProjectViewID=" + intProjectViewId;
			           
			        },
			        error: function () {
			         //   alert("Error")
			        }
         });
	    //End of addition by Yogesh J on 02-Feb-2016 to generate Token
	}
	
	function Delete_OnClick()
	{
		var objForm, objAction;
		objForm = GetFormReference('frmViewBuilder');
		objAction = GetObjectReference('frmViewBuilder','txthidAction_ViewBuilder');
		objAction.value = "<%=ACTION_DELETE%>";
		if(confirm("<%=MyBase.GetResourceString("CONFIRMDELETE")%>"))
		{
			objForm.action = "IB_ViewBuilder.aspx?Mode=<%=m_strMode%>";
			objForm.submit();
		}
	}
	
	function Page_Onclick(strPageNo)
	{
		var objForm;
		objForm = GetFormReference('frmViewBuilder');
		objPageNo.value = strPageNo;
		objForm.action = "IB_ViewBuilder.aspx?Mode=<%=m_strMode%>";
		objForm.submit();
	}
//==========================Speific to List Mode - End - =================================//	

//==========================Speific to Add / Edit Mode - Start - =================================//	
	objlstView_FieldList=GetObjectReference('frmViewBuilder','lstView_FieldList');
	objlstView_SelectedFields=GetObjectReference('frmViewBuilder','lstView_SelectedFields');
	objlstSort_FieldList=GetObjectReference('frmViewBuilder','lstSort_FieldList');
	objlstSort_SelectedFields=GetObjectReference('frmViewBuilder','lstSort_SelectedFields');
	
	function Back_OnClick()
	{
		window.location.href = "IB_ViewBuilder.aspx?Mode=<%=MODE_LIST%>";
	}
	
	function SetAsDefault_OnClick()
	{
		var objForm, objAction;
		objForm = GetFormReference('frmViewBuilder');
		objAction = GetObjectReference('frmViewBuilder','txthidAction_ViewBuilder');
		objAction.value = "<%=ACTION_SETASDEFAULT%>";
	    //objForm.action = "IB_ViewBuilder.aspx?Mode=<%=m_strMode%>&ProjectViewID=<%=m_lngProjectViewId%>";
	    objForm.action = "IB_ViewBuilder.aspx?Mode=<%=m_strMode%>&ProjectViewID=<%=m_lngProjectViewId%>&PKToken=<%=m_strPKToken%>";
		objForm.submit();
	}
	
	//Added By VarunA on 13-July-2007 PMLifeLine Development and Release
	function SetDefault_List_OnClick(ProjectViewID)
	{
	    //Commented and added by Yogesh J on 02-Feb-2016 to generate Token
	    //var objForm; 
	    //objForm = GetFormReference('frmViewBuilder');
	    //objForm.action = "IB_ViewBuilder.aspx?SetAsDefault=1&ProjectViewID=" + ProjectViewID;
	    //objForm.submit();
	   
	
	    $.ajax({
	        type: 'POST',
	        dataType: 'json',
	        contentType: 'application/json',
	        url: 'IB_ViewBuilder.aspx/GenrateURLToken_ViewName_OnClick',
	        data: JSON.stringify({ ProjectViewID: ProjectViewID, EmployeeID: "<%=Session("intUserID")%>" }),
	        success: function (Result) {
	            var objForm; 
	            objForm = GetFormReference('frmViewBuilder');
	            objForm.action = "IB_ViewBuilder.aspx?SetAsDefault=1&ProjectViewID=" + ProjectViewID +"&PKToken="+Result.d;
	            objForm.submit();
			        },
			        error: function () {
			        //    alert("Error")
			        }
	    });
	    //End of addition by Yogesh J on 02-Feb-2016 to generate Token

	}
	//End By VarunA on 13-July-2007
	
    function Save_OnClick() {
        //'Modified by ShraddhaM on Date 01 Jully,2006 for PMLifeLine Issue ID.4168


        //Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
        var Mode = (arguments.length > 0) ? arguments[0] : "0";
        if (Mode == "0") {
            document.body.readonly = true;
            window.setTimeout('Save_OnClick("1")', 1);
            setFrameLoader();
             }
        if (Mode == "1") {
            setFrameLoader();
            //endded By Nilesh g on 25/2/2016 
            var objForm, objAction, objViewName;
            var objOldViewName, objAllViewNames;
            var intCtr, strNewViewName;
            var bln_View_CodedBy, bln_View_AssignTo, bln_Sort_CodedBy, bln_Sort_AssignTo;
            var strAssignToCaption, strCodedByCaption;

            bln_View_CodedBy = false;
            bln_View_AssignTo = false;
            bln_Sort_CodedBy = false;
            bln_Sort_AssignTo = false;

            objForm = GetFormReference('frmViewBuilder');

            objAction = GetObjectReference('frmViewBuilder', 'txthidAction_ViewBuilder');

            objViewName = GetObjectReference('frmViewBuilder', 'txtViewName');

            objOldViewName = GetObjectReference('frmViewBuilder', 'txthidOldViewName');

            objAllViewNames = GetObjectReference('frmViewBuilder', 'txthidAllViewNames');

            //Added by swapnil aswale on 17th Nov 2015 for special character validation
            var objViewName;
            objViewName = GetObjectReference('frmViewBuilder', 'txtViewName');
            if (disallowSpecialCharacters(objViewName, "Characters '/:*?+\"><,\\\\' are not allowed")) {
                RemoveFrameLoader();
                return false;
            }
            //Ended

            if (disallowBlank(objViewName, "<%=MyBase.GetResourceString("ENTERVIEWNAME")%>")) {
                RemoveFrameLoader();
                return;
            }
           

            if (objlstView_SelectedFields.length == 0) {
                alert("<%=MyBase.GetResourceString("SELECTVIEWFIELDS")%>");
                RemoveFrameLoader();//Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
                return;
            }

            for (intCtr = 0; intCtr < objlstView_SelectedFields.length; intCtr++) {
                objlstView_SelectedFields.options[intCtr].selected = true;
                if (isSubstringExists(objlstView_SelectedFields.options[intCtr].value, "AssignTo"))
                    bln_View_AssignTo = true;
                if (isSubstringExists(objlstView_SelectedFields.options[intCtr].value, "CodedBy"))
                    bln_View_CodedBy = true;
            }

            for (intCtr = 0; intCtr < objlstSort_SelectedFields.length; intCtr++) {
                objlstSort_SelectedFields.options[intCtr].selected = true;
                if (isSubstringExists(objlstSort_SelectedFields.options[intCtr].value, "AssignTo")) {
                    bln_Sort_AssignTo = true;
                    strAssignToCaption = replaceSubstring(objlstSort_SelectedFields.options[intCtr].innerHTML, " ASC", "");
                    strAssignToCaption = replaceSubstring(strAssignToCaption, " DESC", "");
                }
                if (isSubstringExists(objlstSort_SelectedFields.options[intCtr].value, "CodedBy")) {
                    bln_Sort_CodedBy = true;
                    strCodedByCaption = replaceSubstring(objlstSort_SelectedFields.options[intCtr].innerHTML, " ASC", "");
                    strCodedByCaption = replaceSubstring(strCodedByCaption, " DESC", "");
                }
            }

            if ((bln_Sort_AssignTo == true) && (bln_View_AssignTo == false)) {
                alert("<%=MyBase.GetResourceString("ADDFIELD")%> '" + strAssignToCaption + "' <%=MyBase.GetResourceString("INDISPLAYFIELDS")%>");
                RemoveFrameLoader();//Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
                return;
            }

            if ((bln_Sort_CodedBy == true) && (bln_View_CodedBy == false)) {
                alert("<%=MyBase.GetResourceString("ADDFIELD")%> '" + strCodedByCaption + "' <%=MyBase.GetResourceString("INDISPLAYFIELDS")%>");
                RemoveFrameLoader();//Added By Nilesh g on 25/2/2016 Purpose : Prevent Save Data Double on Double Click
                return;
            }

            // Check if the view name already exists in database.
            if (isSubstringExists(objAllViewNames.value, "<%=STR_SEPERATOR%>" + objViewName.value + "<%=STR_SEPERATOR%>") > 0) {
                if (objViewName.value.toUpperCase() != objOldViewName.value.toUpperCase()) {
                    alert("<%=MyBase.GetResourceString("VIEWWITHDIFFERENTNAME")%>");
                    RemoveFrameLoader();
                    return;
                }
            }

            objAction.value = "Save";
            setFrameLoader();
            if (objViewName.value.toUpperCase() != objOldViewName.value.toUpperCase()) {
                objForm.action = "IB_ViewBuilder.aspx?Mode=<%=m_strMode%>";
            }
            else {
                //COMMENTED AND ADDED BY NILESH G ON 26/8/2016 PURPOSE : PKTOKEN
                //objForm.action = "IB_ViewBuilder.aspx?Mode=<%=m_strMode%><%If m_lngProjectViewId <> 0 Then Response.Write("&ProjectViewID=" & m_lngProjectViewId)%>";
                objForm.action = "IB_ViewBuilder.aspx?Mode=<%=m_strMode%><%If m_lngProjectViewId <> 0 Then Response.Write("&ProjectViewID=" & m_lngProjectViewId & "&PKToken=" & m_strPKToken)%>";
            }

            objForm.submit();
            RemoveFrameLoader();
        }
    }
	
/*The below written function are customized for this page only. Those are present in QueryBuilder.js also*/	
	function MoveSelectedTo_Custom(objListBox1,objListBox2)	
	{
		var optTag;
		if (objListBox1.selectedIndex == -1)
		{
			return;
		}
		objListBox2.SelectedIndex = -1;
		//Modified by SantoshK on Date June 8, 2006 for PMLifeLine Issue ID.4168
		//Purpose : Firefox Support, () changed to [] and innerHTML chaned to innerHTML
		while (objListBox1.selectedIndex != -1)
		{
			optTag = document.createElement("OPTION");
			if(objListBox2.id == "lstSort_SelectedFields"){
				//optTag.innerHTML = trimString(objListBox1.options(objListBox1.selectedIndex).innerHTML) + " ASC";
				optTag.innerHTML = trimString(objListBox1.options[objListBox1.selectedIndex].innerHTML) + " ASC";
				optTag.value = trimString(objListBox1.options[objListBox1.selectedIndex].value) + " ASC";
			}			
			else if(objListBox2.id == "lstSort_FieldList"){
				//optTag.innerHTML = replaceSubstring(objListBox1.options(objListBox1.selectedIndex).innerHTML," ASC","");
				//optTag.innerHTML = replaceSubstring(optTag.innerHTML," DESC","");
				optTag.innerHTML = replaceSubstring(objListBox1.options[objListBox1.selectedIndex].innerHTML," ASC","");
				optTag.innerHTML = replaceSubstring(optTag.innerHTML," DESC","");
				optTag.value = replaceSubstring(objListBox1.options[objListBox1.selectedIndex].value," ASC","");
				optTag.value= replaceSubstring(optTag.value," DESC","");
			}
			else{			
				//optTag.innerHTML = trimString(objListBox1.options(objListBox1.selectedIndex).innerHTML);
				optTag.innerHTML = trimString(objListBox1.options[objListBox1.selectedIndex].innerHTML);
				optTag.value = trimString(objListBox1.options[objListBox1.selectedIndex].value);
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
			//Modification Ends by SantoshK on June 8, 2006
		}
	}
	
	function MoveAllTo_Custom(objListBox1,objListBox2)	
	{		
		var optTag;
		if (objListBox1.length == 0)
		{
			return;
		}
		//Modified by SantoshK on Date June 8, 2006 for PMLifeLine Issue ID.4168
		//Purpose : Firefox Support, () changed to [] and innerHTML chaned to innerHTML
		objListBox2.SelectedIndex = -1;
		while (objListBox1.length >0)
		{
			optTag = document.createElement("OPTION");
			if(objListBox2.innerTextid == "lstSort_SelectedFields"){
				//optTag.Text = trimString(objListBox1.options(0).innerHTML) + " ASC";
				optTag.innerHTML = trimString(objListBox1.options[0].innerHTML) + " ASC";
				optTag.value = trimString(objListBox1.options[0].value) + " ASC";
			}			
			else if(objListBox2.id == "lstSort_FieldList"){
				//optTag.innerHTML = replaceSubstring(objListBox1.options(0).innerHTML," ASC","");
				//optTag.innerHTML = replaceSubstring(optTag.innerHTML," DESC","");
				optTag.innerHTML = replaceSubstring(objListBox1.options[0].innerHTML," ASC","");
				optTag.innerHTML = replaceSubstring(optTag.innerHTML," DESC","");
				optTag.value = replaceSubstring(objListBox1.options[0].value," ASC","");
				optTag.value= replaceSubstring(optTag.value," DESC","");
			}
			else{		
				//optTag.innerHTML = trimString(objListBox1.options(0).innerHTML);
				optTag.innerHTML = trimString(objListBox1.options[0].innerHTML);
				optTag.value = trimString(objListBox1.options[0].value);				
			}
			//append the tag						
			objListBox2.appendChild(optTag);						
			objListBox1.remove(0);						
		}
		//Modification Ends by SantoshK on June 8, 2006
	}
	
	
	/*========================== for Display Fields=====================*/
	function btnView_AddSelected_OnClick_Custom()
	{
		MoveSelectedTo_Custom(objlstView_FieldList, objlstView_SelectedFields);
	}
				
	function btnView_RemoveSelected_OnClick_Custom()
	{
		MoveSelectedTo_Custom(objlstView_SelectedFields, objlstView_FieldList);
	}
				
	function btnView_AddAll_OnClick_Custom() 
	{
		MoveAllTo_Custom(objlstView_FieldList, objlstView_SelectedFields );							
	}
				
	function btnView_RemoveAll_OnClick_Custom() 
	{
		MoveAllTo_Custom(objlstView_SelectedFields, objlstView_FieldList);
	}

	function lstView_FieldList_OnDblClick_Custom() 								
	{
		MoveSelectedTo_Custom(objlstView_FieldList, objlstView_SelectedFields);
	}
	
	function lstView_SelectedFields_OnDblClick_Custom() 						
	{
		MoveSelectedTo_Custom(objlstView_SelectedFields, objlstView_FieldList);
	}
	/*========================== for Display Fields=====================*/
	
	/*========================== For Sort Fields=====================*/
	function btnSort_AddSelected_OnClick_Custom()
	{
		MoveSelectedTo_Custom(objlstSort_FieldList, objlstSort_SelectedFields);
	}
				
	function btnSort_RemoveSelected_OnClick_Custom()
	{
		MoveSelectedTo_Custom(objlstSort_SelectedFields, objlstSort_FieldList);
	}
				
	function btnSort_AddAll_OnClick_Custom() 
	{
	//Code commented and added by PrashantD on 12 March 2007 for IssueID 11538
		//MoveAllTo_Custom(objlstSort_FieldList, objlstSort_SelectedFields );							
		var i;
		for(i=0;i<objlstSort_FieldList.options.length;i++)
		objlstSort_FieldList.options[i].selected =true;
		MoveSelectedTo_Custom(objlstSort_FieldList, objlstSort_SelectedFields);
		
		//End of Addition by PrashantD on 12 March 2007
	}
				
	function btnSort_RemoveAll_OnClick_Custom() 
	{
		MoveAllTo_Custom(objlstSort_SelectedFields, objlstSort_FieldList);
	}
	
	function lstSort_FieldList_OnDblClick_Custom() 								
	{
		MoveSelectedTo_Custom(objlstSort_FieldList, objlstSort_SelectedFields);
	}
	/*========================== For Sort Fields=====================*/
//==========================Speific to Add / Edit Mode - Start - =================================//	
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
    /*Added By Vaijat K ON 03/11/2015*/
    .footerMenuTable
    {
        bottom:0px !important;
        position:absolute !important;
    }
</style>

<script type="text/javascript">
    $(document).ready(function () {
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if ($('.clsPageBody').find('#frmCommonPage').find('#divPage').find('#divSection2').find('.clsSubTagTable').find('#divListTag').find('table').find('.clsTRSectionHeader').length > 0) {
            removeSectionHeader();
        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-whiz41-Web Form Extension Type
        /*---------------------------------------------------------*/
        if ($('.clsgridtable').length > 0) {
            var divName = $('.clsPageBody').find('#divSection2').find('#divListTag').attr('id');
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

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/

        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Responsive Navigation Tabs
        // Description:Display navigation tabs in dropdown
        // By Whom: Miiint
        // When:07/02/2015
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').addClass('gridTabsOuterTable');
        $('#divSection2').find('.gridTabsOuterTable').find('table:first').addClass('responsiveNavigationTabsClass');
        var responsiveNavigationClass = 'responsiveNavigationTabsClass';
        var responsiveNavigationParentTblClass = 'gridTabsOuterTable';
        if (windowWidth < 992) {
            responsiveNavigationTabs(responsiveNavigationClass, responsiveNavigationParentTblClass);
        }
        else {
            $('#divSection2').find('.clsTable:first').find('table:first').css('display', 'block');
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

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/
    });

    $(window).resize(function () {
        document.body.style.height = window.innerHeight - 3 + 'px'; //Added By Vaijat K ON 14/12/2015
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

        var windowWidth = $(window).width();
        if (windowWidth < 992) {

        }
        else {

        }
        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-Remove footer
        /*---------------------------------------------------------*/
        $('#divSection2').find('.clsTable:first').css({ 'float': 'none', 'margin-bottom': '0px' });

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

        if (windowWidth < 1040) {
            var text = $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').text();
            if (text == "Total") {
                $('#tblGrid1053121').find('tr:nth-last-child(2)').find('td:first').find('span').css('display', 'none');
                $('#tblGrid1053121').find('tr:last').css('display', 'none');
            }
        }

        /*---------------------------------------------------------*/
        // Ends Feature Tag:whiz41-remove plus sign of Footable for 'Total' column
        /*---------------------------------------------------------*/

    });

</script>
<!--Ended by Nilesh gundecha on 18/9/2015 for Responsive Common Page-->