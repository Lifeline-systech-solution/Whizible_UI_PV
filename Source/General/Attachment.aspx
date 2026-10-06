<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Attachment.aspx.vb" Inherits="PbNIT.Attachment" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Attachment")%>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
						<form id='frmAttachment' method='post' runat='server' enctype='multipart/form-data'>						
									<%WritePage()%>								
					</form>
				
					<script language="javascript">
		var objForm;
		var objdivlist;
		
		objForm = GetFormReference('frmAttachment');
		objdivlist = GetObjectReference('frmAttachment','divList');
		
		<%' Added By SonalD on 22nd Jan 2009 %>
		<%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
            disableRightClick();
		<%End If%>
		<%' Added By SonalD on 22nd Jan 2009 %>
		
		function Attach_OnClick(strID, strFromWhere, intProjectID)
		{
          
			var strQueryString;
			var objFileName = GetObjectReference('frmAttachment','txtFileName');
			var objtxtComments = GetObjectReference('frmAttachment','txtComments');
			
			if (disallowBlank(objFileName,"Please select the file",1)	) {return;}
			if (disallowSpecialCharacters(objFileName,'Special character # is not allowed',true,'#')) { return; }
			if (disallowMaxlengthViolation(objtxtComments,<%=m_lngMaxLength%>,"Length should not exceed <%=m_lngMaxLength%> characters",true)) {return;}
	
	
            /// Added by Archanan on 1-Oct-2010
            if ('<%=m_strExtensionList%>'!='')
            {
                debugger;
			    if (ValidateFileExtensions('frmAttachment','txtFileName','<%=m_strExtensionList%>')==false)
			        return;
            }
			/// End of Added by Archanan on 1-Oct-2010
			
			var objtblFileAttachment = GetObjectReference('frmAttachment','tblFileAttachment');
			var objtblFileUploadStatus = GetObjectReference('frmAttachment','tblFileUploadStatus');
			
			objtblFileAttachment.style.display = "none";
			document.body.style.cursor = "wait";
			objtblFileUploadStatus.style.display = "block";
			
			if (strFromWhere == 'CRM,AR' || strFromWhere == 'CRM,SR')
			{
			strQueryString = "Attachment.aspx?Action=ATTACH&FromWhere=" + strFromWhere + "&ID=" + strID + "&ProjectID=" + intProjectID + "&Page=<%=m_strPage%>&Mode=<%=m_strMode%>&QueryString=<%=Server.URLEncode(m_strQueryString)%>";
			objForm.action = strQueryString;
			objForm.submit();
			}
			else
			{
				strQueryString = "Attachment.aspx?Action=ATTACH&FromWhere=" + strFromWhere + "&ID=" + strID + "&ProjectID=" + intProjectID + "&Page=<%=m_strPage%>&QueryString=<%=Server.URLEncode(m_strQueryString)%>";				
				objForm.action = strQueryString;
				objForm.submit();
				
			}	
		}	
		
		function txtFileName_onkeydown() 
		{
			event.returnValue = false;	
		}

		function txtFileName_onbeforepaste() 
		{
			event.returnValue = false;	
		}

		function txtFileName_onpaste() 
		{
			event.returnValue = false;	
		}

		function window_onload()
		{
			var intDivHeight ;
			var intDivHeightRisk;
		    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 38;
			document.body.style.height = window.innerHeight - 11 + 'px'; //Added By Vaijat K ON 14/12/2015
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight + 'px';	
			
			if ("<%=m_strAction%>" == "ATTACH")
			{
				var strParentPage;
				try
				{					
					if ("<%=m_strAction%>" == "BTS")
					{
						opener.document.all.item("btnEnableControls").onclick()	
					}
					else
					{
					    if(trimString("<%=m_strPage%>") != "")
					    {
					    // START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
					   // if ("<%=m_strFromWhere%>" == "BTS"  || "<%=m_strFromWhere%>" ==  "CRM,AR" ||  "<%=m_strFromWhere%>" ==  "CRM,SR" ||  "<%=m_strFromWhere%>" == "CRM,DB" || "<%=m_strFromWhere%>" ==  "CRM") 
					   if ("<%=m_strFromWhere%>" ==  "CRM,AR" ||  "<%=m_strFromWhere%>" ==  "CRM,SR" ||  "<%=m_strFromWhere%>" == "CRM,DB" || "<%=m_strFromWhere%>" ==  "CRM") 
					    { 
					      	strParentPage = "<%=m_strPage%>?" + "<%=m_strQueryString%>" + "&PKToken=<%=m_PKToken%>&Show=2";
					    }
					    //Added by SavitaS on 26 sept 2006 for Security Issue 6197
					    else if ("<%=m_strFromWhere%>" == "BTS") 
					    {
					    	strParentPage = "<%=m_strPage%>?" + "<%=m_strQueryString%>" + "&PKToken=<%=m_PKToken%>";
					    }
					      //End of Added by SavitaS on 26 sept 2006 for Security Issue 6197
					    else
					    {
								strParentPage = "<%=m_strPage%>?" + "<%=m_strQueryString%>";
					    }
					    // END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197	
							opener.location.href = strParentPage;
						}
					}
				}
				catch(e)
				{				
					// This condition will come if the parentpage has been closed, or changed.
					// Do nothing.						
				}	
			}
		}
		
		function window_onresize()		
		{
		    document.body.style.height = window.innerHeight - 11 + 'px'; //Added By Vaijat K ON 14/12/2015
			var intDivHeight;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 38;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';		
		}
					</script>
				
	</body>
</HTML>
