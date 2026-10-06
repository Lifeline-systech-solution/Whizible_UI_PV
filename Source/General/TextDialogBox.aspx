<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TextDialogBox.aspx.vb" Inherits="Whiz.TextDialogBox" %>

<!DOCTYPE HTML>
<HTML>
	<% MyBase.InitializeResources("Resources.TextDialogBox", "Resources")%>
	<%CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("TITLE"))%>
	<!-- Fixed Issue ID 28888 -->
	<body class="clsBody" MS_POSITIONING="GridLayout" onload="window_onload()" onunload="window_onunload()">
		<form id="frmTextDialogBox" method="post">
			<%DrawPage%>
		</form>
		<SCRIPT Language="JavaScript">

	var blnWindowClose = false;
	var text;
	
	var	objText=GetObjectReference('frmTextDialogBox','txtText');
	
	function window_onload()
	{		
	    setFocus(objText);//Added by Ninad on 13 July 2007 Issue ID : 14407
		if (window.showModalDialog)
		{
			//Function modified for Hotfix ID 2.0.37-SP4-WAF by UmeshJ 08-Sep-2006
			objText.value= window.dialogArguments.value;	
		}
		else
			objText.value=window.opener.document.forms['<%=httpcontext.current.request("ParentFormName")%>'].elements['<%=httpcontext.current.request("TextAreaName")%>']<%=m_strRowIndex%>.value;//Modified By - Ninad : Req ID - WAF3_PB_55 : Dt 26 Nov 2007
					
		text=objText.value;
	}		
	function window_onunload() 
	{
		if(!blnWindowClose)
			window.returnValue=frmTextDialogBox.txtText.value;
		else
			window.returnValue	=text;
		
	}
            function doOK() {

                var blnExceedMaxChars = false;//Modified By Vinay on 08 july 2008 Static Combo with static Control
                //objText = GetObjectReference('frmTextDialogBox','txtText');

                <%--if (disallowMaxlengthViolation(objText, <%=httpcontext.current.request("MaxLength")%>, "Max Length of '<%=CommonFunctions.General.BuildJSEscapeSequence(httpcontext.current.request("Title"),""""c)%>' is <%=httpcontext.current.request("MaxLength")%> characters.", true))
                    return false; --%>  //Modified By Ninad on 16 Jan 2008 IssueID-26590


                if ('<%=HttpContext.Current.Request("ParentFormName")%>' != "frmCommonPage") {
                    if (window.showModalDialog) {
                        window.returnValue = frmTextDialogBox.txtText.value;
                        var cntfield, maxlimit;
                        cntfield = 428;
                        maxlimit = 428;

                        if ('<%=strTitle%>' == 'txtAdditionalInformation' || '<%=strTitle%>' == 'txtAddNewRelativeSource' || '<%=strTitle%>' == 'txtDropdownEditSQL' || '<%=strTitle%>' == 'txtEditRelativeSource' || '<%=strTitle%>' == 'Description') {

                            if (objText.value.length > maxlimit) // if too long...trim it! 
                            {

                                objText.value = objText.value.substring(0, maxlimit);
                                alert('Max. Characters Exceeds.! \rU Can Enter Maximum 428 Characters! ');
                                blnExceedMaxChars = true;
                            }
                            else {
                                cntfield = maxlimit - objText.value.length;
                            }
                        }
                    }
                    else {
                        window.opener.document.forms['<%=httpcontext.current.request("ParentFormName")%>'].elements['<%=httpcontext.current.request("TextAreaName")%>']<%=m_strRowIndex%>.value = objText.value;//Modified By - Ninad : Req ID - WAF3_PB_55 : Dt 26 Nov 2007
                    }
                }
                else {
                    //if (window.showModalDialog)
                    //{
                    window.returnValue = frmTextDialogBox.txtText.value;
                    //Modified By Vinay 08 july 2008 Static Combo with static Control
                    var cntfield, maxlimit;
                    //field=frmTextDialogBox.txtText;
                    //Commented & Added By Dipali V On 9th July 2020 For Issue ID 25442

                    //cntfield=428;
                    //maxlimit = 428;                    
                    cntfield = '<%=HttpContext.Current.Request("MaxLength")%>';
                    maxlimit = '<%=HttpContext.Current.Request("MaxLength")%>';
                    
                    //End of Commented & Added By Dipali V On 9th July 2020 For Issue ID 25442

                    //if ('<%=strTitle%>' == 'txtAdditionalInformation' || '<%=strTitle%>' == 'txtAddNewRelativeSource' || '<%=strTitle%>' == 'txtDropdownEditSQL' || '<%=strTitle%>' == 'txtEditRelativeSource') {
                    if ('<%=strTitle%>' == 'txtAdditionalInformation' || '<%=strTitle%>' == 'txtAddNewRelativeSource' || '<%=strTitle%>' == 'txtDropdownEditSQL' || '<%=strTitle%>' == 'txtEditRelativeSource' || '<%=strTitle%>' == 'Description') {

                        if (objText.value.length > maxlimit) // if too long...trim it! 
                        {
                            //Added By Usha Pandit On 19.08.2020 For correct Max Length alert
                            var curTextVal = objText.value;
                            //End Of Added By Usha Pandit On 19.08.2020 For correct Max Length alert
                            //Commented By Usha Pandit On 19.08.2020 For correct Max Length alert
                            //objText.value = objText.value.substring(0, maxlimit);
                            //End Of Commented By Usha Pandit On 19.08.2020 For correct Max Length alert
                            //Commented & Added By Dipali V On 9th July 2020 For Issue ID 25442
                            //alert('Max. Characters Exceeds.! \rU Can Enter Maximum 428 Characters! ');
                            //Commented And Added By Usha Pandit On 19.08.2020 For correct Max Length alert
                            //alert('Max. Characters Exceeds.! \rU Can Enter Maximum ' + maxlimit + ' Characters! ');
                            alert("Max Length of 'Description' is " + maxlimit + " characters.You have entered " + curTextVal.length + " characters");
                            //End Of Added By Usha Pandit On 19.08.2020 For correct Max Length alert
                            //En dof Commented & Added By Dipali V On 9th July 2020 For Issue ID 25442
                            blnExceedMaxChars = true;
                        }
                        // otherwise, update 'characters left' counter 
                        else {
                            cntfield = maxlimit - objText.value.length;                            
                            window.opener.document.forms['<%=httpcontext.current.request("ParentFormName")%>'].elements['<%=httpcontext.current.request("TextAreaName")%>']<%=m_strRowIndex%>.value = objText.value;
                        }
                    }
                    ////Modification End By Vinay 08 july 2008 Static Combo with static Control
                    //}
                <%--else {
                   
                    window.opener.document.forms['<%=httpcontext.current.request("ParentFormName")%>'].elements['<%=httpcontext.current.request("TextAreaName")%>']<%=m_strRowIndex%>.value;//Modified By - Ninad : Req ID - WAF3_PB_55 : Dt 26 Nov 2007
                }--%>
                }
                if (blnExceedMaxChars == false)//Modified By Vinay 08 july 2008 Static Combo with static Control
                {
                    window.close();
                }//Modification End By Vinay 08 july 2008 Static Combo with static Control
            }
	function doCancel()
	{
		blnWindowClose=true;
		window.close(); 
	}
	</SCRIPT>
	</body>
</HTML>
