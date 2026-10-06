<!--Added by Nilesh gundecha on 18/9/2015 for Responsive common Page-->
<%-- Commented by Madhuri.K On 13-Aug-2024 for JQuery and Bootstrap version upgrade--%>
<%--<%  CommonFunctions.General.PlotPageHeadTag("")%> --%>
<%--<script src="../../Whizible2.0-new/plugins/jQuery/jquery-3.6.1.min.js" type="text/javascript"></script>--%>
<script type="text/javascript" src="responsive/responsive.js"></script>

<style>
    .clsTable .clsTRMenu td:first-child
    {
        /*width: 35%;*/
        vertical-align: middle;
    }

</style>

<script type="text/javascript">
    $(document).ready(function () {
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

<%@ Page Language="vb" EnableViewState="false" AutoEventWireup="false" Codebehind="ShowPendingApprovals.aspx.vb" Inherits="PbNIT.ShowPendingApprovals" %>
<HTML>

	<%CommonFunctions.General.PlotPageHeadTag("Show Pending Approvals")%>
	<BODY MS_POSITIONING="FlowLayout" class="clsBody" onload="window_onload()" onresize="window_onresize()">
		<FORM id="frm_ShowPendingApprovals" method="post" runat="server">
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
								<TD><A class="SetAsDefault" href='ShowPendingApprovals.aspx' style='TEXT-DECORATION:none'><FONT size="2" face="verdana"><B>Login</B></FONT></A></TD>
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
		</FORM>
		<SCRIPT language="javascript">
		
		var objtxtlogin=GetObjectReference('frm_ShowPendingApprovals','txtLogin')
		var objIsCookiesExist=GetObjectReference('frm_ShowPendingApprovals','txtIsCookiesExist')
		var objtxtPassword=GetObjectReference('frm_ShowPendingApprovals','txtPassword')
		var objtxtInvalidLogin=GetObjectReference('frm_ShowPendingApprovals','txtInvalidLogin')
		var objform=GetFormReference('frm_ShowPendingApprovals');
		var objfield = document.getElementById("fieldset1");
		var objDivMain=GetObjectReference('frm_ShowPendingApprovals','PageDiv');
		
		    <%' Added By SonalD on 13th Jan 2009 %>
            <%If CommonFunctions.General.GetApplicationKeySetting("Environment") = "P" Then %>
                disableRightClick();
            <%End If%>
            <%' Added By SonalD on 13th Jan 2009 %>
		
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
			
			objform.action = "ShowPendingApprovals.aspx?FromWhere=Login"
			objform.submit();
			
			
		}
		function window_onresize()		
		{
			var intDivHeight;
			var intDivHeightRisk;
			if (objdivlist !=null) {
			intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - 40;
			if (intDivHeight < 100)	intDivHeight = 100;
			    //Comment added on 11 Dec 2015 by Viraj P
			    //objdivlist.style.height = intDivHeight;	
			objdivlist.style.height = intDivHeight + 'px';
        }
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
			    //Comment added on 11 Dec 2015 by Viraj P
			    //objDivMain.style.height = intDivHeight;
				objDivMain.style.height = intDivHeight + 'px';
				
				
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
							objtxtlogin.focus();
						}
						objtxtInvalidLogin.value = "";
						return;
					
				}
			
			}
			if (objtxtlogin != null)	
			{
				objtxtlogin.focus();
			}
			
			// FOR LEAVE APPROVALS
			var objCheckboxLShow = GetObjectReference('frm_ShowPendingApprovals','chkLeaveShow',true);			
			// FOR IR APPROVALS
			var objCheckboxIRShow = GetObjectReference('frm_ShowPendingApprovals','chkIRShow',true);
			// FOR EXPENSE APPROVALS
			var objCheckboxEShow = GetObjectReference('frm_ShowPendingApprovals','chkExpenseShow',true);
			// FOR PROJECT APPROVALS
			var objCheckboxPShow = GetObjectReference('frm_ShowPendingApprovals','chkProjectShow',true);
			// FOR PROJECT TIMESHEET APPROVALS
			var objCheckboxPTShow = GetObjectReference('frm_ShowPendingApprovals','chkProjectTimeSheetShow',true);
			// FOR RESOURCE TIMESHEET APPROVALS
			var objCheckboxRTShow = GetObjectReference('frm_ShowPendingApprovals','chkResourceTimeSheetShow',true);
			
			if ( objCheckboxLShow != null)
				OnLoadSettings(objCheckboxLShow)
			if ( objCheckboxIRShow != null)
				OnLoadSettings(objCheckboxIRShow)
			if ( objCheckboxEShow != null)
				OnLoadSettings(objCheckboxEShow)
			if ( objCheckboxPShow != null)
				OnLoadSettings(objCheckboxPShow)
			if ( objCheckboxPTShow != null)
				OnLoadSettings(objCheckboxPTShow)
			if ( objCheckboxRTShow != null)
				OnLoadSettings(objCheckboxRTShow)
			
			window.location.href.refresh;					
			
		 }
		 function OnLoadSettings(objCheckboxShow)
		 {
		 
				for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
					GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).disabled=true;
					 
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
						var objT = GetObjectReference('frm_ShowPendingApprovals','txtUniqueID'+intUniqueID);
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
							GetObjectReference('frm_ShowPendingApprovals','img_'+intUniqueID).width = "30";
							GetObjectReference('frm_ShowPendingApprovals','img_'+intUniqueID).height = "25";	
						}
						else
						{
							if(Right(GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).src,14)== 'SPA/Details.gif')
							{
								GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).width = "17";
								GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).height = "19";	
							}
							else
							{
								GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).width = "22";
								GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).height = "17";	
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
					objCheckboxShow  = GetObjectReference('frm_ShowPendingApprovals','chkLeaveShow',true);
					break    
				case 2: // FOR IR APPROVALS
					objCheckboxShow  = GetObjectReference('frm_ShowPendingApprovals','chkIRShow',true);
					break
				case 3: // FOR EXPENSE APPROVALS
					objCheckboxShow  = GetObjectReference('frm_ShowPendingApprovals','chkExpenseShow',true);
					break
				case 4: // FOR PROJECT APPROVALS
					objCheckboxShow  = GetObjectReference('frm_ShowPendingApprovals','chkProjectShow',true);
					break
				case 5: // FOR PROJECT TIMESHEET APPROVALS
					objCheckboxShow  = GetObjectReference('frm_ShowPendingApprovals','chkProjectTimeSheetShow',true);
					break 
				case 6: // FOR RESOURCE TIMESHEET APPROVALS
					objCheckboxShow  = GetObjectReference('frm_ShowPendingApprovals','chkResourceTimeSheetShow',true);
					break
						
			}
			
			return objCheckboxShow;
		}
		function loadComment(intUniqueID,intGridNo)
		{
			var strElement;	
			var m_UniqueID="";
			var objid = GetObjectReference('frm_ShowPendingApprovals','txt_' + intUniqueID);
			
			if (objid == null) 
				m_UniqueID = ""
			else
				m_UniqueID = objid.value;
				
				strElement	=	'<b>Comment</b><br><Textarea wrap=Hard  name=txtUniqueID'+ intUniqueID + ' id=txtUniqueID' + intUniqueID + 'maxlength=1000 class=clsTextArea style="width:325px; height:70px; text-align:Left"; rows=5; cols =20>'+ m_UniqueID + '</Textarea>';
				strElement	+= '<input type=button id= btnOK name= btnOK Value = "   OK   " style ="font size=9 width=10pts" onClick = getComment_Onclick(' + intUniqueID + ',' + intGridNo + ')>';
				strElement	+= '<input type=button id= btnCancel name= btnCancel style ="font size=9" Value = CANCEL onClick = cancel_OnClick(' + intUniqueID + ',' + intGridNo + ')>';
				objfield.innerHTML = strElement;	
				GetObjectReference('frm_ShowPendingApprovals','img_'+intUniqueID).width = "30";
				GetObjectReference('frm_ShowPendingApprovals','img_'+intUniqueID).height = "25";
				
						
		}
		function cancel_OnClick(intUniqueID,intGridNo)
		{
			var objDivpopup = document.getElementById("divTbl");
			if(GetObjectReference('frm_ShowPendingApprovals','txtUniqueID'+intUniqueID).innerText.length > 1000)
			{ 
				GetObjectReference('frm_ShowPendingApprovals','txt_'+intUniqueID).value = ""
			}
			if (disallowBlank(GetObjectReference('frm_ShowPendingApprovals','txtUniqueID'+intUniqueID),'',true))
			{ GetObjectReference('frm_ShowPendingApprovals','txt_'+intUniqueID).value = ""
			}
			if (GetObjectReference('frm_ShowPendingApprovals','txt_'+intUniqueID).value == "")
			{ 
				GetObjectReference('frm_ShowPendingApprovals','img_'+intUniqueID).src = '../../Images/SPA/Details.gif'
			}
			objDivpopup.style.display="none"; 	
			
						
			var objCheckboxShow = GetCheckboxShowObject(intGridNo);	
			if (objCheckboxShow!=null)
			{		
				for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
				{
					if(Right(GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).src,14)== 'SPA/Details.gif')
					{
						GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).width = "17";
						GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).height = "19";	
					}
					else
					{
						GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).width = "22";
						GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).height = "17";	
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
			
			objid = GetObjectReference('frm_ShowPendingApprovals','txtUniqueID'+intUniqueID);
			GetObjectReference('frm_ShowPendingApprovals','txt_'+intUniqueID).value = objid.value;

			if(GetObjectReference('frm_ShowPendingApprovals','txtUniqueID'+intUniqueID).innerText.length > 1000)
			{
				alert("Comment should not be more than 1000 characters.");
				GetObjectReference('frm_ShowPendingApprovals','txtUniqueID'+intUniqueID).focus();			
				return; 
			}
			
			if (disallowBlank(GetObjectReference('frm_ShowPendingApprovals','txtUniqueID'+intUniqueID),'&#39;Comment&#39; should not be left blank.',true) )
			{ 
				GetObjectReference('frm_ShowPendingApprovals','txtUniqueID'+intUniqueID).value= "";
				GetObjectReference('frm_ShowPendingApprovals','txtUniqueID'+intUniqueID).focus();
				GetObjectReference('frm_ShowPendingApprovals','txtUniqueID'+intUniqueID).select();
				return; 
			}
			
			objDivpopup.style.display="none";		
			GetObjectReference('frm_ShowPendingApprovals','img_'+intUniqueID).src = '../../Images/SPA/page.gif';														
			GetObjectReference('frm_ShowPendingApprovals','img_'+intUniqueID).width = "22";
			GetObjectReference('frm_ShowPendingApprovals','img_'+intUniqueID).height = "17";	
					
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
							GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).disabled=false;
					}
					else
					{
						GetObjectReference('frm_ShowPendingApprovals','txt_'+objCheckboxShow[intCnt].value).value = "";
						GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).src = '../../Images/SPA/Details.gif';
						GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).disabled=true;
					}			
				}
			}
		}
		var noOfPages ;
		var objtxtpageNumber;
		function validateNumPaging(intGridNo)
		{
			noOfPages = GetObjectReference('frm_ShowPendingApprovals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_ShowPendingApprovals','txtPageNumber'+intGridNo);
						
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
		
			noOfPages = GetObjectReference('frm_ShowPendingApprovals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_ShowPendingApprovals','txtPageNumber'+intGridNo);
							
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
			noOfPages = GetObjectReference('frm_ShowPendingApprovals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_ShowPendingApprovals','txtPageNumber'+intGridNo);
						
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
			noOfPages = GetObjectReference('frm_ShowPendingApprovals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_ShowPendingApprovals','txtPageNumber'+intGridNo);
					
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
			noOfPages = GetObjectReference('frm_ShowPendingApprovals','hidNoOfPages'+intGridNo).value; 
			objtxtpageNumber = GetObjectReference('frm_ShowPendingApprovals','txtPageNumber'+intGridNo);
							
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
			var IRPage					= pagingSettings(page,intGridNo,2); // FOR IR APPROVALS
			var ExpensePage				= pagingSettings(page,intGridNo,3); // FOR EXPENSE APPROVALS
			var ProjectPage				= pagingSettings(page,intGridNo,4); // FOR PROJECT APPROVALS
			var ProjectTimeSheetPage	= pagingSettings(page,intGridNo,5); // FOR PROJECT TIMESHEET APPROVALS
			var ResourceTimeSheetPage	= pagingSettings(page,intGridNo,6); // FOR RESOURCE TIMESHEET APPROVALS
			
			window.location.href.refresh;
			objform.action = "ShowPendingApprovals.aspx?FromWhere=SM&MasterTagID=<%=m_lngTagID%>&LeavePageNumber="+ LeavePage + "&IRPageNumber="+ IRPage+ "&ExpensePageNumber="+ ExpensePage+ "&ProjectPageNumber="+ ProjectPage+"&ProjectTimeSheetPageNumber="+ ProjectTimeSheetPage+"&ResourceTimeSheetPageNumber="+ ResourceTimeSheetPage;
			objform.submit();
		}
		function pagingSettings(page,intGridNo,intCallForGrid)
		{
			var pageNumber = -2;
			if (GetObjectReference('frm_ShowPendingApprovals','txtPageNumber'+intCallForGrid)!=null)
			{	
				if(page ==  "-1" && intGridNo == intCallForGrid)
					pageNumber	= -1;
				else if (page == 1 && intGridNo == intCallForGrid)
					pageNumber	= 1;
				else
					pageNumber	=  GetObjectReference('frm_ShowPendingApprovals','txtPageNumber'+intCallForGrid).value;
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
				objtxtpageNumber =  GetObjectReference('frm_ShowPendingApprovals','txtPageNumber'+intGridNo);
				objtxtNoOfPages = GetObjectReference('frm_ShowPendingApprovals','txtNoOfPages'+intGridNo);
				if (!disallowBlank(objtxtpageNumber,"<%=mybase.GetResourceString("ENTERPAGENO")%>",true) && (!disallowNonNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("NUMERICPAGENO")%>",true)) && (!disallowNegativeNumeric(objtxtpageNumber,"<%=mybase.GetResourceString("POSITIVEPAGENO")%>",true)) & (!disallowNonInteger(objtxtpageNumber,"<%=mybase.GetResourceString("INTEGER_PAGENO")%>",true)))				
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
			SelectAllCheckboxs('frm_ShowPendingApprovals','chkLeaveShow');			   // FOR LEAVE APPROVALS
			SelectAllCheckboxs('frm_ShowPendingApprovals','chkIRShow');				   // FOR IR APPROVALS
			SelectAllCheckboxs('frm_ShowPendingApprovals','chkExpenseShow');		   // FOR EXPENSE APPROVALS
			SelectAllCheckboxs('frm_ShowPendingApprovals','chkProjectShow');		   // FOR PROJECT APPROVALS
			SelectAllCheckboxs('frm_ShowPendingApprovals','chkProjectTimeSheetShow');  // FOR PROJECT TIMESHEET APPROVALS
			SelectAllCheckboxs('frm_ShowPendingApprovals','chkResourceTimeSheetShow'); // FOR RESOURCE TIMESHEET APPROVALS
			// FOR LEAVE APPROVALS
			var objCheckboxLShow = GetObjectReference('frm_ShowPendingApprovals','chkLeaveShow',true);
			// FOR IR APPROVALS				
			var objCheckboxIRShow = GetObjectReference('frm_ShowPendingApprovals','chkIRShow',true);
			// FOR EXPENSE APPROVALS				
			var objCheckboxEShow = GetObjectReference('frm_ShowPendingApprovals','chkExpenseShow',true);	
			// FOR PEROJECT APPROVALS		
			var objCheckboxPShow = GetObjectReference('frm_ShowPendingApprovals','chkProjectShow',true);		
			// FOR PROEJECT TIMESHEET APPROVALS	
			var objCheckboxPTShow = GetObjectReference('frm_ShowPendingApprovals','chkProjectTimeSheetShow',true);	
			// FOR RESOURCE TIMESHEET APPROVALS
			var objCheckboxRTShow = GetObjectReference('frm_ShowPendingApprovals','chkResourceTimeSheetShow',true);	
			
			if (objCheckboxLShow!=null)
				SelectAllSettings(objCheckboxLShow)
			if (objCheckboxIRShow!=null)
				SelectAllSettings(objCheckboxIRShow)
			if (objCheckboxEShow!=null)
				SelectAllSettings(objCheckboxEShow)
			if (objCheckboxPShow!=null)
				SelectAllSettings(objCheckboxPShow)
			if (objCheckboxPTShow!=null)
				SelectAllSettings(objCheckboxPTShow)
			if (objCheckboxRTShow!=null)
				SelectAllSettings(objCheckboxRTShow)
			
		}
		function ClearAllOnClick()
		{
			ClearAll_OnClick('frm_ShowPendingApprovals','chkLeaveShow');			// FOR LEAVE APPROVALS
			ClearAll_OnClick('frm_ShowPendingApprovals','chkIRShow');				// FOR IR APPROVALS
			ClearAll_OnClick('frm_ShowPendingApprovals','chkExpenseShow');			// FOR EXPENSE APPROVALS
			ClearAll_OnClick('frm_ShowPendingApprovals','chkProjectShow');			// FOR PROJECT APPROVALS
			ClearAll_OnClick('frm_ShowPendingApprovals','chkProjectTimeSheetShow');	// FOR PROJECT TIMESHEET APPROVALS
			ClearAll_OnClick('frm_ShowPendingApprovals','chkResourceTimeSheetShow');// FOR RESOURCE TIMESHEET APPROVALS
			
			// to disable the comment while unselecting all the checkboxes using "Clear All" link
			// FOR LEAVE APPROVALS
			var objCheckboxLShow = GetObjectReference('frm_ShowPendingApprovals','chkLeaveShow',true);
			// FOR IR APPROVALS				
			var objCheckboxIRShow = GetObjectReference('frm_ShowPendingApprovals','chkIRShow',true);	
			// FOR EXPENSE APPROVALS			
			var objCheckboxEShow = GetObjectReference('frm_ShowPendingApprovals','chkExpenseShow',true);
			// FOR PROJECT APPROVALS			
			var objCheckboxPShow = GetObjectReference('frm_ShowPendingApprovals','chkProjectShow',true);			
			// FOR PROJECT TIMESHEET APPROVALS
			var objCheckboxPTShow = GetObjectReference('frm_ShowPendingApprovals','chkProjectTimeSheetShow',true);	
			// FOR RESOURCE TIMESHEET APPROVALS
			var objCheckboxRTShow = GetObjectReference('frm_ShowPendingApprovals','chkResourceTimeSheetShow',true);	
			
			if (objCheckboxLShow!=null)
				ClearAllSettings(objCheckboxLShow);
			if (objCheckboxIRShow!=null)
				ClearAllSettings(objCheckboxIRShow);
			if (objCheckboxEShow!=null)
				ClearAllSettings(objCheckboxEShow);
			if (objCheckboxPShow!=null)
				ClearAllSettings(objCheckboxPShow);
			if (objCheckboxPTShow!=null)
				ClearAllSettings(objCheckboxPTShow);
			if (objCheckboxRTShow!=null)
				ClearAllSettings(objCheckboxRTShow);
			
		}
		function SelectAllSettings(objCheckboxShow)
		{
			
			for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
			{
				if (objCheckboxShow[intCnt].checked == true)
						GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).disabled=false;		
			}
		}
		function ClearAllSettings(objCheckboxShow)
		{
		
			for(intCnt=0; intCnt < objCheckboxShow.length; intCnt++)
			{
				GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).src = '../../Images/SPA/Details.gif';
				GetObjectReference('frm_ShowPendingApprovals','txt_'+objCheckboxShow[intCnt].value).value = "";
				GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).disabled=true;		
				GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).width = "17";
				GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).height = "19";
			}
		
		}
		var isCheckedAtLeastOne = false;
		function Approve_OnClick()
		{
			
			isCheckedAtLeastOne = false;
			// FOR LEAVE APPROVALS
			var objCheckLboxShow	= GetObjectReference('frm_ShowPendingApprovals','chkLeaveShow', true);	
			// FOR IR APPROVALS			
			var objCheckIRboxShow	= GetObjectReference('frm_ShowPendingApprovals','chkIRShow', true);	
			// FOR EXPENSE APPROVALS				
			var objCheckEboxShow	= GetObjectReference('frm_ShowPendingApprovals','chkExpenseShow', true);
			// FOR PROJECT APPROVALS			
			var objCheckPboxShow	= GetObjectReference('frm_ShowPendingApprovals','chkProjectShow', true);		
			// FOR PROJECT TIMSHEET APPROVALS	
			var objCheckPTboxShow	= GetObjectReference('frm_ShowPendingApprovals','chkProjectTimeSheetShow', true);	
			// FOR RESOURCE TIMESHEET APPROVALS
			var objCheckRTboxShow	= GetObjectReference('frm_ShowPendingApprovals','chkResourceTimeSheetShow', true);	
			
			
			if (objCheckLboxShow != null)	// FOR LEAVE APPROVALS
				if (validateSelectedCheckBox(objCheckLboxShow)==false)
					return;
			if (objCheckIRboxShow != null)	// FOR IR APPROVALS		
				if (validateSelectedCheckBox(objCheckIRboxShow)==false)
					return;
			if (objCheckEboxShow != null)	// FOR EXPENSE APPROVALS
				if (validateSelectedCheckBox(objCheckEboxShow)==false)
					return;
			if (objCheckPboxShow != null)	// FOR PROJECT APPROVALS
				if (validateSelectedCheckBox(objCheckPboxShow)==false)
					return;
			if (objCheckPTboxShow != null)	// FOR PROJECT TIMSHEET APPROVALS
				if (validateSelectedCheckBox(objCheckPTboxShow)==false)
					return;
			if (objCheckRTboxShow != null)	// FOR RESOURCE TIMESHEET APPROVALS
				if (validateSelectedCheckBox(objCheckRTboxShow)==false)
					return;
			if ( isCheckedAtLeastOne == false)
			{
				alert("Please select at least one checkbox to approve");
				return;
			}
			else
			{			
				window.location.href.refresh;
				objform.action = "ShowPendingApprovals.aspx?MasterTagID=<%=m_lngTagID%>&LeavePageNumber=<%=m_intLeavePageNumber%>&IRPageNumber=<%=m_intIRPageNumber%>&ExpensePageNumber=<%=m_intExpensePageNumber%>&ProjectPageNumber=<%=m_intProjectPageNumber%>&ProjectTimeSheetPageNumber=<%=m_intProjectTimeSheetPageNumber%>&ResourceTimeSheetPageNumber=<%=m_intResourceTimeSheetPageNumber%>&MODE=Approved";
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
					strTitle = GetObjectReference('frm_ShowPendingApprovals','Title_'+intUniqueID).value;
					
					if (GetObjectReference('frm_ShowPendingApprovals','txt_'+intUniqueID).value == "")
					{
						alert("Comment should not be left blank to '"+strTitle+"'.");
						GetObjectReference('frm_ShowPendingApprovals','img_'+intUniqueID).src = '../../Images/SPA/Details.gif';								
						GetObjectReference('frm_ShowPendingApprovals','img_'+objCheckboxShow[intCnt].value).disabled=false;
						return false;	
					} 
					else if(GetObjectReference('frm_ShowPendingApprovals','txt_'+intUniqueID).innerText.length > 1000)
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
