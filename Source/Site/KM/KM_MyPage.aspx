<%@ Page Language="vb" AutoEventWireup="false" Codebehind="KM_MyPage.aspx.vb" Inherits="PbNIT.KM_MyPage"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%--<!DOCTYPE HTML>--%>
<HTML>
	<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%  CommonFunctions.General.PlotPageHeadTag("")%> 
<%--<link rel="stylesheet" href="../../../Whizible2.0-new/bootstrap/css/bootstrap-5.2.2.min.css" />
<link rel="stylesheet" href="../../../Whizible2.0-new/fontawesome/css/all.css?v=1.1" />
<script src="../../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js"></script>
<script src="../../../Whizible2.0-new/bootstrap/js/bootstrap.bundle-5.2.2.min.js"></script>--%>
<link href="../../../responsive/Scripts/HTMLEditor/editor.css" rel="stylesheet" />
<script src="../../../responsive/Scripts/HTMLEditor/editor.js"></script>


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
        //Added by swapnil aswale on 12-1-2015 for Responsive FreeTextBox
        $("#FreeTextBox").Editor();
        //Ended

       
    });

 

</script>
<%--End of Commented and Added By  Vidya J on 18th-September-2015 for Responsive Page--%>

	<body class="clsBody" onresize="window_onresize()" onload="window_onload()"   MS_POSITIONING="GridLayout">
		<form id="frmKMMyPage" name="frmKMMyPage" method="post" runat="server">
			<%=m_strMenu%>
			<div id="DivMain" style='overflow:auto;WIDTH:100%;'>
			<%=m_strLegends%>
			        <%DrawControls()%>
			        <tr class='clsTRBody'><td valign=top align=right nowrap>Article Content</td><td>
                        <textarea class="editor" rows="3" name="FreeTextBox" id="FreeTextBox"></textarea>
                        <input type="hidden" id="freeHidden" name="freeHidden" />
				    <img src='../../images/star.gif'></img></td></TR>
				    <%WritePage()%>
				    </div>
				    <%=m_strMenu%>
		</form>
		<%StyleSheetCreation%>
		<SCRIPT type="text/javascript">
	var objForm, objdivlist;
	
	objForm = GetFormReference('frmKMMyPage');
	objdivMain = GetObjectReference('frmKMMyPage','DivMain');
	objtxtTitle = GetObjectReference('frmKMMyPage','txtTitle');
	objtxtHTML = GetObjectReference('frmKMMyPage','txtHTML');
	//objtxtSynopsis = GetObjectReference('frmKMMyPage','txtSynopsis');
	objtxtLabels = GetObjectReference('frmKMMyPage','txtLabels');
	objFreeTextBox = GetObjectReference('frmKMMyPage', 'freeHidden');
	objFreeTextBox_Toolbar = GetObjectReference('frmKMMyPage','FreeTextBox_Toolbar');
	objchkEdit = GetObjectReference('frmKMMySpace','chkEdit');	
	objchkView = GetObjectReference('frmKMMySpace','chkView');
	objtxtSynopsis = GetObjectReference('frmKMMySpace','txtSynopsis');
	
	var win;
	<%' Added By SonalD on 15th Jan 2009 %>
    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
    disableRightClick();
    <%End If%>
    <%' Added By SonalD on 15th Jan 2009 %>


	
	function window_onload()
	{
	    //Added by swapnil aswale on 12-1-2015 for Responsive FreeTextBox
        //Commented and added By bharat tekade on 3rd-feb-2016
	    //document.getElementById('FreeTextBox_editor').innerHTML = '<=% Server.HtmlEncode(m_strContents.Replace(Chr(13) + Chr(10), "\n").Replace("'", "\'"))%>';
        //Commented and added by Yogesh Jalamkar on 17-Aug-2016 For Javascript Issue
	    //document.getElementById('FreeTextBox_editor').innerHTML = '<=%m_strContents%>';
	    document.getElementById('FreeTextBox_editor').innerHTML = '<%=m_strContents.Replace(Chr(13) + Chr(10), "\n").Replace("'", "\'")%>';
	    //End of addition by Yogesh Jalamkar on 17-Aug-2016
	    //End of Commented and added By bharat tekade on 3rd-feb-2016
	    //Ended

		var intDivHeight ;
		if(objdivMain)
		{
		    //Commented And Added By Vaijat K ON 24/11/2014
			//intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 35;
			//if(navigator.appName == 'Netscape')
			//{
			//	intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 35;
			//}
		    intDivHeight = (window.innerHeight - objdivMain.offsetTop) - 37;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivMain.style.height = intDivHeight + 'px';	
		}
		
		/*if(objtxtTitle)
		{
		objtxtTitle.value = '<%'=m_strPageSubject.replace("'","\'")%>//';
		//alert(objtxtTitle.value);
		//}*/
		
		
		if (objchkView)
		{
			ShowHideTr('tr_ViewUsers',objchkView)	
		}
		if (objchkEdit)
		{
		ShowHideTr('tr_EditUsers',objchkEdit)	
		}
		
		
	}
	
	function window_onresize()		
	{
		var intDivHeight;
		if(objdivMain)
		{
            //Commented And Added By Vaijat K ON 24/11/2014
		    //intDivHeight = document.body.offsetHeight - objdivMain.offsetTop - 35;
		    intDivHeight = (window.innerHeight - objdivMain.offsetTop) - 37;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivMain.style.height = intDivHeight + 'px';
		}
	}
	
	function Save_OnClick()
	{
	   // alert("save");
	  // debugger;
	  var strSpaceID='<%=m_strSpaceID%>';
	  //var objhidProcedureTitle=GetObjectReference('frmKMMyPage','hidProcedureTitle').value;
	  //Addition by SuchitraP on 21-Apr-2009 for IssueID : 30062
	    //Purpose : In Article Contents , It should not accept space as character 
	    
	    //Commented and  added by Yogesh J on 19-Oct-2015
	    //var txtArticleContent=FreeTextBox_editor.document.body.innerHTML;
	    var txtArticleContent;
	    if ($('#FreeTextBox_editor').length >0) {
	        //Added by swapnil aswale on 12-1-2015 for Responsive FreeTextBox	 
	       
	        document.getElementById("freeHidden").value = document.getElementById("FreeTextBox_editor").innerHTML;
	        txtArticleContent = document.getElementById("FreeTextBox_editor").innerHTML;
	       
            //Ended

	       
	    }
	    //end of addition by Yogesh J on 19-Oct-2015
	  
	    //Commented and  added by Yogesh J on 19-Oct-2015
	    //txtArticleContent = txtArticleContent.replace(/<P>/gi,"");
	    //txtArticleContent = txtArticleContent.replace(/<\/P>/gi,"");
	    //txtArticleContent = txtArticleContent.replace(/<BR>/gi,"");
	    //txtArticleContent = txtArticleContent.replace(/&nbsp;/gi,"");
	    if ($('#FreeTextBox_editor').length > 0) {
	       
	        txtArticleContent = txtArticleContent.replace(/<P>/gi,"");
	        txtArticleContent = txtArticleContent.replace(/<\/P>/gi,"");
	        txtArticleContent = txtArticleContent.replace(/<BR>/gi,"");
	        txtArticleContent = txtArticleContent.replace(/&nbsp;/gi,"");
	         }
	    //end of addition by Yogesh J on 19-Oct-2015
	 
	    //Commented and  added by Yogesh J on 19-Oct-2015
	   

	  //Added by SonalD on 30th Sept 2008
	  if (disallowBlank(objtxtTitle,"Article Name should not be left blank"))return;
	  if (disallowSpecialCharacters(objtxtTitle,"Characters '/:*?+\"><|,\\\\' are not allowed")) return;
	  if (disallowBlank(objtxtSynopsis,"Synopsis should not be left blank"))return;
	  if (disallowMaxlengthViolation(objtxtTitle,50,"Article Name should not exceed 50 characters.")) return;
	  if (disallowMaxlengthViolation(objtxtSynopsis,2000,"Synopsis should not exceed 2000 characters.")) return;
	  if (disallowBlank(objFreeTextBox,"Article Contents should not be left blank"))return;
	  if (GetObjectReference('frmKMMyPage','chkEdit').checked == true && GetObjectReference('frmKMMyPage','txtEditUsers').value=='')
		{
		    alert('Please select atleast one user.');
		    return;
		}
		
	  //Comment and Addition by SuchitraP on 21-Apr-2009 for IssueID : 30062
	  //Purpose : In Article Contents , It should not accept space as character 
	  /*if(document.getElementById('FreeTextBox').value=='&nbsp;' || document.getElementById('FreeTextBox').value=='')
	  {
		alert('Article Contents should not be left blank');
	    return;
	  }*/
	    //Commented and added by Yogesh J on 19 Oct 2015
	  //if (isBlank(txtArticleContent))
	  //{
	  //    alert('Article Contents should not be left blank');
	  //    return;
	  //}
	  if ($('#FreeTextBox_editor').length > 0) {
	     
	      if (isBlank(txtArticleContent))
	      {
	          alert('Article Contents should not be left blank');
	          return;
	      }
	      
	  }
	    //End of addition by Yogesh J on 19 Oct 2015
	  //End of comment and addition by SuchitraP
	  
	  if (disallowBlank(objtxtLabels,"Labels should not be left blank"))return;	  
	  if (disallowMaxlengthViolation(objtxtLabels,100,"Search labels should not exceed 100 characters.")) return;
	  //End of addition by SonalD on 30th Sept 2008
	    //Commented By Shamkant s on 20 Nov 2015
	 // var objhidProcedureTitle = '<%=strProcedureTitleDB%>';
	 var objhidProcedureTitle = '<%=strProcedureTitleDB%>';
	
	 if(objhidProcedureTitle.indexOf(','+Trim(objtxtTitle.value)+',')>=0 && '<%=strflag%>' == '1')
	 {
	    alert('Article "' + Trim(objtxtTitle.value) + '" already created.');
	    objtxtTitle.value='';
	    objtxtLabels.value='';
	    objtxtSynopsis.value='';

	    if ($('#FreeTextBox_editor').length > 0) {
            //Commented and Added by Dhanashri S on 27 Jan 2016
	        //FreeTextBox_editor.document.body.innerHTML ='';
	        document.getElementById('FreeTextBox_editor').innerHTML = '';
            //End of Comment and Addition by Dhanashri S on 27 Jan 2016
	    }
	    document.getElementById('FreeTextBox').value='';
	    objtxtTitle.focus();
	    return;
	 }
	 else
	 {
	        
			
			// Commented and Modified by ABhijeetC on 12 Nov 2009
            //  objForm.action = "KM_MyPage.aspx?ActionLink=<%=m_strActionLink %>&PrimaryKey=<%=m_strPrimaryKey %>&Myflag=2&PageNumber=<%=m_strPagingNumber %>&Mode=<%=m_strMode%>&SpaceID=<%=m_strSpaceID%>&Fromwhere=<%=m_strFromWhere %>&Action=SAVE";
            if ('<%=m_From%>' =='KA') //from Knowledge Administration page
            {
                objForm.action = "KM_MyPage.aspx?ActionLink=<%=m_strActionLink %>&PrimaryKey=<%=m_strPrimaryKey %>&Myflag=2&PageNumber=<%=m_strPagingNumber %>&Mode=<%=m_strMode%>&SpaceID=<%=m_strSpaceID%>&From=KA&Action=SAVE";
                //objForm.submit();
            }
            else
            {
                //objForm.action = "KM_MyPage.aspx?ActionLink=<%=m_strActionLink %>&PrimaryKey=<%=m_strPrimaryKey %>&Myflag=2&PageNumber=<%=m_strPagingNumber %>&Mode=<%=m_strMode%>&SpaceID=<%=m_strSpaceID%>&Fromwhere=<%=m_strFromWhere %>&Action=SAVE";
                //"window.opener.location.href = '../KM/KM_MyPage.aspx?PageNumber=&txtSearch=&Fromwhere=Search&Mode=Edit&Myflag=2&EditClick=1&SpaceID=0&ActionLink=&PrimaryKey=&PageID=" & m_intPageID.ToString & "';")
                
                objForm.action = "KM_MyPage.aspx?ActionLink=&PageNumber=1&SpaceID=<%=m_strSpaceID%>&Mode=Edit&Myflag=2&Fromwhere=MyArticle&PageID=<%=m_intPageID%>&txtSearch=&Action=SAVE";
            }
            // End of Comment and Modification by ABhijeetC on 12 Nov 2009
            
	     objForm.submit();
	     
			//Addition by SuchitraP on 4 July 2008
			if(strSpaceID !='' && strSpaceID != 'NULL')
			{
			    if (window.opener != null)
			    {
			        
			        //window.opener.document.forms[0].action="KM_MySpace.aspx?Myflag=2&SpaceID=<%=m_strSpaceID%>&Mode=Edit";
			        window.opener.document.forms[0].submit();
			        //window.close();
                }			    
			}
			else if("<%=m_strFrom %>"=="Manage")
			//End by SuchitraP
			{ 	
			    
			    if (window.opener != null)
			    {	    
			        window.opener.document.forms[0].submit();
			        window.opener.opener.location.href="../km/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&Tab=MY&Subtab=MY PAGES";
			    }    
			}
			else
			{
			    
			    //window.opener.frmKMList.submit();
			    if (window.opener != null)
			    {		
			       window.opener.document.forms[0].submit();
			    }    
			}
	     
	 }
        //Added By Chakshuta H on 22nd-Aug-2016 Purpose::Qa issue fixing
	    window.location.href = "../Km/Km_List.aspx?PageNumber=1&Fromwhere=MyArticle&Tab=MY&Subtab=MY PAGES&SelectList=4";
	    //End Of Added By Chakshuta H on 22nd-Aug-2016 Purpose::Qa issue fixing
	}
	
	//Addition by SuchitraP on 4 July 2008
    //Purpose: Called when clicked on Publish link from Publish to KM link in helpdesk
	function CRMSave_OnClick()
	{
	  if (validateHeaderSection())	
		{
		   objForm.action = "KM_MyPage.aspx?ActionLink=<%=m_strActionLink %>&PrimaryKey=<%=m_strPrimaryKey %>&Myflag=2&QueryID=<%=m_intQueryID%>&PageID=<%=m_intPageID%>&Mode=<%=m_strMode%>&Fromwhere=<%=m_strFromWhere %>&Action=CRMSAVE";
		   objForm.submit();
		   window.opener.frmCommonList.submit();	
		} 
	}
	//End by SuchitraP
	

