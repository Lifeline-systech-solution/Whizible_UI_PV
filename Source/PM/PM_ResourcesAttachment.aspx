<%@ Page Language="vb" AutoEventWireup="false" Codebehind="PM_ResourcesAttachment.aspx.vb" Inherits="PbNIT.PM_ResourcesAttachment" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<!-- Commented by Gauri on 12/08/24 for JQuery and Bootstrap version upgrade -->
	<%CommonFunctions.General.PlotPageHeadTag("Upload Excel")%>
	
 
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
						<form id='frmPM_ResourcesAttachment' method='post' runat='server' enctype='multipart/form-data'>						
									
									<%WritePage()%>								
					</form>
				
		<script language="javascript">
		
			var objForm;
			var objdivlist;
			var intTagID;
			intTagID = "<%=m_intTagID%>"
			objForm = GetFormReference('frmPM_ResourcesAttachment');
			objdivlist = GetObjectReference('frmPM_ResourcesAttachment','divList');
		
		    <%' Added By SonalD on 12th Jan 2009 %>
		    <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
		    <%End If%>
		    <%' Added By SonalD on 12th Jan 2009 %>
		
		function window_onload()
		{
		//var objcboTemplate = GetObjectReference('frmPM_ResourcesAttachment','cboTemplate');
	//	objcboTemplate.focus();
			var intDivHeight ;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			if (intDivHeight < 100) intDivHeight = 100;
		    //Commented and added by Yogesh J on 11/12/2015
		    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
			
		}
		
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 50;
			if (intDivHeight < 100) intDivHeight = 100;
		    //Commented and added by Yogesh J on 11/12/2015
		    //objdivlist.style.height = intDivHeight;
			objdivlist.style.height = intDivHeight + 'px';
				
		}
		
			
		
		function Attach_OnClick()
		{
			var strQueryString;
		
		
			var objFileName = GetObjectReference('frmPM_ResourcesAttachment','txtFileName');
			//var objtxtComments = GetObjectReference('frmPM_ResourcesAttachment','txtComments');
			//var objcboTemplate = GetObjectReference('frmPM_ResourcesAttachment','cboTemplate');
			
			//if (disallowBlank(objcboTemplate,"Please select the Resource Joining Pool Template",1)	) {return;}
			if (disallowBlank(objFileName,"Please select the file",1)	) {return;}
			if (disallowSpecialCharacters(objFileName,'Special character # is not allowed',true,'#')) { return; }
			//if (disallowMaxlengthViolation(objtxtComments,<%=m_lngMaxLength%>,"Length should not exceed <%=m_lngMaxLength%> characters",true)) {return;}
			
			// Check if extn. is xls
			var str=objFileName.value;	
			str=str.toLowerCase()
			var pos=str.indexOf(".xls") 
			if (pos==-1)
			{
				alert("Please select only Excel Files.");
				return;				
			}
				
			var objtblFileAttachment = GetObjectReference('frmPM_ResourcesAttachment','tblFileAttachment');
			var objtblFileUploadStatus = GetObjectReference('frmPM_ResourcesAttachment','tblFileUploadStatus');
			
			objtblFileAttachment.style.display = "none";
			document.body.style.cursor = "wait";
			objtblFileUploadStatus.style.display = "block";
					
			strQueryString = "PM_ResourcesAttachment.aspx?Action=ATTACH&MasterTagId="+intTagID+"&FromWhere=DXU&Page=<%=m_strPage%>&Mode=<%=m_strMode%>", "", "resizable=no,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=300; //&QueryString=<%=Server.URLEncode(m_strQueryString)%>";
			objForm.action = strQueryString;
            objForm.submit();

            //Added By Usha Pandit On 11.12.2020 For refresh issue after Excel upload
            window.onunload = refreshParent;
            function refreshParent() {
                window.opener.location.reload();
            }
			//End Of Added By Usha Pandit On 11.12.2020 For refresh issue after Excel upload
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


		function ViewRejectedFile(RejectedRecordsFilePath)
		{	
			window.open ("../General/ViewAttachment.aspx?FromWhere=DXU%5CRejectedFiles%5C&FileName="+RejectedRecordsFilePath ); 
			
		}
		function ViewUploadedFile(ViewFilePath,DirPath)
		{						 
				window.open ("../General/ViewAttachment.aspx?FromWhere=DXU%5CRequests%5C&FileName="+ViewFilePath ); 
				
		}
		function ViewLogFile(logFilePath)
		{	
			window.open ("../General/ViewAttachment.aspx?FromWhere=DXU%5Clogs%5C&FileName="+logFilePath ); 
			
		}
		
		function Download_onclick()
		{ 
			//var strQueryString;
			if (intTagID == 800)
					window.open ("../General/ViewAttachment.aspx?FromWhere=DXU&FileName=RepositoryTemplate.xls", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
			
				
			if (intTagID == 23)
					window.open ("../General/ViewAttachment.aspx?FromWhere=DXU&FileName=EmployeeTemplate.xls", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
			if (intTagID == 3873)
					window.open ("../General/ViewAttachment.aspx?FromWhere=DXU&FileName=cca96b2b.xls", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
			//window.open ("../General/commonlist.aspx?FromWhere=DXU&MasterTagID=3876", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
			if (intTagID == 3949)
					window.open ("../General/ViewAttachment.aspx?FromWhere=DXU&FileName=EmployeePayrollTemplate.xls&SystemFileName=fc24ea88.xls", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
					
					//Added By VarunA on 23-Mar-2009 IssueID-28582
			//Purpose : To upload Approved Employee Leave through Excel Upload.
			if (intTagID == 1207)
					window.open ("../General/ViewAttachment.aspx?FromWhere=DXU&FileName=EmployeeLeaves.xls", "", "resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 850)/2 + ",top=" + (window.screen.height - 500)/2 + ",width=850,height=500");
			//End By VarunA on 23-Mar-2009 IssueID-28582
			
		}	
		
			
		function DeleteDetails_OnClick()
		{
			var objchkDelete = GetObjectReference('frmPM_ResourcesAttachment','chkDelete',true);
			var blnIsCheckboxChecked;
			var intCounter;
			blnIsCheckboxChecked = false;
			
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
						//Modified By VarunA 30-Sep-2008 IssueID-20106
					    //Purpose : To have the master TagID while deleting a record, b'cos the page get refreshed.
						//strQueryString = "HR_Attachment.aspx?Action=DELETEDETAILS&FromWhere=DXU&Page=<%=m_strPage%>&Mode=<%=m_strMode%>", "", "resizable=no,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=300; //&QueryString=<%=Server.URLEncode(m_strQueryString)%>";
						strQueryString = "PM_ResourcesAttachment.aspx?Action=DELETEDETAILS&FromWhere=DXU&Page=<%=m_strPage%>&Mode=<%=m_strMode%>&MasterTagID=<%=m_intTagID%>", "", "resizable=no,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=" + (window.screen.width - 600)/2 + ",top=" + (window.screen.height - 400)/2 + ",width=650,height=300; //&QueryString=<%=Server.URLEncode(m_strQueryString)%>";
						//End By VarunA 30-Sep-2008 IssueID-20106
						objForm.action = strQueryString;
						objForm.submit();					
					}
				}
				else
				{
					alert("Please Select Record to delete");
				}	
			}
				
		}
		
		function SelectAll_Onclick()
		{
			var objchkDelete = GetObjectReference('frmPM_ResourcesAttachment','chkDelete',true);
			for(i=0;i<objchkDelete.length;i++)
			{
				objchkDelete[i].checked = true;
			}
		}
		
		function ClearAll_Onclick()
		{
			var objchkDelete = GetObjectReference('frmPM_ResourcesAttachment','chkDelete',true);
				for(i=0;i<objchkDelete.length;i++)
			{
				objchkDelete[i].checked = false;
			}
		}
		
		function Close_OnClick()
		{
			window.close();			
		}
		
		</script>
</body>
</HTML>