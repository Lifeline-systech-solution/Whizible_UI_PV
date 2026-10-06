<%@ Page Language="vb" AutoEventWireup="false" Codebehind="IBIssueTypes_New.aspx.vb" Inherits="PbNIT.IBIssueTypes_New" validateRequest="false" %>
<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">--%>
<!DOCTYPE HTML>
<html>
  <%WritePageHead%>
  <%CommonFunctions.General.PlotPageHeadTag("")%>

      <link rel="stylesheet" href="../../Whizible2.0/dist/css/style_custom_project.css?v=3"> 

<!-- <link href="../../Whizible2.0/plugins/alertify/css/alertify.min.css" rel="stylesheet" />  -->
    <style type="text/css">

        .clsBody.no-border-main-wrap {border: none !important;padding: 0px !important;margin: 0px !important;font-family: 'Roboto', sans-serif !important; }
        .bgwhite, .new-main-wrap table {background-color:#fff !important;}
        .new-main-wrap #tblPL00 {display:none;}
        .new-main-wrap table.clsTable.topInnerMenu {margin: 10px 0px;}
        .new-main-wrap .clsTable.topInnerMenu .clsTRMenu td[align="left"] {display:none !important;}
        .new-main-wrap .PagingNormal {margin-right:2px;}
        .new-main-wrap table td{border-color: #ddd}
        .new-main-wrap .clsTRPageCaption {background-color:#4263c1;padding:10px 5px 10px 15px;display:block;margin:0px 0px 10px;height:auto;}
        .new-main-wrap .clsTRPageCaption td {color: #fff;margin: 0px;font-size: 16px !important;padding: 0px !important;}
        .new-main-wrap #tblCap00 {background-color:#fff !important;}
        .new-main-wrap .clsTRPageHeader {background: #e7edf0;padding:10px 15px;width: 95%;margin: 0 auto;display:table;word-spacing: 1px;}
        .new-main-wrap tr.clsTRColumnHeader {background: #e7edf0;color: #464a4c;font-weight: 600;}
        .new-main-wrap tr.clsTRColumnHeader td {border: 1px solid #ddd !important;border-bottom-width: 2px !important;}
        .new-main-wrap tr.clsTRColumnHeader td {padding:8px 2px;font-size:14px;}
        .new-main-wrap tr.clsTREven td  {padding:5px 2px; font-size:14px;}
        .new-main-wrap tr.clsTREven {padding: 0px;margin: 0px;height: 0px;}
        .new-main-wrap tr.clsTREven td[colspan="10"] {display:none;}
        .new-main-wrap #divList{width: 97.6% !important;margin:0 auto;}
        .new-main-wrap .clsTable.footerMenuTable {display:none !important;}
        .new-main-wrap TR.clsTRMenu {height:30px;}
        .new-main-wrap input.clsTextBox, .clsComboBox {padding: 5px 10px;width: 230px !important;height:30px;}
        .new-main-wrap #divList #tblCap00 {width:100%;}
        .new-main-wrap #divList > table:nth-child(5) {padding:0% 14%;}
        #lstStatus, #lstSubType {height:100px;}

    </style>

  <body MS_POSITIONING="GridLayout" class="clsBody no-border-main-wrap" onresize="window_onresize()" onload="window_onload()">
	<div id="divIssueType" style="FONT-SIZE: 9pt!important;">
      <form id="frmIssueTypes" method="post" runat="server" class="new-main-wrap bgwhite">
		<%WritePage%>
	</form>
        </div>
  </body>
</html>
<script language="javascript">

            <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		    
// =============================== Common To all Mode=====================//
    function getURLParameter(url, name) {
        return (RegExp(name + '=' + '(.+?)(&|$)').exec(url) || [, null])[1];
    }
    function refreshMyParent() {
        try {
           
            //Commented By Usha Pandit On 16.01.2020 For Refresh issue 
            var newpath = opener.window.location.href;
            
            if (newpath.indexOf('FromWhereProjectId') == -1) {
                newpath = opener.window.location.href.replace('#', '?');
                newpath = newpath + "FromWhereProjectId='<%= Request.QueryString("ProjectID") %>'&FromWhereData=C&PKToken='<%=m_PKToken_IBIssueTypes%>'&Mode=Edit&update=done";
            }
            newpath = newpath.toString().replace("&update=done", "");
            var currentFromWhereProjectId = getURLParameter(newpath, "FromWhereProjectId");
            var currentToken = getURLParameter(newpath, "PKToken");

            newpath = newpath.toString().replace("PKToken=" + currentToken, "PKToken=" + '<%=m_PKToken_IBIssueTypes%>');
            newpath = newpath.toString().replace("FromWhereProjectId=" + currentFromWhereProjectId, "FromWhereProjectId=" + '<%= Request.QueryString("ProjectID") %>');
            newpath = newpath.toString().replace("FromWhereData=D", "FromWhereData=C");
            if (newpath.indexOf("Add#") != -1) {
                newpath = newpath.toString().replace("Add#", "Edit&update=done");
            }
            else if (newpath.indexOf("Edit#") != -1) {
                newpath = newpath.toString().replace("Edit#", "Edit&update=done");
            }
            else if (newpath.indexOf("Edit") != -1) {
                newpath = newpath.toString().replace("Edit", "Edit&update=done");
            }            
            opener.window.location.replace(newpath);
            //End Of Commented By Usha Pandit On 16.01.2020 For Refresh issue 
        }
        catch (ex) {
            //alert(ex.message);
        }
    }
<%If (m_strAction = ACTION_SUCCESSFUL) AND (m_strMode = MODE_STATUS Or m_strMode = MODE_SUBTYPE) Then%>
	var strParentPage;
	try
	{	
		strParentPage = new String();
		strParentPage = opener.location.href;
		// If the document loaded in the parent window is the IBIssueTypes.asp, then refresh the page.						
		if (strParentPage.toUpperCase().indexOf("IBISSUETYPES_NEW.ASPX") != -1)
		{	
            
		    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
            try {
                setFrameLoader();
            }
            catch (ex) {
                //alert(ex.message);
            }
		    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
			opener.frmIssueTypes.action = opener.location.href;
			opener.frmIssueTypes.submit();
			//opener.location.href = opener.location.href								
		}						
	}
	catch(e)
	{
		// This condition will come if the parentpage has been closed, of changed.
		// Do nothing.						
	}
	window.close();
	function window_onload()
	{
	}
	function window_onresize()		
	{
	}
<%Else%>	

	var objForm;
	var objdivlist;
	objForm = GetFormReference('frmIssueTypes');
	objdivlist = GetObjectReference('frmIssueTypes','divList');
	
	function window_onload()
	{
	   // debugger;
		var intDivHeight ;
		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
		//'Modified by ShraddhaM on Date 01 Jully,2006 for WhizibleSEM Issue ID.4168
		/*if(navigator.appName == 'Netscape')
			{
			if("<%=m_strMode%>"=='Edit')
			{
			 
			    intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 80;
			   
			 }
			 else if("<%=m_strMode%>"=='Add')
			 {
			 
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 75;
				
			 }
			 else
				intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 2290;
				
			}*/
			//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

			if(navigator.appName == 'Netscape')
			{		  
			    
			    intDivHeight =window.innerHeight  - objdivlist.offsetTop - 40 -6;
			    
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
		//'Modified by ShraddhaM on Date 12 July,2006 for WhizibleSEM Issue ID.4168

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
// =============================== Specific to List Mode =====================//
<%If m_strMode = MODE_LIST%>
	var objFocusCtrl;
	objFocusCtrl = GetObjectReference('frmIssueTypes','cboCustomerProjects');
	if(objFocusCtrl != null)
		setFocus(objFocusCtrl);
	
	function Sort_OnClick(strFieldName, strAscOrDesc)
	{
		var objSortBy, objSortOrder;
		objSortBy = GetObjectReference('frmIssueTypes','txthidSortField');
		objSortOrder = GetObjectReference('frmIssueTypes','txthidSortOrder');
		objSortBy.value = strFieldName;
		objSortOrder.value = strAscOrDesc;
		objForm.submit();		
	}

	function ApplyProjectTypes_OnClick()
	{
		var objAction, objCboCustomerProjects;
		objCboCustomerProjects = GetObjectReference('frmIssueTypes','cboCustomerProjects');
		objAction = GetObjectReference('frmIssueTypes','txthidAction_IssueTypes');
		if (disallowBlank(objCboCustomerProjects, "<%=MyBase.GetResourceString("SELECTPROJECT")%>"))
			return;
		//Added by PrashantD on 27 April 2007 for IssueID 11617
		if (confirm("You might lose existing issue type settings.\n Do you want to continue?") == false)
		return;
		//End of addition by PrashantD on 17 April 2007
		
	    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
        try {
            setFrameLoader();
        }
        catch (ex) {
            //alert(ex.message);
        }
	    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
		objAction.value = "<%=ACTION_APPLY_PROECT_TYPES%>";
		objForm.action = "IBIssueTypes_New.aspx?Mode=<%=MODE_LIST%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>";
		objForm.submit();
	}
	
	function ConfigureMails_OnClick(strProjectIssueType)
	{
		window.open("IB_StatusMailConfiguration.aspx?ProjectIssueType=" + strProjectIssueType,"","resizable=no,scrollbars=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 600)/2 + ",width=600,height=600");
	}	
/*
		'By     :   DipaliS
        'Reason :   Apply Role Level Security
        'Date   :   28 June 2004
        'Requirement Number :   IB_PBN_ENT_01
        'Addition Made  :   Function for Click on Config Type Security
*/
	function ConfigType_OnClick()
	{
		window.open ("../General/CommonList.aspx?FromWhere=PM&MasterTagID=2002", "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 750)/2 + ",top=" +(window.screen.height - 500)/2 + ",width=750,height=500", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 0)/2) + ",top=" + ((window.screen.height - 0)/2) + ",width=0,height=0");
				
	}
	/*End Addition*/
		
	function cboCustomerProjects_onchange()
	{
        
	    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
        try {
            setFrameLoader();
        }
        catch (ex) {
            //alert(ex.message);
        }
	    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
		objForm.action = "IBIssueTypes_New.aspx?Mode=<%=MODE_LIST%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>";
		objForm.submit();
	}
	function AddNew_OnClick()
	{
		var objIssueId;
		objIssueId = GetObjectReference('frmIssueTypes','txthidIssueTypeId');
		objIssueId.value = "";
        
	    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
        try {
            setFrameLoader();
        }
        catch (ex) {
            //alert(ex.message);
        }
	    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
        objForm.action = "IBIssueTypes_New.aspx?Mode=<%=MODE_ADD%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>";
        objForm.submit();

	}
	function Page_Onclick(strPageNumber)
	{
		var objPageNo;
		objPageNo = GetObjectReference('frmIssueTypes','txthidPageNumber');
		objPageNo.value = strPageNumber;
        
	    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
        try {
            setFrameLoader();
        }
        catch (ex) {
            //alert(ex.message);
        }
	    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
		objForm.action = "IBIssueTypes_New.aspx?Mode=<%=MODE_LIST%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>";
		objForm.submit();
	}
    //Added by Chetan M on 12 Nov 2020 for token issue
    var PKTokenStatusClick;
    //End of Added by Chetan M on 12 Nov 2020 for token issue
    function Status_OnClick(intProjectTypeStatusID) {
        //Added by Yogesh Jalamkar  on 02 AUG 2016 to validate Token
        //window.open("IBIssueTypes.aspx?Mode=<%=MODE_STATUS%>&MasterTagId=<%=m_lngTagId%>&ProjectTypeStatusID=" + intProjectTypeStatusID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 450)/2 + ",top=" + (window.screen.height - 250)/2 + ",width=450,height=250")

        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'IBIssueTypes_New.aspx/GenrateURLToken_StatusOnclick',
            data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>", ProjectTypeStatusID: intProjectTypeStatusID, MasterTagId: "<%=m_lngTagId%>" }),
            success: function (Result) {
                //Added by Chetan M on 12 Nov 2020 for token issue
                PKTokenStatusClick = Result.d;
                //End of Added by Chetan M on 12 Nov 2020 for token issue
                window.open("IBIssueTypes_New.aspx?Mode=<%=MODE_STATUS%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>&ProjectTypeStatusID=" + intProjectTypeStatusID + "&PKTokenStatusClick=" + Result.d, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 450) / 2 + ",top=" + (window.screen.height - 250) / 2 + ",width=450,height=250")
                //var newpath = opener.window.location.href;
                //newpath = newpath.toString().replace("&update=done", "");
                //if (newpath.indexOf("Edit#") != -1) {
                //    newpath = newpath.toString().replace("Edit#", "Edit&update=done");
                //}
                //else if (newpath.indexOf("Edit") != -1) {
                //    newpath = newpath.toString().replace("Edit", "Edit&update=done");
                //}
                //opener.window.location.replace(newpath);

            },
            error: function () {
                // alert("Error")
            }
        });
        //End of addition Yogesh Jalamkar  on 02 AUG 2016 to validate Token
    }
    function SubType_OnClick(intSubTypeID) {
        //Added by Yogesh Jalamkar  on 02 AUG 2016 to validate Token
        //window.open("IBIssueTypes.aspx?Mode=<%=MODE_SUBTYPE%>&MasterTagId=<%=m_lngTagId%>&SubTypeID=" + intSubTypeID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 450)/2 + ",top=" + (window.screen.height - 250)/2 + ",width=450,height=250")


        $.ajax({
            type: 'POST',
            dataType: 'json',
            contentType: 'application/json',
            url: 'IBIssueTypes_New.aspx/GenrateURLToken_SubTypeOnclick',
            data: JSON.stringify({ EmployeeID: "<%=Session("intUserID")%>", SubTypeID: intSubTypeID, MasterTagId: "<%=m_lngTagId%>" }),
            success: function (Result) {
                window.open("IBIssueTypes_New.aspx?Mode=<%=MODE_SUBTYPE%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>&SubTypeID=" + intSubTypeID + "&PkTokenSubType=" + Result.d, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 450) / 2 + ",top=" + (window.screen.height - 250) / 2 + ",width=450,height=250")
                //var newpath = opener.window.location.href;
                //newpath = newpath.toString().replace("&update=done", "");
                //if (newpath.indexOf("Edit#") != -1) {
                //    newpath = newpath.toString().replace("Edit#", "Edit&update=done");
                //}
                //else if (newpath.indexOf("Edit") != -1) {
                //    newpath = newpath.toString().replace("Edit", "Edit&update=done");
                //}
                //opener.window.location.replace(newpath);
            },
            error: function () {
                // alert("Error")
            }
        });
        //End of addition Yogesh Jalamkar  on 02 AUG 2016 to validate Token
    }
	function SelectAll_OnClick()
	{
		var iCnt;
		var objCheckBox, objCheckBoxCount;
		
		objCheckBoxCount = GetObjectReference('frmIssueTypes','txthidCheckboxCount');
		
		if(objCheckBoxCount.value == 1)
		{
			objCheckBox = GetObjectReference('frmIssueTypes','chkDelete');
			if(objCheckBox.disabled == false)
				objCheckBox.checked =  true;
		}
		else if(objCheckBoxCount.value > 0)
		{
			objCheckBox = GetObjectReference('frmIssueTypes','chkDelete', true);
			for (iCnt=0; iCnt < objCheckBoxCount.value; iCnt++)
			{
				if(objCheckBox[iCnt].disabled == false)
				{
					objCheckBox[iCnt].checked = true;
				}
			}
		}
	}
	function Type_OnClick(strIssueTypeID)
    {
       
		var objIssueId;
		objIssueId = GetObjectReference('frmIssueTypes','txthidIssueTypeId');
		objIssueId.value = strIssueTypeID;
        
	    //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
        try {
            setFrameLoader();
        }
        catch (ex) {
            //alert(ex.message);
        }
	    // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
       //Added By Reshma Chavan on 15Jan 2021 For Issue Type page crash
        if (ProjectID == "") {           
              ProjectID = '<%= Session("intProjectID") %>'
        }
       //End of Added By Reshma Chavan on 15Jan 2021 For Issue Type page crash
        if ('<%= Request.QueryString("PKToken") %>' != "") {
           
            objForm.action = "IBIssueTypes_New.aspx?Mode=<%=MODE_EDIT%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>&PKToken=<%= Request.QueryString("PKToken") %>";
        }
        else {
            objForm.action = "IBIssueTypes_New.aspx?Mode=<%=MODE_EDIT%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>";
        }
        //objForm.action = "IBIssueTypes_New.aspx?Mode=<%=MODE_EDIT%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>&PKToken='<%=m_PKToken_IBIssueTypes%>'";
        
		objForm.submit();
    }
    
    function Delete_OnClick() {
        try {
            var iCnt;
            var objCheckBox, objCheckBoxCount, objTypeUsed;
            var objAction;

            objAction = GetObjectReference('frmIssueTypes', 'txthidAction_IssueTypes');
            objCheckBoxCount = GetObjectReference('frmIssueTypes', 'txthidCheckboxCount');

		<%' Added By NitinVS on 9 Apr 2007 for WhizibleSEM SP 8 Regression Issue 11611 %>
            var blnIsRecordSelected = false; blnIsRecordSelected = IsCheckboxSelected('frmIssueTypes', 'chkDelete')
            if (blnIsRecordSelected == false) {
                //Added By VarunA on 27-June-2007 Whizible Regeression Project Issse-12419
                //Purpose : to have alert msg when no records is selected
                alert('Please select Issue Type to delete');
                //End By VarunA on 27-June-2007 Issse-12419 
                return;
            }
		<%' End added By NitinVS on 9 Apr 2007 for WhizibleSEM SP 8 Regression Issue 11611 %>

            if (objCheckBoxCount.value == 0)
                return;
            if (confirm("<%=MyBase.GetResourceString("CONFIRMDELETE")%>")) {
                if (objCheckBoxCount.value == 1) {
                    objCheckBox = GetObjectReference('frmIssueTypes', 'chkDelete');
                    objTypeUsed = GetObjectReference('frmIssueTypes', 'txthidTypeUsed');
                    if ((objCheckBox.checked == true) && (objTypeUsed.value == "1")) {
                        if (!confirm("<%=MyBase.GetResourceString("THETYPE")%> " + objCheckBox.value.toString() + " <%=MyBase.GetResourceString("CONFIRMDELETE_TYPEUSED")%>"))
                            objCheckBox.checked = false;
                    }
                }
                else if (objCheckBoxCount.value > 1) {
                    objCheckBox = GetObjectReference('frmIssueTypes', 'chkDelete', true);
                    objTypeUsed = GetObjectReference('frmIssueTypes', 'txthidTypeUsed', true);
                    //Commented and added by Chetan M on 9th April 2020 for IssueID = 23066
                for (var i = 0; i < objCheckBox.length; i++) {                      
                    if (objCheckBox[i].checked == true && (objTypeUsed[i].value == "1"))
                    {
						if(!confirm("<%=MyBase.GetResourceString("THETYPE")%> " + objCheckBox[i].value.toString() + " <%=MyBase.GetResourceString("CONFIRMDELETE_TYPEUSED")%>"))
                       objCheckBox[i].checked = false;
                    }
                    continue;                    
                }			
                 
                   <%-- for (iCnt = 0; iCnt < objCheckBoxCount.value; iCnt++) {
                        if ((objCheckBox[iCnt].checked == true) && (objTypeUsed[iCnt].value == "1")) {
                            if (!confirm("<%=MyBase.GetResourceString("THETYPE")%> " + objCheckBox[iCnt].value.toString() + " <%=MyBase.GetResourceString("CONFIRMDELETE_TYPEUSED")%>"))
                                objCheckBox[iCnt].checked = false;
                        }
                    }--%>
                    //End of Commented and added by Chetan M on 9th April 2020 for IssueID = 23066
                }
                objAction.value = "<%=ACTION_DELETE%>";

                //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
                try {
                    setFrameLoader();
                }
                catch (ex) {
                    //alert(ex.message);
                }
                // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
                objForm.action = "IBIssueTypes_New.aspx?Mode=<%=m_strMode%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>";
                objForm.submit();
                refreshMyParent();
            }
        }
        catch (ex) {
            //alert(ex.message);
        }
    }
<%End If%>	
// =============================== Specific to List Mode =====================//
// =============================== Specific to Status Mode =====================//
<%If m_strMode = MODE_STATUS Then%>
	var objFocusCtrl;
	objFocusCtrl = GetObjectReference('frmIssueTypes','txtStatus');
	if(objFocusCtrl != null)
        setFocus(objFocusCtrl);
     //Added by Chetan M on 25th Dec 2019
	//Purpose:Handle the action of REMOVE DEFAULT	
    function RemoveDefault_OnClick() {
        var objAction;
        objAction = GetObjectReference('frmIssueTypes', 'txthidAction_IssueTypes');
        objStatus = GetObjectReference('frmIssueTypes', 'txtStatus');
        objCorporateStatus = GetObjectReference('frmIssueTypes', 'cboCorporateStatus');

        objAction.value = "<%=ACTION_REMOVEDEFAULT%>";
        try {
            setFrameLoader();
        }
        catch (ex) {
            //alert(ex.message);
        }
        objForm.action = "IBIssueTypes_New.aspx?Mode=<%=MODE_STATUS%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>";
        objForm.submit();
        //window.close();
        //window.location.reload();
        //window.opener.location.reload();
        //Commented And Added By Usha Pandit On 13.08.2020 for refresh issue
        //refreshMyParent();
        window.onunload = refreshParent;
        //End Of Added By Usha Pandit On 13.08.2020 for refresh issue
    }
    //End of Addition by Chetan M
    function Save_OnClick(intProjectTypeStatusId) {
        var objAction, objStatus, objCorporateStatus;
       
        objAction = GetObjectReference('frmIssueTypes', 'txthidAction_IssueTypes');
        objStatus = GetObjectReference('frmIssueTypes', 'txtStatus');
        objCorporateStatus = GetObjectReference('frmIssueTypes', 'cboCorporateStatus');

        if (disallowBlank(objStatus, "<%=MyBase.GetResourceString("ENTERSTATUS")%>"))
            return;
        if (disallowBlank(objCorporateStatus, "<%=MyBase.GetResourceString("MAPCORPORATESTATUS")%>"))
            return;
        objAction.value = "<%=ACTION_SAVE%>";

        //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
        try {
            setFrameLoader();
        }
        catch (ex) {
            //alert(ex.message);
        }
        // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
        objForm.action = "IBIssueTypes_New.aspx?Mode=<%=MODE_STATUS%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>&ProjectTypeStatusID=" + intProjectTypeStatusId;
        objForm.submit();

        //Commented And Added By Usha Pandit On 13.08.2020 for refresh issue
        //refreshMyParent();
        window.onunload = refreshParent;
        //End Of Added By Usha Pandit On 13.08.2020 for refresh issue
    }

    //Added By Usha Pandit On 13.08.2020 for refresh issue
    function refreshParent() {
	    window.opener.location.reload();
	}
    //End Of Added By Usha Pandit On 13.08.2020 for refresh issue

	function ConfigureMails_OnClick(strType, strStatus)
	{        
		window.open("IB_StatusMailConfiguration.aspx?ProjectIssueType=" + strType + "&ProjectIssueStatus=" + strStatus ,"","resizable=no,scrollbars=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=600,height=400");
	}
<%End If%>
// =============================== Specific to Status Mode =====================//
// =============================== Specific to Sub Type Mode =====================//
<%If m_strMode = MODE_SUBTYPE Then%>
	var objFocusCtrl;
	objFocusCtrl = GetObjectReference('frmIssueTypes','txtSubType');
	if(objFocusCtrl != null)
		setFocus(objFocusCtrl);
	
    function Save_OnClick(intSubTypeId) {
        var objAction, objSubType, objCorporateSubType;

        objAction = GetObjectReference('frmIssueTypes', 'txthidAction_IssueTypes');
        objSubType = GetObjectReference('frmIssueTypes', 'txtSubType');
        objCorporateSubType = GetObjectReference('frmIssueTypes', 'cboCorporateSubType');

        if (disallowBlank(objSubType, "<%=MyBase.GetResourceString("ENTERSUBTYPE")%>"))
            return;
        if (disallowBlank(objCorporateSubType, "<%=MyBase.GetResourceString("MAPCORPORATESUBTYPE")%>"))
            return;
        objAction.value = "<%=ACTION_SAVE%>";

        //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
        try {
            setFrameLoader();
        }
        catch (ex) {
            //alert(ex.message);
        }
        // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
        objForm.action = "IBIssueTypes_New.aspx?Mode=<%=MODE_SUBTYPE%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>&SubTypeID=" + intSubTypeId;
        objForm.submit();
        //Commented And Added By Usha Pandit On 13.08.2020 for refresh issue
        //refreshMyParent();
        window.onunload = refreshParent;
        //End Of Added By Usha Pandit On 13.08.2020 for refresh issue
    }

    //Added By Usha Pandit On 13.08.2020 for refresh issue
    function refreshParent() {
	    window.opener.location.reload();
	}
    //End Of Added By Usha Pandit On 13.08.2020 for refresh issue

    //Added by Chetan M on 26th Dec 2019
	//Purpose:Handle the action of REMOVE DEFAULT Sub Type	
    function RemoveDefault_OnClick() {        
        var objAction;
        objAction = GetObjectReference('frmIssueTypes', 'txthidAction_IssueTypes');
        objStatus = GetObjectReference('frmIssueTypes', 'txtSubType');
        objCorporateStatus = GetObjectReference('frmIssueTypes', 'cboCorporateSubType');
        objAction.value = "<%=ACTION_REMOVEDEFAULTSUBTYPE%>";
        try {
            setFrameLoader();
        }
        catch (ex) {
            //alert(ex.message);
        }
        objForm.action = "IBIssueTypes_New.aspx?Mode=<%=MODE_STATUS%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>";
        objForm.submit();
        //window.close();
        //window.location.reload();
        //window.opener.location.reload();
        //Commented And Added By Usha Pandit On 13.08.2020 for refresh issue
        //refreshMyParent();
        window.onunload = refreshParent;
        //End Of Added By Usha Pandit On 13.08.2020 for refresh issue
    }
    //End of Addition by Chetan M
<%End If%>
// =============================== Specific to Sub Type Mode =====================//
// =============================== Specific to Review Type Mode =====================//
<%If m_strMode = MODE_REVIEWTYPE Then%>
	/*var objFocusCtrl;
	objFocusCtrl = GetObjectReference('frmIssueTypes','txtSubType');
	if(objFocusCtrl != null)
		setFocus(objFocusCtrl);*/
		
function Save_OnClick()
{   
	var objAction, objCheckboxCount, objCheckbox, objCombo, objPreviewType;
	var intCnt;
	
	objAction = GetObjectReference('frmIssueTypes','txthidAction_IssueTypes');
	objCheckboxCount = GetObjectReference('frmIssueTypes','txthidCheckboxCount');
	if(objCheckboxCount.value = 1)
	{
		objCheckbox = GetObjectReference('frmIssueTypes','chkPreviewTypeId');
		objCombo = GetObjectReference('frmIssueTypes','cboCorporateSubType');
		objPreviewType = GetObjectReference('frmIssueTypes','txthidPreviewType');
		if (objCheckbox.checked == true)
		{
			if (disallowBlank(objCombo, "<%=MyBase.GetResourceString("MAPREVIEWTYPE")%> '" + objPreviewType.value + "' <%=MyBase.GetResourceString("TOCORPORATESUBTYPE")%>"))
			return;
		}
	}
	else if(objCheckboxCount.value > 1)
	{
		for(intCnt=0 ; intCnt < objCheckboxCount.value;intCnt++)
		{
			objCheckbox = GetObjectReference('frmIssueTypes','chkPreviewTypeId',true);
			objCombo = GetObjectReference('frmIssueTypes','cboCorporateSubType',true);
			objPreviewType = GetObjectReference('frmIssueTypes','txthidPreviewType',true);
			if (objCheckbox[intCnt].checked == true)
			{
				if (disallowBlank(objCombo[intCnt], "<%=MyBase.GetResourceString("MAPREVIEWTYPE")%> '" + objPreviewType[intCnt].value + "' <%=MyBase.GetResourceString("TOCORPORATESUBTYPE")%>"))
				return;
			}
		}
	}
}
<%End If%>
// =============================== Specific to Review Type Mode =====================//
// =============================== Specific to Edit / Add Mode =====================//
<%If m_strMode = MODE_EDIT or m_strMode = MODE_ADD Then%>
	var objFocusCtrl;
	objFocusCtrl = GetObjectReference('frmIssueTypes','txtType');
	if(objFocusCtrl != null)
		setFocus(objFocusCtrl);
		
	var intSelectedStatus;
	var intSelectedSubType;
	var intSelectedIndex;
	
	var objTextBox;
	var objDefaultValueTextBox;
	var objDefaultValueLabel;
	var objCorporateComboBox;
	var objListBox;
	var objOldValueListBox;
	var objCorporateListBox;
	var objLabel;
	var strObjectCaption;

	function GetObject(intFlag)
	{
		var strName;
		if(intFlag == 1)
		{
			strName = "Status"
			strObjectCaption = "Status"
			intSelectedIndex = intSelectedStatus
		}
		else
		{
			strName = "SubType"
			strObjectCaption = "Sub Type"
			intSelectedIndex = intSelectedSubType
		}
		objTextBox = GetObjectReference("frmIssueTypes", "txt" + strName);
		objCorporateComboBox = GetObjectReference("frmIssueTypes", "cboCorporate" + strName);
		objListBox = GetObjectReference("frmIssueTypes", "lst" + strName);
		objOldValueListBox = GetObjectReference("frmIssueTypes", "lstOld" + strName);	
		objCorporateListBox = GetObjectReference("frmIssueTypes", "lstCorporate" + strName);
		objLabel = GetObjectReference("frmIssueTypes", "lblSelected" + strName);
		objDefaultValueTextBox = GetObjectReference("frmIssueTypes", "txthidDefault" + strName);
		objDefaultValueLabel = GetObjectReference("frmIssueTypes", "lblDefault" + strName);
	}

	function SetDefaultValue(strDefaultValue)
	{
		if(Trim(strDefaultValue) == "")
		{
			objDefaultValueTextBox.value = "";
			objDefaultValueLabel.innerHTML = "<B><%=Mybase.GetResourceString("DEFAULT")%> " + strObjectCaption + " &nbsp;&nbsp;: </B>[<%=Mybase.GetResourceString("NOTSET")%>]";
		}
		else
		{
			objDefaultValueTextBox.value = strDefaultValue;
			objDefaultValueLabel.innerHTML = "<B><%=Mybase.GetResourceString("DEFAULT")%> " + strObjectCaption + " &nbsp;&nbsp;: </B><FONT color=blue>" + strDefaultValue + "</FONT>";
		}
	}
	
	var objDefault;
	GetObject(1);
	objDefault = GetObjectReference("frmIssueTypes", "txthidDefaultStatus");
	SetDefaultValue(objDefault.value);
	GetObject(2);
	objDefault = GetObjectReference("frmIssueTypes", "txthidDefaultSubType");
	SetDefaultValue(objDefault.value);
	objDefault = null;
    
    function Back_OnClick() {

        //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
        try {
            setFrameLoader();
        }
        catch (ex) {
            //alert(ex.message);
        }
        // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
        objForm.action = "IBIssueTypes_New.aspx?Mode=<%=MODE_LIST%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>";
        objForm.submit();
    }
	
	function ShowHistory_OnClick(intTagID, intUniqueID,intProjectID)
	{
		//'Modified By ShraddhaM on 13 Sep 2006 for SP7 Issue ID : 6211
		
		window.open("../General/CommonList.aspx?ShowHistory=1&MasterTagID=1500&IsSubTagID=0&TagID=" +intTagID+ "&UniqueID="+intUniqueID + "&ProjectID="+ intProjectID , "","resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=600,height=500");

		//window.open("../General/AuditTrail.aspx?TagID=" + intTagID + "&UniqueID=" + intUniqueID,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=500");
	}
		
	function FormValidation()
	{
		var strNewType, intCnt=0, msg;
		var objType, objTypeList, objOldType, objCorporateType, objLayoutId;
		var objDefaultWork, objListStatus, objListSubType, objDefaultStatus;
		var objListOldStatus, objListOldSubType, objListCorporateStatus, objListCorporateSubtype;
		
		objType = GetObjectReference('frmIssueTypes','txtType');
		
		if(disallowBlank(objType, "<%=Mybase.GetResourceString("ENTERTYPE")%>"))
            return false;
        //Added By Reshma Chavan on 28th Oct 2020 for Special Character validation-IssueID-27715
        if(objType!=null)
        {
	        if ( objType.value.indexOf('@') > -1)
	        {
		        alert('Type cannot be contain any of these /\\:*?<>|,"+-@ characters.');
		        objType.focus();
		        return false;
	        }
        }
         //End of Added By Reshma Chavan on 28th Oct 2020 for Special Character validation-IssueID-27715
		if(disallowSpecialCharacters(objType, '<%=Mybase.GetResourceString("NOSPECIALCHARINTYPE")%>'))
			return false;

		objTypeList = GetObjectReference('frmIssueTypes','txthidProjectTypes');
		objOldType = "<%=m_strOldType%>";
		//Added by PrashantD on 15 March 2007 for IssueID 11619
		objType.value = trimString(objType.value);
		//End of addition by PrashantD on 15 March 2007 
		if(isSubstringExists(objTypeList.value, "<%=SEPERATOR%>" + objType.value + "<%=SEPERATOR%>")){
		
			strNewType = objType.value;
			if(strNewType.toUpperCase() != objOldType.toUpperCase()){
				msg=replaceSubstring("<%=Mybase.GetResourceString("TYPEALREAYEXISTS")%>","&#39;","'");
				alert(msg);
				setFocus(objType);
				return false;
			}
        }
       
		objCorporateType = GetObjectReference('frmIssueTypes','cboCorporateType');
		if(disallowBlank(objCorporateType, "<%=Mybase.GetResourceString("MAPCORPORATETYPE")%>"))
			return false;
			
		objLayoutId = GetObjectReference('frmIssueTypes','cboLayoutID');
		if(disallowBlank(objLayoutId, "<%=Mybase.GetResourceString("SELECTISSUEBASELAYOUT")%>"))
			return false;

        //Commented And Added By Reshma Chavan on 4th Dec 2020 For Alert msg given
        objDefaultWork = GetObjectReference('frmIssueTypes', 'txtDefaultWork');      
        if(disallowBlank(objDefaultWork, "Please Enter Default Work Hrs."))
            return false;
		//objDefaultWork = GetObjectReference('frmIssueTypes','txtDefaultWork');
         //End of Commented And Added By Reshma Chavan on 4th Dec 2020 For Alert msg given
		if(disallowMinValueViolation(objDefaultWork, 0.1, "<%=MyBase.GetResourceString("ENTERDEFAULTWORK")%>",true))
			return false;	

        
        //Added By Usha Pandit on 19.01.2020 for work hours wrong validation
        <%--if(parseFloat(objDefaultWork.value) / <%=CommonFunctions.Application.MinHoursForDAEntry%> != parseInt(parseFloat(objDefaultWork.value) / <%=CommonFunctions.Application.MinHoursForDAEntry%>))
		{
			msg = replaceSubstring("<%=MyBase.GetResourceString("DEFAULTWORKMULTIPLE")%>","<=>","<%=CommonFunctions.Application.MinHoursForDAEntry%>");
			msg=replaceSubstring(msg,"&#39;","'");
			alert(msg);
			setFocus(objDefaultWork);
			return false;
		}--%>
        if (<%=CommonFunctions.Application.MinHoursForDAEntry%> == 0.016) {

        }
        else {
            if (parseFloat(objDefaultWork.value) / <%=CommonFunctions.Application.MinHoursForDAEntry%> != parseInt(parseFloat(objDefaultWork.value) / <%=CommonFunctions.Application.MinHoursForDAEntry%>)) {
                msg = replaceSubstring("<%=Mybase.GetResourceString("DEFAULTWORKMULTIPLE")%>", "<=>", "<%=CommonFunctions.Application.MinHoursForDAEntry%>");
                msg = replaceSubstring(msg, "&#39;", "'");
                alert(msg);
                setFocus(objDefaultWork);
                return false;
            }
        }
		
        //End Of Added By Usha Pandit on 19.01.2020 for work hours wrong validation

		objListStatus = GetObjectReference('frmIssueTypes','lstStatus');
		if(objListStatus.length == 0)
		{	
			msg=replaceSubstring("<%=Mybase.GetResourceString("ADDONESTATUS")%>","&#39;","'");
			alert(msg);
			setFocus(objListStatus);
			return false;
		}
		objListSubType = GetObjectReference('frmIssueTypes','lstSubType');
		if(objListSubType.length == 0)
		{	
			msg=replaceSubstring("<%=Mybase.GetResourceString("ADDONESUBTYPE")%>","&#39;","'");
			alert(msg);
			setFocus(objListSubType);
			return false;
		}
		
		objDefaultStatus = GetObjectReference('frmIssueTypes','txthidDefaultStatus');
		if(disallowBlank(objDefaultStatus, "<%=Mybase.GetResourceString("SELECTDEFAULTSTATUS")%>"))
			return false;
		
		objListOldStatus = GetObjectReference('frmIssueTypes','lstOldStatus');
		objListOldSubType = GetObjectReference('frmIssueTypes','lstOldSubType');
		objListCorporateStatus = GetObjectReference('frmIssueTypes','lstCorporateStatus');
		objListCorporateSubtype = GetObjectReference('frmIssueTypes','lstCorporateSubType');
		
		for(intCnt=0 ; intCnt < objListOldStatus.length; intCnt++)
			objListOldStatus.options[intCnt].selected = true;
			
		for(intCnt=0 ; intCnt < objListOldSubType.length; intCnt++)
			objListOldSubType.options[intCnt].selected = true;
		
		for(intCnt=0 ; intCnt < objListCorporateStatus.length; intCnt++)
			objListCorporateStatus.options[intCnt].selected = true;
			
		for(intCnt=0 ; intCnt < objListCorporateSubtype.length; intCnt++)
			objListCorporateSubtype.options[intCnt].selected = true;
			
		for(intCnt=0 ; intCnt < objListStatus.length; intCnt++)
			objListStatus.options[intCnt].selected = true;
			
		for(intCnt=0 ; intCnt < objListSubType.length; intCnt++)
			objListSubType.options[intCnt].selected = true;

		objCorporateType.disabled = false;
		return true;
	}

    function Save_OnClick() {
        
        var objAction;
        if (FormValidation() == true) {
            objAction = GetObjectReference('frmIssueTypes', 'txthidAction_IssueTypes');
            objAction.value = "<%=ACTION_SAVE%>";

            //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
            try {
                setFrameLoader();
            }
            catch (ex) {
                //alert(ex.message);
            }
            // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
            objForm.action = "IBIssueTypes_New.aspx?Mode=<%=m_strMode%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>";
            objForm.submit();
                        
            refreshMyParent();
        }
    }

    function SetAsDefault_OnClick() {
        
        
        var objAction;
        if (FormValidation() == true) {
            objAction = GetObjectReference('frmIssueTypes', 'txthidAction_IssueTypes');
            objAction.value = "<%=ACTION_SETASDEFAULT%>";

            //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
            try {
                setFrameLoader();
            }
            catch (ex) {
                //alert(ex.message);
            }
            // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
            objForm.action = "IBIssueTypes_New.aspx?Mode=<%=m_strMode%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>";
            objForm.submit();
        }
    }
	
	//Added by Dhanashri Samudra ON 2nd April 2014
	//Purpose:Handle the action of REMOVE DEFAULT
	
    function RemoveDefault_OnClick() {

        var objAction;
        if (FormValidation() == true) {
            objAction = GetObjectReference('frmIssueTypes', 'txthidAction_IssueTypes');
            objAction.value = "<%=ACTION_REMOVEDEFAULT%>";

            //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
            try {
                setFrameLoader();
            }
            catch (ex) {
                //alert(ex.message);
            }
            // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
            objForm.action = "IBIssueTypes_New.aspx?Mode=<%=m_strMode%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>";
            objForm.submit();
            
            refreshMyParent();
        }
    }
    //End of Addition by Dhanashri Samudra

   
	function Insert_OnClick(intFlag)
	{
		var objNewElement, objCorporateType;
		var intCtr, msg;
		
		GetObject(intFlag);
		
		if(disallowBlank(objTextBox, replaceSubstring("<%=Mybase.GetResourceString("ENTERINSERTVALUE")%>","<=>", strObjectCaption)))
			return;
		//Modified following codition by PrashantD on 20 March 2007 for IssueID 11625
		if(disallowSpecialCharacters(objTextBox, replaceSubstring("<%=Mybase.GetResourceString("VALUEWITHSPECIALCHAR")%>","<=>", strObjectCaption),null,"[/:&*?+\"><|,\\\\]"))
		//if(disallowSpecialCharacters(objTextBox, replaceSubstring("<%=Mybase.GetResourceString("VALUEWITHSPECIALCHAR")%>","<=>", strObjectCaption)))
			return;
		for(intCtr=0 ; intCtr < objListBox.length ; intCtr++)
		{
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
		
		if(disallowBlank(objCorporateComboBox, replaceSubstring("<%=Mybase.GetResourceString("MAPVALUE")%>","<=>", strObjectCaption)))
			return;
		
		objNewElement = document.createElement("OPTION");
		objNewElement.innerHTML = objTextBox.value;
		objNewElement.value = objTextBox.value;
		objListBox.appendChild(objNewElement);
		
		objNewElement = document.createElement("OPTION");
		objNewElement.innerHTML = objCorporateComboBox.value;
		objNewElement.value = objCorporateComboBox.value;
		objCorporateListBox.appendChild(objNewElement);
		
		objNewElement = document.createElement("OPTION");
		objNewElement.innerHTML = "";
		objNewElement.value = "";
		objOldValueListBox.appendChild(objNewElement);
		
		objTextBox.value = "";
		objCorporateComboBox.value = "";
		setFocus(objTextBox);

		objCorporateType = GetObjectReference("frmIssueTypes", "cboCorporateType");
		objCorporateType.disabled = true;	
	}
	
	function ListboxOption_OnDblClick(intFlag)
	{
		GetObject(intFlag);
		if(objListBox.selectedIndex == -1)
			return;
		intSelectedIndex = objListBox.selectedIndex;
		SetSelectedValue(intFlag);
		objTextBox.value = objListBox.options[objListBox.selectedIndex].innerHTML;
		objCorporateComboBox.value = objCorporateListBox.options[objListBox.selectedIndex].innerHTML;
	}
	
	function Update_OnClick(intFlag)
	{
		var msg;
		
		GetObject(intFlag);
		// Added by GaneshD on 21 Sep 2009 for not to update the status if configured in the statusflow
		var ConfiguredStatusList,SelectedStatus;
		var objstatustocheck=GetObjectReference('frmIssueTypes','txtConfiguredStatus');
		// End of addition by GaneshD
		if(intSelectedIndex == -1)
		{
			msg = replaceSubstring("<%=Mybase.GetResourceString("SELECTTOUPDATE")%>","<=>", strObjectCaption);
			alert(replaceSubstring(msg, "&#39;","'"));
			return;
		}
		if(disallowBlank(objTextBox, replaceSubstring("<%=Mybase.GetResourceString("NEWVALUEFORUPDATION")%>","<=>", strObjectCaption)))
			return;
		
		//Added by PrashantD on 20 March 2007 for IssueID 11625	
		if(disallowSpecialCharacters(objTextBox, replaceSubstring("<%=Mybase.GetResourceString("VALUEWITHSPECIALCHAR")%>","<=>", strObjectCaption),null,"[/:&*?+\"><|,\\\\]"))
		return;
		//End of addition by PrashantD on 20 March 2007
		
		//Added by TruptiK on 12-Nov-08
		//Purpose:-If no value from listbox is selected.
		 if(objListBox.selectedIndex==-1)
		 return;
		//End of addition by TruptiK on 12-Nov-08
		if(objOldValueListBox.options[intSelectedIndex].innerHTML == "1")
		{
			if(Trim(objTextBox.value) != objOldValueListBox.options[intSelectedIndex].value)
			{
				msg = replaceSubstring("<%=Mybase.GetResourceString("VALUECANBECHANGED")%>","<=>", strObjectCaption);
				msg = replaceSubstring(msg, "<==>", objListBox.options[intSelectedIndex].innerHTML);
				alert(replaceSubstring(msg, "&#39;","'"));
				return;
			}
		}
		// Added by GaneshD on 21 Sep 2009 for whiziblesem 9.0 IssueID-33222
		else
		{
		    SelectedStatus=objOldValueListBox.options[intSelectedIndex].value;
		    if (objstatustocheck!=null)
		    {
		        ConfiguredStatusList=objstatustocheck.value;
		    }
		    if(Trim(objTextBox.value) != objOldValueListBox.options[intSelectedIndex].value)
			{
		
			    if (ConfiguredStatusList!=',,')
			    {
			        if (ConfiguredStatusList.indexOf(','+ SelectedStatus +',' )!=-1)
				    {
					    alert('Status '+ SelectedStatus +' can not be updated as it is used in the StatusFlow configuration');
					    return;
				    }
			    }
		    }
		}	
		// End of addition by GaneshD on 21 Sep 2009
		
		for(intCtr=0 ; intCtr < objListBox.length ; intCtr++)
		{
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
		
		if(disallowBlank(objCorporateComboBox, replaceSubstring("<%=Mybase.GetResourceString("MAPVALUE")%>","<=>", strObjectCaption)))
			return;
			
		if(Trim(objDefaultValueTextBox.value.toUpperCase()) == Trim(objListBox.options[intSelectedIndex].innerHTML.toUpperCase()))
			SetDefaultValue(objTextBox.value);
		
		objListBox.options[intSelectedIndex].innerHTML = objTextBox.value;
		objListBox.options[intSelectedIndex].value = objTextBox.value;		
		objCorporateListBox.options[intSelectedIndex].innerHTML = objCorporateComboBox.value;
		objCorporateListBox.options[intSelectedIndex].value = objCorporateComboBox.value;						
		SetSelectedValue(intFlag);
		objTextBox.value = "";
		objCorporateComboBox.value = "";
		setFocus(objTextBox);
	}
	
	function Delete_OnClick(intFlag)
	{
		var objElement, objListStatus, objListSubType, objcboCorporateType;
		var blnDeleteElement;
		var msg;
		//Added by GaneshD on 18 Aug 2009
		var SelectedStatus='';
		var ConfiguredStatusList='';
		var objStatusList;
		objListStatus = GetObjectReference('frmIssueTypes','lstStatus');
		objStatusList=GetObjectReference('frmIssueTypes','txtConfiguredStatus');
		if (objStatusList!=null)
		{
	        ConfiguredStatusList=objStatusList.value;
	        	     
	     }
	    if (objListStatus.selectedIndex!=-1)
	    {
	        SelectedStatus=objListStatus.options[objListStatus.selectedIndex].innerText;
	    }
		 
		
		// End of addition by GaneshD
		
		GetObject(intFlag);
		if(objListBox.selectedIndex == -1)
		{
			msg=replaceSubstring("<%=Mybase.GetResourceString("SELECTTODELETE")%>","<=>", strObjectCaption);
			alert(replaceSubstring(msg, "&#39;","'"));
			return;
		}
		if(!confirm("<%=Mybase.GetResourceString("CONFIRMDELETE")%>"))
			return;
			
			// Added by GaneshD on 18 Aug 2009 for not to delete the status if configured in the statusflow
			if (ConfiguredStatusList!=',,')
			{
			    if (ConfiguredStatusList.indexOf(','+ SelectedStatus +',' )!=-1)
				{
					alert('Status Can not be deleted as it is used in the StatusFlow configuration');
					return;
				}
			}
				
		// End of addition by GaneshD
			
		intSelectedIndex = -1;
		SetSelectedValue(intFlag);
		while (objListBox.selectedIndex != -1)
		{
			blnDeleteElement = false;

			if(objOldValueListBox.options[objListBox.selectedIndex].innerHTML == "1")
			{
				msg = replaceSubstring("<%=Mybase.GetResourceString("VALUEUSEDCANNOTDELETE")%>","<=>", strObjectCaption);
				msg = replaceSubstring(msg, "<==>", objListBox.options[objListBox.selectedIndex].innerHTML);
				alert(replaceSubstring(msg, "&#39;", "'"));
				blnDeleteElement = false;
			}
			else
			{
				blnDeleteElement = true;
			}

			if(blnDeleteElement == true)
			{
				if(Trim(objDefaultValueTextBox.value.toUpperCase()) == Trim(objListBox.options[objListBox.selectedIndex].innerHTML.toUpperCase()))
					SetDefaultValue("");
				objCorporateListBox.remove(objListBox.selectedIndex);
				objOldValueListBox.remove(objListBox.selectedIndex);										
				objListBox.remove(objListBox.selectedIndex);						
			}
			else
			{
				objListBox.options[objListBox.selectedIndex].selected = false;
			}							
		}
		objListStatus = GetObjectReference('frmIssueTypes','lstStatus');
		objListSubType = GetObjectReference('frmIssueTypes','lstSubType');
		if((objListStatus.length == 0 ) && (objListSubType.length == 0))
		{
			objcboCorporateType = GetObjectReference('frmIssueTypes','cboCorporateType');
			objcboCorporateType.disabled = false;
		}
	}
	
	function SetSelectedValue(intFlag)
	{
	    var strSetAsDefault="";
		
		if(intFlag == 1)
			intSelectedStatus = intSelectedIndex;
		else
			intSelectedSubType = intSelectedIndex;					
	
		if(intSelectedIndex == -1)
			objLabel.innerHTML = "";
		else
		{
		    //Modified By VarunA on 23-Sep-2008 IssueID-22509
            //Purpose : Alignment Problem (Mozilla)
			//strSetAsDefault	= strSetAsDefault + "<P align=right>|\n";
			strSetAsDefault	= strSetAsDefault + "<P align=left>|\n";
			//End By VarunA on 23-Sep-2008 IssueID-22513
			strSetAsDefault = strSetAsDefault +	"<A style='TEXT-DECORATION: none' HREF='javascript:SetDefaultValue_OnClick(" + intFlag + ")'>\n";
			strSetAsDefault = strSetAsDefault + "	<FONT size=1 face=verdana color=black>\n";
			strSetAsDefault = strSetAsDefault +	"	<B>Set As Default " + strObjectCaption + "</B>\n";
			strSetAsDefault = strSetAsDefault +	"	</FONT>\n";
			strSetAsDefault = strSetAsDefault +	"</A>|</p>\n";
			objLabel.innerHTML = "<B><%=Mybase.GetResourceString("SELECTED")%> " + strObjectCaption + " : </B>" + objListBox.options[intSelectedIndex].innerHTML + strSetAsDefault;
		}
	}
	
	function SetDefaultValue_OnClick(intFlag)
	{				
		GetObject(intFlag);
		SetDefaultValue(objListBox.options[intSelectedIndex].value);
	}
			
	function AddReviewTypes_OnClick()
	{
		window.open("IBIssueTypes_New.aspx?Mode=ReviewTypes&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>", "", "resizable=yes,scrollbars=yes,left=" + (window.screen.width - 500)/2 + ",top=" + (window.screen.height - 300)/2 + ",width=500,height=300");
	}
	
    function cboCorporateType_OnChange() {
        var objAction;
        objAction = GetObjectReference('frmIssueTypes', 'txthidAction_IssueTypes');
        objAction.value = "<%=ACTION_CHANGE_CORPORATE_TYPE%>";
		if (objAction.value != "") {
		//Added by Chetan M on 10th Aug 2020 for Issue Id = 25509
           var objType = GetObjectReference('frmIssueTypes','txtType');	
		if(disallowSpecialCharacters(objType, '<%=MyBase.GetResourceString("NOSPECIALCHARINTYPE")%>'))
                return false;
            //End of Added by Chetan M on 10th Aug 2020 for Issue Id = 25509
        //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
        try {
            setFrameLoader();
        }
        catch (ex) {
            //alert(ex.message);
        }
        // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
        objForm.action = "IBIssueTypes_New.aspx?Mode=<%=m_strMode%>&ProjectID=" + ProjectID + "&MasterTagId=<%=m_lngTagId%>";
        objForm.submit();
        }
    }
<%End If%>
// =============================== Specific to Edit / Add Mode =====================//
<%End If%>
//Added/Integrated by GaneshD on 04 Jun 2009 for Issue base Status flow configuration
    function StatusFlow_OnClick(strProjectIssueType, strCorporateType, ProjectID) {
        //Added BY AMIT MAHADIK ON 04 JULY 2011, WHIZIBLESEM 10.0
        //Purpose:To inherit Status flow from Corporate level to Project Level
        //debugger;
        var objAction;
        objAction = GetObjectReference('frmIssueTypes', 'txthidAction_IssueTypes');
        objAction.value = "<%=ACTION_INHERIT_STATUS_FLOW%>";

        //Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER 
        try {
            setFrameLoader();
        }
        catch (ex) {
            //alert(ex.message);
        }
        // End of Added By NILESH G on 13-April-2015 Purpose::APPLY LOADER
        objForm.action = "IBIssueTypes_New.aspx?Mode=<%=MODE_LIST%>&MasterTagId=<%=m_lngTagId%>&IssueTypeStatusFlow=" + encodeURI(strProjectIssueType) + "&strCorporateType=" + encodeURI(strCorporateType) + "&ProjectID=" + ProjectID;
        objForm.submit();


        //End Added BY AMIT MAHADIK ON 04 JULY 2011, WHIZIBLESEM 10.0

        //Deleted BY AMIT MAHADIK ON 04 JULY 2011, WHIZIBLESEM 10.0
        //window.open ("../IB/StatusFlowConfiguration_CommonList.aspx?FromWhere=PM&MasterTagID=3978&IssueType="+encodeURI(strProjectIssueType)+"&ProjectID="+ProjectID, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" +(window.screen.height - 600)/2 + ",width=850,height=600", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 0)/2) + ",top=" + ((window.screen.height - 0)/2) + ",width=0,height=0");
        //End Deleted BY AMIT MAHADIK ON 04 JULY 2011, WHIZIBLESEM 10.0


    }
	//Addition end by GaneshD
	
	
	  //Added BY AMIT MAHADIK ON 12 August 2011, WHIZIBLESEM 10.0
	function StatusFlowAtProjectLevel_OnClick(strProjectIssueType,strCorporateType,ProjectID)
	{  	
	  //Purpose:To define Status flow at Project Level	   
	    window.open ("../IB/StatusFlowConfiguration_CommonList.aspx?FromWhere=PM&MasterTagID=3978&IssueType="+encodeURI(strProjectIssueType)+"&ProjectID="+ProjectID, "", "resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" +(window.screen.height - 600)/2 + ",width=850,height=600", "", "resizable=yes,scrollbars=no,left=" + ((window.screen.width - 0)/2) + ",top=" + ((window.screen.height - 0)/2) + ",width=0,height=0");        	
	}
	
	  //End Added BY AMIT MAHADIK ON 12 August 2011, WHIZIBLESEM 10.0
</script>
<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->

<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
<!-- <script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script> -->
<!-- End of Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
 
<script type="text/javascript" src="../../responsive/responsive.js"></script>
<!-- <script src="../../Whizible2.0-new/plugins/alertify/alertify.min.js"></script> -->


<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
       
        var ProjectID = "<%= Request.QueryString("ProjectID") %>";
        var ViewAccess = "<%= m_blnViewAccessRight %>";
        
    $(document).ready(function()
    {
        
        $('#lstStatus font').contents().unwrap();

        alertify.set('notifier', 'position', 'top-right');

        /*----------------------------------------------------------*/
        // Starts Feature Tag:whiz41-Web Form Extension Type
        // Description:Remove section header row in Tablet and Mobile view
        // By Whom: Miiint
        // When:23/01/2015
        /*---------------------------------------------------------*/
        if (ViewAccess == "False") {
            //var bodyHTML = '';
            //bodyHTML = '<div style="text-align:center;height: 744px;overflow: auto;width: 100%;background-color:white;margin-top:3%;"><b style="margin-top:6%;"><center>You are not authorized to view this record. </center></b></div>';
            //$("#divIssueType").html(bodyHTML);
            //return;
        }
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