function validateHeaderSection()
	{
		if (disallowBlank(objtxtTitle,"Title should not be left blank")==false)
		{
		    if (isBlank(FreeTextBox_editor.document.body.innerHTML) || FreeTextBox_editor.document.body.innerHTML.replace("&nbsp;","") == "<P></P>" ||  isBlank(FreeTextBox_editor.document.body.innerHTML.replace("&nbsp;","")))
			{
			alert("Contents should not be left blank");
			return false;
			}
			if (disallowBlank(objtxtLabels,"Contents should not be left blank")==false)
			{	    
			return true;
			}
			if (disallowBlank(objtxtLabels,"Labels should not be left blank")==false)
			{
			return true;
			}	
		}
		return false;
	}
	
		function UserSelection_Onclick(strMode)
		{
				objtxtViewUserIDs = GetObjectReference('frmKMMyPage','txtViewUserIDs');
				objtxtEditUserIDs = GetObjectReference('frmKMMyPage','txtEditUserIDs');
				
			if (strMode == "View")
			{
				window.open("KM_EmployeeSelection.aspx?UsersTextBox=txtViewUsers&UserIDsTextBox=txtViewUserIDs&FormName=frmKMMyPage&UserIDs=" +objtxtViewUserIDs.value ,"","resizable=no,scrollbars=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
			}
			else
			{
			window.open("KM_EmployeeSelection.aspx?UsersTextBox=txtEditUsers&UserIDsTextBox=txtEditUserIDs&FormName=frmKMMyPage&UserIDs=" + objtxtEditUserIDs.value,"","resizable=no,scrollbars=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
			}

		   
		}
		function ShowHideTr(strTrName,objCheckBox)
		{		
		 objTr = GetObjectReference('frmKMMyPage',strTrName);
		 if (objCheckBox.checked == true)
		 	objTr.style.display = ""
		 else
			objTr.style.display = "None"
		 		
		}
		function AddAttachment()
		{
		  if('<%=m_strActionLink %>' == 'More')
		  {
		     // Commented and Modified by ABhijeetC on 12 Nov 2009
            // window.open("../../Source/General/Attachment.aspx?FromWhere=KM&ID=<%=m_intPageID%>&Page=../KM/KM_MyPage.aspx&QueryString=" + "<%=Server.UrlEncode("PageID=" & m_intPageID & "&PageNumber=" & m_strPagingNumber & "&txtSearch=" & m_strtxtSearch & "&Fromwhere=" & m_strFromWhere & "&Mode=" & m_strMode & "&Myflag=2" & "&SpaceID=" & m_strSpaceID & "&ActionLink=" & m_strActionLink & "&PrimaryKey=" & m_strPrimaryKey)%>" ,null,"resizable=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=550,height=240");
            if ('<%=m_From%>' =='KA') //from Knowledge Administration page
            {
                /// Modified by Archanan on 1-Oct-2010 for PMLifeLine SP2
                //window.open("../../Source/General/Attachment.aspx?FromWhere=KM&ID=<%=m_intPageID%>&Page=../KM/KM_MyPage.aspx&QueryString=" + "<%=Server.UrlEncode("PageID=" & m_intPageID & "&PageNumber=" & m_strPagingNumber & "&txtSearch=" & m_strtxtSearch & "&From=KA&Mode=" & m_strMode & "&Myflag=2" & "&SpaceID=" & m_strSpaceID & "&ActionLink=" & m_strActionLink & "&PrimaryKey=" & m_strPrimaryKey)%>" ,null,"resizable=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=550,height=240");
                window.open("../../Source/General/Attachment.aspx?TagID=6&FromWhere=KM&ID=<%=m_intPageID%>&Page=../KM/KM_MyPage.aspx&QueryString=" + "<%=Server.UrlEncode("PageID=" & m_intPageID & "&PageNumber=" & m_strPagingNumber & "&txtSearch=" & m_strtxtSearch & "&From=KA&Mode=" & m_strMode & "&Myflag=2" & "&SpaceID=" & m_strSpaceID & "&ActionLink=" & m_strActionLink & "&PrimaryKey=" & m_strPrimaryKey)%>" ,null,"resizable=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=550,height=240");
                /// End of Modified by Archanan on 1-Oct-2010 for PMLifeLine SP2
            }
            else
            {
                /// Modified by Archanan on 1-Oct-2010 for PMLifeLine SP2
               // window.open("../../Source/General/Attachment.aspx?FromWhere=KM&ID=<%=m_intPageID%>&Page=../KM/KM_MyPage.aspx&QueryString=" + "<%=Server.UrlEncode("PageID=" & m_intPageID & "&PageNumber=" & m_strPagingNumber & "&txtSearch=" & m_strtxtSearch & "&Fromwhere=" & m_strFromWhere & "&Mode=" & m_strMode & "&Myflag=2" & "&SpaceID=" & m_strSpaceID & "&ActionLink=" & m_strActionLink & "&PrimaryKey=" & m_strPrimaryKey)%>" ,null,"resizable=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=550,height=240");
                window.open("../../Source/General/Attachment.aspx?TagID=6&FromWhere=KM&ID=<%=m_intPageID%>&Page=../KM/KM_MyPage.aspx&QueryString=" + "<%=Server.UrlEncode("PageID=" & m_intPageID & "&PageNumber=" & m_strPagingNumber & "&txtSearch=" & m_strtxtSearch & "&Fromwhere=" & m_strFromWhere & "&Mode=" & m_strMode & "&Myflag=2" & "&SpaceID=" & m_strSpaceID & "&ActionLink=" & m_strActionLink & "&PrimaryKey=" & m_strPrimaryKey)%>" ,null,"resizable=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=550,height=240");
                /// End of Modified by Archanan on 1-Oct-2010 for PMLifeLine SP2
            }
            // End of Comment and Modification by ABhijeetC on 12 Nov 2009
		  }
		  else
		  {
		    // Commented and Modified by ABhijeetC on 12 Nov 2009
            //  window.open("../../Source/General/Attachment.aspx?FromWhere=KM&ID=<%=m_intPageID%>&Page=../KM/KM_MyPage.aspx&QueryString=" + "<%=Server.UrlEncode("PageID=" & m_intPageID & "&PageNumber=" & m_strPagingNumber & "&txtSearch=" & m_strtxtSearch & "&Fromwhere=" & m_strFromWhere & "&Mode=" & m_strMode & "&Myflag=2&EditClick=1" & "&SpaceID=" & m_strSpaceID & "&ActionLink=" & m_strActionLink & "&PrimaryKey=" & m_strPrimaryKey)%>" ,null,"resizable=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=550,height=240");
            if ('<%=m_From%>' =='KA') //from Knowledge Administration page
            {
                /// Modified by Archanan on 1-Oct-2010 for PMLifeLine SP2
                 //window.open("../../Source/General/Attachment.aspx?FromWhere=KM&ID=<%=m_intPageID%>&Page=../KM/KM_MyPage.aspx&QueryString=" + "<%=Server.UrlEncode("PageID=" & m_intPageID & "&PageNumber=" & m_strPagingNumber & "&txtSearch=" & m_strtxtSearch & "&From=KA&Mode=" & m_strMode & "&Myflag=2&EditClick=1" & "&SpaceID=" & m_strSpaceID & "&ActionLink=" & m_strActionLink & "&PrimaryKey=" & m_strPrimaryKey)%>" ,null,"resizable=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=550,height=240");
                 window.open("../../Source/General/Attachment.aspx?TagID=6&FromWhere=KM&ID=<%=m_intPageID%>&Page=../KM/KM_MyPage.aspx&QueryString=" + "<%=Server.UrlEncode("PageID=" & m_intPageID & "&PageNumber=" & m_strPagingNumber & "&txtSearch=" & m_strtxtSearch & "&From=KA&Mode=" & m_strMode & "&Myflag=2&EditClick=1" & "&SpaceID=" & m_strSpaceID & "&ActionLink=" & m_strActionLink & "&PrimaryKey=" & m_strPrimaryKey)%>" ,null,"resizable=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=550,height=240");
                 /// End of Modified by Archanan on 1-Oct-2010 for PMLifeLine SP2
            }
            else
            {
            /// Modified by Archanan on 1-Oct-2010 for PMLifeLine SP2
                //window.open("../../Source/General/Attachment.aspx?FromWhere=KM&ID=<%=m_intPageID%>&Page=../KM/KM_MyPage.aspx&QueryString=" + "<%=Server.UrlEncode("PageID=" & m_intPageID & "&PageNumber=" & m_strPagingNumber & "&txtSearch=" & m_strtxtSearch & "&Fromwhere=" & m_strFromWhere & "&Mode=" & m_strMode & "&Myflag=2&EditClick=1" & "&SpaceID=" & m_strSpaceID & "&ActionLink=" & m_strActionLink & "&PrimaryKey=" & m_strPrimaryKey)%>" ,null,"resizable=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=550,height=240");
                window.open("../../Source/General/Attachment.aspx?TagID=6&FromWhere=KM&ID=<%=m_intPageID%>&Page=../KM/KM_MyPage.aspx&QueryString=" + "<%=Server.UrlEncode("PageID=" & m_intPageID & "&PageNumber=" & m_strPagingNumber & "&txtSearch=" & m_strtxtSearch & "&Fromwhere=" & m_strFromWhere & "&Mode=" & m_strMode & "&Myflag=2&EditClick=1" & "&SpaceID=" & m_strSpaceID & "&ActionLink=" & m_strActionLink & "&PrimaryKey=" & m_strPrimaryKey)%>" ,null,"resizable=yes,left=" + (window.screen.width - 550)/2 + ",top=" + (window.screen.height - 240)/2 + ",width=550,height=240");
            /// End of Modified by Archanan on 1-Oct-2010 for PMLifeLine SP2
            }
            // End of Comment and Modification by ABhijeetC on 12 Nov 2009
		  }
		  
		}
		
		function DelAttachment()
		{
			objchkDelete = GetObjectReference('frmKMMySpace','chkDelete',true);
			var blnIsRecordSelected=false;
				
			if (objchkDelete != null)
			{	
				blnIsRecordSelected=IsCheckboxSelected('frmCommonList','chkDelete')
				if (blnIsRecordSelected == true)
				{				
					if(confirm("Are you sure, you want to delete the selected attachments?"))
					{
						// Commented and Modified by ABhijeetC on 12 Nov 2009
			            // objForm.action = "KM_MyPage.aspx?PageNumber=<%=m_strPagingNumber %>&ActionLink=<%=m_strActionLink %>&PrimaryKey=<%=m_strPrimaryKey %>&Fromwhere=<%=m_strFromWhere %>&txtSearch=<%=m_strtxtSearch %>&Mode=<%=m_strMode%>&SpaceID=<%=m_strSpaceID%>&Action=DELETEATTACHMENT";
			            if ('<%=m_From%>' =='KA') //from Knowledge Administration page
			            {
			                objForm.action = "KM_MyPage.aspx?PageNumber=<%=m_strPagingNumber %>&ActionLink=<%=m_strActionLink %>&PrimaryKey=<%=m_strPrimaryKey %>&From=KA&txtSearch=<%=m_strtxtSearch %>&Mode=<%=m_strMode%>&SpaceID=<%=m_strSpaceID%>&Action=DELETEATTACHMENT";
		
                        }
			            else
			            {
			                objForm.action = "KM_MyPage.aspx?PageNumber=<%=m_strPagingNumber %>&ActionLink=<%=m_strActionLink %>&PrimaryKey=<%=m_strPrimaryKey %>&Fromwhere=<%=m_strFromWhere %>&txtSearch=<%=m_strtxtSearch %>&Mode=<%=m_strMode%>&SpaceID=<%=m_strSpaceID%>&Action=DELETEATTACHMENT";
			            }
			            // End of Comment and Modification by ABhijeetC on 12 Nov 2009
						objForm.submit();
					}
					return;	
				}
			}
			
				alert("Please select atleast one attachment to delete.");
										
		}
		function Show_File(strURL,strSystemFileName)
		{
			window.open('../General/ViewAttachment.aspx?FileName=' + strURL + '&FromWhere=KM' + "&SystemFileName=" + strSystemFileName,'_new','resizable=yes,menubar=yes,scrollbars=yes');
		}
		
		function RateArticle()
		{
		    // window.open("../../Source/KM/KM_ArticleRating.aspx?ProcedureID=<%=m_intPageID%>" ,null,"resizable=no,left=" + (window.screen.width - 400)/2 + ",top=" + (window.screen.height - 250)/2 + ",width=400,height=250");
              //Added by Vidya J on 31 Mar 2016 Purpose: To generate and validate Token
		    $.ajax({
		        type: 'POST',
		        dataType: 'json',
		        contentType: 'application/json',
		        url: 'KM_MyPage.aspx/GenrateToken_RateArticle',
		        data: JSON.stringify({ProcedureID: "<%=m_intPageID%>", EmployeeID: "<%=Session("intUserID")%>" }),
		        success: function (Result) {
		            window.open("../../Source/KM/KM_ArticleRating.aspx?ProcedureID=<%=m_intPageID%>&PKToken=" + Result.d, null, "resizable=no,left=" + (window.screen.width - 400) / 2 + ",top=" + (window.screen.height - 250) / 2 + ",width=400,height=250");
			        },
			        error: function () {
			            // alert("Error")
			        }
			    });

		    //End of addition by Vidya J on 29 Mar 2016
		}
		
		function Back_OnClick(strFrom,PageID)
		{
		   
		   if(strFrom == 'TopTen')
		   {
		        
		        if('<%=strEditClick %>' != '1')
		        { window.location.href="../Km/KM_PageView.aspx?Fromwhere="+strFrom+"&Mode=<%=m_strmode %>&txtSearch=<%=m_strtxtSearch %>&PageID="+PageID;}
		        else
		        { window.location.href="../Km/Km_List.aspx?Fromwhere=TopTen&SelectList=2&txtSearch=<%=m_strtxtSearch %>";}
		        
		   }
		   else if(strFrom == 'Search')
		   {    
		        //window.location.href="../Km/KM_PageView.aspx?Mode=<%=m_strmode %>&Fromwhere="+strFrom+"&PageID="+PageID+"&txtSearch=<%=m_strtxtSearch %>";
		        if('<%=strEditClick %>' != '1')
		        {   
		            if('<%=m_strSpaceID %>' > 0)
		            {   
		                window.location.href="../Km/KM_PageView.aspx?ActionLink=<%=m_strActionLink %>&SpaceID=<%=m_strSpaceID %>&Fromwhere="+strFrom+"&txtSearch=<%=m_strtxtSearch %>&Mode=<%=m_strmode %>&PageID="+PageID;
		            }
		            else
		            {
		                if('<%=strEditClick %>' == '2')
		                {   
		                    window.location.href="../Km/KM_PageView.aspx?ActionLink=<%=m_strActionLink %>&SpaceID=0&Fromwhere="+strFrom+"&txtSearch=<%=m_strtxtSearch %>&Mode=<%=m_strmode %>&PageID="+PageID;
		                }
		                else
		                {    //Commented and added by Yogesh Jalamkar on 12-May-2016 for Page Crash
		                 // window.location.href="../Km/KM_PageView.aspx?ActionLink=<%=m_strActionLink %>&SpaceID=NULL&Fromwhere="+strFrom+"&txtSearch=<%=m_strtxtSearch %>&Mode=<%=m_strmode %>&PageID="+PageID;
		                    window.location.href="../Km/KM_PageView.aspx?ActionLink=<%=m_strActionLink %>&SpaceID=0&Fromwhere="+strFrom+"&txtSearch=<%=m_strtxtSearch %>&Mode=<%=m_strmode %>&PageID="+PageID;
		                    //End of addition by Yogesh Jalamkar  on 12-May-2016 for Page Crash
		                }
		            }
		        }
		        else
		        {  
		            window.location.href="../Km/Km_List.aspx?Fromwhere="+strFrom+"&SelectList=3&txtSearch=<%=m_strtxtSearch %>";
		        }
		   }
		   else if(strFrom == 'MyArticle')
		   {
		        window.location.href="../km/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&Tab=MY&Subtab=MY PAGES&SelectList=4&Mode=<%=m_strmode %>&txtSearch=<%=m_strtxtSearch %>";
		   }
		   else if(strFrom == 'MySpace')
		   {    
		        if('<%=m_strSpaceID%>' == '0' || '<%=m_strSpaceID%>'=='')
		        {  
		            //window.location.href="../km/KM_PageView.aspx?ActionLink=<%=m_strActionLink %>&PageNumber=<%=m_strPagingNumber %>&Mode=<%=m_strmode %>&Fromwhere="+strFrom+"&PageID="+PageID;
		            //window.location.href="../km/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&Action=<%=m_strActionLink %>&Tab=MY&Subtab=MY SPACES&PrimaryKey=<%=m_strPrimaryKey %>";
		            window.location.href="../km/KM_PageView.aspx?PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&Action=<%=m_strActionLink %>&Tab=MY&Subtab=MY SPACES&PrimaryKey=<%=m_strPrimaryKey %>&PageID="+PageID;
		        }
		        else
		        {  
		            window.location.href="../km/KM_List.aspx?ActionLink=<%=m_strActionLink %>&PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&Tab=MY&Subtab=MY SPACES&Mode=<%=m_strmode %>&SelectList=5&txtSearch=<%=m_strtxtSearch %>";
		        }
		   }
		   else if(strFrom == 'MySpaceEdit')
		   {
		        ///*if('<%'=m_strmode %>//' == 'EDIT')
		        {
		         //   window.location.href="../km/KM_List.aspx?PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&Tab=MY&Subtab=MY SPACES&Mode=<%=m_strmode %>&SelectList=5&txtSearch=<%=m_strtxtSearch %>";
		        }
		        //else
		       // {*/
		            window.location.href="../km/KM_PageView.aspx?PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&txtSearch=<%=m_strtxtSearch %>&Mode=<%=m_strmode %>&PageID="+PageID;
		        //}
		   }
		   else if(strFrom == 'MyTeam')
		   {
		        window.location.href="../km/KM_PageView.aspx?PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&txtSearch=<%=m_strtxtSearch %>&Mode=<%=m_strmode %>&PageID="+PageID;
		   }
		   else if(strFrom == 'MyTeamEdit')
		   {
		       window.location.href="../km/KM_PageView.aspx?PageNumber=<%=m_strPagingNumber %>&Fromwhere="+strFrom+"&txtSearch=<%=m_strtxtSearch %>&Mode=<%=m_strmode %>&PageID="+PageID;
		   }
		   else if (strFrom == 'LatestFeatured')
		   {
    		   window.location.href="../Km/KM_PageView.aspx?ActionLink=&Fromwhere=LatestFeatured&Mode=<%=m_strmode %>&txtSearch=<%=m_strtxtSearch %>&SelectList=3&PageID="+PageID;
		   }
		   
		   //added by RohiniK on 10 Nov 09
		   else if (strFrom == '')		   
		        window.location.href="../General/CommonList.aspx?MasterTagID=3992";		
		   //End of addition by RohiniK on 10 Nov 09
		}
		
		function PostComment(intProcedureID,strToken)
		{
			// Commented and Modified by ABhijeetC on 12 Nov 2009
			// window.open("../KM/KM_Discussion.aspx?PageTitle=1&ProcedureID=" + intProcedureID +"&Fromwhere=Discussion&PKToken=" + strToken,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=525"); 
			
			    window.open("../KM/KM_Discussion.aspx?PageTitle=1&ProcedureID=" + intProcedureID +"&Fromwhere=Discussion&PKToken=" + strToken,"","resizable=yes,scrollbars=no,left=" + (window.screen.width - 650)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=650,height=525");

			    //Added by Dhanashri S on 29 Mar 2016 Purpose: To generate and validate Token
			    //$.ajax({
			    //    type: 'POST',
			    //    dataType: 'json',
			    //    contentType: 'application/json',
			    //    url: 'KM_MyPage.aspx/GenrateCommentToken',
			    //    data: JSON.stringify({ ProcedureID: intProcedureID, EmployeeID: "<%=Session("intUserID")%>" }),
			     //   success: function (Result) {
			     //       if ('<%=m_From%>' =='KA') //from Knowledge Administration page
			      //      {
			      //          window.open("../KM/KM_Discussion.aspx?PageTitle=1&ProcedureID=" + intProcedureID + "&PKToken=" + Result.d + "&Fromwhere=KA&PKToken=" + strToken, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=650,height=525");
			      //      }
			      //      else
			      //      {
			      //      window.open("../KM/KM_Discussion.aspx?PageTitle=1&ProcedureID=" + intProcedureID + "&PKToken=" + Result.d + "&Fromwhere=Discussion&PKToken=" + strToken, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 650) / 2 + ",top=" + (window.screen.height - 500) / 2 + ",width=650,height=525");
			      //      }
			      //  },
			     //   error: function () {
			           // alert("Error")
			   //     }
			  //  });

			    //End of addition by Dhanashri S on 29 Mar 2016
			
			// End of Comment and Modification by ABhijeetC on 12 Nov 2009
		}
		
		function ShowHistory(intProcedureID,strToken)
		{
		    window.open("../KM/KM_Discussion.aspx?PageTitle=2&Mode=HISTORY&ProcedureID=" + intProcedureID + "&Fromwhere=Discussion&PKToken=" + strToken, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 750) / 2 + ",width=900,height=650");

		    //Added by Dhanashri S on 29 Mar 2016 Purpose: To generate and validate Token
		    //$.ajax({
		    //    type: 'POST',
		    //    dataType: 'json',
		    //    contentType: 'application/json',
		    //    url: 'KM_MyPage.aspx/GenrateCommentToken',
		    //    data: JSON.stringify({ ProcedureID: intProcedureID }),
		    //    success: function (Result) {
		    //        window.open("../KM/KM_Discussion.aspx?PageTitle=2&Mode=HISTORY&ProcedureID=" + intProcedureID + "&PKCommentToken=" + Result.d + "&Fromwhere=Discussion&PKToken=" + strToken, "", "resizable=yes,scrollbars=no,left=" + (window.screen.width - 750) / 2 + ",top=" + (window.screen.height - 750) / 2 + ",width=900,height=650");

		    //    },
		    //    error: function () {
		           // alert("Error")
		     //   }
		    //});

		    //End of addition by Dhanashri S on 29 Mar 2016
            		   
		}
	

		function HistoryBack_OnClick(intPageID,strToken)
		{
		     window.open("../KM/KM_Discussion.aspx?PageTitle=2&Mode=HISTORY&ProcedureID="+intPageID+"&PKToken="+strToken,"_self","resizable=yes,scrollbars=no,left=" + (window.screen.width - 900)/2 + ",top=" + (window.screen.height - 750)/2 + ",width=900,height=750");
		
		}
		//added by RohiniK on 10 Nov 09
		function Rollback_OnClick(intPageID,strToken)
		{
		  
		    var strMsg = "This will create new version and overwrite the existing content by the version you have selected. Do you want to continue ?"
		    var strResponse;
		    strResponse = window.confirm(strMsg);
		    
		    if (strResponse==true)
		    {		    
		        objForm.action = "KM_MyPage.aspx?From=<%=m_From%>&Action=ROLLBACK&PageID=<%=m_intPageID%>&ProcedureID=" + intPageID + "&VersionID=<%=m_strVersion%>&PKToken=" + strToken;
		        objForm.submit();
		        //refreshParent_Phases('frmKMMyPage', 'KM_MyPage.aspx', '../KM/KM_MyPage.aspx?PageNumber=&txtSearch=&Fromwhere=Search&Mode=Edit&Myflag=2&EditClick=1&SpaceID=0&ActionLink=&PrimaryKey=&PageID= <%=m_intPageID%>');
		        //window.close();
		        
		    }
		}
		//End of addition by RohiniK on 10 Nov 09
		
		//Code added by KapilK on 17-jul-09 [RequestID:21816 parameter added "strOriginalFileName"]
		function Show_File(strURL,strOriginalFileName)
		{
			window.open('../General/ViewAttachment.aspx?FileName='+strOriginalFileName +'&SystemFileName=' + strURL + '&FromWhere=KM' ,'_new','resizable=yes,menubar=yes,scrollbars=yes');
		}
		//End;Code added by KapilK on 17-jul-09 [RequestID:21816 parameter added "strOriginalFileName"]
		   
		//function refreshParent_Phases(parentFormName, parentPage, submitToPage) 
		//{
		//    alert('xcvc');
		   


		//}
		   
		
		
		    //End of addition and added by Yogesh J on 9 oct 2015
		</SCRIPT>
	</body>
</HTML>
