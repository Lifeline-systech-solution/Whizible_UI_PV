<%@ Page Language="vb" EnableViewState="false" AutoEventWireup="false" Codebehind="Approvals.aspx.vb" Inherits="Whizible.Approvals" %>
<HTML>
<HEAD>
<TITLE>Show Pending Approvals</TITLE>
<meta name='GENERATOR' content='Microsoft Visual Studio.NET 7.0'>
<meta name='CODE_LANGUAGE' content='Visual Basic 7.0'>
<meta name='vs_defaultClientScript' content='JavaScript'>
<meta name='vs_targetSchema' content='http://schemas.microsoft.com/intellisense/ie5'>
<meta http-equiv="Cache-Control" CONTENT="no-cache">
<meta http-equiv="Pragma" CONTENT="no-cache">
<link rel='stylesheet' type='text/css' href='Source/General/StyleSheetChanakya.css'/>
<link id='lnkWhizStyleSheetImgDir' type='text/plain' href='images/cssImages/'/>
<script language='javascript' src='Source/General/CommonFunctions.js'></script>
<script language='javascript' src='Source/General/CommonValidations.js'></script>
<link rel="stylesheet" type="text/css" href="Source/General/tabcontent.css" />
</script>
</HEAD>
	<BODY MS_POSITIONING="FlowLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<FORM id="frm_Approvals" method="post" runat="server">
			<%If (Session("intUserID") Is Nothing) Then %>
			<TABLE width="50%" height="40%" border="3" align="center" cellspacing="20" cellpadding="5"
				bgColor="#448870">
				<TR>
					<TD>
						<%If m_blnIsWindowsAuthenticated = false then%>
						<TABLE width="100%" align="left" height="100%">
							<TBODY>
								<TR>
									<TD width="100%" align="left" vAlign="middle" height="15" colspan="2">
										<P class="style25" style="FONT-SIZE: 13px; MARGIN: 2px; COLOR: #ffffff; FONT-FAMILY: Verdana"
											align="left">
											Show Pending Approvals
										</P>
									</TD>
								</TR>
								<TR>
									<TD width="50%" align="right" height="15" vAlign="middle">
										<P class="style10" style="FONT-SIZE: 10px; MARGIN: 2px; COLOR: #ffffff; FONT-FAMILY: Verdana"
											align="right">Login ID:
										</P>
									</TD>
									<TD width="50%" align="left" height="15" vAlign="middle">
										<P class="style10" style="MARGIN: 2px">
											<FONT size="1"><INPUT type="text" id="txtLogin" name="txtLogin" class="clsTextBox" size="17" runat="server"
													tabindex="1" style="BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid; BACKGROUND-COLOR: #ebebeb"
													maxLength="30"> </FONT>
										</P>
									</TD>
								</TR>
								<TR>
									<TD width="50%" align="right" height="15" vAlign="middle">
										<P class="style10" style="FONT-SIZE: 10px; MARGIN: 2px; COLOR: #ffffff; FONT-FAMILY: Verdana"
											align="right">Password:</P>
									</TD>
									<TD width="50%" align="left" height="15" vAlign="middle">
										<P class="style10" style="MARGIN: 2px">
											<FONT size="1"><INPUT type="password" id="txtPassword" name="txtPassword" class="clsTextBox" size="17"
													runat="server" tabindex="2" style="BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid; BACKGROUND-COLOR: #ebebeb"
													maxLength="30" language="JavaScript" onkeypress="Password_OnKeyPress(event)">
											</FONT>
										</P>
									</TD>
								</TR>
								<% If m_IsCookiesExist = True Then %>
								<TR>
								
									<TD width="50%" align="right" height="15" vAlign="middle">
										<P class="style10" style="FONT-SIZE: 10px; MARGIN: 2px; COLOR: #ffffff; FONT-FAMILY: Verdana"
											align="right"></P>
									</TD>
									<TD width="50%" align="left" height="15" vAlign="middle">
										<P class="style10" style="FONT-SIZE: 10px; MARGIN: 2px; COLOR: #ffffff; FONT-FAMILY: Verdana"
											<FONT size="1"><INPUT type="checkbox" id="chkRememberPassword" name="chkRememberPassword" 
													runat="server" tabindex="3" style="BORDER-RIGHT: #000000 1px solid; BORDER-TOP: #000000 1px solid; BORDER-LEFT: #000000 1px solid; BORDER-BOTTOM: #000000 1px solid; BACKGROUND-COLOR: #ebebeb">
												Remember me on this computer. </FONT>
										</P>
									</TD>
								</TR>
								<% End If %>
								<TR>
									<TD width="100%" align="center" vAlign="middle" colspan="2">
										<%DrawGo()%>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
						<%Else %>
						<TABLE class="clsTable">
							<TR>
								<TD><A class="SetAsDefault" href='Approvals.aspx' style='TEXT-DECORATION:none'><FONT size="2" face="verdana"><B>Login</B></FONT></A></TD>
							</TR>
						</TABLE>
						<%End If %>
					</TD>
				</TR>
			</TABLE>
			<%End If  %>
			<%If Not (Session("intUserID") Is Nothing) Then %>
			<DIV id="divTbl" runat="server">
				<TABLE class="clsGridTable" id="tbl_popup">
					<TR class="clsTRColumnHeader">
						<Div name='fieldset1' id='fieldset1'></Div>
					</TR>
				</TABLE>
			</DIV>
			
			
			<%BuildPage()%>
						
			<%End If  %>
			<INPUT type="hidden" name="txtInvalidLogin" id="txtInvalidLogin" runat="server">
			<INPUT type="hidden" name="txtIsCookiesExist" id="txtIsCookiesExist" runat="server">
			<INPUT type="hidden" name="txtClientLoggedInAt" id="txtClientLoggedInAt" value="<% = GetTick()%>">
			<INPUT type="hidden" name="txtContentTab" id="txtContentTab" runat="server">
		</FORM>
		<SCRIPT language="javascript">
		
		var objtxtlogin=GetObjectReference('frm_Approvals','txtLogin')
		var objIsCookiesExist=GetObjectReference('frm_Approvals','txtIsCookiesExist')
		var objtxtPassword=GetObjectReference('frm_Approvals','txtPassword')
		var objtxtInvalidLogin=GetObjectReference('frm_Approvals','txtInvalidLogin')
		var objform=GetFormReference('frm_Approvals');
		var objfield = document.getElementById("fieldset1");
		var objDivMain=GetObjectReference('frm_Approvals','PageDiv');
		var objContentTab=GetObjectReference('frm_Approvals','txtContentTab');

		function ContentTab(TabName)
		{
			objContentTab.value = TabName;
			objform.action = "Approvals.aspx";
			objform.submit();
		
		
		}
		function Logout(strLogoutPage)
		{
			window.open(strLogoutPage,"_top")
			
		}
		function login()
		{	
		
			if(IsEmpty(objtxtlogin,"Please enter your Login ID !!!"))
			{
				objtxtlogin.focus();
				return;
			}
			if(IsEmpty(objtxtPassword,"Please enter your Password !!!"))
			{
				objtxtPassword.focus();
				return;
			}
			
			objform.action = "Approvals.aspx?FromWhere=Login"
			objform.submit();
			
			
		}
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			objdivlist.style.height = intDivHeight;	}
		}	
		function Password_OnKeyPress(e)
		{	var code;
			if (e.keyCode) code = e.keyCode;
			else if (e.which) code = e.which;
			if(code==13) 
				login();
					
			
		}
		function window_onload()
		{
			
			var intDivHeight ;
			var intDivHeightRisk;
			var intCnt;
			document.body.style.visibility='visible';
			
			/*if (objDivLeave!=null
				objDivLeave.style.visibility='visible';
			if (objDivProject!=null
				objDivProject.style.visibility='visible';*/
				
			if(objDivMain != null)
			{
				if (navigator.appName=="Netscape") 
				 {
					intDivHeight = window.innerHeight -  objDivMain.offsetTop - 42;
				 }
				else
				{
					intDivHeight = document.body.offsetHeight - objDivMain.offsetTop - 22;
				}
			 
				if (intDivHeight < 100)
					intDivHeight = 100;
				objDivMain.style.height = intDivHeight;
				
				
			}
			if (objIsCookiesExist!=null)
			{
				if(document.cookie !="")
					objIsCookiesExist.value = document.cookie;
				else
					objIsCookiesExist.value ="NotExist"
							
			}
			if(objtxtInvalidLogin!=null)
			{
				if (objtxtInvalidLogin.value!="")
				{
						switch(objtxtInvalidLogin.value)
						{
							case "SPAInvalidLogin": 
								alert("Login has not been created for you , Please contact Administrator.");
								break    
							case "LDAPInvalidLogin":
								alert("LDAP Authentication failed , Please contact the System Administrator.");
								break 
							case "SessionExpired":
								alert("Session has been expired , Please login again.");
								break 
							case "InvalidDomain":
								alert("Invalid Domain , Please contact the System Administrator.");
								break 
						}
						if (objtxtlogin != null)	
						{
							if (objtxtlogin.value == "")
								objtxtlogin.focus();
							else
								objtxtPassword.focus();
						}
						objtxtInvalidLogin.value = "";
						return;
					
				}
			
			}
			if (objtxtlogin != null)	
			{
				if (objtxtlogin.value == "")
					objtxtlogin.focus();
				else
					objtxtPassword.focus();
			}
			
			// FOR LEAVE APPROVALS
			var objCheckboxLShow = GetObjectReference('frm_Approvals','chkLeaveShow',true);			
			// FOR IR APPROVALS
			//var objCheckboxIRShow = GetObjectReference('frm_Approvals','chkIRShow',true);
			// FOR EXPENSE APPROVALS
			//var objCheckboxEShow = GetObjectReference('frm_Approvals','chkExpenseShow',true);
			// FOR PROJECT APPROVALS
			//var objCheckboxPShow = GetObjectReference('frm_Approvals','chkProjectShow',true);
			// FOR PROJECT TIMESHEET APPROVALS
			//var objCheckboxPTShow = GetObjectReference('frm_Approvals','chkProjectTimeSheetShow',true);
			// FOR RESOURCE TIMESHEET APPROVALS
			var objCheckboxRTShow = GetObjectReference('frm_Approvals','chkResourceTimeSheetShow',true);
			
			if ( objCheckboxLShow != null)
				OnLoadSettings(objCheckboxLShow)
			//if ( objCheckboxIRShow != null)
				//OnLoadSettings(objCheckboxIRShow)
			//if ( objCheckboxEShow != null)
				//OnLoadSettings(objCheckboxEShow)
			//if ( objCheckboxPShow != null)
				//OnLoadSettings(objCheckboxPShow)
			//if ( objCheckboxPTShow != null)
				//OnLoadSettings(objCheckboxPTShow)
			if ( objCheckboxRTShow != null)
				OnLoadSettings(objCheckboxRTShow)
			
			window.location.href.refresh;					
			
		 }
		 function OnLoadSettings(objCheckboxShow)
		 {
		 
				for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
					GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).disabled=true;
					 
		 }
		 
		function Close_OnClick()
		{
			window.close();
		}
		
		function DisplayComment(intGridNo,evt,UniqueID)
		{	
			var url;
			var objTblpopup;
			evt = evt || window.event;
			var source=evt.target||evt.srcElement;
			var mouseXY;
			var objDivpopup;
			var intUniqueID ;
			var objComment;
			
			mouseXY=mouseCoords(evt);
			intUniqueID = UniqueID;
			loadComment(intUniqueID,intGridNo);				
			objDivpopup = document.getElementById("divTbl");
			objTblpopup = document.getElementById("tbl_popup");
						
			objDivpopup.style.position = 'absolute';
			objDivpopup.style.left = mouseXY.x- 391;
			objDivpopup.style.top  = 150;
			objDivpopup.style.width  = '600px';
			objDivpopup.style.height  = '130px';
			objDivpopup.style.display  = '';
						var objT = GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID);
			objT.focus();
			objT.select();
			
			var objCheckboxShow = GetCheckboxShowObject(intGridNo);
			 if (objCheckboxShow!=null)
			 {					
				for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
				{
					if (objCheckboxShow[intCnt].checked == true)
					{
						if (intUniqueID==objCheckboxShow[intCnt].value)
						{
							GetObjectReference('frm_Approvals','img_'+intUniqueID).width = "30";
							GetObjectReference('frm_Approvals','img_'+intUniqueID).height = "25";	
						}
						else
						{
							if(Right(GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).src,14)== 'Imeges/SPA/Details.gif')
							{
								GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).width = "17";
								GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).height = "19";	
							}
							else
							{
								GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).width = "22";
								GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).height = "17";	
							}
						}
					}			
				}
			}	
		}
		function GetCheckboxShowObject(intGridNo)
		{
			var objCheckboxShow
			switch(intGridNo)
			{
				case 1: // FOR LEAVE APPROVALS
					objCheckboxShow  = GetObjectReference('frm_Approvals','chkLeaveShow',true);
					break    
				//case 2: // FOR IR APPROVALS
					//objCheckboxShow  = GetObjectReference('frm_Approvals','chkIRShow',true);
					//break
				//case 3: // FOR EXPENSE APPROVALS
					//objCheckboxShow  = GetObjectReference('frm_Approvals','chkExpenseShow',true);
					//break
				//case 4: // FOR PROJECT APPROVALS
					//objCheckboxShow  = GetObjectReference('frm_Approvals','chkProjectShow',true);
					//break
				//case 5: // FOR PROJECT TIMESHEET APPROVALS
					//objCheckboxShow  = GetObjectReference('frm_Approvals','chkProjectTimeSheetShow',true);
					//break 
				case 6: // FOR RESOURCE TIMESHEET APPROVALS
					objCheckboxShow  = GetObjectReference('frm_Approvals','chkResourceTimeSheetShow',true);
					break
						
			}
			
			return objCheckboxShow;
		}
		function loadComment(intUniqueID,intGridNo)
		{
			var strElement;	
			var m_UniqueID="";
			var objid = GetObjectReference('frm_Approvals','txt_' + intUniqueID);
			
			if (objid == null) 
				m_UniqueID = ""
			else
				m_UniqueID = objid.value;
				
				strElement	=	'<b>Comment</b><br><textarea wrap=Hard  name="txtUniqueID'+ intUniqueID + '" id="txtUniqueID' + intUniqueID + '" maxlength=1000 class=clsTextArea style="width:325px; height:70px; text-align:Left"; rows=5; cols =20>'+ m_UniqueID + '</textarea>';
				strElement	+= '<br><span style="text-align:center"><input type=button id=btnOK name=btnOK Value = "  OK   " style ="font size=9 width=10pts" onClick = getComment_Onclick("' + intUniqueID + '",' + intGridNo + ')>';
				strElement	+= '<input type=button id= btnCancel name= btnCancel style ="font size=9" Value = CANCEL onClick = cancel_OnClick("' + intUniqueID + '",' + intGridNo + ')> </span>';
				objfield.innerHTML = strElement;	
				GetObjectReference('frm_Approvals','img_'+intUniqueID).width = "30";
				GetObjectReference('frm_Approvals','img_'+intUniqueID).height = "25";
				
						
		}
		function cancel_OnClick(intUniqueID,intGridNo)
		{
			var objDivpopup = document.getElementById("divTbl");
			if(GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID).value.length > 1000)
			{ 
				GetObjectReference('frm_Approvals','txt_'+intUniqueID).value = ""
			}
			if (disallowBlank(GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID),'',true))
			{ GetObjectReference('frm_Approvals','txt_'+intUniqueID).value = ""
			}
			if (GetObjectReference('frm_Approvals','txt_'+intUniqueID).value == "")
			{ 
				GetObjectReference('frm_Approvals','img_'+intUniqueID).src = 'Images/SPA/Details.gif'
			}
			objDivpopup.style.display="none"; 	
			
						
			var objCheckboxShow = GetCheckboxShowObject(intGridNo);	
			if (objCheckboxShow!=null)
			{		
				for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
				{
					if(Right(GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).src,14)== 'Imeges/SPA/Details.gif')
					{
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).width = "17";
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).height = "19";	
					}
					else
					{
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).width = "22";
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).height = "17";	
					}
				}
			}
		}
		function mouseCoords(ev)
		{
			if(ev.pageX || ev.pageY){
			return {x:ev.pageX, y:ev.pageY};
			}
			return {
				x:ev.clientX + document.body.scrollLeft - document.body.clientLeft,
				y:ev.clientY + document.body.scrollTop  - document.body.clientTop - 40
			};
		}
		function getComment_Onclick(intUniqueID,intGridNo)
		{		
			var strElement;	
			var chkcomment;
			var intCnt;
			var objDivpopup = document.getElementById("divTbl");
			objid = GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID);
			GetObjectReference('frm_Approvals','txt_'+intUniqueID).value = objid.value;

			if(GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID).value.length > 1000)
			{
				alert("Comment should not be more than 1000 characters.");
				GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID).focus();			
				return; 
			}
			
			if (disallowBlank(GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID),'&#39;Comment&#39; should not be left blank.',true) )
			{ 
				GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID).value= "";
				GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID).focus();
				GetObjectReference('frm_Approvals','txtUniqueID'+intUniqueID).select();
				return; 
			}
			
			objDivpopup.style.display="none";		
			GetObjectReference('frm_Approvals','img_'+intUniqueID).src = 'Images/SPA/page.gif';														
			GetObjectReference('frm_Approvals','img_'+intUniqueID).width = "22";
			GetObjectReference('frm_Approvals','img_'+intUniqueID).height = "17";	
					
		}
		function chkShow_OnClick(intUniqueID,intGridNo)
		{		
		
			var objCheckboxShow = GetCheckboxShowObject(intGridNo);	
			if (objCheckboxShow!=null)
			{	
				for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
				{
					if (objCheckboxShow[intCnt].checked == true)
					{
							GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).disabled=false;
					}
					else
					{
						GetObjectReference('frm_Approvals','txt_'+objCheckboxShow[intCnt].value).value = "";
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).src = 'Images/SPA/Details.gif';
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).disabled=true;
					}			
				}
			}
		}
		var noOfPages ;
		var objtxtpageNumber;
		function validateNumPaging(intGridNo)
		{
			noOfPages = GetObjectReference('frm_Approvals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_Approvals','txtPageNumber'+intGridNo);
						
			if(isNaN(objtxtpageNumber.value))
			{
				alert("Please enter numeric value");
				return false;
			}
			
			if(parseInt(noOfPages)<parseInt(objtxtpageNumber.value))
			{
				alert("Please enter value within range of 1 to "+noOfPages);
				return false;
			}
			return true;
		}			
		function ShowPreviousPage(intGridNo)
		{	
		
			noOfPages = GetObjectReference('frm_Approvals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_Approvals','txtPageNumber'+intGridNo);
							
			if (isBlank(objtxtpageNumber.value))
				NumPage_OnClick(1,intGridNo);
			else
			{
				if(!validateNumPaging(intGridNo))
				return;
				
				if (objtxtpageNumber.value==1){alert("This is the first page");return;}
					objtxtpageNumber.value=objtxtpageNumber.value -1;
				NumPage_OnClick(objtxtpageNumber.value,intGridNo);
			}
		}
		function ShowFirstPage(intGridNo)
		{
			noOfPages = GetObjectReference('frm_Approvals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_Approvals','txtPageNumber'+intGridNo);
						
			if (isBlank(objtxtpageNumber.value))
				NumPage_OnClick(1,intGridNo);
			else
			{
				if(!validateNumPaging(intGridNo))
				return;
				if (objtxtpageNumber.value==1){alert("This is the first page");return;}
				objtxtpageNumber.value=1;
				NumPage_OnClick(objtxtpageNumber.value,intGridNo);
			}
			
			
		}
		function ShowNextPage(intGridNo)
		{	
			noOfPages = GetObjectReference('frm_Approvals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_Approvals','txtPageNumber'+intGridNo);
					
			if (isBlank(objtxtpageNumber.value))
				NumPage_OnClick(1,intGridNo);
			else
			{
				if(!validateNumPaging(intGridNo))
				return;
				if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
					objtxtpageNumber.value=parseInt(objtxtpageNumber.value)+1;
				NumPage_OnClick(objtxtpageNumber.value,intGridNo);
			}	
		}
		function ShowLastPage(intGridNo)
		{
			noOfPages = GetObjectReference('frm_Approvals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_Approvals','txtPageNumber'+intGridNo);
							
			if (isBlank(objtxtpageNumber.value))
				NumPage_OnClick(noOfPages,intGridNo);
			else
			{	
				if(!validateNumPaging(intGridNo))
				return;
				if (objtxtpageNumber.value==noOfPages){alert("This is the last page");return;}
				objtxtpageNumber.value=noOfPages;
				NumPage_OnClick(objtxtpageNumber.value,intGridNo);
			}
		}
		function NumPage_OnClick(page,intGridNo)
		{
			
			var LeavePage				= pagingSettings(page,intGridNo,1); // FOR LEAVE APPROVALS
			//var IRPage					= pagingSettings(page,intGridNo,2); // FOR IR APPROVALS
			//var ExpensePage				= pagingSettings(page,intGridNo,3); // FOR EXPENSE APPROVALS
			//var ProjectPage				= pagingSettings(page,intGridNo,4); // FOR PROJECT APPROVALS
			//var ProjectTimeSheetPage	= pagingSettings(page,intGridNo,5); // FOR PROJECT TIMESHEET APPROVALS
			var ResourceTimeSheetPage	= pagingSettings(page,intGridNo,6); // FOR RESOURCE TIMESHEET APPROVALS
			
			window.location.href.refresh;
			//objform.action = "Approvals.aspx?FromWhere=SM&MasterTagID=<%=m_lngTagID%>&LeavePageNumber="+ LeavePage + "&IRPageNumber="+ IRPage+ "&ExpensePageNumber="+ ExpensePage+ "&ProjectPageNumber="+ ProjectPage+"&ProjectTimeSheetPageNumber="+ ProjectTimeSheetPage+"&ResourceTimeSheetPageNumber="+ ResourceTimeSheetPage;
			objform.action = "Approvals.aspx?FromWhere=SM&MasterTagID=<%=m_lngTagID%>&LeavePageNumber="+ LeavePage +"&ResourceTimeSheetPageNumber="+ ResourceTimeSheetPage;
			objform.submit();
		}
		function pagingSettings(page,intGridNo,intCallForGrid)
		{
			var pageNumber = -2;
			if (GetObjectReference('frm_Approvals','txtPageNumber'+intCallForGrid)!=null)
			{	
				if(page ==  "-1" && intGridNo == intCallForGrid)
					pageNumber	= -1;
				else if (page == 1 && intGridNo == intCallForGrid)
					pageNumber	= 1;
				else
					pageNumber	=  GetObjectReference('frm_Approvals','txtPageNumber'+intCallForGrid).value;
				if(pageNumber=="")
					pageNumber	= -1;
			}
			return pageNumber;
		
		}
		function txtPageNumber_KeyPress(e,intGridNo)
		{
			var code;
			if (e.keyCode) 
				code = e.keyCode;
			else
				if (e.which) 
					code = e.which;
					
			if(code==13) 
			{
				objtxtpageNumber =  GetObjectReference('frm_Approvals','txtPageNumber'+intGridNo);
				objtxtNoOfPages = GetObjectReference('frm_Approvals','txtNoOfPages'+intGridNo);
				if (!disallowBlank(objtxtpageNumber,"<%=MyBase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
				{	
					if (Number(objtxtpageNumber.value) ==0)
					{
						alert("Page number should be greater than zero!");
						return;
					}
					if(Number(objtxtpageNumber.value) > Number(objtxtNoOfPages.value) ) 
					{
						alert("Please enter value less than or equal to " +objtxtNoOfPages.value);
						return;
					}
					NumPage_OnClick(objtxtpageNumber.value,intGridNo);
				}	
			}
		
		}
		function SelectAll_OnClick()
		{	
			SelectAllCheckboxs('frm_Approvals','chkLeaveShow');			   // FOR LEAVE APPROVALS
			//SelectAllCheckboxs('frm_Approvals','chkIRShow');				   // FOR IR APPROVALS
			//SelectAllCheckboxs('frm_Approvals','chkExpenseShow');		   // FOR EXPENSE APPROVALS
			//SelectAllCheckboxs('frm_Approvals','chkProjectShow');		   // FOR PROJECT APPROVALS
			//SelectAllCheckboxs('frm_Approvals','chkProjectTimeSheetShow');  // FOR PROJECT TIMESHEET APPROVALS
			SelectAllCheckboxs('frm_Approvals','chkResourceTimeSheetShow'); // FOR RESOURCE TIMESHEET APPROVALS
			// FOR LEAVE APPROVALS
			var objCheckboxLShow = GetObjectReference('frm_Approvals','chkLeaveShow',true);
			// FOR IR APPROVALS				
			//var objCheckboxIRShow = GetObjectReference('frm_Approvals','chkIRShow',true);
			// FOR EXPENSE APPROVALS				
			//var objCheckboxEShow = GetObjectReference('frm_Approvals','chkExpenseShow',true);	
			// FOR PEROJECT APPROVALS		
			//var objCheckboxPShow = GetObjectReference('frm_Approvals','chkProjectShow',true);		
			// FOR PROEJECT TIMESHEET APPROVALS	
			//var objCheckboxPTShow = GetObjectReference('frm_Approvals','chkProjectTimeSheetShow',true);	
			// FOR RESOURCE TIMESHEET APPROVALS
			var objCheckboxRTShow = GetObjectReference('frm_Approvals','chkResourceTimeSheetShow',true);	
			
			if (objCheckboxLShow!=null)
				SelectAllSettings(objCheckboxLShow)
			//if (objCheckboxIRShow!=null)
			//	SelectAllSettings(objCheckboxIRShow)
			//if (objCheckboxEShow!=null)
			//	SelectAllSettings(objCheckboxEShow)
			//if (objCheckboxPShow!=null)
			//	SelectAllSettings(objCheckboxPShow)
			//if (objCheckboxPTShow!=null)
			//	SelectAllSettings(objCheckboxPTShow)
			if (objCheckboxRTShow!=null)
				SelectAllSettings(objCheckboxRTShow)
			
		}
		function ClearAllOnClick()
		{
			ClearAll_OnClick('frm_Approvals','chkLeaveShow');			// FOR LEAVE APPROVALS
			//ClearAll_OnClick('frm_Approvals','chkIRShow');				// FOR IR APPROVALS
			//ClearAll_OnClick('frm_Approvals','chkExpenseShow');			// FOR EXPENSE APPROVALS
			//ClearAll_OnClick('frm_Approvals','chkProjectShow');			// FOR PROJECT APPROVALS
			//ClearAll_OnClick('frm_Approvals','chkProjectTimeSheetShow');	// FOR PROJECT TIMESHEET APPROVALS
			ClearAll_OnClick('frm_Approvals','chkResourceTimeSheetShow');// FOR RESOURCE TIMESHEET APPROVALS
			
			// to disable the comment while unselecting all the checkboxes using "Clear All" link
			// FOR LEAVE APPROVALS
			var objCheckboxLShow = GetObjectReference('frm_Approvals','chkLeaveShow',true);
			// FOR IR APPROVALS				
			//var objCheckboxIRShow = GetObjectReference('frm_Approvals','chkIRShow',true);	
			// FOR EXPENSE APPROVALS			
			//var objCheckboxEShow = GetObjectReference('frm_Approvals','chkExpenseShow',true);
			// FOR PROJECT APPROVALS			
			//var objCheckboxPShow = GetObjectReference('frm_Approvals','chkProjectShow',true);			
			// FOR PROJECT TIMESHEET APPROVALS
			//var objCheckboxPTShow = GetObjectReference('frm_Approvals','chkProjectTimeSheetShow',true);	
			// FOR RESOURCE TIMESHEET APPROVALS
			var objCheckboxRTShow = GetObjectReference('frm_Approvals','chkResourceTimeSheetShow',true);	
			
			if (objCheckboxLShow!=null)
				ClearAllSettings(objCheckboxLShow);
			//if (objCheckboxIRShow!=null)
			//	ClearAllSettings(objCheckboxIRShow);
			//if (objCheckboxEShow!=null)
			//	ClearAllSettings(objCheckboxEShow);
			//if (objCheckboxPShow!=null)
			//	ClearAllSettings(objCheckboxPShow);
			//if (objCheckboxPTShow!=null)
			//	ClearAllSettings(objCheckboxPTShow);
			if (objCheckboxRTShow!=null)
				ClearAllSettings(objCheckboxRTShow);
			
		}
		function SelectAllSettings(objCheckboxShow)
		{
			
			for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
			{
				if (objCheckboxShow[intCnt].checked == true)
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).disabled=false;		
			}
		}
		function ClearAllSettings(objCheckboxShow)
		{
		
			for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
			{
				GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).src = 'Images/SPA/Details.gif';
				GetObjectReference('frm_Approvals','txt_'+objCheckboxShow[intCnt].value).value = "";
				GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).disabled=true;		
				GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).width = "17";
				GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).height = "19";
			}
		
		}
		var isCheckedAtLeastOne = false;
		function Approve_OnClick()
		{
			
			isCheckedAtLeastOne = false;
			// FOR LEAVE APPROVALS
			var objCheckLboxShow	= GetObjectReference('frm_Approvals','chkLeaveShow', true);	
			// FOR IR APPROVALS			
			//var objCheckIRboxShow	= GetObjectReference('frm_Approvals','chkIRShow', true);	
			// FOR EXPENSE APPROVALS				
			//var objCheckEboxShow	= GetObjectReference('frm_Approvals','chkExpenseShow', true);
			// FOR PROJECT APPROVALS			
			//var objCheckPboxShow	= GetObjectReference('frm_Approvals','chkProjectShow', true);		
			// FOR PROJECT TIMSHEET APPROVALS	
			//var objCheckPTboxShow	= GetObjectReference('frm_Approvals','chkProjectTimeSheetShow', true);	
			// FOR RESOURCE TIMESHEET APPROVALS
			var objCheckRTboxShow	= GetObjectReference('frm_Approvals','chkResourceTimeSheetShow', true);	
			
			
			if (objCheckLboxShow != null){	// FOR LEAVE APPROVALS
				if (validateSelectedCheckBox(objCheckLboxShow)==false)
					return;}
			//if (objCheckIRboxShow != null)	// FOR IR APPROVALS		
				//if (validateSelectedCheckBox(objCheckIRboxShow)==false)
					//return;
			//if (objCheckEboxShow != null)	// FOR EXPENSE APPROVALS
				//if (validateSelectedCheckBox(objCheckEboxShow)==false)
					//return;
			//if (objCheckPboxShow != null)	// FOR PROJECT APPROVALS
				//if (validateSelectedCheckBox(objCheckPboxShow)==false)
					//return;
			//if (objCheckPTboxShow != null)	// FOR PROJECT TIMSHEET APPROVALS
				//if (validateSelectedCheckBox(objCheckPTboxShow)==false)
					//return;
			if (objCheckRTboxShow != null){	// FOR RESOURCE TIMESHEET APPROVALS
				if (validateSelectedCheckBox(objCheckRTboxShow)==false)
					return;}
			if ( isCheckedAtLeastOne == false)
			{
				alert("Please select at least one checkbox to approve");
				return;
			}
			else
			{			
				window.location.href.refresh;
				//objform.action = "Approvals.aspx?MasterTagID=<%=m_lngTagID%>&LeavePageNumber=<%=m_intLeavePageNumber%>&IRPageNumber=<%=m_intIRPageNumber%>&ExpensePageNumber=<%=m_intExpensePageNumber%>&ProjectPageNumber=<%=m_intProjectPageNumber%>&ProjectTimeSheetPageNumber=<%=m_intProjectTimeSheetPageNumber%>&ResourceTimeSheetPageNumber=<%=m_intResourceTimeSheetPageNumber%>&MODE=Approved";
				  objform.action = "Approvals.aspx?MasterTagID=<%=m_lngTagID%>&LeavePageNumber=<%=m_intLeavePageNumber%>&ResourceTimeSheetPageNumber=<%=m_intResourceTimeSheetPageNumber%>&MODE=Approved";
				objform.submit();
			}
		
		}
		function validateSelectedCheckBox(objCheckboxShow)
		{
			var intUniqueID;
			var strTitle;
			
			for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
			{
				if (objCheckboxShow[intCnt].checked == false)
					continue;
				else
				{
					isCheckedAtLeastOne = true;
					intUniqueID = objCheckboxShow[intCnt].value;
					strTitle = GetObjectReference('frm_Approvals','Title_'+intUniqueID).value;
					
					if (GetObjectReference('frm_Approvals','txt_'+intUniqueID).value == "")
					{
						alert("Comment should not be left blank to '"+strTitle+"'.");
						GetObjectReference('frm_Approvals','img_'+intUniqueID).src = 'Images/SPA/Details.gif';								
						GetObjectReference('frm_Approvals','img_'+objCheckboxShow[intCnt].value).disabled=false;
						return false;	
					} 
					else if(GetObjectReference('frm_Approvals','txt_'+intUniqueID).value.length > 1000)
					{
						alert("Comment should not be more than 1000 characters for '"+strTitle+"' Initiative.");
						return false;
					}
					
				}
			}
			if (isCheckedAtLeastOne == false)
				return true;
		
		}
		
		</SCRIPT>
	</BODY>
</HTML>
