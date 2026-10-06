<%@ Page Language="vb" AutoEventWireup="false" Codebehind="MultiAttachment.aspx.vb" Inherits="PbNIT.MultiAttachment" %>
<!DOCTYPE HTML>
<HTML>
	<%CommonFunctions.General.PlotPageHeadTag("Attachment")%>
		<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%  CommonFunctions.General.PlotPageHeadTag("")%> --%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
	<script type="text/javascript" src="../../responsive/responsive.js"></script>
	<body MS_POSITIONING="GridLayout" class="clsBody" onresize="window_onresize()" onload="window_onload()">
	<form id='frmAttachment' method='post'  enctype='multipart/form-data'>
		<%WritePage()%>
	</form> 
	<script language="javascript">
		var objForm;
		var objdivlist;
		
		objForm = GetFormReference('frmAttachment');
		objdivlist = GetObjectReference('frmAttachment','divList');
		
		
		
		function Attach_OnClick(strID, strFromWhere, intProjectID)
		{ //debugger;
	        var strQueryString;
			
			//var objFileName = GetObjectReference('frmAttachment','txtFileName');
			var objtxtComments = GetObjectReference('frmAttachment','txtComments',true);
			
			var i;
			var objFileName 
			
			//Added by PrashantSJ on 10 Nov 2006 For WhizibleSEM SP8 -IssueID-7568
			var objFileGrid = GetObjectReference('frmAttachment','tblFiles'); 
			//Added By VarunA on 23-Sep-2008 IssueID-22518
            //Purpose : To attach a single file also. (Mozilla)
			if (document.all)
			{
			//End By VarunA on 23-Sep-2008 IssueID-22518
			    if (objFileGrid.rows.length==1)
			    {
			     alert("Please select the file !")
			     return;
			    }
			//Added By VarunA on 23-Sep-2008 IssueID-22518
            //Purpose : To attach a single file also. (Mozilla)
			}
			else
			{
                //Commented and added by Yogesh Jalamkar on 10-NOV-2016 Purpose:Upload should work if file is not selected
			    //if (objFileGrid.rows.length==0)
			    if (objFileGrid.rows.length==1)
			        //End of addition by Yogesh Jalamkar on 10-NOV-2016
			    {
			     alert("Please select the file !")
			     return;
			    }
			}
			//End By VarunA on 23-Sep-2008 IssueID-22518
			
			//End of addition by PrashantSJ on 10 Nov 2006
			for (i=0;i<FileCount;i++)
			{
			    objFileName = GetObjectReference('frmAttachment','txtFileName'+i);
			  
				if (objFileName!=null)
				{
					if (disallowBlank(objFileName,"Please select the file")	) {return;}
					if (disallowSpecialCharacters(objFileName,'Special character # is not allowed',true,'#')) { return; }
					//Added by NitinC on 13 Feb 2012 For WhizibleSEM 11.0 (Issue Fix : 59728)
					if (disallowSpecialCharacters(objFileName,'Single quotation mark is not allowed in file name',true,"'")) { return; }
				    //End of added by NitinC on 13 Feb 2012 For WhizibleSEM 11.0 (Issue Fix : 59728)

				    //Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement
					var countOfDot, FileNameCharCount;
					var intMinFileSize = '<%=ConfigurationManager.AppSettings("MinFileSize")%>'
					    var intActualFileSize = (objFileName.files['0'].size);
					    var strFileExtension = '<%=ConfigurationManager.AppSettings("FileExtensionDisallow")%>'
			            var validateExtensions;

			            validateExtensions = strFileExtension.split(",");
			            if (strFileExtension.length > 0) {
			                var allowSubmit = false;
			                var file = objFileName.value;
			                var extension = file.slice(file.lastIndexOf('.') + 1).toLowerCase();

			                for (var cnt = 0; cnt < validateExtensions.length ; cnt++) {
			                    var strExtn;
			                    strExtn = validateExtensions[cnt];
			                    if (strExtn.toLowerCase() == extension)
			                        //Commented and Added By Bharat Tekade on 9th-Jun-2016 for SEM Enhancement
			                        //{ allowSubmit = false; }
			                    { allowSubmit = true; }
			                    //End of Commented and Added By Bharat Tekade on 9th-Jun-2016 for SEM Enhancement
			                }
			                if (allowSubmit == false) {
			                    alert("Only files with extensions " + (validateExtensions.join(", ", "").toUpperCase()) + " are  allowed!!!");
			                    return ;
			                }
			            }

			            if (objFileName.files['0'].name != '')
			                var countOfDot = objFileName.files['0'].name.split(".").length - 1;

			            if (countOfDot > 1) {
			                alert('File with two or more extensions is not allowed!');
			                return ;
			            }

			            if (objFileName.files['0'].name != '')
			                FileNameCharCount = objFileName.files['0'].name.split(".")[0].length;

			            if (FileNameCharCount > 120) {
			                alert('File name should not exceed 120 characters!');
			                return ;
			            }

			            if (intActualFileSize < intMinFileSize) {
			                alert('File size should be greater than or equal to ' + intMinFileSize + ' bytes !');
			                return ;
			            }
				    //End of Added By Bharat Tekade on 10th-Jun-2016 for File Validate for SEM Enhancement
				}
			}
			objFileName = GetObjectReference('frmAttachment','txtFileName'+i);
		
			if (objFileName !=null)
				objFileName.disabled=true;
		    //Modified by NitinC on 26 July 2011 for WhizibleSEM 10.0 (Issue --> 50847)
		    for (var k=0;k<objtxtComments.length;k++)
		    {
			    if (disallowMaxlengthViolation(objtxtComments[k],<%=m_lngMaxLength%>,"Length should not exceed <%=m_lngMaxLength%> characters",true)) {return;}
			}
			//End Modification
	        ///Commented by NitinC on 16 March 2011 for WhizibleSEM WhizibleSEM version 10.0 
            /// Added by Archanan on 1-Oct-2010
            //if ('<%=m_strExtensionList%>'!='')
            //{
			    //if (ValidateFileExtensions('frmAttachment','txtFileName','<%=m_strExtensionList%>')==false)
			        //return;
            //}
			/// End of Added by Archanan on 1-Oct-2010
            ///End of Commented by NitinC on 16 March 2011 for WhizibleSEM WhizibleSEM version 10.0
			var objtblFileAttachment = GetObjectReference('frmAttachment','tblFileAttachment');
			var objtblFileUploadStatus = GetObjectReference('frmAttachment','tblFileUploadStatus');
			
			objtblFileAttachment.style.display = "none";
			document.body.style.cursor = "wait";
			objtblFileUploadStatus.style.display = "block";
			///Added by NitinC on 16 March 2011 for WhizibleSEM version 10.0
			if (strFromWhere == 'CRM,AR' || strFromWhere == 'CRM,SR'|| strFromWhere == 'CRM,DB'|| strFromWhere == 'SR'|| strFromWhere == 'CRM')
			{
			    //Added by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
			    var MenuTags = document.getElementsByTagName('A');
			    for (i = 0; i < MenuTags.length; i++) {
			        if (MenuTags[i].className == "Menu") {
			            //MenuTags[i].style.display= "none";
			            MenuTags[i].parentNode.style.display = "none";
			        }
			    }
			    setFrameLoader();
			    //End of addition by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
			    strQueryString = "MultiAttachment.aspx?Action=ATTACH&FromWhere=" + strFromWhere + "&ID=" + strID + "&ProjectID=" + intProjectID + "&Page=<%=m_strPage%>&Mode=<%=m_strMode%>&QueryString=<%=Server.URLEncode(m_strQueryString)%>&PKToken=<%=m_PKToken%>";
			    objForm.action = strQueryString;
			    objForm.submit();
			}
			else
			{
			///End of Added by NitinC on 16 March 2011 with closing of else for WhizibleSEM version 10.0
			    //Added by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
			    var MenuTags = document.getElementsByTagName('A');
			    for (i = 0; i < MenuTags.length; i++) {
			        if (MenuTags[i].className == "Menu") {
			            //MenuTags[i].style.display= "none";
			            MenuTags[i].parentNode.style.display = "none";
			        }
			    }
			    setFrameLoader();
			    //End of addition by Yogesh Jalamkar on 12-OCT-2016 Purpose: Save link issue
			    strQueryString = "MultiAttachment.aspx?Action=ATTACH&FromWhere=" + strFromWhere + "&ID=" + strID + "&ProjectID=" + intProjectID + "&Page=<%=m_strPage%>&QueryString=<%=Server.URLEncode(m_strQueryString)%>&PKToken=<%=m_PKToken%>";
			    //Added Byu VijaYD On 17 Aug 2009 fOR Search Filter On On Issue Page
			    //objForm.action = strQueryString
			    objForm.action = strQueryString+"&IssueListSearchValue=<%=m_strIssueListSearchValue%>&IssueListSearchType=<%=m_strIssueListSearchType%>"; 
			    //End Addition By 17 Aug 2009
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
		    document.body.style.height = window.innerHeight - 11 + 'px'; //Added By Vaijat K ON 15/12/2015
		    var intDivHeight ;
			var intDivHeightRisk;
		    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 38;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';	
			
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
					        ///Commented by NitinC on 16 March 2011 for WhizibleSEM version 10.0
					            ///strParentPage = "<%=m_strPage%>?" + "<%=m_strQueryString%>" + "&PKToken=<%=m_PKToken%>"; 
							    //strParentPage = "<%=m_strPage%>?" + "<%=m_strQueryString%>" + "&PKToken=<%=m_PKToken%>"+"&IssueListSearchValue=<%=m_strIssueListSearchValue%>&IssueListSearchType=<%=m_strIssueListSearchType%>"; 
							    //opener.location.href = strParentPage;
							    //window.close();
    						///End of Commented by NitinC on 16 March 2011 for WhizibleSEM version 10.0
    						
					        //Added by NitinC on 16 March 2011 for WhizibleSEM version 10.0
					        if ("<%=m_strFromWhere%>" ==  "CRM,AR" ||  "<%=m_strFromWhere%>" == "CRM,DB" || "<%=m_strFromWhere%>" ==  "CRM"|| "<%=m_strFromWhere%>" ==  "CRM,SR") 
					        { 
					            strParentPage = "<%=m_strPage%>?" + "<%=m_strQueryString%>" + "&PKToken=<%=m_PKToken%>&Show=2";
                                //Added By Vaijat K ON 24/05/2017 For Production Issue
					            //opener.location.href = opener.location.href;
					            var strAction = opener.location.href;
					            strAction = String(strAction).replace("DELETE_ATTACHMENTS","");
					            opener.location.href = strAction;
					            return;
					            //End Added By Vaijat K ON 24/05/2017 For Production Issue
					        }
					        else
					        {
					        //End of Added by NitinC on 16 March 2011 with closing of else for WhizibleSEM version 10.0
							    //strParentPage = "<%=m_strPage%>?" + "<%=m_strQueryString%>" + "&PKToken=<%=m_PKToken%>"; 
							    strParentPage = "<%=m_strPage%>?" + "<%=m_strQueryString%>" + "&PKToken=<%=m_PKToken%>"+"&IssueListSearchValue=<%=m_strIssueListSearchValue%>&IssueListSearchType=<%=m_strIssueListSearchType%>"; 
							}                               
							opener.location.href = strParentPage;
							window.close();
							
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
		    document.body.style.height = window.innerHeight - 11 + 'px'; //Added By Vaijat K ON 15/12/2015
			var intDivHeight;
			var intDivHeightRisk;
		    //intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 60;
			intDivHeight = window.innerHeight - objdivlist.offsetTop - 38;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight +'px';		
		}
		
		
		var FileCount=0;
		var FileCount_toDisable = 0;
		function addFileinGrid()
		{
		    
			var objtxtFileName = GetObjectReference('frmAttachment','txtFileName'+FileCount);
			var objFileGrid = GetObjectReference('frmAttachment','tblFiles'); 
			objFileGrid.style.display="";
			var newRow  = objFileGrid.insertRow(objFileGrid.rows.length);
		
			newRow.id='FILENAME'+FileCount;
			newRow.name='txtFileName';
			newRow.className = "clsTREven";
			var newCell = newRow.insertCell(0);
			
			var fileName = objtxtFileName.value;
			var index = fileName.lastIndexOf("\\");
			if (index==-1)
			index = fileName.lastIndexOf("/");
			
			if (index != -1)
				fileName = fileName.substring(index+1,fileName.length);
				
			newCell.innerHTML=fileName;
			
			//Added by NitinC on 22 March 2011 For WhizibleSEM 10.0
			newCell = newRow.insertCell(1);
			newCell.innerHTML="<Textarea wrap='Hard'  name='txtComments' id='txtComments' class='clsTextArea' style='width:250px  ; height:50px  ; text-align:Left'  ></Textarea>";
			//End of Added by NitinC on 22 March 2011 For WhizibleSEM 10.0
			
			//Modified by NitinC on 10 Nov 2011 for WhizibleSEM 10.0
			if ("<%=m_intTagID%>" == 405)
			{//debugger;
			    newCell = newRow.insertCell(2);
			    newCell.innerHTML="Internal <Input type=checkbox name='chkIsShowToCustomer"+FileCount+"' id='chkIsShowToCustomer"+FileCount+"' class='clsCheckBox'>";            
			    newCell = newRow.insertCell(3);  //Added By Vaijat K ON 04/11/2015
			}
			else{
			    newCell = newRow.insertCell(2);  //Added By Vaijat K ON 04/11/2015
			} 
			//End of Modified by NitinC on 10 Nov 2011 for WhizibleSEM 10.0
		    newCell = newRow.insertCell(3); //Commented By Vaijat K ON 04/11/2015
			//Replaced by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8
			//Purpose: Replaced tooltip -> Upload to Remove Attachment
			newCell.innerHTML="<A class='Menu' style='' HREF='Javascript:RemoveAttachement("+ FileCount +")' Title='Remove Attachment' >(Remove)</A>";
			//End of addition by PrashantSJ on 09 Nov 2006
			
			
			parentTD = objtxtFileName.parentNode;
			objtxtFileName.style.display = "none";
			
			FileCount++;
			FileCount_toDisable++;
			
			var FileControl;
			FileControl=document.createElement("INPUT");
			FileControl.type="FILE";
			FileControl.id="txtFileName"+FileCount;
			FileControl.name="txtFileName"+FileCount;
			FileControl.className = 'clsTextBox';
			FileControl.size=74;
			
			FileControl.onkeydown=function(){return false;};
			FileControl.onbeforepaste=function(){return false;};
			FileControl.onpaste=function(){return false;}; 
			FileControl.onkeydown=function(){return txtFileName_onkeydown();}; 
			FileControl.onbeforepaste=function(){return txtFileName_onbeforepaste();}; 
			FileControl.onpaste=function(){return txtFileName_onpaste();}; 
			FileControl.onchange=addFileinGrid;
			
			
			//FileControl.style.display = "none";
			//FileControl.value = objtxtFileName.value;
			
			if (FileCount_toDisable==5)
			FileControl.disabled=true;
			
			parentTD.appendChild(FileControl);
		    //Commented by bharat tekade on 16th-jun-2015
		    //FileControl.fireEvent('onclick');			
		    //Ended By Bharat Tekade on 16th-Jun-2015	
			
			
			
			
		}
		function RemoveAttachement(FileNO)
		{
		
			var objTR = GetObjectReference('frmAttachment','FILENAME'+FileNO); 
			var toRemoveFileControl = GetObjectReference('frmAttachment','txtFileName'+FileNO); 
			var objFileGrid = GetObjectReference('frmAttachment','tblFiles'); 
			
			objFileGrid.deleteRow(objTR.rowIndex);
			
			toRemoveFileControl.parentNode.removeChild(toRemoveFileControl);
			GetObjectReference('frmAttachment',"txtFileName"+FileCount).disabled=false;; 
			
			//Added by PrashantSJ on 10 Nov 2006 For WhizibleSEM SP8 -IssueID-7569
			if (objFileGrid.rows.length==1)
			{
			 objFileGrid.style.display='none';
			}
			//End of addition by PrashantSJ on 10 Nov 2006
			
			FileCount_toDisable--;
		}
	</script>
	</body>
</HTML>
