<%@ Page Language="vb" AutoEventWireup="false" Codebehind="DocumentDownLoad.aspx.vb" Inherits="PbNIT.DocumentDownLoad" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Documents")%>
	<body class="clsBody" onresize="window_onresize()" onload="window_onload()" MS_POSITIONING="GridLayout">
		
				
					<form id="frmResourceDocuments" name="frmResourceDocuments" method="post" encType="multipart/form-data"
						runat="server">
						
									<%PageInit()%>
							
					</form>
				
					<script language="javascript">
//					debugger;
	var objform,objdivlist ;
	objform = GetFormReference('frmResourceDocuments');
	objdivlist = GetObjectReference('frmResourceDocuments','DivList');
	
	        <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
	
	function window_onload()		
	{
		//Mode=<%=CONST_MODE_ATTACHURL%>&Action=<%=CONST_ACTION_ATTACHURL%>
////		<% if ((request.queryString("Mode") = CONST_MODE_UPLOAD AND request.queryString("Action") = CONST_ACTION_UPLOAD ) OR (request.queryString("Mode") = CONST_MODE_ATTACHURL AND request.queryString("Action") = CONST_ACTION_ATTACHURL )) %>
////		var strParentPage = new String();
////		if (window.opener != null) 
////		{
////			var MtagID = '<%=m_strOpenerTagID%>'
////			
////			if (MtagID!="")
////			{	
////				var objTokenPK = window.opener.document.getElementById('PKToken');
////				var objIDPK = window.opener.document.getElementById('OpportunityID_PK');
////				strParentPage = '../HR/HR_Opportunity_CommonPage.aspx?';
////				strParentPage = strParentPage + 'OpportunityID_PK='+objIDPK.value+'&PKToken='+objTokenPK.value;
////				strParentPage = strParentPage + '&MasterTagID='+MtagID+'&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1';
////	 
////				refreshParent('frmCommonPage', 'HR_Opportunity_CommonPage.aspx', strParentPage)
////			}
////            window.close();
////		}
////		<%End If %>
		
		var intDivHeight ;
		var intDivHeightRisk;
		strIsReview ='<%=Request.Querystring("IsReview")%>';
		//debugger;
//		if(navigator.appName == 'Netscape')
//		{		  
//		   intDivHeight =window.innerHeight  - objdivlist.offsetTop - 50 ;
//		}
//		else
//		{
//		   intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
//		}
//		if (intDivHeight < 100)
//		intDivHeight = 100;
//		objdivlist.style.height = intDivHeight	;	
	}
			
	/*function window_onresize()		
	{
		var intDivHeight ;
		var intDivHeightRisk;
				
		if(navigator.appName == 'Netscape')
		{		  
		//	intDivHeight =window.innerHeight  - objdivlist.offsetTop - 50 ;
		}
		else
		{
		//	intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
		}
		if (intDivHeight < 100)
		intDivHeight = 100;
		objdivlist.style.height = intDivHeight	;	
	}*/
	
	
	
	function UploadDoc_OnClick()
	{
		window.open("../HR/HR_ResourceDocument.aspx?Mode=<%=CONST_MODE_UPLOAD%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=400");
	}
	
	function AttachURL_OnClick()
	{
		window.open("../HR/HR_ResourceDocument.aspx?Mode=<%=CONST_MODE_ATTACHURL%>","","resizable=yes,menubar=no,scrollbars=no,left=" + (window.screen.width-500)/2 + ",top=" + (window.screen.height-400)/2 + ",width=500,height=350");
	}
  
  function ViewUploadedFile(ViewFilePath,DirPath)
	{						 
			//window.open ("../General/ViewAttachment.aspx?FromWhere=Resource_Demand&FileName="+ViewFilePath ); 
            window.open ("../General/ViewAttachment.aspx?FromWhere=Documents&FileName="+ViewFilePath ); 
			//window.open ("../General/ViewAttachment.aspx?FromWhere=Resource_Demand&FileName=HDLP_IE.txt", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");

			
	}
	
	function cboCategory_OnChange()
	{
		var url;
		var CatID=GetObjectReference('','cboCategory').value;
		url=new String();
		url=""
		
		
		url="../HR/HR_ResourceDocument.aspx?Mode=<%=CONST_MODE_UPLOAD%>&FromXML=1&CategoryID="+CatID;
		
		loadXMLDoc(url,'');
		return;
					
	}
	
	function loadXMLDoc(url,reqQuery)
	{
	   if (window.XMLHttpRequest)
	     {
			xmlhttp=new XMLHttpRequest();
			xmlhttp.onreadystatechange= state_Change;
			if (ns) 
			{
			  xmlhttp.open('GET',url,true);
			  xmlhttp.send(null);
		    }
			else 
			{
			  xmlhttp.open('POST',url,false);
			  xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
              xmlhttp.send(reqQuery);
            }
		}
	  else if (window.ActiveXObject)
	    {
			xmlhttp=new ActiveXObject('Microsoft.XMLHTTP');
			if (xmlhttp) 
			 {
			    xmlhttp.onreadystatechange=state_Change;
				xmlhttp.open('POST',url,false);
				xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
				xmlhttp.send(reqQuery);
			 }
		}

	}
	
	function state_Change() 
	{
		if (parseInt(xmlhttp.readyState)==4) {
			if (xmlhttp.status==200){
			
			     GetObjectReference('','tdSubCategory').innerHTML=xmlhttp.responseText;
			}}
	}
	
	function cboAttachCategory_OnChange()
	{
	   var url;
		var CatID=GetObjectReference('','cboAttachCategory').value;
		url=new String();
		url=""
		
		
		url="../HR/HR_ResourceDocument.aspx?Mode=<%=CONST_MODE_ATTACHURL%>&FromXML=1&CategoryID="+CatID;
		
		loadXMLDoc(url,'');
		return;
		
	  	
	}
	
	function Upload_OnClick()
	{
//	debugger;
	  var objCbo,objTxt,objDesc;
				
	  objTxt = GetObjectReference('frmResourceDocuments','txtFileName');
	  if(disallowBlank(objTxt)==true)
	  {
	     alert('Select document to upload.');
	     objTxt.focus();
	     return;
	  }
	  	
	  objCbo = GetObjectReference('frmResourceDocuments','cboCategory');
	  if(disallowBlank(objCbo)==true)
	  {
	     alert('Select document Category.');
	     objCbo.focus();
	     return;
	  }
	  
	  objDesc = GetObjectReference('frmResourceDocuments','txtDescription');
	  if(disallowBlank(objDesc)==true)
	  {
	     alert('Enter description for document.');
	     objDesc.focus();
	     return;
	  }
	  
	  var objtblFileAttachment = GetObjectReference('frmHR_Attachment','tblFileAttachment');
	  var objtblFileUploadStatus = GetObjectReference('frmResourceDocuments','tblFileUploadStatus');			
			
			objtblFileAttachment.style.display = "none";
			document.body.style.cursor = "wait";
			objtblFileUploadStatus.style.display = "block";
	  
	  objform.action="../HR/HR_ResourceDocument.aspx?Mode=<%=CONST_MODE_UPLOAD%>&Action=<%=CONST_ACTION_UPLOAD%>";
	  objform.submit();	
	  
	}
	
	function Attach_OnClick()
	{
	  var objAttachCbo,objAttachURL,objAttachDesc;
	  var flag;
	  
	  objAttachURL=GetObjectReference('frmResourceDocuments','txtURL');
	  if(disallowBlank(objAttachURL)==true)
	  {
	     alert('Please enter URL.');
	     objAttachURL.focus();
	     return;
	  }
	  
	  flag=IsValidURL(objAttachURL.value)
	  if(flag==false)
	  {
	    alert('Please enter valid URL.');
	    flag=true;
	    objAttachURL.focus();
	    return;
	  }
	  
	  objAttachCbo = GetObjectReference('frmResourceDocuments','cboAttachCategory');
	  if(disallowBlank(objAttachCbo)==true)
	  {
	     alert('Select document Category.');
	     objAttachCbo.focus();
	     return;
	  }
	  
	  objAttachDesc = GetObjectReference('frmResourceDocuments','txtDescription');
	  if(disallowBlank(objAttachDesc)==true)
	  {
	     alert('Enter description for document.');
	     objAttachDesc.focus();
	     return;
	  }
	  
	  objform.action="../HR/HR_ResourceDocument.aspx?Mode=<%=CONST_MODE_ATTACHURL%>&Action=<%=CONST_ACTION_ATTACHURL%>";
	  objform.submit();	
	}
	
	function Download_OnClick(DocID)
	{
	
		window.open("../HR/HR_ResourceDocument.aspx?DocumentID="+DocID+"&Mode=<%=CONST_MODE_HISTORY%>&Action=<%=CONST_ACTION_HISTORYDOWNLOAD%>","","resizable=yes,scrollbars=no,menubar=no,toolbar=no,statusbar=no,left="+(window.screen.width - 600)/2+",top="+(window.screen.height - 400)/2+",width=600,height=400")	
	}
	
	function DeleteDetails_OnClick()
		{
		//debugger;
			var objchkDelete = GetObjectReference('frmResourceDocuments','chkDelete',true);
			var blnIsCheckboxChecked;
			var intCounter;
			blnIsCheckboxChecked = false;
			var strQueryString;
			
			if (objchkDelete.length > 0)
			{
				for(intCounter=0; intCounter < objchkDelete.length;intCounter++)
				{
					if (objchkDelete[intCounter].checked == true)
					{
						blnIsCheckboxChecked = true;
						break;
					}
				}
				
				if (blnIsCheckboxChecked == true)
				{
					if (confirm("Are you sure you want to delete the record(s)?")==true)
					{
						strQueryString = "HR_ResourceDocument.aspx?ActionType=DELETEDETAILS&Mode=<%=CONST_MODE_UPLOAD%>&FromWhere=Resource_Demand", "", "resizable=no,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=300"; 
						objform.action = strQueryString;
						objform.submit();					
					}
				}
				else
				{
					alert("Please Select Record to delete");
				}	
			}
				
		}
	 		
					</script>
				
	</body>
</HTML>
